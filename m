Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55A44D05AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242740AbiCGRuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiCGRuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:50:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 536BCA1A6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646675362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WjmvGsZUfh0/LVVvQ+FZnEKXpArrzRi5L5/MW0I2M4c=;
        b=VDySvamA/Em7wgzBh+sF0wb6xJP8hx/X7VSOoxMVUJBIXZ4f3Vag7BZdIW/3SiwH7Jj0zc
        dmIAdjgBeRaDzurZvWNUlkw5LLWGeByP+9hYURlur+U/MYDCqUNLJEnn3Icfu5DpXCfaCE
        SkDIIm09ysSXyd8Mc/DT26OBIot13pU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-D7OmbKLMOr6_2SEoPGdQmQ-1; Mon, 07 Mar 2022 12:49:21 -0500
X-MC-Unique: D7OmbKLMOr6_2SEoPGdQmQ-1
Received: by mail-ot1-f70.google.com with SMTP id m7-20020a9d7e87000000b005af1551b419so13558204otp.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 09:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjmvGsZUfh0/LVVvQ+FZnEKXpArrzRi5L5/MW0I2M4c=;
        b=4i0Y5TMYoEROvtHb7/bKkvJBtEb6t5Jzv0taeEsYvbrDw7w0gh01Mccwzttph7ln+c
         MEtnEgGcdCW1RUY1LxzVmM/L38Gnfa4QDrzub92lvrBLLXK/vFF1eiCRwXvL7AWv34fy
         KZ7lSju05QP5ICYeSOLVMBYephNktt31L6eCISB7T06O4Cb3kI7/OJLFhp/NCwz01ELO
         33C5eHkVG9qbtIG8jGo1Y01p4uLPUzgIU3aXQOyNCtodwk4+gKOlQgpZi5k/k0QTpBYT
         vRnu/0Z9s7h4Y1PfpXunB4PeTSwfRwMN+JRQNZQgUrQ22bAQEVazd9iJz8emN+AJIlYH
         ZhMQ==
X-Gm-Message-State: AOAM531GMlAYRV3FhZvE/85RR3ZnkSXMjEGtsEd4VRJ/QurPQygmmspy
        RzYoPOtB1H1E76hcGygEykaGxzHCEbD+z50YJP99mUH+W5Uhq4LvcBXUdOnRBnaqDE+0S43LhC4
        j2LHOK6jIyN+gMUc8cj03rXga
X-Received: by 2002:a05:6820:188f:b0:31c:f277:b473 with SMTP id bm15-20020a056820188f00b0031cf277b473mr5199304oob.51.1646675360812;
        Mon, 07 Mar 2022 09:49:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW27+RoBUGuOR02iKAwaAC7oA6O5mFi5GTvGrqEDVLIeNffjired4MrR2gOCNb8+5KybmYtw==
X-Received: by 2002:a05:6820:188f:b0:31c:f277:b473 with SMTP id bm15-20020a056820188f00b0031cf277b473mr5199293oob.51.1646675360638;
        Mon, 07 Mar 2022 09:49:20 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w25-20020a4a6d59000000b003208276963esm5423521oof.14.2022.03.07.09.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 09:49:20 -0800 (PST)
From:   trix@redhat.com
To:     mst@redhat.com, jasowang@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] virtio_ring: Initialize vring_size_in_bytes
Date:   Mon,  7 Mar 2022 09:49:16 -0800
Message-Id: <20220307174916.892433-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

On the clang build, there is this error
virtio_ring.c:1772:26: error: variable 'ring_size_in_bytes'
  is uninitialized when used here
  vring_free_queue(vdev, ring_size_in_bytes,
                         ^~~~~~~~~~~~~~~~~~

ring_dma_addr was intialized twice, once with the ring_size_in_bytes.
value.  So fix typo.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 905c882600618..b2b567ebb9120 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1756,7 +1756,7 @@ static void vring_free_vring_packed(struct vring_packed *vring,
 	ring                  = vring->ring;
 	driver                = vring->driver;
 	device                = vring->device;
-	ring_dma_addr         = vring->ring_size_in_bytes;
+	ring_size_in_bytes    = vring->ring_size_in_bytes;
 	event_size_in_bytes   = vring->event_size_in_bytes;
 	ring_dma_addr         = vring->ring_dma_addr;
 	driver_event_dma_addr = vring->driver_event_dma_addr;
-- 
2.26.3

