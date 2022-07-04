Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1E5565A8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiGDQAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiGDQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:00:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D92A3BA;
        Mon,  4 Jul 2022 09:00:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j7so5657302wmp.2;
        Mon, 04 Jul 2022 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=4JdnfBFmGrVX5YOJOcmnMbispSWgMSddL5cpJkYT3AU=;
        b=RAB870cX4kXaR6xf3unMvDAsoZPwmC0Idf04JNqTgXKOYAArDZwMbbSHBGH20U2tY/
         0QoIN/go641WVHGqF7GKRISvxkLOEc0Yc6s7xZ4XXSjW+mdm4H+zbWsXpitx8OyJFFNh
         /eyiMcg+j5YCqtPTMA0/j2GafVZeO9kVXJtx2w66396Ndluy/LOmRKVKE0bcMAcKmOG6
         ZG9nYa5jPOngI9W75G9thAeBTNvzZWiZqNBDC8tbk5Ov/ndvsc0gc4eKFpEPZ0qhRIe0
         RTwQXn515ed4K9Tf133ILMz9kCKNv0wk5DTaaLGqUrUXaq52xP4yHJAkZBy2diBNdwG9
         0VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=4JdnfBFmGrVX5YOJOcmnMbispSWgMSddL5cpJkYT3AU=;
        b=UpC7YxwiPHOkU3A3Uc9xGwx0YSdCY8RThFgBMNURF3BrWnU0MOOsbAKqriDDOernMg
         Fah7NQNz79a0HO5qPErCOHAxPnIVqtTzPdfmJlST1p1lxy2fztU4GHIpIEDFCSQtZLm7
         vRyTYD7TxJzJNEADossRViqlZh2I1y1gQNhCI3URQHN25vbaQ2xb4zylfUqLoWNUB8Db
         HFlZSD0u+D3/iZTyq+ym6PTfPCen2U45DVggo2NvxQmF/if2QrfwO8+RrTPhf6Ww4r28
         JVbL4SN2o0kXIvVlhxX32HvWRHULX2WtMrBremHZ9Cvo3RGOgctQjFsmnfFwanmoG4al
         VQhQ==
X-Gm-Message-State: AJIora+EvHt1EcB63B8Hhkh/0BfJcWfFnohWF92SlBRS3M+23V0kfXU1
        CKEFb6cmJvd8M2FFpCvR7/g=
X-Google-Smtp-Source: AGRyM1uXsUkkq2QZ8ImfwkHIap5WzUNNc4mow9pRMJ+YFVg05z1G4i4Zm8gKmO59XOAlh1kOoiGYPA==
X-Received: by 2002:a05:600c:3653:b0:3a0:5716:203a with SMTP id y19-20020a05600c365300b003a05716203amr30801186wmq.175.1656950407832;
        Mon, 04 Jul 2022 09:00:07 -0700 (PDT)
Received: from localhost (92.40.202.6.threembb.co.uk. [92.40.202.6])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d564e000000b0021d68d3a27dsm5127329wrw.45.2022.07.04.09.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:00:07 -0700 (PDT)
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-2-aidanmacdonald.0x0@gmail.com>
 <4c9092d20a35ef3fd6a1723e07adad79@walle.cc>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] gpio: regmap: Support registers with more than one
 bit per GPIO
In-reply-to: <4c9092d20a35ef3fd6a1723e07adad79@walle.cc>
Date:   Mon, 04 Jul 2022 17:01:15 +0100
Message-ID: <R11Wg2gY4kEFeq6ZSy2mXbGejo7XRfjG@localhost>
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


Michael Walle <michael@walle.cc> writes:

> Am 2022-07-03 13:10, schrieb Aidan MacDonald:
>> Some devices use a multi-bit register field to change the GPIO
>> input/output direction. Add the ->reg_field_xlate() callback to
>> support such devices in gpio-regmap.
>> ->reg_field_xlate() builds on ->reg_mask_xlate() by allowing the
>> driver to return a mask and values to describe a register field.
>> gpio-regmap will use the mask to isolate the field and compare or
>> update it using the values to implement GPIO level and direction
>> get and set ops.
>
> Thanks for working on this. Here are my thoughts on how to improve
> it:
>  - I'm wary on the value translation of the set and get, you
>    don't need that at the moment, correct? I'd concentrate on
>    the direction for now.
>  - I'd add a xlate_direction(), see below for an example

Yeah, I only need direction, but there's no advantage to creating a
specific mechanism. I'm not opposed to doing that but I don't see
how it can be done cleanly. Being more general is more consistent
for the API and implementation -- even if the extra flexibility
probably won't be needed, it doesn't hurt.

>  - because we can then handle the value too, we don't need the
>    invert handling in the {set,get}_direction. drop it there
>    and handle it in a simple_xlat. In gpio_regmap,
>    store "reg_dir_base" and "invert_direction", derived from
>    config->reg_dir_in_base and config->reg_dir_out_base.
>

I think this is more complicated and less consistent than handling
reg_dir_in/out_base separately.

> static int gpio_regmap_simple_xlat_direction(struct gpio_regmap *gpio
>                                              unsigend int base,
>                                              unsigned int offset,
>                                              unsigned int *dir_out,
>                                              unsigned int *dir_in)
> {
>     unsigned int line = offset % gpio->ngpio_per_reg;
>     unsigned int mask = BIT(line);
>
>     if (!gpio->invert_direction) {
>         *dir_out = mask;
>         *dir_in = 0;
>     } else {
>         *dir_out = 0;
>         *dir_in = mask;
>     }
>
>     return 0;
> }

This isn't really an independent function: what do *dir_out and *dir_in
mean on their own? You need use the matching mask from ->reg_mask_xlate
for those values to be of any use. And those two functions have to match
up because they need to agree on the same mask.

>
> And in the {set,get}_direction() you can then check both
> values and convert it from or to GPIO_LINE_DIRECTION_{OUT,IN}.

Agreed, checking both values and erroring out if the register has an
unexpected value is a good idea.

>
> Thoughts?
>
> -michael

