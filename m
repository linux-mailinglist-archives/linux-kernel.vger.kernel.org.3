Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5F94BB2E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiBRHIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:08:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiBRHIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:08:06 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCF21BA334;
        Thu, 17 Feb 2022 23:07:49 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m14so3651225lfu.4;
        Thu, 17 Feb 2022 23:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+bxWvATPkNOJhL/LdCmA0xomBxVYCMbyohvhLg0UcI=;
        b=cAviAy5J3oRRudjP5AIgmmBkwBZSkZpaCf7XKJkXx2jN9biGtrzmrz1tMLxXvk7Wqx
         +h5moiMM/uORfgGLhJOEyTGdAJkC7C1wCdlzfxxndxKWM9ImTphOcHmpfmmX298P5BRi
         GsFGEsDyhD76/KpyY71L9oz8AjUIb9DlzLyH0Bbslvn2A0OaVI1lbUxzHSsuj29RC7q/
         N9WI03NxUi3RQT4duuhWdbcYDjZgYBQlBvfs6zwd6PLX4Kn2y2RmnViVwzSW4Y/TS6ki
         AHywcxA2maR2tyUnWnT5KrLXvXp+eFzxQjxm/gVxroIE8X4lAY8+EsFM00QV9VhTWAmP
         tjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+bxWvATPkNOJhL/LdCmA0xomBxVYCMbyohvhLg0UcI=;
        b=0zKtz52Gkd/RDs8WabUE2U2sTeFm2kwLD47yW5Aw6+NtKTwspcu49EKMqrvPqUU2dL
         ey8AH+YGsIVJ6wV+yyP6y1CjbBEz8vgg7D6kIpQyCpa7xv2AK93MyIIM6EAgfstdWUkU
         D0gEh2h6axulcqF4PO3cGldHte6qWz1Mo7JEDLrFkf+35BDu3lXWGKgspQxQQ5eiNvGm
         bmazirHrON50/gdaqnJteucB4XXqah1IlZpVriHXK1MXqCKkAhCfG+sr7PgFCRNziSiA
         UZo/j1Q1ubNC4/gtmWOSfBxjBZSeI42LHYye0ak4btTZK6/Ohndh+YocnjJL4IpSkN5L
         oO9g==
X-Gm-Message-State: AOAM533aRAJYRE+VYRhowOADsy3E8ktFV/lQsVourFenY8FQuz3Iitim
        AnzjJ3BX4xiv1LfePuC8wxs=
X-Google-Smtp-Source: ABdhPJxOVs8gipD3+lXvLpzGAJAUN72tLwtRCdCU2mNHxQTEFevcefrvr5xFCYLginqNQACcLpA4Nw==
X-Received: by 2002:a05:6512:1529:b0:432:2c53:f9e7 with SMTP id bq41-20020a056512152900b004322c53f9e7mr4464499lfb.139.1645168067679;
        Thu, 17 Feb 2022 23:07:47 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id f2sm216321ljn.11.2022.02.17.23.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 23:07:47 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V3 1/3] dt-bindings: nvmem: make "reg" property optional
Date:   Fri, 18 Feb 2022 08:07:27 +0100
Message-Id: <20220218070729.3256-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218070729.3256-1-zajec5@gmail.com>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220218070729.3256-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

Most NVMEM providers have cells at hardcoded addresses however there are
some exceptions. Some devices store cells layout in internal structs
using custom formats.

It's important to allow NVMEM consumers to still reference such NVMEM
cells. Making "reg" optional allows defining NVMEM cells by their names
only and using them with phandles.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 43ed7e32e5ac..3bb349c634cb 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -60,9 +60,6 @@ patternProperties:
             description:
               Size in bit within the address range specified by reg.
 
-    required:
-      - reg
-
 additionalProperties: true
 
 examples:
-- 
2.34.1

