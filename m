Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE8157BD28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiGTRsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGTRsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:48:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2754AD57
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:48:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m8so11278363edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GR9U47/8mfP/ckxqrtY0VCAof5NC+fF9d0u+ZbiOF8Q=;
        b=gN3IKSDZWj8csjNsRFaVOS39Wkf1tNxCdYuiTsFSzqXbBQrsGoDDLtz6wzv8m2sVsc
         ijezp77Qf8MLVi6cRoh5OaNnRIw2DUC4oNyrH96bKSnqJQJ8p36CRpmrOFrcbu/lb4/s
         ZDeaYYWMof4PEHHw5vqxq+mkoNpFRdoXoTczA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GR9U47/8mfP/ckxqrtY0VCAof5NC+fF9d0u+ZbiOF8Q=;
        b=U3zMqQsfD8OHUZIenThPgeWYdYFUy1GeirXVX6zGSJ3m20jHZTA41JR7dfIsXv4XZt
         RUiIlANfupknUeOk94O53DyqfVlGfprVJGMTLexo5SEoxPij/NxPKF++iVjM2fBiYJF9
         8Db8E4Ww81Ti+752ikJL6rHm3cY+Vp0QbX6f/aRHFhMLT0oc1dlavzorbAAbplSY5Z2Q
         2u7vmsJAZujrPkO2dr76J8oFoeCcPCvyPQMcLP2CaZRZpW+6eSl9rBJQj/un5N320K5b
         ULaiHfDNWcJsgYjhJos9+RC/opn7cGAwqO/kKnt0vJLQsQL87xV4JDyo+rgRNxqyC2pk
         LdEQ==
X-Gm-Message-State: AJIora/YtOqBmObNFB0xkst5cNhF8pGGd5VUFB5BYzxJi8SMVjKT73ok
        xnAMO65epPHMT152pysciQFJpke0b5zirA==
X-Google-Smtp-Source: AGRyM1uyHqHwhrqV+AoRFj4lUURcAahO7Om26arm2nRYJ8z6zCl8BC7AT0zYgAxBL4FjllrwaNSaZQ==
X-Received: by 2002:a05:6402:e96:b0:43a:f21f:42a0 with SMTP id h22-20020a0564020e9600b0043af21f42a0mr53101566eda.382.1658339287219;
        Wed, 20 Jul 2022 10:48:07 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:d58e])
        by smtp.gmail.com with ESMTPSA id b16-20020a1709062b5000b00722e57fa051sm8122351ejg.90.2022.07.20.10.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 10:48:06 -0700 (PDT)
Date:   Wed, 20 Jul 2022 18:48:06 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: [PATCH v3 0/2] printk: console: Per-console loglevels
Message-ID: <cover.1658339046.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:

- Update to work with John's kthread patches
- Remove force_console_loglevel, now we only have global and local levels
- Remove minimum_console_loglevel control and document how to change it
- The minimum loglevel is now only honoured on setting global/local level
- Add ignore_per_console_loglevel
- Return -EINVAL if trying to set below minimum console level
- Add parser for named console= options
- Fix docs around ignore_loglevel: it can be changed at runtime
- Fix ordering in "in order of authority" docs
- Remove duplicated default_console_loglevel doc
- Only warn once on syslog() use

v2:

- Dynamically allocate struct device*
- Document sysfs attributes in Documentation/ABI/
- Use sysfs_emit() instead of sprintf() in dev sysfs files
- Remove WARN_ON() for device_add/IS_ERR(console_class)
- Remove "soon" comment for kernel.printk
- Fix !CONFIG_PRINTK build
- Fix device_unregister() NULL dereference if called before class setup
- Add new documentation to MAINTAINERS

Chris Down (2):
  printk: console: Create console= parser that supports named options
  printk: console: Support console-specific loglevels

 Documentation/ABI/testing/sysfs-class-console |  43 +++
 .../admin-guide/kernel-parameters.txt         |  28 +-
 .../admin-guide/per-console-loglevel.rst      |  92 ++++++
 Documentation/admin-guide/serial-console.rst  |  17 +-
 Documentation/core-api/printk-basics.rst      |  35 +-
 Documentation/networking/netconsole.rst       |  17 +
 MAINTAINERS                                   |   3 +
 include/linux/console.h                       |  24 ++
 kernel/printk/console_cmdline.h               |   2 +
 kernel/printk/printk.c                        | 311 +++++++++++++++++-
 kernel/printk/sysctl.c                        |  64 +++-
 11 files changed, 599 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-console
 create mode 100644 Documentation/admin-guide/per-console-loglevel.rst


base-commit: 9d882352bac8f2ff3753d691e2dc65fcaf738729
-- 
2.37.1

