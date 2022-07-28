Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4BA5847D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiG1Vpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiG1Vp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:45:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF2A2FFC9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:45:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v18so2902046plo.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=syTibly++ru0N5dyOkn/AFiof+YpFKyPJXjkdOxn6gY=;
        b=L3hxNosa6HA4NUd9AdAGbBt8zqIgmzSokN+t1MndZ5DH+YwDHtTfwjQ7ysWwnOQu6U
         egZdf6+7EyjXaFe8p/GKWXn8F0H28Ca6aTuWXhOncQugzVRY7tt/l0KTPDx4j1yBxsWK
         E49Vyt/Z8IBHE1uHPCIvfiV1tH2r9WVENn9uiVQuLzc8vunUHnqf3qUrNj44eE2rLws6
         RXyOv6WOCR3tsS0OuyVcYEdEBXqUUFr6v9FxyaOwGAg4Y8XlWcfUYCSq/vk6Y6jhZG/u
         Mz1IGyYWm+1WWkTEwb3VTI5ZrVMF7ALXOpCZQrvhwaQWGQHwpSFM5L43t3BqBH4+BmTG
         ymew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=syTibly++ru0N5dyOkn/AFiof+YpFKyPJXjkdOxn6gY=;
        b=rXpWRIMiwY06fKxlj9QETSo8j+etBhwIXB7rjRIESsz+pC+epYztbIMUjNbYHUdaF2
         MMvIiUDlUPwtBf11dcgqdCq4p+/PhODRd4yfOa38TgBL1yokh9N2C+HsVDq3qYM9NQ4h
         pJSpRx2P1X+IjN1beMdCcvkXJUVUJzqVe/vyW48A4xVDAB+D5M4H1/iG2o65PzJCj+JG
         TWZTqCTFC0S7S22OASD6homl1Swq8AVpEpLvj6xQVGj8+ml2edVGfXtbaTZ4KIouajkq
         rI/DIRHQLy3cr1z0UO5NQ6LLNpTlwLj6HWKCNm6AqXRnq1AW5HkNhTDglfiFsyjNqTll
         gHIA==
X-Gm-Message-State: ACgBeo1wvB8Jn+FdglTPxn4PARNOL9SeiJ5es6Oe2AYtYtmAf2KMsHQ/
        LTLAAd7edfD3xQzziTdDGVW1qA==
X-Google-Smtp-Source: AA6agR4eChmymv69Y/dyrU+TW7AUx28+KYMTAoj0VCS7id8iD24Ny/uX3oO4MgWwj+9zXsJk8i8qbw==
X-Received: by 2002:a17:902:f70d:b0:16c:50a2:78d1 with SMTP id h13-20020a170902f70d00b0016c50a278d1mr784242plo.34.1659044725833;
        Thu, 28 Jul 2022 14:45:25 -0700 (PDT)
Received: from [2620:15c:29:203:7a4b:8126:8bad:d042] ([2620:15c:29:203:7a4b:8126:8bad:d042])
        by smtp.gmail.com with ESMTPSA id h131-20020a628389000000b00528d880a32fsm1264930pfe.78.2022.07.28.14.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 14:45:25 -0700 (PDT)
Date:   Thu, 28 Jul 2022 14:45:24 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5] mm: vmpressure: don't count proactive reclaim in
 vmpressure
In-Reply-To: <20220721173015.2643248-1-yosryahmed@google.com>
Message-ID: <539ddf30-160b-848d-5249-770963cba5ab@google.com>
References: <20220721173015.2643248-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022, Yosry Ahmed wrote:

> memory.reclaim is a cgroup v2 interface that allows users to
> proactively reclaim memory from a memcg, without real memory pressure.
> Reclaim operations invoke vmpressure, which is used:
> (a) To notify userspace of reclaim efficiency in cgroup v1, and
> (b) As a signal for a memcg being under memory pressure for networking
> (see mem_cgroup_under_socket_pressure()).
> 
> For (a), vmpressure notifications in v1 are not affected by this change
> since memory.reclaim is a v2 feature.
> 
> For (b), the effects of the vmpressure signal (according to Shakeel [1])
> are as follows:
> 1. Reducing send and receive buffers of the current socket.
> 2. May drop packets on the rx path.
> 3. May throttle current thread on the tx path.
> 
> Since proactive reclaim is invoked directly by userspace, not by
> memory pressure, it makes sense not to throttle networking. Hence,
> this change makes sure that proactive reclaim caused by memory.reclaim
> does not trigger vmpressure.
> 
> [1] https://lore.kernel.org/lkml/CALvZod68WdrXEmBpOkadhB5GPYmCXaDZzXH=yyGOCAjFRn4NDQ@mail.gmail.com/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: David Rientjes <rientjes@google.com>
