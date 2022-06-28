Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD0A55E6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347230AbiF1OwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiF1OwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:52:06 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DEE3732062
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:52:05 -0700 (PDT)
Received: (qmail 156938 invoked by uid 1000); 28 Jun 2022 10:52:05 -0400
Date:   Tue, 28 Jun 2022 10:52:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <roger.quadros@nokia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <cai.huoqing@linux.dev>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v3] usb: gadget: f_mass_storage: Make CD-ROM emulation
 works with Windows OS
Message-ID: <YrsVlYL86r1urA9y@rowland.harvard.edu>
References: <20220628021436.3252262-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628021436.3252262-1-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:14:36AM +0800, Neal Liu wrote:
> Add read TOC with format 1 to support CD-ROM emulation with
> Windows OS.
> This patch is tested on Windows OS Server 2019.
> 
> Fixes: 89ada0fe669a ("usb: gadget: f_mass_storage: Make CD-ROM emulation work
> with Mac OS-X")
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

> v3:
> - ignore start_track value with format 1
> - add fixes tags
> - revise comments properly
> 
> v2:
> - revise comments
> 
>  drivers/usb/gadget/function/f_mass_storage.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 3a77bca0ebe1..e884f295504f 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -1192,13 +1192,14 @@ static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
>  	u8		format;
>  	int		i, len;
>  
> +	format = common->cmnd[2] & 0xf;
> +
>  	if ((common->cmnd[1] & ~0x02) != 0 ||	/* Mask away MSF */
> -			start_track > 1) {
> +			(start_track > 1 && format != 0x1)) {
>  		curlun->sense_data = SS_INVALID_FIELD_IN_CDB;
>  		return -EINVAL;
>  	}
>  
> -	format = common->cmnd[2] & 0xf;
>  	/*
>  	 * Check if CDB is old style SFF-8020i
>  	 * i.e. format is in 2 MSBs of byte 9
> @@ -1208,8 +1209,8 @@ static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
>  		format = (common->cmnd[9] >> 6) & 0x3;
>  
>  	switch (format) {
> -	case 0:
> -		/* Formatted TOC */
> +	case 0:	/* Formatted TOC */
> +	case 1:	/* Multi-session info */
>  		len = 4 + 2*8;		/* 4 byte header + 2 descriptors */
>  		memset(buf, 0, len);
>  		buf[1] = len - 2;	/* TOC Length excludes length field */
> @@ -1250,7 +1251,7 @@ static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
>  		return len;
>  
>  	default:
> -		/* Multi-session, PMA, ATIP, CD-TEXT not supported/required */
> +		/* PMA, ATIP, CD-TEXT not supported/required */
>  		curlun->sense_data = SS_INVALID_FIELD_IN_CDB;
>  		return -EINVAL;
>  	}
> -- 
> 2.25.1
> 
