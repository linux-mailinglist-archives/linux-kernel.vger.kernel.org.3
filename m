Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440BB57319C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiGMIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiGMIzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BCF4AEF7D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657702507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dI6YVPovohaWrafIFhdI1Cj4BYIDUe0+jr5w6UInkNw=;
        b=XHgl9JAolFb5ov5uviDdtirTH15nYm9tTTSHHIovjTe0gAVBXEbbxMD3/4M+ShvSCnp2po
        399DbwxrNMbO9J54XCoc8JnDgIhB+/s7tfUA4oCFjiseAZss+EKr9XdgGnwB8e4vqdTwL2
        8UbvhyxNMQsbB37R2ERWekJrhLCQXOg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-09_RxUvhNcO9UBSgY-1wqw-1; Wed, 13 Jul 2022 04:55:05 -0400
X-MC-Unique: 09_RxUvhNcO9UBSgY-1wqw-1
Received: by mail-ed1-f71.google.com with SMTP id f9-20020a056402354900b0043a902b7452so7885263edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dI6YVPovohaWrafIFhdI1Cj4BYIDUe0+jr5w6UInkNw=;
        b=jMrlB0nNX1p25vQv+w6ytQD4mwQZ2uMhIMMksBv6xyfCosHfqDydkzaQdqTT/LlfmD
         I/U/uMKc5XXxVIw8zR+OM8me1g76BwTFnRVCj5t064qM+COfQzd8yqrX0dtvMWexA8z1
         vGbI+pb+cXrZKLCDFa9XCel4b5rJZ6MSbcTTuAFU4G1K0PhNorm1jkKSCYCJ1HNmvDcb
         h1BxgID8YmgsqHjgfJcylZgrZhsXMW9mgN7gkKZV8ca1JZV65WbGQRqi2AOARfpqhO+T
         I0y/32SOryJHSyfdGLlYI0pyuCZ5Pb8wr3G4FKUpm3/xegKRL/VQDxC84m54z6Vs0TZv
         R8/w==
X-Gm-Message-State: AJIora/vS2SUZzJUHPLgwQGuwqEqu4mxZgnwYEMP2KScjAKm/zyBmUAA
        llws7Q/NGqxmEQzva6XsutOKOErZrXOuwGsJrRzFTAjQTp96U3KRX4TmViTiRMUmGa11l4sCrdm
        wMS6+zXtEjVx56pzuqfPxmzmV
X-Received: by 2002:a17:906:a0cf:b0:726:cbdd:466b with SMTP id bh15-20020a170906a0cf00b00726cbdd466bmr2304578ejb.410.1657702503917;
        Wed, 13 Jul 2022 01:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t26IcZ7VFVC0piZNYs8yiLS0rqclevP1xbJGt8yW/60SZvrzRzMBVQayVzizXS5sVAhCcQqg==
X-Received: by 2002:a17:906:a0cf:b0:726:cbdd:466b with SMTP id bh15-20020a170906a0cf00b00726cbdd466bmr2304561ejb.410.1657702503741;
        Wed, 13 Jul 2022 01:55:03 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id e2-20020a056402088200b0042dcbc3f302sm7547655edy.36.2022.07.13.01.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:55:03 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     emma@anholt.net, mripard@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 0/3] drm/vc4: use drm managed resources
Date:   Wed, 13 Jul 2022 10:54:57 +0200
Message-Id: <20220713085500.1970589-1-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

This patch series converts DRM modeset object allocations from devm_*()
to drmm_*() memory allocators, or their corresponding convenience
wrappers, respectively, in order to tie the release action to the
underlaying struct drm_device.

This can prevent potential use-after free issues on driver unload or
EPROBE_DEFERRED backoff.

Danilo Krummrich (3):
  drm/vc4: plane: use drm managed resources
  drm/vc4: crtc: use drm managed resources
  drm/vc4: encoder: use drm managed resources

 drivers/gpu/drm/vc4/vc4_crtc.c  |  2 +-
 drivers/gpu/drm/vc4/vc4_dpi.c   | 11 ++++++-----
 drivers/gpu/drm/vc4/vc4_dsi.c   | 10 +++++-----
 drivers/gpu/drm/vc4/vc4_hdmi.c  | 10 ++++++----
 drivers/gpu/drm/vc4/vc4_plane.c | 19 +++++++------------
 drivers/gpu/drm/vc4/vc4_txp.c   |  2 +-
 drivers/gpu/drm/vc4/vc4_vec.c   | 11 ++++++-----
 7 files changed, 32 insertions(+), 33 deletions(-)

-- 
2.36.1

