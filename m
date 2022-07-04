Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F43565CAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiGDRRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiGDRRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAD7F120AF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656955036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVND3GM+OEtAkbTKlrFfIkv0IqFoHwP40bUkEd6doGs=;
        b=h6azpLayAiVFW90SHmYl37Xb/e5kPRPpqgoOaJYjsNr6kETP517q5j4CJOQKQ596WPStWW
        7EdB6reQY5iBS6FH1t1E1s9NWLzdhlwK8IcuLY/P8tPzGKLnGsfhrTK1RobWTkOYeKEt8H
        N/0DCJgfp+ZUNnw06Nj4qYTmSKn9CRg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-iy3fFZtXN-mJ4vJUCm58iQ-1; Mon, 04 Jul 2022 13:17:14 -0400
X-MC-Unique: iy3fFZtXN-mJ4vJUCm58iQ-1
Received: by mail-qt1-f197.google.com with SMTP id ck12-20020a05622a230c00b00304ee787b02so6199255qtb.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 10:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVND3GM+OEtAkbTKlrFfIkv0IqFoHwP40bUkEd6doGs=;
        b=FFzIFp1Y16atBUYAmOEcAPFLL32LJWWNXeBfJRPEITjpEfjTf/hyhUiRa+/MJ1lJ9e
         KKqBZDLh5x0O5yXfiBvNhhzaQEeNNHdu+Oaz+8hx8nGi4njGq+kc3Yo7BvxPFVWPJn08
         NJa4RLwsRuJjgW2XBXnJvFl9SfEweLc8uBXsm26xtIzKNriScveFVLF9OH84Rmw6gu1K
         wsCE88Nt0NYaH/bzEgisT7+vsWUg43hp6MBn64YX7rqFPYF1qxK9ZoBelNOlHpdQS6ZL
         yFRhUYAT81utJJoUq5R+Eia7zdY9GMSG0TjwYwoX7xrKAe3Jqrh9PWq9IEsN11Smsaty
         K6yg==
X-Gm-Message-State: AJIora+3cXE0PuzuTlki9vIapqvvbx2l2jmL6EbOl4aCdyFVp29WqIRj
        bhEG+WE1fRenphxrDVWo8f8IzAtEiuoh8XK5InGWKbVvHzmVcUGAcr2vpIomUwk3lZvHm1OOSxh
        JPs1y/sDmmPEXmVo35rWl8aoU
X-Received: by 2002:ac8:5b44:0:b0:318:291d:8f59 with SMTP id n4-20020ac85b44000000b00318291d8f59mr24361550qtw.22.1656955033389;
        Mon, 04 Jul 2022 10:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1srxXAHH5r1Kdxl8lINLquxuasM0BWZ/em5yNCcgZULj5nIl3JWsRbNRPyI0zQuAgROZCfdxw==
X-Received: by 2002:ac8:5b44:0:b0:318:291d:8f59 with SMTP id n4-20020ac85b44000000b00318291d8f59mr24361526qtw.22.1656955033118;
        Mon, 04 Jul 2022 10:17:13 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006a68fdc2d18sm21656078qkp.130.2022.07.04.10.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:17:12 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 3/6] virtio_test: call __virtio_unbreak_device
Date:   Mon,  4 Jul 2022 19:16:58 +0200
Message-Id: <20220704171701.127665-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704171701.127665-1-sgarzare@redhat.com>
References: <20220704171701.127665-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8b4ec69d7e09 ("virtio: harden vring IRQ") initialize vq->broken
to true, so we need to call __virtio_unbreak_device() before starting
to use it.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/linux/virtio.h | 2 ++
 tools/virtio/virtio_test.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 363b98228301..feb720d4304f 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -66,4 +66,6 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      const char *name);
 void vring_del_virtqueue(struct virtqueue *vq);
 
+void __virtio_unbreak_device(struct virtio_device *dev);
+
 #endif
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 23f142af544a..765e64895dab 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -177,6 +177,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 	long long spurious = 0;
 	const bool random_batch = batch == RANDOM_BATCH;
 
+	__virtio_unbreak_device(&dev->vdev);
 	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
 	assert(r >= 0);
 	if (!reset_n) {
-- 
2.36.1

