Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5754C1E64
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243425AbiBWWXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243412AbiBWWXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:23:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB34A3BFBA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:23:22 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id x15so157489wrg.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fy0MJJJI2gB4ymq6roYJN6kjAzccxttzL2stNrD8v6Y=;
        b=q+siJwh1ClLPC329FhiZBRM/m1SdJmWASDiwDzeM2hdV49NiAohHJV382Bkumyw60k
         9Bk/UJzwAlELq6ogiBk5CRY+u0dekRGvG4jSQTAGdlW0AcV1L4ozPVTc46T/gDvBH0GS
         Fh5hPswPyIBfNE4o7n6k2g+Ewo8cD2q1hjp9bC+lBjcycuqvXCUmNk0GLPSSBnGIa9YN
         XxD2JTpuz2aewJJOOzZCMelJLkAnrmoMFpKtwXv1pwHel3Z1uwyQmOcC4C267uPl7vIT
         nXRXRj6DUo1NlyXEpmlu+U+DelDNvF/yZNefMQGOp+25cE79/lCldftG82ueqaAsIqix
         11/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fy0MJJJI2gB4ymq6roYJN6kjAzccxttzL2stNrD8v6Y=;
        b=sIfh+CnKQILzrXPuF7V9YVEOYU9r/r/WqVNJ5wSDEhGKNT0rxF6DvUUAL+Iqmwinoh
         XkrKmktDJ/fQ9VwKpxUN2QmsxoIJn+wlqi1qjMIiWLQFm359MuwN6xGq/Gw/EHhtoFfm
         037ONDj270c/81EcB4J4hsnqcxPpr48YPMNP0jzlz84LuTQd0jnunevFB9xgLUsnavSW
         1MbDfzrY4gyTR/BVXh1X5LrmtYmOQl8Y7nh/HgWBe5Nu8FQCS7arsNK/ifWmxF1gI7Cb
         jbgEjT5uip7ga4kxw6Hb5vHn49GmPelSSZJHI5VDy/Rt4RrOeBjc/2AyuA7S5KeyicDM
         ujVA==
X-Gm-Message-State: AOAM531cdkgDpQl67JvLmia4eEBkINufDB7sI61E96CX7O4y8maX5JY2
        AoZ6uJn68xvd7eNQpKFanV+AuZRBtvv6IloggfoNYQ==
X-Google-Smtp-Source: ABdhPJweT+T0f+0zMs40/eYau4mlgt5Tzm7+i1OsSNV+ijoy0wYETR7YVYWprmL26EgW870OfgvbQCsGvPlnuOb9Jjo=
X-Received: by 2002:a05:6000:1e0b:b0:1ea:99dd:db35 with SMTP id
 bj11-20020a0560001e0b00b001ea99dddb35mr1188067wrb.384.1645655001209; Wed, 23
 Feb 2022 14:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20220223162355.3174907-1-seanjc@google.com>
In-Reply-To: <20220223162355.3174907-1-seanjc@google.com>
From:   David Dunn <daviddunn@google.com>
Date:   Wed, 23 Feb 2022 14:23:10 -0800
Message-ID: <CABOYuvbO3ugf7RrgfsBJEP1m6RujNN0B_jmAU1UJ3k13E5tdkw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Fix pointer mistmatch warning when patching
 RET0 static calls
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
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

Reviewed-by: David Dunn <daviddunn@google.com>

On Wed, Feb 23, 2022 at 8:24 AM Sean Christopherson <seanjc@google.com> wrote:

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 713e08f62385..f285ddb8b66b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1547,8 +1547,8 @@ static inline void kvm_ops_static_call_update(void)
>         WARN_ON(!kvm_x86_ops.func); __KVM_X86_OP(func)
>  #define KVM_X86_OP_OPTIONAL __KVM_X86_OP
>  #define KVM_X86_OP_OPTIONAL_RET0(func) \
> -       static_call_update(kvm_x86_##func, kvm_x86_ops.func ? : \
> -                          (void *) __static_call_return0);
> +       static_call_update(kvm_x86_##func, (void *)kvm_x86_ops.func ? : \
> +                                          (void *)__static_call_return0);
>  #include <asm/kvm-x86-ops.h>
>  #undef __KVM_X86_OP
>  }
