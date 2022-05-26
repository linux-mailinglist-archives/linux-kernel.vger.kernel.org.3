Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E505351C5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348067AbiEZQAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348049AbiEZQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:00:44 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAE69346B
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:00:42 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-300beab2b76so19872887b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9xQMdzHNoTHZ+UFq3AI9FpCr84h47csBpAVGEWrE6E=;
        b=gKUCA8XRy/7JOvVldrZ98O5RkwoNOFqFfVJCWQmSpHW+tyi++EKfJ8iAHZiR6KWIB/
         eXPp+A43o7gNeTUt2iC4vaJCbp0efqZjXXQLa7Tg62DEzFcMgqR6cljQP7gFMTtrDidc
         BNsQwJ8T+Jc8UoPqH4rvET9kMgjUG6HS58z9KlosNdNDsRoFLLizwJfFW8is630RPsli
         vXd+xbKl+O+glH18i+BmZles82K3xg7eviCZDURpyevjzFXUnoffDQ4aAO+z/XSWGWBe
         /ZeB5HMPgOpniKQud0ZvZJSChAmbL/Ey7iUHW3OaKL2ygAWzbPhE2+8PAVdS+xCdJSmW
         kwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9xQMdzHNoTHZ+UFq3AI9FpCr84h47csBpAVGEWrE6E=;
        b=YC/+9Cxy0CtuCWRrJ4pKfLNxmma717O4zHV8FS2MIv1MgCntOTtDGDDP6f0Yv+6BlR
         xvIcIVoesABu+fiUR3ij6i0a+yqk0dRqtJn03cYzC3Sk3EzzGBMhleyJgCk579c5q007
         fl5by7gZsYnt0b6LEAtmLHSGrq5RZZoIeHgdiO8JrGXk7XWbW5Ac8E13JxHy1wB2/fMD
         YpgdS85xC8Yp/ZAGqP9jFkoYzqx0ci5RHiqJfVXSq8suHLIrETScxJZTvsKirp988xRF
         06wJXqDPcPlm5LVCIpH8h6nAJud5U6yolgv+6N1HTjL5O+7CNQU68H+MTNLn/0HzJ5RG
         yYcg==
X-Gm-Message-State: AOAM531Ou2B+C+rTsNDADQ9FQHPn4equEJBMxnB5uOCfip3ZHSZrGy4V
        MOuDoCG9CdQN0IXldQLp5fLgb840KSoSDthDcEc/2w==
X-Google-Smtp-Source: ABdhPJxK8siuCJxx46aoxJ6LyluAf+2SNX+GgURVnLNooDyqYt1tjwqyinR6vVFZqWA4Z9rvJxMXhlSgK313sp+WaGw=
X-Received: by 2002:a81:3696:0:b0:2ff:2dc1:3a05 with SMTP id
 d144-20020a813696000000b002ff2dc13a05mr40469644ywa.478.1653580840998; Thu, 26
 May 2022 09:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220525230904.1584480-1-bgardon@google.com> <a3ea7446-901f-1d33-47a9-35755b4d86d5@redhat.com>
 <Yo+O6AqNNBTg7BMY@xz-m1.local> <a1fbab86-ece9-82e3-64fe-0a19a125513b@redhat.com>
In-Reply-To: <a1fbab86-ece9-82e3-64fe-0a19a125513b@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 26 May 2022 09:00:29 -0700
Message-ID: <CANgfPd8VqKYwr7fprie6h0y0cQEPLrbS5euMrBCjz7osypgkNQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/MMU: Zap non-leaf SPTEs when disabling dirty logging
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
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

On Thu, May 26, 2022 at 8:52 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 5/26/22 16:30, Peter Xu wrote:
> > On Thu, May 26, 2022 at 02:01:43PM +0200, Paolo Bonzini wrote:
> >> On 5/26/22 01:09, Ben Gardon wrote:
> >>> +           WARN_ON(max_mapping_level < iter.level);
> >>> +
> >>> +           /*
> >>> +            * If this page is already mapped at the highest
> >>> +            * viable level, there's nothing more to do.
> >>> +            */
> >>> +           if (max_mapping_level == iter.level)
> >>> +                   continue;
> >>> +
> >>> +           /*
> >>> +            * The page can be remapped at a higher level, so step
> >>> +            * up to zap the parent SPTE.
> >>> +            */
> >>> +           while (max_mapping_level > iter.level)
> >>> +                   tdp_iter_step_up(&iter);
> >>> +
> >>>             /* Note, a successful atomic zap also does a remote TLB flush. */
> >>> -           if (tdp_mmu_zap_spte_atomic(kvm, &iter))
> >>> -                   goto retry;
> >>> +           tdp_mmu_zap_spte_atomic(kvm, &iter);
> >>> +
> >>
> >> Can you make this a sparate function (for example
> >> tdp_mmu_zap_collapsible_spte_atomic)?  Otherwise looks great!
> >
> > There could be a tiny downside of using a helper in that it'll hide the
> > step-up of the iterator, which might not be as obvious as keeping it in the
> > loop?
>
> That's true, my reasoning is that zapping at a higher level can only be
> done by first moving the iterator up.  Maybe
> tdp_mmu_zap_at_level_atomic() is a better Though, I can very well apply
> this patch as is.

I'd be inclined to apply the patch as-is for a couple reasons:
1. As Peter said, hiding the step up could be confusing.
2. If we want to try the in-place promotion, we'll have to dismantle
that helper again anyway or else have a bunch of duplicate code.

>
> Paolo
>
