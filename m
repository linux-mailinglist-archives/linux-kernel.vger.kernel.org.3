Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DA44D7998
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 04:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiCNDMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 23:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiCNDMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:12:45 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F13D3EB80
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:11:36 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w127so15969324oig.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=b97IRgdojmskoUj6xqTHzV6FHlt1zL1rWKMe4IXbzRY=;
        b=AQbTXJ84foDJZijT8rN9O+ZyaKxspYFHahatLu8HgjAPtx/RzWnyYpEt6luy35aGOD
         oLBFHv9ni+/8hOoFbjKWpsPx28eey7mnsCl8ArvINXwleTjqB3mM3vA5D1TNUXkqWliv
         R1fBtoUhRehEJ9HI9W0PQhHSCii56Kv7bFM5Zhu8Xzn54WbkcqrhSWUayTrCqiH4ISw5
         07mlXsfA5SqIG9nVJB5Qsp14IxM7WTSBhquB7K2cjBJRrTToO//6Cj+kp627F4VcyDYF
         TYOaOcwpXt7TCRTiVqg+k4gcN4PHo8Z+KCddahoa2KEoClxiKPgiWc0grciteYzPicyX
         kgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=b97IRgdojmskoUj6xqTHzV6FHlt1zL1rWKMe4IXbzRY=;
        b=mB+xmoMHQJjaFIy40j3Co2agqDfdb1xa53Fp4STqCBM7Mo8VJAo1VYNYbjmgyGBSEb
         mMK404wx1IurqZclWFCRiUZ28eEgMZXe1qZB6o3vskINbgzxCWD39Py1wNVq319A8Imv
         +DyrdtcJghtKkdNZBY1SFCA1uWbQRwidRxUzI+Nnp3aLdFgxw89q3kQ0PChXbt6qll3l
         At9OLgnJrrswadrowMd2c0ZJFkog4WwpMA1lc+SwMVGUNg9OqexQFw2Dep3fT3vOa6L5
         I9r3zekEVeKISHSr+eASDMaaxGHfINKt0qU4iP9DfZgPzzyQnZOloevjWHisA3WYOlRX
         CjQg==
X-Gm-Message-State: AOAM533G3dT+Ej5hl2AAPM+PQVygHgP4ys7fvv+DpMOyEOcMtGX63juI
        fx9wl2+u6jmBaImQivXorbJ4vw==
X-Google-Smtp-Source: ABdhPJyKEa+Se2UwgWD2hdDOZ7BJEdR1K3aXZDbCdRx68cKzGaePUH5fcZIQXDSUmEC6v67vWJ1SkA==
X-Received: by 2002:a05:6808:8e4:b0:2ec:aea1:353a with SMTP id d4-20020a05680808e400b002ecaea1353amr6093082oic.27.1647227495871;
        Sun, 13 Mar 2022 20:11:35 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 60-20020a9d0642000000b005b22a82458csm6920561otn.55.2022.03.13.20.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 20:11:35 -0700 (PDT)
Date:   Sun, 13 Mar 2022 20:11:23 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        Herbert.van.den.Bergh@oracle.com,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mlock: fix potential imbalanced rlimit ucounts
 adjustment
In-Reply-To: <bcfc2048-93ce-b357-8671-7070614db36a@huawei.com>
Message-ID: <1e758c8f-c87b-50ef-52db-942c8a86a32a@google.com>
References: <20220310132417.41189-1-linmiaohe@huawei.com> <268b3146-2963-15b6-6d6-95a96853314@google.com> <bcfc2048-93ce-b357-8671-7070614db36a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022, Miaohe Lin wrote:
> On 2022/3/14 10:40, Hugh Dickins wrote:
> > On Thu, 10 Mar 2022, Miaohe Lin wrote:
> > 
> >> user_shm_lock forgets to set allowed to 0 when get_ucounts fails. So
> >> the later user_shm_unlock might do the extra dec_rlimit_ucounts. Fix
> >> this by resetting allowed to 0.
> >>
> >> Fixes: 5ed44a401ddf ("do not limit locked memory when RLIMIT_MEMLOCK is RLIM_INFINITY")
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > 
> > NAK.  user_shm_lock() remembers to declare "int allowed = 0" on entry.
> > 
> 
> If lock_limit is RLIM_INFINITY, "allowed" will be set to 1. And if get_ucounts fails
> in some corner cases, "allowed" will remain to be 1 while the user_shm_lock ops indeed
> fails. Or am I miss something?

You are right, I am wrong: sorry.
Thanks for pointing now to that RLIM_INFINITY case.

But then the Fixes tag is wrong: it should be
Fixes: d7c9e99aee48 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")
       which introduced the possibility of error down there.

With that,
Acked-by: Hugh Dickins <hughd@google.com>

> 
> Many thanks for comment.
> 
> >> ---
> >>  mm/mlock.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/mm/mlock.c b/mm/mlock.c
> >> index 29372c0eebe5..efd2dd2943de 100644
> >> --- a/mm/mlock.c
> >> +++ b/mm/mlock.c
> >> @@ -733,6 +733,7 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
> >>  	}
> >>  	if (!get_ucounts(ucounts)) {
> >>  		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
> >> +		allowed = 0;
> >>  		goto out;
> >>  	}
> >>  	allowed = 1;
> >> -- 
> >> 2.23.0
