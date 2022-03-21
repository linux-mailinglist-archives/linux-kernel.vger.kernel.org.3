Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148CB4E30E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352821AbiCUTqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352806AbiCUTqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:46:51 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA727462E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:45:24 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id k10so5838533oia.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6hvIp8pXUul8MkAQabiAJVZoLIOX+w0hp2vYhnD0VY=;
        b=Bi05ptWWCkEbMqWa/GgMTXmQ0l8nUFiBK+PQAd2R3cK5s0ZoFzi4Zplo6KR1OEEn1l
         UgHmzcQx2Kl2uXlsbwjHYyIhClBptTsSJ+kbaoWcnB2cj4MOCHWkkDOz3KVpik7LQM5E
         D7XKw9DMh8n3pbzR1HWCj0FdsRb8egX7GPlrZyITn3EuOMc340R29fNl+oFYSe75DQEB
         MbcvbKBZ7i/lVUg8ckWvGbp8ypRCqFA41KqPzO8YwTnAypN8IN+tZVUxJLLLGDpGwdSb
         F6VOeS+QyhDGjW2CKTjkJQXih4PJGzVx7+FheHc5V42MfwM4AuxAGHj+VZWkn7o/IU8U
         XuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6hvIp8pXUul8MkAQabiAJVZoLIOX+w0hp2vYhnD0VY=;
        b=AKNB/upzqC4tfI/fo7SwD5lo8pJsH3T3bGc3QvYoIR7xTo2fDEMXU6tSYSaK0rbPTd
         UorL3LwEOYoTGjHDUEWDdC9lmN/fM1iA+E0Sr+htoySVLc+38/yGTWJbQuQ+ohC8VW90
         GbVc7HPoB1BFstqmuHA1Hu65OMnM6pPV7CB0YZUiwaPVB0Eu5a1phmqDsyQ+x21vq8mv
         He1Cerd398aGO53kW07IA+FS7o/SGq2BD3xfS9mQbOtCevcC0RwwNvGnZY3mCiU+kAzE
         FeYQgKbRh5iEbp++5ov9kDFrnPpnNLt+oQ6jj65kA7ZxkC/ay5yRFDkhjvq6gv6kpdLA
         anvA==
X-Gm-Message-State: AOAM532omKdeSN8sPr4EBKi9+h3cREsglfkvpYHxBtqEFee5GqOmSyuw
        yhABQiXNES/sVBNH69upGSv6wdEgnDC3nfUBt2duwg==
X-Google-Smtp-Source: ABdhPJxCnw6snm/lyG9Cg9XjtSD7+KuAcQaSBkeGoIOCxcBUkRCVrdPKiHTftbvO+UZOYtWavYKgw/2Lx4GI6pnWVRE=
X-Received: by 2002:a05:6808:1592:b0:2d9:fd1a:1a69 with SMTP id
 t18-20020a056808159200b002d9fd1a1a69mr409841oiw.110.1647891923912; Mon, 21
 Mar 2022 12:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220321150214.1895231-1-pgonda@google.com> <CAA03e5HEKPxfGZ57r=intg_ogTp_JPAio36QJXqviMZM_KmvEg@mail.gmail.com>
 <CAMkAt6qbauEn1jGUYLQc6QURhCHLu7eDmzJhfHZZXN9FGbQOMA@mail.gmail.com>
In-Reply-To: <CAMkAt6qbauEn1jGUYLQc6QURhCHLu7eDmzJhfHZZXN9FGbQOMA@mail.gmail.com>
From:   Marc Orr <marcorr@google.com>
Date:   Mon, 21 Mar 2022 12:45:13 -0700
Message-ID: <CAA03e5GDyM1O6aEYcpUnTY4JLBvOqQugWzpXefD9YGEkSuALVA@mail.gmail.com>
Subject: Re: [PATCH] Add KVM_EXIT_SHUTDOWN metadata for SEV-ES
To:     Peter Gonda <pgonda@google.com>
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

On Mon, Mar 21, 2022 at 11:08 AM Peter Gonda <pgonda@google.com> wrote:
>
> > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > index 75fa6dd268f0..5f9d37dd3f6f 100644
> > > --- a/arch/x86/kvm/svm/sev.c
> > > +++ b/arch/x86/kvm/svm/sev.c
> > > @@ -2735,8 +2735,13 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
> > >                 pr_info("SEV-ES guest requested termination: %#llx:%#llx\n",
> > >                         reason_set, reason_code);
> > >
> > > -               ret = -EINVAL;
> > > -               break;
> > > +               vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
> > > +               vcpu->run->shutdown.reason = KVM_SHUTDOWN_SEV_TERM;
> > > +               vcpu->run->shutdown.ndata = 2;
> > > +               vcpu->run->shutdown.data[0] = reason_set;
> > > +               vcpu->run->shutdown.data[1] = reason_code;
> > > +
> > > +               return 0;
> >
> > Maybe I'm missing something, but don't we want to keep returning an error?
> >
> > rationale: Current behavior: return -EINVAL to userpsace, but
> > userpsace cannot infer where the -EINVAL came from. After this patch:
> > We should still return -EINVAL to userspace, but now userspace can
> > parse this new info in the KVM run struct to properly terminate.
> >
>
> I removed the error return code here since an SEV guest may request a
> termination due to no fault of the host at all. This is now inline
> with any other shutdown requested by the guest. I don't have a strong
> preference here but EINVAL doesn't seem correct in all cases, do
> others have any thoughts on this?

Makes sense. Yeah, let's see if others have an opinion. Otherwise, I'm
fine either way. Now that you mention it, returning an error to
userspace when the guest triggered the self-termination, and could've
done so for reasons outside the host's control, is a little odd. But
at the same time, it's just as likely that the guest is
self-terminating due to a host-side error. So I guess it's not clear
whether returning an error here is "right" or "wrong".
