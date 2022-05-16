Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4468529387
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349656AbiEPWWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiEPWWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:22:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ADE1A39E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:22:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c24so18747681lfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03UU3dtb/aAVI5OTh+Y/mwCGeJsGO4jPPM5PKj+jLd0=;
        b=rb8Bqc1IyRn8dSyx6QQ9Osrf/hemhX6w8rbznkJTIRfCLQ2uh8G4YEHlHYc0JO8W32
         +WwfRWVHjgmxz0RzD8E1l5Fd7ZTjIZb91osaefyGs8L8B5+ZlW0tE6X2H3RKnGW+zifk
         Ji5Yv2gf07NHQPltz0+JhWdd8c25LWuR7avEuGHZEiL8DnOPaVGbKkpEWr5NVs/ZNIJ/
         hJ6qi2TZvAxReUe2f9e+kk0uNubUswgxa0p5M93KTIBMZXB/ca9JTOqakFt5ob57Wz12
         HboGS2/hxnTS3eq8D9O7ZEqlKhPalwZjpIraQ6Tesy7Fvfpzhim83cE1EkpQP+clSyJd
         6KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03UU3dtb/aAVI5OTh+Y/mwCGeJsGO4jPPM5PKj+jLd0=;
        b=byME8o6dL8SFdC5mzyq0moy8fZXGZjQOjMHVO0JoLK3Pw/tI8+R9WLZqD6aAy5Iyku
         nkxtH1NZXVeR+ZXACReVcNqHJTCLwdRpvfYaXmcLY+Rm9jCxouRANcBgrSnoUTmjPTwX
         PjDOn3aO0hozhu5SRzA9/5EdU1DrSZGv3NfsE03Y/OPPEpt2CZxKFiOdPX/GwMJfePYs
         YjJ0sdkHik1DZNE+UhmUVFBYMJkIZM8veA5zDxu1T8HZz41Oa3jlGPq7Lpg1UTQsS3Fb
         ayaH6oAMcwGPDWxV+z8KKmeLwJYN0i+8iZw6iRjkfYbfRmP9AV0U6dgYWpCrV3CB24eg
         eFJw==
X-Gm-Message-State: AOAM532krsljKTIZfBqmO7BYITp6HQI/7WSdHZ1ueMyViefzsls81X+x
        rsexXMZ/LDRXA8lO6OQnQCmwkN0FGlaS/pj1kk6A6w==
X-Google-Smtp-Source: ABdhPJwgTI2LCnjKiQvn9b5D7N8cz+mbDNNin18TMKvQB5KG8qkyrbOlBbZDDiPqsqsrxw49lfppc6PCZ004srPb7fI=
X-Received: by 2002:a19:8c1a:0:b0:472:315:48db with SMTP id
 o26-20020a198c1a000000b00472031548dbmr14366639lfd.235.1652739762737; Mon, 16
 May 2022 15:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220513195000.99371-1-seanjc@google.com> <20220513195000.99371-2-seanjc@google.com>
 <CALzav=d36gccJv345Phdr0AJx9=6=TP=iZ60dscgQr64Rq4Kew@mail.gmail.com> <Yn7+HrYbXhror09V@google.com>
In-Reply-To: <Yn7+HrYbXhror09V@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 16 May 2022 15:22:16 -0700
Message-ID: <CALzav=eogd=sNaPOSW3_9hLSZ6pXe5eakHLr5vm8bUiwQrmA6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Drop RWX=0 SPTEs during ept_sync_page()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>
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

On Fri, May 13, 2022 at 5:56 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, May 13, 2022, David Matlack wrote:
> > On Fri, May 13, 2022 at 12:50 PM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > Drop SPTEs whose new protections will yield a RWX=0 SPTE, i.e. a SPTE
> > > that is marked shadow-present but is not-present in the page tables.  If
> > > EPT with execute-only support is in use by L1, KVM can create a RWX=0
> > > SPTE can be created for an EPTE if the upper level combined permissions
> > > are R (or RW) and the leaf EPTE is changed from R (or RW) to X.
> >
> > For some reason I found this sentence hard to read.
>
> Heh, probably because "KVM can create a RWX=0 SPTE can be created" is nonsensical.
> I botched a late edit to the changelog...
>
> > What about this:
> >
> >   When shadowing EPT and NX HugePages is enabled, if the guest changes
>
> This doesn' thave anything to do with NX HugePages, it's an execute-only specific
> bug where L1 can create a gPTE that is !READABLE but is considered PRESENT because
> it is EXECUTABLE.  If the upper level protections are R or RW, the resulting
> protections for the entire translation are RWX=0.  All of sync_page()'s existing
> checks filter out only !PRESENT gPTE, because without execute-only, all upper
> levels are guaranteed to be at least READABLE.

I see what you mean, thanks.

And I also recall now you mentioned (off-list) that the NX HugePage
scenario isn't possible because KVM does not let huge pages go unsync.
