Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A427155E321
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiF0PVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237904AbiF0PTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:19:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D861186D0;
        Mon, 27 Jun 2022 08:19:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u15so19855850ejc.10;
        Mon, 27 Jun 2022 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6EzgaDdod35tOk9Xd3ABhmGRA3bWAFE4kWc8/VH0my0=;
        b=cjCHMjpkMc668iwmhkAiFv98TWy9DCgnLvtw0goGxf+V7nzv5F/tJ58eCegt4KPPyx
         dE2YnmIqIEOU27EF0fn8D6s6Zb59AkpY3jVMMOpPrQbTVSuX9DFi42PK4bUd/7M6Ddde
         eMMPsGmfH1BrCmDyaXuyiq8I3rNIJKs+5TPUcUPPfGek0R6/s/mUpKgDwmXJFivleNkO
         sLyyHwHCRORj96tZxXE1nA3F7KQ9NMdp2R91NVhr5+abAXpboIg5aQ9roPM/6DXlBjcG
         oOdPcpAqgQf9TDHqFKfTroiUXWV6a98IiwfKFZBbqJ/b4eAgmuvLC3+hlzxEWL+GpGD1
         zzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6EzgaDdod35tOk9Xd3ABhmGRA3bWAFE4kWc8/VH0my0=;
        b=MtvK/nHYkU8jx4pel/jvnodtL9TtIlZt2Hf29ueKw1/dT4mug9DFyLMK24+/UcETOf
         4o5rURKz/zLuhfIor5en8VnMBKDrLo2Agx2faExmGyP5Qh7V0Qm7vPf1FBspjg3DjJN/
         xU6mQSmXELVLxx7x1canNGKSRYZ3ZhAtyyyUP8TTin4hObah/iTriNppkyjAVoAQWTG/
         LNMOKfrkVoqdaI2Ynm2o68eKYPKvbeY9ysqZ9ewRh4L8OupE/b/FFSphj6VXM41WJJPx
         XKybt0lXO46tPjYziKpFz3ymNfZl3Yttn9elNvCnfMxt5M4x4d/SVlrptJo4+7+USt5n
         KE0g==
X-Gm-Message-State: AJIora9A+Ck5diCQAfvsKjeXXrnNBxUOnX2xsxzkXjCust58YLAFM7n/
        cHTuyqdDxKmQNw3P9jnAvOQ=
X-Google-Smtp-Source: AGRyM1uk4GJCRDAIipTBgioG17trwdjuek7DuCMHYa50G/DN4fz9gvnvMzkddvHlpkw0AxIwuAV2Hg==
X-Received: by 2002:a17:907:3f29:b0:722:e5b0:ebe7 with SMTP id hq41-20020a1709073f2900b00722e5b0ebe7mr13075572ejc.335.1656343168908;
        Mon, 27 Jun 2022 08:19:28 -0700 (PDT)
Received: from felia.fritz.box (200116b826511b0021a0c74157938809.dip.versatel-1u1.de. [2001:16b8:2651:1b00:21a0:c741:5793:8809])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906434800b00722f2a0944fsm5076901ejm.107.2022.06.27.08.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:19:28 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH 08/11] docs: ja_JP: howto: remove reference to removed submitting-drivers
Date:   Mon, 27 Jun 2022 17:18:16 +0200
Message-Id: <20220627151819.22694-9-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The document submitting-drivers.rst was deleted. This removes the
corresponding reference in the Japanese translation of the howto.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/translations/ja_JP/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index 38fed6fe62fe..03b2079e4d5d 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -129,7 +129,7 @@ linux-api@vger.kernel.org に送ることを勧めます。
     ルに従っているものだけを受け付け、多くの人は正しいスタイルのコード
     だけをレビューします。
 
-  :ref:`Documentation/process/submitting-patches.rst <codingstyle>` と :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
+  :ref:`Documentation/process/submitting-patches.rst <codingstyle>`
     これらのファイルには、どうやってうまくパッチを作って投稿するかにつ
     いて非常に詳しく書かれており、以下を含みます (これだけに限らない
     けれども)
-- 
2.17.1

