Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE2E4EE379
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbiCaVyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiCaVyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:54:46 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF97231ACC
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:52:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id c10so1958906ejs.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sd4Dv+ZWOb6q2yQLaNmeg8xynhdTU6RpDxBF/RZvfQ=;
        b=JtxdpIwivwnUVSniHaAcy7hQSSplDsADhwqzWl1+x8iL63xUZDqKO2N52/nhmLa0ie
         FlDJm2eXWgm+PoK9FatL2QWsapCHPQ2qOgB/6Uzg7ySRdIm7lPNprYIH1G7QpOZnBBe9
         VJ3Cljp9Jn3RvFR6HWI/1Im0+8dLznGp41+gucIagQlIl6FGpRpGiPuzzBjRz9FiSohO
         nqe6A2Bh5o0TKxn2l/AUFkIIAouvA+HmrcVypLIzYJT5hYaOdlM93EOpBLL0j9O1s+wO
         GdA4uf+9U7exz1UmK+1zNG3y/yuF9DKJWgrzefFzfJJDKxcxGu9rUXaRccLHPbO29rYd
         wWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sd4Dv+ZWOb6q2yQLaNmeg8xynhdTU6RpDxBF/RZvfQ=;
        b=UC05HW9YYS3GxY+WzmjxJXqNSt7xPAA5dYt2CQvsWe7YkgD3d7zXHRUAge7MKf3Pr8
         pFzyWpB9Pctf2lEuA55I+77/lLDa61YStsJL0KHKEOnOyh7lnFHghDxkyeaDbOD+4OE1
         n67F67eWlRxdpo9HTALI1R0kc1tr89Aimz4rdJ17qrD8p0RZeY8ymFCruZ13XOn7XboJ
         U8+a9YSWHAZmfhkMBnYcgnMMEsoicxGOWm6sXQcScU7dF96NeZymbDHU5k5T6awoOBjk
         4larMskit/ccRzOlJCe7ov9zMO06V39yaoXtq9jbsZjUL8PdXpEWTzPJTxOCmcbKIK/z
         LtSQ==
X-Gm-Message-State: AOAM532L6/iE8rRsHADXHmfBQjv06WA+77oYiZTS1bfYMrjyKVEfygoY
        9Ia3aexeowJSTBhL0Nf3MrM=
X-Google-Smtp-Source: ABdhPJwz4mdkoYMH3cHppROvh1hEcYupPDv5nUTRyVfJOCK+JnHGSyDSxVNZ5NpoYM4hYMsdq+4Nkg==
X-Received: by 2002:a17:907:7284:b0:6df:9120:d935 with SMTP id dt4-20020a170907728400b006df9120d935mr6837306ejc.276.1648763576045;
        Thu, 31 Mar 2022 14:52:56 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id g20-20020aa7c594000000b004194b07bbfasm299980edq.10.2022.03.31.14.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:52:55 -0700 (PDT)
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
Subject: [PATCH 2/3] ASoC: sprd: remove check of list iterator against head past the loop body
Date:   Thu, 31 Mar 2022 23:50:02 +0200
Message-Id: <20220331215003.882143-2-jakobkoschel@gmail.com>
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
 sound/soc/sprd/sprd-mcdt.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
index f6a55fa60c1b..6e27789a0df5 100644
--- a/sound/soc/sprd/sprd-mcdt.c
+++ b/sound/soc/sprd/sprd-mcdt.c
@@ -866,20 +866,19 @@ EXPORT_SYMBOL_GPL(sprd_mcdt_chan_dma_disable);
 struct sprd_mcdt_chan *sprd_mcdt_request_chan(u8 channel,
 					      enum sprd_mcdt_channel_type type)
 {
-	struct sprd_mcdt_chan *temp;
+	struct sprd_mcdt_chan *temp = NULL;
+	struct sprd_mcdt_chan *iter;
 
 	mutex_lock(&sprd_mcdt_list_mutex);
 
-	list_for_each_entry(temp, &sprd_mcdt_chan_list, list) {
-		if (temp->type == type && temp->id == channel) {
-			list_del_init(&temp->list);
+	list_for_each_entry(iter, &sprd_mcdt_chan_list, list) {
+		if (iter->type == type && iter->id == channel) {
+			list_del_init(&iter->list);
+			temp = iter;
 			break;
 		}
 	}
 
-	if (list_entry_is_head(temp, &sprd_mcdt_chan_list, list))
-		temp = NULL;
-
 	mutex_unlock(&sprd_mcdt_list_mutex);
 
 	return temp;
-- 
2.25.1

