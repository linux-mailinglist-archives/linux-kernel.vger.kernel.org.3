Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529DE48E70E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiANJFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:05:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232562AbiANJFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642151123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QSqhd5EHQVjGBS9+fRjPxVdCzG4rtUKAbc2JLGcS0M8=;
        b=i9+LecqlDdg2ey2y8zapEpM9kN/KzyoJPivYHNsVMCP5f8qJ/VDUxA5J3fnkKX+RXJWuw8
        UEzUYecLYZRTE9TjCNIPWAswNio4PisVlkhrvw4aaJzu04UgzY3GA0F4Sok3Y5TWVORZym
        k/ogyKduhugxQI1+6m96ksABO2K9EjQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-IZikK4zsM2u4QwtmfqRqMg-1; Fri, 14 Jan 2022 04:05:21 -0500
X-MC-Unique: IZikK4zsM2u4QwtmfqRqMg-1
Received: by mail-pl1-f198.google.com with SMTP id x6-20020a170902ea8600b0014a7ff76da7so2861414plb.14
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 01:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSqhd5EHQVjGBS9+fRjPxVdCzG4rtUKAbc2JLGcS0M8=;
        b=B6NyTjyg92G+z6KyclUJUTaPXc783rQKOqL4b23FEuHm7Cdt+iIu6HMkE642YOaxFf
         KYq8g/eUmdio9uVjQTlwE8yHlA38HuA0OdxJOojVWyALpcGlcQhi2LGX/Xci517r+XRa
         3h+Vw5hWK7oZuGPvjKb/tEDtLjSXlKrGgsyI+TTjSEa89q5OOUEtVCX1TUaY00sgis1k
         BbnlL+//yWfknuQ4vbAvgmQzcQKN8hcMWaeZXO1VrkqFLJR8yjs6syHJYzyoOfMhHaM5
         a1Ro6fSU53d7QrhJ9aQ1GvHOYzVEq5YqmWiVQa78LaE+l2ovPaAlhpfcQUsaiDOUBQbd
         GW2A==
X-Gm-Message-State: AOAM531VLEXVWhq8HK2RHjdCDOOqTO4MNUXuz6m8yu5ZCa36o6TZxTZ4
        mwQECbrgECMxOf+gnRXNKV7vB3KKGigpjHj4FdH/17iNNE5wad3A/AWSzBMttuPgf0jGeEZgYpT
        FIcMWgsZnMMSKY2KyHQtKREnX
X-Received: by 2002:a17:902:7603:b0:148:daa7:ed7e with SMTP id k3-20020a170902760300b00148daa7ed7emr8569168pll.150.1642151119913;
        Fri, 14 Jan 2022 01:05:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxW79PSPSMG4VhQolpshd54Loc7rye/TOYMJd/7+9JvMi8g1YuVwpqwFGtXO0bt0SuSVXZouw==
X-Received: by 2002:a17:902:7603:b0:148:daa7:ed7e with SMTP id k3-20020a170902760300b00148daa7ed7emr8569146pll.150.1642151119627;
        Fri, 14 Jan 2022 01:05:19 -0800 (PST)
Received: from steredhat.redhat.com (host-95-238-125-214.retail.telecomitalia.it. [95.238.125.214])
        by smtp.gmail.com with ESMTPSA id c6sm5217474pfv.62.2022.01.14.01.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 01:05:18 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
        kvm@vger.kernel.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v1] vhost: cache avail index in vhost_enable_notify()
Date:   Fri, 14 Jan 2022 10:05:08 +0100
Message-Id: <20220114090508.36416-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vhost_enable_notify() we enable the notifications and we read
the avail index to check if new buffers have become available in
the meantime.

We are not caching the avail index, so when the device will call
vhost_get_vq_desc(), it will find the old value in the cache and
it will read the avail index again.

It would be better to refresh the cache every time we read avail
index, so let's change vhost_enable_notify() caching the value in
`avail_idx` and compare it with `last_avail_idx` to check if there
are new buffers available.

Anyway, we don't expect a significant performance boost because
the above path is not very common, indeed vhost_enable_notify()
is often called with unlikely(), expecting that avail index has
not been updated.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1:
- improved the commit description [MST, Jason]
---
 drivers/vhost/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe2..07363dff559e 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 		       &vq->avail->idx, r);
 		return false;
 	}
+	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
 
-	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
+	return vq->avail_idx != vq->last_avail_idx;
 }
 EXPORT_SYMBOL_GPL(vhost_enable_notify);
 
-- 
2.31.1

