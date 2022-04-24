Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D048050D04D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbiDXHsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 03:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbiDXHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 03:48:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEBB2228A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:45:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c23so20350798plo.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gL5y2sIiW+TivQxmc7o7gDDW8gSuHpLVd5lzE9Konhw=;
        b=1RAraEJ5xHCWBlEGPQxmAthJmBsHyzOu5gUwW01HfgrGFQh9okpsjSVgMY4NjovnTP
         iq0XKKwHFzBsjTnUb4OsU95p1LFYOJXTZxLQSWEwFORB2lfQidbaq1bf1XBcRwxooxak
         WLhgJGwmqbHhOAFgmTRW1H6mzl4VRPmWBik58M8/RUzqgDNlcKkdUMBrbtiRoCAVmTwh
         UWuqDjER+dQCGfziwjpLytGqu94eu33fLE8cIJsSbC7pfkNs2/AOcRraKkhR7LtqpJD6
         tVxV96yuAiq81Em8tBFaoSj3TNR6yqLWmBpUwDBq3Mc0r4YMEkpRGJZSvzF9e0tAGqT0
         XejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gL5y2sIiW+TivQxmc7o7gDDW8gSuHpLVd5lzE9Konhw=;
        b=O8wcwi8I+73YC2HOgGMZFoH88Kn8sfEFww5q/B8KL+kLtrRwa+gT1iRtRcTexfBqNp
         cZ3j4VLbLkIHpzSU1TVYIFik93Esq5y43+qW36VIH1wLFCAZuEoZLWKd8IdRdtHcpCYC
         g3bYRRrF6vGHcoMGfhLvMeix1izhkXImjtdOKddMURydcX7ZijtGB8474cBniO0pUYTP
         nOJglSWwCAQokNkctARR9ult30/YZn5uuky//oGI9FdX55GXxjzvNzJngwgW7NVCy4Lr
         m7Ztshsm9RgOMorZ3hJI8NPw+6CKGyc1HugKEdPZVEgC+agt65tCqjXdUSKnV/70Ryxx
         z3YA==
X-Gm-Message-State: AOAM531DJPiAZl9vzAr9L3vhCq217JPxbxQf3RBx1ubyEGwGc0O8unim
        t2QVTMEI/zGtKCVAaIw0wPCfDA==
X-Google-Smtp-Source: ABdhPJwElLASkEbwdc2PbXhRzXiLtCOhbVZusYiyzt+/WxR/g+yEiPugE6kKCb6sdYGH6W+viCwPog==
X-Received: by 2002:a17:90a:aa92:b0:1d9:5223:489b with SMTP id l18-20020a17090aaa9200b001d95223489bmr3188503pjq.60.1650786306412;
        Sun, 24 Apr 2022 00:45:06 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id 123-20020a620681000000b004fa7c20d732sm7402721pfg.133.2022.04.24.00.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 00:45:06 -0700 (PDT)
Date:   Sun, 24 Apr 2022 15:45:02 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: Add missing cache flushing in
 hugetlb_unshare_all_pmds()
Message-ID: <YmT//huUbFX+KHcy@FVFYT0MHHV2J.usts.net>
References: <419b0e777c9e6d1454dcd906e0f5b752a736d335.1650781755.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <419b0e777c9e6d1454dcd906e0f5b752a736d335.1650781755.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 02:33:19PM +0800, Baolin Wang wrote:
> Missed calling flush_cache_range() before removing the sharing PMD entrires,
> otherwise data consistence issue may be occurred on some architectures whose
> caches are strict and require a virtual–>physical translation to exist for
> a virtual address. Thus add it.
> 
> Fixes: 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all pmds for hugetlbfs when register wp")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

CONFIG_ARCH_WANT_HUGE_PMD_SHARE is only definded on riscv, arm64 and
x86.  All of them do not have a VIVT cache.  In others words,
flush_cache_range() is null on those architectures. So I suspect
in practice this does not cause any issue.  It is better to
clarify this in commit log.

Anyway:

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
