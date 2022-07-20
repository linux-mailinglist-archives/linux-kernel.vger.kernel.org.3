Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B408E57B806
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbiGTOCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiGTOCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25E9831935
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658325742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iKnFxqR/xnLOGU/x0kBd7RKVjTH74hGUTCbW3S5Ws0I=;
        b=NjmRTF2G++ldKIN/v64mYzoyAa4xC3L44sZGp8/cFa1bZ5obMAsWv+2aOMaZLFZzfUHwDB
        lk4JWEsfC1y46HWEzxH8vNvR/VsJa4k19ygi/S+LbF0zzYKV2uNx9+SuVAZMlWKk4YMiPR
        r1/kgl41D8pwro/unhL5P/oX3tqkPKw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-KeEqC7nuMOyUAQZfqYypww-1; Wed, 20 Jul 2022 10:02:20 -0400
X-MC-Unique: KeEqC7nuMOyUAQZfqYypww-1
Received: by mail-ed1-f71.google.com with SMTP id b15-20020a056402278f00b0043acaf76f8dso12296919ede.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iKnFxqR/xnLOGU/x0kBd7RKVjTH74hGUTCbW3S5Ws0I=;
        b=DMZDZOxObGmQHRuuXK+fgRs5sZD3BMz4q82r5tW8CnwlGdITbXwyXVV1s21YUMzHAo
         ero6QmxQs3G14LtCC4rLFI6nJPqmJN2G/Fff5ggTCgcXnZCDKENX6Vm3fuY5CuRpnWmE
         dNJe6OL3FHEt9Vn5ISwad46r6xr4+sE3uh0Lzf4c3N8alD4HKj+leW7o3TzSljcxyCuG
         ibDb3gz3NoEP9NydZpxn46u7d4oRaIzBaOdjEPlzrT7OBDPgw0agx1YAkZkr4LmHw1jM
         EEYDActtDvpEedNJTtNcJ0iQbZ8xWHHeHrlJ8GSlE05ls8puxbtqY8qZouArvZQTZb1L
         1+jw==
X-Gm-Message-State: AJIora+WFRU2Bqc85KlgKidYxBUqz6uHFqy/9Quq6lFZwJ4nEvlEn7Zr
        FgupVycsw70Aoth17ojxQFb66bpG8F4tdv9u7JD96kaXvJaAsNjhJ7WoQt+bTN1OM+4vhlj/BY3
        8fjBxN18ovQKmrMOK5MEFolrH
X-Received: by 2002:a17:906:99c5:b0:6df:8215:4ccd with SMTP id s5-20020a17090699c500b006df82154ccdmr33944150ejn.684.1658325739441;
        Wed, 20 Jul 2022 07:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u7RPMn+gfIrWOhHU+fL8XR930gM9Bvh1ZvK9ZXRK1yNq0MQtL/PL8tYuk1qkNEh3O6EQu5kA==
X-Received: by 2002:a17:906:99c5:b0:6df:8215:4ccd with SMTP id s5-20020a17090699c500b006df82154ccdmr33944136ejn.684.1658325739259;
        Wed, 20 Jul 2022 07:02:19 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906560d00b006fee98045cdsm8053040ejq.10.2022.07.20.07.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:02:18 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 0/2] drm/virtio: use drm managed resources
Date:   Wed, 20 Jul 2022 16:02:12 +0200
Message-Id: <20220720140214.199492-1-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts plain memory allocations for driver structures and
planes to drm managed allocations in order to cleanup/simply the corresponding
release/destroy callbacks.

Danilo Krummrich (2):
  drm/virtio: plane: use drm managed resources
  drm/virtio: kms: use drm managed resources

 drivers/gpu/drm/virtio/virtgpu_kms.c   | 16 ++++++--------
 drivers/gpu/drm/virtio/virtgpu_plane.c | 30 +++++++-------------------
 2 files changed, 15 insertions(+), 31 deletions(-)

-- 
2.36.1

