Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C184523B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345366AbiEKRN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244088AbiEKRNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FE90173364
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652289232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EE9Fagjhe/kqd3S9iC2YvYzVpVJK7eXKAdqNAWFHIas=;
        b=V+nCXNPDJ8h3Ey9KSjR+gF+xpXUiWUEsQ0UNAC+Cd4kYrfHmJBForclQk9zEeaTWrwhSTn
        qB4uH+s7rUsq8Ud4iXtJLQpPSHeODg1KsrfObk4iGNaF0hgvoVnoGPxX+z5rQ1wMemZWAz
        mWoQFVYvHiu8JgMNamhzuEbJ/HIF3OY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-aPM6e6rSNUyxXTtsiO2pBQ-1; Wed, 11 May 2022 13:13:51 -0400
X-MC-Unique: aPM6e6rSNUyxXTtsiO2pBQ-1
Received: by mail-wm1-f71.google.com with SMTP id e9-20020a05600c4e4900b00394779649b1so3113670wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=EE9Fagjhe/kqd3S9iC2YvYzVpVJK7eXKAdqNAWFHIas=;
        b=tx0kxkBYuxjPUnbrckxPFd+8z8j5RnGhh/2mbymcC3G7+yEEXEZkv4PbQBOFcAdsxl
         WqjV8QAmE/A6KE7EuKa1PYvfUeNKiCZpUCnhyC8UaHT/DlpMZW9N0JJCjQZ3ucy9qK7H
         MHChFklKoke/wRYjYvjS7W+VPp049tLWU3gOnhceAOkMhH9yg74M4P+Hv2v36AkIwCs4
         hVNWz5E/IyNNr/zCovxoUEWXKFzuIblgmysu94CRE7xXL2FjQLNAlS1iySatvscOmzR/
         lOMcuxtXa7raUY7Nw7a0J2xCvtGWQjY7MN0FEXDhN4bm3D7j4uSI22mNNMdIl+cHJ9p9
         zjIA==
X-Gm-Message-State: AOAM530GADf2PatkNd0ah7XJFRxVUqv5dRroX6LgQpYLpxe0vpl/Pmjj
        wswa2/nObLr6c8ZnBiEmFbM1ILZwVPtmGymXwKDsCnHz7Fd3jtIc53z3hlJk+Rph7YnkBY3MSa9
        iBB2Mdoo7/2PC5USI0SN84ugO
X-Received: by 2002:a05:6000:1f1a:b0:20c:d84b:5863 with SMTP id bv26-20020a0560001f1a00b0020cd84b5863mr7146320wrb.277.1652289229998;
        Wed, 11 May 2022 10:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtVDDFsoc9w/8xVTQ/+hbmOEJtpXNmZ6DvqciF88VCZQENnuUJU2+YJE5rSrhhzo12JrSDgQ==
X-Received: by 2002:a05:6000:1f1a:b0:20c:d84b:5863 with SMTP id bv26-20020a0560001f1a00b0020cd84b5863mr7146292wrb.277.1652289229792;
        Wed, 11 May 2022 10:13:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:700:2393:b0f4:ef08:bd51? (p200300cbc70107002393b0f4ef08bd51.dip0.t-ipconnect.de. [2003:cb:c701:700:2393:b0f4:ef08:bd51])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c2e0c00b003945781b725sm282850wmf.37.2022.05.11.10.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:13:49 -0700 (PDT)
Message-ID: <f153dd2c-574a-a303-4f54-9e1396b131f9@redhat.com>
Date:   Wed, 11 May 2022 19:13:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 5/6] mm: zswap: add basic meminfo and vmstat coverage
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-6-hannes@cmpxchg.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220510152847.230957-6-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.22 17:28, Johannes Weiner wrote:
> Currently it requires poking at debugfs to figure out the size and
> population of the zswap cache on a host. There are no counters for
> reads and writes against the cache. As a result, it's difficult to
> understand zswap behavior on production systems.
> 
> Print zswap memory consumption and how many pages are zswapped out in
> /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

