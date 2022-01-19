Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F9A493FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356602AbiASSIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:08:51 -0500
Received: from mail.hugovil.com ([162.243.120.170]:49022 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiASSIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8zOYnDHNqtltPFh1+4MBk6WvHQI+mYaP7/8xoY2eUa8=; b=bpfdEvX584Acc4zweUZnqGz2Nm
        lyxreLjjBrN1wn4/HD2biJPR6Gptqhgbmy34hhuma2HBe7+oRM38zbg312AU24/ub8H2de9SSzv9u
        Rydph1MkkcoksL+QhAEZZSVk4IY6TqoaPb/NNBg4Ig8H3U4e9LB7AtfJRMga4ux2IUnE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54850 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nAFO2-00045F-0G; Wed, 19 Jan 2022 13:08:46 -0500
Date:   Wed, 19 Jan 2022 13:08:45 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20220119130845.6de245b8b217e659cd319328@hugovil.com>
In-Reply-To: <YehMZC4vduvSH5HA@piout.net>
References: <20220119172740.1856302-1-hugo@hugovil.com>
        <YehMZC4vduvSH5HA@piout.net>
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
        *      [URIs: dimonoff.com]
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

On Wed, 19 Jan 2022 18:37:40 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 19/01/2022 12:27:39-0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > If writing to CLKOUT register fails, the probe operation will be aborted
> > without a meaningful error message.
> > 
> 
> The current trend is to remove debug messages, please do not add more :)

Hi,
If the read operation fails, the probe function will exit silently, and our RTC chip will not work. In that case, if we parse the dmesg logs, I think we  should have an indication that something went wrong.

I had a case where my dev board was not properly plugged-in, and before this patch, I didn't notice it because of the silent abort of the probe function.

> 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/rtc/rtc-pcf2127.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > index 3d1f57e54372..823abe2a7147 100644
> > --- a/drivers/rtc/rtc-pcf2127.c
> > +++ b/drivers/rtc/rtc-pcf2127.c
> > @@ -717,8 +717,10 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> >  	if (!(val & PCF2127_BIT_CLKOUT_OTPR)) {
> >  		ret = regmap_set_bits(pcf2127->regmap, PCF2127_REG_CLKOUT,
> >  				      PCF2127_BIT_CLKOUT_OTPR);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			dev_err(dev, "writing to CLKOUT register failed\n");
> >  			return ret;
> > +		}
> >  
> >  		msleep(100);
> >  	}
> > -- 
> > 2.30.2
> > 
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
