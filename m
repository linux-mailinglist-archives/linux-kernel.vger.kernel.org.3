Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6335696A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiGFXzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiGFXzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:55:48 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750B42D1DB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:55:47 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r82so21707129oig.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjN6GpQY4nWOSdliTg5TstOsjxKtEZmHyJPBA3SGai4=;
        b=NWmAlvx+hIMXHWO+G9Z63Eb98yhqT+8AjKLRP1akM1C/W4XpF/H/VknMGxd8Nfsdgk
         XD96M4+0V53EXEOW5Q05c/i0wA05OAnLl+3xhSK8IbfCfn06UCDJcqEHJee6r1N3FPYE
         2+1DT5CQWeMW0/3YDxqmsKfR+2PAZhw7vX2KbYDTj5JKrbDrJ3SmqltaHgEuZBBFV5Pj
         tVkzQe9TPw+SkvcMqMssC3Y5DbldxfUrHYQPtj+NB1QQnlE4tkH8qPz881PauWsSExbZ
         yL4cyXjzMqW9bYA56uFsgLNTWoArD/jIQdvBelaYoLMkmCy7v3AvK5ueEdYsm4tSXnDb
         BYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjN6GpQY4nWOSdliTg5TstOsjxKtEZmHyJPBA3SGai4=;
        b=I1LLm+xFpbgj6dlbVRSyat/zDD/AcZWMwEvP2MYKG5weVoRT9PAQIXVGU9Fb9bgDoi
         4Bb84GUaD72qNn88ZqiUIZJJMKaLSDlHBK9269w/p0dMRyYD4sCs5d3RdULRN8TSKNt/
         gA4Ahl3FyrJ5hFEayMdnFrVB8LwORmTEFxn+wKFn/N8VsReE8wowhot6XhiJB4QXyvPF
         7MKyndjHYwJIw55lHTrKwUxPNtmcP1AMF5h8/frXpULyGV+mefZC6JlJ+V5FLFB472t5
         /KhrZqFhjpWNcDY2UzI9wVumzVi77ugFOnv4Vf0kS+W6vqsLcZ8IlaS4d3kUTP+alQwb
         DGNg==
X-Gm-Message-State: AJIora9TRmVau8wvI/mAUiTaa/BXWoduPa4+U5MtYkJ3KJJgTPP2TicB
        z9G7ctUf5ZGSzGTm3xAL+i7RSslC8dEfkKXJr6jTOA==
X-Google-Smtp-Source: AGRyM1u1kGENXV8nStUwrLsg/+fpiYNkh/Rih6iP+xvK5LogBHBd5af9qz8EFu3/WH8UuDYzPZFMJYK0qi2XV/mUXy0=
X-Received: by 2002:aca:5e05:0:b0:337:bd43:860b with SMTP id
 s5-20020aca5e05000000b00337bd43860bmr719740oib.181.1657151746538; Wed, 06 Jul
 2022 16:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220614204730.3359543-1-seanjc@google.com> <20220614204730.3359543-7-seanjc@google.com>
In-Reply-To: <20220614204730.3359543-7-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 6 Jul 2022 16:55:35 -0700
Message-ID: <CALMp9eS+54W=w=0UXRvB95OprNbpte=_TDu=c9qzcY0kyRqbuQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/21] KVM: x86: Treat #DBs from the emulator as
 fault-like (code and DR7.GD=1)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 1:47 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Add a dedicated "exception type" for #DBs, as #DBs can be fault-like or
> trap-like depending the sub-type of #DB, and effectively defer the
> decision of what to do with the #DB to the caller.
>
> For the emulator's two calls to exception_type(), treat the #DB as
> fault-like, as the emulator handles only code breakpoint and general
> detect #DBs, both of which are fault-like.

Does this mean that data and I/O breakpoint traps are just dropped?
Are there KVM errata for those misbehaviors?
What about single-stepping? Is that handled outwith the emulator?
