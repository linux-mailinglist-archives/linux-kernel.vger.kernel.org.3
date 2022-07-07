Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC9256AE16
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiGGWFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiGGWE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:04:58 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963C12C673
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:04:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l68so11422337wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7wEvKldrbzSpzvzf7cF/tBIG4OcicbyZqv1HMnAM6uU=;
        b=I1/2ncRqvqMJy+BGVzbQhxi6htaIzb4VhybmgmPLzthBnhtOWa1dhgLto1BEsgTICP
         AhL5XT89aMYm1DAtXKmKWwE9NBPz1eY4PLcSWiH2q0mJJAmuFjZlwEEz9Y43xPBsUINp
         sR7ZWsa5kDlUPQNe4RjdPPWrjh/FqAF0bf0ektOZ3IjdibERqs9szNiKFFiqJ3qUHKuO
         9YOIl2Rih4qq0W54K/de/mjzekiUFVRWxhN7ISo2MUFJ3Dq9O3BVE9S7FZogDMX/4iUB
         SnhQaaxBQuBfbaRfIgreoD3oo3bWKSwL0QYZC+iRtn9RlCZni3w7odpZ4TwEHyEKzB17
         7mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7wEvKldrbzSpzvzf7cF/tBIG4OcicbyZqv1HMnAM6uU=;
        b=H3iJutEuChvUWEs+0N28N0L3aJ4rOBkpSX/tSxRbaxA8O69EcOsGVFuZKtFTOFOYLV
         FwDvRzl4orwYLdOW2ZEPN7dytn6k1MEPot0loRRfcbzU6dok5SDCQgBhCzjM87uzWM/X
         cFyK3nSmxhANYIG5kE7+46pdhpyWNYF5YPtR8+HqDIvxQVauMv6dM6tgzdq6SX9fMXiF
         M43pdXxnBxwsBT9z8FfdQu2eE7KVuIdK17gFVjqexK1n/oEhXyVxBYQyALHBmnF6FNps
         mnIXl/H1lwX7nlLpHf2q3L8lg+4r6QcYoQ3DRo3IyGS+CG3+avQhCrSjtl1105X6XvZr
         sEew==
X-Gm-Message-State: AJIora9b5M1e/CGvb5nF018WxYRo3dRb19xCCz5EvLpcBEvGO4wqd5Uo
        9cBZL2y/MtlMdN51/wS8By5KNw==
X-Google-Smtp-Source: AGRyM1stTlaaZ8PDLMgVyLk3b3v8YtrUwDb/ZvBcVWXgdsJfv7RfAopcWzGfUfqfzcky8NyVUR+nfA==
X-Received: by 2002:a05:600c:1d03:b0:3a1:7ab1:8dc6 with SMTP id l3-20020a05600c1d0300b003a17ab18dc6mr6641236wms.103.1657231496073;
        Thu, 07 Jul 2022 15:04:56 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id bn24-20020a056000061800b0020fe35aec4bsm38625743wrb.70.2022.07.07.15.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:04:55 -0700 (PDT)
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
        Changbin Du <changbin.du@intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: [PATCH/RFC 0/4] Fix RISC-V's arch-topology reporting
Date:   Thu,  7 Jul 2022 23:04:33 +0100
Message-Id: <20220707220436.4105443-1-mail@conchuod.ie>
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

Because I want to backport that fix, I implemented store_cpu_topology
for RISC-V before migrating to the generic version which seems to have
just complicated things, but was Sudeep's preferred way of doing it.

Palmer, I have not marked the first patch as RFC because I would like
it to be taken as a fix for 5.19-rc(late) independently of the rest if
possible.

The rest of the series is RFC b/c I don't know what I am doing ;)

I only built tested for arm64, so hopefully it is not broken when used.

Thanks,
Conor.

Conor Dooley (4):
  riscv: arch-topology: fix default topology reporting
  arch-topology: add a default implementation of store_cpu_topology()
  riscv: arch-topology: move riscv to the generic store_cpu_topology()
  arm64: arch-topology move arm64 to the generic store_cpu_topology()

 arch/arm64/kernel/smp.c       | 16 ++++++++++++--
 arch/arm64/kernel/topology.c  | 40 -----------------------------------
 arch/riscv/Kconfig            |  2 +-
 arch/riscv/kernel/smpboot.c   |  4 +++-
 drivers/base/arch_topology.c  | 19 +++++++++++++++++
 include/linux/arch_topology.h |  1 +
 6 files changed, 38 insertions(+), 44 deletions(-)


base-commit: b6f1f2fa2bddd69ff46a190b8120bd440fd50563
-- 
2.37.0

