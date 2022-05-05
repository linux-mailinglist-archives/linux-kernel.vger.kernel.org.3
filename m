Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD651C633
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382753AbiEERie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382756AbiEERi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:38:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609325D5F6;
        Thu,  5 May 2022 10:34:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p18so6025543edr.7;
        Thu, 05 May 2022 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J36psD3rFKW5Ka1G3ZnsSWZIunr7YdwdE2cf/mL9osk=;
        b=Gg2LXPVobwp4o5mG9uKglG3BHaRDZIpvfVQeotr8r2wGV8xJdunSEbXkxMuyiSp2iX
         3VawHmVZDLBxsGEZtc5IpMRU6QxVktJ13EKeH7DNy0XdSzT37nLrXluGkP5iD6LpIPyn
         ElJTabd9OIdllU21SBxy4LANhKIQEsXI4QUPRMw0ToOvkTHl5ruIM0vJFQ1AVe8vVSih
         xdi8qXRwDCZF8sUAa8SCUgNdAIlrnJhyql7rSoL/NgWYCma9BYPRjeA9CqmyZnsbVGZT
         tlqPO5xgwD+rM2qBhghryfPw4DPRRyED5N3MGHSOViaYGBPbReY8OXi+3cVvfsVkZTLE
         jAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J36psD3rFKW5Ka1G3ZnsSWZIunr7YdwdE2cf/mL9osk=;
        b=Tqv+6iwIoH7Jrlwdah5Rpm7UhxZ07uIHg+ZFhRcIxBMu8uDilr28MOLZC5uymJWNjt
         bffmyvnYuaVYSmflXghDfvadNkcx9t4BCdkgdZIPzUhZU2VpGhTjLq8xl1H2ZRQoSmNY
         VC4PfcmFgMsJl6OMbTxTCp9xPIVoKO4rkIHpR55/J51Sw6nIssShu81PQpFN4FiFjObq
         +e7bANQoQDsv8oi3fMu7CcBVGAAA2bycjsFZt8ax+LK80egIQB53Tp2S6vPLs4f8fwdl
         us+Yh7qW27ET0+bW8Obkfgrck9dUFuWAF//fTz78PriM5/75HjyTznCxDZqao28XF65/
         LvcQ==
X-Gm-Message-State: AOAM530D6VRUsUfrjahLbMDrXfjblFV9K/ILzIvbsy5cVzNIZlLzk7Hl
        dWseIdRW3Y2duRojtJAsfgQjdGniygsCtpMluDU=
X-Google-Smtp-Source: ABdhPJzHFa4/201KxKWvXvIzAle09vJstgG8ZVqW0xdZ3Xd4qabmhd7jnoJgV/HYyztLG08q1inSAhpKX0wJqtjSlo0=
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id
 f20-20020a056402005400b004199b58e305mr31028257edu.158.1651772082896; Thu, 05
 May 2022 10:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220505152521.71019-1-markuss.broks@gmail.com>
 <20220505152521.71019-2-markuss.broks@gmail.com> <CAHp75VfUA3qnZnkPQB3TRpPDwe+F+Q6rv9dQmq2xLfw9PmJ8LA@mail.gmail.com>
In-Reply-To: <CAHp75VfUA3qnZnkPQB3TRpPDwe+F+Q6rv9dQmq2xLfw9PmJ8LA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 May 2022 19:34:07 +0200
Message-ID: <CAHp75VeVN_Ri2wbQ1ATJg6+R=K6ekQbqGKKNXPdti0rpDptzZA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] leds: ktd2692: Avoid duplicate error messages on
 probe deferral
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     pavel@ucw.cz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 7:29 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, May 5, 2022 at 5:25 PM Markuss Broks <markuss.broks@gmail.com> wrote:

...

> 1) adding a Fixes tag, so it can be backported to stable kernels;

To avoid additional versions in case you don't know how Fixes tag
should look like:

Fixes: b7da8c5c725c ("leds: Add ktd2692 flash LED driver")

Just add this before other tags, like SoB or Reviewed-by (no blank
lines in the tag block).

-- 
With Best Regards,
Andy Shevchenko
