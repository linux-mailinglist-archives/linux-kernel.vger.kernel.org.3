Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6631D565E98
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 22:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiGDUnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 16:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiGDUnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 16:43:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC064B5D;
        Mon,  4 Jul 2022 13:43:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z41so12984871ede.1;
        Mon, 04 Jul 2022 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5SgkUXQH5l8cW8OkSfWR9KslLQ4DlsgBpNjjffiER3I=;
        b=G5JeOSwftEpRaQHoM3zNdpWmB53p11R6ye5SAmUaG0t64gGczOXb8JX0/cvnrbyPDK
         bW5yI4qVLwNBgbvDpRuIpZzGhgei9QRBXlQWbD/mzd/GRVvowPzcmzENa2QZXmWxFXNG
         hEe239MMoOHdpRoPuNq5A+DYWgNqOSQrTmJCTAPMgvzStxpm9XGyC6eFOIkCwQl4Dsik
         sEPquI/IdCvtqMkZ5mKOBretHBoGHHFeVyR50zE5xU/cNvw4pURPJZMpQAE8bRUFfV3H
         4PBzZ8uwgZSt78DxKTcGHwghm2GYm82DqTS2JjzyNBE5UJeLfjb1kZe44KnORfB/LMbF
         VL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SgkUXQH5l8cW8OkSfWR9KslLQ4DlsgBpNjjffiER3I=;
        b=E9www85Bcx48CRm/bhsuU4V++98aE80r55eTE5dbajXLJ6kHNhzKo8q/IO3nD7+kQ9
         c4K5dTBNWWmfLIE6d//7vbO9EnzAcYjSVdsqXj1ASnvvn+BTTrwvS7lH6Am6uIBCwF4/
         QIWVj5daFfSiIZwRbEtaFKjPzJbHFAwaTTq2r9OP2MFR/dbirk41dtdveRR5tX8EArBM
         0s39LDBsPTp7uauzBMYxI/xClYy5so45ZDY2ao16H8PCc8fG1rZN5rQKFIM36Q/QKd6f
         4W21SaK+vpdEt0rX98zwMW3gBxe6ozfcblbdWg9igl9wiDbDT6S0dvLDBefy2TjNm+eg
         T2Hw==
X-Gm-Message-State: AJIora+fMH2vIbZysLN+IIYI8EasRWKwDOvulxwiEMVznYhWPmifDlJr
        ZSjLkf7gzcxDpiZSyRkssaE=
X-Google-Smtp-Source: AGRyM1uJg4JOYffjRpUlVFqnzKqPG26lAaeyXLKWrPya/IwhyIWItUAKp+GOUw6YxqxgzPLtmlb1FQ==
X-Received: by 2002:a05:6402:40c3:b0:439:6b72:483e with SMTP id z3-20020a05640240c300b004396b72483emr28796701edb.154.1656967399526;
        Mon, 04 Jul 2022 13:43:19 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906494300b007262b9f7120sm14644879ejt.167.2022.07.04.13.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 13:43:19 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH] dt-bindings: display: sun4i: Fix D1 pipeline count
Date:   Mon, 04 Jul 2022 22:43:17 +0200
Message-ID: <110465686.nniJfEyVGO@kista>
In-Reply-To: <3674367.kQq0lBPeGt@jernej-laptop>
References: <20220702032921.22433-1-samuel@sholland.org> <3674367.kQq0lBPeGt@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 02. julij 2022 ob 21:06:07 CEST je Jernej =C5=A0krabec napisal(=
a):
> Dne sobota, 02. julij 2022 ob 05:29:21 CEST je Samuel Holland napisal(a):
> > When adding the bindings for the D1 display engine, I missed the
> > condition for the number of pipelines. D1 has two mixers, so it
> > will have two pipeline references.
> >=20
> > Fixes: ae5a5d26c15c ("dt-bindings: display: Add D1 display engine
> > compatibles") Signed-off-by: Samuel Holland <samuel@sholland.org>
>=20
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks!

Best regards,
Jernej


