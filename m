Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F7F4E77EB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376680AbiCYPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377352AbiCYPdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:33:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A952D1E8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:29:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h7so14001413lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPocrmqkuGYHnUVRsDZ/TbHe19zETFDOn27Vxny6QCI=;
        b=NoKTAx+GgAdqOfHToR+2NJ4UdtSN0mm4Tiu7cxkqcQZtXSOtizFo+YQNtguTvNiTmP
         9APy8PjqvWRslGk9feJMbBLaUCDojNH9pMCZI57GUJ//r4APse05WQqFon6BG8iThpUo
         g8Ci2br9eGFDcFOLMRmzAyw/hWsqw7ecyDZXnilV1Ko9h1OtIZhgMZPZRRMEFRYwiWFr
         8r2KQXyeDlTh6eqiVYp9AZpgjZB5Fnjs3hYtMrokYSLBaYCVoJiE00zqnakqCQ5N7zXi
         oG1I/OCrDfwt8EoRs99vAdJU+hjtm59SrJNSZ4uHdN5AVtdOUrVIvE5UCittHYJeQF0s
         NhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPocrmqkuGYHnUVRsDZ/TbHe19zETFDOn27Vxny6QCI=;
        b=PASzDOI3Tc6FKYR8T9J5jj1+rp6koRIRaKnGK9+nJjFLB/Jlg5yR2ahedD18y7Vtud
         vEX9UFWmxsJQrbns03DRnesNMk2K7R4BLU7uOSK+dmc8p5Re1Nf7z2fBZnAnQvb0A1HQ
         SLV75hPNtQqS3nrYInOp6nq6UK8wZrmJPvc4Pn8G/hpFZ+ZSANrAyzOGqG8Y3d6xnUy7
         52LI5Qgw5XkbAfkf4IKsE2Cuc4TNu+4+CmOUtWD+PxQTs/ax2ftINu1ZcgE//xgR0pbi
         hskoN7BxhWFcyn2JWNcA/V9ZGgYXR9QOLy86tsaWYz1LaGQPRF8SRnNik9Do9kkzuxPJ
         ERmA==
X-Gm-Message-State: AOAM5333tsXinyA7ne8lJjyLtIa/iGiZ+PxNgMok88J8xjn6LpyD6FEJ
        mj87nYDu59OYXYarLH6GZcGkLhV38BwB/LoHgDOZdQ==
X-Google-Smtp-Source: ABdhPJwajANP/u7dvP2rPWqqB9wMD9F7TC7XMC4AiQxoD4/abx/UvRQZWo382ah99ciAEHJzTMSSX94FSkDjdVNzRRU=
X-Received: by 2002:a05:6512:15a3:b0:44a:54eb:937e with SMTP id
 bp35-20020a05651215a300b0044a54eb937emr8040694lfb.456.1648222138745; Fri, 25
 Mar 2022 08:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220321150214.1895231-1-pgonda@google.com> <CAA03e5HEKPxfGZ57r=intg_ogTp_JPAio36QJXqviMZM_KmvEg@mail.gmail.com>
 <CAMkAt6qbauEn1jGUYLQc6QURhCHLu7eDmzJhfHZZXN9FGbQOMA@mail.gmail.com> <CAA03e5GDyM1O6aEYcpUnTY4JLBvOqQugWzpXefD9YGEkSuALVA@mail.gmail.com>
In-Reply-To: <CAA03e5GDyM1O6aEYcpUnTY4JLBvOqQugWzpXefD9YGEkSuALVA@mail.gmail.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 25 Mar 2022 09:28:47 -0600
Message-ID: <CAMkAt6qB8GXhu0h+k1pbP_KkhvW+Edk-=zyo3zo2WdOe_qq8PA@mail.gmail.com>
Subject: Re: [PATCH] Add KVM_EXIT_SHUTDOWN metadata for SEV-ES
To:     Marc Orr <marcorr@google.com>
Cc:     kvm list <kvm@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Mar 21, 2022 at 1:45 PM Marc Orr <marcorr@google.com> wrote:
>
> On Mon, Mar 21, 2022 at 11:08 AM Peter Gonda <pgonda@google.com> wrote:
> >
> > > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > > index 75fa6dd268f0..5f9d37dd3f6f 100644
> > > > --- a/arch/x86/kvm/svm/sev.c
> > > > +++ b/arch/x86/kvm/svm/sev.c
> > > > @@ -2735,8 +2735,13 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
> > > >                 pr_info("SEV-ES guest requested termination: %#llx:%#llx\n",
> > > >                         reason_set, reason_code);
> > > >
> > > > -               ret = -EINVAL;
> > > > -               break;
> > > > +               vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
> > > > +               vcpu->run->shutdown.reason = KVM_SHUTDOWN_SEV_TERM;
> > > > +               vcpu->run->shutdown.ndata = 2;
> > > > +               vcpu->run->shutdown.data[0] = reason_set;
> > > > +               vcpu->run->shutdown.data[1] = reason_code;
> > > > +
> > > > +               return 0;
> > >
> > > Maybe I'm missing something, but don't we want to keep returning an error?
> > >
> > > rationale: Current behavior: return -EINVAL to userpsace, but
> > > userpsace cannot infer where the -EINVAL came from. After this patch:
> > > We should still return -EINVAL to userspace, but now userspace can
> > > parse this new info in the KVM run struct to properly terminate.
> > >
> >
> > I removed the error return code here since an SEV guest may request a
> > termination due to no fault of the host at all. This is now inline
> > with any other shutdown requested by the guest. I don't have a strong
> > preference here but EINVAL doesn't seem correct in all cases, do
> > others have any thoughts on this?
>
> Makes sense. Yeah, let's see if others have an opinion. Otherwise, I'm
> fine either way. Now that you mention it, returning an error to
> userspace when the guest triggered the self-termination, and could've
> done so for reasons outside the host's control, is a little odd. But
> at the same time, it's just as likely that the guest is
> self-terminating due to a host-side error. So I guess it's not clear
> whether returning an error here is "right" or "wrong".

Since no one has expressed a strong opinion have have left this part
of the patch unchanged in the V2. Happy to revise again if people
prefer something else.
