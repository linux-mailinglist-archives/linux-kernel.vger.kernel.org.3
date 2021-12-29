Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E4748101F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 06:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbhL2Fk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 00:40:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45330 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhL2FkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 00:40:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06301B81163;
        Wed, 29 Dec 2021 05:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1BDC36AEA;
        Wed, 29 Dec 2021 05:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640756422;
        bh=ZDSJxCw+26nf7CRKQUd/wtLZMwsu5luoF5sZD/yoX0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDFpmUBjvXGojvo/pLAX9ZBtkf0m6VU8AMZGNec6POpOKHNIOfofjmAeWHpWJhUR7
         Jj1zgzXzqnWhX7UESn4AuQ7eesScH28AArX34RnN0xZMNZ/WCdQQQBiFAP4oo5c8Uq
         OEjjultnSWc1pdv2zOi1JCgDoiIP4N3yPWe6xeFE9jZyLi5Dwb04aokFDN+OOOD08p
         SymZ7lnmaEUJA4MLwAP074qvLea1DShU5WVB0YmAAa2hUWgmDBOfGRXbnydglaeEwk
         qkK+I7Z88ryhElZVRGcr8lLa9G7f0ZeRs+EmJSoH2yrH+YTV0VjtZL6IUrbRuvcFG1
         cgtQDr/1XQuVw==
Date:   Wed, 29 Dec 2021 11:10:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/8] device property: Helper to match multiple connections
Message-ID: <Ycv0wtDSyLhS1LWZ@matsya>
References: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
 <20211228052116.1748443-4-bjorn.andersson@linaro.org>
 <78491489-6b31-c741-8c69-8d52fb614a6c@linaro.org>
 <YctDgaHV8dsR109L@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YctDgaHV8dsR109L@ripper>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-12-21, 09:04, Bjorn Andersson wrote:
> On Tue 28 Dec 05:09 PST 2021, Dmitry Baryshkov wrote:
> 
> > On 28/12/2021 08:21, Bjorn Andersson wrote:
> > > In some cases multiple connections with the same connection id
> > > needs to be resolved from a fwnode graph.
> > > 
> > > One such example is when separate hardware is used for performing muxing and/or
> > > orientation switching of the SuperSpeed and SBU lines in a USB-C
> > > connector. In this case the connector needs to belong to a graph with
> > > multiple matching remote endpoints, and the TypeC controller needs to be
> > > able to resolve them both.
> > > 
> > > Add a new API that allows this kind of lookup.
> > > 
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >   drivers/base/property.c  | 94 ++++++++++++++++++++++++++++++++++++++++
> > >   include/linux/property.h |  5 +++
> > >   2 files changed, 99 insertions(+)
> > > 
> > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > index cbe4fa298413..0aa0296fd991 100644
> > > --- a/drivers/base/property.c
> > > +++ b/drivers/base/property.c
> > > @@ -1180,6 +1180,36 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> > >   	return NULL;
> > >   }
> > > +static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
> > > +						const char *con_id, void *data,
> > > +						devcon_match_fn_t match,
> > > +						void **matches,
> > > +						unsigned int matches_len)
> > > +{
> > > +	struct fwnode_handle *node;
> > > +	struct fwnode_handle *ep;
> > > +	unsigned int count = 0;
> > > +	void *ret;
> > > +
> > > +	fwnode_graph_for_each_endpoint(fwnode, ep) {
> > > +		if (count >= matches_len) {
> > > +			fwnode_handle_put(ep);
> > > +			return count;
> > > +		}
> > > +
> > > +		node = fwnode_graph_get_remote_port_parent(ep);
> > > +		if (!fwnode_device_is_available(node))
> > > +			continue;
> > > +
> > > +		ret = match(node, con_id, data);
> > > +		fwnode_handle_put(node);
> > > +
> > > +		if (ret)
> > > +			matches[count++] = ret;
> > > +	}
> > > +	return count;
> > > +}
> > 
> > This API doesn't let it's user know if there are more matches found in the
> > device tree or not. I'd suggest to add 'count' mode that would return the
> > amount of found matches if (matches == NULL) && (matches_len == 0).

But the API does call each match
> 
> Unfortunately in this code path we don't know how to "free" the objects
> returned by match(), e.g. see how typec_switch_match() returns wrapper
> of a refcounted device.
> 
> So we must return all the match results to the caller to it can free
> things up based on its knowledge of what matches[] actually contains..

ACPI walk has similar APIs, I can think of acpi_walk_namespace() which I
have used in past and does similar walk in namespace but for devices and
calls the match()

-- 
~Vinod
