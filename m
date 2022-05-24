Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6EA532DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbiEXPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbiEXPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:46:57 -0400
X-Greylist: delayed 2197 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 May 2022 08:46:55 PDT
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207E369CD4;
        Tue, 24 May 2022 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=T9kVwBVV655q2jjBqBTVTMqSm4y1htgJfQgySVDPZwA=; b=cqpbUo6/iaW2vwimgwGk1A2w6E
        eUNVFPgjnZyOUhl+jzmlBAg9kYIk7E0H0BEDtSxzbP2dAF+eK78oKcrQANB/NJ5iXxMFqO1usG6Fi
        HHCFDzdr+eq983CCGF5eE1DlKufzd++Lc7koKQUSm8SAm8naP4MoeBHd5M3WxzmkfW5k=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:50202 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1ntWAe-0005Ct-U1; Tue, 24 May 2022 11:10:12 -0400
Date:   Tue, 24 May 2022 11:10:04 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20220524111004.7b0fd6c492c835e7f1ee22b7@hugovil.com>
In-Reply-To: <YjNs4YykJWZi/t/z@piout.net>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
        <20220309162301.61679-11-alexandre.belloni@bootlin.com>
        <20220310110918.41a681474f5a0e11abdedc39@hugovil.com>
        <Yiplnqlz2DSXCvi8@piout.net>
        <20220317112820.7617d0d68f50f24ad0c3739e@hugovil.com>
        <YjNs4YykJWZi/t/z@piout.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH 11/29] rtc: pcf2127: set RTC_FEATURE_ALARM_RES_2S
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 18:16:17 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hi,
> 
> On 17/03/2022 11:28:20-0400, Hugo Villeneuve wrote:
> > On Thu, 10 Mar 2022 21:58:49 +0100
> > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > 
> > > On 10/03/2022 11:09:18-0500, Hugo Villeneuve wrote:
> > > > On Wed,  9 Mar 2022 17:22:42 +0100
> > > > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > > > 
> > > > > The PCF2127 doesn't support UIE because setting an alarm to fire every
> > > > > second confuses the chip and the fastest we can go is an alarm every 2
> > > > > seconds.
> > > > 
> > > > Hi Alexandre,
> > > > can you describe what "confuses the chip" means?
> > > > 
> > > > In my experimental PCF2131 driver, I activated UIE and it seems to be working fine at 1s intervals, but since it is similar to PCF2127, maybe there is still a problem and I just didn't see it.
> > > > 
> > > 
> > > Did you remove uie_unsupported? Else, you may have been using uie
> > > emulation. In my tests last year, the pcf2127 was failing to reassert
> > > the interrupt if an alarm was set every second. The same happens on
> > > other NXP based RTCs (i.e. including microcrystal ones).
> > > 
> > > I'm going to test again soon (and also reply to your series).
> > 
> > Hi,
> > I have now access to a board with a PCF2129T.
> > 
> 
> I actually did the test again this afternoon with a pcf2127...
> 
> > I have been able to test with it by sending ioctl RTC_UIE_ON and
> > confirm that it exhibits the problem you reported. Basically, the
> > first alarm triggers the IRQ after 1s, as expected, but the next
> > configured alarm 1s into the future never triggers the IRQ again. But
> > the time/date registers seem to be updating (incrementin) correctly
> > after that.
> > 
> 
> ...and so we agree on what we observe. My guess is that the alarm
> comparator has a latch that triggers only every second update and so you
> need 2 seconds between each alarms.
> 
> [...]
> 
> > I even did some tests where, in pcf2127_rtc_set_alarm(), I disabled
> > all the alarm registers (set to 0x80), except for the SECONDS alarm
> > register. In this case, I observed that the IRQ is triggered after
> > 61s. This seems to indicate that the alarm detection circuitry is
> > still somewhat operating (AF flag / INT pin), but there is probably a
> > bug in the IC when the configured alarm is close to current time after
> > AF is set once...
> > 
> > I also have done other tests by disabling then re-enabling AIE,
> > stopping and restarting the oscillator (STOP bit), etc, but to no
> > avail.
> > 
> > However, in pcf2127_rtc_set_alarm(), if I set the alarm 2s past the
> > current time, instead of 1s, then the IRQ is always triggered after
> > 2s.
> > 
> > I have opened a support case with NXP to investigate this strange
> > behavior.
> 
> Let me know if you ever get a reply.

Hi Alexandre,
after two months and a lot of emails with NXP awful technical support, I was never able to have a valid answer to the problem, apart from "Use a new device as the PCF2127 is not recommended for new designs" :(

On the other hand, have you had time to look at my patch series for the PCF2131 driver?

Thank you, Hugo.


> > > > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > > ---
> > > > >  drivers/rtc/rtc-pcf2127.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > > > > index f8469b134411..63b275b014bd 100644
> > > > > --- a/drivers/rtc/rtc-pcf2127.c
> > > > > +++ b/drivers/rtc/rtc-pcf2127.c
> > > > > @@ -656,6 +656,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> > > > >  	pcf2127->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> > > > >  	pcf2127->rtc->range_max = RTC_TIMESTAMP_END_2099;
> > > > >  	pcf2127->rtc->set_start_time = true; /* Sets actual start to 1970 */
> > > > > +	set_bit(RTC_FEATURE_ALARM_RES_2S, pcf2127->rtc->features);
> > > > >  	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf2127->rtc->features);
> > > > >  	clear_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
> > > > >  
> > > > > -- 
> > > > > 2.35.1
> > > > > 
> > > > 
> > > > 
> > > > -- 
> > > > Hugo Villeneuve <hugo@hugovil.com>
> > > 
> > > -- 
> > > Alexandre Belloni, co-owner and COO, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://bootlin.com
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
