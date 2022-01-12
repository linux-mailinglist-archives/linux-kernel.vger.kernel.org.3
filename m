Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1377F48C5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353989AbiALONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353961AbiALONH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:13:07 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8326BC06173F;
        Wed, 12 Jan 2022 06:13:07 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s30so8584069lfo.7;
        Wed, 12 Jan 2022 06:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FZO7GH1VAP3gSHj6yutdiODbC5oJX0jySmLnQ+aEZjQ=;
        b=S2lAPi1WJQbC/HEbdwHo2alb0WAeNMwyaDCAGarVnoSS5VbXmaYWRaWxrj0uZRQym7
         WdaldxxcSmISYa/iiXZBt/xCXueESue0xrZafJxUG4F0h7YkK11dO5J1GK8jznyJIgA5
         lMUbY6uCQiBL1p0sZUSqdjVUFEx3D2XOlvlzAE8uqMmaK5Q1NyT9LiKtX2TYh/HHLhdj
         Okv9m+HMoxtHuRJ+MlOicPXiG/5hDrwkJGQ3CNUs2rILI6pmZVUfP69uESnIoUlmqKSq
         AJsER2ZAL3DYZ69rLSpg0cj+uzWjzYiT/T2I+XF5Q5IhTjRrlJnxsyDymywu9iDZ7iov
         UyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FZO7GH1VAP3gSHj6yutdiODbC5oJX0jySmLnQ+aEZjQ=;
        b=vu7R4qWq97/bJ62e1ASvFxl/yLHgMnx4ZgzGCknHVByT9vS7jb9sdmgtpyFRb/hyHc
         /L178ouwbEjeQFN8z4fmJQQgTxB+daAcJMKJvawO4ceEc1dW+ee7XXmyJ9DfXgTqm4ci
         1Oqqi1gawJ9l/+qAQ2ifOI6fHGYzbQObpi3YMi8W7SU/irfzkOm1fDp8ZhHCu48erUSH
         Kgwge8X5pNTYsbULnpBp3UBxdf3R2mX2vc4/QM+wM41WPzOdtCSUI/EU2X9B8D8Ywx7f
         OzkuoGvLvHJh4ddHB4V670V6LO11t0ZNCQ0bSN1R6hGTE203fSB7NuJJ9Q7tggO5nUVL
         m4JQ==
X-Gm-Message-State: AOAM531PLROCoL/gIUpCZiunfkemH/fzzLX8d7l6a+p8Y1sHYxeZ+lie
        +Pqwyeyl67FDjxATS1SxU8o=
X-Google-Smtp-Source: ABdhPJy4lr99ztyBa2kSA3shxOrQgi4BCovoR/p0JF4BQpd8xxVBVzq3w2HMuEnQ81LnX0RG0k3PxA==
X-Received: by 2002:a05:6512:159d:: with SMTP id bp29mr3863011lfb.645.1641996785910;
        Wed, 12 Jan 2022 06:13:05 -0800 (PST)
Received: from [192.168.2.145] (94-29-62-108.dynamic.spd-mgts.ru. [94.29.62.108])
        by smtp.googlemail.com with ESMTPSA id m1sm761824lfh.212.2022.01.12.06.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 06:13:05 -0800 (PST)
Subject: Re: [PATCH v2 0/3] clk: Implement a clock request API
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-clk@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Emma Anholt <emma@anholt.net>, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
References: <20210914093515.260031-1-maxime@cerno.tech>
 <a5400ae3-f181-91fc-bc35-db989584c70b@gmail.com>
 <20220112135147.dbkmsnlqyipq7urq@houat>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d5dbdd71-d5db-53d1-176a-812c908f1abf@gmail.com>
Date:   Wed, 12 Jan 2022 17:13:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112135147.dbkmsnlqyipq7urq@houat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.01.2022 16:51, Maxime Ripard пишет:
> Hi Dmitry,
> 
> On Wed, Jan 12, 2022 at 04:28:41PM +0300, Dmitry Osipenko wrote:
>> 14.09.2021 12:35, Maxime Ripard пишет:
>>> Hi,
>>>
>>> This is a follow-up of the discussion here:
>>> https://lore.kernel.org/linux-clk/20210319150355.xzw7ikwdaga2dwhv@gilmour/
>>>
>>> This implements a mechanism to raise and lower clock rates based on consumer
>>> workloads, with an example of such an implementation for the RaspberryPi4 HDMI
>>> controller.
>>>
>>> There's a couple of things worth discussing:
>>>
>>>   - The name is in conflict with clk_request_rate, and even though it feels
>>>     like the right name to me, we should probably avoid any confusion
>>>
>>>   - The code so far implements a policy of always going for the lowest rate
>>>     possible. While we don't have an use-case for something else, this should
>>>     maybe be made more flexible?
>>
>> Hello Maxime,
>>
>> On NVIDIA Tegra we use interconnect framework for converting of
>> workload-based memory bandwidth requirement to the memory clock rate
>> [1]. All Tegra SoCs have two display controllers and other memory
>> clients, ICC takes care of summing and updating memory bandwidth for us,
>> which in the end results in a freq change of the shared memory controller.
>>
>> [1] https://git.kernel.org/linus/04d5d5df9
>>
>> Not so long time ago me and Thierry Reding were looking at yours v1 and
>> back then Thierry suggested that the same ICC approach might work for
>> yours case. I'm now looking at the v2 and yours discussion with Stephen
>> Boyd, and it appears that ICC is indeed what you really need. Have you
>> considered to use ICC?
> 
> The goals seem to be similar indeed, but most of these clocks feed some
> internal state machine in those devices and are not related to the
> memory bandwidth at all. So there's no real interconnect to model there :/

If you could convert resolution/pclk to BW and BW to the clock rates,
then it should be possible to model ICC. BW doesn't necessarily need to
be "memory" bandwidth, bandwidth is abstract value expressed in kbytes/sec.

The state machine will be ICC provider then, although you'll need to
model that machine as a separate device somehow. For example, on Tegra
we needed to specify clocks as separate devices to model GENPD [2][3].

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b1bc04a2ac5

[3]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/tegra30.dtsi?h=next-20220112#n394
