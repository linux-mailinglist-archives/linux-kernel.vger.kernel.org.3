Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E2A58E9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiHJJoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiHJJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FC145070F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660124634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxa8o9Tbfqnk5UAsXfKTjPHNDbYRHlKkIXBkapUnTe8=;
        b=OtdfsynKlDxAJByDl+XOHewhNzDjs41yv+uC67M3otEINfR7aTXbDYQrx/LzrtmAc30Fm6
        5ueBIgCYo7dzUKI+1EnRf1hUWhzSX8QZNNRXIwgGnKji4VBStLqtB3M12kyPbZxEKqt6Wj
        Ui+O7w2kZvz2hOgKLkIrxljnXJx6/cc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-SVq3H4QXNb-QrcTMdb6RIw-1; Wed, 10 Aug 2022 05:43:53 -0400
X-MC-Unique: SVq3H4QXNb-QrcTMdb6RIw-1
Received: by mail-wm1-f72.google.com with SMTP id n1-20020a7bcbc1000000b003a4e8c818f5so391052wmi.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bxa8o9Tbfqnk5UAsXfKTjPHNDbYRHlKkIXBkapUnTe8=;
        b=h1fDVo6i3xsT6Ci10Y09cWa5dPIIJxXYRSficE/hrqi+sbzw8KYCv/5u4/Ol7Jq97V
         KBKBkuzQhODlPiAusZg4nXZTKZ0SN2rU14A+lrpKlY7r/jh2IFoG6OliMtFzAweFHfYA
         veuI5bzlbSNCcdrDhaWA3TN+0hXbT7/eZA6W+kPfMTUgG/I5m9LO6EN32exzbO6SfO1n
         P2jyS+bGQ3ZvNNQjOXFC24g4L8d0Uxhvfq5U/GpZ56huNSxCw1UoAcNWQK8cUKTvuOmG
         WYUigwwTZOX80KcBLW4jzwqgmlNAVc5gjr8MV3BaG3zmONJzEaqakN6bXeWgUH1DHbsS
         GWPQ==
X-Gm-Message-State: ACgBeo3Do6v+kjGxEwD3MoLH7L4gOxp1dCv91FPQjorxNtnJywW+NCr/
        pflwXNda7NS8IBQVYwbLjQJWfL45ozKbuwNYYUzrdAyU68cbBsZ/SjBTFiK/QLr2MVy4OtKbbcC
        jZx1O8O1M5/U2ii9wZk8fBrgI
X-Received: by 2002:a05:600c:1c19:b0:3a5:a3c7:3800 with SMTP id j25-20020a05600c1c1900b003a5a3c73800mr1842909wms.69.1660124631891;
        Wed, 10 Aug 2022 02:43:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Jxsv0aCcVhfY1+aZAP46TL6gSQU1Nu4jG9pvamIlkWl0TlioV7Jo9df4vCccE3CDr541Q2g==
X-Received: by 2002:a05:600c:1c19:b0:3a5:a3c7:3800 with SMTP id j25-20020a05600c1c1900b003a5a3c73800mr1842898wms.69.1660124631718;
        Wed, 10 Aug 2022 02:43:51 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id q11-20020a5d658b000000b0021e4bc9edbfsm12921743wru.112.2022.08.10.02.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 02:43:50 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 1/4] vdpa_sim_blk: check if sector is 0 for commands other than read or write
Date:   Wed, 10 Aug 2022 11:43:44 +0200
Message-Id: <20220810094347.20449-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810094347.20449-1-sgarzare@redhat.com>
References: <20220810094347.20449-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIRTIO spec states: "The sector number indicates the offset
(multiplied by 512) where the read or write is to occur. This field is
unused and set to 0 for commands other than read or write."

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index ba253f8bce32..69c9f4f36f9a 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -112,6 +112,15 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	offset = sector << SECTOR_SHIFT;
 	status = VIRTIO_BLK_S_OK;
 
+	if (type != VIRTIO_BLK_T_IN && type != VIRTIO_BLK_T_OUT &&
+	    sector != 0) {
+		dev_dbg(&vdpasim->vdpa.dev,
+			"sector must be 0 for %u request - sector: 0x%llx\n",
+			type, sector);
+		status = VIRTIO_BLK_S_IOERR;
+		goto err_status;
+	}
+
 	switch (type) {
 	case VIRTIO_BLK_T_IN:
 		if (!vdpasim_blk_check_range(sector, to_push)) {
@@ -178,6 +187,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		break;
 	}
 
+err_status:
 	/* If some operations fail, we need to skip the remaining bytes
 	 * to put the status in the last byte
 	 */
-- 
2.37.1

