Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F72651D726
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391584AbiEFMC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385170AbiEFMC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:02:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34F760DAA
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:59:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso6674188pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 04:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=k/db5mDIqxF7tWh2TgTqZMi0bDMawymBz0T7VjfdAXY=;
        b=ftM2/RuajOJCsGPt4mHROqHa9jy0342iIxQeK6RY+ohhEpSkNHmIMdtGnRaTgcbNcB
         aMBupgCqaxm6MxXZGeMQ5ebp+vdKXSYwwgjv+Hor3AomzdmvYmTBIi9LPHpjSe9bPSHV
         kW/wFlnAdG51rsEND5zC1ITDFX+gtArS321KRE/7eYD3oaWAlDaobYHprZfSb1MB4Dpg
         cuBbJDtInMNKyM9o78BLml2DEifpvqDfbFjvfBeeE2MMB7hI62FolwJJgI6fefxW54B1
         4VMBgs/IXpcNtH2n9OYReZP5oir7n6a3ZvcbbRqO11Bb8BRNX15itfwEco1RinOw9LFi
         e7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=k/db5mDIqxF7tWh2TgTqZMi0bDMawymBz0T7VjfdAXY=;
        b=1WPp2X3hIh/CqHCVDoVrgxM9USR8fczfFA5IEEeVGuUixPvA1386D/tUna96blk1Aa
         i+zi/VNBSoclO7QYLsLiwQGvqKY/pKhiCoOf6iF9bkHQKk4J9BgRbF+jyJtD2ns1h22Q
         pCpF+dR8EYuPd8FrpEjZ6T77pftrobxotejPoaEYYWRwPfGSCyAypJWEnhAjO8q9vtya
         +BRzP6ch0wVPrvi/IZZhDw5p1p4QQPsKfMq0aRshqF5OgoxUbcV6l/+wPAmz8AJ4KJKX
         4sZW83mEqvh9jNCTwb+R2s4m3jsQFWgp2tvgtpslNlKbCQ+5Iq+W7GoAmfRGZPU2i3Fi
         udKQ==
X-Gm-Message-State: AOAM533Tan5CPp5LzksqqaTlugDMIZMz/Jg+YzxeSfIdQyLv7lAbcKY7
        h89rq527MN3t9GhNhkABUNw=
X-Google-Smtp-Source: ABdhPJwzlpHqgyZVbWY5+k5LR3EhCUN8ijXNyBkObccZ5nKE9GvaM11n/yjQHU1caBwSWd1Pc845Xw==
X-Received: by 2002:a17:902:9304:b0:15c:fe50:6581 with SMTP id bc4-20020a170902930400b0015cfe506581mr3205572plb.132.1651838353236;
        Fri, 06 May 2022 04:59:13 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id g67-20020a636b46000000b003c14af505efsm3132460pgc.7.2022.05.06.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 04:59:12 -0700 (PDT)
Date:   Fri, 6 May 2022 19:59:07 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     dan.carpenter@oracle.com, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] staging: rtl8712: fix KMSAN: uninit-value in
 r871xu_drv_init
Message-ID: <cover.1651833575.git.wanngchenng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog v2->v3:
- Add error handler in r8712_usbctrl_vendorreq().

v2: https://lore.kernel.org/lkml/cover.1651760402.git.wanngchenng@gmail.com/

Wang Cheng (3):
  staging: rtl8712: fix uninit-value in usb_read8() and friends
  staging: rtl8712: fix uninit-value in r871xu_drv_init()
  staging: rtl8712: add error handler in r8712_usbctrl_vendorreq()

 drivers/staging/rtl8712/usb_intf.c      |  6 +++---
 drivers/staging/rtl8712/usb_ops.c       | 27 ++++++++++++++++---------
 drivers/staging/rtl8712/usb_ops_linux.c | 21 ++++++++++++-------
 3 files changed, 35 insertions(+), 19 deletions(-)

-- 
2.33.1

