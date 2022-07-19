Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0E5792A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiGSFs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiGSFsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:48:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DA525596
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:48:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g126so12595858pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sX1onoPJ1YOPt+mOAth6+mii2dmZ7QR6AiT86YyKdU=;
        b=Q+etMlFe7tkFERxmJLMYSSfPYaSKlDVB5MmWG/aPRDojaTL7fGB65qXqN91Wp9rHzM
         Z5NdjthNuFERRgaHn1ErM7tncHNinspsUs1jW3qrFtX00TaOJIdUoTQswz9XzPMLikE1
         dvCti5riz+mJ5rvt2kWr6V0MA3Y4TcnntUXmZnRg/yJuwFv9jPW4NMXbKEsAIIt+K/sy
         8rq9awPE1F7KbXNI1cCmjugCjPCEnhjT5hTPcYM8FlJ3M7Cc1zGUZaztBv9xjrBJYjbo
         ULY4FCkMoLuUTLn83FyGLDKKs2UP1dcIOvP73UVAn9rp2Y/PMKIrBbpux8I9MIYYD7R4
         sn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sX1onoPJ1YOPt+mOAth6+mii2dmZ7QR6AiT86YyKdU=;
        b=s6RAWA7Mh1UvllYRzyuPnt/gv4z0Topky51VTH2tB21ekF0M+B5NY6YaTqQjTISKjB
         7bYQaNbwlSB07sxAljhIWt35PuuJUfV6uGceiTKpbP2lFGNVvAAGgSNdwzwMJd4gERca
         rzWKbqFqEdnYcTyPQ8tVHYemghpePK7hU1WbxBIiLMNSKCY1iPswAbRu0J/iv/BHLt4c
         FMVCHdsuItXlg2ZsWLwrRJqPijXtaE8eGfj5Qd/g51ZsHslZzXW+PHl/onDgoxqN0Gj8
         ukT/sZQGWGlPdDNX4VFdonBUzYoK+fcoUAMbDWbUIwdBMYMAMDYboeC1ZNJ4WpBOy8nT
         y1/A==
X-Gm-Message-State: AJIora9lreF/4ZTFN7sBRp8whFodkDRbhTGq8niTWtHxYtYp332+CYLq
        pdhGqANRPj7VrN+Vg94oJH4MR20SVS9hKA==
X-Google-Smtp-Source: AGRyM1vEptqqG+SuWmXjVjM2cnzKrtW4+dR5715b+Hro/HvmivhTCinXeLELS7w7xtHgkbdT9pABkA==
X-Received: by 2002:a63:1a21:0:b0:412:b103:97a2 with SMTP id a33-20020a631a21000000b00412b10397a2mr27744199pga.12.1658209701359;
        Mon, 18 Jul 2022 22:48:21 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.93.102])
        by smtp.gmail.com with ESMTPSA id o186-20020a62cdc3000000b0050dc7628171sm10374129pfg.75.2022.07.18.22.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 22:48:20 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/2] Improve CLOCK_EVT_FEAT_C3STOP feature setting
Date:   Tue, 19 Jul 2022 11:17:27 +0530
Message-Id: <20220719054729.2224766-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves the RISC-V timer driver to set CLOCK_EVT_FEAT_C3STOP
feature based on RISC-V platform capabilities.

These patches can also be found in riscv_timer_dt_imp_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (2):
  dt-bindings: riscv: Add optional DT property riscv,timer-always-on
  clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based on DT
    property

 Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
 drivers/clocksource/timer-riscv.c                 | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.34.1

