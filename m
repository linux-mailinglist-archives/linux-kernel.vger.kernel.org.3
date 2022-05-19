Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA26252DC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiESSNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbiESSNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:13:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5B5E2770
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:13:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eg11so7936858edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yewj9dP5wt1s9U7YLpUlVzt9mnRkbAegjhyrplYM9o=;
        b=ZS4k5Fm/0QXzwwqTCYl+32tMdKVp4Irl/rcz5oQBu563PTd1iYtaAJvhqv9eCO3k9E
         X8Job9oByn6vKu6kHUHdHIlhnCizt03qVrq2i+f8+N7tMCPaeoIg8hwzo9EJXkRCC5vx
         zDoLvvgAELMBrE3OEhh2peuigQmED0zjecoKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yewj9dP5wt1s9U7YLpUlVzt9mnRkbAegjhyrplYM9o=;
        b=4Eyaf/BrjIE7hs20LlDi94I8jPF5tls4B4GJ5bixN0n1owjwq3MedCFtWWT3xvRF3k
         KAqUCuY3RWg9E4VF+ysi4sbXGLz2vq0U9WAL+IkjDfrH/NMks6SU2XjTxaaQgIgzVB/x
         HSuLN9WXeAVPWquQ68tavOg2NZkr+a2Q2F28Wx9fO0kgszkKMuTaKoRCh4RbaHgFo43b
         1KYc3YrLjDht7hrGVOhu0ubhIu9NuoienuIl6eveHqGwh84FfJ5385Ict61a+4iWGytB
         0ASKUziHwhWBh0MZDkxezY5UAd1hpv7CjFXRUe4J6ydZcPWSGTNCwPoUV5KHASK/TZHc
         9RPg==
X-Gm-Message-State: AOAM5317fa61WvnVQe3169B5mA+YyrA5RzHdHwaPw7mLZVwKO6zuDLOd
        WPjM3zKKrt9/ksSUgZFDofZazg==
X-Google-Smtp-Source: ABdhPJxj9yor8DLRo7AKs+MbH9niGQxzN3gmHrj9+B5/8RxjDUcKrU9rjROhOL9EihfIYDqVEIssNw==
X-Received: by 2002:a50:9b0d:0:b0:42a:4bda:c70 with SMTP id o13-20020a509b0d000000b0042a4bda0c70mr6837244edi.287.1652983988675;
        Thu, 19 May 2022 11:13:08 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hw7-20020a170907a0c700b006f3ef214e3csm1225801ejc.162.2022.05.19.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:13:07 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/4] uvcvideo: Fix handling of power_line_frequency
Date:   Thu, 19 May 2022 20:13:02 +0200
Message-Id: <20220519181306.42136-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uvc 1.5 standard recognizes 4 different values for this control, but we
were only using the first 3.

Also add a quirk for those devices that only support 50 and 60 Hz.

v2: Thanks Laurent! 

Do not modify the behaviour of v1.1

Ricardo Ribalda (4):
  media: uvcvideo: Add missing value for power_line_frequency
  media: uvcvideo: Add UVC_QUIRK_LIMITED_POWERLINE
  media: uvcvideo: Add LIMITED_POWERLINE quirks for Quanta UVC Webcam
  media: uvcvideo: Add LIMITED_POWERLINE quirks for Chicony Easycamera

 drivers/media/usb/uvc/uvc_ctrl.c   | 91 ++++++++++++++++++++++++++----
 drivers/media/usb/uvc/uvc_driver.c | 27 +++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 107 insertions(+), 12 deletions(-)

-- 
2.36.1.124.g0e6072fb45-goog

