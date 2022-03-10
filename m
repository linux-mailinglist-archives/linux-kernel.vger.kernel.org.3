Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5640C4D559D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344778AbiCJXqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344551AbiCJXqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:46:34 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BD619DE8C;
        Thu, 10 Mar 2022 15:45:31 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t187so6040987pgb.1;
        Thu, 10 Mar 2022 15:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJVGSw0Gsp0ElMn++CtRLOM3hI6c+NG4/N8yRR58DmQ=;
        b=nFHfOqVeAKi8MeaSk15PZpvyM2vC539pwlaEbTxQd/oePNq3xoZ9IdbxmFGQHzwuzl
         ouayfD2MWaKeAcMYR3kdbw7bQtTMrzN9e/PpPyMng3zpKWktpQC5mPZFeZ5dMnt3zbB+
         VIy5JCjQpWwv5ptUwYpCcXwGaBDvJ5uf6gx1IIf5PAYqbfBPdlPCtqqSnZr+pGKotUZg
         WY6Iw8waLo69on5La8JQFpvVPDH57przII556uWEXQpViIyxgVSiuitQmbx9zAoz9PAC
         hRHAu7lo4UQ/+jFLU1Y1cIiYe3bR9CNBnO3cHBjfQ9whAaAub5TBmx4hU80aNbK7xVth
         4uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJVGSw0Gsp0ElMn++CtRLOM3hI6c+NG4/N8yRR58DmQ=;
        b=TCSvNiQ5lry3mXpmopiD0uQzgootczYJzEV7UkHrikK4ZD+CwKgXIyew6m/s8ds4OU
         iYyfmNZmPZMxz7y4v2DLBp900skmNvm+kze174EHDWw71i3FOIZo9GAK9hZIsXm6Beim
         laAlg9gLgnWW4vDv2lLpLpKrZNnHkYzzvI7gt0psJqRvKdZxSVd6gUBZhLYSnld6Q+El
         1zfx5B6rcAbCngKfc64PfFuFVx6AZGLbHrSIXIt1q45j+oKir0lYvswySVZ+SMDR9Sow
         gWYSL0qnguufDais1QVfy/uIUCIy8tuN3vTN/J4evSIM/Td9Q3x4NHgHEKUOXBXy4DSU
         CfcQ==
X-Gm-Message-State: AOAM53265OxORPzBlMM/79a/Aj9zVeYw/VqQvLeyW1P32L7PUCKLf8E5
        FpArlF6OoL5GPE9y2wZi2MM=
X-Google-Smtp-Source: ABdhPJwLCG3YZoyGRoW8VPXvzJyAmxxuYzqRFyADp5+KhU4VByp4OuLPa6ObO/2zjFDSW87z4UMlVw==
X-Received: by 2002:a63:e817:0:b0:373:8abb:2c51 with SMTP id s23-20020a63e817000000b003738abb2c51mr6075407pgh.185.1646955931416;
        Thu, 10 Mar 2022 15:45:31 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id f2-20020a056a0022c200b004f7649f78dbsm5915119pfj.139.2022.03.10.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:45:29 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-kernel@vger.kernel.org (open list),
        Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: [PATCH 0/3] drm/msm/gpu: More system suspend fixes
Date:   Thu, 10 Mar 2022 15:46:03 -0800
Message-Id: <20220310234611.424743-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

In particular, we want to park the scheduler threads so that suspend
is not racing with the kthread pushing more jobs to the driver.

Rob Clark (3):
  drm/msm/gpu: Rename runtime suspend/resume functions
  drm/msm/gpu: Park scheduler threads for system suspend
  drm/msm/gpu: Remove mutex from wait_event condition

 drivers/gpu/drm/msm/adreno/adreno_device.c | 79 ++++++++++++++++++----
 1 file changed, 65 insertions(+), 14 deletions(-)

-- 
2.35.1

