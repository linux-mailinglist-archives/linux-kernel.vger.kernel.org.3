Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5E34FE337
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356621AbiDLN6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356540AbiDLN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:58:02 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA10DF51;
        Tue, 12 Apr 2022 06:55:44 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id h63so22296868iof.12;
        Tue, 12 Apr 2022 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jwpCHe1y3f5jd2jJ6ba48FfXPVfZO1qP0h+WFGmWlYs=;
        b=GRWy8rY14x4DS5KcUrvlEbtUahmMrOddIUCgMxLLLjcWdZLRiQdcQLF3nJr0zmroA/
         Kg21CqQA6Y8joh0woVe/6t1MXlEMsfYI4V2fndyv23BFcUUQHTX8dTjOIWRRREwSIIEg
         NhAiddMUiPNWgtDB4Vz9Ngoruyu16GfkvSnbmwc8R8651vhB+VdOQfNZu0FHfu+ZsfpO
         3Qz+sX6mtAHB+xYM8IZUeUY2TPwX4XCtjhRoSjI6OSkp7cZhzJuF5zqzW1+pHJfum4su
         mvWM0DOrwge4A34ORWWqgfsdpPABAb215lTNrLGyhBe7zDd+JpdWu5Nt+Aq40AGGSTac
         IMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jwpCHe1y3f5jd2jJ6ba48FfXPVfZO1qP0h+WFGmWlYs=;
        b=Yt7S64uHoL0NrH+1g+WMAJ4DGYdcPjwz9Gkv+IPHRzzXJMAqr9XulJq0gEePL8Dmc9
         BG91CU4BaWWzR294lExIIyvlTdYar5U7NMzYQCTEszY7UR5kl8gkwhSe4bfdyAd1ZYS8
         upRYfyXLdjqGZmGeP1E2oGI4IPv8j8NQQ17nCbJuyVPJfm9SR7fXefMmVt4hhsduxmnn
         RqPggdgjqjJi+YvcfgALj/Kb3bBbVX4s8fPrd7eJ1FwvEcmbughN9/MVwI/A6oROFhpv
         DLEQs6c6ABpQ6nvaf3xpiNNNA4Ur307C+Fwof9rkqvXLGDgIOIqHS4cM99JWca8KcAvn
         bnfA==
X-Gm-Message-State: AOAM532vvHV7fb2efeEVjZ9CKiuzXRAjnIkNi0fgD64PcFV9XCIQwpwP
        eDhbHaOXozzeTekpDzMsGQFAePtBgMJy2g==
X-Google-Smtp-Source: ABdhPJxYAw6lmJpHj1wip7CkchFGObOuhQXhTO884v/kjKp274piptwfYW9uR25fe4w6umH8lnRZHw==
X-Received: by 2002:a05:6638:260f:b0:323:ae28:a0ec with SMTP id m15-20020a056638260f00b00323ae28a0ecmr17687022jat.278.1649771743827;
        Tue, 12 Apr 2022 06:55:43 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2611:a7ae:f1c9:5ec2])
        by smtp.gmail.com with ESMTPSA id n12-20020a92dd0c000000b002cac22690b6sm2280748ilm.0.2022.04.12.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 06:55:43 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, tharvey@gateworks.com,
        cstevens@beaconembedded.com, aford@beaconembedded.com,
        laurent.pinchart@ideasonboard.com, Adam Ford <aford173@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] media: i2c: imx219: Enable variable xclk and 4-lane
Date:   Tue, 12 Apr 2022 08:55:29 -0500
Message-Id: <20220412135534.2796158-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently only supports a 2-lane camera, a fixed external 
clock (XCLK) at 24MHz, a fixed Pixel Rate of 182.4MHz, and a fixed
link rate of 456MHz.  There are a bunch of hard-codec values in a 
table of operating modes which expect the above to be true.

According to the datasheet, the driver is capable of operating in 
either 4-lane with a pixel rate of 280.8MHz and Linux frequency
of 702MHz or 2-lane configured as stated above.  The XCLK can be 
anywhere from 6MHz - 27MHz instead of being fixed at 24MHz.

Split up the hard-coded values into smaller helper functions that
dynamically set the registers of the camera based on the XCLK and
desired number of lanes.

This series was tested on a Beacon RZ/G2M streaming video at 640x480
to an LCD with fbdevsink

media-ctl --links "'rcar_csi2 feaa0000.csi2':1->'VIN0 output':0[1]" -d /dev/media1
media-ctl --set-v4l2 "'imx219 2-0010':0[fmt:SRGGB8_1X8/640x480 field:none]" -d /dev/media1
yavta -w '0x009f0905 2048' /dev/v4l-subdev12
gst-launch-1.0 v4l2src device=/dev/video7 ! video/x-bayer,width=640,height=480,format=rggb ! queue ! bayer2rgb ! fbdevsink

Due to hardware limitations, the XCLK is still 24MHz, so anyone
willing to test this series with a different XCLK would be appreciated.

Due to the video format, streaming video at larger resolution was
not feasible, however individual frames captured at 1920x1080 were
successful.

Adam Ford (4):
  media: i2c: imx219: Split common registers from mode tables
  media: i2c: imx219: Support four-lane operation
  media: i2c: imx219: Enable variable XCLK
  media: i2c: imx219: Create DPHY helper function

 drivers/media/i2c/imx219.c | 340 +++++++++++++++++++++++--------------
 1 file changed, 213 insertions(+), 127 deletions(-)

-- 
2.34.1

