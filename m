Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1493586B5C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiHAMwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiHAMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:51:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B225E87
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:46:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gk3so7963048ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fDTc4Q1QO8nlMcGICtL4SmfYsNLdDUjJrnQH077c/UY=;
        b=caTwfOyzuqUdCnJEIqBA5e5Tag2x4WV4MjEinS6y8rA3fIdodapOM8CK11RZ87FDH2
         9asij++Zjnqkr08wT4AZRH7pTTsMqsAjL6hVlkE+yFBKHzhsGjqRJxyp9jzZhXt2tZVD
         nRCmtl27+qht2NT4xMQagBoByW/5kNznSg9IugOVH+eVzDe/PSVCmpVaKbRBNHIBubgZ
         kKJeo2IBY5y1/lX/6zMM1ibynzZb4NBtfxzgvCisx15nF86/0Cyl6Hdiso4702MVN86X
         bA9Jf2Z58NsUAm2cCab5fq2LyDBSHFeCrdF7jVrHIVSu2Ro2FYqn/51cdPGKSyWjnPGS
         fzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fDTc4Q1QO8nlMcGICtL4SmfYsNLdDUjJrnQH077c/UY=;
        b=eKvmIviVP7W56PVSzH5i9TD0snK63JPB5/Q2F+aUlGnSpfNQJ6edZVNnoqzHE+2Los
         8UCd0B7RBJmRRa2oScJh7z4YjQGJJh78pOnC3FUjRIs3RhKEEUPLG3PfOOGgrAUE7XMR
         D8SlSAZBLvxBUpSm206sKr44lnHf0ILOrQImAoa4V5QEzj9ITwX9YNrktYilmIg0vcIx
         MTwnICJ1svyuJ9kFGwwogXU2BC/jJxs1fxn9XsAAX6HCKXJNlyAQm8MmgJcVmt8k/2EW
         9q0UVD55LLHjup6PVKAAbbm8377wDJYclsU8Z3aHYWK2qCY6VRP/eX8dx0K4+F7+8U0g
         bc3Q==
X-Gm-Message-State: AJIora/U1gpOiodh+SMl2cYTWIrmots3Iv303jN9E8t/AN5T6R1EFRiU
        zz/LXmMGJgQKPy7BgRjd0GY=
X-Google-Smtp-Source: AGRyM1sp2zTCP5Exb/k8DToooD2chBOhPYiBB2mt5MBUa5Kv+cEuw6gFujvv1cJQMDqnWSgKeSUyvQ==
X-Received: by 2002:a17:907:7601:b0:730:3da4:217c with SMTP id jx1-20020a170907760100b007303da4217cmr8938480ejc.563.1659357997843;
        Mon, 01 Aug 2022 05:46:37 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170907984100b007306a4ecc9dsm1951302ejc.18.2022.08.01.05.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 05:46:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 1 Aug 2022 14:46:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/features: Expand the space of sched features
Message-ID: <YufLKxriNQurBmYQ@gmail.com>
References: <1659347211-81838-1-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659347211-81838-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Cruz Zhao <CruzZhao@linux.alibaba.com> wrote:

> With the increase of sched features, the available space decreases
> gradually. In order to prevent features overflow, this patch expands
> the space of sched features from 32 to 64.
> 
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> ---
>  kernel/sched/core.c  | 2 +-
>  kernel/sched/sched.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1899990..afe76fb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -122,7 +122,7 @@
>   */
>  #define SCHED_FEAT(name, enabled)	\
>  	(1UL << __SCHED_FEAT_##name) * enabled |
> -const_debug unsigned int sysctl_sched_features =
> +const_debug u64 sysctl_sched_features =


Have you run into this? We have 27 features listed, so this shouldn't be 
happening right now - and this patch just bloats the word for no good 
reason.

Also, doesn't it generate a build warning/error in that case?

Thanks,

	Ingo
