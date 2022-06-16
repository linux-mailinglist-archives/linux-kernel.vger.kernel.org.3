Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC1654E827
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiFPQy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiFPQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:54:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407C231219
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:54:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i64so1998269pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LzIoat5tvoKjMobcVCYTGuH3jDJmFEBiWBVDBiUd/KE=;
        b=TxgPoU9m7P7k73wmYXXSCSdzcii7y55/TkyYtk6K4DsJ4veirk3cBcbsSqwTO0+v1o
         QA0Qp5+ib36PACt6hsJOCjIaysP7AYNZ8C96Ao+BmimEhXZkqjcD4qHnvbZGvBT3oyMt
         /HrkKamnOrY7GvnirR/1Ia4UYTPLSTQbMA9aR+dO5wvD8+q4yokjLr2Ur+4WeAO9XQGO
         z/iGZcfn3qrJyCwvpCgaQGJAqR07BXMxFLp9AiNRxneqxlMZj9hZAbftUpL6AN9/xNl2
         PqT19PHDDJk3LLPHl8vQx83s/gqtzXzsFO3fUSkx4QRpn1a+x2f1pb1INz3i2d5wmEYG
         zFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LzIoat5tvoKjMobcVCYTGuH3jDJmFEBiWBVDBiUd/KE=;
        b=PDLMn7led/57hCmaw8Y/KaxLYeX43t7NZFKWOmdz/0MLB1jPrBVM2kkUfVKVehpnt8
         HDvE81wGqyBgTSOMsOymhpG1BeCH2DHypfgxnFv8fS0wPKASt7bAazIEIKEMX57YIZkJ
         kHZOo0VYjmV1u9oUU5wXYzEtFvOK1B6QphyTU96MZWbL12kzv+SaUlXRcvMX22EaEmsv
         OHu7BNOfF2yhOY/awhvxFs0mXCT17Wi7sNIf5gbdJqSKHaG6DiFTJL1CuwTQnjBlJzKO
         3ZWzqsCEM5ytfjoJdgvMM/4BSC/Si42BJjk8NWjboAxE2j44DtWB3TZgoDAKFFri6RPb
         JFng==
X-Gm-Message-State: AJIora9BXc8TJ4PUs8yB2b+nZEqqManXWWyr+bAfE1JQFY9FWxDa9df7
        mt7PoePrxOSGP8q4ATMygS15kA==
X-Google-Smtp-Source: AGRyM1uIJP8T9rXgj65zBh450gEVVD6ZZE5nhMnpm6cridY6D6NO8phz3Hg1WSl8XfZ0LT2CfyM8Bg==
X-Received: by 2002:a05:6a00:228d:b0:524:cb23:2fb2 with SMTP id f13-20020a056a00228d00b00524cb232fb2mr2823851pfe.42.1655398493537;
        Thu, 16 Jun 2022 09:54:53 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090a660400b001e8d377c648sm1813816pjj.11.2022.06.16.09.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:54:52 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:54:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] KVM: Avoid pfn_to_page() and vice versa when
 releasing pages
Message-ID: <YqtgWesFK9Hkm9h9@google.com>
References: <20220429010416.2788472-1-seanjc@google.com>
 <20220429010416.2788472-5-seanjc@google.com>
 <e793f8f4-69dd-1824-7bb1-048428d977f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e793f8f4-69dd-1824-7bb1-048428d977f4@redhat.com>
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

On Thu, Jun 16, 2022, Paolo Bonzini wrote:
> On 4/29/22 03:04, Sean Christopherson wrote:
> > -
> > +/*
> > + * Note, checking for an error/noslot pfn is the caller's responsibility when
> > + * directly marking a page dirty/accessed.  Unlike the "release" helpers, the
> > + * "set" helpers are not to be unused when the pfn might point at garbage.
> > + */
> 
> s/unused/unused/

LOL, s/unused/used?  :-)

> But while at it, I'd rather add a WARN_ON(is_error_noslot_pfn(pfn)).

I've no objection to that.  IIRC, I almost added it myself, but my mental coin
flip came up wrong.
