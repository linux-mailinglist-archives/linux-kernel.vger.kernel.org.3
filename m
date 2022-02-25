Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574DA4C4DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiBYSaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiBYS35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:29:57 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117571B0BE7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:29:24 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z15so5390729pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6BUYalwQMjirgBlHQVKIgL8ZyPGCrnEUiyDcldsxoIY=;
        b=AGCSPe65i9gvyZVes9YkqYxlSUT09c4g9QsUY+xr5UT5x3dsjKGTLV0IbeOmX4BFvw
         wOo7lX9BasDNJ6WAo3091vgmVM35mSo5SvO6BYN5tsXRzegeDzrfSUa7YCP3JFWAY43a
         bPrLC4iJLagjOl/Yt3/AhorefHUD7PTHhQCXqt4RZy3WVMF3iFbNW9LSil7PQBQQ6bqN
         nYNP58eHunpvpF/PcJ+Ivg0Hps1/5Dg/56g5nDxsh7D7U4rMW6k0j3LyCeFoIC94SLkV
         ldY+YFi91OVa8PYLiNdaWM8RG8hJD8VBQBZ9Kwv+rkNpi38TLWe8h5udlkZKh9Igyyne
         doWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6BUYalwQMjirgBlHQVKIgL8ZyPGCrnEUiyDcldsxoIY=;
        b=qMCTCuTugeDHBEJI+5fMhowojXVwskBsSuUPpzZK5I3FVuw3JN3tUUY825Gz/g+bVl
         mj73fZLDHFpyLqzRXtsQYCTI+mR1mQf8n6BF5PoljBhKZu+Mg8R+fUkJfKWBlRYsk6Kh
         ZlBm7Iii+2+EhVwxAbVQ8PrebPNVnfHvJhuL9QML0El46sxN/YgYGpzwsluOGJHqY8Ub
         Zu7TtLE1yrFXzMuiuJAmZHX1Q15Wew+79+2CijJO6/M0QJWYQFUGHBCBPLJJg+D96P05
         rdGAb/5oDfFJVn79Hg+Q3koUTpdm35/IsgE3Cwkga+PTjWjwE8+ngNkb0hDcu3yobcru
         oOZA==
X-Gm-Message-State: AOAM532dQX2wy1R6JDAhIyW9vjCEWbsB+yJfG4LOPrVruAhpWASrzcSY
        HxRQLctzqycG0SJz8Z+DAEsYWw==
X-Google-Smtp-Source: ABdhPJypmcBzZFJmNOY3PLAF8glZj7HrAMB+lj6ALtYq3OGeITCoz9OVOYTocmq3HoxZQzNj0hVejg==
X-Received: by 2002:a63:d443:0:b0:364:51b7:c398 with SMTP id i3-20020a63d443000000b0036451b7c398mr7153349pgj.511.1645813763398;
        Fri, 25 Feb 2022 10:29:23 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l13-20020a056a00140d00b004e13da93eaasm4332692pfu.62.2022.02.25.10.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:29:22 -0800 (PST)
Date:   Fri, 25 Feb 2022 18:29:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: VMX: Enable Notify VM exit
Message-ID: <Yhkf/qJ1wpfbA3Fc@google.com>
References: <20220223062412.22334-1-chenyi.qiang@intel.com>
 <CALMp9eT50LjXYSwfWENjmfg=XxT4Bx3RzOYubKty8kr_APXCEw@mail.gmail.com>
 <88eb9a9a-fbe3-8e2c-02bd-4bdfc855b67f@intel.com>
 <6a839b88-392d-886d-836d-ca04cf700dce@intel.com>
 <7859e03f-10fa-dbc2-ed3c-5c09e62f9016@redhat.com>
 <CALMp9eQHKn=ApthER084vKGiQCMdVX7ztB5iLupBPdUY59WV_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eQHKn=ApthER084vKGiQCMdVX7ztB5iLupBPdUY59WV_A@mail.gmail.com>
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

On Fri, Feb 25, 2022, Jim Mattson wrote:
> On Fri, Feb 25, 2022 at 7:13 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 2/25/22 16:12, Xiaoyao Li wrote:
> > >>>>
> > >>>
> > >>> I don't like the idea of making things up without notifying userspace
> > >>> that this is fictional. How is my customer running nested VMs supposed
> > >>> to know that L2 didn't actually shutdown, but L0 killed it because the
> > >>> notify window was exceeded? If this information isn't reported to
> > >>> userspace, I have no way of getting the information to the customer.
> > >>
> > >> Then, maybe a dedicated software define VM exit for it instead of
> > >> reusing triple fault?
> > >>
> > >
> > > Second thought, we can even just return Notify VM exit to L1 to tell L2
> > > causes Notify VM exit, even thought Notify VM exit is not exposed to L1.
> >
> > That might cause NULL pointer dereferences or other nasty occurrences.
> 
> Could we synthesize a machine check? I haven't looked in detail at the
> MCE MSRs, but surely there must be room in there for Intel to reserve
> some encodings for synthesized machine checks.

I don't think we have any choice but to synthesize SHUTDOWN until we get more
details on the exact semantics of VM_CONTEXT_INVALID.  E.g. if GUEST_EFER or any
other critical guest field is corrupted, attempting to re-enter the guest, even
to (attempt to) inject a machine check, is risking undefined behavior in the guest.
