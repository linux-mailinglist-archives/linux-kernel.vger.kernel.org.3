Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCE454C656
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348853AbiFOKjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiFOKje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125634F9C7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A24E7612CD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CC0C34115;
        Wed, 15 Jun 2022 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655289573;
        bh=pyjIu3iIZM/bseMBZ8ufZOEAAkS4aIS8mPG/dTsi5Zk=;
        h=From:To:Cc:Subject:Date:From;
        b=uhfe41Ny1D6bU5CAuPWiHKrnMcES27WZ17CwWqapNKbl7sqZ2sGr+xwCEP+PH3HzE
         pc3iuIyYsg5immrdGoGZh5yHDOAdiEAVfLDs0R0zp46lOcE9vd5dexsgIfGZSY5iyG
         /hvCkyHHv5KMOYQB1G557957K0JeMHmlLRuwR22HNlkFr1oY1veAgHHuyJSPIEd9u3
         dqDLDznuYVcPRI+dp29CYCM7VONWMQi4Lj7NC/Dld4s7GtsndN+kVK6vgaQQ/rliPI
         zIQqF5xJ/T4UDJDT6FS7ZqSlZWWAfHxJ/cE273Ju+frj55X2TFSULW5LqOaGD80m2v
         j1KDwGHZmL5RA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs fix for v5.19-rc3
Date:   Wed, 15 Jun 2022 12:37:52 +0200
Message-Id: <20220615103751.2342910-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

/* Summary */
This fixes an issue where we fail to change the group of a file when the caller
owns the file and is a member of the group to change to. This is only relevant
on idmapped mounts. This has originally been reported against [2]. There's a
detailed description in the commit message and regression tests have been added
to xfstests at [1].

Link: https://lore.kernel.org/fstests/20220615092826.2333847-1-brauner@kernel.org [1]
Link: Link: https://github.com/lxc/lxd/issues/10537 [2]

/* Testing */
All patches are based on v5.19-rc1 and have been sitting in linux-next. No
build failures or warnings were observed. The fstests, ltp, and associated
selftests pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.fixes.v5.19-rc3

for you to fetch changes up to 168f912893407a5acb798a4a58613b5f1f98c717:

  fs: account for group membership (2022-06-14 12:18:47 +0200)

Please consider pulling these changes from the signed fs.fixes.v5.19-rc3 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.fixes.v5.19-rc3

----------------------------------------------------------------
Christian Brauner (1):
      fs: account for group membership

 fs/attr.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)
