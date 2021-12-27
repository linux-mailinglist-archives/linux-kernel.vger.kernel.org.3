Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC58480375
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhL0Sug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhL0Suf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:50:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E5EC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 10:50:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4581AB81135
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9919FC36AE7;
        Mon, 27 Dec 2021 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640631030;
        bh=UEBD17FGDuU4ThIQePgw7S8Ol/WRekKXKaAadwDlrcI=;
        h=From:To:Cc:Subject:Date:From;
        b=YCoVmuA2gZwehwuJC4cTF6kRKpWMeEgSsAiCicYVC2IcdOT1zKwXNWwPCd4tPdMDc
         9tZSZ2H2NyV6embeg1DuqYYAAWEdbFTwdhIAYBwHQkNXJvjm9pLcx1UjDj41gd+kuw
         FfnxP805UQTOVEJQwpXkAJLb09NBdoCbvN5tZbCZAoqYI8g+Lum3I4v62vVSkRl++v
         inwX9QwagIxnJhVDzI3r8y2Do5zmo1+e+fphf1TBvIIc0L3sM0TqRggIGeKbDD6AVJ
         aOgt8WpTx2exJwSeVRRBJSsDHmaJARqBNSt8ZdnevNId1YgDoW/j8DLr+Rw+EbHlYc
         hcs29Zx175Jhw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Brian Cain <bcain@codeaurora.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/3] Fix build errors with do_exit() to make_task_dead() transition
Date:   Mon, 27 Dec 2021 11:48:48 -0700
Message-Id: <20211227184851.2297759-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

I noticed that ARCH=hexagon defconfig was broken after commit
0e25498f8cd4 ("exit: Add and use make_task_dead.") in -next because of a
typo ("make_dead_task" vs. "make_task_dead") and I saw the same thing
happened for csky and h8300. Feel free to squash these into that change.

Cheers,
Nathan

Nathan Chancellor (3):
  hexagon: Fix function name in die()
  h8300: Fix build errors from do_exit() to make_task_dead() transition
  csky: Fix function name in csky_alignment() and die()

 arch/csky/abiv1/alignment.c | 2 +-
 arch/csky/kernel/traps.c    | 2 +-
 arch/h8300/kernel/traps.c   | 3 ++-
 arch/h8300/mm/fault.c       | 2 +-
 arch/hexagon/kernel/traps.c | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)


base-commit: 329b30af470abd854fd301865f1072fa298cc8d6
-- 
2.34.1

