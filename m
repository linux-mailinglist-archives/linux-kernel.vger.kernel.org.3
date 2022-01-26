Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5426A49CA52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiAZNEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:04:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38690 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiAZNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:04:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B30B5B81D4E;
        Wed, 26 Jan 2022 13:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0300C340E3;
        Wed, 26 Jan 2022 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643202265;
        bh=dDphJEYB97uyy1vvATCK4beMGzRjM2Vqi+VkbQMhkJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m/7RyIq2KEJWp0NLYGtSL5zs/Tso3dp/9jfIfL66uFTdHtpKD1ByhrkvcQ5ZJMn9S
         G07+hTD1JmNlhgL8aC6Reb66tFIlq9WKRmmAfWB8dgpLLyOfMHPQ/N450HDwZKoyTR
         1nEJsO1KPdyTSpjr8WbX50O2vS6oCc11rX+ZVPno=
Date:   Wed, 26 Jan 2022 14:04:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: ulpi: Call of_node_put correctly
Message-ID: <YfFG1gjpjAkiG64+@kroah.com>
References: <20220124173344.874885-1-sean.anderson@seco.com>
 <20220124173344.874885-2-sean.anderson@seco.com>
 <Ye/AUUlnuHBoGxab@kuha.fi.intel.com>
 <dc30490b-15e8-1b10-beb2-eaaa10190649@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc30490b-15e8-1b10-beb2-eaaa10190649@seco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 11:53:58AM -0500, Sean Anderson wrote:
> Hi Heikki,
> 
> On 1/25/22 4:18 AM, Heikki Krogerus wrote:
> > On Mon, Jan 24, 2022 at 12:33:44PM -0500, Sean Anderson wrote:
> >> of_node_put should always be called on device nodes gotten from
> >> of_get_*. Additionally, it should only be called after there are no
> >> remaining users. To address the first issue, call of_node_put if later
> >> steps in ulpi_register fail. To address the latter, call of_node_put
> >> only after calling device_unregister.
> > 
> > This looks like a fix, but you don't have the fix tag.
> 
> You're right this should have
> 
> Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")

Please resend this as 2 independent patches as they should not depend on
each other, allowing this one to be backported, but the debugfs addition
added only to 5.18-rc1.

thanks,

greg k-h
