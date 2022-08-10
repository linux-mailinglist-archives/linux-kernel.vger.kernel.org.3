Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C356558E9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiHJJod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiHJJoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 088A052DF0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660124639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2PRyz9SGjKoLZlYF6JLzg9mzaDVsgEeEMI7cjuKE+0=;
        b=asBq+1TfVFvM1bedBUJfiDA2dtD1mmWxAq5heZ8d78g+Stu3RhbQfob3TdOgNYlIimfHBn
        DGRafijuSuGGUK4CZA4sjoiNuJhxkFw76aPcttiZhSocJPOyeZUidjsQTCsTng3DHXHVAn
        THKha1oNqdBukMoEnlGs5KBvHcMU9VY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-cyhY5qzjMEyQ1fRC7ssZ4w-1; Wed, 10 Aug 2022 05:43:58 -0400
X-MC-Unique: cyhY5qzjMEyQ1fRC7ssZ4w-1
Received: by mail-wr1-f70.google.com with SMTP id w20-20020adf8bd4000000b002237e71d4e4so152446wra.21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=b2PRyz9SGjKoLZlYF6JLzg9mzaDVsgEeEMI7cjuKE+0=;
        b=qbK0cEEFBvReEQkZQIs/zEDwhbhd1BGao7Rd4m8fm9HNyZImdL2euE/PAldRpGcaxt
         Hf274t6n6Sb4wjqn5tjhYBGgsF6mjDTbbmOPZhfUcCDItj/we7XluNLnUUxehwXQ1z5F
         bsIur9hMhJmoSplHT5l/skZy+DvQzcLhAzpP21SAMvgRAFj290H/6p8Ulu9+o0wBzNUG
         GlQHqPAyXQVOaUltjnJziOb7X0fUegrY67BXt6y4yl/o/Oq2U6i/yRt1WD2QV3UmnyFM
         KZtQF+GXFJdC4eE5dmGCdeRee2RS9Q/Iz7EkDe5jRAu1lE46h1n+2xVas/SyDFUFvNs2
         yTFQ==
X-Gm-Message-State: ACgBeo1YeQGxd6MAqt5Ss+Fvdj3YzcJ3+052TDWzq18IXVCCXJ8/qUcG
        81gl4rXILor/bygDdTtUlL6R8Qx7haKMdS2upB/CC5jXgfS6gABZ79TOkD/mKP3vMpPtDqcZVPW
        8fmX/8TMo8a/hk5KkgGexZ3E6
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id b9-20020adfd1c9000000b0020fc3dce980mr16506750wrd.552.1660124635489;
        Wed, 10 Aug 2022 02:43:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5G624psAQ0CDHz/tX9HGp8fAwlc2Q6jgDrVstRV8Ex4w7YsTXeGAp2caKRmTJ7VelfCf8tkg==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id b9-20020adfd1c9000000b0020fc3dce980mr16506738wrd.552.1660124635306;
        Wed, 10 Aug 2022 02:43:55 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id q11-20020a5d658b000000b0021e4bc9edbfsm12921743wru.112.2022.08.10.02.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 02:43:54 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 3/4] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
Date:   Wed, 10 Aug 2022 11:43:46 +0200
Message-Id: <20220810094347.20449-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810094347.20449-1-sgarzare@redhat.com>
References: <20220810094347.20449-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
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

The simulator behaves like a ramdisk, so we don't have to do
anything when a VIRTIO_BLK_T_FLUSH request is received, but it
could be useful to test driver behavior.

Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
that we support the flush command.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 24dd9cae6450..1f18f336cf0c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -25,6 +25,7 @@
 #define DRV_LICENSE  "GPL v2"
 
 #define VDPASIM_BLK_FEATURES	(VDPASIM_FEATURES | \
+				 (1ULL << VIRTIO_BLK_F_FLUSH)    | \
 				 (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
 				 (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
 				 (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
@@ -188,6 +189,10 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		pushed += bytes;
 		break;
 
+	case VIRTIO_BLK_T_FLUSH:
+		/* nothing to do */
+		break;
+
 	default:
 		dev_dbg(&vdpasim->vdpa.dev,
 			"Unsupported request type %d\n", type);
-- 
2.37.1

