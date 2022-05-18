Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6CD52BC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbiERNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbiERNja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:39:30 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09DF1A90E8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:39:27 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id t26so3730936ybt.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhJrvJLn+TzZ+Q8hiTJgSRsblqOxOpTfmvIr/hnkxcU=;
        b=Fr1wEjHLVhbeaVjSnAq2+SspRoi/e2nHtCbxH9sSXmM6/3QABuwEX0A/Bsv0tflvx7
         FeGLTj9FD2gkRu3GbCWe+exRmItXfmUcb0sSDSRZD4+ElF7Rf4cjjxqwhIJimVNkCdOk
         G7KCBSkOvXlptSJIcRhHWmc11F2GcHXFR8+qTkIwKJt/USalM5VXcDoAQc4okcJGsMmX
         F5Pa+wE7uyY0nr89lorDyjvaYa071njtprkgH39qA936CcpcVGNJZnYzLFsDlr8OMsAs
         J7/lUHeHwu2zSymb7v1cPfmgnmY1K97t0ftjofja2ovNQL1w63T81Iy1+EXOY2o6HKTK
         rwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhJrvJLn+TzZ+Q8hiTJgSRsblqOxOpTfmvIr/hnkxcU=;
        b=younRyEQ5RrA/M0Uaoa1FTDSsJDPummhtfuvXAqdgN0SqDkKzhr+Wet7SqKSChyixj
         Bo1F1vJJmkLM3Q/qC02cEhrrmxX9holuUqK85sWZYukXd6NvrxmoHx8Bhq+5SkC580VE
         hA2t34MUV/hepwSJCzbviZYHt0AYke8/+7+G4aAhTRcv5+yg4mbHRteW9Pr/7yia5082
         OWsijVqaT6HIYKATatRmHgaGaUWwDu1lCnK1WkT6TihUZO/ht8fl0zp/OU1yOV1wQheX
         uNMA49A4LUh6JmgeCNJcIciIpg3UxRRH+//8QK4jtGzBNJRXmnTKYM4anVu90ttFPEyp
         dvyA==
X-Gm-Message-State: AOAM531iFgZ3dOXB17rox8DZP2fJelsAgo7BA6IpzVn9vmodNUxda6Un
        8iwvJOU22fasI1Ir421I9kqU2PeX4cT1emz4iUf8hA==
X-Google-Smtp-Source: ABdhPJw0ggPGBcwzy17FZdJk/9wHr1iVA0SjK4e5DeP3olkHLrIVoDC/fZ1dAMLEu7Vv5xwFM8k/Dan+CV+eeyELPlE=
X-Received: by 2002:a05:6902:526:b0:64d:b6ab:f91d with SMTP id
 y6-20020a056902052600b0064db6abf91dmr14325832ybs.295.1652881167023; Wed, 18
 May 2022 06:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220518062537.17933-1-hbh25y@gmail.com>
In-Reply-To: <20220518062537.17933-1-hbh25y@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 May 2022 15:39:14 +0200
Message-ID: <CACRpkdY4Ynox3qYu_8=ToH_nkXFpC3xOOuN7D4EM5vszDgKMdw@mail.gmail.com>
Subject: Re: [PATCH] clk: ux500: fix a possible off-by-one in u8500_prcc_reset_base()
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     ulf.hansson@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Wed, May 18, 2022 at 8:25 AM Hangyu Hua <hbh25y@gmail.com> wrote:

> Off-by-one will happen when index == ARRAY_SIZE(ur->base).
>
> Fixes: b14cbdfd467d ("clk: ux500: Add driver for the reset portions of PRCC")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
