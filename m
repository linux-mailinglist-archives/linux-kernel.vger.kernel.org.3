Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3057D53C738
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbiFCJD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiFCJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:03:55 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BCC1E9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654247034; x=1685783034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/c7hQ+QU+SR6ACN+gxaQMwgph9j7/3Uzti/cMVLNetk=;
  b=tcc8M4o9vtBvTk25x9HHIx/3MqSNpBTvS1HpGlMXVWAgUsdeQtWhkIb6
   W3/IZ492oZ5xQmAfwBc0GItScgUJXM4fzDff82phUVU8Hz/cYOV4Nr3W2
   X4UcekDVdAP8O88YMuVMsT+Sxw/oePBp2KpJcz2aJxTJ5Jw8FLd8Fkgxx
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 03 Jun 2022 02:03:53 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Jun 2022 02:03:52 -0700
X-QCInternal: smtphost
Received: from hu-rbankapu-blr.qualcomm.com (HELO hu-ub18template-blr.qualcomm.com) ([10.131.39.233])
  by ironmsg02-blr.qualcomm.com with ESMTP; 03 Jun 2022 14:33:43 +0530
Received: by hu-ub18template-blr.qualcomm.com (Postfix, from userid 4079802)
        id 7AC7C802D96; Fri,  3 Jun 2022 14:33:42 +0530 (+0530)
From:   Raghu Bankapur <quic_rbankapu@quicinc.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krishna Jha <quic_kkishorj@quicinc.com>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>
Subject: [PATCH V1 1/1] asoc: msm: use hashtable to check kcontrol
Date:   Fri,  3 Jun 2022 14:33:38 +0530
Message-Id: <9a0ec3f261ff80d842f926f747e3d10fbc3f9aa9.1654246653.git.quic_rbankapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1654246653.git.quic_rbankapu@quicinc.com>
References: <cover.1654246653.git.quic_rbankapu@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use hashtabe instead of linear list to check kcontrol before
adding them for improving early audio KPI.

