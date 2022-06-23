Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3682557323
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiFWGbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiFWGbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:31:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4CF387B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:31:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k14so5823883plh.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K+lnUFVfXstPnVYy+cjV15iaq6D3ffH6+7K4e6MODC8=;
        b=LgiT/zOSVbu8DlsmkvdlE5W/GMhTBn2bel4uvyqqW4xmCYeIMJaQFgI5Q83yZuKEMq
         EbLtJ5MSTL+x0QiQFKvF/YNiXlz1ecF4kdPqZjrSdRIqyMgJ11gteu2YlLZ77dGf4a+O
         9pHO+VYa5MzTjne5lNQ2NLWn77Dgilw72mSQJI3Kswcxfzk4/oz4ch99nBQshelbpT2r
         WH2CaYYptKuG+SD9z/lqBxy1R1FbjSKJ0paAqW9zAm0s1T2CyGcMUqHhYNsS+8Ne3YRh
         K3oA98pkOSHvxXxNixklNe8IGjJM1ueW80gHtZ7z0wAI24wVFhSz3YAHgj7qJM/wVuCG
         nRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K+lnUFVfXstPnVYy+cjV15iaq6D3ffH6+7K4e6MODC8=;
        b=3ZbCbYSX8A25iNlHajzfJJR25Tm/L0BAtjOLMf84zVD0JMg0KuGhUOHcMr2XGlHZbt
         RgFb4X1mjWc0g/J2IPEIF2yDSuuJpa+X3T/y6lkdwst8bc1zgnSZBNl2uakQUtQSSp2T
         dFUcax1hqUjNmnhgpaOtXLY9BCFZuCwi7Tf3LP57laugug9Z2jm6FScKJwC7hg0TxGWi
         q3kgDz5UU4V0/7YlXQ10VmIZh3/sOkhOFv9FsLQR9WQZWCnVRmusA/4rhJDjFYa/PYLr
         KSX6JJ9aC1ykywGD+4IajE1rcdzfVTlLN/0k3BFkx30Uw2loaSpD5eRY9YyunA6d/HtC
         FIzw==
X-Gm-Message-State: AJIora+vyxn5aFLJPvwOxgMXdVdzMSkTx8nsauDSgV5zYBGyYl7Y+v/i
        ZFEiRaAFLGc7V5H0EyEs2sBMeQ==
X-Google-Smtp-Source: AGRyM1vf5MWvuURdoj7IhD5MZD5R7X4Z2Vz3WcUbfQax2xFKpwWKeQk80mu2YFqT2Z+yXVedDqoGVw==
X-Received: by 2002:a17:90b:180b:b0:1e3:2871:6be3 with SMTP id lw11-20020a17090b180b00b001e328716be3mr2379262pjb.85.1655965861613;
        Wed, 22 Jun 2022 23:31:01 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id d21-20020a056a0010d500b005251c3e7ac5sm8665813pfu.166.2022.06.22.23.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 23:31:01 -0700 (PDT)
Date:   Thu, 23 Jun 2022 14:30:55 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] mm/huge_memory: use flush_pmd_tlb_range in
 move_huge_pmd
Message-ID: <YrQInzK5g/NJMmSA@FVFYT0MHHV2J.usts.net>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-2-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:12AM +0800, Miaohe Lin wrote:
> ARCHes with special requirements for evicting THP backing TLB entries can
> implement flush_pmd_tlb_range. Otherwise also, it can help optimize TLB
> flush in THP regime. Using flush_pmd_tlb_range to take advantage of this
> in move_huge_pmd.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
