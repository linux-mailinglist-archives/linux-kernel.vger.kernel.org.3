Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E105A3FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiH1U5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1U5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:57:34 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8388430F4D;
        Sun, 28 Aug 2022 13:57:33 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id t11so460755ilf.3;
        Sun, 28 Aug 2022 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yorHfhd/+KmEpVFUDGAaD4F9KMlU0fo7Pjux9PaY7xY=;
        b=kZknlSh97mOvFluuYbu0PP9Xa+pMb8873Td3naTZb4o6Vn/by9nfYkQmHxB3ElWmdY
         RcBkMeoznOzYCpOJnzflOFrrM2wXRZBIC2cKgzdOvlqtJRIQllgnqYZr0RapGMPTEVqH
         LCagT4QJPt7xKFr26JrsBTQNCg+RzIoAZTYogDn/KvrQaloeOP0pHUhVZ5jI3QRgBkan
         fVGyHOEhvfS+ZkPfxXZgUzy5rmnse6WJJ42yvk3QH3J76MKZyRNvik/AOZpJXyYEgngi
         h5tt2p5kXVh6BYeTsh3zwu1SrExuYhK1/SzZmA1d+Gs8aC8B/Q9NtLpKPo34Kn4jTUJJ
         pfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yorHfhd/+KmEpVFUDGAaD4F9KMlU0fo7Pjux9PaY7xY=;
        b=h9PY2IKeJBr/zM/v1lukvSQ/8NAMtGSn3nXxPbuU9wTEjEg41xs1je8ni0D5aIR+10
         vEUlBghBuPV7/iSFEIHFRgjZVlYxXBo7BMQcBdJ3X3bFSlxf83PtOToD4Isz2Nzv+LMl
         EhPhLuIDv2whuENqzCa02is5ac4kilWiRi8hFAU5mYCfAKcewQXi6tHX6Ph3c4URgX2g
         uNZ8yrMagtuJQiXjglr5TsO/CtDzuYVgWT4p1pFfix4mjeYMLaupqB5fcHONXvf5BFIv
         iS3T08KXUZpk3miX9kvK5QpOy1BVVhpzeWZ5TZ7ugtg7vLhTyOK5coLtSTRgAeifqlmr
         +fow==
X-Gm-Message-State: ACgBeo1WgOF2U0qzzrWhJ/6qY8RFp3O0FywfsqZ+73Ii1R2glJ7f3uIN
        p0LPQgTTu07LoruL9ESVX9M=
X-Google-Smtp-Source: AA6agR6GLmSPYA6+Jy2X2IFDtgpGl/yusfM4NCxD0QsUKR8GyvrGhChKod1jPQ2vZHSj4JhwFey8aA==
X-Received: by 2002:a92:b00f:0:b0:2d6:5628:6865 with SMTP id x15-20020a92b00f000000b002d656286865mr8339669ilh.230.1661720253016;
        Sun, 28 Aug 2022 13:57:33 -0700 (PDT)
Received: from fedora.. ([2604:2d80:4d8e:a000:6063:7cd5:2f24:16a6])
        by smtp.gmail.com with ESMTPSA id k7-20020a02c767000000b00349be1ef390sm3572404jao.121.2022.08.28.13.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 13:57:32 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v4 1/4] dt-bindings: arm: qcom: update beryllium compatible property
Date:   Sun, 28 Aug 2022 15:57:20 -0500
Message-Id: <20220828205723.20834-2-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828205723.20834-1-joelselvaraj.oss@gmail.com>
References: <20220828205723.20834-1-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two panel variants of Xiaomi Poco F1. Tianma and EBBG panel.
The previous beryllium dts supported the Tianma variant. In order to
add support for EBBG variant, the common nodes from beryllium dts are
moved to a new common dtsi and to make the variants distinguishable,
sdm845-xiaomi-beryllium.dts is now named as
sdm845-xiaomi-beryllium-tianma.dts. The board's model and compatible
properties are also renamed to distinguish between the variants.
So update the dt-bindings to reflect the new compatible value.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..e465ca45c07f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -666,7 +666,7 @@ properties:
               - sony,akatsuki-row
               - sony,apollo-row
               - thundercomm,db845c
-              - xiaomi,beryllium
+              - xiaomi,beryllium-tianma
               - xiaomi,polaris
           - const: qcom,sdm845
 
-- 
2.37.2

