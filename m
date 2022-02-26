Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A714C53B3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 05:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiBZE0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 23:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiBZE0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 23:26:12 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18165EB333
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:25:39 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 12so9127331oix.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRW1QJ44zEpsGk5UtujfrjSj7k2heySjFPlbGEPPKyw=;
        b=suDbmFilW3Jt+qrtziO3xmLeoOIUAU/VnRyH6jHfnk+C5d2HrUGYnmB+tW9jCzX/MP
         OR1W9aDDXIA52TBcMKmF8A1JIr/BUWDKIp5PlokXaM5G6DOvlahyDKYefjes/e4mlqSQ
         +ARdz1ovnNqSJMc3KpkY9B4cMp9puLUJtKYrSh7VotjOTC5hNmFILtZfJ6pOfBqfgzwF
         QLRplPBAy0HhODYja/1nB30WjfMDs3Z1QqsNDAtmxAtOjHg0iwSCnJimKROpSMKiXkAh
         KrYHsfkyPhm+z9S5g36gwsEVrlLtrtfHB1h4FamRxPOX+APzQf9n1gl/PYAzrKlsggbW
         42tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRW1QJ44zEpsGk5UtujfrjSj7k2heySjFPlbGEPPKyw=;
        b=zGY36Axr4OEBuYkHkXjBhl/cC0vk7X8mj8lA3qmBwM5KXKzVb4bNoZXU58csNyRbur
         eQc08Qn/Vfp4aXx2ccbGrugLdhm/KQieTTe4HgqnPnb0KPipa22BhwkR3Hl0rUcMXUrS
         2ONKqoZLtiTSV+BN2F6zWmuYy6WydFeb/dcplzmr2hNVka+g664k6X1pwkB3KlgLWYLY
         X/pfMYt8SioQK3PgTjjoFwlGzMQKbt4q7eA83cdz+a4375VUPYOk5QFrJ3A4R6MNY1U9
         EYCxnwsol360WwiJlFgw4/YIS4aEl7dQ7oKIwfBIZD3CrhfboReobyZB/tr/mNxuLmmv
         vUWA==
X-Gm-Message-State: AOAM5315PYo360BHV+ifk5BSQjyhYekzMzGHG1GcHmIhFRgcjtktBcZb
        +PhrOzxtcXy7xMKiDYtsU0n/S6Q5LNjBSvcKN/fiIA==
X-Google-Smtp-Source: ABdhPJyEt9lNaCxjgbv2hxl6Ij0KpV13H0Y4J982X2CLh2QH0Vwh5FYCedQnUqhzDSLDz0T9Mh3sHb9KKqMRTxheChk=
X-Received: by 2002:a05:6808:1443:b0:2d7:306b:2943 with SMTP id
 x3-20020a056808144300b002d7306b2943mr3916811oiv.66.1645849538082; Fri, 25 Feb
 2022 20:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20220223062412.22334-1-chenyi.qiang@intel.com>
 <CALMp9eT50LjXYSwfWENjmfg=XxT4Bx3RzOYubKty8kr_APXCEw@mail.gmail.com>
 <88eb9a9a-fbe3-8e2c-02bd-4bdfc855b67f@intel.com> <6a839b88-392d-886d-836d-ca04cf700dce@intel.com>
 <7859e03f-10fa-dbc2-ed3c-5c09e62f9016@redhat.com> <bcc83b3d-31fe-949a-6bbf-4615bb982f0c@intel.com>
In-Reply-To: <bcc83b3d-31fe-949a-6bbf-4615bb982f0c@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 25 Feb 2022 20:25:26 -0800
Message-ID: <CALMp9eT1NRudtVqPuHU8Y8LpFYWZsAB_MnE2BAbg5NY0jR823w@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: VMX: Enable Notify VM exit
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Feb 25, 2022 at 8:07 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>
> On 2/25/2022 11:13 PM, Paolo Bonzini wrote:
> > On 2/25/22 16:12, Xiaoyao Li wrote:
> >>>>>
> >>>>
> >>>> I don't like the idea of making things up without notifying userspace
> >>>> that this is fictional. How is my customer running nested VMs supposed
> >>>> to know that L2 didn't actually shutdown, but L0 killed it because the
> >>>> notify window was exceeded? If this information isn't reported to
> >>>> userspace, I have no way of getting the information to the customer.
> >>>
> >>> Then, maybe a dedicated software define VM exit for it instead of
> >>> reusing triple fault?
> >>>
> >>
> >> Second thought, we can even just return Notify VM exit to L1 to tell
> >> L2 causes Notify VM exit, even thought Notify VM exit is not exposed
> >> to L1.
> >
> > That might cause NULL pointer dereferences or other nasty occurrences.
>
> IMO, a well written VMM (in L1) should handle it correctly.
>
> L0 KVM reports no Notify VM Exit support to L1, so L1 runs without
> setting Notify VM exit. If a L2 causes notify_vm_exit with
> invalid_vm_context, L0 just reflects it to L1. In L1's view, there is no
> support of Notify VM Exit from VMX MSR capability. Following L1 handler
> is possible:
>
> a)      if (notify_vm_exit available & notify_vm_exit enabled) {
>                 handle in b)
>         } else {
>                 report unexpected vm exit reason to userspace;
>         }
>
> b)      similar handler like we implement in KVM:
>         if (!vm_context_invalid)
>                 re-enter guest;
>         else
>                 report to userspace;
>
> c)      no Notify VM Exit related code (e.g. old KVM), it's treated as
> unsupported exit reason
>
> As long as it belongs to any case above, I think L1 can handle it
> correctly. Any nasty occurrence should be caused by incorrect handler in
> L1 VMM, in my opinion.

Please test some common hypervisors (e.g. ESXi and Hyper-V).
