Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D5A508C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380227AbiDTPfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380196AbiDTPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:35:12 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034963CA72
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:32:26 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id y129so1473625qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L0g4XuTRG1BcMh3P4chNByt9PFI5OL5q3B7G+owBR8U=;
        b=FyeZeZSppgey1yzrOZBduf7WJjqMTN3eBIWg8pYNMvAs9tTOORR5hdc46LLBFm9yVI
         dip3ByXQKCtJSOzon2XjnEVpF9qA2zrV3gsT1gqCetYQfz8GnqiqmF4pXEvnBxoMN/18
         uqCtX2TEgfSPJCONEWqCmNJ3b+JxscvzSSwjvpw8dxNbhR1kSk9zDkSxp4Cjt0SYi96Q
         EQkvFn7suyIaoXiDA6EStVPUtnAzUIbRr9wGoINlKuQIMbRDqCyWncR4KyS4q4NIMCHD
         RIjk6jhMit8jr7TCVELTMacuv5yq6YvUU3+ZQpiLHmK3bMPDlRn9AURlNTwyevbHlXMG
         j4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L0g4XuTRG1BcMh3P4chNByt9PFI5OL5q3B7G+owBR8U=;
        b=PVxjsmoqx9B75mINObdxujNP8zPjI3oOUABbrHO89EquNG2FWQlcZF7OKrOgAWl4Gt
         dReIGRm2sCHH/XIMFULp9x4XdLJ6r/P8NqxzYfUfRIGF7oY8NCoJWGQmVpJhzpGniOBs
         uj7M+KOAWXAosMGQxmf1X1FWWqCSCXifzJDQBFvbpTiiaycLFqYqogmt68ZYIC2P6gnh
         +U9QrhENahMlMzLUc+xNEgBgLupTYZmEEsmdqIuSsJ2kxrxnK+PE+xWRb/rgGk2cKnOW
         6Fyc+UktraoR/LEHMf/O6FQI97FPdBPqIhfeTQOH1WrAQCGxRmBpQqpTaENXRsco1Yqf
         ym6w==
X-Gm-Message-State: AOAM531y4FnccXiFw2vFwetZQbCX2RvoSnbGMgh8bxSxXruI4WyzBG7Q
        1fGqQoYqiHhDwsAVPuTqcjfrkg==
X-Google-Smtp-Source: ABdhPJzk+XJXypkAQTD39I889slmS94qjjnFfomT/oy6p5fyHYoUrBLE/w2RoCzJsicuEbeUINctKQ==
X-Received: by 2002:ae9:eb04:0:b0:69e:d174:fa97 with SMTP id b4-20020ae9eb04000000b0069ed174fa97mr3588295qkg.338.1650468744898;
        Wed, 20 Apr 2022 08:32:24 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id y18-20020ac85f52000000b002ed08a7dc8dsm1923995qta.13.2022.04.20.08.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:32:24 -0700 (PDT)
Date:   Wed, 20 Apr 2022 11:32:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alistair Popple <apopple@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/uffd: Hide PTE_MARKER option
Message-ID: <YmAnh/fgbPmTRUqj@cmpxchg.org>
References: <20220419202531.27415-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419202531.27415-1-peterx@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 04:25:31PM -0400, Peter Xu wrote:
> The PTE_MARKER option should not need to be exposed to the kernel builder,
> keep it internal and remove the prompt so it won't be seen.
> 
> Instead, make the PTE_MARKER_UFFD_WP option to explicitly choose PTE_MARKER
> when necessary.
> 
> While PTE_MARKER_UFFD_WP will still prompt to user, change the wording so
> that it'll not mention PTE_MARKER at all but renaming it to "Userfaultfd
> write protection support for shmem/hugetlbfs".
> 
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thank you Peter
