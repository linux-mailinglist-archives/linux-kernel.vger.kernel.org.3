Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93744F05EB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 21:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345550AbiDBTls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiDBTlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 15:41:44 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5BA5BD03;
        Sat,  2 Apr 2022 12:39:52 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id t15so4159172ilq.12;
        Sat, 02 Apr 2022 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PfXb6wgE1fCi7gbZmgJh+C1kevw8RuQSvCv1PBgvIQ=;
        b=GmWCN9oQRhR0LKwUWW8dUZkludvNebn4tOCHuJEQoyyXrXBWJGzCmQ2CwaVZyMYTyK
         IKAn2kmXpiXcopf+Gy2nRdTi9uafV66Abl0U84UbTj95RgZk5gSEoKzc4o6PYVzLTpqx
         bSvJy/jtvjKjXG7z4EFBhDcIrcb5QAQckxFJ7lbwGJkEerXqNQQww8CDBAfw86RLmuCl
         IsWv9Iz/iAEnojWc6FundEQZcbW+UT0b4EA85wAln+gNuu+Pr4GRD72BqGkT7kj/jJx1
         77QeNy+vvF+BBPHJh6QLSbTP7JGot2g7/S/p+PZia/7F1dFQF4t7bAnvI1ETaSyfZbCk
         m9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PfXb6wgE1fCi7gbZmgJh+C1kevw8RuQSvCv1PBgvIQ=;
        b=ee+YaMYoIboplo7Gd50zIGrRgvJDaZjTuMJWdqwXZ+3QGvq3C2XqUVtzHuZOuaj/AQ
         XHvBJUDYpid50sv23K6twjlWoL6o1HG0C7pIHOe08VcVEslwdL4M3+185Q7ITowvqBX0
         ZVY+L7kS4oe+zs6pZ4k56NCwheE3uT60AKHX1kvxswyIFuVL1k6kCHne21biYiVf46+W
         CqNYGWLzURQ+eCjnrRSnVCpBGq2f9+Fue+CafJ/6YXY7/2gOmfQjKfzrRiHuJdXXcHhS
         OcEAoDYQehr0dN+7wkBCGms14r022SPxlgWwhjZ7+dSjy3FlNgTMEJtT4oeE1xhoBOCn
         EpTg==
X-Gm-Message-State: AOAM533UqHoZH/8gZKq0pqwkbDhvTOh8wLsLeQh2BTnl8QlC50vS4eoM
        HE3cHvzmIBDpF/sYGJnWAw0/KD0dYw4u3g==
X-Google-Smtp-Source: ABdhPJwT25RBB2oUzUds2hBeUikXA48lMFgEQ+HeejbeO+wZp/5WNtTichNmAGScoXqE41ic8jJOLg==
X-Received: by 2002:a05:6e02:152f:b0:2c9:998a:bb85 with SMTP id i15-20020a056e02152f00b002c9998abb85mr2390044ilu.58.1648928391365;
        Sat, 02 Apr 2022 12:39:51 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6ab1:a455:ad1b:e8da])
        by smtp.gmail.com with ESMTPSA id a14-20020a056e020e0e00b002c9e2f0fd76sm3261756ilk.13.2022.04.02.12.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 12:39:50 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     haibo.chen@nxp.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/4] Fixup fsl-imx-ehci fallback
Date:   Sat,  2 Apr 2022 14:39:38 -0500
Message-Id: <20220402193942.744737-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8mm-usdhc is a superset of the imx7d-usdhc which adds
HS400-ES.
The i.MX8MN and i.MX8MP both support the HS400-ES so the fallback
to imx8mm-usdhc is more correct since they share the same IP block
as the imx8mm.  This series updates the YAML file to show the updated
compatible fallbacks while keeping the older imx7d-usdhc to prevent
breakage and keep backwards compatibility. However, a note was added
indicating the imx7d fallback was deprecated for certain devices.
It then updates the imx8mn and imx8mp to fallback to both imx8mm and
imx7d to enable the missing HS400-ES functionality.

Adam Ford (3):
  dt-bindings: mmc: imx-esdhc: Update compatible fallbacks
  arm64: dts: imx8mn: Enable HS400-ES
  arm64: dts: imx8mp: Enable HS400-ES

 .../bindings/mmc/fsl-imx-esdhc.yaml           |   21 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |    6 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |    6 +-

-- 
2.34.1

