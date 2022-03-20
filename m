Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C174E197C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 03:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbiCTCby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 22:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbiCTCbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 22:31:53 -0400
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5791557FF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 19:30:31 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 61ABA232DC;
        Sun, 20 Mar 2022 02:30:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 82AE220014;
        Sun, 20 Mar 2022 02:30:23 +0000 (UTC)
Message-ID: <86bce3b4176ac83c4d4c82c38bf2e8eac5983b1c.camel@perches.com>
Subject: Re: Checking for space before ending comment tag
From:   Joe Perches <joe@perches.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 19 Mar 2022 19:30:22 -0700
In-Reply-To: <b42be7ee3ed3a2356b7c5ddad545e12d5e7a0ee7.camel@perches.com>
References: <fb2ab099-aefa-6a84-5c62-f0c87eca2725@molgen.mpg.de>
         <b42be7ee3ed3a2356b7c5ddad545e12d5e7a0ee7.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 82AE220014
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: hng6b5ngw881asmt1p6tq1x398rrpwfs
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19jT8NHz9inRLq3I4YcBTn9rK5kBPNYn1U=
X-HE-Tag: 1647743423-579871
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this is better as it can fix them too.

---
 scripts/checkpatch.pl | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 577e029987011..70afa4ff2addf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3868,6 +3868,22 @@ sub process {
 			}
 		}
 
+# Single line comment style - warn when '/*comment */' or '/* comment*/'
+		if ($line =~ /^\+.*$;/ &&
+		    $rawline =~ m@/\*.+\*/@ &&
+		    (($rawline =~ m@/\* @  && $rawline =~ m@\w\*/@) ||
+		     ($rawline =~ m@/\*\w@ && $rawline =~ m@ \*/@))) {
+			if (WARN("COMMENT_STYLE",
+				 "Single line comments should use a space after /* and before */\n" . $herecurr) &&
+			    $fix) {
+				$rawline =~ m@/\*.+\*/@;
+				my $comment = substr($rawline, $-[0], $+[0] - $-[0]);
+				my $newcomment = trim(substr($comment, 2, -2));
+				$fixed[$fixlinenr] =~
+				    s@\Q$comment\E@/\* $newcomment \*/@;
+			}
+		}
+
 # Block comment styles
 # Networking with an initial /*
 		if ($realfile =~ m@^(drivers/net/|net/)@ &&

