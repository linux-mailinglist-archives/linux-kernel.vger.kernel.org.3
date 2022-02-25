Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D6D4C480B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbiBYO4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242049AbiBYOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:55:46 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B0A5BE74
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:55:02 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id k2so7705349oia.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fT9I2+VK56i3wPL86YtJ9oujG8H0O8fU0cHW61eJ+nI=;
        b=ocDI0bpFAlfLlz07Ms9K+Es333B3xLcQsKts2hKdJZcyNuG3hdXqwFx9uzp6xJx/OJ
         VFtkctoftImw0HiMt6IABpjV9KFsNuRi2IMqlb/L+zOrBJB6+X4dfnGQVSt2ji7qzpVT
         twWwoDZbKmWF0Y/UJWgNgp1mIty0Vee1wKPGbg9SYDIS38MO+4e6FUC4kkiFPiRaBOO9
         A/kyypO6Xa0o9Hu7Xnqr7z7e+EEiETdYvryFdK1l/kAFrxq6cCKRERuY2NBRA/mRg8Ov
         s/X0nsQejkjtXdm0XCUKrLjZdoOc2qZfqFvW7Voj+fX2rrr9k1X4RvRWrra3Zo8c0WBd
         DtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fT9I2+VK56i3wPL86YtJ9oujG8H0O8fU0cHW61eJ+nI=;
        b=eoQ0eZ/ZYjCXt7Fdtv+rQfjhpZ/k2hcl3yFg8QjZMxdsTbbvDZN9JKjl7bjJggeAUv
         46qsv9WHF3wBsW9avWuvSlzXbp/4iqlJgKmUlkjvi4pq40ZHxXHo7l4VaMZjW8WhZZgp
         TKTYzQJDt+K919MiszMiZIlTLQMamDJtcduC3ja7byqRD09jqatNDYhIEN+Zx1wuj5Uq
         wVu5H978zScumUoNydOf4sZOJGT49hY8s2x3v5EOcnsVlFrMHg7gK1++GeCN9FiGQ2Ov
         csT/wkWsNF/kOhBbBmuybS90lLb7dzOXb2FTeJuniHJxQrUgkK4TB7RyPS+slMkfooOW
         GzMQ==
X-Gm-Message-State: AOAM533dShnKWhmbsgt4H9rsIRTRxRRW+xzie6l6EaO3HfhBHvqIFDmO
        wEutm8LG5nZ6d2+FBSOeP4RVdxrJWQv1tGPyHHjVTA==
X-Google-Smtp-Source: ABdhPJyM/iJYLsnWoSrKflbZP2N/fNnclFQmE8TzasWzLZmG6Q5uy9uh18fJ4PKpZNI4faItAjnGa6ceCrKGO94B7ug=
X-Received: by 2002:a05:6808:23d0:b0:2d6:bca2:c70 with SMTP id
 bq16-20020a05680823d000b002d6bca20c70mr1755978oib.339.1645800901850; Fri, 25
 Feb 2022 06:55:01 -0800 (PST)
MIME-Version: 1.0
References: <20220223062412.22334-1-chenyi.qiang@intel.com>
In-Reply-To: <20220223062412.22334-1-chenyi.qiang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 25 Feb 2022 06:54:50 -0800
Message-ID: <CALMp9eT50LjXYSwfWENjmfg=XxT4Bx3RzOYubKty8kr_APXCEw@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: VMX: Enable Notify VM exit
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, Tao Xu <tao3.xu@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Feb 22, 2022 at 10:19 PM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
>
> From: Tao Xu <tao3.xu@intel.com>
>
> There are cases that malicious virtual machines can cause CPU stuck (due
> to event windows don't open up), e.g., infinite loop in microcode when
> nested #AC (CVE-2015-5307). No event window means no event (NMI, SMI and
> IRQ) can be delivered. It leads the CPU to be unavailable to host or
> other VMs.
>
> VMM can enable notify VM exit that a VM exit generated if no event
> window occurs in VM non-root mode for a specified amount of time (notify
> window).
>
> Feature enabling:
> - The new vmcs field SECONDARY_EXEC_NOTIFY_VM_EXITING is introduced to
>   enable this feature. VMM can set NOTIFY_WINDOW vmcs field to adjust
>   the expected notify window.
> - Expose a module param to configure notify window by admin, which is in
>   unit of crystal clock.
>   - if notify_window < 0, feature disabled;
>   - if notify_window >= 0, feature enabled;
> - There's a possibility, however small, that a notify VM exit happens
>   with VM_CONTEXT_INVALID set in exit qualification. In this case, the
>   vcpu can no longer run. To avoid killing a well-behaved guest, set
>   notify window as -1 to disable this feature by default.
> - It's safe to even set notify window to zero since an internal
>   hardware threshold is added to vmcs.notifiy_window.

What causes a VM_CONTEXT_INVALID VM-exit? How small is this possibility?

> Nested handling
> - Nested notify VM exits are not supported yet. Keep the same notify
>   window control in vmcs02 as vmcs01, so that L1 can't escape the
>   restriction of notify VM exits through launching L2 VM.
> - When L2 VM is context invalid, synthesize a nested
>   EXIT_REASON_TRIPLE_FAULT to L1 so that L1 won't be killed due to L2's
>   VM_CONTEXT_INVALID happens.

I don't like the idea of making things up without notifying userspace
that this is fictional. How is my customer running nested VMs supposed
to know that L2 didn't actually shutdown, but L0 killed it because the
notify window was exceeded? If this information isn't reported to
userspace, I have no way of getting the information to the customer.
