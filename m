Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31F358975D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbiHDFgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiHDFgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:36:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BBD4D4E6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:36:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x10so17685469plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 22:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=t7lbFj4Rs8t7sIwySKc3fC7UKl81tEI+QoQd6Zyqhzc=;
        b=7wQdto35gKNdGRbQVQD5Va63j/qcvZzI3WhdH5fWIFVQK6nvqeoDlCTofv+cllcDo3
         OalQoTZt9vBhiQ7j1lVQwXnZ1rpYA/1r6JeMthLZlsLdjKGibw76HpCn0DoV8NBEzoL5
         VCjGXBpEfDQimUBA/wqjoQiXK+DkSW2I72PyH2oAgpop4qElvUKSmsT2YIdKwQNliLHK
         y6D8S9EbYbHfO7uNOFWHXtFkH7mY0ziyF7AvqruinUa0jValsPz4qROyC/K2jn7htCwH
         5Fkp1VSxRcyij4qJmyNKGU1VgrBnDFAdDR9P6ybV0v2PMZgHf01ipaFPP2j1ufT4UMBq
         DIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=t7lbFj4Rs8t7sIwySKc3fC7UKl81tEI+QoQd6Zyqhzc=;
        b=qOtIkIx03+n/xkE97mc9MLLkwzcjKl12QYPGB3H96TqWsMfSABbaC3VcFWMwNS8oR+
         q4L02tHZ0jXzPoexIBXPJTsiB9GRDCmUsvXTsul5a+J+I+qn9UlCuh1hlYlyJMqekWJa
         CXDQv2b64ZF82rlYMQmRPDa+bZ7DoAirkbsOV7+lUX9Utm2SLu8RyNG/99xJWN574+Lp
         +YFdYNgSzXwl+91vkmPoH2uCsJwvwwsElRiull04h6PWB9OBZCugFISb/zdUZicS3dm9
         B8adtq+RCOlXAEenmED/Jm2e6Y0oyjqpGU0a/EX3bDLg6WFcQ6di7lYmvAMBWUNccUw7
         yfFg==
X-Gm-Message-State: ACgBeo1156Ks9slpF6JvkdLfMt7MiJwT9Fz4n6iOKL+/iEyZTMus37FR
        KsG9qUUhg1ImZOWTrCSutZdmndBBNtzY5kvdCZRpMg==
X-Google-Smtp-Source: AA6agR7HE9LpII7lH0WEJnMYS1UnBxjACt6yh517TGTHhAqrnucIqU7WhLQNvCAUBdTRVZC6zunjsaNwdEeh7+mgq3M=
X-Received: by 2002:a17:902:b617:b0:16c:bd91:22eb with SMTP id
 b23-20020a170902b61700b0016cbd9122ebmr305710pls.108.1659591403990; Wed, 03
 Aug 2022 22:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220803025121.47018-1-wuyun.abel@bytedance.com>
In-Reply-To: <20220803025121.47018-1-wuyun.abel@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 4 Aug 2022 13:36:08 +0800
Message-ID: <CAMZfGtUOgbLGxpZKZxS2fAk5YbtCd9R43Ske-GEW6NKG_YjxVw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: only search higher order when fallback
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 10:51 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> It seems unnecessary to search pages with order < alloc_order in
> fallback allocation.
>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
