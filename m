Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0826487F92
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiAGXr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiAGXr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:47:28 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D950C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:47:28 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id y4so13100943uad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsjqkGqy6pSC1mMC8XAbvqLyGbXxj+iPNK2s4dSfdoI=;
        b=BpPKfTU9PLl/3gxNIUmI6BsxTslJeFHYClQVDUdZ/WM8hwSwthcEXCT6yWA7hYh6d3
         oyWdTRpE1SF/sQnHcwWByTpW86izTuXwkgw+C9VlOAV4SIfI4MIU8OGb5Plr1b0Mdq9b
         weCK6zBIaI7W21cyO9Qx0lo+iBap9dkwcksx7A2bKWTPKWvt5DW61FdifC9bokl4FOXk
         xHE+6v9MMKYIW6N7rFAWSoelTk5SJ2W7kNLmv350DmbDve+0nGToFEeiBIO+Zb7x32TJ
         j/LTYb7/e2hGdqRQmMvcAFwbtP1mWDeaT1WlZjFOI3IvNGwqvyKq5Idq5j9S1/H5jRpf
         W7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsjqkGqy6pSC1mMC8XAbvqLyGbXxj+iPNK2s4dSfdoI=;
        b=agnronIKpQOqXejpbg8Xm01JKA0EthydrphTStoSo+TfqEOcGI8oVINVcQq4zjo3M1
         yytk2uSMAeBYdLW/h09997VgPFhExzzAAXaEx8yJobzBrV4mAdGQkOcXWMyzvTfA1A3C
         M+y/FXNE4y3L6u5NiN1nehSmYw8+OUzaKWnZ526np6ifMpQiHwlVZeVNn97ByfbTF6iO
         dT8EqaBD4btfXh546XlnGyVFf9pIzntVR7jDWecChH+XcNPGXJSnzj9knA3mX+0E5Jo6
         KhXZpT70/g3kIwC1TSIg2gA/2sKrakY/0epb66ynvbOwhg2faWmNl5QGohko/lM8b2zq
         e+nA==
X-Gm-Message-State: AOAM532ouJ4Mlk7rksvaT67WTUwahGuH2rzGpKyVBZI83DcqAlPPphSc
        nd7aQEOJAuNerwuPeX7EayA=
X-Google-Smtp-Source: ABdhPJwrSzqlFKGcNBdOv3GhMjwTcnWT88Ui7uhRd4SwoIwTpxZaMLTkf0RmU9SwqCwhWBuLF43qJQ==
X-Received: by 2002:ab0:133:: with SMTP id 48mr21245117uak.132.1641599247302;
        Fri, 07 Jan 2022 15:47:27 -0800 (PST)
Received: from localhost.localdomain ([181.23.94.152])
        by smtp.gmail.com with ESMTPSA id az22sm92911vkb.15.2022.01.07.15.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:47:26 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, len.baker@gmx.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 0/2] staging: vc04_services: cleanup macros BM2835_MMAL_VERSION and BM2835_MMAL_MODULE_NAME
Date:   Fri,  7 Jan 2022 20:46:18 -0300
Message-Id: <20220107234620.49900-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches cleanup the macros BM2835_MMAL_VERSION and
BM2835_MMAL_MODULE_NAME.

Gaston Gonzalez (2):
  staging: vc04_services: remove unneeded MODULE_VERSION() usage
  staging: vc04_services: use KBUILD_MODNAME instead of own module name
    definition

 .../vc04_services/bcm2835-camera/bcm2835-camera.c      | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.34.1

