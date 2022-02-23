Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AAF4C065B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiBWAqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiBWAp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:45:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC9236141;
        Tue, 22 Feb 2022 16:45:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B638612A8;
        Wed, 23 Feb 2022 00:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FC6C340E8;
        Wed, 23 Feb 2022 00:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645577131;
        bh=RJnrtn01GXABRz5N65+mxWouMCgo+wRBBxG3o2o73i8=;
        h=From:To:Cc:Subject:Date:From;
        b=RkNxJtXdWNxtaaQ3dGwV4O0TDYQMWZ54ydCsyN6DwyGso5l/4iIRUVWXaTiMQPNQX
         ADJCD7SLxk/iumThjjr1Fmxgqu24QPElWeuB3NIMVwuPROg6rWesfHU23nFzOvRq3+
         4LLVWVyb8MqB2sswlT1/Vj3Ze3LgVloTy82FSkSeutIchG5oD8ru4Isw5GvVqDUiEP
         lTTc+DKCnlR5ceFb5ci4acRNfjFs9//n0BoLIBgOb03kr9WOFX1wmVLhZO41k9Ingq
         ItIL8TiR/JQ3IHY0B2tW4ptr4Q7cjm9OYJVTOecdiLIvNVBlOuDEoZwuiO1UD0rZbA
         +QCzejmVpPq6w==
From:   broonie@kernel.org
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: linux-next: build failure after merge of the maple tree
Date:   Wed, 23 Feb 2022 00:45:25 +0000
Message-Id: <20220223004525.2034065-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the maple tree, today's linux-next build (KCONFIG_NAME)
failed like this:

/tmp/next/build/arch/arm64/kernel/elfcore.c: In function 'elf_core_extra_phdrs':
/tmp/next/build/arch/arm64/kernel/elfcore.c:13:21: error: 'struct mm_struct' has no member named 'mmap'
   13 |   for (vma = tsk->mm->mmap; vma; vma = vma->vm_next) \
      |                     ^~
/tmp/next/build/arch/arm64/kernel/elfcore.c:69:2: note: in expansion of macro 'for_each_mte_vma'
   69 |  for_each_mte_vma(current, vma)
      |  ^~~~~~~~~~~~~~~~
/tmp/next/build/arch/arm64/kernel/elfcore.c:13:43: error: 'struct vm_area_struct' has no member named 'vm_next'
   13 |   for (vma = tsk->mm->mmap; vma; vma = vma->vm_next) \
      |                                           ^~
/tmp/next/build/arch/arm64/kernel/elfcore.c:69:2: note: in expansion of macro 'for_each_mte_vma'
   69 |  for_each_mte_vma(current, vma)
      |  ^~~~~~~~~~~~~~~~
/tmp/next/build/arch/arm64/kernel/elfcore.c: In function 'elf_core_write_extra_phdrs':
/tmp/next/build/arch/arm64/kernel/elfcore.c:13:21: error: 'struct mm_struct' has no member named 'mmap'
   13 |   for (vma = tsk->mm->mmap; vma; vma = vma->vm_next) \
      |                     ^~
/tmp/next/build/arch/arm64/kernel/elfcore.c:79:2: note: in expansion of macro 'for_each_mte_vma'
   79 |  for_each_mte_vma(current, vma) {
      |  ^~~~~~~~~~~~~~~~
/tmp/next/build/arch/arm64/kernel/elfcore.c:13:43: error: 'struct vm_area_struct' has no member named 'vm_next'
   13 |   for (vma = tsk->mm->mmap; vma; vma = vma->vm_next) \
      |                                           ^~
/tmp/next/build/arch/arm64/kernel/elfcore.c:79:2: note: in expansion of macro 'for_each_mte_vma'
   79 |  for_each_mte_vma(current, vma) {
      |  ^~~~~~~~~~~~~~~~
/tmp/next/build/arch/arm64/kernel/elfcore.c: In function 'elf_core_extra_data_size':
/tmp/next/build/arch/arm64/kernel/elfcore.c:13:21: error: 'struct mm_struct' has no member named 'mmap'
   13 |   for (vma = tsk->mm->mmap; vma; vma = vma->vm_next) \
      |                     ^~
/tmp/next/build/arch/arm64/kernel/elfcore.c:104:2: note: in expansion of macro 'for_each_mte_vma'
  104 |  for_each_mte_vma(current, vma)
      |  ^~~~~~~~~~~~~~~~
/tmp/next/build/arch/arm64/kernel/elfcore.c:13:43: error: 'struct vm_area_struct' has no member named 'vm_next'
   13 |   for (vma = tsk->mm->mmap; vma; vma = vma->vm_next) \
      |                                           ^~
/tmp/next/build/arch/arm64/kernel/elfcore.c:104:2: note: in expansion of macro 'for_each_mte_vma'
  104 |  for_each_mte_vma(current, vma)
      |  ^~~~~~~~~~~~~~~~
/tmp/next/build/arch/arm64/kernel/elfcore.c: In function 'elf_core_write_extra_data':
/tmp/next/build/arch/arm64/kernel/elfcore.c:13:21: error: 'struct mm_struct' has no member named 'mmap'
   13 |   for (vma = tsk->mm->mmap; vma; vma = vma->vm_next) \
      |                     ^~
/tmp/next/build/arch/arm64/kernel/elfcore.c:114:2: note: in expansion of macro 'for_each_mte_vma'
  114 |  for_each_mte_vma(current, vma) {
      |  ^~~~~~~~~~~~~~~~
/tmp/next/build/arch/arm64/kernel/elfcore.c:13:43: error: 'struct vm_area_struct' has no member named 'vm_next'
   13 |   for (vma = tsk->mm->mmap; vma; vma = vma->vm_next) \
      |                                           ^~
/tmp/next/build/arch/arm64/kernel/elfcore.c:114:2: note: in expansion of macro 'for_each_mte_vma'
  114 |  for_each_mte_vma(current, vma) {
      |  ^~~~~~~~~~~~~~~~

I did not identify the commit which triggered this. I have used the
maple tree from 20220217 instead.
