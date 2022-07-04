Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451BC5659DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiGDPa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiGDPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:30:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FB12B2;
        Mon,  4 Jul 2022 08:30:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z12so4379239wrq.7;
        Mon, 04 Jul 2022 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=3BzrzCAqUiXWdwa7S6mOs7MQCJ+hR2cBiAXIC/nz5OE=;
        b=pEo3A110eDqe0C8fZ2+kIYAscnijme2LDYY4W9SYLg3HEP1ew2OKYFPb5jvbKbkSOB
         PsMGM00wZ9TCvy7UbShPR1UxOih3axNw0Covf9GPi8fsjh2v2QtL9Y6m6KyTguH2FHRG
         iB1sSsljaf/L4txOHmD6XmIGV/v+vYT08/+5gAxcUTILTbDTbQyH+KzzP8Ihc6N/6BU8
         GGAg+1yRFrtDZ9/Xd080gMOZNbsHFk1KMdZZL1TJjgVrj09/BCUlg/5OkVCHYLWQ5a59
         igHwAcaZF5kY5//Si1I77xUZ/hAk8XON3trBVWs5+lEzn0a25b61CupPrRuXykSH7wSe
         Wl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=3BzrzCAqUiXWdwa7S6mOs7MQCJ+hR2cBiAXIC/nz5OE=;
        b=y/RLzwD4ykjGlhzbavjcx/ExOiuS/eSsT+jB4zpuFmn5obI+hvXdP5lGJqngVgmEue
         nxbbFb+Ir6da1fxp/eJu34oZan0Pk+QiU6HpxHj4LWDSOCjJaZd3uEYSGywnvWN7nyIB
         uqkIqZ7/CezQjoBv2Uw6b7wKBqhyKiXUzjTWPXYF4AS9rhCqqCxkjkKSG7lJEXXFsugb
         tbj0tbOCJjYpqL/cZJ3oLMERCase4yXGjOto1qverf38C+20V1UQb9TOAY643Z5sZtRf
         LCNhpXMbRCniQpJDJa4txv4MwaDBdIefKBFyjI8yY5WyX2KPHi79jHtlAYWPziILhXP+
         LQmg==
X-Gm-Message-State: AJIora+xRVOgHWcGc/7hZ1j0cWTFesUiOcbb+58dErVMds65ypSK4GCu
        SJIu3MPhdcmI2Yq1rUF6eoY=
X-Google-Smtp-Source: AGRyM1uuRfDZH9CfG6pD+T3bCdQHQY28/PPevvkVEqoIx+aA31pXma4E3dsFWRfAeIdKrH9tTu6Niw==
X-Received: by 2002:adf:d1e8:0:b0:21b:b7dc:68e with SMTP id g8-20020adfd1e8000000b0021bb7dc068emr26489317wrd.683.1656948650618;
        Mon, 04 Jul 2022 08:30:50 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm29921287wrr.101.2022.07.04.08.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:30:49 -0700 (PDT)
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-3-aidanmacdonald.0x0@gmail.com>
 <CAHp75VcshqBNtd7HFMR39Fh3mR=Uv0m4rznpFPDhix3hB0or7g@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] gpio: regmap: Support combined GPIO and pin control
 drivers
In-reply-to: <CAHp75VcshqBNtd7HFMR39Fh3mR=Uv0m4rznpFPDhix3hB0or7g@mail.gmail.com>
Date:   Mon, 04 Jul 2022 16:31:57 +0100
Message-ID: <yG5ebSToQJ6Oj2Oe8C7JimXFFcPT8LJ8@localhost>
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

> On Sun, Jul 3, 2022 at 1:11 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
>>
>> Allow gpio-regmap to be used for the GPIO portion of a combined
>> pin control and GPIO driver by setting the has_pinctrl flag. This
>> flag will cause GPIO direction set ops to be implemented as calls
>> to pinctrl_gpio_direction_input/output() instead of updating the
>> direction set registers directly.
>>
>> Note that reg_dir_out/in_base is still required for implementing
>> the GPIO chip's ->get_direction() callback.
>
> ...
>
>> +       /*
>> +        * we need a direction register for implementing ->get_direction
>> +        * even if ->direction_input/output is handled by pin control
>> +        */
>
> /*
>  * Multi-line comments go with this format
>  * or style. Pay attention to the capitalization
>  * and English grammar, e.g. period at the end of sentence(s).
>  */
>

I used this "style" to match the surrounding code, but I suppose
I might as well fix the other comments while I'm here.

>> +       if (config->has_pinctrl && !(config->reg_dir_in_base ||
>> +                                    config->reg_dir_out_base))
>
> Can you re-indent this either to be one line or put the second part of
> the conditional onto the second line?

Yep.

>
> And why not use && everywhere?
>

No reason to be honest, but maybe it's easier to understand?

  "has pin control and doesn't set reg_dir_in_base or reg_dir_out_base".

Using && is more like this:

  "has pin control, doesn't set reg_dir_in_base, and doesn't
  set reg_dir_out_base".
