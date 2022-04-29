Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01AC51487A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbiD2Lrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiD2Lrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:47:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F4CC7495
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:44:18 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id r9so6884081pjo.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EkPpqVJFZwtWuFEh4cjXyyHHD2JdNkeuaKvQxOerGLs=;
        b=UiTgjpBDLYNVb5S2HJ7JkqhnXTLajN0F89ea627idBHei/lCATFHimuuXRKJrI7VP1
         hXd7YtHmJfxGyoIYThnjXVLHYbsWVstByJN/HBzblqHJmwTxONK1aH8TlhMIUEt+J9JL
         Jvj2ubAeOBdbV9dq8oG8yygZ9JPthi8vSkNDCX94aI4sEhLujFDd+HRF55Ml0m06TdkX
         I6Xj25mlJ0iyRn7ETPC/BZk4FHDDb2OOBnDcodFk6gi47HGtXFbrvtnl7TQeEoom11lr
         HZAz2r2JE0eZk/RGC0m2KhI7rmMDlVncQ6eLOBDh+9jdIJ4jcDL3YARyrhK3+hqz12g4
         Xu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EkPpqVJFZwtWuFEh4cjXyyHHD2JdNkeuaKvQxOerGLs=;
        b=Be7b4UczUdvPLRfF24H6M2Vu4gLgXlssMHJXH/JdGPUhtbqUf1zbge40sxL/im+vSc
         Xmvq/Bx5/dUYKWUeqH1RL77VU2SRNekl3u7bkbKnXtu+dR0ZBeSIFKuSiH/tUX++xk4j
         r0kfR2P3MOPg0dHAqZPiZHwlMOarqw4qHeel6BO6/9REtLQQsVoDYIEGvharKB2B6jIL
         FyX/MJXVa9WkGcMgiLrMohuzoCUopmkWJj3frXNvAFoAAG1iQP6b71gQFSPSRkTgR06L
         CwxX6O3n9IEcBrMH1BP0AEARtoybpuvoSIROLWUjmZU6w2ycMMX9w69a21sphD43Fq2A
         rJ1A==
X-Gm-Message-State: AOAM532vQ5KWzebTUzqn19V5ttWVhQ5H1gmxMTyg6PbdiV3MMbE2Zy0m
        8S1uji17sdc1b7s8IFvPHFsqEQ==
X-Google-Smtp-Source: ABdhPJzBsgHH4J5QAo+Gn1X23WEJ7Tm2fIjGmg7YoFqHNQUGWoo/feizs2yfyHBrgsdv6ewosE17vw==
X-Received: by 2002:a17:902:e84b:b0:15c:fee2:aeb6 with SMTP id t11-20020a170902e84b00b0015cfee2aeb6mr27576901plg.128.1651232657669;
        Fri, 29 Apr 2022 04:44:17 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id u14-20020a63470e000000b003c14af5061esm5653739pga.54.2022.04.29.04.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:44:17 -0700 (PDT)
Date:   Fri, 29 Apr 2022 19:44:14 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Peng Liu <liupeng256@huawei.com>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, liuyuntao10@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, dave@stgolabs.net,
        wangborong@cdjrlc.com, linux-ia64@vger.kernel.org,
        adobriyan@gmail.com
Subject: Re: [PATCH v4] mm: Using for_each_online_node and node_online
 instead of open coding
Message-ID: <YmvPjnjufx+XZxN3@FVFYT0MHHV2J.usts.net>
References: <20220413032915.251254-4-liupeng256@huawei.com>
 <20220429030218.644635-1-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429030218.644635-1-liupeng256@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 03:02:18AM +0000, Peng Liu wrote:
> Use more generic functions to deal with issues related to online
> nodes. The changes will make the code simplified.
> 
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
