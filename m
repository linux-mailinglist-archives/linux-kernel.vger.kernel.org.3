Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA1059777C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbiHQUGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbiHQUF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:05:58 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7625A833
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:05:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bs25so17431532wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=De0s+s/D2rq5b1W85sP7P0sadpD1tyl+4KZh5xfCdFc=;
        b=CqamtgAe1cozn3E5KYzIR0JSvcCAa1Xfs2dPgBcx+0TIqlYpaQ31CAGtekwFrEq3/w
         +lY37IADJw7hcSFmTZ5af/FF/BWp/lzVufrxeKGzDhuXY3/lmzb7Y/GcUmt+NJ/1dWRF
         No5gZ+j+hFAHBwcOmgNIM0KteUxW83ESCVJCDvMNCkbHKNu4Fp44M0F8HZ5m4YVcrYE5
         gVv1hRa6fQlU4jn/uVxGBskyzHAK1X3lsTkVsg7wg+nHs6RGCiW+b8g6A1EAMAB44MnL
         JLobl0GZbdVudwNjFMsjiMjZJn3PJPDXAw2MQGt1Z7ETNOFJguNN9qrdd954ctHWf0up
         IktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=De0s+s/D2rq5b1W85sP7P0sadpD1tyl+4KZh5xfCdFc=;
        b=2kAXLhA5tFnpF/9Q9iDwxFS5fTPO3EwNTzA204VMa/J3OW1v+sbiobst2LAVddZrJZ
         yKqi9Ecn2xYrTQmaaOb+phfHEQwzuCz+Tn/zZqpwtTk+0mUONt/j9AO+WpPYu2awITuV
         vwWxNRvEeVVQ8CGsDhqAvqNrv9VS3q0Wa/Fb7mnWTopb3HCCgWGa5t7S0AOHNYOkOw9v
         ObmFSrLkl7edvN42HRuiq+p+E/fV7gQw4fRWa70deipmnD3XiRH/QM/ZZPmHnm+5R2qC
         yVTjLGBpK6zgNykDCniLtDBjT2qU05Pnjjy6Wzwkbc3PHtlnttl42sF74R8AHOOiGHmR
         UC1w==
X-Gm-Message-State: ACgBeo0wd/1rfoIthlwWRN/qygrtOQAMsDPY9um8EWUVexuZJPloyyT3
        GfUrA6PYqc+IOpAfQM+zXcUV5g==
X-Google-Smtp-Source: AA6agR50pEUBEksxLhbytcIwiO8h9Uinjt+PuB3e09bA3J6AK1dzbXoEiGaehAaijDuEftMP10HEjg==
X-Received: by 2002:a5d:534e:0:b0:225:2c0b:9b08 with SMTP id t14-20020a5d534e000000b002252c0b9b08mr750530wrv.136.1660766754709;
        Wed, 17 Aug 2022 13:05:54 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i133-20020a1c3b8b000000b003a531c7aa66sm3400883wma.1.2022.08.17.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:05:53 -0700 (PDT)
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
Subject: [PATCH 3/4] dt-bindings: riscv: add new riscv,isa strings for emulators
Date:   Wed, 17 Aug 2022 21:05:22 +0100
Message-Id: <20220817200531.988850-4-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817200531.988850-1-mail@conchuod.ie>
References: <20220817200531.988850-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

