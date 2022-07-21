Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF9357C190
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiGUA1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiGUA1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:27:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BEB74CCD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:27:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id os14so422455ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bCLRjsvYtRZeZNV9Bm912X2zs0KkM1GXJxaEZhHa5nE=;
        b=HqMfVkkMPd0BQ06k135notIHxmB0/Wr0NhajRsDIE/q1frPsEfF5cN+9ONCxbxnP5D
         L8vG6ozVaqzhR98wdBJ3ap2Woe6/8AyIcyHIqcCkGQsZp0YnD/5meOUjRNixzqOjEsrm
         d/lKXf7c5DfoJp5ahmT4ImNt6nj3COLZ/j8d2YdNhuQT9yJuWBKYKaVpVcTGqOkAjErr
         JywaPH9o2dDwLwd+A389tgG/QBjfKvEBom4Q3mTtorlMiVxiWY1B5JAsdRHtRvHIhipA
         47niDJYvv3ly9eHuFjYat0VcT4Y9bv9RcCdGmOeneOm8kczIQeq3nCZeSyVMZGTxjNBw
         u/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bCLRjsvYtRZeZNV9Bm912X2zs0KkM1GXJxaEZhHa5nE=;
        b=sygpBJ2fnE+4WzVt6U8iMAfyZjrOVod9Yfb5hTBHqVIcjBxKfDhcUIWDokfPsBeWdh
         buDrWMoMhpxQkggqB8bB7UsH9oBY97z5ADo3w1zjH6LPN3goQ+lfCe6zhOnAMrG75Wvs
         flScHXKm6YSBPH340Tfv77JrDAqqn67ys6r76NCfqEIy+isZE+f3xdiFoLyxWbw4F8jA
         O9hgY5xT2pFcQLkG6ksR1wWKf/nVNBA9+BULgRd3Wbf2FCT2XHZoxuRUK5W/tkst9wqZ
         P702GBDk89C49ifnNPj7DGssGtymDYaYVd56dJdtE8Af+lORYp/Ob+3jGTrmLAgdZt1U
         SbOw==
X-Gm-Message-State: AJIora+iZZjhlMv8YjygmjPwBA01JdfVUHRsDsaosbk2LWTm81W21gFW
        qvrblm9sJvQSBVqAFOXqJr1SMA==
X-Google-Smtp-Source: AGRyM1vgRhqQv3LgmIHebxs9JwPcvjq22yU0EnYatlVT11ojjmDMODN5Id2uFmWBXjUd5sSDsbQ2ig==
X-Received: by 2002:a17:906:7e43:b0:72b:52de:b039 with SMTP id z3-20020a1709067e4300b0072b52deb039mr38326269ejr.198.1658363246662;
        Wed, 20 Jul 2022 17:27:26 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.97.246])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090623ea00b0072ab06bf296sm213886ejg.23.2022.07.20.17.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 17:27:25 -0700 (PDT)
Date:   Thu, 21 Jul 2022 08:27:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH v5 01/17] perf: Add SNOOP_PEER flag to perf mem data
 struct
Message-ID: <20220721002719.GA29595@leoy-ThinkPad-X240s>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
 <20220604042820.2270916-2-leo.yan@linaro.org>
 <YthNXweIEdNfcoX1@kernel.org>
 <YthNmcOJOZitcsjD@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YthNmcOJOZitcsjD@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 03:46:49PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jul 20, 2022 at 03:45:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Sat, Jun 04, 2022 at 12:28:04PM +0800, Leo Yan escreveu:
> > > From: Ali Saidi <alisaidi@amazon.com>
> > > 
> > > Add a flag to the perf mem data struct to signal that a request caused a
> > > cache-to-cache transfer of a line from a peer of the requestor and
> > > wasn't sourced from a lower cache level.  The line being moved from one
> > > peer cache to another has latency and performance implications. On Arm64
> > > Neoverse systems the data source can indicate a cache-to-cache transfer
> > > but not if the line is dirty or clean, so instead of overloading HITM
> > > define a new flag that indicates this type of transfer.
> > > 
> > > Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > > Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
> > 
> > Hey, any knews about this going upstream? PeterZ?
> 
> Just took a look and it isn't in tip/master.

Yeah, this patch is not picked by maintainers.

I confirmed that this patch can be applied cleanly on tip/master
branch.  Peter.Z, could you pick this patch?

Thanks,
Leo
