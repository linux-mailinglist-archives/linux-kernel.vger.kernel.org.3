Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F8C4AAD90
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 03:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiBFCiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 21:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBFCit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 21:38:49 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD444C043186
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 18:38:48 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 595B592;
        Sun,  6 Feb 2022 03:38:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5AZt1-6-iP0a; Sun,  6 Feb 2022 03:38:46 +0100 (CET)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 92E42203;
        Sun,  6 Feb 2022 03:38:46 +0100 (CET)
Received: from samy by begin with local (Exim 4.95)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1nGXRt-000Gzf-LC;
        Sun, 06 Feb 2022 03:38:45 +0100
Date:   Sun, 6 Feb 2022 03:38:45 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH] speakup_audptr: cleanup synth_version
Message-ID: <20220206023845.bpzxtjohekclffra@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: /
Authentication-Results: hera.aquilenet.fr;
        none
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: 595B592
X-Spamd-Result: default: False [0.40 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_LAST(0.00)[];
         TO_DN_NONE(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_THREE(0.00)[3]
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer was bigger than necessary, and the while loop not very
canonical. Also better use i as variable name for an index.

Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 .../accessibility/speakup/speakup_audptr.c    | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_audptr.c b/drivers/accessibility/speakup/speakup_audptr.c
index e89fd72..a0c3b8a 100644
--- a/drivers/accessibility/speakup/speakup_audptr.c
+++ b/drivers/accessibility/speakup/speakup_audptr.c
@@ -126,20 +126,22 @@ static void synth_flush(struct spk_synth *synth)
 
 static void synth_version(struct spk_synth *synth)
 {
-	unsigned char test = 0;
-	char synth_id[40] = "";
+	unsigned i;
+	char synth_id[33];
 
 	synth->synth_immediate(synth, "\x05[Q]");
-	synth_id[test] = synth->io_ops->synth_in(synth);
-	if (synth_id[test] == 'A') {
-		do {
-			/* read version string from synth */
-			synth_id[++test] = synth->io_ops->synth_in(synth);
-		} while (synth_id[test] != '\n' && test < 32);
-		synth_id[++test] = 0x00;
+	synth_id[0] = synth->io_ops->synth_in(synth);
+	if (synth_id[0] != 'A')
+		return;
+
+	for (i = 1; i < sizeof(synth_id) - 1; i++) {
+		/* read version string from synth */
+		synth_id[i] = synth->io_ops->synth_in(synth);
+		if (synth_id[i] == '\n')
+			break;
 	}
-	if (synth_id[0] == 'A')
-		pr_info("%s version: %s", synth->long_name, synth_id);
+	synth_id[i] = '\0';
+	pr_info("%s version: %s", synth->long_name, synth_id);
 }
 
 static int synth_probe(struct spk_synth *synth)
-- 
2.34.1

