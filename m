Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF8C565547
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiGDM1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiGDM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:26:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752B8E006;
        Mon,  4 Jul 2022 05:26:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ay16so16470248ejb.6;
        Mon, 04 Jul 2022 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cNjFxmKQ9FWEVFi5C2WKFybYBlChY5kDF2lBxc753bc=;
        b=qFwcIDJZZ6wkcHmi6vwMKQK8lP6DWYXZV3QqMvD7vjt6X6zMq0Sj2bvkphgck6kHWv
         KKwJr+DKVvm4f+nPnDdhJvMvCHFF6k+Eu7Ks4HLWtoi7mJHq3uRUV1/muwj6WnWLFc70
         1baYAti7U4DZo+SXtykUJulP+PTs8vPhGReSqL7cLiJshKX2mgStO6jexWq5XTYXz3a4
         dlDwLnA70Osc/NcMD19waCdclUZhEhpPT3YvX70fvrPtkwpfoWfRYsSIMWWm1TPr4R3g
         wtip2f6VQant2A6znMhj7J7sUQEO7Sl44eUHHUi72FkP4knU/Aq9qTsYRtqVMqx0FHB4
         9cSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cNjFxmKQ9FWEVFi5C2WKFybYBlChY5kDF2lBxc753bc=;
        b=NRBVmUPzATKcOivxwAB/AkbUWe5qlA9ywEYlmOTPHd9MdnI3N/tTfaWnE1Dm0Ta6ut
         kSyyLUm+v91ACCPyW7rk/QhW/WpijcULAvD2efALyh/tPgwaqKxtTh8lxFGAFoKzePQl
         Ck3NxWhMhIk1ZW6y5cazv9UO2wXSkpnz9eKw79cG9nwryv4y2LYCmHXqFnJRMuZozmRz
         hoqWb77bEKrJuiTxw/SScyyIxm0TMS5mPVag7/Er2fGItXeY/EyWo/WGMXNSyu8t5oDP
         zJ+xpDNDpF9t27TGRxA60+y5aqgnOrriuC0jafptv+wwm1O4x9th5iLg0m5VqDOfDEx4
         21lw==
X-Gm-Message-State: AJIora/tvqECwjNFR/pCV8IU2vlsuzettUNRirrXSg7NVQL7kKyVVtVr
        jG9LdXmdmh9G5fEYQB7f3aM=
X-Google-Smtp-Source: AGRyM1u3PMNotc1f56NEP8yRtJWigBBt7SD8zRrMWRbuxt19SELHghjW65jt51eacplEp5/CY5XPIw==
X-Received: by 2002:a17:907:a046:b0:72a:b880:aa19 with SMTP id gz6-20020a170907a04600b0072ab880aa19mr8152690ejc.703.1656937592028;
        Mon, 04 Jul 2022 05:26:32 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm13974467ejj.112.2022.07.04.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:26:31 -0700 (PDT)
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
Subject: [PATCH 08/11] docs: ja_JP: howto: remove reference to removed submitting-drivers
Date:   Mon,  4 Jul 2022 14:25:34 +0200
Message-Id: <20220704122537.3407-9-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
References: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
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
corresponding reference in the Japanese translation of the howto,
with some assistance from Akira Yokasawa.

Link: https://lore.kernel.org/linux-doc/a2be48e5-e559-17d7-5ae7-d1205a737ea4@gmail.com/
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/translations/ja_JP/howto.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index 38fed6fe62fe..649e2ff2a407 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -129,8 +129,8 @@ linux-api@vger.kernel.org に送ることを勧めます。
     ルに従っているものだけを受け付け、多くの人は正しいスタイルのコード
     だけをレビューします。
 
-  :ref:`Documentation/process/submitting-patches.rst <codingstyle>` と :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
-    これらのファイルには、どうやってうまくパッチを作って投稿するかにつ
+  :ref:`Documentation/process/submitting-patches.rst <codingstyle>`
+    このファイルには、どうやってうまくパッチを作って投稿するかにつ
     いて非常に詳しく書かれており、以下を含みます (これだけに限らない
     けれども)
 
-- 
2.17.1

