Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6304D7AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbiCNGfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiCNGfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:35:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC41EAC3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 23:34:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bi12so31602673ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 23:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tMMg4WQQYlz0uot7pHseP3erwI/+QvE1essU4518DNQ=;
        b=gHGaWW+9zdx2nMhyavqLvN3yhv++kdYLXpo/3qlRp6v9TA/jvXDcieX0V6rAEzmFD/
         sdHgZPbpv6nyznR1knnrJ16mS69yajty7YEc1k+MOOHTcVQen1AtRojdZJH3WJkadKKc
         eWDMjp6Z/FWIByWVEqyyBMMLs3uZmrnK2Q19fonFmY7S9MsBeQe+aIn+Mv9jKoaIoP9I
         /Bn8dm/L3ctnb/giKcVeZ38wBYMny4jhyARp0I9nTVs5AVcxoPsCGjRe+IqGenJV2GhG
         r+pL8nZg2klImb67nZDx5VE5K0qOaS+CKqIRv4NlODq0SL1YdcpzoIksjfdtSkwdqiCi
         THgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tMMg4WQQYlz0uot7pHseP3erwI/+QvE1essU4518DNQ=;
        b=NaWl9PSX7CXFx/4f6LiUckBIt81n2H4+OFBwdcUqw5RVh+i0+Clcjm5yXJ8mSP7leo
         bi6z972Msriz7Qrwbk/3zq/EivtXJjwbEkKOob9Acdg2Qv8GOIb4VUMHujOtRlyzJrdD
         HH0U7MxCasLCIbYFrzuIZKyWoFRqlXUcAMJ1dcPPr7RhuW9wiOymUjBufeI3AwY/z9sg
         1quGJ1ONw9P3CdG2+kmpvxBcYa9RC3M/kSI6Y+pSLk8WKmmY8hhwvhc7sDDsKmXM3yGP
         /j+eL63BAwiFdsPiR6DlPmChCFLRD2c/hyZ4Y7PBYFcZlJCfAWveMLMqBtcxV5aYDogN
         6z8w==
X-Gm-Message-State: AOAM5329UUXJl6XEcnGrp2OsUjco2jzHPkJDa1NU1uJplhsRMOCzf1ya
        1o9g6japE/32ayMrqZFjw9JAfQ==
X-Google-Smtp-Source: ABdhPJysJtjJNO/ccMll0pR1WCkbv7gByjW//bPYmXSPWvEeSpDddoRTUmHZzhqpZw9r3SuCmsPdrA==
X-Received: by 2002:a17:907:96a8:b0:6db:4c68:1393 with SMTP id hd40-20020a17090796a800b006db4c681393mr17226489ejc.87.1647239640969;
        Sun, 13 Mar 2022 23:34:00 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id e18-20020a50ec92000000b0041852b30c9esm4286696edr.27.2022.03.13.23.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 23:34:00 -0700 (PDT)
Date:   Mon, 14 Mar 2022 14:33:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        german.gomez@arm.com, james.clark@arm.com, john.garry@huawei.com,
        jolsa@kernel.org, kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org, yao.jin@linux.intel.com
Subject: Re: [PATCH v2 2/2] perf mem: Support HITM for when mem_lvl_num is
 used
Message-ID: <20220314063353.GB163961@leoy-ThinkPad-X240s>
References: <20220313124427.GB143848@leoy-ThinkPad-X240s>
 <20220313191933.26621-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313191933.26621-1-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 07:19:33PM +0000, Ali Saidi wrote:

[...]

> > > > +			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L4)) {
> > >
> > > According to a comment in the previous patch, using L4 is specific to Neoverse, right?
> > > 
> > > Maybe we need to distinguish the Neoverse case from the generic one here as well
> > > 
> > > if (is_neoverse)
> > > // treat L4 as llc
> > > else
> > > // treat L3 as llc
> > 
> > I personally think it's not good idea to distinguish platforms in the decoding code.
> 
> I agree here. The more we talk about this, the more I'm wondering if we're
> spending too much code solving a problem that doesn't exist. I know of no
> Neoverse systems that actually have 4 cache levels, they all actually have three
> even though it's technically possible to have four.  I have some doubts anyone
> will actually build four levels of cache and perhaps the most prudent path here
> is to assume only three levels (and adjust the previous patch) until someone 
> actually produces a system with four levels instead of a lot of code that is
> never actually exercised?

I am not right person to say L4 cache is not implemented in Neoverse
platforms; my guess for a "System cache" data source might be L3 or
L4 and it is a implementation dependent.  Maybe German or Arm mates
could confirm for this.

Thanks,
Leo
