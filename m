Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F44A0089
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344130AbiA1S7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:59:30 -0500
Received: from relay035.a.hostedemail.com ([64.99.140.35]:61256 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231216AbiA1S72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:59:28 -0500
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id A019B60747;
        Fri, 28 Jan 2022 18:59:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id B58B91A;
        Fri, 28 Jan 2022 18:58:53 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] checkpatch: Prefer MODULE_LICENSE("GPL") over MODULE_LICENSE("GPL v2")
Date:   Fri, 28 Jan 2022 10:59:23 -0800
Message-Id: <20220128185924.80137-1-joe@perches.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B58B91A
X-Spam-Status: No, score=3.56
X-Stat-Signature: wdnc9aun5eye7t1ri3cm8tn5ij33p8ax
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19I1ZfyfjPE3rqMKkJ3mgUCIgcenWmETts=
X-HE-Tag: 1643396333-409670
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no effective difference.

Given the large number of uses of "GPL v2", emit this message only for
patches as a trivial treeside sed could be done one day.

Ref: commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b01c36a15d9dd..b7c181ea0ac56 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7418,6 +7418,13 @@ sub process {
 				WARN("MODULE_LICENSE",
 				     "unknown module license " . $extracted_string . "\n" . $herecurr);
 			}
+			if (!$file && $extracted_string eq '"GPL v2"') {
+				if (WARN("MODULE_LICENSE",
+				     "Prefer \"GPL\" over \"GPL v2\" - see commit bf7fbeeae6db (\"module: Cure the MODULE_LICENSE \"GPL\" vs. \"GPL v2\" bogosity\")\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/\bMODULE_LICENSE\s*\(\s*"GPL v2"\s*\)/MODULE_LICENSE("GPL")/;
+				}
+			}
 		}
 
 # check for sysctl duplicate constants
-- 
2.30.0

