Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6670651AF5C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378248AbiEDUjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378238AbiEDUi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:38:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F0610D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:35:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c11so3513461wrn.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5D4kzOmGE7Re7vnlBTXTiR7FcHwOIAoOgkeDw/vc/M4=;
        b=eJ45NdIcxjr/92xfWtahZPRwhHmf1pnasdivXJNSTjnCvSFR7Sf9l/rPHzCzvJ35Jj
         6F7/rw832CQifVQPa3MNqS1UqCEfVy2aUFUSIpJ5oRQ/T5zzMhL6DjPQaW2rSFZGgHP7
         wIcPvoXQX59NsQVoMurnY9nAzG1KBTMMtLnIBHbK1ulqEho9SdiKjHAexH3ThITR85Py
         sJRrhVWJA9B1w9SMhgoQlBXKCxsDb706AmZrwHhkdQu4uW68OWtuQHh2/9ni8UtZ710A
         DOxw5QDNSLD7pZj7sLUdbvjrIOcaKTQIKmNQYOv91ioBBaNUSfZVDfGhtzEJpDn5CTYA
         Rg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5D4kzOmGE7Re7vnlBTXTiR7FcHwOIAoOgkeDw/vc/M4=;
        b=tzIMwKjbl/Cj9iSvmf/dQcFqhmtMJbENw2K2t8GD3s0MsM0k/Ua9FnJIA14cgmRTq0
         dkbYUVhHwVDyOCrhuMqswmn8+L23Pd1qDFmImMKLJv2ExK9Rseav99aXUF4EWCa6M8fs
         VHjWvRIWmUJnWLWtACDm4sAPrF80NflJVChR4cZe042pGlFV5xfj0w23b8c3vvBXfC2u
         kx//p6ssxeVxVCcV9u3T7WSJkc6FMucYv+siOodV1fFDO5mMW0KZoxIc6BFqHizmbHXR
         8JTMrcZ+nTmK8K1LEEkP4k6LetzaJBKW7aqYTUeOSd3UmXnpjbbWvGVRudaxiI9947xd
         USwg==
X-Gm-Message-State: AOAM531O5NxBcbuIv6mfjeYEq4Etoy6ht2ZbPcbtNmLl1bCEG3OzTa8h
        7Xqk0/ik3UcqaGgMcq2qWoX0WA==
X-Google-Smtp-Source: ABdhPJyvbowoCrHJp4S9JGsEZwHDiCmp1MNaFzSxtbcHpSp/Q+WTTmrWNcjGitiaEyvroZY4I2SW5Q==
X-Received: by 2002:a05:6000:1681:b0:20c:5aa2:ae14 with SMTP id y1-20020a056000168100b0020c5aa2ae14mr14366908wrd.443.1651696517422;
        Wed, 04 May 2022 13:35:17 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id l20-20020adfc794000000b0020c5253d8dfsm13330101wrg.43.2022.05.04.13.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:35:16 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 4/8] dt-bindings: riscv: microchip: document icicle reference design
Date:   Wed,  4 May 2022 21:30:48 +0100
Message-Id: <20220504203051.1210355-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504203051.1210355-1-mail@conchuod.ie>
References: <20220504203051.1210355-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add a compatible for the icicle kit's reference design. This represents
the FPGA fabric's contents & is versioned to denote which release of the
reference design it applies to.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 3f981e897126..822a711df9e9 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -20,6 +20,7 @@ properties:
     items:
       - enum:
           - microchip,mpfs-icicle-kit
+          - microchip,mpfs-icicle-reference-rtlv2203
       - const: microchip,mpfs
 
 additionalProperties: true
-- 
2.36.0