Change-Id: I7134816736e08e338c0f22a8ae283a0520aa847a
Signed-off-by: Raghu Bankapur <quic_rbankapu@quicinc.com>
---
 include/sound/control.h |   2 +
 include/sound/core.h    |   5 +-
 sound/core/control.c    | 106 +++++++++++++++++++++++-----------------
 sound/core/init.c       |   1 +
 4 files changed, 68 insertions(+), 46 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index 985c51a8fb74..e50db5c45114 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -70,6 +70,8 @@ struct snd_kcontrol_volatile {
 struct snd_kcontrol {
 	struct list_head list;		/* list of controls */
 	struct snd_ctl_elem_id id;
+	struct hlist_node hnode;
+	unsigned int knametoint;	/* kctl name to uint, hash key value */
 	unsigned int count;		/* count of same elements */
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
diff --git a/include/sound/core.h b/include/sound/core.h
index b7e9b58d3c78..90341d6f1573 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -14,6 +14,7 @@
 #include <linux/pm.h>			/* pm_message_t */
 #include <linux/stringify.h>
 #include <linux/printk.h>
+#include <linux/hashtable.h>
 
 /* number of supported soundcards */
 #ifdef CONFIG_SND_DYNAMIC_MINORS
@@ -24,6 +25,8 @@
 
 #define CONFIG_SND_MAJOR	116	/* standard configuration */
 
+#define SND_CTL_HASH_TABLE_BITS 14	/* buckets numbers: 1 << 14 */
+
 /* forward declarations */
 struct pci_dev;
 struct module;
@@ -103,7 +106,7 @@ struct snd_card {
 	size_t user_ctl_alloc_size;	// current memory allocation by user controls.
 	struct list_head controls;	/* all controls for this card */
 	struct list_head ctl_files;	/* active control files */
-
+	DECLARE_HASHTABLE(ctl_htable, SND_CTL_HASH_TABLE_BITS);
 	struct snd_info_entry *proc_root;	/* root for soundcard specific files */
 	struct proc_dir_entry *proc_root_link;	/* number link to real id */
 
diff --git a/sound/core/control.c b/sound/core/control.c
index a25c0d64d104..e00a02015837 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -331,43 +331,49 @@ void snd_ctl_free_one(struct snd_kcontrol *kcontrol)
 }
 EXPORT_SYMBOL(snd_ctl_free_one);
 
-static bool snd_ctl_remove_numid_conflict(struct snd_card *card,
-					  unsigned int count)
+enum snd_ctl_add_mode {
+	CTL_ADD_EXCLUSIVE, CTL_REPLACE, CTL_ADD_ON_REPLACE,
+};
+
+char snd_ctl_string[50] = { '\0' };
+
+/* Used to convert the string into int value -- BKDRHash */
+static unsigned int snd_ctl_strtoint(const char *s)
 {
-	struct snd_kcontrol *kctl;
+	unsigned int res = 0;
 
-	/* Make sure that the ids assigned to the control do not wrap around */
-	if (card->last_numid >= UINT_MAX - count)
-		card->last_numid = 0;
+	while (*s)
+		res = (res << 5) - res + (*s++);
 
-	list_for_each_entry(kctl, &card->controls, list) {
-		if (kctl->id.numid < card->last_numid + 1 + count &&
-		    kctl->id.numid + kctl->count > card->last_numid + 1) {
-		    	card->last_numid = kctl->id.numid + kctl->count - 1;
-			return true;
-		}
-	}
-	return false;
+	return (res & 0x7FFFFFFF);
 }
 
-static int snd_ctl_find_hole(struct snd_card *card, unsigned int count)
+/**
+ * snd_ctl_hash_check - Check the duplicate enrty on snd hashtable
+ * @card: the card instance
+ * @nametoint: kctl name to uint
+ *
+ * Finds the control instance with the given nametoint from the card.
+ *
+ * Return: The pointer of the instance if found, or %NULL if not.
+ *
+ */
+static struct snd_kcontrol *snd_ctl_hash_check(struct snd_card *card,
+				 unsigned int nametoint)
 {
-	unsigned int iter = 100000;
+	struct snd_kcontrol *kctl = NULL;
 
-	while (snd_ctl_remove_numid_conflict(card, count)) {
-		if (--iter == 0) {
-			/* this situation is very unlikely */
-			dev_err(card->dev, "unable to allocate new control numid\n");
-			return -ENOMEM;
-		}
+	if (snd_BUG_ON(!card))
+		return NULL;
+
+	hash_for_each_possible(card->ctl_htable, kctl, hnode, nametoint) {
+		if (kctl->knametoint != nametoint)
+			continue;
+		return kctl;
 	}
-	return 0;
+	return NULL;
 }
 
-enum snd_ctl_add_mode {
-	CTL_ADD_EXCLUSIVE, CTL_REPLACE, CTL_ADD_ON_REPLACE,
-};
-
 /* add/replace a new kcontrol object; call with card->controls_rwsem locked */
 static int __snd_ctl_add_replace(struct snd_card *card,
 				 struct snd_kcontrol *kcontrol,
@@ -382,26 +388,34 @@ static int __snd_ctl_add_replace(struct snd_card *card,
 	if (id.index > UINT_MAX - kcontrol->count)
 		return -EINVAL;
 
-	old = snd_ctl_find_id(card, &id);
-	if (!old) {
-		if (mode == CTL_REPLACE)
-			return -EINVAL;
-	} else {
-		if (mode == CTL_ADD_EXCLUSIVE) {
-			dev_err(card->dev,
-				"control %i:%i:%i:%s:%i is already present\n",
-				id.iface, id.device, id.subdevice, id.name,
-				id.index);
-			return -EBUSY;
-		}
+	snprintf(snd_ctl_string, strlen(kcontrol->id.name) + 6, "%s%d%d%d",
+		kcontrol->id.name, kcontrol->id.iface, kcontrol->id.device,
+		kcontrol->id.subdevice);
 
-		err = snd_ctl_remove(card, old);
-		if (err < 0)
-			return err;
-	}
+	kcontrol->knametoint = snd_ctl_strtoint(snd_ctl_string);
+	if (kcontrol->knametoint < 0)
+		return -EINVAL;
 
-	if (snd_ctl_find_hole(card, kcontrol->count) < 0)
-		return -ENOMEM;
+	old = snd_ctl_hash_check(card, kcontrol->knametoint);
+	if (old) {
+		old = snd_ctl_find_id(card, &id);
+		if (!old) {
+			if (mode == CTL_REPLACE)
+				return -EINVAL;
+		} else {
+			if (mode == CTL_ADD_EXCLUSIVE) {
+				dev_err(card->dev,
+					"control %i:%i:%i:%s:%i is already present\n",
+					id.iface, id.device, id.subdevice, id.name,
+					id.index);
+				return -EBUSY;
+			}
+
+			err = snd_ctl_remove(card, old);
+			if (err < 0)
+				return err;
+		}
+	}
 
 	list_add_tail(&kcontrol->list, &card->controls);
 	card->controls_count += kcontrol->count;
@@ -411,6 +425,8 @@ static int __snd_ctl_add_replace(struct snd_card *card,
 	for (idx = 0; idx < kcontrol->count; idx++)
 		snd_ctl_notify_one(card, SNDRV_CTL_EVENT_MASK_ADD, kcontrol, idx);
 
+	hash_add(card->ctl_htable, &kcontrol->hnode, kcontrol->knametoint);
+
 	return 0;
 }
 
diff --git a/sound/core/init.c b/sound/core/init.c
index 31ba7024e3ad..24138902e5f2 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -284,6 +284,7 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
 	INIT_LIST_HEAD(&card->ctl_files);
 	spin_lock_init(&card->files_lock);
 	INIT_LIST_HEAD(&card->files_list);
+	hash_init(card->ctl_htable);
 	mutex_init(&card->memory_mutex);
 #ifdef CONFIG_PM
 	init_waitqueue_head(&card->power_sleep);
-- 
2.17.1

