Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5185248E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352001AbiELJZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352021AbiELJYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31F0E22D611
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652347482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYMVGmr4MttuxWd0hUOmG2PAW2P1q54IXjwFFMV7R3w=;
        b=GqLTdxgws4X1pIGMVkoVZkG10J62Dcm6znRLstJITUWNuRkHSfuLCZIdIRi8OWz9+0/4db
        jzXhTS0EdzuzzuKHGTY0otpCgbX4I/4y9Xeitprss45qR0PpwX0GHIq67wOOwqckL5sTaS
        Lg4jagnixB2GE043r8t+UV7HwEXZ8sQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-jzXTvC4rO1eOJmyZsHyGHQ-1; Thu, 12 May 2022 05:24:41 -0400
X-MC-Unique: jzXTvC4rO1eOJmyZsHyGHQ-1
Received: by mail-wr1-f72.google.com with SMTP id w20-20020adfd1b4000000b0020cbb4347e6so1843067wrc.17
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ZYMVGmr4MttuxWd0hUOmG2PAW2P1q54IXjwFFMV7R3w=;
        b=j3XATN4otwE+xnkOUlZCiYDBZ2QAfDkMBHXS61rzLk/WNHz2ONGAir57z6/R7w2/ku
         peajTP2GXsmYZpLaol7RGHmbeLn+MfI6RSz0TT57JmFpQ5vD7nzoEP4BSHlhSPkhHuyZ
         jiHHIrrX7kpVdOWg5cS4MyiMs33nAhT81vuDEShgwcs/YqV2iNiha7Xio7fBthzA2rGE
         urP/Vb/Ms4JZOx3eLWrvhTFcnRBq393DApbNTP6QXcWe8h0SY2pn2GTbV9Wq7FeV8g5M
         C2unmRC7yS2eWjOwW2X5CBAAtVuC5DBUhmu0d3cNX/4YhEcc8edYF683n18E4lP9FO64
         1m9g==
X-Gm-Message-State: AOAM532Ge8aj23DMmAw0bsAPY2jbGyMQagP4noyRe7N2MAqowkeVwtff
        M4/IJhhdg7YR+p3/NQOyyD0r/+RSAiWQTnpcmMNVpxjZQ7UTTP5xsaaITwZCTVOcgSqO1C1x/RO
        hVh+zRyStPhQ7fNvUkZDedHmr
X-Received: by 2002:adf:cd08:0:b0:20a:eafa:4103 with SMTP id w8-20020adfcd08000000b0020aeafa4103mr26900402wrm.227.1652347479778;
        Thu, 12 May 2022 02:24:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc89JlMnGfd5Y/h97lUfa9Op9S3C7Yv7BklTlNgPy5IpIpEeVS1C3FWV4YEd/XbqGW0n2vRQ==
X-Received: by 2002:adf:cd08:0:b0:20a:eafa:4103 with SMTP id w8-20020adfcd08000000b0020aeafa4103mr26900383wrm.227.1652347479493;
        Thu, 12 May 2022 02:24:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d4dd0000000b0020c5253d8f5sm3675398wru.65.2022.05.12.02.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 02:24:39 -0700 (PDT)
Message-ID: <2ffb7b35-5066-3e63-7648-7663a9142e7d@redhat.com>
Date:   Thu, 12 May 2022 11:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        thuth@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, wintera@linux.ibm.com, seiden@linux.ibm.com,
        nrb@linux.ibm.com
References: <20220506092403.47406-1-pmorel@linux.ibm.com>
 <20220506092403.47406-3-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v9 2/3] s390x: KVM: guest support for topology function
In-Reply-To: <20220506092403.47406-3-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.22 11:24, Pierre Morel wrote:
> We let the userland hypervisor know if the machine support the CPU
> topology facility using a new KVM capability: KVM_CAP_S390_CPU_TOPOLOGY.
> 
> The PTF instruction will report a topology change if there is any change
> with a previous STSI_15_1_2 SYSIB.
> Changes inside a STSI_15_1_2 SYSIB occur if CPU bits are set or clear
> inside the CPU Topology List Entry CPU mask field, which happens with
> changes in CPU polarization, dedication, CPU types and adding or
> removing CPUs in a socket.
> 
> The reporting to the guest is done using the Multiprocessor
> Topology-Change-Report (MTCR) bit of the utility entry of the guest's
> SCA which will be cleared during the interpretation of PTF.
> 
> To check if the topology has been modified we use a new field of the
> arch vCPU to save the previous real CPU ID at the end of a schedule
> and verify on next schedule that the CPU used is in the same socket.
> We do not report polarization, CPU Type or dedication change.
> 
> STSI(15.1.x) gives information on the CPU configuration topology.
> Let's accept the interception of STSI with the function code 15 and
> let the userland part of the hypervisor handle it when userland
> support the CPU Topology facility.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>

[...]


> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 0e8603acc105..d9e16b09c8bf 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -874,10 +874,12 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>  	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>  		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>  
> -	if (fc > 3) {
> -		kvm_s390_set_psw_cc(vcpu, 3);
> -		return 0;
> -	}
> +	if (fc > 3 && fc != 15)
> +		goto out_no_data;
> +
> +	/* fc 15 is provided with PTF/CPU topology support */
> +	if (fc == 15 && !test_kvm_facility(vcpu->kvm, 11))
> +		goto out_no_data;


Maybe shorter as

if (fc == 15 && !test_kvm_facility(vcpu->kvm, 11))
	goto out_no_data;
else if (fc > 3)
	goto out_no_data;


Apart from that, LGTM.

-- 
Thanks,

David / dhildenb

