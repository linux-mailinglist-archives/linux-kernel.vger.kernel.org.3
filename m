Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80085AF793
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIFWBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiIFWA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:00:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ADD94ECD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 15:00:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id nc14so26275786ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=a7BlxrU2ulUCUinwJQC17AnM6l9GrZy8aOhqpXfsYtY=;
        b=ZzpE+VKInyTLCtVVYQQH1y09V3uy2pFXV9Xe2a6fqHy3bUloQGyx+qFz3In6xQuUbe
         016tuW8KG+JkhYtDfL4jTD148uCnzOpECWn5+nxM1ezSrP+IWGpmXuJ4N6X+RLegGVF4
         mGewzGi6lkoLIhi0ejPgWYWIaBkT7UHJaycoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=a7BlxrU2ulUCUinwJQC17AnM6l9GrZy8aOhqpXfsYtY=;
        b=KgNR9JNS8QuNfixf39sP/0xCcxKH3TfI1BkB9owq4k6fDaQDEmfkOWQm8/guNl4QKS
         rxDImRwoUZVWzw+XDJElfTScCdXW7wy1p71CiQKEvATfZ4K8j3flGV4mWV/EoqV+Yy85
         28Mh/M7H5rZjswRkjbWmk7ibwE53DbWDqbEdCzQuMskOom/2J0wWXAL9hZ6PnarPBB7m
         QBpFbU9CcGy8JhvHA4eeIGKFyct67Zm3HMKMxZRUYc9ekHfgTmlgW2vklKIbE4n9Js0F
         K5b8KiKe58WRglfdwiP+nroJ+8Sw/EpiWH0TQkUF6YeTgqFGiE7TGvk2DaJP7XCM2NN4
         yEQQ==
X-Gm-Message-State: ACgBeo18E1ZxnDqA3d8PvvA1bVqQ2hHhVgAit1ndZ2cyTf+l6vw2Ex8X
        WLal9AVeLcoX/IZbkOose/UIetSr5sqxe3PY
X-Google-Smtp-Source: AA6agR5A4y6t4EhI/phz1iBCSIbIMOt68zR+gHgMMJ+YitNb88HbsT60cHEl+9KZvV1Gnq/xewIJPA==
X-Received: by 2002:a17:906:8a4e:b0:730:9fcd:d988 with SMTP id gx14-20020a1709068a4e00b007309fcdd988mr360476ejc.636.1662501657039;
        Tue, 06 Sep 2022 15:00:57 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id w21-20020aa7dcd5000000b0044f0a2b9363sm268190edu.41.2022.09.06.15.00.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 15:00:56 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id e20so17410251wri.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 15:00:54 -0700 (PDT)
X-Received: by 2002:a5d:4d0c:0:b0:228:cd9f:5a4c with SMTP id
 z12-20020a5d4d0c000000b00228cd9f5a4cmr286781wrt.138.1662501653855; Tue, 06
 Sep 2022 15:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220830182923.3720287-1-dianders@chromium.org>
In-Reply-To: <20220830182923.3720287-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Sep 2022 15:00:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VD5v8q9shO=uugQiqzotxaGEP3jDfurU+MjuEztFvMqg@mail.gmail.com>
Message-ID: <CAD=FV=VD5v8q9shO=uugQiqzotxaGEP3jDfurU+MjuEztFvMqg@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] arm64: dts: qcom: Add new board revision and LTE
 SKUs for sc7280-villager family
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>,
        Jimmy Chen <jinghung.chen3@hotmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 30, 2022 at 11:29 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> These patches add a new board revision for device Villager, and add
> new LTE sku for both board revisions.
>
> yaml issue has been clarified in [1] and [2], and 'status' has been
> reordeded last since v4.
>
> v9 is me squashing changes from my patches [3] [4] in. For patches I
> touched I removed my Reviewed-by. I added my Signed-off-by to all
> patches.
>
> [1] https://lore.kernel.org/all/CAD=FV=WtKRFQr5jSQvsr08x9dgHrvenUWWtX_SKuCLuSvSH7WQ@mail.gmail.com/
> [2] https://lore.kernel.org/all/d3d4d90b-85b5-5ad9-78e6-5a074c21af4f@linaro.org/
> [3] https://lore.kernel.org/r/20220829084732.1.I9ef7f8b909a7afbef9ff2251a98c67033f37b516@changeid
> [4] https://lore.kernel.org/r/20220829084732.2.I22e256d1ebac577a91fac44d1d12919be7111cd4@changeid/
>
> Changes in v9:
> - Squash https://lore.kernel.org/r/20220829084732.1.I9ef7f8b909a7afbef9ff2251a98c67033f37b516@changeid
> - Squash https://lore.kernel.org/r/20220829084732.2.I22e256d1ebac577a91fac44d1d12919be7111cd4@changeid/
>
> Changes in v7:
> - Revise typo 'ARCG' to 'ARCH' in Makefile
>
> Changes in v6:
> - Remove v5 accidentally added sc7280-herobrine-herobrine-r1-lte.dts
>
> Changes in v5:
> - Revise rev0+ to rev0
> - Add -r1 line to the Makefile
> - Reorder '.dtb' in Makefile
> - Put the "interconnects" line back
>
> Changes in v4:
> - ("...: Add herobrine-villager-r1") new for v4
> - Reorder 'status' last
>
> Changes in v2:
> - ("...: document sc7280 and villager board") new for v2.
>
> Jimmy Chen (3):
>   dt-bindings: arm: qcom: document sc7280 and villager board
>   arm64: dts: qcom: sc7280: Add herobrine-villager-r1
>   arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
>
>  .../devicetree/bindings/arm/qcom.yaml         |  10 +
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../boot/dts/qcom/sc7280-chrome-common.dtsi   |  11 -
>  .../boot/dts/qcom/sc7280-herobrine-crd.dts    |   1 +
>  .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 +
>  .../dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  17 +
>  .../dts/qcom/sc7280-herobrine-villager-r0.dts | 325 +----------------
>  .../qcom/sc7280-herobrine-villager-r1-lte.dts |  14 +
>  .../dts/qcom/sc7280-herobrine-villager-r1.dts |  16 +
>  .../dts/qcom/sc7280-herobrine-villager.dtsi   | 326 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts       |   1 +
>  11 files changed, 392 insertions(+), 332 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi

Is there anything blocking these changes from landing? I just tried
applying them and they now give a (tiny) Makefile context conflict
with the evoker dts that just landed, but "git am -3" handled it fine
for me.

-Doug
