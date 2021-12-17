Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521C247819A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhLQAiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231293AbhLQAiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYOa0F3jqaQqpv+N8rljaqNHk1HiWXZfWmsXt7P2ADU=;
        b=BHPWyCl1b5ZTOlCS+57mt+OAKpBe2eaIFwG4gqYcXciJ8TiahDMxj5owKHpHdtBA/HgvRm
        G6pnuJ9gosm213pEY8/8ib7IfWuyHtff2SNvMokCCW8izWJARp2DGyiNlhkuCmRag5INuS
        rKLKuUESN9F8bDx/A20YANpcSLJ5Ii4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-iL6eNB3WMMCimji5H7CLPg-1; Thu, 16 Dec 2021 19:38:23 -0500
X-MC-Unique: iL6eNB3WMMCimji5H7CLPg-1
Received: by mail-wr1-f72.google.com with SMTP id v15-20020adf8b4f000000b001a24c46d6ceso143838wra.15
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYOa0F3jqaQqpv+N8rljaqNHk1HiWXZfWmsXt7P2ADU=;
        b=M9h0a1q0iX5AOuxhSgS5e110gpzzEI+sVeOQPH6ZBrXPRz3hGMjlEWBO37u/Jr0pFq
         2/MWUl0j83sBL/fdSWG4Fq0LXXCxWJZByfpCKVjvUkjnezEmZDg/ulmIke60I+C01JgQ
         YDs0gdgYCNKYfGeKWvTEoG8Enrnh0MIIj7I/2IxijsD48Q1nNwbpj7J9OL8dMshnAkc0
         sfj1l9ZVVpUjzCxfVaB22AT7B01faCWjASJzIiT7aoNkhvyIc0S2uJk1pr4J/I5eTRcY
         HOjHKTaakcCczV2NrwrKT7bP7CwUCkyagjweIvDPvpOPiTgVFoTkdfHoQqSmiWqbrElr
         eq/g==
X-Gm-Message-State: AOAM533QFlcCmvn71AuUUktknTN/GDD/5u497WVk/O9w12XSFqnAXUyz
        RCoZOE2rtpPPbH6BECyFzOtzPiDTGGRtgyMWe7Bng8wqp+vege6stCXj+G6VskG4aRKJ+sM1bet
        sIndnxPjHSK3421NMmU75ndq87w86FPEX+IpUtHuOBqBsrsndP8D6SlmqTJcaMgQAzNRmUcE+FW
        8=
X-Received: by 2002:a5d:6e8d:: with SMTP id k13mr363714wrz.449.1639701502112;
        Thu, 16 Dec 2021 16:38:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxTViLGqNo1DGlMqBapIEqyC75s/aJw0u0oxAO3rcEgKyVzTALKlCVK39UtqnhY5i7uh+BBw==
X-Received: by 2002:a5d:6e8d:: with SMTP id k13mr363703wrz.449.1639701501862;
        Thu, 16 Dec 2021 16:38:21 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:21 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH v2 24/37] drm/hyperv: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:39 +0100
Message-Id: <20211217003752.3946210-25-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to disable Documentation/admin-guide/kernel-parameters.txt, this
parameter can be used to disable kernel modesetting.

DRM drivers will not perform display-mode changes or accelerated rendering
and only the system framebuffer will be available if it was set-up.

But only a few DRM drivers currently check for nomodeset, make this driver
to also support the command line parameter.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 00e53de4812b..4a8941fa0815 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -305,6 +305,9 @@ static int __init hyperv_init(void)
 {
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	ret = pci_register_driver(&hyperv_pci_driver);
 	if (ret != 0)
 		return ret;
-- 
2.33.1

