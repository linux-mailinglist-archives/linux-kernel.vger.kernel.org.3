Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAA759614D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiHPRkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiHPRkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:40:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C197F104
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:40:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x23so9847577pll.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc;
        bh=hIMXk1lCy7PeMgMus9bPUNIc2yzEqIefq4WSi+UIz3g=;
        b=gU23TNm472yJs3AYqGyYKrwfLS2f6Nk7Rj9rKopRrOtj2OZaZeYJXPuj9+bsEV3Ckg
         IWXMzfRX2+cdXvkbjuffEQmwKQi84FsiTAgZXzqMkHWQ5vy1oB/xyjdzLGJRz6LY+5oS
         oEPLku9+93HGey8m6M0RubpDyeoXv4UkEtQHKfNyVsav73ti+8JXsUSJSkNXTLo6ZBbd
         6Z7SZTO79smvNijNR6LLZgPbrXD38xjyjB6GtteYjC4b2IYj2x0+qmQqhUbY3v84AkSv
         8oW4VxasJ+xgnIteVFMJfZlPL1M/oZ/is244hdD3vQcW2IrVd3eImVjnzUnifWvRYUgE
         rWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=hIMXk1lCy7PeMgMus9bPUNIc2yzEqIefq4WSi+UIz3g=;
        b=u2OD4ldCK86eLZA7b/mAno3TEiNW31tY+nvR+qcDxU2LOtbEcqJjcjUzuU+j3twU0D
         vt1aA+cqwCkBu6Eus5wJUY21Tykx/uKJI7vXyrMB9K1CAfUG7XeN2CrtBgz9erLa4fCu
         D4bIqj8kzs3Jzb94bzaADcD5pRq3nh8/M3mFCoA7HLnevCIJhU8SJ3VZFlJggHFAhlwr
         fjPvFhjTGXllERHxUjiVuau5JeFTBPYJkIP/VItrOFuCOHGsRT3idS1H3Np3I8ZeP9A3
         PIgNFJiXZx9WYHpURWvs0zk4DowbCzK7XuPlIwpI5JNWTxBPYfHXcWK2sBxjGMJS7uK1
         1pLA==
X-Gm-Message-State: ACgBeo2xg7D2O26QvOf8db6PUAjTg3T8MtuR6VUak+oAaAWTmw5/UVoC
        nT8nFPO6az21KHQu4DAlzPdpQQ==
X-Google-Smtp-Source: AA6agR52J8m2xodPayu3JfjmxNMO+0/0nJn8LACM9hVk8SrKFlqPoYwm4lTP+KDm6rI3hZkyoFEigg==
X-Received: by 2002:a17:90b:3849:b0:1f4:89bb:14dc with SMTP id nl9-20020a17090b384900b001f489bb14dcmr25184319pjb.144.1660671606634;
        Tue, 16 Aug 2022 10:40:06 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902dccc00b0016d4f05eb95sm9279904pll.272.2022.08.16.10.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:40:06 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?P=C3=A9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] of: irq: Export of_msi_get_domain
In-Reply-To: <CAL_Jsq+DDPTYodAk-TKs61AUpdYhocWq+EoRGgVwgc1hz5gk0A@mail.gmail.com>
References: <20220812174420.2706827-1-khilman@baylibre.com>
 <CAL_Jsq+DDPTYodAk-TKs61AUpdYhocWq+EoRGgVwgc1hz5gk0A@mail.gmail.com>
Date:   Tue, 16 Aug 2022 10:40:05 -0700
Message-ID: <7hh72cw0i2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh+dt@kernel.org> writes:

> On Fri, Aug 12, 2022 at 11:44 AM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> Export of_mis_get_domain to enable it for users from outside.
>
> typo
>
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Link: https://lore.kernel.org/r/20200122104723.16955-1-peter.ujfalusi@ti.com
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>> Peter tried to resurrect this in 2020 (c.f. Link tag in log) but it
>> didn't work.  Here's one more attempt.  I need this enable building
>> some TI DMA drivers as modules.
>
> Then apply this with that enabling. I've already acked it (which keeps
> it out of my queue, so drop that if you want to ensure I see it).

OK.

I assumed you'd want to take this through your tree, but if you're OK
with it getting merged with the series using it, I'll do that.

Thanks,

Kevin


