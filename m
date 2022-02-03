Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9D4A7F30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 06:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbiBCFyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 00:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiBCFys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 00:54:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A10FC061714;
        Wed,  2 Feb 2022 21:54:48 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so1884608pjb.1;
        Wed, 02 Feb 2022 21:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWVpefFKL0PIV/uUOyn0pPa+4jE5LjZtlNg3t7Gg5XE=;
        b=SHs/QpUZGOZOLclol1bemwO7a+CWpDslvF98/XmlWVsU3ypx6ZR0tX4/RRW2xODhkw
         OdxZ0rGgo0YfcKILf7XF+jW5UVaM+e21G732gCCK8ad/5ehAqQKK8ckg4xkujjFw7mrn
         BY2ttnA3me91+3WpgSvkTcfgW2zD6bsznS5HjlOjaI6W8JNcqKVpjk56kfHihVyG5480
         ox1jrOlTKTaI5GfjkYzTNndZGqBxTnCtYs9/GGHC4UHkGrKYct5jEdazNSRV+EEdMi5o
         kAViKnUw5+PpcJFLWUKUjCNNToNTzXInwfRJY6g9dm8CS8aAbgZwi0Ixv+n3E5HdKj56
         UN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWVpefFKL0PIV/uUOyn0pPa+4jE5LjZtlNg3t7Gg5XE=;
        b=tv47GYx7xjQp51ky5MKpMI3ZSnpii9zYcFL6ZVbneVoS+xEUzTigCdBoka2qODPAld
         wADCblpiyaQAMMvRygSEn11G21uhLKtuytRqetEuNC1WJd7EwB/7jeYYIkhycPesJXgf
         PbAbdMU12OdrY9xD5eVVYjsh4firjS2zSEbdx4bhc7GHjJPxTQlV8qbvTzGRHYe1eq5s
         Bq8Um4cgT1DcRB8qacDI2uzKL+SwmJ8oYkeXWpaErn6C0FLjZDAcerhweFswZzs6IlJS
         7uUG4zcSHc0xLwkR/ai4Ne1BPeBJNn5qY6585tPsA1Sj4HYtxEXy8umDou/W1NQk0aEA
         43TQ==
X-Gm-Message-State: AOAM532V4dtfkEc8xiqMc4tuxjVC+IUsGA0xn/NxueXOgH3O6cEoQJY1
        PkaKmsUwTQiAEGFE5saNQAHQPmgV9gIfn1EbD4k=
X-Google-Smtp-Source: ABdhPJwEdKnUI2k3rZuN7nFyqG2IDxNgM2QKJpelrBwdfzGWY+Z3H8ZxovgpBNVl87sG7bpz+B4kh4CliiJrrSE51r0=
X-Received: by 2002:a17:902:8490:: with SMTP id c16mr33766136plo.129.1643867687641;
 Wed, 02 Feb 2022 21:54:47 -0800 (PST)
MIME-Version: 1.0
References: <YeBEAavbBh/MnbEF@bombadil.infradead.org> <20220117065452.83894-1-vimal.agrawal@sophos.com>
 <Yfrncd3voPOB7PdB@bombadil.infradead.org>
In-Reply-To: <Yfrncd3voPOB7PdB@bombadil.infradead.org>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Thu, 3 Feb 2022 11:24:36 +0530
Message-ID: <CALkUMdTeyfv7aPeQZMXjNK67Buuw6uiVWU0iMQajuGU9TSKm+Q@mail.gmail.com>
Subject: Re: [PATCH v3] kernel/module.c: heuristic enhancement in case symbols
 are missing e.g. when INSTALL_MOD_STRIP= "--strip-unneeded" is used
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Vimal Agrawal <vimal.Agrawal@sophos.com>,
        Christoph Hellwig <hch@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

> Try:
>
> modules: add heuristic when stripping unneeded symbols
>
> Then please describe in your commit log that on OpenWrt the
> INSTALL_MOD_STRIP="--strip-unneeded" at kernel/module install
> time, and so modules are stripped of unneeded symbols.
Yes, Thanks, I will send the updated patch shortly.

> Sorry but for some reason this is not working on my end, but then
> again I'm not able to get the stripped out results you see either.
> So it could be I just have too many debugging options enabled
> that makes INSTALL_MOD_STRIP="--strip-unneeded" not really do
> much. I don't know if that is possible but I will have to try
> to reduce my build options to test.

Yes, there could be some dependencies due to other debug options and
it may not be able to strip it to a good extent.

Are you trying with changes in test_module.c?
I was able to reproduce it easily on ubuntu 21.10 with following patch:

diff --git a/lib/test_module.c b/lib/test_module.c
index debd19e35198..53578e7a34d7 100644
--- a/lib/test_module.c
+++ b/lib/test_module.c
@@ -14,10 +14,25 @@
 #include <linux/module.h>
 #include <linux/printk.h>

+static void test_module_warn_start(int x)
+{
+        if (x) WARN_ON_ONCE(1);
+}
+
+static void __init test_module_warn_init(int x)
+{
+        if (x) WARN_ON_ONCE(1);
+}
+
+
 static int __init test_module_init(void)
 {
  pr_warn("Hello, world\n");
+        printk("address of test_module_warn_int is %px\n",
test_module_warn_init);
+        printk("address of test_module_warn_start is %px\n",
test_module_warn_start);

+ test_module_warn_init(1);
+ test_module_warn_start(1);
  return 0;
 }

After building this module, I used the following command to strip it:
> strip --strip-unneeded test_module.ko
and then loaded the stripped .ko using insmod.

Vimal
