Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB024EE377
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbiCaVyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiCaVyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:54:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D58231AC1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:52:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j15so2003607eje.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7WvWGnp8e2+ZYg4JNgLcns/TOfiaFHz5BOyp+VBRH4=;
        b=lTyVqB+Zc0e84QnpugtFoYsU6sl7K9xjMJMkDzI/2MY0BSJekhavkyJQoQveEAWCdU
         U/29yUBVpmdYDctiBtXhoEYWP97aqmJaRfvJx/8zju1ldkj8caD+VGEQPmdRLcJPDfN3
         TzTBYCAxHgI0B99roIcLtlO2DXlv/SBgb11EHj0mpaudvCBRHBjt5HznTGbG92ak7BsM
         G6+xpDaBUobsstl3W8YTkgsQgbjsRot9Mkm4cRA8sWE2qbZPxCRxM6BqHi6Y/Tegc2Xa
         etQ78axO6I3D6qHS40dFndrk8PBpMN7wIudlaPGoTn/5TpyC4bAis2zdx9DTjQURPGeZ
         AR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7WvWGnp8e2+ZYg4JNgLcns/TOfiaFHz5BOyp+VBRH4=;
        b=R6rgO5NWHp38IaHXvZxaGc/eH3vgHqV8oTZGH0CCUUVio42M6QDEalwcNuUWw8bp36
         2UcdRFfOzUKpPt7/tmh2Gl2MRlv6kBkN4eXMw9xYtLPx58AAqag2HIG7XG29IdA5WELj
         ztXhZx7XjEjElLfBtvThp2yiFX7h4W+ruBTPTjvRW2rE0z2FUUc7U8FGiQmZ3gA5S88l
         kp+l4q9ak+T7eQXGYRDU8BXacX6cIIvcUrMUGV/yisiTTCooXduC5MvFlrW8L2KADi2M
         kwMjxLxfnKUv8XMwjF30PDl1XIscxwDIbpHKQaq8vn5Kk3RaN5SbosHp6v8Zrpvk5vrT
         TRPg==
X-Gm-Message-State: AOAM531AzDRXxqJ1b0HBtgZ2UHtNnt9cdwC3MvQKs2+PA9gLTeOWPrRk
        a8F3+tP1tcuyMIrYCO+arus=
X-Google-Smtp-Source: ABdhPJwI7ID3mvkG8QYmKxcyThluj0R006fho7SSsOjVN+yoz3BWnxu+1Aod9ibwGRMZdf+o4SIDLg==
X-Received: by 2002:a17:906:e4c:b0:6e0:b002:2b2e with SMTP id q12-20020a1709060e4c00b006e0b0022b2emr6627609eji.690.1648763575022;
        Thu, 31 Mar 2022 14:52:55 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id g20-20020aa7c594000000b004194b07bbfasm299980edq.10.2022.03.31.14.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:52:54 -0700 (PDT)
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
Subject: [PATCH 1/3] ASoC: Intel: catpt: remove check of list iterator against head past the loop body
Date:   Thu, 31 Mar 2022 23:50:01 +0200
Message-Id: <20220331215003.882143-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limiting the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 sound/soc/intel/catpt/pcm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/catpt/pcm.c b/sound/soc/intel/catpt/pcm.c
index a26000cd5ceb..b103b2d4026e 100644
--- a/sound/soc/intel/catpt/pcm.c
+++ b/sound/soc/intel/catpt/pcm.c
@@ -330,7 +330,8 @@ static int catpt_dai_apply_usettings(struct snd_soc_dai *dai,
 				     struct catpt_stream_runtime *stream)
 {
 	struct snd_soc_component *component = dai->component;
-	struct snd_kcontrol *pos;
+	struct snd_kcontrol *pos = NULL;
+	struct snd_kcontrol *iter;
 	struct catpt_dev *cdev = dev_get_drvdata(dai->dev);
 	const char *name;
 	int ret;
@@ -354,12 +355,14 @@ static int catpt_dai_apply_usettings(struct snd_soc_dai *dai,
 		return 0;
 	}
 
-	list_for_each_entry(pos, &component->card->snd_card->controls, list) {
-		if (pos->private_data == component &&
-		    !strncmp(name, pos->id.name, sizeof(pos->id.name)))
+	list_for_each_entry(iter, &component->card->snd_card->controls, list) {
+		if (iter->private_data == component &&
+		    !strncmp(name, iter->id.name, sizeof(iter->id.name))) {
+			pos = iter;
 			break;
+		}
 	}
-	if (list_entry_is_head(pos, &component->card->snd_card->controls, list))
+	if (!pos)
 		return -ENOENT;
 
 	if (stream->template->type != CATPT_STRM_TYPE_LOOPBACK)

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

