Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17396546DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350495AbiFJTzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349009AbiFJTzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:55:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F89111C00
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:55:43 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x138so306856pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBy6NjH2ouB9J4AcBo7wTpbSKkOShDZoTHSArfldiUw=;
        b=sklHbZakJDBBoAiTpjSD5q4HxK1etfA1WIC7E1GGXxranlMwDMPGy/uz2sJhGgVhFh
         PsuwAc1Kvt+JrVxUxoIbUT41GO80lUj3bVmOMXx/EiCDoPrvSZTi5VA6KlhM0oySyOuR
         +tYZA59GVkAhi7mk0TAsOWGswz98wriVH5TPC/c2Qf2YokWtgLtStUvjfTvamYaneEGH
         bzvkFbDMtZuEKw/jnULBvxk8zwbsM2bB87HtefiubybLbL+H3NdXdw9PHE9MFa1uwCCh
         tyZDjrUVtcAARyszAW1G5DhaCKiwkKolBeX5R2/hKBE7ytxWxLfuo/5GEb1KHAlQavBv
         Z93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBy6NjH2ouB9J4AcBo7wTpbSKkOShDZoTHSArfldiUw=;
        b=2/P9m6gVZzkqTvYOWE+ZK943P12RXavyS9C8O2r7XPMvpGyGhLNvqHEcz8yNPD4PIE
         nUo2yCDEgzWtmNVIhtnG2JKUH2Va+0AFgidw0MZimrkSqpLWUNOmJbf1bd+6/YSFtJQF
         JRvUgk39rcFbKNd4WpFqwzeNQrKQClxQ2exEkiPNB+WAtJfV8xqwPCnKyDUpKIdE82bj
         cNJeLVB+QuITPMQhTC4olpqgKxW4wU4YpfssTZGrl9um0gkrk51G89tE3uVQQ4je5Fzv
         FSEvgXHyMuBlcUyxjooVtqiFRaoX/xFVvcFEhx6DIZDp8xL2V+sVckokUz3WwRiff7g0
         Gq+Q==
X-Gm-Message-State: AOAM532UDhFU9GoMJNFKKD0LTePAScg/suNDXZZiTC8PYYTapwAnqr7M
        UBwmDMvHUx25lxFHzZDDqvh/g1I0hp7h6nT7IzD4qw==
X-Google-Smtp-Source: ABdhPJzEcSokF/zla93DIjSWei/mG/WMD+1gosW/4iq24fWu9VXSfgg5vd1o6/WI+TarUi1z/A31bQpqsNJXGPSmzwc=
X-Received: by 2002:a05:6a00:a12:b0:51b:92d7:ec55 with SMTP id
 p18-20020a056a000a1200b0051b92d7ec55mr55432987pfh.85.1654890942318; Fri, 10
 Jun 2022 12:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220606222058.86688-1-yosryahmed@google.com> <20220606222058.86688-2-yosryahmed@google.com>
In-Reply-To: <20220606222058.86688-2-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 Jun 2022 12:55:31 -0700
Message-ID: <CALvZod4XtEfdSjq=Jq51tvwXkpv-TKr32G6aeyjzcwxvdPv9SQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Oliver Upton <oupton@google.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
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

On Mon, Jun 6, 2022 at 3:21 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> Add NR_SECONDARY_PAGETABLE stat to count secondary page table uses, e.g.
> KVM mmu. This provides more insights on the kernel memory used
> by a workload.
>
> This stat will be used by subsequent patches to count KVM mmu
> memory usage.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
