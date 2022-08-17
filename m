Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDCB597789
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbiHQUGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241720AbiHQUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:05:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1718783BF2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:05:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j26so4913856wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MSYB9FwL7p/iJdXtPMVngWpHWItwLj/alFVUIh6RUfI=;
        b=aalXbJEtEyz0fdYAOCKPabkxfm+u5zzEGFKYYYxBeomEWGFk/ytTvkEEfWKdBZ9qam
         wwPT8nrUrsYfzpKtV1r1kCaWqWs7YknEFQ+aMuxIJu94oyoYyqccYk++TUEtq7RdJvKO
         MzSWpQ8GV7vEXfBNVWpGsamiURxgJnsbxc7XXf53ogih2Ou90s3e7mUu35VW3GIQCSSw
         JPvYuuH7VSB7jfYTR68yLcDpE1FtIEkttItkbc9J1nSS2wMYrQSwMbS4hn8f9anRfmWP
         24Hrem9kUuAlsAO5ml5foFmLYM1OVh5ICRpf43152oMEX3Pn0AUq0pEnXNS1n6QB9vsm
         c8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MSYB9FwL7p/iJdXtPMVngWpHWItwLj/alFVUIh6RUfI=;
        b=wLWC6fBnrBdVjcm2LupbK9QN3Aa4Fveh4EkQ/+5jOhugUXSmchJeqwZ+k8Jw20qupv
         7c64V1j5438erQqGcejL3cqy6NpcKpW71tOJYMJLejZWKDF+In0zq7hAHRMK12T2yy5r
         2jn6F3Wmf3FVUAtoQbWCd8Y8gVEsuNnTWV206Omx2Za5LmGMLg3fi96caWzQubG7lhw3
         vpt9XBX41mePlla31UWxhP48VINM/y8zg5vAbh9Ug3FyFKmFez+1+pL/Hu+LkdlD4Pyw
         6ED1Hzxd0Y6qaBd5eEeD8bIF1AM6hUU/cPuZmdrh0qq4BXoTRC6TkMT67XiRmDC0LxqL
         LEDA==
X-Gm-Message-State: ACgBeo21mBjeArdiFrKuYYK5dcSSQGmaNtuc0B98YYCdeCu+fwy3guBB
        cd5Nrd+ykaJGbYJVecMoGjSCJw==
X-Google-Smtp-Source: AA6agR5DU5oL31YGMFMqSJ9QosyAIgz1wKmRamOx/HzSICAxr/vstQ62IK8je47MYg2BbSWSiqFh2A==
X-Received: by 2002:a7b:cb88:0:b0:3a5:ea1c:c541 with SMTP id m8-20020a7bcb88000000b003a5ea1cc541mr3165264wmi.114.1660766756496;
        Wed, 17 Aug 2022 13:05:56 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i133-20020a1c3b8b000000b003a531c7aa66sm3400883wma.1.2022.08.17.13.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:05:55 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org
Subject: [NOT-A-PATCH 4/4] dt-bindings: riscv: isa string bonus content
Date:   Wed, 17 Aug 2022 21:05:23 +0100
Message-Id: <20220817200531.988850-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817200531.988850-1-mail@conchuod.ie>
References: <20220817200531.988850-1-mail@conchuod.ie>
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

From: Conor Dooley <conor.dooley@microchip.com>

**NOT FOR CONSIDERATION**

I figured, sure why not add the strings for version number validation,
just in case we need them in the future. The commented out string is
considered by dt-schema to be "not a regex", but regex101 thinks it
is... Maybe dt-schema does not support named match groups, but they
are the only way that I could trivially find to make this somewhat
manageable. Either way, it is permissive so it allows combinations
of "M", "MpM" & no number.

Not-signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index c0e0bc5dce04..38a824453012 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -80,7 +80,11 @@ properties:
       insensitive, letters in the riscv,isa string must be all
       lowercase to simplify parsing.
     $ref: "/schemas/types.yaml#/definitions/string"
-    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:(?:_[zsh][imafdqcbvksh]|_x)(?:[a-z])+)*$
+    oneOf:
+      - pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:(?:_[zsh][imafdqcbvksh]|_x)(?:[a-z])+)*$
+      - pattern: ^rv(?:64|32)(?:i\d+)(?:m\d+)(?:a\d+)(?:f\d+)?(?:d\d+)?(?:q\d+)?(?:c\d+)?(?:b\d+)?(?:v\d+)?(?:k\d+)?(?:h\d+)?(?:(?:_[zsh][imafdqcbvksh]|_x)(?:[a-z])+\d+)*$
+      - pattern: ^rv(?:64|32)(?:i\d+p\d+)(?:m\d+p\d+)(?:a\d+p\d+)(?:f\d+p\d+)?(?:d\d+p\d+)?(?:q\d+p\d+)?(?:c\d+p\d+)?(?:b\d+p\d+)?(?:v\d+p\d+)?(?:k\d+p\d+)?(?:h\d+p\d+)?(?:(?:_[zsh][imafdqcbvksh]|_x)(?:[a-z])+(?:\d+p\d+))*$
+#      - pattern: ^rv(?:64|32)(?:i(?<num>(?:\d+|\d+p\d+)?)?)(?:m(?:\k<num>)?)(?:a(?:\k<num>)?)(?:f(?:\k<num>)?)?(?:d(?:\k<num>)?)?(?:q(?:\k<num>)?)?(?:c(?:\k<num>)?)?(?:b(?:\k<num>)?)?(?:v(?:\k<num>)?)?(?:k(?:\k<num>)?)?(?:h(?:\k<num>)?)?(?:(?:_[zsh][imafdqcbvksh]|_x)(?:[a-z])*(?:\d+|\d+p\d+)?)+$
 
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
-- 
2.37.1

