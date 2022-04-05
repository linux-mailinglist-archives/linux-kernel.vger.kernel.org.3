Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498D34F4900
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389301AbiDEV7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573250AbiDESdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:33:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2A913F81
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:31:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z12so24774334lfu.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yax7P8EHkvsWnyvnaOpe3ZP8r2G7HKN+i3pXtBsfClM=;
        b=AlOylQ0jQKVcFM1G55vgGfIw3N7jIKcPb8Fyyp/oULoQtqlhNXFckkFd9+WqoIycaG
         j3uSXFSnN9MUKlSNkyQuzzYQaqjV8XGOAV98W2dX0/cu0rYAgesS6ZgugsjdK/H/2jkk
         fnbt8Gy5iVlTh1oKRiKygkFT2D7usXujbRj9wtNhFNlx0xb1yHFF5nZCSug2Yffskd6k
         SQbOTL8qdWillxUg7Hfyk1Z4yt900US5/buZ6HSUAnvFJUJzW3ZTTDpX+yeyxCzbWSFK
         f/y1ax+r51kD23D/27l7CsWDA8dkGaWmjrSo4eFHKK9DHWERyMZIp7K7VdiMTWXaCd66
         t7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yax7P8EHkvsWnyvnaOpe3ZP8r2G7HKN+i3pXtBsfClM=;
        b=buQahpw01XwzxpClucWcNEWCeBLnkS4lpP65I31PbvejS2LZ2sSEkT547PL6RIDKqx
         VLlw/c0LN6EUoukge228Ubziag6eFpGLx4YnfTYNhXTRibHwSd/xlQ1kXJBURmbPxaAg
         2/aj2rYSDP51FxKtQxJpDeh+nskoJD9VQUuNlSSIUJSWfUFIC2YRSO7A2oNoPe3tP5M5
         R7YwFu8YmY7vGG5wk3FmYO8AH/yla/1CWWBe963zuU/iE75KaALbU9WJ9Dyz2riazRIu
         EKMRGFcoSIeQ3DAcD3bjjKdVQUZj0WQ93WuVN5t3ICOJG1dRAsFQClKNUqpQ5jjCLFED
         suzA==
X-Gm-Message-State: AOAM531QXaTsZlhsORrmGr8a9IVgKN+ckFH2jTQ2Y4I0IXxziqP6jRjA
        urPesaDuR14wBkwttLDq2BahSA9KG63Bmw==
X-Google-Smtp-Source: ABdhPJyytKONlFFPhM6uOSKsPqQ+53tg6aHeIXEVboaJV0vQ5E/W25OXeJQjKEHyzo/lHMBfI33Qlw==
X-Received: by 2002:a05:6512:2347:b0:44a:6e3f:74f7 with SMTP id p7-20020a056512234700b0044a6e3f74f7mr3457813lfu.660.1649183468960;
        Tue, 05 Apr 2022 11:31:08 -0700 (PDT)
Received: from noname.. ([2a02:2698:8c2a:226e:6d9:f5ff:fecb:a8ab])
        by smtp.googlemail.com with ESMTPSA id c5-20020a2e9d85000000b0024b1571209csm800133ljj.0.2022.04.05.11.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 11:31:08 -0700 (PDT)
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jiawei Gu <Jiawei.Gu@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Accessing to a null pointer
Date:   Tue,  5 Apr 2022 21:30:19 +0300
Message-Id: <20220405183020.9422-1-h0tc0d3@gmail.com>
X-Mailer: git-send-email 2.35.1
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

A typo in the code. It was assumed that it was
possible to shift the pointer to sizeof(BIOS_ATOM_PREFIX) - 1.

Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e729973af3c9..be9d61bcb8ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1426,7 +1426,7 @@ static void atom_get_vbios_pn(struct atom_context *ctx)
 
 	if (*vbios_str == 0) {
 		vbios_str = atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);
-		if (vbios_str == NULL)
+		if (vbios_str != NULL)
 			vbios_str += sizeof(BIOS_ATOM_PREFIX) - 1;
 	}
 	if (vbios_str != NULL && *vbios_str == 0)
-- 
2.35.1

