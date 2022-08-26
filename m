Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EB25A25BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245534AbiHZKTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343528AbiHZKTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E349FCACB5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661509142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iK1Tn6jPwinpVDnV9ak81Ascm2YVGGH4jX+q/msRheo=;
        b=GESqazj3If8A7+WIwyCPJekuE/vYIFlOC9UjpE7qmlc/2QqPIiY0ZWDttHJ8TDyfRET6uZ
        oeLYVPXXVA7D5mloigDdx5GsUCQt/bYVJ/d9iw/ye+m+vAKIJ3yBswvMh40N/uqu0V0udR
        F3bGhLlaLMEwvDpPza5GGDtxn2vwvHo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-196-H9rZTScTPmqxsyC6X4b_jA-1; Fri, 26 Aug 2022 06:19:00 -0400
X-MC-Unique: H9rZTScTPmqxsyC6X4b_jA-1
Received: by mail-wm1-f70.google.com with SMTP id v3-20020a1cac03000000b003a7012c430dso1114939wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=iK1Tn6jPwinpVDnV9ak81Ascm2YVGGH4jX+q/msRheo=;
        b=5dyV5pE3EXoFcbY6EWMkU8Lv0vtWdXuMJpqIiMPtEHxLTDBsTeVRss2HcZEJ1ADV4O
         TrBN/CkHR3LvI1J+8U85smA+RC+oiW1LsdfQcL70RSPw13cLkQGTZ1vrUKCiId9Qkoyh
         5Ykkvr50PcpZ6To3g8mrrk000CC7kbLmGmAvah7JxXhv79TzIcVMMIeL6jn/5SNsNsIK
         SDP5YGY7vbiltjwH6dEafiCsr7UHXM4aUITOUaUvS8G66BaHpMv7XyWoWbBhBCCT6cUs
         6SqyV7g0IRADBJrGfvnm5KXo7zh7ikGMvGzcl//80Ua5hgtGWdqA9eVC6FQVbIA8tL7V
         144A==
X-Gm-Message-State: ACgBeo1y3CQXBBjSeaOKyO8TRzw94HHxv0VLxysyh2WCV55xOjKXhw83
        xJiwYzA1O8bZv2RPaGC/Yd+gluBvdGMIzLx9y8mfOfz03JVH2pd3rk11hq6XTA58hmPgMGNTVKe
        YADJUUhAsKJlBe6vGg9UnXwTB
X-Received: by 2002:a05:600c:22cd:b0:3a6:7b62:3778 with SMTP id 13-20020a05600c22cd00b003a67b623778mr4870166wmg.45.1661509139726;
        Fri, 26 Aug 2022 03:18:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR598X1MmjZ3DMV6g3DPym5yBDmE9ppM3iBECP72+NJ+flYXxutjFWYoIdUKJH+PhdkHPCiBew==
X-Received: by 2002:a05:600c:22cd:b0:3a6:7b62:3778 with SMTP id 13-20020a05600c22cd00b003a67b623778mr4870141wmg.45.1661509139380;
        Fri, 26 Aug 2022 03:18:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f600:abad:360:c840:33fa? (p200300cbc708f600abad0360c84033fa.dip0.t-ipconnect.de. [2003:cb:c708:f600:abad:360:c840:33fa])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4d83000000b0020fff0ea0a3sm1457815wru.116.2022.08.26.03.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:18:58 -0700 (PDT)
Message-ID: <ead1bc0e-c9df-d590-3423-9cfa449167e7@redhat.com>
Date:   Fri, 26 Aug 2022 12:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC 2/3] mm: changes to split_huge_page() to free zero filled
 tail pages
Content-Language: en-US
To:     alexlzhu@fb.com, linux-mm@kvack.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, akpm@linux-foundation.org,
        riel@surriel.com, kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <cover.1661461643.git.alexlzhu@fb.com>
 <490fcdd204ae129a2e43614a569a1cf4bdde9196.1661461643.git.alexlzhu@fb.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <490fcdd204ae129a2e43614a569a1cf4bdde9196.1661461643.git.alexlzhu@fb.com>
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

On 25.08.22 23:30, alexlzhu@fb.com wrote:
> From: Alexander Zhu <alexlzhu@fb.com>
> 
> Currently, when /sys/kernel/mm/transparent_hugepage/enabled=always is set
> there are a large number of transparent hugepages that are almost entirely
> zero filled.  This is mentioned in a number of previous patchsets
> including:
> https://lore.kernel.org/all/20210731063938.1391602-1-yuzhao@google.com/
> https://lore.kernel.org/all/
> 1635422215-99394-1-git-send-email-ningzhang@linux.alibaba.com/
> 
> Currently, split_huge_page() does not have a way to identify zero filled
> pages within the THP. Thus these zero pages get remapped and continue to
> create memory waste. In this patch, we identify and free tail pages that
> are zero filled in split_huge_page(). In this way, we avoid mapping these
> pages back into page table entries and can free up unused memory within
> THPs. This is based off the previously mentioned patchset by Yu Zhao.
> However, we chose to free zero tail pages whenever they are encountered
> instead of only on reclaim or migration. We also add a self test to verify
> the RssAnon value to make sure zero pages are not remapped.
> 

Isn't this to some degree splitting the THP (PMDs->PTEs + dissolve
compound page) and then letting KSM replace the zero-filled page by the
shared zeropage?

-- 
Thanks,

David / dhildenb

