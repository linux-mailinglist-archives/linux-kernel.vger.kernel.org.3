Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0254A4D534F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbiCJU75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiCJU7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:59:55 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39638DB4A3;
        Thu, 10 Mar 2022 12:58:52 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4E53060007;
        Thu, 10 Mar 2022 20:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646945930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jAMRau9vsG1Ep623pXQhR3FKPYrUOoJF+fXhTyrVKaw=;
        b=hBOMXCVusCAhQc/W8ZmZxbI13RfoqG5i5wzmpy2vPNHnPvYqWW0hOGliWG4Mq/KbarXrkE
        FfbZRzdk0yqsehqw7e7yGPNxq3HRmb7CvS0eXcS66JAkGMEGEqhUkzfe9R3RwkRcLV1X4+
        xFSR6w0e6qz+VlxTedYjuzPGsVlTSk2GtRA5FzkePkmd+NXOCFpfgETruEFIb6wkhkPI0P
        oSLK0deuKpdjBosREhQibMx+CBM90jriAEe/0LRq0ZdVnJlQz0dTeY3soxlX+EQqlgjqxh
        V/odqNxlUbtu6rkxQHNdDvi+YFrksWfOuKqD95LBsl8+GKVstUgtgDJLwfYCmw==
Date:   Thu, 10 Mar 2022 21:58:49 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/29] rtc: pcf2127: set RTC_FEATURE_ALARM_RES_2S
Message-ID: <Yiplnqlz2DSXCvi8@piout.net>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
 <20220309162301.61679-11-alexandre.belloni@bootlin.com>
 <20220310110918.41a681474f5a0e11abdedc39@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310110918.41a681474f5a0e11abdedc39@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 11:09:18-0500, Hugo Villeneuve wrote:
> On Wed,  9 Mar 2022 17:22:42 +0100
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > The PCF2127 doesn't support UIE because setting an alarm to fire every
> > second confuses the chip and the fastest we can go is an alarm every 2
> > seconds.
> 
> Hi Alexandre,
> can you describe what "confuses the chip" means?
> 
> In my experimental PCF2131 driver, I activated UIE and it seems to be working fine at 1s intervals, but since it is similar to PCF2127, maybe there is still a problem and I just didn't see it.
> 

Did you remove uie_unsupported? Else, you may have been using uie
emulation. In my tests last year, the pcf2127 was failing to reassert
the interrupt if an alarm was set every second. The same happens on
other NXP based RTCs (i.e. including microcrystal ones).

I'm going to test again soon (and also reply to your series).

> Hugo.
> 
> 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/rtc/rtc-pcf2127.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > index f8469b134411..63b275b014bd 100644
> > --- a/drivers/rtc/rtc-pcf2127.c
> > +++ b/drivers/rtc/rtc-pcf2127.c
> > @@ -656,6 +656,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> >  	pcf2127->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> >  	pcf2127->rtc->range_max = RTC_TIMESTAMP_END_2099;
> >  	pcf2127->rtc->set_start_time = true; /* Sets actual start to 1970 */
> > +	set_bit(RTC_FEATURE_ALARM_RES_2S, pcf2127->rtc->features);
> >  	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf2127->rtc->features);
> >  	clear_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
> >  
> > -- 
> > 2.35.1
> > 
> 
> 
> -- 
> Hugo Villeneuve <hugo@hugovil.com>

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
