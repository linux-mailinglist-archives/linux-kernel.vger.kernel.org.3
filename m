Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4E54A919F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351466AbiBDA2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356249AbiBDA2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:28:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D75C061401
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 16:28:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21FD16194D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53139C340ED
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:28:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MaIc+ctV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643934488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HF0rRa5EnwKT/qOmnqaK6ElRG/TXMX7590t2kkXeFmM=;
        b=MaIc+ctVA54pjoI02uXtw2uPEmauyVuMgFWoSu/CIZiWABkT1X9zX7JXkL8BTbgf4h3iI0
        4gXqJp52x0OnGmNP4COdQGLzXm4oonAvcAahiLfIHwVhwu74ra5qnr8/ITjOtaiT8+oigZ
        0Az48+y2wkHBMb+b7575j/KBBj9mnNw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2611bb48 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 4 Feb 2022 00:28:08 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id j2so14281181ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 16:28:08 -0800 (PST)
X-Gm-Message-State: AOAM533b0MUf+k6yNcgubUr5Bso7ZAWRy3e4X2HPc+vTp2eBICfD36/4
        qN6XRz5cU8A67ilMbivLcap9GUP0A8/6NnlV9Hc=
X-Google-Smtp-Source: ABdhPJxNQK62tdEVNVMjnlIxywN46nOPQ4BXobrWvXD2l1dvgptbg+kzWTml5BQfObTa6s+t2aI9c3pQUZ+jULF/joA=
X-Received: by 2002:a05:6902:14d:: with SMTP id p13mr693243ybh.638.1643934486228;
 Thu, 03 Feb 2022 16:28:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pe2BEJV4WiZNHmDmH_XK621Qqr1JCBdgTNZmr4JGBA4w@mail.gmail.com>
 <20220128223548.97807-1-Jason@zx2c4.com>
In-Reply-To: <20220128223548.97807-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 4 Feb 2022 01:27:55 +0100
X-Gmail-Original-Message-ID: <CAHmME9qtjZX2kVNSQqUsTrZv1cdR8y6n3yZS-RnpVCCzX9okcA@mail.gmail.com>
Message-ID: <CAHmME9qtjZX2kVNSQqUsTrZv1cdR8y6n3yZS-RnpVCCzX9okcA@mail.gmail.com>
Subject: Re: [PATCH v2] random: remove batched entropy locking
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andy,

Think I could bug you to review this patch? The general idea is based
on your original patch, and I think this fits what we talked about on
IRC. I figure we'll probably both page this out of our minds after
another week or two of not thinking about it.

It's here on cgit if that's easier to look at:
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?h=jd/no-batch-lock

Thanks,
Jason
