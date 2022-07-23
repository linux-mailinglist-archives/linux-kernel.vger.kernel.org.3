Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF6057EF44
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 15:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiGWNon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 09:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiGWNom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 09:44:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210321E39
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:44:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ku18so6590684pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hnotxB5Oc/VX76n20x9nu1HrRcKDV9PdbZM9OhqtA6E=;
        b=7x827hbe8Wo6IMCLX1aASTMVo7iqsQtSjbd8ValONvs5byHdPFPMxAODQ72v7MUgaf
         MCPCCG66FBCOih/OZMsNNrwv5y72zJ2zeoI6EyXsPes3675nkmYtNXyl5MjyBxDO5xYM
         d024O9atQocQ3j+MbfCBMVgnDCyhp6KNg85LLwHh7uX33e08itMbuv/wmL1FDGb668AT
         ddCsQIjWeIK8tNVmXGi4xZcOK5NIJmDvOuFJfBy6TEYcCQ86pM+0WbMl0D9PBWdlFPXv
         JgJvlEdCN7J8TDtmDP79jtCRWpBZadrduObH/R4GF1asFedqnZ/4WBReND59uHVv9tQJ
         Gi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hnotxB5Oc/VX76n20x9nu1HrRcKDV9PdbZM9OhqtA6E=;
        b=ppHKQnqwPXaMKMSQJaLTmRSVD0iWe/O/lDljFLq6ZMOKlcAgXNOnEmQk/820WVrO4+
         zDKf0JvFZd/YTQlsq8O2VBWPhs2djbpJYZQDYOx8Y5jtvOZPUl05HnINIKpNSKaYDeOl
         hqFKhCOmfoawgtv7i981atl3rmY60LaMZ2LEs+oMFHLmUvM3Qk72ZH6BjH2T7kx67P0y
         UiMXu/rte51VK0yNXkdYmx3b+BUA7lQUJoJpRtWAH9Y89LzfYgfekyV0s6cEHEKq57qV
         Hv+4TjOCuF6FYuIzbgtTlfYH9iqOyCFkxtQrEouSleQMtCD1gitR1Ldj6fo8Hq/NfMCk
         iskg==
X-Gm-Message-State: AJIora/3XjHVlQbx0ZEtHsU76tBUaRjG94NxY4U7YOq1gXG4BNrGgRoM
        ZvVPSoEgx8FlAuWZtNgoxeHSOg==
X-Google-Smtp-Source: AGRyM1u9aDba9mK7/LfDHKxzs+bASSV0gXHqEO8oFT7L0Cx/Ov6MBeNhWIjD1i//UdMHFKCFVcQ2yg==
X-Received: by 2002:a17:903:41c1:b0:16d:59d9:2bae with SMTP id u1-20020a17090341c100b0016d59d92baemr1882187ple.49.1658583881044;
        Sat, 23 Jul 2022 06:44:41 -0700 (PDT)
Received: from localhost ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id w205-20020a627bd6000000b005286697ec68sm5901700pfc.133.2022.07.23.06.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 06:44:40 -0700 (PDT)
Date:   Sat, 23 Jul 2022 21:44:35 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        mike.kravetz@oracle.com, almasrymina@google.com,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb_cgroup: fix wrong hugetlb cgroup numa stat
Message-ID: <Ytv7Qw7pvG49rEdg@FVFYT0MHHV2J.usts.net>
References: <20220723073804.53035-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723073804.53035-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 03:38:04PM +0800, Miaohe Lin wrote:
> We forget to set cft->private for numa stat file. As a result, numa stat
> of hstates[0] is always showed for all hstates. Encode the hstates index
> into cft->private to fix this issue.
> 
> Fixes: f47761999052 ("hugetlb: add hugetlb.*.numa_stat file")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks for fixing this.

Acked-by: Muchun Song <songmuchun@bytedance.com>
