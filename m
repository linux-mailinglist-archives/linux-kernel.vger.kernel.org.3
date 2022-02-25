Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F04C4C46FA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiBYN4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiBYN4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:56:11 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DC21DD0F1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:55:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p9so11029730ejd.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxV847UKd4z4uHGqCV9gC0E1Cm2nifxyT2XLGSYQIfU=;
        b=r+f4rKoewdTP176j9475FzczVoD5Zo9Kw8BxYFMrKqXmXAhEgRCjRdqV4QFGO0whUr
         o3Gxucfdt4pXoSfCG3QpruKcLRkb6qKW8X+2JslukI5PqKXYSFZkcccIydniTkCggn/H
         68MIspMtNq0s+S21x410BYmcu6ZeQeBOHR9d2ugxfNJXX5sl0reUzGvr8mcqptDlbOqS
         44ZuH6bESMN1TMfDM6XtQUyKn9g94HyLnHwELZu60YSTtIeLUBmTlhxQsJf8KIaYU2Nm
         ZMvyq1zKFc6XhOn9eS0VJMwVg4yx1FipwYjJa3iGvBKKLAR7mskvet913Jotn1/GVvXD
         iFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=YxV847UKd4z4uHGqCV9gC0E1Cm2nifxyT2XLGSYQIfU=;
        b=DQfyYUADveiBJpA/MgSd5mb2Mp4Pb6C4bXMtP9wiCLPaaEj25i2Mvryb38sCpnDRtS
         901kyfTzTB/uZbYIleuzr847nb2fPLMytft2DIEeEmJ9TWCkthH3vFhnToVwlFVds/NO
         H1QUa/v7kzKYUyMtYFoNay71/eTv2SAQa7liT5KdM3KE5G4PmSfthnrsAa+QgxYcIZ+E
         H/SAtNOZ0tNZJwlZvjuxJePqihbXHflU9axfmdsVhxeoXkhsX3CX/vU0dVTjxZTzA9yc
         mFDuIs181/yU9tnKM5HH4IzfYJUOu1hIMFQ5saaHwxVbqsF468i8gp/O/AMK9GwCBQ8E
         yfaQ==
X-Gm-Message-State: AOAM533JubnkOdJ1PN7HdAQ39cFMhSRlkiRXtgJMboqmd744LPfyAcE0
        Vb0xs4rA9xe806YVuXM6QxeROb3N3GkJbw==
X-Google-Smtp-Source: ABdhPJxw0jtu9+QgRx4Url3CcT88JGAbMTbJe9JciyVFJ3lLGqK3xKUaEFxH/YDhYk7cZSCLhDZ/Gg==
X-Received: by 2002:a17:906:1188:b0:6ce:f315:21df with SMTP id n8-20020a170906118800b006cef31521dfmr6312023eja.591.1645797337586;
        Fri, 25 Feb 2022 05:55:37 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id f3-20020a1709067f8300b006ce051bf215sm1023090ejr.192.2022.02.25.05.55.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Feb 2022 05:55:37 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Mahesh Bodapati <mbodapat@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 0/3] microblaze: Fix issues with freestanding
Date:   Fri, 25 Feb 2022 14:55:33 +0100
Message-Id: <cover.1645797329.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with GCC 10 there is issue with simple memset implementation which is
called recursively. There are couple of discussions about it and the first
two patches are trying to workaround this.
The third patch only removes simple implementations from arch code and use
generic one which is the same.

Thanks,
Michal

I sent only 1 patch in v1 that's why sending v2 with all 3.


Changes in v2:
- missing patch in v1
- missing patch in v1

Michal Simek (3):
  microblaze: Use simple memset implementation from lib/string.c
  microblaze: Do loop unrolling for optimized memset implementation
  microblaze: Use simple memmove/memcpy implementation from lib/string.c

 arch/microblaze/include/asm/string.h |  2 ++
 arch/microblaze/lib/memcpy.c         | 18 ++-------------
 arch/microblaze/lib/memmove.c        | 29 ++----------------------
 arch/microblaze/lib/memset.c         | 33 ++++++++++++----------------
 4 files changed, 20 insertions(+), 62 deletions(-)

-- 
2.35.1

