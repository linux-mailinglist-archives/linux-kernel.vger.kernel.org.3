Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD1542C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbiFHKEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiFHKDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A00AB15C8BA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654681529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNY3YF4nQhITGaj91viUklJBWc1Ac9u/YPJFCIMm00s=;
        b=QCGPiBoJdjjR1pSlnQ2ncHXjzJFj2t1A3N83/TiR1XC+ySSIp3MS886iTW55sRx5zqf9aJ
        oENYd4SGuIOW2t8mOZFqGVtLlpF69nkhcpsFmS9bURz/X2ahlGd2i0duXVBq+wu1+M5eN6
        ICHA2FCLt1WPjTblpvxqsXdm073MM9c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-EqaZ6WnlMg2p0iLo2dkk6w-1; Wed, 08 Jun 2022 05:45:28 -0400
X-MC-Unique: EqaZ6WnlMg2p0iLo2dkk6w-1
Received: by mail-wr1-f70.google.com with SMTP id w8-20020adfde88000000b00213b7fa3a37so3856022wrl.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=FNY3YF4nQhITGaj91viUklJBWc1Ac9u/YPJFCIMm00s=;
        b=nOQrAcWOIh/Da/9f2si7UEByJEEY+azymCpt5fkUIh48iTQwr1GtK4Qtfxe/ljM1k+
         bEXWNcmd5rnBeWUzvCAH6miHthYrqdPWfViqwmCbHY7dTJLOr0tK3TNbRMOyFJ+KXSkh
         q+NW5nlFECNnfq1zsAgjTswp2S9CmId5+43BexAmnqklqwFnDtAt0KnROHiPxxrdkLN7
         ZsLzkIAzvi2SaF/rTDiitNMq1+mnVlz8pMtsUmW5Pz6I9lTET6HuaRESmHDXXFUYesvo
         u7ArCGB/eYqewxo+rK1WvBVCs170oUpx1XGBXjUc29MgTmAevSBkmGD7FdcKhJDH316y
         nokw==
X-Gm-Message-State: AOAM531jEXCdMW7uPIVbLahO0NMbcV7mgbetjsQOpP7dVZdCtROID3rN
        NZosveyDNurFtWAyz+98VnpEVklGxZjb87NCZ/U+VSOW/GVWZWd6FtM8asXe7iQnvJbDLx8rsSi
        FtMez/wjgHe/4aClJB44fB1p5
X-Received: by 2002:a05:6000:1841:b0:218:be20:a1b7 with SMTP id c1-20020a056000184100b00218be20a1b7mr1223598wri.390.1654681527421;
        Wed, 08 Jun 2022 02:45:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqEBm2yM2wf3dx+Bj76JV2ZdPBJfMilc36LWsgxJPxs2nQNzZtei8olDYiwRZUy+WMlkUayQ==
X-Received: by 2002:a05:6000:1841:b0:218:be20:a1b7 with SMTP id c1-20020a056000184100b00218be20a1b7mr1223572wri.390.1654681527088;
        Wed, 08 Jun 2022 02:45:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ad00:db2:4c6:8f3a:2ec4? (p200300cbc705ad000db204c68f3a2ec4.dip0.t-ipconnect.de. [2003:cb:c705:ad00:db2:4c6:8f3a:2ec4])
        by smtp.gmail.com with ESMTPSA id e41-20020a05600c4ba900b0039754d1d327sm22108703wmp.13.2022.06.08.02.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:45:25 -0700 (PDT)
Message-ID: <2cc99c51-0ae6-4c56-c964-ced618133ead@redhat.com>
Date:   Wed, 8 Jun 2022 11:45:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mm/memory-failure: don't allow to unpoison hw corrupted
 page
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBICjloIDlj6Mg55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>, zhenwei pi <pizhenwei@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>
References: <20220604103229.3378591-1-pizhenwei@bytedance.com>
 <20220604115616.b7d5912ac5a37db608f67b78@linux-foundation.org>
 <584eedd3-9369-9df1-39e2-62e331abdcc0@bytedance.com>
 <20220606043202.GA1328953@hori.linux.bs1.fc.nec.co.jp>
 <3b58adbf-a8b2-8dba-71a7-123ba3850c10@bytedance.com>
 <20220606091503.GA1337789@hori.linux.bs1.fc.nec.co.jp>
 <5e7abb3f-56e7-0343-a678-749b6f5238a2@redhat.com>
 <20220607145959.785e54c752f373bcc283732b@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220607145959.785e54c752f373bcc283732b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.22 23:59, Andrew Morton wrote:
> On Tue, 7 Jun 2022 14:36:00 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 06.06.22 11:15, HORIGUCHI NAOYA(堀口 直也) wrote:
>>>>>    [  917.864266]  <TASK>
>>>>>    [  917.864961]  clear_huge_page+0x147/0x270
>>>>>    [  917.866236]  hugetlb_fault+0x440/0xad0
>>>>>    [  917.867366]  handle_mm_fault+0x270/0x290
>>>>>    [  917.868532]  do_user_addr_fault+0x1c3/0x680
>>>>>    [  917.869768]  exc_page_fault+0x6c/0x160
>>>>>    [  917.870912]  ? asm_exc_page_fault+0x8/0x30
>>>>>    [  917.872082]  asm_exc_page_fault+0x1e/0x30
>>>>>    [  917.873220] RIP: 0033:0x7f2aeb8ba367
>>>>>
>>>>> I don't think of a workaround for this now ...
>>>>>
>>>>
>>>> Could you please tell me how to reproduce this issue?
>>>
>>> You are familiar with qemu-monitor-command, so the following procedure
>>> should work for you:
>>>
>>>   - run a process using hugepages on your VM,
>>>   - check the guest physical address of the hugepage (page-types.c is helpful for this),
>>>   - inject a MCE with virsh qemu-monitor-command on the guest physical address, then
>>>   - unpoison the injected physical address.
>>
>> That's triggered via debugfs / HWPOISON_INJECT, right?
>>
>> That's a DEBUG_KERNEL option, so I'm not 100% sure if we really want to
>> cc stable.
> 
> Sure, it's hardly a must-have.  But let's also take the patch
> complexity&risk into account.  This is one dang simple patch.
> 
> Or is it.  Should these things be happening outside mf_mutex?  What the
> heck is the role of mf_mutex anyway?

For example, I'm not even sure if we're allowed to use virt_to_kpte()
out of random context at all.

If we have a PMD direct map, why should it be okay to use virt_to_kpte()?

Maybe I am just wrong, I asked that question on the next patch version
as well.

-- 
Thanks,

David / dhildenb

