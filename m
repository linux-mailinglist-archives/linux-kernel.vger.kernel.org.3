Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304F4557489
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiFWHwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiFWHwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:52:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6F147055;
        Thu, 23 Jun 2022 00:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3657B821F6;
        Thu, 23 Jun 2022 07:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEC6C341C0;
        Thu, 23 Jun 2022 07:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655970766;
        bh=huoNFgn3HfD3bERTBZf4NaZJjzvcYRnDGxOvI/0th/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvnVX3ep5DOt+vooFv5V7AUs1dYZJ7YhvBZ1h1QMtjlWAXF46yRpArkIafhPCGklL
         rwhAxTkcivPQWRgt55ePtkUKi2G3NmCrDZrfCw98z4RnA1zjv36AK5gq40f71gLcB/
         wlmqtP6YcrJNkiJAfySb8SeW4q9NZoW30tK6rz2k=
Date:   Thu, 23 Jun 2022 09:52:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roger Quadros <roger.quadros@nokia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <cai.huoqing@linux.dev>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH RESEND] usb: gadget: f_mass_storage: Make CD-ROM
 emulation works with Windows OS
Message-ID: <YrQby7M/ndikPeLW@kroah.com>
References: <20220623030405.1922980-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623030405.1922980-1-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:04:05AM +0800, Neal Liu wrote:
> Add read TOC with format 2 to support CD-ROM emulation with
> Windows OS.
> This patch is tested on Windows OS Server 2019.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 3a77bca0ebe1..3c2a5f1e8b66 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -1209,6 +1209,7 @@ static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
>  
>  	switch (format) {
>  	case 0:
> +	case 1:
>  		/* Formatted TOC */
>  		len = 4 + 2*8;		/* 4 byte header + 2 descriptors */
>  		memset(buf, 0, len);
> -- 
> 2.25.1
> 

Why was this a "RESEND"?  Always put the reason why below the --- line
so we know what is going on...

thanks,

greg k-h
