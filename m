Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6D65A20C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244974AbiHZGUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244903AbiHZGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:19:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA13DF41
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:19:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w2so807444pld.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=feSSvQfSIZTTbKIOXODfwXSxUp0ih4gkGwyK7VijaP0=;
        b=XgDFRm1E8UjNTOgDL5udYLrY3rfl7szKOjxlfoj2UF0hohpr4ppLGZHSckwe23lT/W
         zxa2FF/iIKpWsCVYwSDydF684UjFCrjEVy2f5leRBss3MTVvPgqoR76PCYGt86UNQdEi
         N0UqN2hg+A6xm1ZE2FaelV7AiMqK0vMwgw41Wjc/H05fiQCylmtdpfXIgzR12l6I0IY8
         SC8Ns9qRzM0Erh+Vli8KJ01EsBOXzMwu+Ct8BM5m4s3UvO9F4Ctzbaq1GnEyFsv7v2Mf
         5Uk6J3PCt+wWNx4Rh9MoGQeZ65B+7RxRGQ1gPyu0O6bU8WFplfmWRZgklWXHsVTEnnyA
         SdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=feSSvQfSIZTTbKIOXODfwXSxUp0ih4gkGwyK7VijaP0=;
        b=Z2T2/sj9cgsFA1WWUWa57/4uhDzvoSHwWwXoY1dxXgYVy1VY6sl1ICl/n/4OCUnBha
         yiN5CdAV8vi4m8Zlpyiwvnk+HVkhQOJvOON9gA9Fap6VoedEMW9z+boodyg8IkesNdwL
         xnohrYzbkPKa6O1RVsVi9LvlF7FreJF4wnSYIir5kckh/yl9Al2uDk3M90hC4BXJwvsZ
         YMz/LYGlsaW4FxUFX1eK8TSocSHznsk152dywLlz/QkhyLc48umuDaf0aEuPxpddZA8d
         F0+3W1osjso6Pp5hVBNnJcOj0CzAKjnp5agRosC4wbrksza6DImxFAkGuJwjxE5GODxv
         jttQ==
X-Gm-Message-State: ACgBeo1dy9z4kVHB8rH3jbYbkRVL+ONXDSrv2gburMEYnKD8A1zfEMMz
        66NvZvF/DcvI+A8Glme0SYIiIQ==
X-Google-Smtp-Source: AA6agR5izOHSiZtIGwj1+c6VRv9kb4Nt6ZkJukay+Y+U1Aq3+odozhkh2KBhAAX/gzAij32vGXnc6A==
X-Received: by 2002:a17:90a:c402:b0:1f8:c335:d4d7 with SMTP id i2-20020a17090ac40200b001f8c335d4d7mr2850632pjt.242.1661494797001;
        Thu, 25 Aug 2022 23:19:57 -0700 (PDT)
Received: from leoy-huanghe.lan ([204.124.180.110])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78ec5000000b00536bbe91b83sm743055pfr.157.2022.08.25.23.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 23:19:56 -0700 (PDT)
Date:   Fri, 26 Aug 2022 14:19:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ali Saidi <alisaidi@amazon.com>, Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH RESEND v6] perf: Add SNOOP_PEER flag to perf mem data
 struct
Message-ID: <YwhmBlp0eVtiU5JW@leoy-huanghe.lan>
References: <20220826051603.174792-1-leo.yan@linaro.org>
 <YwhXXiuQ2VysVint@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwhXXiuQ2VysVint@leoy-huanghe.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 01:17:18PM +0800, Leo Yan wrote:
> On Fri, Aug 26, 2022 at 01:16:03PM +0800, Leo Yan wrote:
> > From: Ali Saidi <alisaidi@amazon.com>
> > 
> > Add a flag to the perf mem data struct to signal that a request caused a
> > cache-to-cache transfer of a line from a peer of the requestor and
> > wasn't sourced from a lower cache level.  The line being moved from one
> > peer cache to another has latency and performance implications. On Arm64
> > Neoverse systems the data source can indicate a cache-to-cache transfer
> > but not if the line is dirty or clean, so instead of overloading HITM
> > define a new flag that indicates this type of transfer.
> > 
> > Update notes:
> > 
> > This patch is to sync the headers between kernel and user space, commit
> > 2e21bcf0514a ("perf tools: Sync addition of PERF_MEM_SNOOPX_PEER") for
> > updating kernel header has been merged in the mainline code.
> 
> Hi Peter, could you help to merge this patch?  Thanks!

I sent a new patch with adding my SoB:
https://lore.kernel.org/lkml/20220826060556.176681-1-leo.yan@linaro.org/T/#u

Sorry for spamming.
