Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA352AB41
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352387AbiEQSx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245048AbiEQSx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:53:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2EB4D9F3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF4E6145E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E981C385B8;
        Tue, 17 May 2022 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652813604;
        bh=30bwI04Mfd+WHyRtaC9/dHrxj9ZJ1vDpxbC6SXTuArM=;
        h=From:To:Cc:Subject:Date:From;
        b=ViZxlk2oP9X2+pd1GYvHwFkTyQsN4T/eSndGxXWag0ldygf5NWqIu4FDJK6MT3Lat
         01la7yF+ab+Q7i/vSfVHl2RzgzVmUvPXY8UgRGUZcjW8uiM30SHIrmIpAJ8fQt9OIR
         xAOU6iPFasa+IORG1IJCM9MquWTImpMIn3FkEc9qZk8vlodYoBoq8ZOzKS6/iAnPs+
         9DmDsahX7LgrZ4Sll9GUzmM08ZFRaNmYxdIjVEArVYAGjzJKPAGN+8hKUzVvNVvDb+
         RATa1oWQ1NJKWQTZ7znU7nFjWXsdwp93KkioiY/CFc+YC1A0M/gDKclwbIA0HBTzWN
         QOaJWCuYXXz9g==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] introduce unified static key mechanism for ISA ext
Date:   Wed, 18 May 2022 02:44:51 +0800
Message-Id: <20220517184453.3558-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, riscv has several extensions which may not be supported on all
riscv platforms, for example, FPU and so on. To support unified kernel
Image style, we need to check whether the feature is suportted or not.
If the check sits at hot code path, the performance will be impacted a
lot. static key can be used to solve the issue. In the past, FPU
support has been converted to use static key mechanism. I believe we
will have similar cases in the future.

Jisheng Zhang (2):
  riscv: introduce unified static key mechanism for ISA extensions
  riscv: switch has_fpu() to the unified static key mechanism

 arch/riscv/include/asm/hwcap.h     | 40 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  5 ++--
 arch/riscv/kernel/cpufeature.c     | 14 +++++------
 3 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.34.1

