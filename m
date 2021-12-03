Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79490467158
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbhLCFNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:13:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57672 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhLCFNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:13:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E3FD6291A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB5FC53FC7;
        Fri,  3 Dec 2021 05:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638508229;
        bh=jLlTWUTQ9GYidPvwONo4OapaRUlzHVk8UiPiCkgeH7w=;
        h=From:To:Cc:Subject:Date:From;
        b=iVeLqwb14QL9XacqB6MxMmaCmEBZWFdCfeO2VivuEZthVhgZnl7CfwaJW4t72D6EU
         MpKil8OMJ2feo5iFxATHzPsqdu5KzROu0ic9p3PiToMkNm+OlPDS8sDQHhsnNbYLqJ
         VjsQrzoOVjK6fM38lY97huPNXf8ujoP+R0qMxekfIWW2T01HVfDKmGW/RcTnKee7eY
         3q+VFCCQ/loUT8V18ByRswqb4sXSygGsBDG+DZ3JsQECORX2q87d7PGfFgDC9JWY5c
         uDV4KunmN3hDnDbYFWbCcV/ZxJR2iipNsTlrm/Z6/NgcVZun0wClh9K8bIxvlcha2e
         DTpCq99mTCGyQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] riscv: mm: init clean up #ifdefs
Date:   Fri,  3 Dec 2021 13:03:12 +0800
Message-Id: <20211203050317.2102-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support NOMMU, XIP, the arch/riscv/mm/init.c becomes much complex
due to lots of #ifdefs, this not only impacts the code readability,
compile coverage, but may also bring bug. For example, I believe one
recently fixed bug[1] is caused by this issue when merging.

This series tries to clean up unnecessary #ifdefs as much as possible.
Further cleanups may need to refactor the XIP code as Alexandre's patch
does.

[1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/010607.html

Jisheng Zhang (5):
  riscv: mm: init: remove unnecessary "#ifdef CONFIG_CRASH_DUMP"
  riscv: mm: init: try IS_ENABLED(CONFIG_64BIT) instead of #ifdef
  riscv: mm: init: remove _pt_ops and use pt_ops directly
  riscv: mm: init: try IS_ENABLED(CONFIG_XIP_KERNEL) instead of #ifdef
  riscv: mm: init: try best to remove #ifdef CONFIG_XIP_KERNEL usage

 arch/riscv/mm/init.c | 71 +++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 43 deletions(-)

-- 
2.34.1

