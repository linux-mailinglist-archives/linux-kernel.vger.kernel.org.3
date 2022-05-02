Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316F051768C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386892AbiEBSeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiEBSeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7345C614D
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651516251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rguDjv+d49kqJjpBxJsrbZOSzE2Lv6ZdoiYYlDDf/aM=;
        b=UQylH6CPG8U/t5qRZ4wcvzmwy1mMQbGhZSCud7bOyzbi5r3uQlt5iOouLAh6+9gkkWhFcC
        VZO0/KdT9SQQUS17dWiEt2dE2bq/toPXwS09BSIcbMD+1IhJpP776flR58SJuii8mKPjpP
        D83veIpLRsqrmjQklVbxskiprE7lcuA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-X8mkzM8SMtq5YmsGE3ksTA-1; Mon, 02 May 2022 14:30:50 -0400
X-MC-Unique: X8mkzM8SMtq5YmsGE3ksTA-1
Received: by mail-qk1-f198.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so10689587qkb.23
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rguDjv+d49kqJjpBxJsrbZOSzE2Lv6ZdoiYYlDDf/aM=;
        b=Ko+sY5Jabm6tyZZdiYwIgV73vKFK3E4+s++AUg92e+uwV1wQtOYQwOWUkdRyQTCleI
         cg0Jdr6OFCZkQG36keH88ZF0EaENWLrfzv4i8BNm62cWgHGKhmyyea0pfTy2tivj5u7v
         +qbsNa1qZ3jFQEf92fSlSiS3oiXUCfPSjLxBVj62YlcwEge1E5Ahpx8KPYnKxJfPIuNC
         opagKsomBeh2mT9G0ZQ7Zd7+BYoO/r+/fodro3oVx+rvfpZNqPiCx+r8fX+Vjd5v5SMx
         LMqvjuVkretCiPVT9CYYKaz9/Dvu4SGGOKNj4r8CaqcUVZgkq7ytJvDM8L38SJ92YPi/
         g4sA==
X-Gm-Message-State: AOAM533px1Cx4J/RnJ2hvW8WfuVmGE56Nu+vXGVqI8oyXikhx2YwXjO5
        4NwfQlU5kcRaQKjFTjFkQWtJ7wd7DFSXj8Jqn076b7ZQYiIKRHk8KeGJFwudeIZK2dZQi5K0NJ5
        3yLs0C3CMSXFofuKMcLBqTMVP
X-Received: by 2002:a37:b1c7:0:b0:67d:6a17:cdcf with SMTP id a190-20020a37b1c7000000b0067d6a17cdcfmr9049105qkf.402.1651516249933;
        Mon, 02 May 2022 11:30:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzGMrpuLrvTmxx8frRpTf9Qu2IQ5cz1FrI776CpFn8PKTAz9yYy6P2/rkP71HE8n8rRrh6LQ==
X-Received: by 2002:a37:b1c7:0:b0:67d:6a17:cdcf with SMTP id a190-20020a37b1c7000000b0067d6a17cdcfmr9049093qkf.402.1651516249729;
        Mon, 02 May 2022 11:30:49 -0700 (PDT)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id h12-20020ac846cc000000b002f39b99f68esm4412204qto.40.2022.05.02.11.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:30:49 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Adrien Thierry <athierry@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: [PATCH 0/3] staging: vchiq_arm: remove some unnecessary global
Date:   Mon,  2 May 2022 14:30:39 -0400
Message-Id: <20220502183045.206519-1-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
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

This patch series aims at removing some unnecessary global structures in
order to make the driver more robust. This is part of an effort to address
TODO item "Get rid of all non essential global structures and create a
proper per device structure".

Adrien Thierry (3):
  staging: vchiq_arm: add reference to vchiq device in vchiq_state
  staging: vchiq_arm: get rid of global device structure
  staging: vchiq_arm: get rid of global vchiq_states array

 .../bcm2835-audio/bcm2835-vchiq.c             | 40 +++++---
 .../include/linux/raspberrypi/vchiq.h         | 49 +++++-----
 .../interface/vchiq_arm/vchiq_arm.c           | 94 +++++++++---------
 .../interface/vchiq_arm/vchiq_arm.h           |  8 +-
 .../interface/vchiq_arm/vchiq_core.c          | 98 ++++++++++---------
 .../interface/vchiq_arm/vchiq_core.h          | 38 +++----
 .../interface/vchiq_arm/vchiq_dev.c           | 40 ++++----
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 63 ++++++------
 8 files changed, 218 insertions(+), 212 deletions(-)


base-commit: 5fe7856ad59afc56a6ff35d091bfaddd1d4f4bce
-- 
2.35.1

