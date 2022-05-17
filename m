Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09D052AE04
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiEQWWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiEQWWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:22:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742B52A70E;
        Tue, 17 May 2022 15:21:59 -0700 (PDT)
Date:   Tue, 17 May 2022 22:21:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652826117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arzPXTtG/tZ+5GyS91SjFMeM3hEfP+ttmTLbHmJzI8Q=;
        b=iWgaW+a2IUWJlgfoVTrhJCFq88+UnLtYxDKfBE4KF7vaJ24etgnpVPyze2dtMPWscFqoN9
        U80fG8hNmqs0xYF63V5K9p32ABXX/OVXFr/CthOnlC6CU4j52z+SG8boM79UK0O2LPww4Q
        IrG++yxkt7JBi7i7g3elNLTKZIncWSuk9tMwVCOUwwV2pIFZJT7lDnbCeeNO6h/u1rZ9p4
        1fVHtfm5E4sdtQioF0OjZLvomBf/sZOsabIe0KNeyX6VWAcMJWRgIIGpGFWAzq6QmxaMcO
        iJQqwFHIM94433vavVNXEYssBO1a/C7tCIpIatf1FX0Lpiyblkm6CIw8rrWvWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652826117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arzPXTtG/tZ+5GyS91SjFMeM3hEfP+ttmTLbHmJzI8Q=;
        b=JLPaFuxZk7hfHCcT/XWOBoMFHNOZaVhHzLaBXCJTzzO2pFZ8C2st9hTuDMgO+51zd2Wg97
        uymy28BKzj4vV1DQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scripts: Create objdump-func helper script
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3eb3f091fd6bd9caba50392ceab98ce756804f3b.1650578171.git.jpoimboe@redhat.com>
References: <3eb3f091fd6bd9caba50392ceab98ce756804f3b.1650578171.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165282611567.4207.330892093136670864.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     21e350233b07619dbfc3ce606ff1fc468fce2d82
Gitweb:        https://git.kernel.org/tip/21e350233b07619dbfc3ce606ff1fc468fce2d82
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Thu, 21 Apr 2022 14:56:55 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 12 May 2022 10:08:43 -07:00

scripts: Create objdump-func helper script

Add a simple script which disassembles a single function from an object
file.  Comes in handy for objtool warnings and kernel stack traces.

Originally-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/3eb3f091fd6bd9caba50392ceab98ce756804f3b.1650578171.git.jpoimboe@redhat.com
---
 scripts/objdump-func | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 scripts/objdump-func

diff --git a/scripts/objdump-func b/scripts/objdump-func
new file mode 100755
index 0000000..4eb463d
--- /dev/null
+++ b/scripts/objdump-func
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Disassemble a single function.
+#
+# usage: objdump-func <file> <func>
+
+set -o errexit
+set -o nounset
+
+OBJDUMP="${CROSS_COMPILE:-}objdump"
+
+command -v gawk >/dev/null 2>&1 || die "gawk isn't installed"
+
+usage() {
+	echo "usage: objdump-func <file> <func>" >&2
+	exit 1
+}
+
+[[ $# -lt 2 ]] && usage
+
+OBJ=$1; shift
+FUNC=$1; shift
+
+# Secret feature to allow adding extra objdump args at the end
+EXTRA_ARGS=$@
+
+# Note this also matches compiler-added suffixes like ".cold", etc
+${OBJDUMP} -wdr $EXTRA_ARGS $OBJ | gawk -M -v f=$FUNC '/^$/ { P=0; } $0 ~ "<" f "(\\..*)?>:" { P=1; O=strtonum("0x" $1); } { if (P) { o=strtonum("0x" $1); printf("%04x ", o-O); print $0; } }'
