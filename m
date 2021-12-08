Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB5D46CB9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 04:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243930AbhLHDlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 22:41:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243899AbhLHDlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 22:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638934698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Usm8/O3x4Vrv4f3qn7WGdypmLDEtXX7cryGdxfW72lM=;
        b=RsxOuAkPWRG7MlYZGh6Dy3KF3PipceuLRcgNvaSS2TdL8EBm5+BlXDUUmtfH9lGy/YJ99r
        2UZlr4uZWUNWcnTIjGY28bCXOTnxikpmiWhn+d62eHe5fuYqHoiRhmAO6GZzD7d4oFQBTq
        IznmYU81K0Pu5OlOzKgzRkiOau3uc2k=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-fQ4MJiBTO8WInKTFW5rTUQ-1; Tue, 07 Dec 2021 22:38:17 -0500
X-MC-Unique: fQ4MJiBTO8WInKTFW5rTUQ-1
Received: by mail-yb1-f200.google.com with SMTP id t1-20020a5b03c1000000b005f6ee3e97easo2200302ybp.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 19:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Usm8/O3x4Vrv4f3qn7WGdypmLDEtXX7cryGdxfW72lM=;
        b=xy6su2bSie+LQeR3IbYzecBma1SehsrCmHkfPupl/lAiRlP5yLPpKWAjkpRcBw6LHc
         8RY3O9eCfq4JreBHiIgPMeIxISmEnw8yWryrW2U4X8SutmBo8Qsw1sJC7UZyPDtY7D7W
         SFNYC3aM9sgqk6e6lflR8+2DK7oU/pss0gxL/DgVOSNO9z1lBhjsHpBQMYxxmsDSBkAG
         HI6Orkji+V2ugqxDgeI1Nkdhz4pA4z5o4/1bnjwz8n1m+1U7xQxfa20OKg8M+8/DZA6H
         8676cWN0nAQYC9o03ghls/fsiJtt738/05tnYGre8gq6HtuyOB8inDxDwJm5bfV6wUUH
         KNKA==
X-Gm-Message-State: AOAM530Ch3LHUCT6/Kl4sydZYBvWU96RnjvIP8EDbAZAGDQrpPBGcIHj
        o57YHvPiM4Z73vJHMR2s0b6OGp/KHpK1GeuU8oNB2myb2vq7AFm/YRSvHZWkxb2pCc68samP3Rx
        Z91R9tePqFPnG4xCwzjj8DaA3Q9QS6ZgGA2bja1HQ
X-Received: by 2002:a25:d792:: with SMTP id o140mr18123291ybg.493.1638934696508;
        Tue, 07 Dec 2021 19:38:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrSZ/145BJDSM88ngNZDMqi4jaqquB9mohl2mSpkU5+Q8Ltv+dUGjNwpGCZVVN6/6gXiwWN9d3XodP8QLOTOU=
X-Received: by 2002:a25:d792:: with SMTP id o140mr18123274ybg.493.1638934696324;
 Tue, 07 Dec 2021 19:38:16 -0800 (PST)
MIME-Version: 1.0
References: <20211207214902.772614-1-jsavitz@redhat.com> <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
 <ce63e509-dedf-ce00-cd12-2c67a3e650ba@redhat.com> <20211207175816.8c45ff5b82cb964ade82d6f1@linux-foundation.org>
In-Reply-To: <20211207175816.8c45ff5b82cb964ade82d6f1@linux-foundation.org>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Tue, 7 Dec 2021 22:38:00 -0500
Message-ID: <CAL1p7m48NfO0WfOcQ0F36Wk+YxiVMea-Pr1YCyVktViNfaxQQw@mail.gmail.com>
Subject: Re: [PATCH] mm/oom_kill: wake futex waiters before annihilating
 victim shared mutex
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nico Pache <npache@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 8:58 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 7 Dec 2021 19:46:57 -0500 Nico Pache <npache@redhat.com> wrote:
>
> >
> >
> > On 12/7/21 18:47, Andrew Morton wrote:
> > > (cc's added)
> > >
> > > On Tue,  7 Dec 2021 16:49:02 -0500 Joel Savitz <jsavitz@redhat.com> wrote:
> > >
> > >> In the case that two or more processes share a futex located within
> > >> a shared mmaped region, such as a process that shares a lock between
> > >> itself and a number of child processes, we have observed that when
> > >> a process holding the lock is oom killed, at least one waiter is never
> > >> alerted to this new development and simply continues to wait.
> > >
> > > Well dang.  Is there any way of killing off that waiting process, or do
> > > we have a resource leak here?
> >
> > If I understood your question correctly, there is a way to recover the system by
> > killing the process that is utilizing the futex; however, the purpose of robust
> > futexes is to avoid having to do this.
>
> OK.  My concern was whether we have a way in which userspace can
> permanently leak memory, which opens a (lame) form of denial-of-service
> attack.
I believe the resources are freed when the process is killed so to my
knowledge there is no resource leak in the case we were investigating.

> > >From my work with Joel on this it seems like a race is occurring between the
> > oom_reaper and the exit signal sent to the OMM'd process. By setting the
> > futex_exit_release before these signals are sent we avoid this.
>
> OK.  It would be nice if the patch had some comments explaining *why*
> we're doing this strange futex thing here.  Although that wouldn't be
> necessary if futex_exit_release() was documented...
>
Sounds good, will send a v2 tomorrow

Best,
Joel Savitz

