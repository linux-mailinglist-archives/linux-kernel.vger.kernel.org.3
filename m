Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094F7487E82
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiAGVur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiAGVuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:50:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA18CC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:50:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v123so4834091wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQnTAOzqfnEo9STtUG3p3gnrWCeSeGnMweWxCdq98J4=;
        b=l3aYK2qsZES/UMTB5Dj5xMSWSGdqQggwJ3aZCUV0OcmD2G1e7ZquqML2OsMOl9sbU+
         uUaoRUQ65f9Kt72KdVV5Fk4ItZ+gf0MzCs32xgmiAakVK+eulsGry8sKqhqgi6FdBMjF
         PJy0i6/1ygrYUbixHPb9dBtPrNYa9K/hYTf2RUqOmKgX3f9zkFIv2YSjAqvG5/vSRIIf
         PwOlKo8ccAEtWHD4FyHPijdz67t5nYevsDzcNfhptq0k/WcV7WLIzBoPmLqYylX/MIm0
         w+7xv1NZUaT/uVIf/RJL60VAngX3Sc0TRtCcogE5SvLfsXa8NPaKeqwvMCbJfr35CljX
         1n6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQnTAOzqfnEo9STtUG3p3gnrWCeSeGnMweWxCdq98J4=;
        b=epBKUfczMUFjQVD+jOKMMi65w+hIu5Mq0CbTuN4+LQPviEyqt6ELmANorXlZvFrORL
         7b9Bys2VQciXfasIeHUN1DPmjusnNgZmU4bJ383rqfABC5CtG4h26Fa7oEiN91z0jfsC
         rjex0vbBKHO9t49gDntrbqAOO6c27MVKi99Cmx8sQJ/bg5zLyQMEuTAu10VbEEbSZBra
         jlfZT2DL3UEL/QQ8cF4ABKh25ElbOmh9/tHWmlczx7KQuTXj6P7KUOwHsvANhJb1uJ6L
         oqwu9fY0qhNYaX3ijzcNkyFve6nohGCOTpo+p9lCcBeQgDv2oQHRJMdQpE7HFLHboiwf
         S8wQ==
X-Gm-Message-State: AOAM530wzo76Noe0d3DiC0HvqZho6+5ONtr3UitX2DUqHn5/07OlsXMX
        DoDimM0LYN+EtYzG+VFKKN8=
X-Google-Smtp-Source: ABdhPJz9FjU6RPQHxLJMyrC3sBYKcJwGoUxuDVqAat1O6y7hObS2LOthMSza8UlzN1X+k02m4SmHvA==
X-Received: by 2002:a05:600c:1991:: with SMTP id t17mr12546723wmq.21.1641592244312;
        Fri, 07 Jan 2022 13:50:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id k14sm1729161wrn.59.2022.01.07.13.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:50:44 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/6] staging: r8188eu: clean up GetHwReg8188EU()
Date:   Fri,  7 Jan 2022 22:50:27 +0100
Message-Id: <20220107215033.12257-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes unused cases from GetHwReg8188EU(). Some of the
cases are also unused in SetHwReg8188EU() and removed there as well.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (6):
  staging: r8188eu: remove HW_VAR_BASIC_RATE from GetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_TXPAUSE
  staging: r8188eu: remove HW_VAR_CURRENT_ANTENNA from GetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_EFUSE_BYTES from GetHwReg8188EU()
  staging: r8188eu: EfuseUsedBytes is set but never used
  staging: r8188eu: remove HW_VAR_APFM_ON_MAC

 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  3 ---
 drivers/staging/r8188eu/hal/usb_halinit.c     | 25 -------------------
 drivers/staging/r8188eu/include/hal_intf.h    |  5 ----
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 --
 4 files changed, 35 deletions(-)

-- 
2.34.1

