Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5658A58A322
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiHDWRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiHDWRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:17:50 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380E161D68
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:17:49 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 13so1080595pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sV7vlp9vVqtESovTZq4J4qUrClPc07IPwMZZmtZmWxI=;
        b=ED+ZBw0+7Ig7TW12P74TnVQTzI336MvtfhJaW3/mGmifFHZ9oxFUcuQS5+l9YNvlHW
         dqyC69YrgBTrNeV391PFe3DqXkzGW7qTTPasyptA8QRIObfywnF37ZqJxrYmuiAqCKpy
         ruX1JTrKF2kg1GXdbFL8PBOn0WnL/x3n0pfEBPsEYigrZKJP2HpaL8J4bIOtXanfJoS1
         I26LEWSiBilH/JCzX7NrkW0eDjoNRi459XDlqdS8yJze0KQzUEg8GL/YEi1XjWKBjNnr
         3jVP1Rqdy3TG5UWpfEJ5LBfz5GY6Ut+VMrhcgl5Xi0VwzS2uMKmgXxuT2ay0VmRqMdQL
         ATJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sV7vlp9vVqtESovTZq4J4qUrClPc07IPwMZZmtZmWxI=;
        b=1QOzLEvePWfSfuKJVn/I8V3bz2CSVLDZD9J7Pv4G/sOU0e7reXrt59UnlIak/k9ASm
         NoLcSHT0by9d+xQgJ9Im/WaZ+x6A0ONjBgEw4dI2+IXr2FbzV1VfWlPdneSzRII9AnXC
         S7bMGpTDhggF51+4ShAN6meDoh6Psvdt2tlaPczhdG65XkTlpN+H+1KXVhiUIFGkv0Ul
         WxVIEE1wmmuKqkIaizcreV+OShLx3jxMWH2lPZtOdnAXOwqU3ko31l+U0vEvkAuVOfHG
         NlIgIRalu9+H4tZM6myNlH/INM+Oj3VZYpOBCTnrTFdVRwvYraCy784Le+J0MITwTSqp
         K2YA==
X-Gm-Message-State: ACgBeo1ALq63M3AH/ZUb8lzdVwR1O/Yp8yibqlIQPdeKcOpqeO2+Cxm3
        v6vpeHE0kVpWGVjpGn+JyXxU3bW4wbSzGQ==
X-Google-Smtp-Source: AA6agR7VqNHniSYB22eSZRdF7z3geWw36RASKr2qdfYIecjIbXQT5983ohhl0dn3RY3r/bg/tonT5g==
X-Received: by 2002:a65:6556:0:b0:41c:9c36:98fa with SMTP id a22-20020a656556000000b0041c9c3698famr3287755pgw.491.1659651468390;
        Thu, 04 Aug 2022 15:17:48 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id z1-20020a170903018100b0016f0d6213a5sm1527879plg.2.2022.08.04.15.17.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 15:17:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 0/2] mm: Remember a/d bits for migration entries
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220804203952.53665-1-peterx@redhat.com>
Date:   Thu, 4 Aug 2022 15:17:44 -0700
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Transfer-Encoding: 7bit
Message-Id: <8FBBFD68-3315-48D6-B318-4AA5A170C0C8@gmail.com>
References: <20220804203952.53665-1-peterx@redhat.com>
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

On Aug 4, 2022, at 1:39 PM, Peter Xu <peterx@redhat.com> wrote:

>  (1) Page Idle Tracking
> 
>  Before this series, idle tracking can cause false negative if an accessed
>  page got migrated, since after migration the young bit will get lost.
>  After this series, it'll be better in that after migration young bit will
>  be persisted, so it'll be able to be detected correctly by page idle
>  logic when walking the pgtable.
> 
>  However there's still nothing done when page idle reset was carried out
>  during migration procedure in progress, but that should be a separate
>  topic to be addressed (e.g. to teach rmap pgtable walk code to be able to
>  walk with both present ptes and migration ptes).

IIUC, when a migration entry is set page_remove_rmap() is called by
try_to_migrate_one(), so improving page-idle accuracy should be done in a
different way.

