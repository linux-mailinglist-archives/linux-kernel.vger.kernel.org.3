Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87AD492BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346990AbiARRED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:04:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236454AbiARREB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642525441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gp9KSX6Flr6j6FmwJ5l+iw44DxlO8pNbZWCP2QxAjMw=;
        b=izSHmRav13ZQuuLkFhRhEu4nC5oTpv4F6h2b5NFzalnOh93sJ6bWN4IIxBicUJIXLvdCVy
        sFDs/1CyqgmgBcHH0aQW/e1GZSdAc/2d9ex20v1wmyjQ4Wz1BYEynyTNMT0ZS0U8nOVboA
        GAFOwX2WB6XVYXCjMhpJMpKu9+5+vsA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-_4018_ZgMQKUe3ln0xL3IQ-1; Tue, 18 Jan 2022 12:04:00 -0500
X-MC-Unique: _4018_ZgMQKUe3ln0xL3IQ-1
Received: by mail-ed1-f70.google.com with SMTP id t5-20020aa7db05000000b00402670daeb9so6661341eds.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gp9KSX6Flr6j6FmwJ5l+iw44DxlO8pNbZWCP2QxAjMw=;
        b=EguhUnyvjp5l9z4qzgQ3WIF4L7PgXiDVfw+g2MwV9pUwJzs/oNAlDSb5Tzeg+A09E8
         QyKpfm/veVQSCuY81DD684Ep4gvsPdLO/oQ7kyNIkY3yZFuYWUeW7ReU+QkE9KpGdcx2
         VDXNmF+lZ6l5rIDs54B5u36Fp8Eq3XZ2euf0IhQq38ItFTpqOzmuodHKxvKjyAlK39M1
         uXB7q7nMki8t/daybJel20IeAOKrBgIhKIAj4fDHWY8l5qhOK9bdiW3S4irvg5ZPy609
         mGVrKjG90kKobfFXt6MS5z1fQUsvVbBZErgNvSOeYz0IIcT/d+Szygq0ZrACg0Ck633a
         NtYw==
X-Gm-Message-State: AOAM530e3s83n52DDVxel7nO8AuacPyHnTtQw9QEqePUngpdeZDXbCrC
        rvuFyiULjfLfVCmDJuP+4o3sC+ad0JVtL3yWDmGnl+tUYYu4Ck31rYw7TPZJNxUN9/WdCb+fwFj
        mkyv0e8dNQpX4WxwlOeDKGeUYPQO9K0vebEBAPFT7jvk0SQnAIZMD/fzogFs3D52Ylq1A9Q==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr26442203edd.129.1642525436733;
        Tue, 18 Jan 2022 09:03:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfgfOmVJ8BK0HjVcw/Hr9YnRhWaJmgMtpY0BioTVBV93Ej3a8ugF3NkU9nC+CEupjnMcNFjg==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr26442170edd.129.1642525436411;
        Tue, 18 Jan 2022 09:03:56 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
        by smtp.gmail.com with ESMTPSA id d8sm117917edz.62.2022.01.18.09.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 09:03:55 -0800 (PST)
Date:   Tue, 18 Jan 2022 12:03:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH v2 2/2] virtio: acknowledge all features before access
Message-ID: <20220118170225.30620-2-mst@redhat.com>
References: <20220118170225.30620-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118170225.30620-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature negotiation was designed in a way that
makes it possible for devices to know which config
fields will be accessed by drivers.

This is broken since commit 404123c2db79 ("virtio: allow drivers to
validate features") with fallout in at least block and net.  We have a
partial work-around in commit 2f9a174f918e ("virtio: write back
F_VERSION_1 before validate") which at least lets devices find out which
format should config space have, but this is a partial fix: guests
should not access config space without acknowledging features since
otherwise we'll never be able to change the config space format.

To fix, split finalize_features from virtio_finalize_features and
call finalize_features with all feature bits before validation,
and then - if validation changed any bits - once again after.

Since virtio_finalize_features no longer writes out features
rename it to virtio_features_ok - since that is what it does:
checks that features are ok with the device.

As a side effect, this also reduces the amount of hypervisor accesses -
we now only acknowledge features once unless we are clearing any
features when validating (which is uncommon).

Cc: stable@vger.kernel.org
Fixes: 404123c2db79 ("virtio: allow drivers to validate features")
Fixes: 2f9a174f918e ("virtio: write back F_VERSION_1 before validate")
Cc: "Halil Pasic" <pasic@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

fixup! virtio: acknowledge all features before access
---
 drivers/virtio/virtio.c       | 39 ++++++++++++++++++++---------------
 include/linux/virtio_config.h |  3 ++-
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index d891b0a354b0..d6396be0ea83 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -166,14 +166,13 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
-static int virtio_finalize_features(struct virtio_device *dev)
+/* Do some validation, then set FEATURES_OK */
+static int virtio_features_ok(struct virtio_device *dev)
 {
-	int ret = dev->config->finalize_features(dev);
 	unsigned status;
+	int ret;
 
 	might_sleep();
-	if (ret)
-		return ret;
 
 	ret = arch_has_restricted_virtio_memory_access();
 	if (ret) {
@@ -244,17 +243,6 @@ static int virtio_dev_probe(struct device *_d)
 		driver_features_legacy = driver_features;
 	}
 
-	/*
-	 * Some devices detect legacy solely via F_VERSION_1. Write
-	 * F_VERSION_1 to force LE config space accesses before FEATURES_OK for
-	 * these when needed.
-	 */
-	if (drv->validate && !virtio_legacy_is_little_endian()
-			  && device_features & BIT_ULL(VIRTIO_F_VERSION_1)) {
-		dev->features = BIT_ULL(VIRTIO_F_VERSION_1);
-		dev->config->finalize_features(dev);
-	}
-
 	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
 		dev->features = driver_features & device_features;
 	else
@@ -265,13 +253,26 @@ static int virtio_dev_probe(struct device *_d)
 		if (device_features & (1ULL << i))
 			__virtio_set_bit(dev, i);
 
+	err = dev->config->finalize_features(dev);
+	if (err)
+		goto err;
+
 	if (drv->validate) {
+		u64 features = dev->features;
+
 		err = drv->validate(dev);
 		if (err)
 			goto err;
+
+		/* Did validation change any features? Then write them again. */
+		if (features != dev->features) {
+			err = dev->config->finalize_features(dev);
+			if (err)
+				goto err;
+		}
 	}
 
-	err = virtio_finalize_features(dev);
+	err = virtio_features_ok(dev);
 	if (err)
 		goto err;
 
@@ -495,7 +496,11 @@ int virtio_device_restore(struct virtio_device *dev)
 	/* We have a driver! */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
 
-	ret = virtio_finalize_features(dev);
+	ret = dev->config->finalize_features(dev);
+	if (ret)
+		goto err;
+
+	ret = virtio_features_ok(dev);
 	if (ret)
 		goto err;
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 4d107ad31149..dafdc7f48c01 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -64,8 +64,9 @@ struct virtio_shm_region {
  *	Returns the first 64 feature bits (all we currently need).
  * @finalize_features: confirm what device features we'll be using.
  *	vdev: the virtio_device
- *	This gives the final feature bits for the device: it can change
+ *	This sends the driver feature bits to the device: it can change
  *	the dev->feature bits if it wants.
+ * Note: despite the name this can be called any number of times.
  *	Returns 0 on success or error status
  * @bus_name: return the bus name associated with the device (optional)
  *	vdev: the virtio_device
-- 
MST

