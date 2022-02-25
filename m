Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C574C484F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbiBYPIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiBYPIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:08:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 196175F8DD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645801664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXzg+KGWwllNSUCsWeeWB7MRsMJhSltnLNe0hU0M5/I=;
        b=Rd2cejM8e3m/g/pQCfrWLF37/svv9CZbY9EpslhY2Mld5gvrsU4aOQx6QGkxzakFMbeQSe
        5bbAs+RBk4v8HZUc1gGlv/l8bQtEXnyitN9sls8rZ4bAi1hXXZA00O9henpfI0we+Thve4
        2kdC0QQvX0oE/CNG6JTtEy+fd45ROfI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-S9f_2QIBNVaTvWwzPoRLlg-1; Fri, 25 Feb 2022 10:07:42 -0500
X-MC-Unique: S9f_2QIBNVaTvWwzPoRLlg-1
Received: by mail-wr1-f70.google.com with SMTP id u9-20020adfae49000000b001e89793bcb0so987512wrd.17
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZXzg+KGWwllNSUCsWeeWB7MRsMJhSltnLNe0hU0M5/I=;
        b=uq3FzSXHPd8sw0nVuN1Bdr/p/3Lii73qi4JyI9R+QMTtJ75gijqR7JvGmHDpqlhKt+
         4oX+kyc/p4qxXNPF4SE2CxAwpqEAfgJ5uA1M5WRQYFE3a1QaTwzq2UZTlIZ1sGKEQ9PJ
         vtBLp0pkWyj3XcqrTPK1Xv3RdP9gogicoLxCCRWlIlPZ9dKU+Is7dpeIS71wP+obMW5H
         m0i7Km9CwGpuoPEAQI+QdEQO970bC0WQWAuFNzK8vsMgBEYS8vAQYOD+ovNcSu28OHC1
         eb1chqPyZ4KvgWcL1rUmjxcGnu06MqU7iR3mOvtmU3dUuntLwklrtz18mjMRSFkeRC+o
         GQaA==
X-Gm-Message-State: AOAM531U6K0DxwprwUrPG+Fnzo8FoP9e/mstX1/PQds9+BZGjweCALuo
        oQC4lb/YxgYtrf9uPLCF5/xvweqACvzU8FtWjvOSO5UZgGQsiBvS2P/qbKK3ohA/fdjaEpIKHDH
        4oSuZ6osjbz57DH41DK6JV96h
X-Received: by 2002:a05:600c:500a:b0:37b:ec27:1a2c with SMTP id n10-20020a05600c500a00b0037bec271a2cmr3059013wmr.179.1645801661629;
        Fri, 25 Feb 2022 07:07:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrSki4Vsp6ZUikRWQRUZNBuGhi0p8ZD93QRZt7+iDH2WTTx9q7DHDK2VxAukY6SBi8ZBxrJw==
X-Received: by 2002:a05:600c:500a:b0:37b:ec27:1a2c with SMTP id n10-20020a05600c500a00b0037bec271a2cmr3058983wmr.179.1645801661377;
        Fri, 25 Feb 2022 07:07:41 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id f17-20020adffcd1000000b001edbf438d83sm2559168wrs.32.2022.02.25.07.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 07:07:40 -0800 (PST)
Message-ID: <4896c092-a5cb-7ed0-a5d0-32b3abc352c4@redhat.com>
Date:   Fri, 25 Feb 2022 16:07:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/3] KVM: x86/emulator: Move the unhandled outer
 privilege level logic of far return into __load_segment_descriptor()
Content-Language: en-US
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <cover.1644292363.git.houwenlong.hwl@antgroup.com>
 <5b7188e6388ac9f4567d14eab32db9adf3e00119.1644292363.git.houwenlong.hwl@antgroup.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <5b7188e6388ac9f4567d14eab32db9adf3e00119.1644292363.git.houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 10:34, Hou Wenlong wrote:
> Outer-privilege level return is not implemented in emulator,
> move the unhandled logic into __load_segment_descriptor to
> make it easier to understand why the checks for RET are
> incomplete.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---
>   arch/x86/kvm/emulate.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 37c4213bdcc1..bd91b952eb0a 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -1631,9 +1631,14 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
>   		if (!(seg_desc.type & 8))
>   			goto exception;
>   
> -		/* RET can never return to an inner privilege level. */
> -		if (transfer == X86_TRANSFER_RET && rpl < cpl)
> -			goto exception;
> +		if (transfer == X86_TRANSFER_RET) {
> +			/* RET can never return to an inner privilege level. */
> +			if (rpl < cpl)
> +				goto exception;
> +			/* Outer-privilege level return is not implemented */
> +			if (rpl > cpl)
> +				return X86EMUL_UNHANDLEABLE;
> +		}
>   		if (transfer == X86_TRANSFER_RET || transfer == X86_TRANSFER_TASK_SWITCH) {
>   			if (seg_desc.type & 4) {
>   				/* conforming */
> @@ -2228,9 +2233,6 @@ static int em_ret_far(struct x86_emulate_ctxt *ctxt)
>   	rc = emulate_pop(ctxt, &cs, ctxt->op_bytes);
>   	if (rc != X86EMUL_CONTINUE)
>   		return rc;
> -	/* Outer-privilege level return is not implemented */
> -	if (ctxt->mode >= X86EMUL_MODE_PROT16 && (cs & 3) > cpl)
> -		return X86EMUL_UNHANDLEABLE;
>   	rc = __load_segment_descriptor(ctxt, (u16)cs, VCPU_SREG_CS, cpl,
>   				       X86_TRANSFER_RET,
>   				       &new_desc);

Queued all three, thanks!

Paolo

