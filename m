Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44F65331D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbiEXToJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiEXToG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:44:06 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B325168335
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:44:04 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i68so14596298qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=duLuqB8eb+MaAuTUNyV5BqcfLXI7fybo56wYzXWGIiA=;
        b=LQjPgH5pYVk+OZLBC5c+2LKzzjOPpoPsmIYf3dAjs7IR7wior+HPhi5DLXc2LN8Drl
         EoPOpIeoYB26pjGvRbHNNSnA83STJMvJOYq7RdgglpVduRGUsjLWU10mtO5H62JaXoF9
         vvdrZTi3UEoCva9nzg8aa+ette30RLNnKvAt1D0z2fJD1n7xhSZUHFvUzyk1gsVM0VGu
         pEoEpUMwmqNqgZVw0lPpHwqwyrHiZd6uvBB/uBLURbI24NimfrzoT/Ih/EthYiIFc3u+
         zvk+RxOEcP5uiATSRbIUpyJOVEjk6lS5kjo/wf6G+dhdXufA7bCE4Qi4FA0Ug0L+2n1p
         CCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=duLuqB8eb+MaAuTUNyV5BqcfLXI7fybo56wYzXWGIiA=;
        b=ZiGizB1VXdemKjTmPWeQ5KYaQq9Mdf6R9z2ecRcdeyCaYTO2hqroSSgXws292EtZx6
         rJJq9VFG6YlmWykfbOYS0DLvzg4EjXRhzCJVu28k4zQ/8bdnt9UpJIo3oKFwXRNtW200
         eqbyvJdfmfiq/FS3iEBqvFZw3JL0sTuOtdieXGHN92PnOGZuQxBKrn1SUsesNAZQ1D9D
         4AdxlhNoQFPHSnzzO5lv7jF3kRmk2MDcBopOzuOFYittLzNVJu1CmUXiKqnsspnrobiN
         ey3JA6KtE/AY+reHSXC28D4iHhC7RXH3jX2q3UUgfCvgand4515Vtb+XeTGm9FHM7VV7
         f/Bg==
X-Gm-Message-State: AOAM530vQ3Ppzm/7Y0+n6JmZx4DTER9JOX4sSoVOt+m57J9I9xweEpBv
        3a5U7KXuv+QuxC7hs6TiIwe8wQ==
X-Google-Smtp-Source: ABdhPJwTajcKtx2V/QLGvqEuTqKhR5BiouYc6FC4OWgv+ME5gp4jMrmzVH3N6vonhgCQHelCZJf3bQ==
X-Received: by 2002:a05:620a:408f:b0:6a0:4fda:b4c9 with SMTP id f15-20020a05620a408f00b006a04fdab4c9mr18131976qko.777.1653421443943;
        Tue, 24 May 2022 12:44:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id r7-20020ac87947000000b002f3fbf28826sm149560qtt.23.2022.05.24.12.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:44:03 -0700 (PDT)
Date:   Tue, 24 May 2022 15:44:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 10/11] mm: lru: add VM_BUG_ON_FOLIO to lru maintenance
 function
Message-ID: <Yo01ghDEu4KcYKpH@cmpxchg.org>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-11-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524060551.80037-11-songmuchun@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 02:05:50PM +0800, Muchun Song wrote:
> We need to make sure that the page is deleted from or added to the
> correct lruvec list. So add a VM_BUG_ON_FOLIO() to catch invalid
> users.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Makes sense, but please use VM_WARN_ON_ONCE_FOLIO() so the machine can
continue limping along for extracting debug information.
