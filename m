Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B821C537063
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 10:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiE2Iul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 04:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiE2Iuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 04:50:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5127814A2
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 01:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653814235; x=1685350235;
  h=from:to:cc:subject:date:message-id;
  bh=pVctacfE/6fUl/sXtENzfCHXL++mZW7suIifbtJm0oE=;
  b=X73a7ZtRNjqnRcYD+FFm0vATnHCcJf+SnhWPhYLZAcL4W+9YoIba7AHy
   lqn+Fen53pqtt4RuQ9nlvVSjMAdNc5zhKrfV5q3T+iUO2njtu1LXUqtK2
   u2LTV4uo4VS5UlVBXXX9dFqFAL54mQVjyzOaK+oCg8XfWAKk76qoPKo0d
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 29 May 2022 01:50:35 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 29 May 2022 01:50:34 -0700
X-QCInternal: smtphost
Received: from hu-rbankapu-blr.qualcomm.com (HELO hu-ub18template-blr.qualcomm.com) ([10.131.39.233])
  by ironmsg02-blr.qualcomm.com with ESMTP; 29 May 2022 14:20:28 +0530
Received: by hu-ub18template-blr.qualcomm.com (Postfix, from userid 4079802)
        id B8F86800995; Sun, 29 May 2022 14:20:27 +0530 (+0530)
