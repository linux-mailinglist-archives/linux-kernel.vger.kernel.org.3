Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CD350CD57
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 22:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbiDWUFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 16:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiDWUFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 16:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36DF6191C46
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650744124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TmI4HuYyRoxvHL+vw/EIwCgtYuWPzs344Ybx3U2pVv8=;
        b=PMthp5y5Ecn522rZbzbXfwDy5F6wQnXvfd7EqQzGbVFiwqG8k9Oyil8cpQHiygACDAW/tW
        A7zUTKgRkt8yX9YyVK8JSDw7zlQGZ60BKh5pJDqltj8U9pLr9euAjD2vxlJpQ9yo5wUVoq
        M1rIgoHP4gibIEzvhzWK5kpls+rkRaI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-CK_WC18VPxOPC_anD1-Wxg-1; Sat, 23 Apr 2022 16:02:02 -0400
X-MC-Unique: CK_WC18VPxOPC_anD1-Wxg-1
Received: by mail-qv1-f70.google.com with SMTP id fw9-20020a056214238900b0043522aa5b81so9321454qvb.21
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 13:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmI4HuYyRoxvHL+vw/EIwCgtYuWPzs344Ybx3U2pVv8=;
        b=ctFCMaxZXqxY0bMa/n+S7P6Uy3KuE4s5MebGXyKX5PJ5M3Gu/XLlQud6RWX2p2cIE5
         8qHreuV61IYt0H+4IUkE9V98vlOKXcXmM0dc4adrToFLM7f65nmHY0BTjgCBs80F08/x
         O1gb/DgIH8vsHCgSu/JcvWh57t5QF0yEGNOOfSxiYYUO+3LB6wgXymkNbZ05dtA8CEUz
         PT6RWVCkbuFCahCund72zGJKyWcHp76xFIqLJGWApAQ8uBoa9dEdZTwl69RV5eXfWsX9
         sjw7j2jzH9fYXU5fdZMaiuUPTS6XCjItDlPv1MYtmUObhS6cpNZGkGNBroJdzg1G2Q6g
         YZxg==
X-Gm-Message-State: AOAM532JW+wJSq6LnMnXY1KCOObisbpTNuw9aYsKiQOF3OhZFoPzQy1n
        TqPa+acFr1U2Up/3VM2h3+oUUoANh1pMfVFgOvgHCvva6B9HHVYpAp6Rn/LO5zYRWSLzrdjWAOv
        weku21PDHROWvzhseppEhZKgi
X-Received: by 2002:a05:622a:1b91:b0:2f3:45f0:d9fb with SMTP id bp17-20020a05622a1b9100b002f345f0d9fbmr7608093qtb.147.1650744122263;
        Sat, 23 Apr 2022 13:02:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmfh+uSxEWKmvVX8l/LATjWvc9VwFZNJueNhicXlKtCgy74l29do1f86Ksx39bNBVQ+S9p3w==
X-Received: by 2002:a05:622a:1b91:b0:2f3:45f0:d9fb with SMTP id bp17-20020a05622a1b9100b002f345f0d9fbmr7608083qtb.147.1650744122071;
        Sat, 23 Apr 2022 13:02:02 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e26-20020ac84b5a000000b002f35d11c5dfsm2348748qts.65.2022.04.23.13.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 13:02:01 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/radeon: change cac_weights_* to static
Date:   Sat, 23 Apr 2022 16:01:55 -0400
Message-Id: <20220423200155.1735336-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports these issues
si_dpm.c:332:26: warning: symbol 'cac_weights_pitcairn' was not declared. Should it be static?
si_dpm.c:1088:26: warning: symbol 'cac_weights_oland' was not declared. Should it be static?

Both of these variables are only used in si_dpm.c.  Single file variables
should be static, so change their storage-class specifiers to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/radeon/si_dpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 3add39c1a689..fbf968e3f6d7 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -329,7 +329,7 @@ static const struct si_dte_data dte_data_malta =
 	true
 };
 
-struct si_cac_config_reg cac_weights_pitcairn[] =
+static struct si_cac_config_reg cac_weights_pitcairn[] =
 {
 	{ 0x0, 0x0000ffff, 0, 0x8a, SISLANDS_CACCONFIG_CGIND },
 	{ 0x0, 0xffff0000, 16, 0x0, SISLANDS_CACCONFIG_CGIND },
@@ -1085,7 +1085,7 @@ static const struct si_dte_data dte_data_venus_pro =
 	true
 };
 
-struct si_cac_config_reg cac_weights_oland[] =
+static struct si_cac_config_reg cac_weights_oland[] =
 {
 	{ 0x0, 0x0000ffff, 0, 0x82, SISLANDS_CACCONFIG_CGIND },
 	{ 0x0, 0xffff0000, 16, 0x4F, SISLANDS_CACCONFIG_CGIND },
-- 
2.27.0

