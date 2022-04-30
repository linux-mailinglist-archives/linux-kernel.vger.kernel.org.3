Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83501515D6A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382775AbiD3NQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382702AbiD3NQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:16:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD9F83025
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:13:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m62so5978963wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Ldjvg75trqwAdnOnSC1cbShnEwGZkL07QizR47KBI0=;
        b=3Q+LcRPAJonoG2Ba2IxaBDslynUXIxTEvrqhBNEZ6i7dnqdnblFID6Zx9ksmZECEzN
         6lgj+D8WLHntXq2O9lJEtYI+n4tZCtCLw/Yv1Qqp6Vl5gvjfZ72Ik5yrqvbiOljGS9b7
         Udt4fiet896JrQqswR/A3qdJwJYLFKwdVag0aQO/Wkqitfepz+snW3V1c7k7csLx2kQb
         cARJOxDJn7s6/G9pqRpmJRbzI2DB3YcTz5VVyJggtk5+BbPeWjIbK+VaSaY+yOTXauUL
         UuebwGCM8gPg1UZp4G/s+86pJzcs4PH0Vad9UZOQWHXL+m35eqzIke3O+K7trCfvqj8p
         XMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Ldjvg75trqwAdnOnSC1cbShnEwGZkL07QizR47KBI0=;
        b=p/6Ka6fXxKiVOnWG3t7SlfMxh8FcD7rQiiWXh+4PGUZqP2/LouDhJItXASGvuMsgeX
         sG9ogYOfqv6G6HUrfBCGnIto2HqgmaFc4PwRfWkdT24dGWYX3PBb4vY68Fho0Xnkqnv/
         zQG+kNoRInlVt9vyAoXBeKMwMp+wYmTs+IWwHUkiOz7VA6+62y5XpnRZhYj209xggbgI
         MUDFYzkt844R7W0i/LyFJABQKSp7SLXuyAgIWR6yY1TI1yC6Gk3PRAQXQsy/arszjJ9W
         TvbYeiVi/QzU3AdgoLkDN1lA6hETP1sPawm3BAyNPJ6G8WmeoZre3GN3B/xqY1L8tk3+
         3DxQ==
X-Gm-Message-State: AOAM533/5t4sRr9Jx99kdC6DJlBpgr/e/tGXfup+pZWUENtUzS7/oQo4
        yEym/lbI9Jtnv8so9hLNTN4p/w==
X-Google-Smtp-Source: ABdhPJwCuW2uPEbg66rIDyyS+5v2XYGjunNR1Scwt3xYvOnicye2eTMHVsC/c2tFquBud2iD8rYJ9g==
X-Received: by 2002:a05:600c:198f:b0:392:9120:c6ee with SMTP id t15-20020a05600c198f00b003929120c6eemr7704932wmq.18.1651324380909;
        Sat, 30 Apr 2022 06:13:00 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id p9-20020adfa209000000b0020c5253d8ebsm2004439wra.55.2022.04.30.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:13:00 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <mail@conchuod.ie>
Subject: [PATCH v2 7/8] dt-bindings: riscv: microchip: add polarberry compatible string
Date:   Sat, 30 Apr 2022 14:09:22 +0100
Message-Id: <20220430130922.3504268-8-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220430130922.3504268-1-mail@conchuod.ie>
References: <20220430130922.3504268-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add a binding for the Sundance Polarberry board.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <mail@conchuod.ie>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index c9d8fcc7a69e..7f9296991a56 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -21,6 +21,7 @@ properties:
       - items:
           - enum:
               - microchip,mpfs-icicle-kit
+              - sundance,polarberry
           - const: microchip,mpfs
       - items:
           - const: microchip,mpfs-icicle-reference-rtlv2203
-- 
2.36.0

