Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B285A184E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbiHYSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242983AbiHYSF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:05:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD517286E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:05:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so2933941wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JUTRY4gaK8Gdeip+jNVieK44Ohhk3yQH8niH5zENkSw=;
        b=UQRwsSKSQOopSzPEnfGl08Wcz8NArorGUNMK0W1lv9/M3NFHsrXasUoP/8N6hnNLyh
         Db+QzkVDzRMXC3hgUyXq0p/ra8hm2s0axZjgkn5/xzjO73xUBq3NWFs8zslI3FobG/9q
         ElabZvviGU6oh6mONYgE7ezidVx0xJSjXX7zA3rtbmtllF1f27STAnj3DnA+VfAXUkMl
         Da7Z8W1c5erVgM2O39G0VW5VS1MZds4EV6uliQXvj/E8xFQyQSOgSyjZyifITgzLG8Ka
         oMAd0Sich0b0OCAAyxB0J9XknMkajEdI82BQg3Gwbo/HoD4VPnFnOKOAkEkcJMZH3M23
         2JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JUTRY4gaK8Gdeip+jNVieK44Ohhk3yQH8niH5zENkSw=;
        b=4qhPw8D15vJpRBc6MDxPh6bnSaOWcKTWF1tziXCBIIClofCvt+MM0Y9i912gOouLBL
         vUw8yDH3mu+i/C8AI8/ItC3CACkLAJ2qEQAx5yPKfemkP1Ssn721iL7rlYVmzHLwwHFp
         pnhVzRUD9q3tYzu+HYplPD5ZUbOqN2Q4MtQImUKa0PRoEYuc1IYxzQRZ0pWMjlQoakx3
         TUWmvw1tvSlS/WvESWHtcVCuVctMwTBSv/MCGg68lFDJMHUFEfTkScrNKnlrG+Js8i5x
         TfRDq9EHj53A8ypIv03Fnk1UMtY7DukV8H+9prXfCmQ+rwx5Lbt/ep0bRt6kbIy9S9cd
         71tw==
X-Gm-Message-State: ACgBeo3olN4cfuirCGLWWuiHdlM4YJMli7Mgi8ox7/YLj9DLuzu6wq3O
        3UN6YBMCElmiZnOe5J5ZJEtYRw==
X-Google-Smtp-Source: AA6agR5biMHZOOviA7RBIh8sODjlp+ZpN4gWA6662c/obgpPYUJW3Xon/lSc/ip8BcNFU0lBj4jAww==
X-Received: by 2002:a05:600c:3d09:b0:3a5:e408:ca19 with SMTP id bh9-20020a05600c3d0900b003a5e408ca19mr3121650wmb.135.1661450725527;
        Thu, 25 Aug 2022 11:05:25 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d6044000000b002254a7f4b9csm14967970wrt.48.2022.08.25.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:05:25 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc:     Sagar Kadam <sagar.kadam@sifive.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@atishpatra.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add a PolarFire SoC l2 compatible
Date:   Thu, 25 Aug 2022 19:04:16 +0100
Message-Id: <20220825180417.1259360-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
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

Whilst re-running checks before sending my dt-fixes PR today I noticed
that I had introduced another dtbs_check warning by applying one of the
patches in it.

PolarFire SoC has 4 cache interrupts, unlike the fu540 (which the dts
re-uses the compatible of currently) which only has 3. Add a new string
to the binding like should've been done in the first place...

The driver does not care which compatible it matches against, and just
uses as many interrupts as are in the dts so will happily work away
without any needed changes there.

@Palmer, you can take this directly as long as my fixes PR for rc3 is
merged if you like, since the application path for the binding is via
you anyway. I suppose I could take both too, but whatever works best
for you (:

Thanks,
Conor.

Conor Dooley (2):
  dt-bindings: riscv: sifive-l2: add a PolarFire SoC compatible
  riscv: dts: microchip: use an mpfs specific l2 compatible

 .../bindings/riscv/sifive-l2-cache.yaml       | 79 ++++++++++++-------
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  2 +-
 2 files changed, 50 insertions(+), 31 deletions(-)

-- 
2.37.1

