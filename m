Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B517535057
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiEZOEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbiEZOEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F6128CB38
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653573881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vXIDMXdbWn3CFwJPPtOALPFH0gfKO88GqGt6FTcIcL0=;
        b=NJNtrj79mG1HJHf9pCYgtT40oqTcBWPFY9k/sW5BkfjeW89k6C+gLz3A+ucHsdsyPyNQnz
        20y6HUgV0NzB4804vMZeVZEXyqvugfn8iqAfXHZesI79FEjnc+DnGcS2F8RwmnOyeUtDSE
        GVeB/2rypVlsT0FwJ0sPjru1URNsDxc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-BI4rfRWHMii3ED0p-0dhMQ-1; Thu, 26 May 2022 10:04:40 -0400
X-MC-Unique: BI4rfRWHMii3ED0p-0dhMQ-1
Received: by mail-wm1-f71.google.com with SMTP id bg13-20020a05600c3c8d00b003974d0ff917so1145305wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vXIDMXdbWn3CFwJPPtOALPFH0gfKO88GqGt6FTcIcL0=;
        b=SjUEYbx+TQmZZl+5jIEUmuGKPOg0Z8ZTjHKbTcewDgZl5zDnWfOMdgcpN5CKIK0WZn
         hWMB8tQSvleD6geNVuchW+VKetfE35eXky8jF1mJqxltOP/xD88JVOfVeA/gHzKdXFPN
         NMEX7+sOVf9nv4QGsdJfjXFjrfVS1IMW5DMh/gurK7JmP+wXE/IFPN2ziFSm/GAEfPk6
         zGZm+DboZq6qvVwo+/mN1HibCWvn1OmxUcqAd2jjQbCt3EZNrqiw39R9jPOKfZPGDQKN
         yuXptHZB94BOprjBW9zzdawP0cseN4y3m1bFKm82LeF605JoArM+I3tuBf58qqhJHrkG
         D/+Q==
X-Gm-Message-State: AOAM531nf7yf/dPZumI8608Y2DZt5bQCOBHhr0keODLKlZG6jJRiYbIM
        xzs82ctn7F0SlMU0t1qj4yl/ur5/EBW9oue3YJq7Weo2PgxwNIFF3lLShe0f7WmZGUZAa3gm5qm
        3PbKWOQkp7OOqrcK9RvPu3Sqy
X-Received: by 2002:a7b:c957:0:b0:397:3f4d:555c with SMTP id i23-20020a7bc957000000b003973f4d555cmr2533243wml.101.1653573879037;
        Thu, 26 May 2022 07:04:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsUkpmO+WEr+0K774juxAKra9bm1YWJFZ84phTC7DPfVnt0rczZU3R2XM2/lzjJ/CGKSGZBg==
X-Received: by 2002:a7b:c957:0:b0:397:3f4d:555c with SMTP id i23-20020a7bc957000000b003973f4d555cmr2533207wml.101.1653573878757;
        Thu, 26 May 2022 07:04:38 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ay5-20020a05600c1e0500b003948f4e750fsm5721538wmb.23.2022.05.26.07.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:04:38 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Dinse <nanook@eskimo.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/4] KVM: x86: Grab regs_dirty in local 'unsigned long'
In-Reply-To: <20220525222604.2810054-2-seanjc@google.com>
References: <20220525222604.2810054-1-seanjc@google.com>
 <20220525222604.2810054-2-seanjc@google.com>
Date:   Thu, 26 May 2022 16:04:37 +0200
Message-ID: <87tu9cqtje.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Capture ctxt->regs_dirty in a local 'unsigned long' instead of casting
> ctxt->regs_dirty to an 'unsigned long *' for use in for_each_set_bit().
> The bitops helpers really do read the entire 'unsigned long', even though
> the walking of the read value is capped at the specified size.  I.e. KVM
> is reading memory beyond ctxt->regs_dirty.  Functionally it's not an
> issue because regs_dirty is in the middle of x86_emulate_ctxt, i.e. KVM
> is just reading its own memory, but relying on that coincidence is gross
> and unsafe.

Your nearly perfect description misses one important part: in 'struct
x86_emulate_ctxt', 'regs_dirty' is actually 'u32' thus all this buzz :-)

>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/emulate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 89b11e7dca8a..7226a127ccb4 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -269,9 +269,10 @@ static ulong *reg_rmw(struct x86_emulate_ctxt *ctxt, unsigned nr)
>  
>  static void writeback_registers(struct x86_emulate_ctxt *ctxt)
>  {
> +	unsigned long dirty = ctxt->regs_dirty;
>  	unsigned reg;
>  
> -	for_each_set_bit(reg, (ulong *)&ctxt->regs_dirty, 16)
> +	for_each_set_bit(reg, &dirty, 16)
>  		ctxt->ops->write_gpr(ctxt, reg, ctxt->_regs[reg]);
>  }

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

