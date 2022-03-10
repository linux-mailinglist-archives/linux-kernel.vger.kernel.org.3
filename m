Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92F74D4E32
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiCJQKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbiCJQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:10:28 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9039818F21C;
        Thu, 10 Mar 2022 08:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ga7LhQbUj0BJm9/YIp6vd9e5mI8wLFqKkHI6WlgR2iM=; b=jYcZ3D5y4UT3qqdPO2H11nxNoU
        gEgE6zKIL9/IrIFL6S9iqnEP4o0ovBh/Aqhj3XrIpsb5lrZ3IbSPMPy+ixz0rOILP7DLE6BC3JCci
        Lr5a0Nvmufb4+Ju8dV4ab7OQ/13t7g1AiQjUsR2HF0yaqby//ielf25EkUEyEF1Qr0GM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59680 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nSLLr-0002a4-08; Thu, 10 Mar 2022 11:09:20 -0500
Date:   Thu, 10 Mar 2022 11:09:18 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20220310110918.41a681474f5a0e11abdedc39@hugovil.com>
In-Reply-To: <20220309162301.61679-11-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
        <20220309162301.61679-11-alexandre.belloni@bootlin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH 11/29] rtc: pcf2127: set RTC_FEATURE_ALARM_RES_2S
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Mar 2022 17:22:42 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> The PCF2127 doesn't support UIE because setting an alarm to fire every
> second confuses the chip and the fastest we can go is an alarm every 2
> seconds.

Hi Alexandre,
can you describe what "confuses the chip" means?

In my experimental PCF2131 driver, I activated UIE and it seems to be working fine at 1s intervals, but since it is similar to PCF2127, maybe there is still a problem and I just didn't see it.

Hugo.


> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index f8469b134411..63b275b014bd 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -656,6 +656,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>  	pcf2127->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
>  	pcf2127->rtc->range_max = RTC_TIMESTAMP_END_2099;
>  	pcf2127->rtc->set_start_time = true; /* Sets actual start to 1970 */
> +	set_bit(RTC_FEATURE_ALARM_RES_2S, pcf2127->rtc->features);
>  	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf2127->rtc->features);
>  	clear_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
>  
> -- 
> 2.35.1
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
