Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E8B4C4D51
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiBYSHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiBYSHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:07:33 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5D11E6EA7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:07:00 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id x6-20020a4a4106000000b003193022319cso7332581ooa.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NN5kUdin7citIfmsQk9dU1OmhSvd2Lzcs2UPLOuI96I=;
        b=mZgUDHNQER4VN5jp1nQ+UOooKupVC14mE+ybXlq0GFuOTKAKgCScsKJvcQGhwYht6g
         ADtrQysZaUbKJJ19rzSH/wl68dYebZWMjQTOFut1JcRerkMYl2ihS4ByNHAaHjex7h4v
         +IhzLX/hd9wmJHdvKqey5LNtKgCQoF4vaz6XAk7nhicCmbXxzgZ2ZbbLl8MG59+1pfVs
         6gpsx9/RUKSpG+C5CCV9SXXLkZhsXy1EgDOSuy8QxQNoHl0v9hoL0oaoJdlEQCzTYmhy
         LUw0C5WFNUJDoSMnPZ74J9aVuDcw8GwlubVOHrsohk+dOgGnfsDvQdyFWdNvzCbUbPX8
         Ce2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NN5kUdin7citIfmsQk9dU1OmhSvd2Lzcs2UPLOuI96I=;
        b=R6F3TAOATynHkDnWmGXOpfxLORoDvY2ndl+/VczTaY3nT+Oki8A5hmb5f3ByFOWIVq
         V8bOrsCoRjabyBxsRi/P957nvIMvwq1Gp8voFAMvuuH7iWgDQik81hQkMJAtt6Q+mdSO
         rtdqiel2bGCfcgmeuxcq16//ckQbLpqhDG5YJyZvHBz2KxodTaRjuJB1YpCPS9O8fQ4Q
         lsR1zt1T4FCpZSqgncUoIKdgPdxc1f9aFxDkCujN0x/AI26h9CaYPOwopT9SsQuxtG9D
         P9EFpVjUIwaZlOY2xOJeVgYHsoKqC8D1hlM0WGIOWJQrhlqbY0JYgnxH9ePCvot5ePSl
         YJ1Q==
X-Gm-Message-State: AOAM530eD7U7JBwxMgER4r36ADi0nsJXR7M3ufZY11oRRnS1AmAcPhUQ
        49naAs6aImH2Cdni+XEoD82gwcbiAig8r0Zc2JWtOw==
X-Google-Smtp-Source: ABdhPJwpr/Ifbo68q2+J4j/DBvPxK7bgpP1DW9yuyBh1wSi+UvI2AhGyYgCTxCmjYyEQl3QZtsML4iCA3H8W1zG2M3M=
X-Received: by 2002:a05:6870:6490:b0:d6:d161:6dbb with SMTP id
 cz16-20020a056870649000b000d6d1616dbbmr1808297oab.129.1645812419250; Fri, 25
 Feb 2022 10:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20220223062412.22334-1-chenyi.qiang@intel.com>
 <CALMp9eT50LjXYSwfWENjmfg=XxT4Bx3RzOYubKty8kr_APXCEw@mail.gmail.com>
 <88eb9a9a-fbe3-8e2c-02bd-4bdfc855b67f@intel.com> <6a839b88-392d-886d-836d-ca04cf700dce@intel.com>
 <7859e03f-10fa-dbc2-ed3c-5c09e62f9016@redhat.com>
In-Reply-To: <7859e03f-10fa-dbc2-ed3c-5c09e62f9016@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 25 Feb 2022 10:06:48 -0800
Message-ID: <CALMp9eQHKn=ApthER084vKGiQCMdVX7ztB5iLupBPdUY59WV_A@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: VMX: Enable Notify VM exit
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 7:13 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 2/25/22 16:12, Xiaoyao Li wrote:
> >>>>
> >>>
> >>> I don't like the idea of making things up without notifying userspace
> >>> that this is fictional. How is my customer running nested VMs supposed
> >>> to know that L2 didn't actually shutdown, but L0 killed it because the
> >>> notify window was exceeded? If this information isn't reported to
> >>> userspace, I have no way of getting the information to the customer.
> >>
> >> Then, maybe a dedicated software define VM exit for it instead of
> >> reusing triple fault?
> >>
> >
> > Second thought, we can even just return Notify VM exit to L1 to tell L2
> > causes Notify VM exit, even thought Notify VM exit is not exposed to L1.
>
> That might cause NULL pointer dereferences or other nasty occurrences.

Could we synthesize a machine check? I haven't looked in detail at the
MCE MSRs, but surely there must be room in there for Intel to reserve
some encodings for synthesized machine checks.
