Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E051588CE3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiHCNXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHCNW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E94863E6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659532976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r+gknjCfxt0fEOnt+pVR0+jPvwgnjQqFJO2CdOTgi0A=;
        b=SKmQPvD7Hi+SkHNTWyCTcK4BVzl85qbLGS33wujAyrCOQbCwWjXT20tTcjDfnIjIrX4UFD
        Y6vN8hLYYwDmykGlCaA8AuAUDrTYlqi9VUPj+YhoqWSlkl8PpoR+2Lb6HP4K4ZgAE4iwHc
        Bv0hH973SOygfP15QzoiPdEJMS9N7kQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-3d1gJx0CPeilOGVT_fP0ZQ-1; Wed, 03 Aug 2022 09:22:55 -0400
X-MC-Unique: 3d1gJx0CPeilOGVT_fP0ZQ-1
Received: by mail-ed1-f72.google.com with SMTP id s17-20020a056402521100b0043ade613038so11177706edd.17
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 06:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=r+gknjCfxt0fEOnt+pVR0+jPvwgnjQqFJO2CdOTgi0A=;
        b=zL97gp1RN66mDtu5wTNpNu4B8d7cn44x8JBWnXZDeSCR/QLcrnSC+dwXGIEzUC3IcB
         SwKgdgrBlZHgWFr0/adV8lPYwoS0jSfb9ZnEVXGQsuV7vIw0goyr8bwv0XrOA4pIg3xC
         /2btLAFA4qNP2r09JjZyRZ8cQd50BE6wtTxxJl3ujq1gXYK1ZRNBsHFigTYu7Q0XB6c2
         QfpcStG+YqnxzLKANRiqqdocyPT6aGjr9YX6EmNQSCVpHurIuX8hZP6HKezT3bZHGtCW
         mf4Dvqcg7UYBLm8+XItrxV7h3O5Jmhmy2k+s9Ysbz684qacA/pu+kRCgPiobJEmIGl1B
         7fcw==
X-Gm-Message-State: ACgBeo1iSN8eSgqoX0nHshAqYa1k9ApBKVgJTAwcWSI9W9QT/TFK8lsJ
        mwUXwr60HWf05fLfgFrSdKkt0jGdvNHuCFREjFBn2fihuog3NwBEEOj692sLxA96UfnJV6H77N5
        i5mNkblFscW1UqpgKJNk2IXHGA999xeF1u6jetL7aSK6XOUHiIP/IYOwcE8gwV7ECTRIFmo0L24
        gc
X-Received: by 2002:a17:907:2da6:b0:730:8b30:e517 with SMTP id gt38-20020a1709072da600b007308b30e517mr11135817ejc.291.1659532974386;
        Wed, 03 Aug 2022 06:22:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7QXzIvyo5JHfdTWJxkKXD5/xn7PyCYwfwoPD1cdJzUdavBBqrMT6feXNS0/L/XKVI9iTydcQ==
X-Received: by 2002:a17:907:2da6:b0:730:8b30:e517 with SMTP id gt38-20020a1709072da600b007308b30e517mr11135794ejc.291.1659532974112;
        Wed, 03 Aug 2022 06:22:54 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090631ce00b006f3ef214daesm7263746ejf.20.2022.08.03.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 06:22:53 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 33/39] KVM: selftests: nVMX: Allocate Hyper-V
 partition assist page
In-Reply-To: <YtnGd4OT3FQJ75b8@google.com>
References: <20220714134929.1125828-1-vkuznets@redhat.com>
 <20220714134929.1125828-34-vkuznets@redhat.com>
 <YtnGd4OT3FQJ75b8@google.com>
Date:   Wed, 03 Aug 2022 15:22:52 +0200
Message-ID: <877d3p1mxf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Jul 14, 2022, Vitaly Kuznetsov wrote:
>> In preparation to testing Hyper-V L2 TLB flush hypercalls, allocate
>> so-called Partition assist page and link it to 'struct vmx_pages'.
>> 
>> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  tools/testing/selftests/kvm/include/x86_64/vmx.h | 4 ++++
>>  tools/testing/selftests/kvm/lib/x86_64/vmx.c     | 7 +++++++
>>  2 files changed, 11 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
>> index cc3604f8f1d3..f7c8184c1de8 100644
>> --- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
>> +++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
>> @@ -570,6 +570,10 @@ struct vmx_pages {
>>  	uint64_t enlightened_vmcs_gpa;
>>  	void *enlightened_vmcs;
>>  
>> +	void *partition_assist_hva;
>> +	uint64_t partition_assist_gpa;
>> +	void *partition_assist;
>
> Rather than duplicate this and other Hyper-V stuff, can you first add a struct
> to hold the Hyper-V pages, along with a helper to populate them?  I'd even throw
> in the eVMCS stuff, it's trivial for the helper to have a flag saying "don't bother
> allocating eVMCS".  That will give us an easier path to allocating these pages
> if and only if the test actually wants to enable Hyper-V stuff.

Good suggestion and a good excuse to do another refresh/rebase as this
apparently missed 5.20 merge window. 

v9 is coming to rescue!

-- 
Vitaly

