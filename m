Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04CE4AB2DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 01:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbiBGACZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 19:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiBGACW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 19:02:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD6C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 16:02:21 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so2690539wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 16:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6y8D3kpo4uKuVZoaqtD5J5vageNIGOTp/wVMHU+XYk=;
        b=gElwdwxlVHLX8tMzCIjES1hP49FBEizTKUY6xDy+76oDB8AT9SPVXAsMxkGs6B7ABd
         DF8n/7RHE12GUwBzB0Ev18YzRn+3lgOUfMHcD5Vp2tuxuhv9byBCMguuSD1vjWlui5xH
         MT355TRhzTbR6aApCyTzHajT8LQPYrWQBvreuk5syqdG8rPZuxfsFF7bAlvhgI5i3lqm
         bFYxKYL9XJVNyZZEnlgTJidwTbsrfcxDdKXpFEhFN4u6YkcFMRBepGIBGRNlY644/S+U
         /QlyAEhXoSUzHeTG6wS/TVfZ+I9ZAPH0xUS9a2WtQIjU4i6T1K/NqtDN1GeMf4hwDzas
         VYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6y8D3kpo4uKuVZoaqtD5J5vageNIGOTp/wVMHU+XYk=;
        b=tqyQHLQEss/JPVz0fqAH5D3ZVLh+NEwuhcbjwIo6BLWIkW+Epg7lSBrqKopvfy9+qM
         3pzkDCMfsRM/b+tCPzG3EZS9Eij587Ay3WkSaMS4v1+JqNQeCtLRyKmRh3Ja18ndVQxv
         RGB4cbjTfoobLeVlwpRPIjxhCyW8AFgAQdUOWOCJ8FsN/zvD9NG0QRpuazbG3JnzWQUT
         V6kRqLY3ksROIPxS7ewTmPQSZ8HEMdsUvwyOvlJhXK5QXwwTPqXhEX9+BHt3Yw72wx3s
         yWFEXOYNNqZN0McQmTkCd0VqIdNIlJOHZQc9ePveiWzKCZm7rU7NjWEWNeEmgH4suBv1
         YPCg==
X-Gm-Message-State: AOAM5302L477UulpYhCV6rLfwnJIkRG+PKdrlV50I1ho7pxGfFIn4gvz
        UFrocfSiW/VymejbZ/VPmKw=
X-Google-Smtp-Source: ABdhPJzttKD35oquTDKy+pzbXdCkOtSBB8h8Sdt62xvWcG4vlV66CWY4GuL+PkwLAKBi7rmaxGnD0w==
X-Received: by 2002:a05:600c:1da5:: with SMTP id p37mr8672026wms.93.1644192140127;
        Sun, 06 Feb 2022 16:02:20 -0800 (PST)
Received: from leap.localnet (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id b16sm2780974wmj.32.2022.02.06.16.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 16:02:19 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        phil@philpotter.co.uk, larry.finger@lwfinger.net
Cc:     julia.lawall@inria.fr, linux-kernel@vger.kernel.org,
        Michael Straube <michael.straube@stud.uni-goettingen.de>,
        martin@kaiser.cx
Subject: [RFC] staging: r8188eu: Sleeping in atomic context (SAC) bugs
Date:   Mon, 07 Feb 2022 01:02:17 +0100
Message-ID: <2111927.Icojqenx9y@leap>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I've noticed a couple of SAC bugs in r8188eu. Recently two of them have been 
addressed by me and one by Michael Straube (sorry if I recall it wrongly).

Prof. Julia Lawall wrote with Others in a paper that "[] Code executing in 
atomic context monopolizes a CPU core, and the progress of other threads that 
need to concurrently access the same resources is delayed. Thus the code 
execution in atomic context should complete as quickly as possible. Sleeping 
in atomic context is forbidden, as it can block a CPU core for a long period 
and may lead to a system hang. [] SAC bugs do not always cause problems in real 
execution, and they are often hard to reproduce at runtime. Recent studies [] 
have shown that SAC bugs have caused serious system hangs at runtime. Thus, 
it is necessary to detect and fix SAC bugs in kernel modules.".

Probably the phrase "SAC bugs do not always cause problems in real execution" 
is the key to understand why very few people seems to care and fix them.

While working on my last patch for this driver, I noticed that a Mutex is 
acquired while holding a Spinlock and while bottom halves are disabled.

In staging/r8188eu/core/rtw_ioctl_set.c, the function rtw_set_802_11_disassociate()
calls spin_lock_bh(). While holding that Spinlock, it calls _rtw_pwr_wakeup()
that, in turn, does a call to msleep().

My first question is whether or not msleep() can be called in atomic context. If
I understand its semantics and implementation it seems that it should be forbidden.
What about changing it to mdelay()? Again, it seems that mdelay() spins without 
sleeping so it should be safe. Isn't it?

Furthermore, I noticed that _rtw_pwr_wakeup() calls ips_leave(). The latter 
acquires the "pwrpriv->lock" Mutex. Aren't we forbidden to call Mutexes while 
holding Spinlocks? That lock is used to protect struct "pwrctrl_priv". I didn't
yet provide a patch because I'm pretty sure that I'm missing the good and 
correct reasons that led the author(s) to use a Mutex in that context...

My second question is: should we substitute that Mutex with a Spinlock and use 
it everywhere else the struct "pwrctrl_priv" must be protected in the driver?

Looking forward to reading what you all think about these two questions of mine.

Regards,

Fabio M. De Francesco



