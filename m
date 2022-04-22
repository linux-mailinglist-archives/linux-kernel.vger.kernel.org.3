Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDDA50ADB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443324AbiDVC0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443316AbiDVCZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:25:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96B49698
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:23:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d15so7739308pll.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/r6xw+gj3ZTku8Ban2Ty+342ukm24iTASQaEDp2KNQM=;
        b=Ib8b5bLDkA26LrA6dCcYGi19rtQ+3Mrl6DdFt3V0pfQltiTIh6katrX1tWJQA7hCPd
         41Ga7W4SB7elDpM08p0ULKc3OfwLM6N4aOwQPVAfvEhJnVZiiNDQYp9a+gv/dEQ/GO75
         C/Y0//i7ekOZj7Xi+eB06n63ANAWPwLyckiVSNQynddV6XvJSIcaiYOEP2mvAmjIZKyu
         BvnD/t/fseEXFrc45GU4xVEBEun6biSDbiELpy+XpCabvEPJ4OUYK+VQM/XB0NiUytoC
         Wno6y/lSbCTrO5OY4/A7HcRrEmE8XfnxzYt8dHvQa7pcRY2iAgGWzRo1ydNtrNOaZ8XH
         1SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/r6xw+gj3ZTku8Ban2Ty+342ukm24iTASQaEDp2KNQM=;
        b=nTWCxV4MxdKtVOtnUemdN8urrx7VfQnRrboXmudRLFvg6uKT6peuXrq61KOTtmu4D+
         4azxpHzfq09QbvFMChrO91PVqWgl6672+oUvFYRzCOR+WBBrddgZCG9pug91dKtaRcwE
         LDS4MKQh0WzrFGL/cZh+YY9Ac5FO1vXC19TBOksOpDurxy7hePlVCTtiI2HiB3nL9Mdk
         pIqWhRUwkHLGy5s3be771aDh+EaoEQ1thlGtRykAGFTNETgCoUN+9Gz98kDWw7Eq7Xwx
         nq08ljMxQ2XBXx4tJDMlgMx5Qmxoq3ss4kR94PVeWGjtQexW0dz6CPKgUD1KKldp9sbC
         AfFw==
X-Gm-Message-State: AOAM530YHnFO9l1rfWLIElbwB+AOSgjOyu2GlKduhhxkVgdavb7T4c0M
        /4Lq1QDkrhtEDErC66Ti4RytUw==
X-Google-Smtp-Source: ABdhPJx8bN1zOvSNsoELmBDe7+fKr70if1BlvjKWBht+eNDqttt5xN3LauEEFhE86vFppa150f4cBA==
X-Received: by 2002:a17:902:8214:b0:158:b5c2:1d02 with SMTP id x20-20020a170902821400b00158b5c21d02mr2189234pln.27.1650594186815;
        Thu, 21 Apr 2022 19:23:06 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id cp19-20020a056a00349300b0050a890c8c16sm453057pfb.19.2022.04.21.19.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:23:06 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:23:02 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next] mm/memcontrol.c: make cgroup_memory_noswap static
Message-ID: <YmIRhikdGutx6TeE@FVFYT0MHHV2J.usts.net>
References: <20220421124736.62180-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421124736.62180-1-lujialin4@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:47:36PM +0800, Lu Jialin wrote:
> cgroup_memory_noswap is only used in mm/memcontrol.c, therefore just make
> it static, and remove export in include/linux/memcontrol.h
> 
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
