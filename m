Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FD0550B74
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 17:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbiFSPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 11:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiFSPMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:12:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE64BF67;
        Sun, 19 Jun 2022 08:12:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id es26so10233063edb.4;
        Sun, 19 Jun 2022 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=RJzDkPFskjglyxjdgSbQuGOhzURnWkxTtKrsQq5BUFw=;
        b=ca4jxDqIoJXxrf5ao9yeMdnG7Zs8YtOPO2bL90eFOVvJcPdEMXBbRuHOzH5iOgCUzC
         tQmFWpqka7TJ75fR+1njsa2Js3GGIUmLws8YSHlexEcY0TG11XDNQKlLcSDhTU+GG8/S
         8OEMmYbtLUPGEzNbDe39T4s6s72ygDrbJOOnIanByNoN31t+7XBVg+rdEl4cgrI/BfAU
         mfuQOnQuykbMheyYOJJHEGu0/hSM4+eM4lCiU76x2vT5abBthJOIPCuOvAIBkxQkhlDq
         doDldvUsFegQotL89sv83eyjt+FKla4TpKr+hW3uc/iO9uGqYR/CTAf/JBa51Egmms0H
         Uufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=RJzDkPFskjglyxjdgSbQuGOhzURnWkxTtKrsQq5BUFw=;
        b=UwKZ5+q7aD2QD4WrhX6XeAi9Lu4nz1kTCjclhsNly63fFngcrpnCFkqwXkyxZj23NE
         XUQaFODPryMvfrnf0IMD8hAfquTlcEp/UknugY6T0T1knanokRQbUPvxYXnAnNg6h66m
         SZG3NTCZx1MKUHkBUe4EAgyzEqfxzwzyb8PImllXSD4AphWLwuptQn56Rc1iqgcpQnfl
         SnInP7TohpEhgQB4Z49Wj7Iqlirm3NP6aebzPY0FVrLeh5AWAvSQ4Ox+wjJzVI09FJk/
         vSuanQxUPfxeiPxcknJ//d+8wpWXRbTDfDyiYOkUGR0oPP1MbC1sig4wTwilr0JQyRbb
         /Qng==
X-Gm-Message-State: AJIora8RbdUMJmiKxicmMHXMotDffLGBSiLXtSMWUJ5dI3T59mCHCzJp
        JTLVbM1I0wgFHfP8wPHDfZ8=
X-Google-Smtp-Source: AGRyM1v/1/odC+BbzOn8+WAbHaAy9Eq6BUjjD43Ft9rWd9fgvmQsnW9Ih/bLdq+yXZTkZLFHjarapg==
X-Received: by 2002:a05:6402:3482:b0:42d:e063:7c1d with SMTP id v2-20020a056402348200b0042de0637c1dmr24456140edc.40.1655651537531;
        Sun, 19 Jun 2022 08:12:17 -0700 (PDT)
Received: from localhost (92.40.168.204.threembb.co.uk. [92.40.168.204])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906368e00b00705f6dab05bsm4637837ejc.183.2022.06.19.08.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:12:17 -0700 (PDT)
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
 <20220618214009.2178567-12-aidanmacdonald.0x0@gmail.com>
 <20220619121315.203a709b@jic23-huawei>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 11/16] iio: adc: axp20x_adc: Add support for AXP192
Date:   Sun, 19 Jun 2022 16:11:51 +0100
In-reply-to: <20220619121315.203a709b@jic23-huawei>
Message-ID: <9VAa62XhSlCMAJF7vdE7bHGSg95FKyr6@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Cameron <jic23@kernel.org> writes:

> On Sat, 18 Jun 2022 22:40:04 +0100
> Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:
>
>> The AXP192 is identical to the AXP20x, except for the addition of
>> two more GPIO ADC channels.
>> 
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> Hi Aidan,
>
> Looking at this again, I'd have a slight preference for doing the switch to
> adc_en2_mask as a precursor patch.

I might as well, it's a bit cleaner that way.

>
> Still, not a big thing (and I should have raised it earlier!) so up to you.
> Either way
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Thanks,
>
> Jonathan

