Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA8854BBAF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352545AbiFNU3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiFNU3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:29:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B912A733;
        Tue, 14 Jun 2022 13:29:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d14so13211236eda.12;
        Tue, 14 Jun 2022 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRjb3jd1aQaLkq/z5sj77GhYqe2JvAPzVwwOMMfP38E=;
        b=K2N4aGCv4zNeMOd2yGAV7ZteJENWlMQgdsiYFaolNK+bkH7DEmbuYt/AslWT/HocXR
         mjkp9xGKv7oGtT+u2defmr8V9/RJSsYBuPdA+LTb9VMZ9oSVHcUSHgX/LZ4H1tHMPsA7
         0FSvpeIvmwqUYrrzc4IBXExEwWdEjH/RCWvjXmgWBiJX8fri2mtQ/fj1cFcBqs5WnBnz
         +HjCzkVYGrA+b6clPD9Uwi0qGmHWjoXgnbDNEvQOvovTeZVkTiA2e39bKmSeLatM1x6c
         ONzaCqcyXiLjYOdrqRQ0ruIfl1eGvxCbooXQaKR6/FSl0Cqh9hVx4S+9GFIeyImTXP3W
         gy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRjb3jd1aQaLkq/z5sj77GhYqe2JvAPzVwwOMMfP38E=;
        b=drgu4BlyOPy7fkEYFGC5WBF3ru8SrokHI/JR+jXArUmId1XnZzxf10dIAj+GJ52p/+
         fVK84Bh2n6fHDlP6DLibJVwVGvZyd5sTZ7OWy2tyj9apd+Hhmecz2ymm6DCKeLEbmz7F
         JQ8qeC/s9vlSRG2W4EVP4AUinovDqVWXTEMNfJm2AV7h9ToisnzBczxcPU7VANQQ2FJr
         9PYZMOBoAQsH26Mw/fNAyiZOw8U7mP4dSfVCH60oi+ZFkgQj1BL7ahtTBkZFEmWxRDeL
         +KpQZ7xqKCAv46eKagKAazdCRGbzfeVsolvJVFw07okwn56aZ3AI/+nEK7s5RWT0HOOh
         Ktyw==
X-Gm-Message-State: AOAM531z4MHAOPn6eXf+N0vLS/1wfemRXkc9AwAkwkNvh5ifvbqozy4I
        f6MKmExqc4SEBEGTDFQBPNI=
X-Google-Smtp-Source: ABdhPJwkmm9/r74/oo/mg4CEbzb7CSnzzm/yuMLEXu/YYGuNTmplbjVAPd146zBa1fc16wAv5FKfUw==
X-Received: by 2002:a05:6402:1914:b0:430:b941:2c44 with SMTP id e20-20020a056402191400b00430b9412c44mr8400109edz.77.1655238550743;
        Tue, 14 Jun 2022 13:29:10 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id oq13-20020a170906cc8d00b006feb047502bsm5394863ejb.151.2022.06.14.13.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:29:10 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: Re: [PATCH v2 05/48] arm64: dts: allwinner: align gpio-key node names with dtschema
Date:   Tue, 14 Jun 2022 22:29:09 +0200
Message-ID: <21497739.EfDdHjke4D@kista>
In-Reply-To: <5574044.DvuYhMxLoT@kista>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org> <20220609113911.380368-4-krzysztof.kozlowski@linaro.org> <5574044.DvuYhMxLoT@kista>
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

Dne ponedeljek, 13. junij 2022 ob 23:00:02 CEST je Jernej =C5=A0krabec napi=
sal(a):
> Dne =C4=8Detrtek, 09. junij 2022 ob 13:39:07 CEST je Krzysztof Kozlowski=
=20
> napisal(a):
> > The node names should be generic and DT schema expects certain pattern
> > (e.g. with key/button/switch).
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks!
=20
Best regards,
Jernej


