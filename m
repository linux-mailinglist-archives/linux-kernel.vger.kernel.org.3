Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA358A4D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiHECow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiHECou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:44:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C444270E69
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:44:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 17so1168961pfy.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 19:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Ge650nsibp9BJRcwR8vjT9DTFibFHRWpu3X6S8ZIxw4=;
        b=EhC8cdWn6CptK/UCyIMOwYDGIEL4wVO1KUvpBFSm4ssWHjz13EnExX5VpGtd1Ls2TM
         qgh3dw24BJ715TduWcIiaUEtTt0s+DzZnR6lJgadXcbZVwl2JfOR17IDWhzibNOgKXLE
         Ji6f2HrahxQYIMQlsWI5RO9vzTGa25axFYdvLx464MCyQAJTKvo+clPrL6Olu4Oe7caF
         Yhwi2VUekDd2F3gYqgnejYcE7KjvEFJeUsYqktBUI608MNQjVrSARgmToBehGsNyXZ49
         /Ze2bjhdsmBBnB/YQyTcPsrXAtpfdpIBhaqbiMokVJ6AkCmISlpJTfdJOSlguySGbm51
         EH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Ge650nsibp9BJRcwR8vjT9DTFibFHRWpu3X6S8ZIxw4=;
        b=C/74T6Eclxr6lUjNm0hBKKC4D6zZUJERhftuVJSZ+uvT/MogIgYMXGK7+tTRATv9LT
         SpVD/ojsR8GPxVBlpEmK7dn6L8DJT4Y3Rm/4efs2OLTEjxdJeStosBc/CenlTC6xINmu
         fPSOxI6YeGgXQ9xdNUVIb7BHQFQ4yKLYbYIk+0emNx11MMbsFvOD7WSAkaB7UnQ6t5K1
         eyhjU+XjUrumYgBZbGbsRIGO5vwjzDtevbAQbWHzV/CcNk7K/FsNYFL5M4WK8MXeWNNK
         QupKyq6zVc7rwKl2Ea27oputoWj+909ybfR5OUdnfRK+6QYojbBKJPyDuXvupblzlpRb
         SM9w==
X-Gm-Message-State: ACgBeo0WRS05Eml4D+9Aw7iIRb3VDRGlVzCFapvBgKImRWgn7jR4KFAS
        LV7XIu2p8cXfjQbQiDEj7CVVBw==
X-Google-Smtp-Source: AA6agR4ckl2JHPiW/tp9tke26knPbADR0uC+WjekY6sh31/R9hzVRt0A1VAItLW5bvJatvE9mF0jNQ==
X-Received: by 2002:aa7:909a:0:b0:52b:3afb:fc49 with SMTP id i26-20020aa7909a000000b0052b3afbfc49mr4622761pfa.39.1659667489212;
        Thu, 04 Aug 2022 19:44:49 -0700 (PDT)
Received: from localhost ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id c78-20020a624e51000000b0052ce1737ee1sm1748693pfb.37.2022.08.04.19.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 19:44:48 -0700 (PDT)
Date:   Fri, 5 Aug 2022 10:44:35 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-founddation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hugetlb: add dedicated func to get 'allowed'
 nodemask for current process
Message-ID: <YuyEE3ag0/0iixo6@FVFYT0MHHV2J.usts.net>
References: <20220805005903.95563-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805005903.95563-1-feng.tang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 08:59:03AM +0800, Feng Tang wrote:
> Muchun Song found that after MPOL_PREFERRED_MANY policy was introduced
> in commit b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes"),
> the policy_nodemask_current()'s semantics for this new policy has been
> changed, which returns 'preferred' nodes instead of 'allowed' nodes.
> 
> With the changed semantic of policy_nodemask_current, a task with
> MPOL_PREFERRED_MANY policy could fail to get its reservation even though
> it can fall back to other nodes (either defined by cpusets or all online
> nodes) for that reservation failing mmap calles unnecessarily early.
> 
> The fix is to not consider MPOL_PREFERRED_MANY for reservations at all
> because they, unlike MPOL_MBIND, do not pose any actual hard constrain.
> 
> Michal suggested the policy_nodemask_current() is only used by hugetlb,
> and could be moved to hugetlb code with more explicit name to enforce
> the 'allowed' semantics for which only MPOL_BIND policy matters.
> 
> apply_policy_zone() is made extern to be called in hugetlb code
> and its return value is changed to bool.
> 
> [1]. https://lore.kernel.org/lkml/20220801084207.39086-1-songmuchun@bytedance.com/t/
> 
> Fixes: b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
> Reported-by: Muchun Song <songmuchun@bytedance.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for fixing this.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

