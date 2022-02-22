Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8982F4C05AB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiBWAAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiBWAAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:00:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65C02654;
        Tue, 22 Feb 2022 15:59:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3183261227;
        Tue, 22 Feb 2022 23:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E00C340E8;
        Tue, 22 Feb 2022 23:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645574384;
        bh=nKpRT4I7rBEMlNQ22UrRDmjM7DxTxcBYObIPyBwFRvU=;
        h=From:To:Cc:Subject:Date:From;
        b=DvLA8wUdq6tbNOhUPBnoxDc5JxsShl+RuYsIlvsAcsZx0LantEzAp7zNl+tL0PP0X
         49HTNa9OPZI7azPwY8HeLd08Fub8Hs3L8dZHfo1EdI5TfExKi2llU2ezwi92xfmuLr
         F0JZuYktur1iLAzbviH/YJrC50m5y6RuMtmRzadJKV5p38o8GyceR88yzwAxaZV8Ce
         Tr1VuEXDinn3gGYXl0ovsUrg9qhB05KmypKa2sGZlXYhf/zGWZ1Nx8OQPuO44oZZ2N
         kp3KPfQaVyAHjZLNnUdr9W5TLAGz/fZjQRidOShZRWsypF0FOC/aIrObpIrhBr2rja
         gN7KuJUXSoQBg==
From:   broonie@kernel.org
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Dave Anglin <dave.anglin@bell.net>, Helge Deller <deller@gmx.de>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: linux-next: manual merge of the maple tree with the parisc tree
Date:   Tue, 22 Feb 2022 23:59:39 +0000
Message-Id: <20220222235939.906617-1-broonie@kernel.org>
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

Today's linux-next merge of the maple tree got a conflict in:

  arch/parisc/kernel/cache.c

between commit:

  389f36b709496 ("parisc: Add vDSO support")

from the parisc tree and commit:

  57723d1d4d3fc ("parisc: Remove mmap linked list from cache handling")

from the maple tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/parisc/kernel/cache.c
index e7b8e74dad8e1,c3a8d29b6f9fe..0000000000000
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@@ -582,8 -585,8 +585,8 @@@ void flush_cache_mm(struct mm_struct *m
  	}
  
  	preempt_disable();
 -	if (mm->context == mfsp(3)) {
 +	if (mm->context.space_id == mfsp(3)) {
- 		for (vma = mm->mmap; vma; vma = vma->vm_next)
+ 		for_each_vma(vmi, vma)
  			flush_user_cache_tlb(vma, vma->vm_start, vma->vm_end);
  		preempt_enable();
  		return;
