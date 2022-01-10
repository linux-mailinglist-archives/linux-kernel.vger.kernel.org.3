Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED1C4895D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbiAJJ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:57:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243550AbiAJJ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641808621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ObCOlx7qc1MuxpL5+ry8PrWxS3J2SNPySVs4WNajgno=;
        b=dnDqfT43vBy5Oag+yt7G7Cd+i58FSbMYt5ZmcFbyuQSW/AI1gWhbqatSXGvzjvP7QwLyMb
        r+vhXCDJwQpX/nVemZwUw8yJBJm6en0M3peWVNtbmwcfKC69GAZvCnZH3OBM8q/FS1eiKd
        J5G/44x43lbHeCwjXiBkVDARm8glfKM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-znAgNhngNg-if-ghr2QDFQ-1; Mon, 10 Jan 2022 04:56:30 -0500
X-MC-Unique: znAgNhngNg-if-ghr2QDFQ-1
Received: by mail-wm1-f69.google.com with SMTP id a68-20020a1c9847000000b00346939a2d7cso1840163wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ObCOlx7qc1MuxpL5+ry8PrWxS3J2SNPySVs4WNajgno=;
        b=p4B6fjj+ktr6JWShICV31LrkHYEgtX9AASmusNj3EUcStFuDetp1jwCJycCS2wTo5O
         pT7DRyj9jco1plugiwB/sI77H5VbU43oJVVk60Vg73cjg1B8ltp5cvSswcsE9sxWjdRU
         A28WBOruYNRG3NwTea2buNW0XSgvbgnMEK17g2/qFFW8w6YClERDnmySzoLrkjFQ4FKb
         wBQRlkEN1j/GOYclTCf9Sx6paMp9gw3TOxAVQx3VZ6h1c1Qq6iYD/owsFqevyca6tAXj
         alhRTtZNixe8DMliO/8OyfixmmjlTbaaJ/OIjT+maOSDP2984JbDvA1GrtSqwo1+D4EC
         4oJQ==
X-Gm-Message-State: AOAM533PPA/qbx0BOTeGZhfV0TcCqkFvC0m6cVVYLCtfme94GBqV1mm1
        PQvkN1qGNw1s6OZRAGmXQbjqqIt3QbWmnn59IlnlDBX2HbJi0nnbfZDZRBzdqqfsh9+bRGpMGM0
        GM1a1/anxfW4qdQvAG3Sz7vrMudTv+P13l3BCn//obU75DfSzVyGT13QHXeY1HslD/JsraPMkS+
        M=
X-Received: by 2002:a05:6000:1687:: with SMTP id y7mr62811742wrd.636.1641808588460;
        Mon, 10 Jan 2022 01:56:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGrDXSR/pexIPk1NzHcVn2qTkgOkF6tU7OxEDfgPSVggBPqdm80ZGadCbvMnDG9B5WHjpKYA==
X-Received: by 2002:a05:6000:1687:: with SMTP id y7mr62811720wrd.636.1641808588144;
        Mon, 10 Jan 2022 01:56:28 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b13sm6315167wrf.64.2022.01.10.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:56:27 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kris Karas <bugs-a21@moonlit-rail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 0/2] video: A couple of fixes for the vga16fb driver
Date:   Mon, 10 Jan 2022 10:56:23 +0100
Message-Id: <20220110095625.278836-1-javierm@redhat.com>
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

This is a v2 of the patch series that addresses issues pointed out by
Geert Uytterhoeven.

Patch #1 is fixing the wrong check to determine if either EGA or VGA is
used and patch #2 adds a check to the driver to only be loaded for EGA
and VGA 16 color graphic cards.

[0]: https://bugzilla.kernel.org/show_bug.cgi?id=215001

Best regards,
Javier

Changes in v2:
- Make the change only for x86 (Geert Uytterhoeven)
- Only check the suppported video mode for x86 (Geert Uytterhoeven).

Javier Martinez Canillas (2):
  video: vga16fb: Fix logic that checks for the display standard
  video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

 drivers/video/fbdev/vga16fb.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
2.33.1

