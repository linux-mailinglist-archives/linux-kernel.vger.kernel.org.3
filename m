Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E8651C60C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382664AbiEERaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382284AbiEERaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:30:03 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A036A5A153
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651771582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e98sMaFL76Y6Cm1rd8CKp7RmcgmlQurw+mFaLikvOas=;
        b=fEY+ioiscwNevPBKaAhKfOT5LehrNUfRhnddYz2a3ku9I4D/XJQNCMlj/mjd9zoqTXgpcc
        euTI/8MsIXDk4hwfIoHDE96gw+XaVVKn9ny8PxWFgY6LZ/ZhW5IJ9i6F4677k/j5goA+af
        Eb9HYv6UvcXnCXRJ2KEG99z9HxBEePQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-BLzZpnj2M_KU1FatnH5wag-1; Thu, 05 May 2022 13:26:21 -0400
X-MC-Unique: BLzZpnj2M_KU1FatnH5wag-1
Received: by mail-wr1-f72.google.com with SMTP id s8-20020adf9788000000b0020adb01dc25so1715244wrb.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 10:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e98sMaFL76Y6Cm1rd8CKp7RmcgmlQurw+mFaLikvOas=;
        b=k4JfT+qamfpkrko/z2ek7xEUWcfLL5WbqFcUsvcxzOZa54qgdmM/juA/ZWOFBqpC0K
         DSqB+0wKDq2uW/VMqcGXikDDq2jEatiBpeNi0CDfmjKtnR+IziS04rqK6uQu8PXA6F/8
         hTP7TPlq9mOQJGaFCZV2+THJO1ueZu80KNjjdlKScdWwHMaxj3f0U3bDSaTZEqzHa9NI
         0vAD9QriVOHrT0FWvbrT5ooWc8j6pyiNER45c8dJ65Y1gKrs2reaHKqNvVW1kXxhSUoU
         Mt9EZbbxdRdzx8vPGAmX+AtSUUBvFezU+QeVjC3IGlQwBunR1Sf/ACuhw/35ePZIfd4S
         xYAA==
X-Gm-Message-State: AOAM532KiXjD0hD3nvlF32QxhcHdEmpM9eJZtHYwREmaEvCaqa2TXzJN
        h37hhuvCINfFDn1BaorCdRdIVZMpyMkT8A+7QCy96sW8/SGMPBAwZui+qjPWrjAByBqTlEG3fMe
        lQSnW9yhO6KRMt1Kiclu8jvf1wGgDKg0ZIJWOAay+SxwC5PMcD24wCPHSqThTEWFJ8cSYt+ZBSz
        o=
X-Received: by 2002:a7b:c341:0:b0:37b:c619:c9f4 with SMTP id l1-20020a7bc341000000b0037bc619c9f4mr6107282wmj.38.1651771580363;
        Thu, 05 May 2022 10:26:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxki7iyu9gMgTY/R73KgvCenycMwZNSN+eMekiPcpV176MYO3mdFF8N0nyze9RG5OhqyF5WDw==
X-Received: by 2002:a7b:c341:0:b0:37b:c619:c9f4 with SMTP id l1-20020a7bc341000000b0037bc619c9f4mr6107261wmj.38.1651771580129;
        Thu, 05 May 2022 10:26:20 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e20-20020adf9bd4000000b0020c61af5e1fsm1692780wrc.51.2022.05.05.10.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 10:26:19 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH] MAINTAINERS: Add simpledrm driver co-maintainer
Date:   Thu,  5 May 2022 19:26:10 +0200
Message-Id: <20220505172610.338299-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas asked me to serve as co-maintainer for the simpledrm driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a04950c1a8f..bfe43560f9d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6389,6 +6389,7 @@ F:	include/uapi/drm/savage_drm.h
 
 DRM DRIVER FOR SIMPLE FRAMEBUFFERS
 M:	Thomas Zimmermann <tzimmermann@suse.de>
+M:	Javier Martinez Canillas <javierm@redhat.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-- 
2.35.1

