Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BE25A0D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbiHYJ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHYJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2463DF37
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661421532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXEuh/C7EhMT4N5IVCTMgJSlHVPtxpuWjvzgdztQOwA=;
        b=FyYafbFkTwL/yGrlVFUCKT4YjfwfnI7ZlkozTJ2e2AFuQQ9kdkSEIcovrum9Rq4hthtpiJ
        dDWKpP0h9SlzziymOCHgTfyAZHgQJzPquw55v/oaYuhXHa+0NP+WJErOOIWkI9eDQF/y5V
        +I4kDsOmkwpyKuPhNfX65drDz3NJnKo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-oLL8MPS-PyeJQhcHJ1VbNQ-1; Thu, 25 Aug 2022 05:58:51 -0400
X-MC-Unique: oLL8MPS-PyeJQhcHJ1VbNQ-1
Received: by mail-wm1-f72.google.com with SMTP id i7-20020a1c3b07000000b003a534ec2570so2244169wma.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=sXEuh/C7EhMT4N5IVCTMgJSlHVPtxpuWjvzgdztQOwA=;
        b=oyDsxYaLmWu7W9phdZr8pKHZot1XuA/9VY9u9ihik+KbWsw2754EIq/uKVTlMvOy3+
         HOGbd1N+g3jWj8Reb44oQuzLctbvI/euY7hfDTU9wVctFambeSpD6tAZdl+weoSbqDBP
         P02Za2NKTQuIx9mQ2PFt8CwouBOBVls5FZCBwjGalwEIR10iBWikE4YQO0GuyOWxGuoU
         aVYbhiqGSAQp6CAPgURQpKXAFdQ3RPKdcxBvRcaLIy7ktr+O+35tDw4X+nVl0FKRaHiF
         lBGi1w2QjoD4NID4oihGLcBJbJIbchENOS4bRz4u0WiQUD+d3Bk77RfempjPdFkQm2uc
         Fhcg==
X-Gm-Message-State: ACgBeo21nStEhYMjGwsWiuT8VBl5R3HSzzFN2Qk56JVWltR1edN3dwwO
        hOPPBNKHX59Cv3oe4gt35yhedz3oHdhZdZpHJ6AVNpswGKSDLijwdubKXjw7P882aafVMBFg5UT
        unuFwhbU5EA+IKUlfWCkrRJlQ
X-Received: by 2002:adf:fe09:0:b0:225:6c9a:1925 with SMTP id n9-20020adffe09000000b002256c9a1925mr1689589wrr.546.1661421530147;
        Thu, 25 Aug 2022 02:58:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zjV5/uX5zJoDDQGvyv88ADNp860yGdsGm+iTCH+1DVQ3YBmb2/7qZdaBeUnu1fynPZfG7sQ==
X-Received: by 2002:adf:fe09:0:b0:225:6c9a:1925 with SMTP id n9-20020adffe09000000b002256c9a1925mr1689579wrr.546.1661421529892;
        Thu, 25 Aug 2022 02:58:49 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b0021e42e7c7dbsm19557923wri.83.2022.08.25.02.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 02:58:49 -0700 (PDT)
Message-ID: <b1103c81-0c56-0e9b-711c-246e431db151@redhat.com>
Date:   Thu, 25 Aug 2022 11:58:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-3-david@redhat.com>
 <3c250aa26020b2f336fd575a58d06ba26faf1f14.camel@perches.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 2/2] checkpatch: warn on usage of VM_BUG_ON() and
 friends
In-Reply-To: <3c250aa26020b2f336fd575a58d06ba26faf1f14.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.22 18:52, Joe Perches wrote:
> On Wed, 2022-08-24 at 18:31 +0200, David Hildenbrand wrote:
>> checkpatch does not point out that VM_BUG_ON() and friends should be
>> avoided, however, Linus notes:
>>
>>     VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
>>     no different, the only difference is "we can make the code smaller
>>     because these are less important". [1]
>>
>> So let's warn on VM_BUG_ON() and friends as well. While at it, make it
>> clearer that the kernel really shouldn't be crashed.
>>
>> Note that there are some other *_BUG_ON flavors, but they are not all
>> bad: for example, KVM_BUG_ON() only triggers a WARN_ON_ONCE and then
>> flags KVM as being buggy, so we'll not care about them for now here.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -4695,12 +4695,12 @@ sub process {
>>  			}
>>  		}
>>  
>> -# avoid BUG() or BUG_ON()
>> -		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
>> +# do not use BUG(), BUG_ON(), VM_BUG_ON() and friends.
>> +		if ($line =~ /\b(?:BUG|BUG_ON|VM_BUG_ON|VM_BUG_ON_[A-Z]+)\b/) {
> 
> Perhaps better as something like the below to pick up more variants
> 

Trying to find more possible variants and exceptions

$ git grep -h -o -E "\b[a-zA-Z]+_BUG(_ON(_[a-zA-Z]+)*)?\(" | sort | uniq
AA_BUG(
-> Ok, no BUG()
ASM_BUG(
-> Bad
BUILD_BUG(
BUILD_BUG_ON(
BUILD_BUG_ON_INVALID(
BUILD_BUG_ON_MSG(
BUILD_BUG_ON_ZERO(
-> Ok
CI_BUG_ON(
-> Bad with CONFIG_DRM_I915_DEBUG
DCCP_BUG(
DCCP_BUG_ON(
-> Ok, no BUG()
do_BUG(
-> BUG implementation, ok.
GEM_BUG_ON(
-> Bad with CONFIG_DRM_I915_DEBUG_GEM_ONCE
GLOCK_BUG_ON(
-> Bad
handle_BUG(
-> BUG implementation, ok.
IDA_BUG_ON(
KVM_BUG(
KVM_BUG_ON(
-> Ok, no BUG()
lkdtm_BUG(
paravirt_BUG(
-> bad
PROM_BUG(
-> unused, will remove
RWLOCK_BUG_ON(
-> Ok, no BUG()
snd_BUG(
snd_BUG_ON(
-> Ok, no BUG()
SNIC_BUG_ON(
-> Bad
SPIN_BUG_ON(
-> Ok, no BUG()
UNWINDER_BUG(
UNWINDER_BUG_ON(
VIRTUAL_BUG_ON(
VM_BUG_ON(
VM_BUG_ON_FOLIO(
VM_BUG_ON_MM(
VM_BUG_ON_PAGE(
VM_BUG_ON_PGFLAGS(
VM_BUG_ON_VMA(
XA_BUG_ON(
-> Bad

So an extended versions of your proposal like (ignoring do_BUG and handle_BUG, people are smart enough to figure that out)

if ($line =~ /\b(?!AA_|BUILD_|DCCP_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a-zA-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/

?

-- 
Thanks,

David / dhildenb

