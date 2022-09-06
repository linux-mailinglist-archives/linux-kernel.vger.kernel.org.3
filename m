Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F95AF450
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIFTR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIFTR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:17:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877EDA3445
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:17:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z21so6400534edi.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mMXTLXRqhOR549yPMPkM4OHzglrtC5ZpCYNOZXQQAik=;
        b=B3E8C/TBZqnpTcrMrYBP1uypjvJt6LTn5K0aeSFGTGnDM75/SgcLjnH2s1XuyndOr2
         NeXdk4gLnAtC1jnnSpSJcWb1nGw9BZXaiyxFj4nI7r60vra2MaDh1iVW+Vvc5roP7xyo
         +k854UjiXhaYoHukWSGuB1mcHCt99tnhERIvCrrIJubWvsrsQuJuyzqwJhPDs26ygpHa
         HikcX773yxgREPaejt0TfXyqKwSC72yBtS6IEcrjKfhKp/kmBybEA9Smaw16vi39PDAd
         /OBVPT0jcSIp2ASW0+yIy/FiHqpMYqsiePds7WT4ATwMGukbyxhYAyFGT0+e7U5H4Qit
         rlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mMXTLXRqhOR549yPMPkM4OHzglrtC5ZpCYNOZXQQAik=;
        b=1Cl0q0tuZ6gqL6XkZoiY/I4DotFFveAw+GSDAYBW1iPIL5k/qOcQ4h5somdHZBqJml
         xOs0H1oFejf6G5BOvBduVtjfaFupUKQi447HpG6EB/u4tZegztVN4EXrhHk+O8AZnFGF
         PlWXP5pJwuEUncfukcwprlMasOlaO9cMzrpD7IMEEMNIwgC9AByXN9nTYVEjWpYNu6qw
         G1CPrKYPLOGAPsHI8M4elZ3pYpyFoQ3d/Q9fTO8gWbZqbaDbN4ewk2leTgIo1EN5s0zL
         mqwUtIWZu9H4FwRKhI/Fvsh4u6HI7SQmKGB/F3ZeXwgiOEXwNSLWwSaXK0z36sl91XuF
         Q+Hg==
X-Gm-Message-State: ACgBeo1Xa/gCjodCpNS5lSB9mPCXNFPrdY/Piob9oFLuN3Ii1jBbXVbO
        nJ1xWiKb8AlFwxfmE5TlaaHnDwaCLuVn8dF/Bc6GCw==
X-Google-Smtp-Source: AA6agR6o8OVhPVYM0ef4LJ7gVnZEfp7DJX8/8ks9/6/dcXNmB91DkT5okCGy8Jsh2ons04HOpj/baeQ+tZHL0Qzh1PY=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr85904edb.133.1662491875121; Tue, 06
 Sep 2022 12:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <YxeaITtlJexygQo9@google.com>
In-Reply-To: <YxeaITtlJexygQo9@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Sep 2022 21:17:43 +0200
Message-ID: <CACRpkdb_wksaRhAesjmGjvzm-thB2UdXX04Pd+-qRe2KKZhK4A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: simple-card-utils: switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 6, 2022 at 9:06 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Excellent patch, I love what you're doing here!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
