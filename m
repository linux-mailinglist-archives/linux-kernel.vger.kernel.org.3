Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A14576663
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiGORxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiGORxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:53:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA494FF9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:53:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z12so7738352wrq.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7FdqtQskr0feGEMESNye0rnehyoWZm9I2IR2qQbWhw=;
        b=JXY9tG2WRrIfIGRKFohwcnYsUQVcSdNBZ0QIGMlDIRqOWRYIzyrwhMfXSxiZolGhlz
         UWrxE1UeKpDBH5S9j/w3Oe0wOc0gaEMnZoj8v6PyId4PI0r0rxgKn5Tztce2L/BFxYIl
         MBrrLnvciZ/KnPWkPpgpubUUVfrvJA2VXNl1ur33S/pN3jhfrvHYwkLphcBcOzXm5UOB
         kbQeKNF63/K44eKvMFOwEhd1+uvrrkhzcGjfSf8Gk2QY7QPBm+WPHbyAAfSCMS+eCOiW
         swSCRO0Fu0G0IgVCoEP3escuvfEGpga6GeL3RBEFg1OGRftF39s4qfhdXMgBJ3AAxocU
         dLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7FdqtQskr0feGEMESNye0rnehyoWZm9I2IR2qQbWhw=;
        b=FHObFp07w2mQVrjF3/KoazmRmYgfsQSkxI1N7qTFmOWNf5Kal+JX1hmxQf5jq6qcEc
         65r5Eu+yP16OTRzD93GQDD7Ou4Hn14PKSiYCSsHrLI3PW+XnzeYn4Lab2pgmwDBZ/hth
         Kt60Rc/SAzMTYoJuUAa1djCnuO6r1AUBwCNHkaZwXcDca13dVdaAV0md9PHT5j6gaGRc
         RpXmxhuDmDSYE04RsEQ+E6oYZivsXAl+I2YEund7JlZntA+6K1WiMlmtSAuRKhBVHGTm
         DjrWwp8N1zzHc2BZ+jE3bkg/YjrvrPiiztB6ivPDVVCMVKX/gCdA5OW1G+SMAx5QZZSZ
         rTkA==
X-Gm-Message-State: AJIora8IHmNhxhrzWJhnIdbew5OSUVHEtM6MMhtWYoWs/TYeSulr4du5
        VQ8UCbqkv7YaMGMGwlLWQbXwjQ==
X-Google-Smtp-Source: AGRyM1vAaj7pVFqqnelORFYKWYhdT3B3rL63PBVd14yEq7ucjnt/2MVUoT9Qyfj1fcyeS3ao5/kSog==
X-Received: by 2002:a5d:6c63:0:b0:21d:bf45:f90f with SMTP id r3-20020a5d6c63000000b0021dbf45f90fmr11182223wrz.715.1657907618412;
        Fri, 15 Jul 2022 10:53:38 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d4c49000000b002167efdd549sm4364131wrt.38.2022.07.15.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 10:53:37 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: [PATCH v4 0/2] Fix RISC-V's arch-topology reporting
Date:   Fri, 15 Jul 2022 18:51:54 +0100
Message-Id: <20220715175155.3567243-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Hey all,
It's my first time messing around with arch/ code at all, let alone
more than one arch, so forgive me if I have screwed up how to do a
migration like this.

The goal here is the fix the incorrectly reported arch topology on
RISC-V which seems to have been broken since it was added.
cpu, package and thread IDs are all currently reported as -1, so tools
like lstopo think systems have multiple threads on the same core when
this is not true:
https://github.com/open-mpi/hwloc/issues/536

arm64's topology code basically applies to RISC-V too, so it has been
made generic along with the removal of MPIDR related code, which
appears to be redudant code since '3102bc0e6ac7 ("arm64: topology: Stop
using MPIDR for topology information")' replaced the code that actually
interacted with MPIDR with default values.

I only built tested for arm{,64} , so hopefully it is not broken when
used. Testing on both arm64 & !SMP RISC-V would really be appreciated!

For V2, I dropped the idea of doing a RISC-V specific implementation
followed by a move to the generic code & just went for the more straight
forward method of moving to the shared version first. I also dropped the
RFC.

V3 moves store_cpu_topology()'s definition down inside the arch check
alongside the init function so that boot on 32bit arm is not broken.

V4 has moved the RISC-V boot hart's call to store_cpu_topology() later
into the boot process it is now right before SMP is brought up (or not
in the case of !SMP). This prevents calling detect_cache_attributes()
while we cannot allocate memory.

V4 is also rebased on next-20220715 to get Sudeep's most recent
arch_topology patchset.

Thanks,
Conor

Conor Dooley (2):
  arm64: topology: move store_cpu_topology() to shared code
  riscv: topology: fix default topology reporting

 arch/arm64/kernel/topology.c | 40 ------------------------------------
 arch/riscv/Kconfig           |  2 +-
 arch/riscv/kernel/smpboot.c  |  3 ++-
 drivers/base/arch_topology.c | 19 +++++++++++++++++
 4 files changed, 22 insertions(+), 42 deletions(-)


base-commit: 6014cfa5bf32cf8c5c58b3cfd5ee0e1542c8a825
-- 
2.37.1

