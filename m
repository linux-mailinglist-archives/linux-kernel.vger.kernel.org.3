Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC40D53FEC8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbiFGMbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiFGMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:31:06 -0400
Received: from smtp125.iad3b.emailsrvr.com (smtp125.iad3b.emailsrvr.com [146.20.161.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F6C1EC3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1654605060;
        bh=iJdH+cC9+3qmvcM+VtHfSdCQIx+u2/nDFIKkNrB6JRA=;
        h=Date:Subject:To:From:From;
        b=Ou7nwaz3C4YR1bss+QGw6bfEzcya2amxMTCdnV4jnF0/d4FcyzEiTjcSF8Z9glWXD
         YS7u5i+92JkgLm+odysevHCCMhOWlujLDkoFc7tQEZdF3GkjiKmtMLPjIo9tQnmoCk
         YhBz+RRRoTgxtNutVXuHzRX6qfmhAJGs7EetORr8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp8.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 1022F400F0;
        Tue,  7 Jun 2022 08:30:59 -0400 (EDT)
Message-ID: <cafcc2b1-2b9b-4957-ee8a-9e260a7e2f5d@mev.co.uk>
Date:   Tue, 7 Jun 2022 13:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] comedi: ni_usb6501: fix transfer-buffer overflows
Content-Language: en-GB
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
References: <20220607111802.13311-1-xiaohuizhang@ruc.edu.cn>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20220607111802.13311-1-xiaohuizhang@ruc.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 8a778d23-9852-4091-b4fb-bd1a2b7f2295-1-1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 12:18, Xiaohui Zhang wrote:
> Similar to the handling of vmk80xx_alloc_usb_buffers in commit
> a23461c47482("comedi: vmk80xx: fix transfer-buffer overflows"),
> we thought a patch might be needed here as well.
> 
> The driver uses endpoint-sized USB transfer buffers but up until
> recently had no sanity checks on the sizes.
> 
> Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
> ---
>   drivers/comedi/drivers/ni_usb6501.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/ni_usb6501.c b/drivers/comedi/drivers/ni_usb6501.c
> index 0dd9edf7bced..8303bfc305c5 100644
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
> +	size = max(usb_endpoint_maxp(devpriv->ep_tx), MIN_BUF_SIZE);
>   	devpriv->usb_tx_buf = kzalloc(size, GFP_KERNEL);
>   	if (!devpriv->usb_tx_buf)
>   		return -ENOMEM;

The code change looks OK but this patch should have been sent as a "v2" 
patch and should have a brief description of the v2 changes after the 
"---" line.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
