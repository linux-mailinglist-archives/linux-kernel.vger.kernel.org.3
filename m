Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6F055499B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353389AbiFVIbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352995AbiFVIbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA003120
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655886678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOgNTkwcAWagD+/8qHv42QL8TsgA9waoElQ8wVBi9FU=;
        b=evkaqQbG9RLP9yO1TmL03Fs09k7fFX/0PRR6fjpuXQkEA3e3q5Hn/co64290oXBZktfbzq
        i4SUlfdP5Yr9UUjlIvyng4bXvRh8pYXf4oAYXa2rwkXOgthhIvIiEIXE3KXrDia74VzRbT
        f8c1cdB1vVoiIwDL+O+aRIgCyFfeIpM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-ugOwdAPbNUuSbDvQXjwqJQ-1; Wed, 22 Jun 2022 04:31:15 -0400
X-MC-Unique: ugOwdAPbNUuSbDvQXjwqJQ-1
Received: by mail-wm1-f70.google.com with SMTP id v184-20020a1cacc1000000b0039c7efa3e95so5260966wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=XOgNTkwcAWagD+/8qHv42QL8TsgA9waoElQ8wVBi9FU=;
        b=GrS3eRRRfr63AyO5aE8VF3jV3g0gZU16Vh6+Iuyo+9vOHvylyrIFREvWxw9eD6la8I
         iST0/G+uV9b4L3OU+DYtEl6ESjsLIIt/3fx0ofiae1Le6kbnikEEu/T9UcYs72dLLIoj
         9gEdQtUqYFcA9c1z1jyUwkFpd6I+ozCx5VcfmwHZ9UFOm4G7p5jM4AuA2fNyPcjMHU1G
         bgjHSWd8ear0m69h8wj8hH1KtTojgBWCeW79zWWJ2BgncsvrKv8nWJXEP0oU6QLbdhJo
         Kg+KZtkCZKh/ETe9fwmg6gzcVJZ7+Um6WqJQNgUwRIQ+cO0mycQml0MpKWO5WX9NLwvQ
         QJAQ==
X-Gm-Message-State: AOAM532qroB/EsCAQPl+La4fTYFs6QS28xfCgKGZGTIxwn1Dwj1Gu689
        47950RqUtw3Hk5mapBMz7WDW4ntvWU5VSt3qnd2dLAWK68x/7ppPuFfBFZJV6D+bKjorRkQZFyN
        hLUbIavu+ZxPsHSdLlgROSzDV
X-Received: by 2002:a05:600c:4f96:b0:39c:7bd0:d4c8 with SMTP id n22-20020a05600c4f9600b0039c7bd0d4c8mr44443166wmq.16.1655886673885;
        Wed, 22 Jun 2022 01:31:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx16lJt7BskzRi2HcEZFHzW44YMI7gnzl0NsviMBJcoc315uKONdvJnnum5f8m+18ezKwpOWw==
X-Received: by 2002:a05:600c:4f96:b0:39c:7bd0:d4c8 with SMTP id n22-20020a05600c4f9600b0039c7bd0d4c8mr44443139wmq.16.1655886673637;
        Wed, 22 Jun 2022 01:31:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:5100:9c77:ce13:2aeb:8748? (p200300cbc70351009c77ce132aeb8748.dip0.t-ipconnect.de. [2003:cb:c703:5100:9c77:ce13:2aeb:8748])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d6a87000000b0021b8c99860asm9919631wru.115.2022.06.22.01.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 01:31:13 -0700 (PDT)
Message-ID: <bb71d77e-583a-d216-1aae-2bc062318888@redhat.com>
Date:   Wed, 22 Jun 2022 10:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] mm/page_alloc: Do not calculate node's total pages
 and memmap pages when empty
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220621041717.6355-1-osalvador@suse.de>
 <20220621041717.6355-2-osalvador@suse.de>
 <506203e3-1de0-1187-5234-7afc66d4ddfe@redhat.com>
 <YrKQyhwDwMvueOUc@localhost.localdomain>
 <YrKS6aFHKRyZzAwi@FVFYT0MHHV2J.usts.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YrKS6aFHKRyZzAwi@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.22 05:56, Muchun Song wrote:
> On Wed, Jun 22, 2022 at 05:47:22AM +0200, Oscar Salvador wrote:
>> On Tue, Jun 21, 2022 at 09:44:47AM +0200, David Hildenbrand wrote:
>>>
>>>
>>> It's worth noting that the check in pgdat_is_empty() is slightly
>>> different. I *think* it doesn't matter in practice, yet I wonder if we
>>> should simply fixup (currently unused) pgdat_is_empty().
>>
>> I guess we could change it to
>>
>>  static inline bool pgdat_is_empty(pg_data_t *pgdat)
>>  {
>> 	 return node_start_pfn(pgdat->node_id) == node_end_pfn(pgdat->node_id)
>>  }
>>
>> ? And maybe even rename it to to node_is_empty (not sure why but I tend to like
> 
> At least I like this name (node_is_empty) as well.
> 

Let's try keeping it consistent. I think node_is_empty() might indicate
that we're punching in a node id instead of a pgdat.


-- 
Thanks,

David / dhildenb

