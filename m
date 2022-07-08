Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4856C45A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240123AbiGHUe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbiGHUeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:34:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DDE9CE3D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:33:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f2so26578935wrr.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J7aE5Nbw36y+7KVb892AE4NEYNWfAfYQAkoZmLt8mFw=;
        b=fZBU276Fcxl+YM1cb4rfqdQjDpEA4t7V5dMpP1OBWWH58JiTETtYGW+BhpcP+fWWYp
         3l4Lw5RVRfJBZH+chhoxp0I0PDaILDdV7RCk9g4G4L6/FvxKEeAtAxhWM+qTj3pg/kbm
         WPLGyPfzRX7XZhFQKaIknluxpK6Bou54UXV4kno0mEQeAMQ9FHVBVPvV0P8Y2IOSqDIz
         jXEVgxbx0b2RdkhXNTVpD6oNq2gFLcF/noA9KWAMMaDq8KM708Jgoi5JZ4hmAFdCus/Q
         K9EsM+fW4IqQCnZg4modEg5IplVjH/lxaI9H2MG1vpSVVSpeGR/fapKz0HfvACLYcCgX
         08VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J7aE5Nbw36y+7KVb892AE4NEYNWfAfYQAkoZmLt8mFw=;
        b=13yd8nGbU1REf0mFstwAof/6HCJVcpTAow97EVwyQe4y4RsdIevDmEfXMU+6xYQvry
         JxRuLTZQ4CaFDPThAPRTr5nCUIehcK32jO3i/NTZLZBkDQoVXqSTjmebPRDcVa7Ek5lq
         kLN6gM7pvuwFZ4iuTMCgI3xGyZn8m0kiFG1G3Gf+rDxsd8lFvc+kZ17EtH/hAubM0wYi
         wHWpYpik88+H7JDKo6qMyvNXYr07sOWNAktPJBbNS5Wmbt4IV97zV243MXhNUIQGsMHR
         ClKuwcugkkpU3MmtoNhTsfeUhNzKjJZVRFPv7Q8JOe4ySaJDnDylbrdEgPlzVZJC4WVw
         sutg==
X-Gm-Message-State: AJIora+ywTdhT1tJKswunVRp/dk+JR9KRDeSfnRTUgTmvuo8dRuUyOZ+
        4mBjZKQp70opwlx6yrNtUT2iOQ==
X-Google-Smtp-Source: AGRyM1vvjnkjIO4BJ/3OsUkxWtTWWxiuZDyW8gz8dsIe0ki9rXSxWqa7cMdlqhcr6EBYykIN6uzOxg==
X-Received: by 2002:adf:f1d1:0:b0:21d:7f88:d638 with SMTP id z17-20020adff1d1000000b0021d7f88d638mr5126429wro.586.1657312433655;
        Fri, 08 Jul 2022 13:33:53 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id a3-20020a1cf003000000b0039c8a22554bsm3165034wmb.27.2022.07.08.13.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:33:52 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Fix RISC-V's arch-topology reporting
Date:   Fri,  8 Jul 2022 21:33:41 +0100
Message-Id: <20220708203342.256459-1-mail@conchuod.ie>
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

I only built tested for arm64, so hopefully it is not broken when used.
Testing on both arm64 & !SMP RISC-V would really be appreciated!

For V2, I dropped the idea of doing a RISC-V specific implementation
followed by a move to the generic code & just went for the more straight
forward method of moving to the shared version first. I also dropped the
RFC :)

Thanks,
Conor.

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

