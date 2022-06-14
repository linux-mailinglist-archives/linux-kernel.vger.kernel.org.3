Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD77854B4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344910AbiFNP2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355647AbiFNP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:28:09 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD27D103
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:28:04 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A32EBC1CA1;
        Tue, 14 Jun 2022 15:28:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9056FC093E;
        Tue, 14 Jun 2022 15:28:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655220481; a=rsa-sha256;
        cv=none;
        b=b3LPzxiB0VYDThEKxI+Nbz5UxtS7gOEWEe1S4sD0plbL+yjTmg+JYbnKqfKyfJb+lK3cyh
        7vuw/bS5MJlWXjL7zUxeoWA4GE4BReXP45nE5qJSfgFPC4mLOF48nq5kLs5VpkrFvKpwzD
        M2+BC76zzlAZE2HDXJ4aL0I7qzNC7Nv3NOBAKAlxjtNM76XjmEzl/qWqElDBsxajc2dyGH
        b4VvQBaK7PLk5d0zSO7Z7UEIYC6DQxo6m/oMw2r8TA9/TZVPRPXIgzjRrijYHyBTY21BTX
        xlYRxd0UcgqxbzMK+JI5diaUDW/G+jbGoKvEUz8mZYwABwHzI96EnD7chAmgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655220481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=pLaENAuPBEwvMoIebkqcH+MInFWv6GEjcL6JFJzqg2o=;
        b=5npjehOE6E2ctpOgD/zTOsfYGCfL2Xyx9eSpPxhEf8esaBIgclGJqYHxA2U5lsUlBYA6cN
        TvpJLUiJeViP4ZIpFy3P46b/QbUIDWgAs4OSHMOKZB3t12TdQqgmeKqxdOOFF155pBl7ta
        QEK6I14juAw+fIuCQZBqm1L5/nH9S1WOfYQbclvFIr0747S45ssxmxKPQ7hSf3KkQWgsfj
        ui8B62BcQa88YGhyD0Lm2Cnzhy8VPfOdT+5HsqbCotIvUBUBAuZM/5ahMAcnNtfDt6M8mi
        TBMBupVmKmC0vPHe1zOU2N4362SZ+Jhv7iHI5cQwuFaJyYbHXo0FkP7uOerj1w==
ARC-Authentication-Results: i=1;
        rspamd-848669fb87-7n5sb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Occur-Irritate: 548a5fc51c1fcc40_1655220482165_1397644257
X-MC-Loop-Signature: 1655220482164:958609309
X-MC-Ingress-Time: 1655220482164
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.98.242.216 (trex/6.7.1);
        Tue, 14 Jun 2022 15:28:02 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LMsl33B3pzLK;
        Tue, 14 Jun 2022 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655220481;
        bh=pLaENAuPBEwvMoIebkqcH+MInFWv6GEjcL6JFJzqg2o=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Znyqx7Rbs+TlzGfKa2qxr/7bu2RxNIQSE7S/eOGTTV4OrJV1S00sjHvq1qpwMG7Fk
         Xs/PKKRhgD1oueIpU87/1sRwiN3UXu6wCVWQQfYEFLbgMrAZji/yuAigqDWf5CrUYb
         rt7LwHNUxqfxOXetRVaNhaEBV0NOqC1Rhh6mp/EM0SaqPtcUE1ogzS7Oefv3+Gi+8g
         mcBn3osxIw6Z+0el0mgiLtCyE/Ru2UWN9ztUt0g+s7LQMsivceYLVojRqUuJK3E6nz
         uCTMkjV7V2jk5KeMA46rJb9/K6zbW7ov0DuzMjTcyt0CFjuNardAzIhyp717ye/l3R
         gDOeo+IZVSqOA==
Date:   Tue, 14 Jun 2022 08:13:52 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v6 01/13] mm/demotion: Add support for explicit memory
 tiers
Message-ID: <20220614151352.6ykunpu3q2e7twmv@offworld>
Mail-Followup-To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
 <20220610135229.182859-2-aneesh.kumar@linux.ibm.com>
 <7e0b41422dbd0976cb43c2f126e9371d5e311e77.camel@intel.com>
 <48096ad7-ce6d-79b7-1edd-7e6652ab2a4d@linux.ibm.com>
 <a88bd25fc77252dee4f895f3a9b2c1f6ebb5169e.camel@intel.com>
 <87a6afmzaq.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87a6afmzaq.fsf@linux.ibm.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> memory_tier_lock isn't held to call register_memory_tier() in this
>> patch.  That will cause confusion.
>
>will this help to explain this better
>modified   mm/memory-tiers.c
>@@ -151,6 +151,11 @@ static void insert_memory_tier(struct memory_tier *memtier)
> 	struct list_head *ent;
> 	struct memory_tier *tmp_memtier;
>
>+	if (IS_ENABLED(CONFIG_DEBUG_VM) && !mutex_is_locked(&memory_tier_lock)) {
>+		WARN_ON_ONCE(1);
>+		return;
>+	}

Why not just use lockdep here instead?
