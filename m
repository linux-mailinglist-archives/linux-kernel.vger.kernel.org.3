Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246BE4770F2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhLPLpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:45:03 -0500
Received: from mail.wizzup.org ([95.217.97.174]:44500 "EHLO wizzup.org"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234276AbhLPLok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
        s=mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=S9Vleixp9Hk+l/pEzhz3w9o6LjKmpY/kaFA5/9KTWIo=; b=Kb9usO7WOx4xMq3OTJPeR5S67W
        sAv49bME9rdg/TSeWfL1WmJH42ssyM2ACS78KdJ8FicY5nDtGSEG96foUNKplVGUfNfwZfOY3Hfzn
        ZDWEPojvUno4c+J+Ge6rq99UeLlsderkBMirLQvwdnwto6s+SbvdSlz+JfaE+5M8AjoAWQiUYPTjq
        whshHbmdJ+41nC499/wH1D28PhQYkHkMec35Mp3k0uFJxUy9m0JjvhQ/YdYDaWz7qgHT7/NKHeoku
        jj1RRvUjjwTNBPrIaEtxqS6ttKVnBuA3H5kBmmOZzwf1ukB3sIbGDvUg4baIuT8A6g0mV7lXjztKc
        zqVdilEg==;
Received: from [45.83.235.159] (helo=[0.0.0.0])
        by wizzup.org with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <merlijn@wizzup.org>)
        id 1mxpBU-0004NN-Im; Thu, 16 Dec 2021 11:44:28 +0000
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211212224007.10293-1-merlijn@wizzup.org>
 <20211212224007.10293-2-merlijn@wizzup.org>
 <20211215203113.GE28336@duo.ucw.cz>
From:   Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 1/2] ARM: dts: omap3-n900: Fix lp5523 for multi color
Message-ID: <ad6fb0bd-5473-9ecb-b97b-ecab9c70a73e@wizzup.org>
Date:   Thu, 16 Dec 2021 12:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211215203113.GE28336@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 15/12/2021 21:31, Pavel Machek wrote:
> Hi!
> 
>> From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
>>
>> Since the LED multicolor framework support was added in commit
>> 92a81562e695 ("leds: lp55xx: Add multicolor framework support to lp55xx")
>> LEDs on this platform stopped working.
> 
> Does this change names is /sys/class/leds?

I booted my 5.15 with this series (and some other patches) added and
these are the led names:

> root@devuan-n900:~# uname -a
> Linux devuan-n900 5.15.2-00596-g94bfc7de5522-dirty #58 SMP PREEMPT Thu Dec 16 11:53:53 CET 2021 armv7l GNU/Linux
> root@devuan-n900:~# ls /sys/class/leds
> debug::sleep  lp5523:g    lp5523:kb2  lp5523:kb4  lp5523:kb6
> lp5523:b      lp5523:kb1  lp5523:kb3  lp5523:kb5  lp5523:r

On 5.1 (my previous 'stable') kernel, these are the led names:

> root@devuan-n900:~# uname -a
> Linux devuan-n900 5.1.21 #1 Mon Jul 19 16:32:44 UTC 2021 armv7l GNU/Linux
> root@devuan-n900:~# ls /sys/class/leds
> debug::sleep  lp5523:g    lp5523:kb2  lp5523:kb4  lp5523:kb6
> lp5523:b      lp5523:kb1  lp5523:kb3  lp5523:kb5  lp5523:r

So I don't think the names are changed.

Regards,
Merlijn
