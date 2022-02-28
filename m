Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2F14C6F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiB1O2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiB1O1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:27:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E3573061;
        Mon, 28 Feb 2022 06:27:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x5so17813796edd.11;
        Mon, 28 Feb 2022 06:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/fXkjBKuEDR4qpYn2ujxjEbDpHzrM+R4EAAb1AiNHio=;
        b=lLYjGCYLSL+av8OkcVAc4/oCnI/WeeRgq29iylTKybgQlc4MGL8Q/SHKtzbrfvhbxI
         0GX5FmsK6X5LjNXzfD0vHJrPr/79Ie/HnMIj1ax7+jmO18bjcqQp8rt98niTVc+P4mEl
         HCYRfeUZTI2XTspDLVtcpqzL0ndyTiLboWta0DqzbPO9PefB6elVGbarZc+hLXEDtUK9
         OD5/2b1YudoTvlldsZLM5cUwkwGpJQC7b5/7m82OAWioLcq0MDvtfv+8xujrtLi5G20Q
         8hB+wPesBi2UNUeiodZpOq82c+ECkgFJvzoIWli3eRBma0m0Kp/v+P+fCKPxy9Bq3H4H
         VYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/fXkjBKuEDR4qpYn2ujxjEbDpHzrM+R4EAAb1AiNHio=;
        b=ufcUyEXZXtXaJiujSj+wEHo6GKvDIsXJkcrWdoywnW3qirpzTlbzbt5O796+M3urdP
         PQHLUmjEtMinIhthD6BsJcscXo8Pu3j7fT+z42lApwparGHJzT/JeDS+ZqDEsMmzBdGo
         LYzegtcRQVG/SyuSxxFziTGXg694wmbVnfwge89TQZCFIOrXVwswgxyNh5EbxUKHsKP8
         6UtiGYTi8rPgwSZ4KS4WOz1BigFbpF7Ilyq+ZjzuLeppGkCiFlYmRw1nHey2daPKlmzC
         pBu+c8RjcYrY0l/6YsariPKziL0XYIJrwyxiQMcZt2G0aGEegcIowRRPSves0dNToZxi
         LHDg==
X-Gm-Message-State: AOAM533sJdtzjb60nkDw+3MBT4anjdiSpEw3PaMEXJ4WygeQr5Chi2r/
        7h702Oq19uLBmj0m1p2NTuQ=
X-Google-Smtp-Source: ABdhPJwAE6H2XbhwQwrAKKYbCx+L/5tctqMz/DEmewhfUE0UjDRfcU5OHoR/Ppy2sF3GLnFeRL9w+Q==
X-Received: by 2002:a05:6402:42c6:b0:412:8cbc:8f3d with SMTP id i6-20020a05640242c600b004128cbc8f3dmr19826123edc.310.1646058429475;
        Mon, 28 Feb 2022 06:27:09 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id bm23-20020a170906c05700b006d597fd51c6sm4458707ejb.145.2022.02.28.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:27:09 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Andrew Morton <akpm@osdl.org>,
        Ricardo Cerqueira <v4l@cerqueira.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: saa7134: fix incorrect use to determine if list is empty
Date:   Mon, 28 Feb 2022 15:26:26 +0100
Message-Id: <20220228142628.577433-1-jakobkoschel@gmail.com>
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

'dev' will *always* be set by list_for_each_entry().
It is incorrect to assume that the iterator value will be NULL if the
list is empty.

Instead of checking the pointer it should be checked if
the list is empty.

Fixes: 79dd0c69f05f ("V4L: 925: saa7134 alsa is now a standalone module")
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/media/pci/saa7134/saa7134-alsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
index fb24d2ed3621..d3cde05a6eba 100644
--- a/drivers/media/pci/saa7134/saa7134-alsa.c
+++ b/drivers/media/pci/saa7134/saa7134-alsa.c
@@ -1214,7 +1214,7 @@ static int alsa_device_exit(struct saa7134_dev *dev)
 
 static int saa7134_alsa_init(void)
 {
-	struct saa7134_dev *dev = NULL;
+	struct saa7134_dev *dev;
 
 	saa7134_dmasound_init = alsa_device_init;
 	saa7134_dmasound_exit = alsa_device_exit;
@@ -1229,7 +1229,7 @@ static int saa7134_alsa_init(void)
 			alsa_device_init(dev);
 	}
 
-	if (dev == NULL)
+	if (list_empty(&saa7134_devlist))
 		pr_info("saa7134 ALSA: no saa7134 cards found\n");
 
 	return 0;

base-commit: 7ee022567bf9e2e0b3cd92461a2f4986ecc99673
-- 
2.25.1

