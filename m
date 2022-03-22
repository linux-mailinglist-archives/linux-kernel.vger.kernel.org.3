Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04D84E45AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbiCVSG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbiCVSGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:06:25 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F2B6948D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:04:57 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r11so12969642ila.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mnfs0TGaLCiuR8+h7Bh7JMBdIzmhOD0lSzxPoaLstY0=;
        b=Ai5ApELwIGxbAGkA7bjCsyR06EgM1YDueepe43Ht6yQpfzmaehyh2jghZB+UEQXXp+
         b+yG8TxNPBHJ0lGuUDHKcIy+5RFBdedUl80l+9B1M/CnuJhACvcHwDNTPmMyUoHHurFt
         TaUwbc9sNQaTF5RbHPk58TCMYSygYYVu4HZSVd0889x8GIjwqkWK3K+uBhrFsXkW645y
         OaeOFOp7ujmNQJ6VtHXVLUoUe51I723IzUqprOMnhYMgqV8nG56hucbv2Rhy4KwOnGps
         6O9vq0L+84lmtJ/G4x85esjVcmytLf1zstdDHAJqIgMZzdNG91ghhvfIcWN5gka3rysA
         pmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mnfs0TGaLCiuR8+h7Bh7JMBdIzmhOD0lSzxPoaLstY0=;
        b=vJeY/ToKlOeZ41FhIAeOvNkYbcrkwfSiwkYirq3CCOymycuNzOMEHkWevwVzIMpvfw
         XtSlVWI7HpUCnsJqURzjBtbkOZIkRg1iu7/iTuHdNIUk+FDtcMAs4eXWtwFRqgxVIimO
         8x7jh/twe7zwpKis2qm6KdfJ0ZfZuzsg4OxwA8SYUpZKAKqGwdsISrk3nO8KbK7NKImL
         CqXj+IPP9tW6sdUluN3buKKmLvjRuoa1mRkdHapJn7B56r+o8K7asG9bFIgRXtwKW+6N
         8qi7lQkij017wg35u1G/2DjyPG3UkTmcx08NygrUIeYAwob7JQ27cOXDg0fdRE8zORq4
         yGUg==
X-Gm-Message-State: AOAM530h5xSh8VH0TdiCxhNxh9eIPCzSrYuwBEAKxyJdSeHcO5uQdYxZ
        5PyqcKrGiF3vPEZeTDGKsoIsKg==
X-Google-Smtp-Source: ABdhPJye2KWFKxhR/JkKla/5EeDb9ty681k7BmUZOKULsq7C/DlrxsaYNUuo5fKFZrXcVmXaz73tVA==
X-Received: by 2002:a05:6e02:1b09:b0:2c8:3fa3:d7a1 with SMTP id i9-20020a056e021b0900b002c83fa3d7a1mr2564306ilv.173.1647972296912;
        Tue, 22 Mar 2022 11:04:56 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id 9-20020a056e0220c900b002c8276ca065sm4070180ilq.2.2022.03.22.11.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:04:56 -0700 (PDT)
Date:   Tue, 22 Mar 2022 18:04:52 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
Subject: Re: [PATCH v5 03/22] KVM: arm64: Support SDEI_VERSION hypercall
Message-ID: <YjoPxLAMIPobBzS0@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-4-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322080710.51727-4-gshan@redhat.com>
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

On Tue, Mar 22, 2022 at 04:06:51PM +0800, Gavin Shan wrote:
> This supports SDEI_VERSION hypercall by returning v1.1, which is
> the specification version we're following. The vendor is set to
> 'KVM'.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index 8a9b477b8977..5a3a64cd6e84 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -118,6 +118,14 @@ static bool remove_all_vcpu_events(struct kvm_vcpu *vcpu,
>  	return pending;
>  }
>  
> +static unsigned long hypercall_version(struct kvm_vcpu *vcpu)
> +{
> +	/* v1.1 and the vendor is KVM */
> +	return (1UL << SDEI_VERSION_MAJOR_SHIFT) |
> +	       (1UL << SDEI_VERSION_MINOR_SHIFT) |
> +	       0x4b564d;

It looks like the SDEI specification states that the vendor-defined
version number is 32 bits. Could we just use one of the
ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_{0,3} values instead?

ASCII 'KVM' is neat, but in reality guest software will just throw it in
a macro regardless. Might as well use one of the values we've already
trained it to use :-)

Also, it would appear that guest discovery of SDEI relies upon KVM
reporting a valid SDEI version. IMO, this patch should come at the very
end when KVM actually implements SDEI.

--
Thanks,
Oliver
