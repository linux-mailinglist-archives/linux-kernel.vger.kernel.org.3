Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D38A5977B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbiHQUM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiHQUMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:12:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE49A6C2C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso1569346wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=De0s+s/D2rq5b1W85sP7P0sadpD1tyl+4KZh5xfCdFc=;
        b=VoUCelW9ATsck56Z8Vshz+e5skJfqAaLWP0HlwFo7La/BTrmJH5e8zjyqLvEREwsny
         wivfEbQBCbsuAwXFwnaTCReVWo48k1o/9NHZ6uWUyyb1QcRZaacS8eYKfW160GvNgdRl
         tERNO6oWhTlIwX2AAbAEDn9M5mRMpl16CQcmPD1jWSFcupCT4CmqBFX72IKxsy5HNvI6
         1ofx3JTRa4Gz5oJXqe8j7aHCHkdofi+lsc4O68CTHYD7rM2Dd+IYZB4Y1c4bvN760fwl
         mqGvxbSv/gH2QOynns+PpVsW5V8qUj2oLo3HbjL3PbdYC6gjSc78t0dyQeNKj8aE5M8n
         wMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=De0s+s/D2rq5b1W85sP7P0sadpD1tyl+4KZh5xfCdFc=;
        b=hKa4vXMuq76OzDdwuGp0TB9c2OK/gnZSzpFaJH0lf6JGkAq8s8jHiYwgHuE2shvpnm
         alZJyqVsna8GmOyTfMOP1UGgsN8GFLeS+L2SUOPx8ntJw6HRyR5R96tdjbUyRrRFhbaa
         BjemcYs6o3TCHWOLXZNdbUzHlBqDeAOJT8+CEe1cTXlEevNRWB/miBJ5XN9ie7tfKKWu
         IsvtCpaiackQWB/mcBqldbP15Jfr73jjIKylI87nZeZe0JGti7SnUgF6N4TJo4ON0kAT
         g5grC9j5t0kC28MVjlTE0j6rKBWzDG6d1cf+Pg7Ru0pJJ3rDM61uSZPIPIDoH/zsQwpr
         9SQA==
X-Gm-Message-State: ACgBeo0H81763rpStZ/IpV+wdc9J60oZ1D4k1VPvSGY1rMyuqt6iL1UY
        ZBh4j8rEK98k8xQWP8c3golmSg==
X-Google-Smtp-Source: AA6agR5fECZky51OLxj7IyiHwCUh5pSaXNngYTDHiSH2lpDG7XCOjdR0BjCA3TzdeYNFfoayKbBkfg==
X-Received: by 2002:a05:600c:4f05:b0:3a5:ffec:b6b with SMTP id l5-20020a05600c4f0500b003a5ffec0b6bmr3007577wmq.199.1660767164394;
        Wed, 17 Aug 2022 13:12:44 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b003a5dfd7e9eesm3029371wmq.44.2022.08.17.13.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:12:43 -0700 (PDT)
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
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/4] dt-bindings: riscv: add new riscv,isa strings for emulators
Date:   Wed, 17 Aug 2022 21:12:12 +0100
Message-Id: <20220817201212.990712-4-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817201212.990712-1-mail@conchuod.ie>
References: <20220817201212.990712-1-mail@conchuod.ie>
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

The QEMU virt and spike machines currently export a riscv,isa string of
"rv64imafdcsuh",

While the RISC-V foundation has been ratifying a bunch of extenstions
etc, the kernel has remained relatively static with what hardware is
supported - but the same is not true of QEMU. Using the virt machine
and running dt-validate on the dumped dtb fails, partly due to the
unexpected isa string.

Rather than enumerate the many many possbilities, change the pattern
to a regex, with the following assumptions:
- the single letter order is fixed & we don't care about things that
  can't even do "ima"
- the standard multi letter extensions are all in a "_z<foo>" format
  where the first letter of <foo> is a valid single letter extension
- _s & _h are used for supervisor and hyper visor extensions.
- after the first two chars, a standard multi letter extension name
  could be an english   word (ifencei anyone?) so it's not worth
  restricting the charset
- vendor ISA extensions begind with _x and have no charset restrictions
- we don't care about an e extension from an OS pov
- that attempting to validate the contents of the multiletter extensions
  with dt-validate beyond the formatting is a futile, massively verbose
  or unwieldy exercise at best.
- ima are required

The following limitations also apply:
- multi letter extension ordering is not enforced. dt-schema does not
  appear to allow for named match groups, so the resulting regex would
  be even more of a headache.
- ditto for the numbered extensions.

Finally, add me as a maintainer of the binding so that when it breaks
in the future, I can be held responsible!

Reported-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Palmer, feel free to drop the maintainer addition. I just mostly want
to clean up my own mess on this when they decide to ratify more
extensions & this comes back up again.
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 873dd12f6e89..c0e0bc5dce04 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -9,6 +9,7 @@ title: RISC-V bindings for 'cpus' DT nodes
 maintainers:
   - Paul Walmsley <paul.walmsley@sifive.com>
   - Palmer Dabbelt <palmer@sifive.com>
+  - Conor Dooley <conor@kernel.org>
 
 description: |
   This document uses some terminology common to the RISC-V community
@@ -79,9 +80,7 @@ properties:
       insensitive, letters in the riscv,isa string must be all
       lowercase to simplify parsing.
     $ref: "/schemas/types.yaml#/definitions/string"
-    enum:
-      - rv64imac
-      - rv64imafdc
+    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:(?:_[zsh][imafdqcbvksh]|_x)(?:[a-z])+)*$
 
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
-- 
2.37.1

