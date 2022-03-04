Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66A64CE03F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 23:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiCDWeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 17:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCDWe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:34:28 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6204E5D5D6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 14:33:39 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d84so7584625qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 14:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=VnF5SiU5EKCLKwi41uZyCysuVJrgHXPJdzY01fJNaS0=;
        b=gRA/odwLAg4xYlwLDYSTSTk0NNmin7TutlFP+pye+5mH3RccpDLg2fXgsLTjHEVoJk
         80ssccDMeOHXxl+vu/N9oOn2YJHxMhDRaGefTeyPfGclMuZGafjpLcQBQCNukS+PHnbQ
         D7uXFPJQmnNDY4KQxlde1/l4kov3nUNfJIeOFPvA/5a1bvy7SNutshtBJZ9c4fzZxDYa
         xUMFNITHHIn3PtnH6I4L3YXN8p6X2Qugw4K2WhbPkCac/4GHBcbVPJPYCXLGtaJitJN0
         VAH9vKrmc5Ifx8r8FEF3qxZbnVOGEm4/5e2+pUK/p0ladNfnZh8hhV6t22IBrR0mW86p
         jDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=VnF5SiU5EKCLKwi41uZyCysuVJrgHXPJdzY01fJNaS0=;
        b=6iA4uucJVedrSEbmwPSWhjON7qn4YsHdZgH1veaCy5AJ4WNrEwYjFUtcpIWU6sy/gL
         GfkGPVkw6FuZiWCUlzGl/vdBEC9yq4VOxPv8oEVvttRt5lfv60FVrLVsZHboGqeBMYiP
         sD349ABxo8xSUdS4wMa71/Wy2bQzScEoYYfIbJrzjiTYBb4M64Cib4+LW2encrorr0Sf
         lnwq4FTN0g0LkXNS9FR/7IiSJZOfsatTvirudwEs3V7Hw8xldokS2RoOcZUp24nQ/7kU
         PMWoEAFbjq4tSoBNUCA1u1RP+1CpDztamxcnVZxI3ORvGeNLAmCKLTUILKpwWWBfGB3o
         FbUg==
X-Gm-Message-State: AOAM5306tvPARWaD5xCLvi6TSnlve3Dh/wvBuEgnaVeUxCGv/z8+fFHN
        DV9I5a7qeUx4qZhhx80kn8hylw==
X-Google-Smtp-Source: ABdhPJzereD2bFlLlb34GoVSO0Hd6Wcxg+yk8n3xCRjqmGrB8nsKAi6PrzuzS5SDxuKwLZyHQNZpuA==
X-Received: by 2002:a05:620a:2445:b0:648:ca87:d35a with SMTP id h5-20020a05620a244500b00648ca87d35amr579693qkn.412.1646433218312;
        Fri, 04 Mar 2022 14:33:38 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t18-20020ac85892000000b002de3a8bf768sm4341912qta.52.2022.03.04.14.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:33:37 -0800 (PST)
Date:   Fri, 4 Mar 2022 14:33:26 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Oleg Nesterov <oleg@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
In-Reply-To: <20220304180636.GD19636@redhat.com>
Message-ID: <1ba9dc93-7f16-7ab0-16a4-4f253574972@google.com>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com> <20220304180636.GD19636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022, Oleg Nesterov wrote:
> On 03/03, Hugh Dickins wrote:
> >
> > Just delete that optimization now (though it could be made conditional
> > on vma not having a set_policy).  Also remove the "next" variable:
> > it turned out to be blameless, but also pointless.
> >
> > Fixes: 3964acd0dbec ("mm: mempolicy: fix mbind_range() && vma_adjust() interaction")
> 
> I can't believe I ever looked at this code ;)

;)

> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>

Thanks.

> 
> offtopic question... can't vma_replace_policy() check vm_ops && vm_ops->set_policy
> at the start, before mpol_dup() ?

You are probably correct, though that is not how I did or would do it.

For me too, it's a long time since I've been in here: I have a large
number of cleanups to mm/mempolicy.c, done in the early days of shmem
huge pages (and leading up to NUMA migration outside of mmap lock),
but never the time to carry them forward; and quite a few other people
have made their own cleanups here too, so hard work to integrate it all.

This particular patch here stood out in my mind as an actual bugfix:
our people found shmem pages being allocated on the wrong node because
of it; last time I tried to work in this area, I did pull this one out
and push it into our tree, before approaching any of the rest of it.

If I look at the last of our trees which had the full set of cleanups,
I see that my vma_replace_policy() had less in, but mbind_range() doing
what you have in mind, checking vm_ops->set_policy in between the
mpol_equal() check at the top of the loop and the vma_merge() below it:
with a comment "If set_policy() is implemented, the vma is nothing more
than a window on to the shared object, and we do not set vm_policy and
we do not split the vma" (then calls the set_policy()).

But I think that depends on other changes in other patches (not
setting vm_policy): now, just as usual, I absolutely do not have
the time to get back into that.  So, thanks for the observation,
but I have to stick with just this bugfix for now (a long now!).

It's good to hear from you, Oleg: stay well.

Hugh
