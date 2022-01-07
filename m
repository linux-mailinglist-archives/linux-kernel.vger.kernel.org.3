Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A890487634
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346997AbiAGLHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:07:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237725AbiAGLHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641553654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+kcDM4DA7iF+2H6LBkZldn3r6QWbKOMJ1NrH2QklOIQ=;
        b=Mx4FXWdPZ4TiluYsosNBJOJLLQ4rwf2cYYAcc1CDWvqBFdOPDNf8SEqTHnaHI4GJdZzv/c
        sfKjCgXNW1zhiqUQd+NwCh9dQqvRAQyKd9XoLGpMd60JqphmLfJpFJKtbqDJgT/E0VSyn4
        idjop+OcctuK3JsymcAurqIH3nDyNwY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-1vkUShSeNeu6MRwkHKN98g-1; Fri, 07 Jan 2022 06:07:33 -0500
X-MC-Unique: 1vkUShSeNeu6MRwkHKN98g-1
Received: by mail-wr1-f70.google.com with SMTP id i23-20020adfaad7000000b001a6320b66b9so266155wrc.15
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 03:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+kcDM4DA7iF+2H6LBkZldn3r6QWbKOMJ1NrH2QklOIQ=;
        b=FiNiK8WTKXuNEysYhaSfkoDrpQBvhIKrgxHKankdHhKk2uKKEpmqSGvgB/lhP/dKdV
         6R3mF+1TVNK2T+T/MnnmIP7gfcaW3OUP6UJqJRKHoLKkMag/SIIA+uEgoHJSwDbEtMhX
         NF/pMCj3J2LiE6NgxMHAheTJXi1XzlvJ8esqprnESvvnC2nxy+cl82/rXZDb/UGJTEiw
         js8ZbCPqtKyq/C1A8iN0+DRzdSJG453SIYINfzbSJHSUz0CibOPltehBRf5R27OfN/Gf
         xVwkKCD9UNJhwX+ytR1+3fDIOtJk/vFquyrMU8Qh4OCbMLuCAFWnGVnA5r1n33SBXunF
         TTbA==
X-Gm-Message-State: AOAM531+w95u9VKtRM1H21J8qcIt/yDDf2UbO+Muqn9oUJtxbZT1ypRt
        +wQKs0J8+zKT+yznt0vYbUlXIu9SZYYahbYb0aKR6VAwgRWob4Ove0NV9DRHMEApGcE0pdRy1s1
        tbHc33MkRMSOj0rTvdY3x05Ws4B3thQ4BImGBP1eJ6wl+fEjTruVpVdINnghb29jnjGN7BS+sCe
        c=
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr54376485wrx.49.1641553652119;
        Fri, 07 Jan 2022 03:07:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtOPD/6pEBen2ILWzQHaAQuxOtuwbQ3rz4DnLfmgOAOVsFRE5K9lxV3eeCKmjU9fywMsfmMw==
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr54376465wrx.49.1641553651914;
        Fri, 07 Jan 2022 03:07:31 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r9sm9337273wmq.18.2022.01.07.03.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 03:07:31 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kris Karas <bugs-a21@moonlit-rail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 0/2] video: A couple of fixes for the vga16fb driver
Date:   Fri,  7 Jan 2022 12:07:21 +0100
Message-Id: <20220107110723.323276-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains two fixes for the vga16fb driver. I looked at
the driver due a regression reported [0], caused by commit d391c5827107
("drivers/firmware: move x86 Generic System Framebuffers support").

The mentioned commit didn't change any logic but just moved the platform
device registration that matches the vesafb and efifb drivers to happen
later. And this caused the vga16fb driver to be probed even in machines
that don't have an EGA or VGA video adapter.

Patch #1 is fixing the wrong check to determine if either EGA or VGA is
used and patch #2 adds a check to the driver to only be loaded for EGA
and VGA 16 color graphic cards.

[0]: https://bugzilla.kernel.org/show_bug.cgi?id=215001

Best regards,
Javier


Javier Martinez Canillas (2):
  video: vga16fb: Fix logic that checks for the display standard
  video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

 drivers/video/fbdev/vga16fb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.33.1

