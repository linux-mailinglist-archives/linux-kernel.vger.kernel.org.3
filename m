Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1550AE3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443617AbiDVC4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352185AbiDVCz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A28C4D62F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650595986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rmnSxVr3m8j430qXjhb6BYHPsWg8vcXZrzP1M7hSHg8=;
        b=afzqzQixPQuLMAuQAg6TUJdsp0PyietFTyeRarC/14oLUhtCzYW6VZZSxia0fjobehYAib
        xfWA7lU2DRaVQ+KcnvLE0+Kd1oyASa1LT6uyeEri3iNazlNbH3Z+bbT/WlS4jSlLfSR5Zn
        XTDPJlmESnrKWvfzlKfB10A77/kmUIE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-zQNMne4AOaS7DaTkjjZ6bg-1; Thu, 21 Apr 2022 22:53:05 -0400
X-MC-Unique: zQNMne4AOaS7DaTkjjZ6bg-1
Received: by mail-il1-f197.google.com with SMTP id y19-20020a056e02119300b002c2d3ef05bfso3645109ili.18
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rmnSxVr3m8j430qXjhb6BYHPsWg8vcXZrzP1M7hSHg8=;
        b=wIAaC0rnfC90ecHx5kZkP/F7m9dqH3Fz57eyp1C+b+M3ws7e8XkeoM3G8OO1O7qQzt
         WDz60iMmxx1T3vvvF6v/mCy/bEQZUB/svlZA+3rp0M6kdkmhHv4lM6kYPyZpeCf1E9j1
         t2YXfc9sBpk/uKl2kSW9coZuObQTw8s/ZeRk8W0+43YXvvo6fCcLJEuO+oQ8ljkWOX2/
         pNBL17zwDSdtfEvZf8zqCYRLVfHYPIhZzjHY35Aq+LBDorR1iYPB9NcDmdtyIPj/F0NO
         rHp3vJqGNmnO/g4yAJ6cGKI6hd9Xi3m8B7Q4Iiv9ic/PxGADPFoEUFABIB2lVZr3ihvH
         NccQ==
X-Gm-Message-State: AOAM530akNMzcmAODSi56RBTxNbfNgAsfhUsm0RT+wuucExkiM76j0sF
        F948m8Wx+HpF4EmOK8YJW8+bzz8Zx6k49/gcw3z4GqdZmHMz8rlen42akYjbq81HK5TqFCL/2NP
        y2aVkDrW242Dsu1tms2SeW6bQ
X-Received: by 2002:a05:6638:2604:b0:32a:9c8d:33b7 with SMTP id m4-20020a056638260400b0032a9c8d33b7mr1188372jat.278.1650595984525;
        Thu, 21 Apr 2022 19:53:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSG+qHo5InB+v+4x+yjnU8lDzVRD1JosP9MDmN/RlEe3NAJ/TUtmBo6iqp4jvLZWwbd9cjFA==
X-Received: by 2002:a05:6638:2604:b0:32a:9c8d:33b7 with SMTP id m4-20020a056638260400b0032a9c8d33b7mr1188363jat.278.1650595984257;
        Thu, 21 Apr 2022 19:53:04 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id 5-20020a6b1405000000b0065064262ef4sm569903iou.30.2022.04.21.19.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:53:03 -0700 (PDT)
Date:   Thu, 21 Apr 2022 22:52:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, david@redhat.com,
        apopple@nvidia.com, surenb@google.com, minchan@kernel.org,
        sfr@canb.auug.org.au, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm/madvise: free hwpoison and swapin error entry
 in madvise_free_pte_range
Message-ID: <YmIYi0AD+46YYTVj@xz-m1.local>
References: <20220421125348.62483-1-linmiaohe@huawei.com>
 <20220421125348.62483-4-linmiaohe@huawei.com>
 <YmFqHBMtNKqib8lt@xz-m1.local>
 <d391b905-e017-5d0c-7485-2ea51d2587ae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d391b905-e017-5d0c-7485-2ea51d2587ae@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:47:32AM +0800, Miaohe Lin wrote:
> On 2022/4/21 22:28, Peter Xu wrote:
> > On Thu, Apr 21, 2022 at 08:53:48PM +0800, Miaohe Lin wrote:
> >> Once the MADV_FREE operation has succeeded, callers can expect they might
> >> get zero-fill pages if accessing the memory again. Therefore it should be
> >> safe to delete the hwpoison entry and swapin error entry. There is no
> >> reason to kill the process if it has called MADV_FREE on the range.
> >>
> >> Suggested-by: Alistair Popple <apopple@nvidia.com>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/madvise.c | 13 ++++++++-----
> >>  1 file changed, 8 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/mm/madvise.c b/mm/madvise.c
> >> index 4d6592488b51..5f4537511532 100644
> >> --- a/mm/madvise.c
> >> +++ b/mm/madvise.c
> >> @@ -624,11 +624,14 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
> >>  			swp_entry_t entry;
> >>  
> >>  			entry = pte_to_swp_entry(ptent);
> >> -			if (non_swap_entry(entry))
> >> -				continue;
> >> -			nr_swap--;
> >> -			free_swap_and_cache(entry);
> >> -			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> > 
> > Nitpick: IMHO you don't need to invert non_swap_entry() then it'll generate
> > a smaller diff, just add the new code above "continue".
> 
> I tried this way, but that lead to long line splitting, so I rewrote the code like this.
> If you prefer to just add the new code above "continue", I will do it in the next version.

No worry then, feel free to keep it as is.

> 
> > 
> >> +			if (!non_swap_entry(entry)) {
> >> +				nr_swap--;
> >> +				free_swap_and_cache(entry);
> >> +				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> >> +			} else if (is_hwpoison_entry(entry) ||
> >> +				   is_swapin_error_entry(entry)) {
> >> +				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> > 
> > Since it's been discussed and you're reposting a new version anyway, why
> > not start with either reusing hwpoison or pte markers?  Or do you think it
> > should be for future to drop the new swap entry again?
> > 
> 
> IMHO if reusing hwpoison markers, there are some places that we need to distinguish them and do
> different processing (and maybe also well comment them) which will make code more complicated and
> somewhat hard to follow. And the "swapin error marker" here is most straightforward. And If pte markers
> will support the "swapin error case" in the future, I think it's fine to change to use it then.
> Does this make sense for you?

Yeah it's fine.  If the pte marker things can finally land as expected,
maybe I can try it out as the 2nd user of it. :)

-- 
Peter Xu

