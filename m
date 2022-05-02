Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD1A51700B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385182AbiEBNNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385169AbiEBNNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2409192A0
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651497002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WaotQP90v4LJiFV9U7D4wGlm3uQ+5ZZcBUavInrV48=;
        b=Z+proRlf13zm9Avmvo9+QkoMJaTo3lq0noMcw/KqrMgEWjSiqoIkaLs7xkWq+nui4NC8pg
        0p1xtbLG7nKXnr+KZQZM7Fy895r8Sgup6Wawa1y1787qdTCsrAteoXbsnIu5Gh6xs6DbCP
        G93ig+5R45LZrvsQlD3n1zFrUhee8EI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-aVN2osgTOAKKpZ3z2bYaSQ-1; Mon, 02 May 2022 09:10:01 -0400
X-MC-Unique: aVN2osgTOAKKpZ3z2bYaSQ-1
Received: by mail-wr1-f72.google.com with SMTP id e21-20020adfa455000000b0020ae075cf35so5326506wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 06:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WaotQP90v4LJiFV9U7D4wGlm3uQ+5ZZcBUavInrV48=;
        b=y++uUlQW3CUnV1pm6WqhW1UQalRIMTHT5D8XUO0BTUFS71ibR4QEjk72ZrfObQHHm/
         FYPMZWl3eN9O2ochMyPBsRpTyMZGkRkUCMQjiGH51hgNrocVB3TllDxlD6T/1TXGIX7j
         RWgaokW0NM1kMgHWojeiHTLP2HUIMjMWLAfkgxmtWi1GPz+7VmM76sSGnrZQT4re+WbN
         Q/nSeA1hc00uaLsQpxqkEkbkK4brd2XzC88xretTbVwDzwQi16BI/tRyOG6vpLqCqheW
         AHE2Oss2AvzyEX9d4jF+Top6hukQyPls2th4oW3tWFZhrMtvjZFWjbje0x9pd1XJNQYd
         GbIQ==
X-Gm-Message-State: AOAM530aVd1ljyG32ZdKSI28twK9Rk+5qKu9DBL/0zmKYHCIcTOA17q6
        m6MwvKga/UB83RxiK4dtrMK5RjqBWxl/SofDP49hq8HenIMrNFoczFI1/Ejbk6PZ0DTi5pXhRLI
        Ccgzep6r0cfubkTBahMwH96Mulx8KEQA7/oKmRxD1J/N4o7J34dLwQzxLlYggkXd2F9nipFRfSY
        A=
X-Received: by 2002:a05:6000:1707:b0:20c:660c:7c78 with SMTP id n7-20020a056000170700b0020c660c7c78mr2875397wrc.150.1651497000507;
        Mon, 02 May 2022 06:10:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjmpu5DF0NDgIenLWQrfwWpzc9ggipOyyqoLLJb25FhgbRN0nzSaLoP3BCeGiVSQj+kuDHOA==
X-Received: by 2002:a05:6000:1707:b0:20c:660c:7c78 with SMTP id n7-20020a056000170700b0020c660c7c78mr2875372wrc.150.1651497000266;
        Mon, 02 May 2022 06:10:00 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y16-20020adfc7d0000000b0020adc114136sm9302081wrg.0.2022.05.02.06.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:09:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 1/2] fbdev: Check in file_fb_info() if the fb_info was already been freed
Date:   Mon,  2 May 2022 15:09:43 +0200
Message-Id: <20220502130944.363776-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502130944.363776-1-javierm@redhat.com>
References: <20220502130944.363776-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If real driver probes, the fbdev core kicks out all drivers that are using
a framebuffer that were provided by the system firmware. But it could be a
user-space process still has a file descriptor for the fbdev device node.

This can lead to a NULL pointer dereference, if the framebuffer device is
unregistered and associated data freed, but later in the .release callback
is attempted to access its struct fb_info.

To prevent this, make file_fb_info() to also check the fb_info reference
counter and just return NULL if this equals zero. Since that means it has
already been freed.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fbmem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 84427470367b..20d8929df79f 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -751,8 +751,13 @@ static struct fb_info *file_fb_info(struct file *file)
 	int fbidx = iminor(inode);
 	struct fb_info *info = registered_fb[fbidx];
 
-	if (info != file->private_data)
-		info = NULL;
+	if (!info)
+		return NULL;
+
+	/* check that the fb_info has not changed or was already freed */
+	if (info != file->private_data || refcount_read(&info->count) == 0)
+		return NULL;
+
 	return info;
 }
 
-- 
2.35.1

