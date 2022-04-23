Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3750C7D6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 08:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiDWGlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 02:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiDWGlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 02:41:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F02DEB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 23:38:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id s18so20283076ejr.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 23:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JfYNk7PKym38MlGAXyXafcCNWPn+2drPWLNtsAJTZac=;
        b=wYRkumz1HH5a5k41YA/3eyDDbvnMB1QTrSknt8c1j99bwzKt02sO/yGBsz4l9qzhVx
         JdgMXmnVnqe5kV8Html2wprELfIEpNmTRD3bGakgJS/qHVWcPU+sLDjpFY+jOl9b8+T5
         LKtUZ6In5Mvp/0CB6hxnHt12qThKxTApkJxaOik1N8AUYqMwHSGe4WZB8Y7lXZ58hRma
         D81PrYOUXEPCCSE4QAkX2/wFJngtAzRzub/zH38Bf1ZeFUv6eAyW9KHYipZpX+NZSUo9
         +LXdpkcwiBohl6gk/mtgxvVf6x2fv+6i+6lKMMNVHEktGiUyRGwDJ4YYBudkReeqX6EA
         2WNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JfYNk7PKym38MlGAXyXafcCNWPn+2drPWLNtsAJTZac=;
        b=kmTlQy9RUAtaLPu7+r2QGvQt9wMNlub67LzSAy5baGPqnxVnnUBncitxdX5+RRyBH9
         znIXyWZJtIBi0irkifyV/1r7XNbg64jdrPvpOqsyJthJ4fKIjAIxRDstZKzfnjZRCqF1
         oeborYRJUDUVuPTASMpTqdGvL4Ty8eVEluJYXshdv1bl3y2dDwCd4bGxMDp9m5LmmdBm
         TIHwiCCtIxSGzNG8SBHCFOtkkInjYrcOG1vLKxgrWZar0P56lAOeIARwIahGtVOWFIlN
         Cd/mj068GL3PMy1GAGQiUzTuMpT8QiS3r/E2M5/uSqit2RUQkqZ770fEYxd+YSD8NiGw
         rxCA==
X-Gm-Message-State: AOAM533+6SWH4tnuZUfxyTZ2/8U3wZMFFA/axXeQ9FnJIFr+8JSYeyhj
        WVll+YDwZM+0Fn4sf9G8fb/x2A==
X-Google-Smtp-Source: ABdhPJwzivo8NzW2VqVoaWDBZYgI3SnzZw9bPgroasDWLZL3hitJGtp3e92gxF/3V81cOzkCePJQXg==
X-Received: by 2002:a17:906:5d12:b0:6f0:17a5:6053 with SMTP id g18-20020a1709065d1200b006f017a56053mr7275588ejt.635.1650695894463;
        Fri, 22 Apr 2022 23:38:14 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id x12-20020a170906134c00b006ef8be0e8e9sm1398092ejb.168.2022.04.22.23.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 23:38:13 -0700 (PDT)
Date:   Sat, 23 Apr 2022 14:38:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     kan.liang@linux.intel.com, Nick.Forrington@arm.com,
        acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Message-ID: <20220423063805.GA559531@leoy-ThinkPad-X240s>
References: <c17dedde-6ba8-db9b-4827-32477f039764@linux.intel.com>
 <20220422212249.22463-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422212249.22463-1-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 09:22:49PM +0000, Ali Saidi wrote:
> 
> On Fri, 22 Apr 2022 21:43:28, Kan Liang wrote:
> > On 4/22/2022 2:49 PM, Ali Saidi wrote:
> > > On Wed, 20 Apr 2022 18:43:28, Kan Liang wrote:
> > >> On 4/8/2022 3:53 PM, Ali Saidi wrote:
> > >>> Add a flag to the perf mem data struct to signal that a request caused a
> > >>> cache-to-cache transfer of a line from a peer of the requestor and
> > >>> wasn't sourced from a lower cache level.
> > >>
> > >> It sounds similar to the Forward state. Why can't the
> > >> PERF_MEM_SNOOPX_FWD be reused?
> > > 
> > > Is there a definition of SNOOPX_FWD i can refer to? Happy to use this instead if
> > > the semantics align between architectures.
> > > 
> > 
> > + Andi
> > 
> > As my understanding, the SNOOPX_FWD means the Forward state, which is a 
> > non-modified (clean) cache-to-cache copy.
> > https://en.wikipedia.org/wiki/MESIF_protocol
>   
> In this case the semantics are different. We know the line was transferred from
> another peer cache, but don't know if it was clean, dirty, or if the receiving core
> now has exclusive ownership of it.

In the spec "Intel 64 and IA-32 Architectures Software Developer's Manual,
Volume 3B: System Programming Guide, Part 2", section "18.8.1.3 Off-core
Response Performance Monitoring in the Processor Core", it defines the
REMOTE_CACHE_FWD as:

"L3 Miss: local homed requests that missed the L3 cache and was serviced
by forwarded data following a cross package snoop where no modified copies
found. (Remote home requests are not counted)".

Except SNOOPX_FWD means a no modified cache snooping, it also means it's
a cache conherency from *remote* socket.  This is quite different from we
define SNOOPX_PEER, which only snoop from peer CPU or clusters.

If no objection, I prefer we could keep the new snoop type SNOOPX_PEER,
this would be easier for us to distinguish the semantics and support the
statistics for SNOOPX_FWD and SNOOPX_PEER separately.

I overlooked the flag SNOOPX_FWD, thanks a lot for Kan's reminding.

Thanks,
Leo
