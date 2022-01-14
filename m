Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBBD48EBD9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbiANOkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:40:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238631AbiANOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642171213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKV19dENBhFl1olZIBfaFtSkXrSPs/HdlOLwrwpt/XY=;
        b=JI9pf9Z/tDn46TkJP/+RJ0h2O4YMZd2Arpzc6BQmKRS/zilusCTeQrYUF7R1S6Oux/w2wN
        czOoOH2qoElfhSL2p8jHWBoOnA3I5QuiNY+4Vp7qw4a9lHwBwXEMwGq6jNaYFOukIc0weQ
        rBXivjvO/L9ksiB/1AWXo2+RN5RgnBI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-FKM1wCRiPlmQAJpHhpt-vA-1; Fri, 14 Jan 2022 09:40:12 -0500
X-MC-Unique: FKM1wCRiPlmQAJpHhpt-vA-1
Received: by mail-yb1-f200.google.com with SMTP id g7-20020a25bdc7000000b00611c616bc76so9335865ybk.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKV19dENBhFl1olZIBfaFtSkXrSPs/HdlOLwrwpt/XY=;
        b=bAUZPTfwzoPJOEy5LD5PdlOeNFTDiBCkEVENg8QfNEQXPYFjNndlcKRfhuAo3vDLrR
         b6+TKJPg/c69rwu3a+EkqVXHjPpnSEniw2YnQ3V0x00U21TgFl5LxnlVTXplt9p/F3xe
         6afRKy3f5njh2M5GsyEu4cw+NJh/pEK+cMklAtzslH2Knl76W6T88ttzquoXrIuhBWA/
         k2kljVVgqArXjazoyKhyfYLHU6gHIyyahsm9uBJZfdYsWGzhGwPtUHzojtNa7a4e0dcc
         yB0n4YbOp0Ge/LaLK52o7SG98aArISOJF91S1Ilz3LZTaWN+0m53J96a7YAaN8US2f01
         stzQ==
X-Gm-Message-State: AOAM5318gj9J3jbOIEUdIf/NXdWQeJ8x+ZA6DIPOGBDcmpVzdaEeQlWY
        46fCkdXw1XrF4U9F8+M6ZoP5IEQ/PnpzyskYJBnVwPQkzrVHJ2UBZcC8HMah16cqspvVRdpAYmf
        1ipNzjGryoQi5dYEwalNmuHgcLuuDPQNmqamAWkRC
X-Received: by 2002:a05:6902:1029:: with SMTP id x9mr13850662ybt.51.1642171211991;
        Fri, 14 Jan 2022 06:40:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHapFsOwhgeQK8c6DQZkHoQw83S550a/inbIsrjpPP/8BgLW1kn2oHlZGR6sri9U5Gkb8PKUuLM8BKKzLen5M=
X-Received: by 2002:a05:6902:1029:: with SMTP id x9mr13850634ybt.51.1642171211744;
 Fri, 14 Jan 2022 06:40:11 -0800 (PST)
MIME-Version: 1.0
References: <20211207214902.772614-1-jsavitz@redhat.com> <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
 <YbB0d6T8RbHW48sZ@dhcp22.suse.cz> <YbDX16LAkvzgYHpH@dhcp22.suse.cz>
 <CAL1p7m4ka1v-Zoi-RpDy5ME-bMikGPX5V_4Hod-Y0KHOq_G8zA@mail.gmail.com> <YbG1mu0CLONo+Z7l@dhcp22.suse.cz>
In-Reply-To: <YbG1mu0CLONo+Z7l@dhcp22.suse.cz>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Fri, 14 Jan 2022 09:39:55 -0500
Message-ID: <CAL1p7m7mWxLE-7Qf_QjmREJ2AvfSexPvybPyHvxTUugxsPPxjQ@mail.gmail.com>
Subject: Re: [PATCH] mm/oom_kill: wake futex waiters before annihilating
 victim shared mutex
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What has happened to the oom victim and why it has never exited?

What appears to happen is that the oom victim is sent SIGKILL by the
process that triggers the oom while also being marked as an oom
victim.

As you mention in your patchset introducing the oom reaper in commit
aac4536355496 ("mm, oom: introduce oom reaper"), the purpose the the
oom reaper is to try and free more memory more quickly than it
otherwise would have been by assuming anonymous or swapped out pages
won't be needed in the exit path as the owner is already dying.
However, this assumption is violated by the futex_cleanup() path,
which needs access to userspace in fetch_robust_entry() when it is
called in exit_robust_list(). Trace_printk()s in this failure path
reveal an apparent race between the oom reaper thread reaping the
victim's mm and the futex_cleanup() path. There may be other ways that
this race manifests but we have been most consistently able to trace
that one.

Since in the case of an oom victim using robust futexes the core
assumption of the oom reaper is violated, we propose to solve this
problem by either canceling or delaying the waking of the oom reaper
thread by wake_oom_reaper in the case that tsk->robust_list is
non-NULL.

e.g. the bug does not reproduce with this patch (from npache@redhat.com):

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 989f35a2bbb1..b8c518fdcf4d 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -665,6 +665,19 @@ static void wake_oom_reaper(struct task_struct *tsk)
        if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
                return;

+#ifdef CONFIG_FUTEX
+       /*
+        * don't wake the oom_reaper thread if we still have a robust
list to handle
+        * This will then rely on the sigkill to handle the cleanup of memory
+        */
+       if(tsk->robust_list)
+               return;
+#ifdef CONFIG_COMPAT
+       if(tsk->compat_robust_list)
+               return;
+#endif
+#endif
+
        get_task_struct(tsk);

        spin_lock(&oom_reaper_lock);

Best,
Joel Savitz

