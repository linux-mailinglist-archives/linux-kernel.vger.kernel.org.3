Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49A14D912C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbiCOAXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiCOAXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:23:14 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F1C3F316
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:22:03 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2dbd8777564so184710377b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqLppnGP4MbsD+gVviOPlH5VnfiPJBlj6/pZOIVk87s=;
        b=dMTpOfPNcuKpTGl/JROG/JfBp6BpRXuCPI7gXdwwNZxgiZQqpugLMPeFDPkXwYOwwq
         zDFEZFGTMp/wQ6s/n41FvqOf+fP7hCh+PVZEB2t7yvJsx1Py+mmYIE3wkIB97ru3nxnX
         8iYD+r3adI3DiwmFOBL2Krua262HaeWj9bFF2ITuaoCFESlH8e+0u021wuDwaqlzgUSK
         jvHFShoXHwMlO5Ztbj0woLMnJxFlzb/0lNljSP375mC4gS/Vh18qtVTL6Z1NbHDOIMTl
         rVEeLLIPlcXdPbpCF95OoYCr0MzRoZ2hGVrKMN1+s+RaFT6lYYoPrqTrDtuaxMzCeV8H
         6Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqLppnGP4MbsD+gVviOPlH5VnfiPJBlj6/pZOIVk87s=;
        b=PQ21dxFJfdSA5WVlL5H5AKW9NVazTocWoiBNQu/TdeNvq7krxjKksk3E4sUQjAVsCE
         ms1RTEreqYQNPPavSy8sZyA25X+MBVlHrK7u8cmfMuL/1lV0znN14Toz5rTJBhZri6PU
         8vHnn/y9HDbP/9Tu3wvkZIrGdEoG++FyXhKpXbV4sYzfvZX7Fxin3RIQStPT/zYue9z7
         xJJ0Pg3nFa0Zzs8jwRbJU0hMePW3kyELDGUF7ZuGCpytuYMq9a+gf47qxl978ZICFKX0
         uixZ3+Gc61NNnwPrx67Ximug1LhHEgC0/d3Ynb6wfNDwA/IsQb/CsNalX8YTBNVYiBck
         fvKg==
X-Gm-Message-State: AOAM532MgYh6c0dLD6ZDp5gk0rtiYfW2VhZORhSEmN3RqGOHwO8BRK/O
        H2fw5EaVQsRiE/x4A3zrNYP1fnmivruGV56vvTD1uUfBpXk=
X-Google-Smtp-Source: ABdhPJxPeLs/sQQPILHw4rprmLVR2kPw4SQcmTT2sG/U6jXD1r8wVmQwtPptjgzVGLG2oUXGgIKZdPWG432SjaJd4sw=
X-Received: by 2002:a81:89c2:0:b0:2e5:84b7:83e with SMTP id
 z185-20020a8189c2000000b002e584b7083emr1458669ywf.448.1647303723144; Mon, 14
 Mar 2022 17:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220308071155.21114-1-linmq006@gmail.com>
In-Reply-To: <20220308071155.21114-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:21:52 +0100
Message-ID: <CACRpkdbu_rqQf101WC+bf8io_Kr7eDvRwt3h9yq-kAH-9Az8Ng@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Fix missing of_node_put() in mtk_pctrl_init
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 8, 2022 at 8:12 AM Miaoqian Lin <linmq006@gmail.com> wrote:

> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
>
> Fixes: a6df410d420a ("pinctrl: mediatek: Add Pinctrl/GPIO driver for mt8135.")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Patch applied.

Yours,
Linus Walleij
