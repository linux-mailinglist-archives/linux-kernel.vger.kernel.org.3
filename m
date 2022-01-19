Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D3A494030
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356928AbiASSuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350117AbiASSui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:50:38 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52683C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:50:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d3so11822332lfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wj3R0FRfn1yO5ogKeGc8aripFNfSyJxmajRu2on35kY=;
        b=pe1iWhZirUTGmhYFeMyFbD34nGrpS52XKubMcy7XhUsPHYDaweveoSSJ0xnTHhRHWK
         20m5NC6R9tJIDsHjIbD1VFPqYLDmsG/N0Szv1UrZm9xhVPlG9AJJli7CV6iYMrgR6Rwu
         NhOEIJxv0osNjyejn4S6X35hD31YubMuEqCY2s7DYdDUc6uTefMSQbbc/Se0C5xs8nmB
         ccI4yd5EFGZv+k4tvN8+95FjVBq0L8Uub4f5y/1nX/vM3XeUsEW7Audld9eBL5dk72Yu
         AAkeVbwfhIrCNp+6Q4qlOOkWhGRMnA9Tb8TOCRMyLgl9GUZrTl+LJ2hRvgWNXwivZO25
         2x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wj3R0FRfn1yO5ogKeGc8aripFNfSyJxmajRu2on35kY=;
        b=bkY290Qw495oPSbnGW71OIURJdX3x1Ds0f51b8MYhhkXBrI8w9M1KnqYuSOTloUmcD
         MhTQKiJ52awLupVbLCJKA4zv86FvE0lvLoAsFeHzd8KPgub1OxvhjZ/U7SQa53aG81VC
         2r4N7ejeWMyPj8ykII6uhQB9gFckSQA9kFqULEcQG4XL4Kc8czKytQCokRf+HU3G/wHP
         eYljMNoAaKPaYUIqDqDRI9fhvb0ns1642EfXhzE/YfQC5Xq0p/w9ZIjLecmMgZ7UGDiB
         e8Hy2cAEVL6SToSvc+7AVb6/zDFpPURYlS6xkSzJkzmA/CUKo1Tm0UKmzQGB36HOffEr
         eKag==
X-Gm-Message-State: AOAM531pD/VFIsfwqeSegm8fSn3s3/cZsSoSflIAPi8aKq5jkuoAqZvb
        t3Ds4aQ6CQwTHRViTXnmQwU5g8WhbOorE1vXRKvD9w==
X-Google-Smtp-Source: ABdhPJxlWimiZNLmr8h++3TY1Fh0zvEgbDHKd8bwKwVQGXviRDQ5XXrBx6FNgZ9IhOY46CUuigHNzP3pTgPWPhbpLkM=
X-Received: by 2002:a05:6512:3b94:: with SMTP id g20mr28870780lfv.119.1642618233416;
 Wed, 19 Jan 2022 10:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20211222225350.1912249-1-vipinsh@google.com> <20220105180420.GC6464@blackbody.suse.cz>
 <CAHVum0e84nUcGtdPYQaJDQszKj-QVP5gM+nteBpSTaQ2sWYpmQ@mail.gmail.com>
 <Yeclbe3GNdCMLlHz@slm.duckdns.org> <7a0bc562-9f25-392d-5c05-9dbcd350d002@redhat.com>
 <YehY0z2vHYVZk52J@slm.duckdns.org>
In-Reply-To: <YehY0z2vHYVZk52J@slm.duckdns.org>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 19 Jan 2022 10:49:57 -0800
Message-ID: <CAHVum0fqhMQd2uFic5_7RN=Ah6TTH2G2qLNZuxnQXSazR57m6g@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: Move VM's worker kthreads back to the original
 cgroups before exiting.
To:     Tejun Heo <tj@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        seanjc@google.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        dmatlack@google.com, jiangshanlai@gmail.com, kvm@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 10:30 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Jan 19, 2022 at 07:02:53PM +0100, Paolo Bonzini wrote:
> > On 1/18/22 21:39, Tejun Heo wrote:
> > > So, these are normally driven by the !populated events. That's how everyone
> > > else is doing it. If you want to tie the kvm workers lifetimes to kvm
> > > process, wouldn't it be cleaner to do so from kvm side? ie. let kvm process
> > > exit wait for the workers to be cleaned up.
> >
> > It does.  For example kvm_mmu_post_init_vm's call to
> > kvm_vm_create_worker_thread is matched with the call to
> > kthread_stop in kvm_mmu_pre_destroy_vm.
> > According to Vpin, the problem is that there's a small amount of time
> > between the return from kthread_stop and the point where the cgroup
> > can be removed.  My understanding of the race is the following:
>
> Okay, this is because kthread_stop piggy backs on vfork_done to wait for the
> task exit intead of the usual exit notification, so it only waits till
> exit_mm(), which is uhh... weird. So, migrating is one option, I guess,
> albeit a rather ugly one. It'd be nicer if we can make kthread_stop()
> waiting more regular but I couldn't find a good existing place and routing
> the usual parent signaling might be too complicated. Anyone has better
> ideas?
>
Sean suggested that we can use the real_parent of the kthread task
which will always be kthreadd_task, this will also not require any
changes in the cgroup API. I like that approach, I will give it a try.
This will avoid changes in cgroup APIs completely.
