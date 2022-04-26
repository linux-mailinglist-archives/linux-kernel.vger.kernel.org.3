Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABAA510582
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350448AbiDZRhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349185AbiDZRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C39A939B3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650994480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JumK7LOjU2+9ljtUKiS2aDX11u3heSmlrGdnx7b+T4g=;
        b=MuJGiv2uBl/3gVx/Ykih+mfJiX1+6jMLcN1NbMbK6Yyh/BV1yEai2f4kM4QLVO0DoG4Hir
        g5EyPfOpPJDLW0LlyJjR8OoSO307aYdj6w1dqMwybsmx5hSuyF4JWWC61tXsOlpBQHU6D9
        yV+DOhobklMGJt4E0ZDf8NUsUmUGj+c=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-h1BQvZcTNKqb1GxZu0AV0g-1; Tue, 26 Apr 2022 13:34:39 -0400
X-MC-Unique: h1BQvZcTNKqb1GxZu0AV0g-1
Received: by mail-io1-f69.google.com with SMTP id y20-20020a5e8714000000b0065494b96af2so14731397ioj.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JumK7LOjU2+9ljtUKiS2aDX11u3heSmlrGdnx7b+T4g=;
        b=OUevENgF4XOp65n4KxOqJYHksSK3ObMCJT7w1AWExnXTBenliTydO3+VjZqufsld55
         IsSr6bHCDu80B4jsBSVkLtIpmQ687+CirGg/KkJl/p0m0tnWLtN2/soxH5Sfmup5nqpg
         N1aIyFdLIirGl6KTgticq4ifQ0f7vlSlO15IbN6wsGie0RX7alynWGBdKWZLoHywtz83
         tVXb8NwO44IvuqQjmAywiK+9Z1YXRgO2oI/ItasAb8U2DpLS/vUmxOUMlpCNnWr+KeUp
         uaHts4y5+4M8qFTX8LPt/XgzY83Uo3vJV2p4mKVLha5w2t23e3JHt2jwlXXNv8wOovzZ
         jwfg==
X-Gm-Message-State: AOAM532AYJmNguNi/bvnJ67cfc7T7kdCNPYaG5V/aGAyLfWFpatdEh0T
        ipXa23IsbZd//tbYO9/LcZEU9prXH+Dyyu58ypLPgWqgTaHge5YaZP70wmo18PKiWUIKf0Unk+4
        PnV5ZBOQ6fz6eRPfcZKqkPDm8
X-Received: by 2002:a05:6638:dc1:b0:32a:df34:e198 with SMTP id m1-20020a0566380dc100b0032adf34e198mr6587061jaj.117.1650994478306;
        Tue, 26 Apr 2022 10:34:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGjRSNQEXmwLe232lch2But7s0o5O2VkU1hxD9zj2P5Si3uIjuFd6J4A4k7tDxIBW0o2S/2g==
X-Received: by 2002:a05:6638:dc1:b0:32a:df34:e198 with SMTP id m1-20020a0566380dc100b0032adf34e198mr6587052jaj.117.1650994478124;
        Tue, 26 Apr 2022 10:34:38 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id d14-20020a5d964e000000b00657430ee98bsm9841162ios.4.2022.04.26.10.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 10:34:37 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:34:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: Add missing cache flushing in
 hugetlb_unshare_all_pmds()
Message-ID: <YmgtLProFiMsyouf@xz-m1.local>
References: <419b0e777c9e6d1454dcd906e0f5b752a736d335.1650781755.git.baolin.wang@linux.alibaba.com>
 <YmT//huUbFX+KHcy@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmT//huUbFX+KHcy@FVFYT0MHHV2J.usts.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 03:45:02PM +0800, Muchun Song wrote:
> On Sun, Apr 24, 2022 at 02:33:19PM +0800, Baolin Wang wrote:
> > Missed calling flush_cache_range() before removing the sharing PMD entrires,
> > otherwise data consistence issue may be occurred on some architectures whose
> > caches are strict and require a virtual–>physical translation to exist for
> > a virtual address. Thus add it.
> > 
> > Fixes: 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all pmds for hugetlbfs when register wp")
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE is only definded on riscv, arm64 and
> x86.  All of them do not have a VIVT cache.  In others words,
> flush_cache_range() is null on those architectures. So I suspect
> in practice this does not cause any issue.  It is better to
> clarify this in commit log.

Looks correct.

> 
> Anyway:
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

