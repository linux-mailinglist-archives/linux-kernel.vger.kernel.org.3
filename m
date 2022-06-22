Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F05E5540C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356412AbiFVDJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356386AbiFVDJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:09:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347F02E9CB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:09:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t21so8592316pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qeFLGzKyEitMeyLAF5p2SS4hTRAjoU69UDSP6vdWSjY=;
        b=p2wwgxhu9ut5UKfrtDC0rPYOS8CGYB4DZKXrTV8Z6vFZaGsCErBuey217nlClTv6sL
         F4xbgHt4MjpUrGsIfxCNeQqcdvLLcCo8zQRCZPoMa/FSPeUWBDmMVga+VitfhQKbIXKs
         RWirpynPoN/X+YpCHLmDmw67sKTa0bl3A0lzfyzEG2A/lyGOcWItAYsfTznkQRS6SQ/+
         /8m20H/hLi2E1/xgjLH9iLLvl+XnO3MrlCz8jZtna9qWwcAWVOrl04NY+SUT/ceAJF8j
         XhTyy6Yr4uf1yihCeZwvc3UQv1ubTwxn9/GHyyMgo+h+0pPS4enGayVOVjCuAKzF8Vkn
         MNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qeFLGzKyEitMeyLAF5p2SS4hTRAjoU69UDSP6vdWSjY=;
        b=xSAX2R0IYpInt8CO88u1IcgPRjvVIzYp7y+mMpDr6Af/r+13ABSLvUkChC+wJ0o/+L
         uCpm6cNFz2mZ7rnL+qxigI9rWUiOVpSvSVMA7bY/gGTKGq3bMZgT+igKzVqmMzrizVb+
         FjlnNJoPo7Vzza8wzJuUtu94zPz7t3ksUGmEuQ9qHfzYnSg06YcSYRpHD0ETdYekctRZ
         eG72nyukhxR86rl8a6RMfCF9huuXQjmMu0OGiwqNvSGXiqbtCzuzPHfFRvsB6MX9n410
         QZsGQwgGc1c+Ad3ElQ5031i/0bwDKMQTW/qyakUaKMOSi52uvArutrlEYq1oQJC77e3z
         GsOA==
X-Gm-Message-State: AJIora/Z5pmDyEu0FbNZ0yk53pAReDXeT9uJ987R1nK8nvEJJrl3VlAq
        NzmQLHCtRYDGsADVic1FAGTV0w==
X-Google-Smtp-Source: AGRyM1v/MjNT/bnm9g6Ofg4xP2CNsIToPVWuYeLOj+RxjCRuiNQqo1YZVEhQtNsoecrOZLGUHppubw==
X-Received: by 2002:a63:68c4:0:b0:3fb:984f:6779 with SMTP id d187-20020a6368c4000000b003fb984f6779mr1066855pgc.444.1655867361716;
        Tue, 21 Jun 2022 20:09:21 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id x16-20020a17090a165000b001e667f932cdsm13118167pje.53.2022.06.21.20.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 20:09:21 -0700 (PDT)
Date:   Wed, 22 Jun 2022 11:09:16 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, mike.kravetz@oracle.com,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Use set_huge_pte_at() to make huge pte old
Message-ID: <YrKH3BlKA6sKdLbd@FVFYT0MHHV2J.usts.net>
References: <1655692482-28797-1-git-send-email-baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655692482-28797-1-git-send-email-baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 10:34:42AM +0800, Baolin Wang wrote:
> The huge_ptep_set_access_flags() can not make the huge pte old according
> to the discussion [1], that means we will always mornitor the young state
> of the hugetlb though we stopped accessing the hugetlb, as a result DAMON
> will get inaccurate accessing statistics.
> 
> So changing to use set_huge_pte_at() to make the huge pte old to fix this
> issue.
> 
> [1] https://lore.kernel.org/all/Yqy97gXI4Nqb7dYo@arm.com/
> 
> Fixes: 49f4203aae06 ("mm/damon: add access checking for hugetlb pages")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

The changes make sense to me.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

