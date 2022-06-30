Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E930B561F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbiF3Pci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiF3Pcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C45C33D4AF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656603153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pcmUWHwjNzcwYP1ffPOW41Lm6XhO65tP5GIsXRO8MKU=;
        b=EJG2vF9kLssqTnJXe7C2lIEfafISDQ3u+RAZ9Ah+1PeDlAxN2fOA+O2XEicCB5wEZh2gGz
        iLMDGCcBO3ufvVvh3eVfZfvorXlyZ/GmhrXJXu6RinwpiQMc58AAPdjgEEeYSErDew00xb
        W6O3gzdSHajK4pCgbb1leOl8arOY8jc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-0MiIVzZMMI2Qtsv4tvyS0g-1; Thu, 30 Jun 2022 11:32:29 -0400
X-MC-Unique: 0MiIVzZMMI2Qtsv4tvyS0g-1
Received: by mail-qv1-f71.google.com with SMTP id mz4-20020a0562142d0400b004726d99aa49so11496216qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pcmUWHwjNzcwYP1ffPOW41Lm6XhO65tP5GIsXRO8MKU=;
        b=d0aYyRbAp8LVEBN4g/TpZ3HFNt5NxrgWoEngFdLR0EVoU5laqhodj0JYVpOu+RnaRv
         jFhkq/lOTwpssYqD/YIN9EctwEv4rrhShnRe10T/72riKS3/agNtliQ6U2Eu80lbknCD
         +VnCezsM/DwJwE/nhvDXiZXsGWMcZxmjQXN1jNdBdo/cyMGUrpDV218j2cxNHRz1DeD9
         +UVrdkSUmIleMADj8etChyHJq1Wf4nx9tTVnQqgDkMA7tvWiQPR//pGymr2LWQV9c8PT
         ICJLEI32trC/uU1kTJmaN4o+mx90tglOVE96ob283o+Ff0YoVLelCrxJQAmM776L2xZy
         jBiQ==
X-Gm-Message-State: AJIora+AIC2cXkdBXuMU7SBVrZ/+s7SNCcrfG1ytJy+9FnKeGs+qwzOL
        IVkGZKmjJhup64v5puHN7GBQjr1phDNd4HxwcOSs27eqSTvqUqBztBAUYX72Bwkz3lM3fpQt9mW
        EFyBSw6CVsuRM40iaPpD02MVK
X-Received: by 2002:a05:620a:8018:b0:6af:1fee:41ac with SMTP id ee24-20020a05620a801800b006af1fee41acmr6695916qkb.476.1656603146766;
        Thu, 30 Jun 2022 08:32:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vkIc7TNQUd9dH7P1QOC596mqRPfmhoP8IEwy11rq536OjOmrdmPduBteJuiTGuWl5OEDH/Ag==
X-Received: by 2002:a05:620a:8018:b0:6af:1fee:41ac with SMTP id ee24-20020a05620a801800b006af1fee41acmr6695886qkb.476.1656603146450;
        Thu, 30 Jun 2022 08:32:26 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-149.retail.telecomitalia.it. [87.11.6.149])
        by smtp.gmail.com with ESMTPSA id y20-20020a05620a44d400b006af0639f7casm16089325qkp.12.2022.06.30.08.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 08:32:25 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 0/3] vdpa_sim_blk: several fixes for the vDPA block simulator
Date:   Thu, 30 Jun 2022 17:32:18 +0200
Message-Id: <20220630153221.83371-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Patch 2: restored previous behaviour, exiting the loop immediately if the
  request is malformed [Jason]
- Added Jason's A-b In patch 1 and 3

v1: https://lore.kernel.org/virtualization/20220621160859.196646-1-sgarzare@redhat.com/

The first two patches essentially limit the possibility of the guest
doing a DoS to the host.

The third makes the simulator more correct (following what we do in
vdpa_sim_net) by calling vringh_complete_iotlb() in the error path as well.

Stefano Garzarella (3):
  vdpa_sim_blk: use dev_dbg() to print errors
  vdpa_sim_blk: limit the number of request handled per batch
  vdpa_sim_blk: call vringh_complete_iotlb() also in the error path

 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 44 ++++++++++++++++++----------
 1 file changed, 29 insertions(+), 15 deletions(-)

-- 
2.36.1

