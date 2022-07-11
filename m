Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950DD56D22E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 02:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiGKAaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 20:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGKAaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 20:30:22 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4FD65BD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 17:30:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s27so3412136pga.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 17:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DJg3YRH6CUXfVSsu3n1w0/lNOyzgmf1DQiZyHhqhZhU=;
        b=VQBocgpCZ4dsFBSfRIbIYncvcQdzbFY/GrStM11S9TEcEutsI6A/hj/x2or3uh7IWv
         2bV1KqaArnRAWWDmYi4SxctLDaDTCSxASaK1vIZc8gPIIHuvpLNdchkI5Sjdcwuhml67
         3IFeueE1cpV8ZfhHao8V/NYSFyew+CmaSdJP6X4yTqLog3uU77sSJZayfkEF2rG5JhUh
         2xZqPUyUAssgnzFep/Yi1PgYag6Q3tKsYn/V7q3BwPpc1yBNcBJws0vBXzbKLkx//yW0
         SLY/zAEnzWNphB2tBUZNlStfBN7Hc6SjRr+md+qmISmFdOraLZLz95ZLBAnAqqancBNC
         6L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DJg3YRH6CUXfVSsu3n1w0/lNOyzgmf1DQiZyHhqhZhU=;
        b=HMNgmxd/NcGTe8Wo+ZtkoTVaDzgEu+OsWTQiZeEDofgGjERAWaEMORPCUNCpAQCFwU
         S4aLj3InaBEkmjCUtX+MUEMaxhbblipxiEWDeFGRYP364CNmoukbrZOt3rVfUQkZTwXa
         /lhTG8MMC/4jITAtUVN1ELdfFpq65l24SlCE9CiMtIsZQaM3kadwlxk6gDq6eeoEI4qW
         8hGRY4fl3mDiUdrtHvHBWcAXiS38T2ikYH8WIjgAc10n+cfyvWAPhl2b+J+EjueuqV8i
         JMt4FezTT7mbaVbMforxPGXsI7VrkSkeVwQjuD6zwoA6EsSPvYq88bEO6ci7YHlSnb20
         /YDQ==
X-Gm-Message-State: AJIora96hsnRm5OxwHhu1wHUE5qvtAZgpLjm8waWAOMLFZ4EDbR1IcFL
        r5+s1/HHMXogT3y/i1fws+d8yg==
X-Google-Smtp-Source: AGRyM1vMXt7mVlflj87k8nDofAiOwRDlpcv/PraUDQsidAU0LuwEsrMYoGVKQjfBncUQPBeyufqO9w==
X-Received: by 2002:a05:6a00:2384:b0:52a:b75b:1123 with SMTP id f4-20020a056a00238400b0052ab75b1123mr11870976pfc.8.1657499420447;
        Sun, 10 Jul 2022 17:30:20 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902654900b0016bfb09be10sm3244937pln.305.2022.07.10.17.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 17:30:20 -0700 (PDT)
Date:   Mon, 11 Jul 2022 06:00:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] AMD Pstate Enhancement And Issue Fixs
Message-ID: <20220711003010.iofsk6xdyxkvmsnl@vireshk-i7>
References: <20220709140835.830084-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709140835.830084-1-Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-07-22, 10:08, Perry Yuan wrote:
> Hello,
> 
> This patchsets adds support for precision boost hardware control
> for AMD processors.
> 
> Meanwhile the patchset fixs lowest perf query and desired perf scope issues.
> Update transition delay and latency default value to meet SMU firmware requirement.
> and do some code cleanups,
> It also exports cpufreq cpu release and acquire for coming amd-pstate epp mode driver
> 
> The patch series are tested on the AMD mobile and EYPC server systems

Please use "--thread=shallow" option while generating patches with
git, these should be part of a single thread.

-- 
viresh
