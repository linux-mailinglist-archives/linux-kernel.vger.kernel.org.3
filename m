Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB54CB5EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 05:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiCCEjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 23:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCEjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 23:39:42 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E452187
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 20:38:56 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q5so3768873oij.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 20:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wo7DR6hin152XAg/mOrL8xQTTw69iw6giRIoImOhAss=;
        b=tBNSePt5D36Q4+SxLdam2ME33dJzm5Z2/Qt7AhmESbvYQEHBfItiUpeesWZ3Xu9O1Z
         pLztfP99SkzEIsM6gq2q9U4DaaRBdbOd+2IACldieNP8Yy7QSs0q3PwC4SzRxfEqktRI
         DGp0TC8QX7T7T9HiGYrxIbXemCRl1gQiKHh/Yio+hb7XyR8oNPR/lMXYqL/8SUxVSu69
         DZttcf+rOn9GgZ+EtY5euqwb/xFWiSSUethtfd5Uab2Lb+CvVjGvF3bbieNZEENj9I6O
         aKql0BNpFNPjCyol82LjJpVNwoWOBOQE6yKWxa7BHw1IbWx+4lOsMN3Nk2CW4CnH5W74
         wlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wo7DR6hin152XAg/mOrL8xQTTw69iw6giRIoImOhAss=;
        b=3Mq1uM8PfHKCnNl1yayaUBfZx6prsePBz8PjcMJxrUDHDFFQD//MX1wadOtIdcmP12
         UQuojz3y3dRAy0XDP2qYVtc5YPgpgtT9eW8lcZQ5wFhYGs9ifP2fZycQq6sBr6YrM1rm
         aH/SmqJMRiEnRiHwXOWiH/BLkVUvsgoioMVGFyrXn8vGJQEYxiNy5mr4Eyxk9jTwkl6r
         Qi0c7FaAMXAAeeWqUAY0OPBU+zAXRv/oz4iWjMXf4kkLjORRJ4yd+7OFncLvAdUFD2Wb
         HHvRyE9w1JmTazQS3xL4upIRxgcnt2rVROtJFz6YvqRw2KRRqpBsVECSsfoqfVqyjuTj
         t9iw==
X-Gm-Message-State: AOAM5317v7kwdfSk60z1mYwqcBL58VgLohd4APVtbaHNwFrfkh82J3t4
        C3Sjr/jxL18F3N1HNRKR//nGlvP7RGLwmgnXNGqXxA==
X-Google-Smtp-Source: ABdhPJw/KBkvONKt9Wn4/0uYn7NnptsmDqJMe0dlO8oCQEOxR1thOKUdkAXxW6zLTBPFM3gAg1cJVxgsicshKPRlak4=
X-Received: by 2002:a05:6808:1443:b0:2d7:306b:2943 with SMTP id
 x3-20020a056808144300b002d7306b2943mr2994793oiv.66.1646282335689; Wed, 02 Mar
 2022 20:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20220221073140.10618-1-ravi.bangoria@amd.com> <20220221073140.10618-4-ravi.bangoria@amd.com>
 <1e0fc70a-1135-1845-b534-79f409e0c29d@gmail.com> <80fce7df-d387-773d-ad7d-3540c2d411d1@amd.com>
In-Reply-To: <80fce7df-d387-773d-ad7d-3540c2d411d1@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 2 Mar 2022 20:38:44 -0800
Message-ID: <CALMp9eQtW6SWG83rJa0jKt7ciHPiRbvEyCi2CDNkQ-FJC+ZLjA@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: x86/pmu: Segregate Intel and AMD specific logic
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Like Xu <like.xu.linux@gmail.com>, seanjc@google.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, eranian@google.com,
        daviddunn@google.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        santosh.shukla@amd.com,
        "Paolo Bonzini - Distinguished Engineer (kernel-recipes.org) (KVM HoF)" 
        <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 2:02 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
>
>
> On 21-Feb-22 1:27 PM, Like Xu wrote:
> > On 21/2/2022 3:31 pm, Ravi Bangoria wrote:
> >>   void reprogram_counter(struct kvm_pmu *pmu, int pmc_idx)
> >>   {
> >>       struct kvm_pmc *pmc = kvm_x86_ops.pmu_ops->pmc_idx_to_pmc(pmu, pmc_idx);
> >> +    bool is_intel = !strncmp(kvm_x86_ops.name, "kvm_intel", 9);
> >
> > How about using guest_cpuid_is_intel(vcpu)
>
> Yeah, that's better then strncmp().
>
> > directly in the reprogram_gp_counter() ?
>
> We need this flag in reprogram_fixed_counter() as well.

Explicit "is_intel" checks in any form seem clumsy, since we have
already put some effort into abstracting away the implementation
differences in struct kvm_pmu. It seems like these differences could
be handled by adding three masks to that structure: the "raw event
mask" (i.e. event selector and unit mask), the hsw_in_tx mask, and the
hsw_in_tx_checkpointed mask.

These changes should also be coordinated with Like's series that
eliminates all of the PERF_TYPE_HARDWARE nonsense.
