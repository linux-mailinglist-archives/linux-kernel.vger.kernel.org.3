Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DC4F910D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiDHIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiDHIop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:44:45 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477421A9CAC;
        Fri,  8 Apr 2022 01:42:40 -0700 (PDT)
X-UUID: 9c58a1d6e1d148e189a0b35b5663b515-20220408
X-UUID: 9c58a1d6e1d148e189a0b35b5663b515-20220408
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 170892376; Fri, 08 Apr 2022 16:41:32 +0800
X-ns-mid: postfix-624FF57C-8530006886
Received: from localhost.localdomain (unknown [172.30.60.63])
        by cs2c.com.cn (NSMail) with ESMTPSA id CAABD383C646;
        Fri,  8 Apr 2022 08:42:36 +0000 (UTC)
From:   Enze Li <lienze@kylinos.cn>
To:     phil@philpotter.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: [PATCH] cdrom: do not print info list when there is no cdrom device
Date:   Fri,  8 Apr 2022 16:42:21 +0800
Message-Id: <20220408084221.1681592-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to print a list of cdrom entries with blank info when
no cdrom device exists.  With this patch applied, we get:

================================================
$ cat /proc/sys/dev/cdrom/info
CD-ROM information, Id:cdrom.c 3.20 2003/12/17

No device found.

================================================

BTW, I also formatted the argument list of the cdrom_sysctl_info
function, using tabs instead of spaces.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 drivers/cdrom/cdrom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 7bd10d63ddbe..33a51303f565 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3507,7 +3507,7 @@ static int cdrom_print_info(const char *header, int val, char *info,
 }
 
 static int cdrom_sysctl_info(struct ctl_table *ctl, int write,
-                           void *buffer, size_t *lenp, loff_t *ppos)
+			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int pos;
 	char *info = cdrom_sysctl_settings.info;
@@ -3522,6 +3522,11 @@ static int cdrom_sysctl_info(struct ctl_table *ctl, int write,
 
 	pos = sprintf(info, "CD-ROM information, " VERSION "\n");
 	
+	if (list_empty(&cdrom_list)) {
+		scnprintf(info + pos, max_size - pos, "\nNo device found.\n");
+		goto doit;
+	}
+
 	if (cdrom_print_info("\ndrive name:\t", 0, info, &pos, CTL_NAME))
 		goto done;
 	if (cdrom_print_info("\ndrive speed:\t", 0, info, &pos, CTL_SPEED))
-- 
2.25.1

