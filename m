Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3861F576DC2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 14:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiGPMQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 08:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGPMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 08:16:47 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BD31F2FB
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 05:16:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q16so3539821pgq.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=K1y/UJPxPUwfW6UWjIkb1qyn/R/LCx7VwgOQ6WaAtz8=;
        b=SsowFVwyjPiyY8IH8cHbEZBRAdu8lw6QXB246nYL8DDsaXNd5/olyU7Ju+XjgX5Sfj
         oAG2ILt//jwOlWKbOwCy2RIvH+GZtSZ4+v1vjkv5lpaAFU2yZd6aSASFOYlOEOckjaZy
         m3WcbGffJ8cQVqi6Uav1BHdm+zfeeioPdaG1u01uYYDAAc1KgutZU0fR1nB5d2/S9jOv
         4M8ns3bOroOZNamFYVIyC1Uqw3Q+/06vM1ZuSvhk5I00OPNvZmpNkvw+egaTfB5A5L5w
         re5Def65PcY/x3BGHQmLfg8pI2HWA92h4wChd0dpp3R0v95IM9Lg00oFLvSXD7rE4kfa
         /9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=K1y/UJPxPUwfW6UWjIkb1qyn/R/LCx7VwgOQ6WaAtz8=;
        b=mZBz91j+IaNUPp+rwW9XLvX8cWBNHXbzzDThJFzGFqtpLVBIOhl6GpCm08dn3Bb6b8
         kqHTBBfaQbYSAHPT1Ga7iDlgum3snltO/5pW2bbn1ocT0Ze4o5x5mTr/B/FvaB7qxxZO
         k+n+GPXxtPm+AfFNwvwpNuoGWjWKjLLss9R9efw91jKsL1JlHtxRUiaAhqSrffg4s/fT
         idiBjiggC0t0z7dxrvIqQMiSaYifg9ZrvPOqySBGOFdS6LIFxVps+wN27UtGLjvupXUT
         Bg8c8X6S2JZZGvhPwu/HUwI4mp8FovIIth/2C4Kpu1Qe+cjIAEiCA5vlE32dAXIBpLtd
         YxUg==
X-Gm-Message-State: AJIora/KffZwMDxuWraplikTa5AuahRpCoAU9+TE+E0OkoppcZtOL5Hq
        9kpe911qEmAoi0a8owZnS14kZ5gwjIcu8Isu7g==
X-Google-Smtp-Source: AGRyM1trfsrkcG8fM6vlzvMUEWURpvlRXlh3f+awZEa2FQhtn2DlxrU8N4iO7v/i4lg2szwlWAUmcBlOLB8qEj/mCco=
X-Received: by 2002:a05:6a02:113:b0:412:a7c0:da8e with SMTP id
 bg19-20020a056a02011300b00412a7c0da8emr17005590pgb.113.1657973806781; Sat, 16
 Jul 2022 05:16:46 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sat, 16 Jul 2022 20:16:35 +0800
Message-ID: <CAMhUBjmX0BDh-35GQxf3-fXFa8_EKfh2fwYKZDgH4NzGGQHiSg@mail.gmail.com>
Subject: [BUG] staging: rtl8192u: Found a bug when removing the module
To:     Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tong Zhang <ztong0001@gmail.com>
Cc:     linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a bug in the rtl8192u module.

When removing the module, I got the following warning:

[   20.407360] remove_proc_entry: removing non-empty directory
'net/rtl819xU', leaking at least 'wlan0'
[   20.408609] WARNING: CPU: 4 PID: 451 at fs/proc/generic.c:718
remove_proc_entry+0x2e1/0x3e0
[   20.412316] RIP: 0010:remove_proc_entry+0x2e1/0x3e0
[   20.420050] Call Trace:
[   20.421178]  rtl8192_usb_module_exit+0x4a/0x63 [r8192u_usb]

I think the problem is the misuse of the proc entry, but I'm not
familiar with the driver, so I'm reporting the bug to you.

regards,

Zheyu Ma
