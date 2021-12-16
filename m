Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D955E476D51
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhLPJWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbhLPJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:22:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6A7C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:22:16 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a18so42970550wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=IBIcLZSOy80V1yBzhtcSFcqDD4kkSdfp+gTS9zZBVCk=;
        b=XPwMjjS896rF3wTPgiL4/7AJY56mYN+5vaZ7vvkRsi2Dz9xjnSF+kNAjfDHlE7mEqm
         nICcYZUXRCzHjg3Ahnfu7YadMbpn5UKx87+NRxJCUPOMCudu9t4jlvALU2yP8+kvMNDC
         6aBRg8UkobFS6YwtcnwZItuubVAlYOlLIH4AbYOtQ1fR5PCTzYfMSmRHPw4qkF4cwnCH
         IJZXrBcCXmVwAmNQZlza5H8bm14GZJBK4Q9PyjHo4FiBYTebUPGjY2/3TvVegtgzEO3V
         DY8MLaUdZNqKaP++ZeyWNBG7Gg9ip1GfqMlscvGxWJq33oli0ljkfY+DDuGxaZCNQSHZ
         60qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=IBIcLZSOy80V1yBzhtcSFcqDD4kkSdfp+gTS9zZBVCk=;
        b=cMt4RmvDG2+LDhH3vd5n0Xx2yi+hNce8kShS9dUOacMnKUe294N6H1Vjii38tB2cCW
         lsjeT5wjAbirNsNj5zMYkJ4+ePUWB5B2QUUZYdaGHul0ggE9V8CowDTOYDdpUKDnd/ue
         TDfe/PCpoaUopoqUmgHQV2MKzR9n1Cj3T4z2xLyRrUcj7SqWYgLil7vaiR9b7wyHpqQI
         cCwvPuxsKnPn36+FjIobZ0+Wnn1Ky1la8aRJ0TvRQgbSs/8f4F2GhnK594HBFD+ckdWs
         T8xGCOOJj6yBQ9LbIf3AM1w3zUZHYEv04kUoi2DZjQ1sT5xQdfOhcG62nbBNzhclV9NL
         ebRg==
X-Gm-Message-State: AOAM53351pcNyP8cu/loq0naxRHzxzu+ggwmQLmpsfL5XqWHaUAwO/t4
        aMYu2/JIcZB9xTgPWe4WKO9vcQ==
X-Google-Smtp-Source: ABdhPJxSnTquNq6JwmPv+bXWcRlBCk+Bimb5jSizbS7N5/Rsoe683qozx8WpAu0ZU+/nhDp/7JIxlA==
X-Received: by 2002:a05:6000:118a:: with SMTP id g10mr7702290wrx.533.1639646534830;
        Thu, 16 Dec 2021 01:22:14 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c11sm738335wmq.48.2021.12.16.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 01:22:14 -0800 (PST)
References: <20211214022100.14841-1-qianggui.song@amlogic.com>
 <20211214022100.14841-4-qianggui.song@amlogic.com>
 <1j35mv31c1.fsf@starbuckisacylon.baylibre.com>
 <0a3efa6f-f048-ee04-a2d6-30f337f3d484@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     "qianggui.song" <Qianggui.Song@amlogic.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/3] pinctrl: meson: add pinctrl driver support for
 Meson-S4 Soc
Date:   Thu, 16 Dec 2021 10:20:54 +0100
In-reply-to: <0a3efa6f-f048-ee04-a2d6-30f337f3d484@amlogic.com>
Message-ID: <1jczlwaoqj.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 16 Dec 2021 at 14:07, qianggui.song <Qianggui.Song@amlogic.com> wrote:

>>> +static const unsigned int clk12_24_pins[]		= { GPIOD_10 };
>>> +static const unsigned int pwm_g_hiz_pins[]		= { GPIOD_11 };
>>> +
>> [...]
>> 
>>> +
>>> +static const char * const tdm_groups[] = {
>>> +	"tdm_d2_c", "tdm_d3_c", "tdm_fs1_c", "tdm_d4_c", "tdm_d5_c",
>>> +	"tdm_fs1_d", "tdm_d4_d", "tdm_d3_d", "tdm_d2_d", "tdm_sclk1_d",
>>> +	"tdm_sclk1_h", "tdm_fs1_h", "tdm_d2_h", "tdm_d3_h", "tdm_d4_h",
>>> +	"tdm_d1", "tdm_d0", "tdm_fs0", "tdm_sclk0", "tdm_fs2", "tdm_sclk2",
>>> +	"tdm_d4_z", "tdm_d5_z", "tdm_d6", "tdm_d7"
>>> +};
>> On previous chip, there were pin assigned to tdm A, B or C.
>> On this generation, it seems you have added a second level on pinmuxing
>> to re-route the audio pins to different controllers
>> In such case, I don't think they belong in the same group.
>> Depending on settins, D2 and D3 could be unrelated
>> I think each audio pin should have its own group (one group for D3, one
>> D4, etc ...)
>> 
> According to our audio colleague, on this chip, tdm A/B/C can choose which
> pins are routed to their controllers freely by writing special registers,
> say, tdm_d2_c can be assigned to any of tdm a, b and c by demand, so no
> need to specify a/b/c words any more.

That's basically my comment above. Comment still stands
Each D and FS pin could be related to different interface and should be
in different groups

