Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF725887ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiHCH32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiHCH30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:29:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4261AF3C;
        Wed,  3 Aug 2022 00:29:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l22so20487427wrz.7;
        Wed, 03 Aug 2022 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DnwCv3ne7t4VsczDACOd/QZeuOU46Y+vUbACe7h+Vcc=;
        b=Z9sHp1rQ6UEA5jgNJMBEfObRj9UkraU1s6VGfAtODedoODzmyqMJs74Ou1T5zAFdl/
         qlvnNMM43doBpGk4tYPtiFceevUd2Kooh4xnSc80aLayidq54YvRiZkrvbN/5Ivzb34D
         Ju1khvS/beoLsMQjxcLMPukRYK3sjOwroQoqzxErS0ZlNu0A54/+3Kk4CX+hXF19U/Zw
         vvc36mm9E3bZJFIW8e+eJ4n4Z00djrTvjghQi6wAOE6LlwaKZhIV3CBlh5dankXnRcPK
         rQ989EL6fWmQT7Z+p//oyV8FipQr8khyVR8x9+oLPYGZaf3AqjSSlm9GQvdcVW8kmi+m
         4KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnwCv3ne7t4VsczDACOd/QZeuOU46Y+vUbACe7h+Vcc=;
        b=Z8vCkjL3Ya7tVZET/3YFuqLO06OJ/KzIBFMeTCLbMwwQcawfzH0HVFisKZ0jz/IUaw
         DUu3JOY0coWh4SmdjtOBApn2+fTPD7ER/vUjZEIIy5TLJud+DyyFbtFy7pklRjpXxU4I
         mwkvJGs/mLqTZ31Htqvo3QlRP7sHvKoAqLo8wVkIGuKj5nJ2RgYsSrWSzcnUR7gonk0P
         hm5Mbc00vJHIE2P6iJcqwrGEh4knvshV9XyeRVB3F2BToc9wU3oixU2yKMXQTqx+ejqE
         TOhIgd9NgGkh8qvfNKibpyorVkoR7YQWUMVQhgokl5jt19B4DoKxvv/8GzbNvGiCVmyU
         XvSw==
X-Gm-Message-State: ACgBeo3HVC9kFmqx2iOPblM61EGIHlXOVubuUu8QoeZowcTtQRhyrXj0
        qTVTA3XDknFgYp27yjHuhOo=
X-Google-Smtp-Source: AA6agR4B4mTSnCya1ay3mFK+wvoTuG8FqPaeL+iK2sTy/kBDZ8JKZSekqB8xHebkI7cpKW3jtLjAGg==
X-Received: by 2002:a05:6000:887:b0:21e:24a0:f302 with SMTP id ca7-20020a056000088700b0021e24a0f302mr14565311wrb.466.1659511762271;
        Wed, 03 Aug 2022 00:29:22 -0700 (PDT)
Received: from ainazi.localnet (p200300d09706d9000384b2cb471c28f8.dip0.t-ipconnect.de. [2003:d0:9706:d900:384:b2cb:471c:28f8])
        by smtp.gmail.com with ESMTPSA id a5-20020adffb85000000b0021e5cc26dd0sm17176199wrr.62.2022.08.03.00.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 00:29:21 -0700 (PDT)
From:   Shinjo Park <peremen@gmail.com>
To:     Rudraksha Gupta <guptarud@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ARM: dts: qcom: msm8960: add the device node of USB1
Date:   Wed, 03 Aug 2022 09:29:20 +0200
Message-ID: <2654048.mvXUDI8C0e@ainazi>
In-Reply-To: <cbccc7c3-a45e-43d0-50d9-55776579afa1@gmail.com>
References: <76ed8999-c211-f8ea-c70c-21fddd75a896@linaro.org> <20220730081412.14297-1-peremen@gmail.com> <cbccc7c3-a45e-43d0-50d9-55776579afa1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022=EB=85=84 8=EC=9B=94 2=EC=9D=BC =ED=99=94=EC=9A=94=EC=9D=BC =EC=98=
=A4=EC=A0=84 7=EC=8B=9C 21=EB=B6=84 54=EC=B4=88 CEST Rudraksha Gupta wrote:
>  > #include <dt-bindings/clock/qcom,lcc-msm8960.h>
>=20
> Does not apply cleanly to mainline. Please include the above

Will be fixed in the next revision of this patch.


