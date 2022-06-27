Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEBB55E270
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiF0QIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbiF0QHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:07:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019CE15711
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:07:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so2259515pjs.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l0pibN8bjG0PnvfGdr94sagjrAjKQlwTKx4ke7hg5TE=;
        b=KXpJaULYCMOBvM0KZ+Y0QmYKcs5GsOT3UDoT12OxOmZTuofXiRwwGm/WgJTM1heXoI
         t1dv3k342OQnZ9iooXjd608cniWLl0qlDw2/EFrZO3JITiMUniSnoS9vRpsVYcQj8vN/
         I7nko6H+yxfXlWmj6BpVmIQCvWqpF55RTmiG3dExwV8krl6JWA8dxuz7o3cuKUtlCKLL
         AUH1GrHaKcLi0AxNkq1Q0RlPIztx9SDq4ccjZXK7Aa2jkpBZXbRVUSJ+/fIBfJxIB9bo
         wqHrvEDbll+Qw87/iH2rzRcMOLCQ34VpKyfcZXoB0fUgM3GYU80A2xB80LHN6E80KQa1
         5riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l0pibN8bjG0PnvfGdr94sagjrAjKQlwTKx4ke7hg5TE=;
        b=1vRXz30PCVCi6B/rimdZvAI6IK44lnufViVwMmA5+3e4TMSw674P34KvVZ+GcApCWc
         CCvPETOAFiUx8Pe/mD6cihACCmKQOrm+4Hh4QOaWfBn3hFV7VXBOn5V16HKSxZaVpEkQ
         BFFkCuplY7KW9YGFvbk31uP3FAwsMBMnvuVBH8iwvCIkyHOoihCPmOWNUHhcL+mChvwq
         57GjPgWnvgH4xacZtw9mwMpvI82JffYs4afZCwjK+rUjXMWnx6I/28eSghv1umHcIEJF
         pT2aNCG0JGfHkt/SXl9BEB8WhVUG3puPC22SuKJGKkdWISj5I3fwLztC3yMKUMhKhK7W
         yByw==
X-Gm-Message-State: AJIora/3IgbhLm3BpDGsuo98K7bD8MHI6faeVudAq5k+D2zQZrODViA4
        DJ127v76zwqA64Sis0P7s4guqg==
X-Google-Smtp-Source: AGRyM1uyfo5AfaNgmfF7G/qEE7dWnvzScXgctBWfKk3cum7fj6D7nx+TeglAS/qAbSPCsy6MAsmoPA==
X-Received: by 2002:a17:902:9f97:b0:16a:9b9:fb63 with SMTP id g23-20020a1709029f9700b0016a09b9fb63mr15547216plq.7.1656346056250;
        Mon, 27 Jun 2022 09:07:36 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78191000000b005254bd90f22sm7528584pfi.150.2022.06.27.09.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:07:35 -0700 (PDT)
Date:   Mon, 27 Jun 2022 16:07:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Oliver Upton <oupton@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
Message-ID: <YrnVxM/5KjVhkOnn@google.com>
References: <20220606222058.86688-1-yosryahmed@google.com>
 <20220606222058.86688-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606222058.86688-2-yosryahmed@google.com>
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

On Mon, Jun 06, 2022, Yosry Ahmed wrote:
> Add NR_SECONDARY_PAGETABLE stat to count secondary page table uses, e.g.
> KVM mmu. This provides more insights on the kernel memory used
> by a workload.

Please provide more justification for NR_SECONDARY_PAGETABLE in the changelog.
Specially, answer the questions that were asked in the previous version:

  1. Why not piggyback NR_PAGETABLE?
  2. Why a "generic" NR_SECONDARY_PAGETABLE instead of NR_VIRT_PAGETABLE?

It doesn't have to be super long, but provide enough info so that reviewers and
future readers don't need to go spelunking to understand the motivation for the
new counter type.

And it's probably worth an explicit Link to Marc's question that prompted the long
discussion in the previous version, that way if someone does want the gory details
they have a link readily available.

Link: https://lore.kernel.org/all/87ilqoi77b.wl-maz@kernel.org
