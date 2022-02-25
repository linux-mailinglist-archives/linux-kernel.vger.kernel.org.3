Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E91E4C4E77
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiBYTQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiBYTP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:15:57 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9329821CD21
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:15:25 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id l21-20020a056830239500b005afd2a7eaa2so1440329ots.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHENS+Ovpeo1eaUhBdH1C0+VesNPCtOkEQBYOIU9JA0=;
        b=VEyJOE71f22U9Xy7lZCJfgCL//TQQSz0k5aUfPh4NzPFURCzua+2n6snOJAHMsPx1O
         WR6Wk9PleJXpJRob72UJulypveBh4fo1qE12aEpltMBREwQo5ctmt8RJLQVS4KOTFX52
         TrqpEUmzL9TFg/dNp1Xo9vKj9eYIt0gmim4oXfUmksOfvFGYN4dBBCLywaTKC0AJCNLC
         HfE8RVxC/BMlGHO/WvXPeyB7uCzbKDfNsT9GvthDUiq6pDXfW3vxMu1QWVJUURpM7bo5
         McLGIydsNONSnavoAyr5P76b9+MMaO7rT0mvvTt/8ELJvzaqxDSVseXMlQinbd8lPZUI
         PHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHENS+Ovpeo1eaUhBdH1C0+VesNPCtOkEQBYOIU9JA0=;
        b=HY8X4Xk9KJF/5u9NqEo/xlgTAMFk4K57aPqdKW5l+WQAKupGl23YXcZjFHZu2NC9X4
         MeU1TortU60jiyOqgJqGymkTc8f4rvgnpa2yYO7NNhV6LqHbEqtBcQm5KwJLOj7ccVDB
         tMQrZZ3XYaqv+M0WvmeLeLy0EyUMy+JG2SV9M0SwahJWVdtTvlPv9j31CYwMdFW8NXyA
         9fG3FdHLsgw1LAHU/aeTUPb8d7sF055YuE0QYkWpnt9ElM9J31H5N3GsFyo+47NhA4wm
         Oa9sG4cBgtC/U8KUEgAItX/zwueoxDsfl4/HeJ6lG8qhYkLs4Ajf0nVmiSwK8H3DsMwL
         z1aw==
X-Gm-Message-State: AOAM533+MLFZtxA4P7brZvex/SYXU4p/nwxp9v+D5xR8/NElwnfXfO+m
        CN7UBFUyxyMdgqbpgUgOWB1jHuTAdcRnsEBO3Pq3eA==
X-Google-Smtp-Source: ABdhPJxANXKGE/Y8oyJTKQRCNn611DCucdk0b1RMwNdrqUnynfMrMAydeff8twAuQ8raoQnl65/aYBa0Ol96UFxvjhw=
X-Received: by 2002:a9d:6e04:0:b0:5af:6426:6d39 with SMTP id
 e4-20020a9d6e04000000b005af64266d39mr3467118otr.75.1645816524707; Fri, 25 Feb
 2022 11:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20220223062412.22334-1-chenyi.qiang@intel.com>
 <CALMp9eT50LjXYSwfWENjmfg=XxT4Bx3RzOYubKty8kr_APXCEw@mail.gmail.com>
 <88eb9a9a-fbe3-8e2c-02bd-4bdfc855b67f@intel.com> <6a839b88-392d-886d-836d-ca04cf700dce@intel.com>
 <7859e03f-10fa-dbc2-ed3c-5c09e62f9016@redhat.com> <CALMp9eQHKn=ApthER084vKGiQCMdVX7ztB5iLupBPdUY59WV_A@mail.gmail.com>
 <Yhkf/qJ1wpfbA3Fc@google.com>
In-Reply-To: <Yhkf/qJ1wpfbA3Fc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 25 Feb 2022 11:15:13 -0800
Message-ID: <CALMp9eQyQkRc8goGL2eJNftKROxLcTouiEt81Qqin4fHphoN1w@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: VMX: Enable Notify VM exit
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Feb 25, 2022 at 10:29 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Feb 25, 2022, Jim Mattson wrote:
> > On Fri, Feb 25, 2022 at 7:13 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > On 2/25/22 16:12, Xiaoyao Li wrote:
> > > >>>>
> > > >>>
> > > >>> I don't like the idea of making things up without notifying userspace
> > > >>> that this is fictional. How is my customer running nested VMs supposed
> > > >>> to know that L2 didn't actually shutdown, but L0 killed it because the
> > > >>> notify window was exceeded? If this information isn't reported to
> > > >>> userspace, I have no way of getting the information to the customer.
> > > >>
> > > >> Then, maybe a dedicated software define VM exit for it instead of
> > > >> reusing triple fault?
> > > >>
> > > >
> > > > Second thought, we can even just return Notify VM exit to L1 to tell L2
> > > > causes Notify VM exit, even thought Notify VM exit is not exposed to L1.
> > >
> > > That might cause NULL pointer dereferences or other nasty occurrences.
> >
> > Could we synthesize a machine check? I haven't looked in detail at the
> > MCE MSRs, but surely there must be room in there for Intel to reserve
> > some encodings for synthesized machine checks.
>
> I don't think we have any choice but to synthesize SHUTDOWN until we get more
> details on the exact semantics of VM_CONTEXT_INVALID.  E.g. if GUEST_EFER or any
> other critical guest field is corrupted, attempting to re-enter the guest, even
> to (attempt to) inject a machine check, is risking undefined behavior in the guest.

Synthesizing shutdown is fine, as long as userspace is notified.
