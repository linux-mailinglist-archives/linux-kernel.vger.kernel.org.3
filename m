Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFAA57790B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 02:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiGRAl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 20:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRAlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 20:41:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6E013D14;
        Sun, 17 Jul 2022 17:41:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 5so7693277plk.9;
        Sun, 17 Jul 2022 17:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9cFK95jUJ/VEHOa/R8FTtdnRjPaJWSBWfAQkMz6g64=;
        b=gfzCKqBjbDBR8zsSfs57EcWDuLzHUloNR32b4bZWlu7m3tVcsDsSrF6WVpARw2GbYy
         6mQCTWmFrIgEUEhv1x46fmN2FoDnRT5YM/vhynbFe1lP685xTFuUn2k8H2E42ltbfZw+
         pCJ3vqcB6hYabbj43d4qHHR/Q2VMIRUBRWU3iEWlAHC4ti5h54l/2EQI3dKZbqYA4jLe
         33p6ZhtGkHVV6pxD2IOcdNZahAFjzEdVct8Y/PgBDqDwowLPYwmYsNKpxsbQ5F/BoQMX
         BdAtU+ICy4+n+xOSK5p/3S5cI5abd4xA4Wle52EeqaGBVrD605yWNUMb26VpQ0A4Kh4s
         E7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9cFK95jUJ/VEHOa/R8FTtdnRjPaJWSBWfAQkMz6g64=;
        b=eBV6smEryX1vNIffVYpa2RaiIAK4qi+vwKtzOUOhwlb2FnTkrhpoawLaZB9o0IejOk
         2O9WKiOL09paSYeAs04KL2MOcpw1XGUkO0ZaPgFQC6+rGijCKkXsh63WUbBWA9xvE61Z
         5liyA5NoNDODX97zFwI6pwp+Jlxgx68J2ykDJrDUnJTTQX0ujBU9EIPjr7ghECdZaTVS
         A8utG+qaGB8QhoM2sFkV0MBhWAzeEBCQ7pluljLUNOKBUl3BM2t29Rn/x3gsdrSjLJoF
         PfCYXlY2HF+F3UvnQw21URWk/QKYtKoZi3gH+k1trW8kNmV7pXSGzHyoz0gT8FbYPYRr
         +7oA==
X-Gm-Message-State: AJIora9FjBhr08rqiYso/zdQryNtfDVKB9iAyglT3faZConFcbIM+0Kp
        +5PjDc2Z4HDqTQNpq2QKsESErvBaSYIknA==
X-Google-Smtp-Source: AGRyM1sCUiFZMu5spy7h3aBwSkuHHCzPAj9rfWSz61VtJtlmq1sl10bnEhwEFfaF/9C0SByYzafGgg==
X-Received: by 2002:a17:903:c5:b0:16b:d8d5:5f14 with SMTP id x5-20020a17090300c500b0016bd8d55f14mr25534716plc.18.1658104883939;
        Sun, 17 Jul 2022 17:41:23 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id 64-20020a620443000000b005289a50e4c2sm7842627pfe.23.2022.07.17.17.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 17:41:23 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: [PATCH v3 0/2] Updates for asm-generic/pci.h
Date:   Mon, 18 Jul 2022 09:41:12 +0900
Message-Id: <20220718004114.3925745-1-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the OpenRISC PCI support patch Arnd suggested that
we avoid copying arm64 and riscv asm/pci.h and moving that to be
the new asm-generic/pci.h.

This patch does that by first moving the old pci.h definition
of pci_get_legacy_ide_irq out to the architectures that use it,
this turns out to only be x86.

Next, we create the new pci.h definition.

Note, for the series, I am working on these fixups as part of adding PCI to
OpenRISC.  If the series is accepted I would like to merge via the OpenRISC tree
with the OpenRISC PCI support patches to avoid having to coordinate upstream
merges.

Since v2:
 - Remove pci_get_legacy_ide_irq from m68k.
Since v1:
 - Remove definition of pci_get_legacy_ide_irq on architectures
   not using CONFIG_PNP, which eliminated most.
 - Add ifdef around PCIBIOS_MIN_MEM for consistency.


Stafford Horne (2):
  asm-generic: Remove pci.h copying remaining code to x86
  asm-generic: Add new pci.h and use it

 arch/alpha/include/asm/pci.h   |  1 -
 arch/arm64/include/asm/pci.h   | 12 +++------
 arch/csky/include/asm/pci.h    | 24 +++--------------
 arch/ia64/include/asm/pci.h    |  1 -
 arch/m68k/include/asm/pci.h    |  2 --
 arch/powerpc/include/asm/pci.h |  1 -
 arch/riscv/include/asm/pci.h   | 25 +++---------------
 arch/s390/include/asm/pci.h    |  1 -
 arch/sparc/include/asm/pci.h   |  9 -------
 arch/um/include/asm/pci.h      | 24 ++---------------
 arch/x86/include/asm/pci.h     |  6 +++--
 arch/xtensa/include/asm/pci.h  |  3 ---
 include/asm-generic/pci.h      | 47 ++++++++++++++++++++++++----------
 13 files changed, 49 insertions(+), 107 deletions(-)

-- 
2.36.1

