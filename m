Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F83469D1F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbhLFP2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356261AbhLFPRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:17:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7825EC08C5D9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:11:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 130076132C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F0EC341C5;
        Mon,  6 Dec 2021 15:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638803465;
        bh=qfmITF7f/5VRc/TWy5vem0/292bk80Zd+3Le10rukNA=;
        h=From:To:Cc:Subject:Date:From;
        b=V0sOT6+Bl8qa7Rg0yXZi3VBmyjK4EBAPsgSl4BF8nI0GVIQQwgNVAUp8FHWesgvfk
         ra/mLRT0lmfTcZKCpm8KywmtoM6aq5RCx6KsbhhmauaA+81DuyNKTqSm51gthD/zud
         SFJv3ixxTzePOJ6iUyF7LxrFRXsDMGSJL1dy110GTFpFG6J1An85/+bL9NuYAb0UlD
         6oEsK64rOGP7OXMyNRt3dAiHXTFxEPC2CkhqwueviEU3rvzOdmgdBAA4G4h6aLyn7V
         AytonzkgIx1VOKppxD+uWYJzG9TIZk8poELwPbEsIA7uvqHxrJXmO8U1ZBIlCJyBeR
         mMz9cndzoL4OA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] riscv: mm: init clean up #ifdefs
Date:   Mon,  6 Dec 2021 23:03:48 +0800
Message-Id: <20211206150353.731-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support NOMMU, XIP, the arch/riscv/mm/init.c becomes much complex
due to lots of #ifdefs, this not only impacts the code readability,
compile coverage, but may also bring bugs. For example, I believe one
recently fixed bug[1] is caused by this issue when merging.

This series tries to clean up unnecessary #ifdefs as much as possible.

Further cleanups may need to refactor the XIP code as Alexandre's patch
does.

[1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/010607.html


Since v1:
 - collect Reviewed-by tag.
 - remove the __maybe_unused used in max_mapped_addr declaration.
 - remove the BUG_ON check of mapping the last 4K bytes of the
   addressable memory since "this is true for every kernel actually"
   as pointed out by Alexandre.

Jisheng Zhang (5):
  riscv: mm: init: remove unnecessary "#ifdef CONFIG_CRASH_DUMP"
  riscv: mm: init: try best to use IS_ENABLED(CONFIG_64BIT) instead of
    #ifdef
  riscv: mm: init: remove _pt_ops and use pt_ops directly
  riscv: mm: init: try IS_ENABLED(CONFIG_XIP_KERNEL) instead of #ifdef
  riscv: mm: init: try best to remove #ifdef CONFIG_XIP_KERNEL usage

 arch/riscv/mm/init.c | 76 ++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 49 deletions(-)

-- 
2.34.1

