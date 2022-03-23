Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419CC4E57AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbiCWRic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343714AbiCWRiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B24767E0A7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648056993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MzwRKwBdRCLittF2Yi0pCWERtTQbkRUJ2eaS0FEovlY=;
        b=eABIYVBYo3oK80xv1syrc2DnRL2TcnyYRo6P7b7siGLKi9T+aQHiIlp4Kn+n/5GUHaMn6o
        mLpzzCJcQv3f2/S6yA6cBcgiQKmONMOREUYcpOF0ZMYJiCCQJMGtV8cZnnidcZE+RaBoNN
        MqFTvnyGR1vR/0ZaTZhqAOvQs7PX0dg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-V4UdeM3vMfySjR17BL3xrg-1; Wed, 23 Mar 2022 13:36:32 -0400
X-MC-Unique: V4UdeM3vMfySjR17BL3xrg-1
Received: by mail-qv1-f69.google.com with SMTP id k20-20020ad44714000000b00440fd2c4a0aso1751549qvz.20
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MzwRKwBdRCLittF2Yi0pCWERtTQbkRUJ2eaS0FEovlY=;
        b=qV4HUUPkqWvcZPjuEfZE6tdHfp7VCdLvX3+otIHXP3JTSdxknTekLYVNvc8ykCiCq0
         S0pJsdq/RuSuqQttXKeEiBfDAitTgRDpMp6shNFFacnXXQsuhQtGkChVstB60F8WWaPA
         nHiltuB0xoDrEatigL/OkOTR8f6s9HluNF8Rpx8ElV0SBHASUGuaxMM55HN8VEL7e/qY
         mDT9lv673TKqtYKjVOHYq36glmvEArVbQ8EQpUwRU5CkRpiAjCDHgi6Smj6qzBbGs8dC
         q1VX1gZ5JuqyIDBCwZ4/Q57kTCIiozUtQASm0nZndtxDcO8oDrfT4P+xjUPKWWrU2d9t
         jvpA==
X-Gm-Message-State: AOAM533vgxqgv6Q++CZQY0GZYwGEaDcolH8vBcuS8LYPZLutrglTKnS9
        yq1+nD1S3wySu5/QdkimMNMbBEZS/fYGpe5jcD7pO5Pn7tLFC43r/Xp/VTFs7s0fQZemKBLRId4
        S8k6zHINhnkLSwVtBR75O16Y4
X-Received: by 2002:a05:6214:2509:b0:435:7443:2dad with SMTP id gf9-20020a056214250900b0043574432dadmr938553qvb.47.1648056991873;
        Wed, 23 Mar 2022 10:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeN8QDcW/nCBes+HF3p4Qa8YtXACGqrPDG30FPUtcA4s5rpDfAh0kaotVknOsyPTvs3/VKmw==
X-Received: by 2002:a05:6214:2509:b0:435:7443:2dad with SMTP id gf9-20020a056214250900b0043574432dadmr938508qvb.47.1648056991171;
        Wed, 23 Mar 2022 10:36:31 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-114.business.telecomitalia.it. [87.12.25.114])
        by smtp.gmail.com with ESMTPSA id h14-20020a05622a170e00b002e1a65754d8sm476127qtk.91.2022.03.23.10.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:36:30 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, Asias He <asias@redhat.com>,
        Arseny Krasnov <arseny.krasnov@kaspersky.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH net v3 0/3] vsock/virtio: enable VQs early on probe and finish the setup before using them
Date:   Wed, 23 Mar 2022 18:36:22 +0100
Message-Id: <20220323173625.91119-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch fixes a virtio-spec violation. The other two patches
complete the driver configuration before using the VQs in the probe.

The patch order should simplify backporting in stable branches.

v3:
- re-ordered the patch to improve bisectability [MST]

v2: https://lore.kernel.org/netdev/20220323084954.11769-1-sgarzare@redhat.com/
v1: https://lore.kernel.org/netdev/20220322103823.83411-1-sgarzare@redhat.com/

Stefano Garzarella (3):
  vsock/virtio: initialize vdev->priv before using VQs
  vsock/virtio: read the negotiated features before using VQs
  vsock/virtio: enable VQs early on probe

 net/vmw_vsock/virtio_transport.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.35.1

