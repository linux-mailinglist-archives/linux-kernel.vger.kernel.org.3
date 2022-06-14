Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231C954AFC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355700AbiFNMCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355494AbiFNMCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62AA24925B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655208124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o96R2liK/Rw+rA+r9jCufpYDG8GL1tJQ/8vEiFbyM6o=;
        b=bXxIGKtZY82zhaB3kQofzlqK84QH+zgmJGzegioWN2d70wtiRMbJcWjaPJdHLzg6wkp2WV
        gGAGwvnJjLgfw5ePolldQLdooTcLinubm+Um42eXurKUxG4T6Q6bnGpBPBidlWnfH06fPC
        5zXFfopmXJrjNQRgUnulXCQy8pqGEf0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-prXURZg6PCmU1av7Bezv4Q-1; Tue, 14 Jun 2022 08:01:57 -0400
X-MC-Unique: prXURZg6PCmU1av7Bezv4Q-1
Received: by mail-ed1-f72.google.com with SMTP id co13-20020a0564020c0d00b0042dc9ef4f01so6006504edb.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=o96R2liK/Rw+rA+r9jCufpYDG8GL1tJQ/8vEiFbyM6o=;
        b=KXQB7/9AiDlhUuHlcBcxazuhmovTbcJTYOuZE0YwLOwO7WDpf45xOX4CY/alpAyzrQ
         bGYmdEwoQgqys5+nLYJDKXT5gq7yy+e6DANqb9MCAiBaVNTbaVQSqrTKAD5+RxeDaDhN
         aDWagAcvp8lMDsXas67Tib2Hkx1clpPyOgUlnfspFLowWYZEjomCNHHFUzd2LdR2TISn
         lapsRrlD4UJrddIG9dadUIfOehA69ZwL1Il+hgRXfxTcXqyF0+DEZVy5mS6qFb7tILiH
         fWa8P3BVP0IyorUYtqevXWRAhQj2W27pLuL/qqMKc42t3v9laxlJFULYfpXDMJJaCB9n
         vPbw==
X-Gm-Message-State: AOAM533BKLx6BR1h9BHnWioJPzVIxxYPXXZSxed3ZEIV+YlwfSvZJBLV
        Bbj1ncVDQsPgHDpQUnUwq2RDsw8a1Idfic2pNnTDl61gwOu0JN2Xbc1+BJWPTBZFoYeSRACwIDG
        LfX+6KST2KDpH0JEcBFoVyCkgN499MKaIOMQ3EwlT7Ul/yUv5RtO5JtRZvMTDdPbb2/8ocXJOpT
        yb
X-Received: by 2002:a05:6402:b09:b0:42d:bd80:11ac with SMTP id bm9-20020a0564020b0900b0042dbd8011acmr5697617edb.244.1655208116077;
        Tue, 14 Jun 2022 05:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tEtZpjxqfX31iR1J4Bw5cOqOaEdjuVhAslKHGEPsqyrNUbKoaC6+E3Rv9RKO/BWr1fuea/Iw==
X-Received: by 2002:a05:6402:b09:b0:42d:bd80:11ac with SMTP id bm9-20020a0564020b0900b0042dbd8011acmr5697568edb.244.1655208115822;
        Tue, 14 Jun 2022 05:01:55 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v14-20020a056402348e00b0042dc25fdf5bsm7112494edc.29.2022.06.14.05.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 05:01:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     mudongliang <mudongliangabcd@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: kvm: remove NULL check before kfree
In-Reply-To: <20220614085035.122521-1-dzm91@hust.edu.cn>
References: <20220614085035.122521-1-dzm91@hust.edu.cn>
Date:   Tue, 14 Jun 2022 14:01:54 +0200
Message-ID: <87zgifihcd.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongliang Mu <dzm91@hust.edu.cn> writes:

> From: mudongliang <mudongliangabcd@gmail.com>
>
> kfree can handle NULL pointer as its argument.
> According to coccinelle isnullfree check, remove NULL check
> before kfree operation.
>
> Signed-off-by: mudongliang <mudongliangabcd@gmail.com>
> ---
>  arch/x86/kernel/kvm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 1a3658f7e6d9..d4e48b4a438b 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -236,8 +236,7 @@ void kvm_async_pf_task_wake(u32 token)
>  	raw_spin_unlock(&b->lock);
>  
>  	/* A dummy token might be allocated and ultimately not used.  */
> -	if (dummy)
> -		kfree(dummy);
> +	kfree(dummy);
>  }
>  EXPORT_SYMBOL_GPL(kvm_async_pf_task_wake);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

