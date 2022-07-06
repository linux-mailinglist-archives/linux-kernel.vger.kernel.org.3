Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B218569316
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiGFULQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiGFULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:11:14 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374001ADB1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:11:14 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10be0d7476aso15873367fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgJ+Zw0oIk141D/MPC1R9iNqIoe5s4CY1XwI/TBgdAk=;
        b=JT2C2QZsY6XmZl+mIs7qQCxgvzVr5C7/e+VzHMTAXuxhpVdljIAhzvdOU+mSloBfeV
         3W2zxYwT8vRqZTRoRrqhR43ftaKEUgNOdnmad5UuJcEMjKkS2xohWCDks+i6USyKYswr
         //ZCOfKGq7o9afzwRXTDFB7PK5tXE3RBwhSPWpLj2k8wrCfkxJVa4xYVsnhknVtiEucY
         cHsJAiL1NAgvbe6G8bQwTljm81ES+TFe7vctmCzruYsMTSONgCOYwb+Jfq8B6VL2uOsL
         uU6JD30TsH8OTfb2KPEYRiLyb5B+sMi0dGqDwR58TMJFId1fSojT5PMSGartwt+I5jVD
         15SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgJ+Zw0oIk141D/MPC1R9iNqIoe5s4CY1XwI/TBgdAk=;
        b=rvqaJs6xJ7uEBho0v8PZ4sk/WiBTc0474U8ilNdzmM+FWbSzdcKHGd3Ne5brxSt0In
         9G3bNiM5NHRMvxXrBysl2jo9wHjPNSD5Fh3p+i/2F+mr5SgNNBJcmBZ52Ew8eoM/6mzF
         lmkwGiuC4v6cabMDj6me2YUYfqYd4vSFCd7EJ+VHrP4AxtkM+kOL0Net8dhncxiv00aP
         8SYifnPoZ6OQT7uzNnYLrIwA/ouRrJYPgnQXj2mIC4Su86KVnVBOQseTL8PGb+ZC0Y5l
         GUJB5GWDVMQWqcNMK/BxK4ejX5xUCR8vqrJP00dvvQTIXcu4zWWVSdbGaoMzyO2dcDzF
         BjUQ==
X-Gm-Message-State: AJIora8GC8yY5K8L6SDSonVNtU/k4JHvajSyyXJN7UKzZ9DwAYF/PZDD
        w/p/QmPKGyFu/MlLEs/x4/GtM21/ziMn67aCYU9Rjw==
X-Google-Smtp-Source: AGRyM1uwn8IMYWnu1RQ7SYBUdss69IMOdFJxoeQ7zSsr2WuGEnCKfgOHTa6sZKy2kiP4CaZi6fRmqa3XFnTJIseTNp8=
X-Received: by 2002:a05:6870:56aa:b0:10b:f4fb:8203 with SMTP id
 p42-20020a05687056aa00b0010bf4fb8203mr237427oao.181.1657138273426; Wed, 06
 Jul 2022 13:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220614204730.3359543-1-seanjc@google.com> <7e05e0befa13af05f1e5f0fd8658bc4e7bdf764f.camel@redhat.com>
 <CALMp9eSkdj=kwh=4WHPsWZ1mKr9+0VSB527D5CMEx+wpgEGjGw@mail.gmail.com>
 <cab59dcca8490cbedda3c7cf5f93e579b96a362e.camel@redhat.com>
 <CALMp9eT_C3tixwK_aZMd-0jQHBSsdrzhYvWk6ZrYkxcC8Pe=CQ@mail.gmail.com> <YsXL6qfSMHc0ENz8@google.com>
In-Reply-To: <YsXL6qfSMHc0ENz8@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 6 Jul 2022 13:11:02 -0700
Message-ID: <CALMp9eRrm7B_6MyNxuBGxm8WvgvkDcC=XrZ9dRK4pi=qQ=BuRw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] KVM: x86: Event/exception fixes and cleanups
To:     Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
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

On Wed, Jul 6, 2022 at 10:52 AM Sean Christopherson <seanjc@google.com> wrote:

> Hmm, I'm not entirely convinced that Intel doesn't interpret "internal to the
> processor" as "undocumented SMRAM fields".  But I could also be misremembering
> the SMI flows.

Start using reserved SMRAM, and you will regret it when the vendor
assigns some new bit of state to the same location.
