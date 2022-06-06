Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5317753E685
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiFFKOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiFFKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:14:21 -0400
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 03:11:42 PDT
Received: from smtp90.ord1c.emailsrvr.com (smtp90.ord1c.emailsrvr.com [108.166.43.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C04D18145A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1654509810;
        bh=2DgrG36IhDguZ+hDtbMCQKf+gT03l6Kh/o4gDP6eSUg=;
        h=Date:Subject:To:From:From;
        b=M6czLYSMfGEt30s0ephW+6Mvo43V4C/lC5JgyGr7vR8FTVIzlRszft8bmWfs1P5Ys
         GJs4lo02X6OJu7FIHUTzdCaTbgtdmQWug9rs50ZeDWsd+o3V0CptLYbtNE9cg6sWv4
         zWQJ4A9tYPgI36ladLu0NLuD9vjvai9oAQuLQ0HQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp28.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 50AA6400E8;
        Mon,  6 Jun 2022 06:03:29 -0400 (EDT)
Message-ID: <4d41319e-1337-5300-77ed-e9c0cc7fe478@mev.co.uk>
Date:   Mon, 6 Jun 2022 11:03:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] comedi: ni_usb6501: fix transfer-buffer overflows
Content-Language: en-GB
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
References: <20220605124322.33148-1-ruc_zhangxiaohui@163.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20220605124322.33148-1-ruc_zhangxiaohui@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: f84fe9e9-2784-4821-ae60-1a381fc51a56-1-1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2022 13:43, Xiaohui Zhang wrote:
> From: xiaohuizhang98 <ruc_zhangxiaohui@163.com>
> 
> We detected a suspected bug with our code clone detection tool.
> 
> Similar to the handling of vmk80xx_alloc_usb_buffers in commit
> a23461c47482("comedi: vmk80xx: fix transfer-buffer overflows"),
> we thought a patch might be needed here as well.
> 
> The driver uses endpoint-sized USB transfer buffers but up until
> recently had no sanity checks on the sizes.
> 
> Signed-off-by: xiaohuizhang98 <ruc_zhangxiaohui@163.com>
> ---
>   drivers/comedi/drivers/ni_usb6501.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/ni_usb6501.c b/drivers/comedi/drivers/ni_usb6501.c
> index 0dd9edf7bced..3e2b9f4d840b 100644
> --- a/drivers/comedi/drivers/ni_usb6501.c
> +++ b/drivers/comedi/drivers/ni_usb6501.c
> @@ -90,6 +90,7 @@
>   #include <linux/comedi/comedi_usb.h>
>   
>   #define	NI6501_TIMEOUT	1000
> +#define MIN_BUF_SIZE	64
>   
>   /* Port request packets */
>   static const u8 READ_PORT_REQUEST[]	= {0x00, 0x01, 0x00, 0x10,
> @@ -459,12 +460,12 @@ static int ni6501_alloc_usb_buffers(struct comedi_device *dev)
>   	struct ni6501_private *devpriv = dev->private;
>   	size_t size;
>   
> -	size = usb_endpoint_maxp(devpriv->ep_rx);
> +	size = max(usb_endpoint_maxp(devpriv->ep_rx), MIN_BUF_SIZE);
>   	devpriv->usb_rx_buf = kzalloc(size, GFP_KERNEL);
>   	if (!devpriv->usb_rx_buf)
>   		return -ENOMEM;
>   
> -	size = usb_endpoint_maxp(devpriv->ep_tx);
> +	size = max(usb_endpoint_maxp(devpriv->ep_rx), MIN_BUF_SIZE);
>   	devpriv->usb_tx_buf = kzalloc(size, GFP_KERNEL);
>   	if (!devpriv->usb_tx_buf)
>   		return -ENOMEM;

Actually, there is a typo in the last bit of the patch that was copied 
from the similar patch to vmk80xx.  It is using the wrong endpoint to 
determine the size for usb_tx_buf.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
