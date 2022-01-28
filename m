Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782D249F90F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348381AbiA1MTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243048AbiA1MTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:19:12 -0500
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318DCC061714;
        Fri, 28 Jan 2022 04:19:12 -0800 (PST)
Received: from [IPV6:2a01:e0a:255:1000:3124:3dac:d662:6a32] (unknown [IPv6:2a01:e0a:255:1000:3124:3dac:d662:6a32])
        (Authenticated sender: duncan.sands@free.fr)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 3BF0E7802CE;
        Fri, 28 Jan 2022 13:19:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1643372349;
        bh=3L95F8XCRFzMRvjD9lkd7vEXaFEh+figQSC1zy0PMAo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R3hHWeb/x/FYlGZmhpiVGc1cJUhGrYQp31Oxxz8hU7ueiBupPlJ9rI81TN9hHsow5
         TXVqSuTjPWeKBljSmFzydR5+QtArOCws+c2lFuheA+UwwoOo109tBjtoFdC8qtGvBe
         wnrddCuwjZhf3OxXBxVrN+KDR0gaqpf5+VDob6WsN04l8kJcDZjKRRkCjTLMYld1Dx
         pZFbntJ0ffBD7S8oRxx2Ml7F0qP/gRbWuOCGiz2mlnmITYFljLmEAbKK7cFJ24W//Q
         RXtHuEWiPFY3Ut8GfKUmk35BQp5Vz2Qsj5HoFaJmLUmOaguo4o36mexFInFvz7uFPd
         xeMheu3Z35nKg==
Message-ID: <a9b867e5-3728-7815-43da-3e6dddf214f2@free.fr>
Date:   Fri, 28 Jan 2022 13:19:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] usb: atm: Make use of the helper macro kthread_run()
Content-Language: en-US
To:     Yin Xiujiang <yinxiujiang@kylinos.cn>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220127074744.845537-1-yinxiujiang@kylinos.cn>
From:   Duncan Sands <duncan.sands@free.fr>
In-Reply-To: <20220127074744.845537-1-yinxiujiang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yin Xiujiang, please see my earlier reply to Cai Huoqing for the same patch 
below.  Did you do the analysis?

>>         instance->thread = t;
>> -    wake_up_process(t);
> 
> doesn't this mean that the thread may now start running before instance->thread has been assigned?  It's not clear to me what race conditions this may open up, if any (I haven't looked at the code in a long time), but it does need to be carefully analyzed.  So I can't sign off on this as it stands.

Best wishes, Duncan.

On 27/01/2022 08:47, Yin Xiujiang wrote:
> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
> 
> Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
> ---
>   drivers/usb/atm/usbatm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
> index e3a49d837609..24ba739a85e0 100644
> --- a/drivers/usb/atm/usbatm.c
> +++ b/drivers/usb/atm/usbatm.c
> @@ -976,7 +976,7 @@ static int usbatm_heavy_init(struct usbatm_data *instance)
>   {
>   	struct task_struct *t;
>   
> -	t = kthread_create(usbatm_do_heavy_init, instance, "%s",
> +	t = kthread_run(usbatm_do_heavy_init, instance, "%s",
>   			instance->driver->driver_name);
>   	if (IS_ERR(t)) {
>   		usb_err(instance, "%s: failed to create kernel_thread (%ld)!\n",
> @@ -985,7 +985,6 @@ static int usbatm_heavy_init(struct usbatm_data *instance)
>   	}
>   
>   	instance->thread = t;
> -	wake_up_process(t);
>   	wait_for_completion(&instance->thread_started);
>   
>   	return 0;

