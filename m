Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7A2574E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbiGNNAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbiGNNAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D32853D25
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657803634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iKnFxqR/xnLOGU/x0kBd7RKVjTH74hGUTCbW3S5Ws0I=;
        b=gkMyQgueq4o5UaHrsycpUl6pM8ZIVaMWt3DMPvxcyOP6h/NqdDaPeUnViNr0net/kic8kz
        WvmicGH9xhBVi//tWQ0JAeHlEuQ7JcsgTvWFsitHYCAY3W/LD0mEGkviMlFwiA6bJMUHpL
        tPohpmRHj7Tz5tR3h8QuxmHwQdE77Iw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-_z8zsyrlPfyZ_CVsZvo3vA-1; Thu, 14 Jul 2022 09:00:32 -0400
X-MC-Unique: _z8zsyrlPfyZ_CVsZvo3vA-1
Received: by mail-ed1-f72.google.com with SMTP id n8-20020a05640205c800b00434fb0c150cso1439656edx.19
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iKnFxqR/xnLOGU/x0kBd7RKVjTH74hGUTCbW3S5Ws0I=;
        b=NOypbk4/qAelH/kNp7QWRyY4oCcnfQhKo5WsroyL0CTL+gtYEXE6xZqArtTc6X0/vf
         xBDSEZQxWQNwPmJPLtW4dvQ1B3W1xoYuk+s6mhbn2wG4pHqM3R0BfY7ZHk52KNTacj8Y
         FvC2cSldQiC7B6BOK7wV1HUk16YuCVz9JUZbZMQr5j1TRzAnP+azaW2a+O7YDm+KLgL9
         XUSqjDSIaXTbxJq9l7s/LmSQJP3Rf5xdEwfRe8AiyEqhPZwCjy67qpiT8fkQDtHb8XNV
         VcMcX6K7w6TyjfnMVNgY2dlWeDZqrQESnTlhLaGb0ADE4PPVOqm0NwcCxhgl8BZ1xoMw
         A6EA==
X-Gm-Message-State: AJIora+CwVDccjPRT1Aiqa93AWabhFMdGoKUoS9oNWq1wKCHRtbK6LDT
        zbjxU3xb6kjmX18/IV2XK8WqBI/jl5O6IsB/pCL6J5mM41lSMwpevGSSCIIg44v+PmRGvQH50dU
        CnNOPZxd4f1fOuNWN1hiAcPBd
X-Received: by 2002:a05:6402:2786:b0:43a:dc4e:ea63 with SMTP id b6-20020a056402278600b0043adc4eea63mr12517989ede.175.1657803631492;
        Thu, 14 Jul 2022 06:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t+2ObxccmxD712cuXRmX9quI6ekyMGtiKiuOhSEY86aReh6m2BXNY85vO9S1aEdOFNawKcDA==
X-Received: by 2002:a05:6402:2786:b0:43a:dc4e:ea63 with SMTP id b6-20020a056402278600b0043adc4eea63mr12517965ede.175.1657803631343;
        Thu, 14 Jul 2022 06:00:31 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id zk9-20020a17090733c900b0072ecef772acsm694237ejb.2.2022.07.14.06.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:00:30 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 0/2] drm/virtio: use drm managed resources
Date:   Thu, 14 Jul 2022 15:00:26 +0200
Message-Id: <20220714130028.2127858-1-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

