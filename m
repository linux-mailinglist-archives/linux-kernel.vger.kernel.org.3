Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D95A55AD94
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 01:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiFYX3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 19:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiFYX3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 19:29:52 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3817B12D29
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:29:51 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3178acf2a92so55129357b3.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UYyw8IG/FSt87W5iD6mQ31cHerUlAdMQ2QniI7HaAw=;
        b=bGT/TUEUIpH/AtdebSxmJ90TAfkQSd5kFWTqQIidw52LzjG7TQSh0LmTr2M8mryZpa
         dGDR7p7mKGOLP+jUBtsAobfG+gjaGBMYy6u4KifpmeUq/mAnnidrag9RiSfpKf3IHV0Q
         meU7rUE8Nmg6DVaHqy9xL6OSlmRZP6KypCnme5MDO4NbN+dnT1aU86HLbYxINAPSxBoc
         6OOQRXBG5VuWnmbGnijns/2ZtczdgXYguIFInZMXBPJi5NGI9Wr+AbDPobhgkeusfb97
         ruYf6ClPDIKU0V+FiCw4lc8kHR7WuVl/cJSG74pS0RHRpcWMXsHAk7q4lpOsMq4zFvcI
         mTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UYyw8IG/FSt87W5iD6mQ31cHerUlAdMQ2QniI7HaAw=;
        b=3WjZmC3s6xrHDRK63EtBaO7Ie++CPyNnjHnMFfylWlUOgCDV/k16wkwLNtDcYIFsQo
         3FQeHlEU6XC7Z0ySM3pQf6KbZw9AIOihOdwr/qTFjbIlWwOorMS/6d3nkoy8ndBwQOFA
         DCZf+iol5++eqEKXDbayrw6HWsDmHduX1CubxXD/IPJ118Dd6SeQdUYk3Oofpf2E/GIe
         qkxMnUm25EGeut6kzRX2jM/BB0Z7CTd65bFFYhLsyRu7elGed2fKPECW7HMUkUb0Hx4Q
         SnSUYBot5XA2dlp9RbAdTp+b7KFpWY7my76iaAdP7xI/LeOtVT7O5O2so0fKy5XeNWRY
         LZKA==
X-Gm-Message-State: AJIora/fW+kp+auB1Gw4w6NTeIONw+FLlkUatxJjiBxXsAwDMJN0htYK
        T9siDJroOaSk9wxJVHp6F7ZNCnhUcERTPMHCeTZHeg==
X-Google-Smtp-Source: AGRyM1vpTcWtObITT3ftjiLLwTgIpKRXuKXwH1aFHV+d73Jv0wSLTLduzlvcKGSgo4TsXq453J4pwkW3b/dg+4gpDKc=
X-Received: by 2002:a81:71c6:0:b0:318:38d5:37f3 with SMTP id
 m189-20020a8171c6000000b0031838d537f3mr7041733ywc.268.1656199790486; Sat, 25
 Jun 2022 16:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220616060915.48325-1-samuel@sholland.org> <20220616060915.48325-4-samuel@sholland.org>
In-Reply-To: <20220616060915.48325-4-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Jun 2022 01:29:39 +0200
Message-ID: <CACRpkdb8Sh+_HMxd11FTS2S0Yjqn-RQhn0w=689Y-+4-6YP_BA@mail.gmail.com>
Subject: Re: [PATCH 3/4] pinctrl: axp209: Support the AXP221/AXP223/AXP809 variant
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 8:09 AM Samuel Holland <samuel@sholland.org> wrote:

> These PMICs each have 2 GPIOs with the same register layout as AXP813,
> but without an ADC function. They all fall back to the AXP221 compatible
> string, so only that one needs to be listed in the driver.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
