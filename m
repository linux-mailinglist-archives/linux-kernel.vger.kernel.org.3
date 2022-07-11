Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6935702EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiGKMnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiGKMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:43:01 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649131167
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:43:00 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31d7db3e6e5so16825007b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lmOFARrhQ1pMDU/VLUawj5EfoW09HSc+5IobtUlDT4g=;
        b=Ew9QEg0QOa2HYOZBAE1hP6sBA33MfhSiwJaBqqImtbBQXdcPk0XjRXd7/DNkvlmyfC
         POOiq9QYlRaSiD5vEpf1oQSr6j8U3mhgLnDcHO52OcjhDtreuRLqsfGK/47K95gAQ8q9
         a5iJmPZ0plASkSvFIkZZhHdOrq8BeqADQr0itwwRnPvk8k8h40HgJ4uL663zNE6HcgNO
         bTUSHXiAIpcCf3F6q47OUMXY08C2vt4+KXQG8DR+JdRze6MLjVdObOjSx4Pp5wDQdZuO
         xA7g0A06RSIjeRhffWYQjI3bv/HYCRDdPkB3sl3E5R7sk3nsiu8Klvlz3rOc51H7jXdJ
         6Tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lmOFARrhQ1pMDU/VLUawj5EfoW09HSc+5IobtUlDT4g=;
        b=WAjHwcwgcA34Io2PIo2Jzj+FKE3aLx4geI5Go6bBpjeJU75Fz5lkAi00JSwjmfkuvA
         Og7vZp+4JsNjarMX+Tarqu+mdSX/Hs1iwuFAByrc3eR8iIfOfTZWEikr7bFmf+BqZI3x
         1yLvSt8Cu0pNI0g7NYRV0NWJ+tmnICq7biHzsaVIGLvQFOkdA7iGXQtIdmrLEAdPAZO4
         fBWGK6XPO5PkgxE2eaExPq3vKJxFwgWYYsJR2LBV12vJe/DLbBDXQMDVFom6h4Lqir9l
         stQQaDOmaiHux+ZrZQ0VqJA2aCoah36sC115g28Djz/ElH1h6FaEzXf2p3TL3OMvVoR6
         iDQA==
X-Gm-Message-State: AJIora9HRdCaChWNTDDqKJWOSpeYzjIssmM3oTbbsU9t9ku4Es6TA88E
        UnTtliCggbJwADIk9fVeO+4qVC/mXfZDij++jKfCBA==
X-Google-Smtp-Source: AGRyM1vkwySEaYRGhzMKZoWJjboSnV4o26yTCDrSpsOLaiTgvmVl1G7UxvGu9mq66bSMaSRJ7qBtK5XjL70QEhlcGlo=
X-Received: by 2002:a81:71c6:0:b0:318:38d5:37f3 with SMTP id
 m189-20020a8171c6000000b0031838d537f3mr19034591ywc.268.1657543379619; Mon, 11
 Jul 2022 05:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220710154922.2610876-1-williamsukatube@163.com>
In-Reply-To: <20220710154922.2610876-1-williamsukatube@163.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 14:42:48 +0200
Message-ID: <CACRpkda+GhRyq5fKhBuZ209r5veM=7xyGqGqEVyQr8xQZNOa2A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ralink: Check for null return of devm_kcalloc
To:     williamsukatube@163.com
Cc:     arinc.unal@arinc9.com, sergio.paracuellos@gmail.com,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 5:49 PM <williamsukatube@163.com> wrote:

> From: William Dean <williamsukatube@gmail.com>
>
> Because of the possible failure of the allocation, data->domains might
> be NULL pointer and will cause the dereference of the NULL pointer
> later.
> Therefore, it might be better to check it and directly return -ENOMEM
> without releasing data manually if fails, because the comment of the
> devm_kmalloc() says "Memory allocated with this function is
> automatically freed on driver detach.".
>
> Fixes: a86854d0c599b ("treewide: devm_kzalloc() -> devm_kcalloc()")
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: William Dean <williamsukatube@gmail.com>

Patch applied for fixes!

Yours,
Linus Walleij
