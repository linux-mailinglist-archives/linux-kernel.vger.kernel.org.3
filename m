Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497DC4D90BC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiCOACg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbiCOACd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:02:33 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5DE2A726
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:01:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id u3so34122185ybh.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Hx8gzlcnA9WQe4/nRaiJeKdSgiXZDA8CSlyHo2MoEU=;
        b=jcHH0Naib9/jGqvrQ1aYDeQe3af8nnI2aVm55ZrM2tqkwPQZn77OZg8GBKl4niqFlQ
         AgaFjT7RvjJ1AtNBsiX1VKChX7x2LCEBUrwA4ucBUbp+gNR+ORBmJ7+O91o1H1DRkdzZ
         IE80u8haFRV+iUSWtskB4AzB1hgZlQvsiwDTgviW2XjmenxrO6BOvb0VMtE/mFkNiFM1
         duwvtqqfBzFKgdy2HKekrDBNDHC5cL2jHfIk6dwXOzAPWNKms4SNu4Cznl84wLUduZ5k
         AsDyPAX/JN0LPzP6m+1z1Qm/u8oNdK0JLnr87UllvIAwirMbxU8QFDQeNOaroPoUgKsZ
         nkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Hx8gzlcnA9WQe4/nRaiJeKdSgiXZDA8CSlyHo2MoEU=;
        b=vZZ7jcCYBuL/7BP3qdI8cN6zKUzWwvEtnyy5H+Tequ9LIQsfbkC1EnPubhbQCeFIFy
         SkZaVkWU684bZKlRUv8lCdNGPILHdqAObJq2DNijlYQew0Bj2oX+9b8lJtiCgZje3fv+
         DdDqsLAWjaD3BtLF2LpmYgliXHY51hMTVxpbOegbbiviVAXL5cZX/s9Xo1UikQ/t5q2z
         pO0DM5gdV/CVwrmC+kJD23P6jburA2RFOZKP8wIfK6tsDzAqb7v2dOf8jJhDZainhu/g
         3OM3JLiIQPGAetLLxN8ZLPELJAuXNfHUZKztgJYU2KZgXZ6I1okURXgpv5N6PdjCtErL
         0TKg==
X-Gm-Message-State: AOAM531t7jVIw8jgEyEObtF5H5nCmKFMeCAm0a54+YnFrFeStnG+PUBG
        R4vpC/A9F59UKSBB69aDF/QQ7eprovVphX9Dv4GXSjx55tw=
X-Google-Smtp-Source: ABdhPJw5LtCuJ+XoMQAG1Kz6dZV2htXDgYWN1IuTcwXuEzgQE4YVaS5pBngW1oMfQeA9WTvMA9GcUMZRxHPHeRyBljA=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr19792106ybr.295.1647302481820; Mon, 14
 Mar 2022 17:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220216032124.28067-1-guodong.liu@mediatek.com>
In-Reply-To: <20220216032124.28067-1-guodong.liu@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:01:10 +0100
Message-ID: <CACRpkdb5t_rKzRy6+NFy1zbrQstPXNMaUndvNvt6VOfiN2z2mA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] pinctrl: mediatek: Support pinctrl driver on mt8186
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
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

On Wed, Feb 16, 2022 at 4:21 AM Guodong Liu <guodong.liu@mediatek.com> wrote:

> changes since v4:
> - update mt8186 pull up RSEL type define value
> - update mt8186 pull up RSEL type si unit value(ohm)
> - update macro definition name
> - update mt8186 bias resistance selectio register description

Patches applied for v5.18!

If people have more comments they can be fixed with further patches.

Yours,
Linus Walleij
