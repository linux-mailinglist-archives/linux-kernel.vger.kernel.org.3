Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615D652B4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiERI3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiERI3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:29:08 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D6B129EDC;
        Wed, 18 May 2022 01:29:02 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B3692C0003;
        Wed, 18 May 2022 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652862541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NlIcAIfMVoOYvEtRo6Y7sDw80J8H5Asrq5W676I+ZIY=;
        b=hZvXa/hx1psoDuOQFjEyl/yioMON23FcQdUZSzeMOtlIPgecU8iKY3RSGSpxH4IKSZhac+
        HODp6gBIRfPOTZa0I/N/UomGqDuokBldquZyB4xF1VG+NWiCfNq8tXvPVNMpkUomuafM1i
        AKdNdJ5VOcsJtu+65Fu6bMjQvLw/f4e798kfP0Wd9l3BOzv0FHQUJP3zLoUAeuCP0JiS31
        dKjn8KfaCYIg3EalEb0a10izQbg99gyy0nGOW6gSzccY9x/qh+lBlOM9FR0iCkSi/j+ZWF
        +ICGbm+l3bOOQNHQ332soUs0naiH4btAmci3DJXK2q2zww4bI2oSwg3NMa1ggg==
Date:   Wed, 18 May 2022 10:28:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Medad Young <medadyoung@gmail.com>
Cc:     Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, a.zummo@towertech.it,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING <KFTING@nuvoton.com>, ctcchien@nuvoton.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] RTC: nuvoton: Add NCT3018Y real time clock driver
Message-ID: <YoSuS+nFJoD4+oKM@mail.local>
References: <20220517092927.19537-1-ctcchien@nuvoton.com>
 <20220517092927.19537-4-ctcchien@nuvoton.com>
 <YoPzaSc/8BBVWWsB@mail.local>
 <CAHpyw9fw54hQrsPa4psbUs2VfBqHj+gMKDceL2N5k8_jU+434w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHpyw9fw54hQrsPa4psbUs2VfBqHj+gMKDceL2N5k8_jU+434w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 11:11:00+0800, Medad Young wrote:
> > > +config RTC_DRV_NCT3018Y
> > > +     tristate "Nuvoton Real Time Clock"
> >
> > This definitively needs a better description
> 
> OK, I will add a better description.

To be clear, this needs at least the part number

> > > +     tm->tm_wday = buf[6] & 0x07;
> > > +     tm->tm_mday = bcd2bin(buf[7] & 0x3F);
> > > +     tm->tm_mon = bcd2bin(buf[8] & 0x1F) - 1 ; /* rtc mn 1-12 */
> > > +     tm->tm_year = bcd2bin(buf[9]) + 100;
> > > +
> > > +     dev_dbg(&client->dev, "%s:s=%d, m=%d, hr=%d, md=%d, m=%d, yr=%d, wd=%d\n",
> > > +             __func__, tm->tm_sec, tm->tm_min, tm->tm_hour, tm->tm_mday, tm->tm_mon,
> > > +             tm->tm_year, tm->tm_wday);
> > > +

I forgot but this dev_dbg is not particularily useful as we have
tracepoint in the core. However, if you want to keep it, please use
%ptR.

> > > +     return 0;
> > > +}
> > > +
> > > +static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
> > > +{
> > > +     struct i2c_client *client = to_i2c_client(dev);
> > > +     unsigned char buf[10] = {0};
> > > +     int err;
> > > +
> > > +     dev_dbg(&client->dev, "%s:s=%d, m=%d, hr=%d, md=%d, m=%d, yr=%d, wd=%d\n",
> > > +             __func__, tm->tm_sec, tm->tm_min, tm->tm_hour, tm->tm_mday, tm->tm_mon,
> > > +             tm->tm_year, tm->tm_wday);

Ditto

> > > +
> > > +     err = nct3018y_read_block_data(client, NCT3018Y_REG_CTRL, 1, buf);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     if (!(buf[0] & NCT3018Y_BIT_TWO)) {
> > > +             dev_err(&client->dev,
> > > +                     " TWO is not set.\n");
> >
> > This is not useful, what is TWO?
> 
> TWO stands for Time Registers Write Ownership
> for NCT3018Y, driver needs to set this bit before writing to other registers
> 

Can't you simply set it forcefully here instead of erroring out?

> >
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     /* hours, minutes and seconds */
> > > +     buf[NCT3018Y_REG_SC] = bin2bcd(tm->tm_sec);
> > > +     buf[NCT3018Y_REG_MN] = bin2bcd(tm->tm_min);
> > > +     buf[NCT3018Y_REG_HR] = bin2bcd(tm->tm_hour);
> > > +     buf[NCT3018Y_REG_DW] = tm->tm_wday & 0x07;
> > > +     buf[NCT3018Y_REG_DM] = bin2bcd(tm->tm_mday);
> > > +
> > > +     /* month, 1 - 12 */
> > > +     buf[NCT3018Y_REG_MO] = bin2bcd(tm->tm_mon+1);
> > > +
> > > +     /* year and century */
> >
> > Were is the century?
> 
> I will update the comment, for there is no century.
> 
> >
> > > +     buf[NCT3018Y_REG_YR] = bin2bcd(tm->tm_year - 100);
> > > +
> > > +     return nct3018y_write_block_data(client, NCT3018Y_REG_SC, 10, buf);

So this overwrites the alarm which is something you must not do.

> > > +     buf[0] = bin2bcd(tm->time.tm_sec);
> > > +     buf[1] = bin2bcd(tm->time.tm_min);
> > > +     buf[2] = bin2bcd(tm->time.tm_hour);
> > > +
> > > +     err = nct3018y_write_block_data(client, NCT3018Y_REG_SCA, 1, buf);
> > > +     if (err)
> > > +             return err;
> >
> >
> > Writing byte per byte opens a huge window for a race condition here.
> >
> 
> I write byte per byte,
> because these three registers are not continuous
> 

Right, I did see it and then forgot.

> > > +     nct3018y->rtc = devm_rtc_allocate_device(&client->dev);
> > > +     if (IS_ERR(nct3018y->rtc))
> > > +             return PTR_ERR(nct3018y->rtc);
> > > +
> > > +     nct3018y->rtc->ops = &nct3018y_rtc_ops;
> > > +     nct3018y->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> > > +     nct3018y->rtc->range_max = RTC_TIMESTAMP_END_2099;
> > > +     nct3018y->rtc->set_start_time = true;
> >
> > Do you have a good reason to set set_start_time here?
> >
> 
> Sorry, I am new here.
> I just follow other drivers.
> so you think I should not set set_start_time, right?
> 

There are very few drivers that needs it, when they used to window the
dates they support back to 1970 which is not something you seem to care
about.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
