Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7175B5882FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiHBULe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHBULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:11:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB044FD39;
        Tue,  2 Aug 2022 13:11:30 -0700 (PDT)
Date:   Tue, 02 Aug 2022 20:11:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659471089;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30l/G2OftEuc9xAsmIsf/rQ3/w2aA97NhlrRZOnGOFM=;
        b=RHmlfRd3i0T05ME4j0+VFvH80apYhWw7WenjBOx7zhxL4/A7trkbfuBYhLirnuYLr2N+yx
        i4sYRjoBSV89QeN6KYhs+qPc8z4twXxXfl288rDzuuM5CXebI8aFvsNjCph9FuePxcdm0i
        MbNMIMcFnkTcP/ErJpFyu2pxC6sPcE2sqQ1wrP5//nGjBEa2KULJpqmZMkcc61Bajzp72u
        TtfuKLoHouIPDVsFriIqjTH15EK3QFq/+TVNGNDQuh+ztQ1ToapS5FvcJ0268IU7Z38BP8
        ZyLPvPZaAZnI4t74ENW1FckGyctcXxQJ6LYhJ3gLon5nmanTr/aOUsrLyUwufg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659471089;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30l/G2OftEuc9xAsmIsf/rQ3/w2aA97NhlrRZOnGOFM=;
        b=Y8KB7L1wBo6mvCU7SDYNLgQ1kaQfjfgHxizojzfh2Ok5eNhYlmtoiBuTa8Tg7rJYLFR5R0
        nEUAfyxw59bl6FBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] scripts/faddr2line: Add CONFIG_DEBUG_INFO check
Cc:     John Garry <john.garry@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ffa7734c929445caa374bf9e68078300174f09b4.1658426357.git.jpoimboe@kernel.org>
References: <ffa7734c929445caa374bf9e68078300174f09b4.1658426357.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <165947108802.15455.111004551670168325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a41a2e2e34a907bd8979a53c58f44287630616e8
Gitweb:        https://git.kernel.org/tip/a41a2e2e34a907bd8979a53c58f44287630616e8
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 21 Jul 2022 11:01:24 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Aug 2022 22:08:17 +02:00

scripts/faddr2line: Add CONFIG_DEBUG_INFO check

Otherwise without DWARF it spits out gibberish and gives no indication
of what the problem is.

Suggested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/ffa7734c929445caa374bf9e68078300174f09b4.1658426357.git.jpoimboe@kernel.org
---
 scripts/faddr2line | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 5709968..5514c23 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -61,6 +61,7 @@ die() {
 READELF="${CROSS_COMPILE:-}readelf"
 ADDR2LINE="${CROSS_COMPILE:-}addr2line"
 AWK="awk"
+GREP="grep"
 
 command -v ${AWK} >/dev/null 2>&1 || die "${AWK} isn't installed"
 command -v ${READELF} >/dev/null 2>&1 || die "${READELF} isn't installed"
@@ -271,6 +272,8 @@ LIST=0
 [[ ! -f $objfile ]] && die "can't find objfile $objfile"
 shift
 
+${READELF} --section-headers --wide $objfile | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
+
 DIR_PREFIX=supercalifragilisticexpialidocious
 find_dir_prefix $objfile
 
