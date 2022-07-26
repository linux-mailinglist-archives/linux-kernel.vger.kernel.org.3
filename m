Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC9A5816AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbiGZPng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbiGZPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84A4A2CCBF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658850211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y6NYfeTb550US7mev7AopaFJdf46Ahr+jvda49+lmqU=;
        b=KQj9cPHv1sTDyAihg0eMOJVHH0/e6Lpbf2cjcD9d4xaRUoi3dmPo9JXz+nzTvzMcekHA1r
        FcgQSfL5bg7y8ObhEQb3Sxdhx1PqS6XncJL16b88UQaPxI+GfUcQ6aMtScaADUi/SByXHk
        RPOc61c5WC4WfxFvuxhY9TjzOtbVo+4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-k4iAtCmDN3mOv7nuIOanAw-1; Tue, 26 Jul 2022 11:43:30 -0400
X-MC-Unique: k4iAtCmDN3mOv7nuIOanAw-1
Received: by mail-ej1-f70.google.com with SMTP id ji2-20020a170907980200b0072b5b6d60c2so4502934ejc.22
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y6NYfeTb550US7mev7AopaFJdf46Ahr+jvda49+lmqU=;
        b=0VnEkwvmIBJ+wucvkhUJYijWxVlCigW4O0wvUonb6CmcxI7FbtdFsLZANXmiULjRQl
         stoydkpIa1LyrEyFMdUk8ddsDu9KSXO1Iqa32lYCHMx/vhbafwbdpeP7T17JWFS3kO3T
         sOS92LjmR8OVOuErAIoB8JQp1K1zByWm45JCy3sqWY83/bAD+udJwRnRH7yrfjmIy80O
         0HulX/VLFBeHGduwoXbB5Mx8lwKYTzN704xKQhIJ5p6QCQ03qTeEeE3WD64Tfnv3XMzk
         QZWGP3GyXXMNARo08vtZwuN88TzhzP7QOrx01Q0kfhezZd1ljNEH3mWvlVsKYS7slDvI
         Awng==
X-Gm-Message-State: AJIora+eIPYm6r4MqvBz85rLDEz6nn6+A7a23WkGJBJr9JVojCEgP638
        hzDSIbCC4Zef4SrLcp9tePaxZa7tEPtGB9y5e1yif+JiaHXrTcuiBhjCVD/ArZif5EP536KO4hR
        GsoHoAFFqwjY+TXZ/CkBifie5
X-Received: by 2002:a05:6402:331c:b0:43b:c62e:24dd with SMTP id e28-20020a056402331c00b0043bc62e24ddmr18559310eda.325.1658850209304;
        Tue, 26 Jul 2022 08:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tfsDx5b8T5x9hwqArzic0Fuj5fMOp55zpv2kn2x2FQaclY40VE6p07BBhvL07U9oisoulw4g==
X-Received: by 2002:a05:6402:331c:b0:43b:c62e:24dd with SMTP id e28-20020a056402331c00b0043bc62e24ddmr18559278eda.325.1658850208849;
        Tue, 26 Jul 2022 08:43:28 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id x4-20020aa7dac4000000b0042617ba638esm8699374eds.24.2022.07.26.08.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 08:43:28 -0700 (PDT)
Message-ID: <ffc99463-6a61-8694-6a4e-3162580f94ee@redhat.com>
Date:   Tue, 26 Jul 2022 17:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] KVM: x86: enable TDP MMU by default
Content-Language: en-US
To:     Stoiko Ivanov <s.ivanov@proxmox.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        bgardon@google.com
References: <20210726163106.1433600-1-pbonzini@redhat.com>
 <20220726165748.76db5284@rosa.proxmox.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220726165748.76db5284@rosa.proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 16:57, Stoiko Ivanov wrote:
> Hi,
> 
> Proxmox[0] recently switched to the 5.15 kernel series (based on the one
> for Ubuntu 22.04), which includes this commit.
> While it's working well on most installations, we have a few users who
> reported that some of their guests shutdown with
> `KVM: entry failed, hardware error 0x80000021` being logged under certain
> conditions and environments[1]:
> * The issue is not deterministically reproducible, and only happens
>    eventually with certain loads (e.g. we have only one system in our
>    office which exhibits the issue - and this only by repeatedly installing
>    Windows 2k22 ~ one out of 10 installs will cause the guest-crash)
> * While most reports are referring to (newer) Windows guests, some users
>    run into the issue with Linux VMs as well
> * The affected systems are from a quite wide range - our affected machine
>    is an old IvyBridge Xeon with outdated BIOS (an equivalent system with
>    the latest available BIOS is not affected), but we have
>    reports of all kind of Intel CPUs (up to an i5-12400). It seems AMD CPUs
>    are not affected.
> 
> Disabling tdp_mmu seems to mitigate the issue, but I still thought you
> might want to know that in some cases tdp_mmu causes problems, or that you
> even might have an idea of how to fix the issue without explicitly
> disabling tdp_mmu?

If you don't need secure boot, you can try disabling SMM.  It should not 
be related to TDP MMU, but the logs (thanks!) point at an SMM entry (RIP 
= 0x8000, CS base=0x7ffc2000).

This is likely to be fixed by 
https://lore.kernel.org/kvm/20220621150902.46126-1-mlevitsk@redhat.com/.

Paolo

