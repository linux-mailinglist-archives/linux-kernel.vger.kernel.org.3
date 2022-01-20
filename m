Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE74495708
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348190AbiATXf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:35:56 -0500
Received: from mail.hugovil.com ([162.243.120.170]:49952 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiATXfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=f3L6TZiJ+uQRcJZkGE5CwwCr2VwQ6AVuXmjyr0r35t4=; b=GNE+s1WZLCKxV6C7H88EjIH/Bv
        DQJfa+dfUFhV7NDRzEUQ3Urc1qjZVMXLkF+vhLtaXkeXTJ7KUGr6+/xJDfFG5HLVHWkYAOR5427qP
        LQpGsDnX8DyciLozziTRcwpUEhEf+hgyXoZIc1gAVNTuPnGRTId6wevvaCmL2aSC6olo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54882 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nAgy4-0004Me-LJ; Thu, 20 Jan 2022 18:35:50 -0500
Date:   Thu, 20 Jan 2022 18:35:48 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20220120183548.e6a8f46ede2a636a8eaf11c1@hugovil.com>
In-Reply-To: <YehiHJXP23TSREbE@piout.net>
References: <20220119172740.1856302-1-hugo@hugovil.com>
        <YehMZC4vduvSH5HA@piout.net>
        <20220119130845.6de245b8b217e659cd319328@hugovil.com>
        <YehiHJXP23TSREbE@piout.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.hugovil.com
X-Spam-Level: 
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: bootlin.com]
        * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 NICE_REPLY_A Looks like a legit reply (A)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] rtc: pcf2127: add error message if writing to CLKOUT
 register fails
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 20:10:20 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 19/01/2022 13:08:45-0500, Hugo Villeneuve wrote:
> > On Wed, 19 Jan 2022 18:37:40 +0100
> > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > 
> > > On 19/01/2022 12:27:39-0500, Hugo Villeneuve wrote:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > 
> > > > If writing to CLKOUT register fails, the probe operation will be aborted
> > > > without a meaningful error message.
> > > > 
> > > 
> > > The current trend is to remove debug messages, please do not add more :)
> > 
> > Hi,
> > If the read operation fails, the probe function will exit silently, and our RTC chip will not work. In that case, if we parse the dmesg logs, I think we  should have an indication that something went wrong.
> > 
> 
> This is not true, it doesn't fail silently, you'd get:
> rtc-pcf2127: probe of 1-0051 failed with error -121

Well this is certainly true for me because I am not seing the same error message as you :)

Just for context, I have defined a dummy pcf2127 on I2C bus 0 in my device tree (no actual hardware is present). I also added some debug messages to investigate (rtc-pcf2127.c and dd.c files), and here is the dmesg log after issuing "modprobe rtc-pcf2127":

[Thu Jan 20 23:22:20 2022] rtc-pcf2127-i2c 0-0051: pcf2127_i2c_probe
[Thu Jan 20 23:22:20 2022] rtc-pcf2127-i2c 0-0051: pcf2127_probe
[Thu Jan 20 23:22:20 2022] rtc-pcf2127-i2c 0-0051: PORO disabling failed with error -6
[Thu Jan 20 23:22:20 2022] rtc-pcf2127-i2c 0-0051: call_driver_probe probe error: -6

Error code -6 is -ENXIO, and looking at the call_driver_probe() function in dd.c, I now understand why I didn't see the error message (line 531):

	case -ENXIO:
		pr_debug("%s: probe of %s rejects match %d\n",
			 drv->name, dev_name(dev), ret);

So it seems that the return code is different than what you got?


> > I had a case where my dev board was not properly plugged-in, and before this patch, I didn't notice it because of the silent abort of the probe function.
> > 
> 
> Again, not silent.
> 
> > > 
> > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > ---
> > > >  drivers/rtc/rtc-pcf2127.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > > > index 3d1f57e54372..823abe2a7147 100644
> > > > --- a/drivers/rtc/rtc-pcf2127.c
> > > > +++ b/drivers/rtc/rtc-pcf2127.c
> > > > @@ -717,8 +717,10 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> > > >  	if (!(val & PCF2127_BIT_CLKOUT_OTPR)) {
> > > >  		ret = regmap_set_bits(pcf2127->regmap, PCF2127_REG_CLKOUT,
> > > >  				      PCF2127_BIT_CLKOUT_OTPR);
> > > > -		if (ret < 0)
> > > > +		if (ret < 0) {
> > > > +			dev_err(dev, "writing to CLKOUT register failed\n");
> > > >  			return ret;
> > > > +		}
> > > >  
> > > >  		msleep(100);
> > > >  	}
> > > > -- 
> > > > 2.30.2
> > > > 
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
