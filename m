Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724894C43E7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiBYLtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbiBYLtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:49:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73DA21CABFB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645789731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=scWxKg4GU2Bc5BNOef08NlM2V9Xj4Fo3ABvGq3MHV14=;
        b=Dt4EoMNkuryhqdo/VUaOWuG7VKitZ+9Fh5dsvsJ4v7ZnLJog+WG/SkyViSb85n03Dg6yaW
        qNt9PP4BBkOWsyrORMy4WbESRQ5miEsDQhU0KxclxBObXJFpV/aFNCI4G/AAByS+eqhItb
        1E5sMDxSkIg33MtHPqxXvRf/2pw+31k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-pay3qN-1ONCq5GVaT36N9g-1; Fri, 25 Feb 2022 06:48:50 -0500
X-MC-Unique: pay3qN-1ONCq5GVaT36N9g-1
Received: by mail-wr1-f70.google.com with SMTP id u9-20020adfae49000000b001e89793bcb0so793711wrd.17
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=scWxKg4GU2Bc5BNOef08NlM2V9Xj4Fo3ABvGq3MHV14=;
        b=0quOBrps91uixosIAeDSNWEJFSIE7yog4WqTCrMUkULaVlkbCNVBOpYzG/PRkE+Xqa
         uUvA5uoUUXCZZzNOoTSi1dtusA/tesJK5BQ6pQ8/uGn8mL7wQFPWRk8JPeiHeN04tqux
         ldecM05BLkWz2SfKfCr9/cKbPDL8eJ33FuHvXnhSgXwgh4aqU395eeRhcHwK3VA9icMH
         0eCapMp4P08azP+V28NjEaezc1OcOUcvtSPDnWjPXV7bqdn/6OpK+C33Md7WTtHQMdqG
         CDakdENpQ45ndD5UA/Fjbc0MT2B8fwJ00b9S2skmEqV/fUxqpV6VmLVGxz+nRs461VFD
         xxgg==
X-Gm-Message-State: AOAM532oEXSVUfg4rNtI3V34dlpXfCloiNsXnU5dOH44Inn+03G2YxAx
        Ke7OkuAHsmF1bT6ADmQmnSN8j2cYMnjvuokKThCToZ8KpXcMmUgEdnrN9s8Q2zP1LIOQYJdNnOE
        zR923NTCTCBfP3/99ZH+WnCtXDLFmF0kTZYsVj6U7lksPSfJld8ouYkyKmegkSW5+WoJErA==
X-Received: by 2002:a5d:5887:0:b0:1d7:36e4:e40f with SMTP id n7-20020a5d5887000000b001d736e4e40fmr5963324wrf.298.1645789728986;
        Fri, 25 Feb 2022 03:48:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwu1fG1N/2AZ+M3s346bFKeHxAClPaPazs6BuiKvazV+7Ij8KAG57M+nTgR/+3dBEb+ML0KZw==
X-Received: by 2002:a5d:5887:0:b0:1d7:36e4:e40f with SMTP id n7-20020a5d5887000000b001d736e4e40fmr5963302wrf.298.1645789728723;
        Fri, 25 Feb 2022 03:48:48 -0800 (PST)
Received: from redhat.com ([2.55.145.157])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d4dc4000000b001d8e67e5214sm2122519wru.48.2022.02.25.03.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 03:48:47 -0800 (PST)
Date:   Fri, 25 Feb 2022 06:48:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] virtio: drop default for virtio-mem
Message-ID: <20220225114801.47348-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no special reason why virtio-mem needs a default that's
different from what kconfig provides, any more than e.g. virtio blk.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 34f80b7a8a64..492fc26f0b65 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -105,7 +105,6 @@ config VIRTIO_BALLOON
 
 config VIRTIO_MEM
 	tristate "Virtio mem driver"
-	default m
 	depends on X86_64
 	depends on VIRTIO
 	depends on MEMORY_HOTPLUG
-- 
MST

