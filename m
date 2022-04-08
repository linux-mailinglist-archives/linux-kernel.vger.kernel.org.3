Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0164F991F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbiDHPOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiDHPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:14:46 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D837FC8A5;
        Fri,  8 Apr 2022 08:12:42 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id j6so5023886qkp.9;
        Fri, 08 Apr 2022 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ChSEY7h2sRW/2ExANChMlGLpgvQbTjAzXwSGw78syU4=;
        b=VL1Y942y0CjJChV2tq2vsSLGf9pTuJOFpVmdTPyNruzKwny/pl92SPdwDE7JjJqrC7
         sPQ3fqggNInkGYeBcIH1fiyaPuU4wvysUlDRIkRuRC3Wqb3Bbhvc3ym473gBDVOGKQk4
         mv7YZUmqITDZ2Etk09PrfFLmxD3Ki6eRYtXWKKCloAtUE2FjDY8TfQQH7mBktUkR+LN1
         2kBJZHf1ktDPuQxcejrWCIngAVNBKuFZJRRmXCKCn0VUQrha0K1exXCzIg6xq5v1Ag5A
         EL6mehVqJWqU4dbcne64OMdSdvKp1KXxcr8Ti6xKJUdhKPiRGp5aMIIJd8mb/2XEC11r
         fvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ChSEY7h2sRW/2ExANChMlGLpgvQbTjAzXwSGw78syU4=;
        b=B4fMJrK+Xcy+q8dMb+jDKSeCLXu1/BXtzIF7wx6NjytrmRzR/+XnJpCZJLp4cMc9Z+
         RHESNk6e99aJp01l974HGQvAeWv8s87Wa8zadxusQqw5PugGkcnJ6QhztcMtbqokvnCB
         /S4xO7+99DA5A0AGh10QhIZOcJjP97NWg9h7yJ9HaVELqVNUpP8j8DPpDX887irkD/nk
         zM0sc7UtSlGytW7l5yF+CQv9giOm7pv9JsblyHzdDLn9FwhXqMBmTKldJrZUqAc3Hnup
         aClNfQxmK/GwHXjw/IOibsMkcrXTlLiqJ37cekQrzDM0KGvKPRPbp35MSacD813MbRUc
         r9JA==
X-Gm-Message-State: AOAM531qMrTaCUMyldbyZfV0iLv1vyazplBb4keYtdPRRVjVZcCo2sjx
        3iEj7tErk10woXLQVu7S/Lw=
X-Google-Smtp-Source: ABdhPJwyTFG9s1eZqDpr0it5uK6x7Wfc6bXkHoffjYadfbrQpn/oFApdowm3ocx0VSpB92zWbYg23A==
X-Received: by 2002:a05:620a:460b:b0:67d:1cd4:527e with SMTP id br11-20020a05620a460b00b0067d1cd4527emr12838615qkb.277.1649430761326;
        Fri, 08 Apr 2022 08:12:41 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 191-20020a3707c8000000b0069a13545fcfsm2266052qkh.123.2022.04.08.08.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:12:41 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v5 0/5] enable usb support on rk356x
Date:   Fri,  8 Apr 2022 11:12:32 -0400
Message-Id: <20220408151237.3165046-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning,

This is my patch series that I have maintained out of tree until the
combophy driver landed.

This has been rebased on v5.18-rc1, several patches in the previous
series already landed and have been dropped.

Patch 1 adds the dt bindings for the grf changes necessary.
Patch 2 adds support to the grf driver to set the rk3566 otg clock
source.
Patch 3 adds the dwc3 nodes to the rk356x device tree includes.
Patch 4 enables the dwc3 nodes on the Quartz64 Model A.
Patch 5 enables the dwc3 nodes on the rk3568-evb.

Please review and apply.

Very Respectfully,
Peter Geis

Changelog:
v5:
- Rebase on v5.18-rc1
- Drop patches already merged
- Collect acks and tested-by

v4:
- Add SoC specific binding, fall back to core.
 
v3:
- Drop the dwc-of-simple method in favor of using dwc core.
- Drop all quirks except snps,dis_u2_susphy_quirk, which is necessary to
  prevent device detection failures in some states.
- Drop the reset-names.

v2:
- Add a dt-bindings fix for grf.yaml
- Unify the reset names.
- Constrain the force usb2 clock dwc3 patch to only supported variants of
the ip.
- Change dwc3-of-simple to support of-match-data.
- Drop the PCLK-PIPE clk.
- Rename the usb nodes to be more friendly.
- Add the rk3568-evb enable patch.

Michael Riesch (1):
  arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10

Peter Geis (4):
  dt-bindings: soc: grf: add rk3566-pipe-grf compatible
  soc: rockchip: set dwc3 clock for rk3566
  arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
  arm64: dts: rockchip: enable dwc3 on quartz64-a

 .../devicetree/bindings/soc/rockchip/grf.yaml |  1 +
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 37 +++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3566.dtsi      | 11 +++++
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 46 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  9 ++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 35 +++++++++++++-
 drivers/soc/rockchip/grf.c                    | 17 +++++++
 7 files changed, 155 insertions(+), 1 deletion(-)

-- 
2.25.1

