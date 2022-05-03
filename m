Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BFD5181DF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiECKDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiECKDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:03:44 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6EA1DC
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:00:11 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e93bbb54f9so16681849fac.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6VmgZgbj9KAuI/YkBuK9i9uLFuu8Ee6aM08pw3KfSA=;
        b=TPyaTRJsj5bYrYQA551NtRkGLgJ6IViBsfnkV/igMEtxtWKpuwgHR0geNoV8fiwyZ6
         GXS2SDRwITFcf3ApeWyXen0Bg5GwZSirSvwtBE51eSRvT+apQL3jSkgbybPsb95LdOCY
         YlavU+X9YACl53qeYW6JDe3EsK3mLgfrLoZv8tmCOpvozOE9/xCNlpMH4BYn8BAnCZHR
         BZXvQy2U+AMS4vtpP3ynsb7g2LNQ+ClpjhCL+z4Ak0bE+0zn5AZOulJEcHd4YYpQ28K9
         25djKykytyBg5t3UAnDlvgV1CHCdMncGDndNEJGT0eU6U0KEucVx9kOySWV38tS1BK/f
         WeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6VmgZgbj9KAuI/YkBuK9i9uLFuu8Ee6aM08pw3KfSA=;
        b=ShUxifT+kzG9GCPsQnYqlfgKQmzntcDhACFzX0UDPoB8LnOxqqaN/WhGZbTXMdyaex
         UFHulvRKbeiw3VVQiiiPFKxNa6jiVcM852keSZK+AirZc6VdF19tGzFmt8tMK7ciAsXA
         bXFYPFDuBSg5/aXkfXk1AbsBp0puT1WFiLVcHEzGPYbh8NDr8VO9ekoSjggUd2YhCeu1
         MW1qFXu54rMQgXoa2FgA62TckwXBJvmFlnrE/UuZ50njVphinjZBcmC4evrgqma5ZF3O
         mLMmC97hKVw9qVndtTlio6A1KjgAkNG1dZhMleOxLnuI2QwpxF3U7C+vWraccel/fOgT
         TywQ==
X-Gm-Message-State: AOAM5320GtNz6GGTOHxdIYZDLnsiVL5hkyabCM5oDCVjxeNPurmtVT1T
        Ixpw0TzSDk+U/OYDWwxwNz0moKKg0OFLjSdKr/v3lg==
X-Google-Smtp-Source: ABdhPJwLxBYAs66rQRuoxspW2AW7l0Rwad4MVCd59NJBFjU3fDtR69VxutXMYb8Qr4bobex6FWU5i9oVLT8RpGVGzSU=
X-Received: by 2002:a05:6870:41c4:b0:e6:6550:2da3 with SMTP id
 z4-20020a05687041c400b000e665502da3mr1435938oac.13.1651572011045; Tue, 03 May
 2022 03:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220503050136.86298-1-khuey@kylehuey.com> <20220503094631.1070921-1-pbonzini@redhat.com>
In-Reply-To: <20220503094631.1070921-1-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 3 May 2022 03:00:00 -0700
Message-ID: <CALMp9eTCY3tMGL4=g4UfxGJoVhVB6KGu+vbwL-aDr+HJyaBBcQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/svm: Account for family 17h event renumberings
 in amd_pmc_perf_hw_id
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Kyle Huey <me@kylehuey.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Keno Fischer <keno@juliacomputing.com>,
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

On Tue, May 3, 2022 at 2:46 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Queued, thanks.

Isn't it better to just drop this entirely, as in
https://lore.kernel.org/kvm/20220411093537.11558-12-likexu@tencent.com/?
