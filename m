Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B655A74E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiHaEU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiHaET4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:19:56 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E39B7ED7;
        Tue, 30 Aug 2022 21:19:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so8516521pjj.4;
        Tue, 30 Aug 2022 21:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=e7L8u33NrCbTz3Wn8ohLrkFoEXGeKpOVIQkcud1O/8s=;
        b=VoODnOqwvNJDPgRm9iI95WWcs9xOLdpxaufUb+VvGII+rwoaIHdEAPzZ6H1Vnjp1Vr
         oWfk22lzuYGMQztrdLfkuD31Kavwmdq/Aphd33nDdeQK6qhFN8s7osfOFED01e5LFNj4
         OgvTPuu+t9Sa6d6K3kcy3Iv0Ey5uMVeuJJWWEovCHvFSrlIdaG7LWAtYEDWzimdyTFSN
         poXKTdCXfCLmK3TTbGsX0E0EWNj2cCMRjlHlL2TFvRXq+i71UHHxm9dViU+o2hltlcwI
         D+U2abW7/dAesXgi/RTFog+3wWdhBviIeJOzbWVrcKnMEVi4osXiddeSBaL9uvctQ8lx
         8gqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=e7L8u33NrCbTz3Wn8ohLrkFoEXGeKpOVIQkcud1O/8s=;
        b=phEITIVt8qvHbfFtqizkbrprkFSBgpCs3rzxVcYCaAW+sm6vJP7l8F2CGLmlBBlUrO
         3RTXGBKAm3Cs5Cb7lcyjUoUvFCajHrO0aNeHnrr2DfjLx8+3e/2RWJAIo7+GhiHdVFL1
         U0b1FM01ukp/ZzKS69ojPkmpKxRkDGeKWX4nPA/iqYOVAiNLTo3qScBt625p1saUfEvy
         +owcIVcj4Rh0biEynkZYpoHcW5N4Onchq/MPFrf9b/IQ1EKwvWOZp0VDenFbrdqvSORO
         00A0zjSMNNkIpPfkVLka2WwTdIcP5dWnlRQg6tXajJdb3shnypkhh3phUYcbCYbuLbtQ
         S2ug==
X-Gm-Message-State: ACgBeo15YAeJucTJ5jHMyJhJwekpAt89ROSQkLBEA1QlbTThS9W/qW6P
        f7MV1hppJAyAYxyqLEwheTI=
X-Google-Smtp-Source: AA6agR7rnARIPojC432a3CnLSDsgqBRd9wk74SJXwfkQhAciL9Pa+RmWIqRQRWFfhgn0QIAALX1ptA==
X-Received: by 2002:a17:90b:3509:b0:1fb:35ed:6fd4 with SMTP id ls9-20020a17090b350900b001fb35ed6fd4mr1366997pjb.1.1661919560012;
        Tue, 30 Aug 2022 21:19:20 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2488:79db:897a:5de7])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902a38a00b0016bdeb58611sm5792835pla.112.2022.08.30.21.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 21:19:19 -0700 (PDT)
Date:   Tue, 30 Aug 2022 21:19:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v4 00/10] adp5588-keys refactor and fw properties support
Message-ID: <Yw7hRIbsTqOWVeyJ@google.com>
References: <20220829131553.690063-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220829131553.690063-1-nuno.sa@analog.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 03:15:43PM +0200, Nuno Sá wrote:
> The main goal of this patchset is to remove platform data and replace it by
> firmware properties. Original discussion in [1].
> 
> While in here, some refactor was done to the driver. The most noticeable one
> is to replace the GPIs events handling by irqchip support so that this gpi
> keys can be "consumed" by the gpio-keys driver (also as suggested in [1]).
> With this, the gpio-adp5588 can be removed. This change comes first so that
> we can already remove some platform data variables making it easier to
> completly replace it by firmware properties further down in the series.
> 
> As there's no users of the platform data, I just replace it in a single
> patch as there's no point in having support for both (even though it might
> be harder to review the patch as-is).
> 
> Special note to the gpio-adp5588 driver removal. I'm aware of some changes
> to the driver in [2]. These changes are in the gpio tree and this patchset
> is naturally based on the input tree which means that patch 2 will
> not apply. So, I'm not really sure how to handle this. I guess in this
> case the conflict is easy to handle :) but just let me know on how to
> proceed in here if there's anything for me to do.
> 
> [1]: https://lore.kernel.org/linux-input/20220504084617.36844-1-u.kleine-koenig@pengutronix.de/
> [2]: https://lore.kernel.org/linux-gpio/20220628193906.36350-3-andriy.shevchenko@linux.intel.com/

Given that one of the GPIO maintainers Acked the removal I applied the
series to my tree, thank you.

-- 
Dmitry
