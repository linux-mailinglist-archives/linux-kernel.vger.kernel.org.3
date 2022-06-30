Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6537560E90
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 03:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiF3BHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 21:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiF3BHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:07:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0EE4091F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 18:07:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a15so16619516pfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 18:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b24zTk0e6let+DmkyD3O6bwmQoOkoTYKCmgGUtQJ0ic=;
        b=q0wyUYDG3+RW5ZLzjV35nCB9Kyy1ozJ2yhLjTJx+jH+RFiJMIeE/Mtb/vTnUBCJ5Ih
         uAk1TObOeVDjM4rMjngdp//PkZ3aaqMSuuV5u+clo8zOT2ad+zUv7Vc3Jxclt7ya6cBV
         6aVVoL4/4XC9uS9ZO8wNheVKyaK0aZdXBw98tU2bw0u1C1G0HG8GkWMuNQRnrapiT7DF
         hSgxjq9XzbluDoYOQjrZ5RyCsgJ4lTnxn9SDIeoAf/NKvlXgYBqR8IIEPMbFWdduQ0ZF
         nmKXYcL7awq84bzQ6SoG2zTHSNcdCXlzSgRly8d4lnWuoQFc7oI7/YkEhSFVU48n7iqX
         2PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b24zTk0e6let+DmkyD3O6bwmQoOkoTYKCmgGUtQJ0ic=;
        b=CEl5LVmQPWDqtfsf72GEsnhMDHvTN6WomsLa5dKZyNe7UEa0/a4E/E5AztDllrzK+Q
         SJkXPKeDjIVcvdB5R9c8ASRtK434ZDIVGuKstPuu2ag67qN5Nz3ZID2oxIKf0KEQskG1
         if4v2NbqtddWii7FQg+enhvOBTFrC8ydcDGGIHzB81h0NipynyAS4EOJ/95/rFPE67b3
         wDadk85ZwwSuDZXPxYFaovnaN8IU5hN82RVCKXPx9qO6qZNuByMex/DSs325tt/Pkgs9
         bHqC0akmgfBYCOjpLYI5CZaXvsPecJ2Jm3aZhmKBS01WGDkqmv1APVEVsiwwXEL2caU8
         TdwQ==
X-Gm-Message-State: AJIora+QGzpHozBBhT6BxdQ2vCkA5/bPTCqkKuIh944bvN7RNyigLKCr
        QOENdpLu2nk1TTyDtRJJMVSj+uMOdENNGMLSCJAq5w==
X-Google-Smtp-Source: AGRyM1t1j0WgGjh0fBoPPJcAaXStzXPcr4K31ta8tbb+Vp/wo09weJxlO19+QLmE2GFxnGfT+NXhQwsU/MbB9V2ezsc=
X-Received: by 2002:a63:711e:0:b0:40c:c08d:79e0 with SMTP id
 m30-20020a63711e000000b0040cc08d79e0mr5293898pgc.357.1656551231569; Wed, 29
 Jun 2022 18:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz> <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
 <YrSWruhPlJV1X9kp@dhcp22.suse.cz> <CALvZod6eLa1X1FJ2Qi6FXhFA-qBCP4mN2SB31MSgjj+g8hKo6Q@mail.gmail.com>
 <YrSdFy3qYdG+rGR6@dhcp22.suse.cz> <CAJD7tkZNEtzJMDsLMHuNHkxFfurS37UuK=zFcPCkOkWfN-dbJQ@mail.gmail.com>
 <YrlpcdgF1HzA7bHS@dhcp22.suse.cz> <CAJD7tkYVy2uNwaPiiJdPKT5P_O-9WgxD68iFJ6vw=TLJcQV3Ag@mail.gmail.com>
 <Yrl2T632Vfv8QGPn@dhcp22.suse.cz> <CAJD7tkZzwzHq7Q7KKUdVSdO4LWTPkrGprp0Q-ze_SWhUd_mTMw@mail.gmail.com>
 <YrmjH2FZF7iNn8da@dhcp22.suse.cz> <CAJD7tkYemNQqu_O2nYG3cqxPWGELvc6Lh5i+KKNCtv6cgSPmdA@mail.gmail.com>
In-Reply-To: <CAJD7tkYemNQqu_O2nYG3cqxPWGELvc6Lh5i+KKNCtv6cgSPmdA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 29 Jun 2022 18:07:00 -0700
Message-ID: <CALvZod68WdrXEmBpOkadhB5GPYmCXaDZzXH=yyGOCAjFRn4NDQ@mail.gmail.com>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 10:04 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Mon, Jun 27, 2022 at 5:31 AM Michal Hocko <mhocko@suse.com> wrote:
> >
[...]
> >
> > I can see clear arguments for memory.reclaim opt out for vmpressure
> > because we have established that this is not a measure to express a
> > memory pressure on the cgroup.
> >
> > Max/High are less clear to me, TBH. I do understand reasoning for PSI
> > exclusion because considering the calling process to be stalled and
> > non-productive is misleading. It just does its work so in a way it is
> > a productive time in the end. For the vmpressure, which measures how
> > hard/easy it is to reclaim memory why this should special for this
> > particular reclaim?
> >
> > Again, an explanation of the effect on the socket pressure could give a
> > better picture. Say that I somebody reduces the limit (hard/high) and it
> > takes quite some effort to shrink the consumption down. Should the
> > networking layer react to that in any way or should it wait for the
> > active allocation during that process to find that out?
>
> I am out of my depth here. Any answer on my side would be purely
> speculation at this point. Shakeel, can you help us here or tag some
> networking people?

So, the effect of returning true from mem_cgroup_under_socket_pressure() are:

1. Reducing send and receive buffers of the current socket.
2. May drop packets on the rx path.
3. May throttle current thread on the tx path.

Now regarding the behavior from the reclaim due to reducing max or
high, I think the kernel should not ignore vmpressure. Please note
that unlike PSI which is associated with the current process,
vmpressure is associated with the target memcg. So, any reclaim on
that memcg due to real shortage of memory should not be ignored. That
reclaim can be global reclaim or limit reclaim of ancestor or itself
or reclaim due to lowering the limit of ancestor or itself.
