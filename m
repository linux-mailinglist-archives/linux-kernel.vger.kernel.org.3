Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C26589FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiHDRRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiHDRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:16:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C780F5C9D2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 10:16:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x23so427164pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 10:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QHDKoLkk6GDmpCFPVivtCs2hgFz4v8Al+bShpzHhVfw=;
        b=VqJbMd6Unb+dMzpQ1YaxAmRZ3fFgtuIAqWSj3+TjBB4e0oQiM/3oxOl8xTK19I62E7
         JumT6OWo9Ht5UVP7BN7bPyC+1pTS4ylOpwKKJ6emRCWMrtR8mOuoCThcaucl6qXTb3bm
         wcjqg/igMmjOQa8+VkEPOnssCigJzylCu0SKGRCqV9HUECfTu7uPDCTvAIufFaxAVD51
         qZDeRRK17bN+lMTkt4LLmW3tHQOTnjODwjkT/aGU2Y/VFsWlunNeayGzyOjDe9tE6Kpv
         ar5PmjCYZndk/cHfxHYhkUW58IUzfbUdnylw4DfVkRCtoclRdUBV99J9491vPZCLxxwQ
         +tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QHDKoLkk6GDmpCFPVivtCs2hgFz4v8Al+bShpzHhVfw=;
        b=zuFeXHQb5gKA7RdUG6LXPxrl10hN2b/ARW9aidcEINXWvjST28gkD3oaPx6PIDPddk
         alt8BOLX6YyXW5JkmWdCThlwgMsrmtUWIvYGfQO5rM7F1nlRuICQT1jjRtjhzW98mjLb
         V4GkTw468P9Qu4Gi7aevEwYaRCKNo7OZhnBCBtnNZsvxdekXtZahyUZwIv9Z12VtAziQ
         E6MzW5Tgde456Lmlv+1HLhNa+PSaG3ZyYhYk950fiFFgJCFSLnbglLrBMUF2a31F6dT7
         p8TUY7WVpWsw4fx3k2bn/2dt0L0FdCo76Ctbuj0j5KJXgVaJmsMcOYVpvVazRNyxGaC3
         d7EA==
X-Gm-Message-State: ACgBeo3yVUvxctJY2kTyOTAf68c8EsFGVuBV7JFYZSuVHfq5/a8/2RI5
        kRi2pY2iKhP3z1RbEz0sToY=
X-Google-Smtp-Source: AA6agR7u9s3VhH6I4fg6XbCQBSObT3COgDyRm9I5NQPZb+wLdfqVv9G0l0QVaB45S9rdZISkc8gLwQ==
X-Received: by 2002:a17:90a:fe92:b0:1f5:1b0b:1cd7 with SMTP id co18-20020a17090afe9200b001f51b0b1cd7mr3092551pjb.197.1659633414088;
        Thu, 04 Aug 2022 10:16:54 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b0016d8b0dfd61sm1179202pla.178.2022.08.04.10.16.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 10:16:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] mm: Remember young bit for page migrations
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <Yuv811AnT9aoBxbH@xz-m1.local>
Date:   Thu, 4 Aug 2022 10:16:50 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <40FDA6B1-EB53-484D-91A0-323606199C4E@gmail.com>
References: <20220803012159.36551-1-peterx@redhat.com>
 <20220803012159.36551-3-peterx@redhat.com>
 <EEBB9DDB-3D67-42BD-BD16-4264F40760CD@gmail.com>
 <YuqmKmVtVYnkDF7J@xz-m1.local>
 <A53E0AC4-D171-41C1-9C2D-F8145AAB4A36@gmail.com>
 <Yuv811AnT9aoBxbH@xz-m1.local>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 4, 2022, at 10:07 AM, Peter Xu <peterx@redhat.com> wrote:

> On Wed, Aug 03, 2022 at 11:42:39PM -0700, Nadav Amit wrote:
>> On Aug 3, 2022, at 9:45 AM, Peter Xu <peterx@redhat.com> wrote:
> 
> For this series, I can think more of dropping the young bit for migration
> entry during these madvises (which should be relatively safe with the
> pgtable held, since I don't need to touch the page but just modify the swap
> entry within), but probably that's not really the major problem here, so
> not sure whether that matters a huge lot (e.g., for FREE we should really
> drop the whole entry?).

Sounds good to me. I just had a look whether the swap entry should be
checked and hit these additional cases, so I thought they are worthy of
consideration. But as they are already not handling some cases, which is
valid for madvise's hints, leaving it to later sounds fine.

Handling migration entries anyhow might not be worthy of the risk of
breaking something.
