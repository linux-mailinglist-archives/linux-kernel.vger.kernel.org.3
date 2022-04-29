Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856C5514485
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355939AbiD2Iqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355907AbiD2Iqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B7A0C3EAC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vubZvz77eO0eWEbWF5Lc06RI0x4vo6zT37jaMVflNHg=;
        b=XiAxzgHB2Dhdc8YX1ld9APi3S4VS01INXXVof4NqCySwhWEn99enr4vmtsvB8fy2HCF5lW
        xNGPVJutHoSqRavyUv/FgitWGyQnDzCzyxTkONI79ExgZC32XaeWip1Nk67zp6HySvcPc8
        70T2XFV0AyYOO6neQTVoCHXxe+1Z+6Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-iY_5bua_PUiItje3bFtS4Q-1; Fri, 29 Apr 2022 04:43:12 -0400
X-MC-Unique: iY_5bua_PUiItje3bFtS4Q-1
Received: by mail-wm1-f71.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so2224862wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vubZvz77eO0eWEbWF5Lc06RI0x4vo6zT37jaMVflNHg=;
        b=7X8v58dKXu/C6UIcmm6rR+hCqAQqSmj3/XAOq9mtTbOQGMynp9URwAVhib2luRAPRh
         sbetmUXOmQdPn2CLkHgM18hraUp6RasPg0ONU61k3dBaFbhYpDh+ts2IYyNrqO6cgFkT
         4hAaS4IHUe85xkrnuTfdKvg0bpzw1LiJ5dAXg9KnBHdp1cIYhnHlu121P9erlAZj0aa/
         CpRvXZswDQGWICvbK/pwBC1lB7w5J/KdxrF7u1RbH+81RyymFn+HOXCv1In+rvM+mbMF
         RPRXmJlcNyLzsjL2jVZT3YBqnlUSU0dbozBrBzPGnPPpDqzFwVbr3SjnXiWGD7LQOFuO
         xcOg==
X-Gm-Message-State: AOAM532cjVQoOppFDLdNwrFWkbZoGbaXfq+Wz3njHnamajJJiqGc7kMA
        pHzK5vIttczzpzqcV9vtgF1htYOd6fsQ0Daeuc6e7JZUnEXwIdI3KJ71/VoBIS3asnD4LaaCfSD
        YOGqlsbnqekbKpycsEEPIVFIxo9IMiNNGK5xh7htsC1M+5iPixa44gCWhxZGw/AbhZfxx5QF4rJ
        I=
X-Received: by 2002:a05:6000:c:b0:20a:df2e:2c38 with SMTP id h12-20020a056000000c00b0020adf2e2c38mr17607758wrx.481.1651221790788;
        Fri, 29 Apr 2022 01:43:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0tFeN1mlsIlAflE3jz2oXywVPeAUCPmToSm7Z6Ls+OM8AB5Vsy2UusgOW1eoW8qfxPH/hvw==
X-Received: by 2002:a05:6000:c:b0:20a:df2e:2c38 with SMTP id h12-20020a056000000c00b0020adf2e2c38mr17607737wrx.481.1651221790579;
        Fri, 29 Apr 2022 01:43:10 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:10 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [RFC PATCH v4 03/11] drm/simpledrm: Set the DRM_FIRMWARE capability
Date:   Fri, 29 Apr 2022 10:42:45 +0200
Message-Id: <20220429084253.1085911-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429084253.1085911-1-javierm@redhat.com>
References: <20220429084253.1085911-1-javierm@redhat.com>
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

The DRIVER_FIRMWARE flag denotes that a DRM driver uses a framebuffer
that was initialized and provided by the system firmware for scanout,
which is the case for simpledrm.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/tiny/simpledrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index f5b8e864a5cd..f039419d4d36 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -878,7 +878,7 @@ static struct drm_driver simpledrm_driver = {
 	.date			= DRIVER_DATE,
 	.major			= DRIVER_MAJOR,
 	.minor			= DRIVER_MINOR,
-	.driver_features	= DRIVER_ATOMIC | DRIVER_GEM | DRIVER_MODESET,
+	.driver_features	= DRIVER_ATOMIC | DRIVER_GEM | DRIVER_MODESET | DRIVER_FIRMWARE,
 	.fops			= &simpledrm_fops,
 };
 
-- 
2.35.1

