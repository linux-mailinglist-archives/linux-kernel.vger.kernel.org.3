Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE934B754D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbiBOTkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:40:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243704AbiBOTkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:40:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C43DEAD;
        Tue, 15 Feb 2022 11:40:10 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 90E381F37B;
        Tue, 15 Feb 2022 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644954008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8u8PjdIzbfQMtiY3mRFAQedyhueCJjszz6hXjTc8rTk=;
        b=QhW6nE0/GVBRI9VbtCzshznpy+OFGHS5foHg+1++JwkpZ6gkmNLpuXoEgiwI75QdunQq+x
        hcWZVaYOw0tVvhvlXgVP/aJsVObbxIEO7y37h/OGUA1UMCvkXoXtxWesdNtO+Zqso2b/aN
        6dJloNGaWVH4K39c8Q7LBbs9OYOVEKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644954008;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8u8PjdIzbfQMtiY3mRFAQedyhueCJjszz6hXjTc8rTk=;
        b=uzveXHo0tshmF6FfZuSkt3f1rGVMAtsJ6UIRc2nR+GxdRu/kLFcU6JF7mSBO+gZZZ1dAJt
        jMlsOeFsN/jaORAQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 36832A3B85;
        Tue, 15 Feb 2022 19:40:08 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kairui Song <kasong@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 0/4] Unifrom keyring support across architectures and functions
Date:   Tue, 15 Feb 2022 20:39:37 +0100
Message-Id: <cover.1644953683.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing KEXEC_SIG on powerpc I noticed discrepancy in support for
different keyrings across architectures and between KEXEC_SIG and
MODULE_SIG. Fix this by enabling suport for the missing keyrings.

The latter two patches obviously conflict with the ongoing module code
cleanup. If they turn out desirable I will add them to the other series
dealing with KEXEC_SIG.

The arm patches can be merged independently.

Thanks

Michal

Michal Suchanek (4):
  Fix arm64 kexec forbidding kernels signed with keys in the secondary
    keyring to boot
  kexec, KEYS, arm64: Make use of platform keyring for signature
    verification
  kexec, KEYS, s390: Make use of built-in and secondary keyring for
    signature verification
  module, KEYS: Make use of platform keyring for signature verification

 arch/arm64/kernel/kexec_image.c       | 13 +++++++++++--
 arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
 kernel/module_signing.c               | 14 ++++++++++----
 3 files changed, 34 insertions(+), 11 deletions(-)

-- 
2.31.1

