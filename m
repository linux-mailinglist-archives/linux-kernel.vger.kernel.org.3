Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E37469328
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbhLFKGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:06:08 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:37479 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbhLFKGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:06:05 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id DB6C0C76D9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 09:59:42 +0000 (UTC)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9E527FF812;
        Mon,  6 Dec 2021 09:59:20 +0000 (UTC)
From:   Kory Maincent <kory.maincent@bootlin.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: soc-core: add the driver component name to the component struc
Date:   Mon,  6 Dec 2021 10:59:20 +0100
Message-Id: <20211206095920.40552-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function fmt_single_name is using to sanitize namings, and it return
the name set to component->name.
This function is returning either the "device_name" or the
"device_name.driver_name" for i2c devices. There is no use of the component
driver name.
If a non i2c driver register two components the function will return the
same "device_name" for both components. This could cause unexpected issue,
in my case it is a debugfs error which tries to create two directory with
the same component name.

I have fixed it by prefixing the component name with the driver component
name.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 sound/soc/soc-core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index dcf6be4c4aaa..21ff77b231b8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2342,10 +2342,10 @@ EXPORT_SYMBOL_GPL(snd_soc_unregister_card);
  * Simplify DAI link configuration by removing ".-1" from device names
  * and sanitizing names.
  */
-static char *fmt_single_name(struct device *dev, int *id)
+static char *fmt_single_name(struct device *dev, const char *snd_drv_name, int *id)
 {
 	const char *devname = dev_name(dev);
-	char *found, *name;
+	char *found, *name, *tmp;
 	unsigned int id1, id2;
 
 	if (devname == NULL)
@@ -2380,6 +2380,14 @@ static char *fmt_single_name(struct device *dev, int *id)
 		*id = 0;
 	}
 
+	if (snd_drv_name != NULL) {
+		/* Add driver component name if present */
+		tmp = devm_kasprintf(dev, GFP_KERNEL, "%s.%s", snd_drv_name, name);
+		devm_kfree(dev, name);
+		name = devm_kstrdup(dev, tmp, GFP_KERNEL);
+		devm_kfree(dev, tmp);
+	}
+
 	return name;
 }
 
@@ -2444,7 +2452,7 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 	 */
 	if (legacy_dai_naming &&
 	    (dai_drv->id == 0 || dai_drv->name == NULL)) {
-		dai->name = fmt_single_name(dev, &dai->id);
+		dai->name = fmt_single_name(dev, dai_drv->name, &dai->id);
 	} else {
 		dai->name = fmt_multiple_name(dev, dai_drv);
 		if (dai_drv->id)
@@ -2578,7 +2586,7 @@ int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->list);
 	mutex_init(&component->io_mutex);
 
-	component->name = fmt_single_name(dev, &component->id);
+	component->name = fmt_single_name(dev, driver->name, &component->id);
 	if (!component->name) {
 		dev_err(dev, "ASoC: Failed to allocate name\n");
 		return -ENOMEM;
-- 
2.25.1

