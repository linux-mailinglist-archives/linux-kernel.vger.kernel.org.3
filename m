Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D836C55D4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbiF0Q3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbiF0Q3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:29:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBF3B7C7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:29:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v65-20020a1cac44000000b003a03c76fa38so5203844wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCgDBgQt6lsYAKDyUa0fPFsfL97zuKyIxwCybKNVm6o=;
        b=IuiG/blkJ7gXjOQhLgtlkFYoJRK5r8pgakqSWN1/zlxqf40s05Q2KxgVLRnXAzs+fg
         ulTgDq4Xa1IQ2RvaytKxJcvgFOnViaFiqQeqoT8bFMwQmOfmx5WYvBOMGbjbujaxBKq2
         ZxRw26go6NuTS6kLvJS34xZfj51gNbDxnvzESq7KPA+97DIORIk3qqV6wvZaFYlRyp37
         iYjN5F2Fx3qCzsMwgAJwoELntygw5WoMYjcgqI9vY49AS4kLGOtkbsV2NX3QusZYb24t
         UMBgY7EFeybOiOqeaEkIwXo3wZRzJbzLQJE66d9iQWRd6teu2XSLOdmiKZKg0XoS0prd
         qUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCgDBgQt6lsYAKDyUa0fPFsfL97zuKyIxwCybKNVm6o=;
        b=tqIcpVtDHpGBtwZe39UVng1s7CYSTjq2hCgLRmgZEPWN2ZnJgXprWtKoFpGmDCmAil
         gudbOl9do1t2HkPHzPRR1wIaES3WU9VTOImwTfF3cSYUBxssHiTvG99pvCHDIcnSX55s
         fERim8Kvy1YUi3VVhsoEn+S5P84d+cjmF52271e0Njv39LpzLrOCIaiOazJYWJI2RLmw
         yxzVPNSmRBMS+LYk5D3H/BJPNCgKm+ubnTKpPzypuK1xiOK/BScOKj/1kY6GIfvK3Vaq
         DD81BazAhdeqi/pGdmDIXL5cXZwUdFBuufqJWlHJ76bTcWX39khgicsXP8jLE5RzGQCh
         6Ueg==
X-Gm-Message-State: AJIora/0zthVpVigZw1qJ1Q7fcxefvQdefv+QCCeaL9CvnSMnsc2gXLp
        Z9BQOCn9/YyOi8qXuu/08K4+GXOlao9QLy7tkANhfw==
X-Google-Smtp-Source: AGRyM1vrDRm9Dztps4OpWjfEHDZNDaLLcMTy/XMsmuqPQoMJ/tNBlVur8bjCqgfF0MDzD0AVg6RDeZvfzsVoc13BMio=
X-Received: by 2002:a05:600c:34cc:b0:39c:832c:bd92 with SMTP id
 d12-20020a05600c34cc00b0039c832cbd92mr16254989wmq.24.1656347388958; Mon, 27
 Jun 2022 09:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220606222058.86688-1-yosryahmed@google.com> <20220606222058.86688-4-yosryahmed@google.com>
 <YrnZVgq1E/u1nYm0@google.com>
In-Reply-To: <YrnZVgq1E/u1nYm0@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Jun 2022 09:29:12 -0700
Message-ID: <CAJD7tkbkgruPRrfyaHGQcOgmNFCWRASaZB-a8igBScpasfC64g@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] KVM: x86/mmu: count KVM mmu usage in secondary
 pagetable stats.
To:     Sean Christopherson <seanjc@google.com>
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
        Oliver Upton <oupton@google.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 9:22 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Jun 06, 2022, Yosry Ahmed wrote:
> > Count the pages used by KVM mmu on x86 for in secondary pagetable stats.
>
> "for in" is funky.  And it's worth providing a brief explanation of what the
> secondary pagetable stats actually are.  "secondary" is confusingly close to
> "second level pagetables", e.g. might be misconstrued as KVM counters for the
> number of stage-2 / two-dimension paging page (TDP) tables.
>
> Code looks good, though it needs a rebased on kvm/queue.

Will rebase and modify the commit message accordingly, thanks!
