Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F4746818C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383798AbhLDAtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354618AbhLDAtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:49:32 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B338AC061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 16:46:07 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id k2so9339849lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 16:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84mOUp3LokD6J3j/XPGM8Gdyu0TNZ1hY1SXnt8ueQl0=;
        b=W00VL1dQdtqB96CSXr76uDShRNGRcJZoc5gxPBZH6JD2lO3sXg/MbNgoIepxvjgy/v
         1ngl4zAcaMGNYSSMFZUmcTZGNuuO8BREoXOAvrLF1NuaG6twbr/BvF8zVlA2WCvc2n+s
         3atBTFjXpvf1BSw+xfGON8yWnXNLilAs33nqQ3TOiIIAryw8JTfFkO7b1WoJAv3zh/vW
         q1r05yy7mWaFNdo7OI46VANrC5cGCWMoG3EInP4CFFm8+Q/q39qu7nPEsJ9jSHTc3IgO
         oyiqNf62GHUrdj+I5THRVlKdw6jqwGTlCFLYmU1q+05R2IZ7CtOuatZgdbmNpnfUpW6C
         1BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84mOUp3LokD6J3j/XPGM8Gdyu0TNZ1hY1SXnt8ueQl0=;
        b=r9AcnJU1seePJwy2wrhlLX6Du4GVMvh723p/OvZXklGRrqfqvP2xIvZWJo/x9KufeB
         p6ccOP1CYhkaJf6Ghl9g6MAYmAzdpgjajKik+Q/zcTyfOXvGsUFa/avYUcJBTbpvfb0W
         fSERwATLYsPFNAkywOktwfIa1um831nXXcwLK/5PD7xenPnHcfd58ojOQbaN0j+A+JH2
         GmAIhpUQ/pUSErIOhRuP7gGSIM5we/zGr5oK/Hw9wHan+aS0JMcd7AnpoxVkRiSNM19I
         lb5X1Gt2v3nWBiHnzmWdwz3xW/Vvfh8JwVocEgrvMkfb8SmB0rlgHuD7F0cXtlgonTxb
         ACAA==
X-Gm-Message-State: AOAM533BhD2qj3NurkmvyC7kUGYs0eilNCwWWCIsIQUpLpGhTzSzHCG7
        5oEa/S2etVsKDFUbNG8vEbHu2hakNxYFsD9JDb+36g==
X-Google-Smtp-Source: ABdhPJzLV+ZZmoda/NgcR2Lu4eylwVG/7x4I9dAzKn8K8L/25X9VSHMV6CmA5i65Wuva7AzCKFziwlqii0mxLRX3B38=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr20684058ljp.202.1638578765757;
 Fri, 03 Dec 2021 16:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20211203162426.3375036-1-schatzberg.dan@gmail.com>
In-Reply-To: <20211203162426.3375036-1-schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 3 Dec 2021 16:45:54 -0800
Message-ID: <CALvZod6y+_O49jzuD9wLXncCEGCgun4f-uf_yBzYcsfEiH1WOQ@mail.gmail.com>
Subject: Re: [PATCH] mm: add group_oom_kill memory event
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 8:24 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> Our container agent wants to know when a container exits if it was OOM
> killed or not to report to the user. We use memory.oom.group = 1 to
> ensure that OOM kills within the container's cgroup kill
> everything. Existing memory.events are insufficient for knowing if
> this triggered:
>
> 1) Our current approach reads memory.events oom_kill and reports the
> container was killed if the value is non-zero. This is erroneous in
> some cases where containers create their children cgroups with
> memory.oom.group=1 as such OOM kills will get counted against the
> container cgroup's oom_kill counter despite not actually OOM killing
> the entire container.
>
> 2) Reading memory.events.local will fail to identify OOM kills in leaf
> cgroups (that don't set memory.oom.group) within the container cgroup.
>
> This patch adds a new oom_group_kill event when memory.oom.group
> triggers to allow userspace to cleanly identify when an entire cgroup
> is oom killed.
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

So, with this patch, will you be watching oom_group_kill from
memory.events or memory.events.local file for your use-case?

Reviewed-by: Shakeel Butt <shakeelb@google.com>
