Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD43B4F81D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiDGOgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344106AbiDGOfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:35:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A281BBF54
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:33:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qh7so11192015ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6WexuKP2+sDgybtIp4d5+di9H7v3WxWenN1FdjYcEmk=;
        b=y/SG15SEpRCCG8uYeJmXPIv9oAYavis/ItpzS7yLNHAFM5XaLn3QHBwSEUJF76Fljx
         92pFV11kezcROBOnXoPUn+IeOEFyawtfsm+3onlxSnHrxn1hbkL/V2rILaCwpRAnI/47
         /IpC+r5T09f0/F1fwJ0GZBFy16DypolTb61Y26dkfUT9ddK9Ay7vmpheriUCk3wh5D6d
         R+PCulq7AcsKwaTaDucEuQvU+c3vs0SRV8d2Hzp8RJBfH+EMh35leg3hfUUpxjWkNEf4
         u4oPwWrUaRudP6dFhUYRHn9TBlAXuA9XOk9l0MhgVy3URBlVAOpRa3oil7DnhSpx/eMZ
         Jmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6WexuKP2+sDgybtIp4d5+di9H7v3WxWenN1FdjYcEmk=;
        b=FQlqTArVPkpzJwOksoqAow/HYCFM2f1K/osUrfyqbpMZzB94ubxEamB/6oaT4jMzZb
         OjvLJ7smyVSwhIJYkQb8TtxvxSQ/gBxVgf4aE1oNkdvgoG2MIIJ/nLBUZAraPBM28lmI
         1VPKhDm/TLWD9u9mfRIyhFNcrb+COpIAYlh/abmd5L2aLMxGed6Ga5yHSgrjtR6zn2PG
         iBXmNlpMGa64wXCvePcLcU73gWQOm9HmrJw0Fh3hT7HVe2JktMPlkd6HRpA9nso7OmDB
         ZbMIN6bdKct5UFctvLS/SO0/F3OS8l3sENY6x2fE1Y3FcqRc8qzFASLsJPMZSQObAAeb
         QEYg==
X-Gm-Message-State: AOAM533Svi6rAGIDyvY8yUY7+Tw1wI9QniffrQvx0uok/Wb6eniBBIVm
        /uaiBtkoCTBUqG/GBasSMyK9Ww==
X-Google-Smtp-Source: ABdhPJw5zue4iKS/TQaJIGMwSZ6Y7iPPlhdZ+SImZzHszW1qfRZOjpR6siPostuHMy/5BnvEtua0aw==
X-Received: by 2002:a17:907:7e99:b0:6e0:2fed:9789 with SMTP id qb25-20020a1709077e9900b006e02fed9789mr13512644ejc.72.1649342004706;
        Thu, 07 Apr 2022 07:33:24 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfdfdac005sm7653567ejc.174.2022.04.07.07.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:33:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vineet Gupta <vgupta@kernel.org>, devicetree@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARC: dts: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:33:22 +0200
Message-Id: <20220407143322.295696-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arc/boot/dts/hsdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index dcaa44e408ac..f48ba03e9b5e 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -275,7 +275,7 @@ spi0: spi@20000 {
 			cs-gpios = <&creg_gpio 0 GPIO_ACTIVE_LOW>,
 				   <&creg_gpio 1 GPIO_ACTIVE_LOW>;
 
-			spi-flash@0 {
+			flash@0 {
 				compatible = "sst26wf016b", "jedec,spi-nor";
 				reg = <0>;
 				#address-cells = <1>;
-- 
2.32.0

