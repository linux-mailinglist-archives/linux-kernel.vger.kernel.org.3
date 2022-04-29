Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D295A514DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377732AbiD2Opz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377628AbiD2Opo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:45:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5068304
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:42:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g8so4688554pfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q8Sf/GbjZKXQvTHW2LwW4qAGOz3b9F7JEp6h77YJ1Oo=;
        b=qkeV4CtdSEM5tiWHb1MIxWYVlPfLgGE7UevmkBnAbFH9057fEACF93fsFXKz4W78kT
         GolFOevTDcjA6d9cOVyV8wm7NnCDZpJ6qMGTbgJLEXqq7xa/3ulb+5ZzBKpxqGlXSq6d
         HdtRm0U0qlohOxBJOOLjb0QyzAAA1vC+e25Kdwxz+tYDp/PmNt/RK28EeG0VakCxkJJK
         tIn2Dj9i9H7HBZiiN7/80Ce64afhJkaLQ5tq338mVjJ18i/IyRjej+Bl2QfkoUPXP+lJ
         onZ+lHU0vcjwafKhTaKJtkxRFdBtVZeG362TZVEFKS87HvQrmMzWvPKqEKkT8HPhRqVV
         aosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q8Sf/GbjZKXQvTHW2LwW4qAGOz3b9F7JEp6h77YJ1Oo=;
        b=ShrW3v66T7RZFVwnQxXWu+7a0IDL7/7jeLpgpgg+x+Ge+w7Ug+LcSv22hwcd/CsTxQ
         2OrqiJjOK5wFqk/9RReNtZdvNORpp3/9zhYoFwz/XiZMM+puL0LCES2xZUuOld7Dwa0w
         O52FE2DySWeGO94p6teyPO0jCvl0vdOlN+dK7QoVX+VRjGNCtxfLJXNo0/w7TgzudyLN
         uG2gUMYnVkGTqNJetyAP4Ju0qVTxmzLJ4DZ9+Y90Pq3otjzc7s4KPsBu10mGYJYMGTBL
         pIbta/srZ+ULztA1xeKJu/Jy+dSkGrKmcziB1V4KbTa4hX39w0EZ3BXVZf6jeUF5ujeb
         m6HQ==
X-Gm-Message-State: AOAM532vm4FuLhgeia/DKJs99iTw7ToMm6OGIBUItKxFr4EXwW2QhFlK
        G3HCxGJxBb6YNcPcG0N3lofjjg==
X-Google-Smtp-Source: ABdhPJzTZJpSp9OxdNz1eGasYYqmBNDjW6EMNn24fFlY6RotVQJetGMsjQZrSR30PRSCZy5b5WZcYA==
X-Received: by 2002:a63:d758:0:b0:380:fba9:f6e5 with SMTP id w24-20020a63d758000000b00380fba9f6e5mr32765775pgi.330.1651243345281;
        Fri, 29 Apr 2022 07:42:25 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b005057336554bsm3382348pfo.128.2022.04.29.07.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 07:42:24 -0700 (PDT)
Date:   Fri, 29 Apr 2022 14:42:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Do not create SPTEs for GFNs that exceed
 host.MAXPHYADDR
Message-ID: <Ymv5TR76RNvFBQhz@google.com>
References: <20220428233416.2446833-1-seanjc@google.com>
 <337332ca-835c-087c-c99b-92c35ea8dcd3@redhat.com>
 <Ymv1I5ixX1+k8Nst@google.com>
 <20e1e7b1-ece7-e9e7-9085-999f7a916ac2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20e1e7b1-ece7-e9e7-9085-999f7a916ac2@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022, Paolo Bonzini wrote:
> On 4/29/22 16:24, Sean Christopherson wrote:
> > I don't love the divergent memslot behavior, but it's technically correct, so I
> > can't really argue.  Do we want to "officially" document the memslot behavior?
> > 
> 
> I don't know what you mean by officially document,

Something in kvm/api.rst under KVM_SET_USER_MEMORY_REGION.

> but at least I have relied on it to test KVM's MAXPHYADDR=52 cases before
> such hardware existed.  :)

Ah, that's a very good reason to support this for shadow paging.  Maybe throw
something about testing in the changelog?  Without considering the testing angle,
it looks like KVM supports max=52 for !TDP just because it can, because practically
speaking there's unlikely to be a use case for exposing that much memory to a
guest when using shadow paging.
