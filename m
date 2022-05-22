Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5AE53039A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 16:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347466AbiEVOrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 10:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347371AbiEVOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 10:47:20 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111E83B56B
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 07:47:20 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id l10-20020a9d7a8a000000b0060b151de434so291602otn.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qs1N4izsogFrS0OZ7oEYOqsnkQJp8brscTXYKO0KODg=;
        b=n0ri6GuuRPbaGra3hsQb2Sl6zVFxnndY7NXm+jezsIjAi4V4h/jKv9xmJpQ6I7DZQK
         ZHC18L/3KL9VZJgQ3UfNemR7n6cUs6mvd17BoYNecLqeWeUFjNKHeVSSnWB/YiUuAmgw
         EZzXPq2St3RSIT9ak9KXc22WLER/LuPj8/mD4wpKl+sHPqCFajKOTaaYZTpJo23HlQ9r
         vIyOhlHUtzqZ5aYIbnufJQVr/JrVrKAosPQSbKWl+zRzow3xjiz60kshBliNTxbaiC02
         kGLQWcLi0+eGJMPrnpoZIvQsTgg/DupstjpIz9uiHIMA9zs39gjnzw9bvrcBWJV/32Xn
         I6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qs1N4izsogFrS0OZ7oEYOqsnkQJp8brscTXYKO0KODg=;
        b=yW8PahygTHWIPtZfrqG8pFPb/4Rysh7mRadr3O6kLYnSmsNrxnRsizVzA984kd8+pc
         9n7ukrvgiz+OqPj9uIa77wBsoD48GZyAbnt5DgfOB1tcjwK6ZO/aO+7eO8ZAq8SV+jBl
         O7eXj7E4TeBD3TIVePqPlkG/uZ+MOxi1ApkXQkWjNmd/lqtu+fUX2TQkpO1gUnB3muQN
         myxwwSz9Kc3ZW5YFKTl2bzIcyoWHy3A0N5147B9PHEopuBrc9wtNp0SEjKYS1z4GOQx6
         mdkDKyG0LSgkNQIEDjq8ehkXLSJgP1guZBtOVqyZbIUN/pUf30S9p60AZeNLCVEaiRB5
         LuRA==
X-Gm-Message-State: AOAM530bbcTD5sF91TmBSloCJa24ZqWdBiurMOTVnI/62Pmj4E412ob1
        kPFGrWiokqEp0lL3/5TJnKdqnN4Ah+LMx3ZtvXHfJA==
X-Google-Smtp-Source: ABdhPJymhdAfrmIP3RTOY2pkVWLq6TJ5BXlS/aT4ewlndrVWFaHL6w8GFbXgU4aDVUAXyxz4+oecu/U8A24wK/Ylz1Q=
X-Received: by 2002:a05:6830:280e:b0:606:ae45:6110 with SMTP id
 w14-20020a056830280e00b00606ae456110mr6973637otu.14.1653230839109; Sun, 22
 May 2022 07:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220427200314.276673-1-mlevitsk@redhat.com> <20220427200314.276673-3-mlevitsk@redhat.com>
 <YoZrG3n5fgMp4LQl@google.com> <e32f6c904c92e9e9efabcc697917a232f5e88881.camel@redhat.com>
In-Reply-To: <e32f6c904c92e9e9efabcc697917a232f5e88881.camel@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Sun, 22 May 2022 07:47:07 -0700
Message-ID: <CALMp9eSVji2CPW1AjFoSbWZ_b-r3y67HyatgdqXEqSyUaD1_BQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/19] KVM: x86: inhibit APICv/AVIC when the guest
 and/or host changes apic id/base from the defaults.
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, Zhi Wang <zhi.a.wang@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
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

On Sun, May 22, 2022 at 2:03 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> On Thu, 2022-05-19 at 16:06 +0000, Sean Christopherson wrote:
> > On Wed, Apr 27, 2022, Maxim Levitsky wrote:
> > > Neither of these settings should be changed by the guest and it is
> > > a burden to support it in the acceleration code, so just inhibit
> > > it instead.
> > >
> > > Also add a boolean 'apic_id_changed' to indicate if apic id ever changed.
> > >
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > > +           return;
> > > +
> > > +   pr_warn_once("APIC ID change is unsupported by KVM");
> >
> > It's supported (modulo x2APIC shenanigans), otherwise KVM wouldn't need to disable
> > APICv.
>
> Here, as I said, it would be nice to see that warning if someone complains.
> Fact is that AVIC code was totally broken in this regard, and there are probably more,
> so it would be nice to see if anybody complains.
>
> If you insist, I'll remove this warning.

This may be fine for a hobbyist, but it's a terrible API in an
enterprise environment. To be honest, I have no way of propagating
this warning from /var/log/messages on a particular host to a
potentially impacted customer. Worse, if they're not the first
impacted customer since the last host reboot, there's no warning to
propagate. I suppose I could just tell every later customer, "Your VM
was scheduled to run on a host that previously reported, 'APIC ID
change is unsupported by KVM.' If you notice any unusual behavior,
that might be the reason for it," but that isn't going to inspire
confidence. I could schedule a drain and reboot of the host, but that
defeats the whole point of the "_once" suffix.

I know that there's a long history of doing this in KVM, but I'd like
to ask that we:
a) stop piling on
b) start fixing the existing uses

If KVM cannot emulate a perfectly valid operation, an exit to
userspace with KVM_EXIT_INTERNAL_ERROR is warranted. Perhaps for
operations that we suspect KVM might get wrong, we should have a new
userspace exit: KVM_EXIT_WARNING?

I'm not saying that you should remove the warning. I'm just asking
that it be augmented with a direct signal to userspace that KVM may no
longer be reliable.
