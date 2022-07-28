Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDD7584891
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiG1XMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiG1XL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:11:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCD14C638
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:11:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i8so4025546wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GdPmGJsSD+Rly2C/T4Se+7BRYHNRgvNRspUD0lWhZ3g=;
        b=GVsGKlCSdL6HaRl9VPPqNE7Zdoc9KafkFtJjRdFFn4Bbbjxj1JE9qwruodhBwuYpWk
         0ZpixhvNVwBIA3Tj1hUbD3ap1k+SP1idXxCirpgtSI4QX2zeZ7EIixe9rtgmaozYjgtm
         vc9qHEmFsIM9yS8fiTj1EJ+++HJc3Z19qrmMv+bKJn46uMfcM0AyUJP9ZOPOFnCMoSjs
         fDvL15juEQtJzCKieY3nGai6k8llgGb1briAaUxyNsm56Ylm+KaXlCAyaF/qRhK/LOKf
         tzAfM4L4UzwJ+cZuyEMypWgh3ZToloHyyy2lsjn/4cB2Uu5RMYYFd62e5W41lcwGGijk
         Iu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GdPmGJsSD+Rly2C/T4Se+7BRYHNRgvNRspUD0lWhZ3g=;
        b=bDT68AAUwr5GOmuYHqU32vmL/pJZQKiSV7wzbi5ij1THHaY/7J6ylHpbx957Cn9lT9
         BEAMgX2u99tmLq9cTQzSXSx45ToOt+qbR29IljIDcXPD5+6GKQ9iJTcQ7pzQEBViqvY9
         5JJ+1ApOb1mMpfiSZHq6+893cXfJy3WpmxAUg2YScNNVaDbV0DxoDpts7Bj6zbjU4LnC
         g2KqSzjuSq3kr+zlEvB4YO1U/M0OHjmaQSiPBBu+9euUiGYZW3LohiJxguBJFOqFqX98
         KaGtWBRwxOoXT7rJg+/qVoWgRM2EJyA0EjXJlSDSPl26O3+wd25RlpnSaA6lDLIOng+/
         P4Eg==
X-Gm-Message-State: ACgBeo2DuNo8AJNv1GFcg7y1raF5VPG0GlRCZkB79mhE//4LO2TmzctJ
        IW2tdb3Br5Nwg7EGaU/X3Y0p4w==
X-Google-Smtp-Source: AA6agR4dKGi/q//WSFXqwam3w0BKNlwdDxyw6zTLZ7WLaHZG7SNOY8elsnub43cOxcnDSWrj7kMTgQ==
X-Received: by 2002:a5d:64e1:0:b0:21e:8d9d:e920 with SMTP id g1-20020a5d64e1000000b0021e8d9de920mr608652wri.667.1659049914337;
        Thu, 28 Jul 2022 16:11:54 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2089419wrh.17.2022.07.28.16.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 16:11:53 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        paskripkin@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: r8188eu: more error code cleanups
Date:   Fri, 29 Jul 2022 00:11:48 +0100
Message-Id: <20220728231150.972-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series addresses a cleanup suggestion discussed by Greg
Kroah-Hartman and Dan Carpenter, and also includes another function
conversion. It would be a larger series, but my time being what it is,
I intend to chip away at these slowly and steadily.

Phillip Potter (2):
  staging: r8188eu: remove initializer from ret in rtw_pwr_wakeup
  staging: r8188eu: convert rtw_set_802_11_add_wep error code semantics

 drivers/staging/r8188eu/core/rtw_ioctl_set.c    | 8 ++++----
 drivers/staging/r8188eu/core/rtw_pwrctrl.c      | 2 +-
 drivers/staging/r8188eu/include/rtw_ioctl_set.h | 2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 5 ++---
 4 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.36.1

