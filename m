Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F351F942
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiEIKEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbiEIKCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:02:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1376526AEC
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:58:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 901421F9BB;
        Mon,  9 May 2022 09:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652090338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t3Nw8WzaK1PoevHun3ShSThFnKV+M2vU5e2JQiidvDw=;
        b=CXXG+hQMBOphUH1gcr22Ve/aXotZ1hFxM02RPzbepKQ7S00eaBYD5MWx1g6XREZLxWb/89
        D230tqg7UVI/dAh7GNBLQFqaFjpSYpbQ8edBQ+6JtyqonQHIiyP7LXfljBD/fr1boB3AYJ
        cMj9c7F5Xb0p9GhS/Q7FlR/csFrsYfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652090338;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t3Nw8WzaK1PoevHun3ShSThFnKV+M2vU5e2JQiidvDw=;
        b=LYmXchS2Vpa+xW5lYWRGgNfp5aHMwIbNr5po8M8YhkXu2NelWmtihaGQyoQ70zDc7hco9E
        FYtT2Xtp/b3wU5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF73E132C0;
        Mon,  9 May 2022 09:58:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2hE5L+HleGJobwAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 09 May 2022 09:58:57 +0000
Date:   Mon, 9 May 2022 11:58:56 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
Message-ID: <Ynjl4JmLXkA47U8T@localhost.localdomain>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
 <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
 <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
 <6a5d31a3-c27f-f6d9-78bb-d6bf69547887@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a5d31a3-c27f-f6d9-78bb-d6bf69547887@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 05:04:54PM +0800, Miaohe Lin wrote:
> >> So that leaves us with either
> >>
> >> 1) Fail offlining -> no need to care about reonlining
> 
> Maybe fail offlining will be a better alternative as we can get rid of many races
> between memory failure and memory offline? But no strong opinion. :)

If taking care of those races is not an herculean effort, I'd go with
allowing offlining + disallow re-onlining.
Mainly because memory RAS stuff.

Now, to the re-onlining thing, we'll have to come up with a way to check
whether a section contains hwpoisoned pages, so we do not have to go
and check every single page, as that will be really suboptimal.


-- 
Oscar Salvador
SUSE Labs
