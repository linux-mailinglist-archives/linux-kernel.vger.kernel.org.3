Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D575A9D15
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiIAQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiIAQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39A82B1A4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662049809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLuHDLzRcMC/7r5bScPI3onM/CzOE/9m3NqNJ3imxUc=;
        b=c2npPZb1P8vtt/oudm9vgbPXpeR1D5225HEu3X7lTQSctcckOkcf8ELuqEZezS42HwnQYW
        a4QbiX5zLiZY4BrNMk/x6nUqKLr7Jh5ZeRa+ynUTS6afEqztpvafiaXbsOzpn2LGfM1VP1
        7HooZ/N7QviPgzWKnsVhnrF+19nGrSY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-65aOLhJ9OAuIfSwc1NkFqg-1; Thu, 01 Sep 2022 12:30:08 -0400
X-MC-Unique: 65aOLhJ9OAuIfSwc1NkFqg-1
Received: by mail-wm1-f72.google.com with SMTP id v67-20020a1cac46000000b003a615c4893dso10062528wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=fLuHDLzRcMC/7r5bScPI3onM/CzOE/9m3NqNJ3imxUc=;
        b=hk5u8wFXz2s2AW+jHdKtZCSp7l/CPM0kySfYNYcDatA1AH//kpKfENldKifmMKLWV1
         6rWvtfAaxyYgqbdyKQc+73Sj7niek1oVuSFdpl+hflXJ+8dTL+LnIjivt7luiZN871A9
         OSvyBWqWI154RxCgWLYuAJ0J7pQLz0shpa6M7yCuowojnMINXEHn/4H4r+OK8Q71lFEx
         BZ8OCg0yLjEoAG1gPXv0s9JZKF99WArIL5ciZ91bbKJaMdyBl/3lyPw1C209vPL5LlN5
         BUndgW9Sgw0qfZMINgL9Bs6Kuzew04Xs4LXRreaphgJIJSmqS7xyX9hAt5MjCzCgmhk1
         Bd3g==
X-Gm-Message-State: ACgBeo3QcEMDXixGrAXs2Wdq50jgdR9Exa7jybf2FXJWb0K5KowRhDwQ
        Nj2cB9W93biF763G0QdGBF4rZH3iKcar1s0EfOwk17LBHmtQcViifTi/CU/bHwBlLZbBV4HXut1
        0NPfcz4lR67LTE7U1hrHiHtVt
X-Received: by 2002:adf:ea51:0:b0:226:dd73:8b88 with SMTP id j17-20020adfea51000000b00226dd738b88mr10662029wrn.175.1662049806702;
        Thu, 01 Sep 2022 09:30:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5NJHbqnyKjsbcgDD2m9PqfCb+kWWILrc8Jstl6MuxgmJZniixWAO/kTIg/6AMvhAbZ+lXBcQ==
X-Received: by 2002:adf:ea51:0:b0:226:dd73:8b88 with SMTP id j17-20020adfea51000000b00226dd738b88mr10662013wrn.175.1662049806449;
        Thu, 01 Sep 2022 09:30:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b003a5b6086381sm6575410wmq.48.2022.09.01.09.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:30:05 -0700 (PDT)
Message-ID: <8e566857-d552-86f4-cbbb-5eed9de6acca@redhat.com>
Date:   Thu, 1 Sep 2022 18:30:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>
References: <20220901072119.37588-1-david@redhat.com>
 <YxDZ86XW3hPcJtPX@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
In-Reply-To: <YxDZ86XW3hPcJtPX@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.22 18:12, Jason Gunthorpe wrote:
> On Thu, Sep 01, 2022 at 09:21:19AM +0200, David Hildenbrand wrote:
>> commit 4b471e8898c3 ("mm, thp: remove infrastructure for handling splitting
>> PMDs") didn't remove all details about the THP split requirements for
>> RCU GUP-fast.
>>
>> IPI broeadcasts on THP split are no longer required.
>>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Sasha Levin <sasha.levin@oracle.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Jerome Marchand <jmarchan@redhat.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/gup.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> The comment a bit above seems to need touching to:
> 
>  * protected from page table pages being freed from under it, and should
>  * block any THP splits.

Ah right. Will drop it as well -- thanks!

> 
> What is the current situation for THP splits anyhow? Is there are
> comment in the fast pmd code explaining it?

Not aware of a comment, I think it just works naturally by always
re-routing references taken on tail pages to the head page refcount.

Before that, we had "Tail page refcounting", which -- as I understand --
was a mess.

ddc58f27f9eee9117219936f77e90ad5b2e00e96 contains some comments.

> 
> But this seems OK too
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
> 


-- 
Thanks,

David / dhildenb

