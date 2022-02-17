Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9764E4BAA66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245580AbiBQTya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:54:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiBQTy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:54:27 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E09F12E150
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:54:12 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2d625082ae2so44056547b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CY03vuKHIipPaIy4G74R9XCKkPzAcd7M3s3fpInivhA=;
        b=Zqu/g+7VZQJs9deYRXvrVTIVbE6RVmPdkzUvltXlnz/pz9eh/v39w8IhGUv4Cp9OYM
         OSSYDblf2WSUnxCXIj3sYpyW6W6Px7mtt0zpTdNjI91ONX3PKpSwtWRD/X9w7kixghv+
         hBJ/7gf2GQlJeU28ZtrDTtI+VFGee+BV8WL/SOkL8lrIww97jp4oJKdKT+4e+3pB+WOP
         o1MDBIvwyaDSUP7piAgCiHzZ7GQGfqft+Ze5D750C96dWtJllyKG3D7ao0uzpJ1mScze
         WoJsTVgqfCwPFqRJQy0uthHG8ywFUm9WfGEWfAB7vVDE/v7iTtwmsI3+5w5+1vBxb62h
         0sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CY03vuKHIipPaIy4G74R9XCKkPzAcd7M3s3fpInivhA=;
        b=0AT0izEyJG6DAev9UUmi9yoF00cobLGl9EG0newe2M1gTw3/JGrLwri1WNyGMm8V22
         wj6nByXpi5eeh8IpoDyCoQYAUPLzzgnQFKQ8gsP1R8Ko3tqXIh8t2teyPtr8Sl6IrVEx
         kA8ThxL/+b8R1Ouy2Ra1vN+tJCK0s06rC67syTotmUwDJBeK59Q9Pss9tZhAeoHmG+yK
         LAGISf1gTfraq61srbsrgNBc8amIP2ZJw59hStC1dFxUAOumBp5Flt8tW9jDAUywY7Au
         YVwWufrYJiREkAPg2SsOPghg/bLy5UEeQCHdrct0mivmtECwoGJy2OwhuO40PqfDl/He
         byIQ==
X-Gm-Message-State: AOAM532lqso8u7xX6Xbtf1Bi4HJAP7lG5tT4eXJfrtEQjF0GEtDDQ20P
        LMRWwekHhm5wTPbjpTJxI96ESffz/puM5lJNf+q7Cg==
X-Google-Smtp-Source: ABdhPJyT2mtE7BfLv9CuhSal0ghswn//AN1A619CSO+rB8TDmoZHs2sOAvPmEG3am2YYXgZHn1fzVIRvSUZumnflswc=
X-Received: by 2002:a81:334e:0:b0:2d0:aeef:fcd2 with SMTP id
 z75-20020a81334e000000b002d0aeeffcd2mr4216866ywz.180.1645127651380; Thu, 17
 Feb 2022 11:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20220211013032.623763-1-surenb@google.com> <YgvONKdZ2T0PB2/0@dhcp22.suse.cz>
 <YgwDa6rMHRdRTnzB@dhcp22.suse.cz> <YgwHhTN4P5yyZqBz@dhcp22.suse.cz>
 <CAJuCfpGG9zwbvfH5UZkt6cG=woeO0RGE7QxjEpXn=gFhiaDdmQ@mail.gmail.com> <YgywnF8l4Zu0aLtF@dhcp22.suse.cz>
In-Reply-To: <YgywnF8l4Zu0aLtF@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 17 Feb 2022 11:54:00 -0800
Message-ID: <CAJuCfpFOy_oRp=WWqtzE7bJR7p51FzzBPtbKhWeTGOKC-n41Cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>, legion@kernel.org,
        ran.xiaokai@zte.com.cn, sashal@kernel.org,
        Chris Hyser <chris.hyser@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Collingbourne <pcc@google.com>, caoxiaofeng@yulong.com,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 12:06 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 15-02-22 15:02:54, Suren Baghdasaryan wrote:
> > On Tue, Feb 15, 2022 at 12:05 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > One thing I was considering is to check agains ref counte overflo (a
> > > deep process chain with many vmas could grow really high. ref_count
> > > interface doesn't provide any easy way to check for overflows as far as
> > > I could see from a quick glance so I gave up there but the logic would
> > > be really straightforward. We just create a new anon_vma_name with the same
> > > content and use it when duplicating if the usage grow really
> > > (arbitrarily) high.
> >
> > I went over proposed changes. I see a couple small required fixes
> > (resetting the name to NULL seems to be missing and I think
> > dup_vma_anon_name needs some tweaking) but overall quite
> > straight-forward.
>
> OK, great that this makes sense to you. As I've said I didn't really go
> into details, not even dared to boot that to test. So it will very
> likely need some more work but I do not expect this to grow much.
>
> > I'll post a separate patch to do this refactoring.
> > The original patch is fixing the UAF issue, so I don't want to mix it
> > with refactoring. Please let me know if you see an issue with
> > separating it that way.
>
> Well, I am not sure TBH. Look at diffstats. Your fix
> 2 files changed, 63 insertions(+), 17 deletions(-)
> the refactoring which should fix this and potentially others that might
> be still lurking there (because mixing shared pointers and their internal
> objects just begs for problems) is
> 7 files changed, 63 insertions(+), 86 deletions(-)
>
> more files touched for sure but the net result is much more clear and a
> much more code removed.
> The overflow logic would make it bigger but I guess the existing scheme
> needs it as well.

Ok, I'll see how to slice it after it's complete and tested.
Thanks for the input!

>
> I would also claim that both approaches are really painful to review
> because the existing model spreads into several areas and it is not
> really clear you caught them all just by staring into the diff so both
> will be rather painful to backport to older kernels. Fortunately this
> would be only 5.17.
> --
> Michal Hocko
> SUSE Labs
