Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD455598B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiFXLol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiFXLod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:44:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887FA7B346;
        Fri, 24 Jun 2022 04:44:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F652621E8;
        Fri, 24 Jun 2022 11:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D02C34114;
        Fri, 24 Jun 2022 11:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656071071;
        bh=QQYTSBhO3NWX36hqngi0V5m9BlBXYEOZGEq7c/OcriA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLYOAJQIt+o4DXE5kCsssmNBVQIJ9N7drzW5z2GH7R8tBJWzJsYPCqJ4zEZl4xyob
         FEwCN1/csQF2cCiat1k9NQsjCpRfim+iqq33ucczFzkc/jSQrF2WkHdxj7W82wPKJ5
         0ZbnexP+UlrAdeOfYEP712mDTRQ/O9N6CUGTvH8A=
Date:   Fri, 24 Jun 2022 08:46:30 +0200
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
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Make CD-ROM emulation
 works with Windows OS
Message-ID: <YrVdxmleSZDeUp19@kroah.com>
References: <20220624021916.318067-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624021916.318067-1-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:19:16AM +0800, Neal Liu wrote:
> Add read TOC with format 1 to support CD-ROM emulation with

What is "TOC"?  What is "format 1"?

> Windows OS.

Which versions of Windows support this?

> This patch is tested on Windows OS Server 2019.

Does this fix a regression where we used to support this?  Or is this a
new feature of Windows?


> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 3a77bca0ebe1..9edf76c22605 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -1209,7 +1209,8 @@ static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
>  
>  	switch (format) {
>  	case 0:
> -		/* Formatted TOC */
> +	case 1:
> +		/* Formatted TOC, Session info */
>  		len = 4 + 2*8;		/* 4 byte header + 2 descriptors */
>  		memset(buf, 0, len);
>  		buf[1] = len - 2;	/* TOC Length excludes length field */
> @@ -1250,7 +1251,7 @@ static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
>  		return len;
>  
>  	default:
> -		/* Multi-session, PMA, ATIP, CD-TEXT not supported/required */
> +		/* PMA, ATIP, CD-TEXT not supported/required */

So case 1 is "multi-session"?  Please document this properly.

thanks,

greg k-h
