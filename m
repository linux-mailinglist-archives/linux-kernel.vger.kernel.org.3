Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5B54CAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346815AbiFOOEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355971AbiFOOEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:04:37 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB6323BCB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:04:36 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-30ec2aa3b6cso61814727b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKNmlelPMUUwEhyo/oW2GfDg9fGO0GWkAQdbd+usNG0=;
        b=Hhk5ooKmiw/m4i7aPxBot9kGRRD4QfdArggzSzM1SVYadr1ayhHvdo0Lf2/Twv4K3v
         jYq2sbCVcfkaursJKcvjxYIOAOWgCibUIArbV5dqqKvm2HU1zksAyPgEsqoxpEr1dFxF
         TJS7ncF98C5hZIDPDc5Q0ao/FWu2b51fJxaOZS+7j3wdLgyARfPd21tN1FAjd37XByP1
         tMxMNMaoRie1uKHl3QFXUlm4wqmLoRGmmCjvDpXCxP83wB9cgXLIhfqiQppMC76e8JNL
         xui5hyqZ4b8F2FsfjmoaZNDc3fuo8nDZrviLYt+kiNM7UaALnCXM5F053RXiWxk71KoG
         hpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKNmlelPMUUwEhyo/oW2GfDg9fGO0GWkAQdbd+usNG0=;
        b=ePI5wj5v3OjtmhY2KscQU5jaGc3YyAWPTG0kNN7mMP62XZgl+EnTYVG5zsTfM3fAV7
         fqjkzRMyU7SfEsZX16eHVZCHOG5BwM/uQSE1PB3CBC69y89ILDLHtK0L5FgbmzRfBSnu
         3LB/ei5H7BUR+GE6sOTlJj6l+2qjaScSltqzugbYS2TfPx4BiW2u0b8jNqMlcLgPBm/f
         ZHGid4cx6bC62ptodEf5hEgU3d+oUL/Ii4k4RYOAEUmBlE1h8uWLNqR+m93V1sOpE1Ei
         HrD3OQydkmk88G2WZPbpZq0gKgYmlAfKPste/z8NhVJ2tA4vkgMTCXXVNaR6I4sq3sP1
         SnzA==
X-Gm-Message-State: AJIora9Nl2lNdO+Q03rhg2SCFXTL/TDyIetpVVhultAndv9k+2Q4Mjuy
        Cpo9HVPW6ybPRnpW7nhUnwjRJq9Tpkkoy8UcjEWeSQ==
X-Google-Smtp-Source: AGRyM1tcOWzYDj+vzN+BPLmjJWB+4BtKrK1yhKwTxn7O9wjxBMPpl/2kQCMvVMBdo4eZwYOsbLHoIiNtVTcY6D3IZpY=
X-Received: by 2002:a81:830f:0:b0:313:3918:5cf with SMTP id
 t15-20020a81830f000000b00313391805cfmr11990562ywf.126.1655301875869; Wed, 15
 Jun 2022 07:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220607111602.57355-1-linmq006@gmail.com>
In-Reply-To: <20220607111602.57355-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jun 2022 16:04:24 +0200
Message-ID: <CACRpkdYBHniSSb1Och=P_YNcuSvRxXYJM0KtCuLSeETxMtnAdQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: Fix refcount leak in nmk_pinctrl_dt_subnode_to_map
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Jun 7, 2022 at 1:16 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak."
>
> Fixes: c2f6d059abfc ("pinctrl: nomadik: refactor DT parser to take two paths")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Patch applied!

Yours,
Linus Walleij
