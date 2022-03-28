Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871594E95B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiC1Lw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243200AbiC1Log (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:44:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F2832042
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:39:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r13so28033127ejd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qbZlyK41top+fUFxaArbnfsAsaJyOPV3CRdd0agBOs=;
        b=eiav2mIIB10KaNLFSu2fH/zVh1VhcZp/GYAuzUkyCYBXYMisjBWmSh70c2CNQ3Ng44
         F42KDPdbDtkeKXVs6reqLAEGIu4nn6yiS0hEImIWzXsKs2D9ePOqpjmZm9eJPvIjuvUg
         oaPFnkWdkO5Usm6odR0NbSgn16QIpAXFx8WGlh2fVfPn9AIprAblqlbai2REppcFCfVZ
         2Ah+xvvXnPKkTJZ9PjMqgpQZ3kjcK7GIcXYCCgoN7lCftwFo3kzrM/qTt0hvBakW6Vax
         NP7zSqWYvpBP5iIaTZD0RjO1vWO9hK+KJ1q+xvNYBdbNqZj+tTHM4UC9UuxW/PIrfcYt
         LlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qbZlyK41top+fUFxaArbnfsAsaJyOPV3CRdd0agBOs=;
        b=EVLR2csVm2n3kFMk7pUAJ6Ynl51Q9IOL3z5OLI54UQk2MhPw3sMvIs0O6YBvukbdAf
         joGHYJj60Sy3EzJJd/N6/TTaTf94l2ZZDkxd2pGWn0HX+I7rU9WjYzN60dXvGf0tEQzQ
         3mwfbsYc54cosZa6wcIrjCZNjaZTMAtu5ltgtaGBiO44iCWC65iVcHQSszgQKD69o6CJ
         K1fQHWwE+Q9C9cIiXlmSfROFzKnpzW0UZd0DG2wMhBzMYak/ktiJDlUWE7N4JufYEvZM
         nrSGG4fjXmcUT399YXZjBwM4z0+pVyUZ1dQnNXApmDYxUE1t79nYXq4ZTnSbtYfY4ger
         PNqA==
X-Gm-Message-State: AOAM533sbZnE/kURjg1XXe1qUXuC5f5wXVP1Xx3WrXVC6kyFKJT/V9/5
        WB4AWuD7EnGEhJQVaC64Mys=
X-Google-Smtp-Source: ABdhPJzJz42IY+2x7DyRmSbgEb2NLTDjQIn7jkFcMRAFbG0Iemn3uf6JdQTV4qH/pOdp3qCgfwX8+w==
X-Received: by 2002:a17:907:1c89:b0:6e0:cc9:345a with SMTP id nb9-20020a1709071c8900b006e00cc9345amr27563502ejc.332.1648467590086;
        Mon, 28 Mar 2022 04:39:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id hq39-20020a1709073f2700b006dfc58efab9sm5938556ejc.73.2022.03.28.04.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:39:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/9] staging: r8188eu: SetHwReg8188EU() cleanups
Date:   Mon, 28 Mar 2022 13:39:31 +0200
Message-Id: <20220328113940.6396-1-straube.linux@gmail.com>
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

This series removes some cases from the function SetHwReg8188EU()
and moves the functionality to the callers. This is part of the
ongoing effort to get rid of the unwanted hal layer.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (9):
  staging: r8188eu: remove HW_VAR_RESP_SIFS from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_MLME_DISCONNECT from SetHwReg8188EU()
  staging: r8188eu: rename some macros to upper case
  staging: r8188eu: remove HW_VAR_ACM_CTRL from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_RXDMA_AGG_PG_TH from SetHwReg8188EU()
  staging: r8188eu: remove unnecessary if statement
  staging: r8188eu: simplify if-else statement
  staging: r8188eu: remove HW_VAR_TX_RPT_MAX_MACID from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_BCN_VALID from SetHwReg8188EU()

 drivers/staging/r8188eu/core/rtw_mlme.c       | 22 +++----
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 27 ++++++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 38 ++++++++---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    | 12 ++--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 63 -------------------
 drivers/staging/r8188eu/include/hal_intf.h    |  5 --
 .../staging/r8188eu/include/rtl8188e_spec.h   | 10 +--
 7 files changed, 73 insertions(+), 104 deletions(-)

-- 
2.35.1

