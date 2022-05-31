Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7204553915A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344534AbiEaNGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiEaNGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27528FF5;
        Tue, 31 May 2022 06:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6B71611ED;
        Tue, 31 May 2022 13:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23089C36AE3;
        Tue, 31 May 2022 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654002401;
        bh=fQyBKa6i2Oi/d6zUCqifTnGlCz1MKWwjMKnJhC5OgKU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JXv5yfghZk1tbSPMN2pXN+/znRFvMr95s0HVF2hqCp6bqeUeugg1kxs8H4LQtBht9
         dJZaT5lNuD8kP3vI6JI24z3USrGb+1JRAzQXpcm57FqxndsTpzTa/zTBS+zRc462Lz
         mKY54sWvSNREBI9oTsSsSembR9Uoi0cV1NKwCv2+Jg8yHYXtGro5xWFgR6bkS6vwhI
         kquO7eJ1TXunLXG/cjdVsvSkVXWX+LYroWCQOASBj3HUEZdrHVLtDVk3ShwONZ4bxS
         YeIzDMC9KW9blAgNNg+2bLKycmYnGos7yYCbyEuXJXtkMw2pHXrqxmDX/0Z8cNVref
         H2SixmTqhF12Q==
Received: by mail-vs1-f45.google.com with SMTP id 67so13519229vsh.2;
        Tue, 31 May 2022 06:06:41 -0700 (PDT)
X-Gm-Message-State: AOAM532nW8YGDJoj7spFV5wIvysh08O/nEj1rrVpoPOyVuiiZWxyceNI
        A0p35oKGoKoWUTIoGRmod4dQDRlDbGwMJt41lg==
X-Google-Smtp-Source: ABdhPJzIzgHJ8nyxJIrzYvXYC2oWioOfU589jWLaAk9OWmEVsMAUlK4GGYDgQwFpI0Ejh52SgdHXc2ULtIxtWnWSJlk=
X-Received: by 2002:a05:6102:510b:b0:337:a739:ce7c with SMTP id
 bm11-20020a056102510b00b00337a739ce7cmr18125393vsb.53.1654002400089; Tue, 31
 May 2022 06:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220531053358.19003-1-qun-wei.lin@mediatek.com>
In-Reply-To: <20220531053358.19003-1-qun-wei.lin@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 31 May 2022 08:06:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJnir+qA1Cgm5ATzsAH-pMqQSychLG=JQyUQg02dYb8TQ@mail.gmail.com>
Message-ID: <CAL_JsqJnir+qA1Cgm5ATzsAH-pMqQSychLG=JQyUQg02dYb8TQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: dtc: fix a false alarm for node_name_chars_strict
To:     Qun-Wei Lin <qun-wei.lin@mediatek.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, casper.li@mediatek.com,
        chinwen.chang@mediatek.com, kuan-ying.lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 12:34 AM Qun-Wei Lin <qun-wei.lin@mediatek.com> wrote:
>
> The function check_node_name_chars_strict issues a false alarm when
> compiling an overlay dts.
>
> /fragment@0/__overlay__: Character '_' not recommended in node name
>
> This workaround will fix it by skip checking for node named __overlay__.
>
> Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
> ---
>  scripts/dtc/checks.c | 5 +++++

We don't take patches for dtc. You must send them to upstream dtc and
then it will be sync'ed to the kernel tree.

>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> index 781ba1129a8e..6ef4f2cd67b9 100644
> --- a/scripts/dtc/checks.c
> +++ b/scripts/dtc/checks.c
> @@ -325,6 +325,11 @@ static void check_node_name_chars_strict(struct check *c, struct dt_info *dti,
>  {
>         int n = strspn(node->name, c->data);
>
> +       if (streq(node->name, "__overlay__")) {
> +               /* HACK: Overlay fragments are a special case */

Not a hack IMO.

However, this should be checking for any node name starting with '__'.

Also, doesn't 'fragment@0' cause a warning about missing 'reg'?
