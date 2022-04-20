Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99271508B96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380005AbiDTPKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbiDTPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:10:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CAB3B3C2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:07:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id s18so4270567ejr.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9v+bg8k7RA4LH8F4uiECLoS6Or0HyKFR68rUp70rg0=;
        b=rtT22V0cDoanqCuujkQpoaT0yhDYBLgiimNx0juuhBoRiMut7z917HHz6d+MKEQXHl
         z00kp8IR8E9kM/wmiadEhXBh35eohO+nALg9MtNBbX3HRz9qbrsAKR2FfFnYNFbiuINx
         KUMazrAPQy+TX/Y3dxm0nldDr0XuqiFu+J56Q/vyCTj3enXrf8kxa0do/tseSM6zYayQ
         fGeGM8HzlATsqcUy+LO9uJa/WwSLbuSh1qk1Pi4Mpc5SAFi4BbKy02oKwjV2kKzWEw7O
         gHdHdzmf6k7qXvTzviJ4yauLltYgHDrYcBte05jroztpm+do6DCy5h/YSsRKWLNjlMmf
         xfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9v+bg8k7RA4LH8F4uiECLoS6Or0HyKFR68rUp70rg0=;
        b=vqBSPP3EGJkg3RIv5Qj6z0kU3NvsXDSvxlAFYnVJN+kudF4L9CTPYZgi7gYKZUthnb
         kLduywMz3do4ZL0H9y+0+F1fTFrMMC03cx94HItDKiakceDjcVeNcim53CiEOUhHjTIR
         kl3E3aNSYOMRaCgRVE3WlGRu779k5yCvv4wJgm7Mb3N33fFjb+qWf2kvcteguXz7aC3d
         ueC6RzzXxb6f95RjQLXlm9lRnQbqd+vbVfh4qVKRL8Ovp80SjskikGpvXmQ+zlTCF96o
         v1MWeceVlSho/9TOaNjTrqqEcOJGCDBsB7yJfigkpL0SjrvpmA984N96iQZcjbbJ89b7
         G0Dw==
X-Gm-Message-State: AOAM532FLFBm8eroI2pwAO+7J0OMsPLQHeq8p7RQK5GfJDpLVSR5JQhf
        8IVqnbWdSZHAtcPS48qsV7rzRA16rUfmsPu0
X-Google-Smtp-Source: ABdhPJwAFQHutKppASipYKvkjN1qaI67hljqa3I5zyWOmLhP6i5HngJ0kxnxOpRY78y4Lz7nQDbExA==
X-Received: by 2002:a17:907:7f24:b0:6e8:b5a9:3434 with SMTP id qf36-20020a1709077f2400b006e8b5a93434mr18524193ejc.254.1650467237366;
        Wed, 20 Apr 2022 08:07:17 -0700 (PDT)
Received: from localhost.localdomain (hst-208-209.medicom.bg. [84.238.208.209])
        by smtp.gmail.com with ESMTPSA id zk19-20020a17090733d300b006f00e918483sm415262ejb.84.2022.04.20.08.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:07:15 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     linux-arm-msm@vger.kernel.org, ezequiel@collabora.com,
        stanimir.varbanov@linaro.org, quic_vgarodia@quicinc.com,
        quic_majja@quicinc.com, quic_jdas@quicinc.com
Subject: [PATCH v6 0/2] Introduce Intra-refresh type control
Date:   Wed, 20 Apr 2022 18:07:02 +0300
Message-Id: <20220420150704.144000-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series add a new intra-refresh type control for encoders.
this can be used to specify which intra refresh to be enabled, random, cyclic or none.

Change since v0:
 Dropped INTRA_REFRESH_TYPE_NONE as it was not needed.
 Intra refresh period value as zero will disable the intra  refresh.

Change since v1:
 Updated the control name for better undestanding.
 Also updated the documentation accordingly.

Change since v2:
 Updated the venus driver implementation as well to use the  correct control name. Missed in v2.

Change since v3:
 Addressed comments from Hans in v4l2 patch.
 Enabled the support for cyclic intra refresh in venus driver.

Change since v4:
 fixed typos in v4l2 patch.
 fix mask value in venus driver patch (Hans).

Change since v5:
 change in patch subject mode -> type in 2/2

regards,
Stan

Dikshita Agarwal (2):
  media: v4l2-ctrls: Add intra-refresh type control
  venus: venc: Add support for intra-refresh type

 .../media/v4l/ext-ctrls-codec.rst             | 22 +++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h      |  1 +
 drivers/media/platform/qcom/venus/venc.c      |  6 ++++-
 .../media/platform/qcom/venus/venc_ctrls.c    |  8 +++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  9 ++++++++
 include/uapi/linux/v4l2-controls.h            |  5 +++++
 6 files changed, 50 insertions(+), 1 deletion(-)

-- 
2.25.1

