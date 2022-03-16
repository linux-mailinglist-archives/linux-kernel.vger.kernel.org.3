Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15D14DAFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355851AbiCPMnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355826AbiCPMnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:43:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAC966613
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:42:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a8so3879658ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YrCeMG8+8SJcl5IZrnVgtr+ceay0Mers6Na6OnHdZTw=;
        b=TQRVGhRWirfiJIhyx1moflTGQ2SHv5VR189C5W4KZyH7DlZ2rW9FEsvGD9FWt9I729
         6r6oqrS6HdE2ipMubO90ffqAZyb2sIM6NbeEP/2TZ0aLFd6E1eBlGPL5OLz3dqo+tm1N
         Ou8pFbDCnvi6bRVKAB3+kwxfQbZ+QtMBtnCbCyWzvkEzyhrJqZ5Sh/NKh9f6iaurn9cu
         0JVtE9A4aoU0LSvn41hPlpWVSMOSRqPrVmXD9su5dheW/lhIxpoWLbsZY+R/NgEkfSqs
         Jli8rq+I5RMhg7WEUMeEWoLXboU+MU6+7waPqhl5i+MhiJLcgkKo2tz0O6HeRFYohwNK
         ph7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YrCeMG8+8SJcl5IZrnVgtr+ceay0Mers6Na6OnHdZTw=;
        b=ivWYN+XZJhgmzqemoAAf6n0Lndjm+9T0PdXGLhyrK/coQPcJ8Y5XcBwdMVLXDbmg0b
         FGtcQHPMOioB8eTh4r7AP/imda+3DzPr7HAi4Q1OLJKZNU/DZOiP8+t/H/b0XnLzb4KH
         jBl+7vu26KB9S6UX2pBFB0QcuRC74V9zQQ0we+qSXMp2HbkYjUqYQW8FfoeuWmTywis8
         symhWFCod1cnNj56nKNOiZ9JqsgCvz8sS460pPcA5XfE2NjJ00CZvNuHCxlA7Drhksxl
         qaJ1EUkFHwAtJh5ie5mSlL50xawgXxcib11zLM8cjCm6hu8MeLO086NNo/HRcwrF/ATu
         VhcA==
X-Gm-Message-State: AOAM533ypCz3L386MUwKyjB8SktOYz1KHT1HR49cCRjQnt2r3a54eQiD
        8kVfdYz+cDgK80lOjqNqBKRc1w==
X-Google-Smtp-Source: ABdhPJznn6FFCYH1rXZ8XxK4RoArSWMYjykUAYamaJ2woslaFFp5HwYgTC7qyrPkecYF6b5PzCCjNA==
X-Received: by 2002:a17:906:9c81:b0:6df:78a0:fb37 with SMTP id fj1-20020a1709069c8100b006df78a0fb37mr2989398ejc.703.1647434536233;
        Wed, 16 Mar 2022 05:42:16 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id y14-20020a056402440e00b00416046b623csm980513eda.2.2022.03.16.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 05:42:15 -0700 (PDT)
Date:   Wed, 16 Mar 2022 20:42:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, james.clark@arm.com,
        john.garry@huawei.com, jolsa@kernel.org, kjain@linux.ibm.com,
        lihuafei1@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mathieu.poirier@linaro.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, will@kernel.org,
        yao.jin@linux.intel.com, Nick.Forrington@arm.com
Subject: Re: [PATCH v2 2/2] perf mem: Support HITM for when mem_lvl_num is
 used
Message-ID: <20220316124208.GA310478@leoy-ThinkPad-X240s>
References: <df73fb93-3892-6713-8ebe-bc57a861ec5d@arm.com>
 <20220314183721.3198-1-alisaidi@amazon.com>
 <172ce478-b539-2aa4-0470-1b96c6b8169b@arm.com>
 <7b3aaa4d-5194-a729-f8ad-d55ada7fa58f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b3aaa4d-5194-a729-f8ad-d55ada7fa58f@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 11:43:52AM +0000, German Gomez wrote:

[...]

> >>> I had a look at the TRMs for the N1[1], V1[2] and N2[3] Neoverse cores
> >>> (specifically the LL_CACHE_RD pmu events). If we were to assign a number
> >>> to the system cache (assuming all caches are implemented):
> >>>
> >>> *For N1*, if L2 and L3 are implemented, system cache would follow at *L4*
> >> To date no one has built 4 level though. Everyone has only built three.
> > The N1SDP board advertises 4 levels (we use it regularly for testing perf patches)
> 
> That said, it's probably the odd one out.
> 
> I'm not against assuming 3 levels. Later if there's is a strong need for L4, indeed we can go back and change it.

Thanks for the info.

For exploring cache hierarchy via sysFS is a good idea, the only one
concern for me is: can we simply take the system cache as the same
thing as the highest level cache?  If so, I think another option is to
define a cache level as "PERF_MEM_LVLNUM_SYSTEM_CACHE" and extend the
decoding code for support it.

With PERF_MEM_LVLNUM_SYSTEM_CACHE, it can tell users clearly the data
source from system cache, and users can easily map this info with the
cache media on the working platform.

In practice, I don't object to use cache level 3 at first step.  At
least this can meet the requirement at current stage.

Thanks,
Leo
