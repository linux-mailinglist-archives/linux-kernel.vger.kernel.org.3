Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C204F6A09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiDFTfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiDFTfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:35:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58B311D7A0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:22:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k23so5714245ejd.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I61gN2qyHfQVc0lXEisvsSshJTx/hjGvwxAqAi4L41M=;
        b=mQeh1ZOB58Xp4ghWny/k9KagUmjj7tiQrxMEkzUU8AJtPIWT6WZZImN6wIvKB8KyCY
         A+hfHCQRcqO8rt2v+B0p5bo2Ioej5IWO6pqGWAFrePNIh7OycZhNQN2PgTZEYp/436TO
         MXaI8aC3+9Jy1vuwCdE1lfKHGYHFWwZpy+v1Xc7g7YPd1aJc5WqVDN7Va+vSIIxu7PhB
         yRqXmT0fOhmCC8Y2+wTvL6VubWMkh7k4997DFqWVm+qGMewJq+Xkp5CV+/0s0oYrG6sz
         n74SRu3wu1GpsLv4QIfaUeo6DqAVx29Xe5Rl2QgWqaX3+tsxsrtvbknlWwJ8AQmyNpdn
         zXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I61gN2qyHfQVc0lXEisvsSshJTx/hjGvwxAqAi4L41M=;
        b=EaqvoLDqc9GOLK0fW/FSRtMUkDC0/mdj8uOglHhAt7WE0oBVTpKRblfAQDpc6GGVOi
         zy7IpoLa2pDhNFokkxcHOCkXAlL5xNBNPeF6HCpBRk1T1GiphK9hNTHB0KRQ9ercsx3X
         lo5beGIxBIysbCc/lhh+PN7VWuAX7NaP5+HG76BYePv/B48XxRRR0MBAkbz6fOI7QMNw
         xH7cnl9njeTU1TLlL6E+duay8edMKAOpG4mVpTlL/rreP8ziY/G3qWGAEPhrJZ+BjimP
         +hpCF4alshAEsNpSCIGTIFcpQ8Xnjq3hx8zIhptTqEXsURAzIAMzt5xLFjUwGW3IHP5h
         Mt3g==
X-Gm-Message-State: AOAM532yjMw/OLoMLs0w9zYOLjMqH5BFH5it4KyPoHSV9eSM2xY/EbbR
        LkhowOciMM11pmqRStFl0mU=
X-Google-Smtp-Source: ABdhPJzZHiAnJyLP+Iks60sV0TEElSwYYK4adIyA/DBg3K62WmoCz8LytOn97+kMRFDrFe7ZBShkgA==
X-Received: by 2002:a17:907:7f8d:b0:6db:7227:daea with SMTP id qk13-20020a1709077f8d00b006db7227daeamr9338204ejc.100.1649265755199;
        Wed, 06 Apr 2022 10:22:35 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm7912730edb.14.2022.04.06.10.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:22:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/5] staging: r8188eu: use round_up()
Date:   Wed,  6 Apr 2022 19:22:14 +0200
Message-Id: <20220406172219.15565-1-straube.linux@gmail.com>
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

This series converts the driver to use the in-kernel round_up()
and PTR_ALIGN() instead of custom _RND* implementations.

Tested on x86_64 with Inter-Tech DMG-02.

v2:
use PTR_ALIGN in patch 1/5

Michael Straube (5):
  staging: r8188eu: use PTR_ALIGN() instead of RND4()
  staging: r8188eu: use round_up() instead of _RND4()
  staging: r8188eu: use round_up() instead of _RND8()
  staging: r8188eu: use round_up() instead of _RND128()
  staging: r8188eu: remove unused _RND* from osdep_service.h

 drivers/staging/r8188eu/core/rtw_cmd.c        |  2 +-
 drivers/staging/r8188eu/core/rtw_security.c   |  6 +--
 drivers/staging/r8188eu/core/rtw_xmit.c       |  7 +--
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  8 ++--
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  2 +-
 .../staging/r8188eu/include/osdep_service.h   | 43 -------------------
 6 files changed, 11 insertions(+), 57 deletions(-)

-- 
2.35.1

