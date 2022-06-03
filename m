Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6254C53C819
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbiFCKHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbiFCKHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:07:16 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308641BEB7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:07:14 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r82so12836353ybc.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnywvXbY89DFzuaqv8CLE/E3Ene3vKzzXSeiQwG/F7A=;
        b=fwmuc6OvzgxZJi77pwbfhyw3Vo96AGHuONEv3g+nry0enYQxf9FqupXfRNR8+vsnwN
         tmNC0sbVK8sDFQIOXRytXhKZWIYp0DxQIOOPtlcA32HS5coXu0C8iwN8f2tgx0jffZNK
         qRtpk8TvG3FRD+QQ4XTbGZi8GilXHFdpP7La1jkvL0aolleefv824Hkqm4RLn3kQpw6+
         DkGwXrGeMvYSn+sgon2Ws78CSMZy9qdNsIKnUIkRcBV/AIQjqFzOIK5DSsFEMD/FH/SU
         neiCyNnfkufnK2bFQqbwzwulxKERP8050zKYblHzkuBW8P5804lYf5u4duF5oYHj3feY
         XcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnywvXbY89DFzuaqv8CLE/E3Ene3vKzzXSeiQwG/F7A=;
        b=lzfGk+vUvh0Upaq0g/2/hspKjo4f2YTny1jPJ4deQNvn+Br/2qSGeUhVjrj2Wuon4V
         KLzlPwz+0u3JAV+WUClDBmC7Bo+pEtPMFivW1U1V31vBU5RQwP2pa0vKGcv8YUr35LzX
         /2cYZlpc0gWoxePnwB8xHwMbGOsJXN8oFh76kd3aBFE/+doF2fiSDNpfyD3gsEC+CB7K
         eITqn37XFNiFCd48F1k3oTBhNBMacdtJsJ8EU4ljyPmVKKTWwYZEquZHddKoTkv5/fE/
         K5ZdK01WbZ86Ev3HYVKlK117tB6ANoaX/D8xAvpEf196juQBpiFg0DlB+H0eyJkXCM/D
         /Lxw==
X-Gm-Message-State: AOAM533zigFCzOOkw9+Zzpa8V78NRLxnxz02ornBvd0nMmviWfyF4Kql
        88kaoXEjw8qlg15ceHJ1suCnv/ibKKL7xmzLadmNow==
X-Google-Smtp-Source: ABdhPJxZz8M5WLm/vcvAJxH2xhFx7nZgpViQEPdLYydzICY7mYViKsZr6cs9+Bd6qtlj13nSzO8oOlZeNybcahmTGzA=
X-Received: by 2002:a25:dc0b:0:b0:65d:e5d:a87a with SMTP id
 y11-20020a25dc0b000000b0065d0e5da87amr9936264ybe.295.1654250833397; Fri, 03
 Jun 2022 03:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220523141555.57346-1-linmq006@gmail.com>
In-Reply-To: <20220523141555.57346-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Jun 2022 12:07:02 +0200
Message-ID: <CACRpkdY6WO4Ffm9B_DbmphwqPfYHe_TgcHYOOVxBZ+YHtWsOJQ@mail.gmail.com>
Subject: Re: [PATCH] soc: integrator: Fix refcount leak in integrator_soc_init
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, May 23, 2022 at 4:16 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: f956a785a282 ("soc: move SoC driver for the ARM Integrator")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Patch applied!

Yours,
Linus Walleij
