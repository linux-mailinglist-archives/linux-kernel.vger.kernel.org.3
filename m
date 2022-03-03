Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701104CC8CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiCCW0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiCCW0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:26:03 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA7035260
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:25:17 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c4so5950846qtx.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EZmBSf7RjPn5+sYY9ZdCSnzCqzjve1M3G+h5tfOhBH8=;
        b=weqSjXg88DL4Q86PolMdKXQ5mcLbv9EpSztPGU/faQsSpAtE0vJmGGaDP07nvudbOR
         HlRcpr4wFeh7zj6oOvhAw1Qxo/n0IQD86jxZBv1aoZANW5MCuxxsBX1jF5qUB4digaml
         M6aQwmvYuF6vGvmfaCBhsDR/DJUIDW0sxydQ3REZ4oD6LpYnJlCe6EWcnNOpryZHu6BE
         zZMJLyWqECGso5RRrkzfoipFQbUfvh6F51VXy0U3j1ggR0I1mkD5W+FpiOmgfTmn1hjM
         R+nLoFEz/W0Lgv3ofiAkUicR5eKVWbXSRfOEeB1yWvTu9TVALje1Cu3jsl103dsWB2ei
         +Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EZmBSf7RjPn5+sYY9ZdCSnzCqzjve1M3G+h5tfOhBH8=;
        b=NNRWnDN5XhC3889TGSVpnBdQ97/bmPxPpQRPn9u+Q0mnQ8eSYwpDgEqXC8pTJS9BvZ
         +/GaVrA95XTHlMGeca0DI3uJRzdYvBUoxXp0WpJ0ZJv7+qNSHG8WRA9GLNBy2ns3R5DH
         ChmjVI7RWIXacM0iSdkgmyo2GebFlM2u2DbGsEVR40gsUFp1aTWAFQjPN2hj+iqObPK8
         DryL2MC7bcSimVp5YieOQpLYlQRrlIoVuQhaYqypYQafTUy7PsBfkAUiKNWXggi4ZzdY
         pN44g4yO0NQCgcwX5LD4Z6J5Vif5pGCa1mg0Gw4ltFSaWzMUvGNl2o+kEBbcw+D/zEhb
         1H8A==
X-Gm-Message-State: AOAM530LA6p+zP3Cg5e2Vk7DDH1bxEskeWRBUA+PT/p/CB7h/2s2H3P1
        Gpum9uuwBougiZDjqwf1HJtStr5FiEDJNQ==
X-Google-Smtp-Source: ABdhPJzYN95+uz4+u9xXJzwMda1refAsjqTib3Zaa8+ah435dQl9KyFkVsVrBg9/zkvipfqaRlPE1Q==
X-Received: by 2002:ac8:5cd5:0:b0:2d0:6770:c997 with SMTP id s21-20020ac85cd5000000b002d06770c997mr29105165qta.178.1646346316452;
        Thu, 03 Mar 2022 14:25:16 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id v14-20020a05622a014e00b002cf75f5b11esm2290185qtw.64.2022.03.03.14.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:25:15 -0800 (PST)
Date:   Thu, 3 Mar 2022 17:25:15 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: madvise: MADV_DONTNEED_LOCKED
Message-ID: <YiFASwUhc1Mz1Jz2@cmpxchg.org>
References: <20220303212956.229409-1-hannes@cmpxchg.org>
 <A5A8E655-0CE6-4F27-85FD-E99726776EAC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A5A8E655-0CE6-4F27-85FD-E99726776EAC@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 01:35:56PM -0800, Nadav Amit wrote:
> 
> 
> > On Mar 3, 2022, at 1:29 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> > MADV_DONTNEED historically rejects mlocked ranges, but with
> > MLOCK_ONFAULT and MCL_ONFAULT allowing to mlock without populating,
> > there are valid use cases for depopulating locked ranges as well.
> 
> ...
> 
> > @@ -850,7 +858,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > 		VM_WARN_ON(start >= end);
> > 	}
> > 
> > -	if (behavior == MADV_DONTNEED)
> > +	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
> > 		return madvise_dontneed_single_vma(vma, start, end);
> > 	else if (behavior == MADV_FREE)
> > 		return madvise_free_single_vma(vma, start, end);
> > @@ -988,6 +996,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
> > 		return madvise_pageout(vma, prev, start, end);
> > 	case MADV_FREE:
> > 	case MADV_DONTNEED:
> > +	case MADV_DONTNEED_LOCKED:
> > 		return madvise_dontneed_free(vma, prev, start, end, behavior);
> > 	case MADV_POPULATE_READ:
> > 	case MADV_POPULATE_WRITE:
> > @@ -1113,6 +1122,7 @@ madvise_behavior_valid(int behavior)
> > 	case MADV_REMOVE:
> > 	case MADV_WILLNEED:
> > 	case MADV_DONTNEED:
> > +	case MADV_DONTNEED_LOCKED:
> > 	case MADV_FREE:
> > 	case MADV_COLD:
> > 	case MADV_PAGEOUT:
> 
> Don’t you want to change madvise_need_mmap_write() as well and add
> MADV_DONTNEED_LOCKED there too?

You're absolutely right, thanks Nadav! It'd be fine, but more
expensive than necessary. Here is the fixlet:

diff --git a/mm/madvise.c b/mm/madvise.c
index 12dfa14bc985..7dbfcd6c955a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -52,6 +52,7 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_REMOVE:
 	case MADV_WILLNEED:
 	case MADV_DONTNEED:
+	case MADV_DONTNEED_LOCKED:
 	case MADV_COLD:
 	case MADV_PAGEOUT:
 	case MADV_FREE:
