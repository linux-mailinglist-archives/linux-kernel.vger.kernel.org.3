Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F35129B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241668AbiD1C7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241634AbiD1C7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:59:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44225986F8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:56:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so5143647pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IvwH9xbsu6FeuNLim9woHWyD9ldcfxEbIcF/eG8AgJw=;
        b=P2vJUR2qlxWOLpkcSYZd+hHtix4PhqAD8cPpOe1GZUsDrWejpdCJqLq6253y0W/c6y
         CO7ZAQH/Kxad7GkOY41UiVo3bOCYQ+VnBNeTRk18ZMjx6bzwiJNzUTfOK1KXgi8K3XF/
         VNiXmoLsEdrPKIY0TvEJWDVDu0G7LBJh1BMSPxX0ZeTG+LixGXrW2pgvLo2Jh5CU8tBY
         4SrVSVLPxy85LskI7qAZkuXtyAG+vAPb6OPfV/aa6Nvq6tpFegpoDK75XMqqUE6j/osV
         t0NVdb3KjKJaVbkGJ98KigDHRRIMCdkPqkhaY7Icr+7GaOY0FX/a4BEhGBv1CvyBhPLn
         On9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IvwH9xbsu6FeuNLim9woHWyD9ldcfxEbIcF/eG8AgJw=;
        b=b27NRE6ot/onZhlObkuquHO5/hm+oB456QCBcERVudwsOFafoCgrc3jp7XXDYj/Y5d
         n6MQUdONQya45KwMBZZL41npxJtRAYIKy0yUgQd4Ke6eMRmhYZOdBHNHYQrAbQZ1WeuK
         hyQ+CH0qspkrzAJvrcsf2z5yjpUwksEdRgMCSuAPjQ4shsS3YIfLfIoP08oTJdohq6k8
         g1jNDWOQSGniEX/ffUYfBE3cvRw+2RRTvkliT+VzCLip9aUsObHKXmdA1qeo/NAeuVpm
         Gqaqsrx6/1bnkL5ZJMsXYdSkKBKchUHsT18rYPrbJhn9MrP4EoMFks5uUcu3qWzyDbYE
         AddQ==
X-Gm-Message-State: AOAM531eDjMjZaiMWNM5o0/7sS8noRYZ7lIvczM+kie4XxthWLhtBzGs
        ymRB0i3XE24bz4BDUWuBFnPKGw==
X-Google-Smtp-Source: ABdhPJy1ESR8MK5eh/CTeJwke24+N9wQZVarAEzXV+tdbYLw16YrJcUNcoHvMx8HVxPNgTxxTtbXvg==
X-Received: by 2002:a17:90b:1d85:b0:1d9:c22a:e8c with SMTP id pf5-20020a17090b1d8500b001d9c22a0e8cmr10934560pjb.211.1651114562750;
        Wed, 27 Apr 2022 19:56:02 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a000a1b00b004f3f63e3cf2sm23472856pfh.58.2022.04.27.19.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 19:56:02 -0700 (PDT)
Date:   Thu, 28 Apr 2022 10:55:59 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        almasrymina@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: hugetlb: Considering PMD sharing when
 flushing cache/TLBs
Message-ID: <YmoCP4PoFbMVZ0AK@FVFYT0MHHV2J.usts.net>
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
 <0443c8cf20db554d3ff4b439b30e0ff26c0181dd.1651056365.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0443c8cf20db554d3ff4b439b30e0ff26c0181dd.1651056365.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:52:05PM +0800, Baolin Wang wrote:
> When moving hugetlb page tables, the cache flushing is called in
> move_page_tables() without considering the shared PMDs, which may
> be cause cache issues on some architectures.
> 
> Thus we should move the hugetlb cache flushing into
> move_hugetlb_page_tables() with considering the shared PMDs ranges,
> calculated by adjust_range_if_pmd_sharing_possible(). Meanwhile also
> expanding the TLBs flushing range in case of shared PMDs.
> 
> Note this is discovered via code inspection, and did not meet a real
> problem in practice so far.
> 
> Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
