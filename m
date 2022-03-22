Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3D4E3BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiCVJsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiCVJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A7FC6A416
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647942403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gj16fIvhMGn60A3rgtQAZDpb6AlAuaEkvfPmTyLtwTQ=;
        b=R1ySavt5osXkTuXusBrsfDurTnhoXlt4uT+0GKNuUGJ9iJQFVKW/D27bmhvoaTOpLsl2Yx
        wBHyAg6ZDceUl/QJdDququxS7RLzqQ6FCECBehsK/W3QrRLVFgXPqPtVnoACMgSmC1N1lZ
        Yo7NqyIgJ8waF0F97F/ATgW2CLj2t1w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-uKBJyHgoN5-WsJPmxkYCjA-1; Tue, 22 Mar 2022 05:46:42 -0400
X-MC-Unique: uKBJyHgoN5-WsJPmxkYCjA-1
Received: by mail-wm1-f72.google.com with SMTP id o19-20020a05600c379300b0038c7117460dso606829wmr.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=gj16fIvhMGn60A3rgtQAZDpb6AlAuaEkvfPmTyLtwTQ=;
        b=ght3TBl8fiKn0ABvL1MNQF/nhAuuV6ddr2wy0/kiEgIn3qy+pHRhY+SHaYvWxP5aX4
         D7AkY3icqBdETsK6L0neI7tj2cX8vpNaNOW1OE79PD848wMrRRmLmODov8T7aBzoVEk/
         vZS8zRewTgs5Mpng+lP7SbTRUb2XVolFlsJOpl17P2SzsgG8RL7PbqJ0mGQ98peTosrp
         uBey/6FUvDeRShWpWuaGrz1Whcdpp8NCB6pvt5TKZ5xq/hc6iV6ekC6acHni8eeJUcNc
         MjsMTmY3ujTV2CYMmMeurN2gMCj6q9Sm9E4NlDGdBp1F5e9ufSpwzujeBTg2Crw9a7bp
         V15A==
X-Gm-Message-State: AOAM533tS7yKf/yx9ueXiKneWer2fyog/Kwwf2uti+cV9tWyKUgu/14X
        l+iIweL/K8Wl1xKsaSv9cjZ4Px7tIs4CFb842LMEXlNWkaiNPbmS5E62UWsY0Hz768oU0iKJyVv
        OecepuXHU2q3/9yyK+SFCsqrh
X-Received: by 2002:adf:f34e:0:b0:203:fa2f:73e with SMTP id e14-20020adff34e000000b00203fa2f073emr14961273wrp.351.1647942401006;
        Tue, 22 Mar 2022 02:46:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZd8Uvoix5JtZIw5NnbrgIf9I7tI3M1eMO959R1yIf5jk559l3XNPulFYZR9OqDfvtCDALew==
X-Received: by 2002:adf:f34e:0:b0:203:fa2f:73e with SMTP id e14-20020adff34e000000b00203fa2f073emr14961247wrp.351.1647942400705;
        Tue, 22 Mar 2022 02:46:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:de00:549e:e4e4:98df:ff72? (p200300cbc708de00549ee4e498dfff72.dip0.t-ipconnect.de. [2003:cb:c708:de00:549e:e4e4:98df:ff72])
        by smtp.gmail.com with ESMTPSA id v188-20020a1cacc5000000b00384b71a50d5sm1507806wme.24.2022.03.22.02.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 02:46:40 -0700 (PDT)
Message-ID: <10851f31-632c-5fb4-a941-3dccc46e5156@redhat.com>
Date:   Tue, 22 Mar 2022 10:46:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 4/7] arm64/pgtable: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
References: <20220315141837.137118-1-david@redhat.com>
 <20220315141837.137118-5-david@redhat.com> <YjIr9f9qaz4xITVd@arm.com>
 <20220321143802.GC11145@willie-the-truck>
 <ea570f92-f896-7f9b-91c4-ad0a025bb340@redhat.com>
 <20220321174404.GA11389@willie-the-truck> <YjjDlajNUdHgOOWM@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YjjDlajNUdHgOOWM@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.22 19:27, Catalin Marinas wrote:
> On Mon, Mar 21, 2022 at 05:44:05PM +0000, Will Deacon wrote:
>> On Mon, Mar 21, 2022 at 04:07:48PM +0100, David Hildenbrand wrote:
>>> So the example you gave cannot possibly have that bit set. From what I
>>> understand, it should be fine. But I have no real preference: I can also
>>> just stick to the original patch, whatever you prefer.
>>
>> I think I'd prefer to stay on the safe side and stick with bit 2 as you
>> originally proposed. If we need to support crazy numbers of swapfiles
>> in future then we can revisit the idea of allocating bit 1.
> 
> Sounds fine to me. David, feel free to keep my reviewed-by on the
> original patch.
> 

Thanks both, I'll add the following comment to the patch:

"Note that we might be able to reuse bit 1, but reusing bit 1 turned out
 problematic in the past for PROT_NONE handling; so let's play safe and
 use another bit."


-- 
Thanks,

David / dhildenb

