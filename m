Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD564FEB96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiDLXsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiDLXsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:48:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E4A4F46E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:39:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 12so396233pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=1W9oqCN8wDLLRslf/UifsNepVBCi7XynHll3+gMPRpM=;
        b=Iby22yXoSsvViW3rkRtC2j9XvhDXUHDcEKXVAUh3nxOBKa+D35eEI1P9zG/qR/FbkU
         o37YxymqN7f14bHb827UH4PZu14eRI/7IxF35bXw4S/mxvOzeRYUgje1ioYu6OPIsrCr
         zbmwKvI6JmVeDyvYJ2AhMa4in4KV63nL2xz5CfRnhxgYwSYJfW2f8KOgPnAHMh3wusNK
         JtM+rUHYEXi/5u6eX2lAwSeok1cQqU8cGMuMVunmdFNC22gUJlijICPFznUR1xvMq87F
         L0yT92C3yS21up56Q1+QCubcRsEUzYlTAlshl+5YE5omPdLJmKjbssSyzoBGaMSiPtZ9
         XDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1W9oqCN8wDLLRslf/UifsNepVBCi7XynHll3+gMPRpM=;
        b=dAgNDb8hUAZj1Awd2fwVaACkLVMT3sHiB9NDVFEMkfwfcZjPaDPzH14MhMvqqyZ3dA
         ZAWbQ950z8di4AAQ1gKq9xAVKMhO3xMoFM0pGUnFyZed5y6jBe3u4y4/06dmXTxzgsyG
         CCsb0toZF6bmxjjE+XtN3DyFZuUT2Lmp/8QEFiU9xVhQYQew92M0jMhHzvegys9GbiVG
         gWc16molc9/bCCXAmBMnobObBluqQiUc1dPfp3+tuRHKMf4HnI4pJLIybUl6w6Htrv83
         9tQrdAiG0qeZlcRJVMd/ZT4+xy4eD+VXgYP3rFYHX+g5/7fIEoJFvyesrSdPxrwzdmWg
         cQcg==
X-Gm-Message-State: AOAM5315hW8FOgNLvbn8NpJV4j+2EY3ZaWbs+cpEpWVjXXePcE9XNvCq
        R74Rq+XUEwNzRK2FqtADnZxEMA==
X-Google-Smtp-Source: ABdhPJwJCq1wrTnCE9M8nKuiUtWRQTeyL0PV2chpR3Dh57p5Gdj48FHjQn6gzhR6F96aat17BHv0zQ==
X-Received: by 2002:a17:90b:4a89:b0:1c7:3933:d802 with SMTP id lp9-20020a17090b4a8900b001c73933d802mr7513659pjb.75.1649806753618;
        Tue, 12 Apr 2022 16:39:13 -0700 (PDT)
Received: from [2620:15c:29:204:1a89:45ec:16da:55dc] ([2620:15c:29:204:1a89:45ec:16da:55dc])
        by smtp.gmail.com with ESMTPSA id w123-20020a623081000000b005056a4d71e3sm19342083pfw.77.2022.04.12.16.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 16:39:13 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:39:12 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     JaeSang Yoo <js.yoo.5b@gmail.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: remove meaningless node check in
 ___slab_alloc()
In-Reply-To: <20220409144239.2649257-1-jsyoo5b@gmail.com>
Message-ID: <5b18a8db-7e10-3bf1-cd23-8f9521a4784d@google.com>
References: <20220409144239.2649257-1-jsyoo5b@gmail.com>
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

On Sat, 9 Apr 2022, JaeSang Yoo wrote:

> node_match() with node=NUMA_NO_NODE always returns 1.
> Duplicate check by goto statement is meaningless. Remove it.
> 
> Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
