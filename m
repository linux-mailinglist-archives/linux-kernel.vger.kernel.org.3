Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA59A547189
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348522AbiFKDPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiFKDPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:15:06 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221AE7C14D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:15:02 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-fe023ab520so1535663fac.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=i3PveqzxOSfMeIA5E7qSY6I1PBV29u2B7LHH4YJatsw=;
        b=NdJmIjo/fkkrwGS2vSrcmgt+wPfap+5wiAUAo47bVRkzsY2soRkocWOl1U4OdC4QvW
         1+o3AzwgNPGHEVve1PXadpMxGAKqW9xnVck+n7EI1wrWaDoYUHaXf08dO1/feGuAIQYm
         Q6INuuIejIksWcprtyxG1n2jxlVy/L7l0iShsXdgoyv7Ra/xMHKpZkV8lVnnGiYqwMb5
         vAm/b61+kDNuiDTODbHQ7qgZ2CZ3JL3eeQvTDFeiTc1/Z5MDbRNYVL1yjGq+tE4E1HT/
         lR7nzwjrCJHUKlJ3l6mtdgYk0bK0XGa9DHrdd6UKolK2dqyPQep1hMU3BsAIylqcC7ER
         8nqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=i3PveqzxOSfMeIA5E7qSY6I1PBV29u2B7LHH4YJatsw=;
        b=iSxIxYJh74Ev858pG+qXql+vN6sRZn85DT83jr8aGPtCCLyoZjz1TA0/6Pw8ZwpldS
         umN1uksi9tD/TofGOTuzWZQWWKmzJAZbk3WkRK7jjbzusZlk32KNUniypPhUE9rQW6gz
         oJm2FGTxNnSEzgC799a3pY/zlHA8GUT1lCinc8HjBoXy8xuYk1ckc7SmgFXVDm7wp6lU
         CcjrZO0sTZpX0v4c+momIVSrjOrmaE8oPOWz0hTdVX6vNTPMdrzmaJ6P812qGebFP3ub
         xIymyXEx/u90elCf+H5c6mPPbgmb5MqpdGRFa30yrDs31dOzCgxQeubvbKpyxhcGoC5d
         VrNQ==
X-Gm-Message-State: AOAM5321amrg/uGpfy4OUp7vxn44u3MDZOabHredt/pt6/dfoo1AeKeP
        z3UJ3Xtf0jjHhNidUVS9gIPRGQ==
X-Google-Smtp-Source: ABdhPJwlicWpC0b0+htVy1SbYiuX+t5H3/KQGj98sGWA/Sr0QJvC4IsBypGanwOYgphFBqTOU3gLzQ==
X-Received: by 2002:a05:6870:638d:b0:f5:d6c9:3f45 with SMTP id t13-20020a056870638d00b000f5d6c93f45mr1563800oap.233.1654917300112;
        Fri, 10 Jun 2022 20:15:00 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id be8-20020a056808218800b0032ed4543c36sm570080oib.36.2022.06.10.20.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 20:14:59 -0700 (PDT)
Date:   Fri, 10 Jun 2022 20:14:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     akpm@linux-foundation.org, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/shmem.c: use helper transhuge_vma_enabled()
In-Reply-To: <20220611022314.21593-1-linmiaohe@huawei.com>
Message-ID: <8b34a515-e5fd-731a-4164-9080c275d4e9@google.com>
References: <20220611022314.21593-1-linmiaohe@huawei.com>
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

On Sat, 11 Jun 2022, Miaohe Lin wrote:

> Use helper transhuge_vma_enabled() to check whether transhuge is enable
> on vma. Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

No thanks, that's a readability regression, forcing reader
to go and look up what transhuge_vma_enabled() actually means.

What you call a helper, I call an obfuscator - as I implied in
b9e2faaf6fa0 ("huge tmpfs: revert shmem's use of transhuge_vma_enabled()")

Hugh

> ---
>  mm/shmem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 133c67057d41..59cc2e980c95 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -480,8 +480,7 @@ bool shmem_is_huge(struct vm_area_struct *vma,
>  		return false;
>  	if (shmem_huge == SHMEM_HUGE_DENY)
>  		return false;
> -	if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
> -	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
> +	if (vma && !transhuge_vma_enabled(vma, vma->vm_flags))
>  		return false;
>  	if (shmem_huge == SHMEM_HUGE_FORCE)
>  		return true;
> -- 
> 2.23.0
