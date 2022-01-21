Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EBE49621D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381602AbiAUPb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381585AbiAUPbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642779084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OtUoNHq7A4SE6zFtDfLA7te7a+Lq28AP0hpcNcpECag=;
        b=eLHHWgWCgvNxX1PszFVnUGjuNwSxY3GlCbCY/sqlmuFMrO2TtA58Mc0u6GruFH+xSHaj2w
        T6M6AYM8Uwr6QPXCCyY7bBoe+0KRSTl7SibVF6oAg17kcL6FjBx7jtje0FPYN9y9ylYlNU
        qf6XeUSkz0pQAVAwl8LTvHzD/PAFBao=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-jreAGW5DMWKPAixtTX4gWA-1; Fri, 21 Jan 2022 10:31:21 -0500
X-MC-Unique: jreAGW5DMWKPAixtTX4gWA-1
Received: by mail-pl1-f199.google.com with SMTP id u14-20020a170902714e00b0014ace69caccso1675124plm.17
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 07:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OtUoNHq7A4SE6zFtDfLA7te7a+Lq28AP0hpcNcpECag=;
        b=caJ7+IXKjGjsKrsmwFo0jOXNrIP0iqG3+TqF9rVRN721FWAD/qJPyRXX2UZBS3ft1o
         uH99USF+aFKQUgiobCTLdZPElGV6w6FkDzg3c01AGw0+/QQH28EOdRFfHSpqT9svIozU
         yxm4TgxMNuOk9gpOpJUQ8YcRhYHkgKCrP8hZca6MLkSQ4T8/VK/3N0Ndi7o0X/CChJEc
         hG/KltmyKzyd/nytwO0xN43B55PuP7jUdsPPMGK3rcxE0jpZzJIQKvCBc35Fnv0KF/uJ
         x47L+kTuv6kb9jttHLuagnnqqu+5RQ9S5WSsAfuawclYF8xz0Rqlt8erDZ4bl6jsfIpX
         oveg==
X-Gm-Message-State: AOAM530gTPy3MMlba5tP+FfNFfKkVDfAsSaxasI35eXRoTW5tqK8DDlT
        CGxzf79SPNoa37ZOOR4IbK1RAZN7Fs7RJuN28pnWx9uvLxLepBVR3zSbzymzZAV0ox25yhI9VSQ
        P+bc/CWOtqS9McmrBXi5qNocp
X-Received: by 2002:a62:ab03:0:b0:4c6:419e:f8f2 with SMTP id p3-20020a62ab03000000b004c6419ef8f2mr4067811pff.4.1642779080353;
        Fri, 21 Jan 2022 07:31:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6q0reQiVxMv8WMVszJ9f1J1yC2BTK8uM93yxVR4UChzktBXihhcIJ52HJnaO4J45jUP3f6A==
X-Received: by 2002:a62:ab03:0:b0:4c6:419e:f8f2 with SMTP id p3-20020a62ab03000000b004c6419ef8f2mr4067798pff.4.1642779080064;
        Fri, 21 Jan 2022 07:31:20 -0800 (PST)
Received: from steredhat.redhat.com (host-95-238-125-214.retail.telecomitalia.it. [95.238.125.214])
        by smtp.gmail.com with ESMTPSA id s6sm5394612pgk.44.2022.01.21.07.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 07:31:18 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH v2] vhost: cache avail index in vhost_enable_notify()
Date:   Fri, 21 Jan 2022 16:31:08 +0100
Message-Id: <20220121153108.187291-1-sgarzare@redhat.com>
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

We don't expect a significant performance boost because
the above path is not very common, indeed vhost_enable_notify()
is often called with unlikely(), expecting that avail index has
not been updated.

We ran virtio-test/vhost-test and noticed minimal improvement as
expected. To stress the patch more, we modified vhost_test.ko to
call vhost_enable_notify()/vhost_disable_notify() on every cycle
when calling vhost_get_vq_desc(); in this case we observed a more
evident improvement, with a reduction of the test execution time
of about 3.7%.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2
- added performance info in the commit description [MST]
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

