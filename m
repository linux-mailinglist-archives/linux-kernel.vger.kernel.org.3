Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38063518C9B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbiECSxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbiECSxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:53:05 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D79F3F8BD
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:49:24 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2f7d19cac0bso189688127b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2RVFHg4J+XiYNHLd6mO9jBpgTMA8wJDRHLKt8HLDZag=;
        b=D8eHTcfTZf0aangD3/F507rAzlAJhrb5z3tZDy1kbX20PciK6IfBwz/4PNfuleSx0Q
         Q0xU7/YQtPzsLyeLgw1EAa1R8W73BCJmdkq5MMpFtJNdr6ZvwYyxjYSWDH3eTqNsXRMB
         tbCxbVWfMhpiKcj3/ASXTdhk5YNGZjKX6kOl5X4ZHYOs4V0Fa+ZbhGRjXdYgY/Erom7f
         kmCXngcb/dxpkWWMSzCaE7lFNfN+fVCBzvJ/rNdquW8eZvEpSpOqjnzlsDZ+HgIWJEnj
         vduTalPXsNoQB+nme19yLfsZu0p6LTEluDGahZfkayRKYiJqoVrjAQpWzOGig+3e8eto
         7PAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2RVFHg4J+XiYNHLd6mO9jBpgTMA8wJDRHLKt8HLDZag=;
        b=df3zoPwpnZzZdIRPmf58UanGEqGaN0WjHGKr6mURtYmvFlBLiR+iumeziyek/+86lT
         CWHu/BFfjsMGsH9Ml9hLf8189gU8q/g1RxFJxuraFA/OkKl5MkPw09FAjacyTc7rlueQ
         l4LMNpLsBXkaPQl1eGFzLeTyDgp+vgYu57id7yzPAe5Ak1IJKudXMdp0GXfnzNnqAojP
         OfuX1iKWvYTkuvT+Hh5/fOV5Q+UZvTwQUH1rYN6ugBNXseJtcZVm9QczCbdEByzuFoKP
         m4crIT0tPz9GY1K2DGvJcgQMEPyq2WTu5WnpjEZlvuKYTnZXKNkpDeLOri3rPCtCelLM
         6BQA==
X-Gm-Message-State: AOAM533x48d6QgjOkOYIYxNRRL+UpGmQnKfy/vjSiKUHNlXkGxNkA4+/
        tdn/l4tze5SvxzVhZH95uPOl+IpTXDv3TBamjHxqlQ==
X-Google-Smtp-Source: ABdhPJwlC5LLT8qc2EBu/75ZFoBSCD2aheEv/0F0Bxd/JtnhVZiAZdUSCNlpn7PYi6ZP9gaCJKYUVW6yxjrPsLKdXKQ=
X-Received: by 2002:a0d:dd90:0:b0:2f8:5459:486e with SMTP id
 g138-20020a0ddd90000000b002f85459486emr16835296ywe.427.1651603763187; Tue, 03
 May 2022 11:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220502233853.1233742-1-rananta@google.com> <878rri8r78.wl-maz@kernel.org>
In-Reply-To: <878rri8r78.wl-maz@kernel.org>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Tue, 3 May 2022 11:49:13 -0700
Message-ID: <CAJHc60xp=UQT_CX0zoiSjAmkS8JSe+NB5Gr+F5mmybjJAWkUtQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] KVM: arm64: Add support for hypercall services selection
To:     Marc Zyngier <maz@kernel.org>
Cc:     Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Marc,

On Tue, May 3, 2022 at 10:24 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 03 May 2022 00:38:44 +0100,
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> >
> > Hello,
> >
> > Continuing the discussion from [1], the series tries to add support
> > for the userspace to elect the hypercall services that it wishes
> > to expose to the guest, rather than the guest discovering them
> > unconditionally. The idea employed by the series was taken from
> > [1] as suggested by Marc Z.
>
> As it took some time to get there, and that there was still a bunch of
> things to address, I've taken the liberty to apply my own fixes to the
> series.
>
> Please have a look at [1], and let me know if you're OK with the
> result. If you are, I'll merge the series for 5.19.
>
> Thanks,
>
>         M.
>
Thank you for speeding up the process; appreciate it. However, the
series's selftest patches have a dependency on Oliver's
PSCI_SYSTEM_SUSPEND's selftest patches [1][2]. Can we pull them in
too?

aarch64/hypercalls.c: In function =E2=80=98guest_test_hvc=E2=80=99:
aarch64/hypercalls.c:95:30: error: storage size of =E2=80=98res=E2=80=99 is=
n=E2=80=99t known
   95 |         struct arm_smccc_res res;
      |                              ^~~
aarch64/hypercalls.c:103:17: warning: implicit declaration of function
=E2=80=98smccc_hvc=E2=80=99 [-Wimplicit-function-declaration]
  103 |                 smccc_hvc(hc_info->func_id, hc_info->arg1, 0,
0, 0, 0, 0, 0, &res);
      |                 ^~~~~~~~~

Also, just a couple of readability nits in the fixed version:

1. Patch-2/9, hypercall.c:kvm_hvc_call_default_allowed(), in the
'default' case, do you think we should probably add a small comment
that mentions we are checking for func_id in the PSCI range?
2. Patch-2/9, arm_hypercall.h, clear all the macros in this patch
itself instead of doing it in increments (unless there's some reason
that I'm missing)?

Regards,
Raghavendra

[1]: https://lore.kernel.org/all/20220409184549.1681189-10-oupton@google.co=
m/
[2]: https://lore.kernel.org/all/20220409184549.1681189-11-oupton@google.co=
m/

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git=
/log/?h=3Dkvm-arm64/hcall-selection
>
> --
> Without deviation from the norm, progress is not possible.
