Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2C151700A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385174AbiEBNNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiEBNNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 975A319297
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651497001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M98yuoliII0uhmAHMZF66gc9CngyxoP5h99A2Tsi4xY=;
        b=EBbFVwCJwJ9npy/ioOpNz3rXoqLvdTqkpxdDwqzObFgdhcdOUPA0RGPPEYBJfn8wUg61n8
        eV7pxCKXVNtTynM7Oudn8uYtx38I8x/YnmDIrhcHvOczyQfOXNzxJaO5NrJ0UHLZnyMmDR
        leWFu4L+UsSvSyaUFn5NdrAHOZUAxnk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-vVWjlhRQM0OlWvhssMmC2g-1; Mon, 02 May 2022 09:10:00 -0400
X-MC-Unique: vVWjlhRQM0OlWvhssMmC2g-1
Received: by mail-wm1-f69.google.com with SMTP id j5-20020a05600c1c0500b0039419a269a1so3276911wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 06:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M98yuoliII0uhmAHMZF66gc9CngyxoP5h99A2Tsi4xY=;
        b=iiNgqQaqkqZWz3cbz3mGvF3M7bXq3ZWv9Z3m1W9F+keZhPzBu3p2TTD1B35+RCa+qA
         wQYiLVF556wep1MU1wYaYHLUfaX0RzXc0i1AhmeGy/D5DSNxEiku7Vb6amZ7k7aUngFj
         KZHCzE0SvvKQA0h6ScRPhO1Ja3OPcdp00wgz5O90/16Qv8QMeAlS4OAnDTGQgx+8tbPI
         aNGr1thJ/Sf8RA9oh78wSa3aNBj8jMbapRmvUAbGPYTaqsab/uy7I/09AxKdcF3izyHX
         DyOift/Sgf7R+na+spYDrOEK2Ged81lVRRoOw0syhbFq8j46Mb6ge5n3uOOGYZ9TPVNo
         ndiw==
X-Gm-Message-State: AOAM53204jceyHrUSFuaxG3nXbjJsmS2S9PXBtniHL69+E14kLRA7stW
        j/+G3JUxwiyvS3UmTAWtdx4kQ2MLOTdEvqw9nf4nzcXNhNx3fAnN9zMP11dB5eqiJe2eCNGhGnw
        tu1xauRKkDO+n4SIPncQz2D2l4eOJ/0H8q6AULl0WMHbWKuc/IYhH8QPTC5xIuYxG2dSah6km02
        8=
X-Received: by 2002:a5d:4302:0:b0:206:4b2:8690 with SMTP id h2-20020a5d4302000000b0020604b28690mr9494470wrq.224.1651496999274;
        Mon, 02 May 2022 06:09:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKVP2T2hazdS7uD0pMN5Q6bcG0ygMlmFscepv/VzzVywZGxoSQ2B+d0TgKpqI/Cu+rYnhltw==
X-Received: by 2002:a5d:4302:0:b0:206:4b2:8690 with SMTP id h2-20020a5d4302000000b0020604b28690mr9494444wrq.224.1651496999021;
        Mon, 02 May 2022 06:09:59 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y16-20020adfc7d0000000b0020adc114136sm9302081wrg.0.2022.05.02.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:09:58 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 0/2] fbdev: Fix a NULL pointer dereference in fb_release()
Date:   Mon,  2 May 2022 15:09:42 +0200
Message-Id: <20220502130944.363776-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This small series contains fixes for two bugs I found in fbmem.c, that may
explain a bug reported in the rpi4 [0] when using simplefb and vc4 drivers.

I was not able to reproduce the mentioned bug, but looking at the code I
think that it might explain the issue.

I've tested these patches in a rpi4 with both simplefb and vc4 drivers
built-in and did not find any regression.

[0]: https://github.com/raspberrypi/linux/issues/5011

Best regards,
Javier


Javier Martinez Canillas (2):
  fbdev: Check in file_fb_info() if the fb_info was already been freed
  fbdev: Make fb_release() return -ENODEV if fbdev was unregistered

 drivers/video/fbdev/core/fbmem.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.35.1

