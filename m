Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115E5598C66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344857AbiHRTM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240608AbiHRTMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:12:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CB1C6948;
        Thu, 18 Aug 2022 12:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDFD3B823E5;
        Thu, 18 Aug 2022 19:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1A1C433C1;
        Thu, 18 Aug 2022 19:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660849969;
        bh=Xo4hTvNR0cypUl1rvNXLIgHT1qK0Tu+nac3EmkuNcFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMqhnxp8MllYPWvKyVTOEcgtlV5P1z29Y5dsaowynW3Q3Cti7QrHjZmQUO8B4O16t
         zn0S7Zbdvhn4UASs7DHAm0O9M8j8F5H72clZJVsLhVquGG0L1X0cLo4R2TcKWO4sy6
         DG51Jrh+O0jI37U7QC/jgqlwvgx3F+0D5C8Yybk4=
Date:   Thu, 18 Aug 2022 21:12:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        rajmohan.mani@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/6] ACPI: New helper function
 acpi_dev_get_memory_resources() and a new ACPI ID
Message-ID: <Yv6PLl4aLPzHTJTQ@kroah.com>
References: <20220816101629.69054-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816101629.69054-1-heikki.krogerus@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 01:16:23PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> The helper function returns all memory resources described for a
> device regardless of the ACPI descriptor type (as long as it's
> memory), but the first patch introduces new ACPI ID for the IOM
> controller on Intel Meteor Lake and also separately modifies the
> driver so that it can get the memory resource from Address Space
> Resource Descriptor.
> 
> An alternative would have been to introduce that helper function first
> so we would not need to modify the driver when the new ID is added,
> but then the helper would also need to be applied to the stable kernel
> releases, and that does not feel necessary or appropriate in this
> case, at least not IMO.
> 
> So that's why I'm proposing here that we first add the ID, and only
> after that introduce the helper, and only for mainline. That way the
> patch introducing the ID is the only that goes to the stable releases.
> 
> If that's okay, and these don't have any other problems, I assume it's
> OK if Rafael takes all of these, including the ID?

I took the id now, for 6.0-final as it seems to be totally independant
of the other commits (otherwise you would not have tagged it for the
stable tree.)

The remainder should probably be resent and send through the acpi tree.

thanks,

greg k-h
