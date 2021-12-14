Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA91474664
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhLNPZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbhLNPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:25:37 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050A3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:25:37 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id iq11so14566887pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Vm1Fqs6tdlQlqFRvByXD9ZZ5ex3zALshKcVnK+T6aeE=;
        b=ofJ4teTiF+PAhd90t9KU1GXvhu3kCeT87aeJAZV+EgB5ABSkMMVeikE32eklERyxXJ
         plpbdFGxS98zl88Fv+fOD6GaqzxN2upiKJBSOmY73fsBPCp7r0hkMBld+zzkJx6gSAyh
         +sAsranIVKeSbl3ZfSu2RfTO90Pw6NgC0qhoXvc+qkl3MQSMAKYRvnsG7hqksSZ8bgIm
         QeN15HSpxht6QtDc3yace2C3nzSq5yy4WLgK5SViEPOKCQAf3dBJE0yBynhx0WeZxNKP
         DVO256ES3/2nmf9vzPtcL2PWGfyHUWLVfTUtYpr4/czUEj/xMDEUfVSjxuVxtdBOEEh/
         JBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vm1Fqs6tdlQlqFRvByXD9ZZ5ex3zALshKcVnK+T6aeE=;
        b=P/TlPq8FUbbWaA/TdebDgkw0ESKTfzQDqk4Zi/lq6DCPn/s6ZjhQtCYZ21M9wwmn4U
         +apWeW73AmttiSVgwkxNLUjyiiZuIucIJ0O9S167rmQsqUHSvR3EdkVAJQLnsVjgErUB
         4NAqz9Li5NVfAbIs91+2rWDySC5Ydl/kE1yn8JClzznkqaLpnn9mbZKJwKVh6ZRbVlHY
         o94f+0fsEv+InTq1ew9TsDisEhfJ9GQyszQ7a08mhzmYtQwSuF4TReUuMV1mA8fyn2N7
         RPrFBEhvrOTbChuG2oB7/hHYb9qzSVvRlbuaIoPky6EWffsUnYIeSjGjCFkweInlfP2P
         C9og==
X-Gm-Message-State: AOAM533/Bh818Zwi5PKlxQb1+BAdfhE+FbBJr2tvzV9kuuTTg9TNHOpj
        Kgx3LJMvRpbKiKKxMAelgfE=
X-Google-Smtp-Source: ABdhPJzu4M87hrW+1Y/9HZnnji6CqtIbx+N0tmAsFOXR2FraebwN2EVZQUi00br1VjVj7nJY62vxgA==
X-Received: by 2002:a17:90b:4b0d:: with SMTP id lx13mr6342088pjb.146.1639495536527;
        Tue, 14 Dec 2021 07:25:36 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id f5sm67707pju.15.2021.12.14.07.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 07:25:36 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wcd934x: Fix a incorrect use of kstrndup
Date:   Tue, 14 Dec 2021 15:25:30 +0000
Message-Id: <20211214152530.23767-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In wcd934x_codec_enable_dec(), widget_name is allocated by kstrndup().
However, according to doc: "Note: Use kmemdup_nul() instead if the size
is known exactly." So we should use kmemdup_nul() here instead of
kstrndup(). It's similar to CVE-2019-12454.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/codecs/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index e63c6b723d76..c6677cfbce59 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5005,7 +5005,7 @@ static int wcd934x_codec_enable_dec(struct snd_soc_dapm_widget *w,
 	char *dec;
 	u8 hpf_coff_freq;
 
-	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
+	widget_name = kmemdup_nul(w->name, 15, GFP_KERNEL);
 	if (!widget_name)
 		return -ENOMEM;
 
-- 
2.17.1

