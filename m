Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3356D58AA6A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbiHEL5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiHEL5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:57:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65CF76470
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 04:57:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x21so3109220edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 04:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9IFcrRZX/CnV4UIXqlxp6Mdb1PIceUrFZLWlYBsRj8o=;
        b=bTy+O1/anUql+Hc31tuF6+5KPrD6TJMZRBYrkS/MOA9/wBX+81dCSgYJMu2WSOiTna
         d+8XCnNTXtxNaOmYvCIG5YnzXl1uLqDJTsSgR+jxTpzGNkmvwDLkrsYDLZ5NtpVgWcHv
         GPr1ibEwLfnfT3hxMSmTU6TouSRjE92sSr7VUZ5YM9QC0MFptzJ5YvZjUsBlpIs7roL4
         hit7DT5J0FcWTRhhEr/7lzDoTpj13h1rBfkv4EvGQ7QETsLuW73l1uyKqDVrqQxmVskn
         JW5Dbmzb9VDRmh+GO2ekcu2um3H5IySy9DCfi+wbHzmItpopW5JPOYWitblR+ZczbndK
         C3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=9IFcrRZX/CnV4UIXqlxp6Mdb1PIceUrFZLWlYBsRj8o=;
        b=qqhPMWyYn2p25Qi6fJEDAgDi2mAYSy164jQ/1dtFMqpUrknmILgTQm8U/tKxvgd9Lx
         jenj5y+Dkz6zy9d6YZAVdXaOVj2GSnFxhkApSuxSexP5qntNvad36Rbw1UtMToCtFpjS
         q+khVtOH9shiv/RniOrS+Oqbq0EUMiY2+euRWj9XSA3SOsphqGe9pVA+HUqauVSoDvXz
         oo9VLx6ypWyGx5ksKhm2Kn8U+HhSyZR1KYPNoxIaEkJ0oe0fE4TEyYVupJMdvdXd0pEG
         yebnulnP+iV7+1zVvwdRMcG1SH6S+yd5M5W/eo1kb5S0Qupusn469ex00WzK3nhNydSu
         Hsbg==
X-Gm-Message-State: ACgBeo0PSkZ75XACoxhUsj/ACXMBUW1Z79EaoI05iMHPOGZZjQC29cVR
        1YSffwYRkfPiYy9OzzmoVBrLqFjfDlVkJQ==
X-Google-Smtp-Source: AA6agR5QOMzpP+mAS3PyycCHlndfEHgm/KzScHlT1ys5+53/fXBo1JTgNdgTNbjFD8uFYoGMmJJ3AQ==
X-Received: by 2002:aa7:c14e:0:b0:43d:7bad:b53e with SMTP id r14-20020aa7c14e000000b0043d7badb53emr6219629edp.353.1659700667002;
        Fri, 05 Aug 2022 04:57:47 -0700 (PDT)
Received: from localhost.localdomain (p200300d99703c2003e69dd231e074304.dip0.t-ipconnect.de. [2003:d9:9703:c200:3e69:dd23:1e07:4304])
        by smtp.googlemail.com with ESMTPSA id dy9-20020a05640231e900b0043bc19efc15sm1977921edb.28.2022.08.05.04.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 04:57:46 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Davidlohr Bueso <dave@stgolabs.net>, 1vier1@web.de,
        Manfred Spraul <manfred@colorfullife.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] ipc/util.c: Cleanup and improve sysvipc_find_ipc(), V3
Date:   Fri,  5 Aug 2022 13:57:33 +0200
Message-Id: <20220805115733.104763-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysvipc_find_ipc() can be simplified further:

- It uses a for() loop to locate the next entry in the idr.
  This can be replaced with idr_get_next().

- It receives two parameters (pos - which is actually
  an idr index and not a position, and new_pos, which
  is really a position).
  One parameter is sufficient.

Link: https://lore.kernel.org/all/20210903052020.3265-3-manfred@colorfullife.com/
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---

Resending the patch, it seems it was stuck:
- typo noticed by Waiman corrected.
- rediffed
- retested

@Andrew: Could you add it it linux-next/mm?
It is in my outbox for > 6 months now, and using a for() loop instead of
idr_get_next() is just wrong.
And the variable naming should be cleaned up as well
(idx -> index, without sequence number. id -> user space id, with
sequence number. The current function doesn't follow that)

  ipc/util.c | 53 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index a2208d0f26b2..05cb9de66735 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -782,28 +782,37 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
 	return iter->pid_ns;
 }
 
-/*
- * This routine locks the ipc structure found at least at position pos.
+/**
+ * sysvipc_find_ipc - Find and lock the ipc structure based on seq pos
+ * @ids: ipc identifier set
+ * @pos: expected position
+ *
+ * The function finds an ipc structure, based on the sequence file
+ * position @pos. If there is no ipc structure at position @pos, then
+ * the successor is selected.
+ * If a structure is found, then it is locked (both rcu_read_lock() and
+ * ipc_lock_object()) and  @pos is set to the position needed to locate
+ * the found ipc structure.
+ * If nothing is found (i.e. EOF), @pos is not modified.
+ *
+ * The function returns the found ipc structure, or NULL at EOF.
  */
-static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
-					      loff_t *new_pos)
+static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t *pos)
 {
-	struct kern_ipc_perm *ipc = NULL;
-	int max_idx = ipc_get_maxidx(ids);
+	int tmpidx;
+	struct kern_ipc_perm *ipc;
 
-	if (max_idx == -1 || pos > max_idx)
-		goto out;
+	/* convert from position to idr index -> "-1" */
+	tmpidx = *pos - 1;
 
-	for (; pos <= max_idx; pos++) {
-		ipc = idr_find(&ids->ipcs_idr, pos);
-		if (ipc != NULL) {
-			rcu_read_lock();
-			ipc_lock_object(ipc);
-			break;
-		}
+	ipc = idr_get_next(&ids->ipcs_idr, &tmpidx);
+	if (ipc != NULL) {
+		rcu_read_lock();
+		ipc_lock_object(ipc);
+
+		/* convert from idr index to position  -> "+1" */
+		*pos = tmpidx + 1;
 	}
-out:
-	*new_pos = pos + 1;
 	return ipc;
 }
 
@@ -817,11 +826,13 @@ static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)
 	if (ipc && ipc != SEQ_START_TOKEN)
 		ipc_unlock(ipc);
 
-	return sysvipc_find_ipc(&iter->ns->ids[iface->ids], *pos, pos);
+	/* Next -> search for *pos+1 */
+	(*pos)++;
+	return sysvipc_find_ipc(&iter->ns->ids[iface->ids], pos);
 }
 
 /*
- * File positions: pos 0 -> header, pos n -> ipc id = n - 1.
+ * File positions: pos 0 -> header, pos n -> ipc idx = n - 1.
  * SeqFile iterator: iterator value locked ipc pointer or SEQ_TOKEN_START.
  */
 static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
@@ -846,8 +857,8 @@ static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
 	if (*pos == 0)
 		return SEQ_START_TOKEN;
 
-	/* Find the (pos-1)th ipc */
-	return sysvipc_find_ipc(ids, *pos - 1, pos);
+	/* Otherwise return the correct ipc structure */
+	return sysvipc_find_ipc(ids, pos);
 }
 
 static void sysvipc_proc_stop(struct seq_file *s, void *it)
-- 
2.37.1

