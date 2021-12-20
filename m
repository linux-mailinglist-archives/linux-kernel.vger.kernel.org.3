Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DD947B535
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhLTVac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhLTVaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:30:30 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBC8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:30:30 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 132so10680219qkj.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CjOpGoTB+RgFzED/Z5AJZmeEWUvnehVde5GsP9KVlrg=;
        b=iPwn9myv9DhSISQF4gJy7e3ExgU3CZV85sDsiLBSKar85A7qLsigdOqYYxRYht2dzG
         K0pxeA4bfxppWl1XmCx4YwCS+CEFByUmFJ1IviO9vNfG2mlLMaXFRMsahgdiha4rudKu
         6VwLnLMWggIpnv7UXmFvmnrhEBqDeiIz3Iiutd7CyzGN1bEe4NYeDXyznYYDwKv+G23L
         pvg4vyr9qf6RAaas6Ggdp+qjupqXTDGTOnATs7ccwnLGomdAXynhTxDplLl6cH0hiYAv
         rKsO0Kjam7ytgrOFMBhoeG6YiuCqsSDkUQ3ydkvecc+klDoUiDuL+iLm1PvEq+KJRTot
         bk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CjOpGoTB+RgFzED/Z5AJZmeEWUvnehVde5GsP9KVlrg=;
        b=AVq1tY8DzIlIe8jMlKWWa2ozdKPiE8YMBGW3RmExq9dKk6eXrMJ8nagMTK19sY2h8L
         fFbfPwARA7W9VR194Svv9NaxZDoZt3CrlrB7VpoQScz6MYFMSAUD6ZpnEDoPT083qMKr
         uJG0+aFwJE/0J35R4q0ysbPt4YaFYAf7tsinf7fcFmACHc32MX1HA5BCPKqUGi7SF2uL
         By3O5+lHLXx/VWAzrGEpYyCJopFc4O3yL4ljDBvREKdQGO+UTsoUDBD4jlFwBGUNeJkK
         /6/ZklRv9VMVfw9IBcpxJlNL4z/X6xCz75GaPKyJf5JFTK4T1FXrpLKepx5Ul9bc0iNI
         A1wA==
X-Gm-Message-State: AOAM533MTGd/dnONHWym/URuwyWG/l8ZDO5tcMKYG7k6KeN6xqbPBpxN
        OWSNybBbWEoE+P928P2GzRs=
X-Google-Smtp-Source: ABdhPJwsW3YzqTrxOFRap0vjfSnMSaYXOxThDtZXdIBLAgmpQiM0u9ULfOv8wwdtazDAaYNCF/qYwA==
X-Received: by 2002:a05:620a:bc7:: with SMTP id s7mr101221qki.20.1640035829392;
        Mon, 20 Dec 2021 13:30:29 -0800 (PST)
Received: from localhost.localdomain ([181.23.83.92])
        by smtp.gmail.com with ESMTPSA id s20sm16132210qtc.75.2021.12.20.13.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 13:30:28 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gascoar@gmail.com
Subject: [PATCH 0/4] staging: vc04_services: avoid the use of typedef for function pointers
Date:   Mon, 20 Dec 2021 18:29:10 -0300
Message-Id: <cover.1639858361.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set removes some typedefs for function pointers in vc04_services.

After patches 01 to 03, there are no remaining typedef under vc04_services.
Hence, the patch 04/04 updates the TODO file removing the 'remove typedefs'
task.

Gaston Gonzalez (4):
  staging: bcm2835-audio: replace function typedefs with equivalent
    declaration
  staging: vc04_services: replace function typedef with equivalent
    declaration
  staging: vc04_services: avoid the use of typedef for function pointers
  staging: vc04_services: update TODO file

 .../vc04_services/bcm2835-audio/bcm2835.c     | 28 +++----
 .../vc04_services/bcm2835-camera/controls.c   | 76 +++++++++----------
 drivers/staging/vc04_services/interface/TODO  |  8 +-
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 24 +++---
 .../vc04_services/vchiq-mmal/mmal-vchiq.h     | 13 ++--
 5 files changed, 66 insertions(+), 83 deletions(-)

-- 
2.34.1

