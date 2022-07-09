Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B91356CA54
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiGIPYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:24:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37CA12D31
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:24:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r14so1873479wrg.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RlYEDG/Aq6CKRcdir+VJjOvlvPk+ZQG3YqkRE4NjZeM=;
        b=NyOtj2BiWZbts+G7i2cImegn1yuZO+butLRR01SJffpGEu4A3kPGjnnim7079L1lZ7
         9MmCXtqJAN2zbiRsdivXlvRtJHn3HfLKix6IskPoSYjcrFMgfN8/oXjSugzoDfkje4QK
         YuQernyWi8KynWB0PCNdbfda7w1b0j/SQywtrv7gyL1DBzCSbOdptzQxxn38XrsikdBF
         qZbS1HpxuVea9GxpcMAZZW7WQadg3drzAN0V1CMiCBmzbAXcuN7Bxm2uIQtryEaYe1Av
         F2GDuXBE5ZIQqBZDQarTaPHaP5U9n7KjDL/HlOjgICzq5kOjj7eBX0gAxNbW7TmKas4X
         2maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RlYEDG/Aq6CKRcdir+VJjOvlvPk+ZQG3YqkRE4NjZeM=;
        b=z5bsUGyK+72cKq0wrZL7Wyrneyg7SOdMA+ChDMjW8HqXwP0ISmBDsHOufiZtoYz1ry
         gfgDQs0BAHhvYFaMAa/R0/i8hC91j2EEbbhze6jixW+mzCdF+CmptkBJGXkPocRFas28
         r5zA9e88e7RfPI401S31MJFJXIRJZE5g80pjn5czSBAdJbJOO4VJ29Ec4iQM9r7MDXf+
         wqrxmfWNe6fQUlx0zKj95iZaf3fK9TFk3eHxCaB2rTuIz0LJ035BTe2N+I8SMAGPqisb
         Yb3H1WQs5a9cZX+DOfYviImzuUqw/GS+fqHxpAm0T78yCphZU1AMpIp54WpA4QMVm24O
         MrhQ==
X-Gm-Message-State: AJIora+IvUh88uJTuGWO2TNonp46qkSXwVGWIEbr8Q6ls5LyVAdBmNiy
        xQQPWMfNPI5tOHGR15VjNmMfZQ==
X-Google-Smtp-Source: AGRyM1tieCoHD9A7Yw7K0uvcAi59jSz2pwdtWc11EeCwXaSND7420PDrYPfA1NC3F8HHXEgUzVMP3w==
X-Received: by 2002:a05:6000:154c:b0:21c:65c8:2ef with SMTP id 12-20020a056000154c00b0021c65c802efmr8531726wry.473.1657380279147;
        Sat, 09 Jul 2022 08:24:39 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d620c000000b0021d63fe0f03sm1626730wru.12.2022.07.09.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:24:38 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Fix RISC-V's arch-topology reporting
Date:   Sat,  9 Jul 2022 16:23:53 +0100
Message-Id: <20220709152354.2856586-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

V3 moves store_cpu_topology() down inside the arch check alongside the
init function so that boot on 32bit arm is not broken.

Thanks,
Conor

Conor Dooley (2):
  arm64: topology: move store_cpu_topology() to shared code
  riscv: topology: fix default topology reporting

 arch/arm64/kernel/topology.c | 40 ------------------------------------
 arch/riscv/Kconfig           |  2 +-
 arch/riscv/kernel/smpboot.c  |  4 +++-
 drivers/base/arch_topology.c | 19 +++++++++++++++++
 4 files changed, 23 insertions(+), 42 deletions(-)


base-commit: b6f1f2fa2bddd69ff46a190b8120bd440fd50563
-- 
2.37.0

