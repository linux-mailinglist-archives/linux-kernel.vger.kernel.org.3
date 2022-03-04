Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6514C4CD4DB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbiCDNKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiCDNKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:10:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E02371B50DC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646399343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jV96QDQfXFziaL0vRlxFYke/x+ja4OWA5o4UOaANEss=;
        b=K6aGf5Zx4NTarbSWY0l61NbtzpWz1bMEhHPWCRZBzZAqK/aSSeVmzE3WrMBTqYUaTDXtxY
        x6zMwtXWlIZVQj6v2AXS2Q3Pf4tJ/WCIfPhQP8zKeF3luU5gB5rREF5+WBOabcTU2JRQZw
        G6EzbjhX3a7M5Qs4FpkNL2XwFqbDFk8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-JsxlKjzdNo6ctDD6dyUyAQ-1; Fri, 04 Mar 2022 08:09:00 -0500
X-MC-Unique: JsxlKjzdNo6ctDD6dyUyAQ-1
Received: by mail-wm1-f71.google.com with SMTP id 187-20020a1c19c4000000b0037cc0d56524so4135501wmz.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 05:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jV96QDQfXFziaL0vRlxFYke/x+ja4OWA5o4UOaANEss=;
        b=u2Ev7XuGfclbBUuh9R3lFWgX7hruAeqCcQszV2I5GCDOJYrnNpubTfuSbLTMlfSAwJ
         ylWXdQacSxst66nnXGP2QF57LgMECLmDeDB6BOzbFA2DBPxBHFSTSAyjvzNtmNpRpVwB
         EqiguPsjtBs8TlYFscXZCyhNG2pHq/2C9FItI1cf1NIG0IwDgDjj3G5OFE0LCoS1+xQC
         qNZC5529FysTw4jhy4gwXlAtv0dEbuqnX2xp7q1tZ+4qRvihUWVJ2tmk3ZsRjPmBTRnV
         o0lYXMAbB4s2i+Y/fjzB0ZWAmcUfT2l2RdYSOOjuDaH84h6+81RZ+eTfrEEkKsa4ChBI
         ZCww==
X-Gm-Message-State: AOAM530IuWErpskuUESuyjVPp8R5wKV9oRscsV0+QXHoBzi4rnnY2ro4
        CglOJD6UQddpq+U3CeSfe7h7uO6vsCL0ahozlC6RM++MpJf/d7DEsDH65ACU3kL+oy71FInpwVa
        zykGtx6jY1UqjkzgRwb80Z0DV
X-Received: by 2002:a5d:4dc4:0:b0:1ef:7aa9:5a8e with SMTP id f4-20020a5d4dc4000000b001ef7aa95a8emr24348666wru.168.1646399339606;
        Fri, 04 Mar 2022 05:08:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTMqwe4LsUwaoHrcsvjBPAt9as9hy5C/Ekyk/47uS9Fy4qmMvnToGpILbP7mlm9PMiAlnQXQ==
X-Received: by 2002:a5d:4dc4:0:b0:1ef:7aa9:5a8e with SMTP id f4-20020a5d4dc4000000b001ef7aa95a8emr24348658wru.168.1646399339359;
        Fri, 04 Mar 2022 05:08:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:4600:7355:df2c:f6ff:94d? (p200300cbc70946007355df2cf6ff094d.dip0.t-ipconnect.de. [2003:cb:c709:4600:7355:df2c:f6ff:94d])
        by smtp.gmail.com with ESMTPSA id m10-20020adfe94a000000b001ef57f562ccsm4501764wrn.51.2022.03.04.05.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 05:08:58 -0800 (PST)
Message-ID: <d67e9c8c-fa82-3ce4-1894-f2ad1779d834@redhat.com>
Date:   Fri, 4 Mar 2022 14:08:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: madvise: MADV_DONTNEED_LOCKED
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "dgilbert@redhat.com" <dgilbert@redhat.com>
References: <20220303212956.229409-1-hannes@cmpxchg.org>
 <YiE3do4qCmJ6RsmP@cmpxchg.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YiE3do4qCmJ6RsmP@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.22 22:47, Johannes Weiner wrote:
> On Thu, Mar 03, 2022 at 04:29:56PM -0500, Johannes Weiner wrote:
>> MADV_DONTNEED historically rejects mlocked ranges, but with
>> MLOCK_ONFAULT and MCL_ONFAULT allowing to mlock without populating,
>> there are valid use cases for depopulating locked ranges as well.

Indeed, there are. I'd have use for that in QEMU for virtio-mem (which
uses MADV_POPULATE_WRITE+MADV_DONTNEED to dynamically allocate/discard
memory in a sparse memory mapping to be used by the VM, currently
doesn't support mlock for obvious reasons).

Further, QEMU postcopy live migration handling requires an munlockall()
before registering the uffd handler and discarding all RAM via
MADV_DONTNEED. Once postcopy finished, we have to mlock() again. I
didn't check if there would be more stopping uffd from working on a
mlocked region, but this would be one piece of the puzzle I guess.

-- 
Thanks,

David / dhildenb

