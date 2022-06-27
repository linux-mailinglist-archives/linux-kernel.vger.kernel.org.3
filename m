Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAD755DA33
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiF0H7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiF0H7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:59:46 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB0BEE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:59:45 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3178acf2a92so77314367b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLbnVfK5qQEeQYnfPgPZcOxuISU/J4AuEIo4n5DoLMs=;
        b=UZfIAOqSuYd4sEobLjGHaElE4Xp1N278qe1VP25+60RNjCFwyV6+9siBVa31jpTz6u
         3bqcwIGrfmsd/CgbWBvC1xjZyARRnRC11XTHEnGjPUgTt8uKLyHSF1OfzRXbXKiLzau+
         vXbJNsDzN2YkspD12MS0ZXCbqPenc+xEmGcgyRlIAS8S+RCtfxnMDrfK7i6nKNGR8c0e
         tvb6MFfa8h4RmTM5VWRI6oc6FLcGELBL6Tj7hgPLlGU1KOiziNyxSm4gzkli/cojKUZm
         ILo8Dz9fXbYpguE/yTBMA3EkL2k7QygqEA2SJEJNZuiC0SP8IQD/PAGpI5JiZ0GpXYeg
         lTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLbnVfK5qQEeQYnfPgPZcOxuISU/J4AuEIo4n5DoLMs=;
        b=3DRW55VQQGsqAuaT5q3J0SLDQ2Io5EQY0YFT8+LopuE+wgs5W0lmJU0FkKOpnJoOfn
         eC0rYZOjgJyyNX4ukl49UwZdMu0Zt0oqAtX1bme1g8J7BqagcSkp7s0/Dw1cuZyrnl8t
         qCD2AXqBW273pb0N+gRXK4MC0r5nXr2HT2SfKpfxpHnEAa5TETl7j5ajtJBG2IrgcL2Y
         CJjHSl7ati4qOG6JgayLy4W3gAI4a4ba+3VR6zwpzw7PYMlxudZGFjSgiJ3e+2RNX49h
         kHK2fnEYJtddrcGWzX/5ufTYio6nyMM81FGTztZY+q47snKnEU7rNQrJ3OrIQuqsFKEa
         PuDA==
X-Gm-Message-State: AJIora+SueOl7wUXY+sYUa8Ngde8jR9skm7dEuZXxoqcuFgUFeOrDtFr
        zlN/Wc+9t1/oVwzWwbB0TyTWEq9E+2pLxaA5oIfXxg==
X-Google-Smtp-Source: AGRyM1s8ANsng0ns1eq80nIWyEjCbn1cuhBkyhhVoT4XDy7EcNhK9EPjms3Z1YNrJJlZ8AIuZJaJHReEf3JvhDiAuh0=
X-Received: by 2002:a0d:eace:0:b0:317:87ac:b3a8 with SMTP id
 t197-20020a0deace000000b0031787acb3a8mr13750237ywe.126.1656316784367; Mon, 27
 Jun 2022 00:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220525115411.65455-1-linmq006@gmail.com>
In-Reply-To: <20220525115411.65455-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Jun 2022 09:59:33 +0200
Message-ID: <CACRpkdbS2Ksdo1kP-LZ5Dva-ZY_R9k5Nai2nAji+OGouYCAZHA@mail.gmail.com>
Subject: Re: [PATCH] drm/mcde: Fix refcount leak in mcde_dsi_bind
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, May 25, 2022 at 1:54 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> Every iteration of for_each_available_child_of_node() decrements
> the reference counter of the previous node. There is no decrement
> when break out from the loop and results in refcount leak.
> Add missing of_node_put() to fix this.
>
> Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Patch applied for next as nonurgent fix.

Yours,
Linus Walleij
