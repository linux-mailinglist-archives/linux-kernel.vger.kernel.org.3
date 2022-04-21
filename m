Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDF7509B26
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386956AbiDUIxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386954AbiDUIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12AE718E3D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650531052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9GOgKbTaKLpjisKA5uiBPW2PYHrqd+UofqKoU0ytW8=;
        b=QjXwcFMN/xurlBkr5UTrjWwDlLYtLP34nZOOVFD8Sbmrm/Do9a90j7zmSviss91xBcAkt7
        V3y4ZxN6xZoPGUVjMMrqX29EDF5RSbnKbEV1Jk6uR6eBbBEHkHv3h3gI56WOvNkO3+4OaX
        ymsoPEO42V7ZjlxI7jzGkhd7KH2jVxo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-ODHWt5YyMRSBo5Cnshcpag-1; Thu, 21 Apr 2022 04:50:48 -0400
X-MC-Unique: ODHWt5YyMRSBo5Cnshcpag-1
Received: by mail-wr1-f70.google.com with SMTP id w22-20020adf8bd6000000b0020aaff5af82so915714wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=/9GOgKbTaKLpjisKA5uiBPW2PYHrqd+UofqKoU0ytW8=;
        b=akoVAXwcZSRp4sH5XhqQKO28/JBOouuDqpLUpb561dHAMWII/00ABz6vpCMngBp0fV
         PsCZgGIg7Wj+9GrxHhfeCdqWTH5gi0SE8lM/eN4Z1lFVDlIgBIgw/yPmKPSX4YRUVn5V
         soelsy9pDNtyVCmNGAcsxtq3bjf8hvyTIRXK1u5UZAMbQFeXz2aBDVM1nNxuSbSc2K7M
         IB65qlkJtDrkmwa5kzJ3gnpzFuaQ8Meuu1jvrqEuT9v5snMJw3b2+qLThkDv2Z6UVbFG
         Qu7LqxqKsP5JOFp4w34DOni4AAPmQO2P3il8cjgiO6xsiebKpVLqQIdz6Gx+8PxHDzIB
         zSHA==
X-Gm-Message-State: AOAM533WHJbq+1ZIiu5dy8D7pLEBJORm4IlRMwxV2Si9n8EIhDHKmgf1
        C0ePCHE6aA2cm/q93zmXvtTcgD6q91jin4WxT+P+u7e0BN+8hGhU9Nyya7e7q4r422iadb6qU6L
        Vw05GshwCrV+9n7tK9QCYyAcx
X-Received: by 2002:a5d:6251:0:b0:20a:b1de:627c with SMTP id m17-20020a5d6251000000b0020ab1de627cmr4744811wrv.100.1650531046725;
        Thu, 21 Apr 2022 01:50:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKFLs1xBNEuxsOzGJ6kr1aswBBF3UzmV1rUTNavKT9f4etZ83OsiQoPegkDw48HatLMKviUw==
X-Received: by 2002:a5d:6251:0:b0:20a:b1de:627c with SMTP id m17-20020a5d6251000000b0020ab1de627cmr4744789wrv.100.1650531046421;
        Thu, 21 Apr 2022 01:50:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:de00:711b:76af:b335:9b70? (p200300cbc702de00711b76afb3359b70.dip0.t-ipconnect.de. [2003:cb:c702:de00:711b:76af:b335:9b70])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b0020aac00f862sm1741182wry.98.2022.04.21.01.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 01:50:45 -0700 (PDT)
Message-ID: <022fe906-054d-43b4-14d4-a4c1cb7527af@redhat.com>
Date:   Thu, 21 Apr 2022 10:50:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:HWPOISON MEMORY FAILURE HANDLING" <linux-mm@kvack.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220420210009.65666-1-qiuxu.zhuo@intel.com>
 <3720f7d9-a4f3-214c-1dea-f8ffc837c1da@intel.com>
 <DM8PR11MB566941C063EA44929147035E89F49@DM8PR11MB5669.namprd11.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/1] x86/mm: Forbid the zero page once it has
 uncorrectable errors
In-Reply-To: <DM8PR11MB566941C063EA44929147035E89F49@DM8PR11MB5669.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.22 09:53, Zhuo, Qiuxu wrote:
>> From: Hansen, Dave <dave.hansen@intel.com>
>> ...
>> Subject: Re: [PATCH 1/1] x86/mm: Forbid the zero page once it has
>> uncorrectable errors
>> ...
>> There are lots of pages which are entirely fatal if they have uncorrectable errors.
>> On my laptop, if there were an error, there is a 0.00000596% chance it will be in
>> the zero page.
>>
>> Why is this worth special casing this one page?
> 
> Hi Dave,
> 
>    Yes, this is a rare problem. Just feel that the fix is simple, so post it here to see whether you'll consider it 😊.

Just some background information.

mm_forbids_zeropage() exists for the sole purpose of s390x/kvm not being
able to use the shared zeropage for a KVM guest because the storage keys
associated with the shared zeropage could result in trouble. So
s390x/kvm has to make sure that no shared zeropage
is mapped into the process.

See fa41ba0d08de ("s390/mm: avoid empty zero pages for KVM guests to
avoid postcopy hangs") for details.

@Christian

a) with keyless guests we could actually use the shared zeropage because
the guest cannot possibly enable storage keys, correct?

b) Why is there no mm_forbids_zeropage() check in mfill_zeropage_pte()?
Maybe I'm missing something, but looks like we can still place the
shared zeropage into a KVM guest via uffd.


In general, there are more place that will use the shared zeropage, most
notably, fs/dax.c  will place the shared zeropage for holes and would
still use it on x86-64. IIRC, s390x doesn't use it.

/proc/vmcore will map the zeropage to user space for areas that are not
RAM, so you could still stumble over it there and trigger a MCE.

Last but not least, the huge shared zeropage would suffer from similar
problems.


Also, I wonder if the generic code change in mm/memory-failure.c is
correct as it touches common code and you only mess with the x86
zeropage. But I did not look into the details.


So the code here at least isn't complete. So I'm not convinced this
change is worth it.


-- 
Thanks,

David / dhildenb

