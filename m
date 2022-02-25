Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554F04C3E99
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiBYGtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiBYGtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:49:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9661D63AC;
        Thu, 24 Feb 2022 22:49:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3189B82A97;
        Fri, 25 Feb 2022 06:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38ECC340E7;
        Fri, 25 Feb 2022 06:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645771751;
        bh=BjNnUDa6YlGgHdiU/3W/Okj0r21M2eZrvd1rB4FoNeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YO1rSojNZX7K70GU6AqJDWQ2IFRsUyUKjWVllXrmh2m8IMqneE8wc9qDilxDUucew
         lCPKNRD5HLLbhGHtqzHosuaC7lOzMtxf7dEPmzq1XpobO6WxyBdwmdpU9gA4fMhcDh
         exwRtBpoK9jcCXqkmel+58l9zq2P0a9hHzaAENlM=
Date:   Fri, 25 Feb 2022 07:49:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Henry Lin <henryl@nvidia.com>
Cc:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xhci: fix runtime PM imbalance in USB2 resume
Message-ID: <Yhh74nrKH5XuRZ/U@kroah.com>
References: <20220225055311.92447-1-henryl@nvidia.com>
 <Yhh19qsTsGRhsLWT@kroah.com>
 <CH0PR12MB5089EB28FAA6DF61F57F6D09AC3E9@CH0PR12MB5089.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR12MB5089EB28FAA6DF61F57F6D09AC3E9@CH0PR12MB5089.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Feb 25, 2022 at 06:40:53AM +0000, Henry Lin wrote:
> It fixes side effect from below change. 
> 
> commit a231ec41e6f6433daf4c693f169f6c5cfda8cb9d
> Author: Mathias Nyman <mathias.nyman@linux.intel.com>
> Date:   Fri Dec 7 16:19:35 2018 +0200
> 
>     xhci: refactor U0 link state handling in get_port_status
> 
>     Move U0 link state handing to USB3 and USB2 specific functions
> 
>     Note that
>     bus_state->resuming_ports:
>     bus_state->resume_done[]:
>     are only used for USB2, and don't need to cleared for USB3 ports
> 
>     No functional changes
> 
>     Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Great, please add a "Fixes:" tag to the patch when resubmitting it.

And the "no functional changes" seems not to have been true, right?
Does this need to go into the stable kernels?

thanks,

greg k-h
