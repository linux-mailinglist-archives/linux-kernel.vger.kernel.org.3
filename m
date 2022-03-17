Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953E64DC9F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiCQP3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbiCQP3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:29:44 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8097916D8E5;
        Thu, 17 Mar 2022 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=y4zQ1pCi+Ja432DNErfOtT8ZJqRK7E3h1dIL5wLYIWo=; b=cXeUQqNn5B0KNtRS5NtCm6/bMt
        RTeN/8nFoPfSwopmAfR6IXzhHm540FMLa7leDFbGcIBe9YZYC11iCKl3ubpHfNF953XRkx+XweSMJ
        Qcj0O5/mnIxTNfhOo+RWfxQc3Me+NrHykf7T19ZiGPI4DotI0oLe5lHzZyj/l/O9u6kw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59880 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nUs33-0005pV-Ax; Thu, 17 Mar 2022 11:28:22 -0400
Date:   Thu, 17 Mar 2022 11:28:20 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20220317112820.7617d0d68f50f24ad0c3739e@hugovil.com>
In-Reply-To: <Yiplnqlz2DSXCvi8@piout.net>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
        <20220309162301.61679-11-alexandre.belloni@bootlin.com>
        <20220310110918.41a681474f5a0e11abdedc39@hugovil.com>
        <Yiplnqlz2DSXCvi8@piout.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH 11/29] rtc: pcf2127: set RTC_FEATURE_ALARM_RES_2S
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 21:58:49 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 10/03/2022 11:09:18-0500, Hugo Villeneuve wrote:
> > On Wed,  9 Mar 2022 17:22:42 +0100
> > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > 
> > > The PCF2127 doesn't support UIE because setting an alarm to fire every
> > > second confuses the chip and the fastest we can go is an alarm every 2
> > > seconds.
> > 
> > Hi Alexandre,
> > can you describe what "confuses the chip" means?
> > 
> > In my experimental PCF2131 driver, I activated UIE and it seems to be working fine at 1s intervals, but since it is similar to PCF2127, maybe there is still a problem and I just didn't see it.
> > 
> 
> Did you remove uie_unsupported? Else, you may have been using uie
> emulation. In my tests last year, the pcf2127 was failing to reassert
> the interrupt if an alarm was set every second. The same happens on
> other NXP based RTCs (i.e. including microcrystal ones).
> 
> I'm going to test again soon (and also reply to your series).

Hi,
I have now access to a board with a PCF2129T.

I have been able to test with it by sending ioctl RTC_UIE_ON and confirm that it exhibits the problem you reported. Basically, the first alarm triggers the IRQ after 1s, as expected, but the next configured alarm 1s into the future never triggers the IRQ again. But the time/date registers seem to be updating (incrementin) correctly after that.

Here is a log of my tests, adding dump of registers and a lot of debug traces:

[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [02] 00000000: 00                                               .
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [03] 00000000: 04 00 15 17 04 03 22                             ......"
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time: 15:00:04 (month=17)
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [02] 00000000: 00                                               .
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [03] 00000000: 04 00 15 17 04 03 22                             ......"
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time: 15:00:04 (month=17)
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [02] 00000000: 00                                               .
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [03] 00000000: 04 00 15 17 04 03 22                             ......"
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time: 15:00:04 (month=17)
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_set_alarm
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [01] 00000000: 04                                               .
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C gwrite: [0A] 00000000: 05 00 15 17 80                                   .....
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_alarm
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [01] 00000000: 04                                               .
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [0A] 00000000: 05 00 15 17 80                                   .....
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_alarm: 15:00:05 (month=17)
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [02] 00000000: 00                                               .
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [03] 00000000: 04 00 15 17 04 03 22                             ......"
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time: 15:00:04 (month=17)
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_alarm_irq_enable: enable = 1
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [01] 00000000: 04                                               .
[Thu Mar 17 11:02:43 2022] rtc-pcf2127-i2c 4-0051: I2C write:  [01] 00000000: 06                                               .
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_irq: irq = 211
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [00] 00000000: 00 16 00 05 00 15 17 04 03 22 05 00 15 17 80 20  ........."..... 
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [00] 00000010: 82 00 80 00 00 00 00 00 00 08                    ..........
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [01] 00000000: 16                                               .
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [00] 00000000: 00                                               .
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C write:  [01] 00000000: 06                                               .
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [02] 00000000: 00                                               .
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [03] 00000000: 05 00 15 17 04 03 22                             ......"
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time: 15:00:05 (month=17)
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [02] 00000000: 00                                               .
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [03] 00000000: 05 00 15 17 04 03 22                             ......"
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time: 15:00:05 (month=17)
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_set_alarm
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [01] 00000000: 06                                               .
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C gwrite: [0A] 00000000: 06 00 15 17 80                                   .....
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_alarm
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [01] 00000000: 06                                               .
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [0A] 00000000: 06 00 15 17 80                                   .....
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_alarm: 15:00:06 (month=17)
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [02] 00000000: 00                                               .
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [03] 00000000: 05 00 15 17 04 03 22                             ......"
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_read_time: 15:00:05 (month=17)
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: pcf2127_rtc_alarm_irq_enable: enable = 1
[Thu Mar 17 11:02:44 2022] rtc-pcf2127-i2c 4-0051: I2C read:   [01] 00000000: 06   

Note: doing the same tests without dump and debug traces doesn't improve things.

I even did some tests where, in pcf2127_rtc_set_alarm(), I disabled all the alarm registers (set to 0x80), except for the SECONDS alarm register. In this case, I observed that the IRQ is triggered after 61s. This seems to indicate that the alarm detection circuitry is still somewhat operating (AF flag / INT pin), but there is probably a bug in the IC when the configured alarm is close to current time after AF is set once...

I also have done other tests by disabling then re-enabling AIE, stopping and restarting the oscillator (STOP bit), etc, but to no avail.

However, in pcf2127_rtc_set_alarm(), if I set the alarm 2s past the current time, instead of 1s, then the IRQ is always triggered after 2s.

I have opened a support case with NXP to investigate this strange behavior.

Hugo.


> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > ---
> > >  drivers/rtc/rtc-pcf2127.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > > index f8469b134411..63b275b014bd 100644
> > > --- a/drivers/rtc/rtc-pcf2127.c
> > > +++ b/drivers/rtc/rtc-pcf2127.c
> > > @@ -656,6 +656,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> > >  	pcf2127->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> > >  	pcf2127->rtc->range_max = RTC_TIMESTAMP_END_2099;
> > >  	pcf2127->rtc->set_start_time = true; /* Sets actual start to 1970 */
> > > +	set_bit(RTC_FEATURE_ALARM_RES_2S, pcf2127->rtc->features);
> > >  	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf2127->rtc->features);
> > >  	clear_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
> > >  
> > > -- 
> > > 2.35.1
> > > 
> > 
> > 
> > -- 
> > Hugo Villeneuve <hugo@hugovil.com>
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
