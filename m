Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC3C508355
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376684AbiDTI0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376703AbiDTI0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:26:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29372DAB0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:23:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id s18so2035697ejr.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xr/nwtWLJ4TVu51kmsxUrzU9/ydN9NkiuHnUJzHV7fM=;
        b=HdpM/EEKgkbRipP0cAc3Eq561sf8la7DC871v+kRQo5yDV0HaXu0mE1BYlFEDMHvyA
         JSq91bpiBkpSofh7MNm/eIWm7xhqUdahyWYtQT19REhiexB3m+0w1Ro9/zwbmopG79Is
         Sg/Wc3V23gXKMNfDszhod1Xp6jkO/JEj/Ua/+J4W7cGyvx33kCA40eWNiNlhMoKeN8Ww
         9r92eQn+3e2xKGxfCMokEfE8G+H6tTbXr14BZtDdE2fSUWUCUNyTXq633K4fbu+ggvU/
         tGNLFH1G9tT1uWBIHhvEqwQWjY1W/QJpWE80CJad6Bbq/w4Whn+XWT4FqFikd3SGdOqf
         0lNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xr/nwtWLJ4TVu51kmsxUrzU9/ydN9NkiuHnUJzHV7fM=;
        b=xFtiZnPbKVDVUXcB1z/oVGVOJdlBuqQOnl5kPIKgywFrH370xfh0MyJclO+YtD3Gf6
         N4bmUPR7CI0i6c50n+eRHbQhZYdryypSD84QQiDbKv81v1ASiDaVYO/0DgYGrIXG0c5O
         c+I0x/LrjTxd0WMK3HmhsWDgCI0IMMk1yqRy3YbWMog9t8Sd6vI/eNGDDTOgSBtjFgSD
         izsKEsA9w+hzbMkNjKkTFHRy7pWdHn/8SVT3aQZOW6VMc8x/ObYyGAH/GP0VEyC5P9R0
         nfY+DMTrBTCEw1mrZGicNfYII7DqM3BTB+LOi5okNEh+7K+Dc/BN1koqIMDTd+AQmGrX
         v0Pw==
X-Gm-Message-State: AOAM533WWuleoyGN6fMcBk/YVQi4AWMzAtNHh1YO3t36SgPoR8Kobxbr
        4nu9FBNqbrpp6C6rBuAGJSBVvw==
X-Google-Smtp-Source: ABdhPJxmVvwxaASEaA16ZHiFrG8KB1I8Px1ZRIfmaCjtMBOMeQ0BQ3KZfr0IsdqGObsczZkGlCfPjw==
X-Received: by 2002:a17:907:7da3:b0:6f0:d63:69bd with SMTP id oz35-20020a1709077da300b006f00d6369bdmr482243ejc.289.1650442998280;
        Wed, 20 Apr 2022 01:23:18 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709066d8800b006e09a49a713sm6500926ejt.159.2022.04.20.01.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 01:23:17 -0700 (PDT)
Date:   Wed, 20 Apr 2022 16:23:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, acme@kernel.org,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v5 3/5] perf tools: sync addition of PERF_MEM_SNOOPX_PEER
Message-ID: <20220420082311.GB843168@leoy-ThinkPad-X240s>
References: <20220408195344.32764-1-alisaidi@amazon.com>
 <20220408195344.32764-4-alisaidi@amazon.com>
 <39448754-adf5-f1ba-25e7-8ee3d76f0159@arm.com>
 <47ec29fe-75ea-62ef-447b-1164569616de@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ec29fe-75ea-62ef-447b-1164569616de@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 03:35:52PM +0100, German Gomez wrote:
> 
> On 11/04/2022 11:26, German Gomez wrote:
> > On 08/04/2022 20:53, Ali Saidi wrote:
> >> Add a flag to the perf mem data struct to signal that a request caused a
> >> cache-to-cache transfer of a line from a peer of the requestor and
> >> wasn't sourced from a lower cache level.  The line being moved from one
> >> peer cache to another has latency and performance implications. On Arm64
> >> Neoverse systems the data source can indicate a cache-to-cache transfer
> >> but not if the line is dirty or clean, so instead of overloading HITM
> >> define a new flag that indicates this type of transfer.
> > I think it's fine to merge this and the previous commit rather than have
> > two commits with the same msg.
> >
> 
> I take it back. It has been pointed out to me that having the separation
> is normal/ok. So my comment doesn't apply.

Yeah, it's good that we split these two patches since it's easier
for maintainer to pick up separately :)

Thanks,
Leo
