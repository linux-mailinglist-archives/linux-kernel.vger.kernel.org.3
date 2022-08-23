Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97D759EC70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiHWTe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiHWTe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:34:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373061C2;
        Tue, 23 Aug 2022 11:28:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 202so12979638pgc.8;
        Tue, 23 Aug 2022 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wmSMCRFZSxcgnDSmELzb7JIe5u2Gi0VRVmvHwrpfAws=;
        b=lpp9S+kBi2bxX0uqMqqitmwkC/F8KjETINbFgtPX33rOBLZqiofK8OVkTuZF6cTqi5
         cIISJO5g0NVILJpqVy2mX/Jthv8Ri7x0qpO0lbdONdYHf0mJ5kVX+U6pMpPN8p9IdyWz
         eW+owDT42DCziICeAHUyStY66gE+FRKa1aaIm+LOfQazFWF6GrxxBG72t0/50OAVkPxC
         Ga+aZAl61sD92lYYOMcCpcHYhx/Tj79KRsVDoTINYuh+4/79S6zf+XulGFmyM+SeTTkI
         M4i7x7BLdJPddgYzmP3PZKksDl5jJZ0Ojbsar2GA6C5RVWNkerJxwp2dRRLfccXfMeHC
         rTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wmSMCRFZSxcgnDSmELzb7JIe5u2Gi0VRVmvHwrpfAws=;
        b=1ORrnK47EbyJPsBik9lNqn16HXhZO0qbl69qqi/j7Bnj9PNCOOzAGNJoYq6GE/2uzc
         6E6svWXIMHrTTnKPL47X3nLjczPoNCyM6rsV2ZLxpASF014ZaFtHSaWfmsOa5xH1vgKl
         Eka6RFLpK81ItfUSx4nCC3clMqEwRFOf1x/jUkqP7HGnm145TQk/IXKOzlH5Ax5V6k/Z
         E0+SW2H2BGnikg3aaZ3EQgF9BHR9FoJtzX/LWFv6gQ/XeNGGrwb8TpSrCnkqbsc7omSt
         sc1gCp/Yhe7cpDhiT9D7pjfsBNYwBreCVq1ndx+trQ3F9T/DnGOPtFF0EAHWQKRS3qQW
         EXtQ==
X-Gm-Message-State: ACgBeo20JPOa7wgbxbr8RqgdjrqLZgCu0XeAzHlxpAkDSYRtUM1fvGnP
        kjUCleUZRTwiwsGueaD9jurnmlMQyGQNaA==
X-Google-Smtp-Source: AA6agR7TIJQ4Mm+joOcCymHFuewcD/S1AtW0VepCnt5olMRV4A3d0Q/2sbKF/Bz/l2i4KZqJ31zepw==
X-Received: by 2002:a63:310e:0:b0:429:bf9c:99ed with SMTP id x14-20020a63310e000000b00429bf9c99edmr21123513pgx.524.1661279293034;
        Tue, 23 Aug 2022 11:28:13 -0700 (PDT)
Received: from fedora.. ([103.159.189.136])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090a6e0d00b001f2fa09786asm10328798pjk.19.2022.08.23.11.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:28:12 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Khalid Masum <khalid.masum.92@gmail.com>
Subject: [PATCH 1/2] usb: ehci: Prevent possible modulo by zero
Date:   Wed, 24 Aug 2022 00:27:57 +0600
Message-Id: <20220823182758.13401-2-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823182758.13401-1-khalid.masum.92@gmail.com>
References: <20220823182758.13401-1-khalid.masum.92@gmail.com>
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

usb_maxpacket() returns 0 if it fails to fetch the endpoint. This
value is later used for calculating modulo. Which can cause modulo
by zero in qtd_fill and qh_urb_transaction.

Prevent this breakage by returning if maxpacket is found to be 0.

Fixes coverity warning: 744857 ("Division or modulo by zero")
Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
 drivers/usb/host/ehci-q.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 807e64991e3e..eb31d13e9ecd 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -646,6 +646,8 @@ qh_urb_transaction (
 	/* else it's already initted to "out" pid (0 << 8) */
 
 	maxpacket = usb_maxpacket(urb->dev, urb->pipe);
+	if (unlikely(!maxpacket))
+		return NULL;
 
 	/*
 	 * buffer gets wrapped in one or more qtds;
-- 
2.37.1

