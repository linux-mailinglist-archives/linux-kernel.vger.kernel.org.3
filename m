Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FA45B040A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiIGMgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIGMgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:36:14 -0400
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCDFB275A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:36:11 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MN1vY0cMMzMqC35;
        Wed,  7 Sep 2022 14:36:09 +0200 (CEST)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MN1vW6p3PzMppZ3;
        Wed,  7 Sep 2022 14:36:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1662554169;
        bh=OfaoBsKpDFqckHovf40Gpkkxx6wVziWuBLb6theEUt8=;
        h=From:To:Cc:Subject:Date:From;
        b=utss6XnT4z+9MgncvQF1+6lz1TxlJrihhFkYVlAH/AqGLtYM7f/grafmdYOwFgXkk
         BoRBAF8p3iCUX4/iRqM+G8kCXoWG3xnF9+gFzILsUzTVwJmpb+QZVQNZwSJZWq8RTP
         CtkqdsvZ/kab/m5H0pCPKseTFEricBwCzwT6lcdw=
From:   Philippe Schenker <dev@pschenker.ch>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH] checkpatch: add check for fixes: tag
Date:   Wed,  7 Sep 2022 14:35:47 +0200
Message-Id: <20220907123547.138646-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

The page about submitting patches in
Documentation/process/submitting-patches.rst is very specific on how that
tag should be formatted: 'Fixes: <12+ chars of sha1> (\"<title line>\")'

Add a rule that warns if this format does not match. This commit is
introduced as in the past commits have been sent multiple times with
having the word commit also in the Fixes: tag which had to be corrected
by the maintainers. [1]

[1] https://lore.kernel.org/all/20220906073746.1f2713f7@canb.auug.org.au/
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..0d7ce0c3801a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3438,6 +3438,13 @@ sub process {
 			}
 		}
 
+# Check fixes tag format
+		if ($in_commit_log && ($line =~ /^\s*Fixes:/i) &&
+			!($line =~ /^\s*Fixes:\s[0-9a-f]{12,40}\s\(\".*\"\)/)) {
+			WARN("FIXES_TAG_FORMAT",
+			     "Possible wrong format on Fixes: tag, please use format Fixes: <12+ chars of sha1> (\"<title line>\")\n" . $herecurr);
+		}
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
2.37.2

