Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BF251ACFD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377225AbiEDSjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377445AbiEDSjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4F9515FFB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651689090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlxGeddYm7+kUp1oNq/vf6ZRSDNbbDHnlMtNw0D7/Y8=;
        b=KgYHjlwPchdUmSCrAEL2D5mWJHfO8/7KkuP4So9esntsWdI222TZ+ICcGKfOMvgpeWK8VO
        AQ9+VUn0KWjhzSPZrUR4t/HtLw2ZJWAKXqAPZnUcc6jqMwSzFkcYLkFcX8OPp9Y1uXZWq0
        D92N9UqX5MWeHJp2cE7OTFii3WceuOY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-hLoKJjY2P0eWUHVB1unQIw-1; Wed, 04 May 2022 14:31:27 -0400
X-MC-Unique: hLoKJjY2P0eWUHVB1unQIw-1
Received: by mail-pl1-f200.google.com with SMTP id y14-20020a1709027c8e00b0015906c1ea31so1094449pll.20
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jlxGeddYm7+kUp1oNq/vf6ZRSDNbbDHnlMtNw0D7/Y8=;
        b=ZYZMlWy2tWTQqwZ6c2AKUg+S1/EsA+L5NYHITFlBjAksL4SUF/aLRIs54Lgd3x6kzg
         NJDsUmRV3Q0Gv+FRcgzcENrFqMDUBuAOOnMpLCyPx7DKTco6rfvwDmb7FgtBIgSwRB6S
         kUZCX+w9QTmO6XUkRw914n5ebPnpRND2qT1DVXgNWjpVMN4Ik2oZv53q+e+lCLZkNbwJ
         bKnXGEiPsyo8HPIgTCCLkSGLDBwyuN+8U5NiH5qEDL4DYfnfAJpoKPkrt7J6v5B3QYeM
         IKvP0rTvZx0EFlfVOZaHZBanRBQckuJuMg3CTXwSkSvJW3csSZxNVRdU1nGOLXQv/WY/
         9kNg==
X-Gm-Message-State: AOAM530EmQzzUCbp64y2efNZb9Odl3iRRzEMctJ5Enu/GfevEVsTyfcV
        c/u2spMu1vcqL3EGVFkpZNp9QWvZfDY0AOSFL5X4NsI1cyoUsGebNQ+qPwpKbT9Km9He0v71AAk
        C10Wz69m/AtQZfMP8s40I8Odg
X-Received: by 2002:a17:903:41c3:b0:15e:b690:bedc with SMTP id u3-20020a17090341c300b0015eb690bedcmr9689657ple.161.1651689086597;
        Wed, 04 May 2022 11:31:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzA9Ji+G5KCYEXFnDpZIK3Bup0w0RF0Z/dspcO6sxnccRhu0add6ZvdZkW3XyEfR9yWmA1uGw==
X-Received: by 2002:a17:903:41c3:b0:15e:b690:bedc with SMTP id u3-20020a17090341c300b0015eb690bedcmr9689615ple.161.1651689086262;
        Wed, 04 May 2022 11:31:26 -0700 (PDT)
Received: from [10.10.69.234] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id m17-20020aa78a11000000b0050dc76281d6sm8852386pfa.176.2022.05.04.11.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 11:31:24 -0700 (PDT)
Message-ID: <15f5f8d6-dc92-d491-d455-dd6b22b34bc3@redhat.com>
Date:   Wed, 4 May 2022 20:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
References: <20220426150616.3937571-24-Liam.Howlett@oracle.com>
 <20220428201947.GA1912192@roeck-us.net>
 <20220429003841.cx7uenepca22qbdl@revolver>
 <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
 <20220502001358.s2azy37zcc27vgdb@revolver>
 <20220501172412.50268e7b217d0963293e7314@linux-foundation.org>
 <Ym+v4lfU5IyxkGc4@osiris> <20220502133050.kuy2kjkzv6msokeb@revolver>
 <YnAn3FI9aVCi/xKd@osiris> <YnGHJ7oroqF+v1u+@osiris>
 <20220503215520.qpaukvjq55o7qwu3@revolver>
 <60a3bc3f-5cd6-79ac-a7a8-4ecc3d7fd3db@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <60a3bc3f-5cd6-79ac-a7a8-4ecc3d7fd3db@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.22 09:37, Janosch Frank wrote:
> On 5/3/22 23:55, Liam Howlett wrote:
>> * Heiko Carstens <hca@linux.ibm.com> [220503 15:49]:
>>> On Mon, May 02, 2022 at 08:50:04PM +0200, Heiko Carstens wrote:
>>>> On Mon, May 02, 2022 at 01:31:00PM +0000, Liam Howlett wrote:
>>>>> * Heiko Carstens <hca@linux.ibm.com> [220502 06:18]:
>>>>>> On Sun, May 01, 2022 at 05:24:12PM -0700, Andrew Morton wrote:
>>>>>>> (cc S390 maintainers)
>>>>>>> (cc stable & Greg)
>>> ...
>>>>>>>> booting.  The last thing I see is:
>>>>>>>>
>>>>>>>> "[    4.668916] Spectre V2 mitigation: execute trampolines"
>>>>>>>>
>>>>>>>> I've bisected back to commit e553f62f10d9 (mm, page_alloc: fix
>>>>>>>> build_zonerefs_node())
>>>>>>>>
>>>>>>>> With the this commit, I am unable to boot one out of three times.  When
>>>>>>>> using the previous commit I was not able to get it to hang after trying
>>>>>>>> 10+ times.  This is a qemu s390 install with KASAN on and I see no error
>>>>>>>> messages.  I think it's likely it is this patch, but no guaranteed.
>>> ...
>>>>>> Liam, could you share your kernel config?
>>>>>
>>>>> Sure thing.  See attached.
>>>>
>>>> So, I can reproduce the hanging system now. However this looks like a
>>>> qemu problem on s390, since I can reproduce this only with Qemu+TCG.
>>>> Qemu with kvm works without any problems (same if I use z/VM as
>>>> hypervisor).
>>>>
>>>> Janosch, Claudio, can you have a look at this please?
>>>
>>> So, at least for me this problem also exists with plain v5.17.
>>> Switching off KASAN, or alternatively switching to KASAN_INLINE
>>> "fixes" it for me with Qemu+TCG.
>>>
>>> Liam, could you please also try to disable KASAN in your config? With
>>> that I think we can be almost sure this could be some bug in Qemu.
>>
>> With KASAN, my tree fails 100% of the time (mm-stable + my maple tree
>> patches)
>>
>> Without KASAN, it boots 100% of the time.
>>
>> I think this verifies with you say above?
>>
>> Thanks,
>> Liam
> 
> I had a short look yesterday and the boot usually hangs in the raid6 
> code. Disabling vector instructions didn't make a difference but a few 
> interruptions via GDB solve the problem for some reason.
> 
> CCing David and Thomas for TCG
> 

I somehow recall that KASAN was always disabled under TCG, I might be
wrong (I thought we'd get a message early during boot that the HW
doesn't support KASAN).

I recall that raid code is a heavy user of vector instructions.

How can I reproduce? Compile upstream (or -next?) with kasan support and
run it under TCG?

-- 
Thanks,

David / dhildenb

