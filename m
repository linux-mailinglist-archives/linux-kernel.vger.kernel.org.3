Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70604581592
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbiGZOlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbiGZOl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:41:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76DB2C13B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:41:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b10so13650520pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WLVXS/0kupUktsK2+CD6EuJ/Qvqf6s7Lb65K/IAy4w8=;
        b=WNXA9pBwXIZKyCUHbghG3vxlDSskNo9cLyhT73WCcLsGMtugoohsTPby0NXH8rfmaa
         /Kcp/3Osi/SejSRkw50UYeR+WMAsFsIy1+/boAfuwON6uBYdH7nFcX4cVEMnbC8ZCQrs
         JkOqePeio6fs2HviTTabAF6I5zijeOoqcYpDLAmZRJ/+AsrRoBoS0eC+GuXPRIsCiI8e
         luwoF0Tn+RVOplbN6jPR4RV7uhuXISkt7bIpI73z9Ixoy/cwiOB8Ox38qSMWO9lYc74d
         o8y0ApmuueuiI0i8bQgxbPg+LCuFkrMy0aDz21NwOhZzoCQ5Rks6tXHcSfpQA6wGVQ6s
         BsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WLVXS/0kupUktsK2+CD6EuJ/Qvqf6s7Lb65K/IAy4w8=;
        b=ZNmk74MbKNtIW/6j9c9TSC5NuPEUj+aQenmNhsZaP0XaT/zB6zYbX27fGMcrH7Tl/e
         Ur49jbqzkJdCZbunuiQ4tgqStc1YftINy7CQIhQqVz8dG1VizIvugLjocKtc2gtel+k6
         ZNzQAruU+0lhQ+HOj2bzmeHjoBF2Rw9IyXdM6XhXrUvsQNNHqHeAzWhuBOyCyB/aplXa
         ddFA3AVsNeroYeqFIiJLyQdsjmFtAs9ZPj5pvhGHMdNTndT3aSlNxHqEFCH5Cvf6nxrl
         4+ZtNe7EsZsOWfZYzQTQWxS13DT3g9JwhtmzZz0y43ZPKWNMwh19wpUiX+DMXaLoIe08
         gmJQ==
X-Gm-Message-State: AJIora/D5a4mzYcp9utGZ/7191mb03fJJ3XCVfyJlIPZEf+jggNoOYcl
        OWlXGOcMJOqh3iSbuBQSWhytnw==
X-Google-Smtp-Source: AGRyM1sSMliYn1VhOQ2MAyXAGbL7E+yRGbQRKY7iNy6rCoDwmJZOOccvooE6ooWjpnALWrPjUF9nsw==
X-Received: by 2002:a17:90b:1b43:b0:1f2:3d94:efd2 with SMTP id nv3-20020a17090b1b4300b001f23d94efd2mr25983180pjb.65.1658846485034;
        Tue, 26 Jul 2022 07:41:25 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 135-20020a63058d000000b0040d75537824sm10254744pgf.86.2022.07.26.07.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:41:24 -0700 (PDT)
Date:   Tue, 26 Jul 2022 14:41:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: mmu: Simplify judgment conditions
Message-ID: <Yt/9EJienmR2i+va@google.com>
References: <CAPm50aLYb9+wsm3WA8buhC+ePfR6TrGbDR0nMju+bLzf0Tozuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPm50aLYb9+wsm3WA8buhC+ePfR6TrGbDR0nMju+bLzf0Tozuw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022, Hao Peng wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> kvm_shadow_root_allocated() has been checked before in
> mmu_first_shadow_root_alloc,
> and subsequent kvm_memslots_have_rmaps() does not need to check
> kvm_shadow_root_allocated() again.

Heh, this has come up before[*].  I agree with Paolo that checking for rmaps is
more intuitive than checking for !TDP MMU.  I'm not sure I agree about dropping
the check entirely though, it just seems like we'll end up back here again, i.e.
someone will inevitably propose optimizing the case where KVM has already allocated
rmaps and gfn_track.

[*] https://lore.kernel.org/all/c31a5f84-6da2-c6a0-c0cd-9f6802c39fc3@redhat.com

> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 52664c3caaab..ecd64c06f839 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3584,7 +3584,7 @@ static int mmu_first_shadow_root_alloc(struct kvm *kvm)
>          * Check if anything actually needs to be allocated, e.g. all metadata
>          * will be allocated upfront if TDP is disabled.
>          */
> -       if (kvm_memslots_have_rmaps(kvm) &&
> +       if (!is_tdp_mmu_enabled(kvm) &&
>             kvm_page_track_write_tracking_enabled(kvm))
>                 goto out_success;
> 
> --
> 2.27.0
