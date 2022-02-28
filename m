Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870A04C6347
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiB1GmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiB1GmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:42:23 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E5366FB5;
        Sun, 27 Feb 2022 22:41:45 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z2so9866090plg.8;
        Sun, 27 Feb 2022 22:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9QiizqeRQgoEQFziW+33bQt2mpBCC2WwkxDOsJ17xwA=;
        b=iOKZZLEoKQSLsmBcaiDnn5yeHIk5oYrL5RzaV+Nv1WyQTJ7kifZQ9YjYsVJb6Q6y9O
         B9Moi3Y/+wi9m3TYS8/n5XmqVQB4RwgvuQPlh6Jjqob72KQuQmmd/rwNSATDAKouyT87
         5aFF65bvw4DyI33gmFJLSe6MSt5IvQzaCHDbUoEvqHzqj6AYkCfz6N0pCQMYPA/U5kr6
         fA5rkzzwL0iw0rObxb18ro1ac8PQzxFdNepCKNroQ1tut7YmiqT7rxGIxwUJVX5bmj0Y
         vQ6dK9gXlfL/6pY+NqkX3VaLfoEzOF44FAo8Vg3VWVCvhsa5YUNaeb8Y/x93PyMnDwme
         3NPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9QiizqeRQgoEQFziW+33bQt2mpBCC2WwkxDOsJ17xwA=;
        b=Uqcq82F0De8rjlFHFVIAu+bfrvclIM++C+mBOjACXOyw/JbzE/DOPHohFcOcO16/m/
         xRhvFlPKe60+/fhldbkMVu271CXNYBs7gfp6Lqc3YWQIjLPGrLUQ6RM4V52f0RtG6K0w
         2rgid+zuzfdYqMWXxGdbowLUz+PQrSRsHQakInNFCM9rUFYMfApdSQCgDY7im1RBzeJA
         w1Fuq71Qvs+IwmG0TGAJ7wBpfQxNMtxaLJ0uBg7LLmj8sekOYpJzmjQbBP57OCj5x5bT
         Zfd67ulVEHuZh61ri6uzcT7p+rJd0HFl3g9+Sqy8pFVpi98HsmcVepNkhWcknfbooydD
         M+Bg==
X-Gm-Message-State: AOAM533gJkdqwW7PLeUcXgT3nS1CZExQPF6YlFU1rLqASSJ+xSHywGiV
        UzYfn32tG3tfe2Wl3EIdCVMsDuLziT7m7uDaWA==
X-Google-Smtp-Source: ABdhPJx+VKi9/xxRILycRigeXUIPDXAK5Du653/QDz/ik7X2QnfLN07fqxVyfcyKpwZDmR4PdWESB+M5hXdKqPLk6q0=
X-Received: by 2002:a17:90a:a502:b0:1bc:8dd6:a859 with SMTP id
 a2-20020a17090aa50200b001bc8dd6a859mr15190418pjq.46.1646030504804; Sun, 27
 Feb 2022 22:41:44 -0800 (PST)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Mon, 28 Feb 2022 14:41:33 +0800
Message-ID: <CAMhUBjmVD63g7zx1UTqomKAw7S6BMiyG1DVkHkWrNN08mYkLgw@mail.gmail.com>
Subject: [BUG] media: solo6x10: Disabling already-disabled device in free_solo_dev
To:     maintainers@bluecherrydvr.com, anton@corp.bluecherry.net,
        andrey_utkin@fastmail.com, ismael@iodev.co.uk, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a bug during the process of probing.

The function call of v4l2_device_register() maybe failed, and then the
driver will call free_sole_dev(). In this function, the driver will do
some cleanup work such as pci_disable_device(), but now the PCI device
is not enabled ever, which can cause a warning of the kernel.

The root cause of this bug is that the driver does not handle the
failures properly, the driver should split the error handling and
handle it differently depending on the error.

The following log can reveal the bug:
[  115.920219] solo6x10 0000:00:04.0: disabling already-disabled device
[  115.920255] WARNING: CPU: 5 PID: 489 at drivers/pci/pci.c:2202
pci_disable_device+0x27a/0x380
[  115.923962] RIP: 0010:pci_disable_device+0x27a/0x380
[  115.932590] Call Trace:
[  115.932806]  <TASK>
[  115.932990]  free_solo_dev+0x1d4/0x270 [solo6x10]
[  115.933413]  ? solo_pci_probe+0x165/0xb70 [solo6x10]
[  115.933865]  solo_pci_probe+0x21b/0xb70 [solo6x10]
[  115.934954]  local_pci_probe+0x13f/0x210
[  115.935288]  pci_device_probe+0x34c/0x6d0

Regards,
Zheyu Ma