From:   Raghu Bankapur <quic_rbankapu@quicinc.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krishna Jha <quic_kkishorj@quicinc.com>
Subject: [PATCH V0 1/1] asoc: msm: use hashtable to check kcontrol
Date:   Sun, 29 May 2022 14:20:09 +0530
Message-Id: <ad55bbd41cc253acb9af6ac068c15dd1545ecd81.1653813866.git.quic_rbankapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1653813866.git.quic_rbankapu@quicinc.com>
References: <cover.1653813866.git.quic_rbankapu@quicinc.com>
In-Reply-To: <cover.1653813866.git.quic_rbankapu@quicinc.com>
References: <cover.1653813866.git.quic_rbankapu@quicinc.com>
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
 include/sound/control.h |  4 ++
 include/sound/core.h    | 12 +++++-
 sound/core/control.c    | 92 +++++++++++++++++++++++++++++++++--------
 sound/core/init.c       |  3 ++
 sound/soc/Kconfig       |  9 ++++
 5 files changed, 101 insertions(+), 19 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index 985c51a8fb74..1b85d36c2066 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -70,6 +70,10 @@ struct snd_kcontrol_volatile {
 struct snd_kcontrol {
 	struct list_head list;		/* list of controls */
 	struct snd_ctl_elem_id id;
+#ifdef CONFIG_SND_CTL_HASHTABLE
+	struct hlist_node hnode;
+	unsigned int knametoint;		/* kctl name to uint, hash key value */
+#endif
 	unsigned int count;		/* count of same elements */
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
diff --git a/include/sound/core.h b/include/sound/core.h
index b7e9b58d3c78..dd6714fc43ff 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -14,7 +14,9 @@
 #include <linux/pm.h>			/* pm_message_t */
 #include <linux/stringify.h>
 #include <linux/printk.h>
-
+#ifdef CONFIG_SND_CTL_HASHTABLE
+#include <linux/hashtable.h>
+#endif
 /* number of supported soundcards */
 #ifdef CONFIG_SND_DYNAMIC_MINORS
 #define SNDRV_CARDS CONFIG_SND_MAX_CARDS
@@ -24,6 +26,10 @@
 
 #define CONFIG_SND_MAJOR	116	/* standard configuration */
 
+#ifdef CONFIG_SND_CTL_HASHTABLE
+#define SND_CTL_HASH_TABLE_BITS 14	/* buckets numbers: 1 << 14 */
+#endif
+
 /* forward declarations */
 struct pci_dev;
 struct module;
@@ -103,7 +109,9 @@ struct snd_card {
 	size_t user_ctl_alloc_size;	// current memory allocation by user controls.
 	struct list_head controls;	/* all controls for this card */
 	struct list_head ctl_files;	/* active control files */
-
+#ifdef CONFIG_SND_CTL_HASHTABLE
+	DECLARE_HASHTABLE(ctl_htable, SND_CTL_HASH_TABLE_BITS);
+#endif
 	struct snd_info_entry *proc_root;	/* root for soundcard specific files */
 	struct proc_dir_entry *proc_root_link;	/* number link to real id */
 
diff --git a/sound/core/control.c b/sound/core/control.c
index a25c0d64d104..914d05647497 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -368,6 +368,47 @@ enum snd_ctl_add_mode {
 	CTL_ADD_EXCLUSIVE, CTL_REPLACE, CTL_ADD_ON_REPLACE,
 };
 
+#ifdef CONFIG_SND_CTL_HASHTABLE
+char snd_ctl_string[50] = { '\0' };
+
+/* Used to convert the string into int value -- BKDRHash */
+unsigned int snd_ctl_strtoint(const char *s)
+{
+	unsigned int res = 0;
+
+	while (*s)
+		res = (res << 5) - res + (*s++);
+
+	return (res & 0x7FFFFFFF);
+}
+
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
+{
+	struct snd_kcontrol *kctl = NULL;
+
+	if (snd_BUG_ON(!card))
+		return NULL;
+
+	hash_for_each_possible(card->ctl_htable, kctl, hnode, nametoint) {
+		if (kctl->knametoint != nametoint)
+			continue;
+		return kctl;
+	}
+	return NULL;
+}
+#endif
+
 /* add/replace a new kcontrol object; call with card->controls_rwsem locked */
 static int __snd_ctl_add_replace(struct snd_card *card,
 				 struct snd_kcontrol *kcontrol,
@@ -382,24 +423,38 @@ static int __snd_ctl_add_replace(struct snd_card *card,
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
+#ifdef CONFIG_SND_CTL_HASHTABLE
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
+
+	old = snd_ctl_hash_check(card, kcontrol->knametoint);
+	if (old) {
+#endif
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
 
+			err = snd_ctl_remove(card, old);
+			if (err < 0)
+				return err;
+		}
+#ifdef CONFIG_SND_CTL_HASHTABLE
+	}
+#endif
 	if (snd_ctl_find_hole(card, kcontrol->count) < 0)
 		return -ENOMEM;
 
@@ -410,7 +465,10 @@ static int __snd_ctl_add_replace(struct snd_card *card,
 
 	for (idx = 0; idx < kcontrol->count; idx++)
 		snd_ctl_notify_one(card, SNDRV_CTL_EVENT_MASK_ADD, kcontrol, idx);
-
+		
+#ifdef CONFIG_SND_CTL_HASHTABLE
+	hash_add(card->ctl_htable, &kcontrol->hnode, kcontrol->knametoint);
+#endif
 	return 0;
 }
 
diff --git a/sound/core/init.c b/sound/core/init.c
index 31ba7024e3ad..fda38b2137ee 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -284,6 +284,9 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
 	INIT_LIST_HEAD(&card->ctl_files);
 	spin_lock_init(&card->files_lock);
 	INIT_LIST_HEAD(&card->files_list);
+#ifdef CONFIG_SND_CTL_HASHTABLE
+	hash_init(card->ctl_htable);
+#endif
 	mutex_init(&card->memory_mutex);
 #ifdef CONFIG_PM
 	init_waitqueue_head(&card->power_sleep);
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 5dcf77af07af..0eb18f8ee6fd 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -58,6 +58,15 @@ config SND_SOC_TOPOLOGY_KUNIT_TEST
 config SND_SOC_ACPI
 	tristate
 
+config SND_CTL_HASHTABLE
+	bool "Add SND CTL hashtable"
+	help
+	  This enables hash table in sound card for kcontrols. The traditional way is
+	  traversing the linked list of controls and compare each exsiting control with
+	  the new kcontrol to find out whether there are duplicate kcontrols, which will
+	  consumes much time during bootup. Enable this will use hash table instead of
+	  linked list to check new kcontrol and reduce much time for sound card registration.
+
 # All the supported SoCs
 source "sound/soc/adi/Kconfig"
 source "sound/soc/amd/Kconfig"
-- 
2.17.1

