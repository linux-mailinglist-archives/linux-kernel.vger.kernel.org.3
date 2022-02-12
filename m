Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176C74B3869
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 23:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiBLWma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 17:42:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBLWm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 17:42:29 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30E123BCF;
        Sat, 12 Feb 2022 14:42:23 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E1A7D60002;
        Sat, 12 Feb 2022 22:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644705742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o7nmq5PpfhPJseJpTWo3AP6LjcDu4IADuUW9epeYJTg=;
        b=aj1zeNyXQMCippy0hC/h0XaigL/80Gn/7A7P20K6xopvizsENw3S79xXbd16eaKVuxgu31
        /6J8Iytsm1jluaN2+DAUoyqElgfFV35674X2Fpq8nMJ5Sb8ezERS6joB3u94aUOHWm4zDI
        5LZMmXLM1comTl837YHR2z7fXL6zyt8brltFF+t4PUKkvZax8GlB46f9sIyc1MyDIBdz9g
        PQfl18PPrnvDG12e0ABLeB+E4f8T6TNyS8MT5nSNntP3mW9ceKxO2HESLKJbdP3zDP6KsU
        KdiQejVoAQNfX2sOcr9Ta9HXoJiltVd20xvLtaWYidquJCbzlPgQyEopJ0B6hg==
Date:   Sat, 12 Feb 2022 23:42:21 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc-mc146818-lib: wait longer for UIP to clear
Message-ID: <Ygg3zXX+vgBhDb30@piout.net>
References: <20220212220454.566548-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220212220454.566548-1-mat.jonczyk@o2.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 12/02/2022 23:04:54+0100, Mateusz Jończyk wrote:
> Before reading date / time from the CMOS RTC, we wait for the UIP
> (Update in progress) bit to clear --- so that the values are correct and
> consistent. To avoid a hang, there is a time limit after which we give
> up waiting.
> 
> Increase the time limit from 10 to 20ms in case there are RTCs out there
> that are much slower than expected.
> 

I'm not going to apply that until we actually have reports that there
are issues because now, we can't know what is the benefit risk balance.

> Note: This may cause problems with hpet_rtc_interrupt() if the CMOS RTC
> breaks down while the system is running and RTC update interrupt / RTC
> alarm interrupt happens to be enabled (which should be rare).
> hpet_rtc_interrupt() is executed usually 64 times per second and after
> this patch it may take up to 20ms to complete (always hitting RTC read
> timeout) - which may constantly occupy one CPU. This looks very
> unlikely, though.
> 
> Also fix "then" -> "than" in a comment.
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Fixes: ec5895c0f2d8 ("rtc: mc146818-lib: extract mc146818_avoid_UIP")
> ---
> 
> This comment from Mr Alexandre Belloni got me thinking and is why I am
> submitting this patch:
> > We'll probably get some breakage later on because many RTCs using this
> > driver are not adhering to the spec.
> (See: https://lore.kernel.org/linux-rtc/277177e7-46a0-522c-297c-ad3ee0c15793@o2.pl/T/ )
> 
> Googling for dmesg messages that indicate problems with reading from RTC
> (such as "unable to read current time" - using quotation marks to force
> exact phrase search) produces no results apart from kernel code and
> patches. Any problems would happen rarely on affected systems, though.
> 
>  drivers/rtc/rtc-mc146818-lib.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
> index ae9f131b43c0..29ceec9875f4 100644
> --- a/drivers/rtc/rtc-mc146818-lib.c
> +++ b/drivers/rtc/rtc-mc146818-lib.c
> @@ -21,7 +21,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
>  	unsigned long flags;
>  	unsigned char seconds;
>  
> -	for (i = 0; i < 10; i++) {
> +	for (i = 0; i < 20; i++) {
>  		spin_lock_irqsave(&rtc_lock, flags);
>  
>  		/*
> @@ -79,8 +79,8 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
>  EXPORT_SYMBOL_GPL(mc146818_avoid_UIP);
>  
>  /*
> - * If the UIP (Update-in-progress) bit of the RTC is set for more then
> - * 10ms, the RTC is apparently broken or not present.
> + * If the UIP (Update-in-progress) bit of the RTC is set for more than
> + * 20ms, the RTC is apparently broken or not present.
>   */
>  bool mc146818_does_rtc_work(void)
>  {
> 
> base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
