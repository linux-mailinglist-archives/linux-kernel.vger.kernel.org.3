Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836124EE378
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbiCaVyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241947AbiCaVyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:54:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F3A231AC1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:52:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o10so2100047ejd.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QOImAANTWLBikn8WE3acPmaj6Gy0UFu59bmhhFGIeCA=;
        b=VQSaHJzJLRFaxfS/H8mgdqxOLx5qp1cgKAzL60yVLDlMeAt8VGhJ9dkvSo8sse5peb
         boPtfzWnd11zFz27+iSxjTF4FB3YXcvxCT+y5FxIQXjsDIGZGlrAhjAUt9Gojhs/ydoV
         iRq25wsDAnQkMPcHv0/3gqrPQJqkQqnelapWUf1mTwoNfW/NUCQK1omIjnmbWosXVlbC
         h5SpKhE16NeouY/7uihnCR6OXqqIZ6MiXayAqcOpsHk8L7jbpyZ/itHHQNd+sB4jvelb
         5E3hF9MNJIokJCh19DtkusmD9+MQFxQTeDbp1vVfR/7mDfIN14lven09Sut3cK8Ri4Xm
         00IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOImAANTWLBikn8WE3acPmaj6Gy0UFu59bmhhFGIeCA=;
        b=sL1Vb7f3shoMBuxyzyVjIXXJMICLz5GTzxJAShHbWOZkUgH7jbUze1k39WMjRdoZAO
         SL5Of68Zn5yMJSLnubBWVnR4WfN/fpnrVNocQyYklZXQTNGvluNJwNO+bH9a7nrZl8+f
         xQSreES9KbxqihmqlKQqHz0A2/qmUAGcf7VcDaDbf6rhJzZMUCZ2/VdRNLsNMfYAjNE/
         P89Hcj0g+Dux9OvY3XN2f6o9bflzPZC8++8qrDDso3wsc+cPChLPRYeVmRak+E5Fww3N
         HiFimlybzSblfS96hr629aYDk2578SD5x8ys4NJoQDki6BBJ1uR0fu8vnEZ8h9ghoX8l
         MrcA==
X-Gm-Message-State: AOAM532X1E/KV9QkBvfVMeMSi59OeAB7rWNf1PQULC/X0TBgjTFCAVbV
        SkD7iuqpxKXRBu+NarxnBM8=
X-Google-Smtp-Source: ABdhPJwhW6AYtGNMAVFbxpGjx9UHVrI4ApY9BLlL1tGNDzt2uyxR6JIV8D6VbtshApQXftpkkWYqOQ==
X-Received: by 2002:a17:906:32cf:b0:6d5:83bc:e962 with SMTP id k15-20020a17090632cf00b006d583bce962mr6882166ejk.108.1648763577157;
        Thu, 31 Mar 2022 14:52:57 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id g20-20020aa7c594000000b004194b07bbfasm299980edq.10.2022.03.31.14.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:52:56 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 3/3] ASoC: atmel-ssc: replace usage of found with dedicated list iterator variable
Date:   Thu, 31 Mar 2022 23:50:03 +0200
Message-Id: <20220331215003.882143-3-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331215003.882143-1-jakobkoschel@gmail.com>
References: <20220331215003.882143-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/misc/atmel-ssc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index d6cd5537126c..343e25555fbb 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -25,25 +25,24 @@ static LIST_HEAD(ssc_list);
 
 struct ssc_device *ssc_request(unsigned int ssc_num)
 {
-	int ssc_valid = 0;
-	struct ssc_device *ssc;
+	struct ssc_device *ssc = NULL, *iter;
 
 	mutex_lock(&user_lock);
-	list_for_each_entry(ssc, &ssc_list, list) {
-		if (ssc->pdev->dev.of_node) {
-			if (of_alias_get_id(ssc->pdev->dev.of_node, "ssc")
+	list_for_each_entry(iter, &ssc_list, list) {
+		if (iter->pdev->dev.of_node) {
+			if (of_alias_get_id(iter->pdev->dev.of_node, "ssc")
 				== ssc_num) {
-				ssc->pdev->id = ssc_num;
-				ssc_valid = 1;
+				iter->pdev->id = ssc_num;
+				ssc = iter;
 				break;
 			}
-		} else if (ssc->pdev->id == ssc_num) {
-			ssc_valid = 1;
+		} else if (iter->pdev->id == ssc_num) {
+			ssc = iter;
 			break;
 		}
 	}
 
-	if (!ssc_valid) {
+	if (!ssc) {
 		mutex_unlock(&user_lock);
 		pr_err("ssc: ssc%d platform device is missing\n", ssc_num);
 		return ERR_PTR(-ENODEV);
-- 
2.25.1

