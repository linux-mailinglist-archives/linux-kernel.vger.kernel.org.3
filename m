Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD551C1F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380400AbiEEOMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380388AbiEEOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:12:39 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BE2258E7D
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651759739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VzI9JvCxja3W1WlPRY5tnznUwEDg18sqNajkevf1Dr8=;
        b=GrMlOfbM3j+DXsYRHJ37ojBdBwOdgRdU7M/NwP9svuTlrEVjTSgcxOMeoUnS17wYBu28+s
        4K04WTOtzNtKxQSK4mFp6TSsZ7x1ttJX9M3gLq+JHbA8L6pdEdySIf78TtoTa5bTx/AiIr
        Me65lvFOsfgJLZQzy0zg03EXF5vUQ18=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-rDWmC_dUOHCFpUCVEcXMIg-1; Thu, 05 May 2022 10:08:58 -0400
X-MC-Unique: rDWmC_dUOHCFpUCVEcXMIg-1
Received: by mail-wm1-f69.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so1799838wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 07:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VzI9JvCxja3W1WlPRY5tnznUwEDg18sqNajkevf1Dr8=;
        b=F85Ktu5KM9Mbe5OmBhfJALXGJKeNPkxrkpfjuk1zYV2D533pH3zE2A7k4F6DJT8h40
         1qUW4Bvptf1Irh36P1/Q0Tbv8pvVNbBViVFJl9mPSUCrtT0A1D9u5FidoXL0WlK/xZNK
         1ZwgKrkLj/Nf0kgMi6A9QcmxF+cfByUVZtjN2/vDpts5So3i1PAvX4gmog9hulUt/khw
         Vt2ocpbrDD1BKn19mSvSgAVYNK00XLT2/gMURnprNyaYFdgyiswUmSyJtaaXGoP+SmHy
         ArjKHyMmFg+2MCLbOBhOxQrEZmqQrM3QOYRpp3oKayE9qsOkFIwIXDN5qchWlkHcJhsO
         OZbQ==
X-Gm-Message-State: AOAM533WDFtSSAsNw6TVFFmrgnw3EHd+cWXnuYz62FFYOm6PAqMkZhHZ
        O3RCR430hEWIZt14FoNjuqNhi90IrqK2KORJ8jdhkS9FxuSMsRZh0T/lH1w12XddKmvkUrVK76R
        3Trb2fwr2JqUgDbekP1DEzkH+
X-Received: by 2002:adf:cc82:0:b0:20a:cf3b:4624 with SMTP id p2-20020adfcc82000000b0020acf3b4624mr20695805wrj.573.1651759736824;
        Thu, 05 May 2022 07:08:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycDSaP/HTRh31DRv1701UdMU8PXjQJEzz5lOf8or8YKiW2KqGjGdEQ8AWqpQqk7+z32NLSWg==
X-Received: by 2002:adf:cc82:0:b0:20a:cf3b:4624 with SMTP id p2-20020adfcc82000000b0020acf3b4624mr20695779wrj.573.1651759736570;
        Thu, 05 May 2022 07:08:56 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600010c400b0020c5253d8fesm1259871wrx.74.2022.05.05.07.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:08:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 003/128] KVM: selftests: Unconditionally compile KVM
 selftests with -Werror
In-Reply-To: <20220504224914.1654036-4-seanjc@google.com>
References: <20220504224914.1654036-1-seanjc@google.com>
 <20220504224914.1654036-4-seanjc@google.com>
Date:   Thu, 05 May 2022 16:08:55 +0200
Message-ID: <875ymk137s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Specify -Werror when compiling KVM's selftests, there's zero reason to
> let warnings sneak into the selftests.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index af582d168621..c8efaaeb0885 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -153,7 +153,7 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/x86/include
>  else
>  LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
>  endif
> -CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
> +CFLAGS += -Wall -Werror -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>  	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>  	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
>  	-I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)

"-Werror" in kvm-unit-tests is a constant source of pain as different
GCC versions tend to produce different warnings. It's going to be even
worse for selftests: e.g. bisecting an 'old' kernel on a system with
somewhat 'newer' compiler and selftests don't even build.

Personally, I'd prefer "-Werror" to be an acceptance criteria for
upstream patches (e.g. if something produces warnings on Paolo's
setup -- the patch doesn't get accepted) but not the hardcoded default
in Makefile.

-- 
Vitaly

