Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE114F7F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245454AbiDGMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244128AbiDGMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:53:06 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38BB21799D;
        Thu,  7 Apr 2022 05:51:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::e2d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CFC736A2;
        Thu,  7 Apr 2022 12:51:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CFC736A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1649335863; bh=ed1Yj2sHuJcCEx/tFjo0LHfX5lvHuxVzLRNxW1ZCHkY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AApfQ/rMNBOyVzv5HogVzu9LOs5/bbm/28NxoRP3bLqI6djr/QVWkvi5Fo33hyocE
         q0x2QKNOKpZnUwsoMVf95v03EtGhWc2qHPSyDsiUNAnMDNQJQtFESCYrkOZBborm87
         EpEl1O7XnUA/cqmkxDDLFVZY1rFvbhFkfBBLmOx0UPAmttf7u0C/h1jmmXy9e4eK65
         RT6QE1JXqirnBs1hCI3lMDZ5YI8/7XdpyCiaYMxxR9+pTq2O/F1KrjJYZnTEF5NmHE
         fAR6RHcif4P+tb4BdP5G7Y5bzmSy5WbH+XkwHvt57nrOgqQEews2GB0oUAzTb+7pgb
         Ekn7cTHAxopsw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 13/14] mm: multi-gen LRU: admin guide
In-Reply-To: <fde38982-a816-567a-3abb-370ec294b2c9@gmail.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
 <20220407031525.2368067-14-yuzhao@google.com>
 <fde38982-a816-567a-3abb-370ec294b2c9@gmail.com>
Date:   Thu, 07 Apr 2022 06:51:03 -0600
Message-ID: <871qy99hvs.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 07/04/22 10.15, Yu Zhao wrote:
>> Add an admin guide.
>
> Why this documentation be added to admin-guide?

It appears to describe various parameters that a system administrator
can tweak to affect how MGLRU works on their system.  So the admin guide
seems to be the right place.

Bagas, why are you questioning this?

Thanks,

jon
