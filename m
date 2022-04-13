Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE374FEE54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 06:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiDMElf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 00:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiDMEl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 00:41:26 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926CA26AF9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:39:06 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c1so536890qkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rd3KV41aUoY+ervcunShKpSHVvLcMJA0NVeQFOWrEOo=;
        b=Fko+lRIQ+iVCWipOu317fjQBzqjCPXywqFfMsUje86jO61YwV9ENKJp21iWm8fi1Yk
         p3MIgBvpOPGhDHo83hREOzQ1q/wfHMzkP8cMdvdBU0k3lO7kvz9sbmgoXChzhhbUrWw7
         uE+qADA2tgE11qICvJKLpPsVwHg1Po9CbUH9bAhZHtQihdP9zbi7y023f45LO4tp0NoA
         jWdY8kMz6U1kCbUXegr9kHNJTxCMuRe+kSK7R6D7WX1rdOFB87SLIBQgYxlSscfhKhSE
         QCVXP6C8y02Anf8FAPz7GXFgr0wCJf79jpwiq7fbIeg8fURMr9LmzlGpdlqkHB7Lvtbj
         M4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rd3KV41aUoY+ervcunShKpSHVvLcMJA0NVeQFOWrEOo=;
        b=uZmpipmLWoVQL7FB+ShkGQSna3kIUiiEkLBHwSPvJDVwtK+jKFKPXNHGyhfdTv4dZc
         kbZR6m48aIfypCd+0V1a41SLi24HeJaTUHMu7Zxveef+kugYezl27lX9OsADX/ZFin7y
         dlco1F0PPEq9jrbQU3MEHrH8KvoxlQvfhmZmvAiCHyK7YAaVb1ACCcOPvpFhx8Zud6Fi
         w0L0LWaox78AD5QutxI8zfPBr5z9yNR3sSBeiQFfYJwV2NLnf7xQk9JDAV2XNTNbKxEO
         1U0q5n2euy1qjdD5nIC9Oe6gtMVOZ1bcHIvmbBv9eCueMJ46d9KqwpQZ6mTMRMJbbzdr
         VVKg==
X-Gm-Message-State: AOAM532BtGxQNXit0rv12AbBYe/o2JcYi4xGg+hchEEm29hHzEEdrWLs
        M7takgYMauxFfVyEB1RHbYI=
X-Google-Smtp-Source: ABdhPJyha8Jh0Jjw2gWznz3dhHKao6JCzsLs2GXNsC/68UHN0IVtd0KMHCh/GiGc+pTjUiDxr7XVkA==
X-Received: by 2002:a05:620a:d4f:b0:67e:9cbf:a969 with SMTP id o15-20020a05620a0d4f00b0067e9cbfa969mr5581732qkl.509.1649824745762;
        Tue, 12 Apr 2022 21:39:05 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:50fb:900e:5e57:caff:f44b:33f4])
        by smtp.gmail.com with ESMTPSA id d126-20020a37b484000000b0067e60283d08sm21984056qkf.40.2022.04.12.21.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 21:39:05 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        jhpark1013@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 2/2] staging: greybus: remove empty callback function
Date:   Wed, 13 Apr 2022 00:38:52 -0400
Message-Id: <12037ae2502ad7d0311bcdf2178c3d2156293236.1649824370.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649824370.git.jhpark1013@gmail.com>
References: <cover.1649824370.git.jhpark1013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the optional remove callback for the soc_codec_dev_gbaudio
structure. The only place it is referenced is
snd_soc_component_remove() which is only called if the sound_component
pointer is non-null. The null function pointers here can be optionally
ommitted. When a sound component is registered this way, the remove
callback is optional. We can safely remove the whole gbcodec_remove
function, which used to be an empty function with a void return type.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 0f50d1e51e2c..dc030caa64ba 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -1029,12 +1029,6 @@ static int gbcodec_probe(struct snd_soc_component *comp)
 	return 0;
 }
 
-static void gbcodec_remove(struct snd_soc_component *comp)
-{
-	/* Empty function for now */
-	return;
-}
-
 static int gbcodec_write(struct snd_soc_component *comp, unsigned int reg,
 			 unsigned int value)
 {
@@ -1049,8 +1043,6 @@ static unsigned int gbcodec_read(struct snd_soc_component *comp,
 
 static const struct snd_soc_component_driver soc_codec_dev_gbaudio = {
 	.probe	= gbcodec_probe,
-	.remove	= gbcodec_remove,
-
 	.read = gbcodec_read,
 	.write = gbcodec_write,
 };
-- 
2.25.1

