Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4A84DCC2D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiCQRRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiCQRRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:17:37 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1070BA6E13;
        Thu, 17 Mar 2022 10:16:19 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 54D54E000B;
        Thu, 17 Mar 2022 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647537378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fccZaLU3e9ufDI4tRZPJop/s9Lv4MUlUjsAiY2kUdW0=;
        b=PDeZ0bkwhoWzeOQnqKILcYTvx76vPbtd4o51rDK58u8n9MfsPtindNsaV9YhI8jUr5vZ0d
        sMljGWimoHOkt3jqGEIVotBuFyIwrvyiq6wxPf2DDU1p0ao52g7eDfpFWJt33QDEFfICqn
        OjQ70FgTyCj1dPhKbP9t1pbxGZQ/sWDGkOyLfteDe8WYsDXoM/Qcj7GqFj4VeUXWQtFBCd
        kSO/PYrkvIZr8Q9NLAGkp8jLTjTvLSfptgBD1QeAVl+teVovbmiks1jvYs+ZRJpmulG2XF
        kk/u6wnO1ic0MkYPrUQg/hsdulXT5A/ngQLresVustUZdrY2vYU9RkLFq2CqjA==
Date:   Thu, 17 Mar 2022 18:16:17 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/29] rtc: pcf2127: set RTC_FEATURE_ALARM_RES_2S
Message-ID: <YjNs4YykJWZi/t/z@piout.net>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
 <20220309162301.61679-11-alexandre.belloni@bootlin.com>
 <20220310110918.41a681474f5a0e11abdedc39@hugovil.com>
 <Yiplnqlz2DSXCvi8@piout.net>
 <20220317112820.7617d0d68f50f24ad0c3739e@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317112820.7617d0d68f50f24ad0c3739e@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/03/2022 11:28:20-0400, Hugo Villeneuve wrote:
> On Thu, 10 Mar 2022 21:58:49 +0100
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > On 10/03/2022 11:09:18-0500, Hugo Villeneuve wrote:
> > > On Wed,  9 Mar 2022 17:22:42 +0100
> > > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > > 
> > > > The PCF2127 doesn't support UIE because setting an alarm to fire every
> > > > second confuses the chip and the fastest we can go is an alarm every 2
> > > > seconds.
> > > 
> > > Hi Alexandre,
> > > can you describe what "confuses the chip" means?
> > > 
> > > In my experimental PCF2131 driver, I activated UIE and it seems to be working fine at 1s intervals, but since it is similar to PCF2127, maybe there is still a problem and I just didn't see it.
> > > 
> > 
> > Did you remove uie_unsupported? Else, you may have been using uie
> > emulation. In my tests last year, the pcf2127 was failing to reassert
> > the interrupt if an alarm was set every second. The same happens on
> > other NXP based RTCs (i.e. including microcrystal ones).
> > 
> > I'm going to test again soon (and also reply to your series).
> 
> Hi,
> I have now access to a board with a PCF2129T.
> 

I actually did the test again this afternoon with a pcf2127...

> I have been able to test with it by sending ioctl RTC_UIE_ON and
> confirm that it exhibits the problem you reported. Basically, the
> first alarm triggers the IRQ after 1s, as expected, but the next
> configured alarm 1s into the future never triggers the IRQ again. But
> the time/date registers seem to be updating (incrementin) correctly
> after that.
> 

...and so we agree on what we observe. My guess is that the alarm
comparator has a latch that triggers only every second update and so you
need 2 seconds between each alarms.

[...]

> I even did some tests where, in pcf2127_rtc_set_alarm(), I disabled
> all the alarm registers (set to 0x80), except for the SECONDS alarm
> register. In this case, I observed that the IRQ is triggered after
> 61s. This seems to indicate that the alarm detection circuitry is
> still somewhat operating (AF flag / INT pin), but there is probably a
> bug in the IC when the configured alarm is close to current time after
> AF is set once...
> 
> I also have done other tests by disabling then re-enabling AIE,
> stopping and restarting the oscillator (STOP bit), etc, but to no
> avail.
> 
> However, in pcf2127_rtc_set_alarm(), if I set the alarm 2s past the
> current time, instead of 1s, then the IRQ is always triggered after
> 2s.
> 
> I have opened a support case with NXP to investigate this strange
> behavior.

Let me know if you ever get a reply.

> 
> Hugo.
> 
> 
> > > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > ---
> > > >  drivers/rtc/rtc-pcf2127.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > > > index f8469b134411..63b275b014bd 100644
> > > > --- a/drivers/rtc/rtc-pcf2127.c
> > > > +++ b/drivers/rtc/rtc-pcf2127.c
> > > > @@ -656,6 +656,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> > > >  	pcf2127->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> > > >  	pcf2127->rtc->range_max = RTC_TIMESTAMP_END_2099;
> > > >  	pcf2127->rtc->set_start_time = true; /* Sets actual start to 1970 */
> > > > +	set_bit(RTC_FEATURE_ALARM_RES_2S, pcf2127->rtc->features);
> > > >  	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf2127->rtc->features);
> > > >  	clear_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
> > > >  
> > > > -- 
> > > > 2.35.1
> > > > 
> > > 
> > > 
> > > -- 
> > > Hugo Villeneuve <hugo@hugovil.com>
> > 
> > -- 
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> > 
> 
> 
> -- 
> Hugo Villeneuve <hugo@hugovil.com>

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
