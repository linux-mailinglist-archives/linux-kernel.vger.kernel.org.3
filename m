Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919725AD686
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbiIEP3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbiIEP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3F662A9B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BENTc3SWGB4BWWG2iajoQJSVj5Fw7ENwsYJf9LzZDOc=;
        b=YkC5rHm5MrrIFgOwqJPDL848D0Anuw6cwUY9iJ1lzVmduZiVevM1cUHBvkVRDPick7jVes
        tfCkTmSl3Y2bH/gQgRJyyzSdmbiXySqb3O0/tvyZNKjknTOdxWyZkd9ryOSLEkiGTcmS4f
        HLZTjE2S12DO4VJztJvkNALFiF1MkAA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-304-MRp5DmRENMqspWZ2t6s9sg-1; Mon, 05 Sep 2022 11:27:23 -0400
X-MC-Unique: MRp5DmRENMqspWZ2t6s9sg-1
Received: by mail-ej1-f70.google.com with SMTP id qb39-20020a1709077ea700b0073ddc845586so2455482ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BENTc3SWGB4BWWG2iajoQJSVj5Fw7ENwsYJf9LzZDOc=;
        b=3BivqbjFEL6dkHHXyLw4MedrMNTg02WS+zZ7RjIIOttlf4UHwzZHnJoTURmeN9WlNP
         Od0iL5UdD5Rp/k8qMtYhN79paq7cTbG5wpoB82cN3fP3WIJCL4FqWoA70wgs2iTLzUIA
         Q9Z971yqW203rWgR0LgJT1ZVoHV+4GvC5zOXQ4iPSzVCYoHYHCjepe5yMvz/Mmro/VCf
         LCr30bgmPj27fPMbsoKLoPFmssJQiXJABB4gxYTpYfyI+Hx7znB0Tf0VKMirg9aOhRbU
         JBw1lwOIdkABEmKFZcsKroqBYo4y+TL9M0RJjh7X0n5JHlCS4vsASajMx0IxJuCXl4Jd
         qLdA==
X-Gm-Message-State: ACgBeo0pDxJMdCqqCHVpt9exuUOwQx6FAF/qfbXWq/03/OI7INqDB6bA
        QBr+odp8+kF9yMgwlaXE8U8vFvZwdcSTSXqdEsZ3k/is9mEBA5Y0LyQ+FxhnCmfpvNvk/DbNmMQ
        ZwukyyaSVtzKWBW2Cc1ZUbV+L
X-Received: by 2002:aa7:cb13:0:b0:448:3759:8c57 with SMTP id s19-20020aa7cb13000000b0044837598c57mr34560728edt.8.1662391642887;
        Mon, 05 Sep 2022 08:27:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4cgqjDj71pPF1s5eWep0UxzIGtBSbww7xJGV60Wk3FNDdc4XOKRNaNLC58VwLuKmtk2E0Qcw==
X-Received: by 2002:aa7:cb13:0:b0:448:3759:8c57 with SMTP id s19-20020aa7cb13000000b0044837598c57mr34560713edt.8.1662391642704;
        Mon, 05 Sep 2022 08:27:22 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id r7-20020aa7cb87000000b0044ea7b8f57bsm1027934edt.1.2022.09.05.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:27:22 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 0/7] drm/arm/hdlcd: use drm managed resources
Date:   Mon,  5 Sep 2022 17:27:12 +0200
Message-Id: <20220905152719.128539-1-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series converts the driver to use drm managed resources to prevent
potential use-after-free issues on driver unbind/rebind and to get rid of the
usage of deprecated APIs.

Danilo Krummrich (7):
  drm/arm/hdlcd: use drmm_* to allocate driver structures
  drm/arm/hdlcd: replace drm->dev_private with drm_to_hdlcd_priv()
  drm/arm/hdlcd: crtc: use drmm_crtc_init_with_planes()
  drm/arm/hdlcd: plane: use drm managed resources
  drm/arm/hdlcd: use drm_dev_unplug()
  drm/arm/hdlcd: crtc: protect device resources after removal
  drm/arm/hdlcd: debugfs: protect device resources after removal

 drivers/gpu/drm/arm/hdlcd_crtc.c | 78 ++++++++++++++++++++++++--------
 drivers/gpu/drm/arm/hdlcd_drv.c  | 36 ++++++++-------
 drivers/gpu/drm/arm/hdlcd_drv.h  |  2 +
 3 files changed, 79 insertions(+), 37 deletions(-)


base-commit: 8fe444eb326869823f3788a4b4da5dca03339d10
-- 
2.37.2

