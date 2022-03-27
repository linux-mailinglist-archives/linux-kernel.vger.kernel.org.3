Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97464E88B1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiC0QNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiC0QNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:13:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73971C13E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:11:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so11630521wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=6GFJ7ancB1plEhfgVzWZYVl+G7Gv/ojaNkdikZ/2jZg=;
        b=orqlMfSrIwbyWYkxZvplXPR/LEXQlsFsphWNY42yJ+k9AqwBhabrHAiJkEGgEJQ4c5
         tVuDgtkcZUw1pUawPj2wupbIlL/noe5AYE2CHM7E0rKnye5waqjP/HxuCyT9FwuCnpK2
         xsMGqznycLaxDy5IQwMEQWsmr+IyiRLbLY0HGQDcchsthrw8OOApWaGgBVIrBl4JiXAj
         2/vaEs0dJJXrLC+rjpwDoOFI8FYSXTIWoUMrh6rMex8x0zFj05tukxn4PUD+cmQSsaMr
         JozTSLpuTmfQepoKzpTN39+u5OADe14u/40UVQWLBl4P62b8cwQ7VuhzncUvLB52PfFk
         c7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=6GFJ7ancB1plEhfgVzWZYVl+G7Gv/ojaNkdikZ/2jZg=;
        b=lCnSfPNyb3G7cQXg5I1Xp2wqEoIzzyqUOXJBwOYTCj7ciW0/wBeAY6RERnzvH3D23u
         ycONiCfSGi1E8mvm/y6mB8AqSWMptQr2Rd7SewvGBdDgTZlb+F6qLlopeulXIxEzbsxw
         i8rOmBUVxI5GyOBMbW3fjnJOi+pbdMXCdykKeLvJ5qn5U0ABk994wEKtyK2SuM9XruSz
         ncyJcQT+TmiwA1wCPvOsYF6Aj2zUhxMqbotYyjc5VOL1XNr/R2a9XaajSqSt3gfdgR4h
         Mg+yxCnw7XG27Vyowc/Are9Zp98nCCep8wY6s/MBKshqo7a0Jtb+SicibDCEppM7XfV+
         sw6g==
X-Gm-Message-State: AOAM5339C5IOVD5bLIt6YtG10wvCZsSje13Nci3mAlATo8bhP3UY37yA
        sRp1uYZQN5shki/O3pOLTpVFZw==
X-Google-Smtp-Source: ABdhPJxkS2ERSmOVuz2DI45w4YukiucqyQOcslY68QODGIq7pyctREMo4NgaLnq/arb34R/RiBevjA==
X-Received: by 2002:a05:600c:5029:b0:38c:9768:b4c with SMTP id n41-20020a05600c502900b0038c97680b4cmr19962707wmr.123.1648397486308;
        Sun, 27 Mar 2022 09:11:26 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id v8-20020a1cf708000000b0034d7b5f2da0sm9633355wmh.33.2022.03.27.09.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:11:25 -0700 (PDT)
References: <1jk0cf6480.fsf@starbuckisacylon.baylibre.com>
 <20220327130801.15631-1-xiam0nd.tong@gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        khilman@baylibre.com, lgirdwood@gmail.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, narmstrong@baylibre.com,
        perex@perex.cz, stable@vger.kernel.org, tiwai@suse.com
Subject: Re: [PATCH] soc: meson: fix a missing check on list iterator
Date:   Sun, 27 Mar 2022 18:05:26 +0200
In-reply-to: <20220327130801.15631-1-xiam0nd.tong@gmail.com>
Message-ID: <1j35j374us.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 27 Mar 2022 at 21:08, Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:

> On Sun, 27 Mar 2022 13:03:14 +0200, Jerome Brunet <jbrunet@baylibre.com> wrote:
>> On Sun 27 Mar 2022 at 16:18, Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>> 
>> > The bug is here:
>> > 	*dai_name = dai->driver->name;
>> >
>> > For for_each_component_dais(), just like list_for_each_entry,
>> > the list iterator 'runtime' will point to a bogus position
>> > containing HEAD if the list is empty or no element is found.
>> > This case must be checked before any use of the iterator,
>> > otherwise it will lead to a invalid memory access.
>> >
>> > To fix the bug, just move the assignment into loop and return
>> > 0 when element is found, otherwise return -EINVAL;
>> 
>> Except we already checked that the id is valid and know an element will
>> be be found once we enter the loop. No bug here and this patch does not
>> seem necessary to me.
>
> Yea, you should be right, it is not a bug here. id already be checked before
> enter the loop:
>
> if (id < 0 || id >= component->num_dai)
>                 return -EINVAL;
>
> but if component->num_dai is not correct due to miscaculation or others reason
> and the door is reopened, this patch can avoid a invalid memory
> access.

This is a speculation which just does not hold ATM. What this patch does
is adding dead code cause the last "return -EINVAL;" will never be
reached.

This no fix nor improvement.

> Anyway,
> it is a good choice to use the list iterator only inside the loop, as linus
> suggested[1]. and we are on the way to change all these use-after-iter cases.
>
> [1]https://lore.kernel.org/lkml/20220217184829.1991035-1-jakobkoschel@gmail.com/

You can make improvements as long as the code is kept clean an
maintainable. Dead code is not OK.
