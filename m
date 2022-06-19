Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96E9550B5A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 17:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiFSPE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiFSPEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:04:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3092669;
        Sun, 19 Jun 2022 08:04:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id o9so2671309edt.12;
        Sun, 19 Jun 2022 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=MvHWIYxlnwe5DqT8JCWuuCj202RaByoQ+NVNi6elRV8=;
        b=NRLvCCqiC/na3Uu0utCLUNnZqPZ5yvRgu9kPAAKomC+eJaZz0xEc8mbNxJaYZ/urW2
         5Wvm9aY1fAEYhET4vvhqGl7Be9gtAVxpUD2Y6P3Ue6NLdPDOu2yV3rPwZalI5qTsF/71
         o3UQ/w9IQcJUByvj05HpVPq0ZJXm3PclcmPZ9HYyR9gQVn/eO0fBUsx50WJ/lNp3FYyJ
         36yJ+AB3OFtfi133MolywZFIRRX/rj/jdScxxKwM/4xWDaTfNOVxSoV0iGsv7TXj9wqE
         5zCrqzNsXNl3KnlbTUPLGY8HV7Tm4e9nl0Lu7I/wmYq5i0fbe3tfeooIorWoGCMlQYGj
         4rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=MvHWIYxlnwe5DqT8JCWuuCj202RaByoQ+NVNi6elRV8=;
        b=Y/QsTmZ9au6l7idhuLO/hcCClh003uTL+q7VhzUh6etbO8iNOveja3MxxhsJ6MlbQC
         mw/Nlvq3QppRSR18HYRJ6ao7bm1cYvbuNHo/E9PrTgbAs7SkXOHwLPEZcCMHf0qWoo+v
         bJ7VCHa+9r54VY2jLAqAXOB3njOumgfjg5JnhkdDY7lsobbnnnUKLe4JGtheIMtDJLck
         Vp/UpkLW5kiodxxlmjJ5Mtgvyhs1xr4STYMUkLco9gp/wIbNrChe81SRLcR9qC9kNa5u
         nBH/g2Mtr31/fy9kFaMdHlTQLXPFPuSkCin4JUPL7C2tJ6y9DhZ26FRHufYEQUKLER4q
         FoCA==
X-Gm-Message-State: AJIora9bBsRHqcaC4i1R1C6pAZ/Pygkxo3lZPZricKO1JzVmt8cq+dP6
        iQUDNrLXqlbBP9DKR89wxPY=
X-Google-Smtp-Source: AGRyM1tA4QmqEQushoe9b63xEYZ151MaBU2vByHazOXsFnYORd6ThgZYUl74v6HuIcD8aQR5gLRVcA==
X-Received: by 2002:a05:6402:d:b0:431:98fe:c5fd with SMTP id d13-20020a056402000d00b0043198fec5fdmr23854737edu.170.1655651090973;
        Sun, 19 Jun 2022 08:04:50 -0700 (PDT)
Received: from localhost (92.40.168.202.threembb.co.uk. [92.40.168.202])
        by smtp.gmail.com with ESMTPSA id u20-20020a17090657d400b00712134a676asm4690559ejr.93.2022.06.19.08.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:04:49 -0700 (PDT)
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
 <CAHp75VfrzQFq4u0vMtPM7LRYNcQQC-padQ1yyFijbpWx8_LwBQ@mail.gmail.com>
 <20220619121743.2b259153@jic23-huawei>
 <CAHp75VcG-rkyJ6Sy_ya5Asrzp1hBAofY1qvK+o4iue=FmNGXxA@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "wens@csie.org" <wens@csie.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "quic_gurus@quicinc.com" <quic_gurus@quicinc.com>,
        "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 00/16] Add support for AXP192 PMIC
Date:   Sun, 19 Jun 2022 15:54:41 +0100
In-reply-to: <CAHp75VcG-rkyJ6Sy_ya5Asrzp1hBAofY1qvK+o4iue=FmNGXxA@mail.gmail.com>
Message-ID: <7bYbROHIFQUbzWDNUadQUEIYRAVaP5V5@localhost>
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


Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Sun, Jun 19, 2022 at 1:08 PM Jonathan Cameron <jic23@kernel.org> wrote:
>> On Sun, 19 Jun 2022 00:43:07 +0200
>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> > On Saturday, June 18, 2022, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> > wrote:
>> >
>> > > Changes in v3:
>> > >
>> > > * Update pinctrl driver to address Andy Shevchenko's review comments
>> > >   from v1, and fix a few other
>> >
>> > I believe I gave more comments than just against pin control driver. Even
>> > though, some comments are still not addressed in the series, including pin
>> > control. Am I mistaken?
>>
>> Hi Andy,
>>
>> Maybe, it's a question of clarity/misunderstanding? You had some 'global' comments
>> at the end of the pinctrl review. Perhaps not clear enough you meant
>> they should apply to the rest of the patch series (and more generally to
>> the driver being modified I think).
>
> Yeah, I think that is.
> I don't remember if we have somewhere a documentation on how to
> respond to the review comments, in which the point of addressing
> comment everywhere in the series, and not only in the place(s) where
> it was given.

That's exactly it, I was only looking at the pinctrl patch since that's
the one you replied to, and didn't think to check the other patches for
similar cases even though that's obvious in retrospect. Sorry for any
confusion.
