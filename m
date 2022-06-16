Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15B054D8E2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiFPDZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358349AbiFPDZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:25:20 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C425131F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:25:19 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-30fdbe7467cso2044787b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sfFwkASSxn3l6CWedIX7pCCt8q5DU/J1WP/2EbjK124=;
        b=qBHLivSWOpwtzBzhkFjj1AAqWgvnR7ZRto9dxdgq6LbvvUglWolPBBzG6an8cCN0ek
         loShWGn7XFWj/G48hTyZRNfGXrrnKhSQi2TAaWnRVCXQu2VR6NmT7cup9s6IxENopZ6X
         Q5KeNRzAYMbcqo8NulvclWXaECB0Io9uGfa1RkmosUHJuKmUGApK9SUGjSgiP+Ei6yXI
         KYaO60CrZLjSaEF00Lp84wtl3RBS0UpXoLeqzfKUZbDzvT/U+d2FzFI4TmC7qj95ALdP
         +h+uxqhZHP956PQnMpm94olrzkF33KK8mCUqhjZ/zSTNJn/Qbb7Jz0IUkDBmK08XqwXu
         pYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sfFwkASSxn3l6CWedIX7pCCt8q5DU/J1WP/2EbjK124=;
        b=bLQcLT0jsj8kcSXu5+OeP877FatcV/n0D4LYnZmjBFGjdAHjOB1Nzf0kaHBB2DNlrc
         AYxPNsHtyOyqGg0t/xZ44D+Pz1LMZCWp8YXd4akI7kAeIjCaYJg48ZCHXtcetT+DtqQY
         ctpA7p0Mut+P5yB7jKsPCy+yNplgRRQqhpdN9bqoAgHkJsXlLq5OkO9xBy8nc/UQnArC
         zXH2agqxdBzFJH9pI4dth7OsL6K/J4lPousMKVfYzBb4FbqFAYc1YVKVQmvcLe1F9aAT
         tuyzgtOAMQytidh2z/Ft3wM6TsPcS/AMgrwkNkwrk0bjoohJTkphTvVNLqshHWNsauuq
         LzAA==
X-Gm-Message-State: AJIora9nfOcl8EMFfgd2i+SQkejL3YoaX614E6Wnq5TUGIr3QUi0p0jh
        2k8sj0w1gW56RnYrBqLKy6JKP9SQ0dVSL8npybeqz7tq08aCTw==
X-Google-Smtp-Source: AGRyM1tkmlCCYx3ne7qNrM2SsKb5JS+l/a+KZwu7nwpjE8KX+lPeU2pj4b5A6emqwDz9IBbYn4p/A2aQ7K0cpB79WAc=
X-Received: by 2002:a0d:c984:0:b0:30c:c95c:21d0 with SMTP id
 l126-20020a0dc984000000b0030cc95c21d0mr3559521ywd.218.1655349918015; Wed, 15
 Jun 2022 20:25:18 -0700 (PDT)
MIME-Version: 1.0
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 15 Jun 2022 20:24:42 -0700
Message-ID: <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com>
Subject: Default async probing for DT based systems
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

TL;DR: I want to improve boot times by enabling async probing by
default for DT based systems. Can you give it a shot please?

Why do you think it might work when async probing has been a pain before?
==========================================================
Since fw_devlink=on is the default behavior and fw_devlink understands
approximately 24 DT bindings, it should capture most of the device
dependencies and ensure proper probe ordering. For example, on a Pixel
6, fw_devlink figures out 325 dependencies that it uses to enforce
probe ordering.

You can find all the dependencies under /sys/class/devlink.

Fine! What do you want me to try?
==========================
With the patches that have landed in 5.19-rc1, we can now enable
default async probing for all built-in drivers by adding the following
to the kernel command line:

driver_async_probe=*

I'd really appreciate it if folks can try adding driver_async_probe=*
to their kernel command line and report any boot time
improvements/regression or boot/probe failures it causes.

(* insert cat begging pic *)
Can I haz some reports pleez?!

Tips:
====
One easy way to check for devices probe failures is to compare the
output of this command with/without the commandline changes:

# find /sys/devices -name driver

Btw, if you need to force sync probing for a few drivers so that your
rootfs mounts properly, you can set the flag in the driver, or you can
list them as exceptions following the * in the command line option.
For example:
driver_async_probe=*,my_flash_driver,my_sdio_driver

Report these too.

Known issues:
===========
fw_devlink doesn't yet support phy-handle and mdio-parent DT bindings.
They have some tricky issues I need to resolve first and I need to add
both of them together -- I'm working on it. If there are other DT
bindings that are missing support, do let me know. Most of them are
easy to add.

The driver_async_probe=* won't have any useful impact for modules
without adding <module_name>.async_probe to the commandline or
async_probe as a module option when loading it. This is because
modules intentionally force sync before they exit. There's a patch for
a global flag for modules too [1], but it can never be set by default
for userspace reasons[2].

[1] - https://lore.kernel.org/lkml/20220604010101.719508-1-saravanak@google.com/
[2] - https://lore.kernel.org/lkml/CA+55aFxV40V2WvNtJY3EC0F-B9wPk8CV2o1TTTyoF4CoWH7rhQ@mail.gmail.com/

Thanks,
Saravana
