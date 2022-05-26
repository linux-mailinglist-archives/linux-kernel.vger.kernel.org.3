Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16625350EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347601AbiEZOpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347489AbiEZOpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:45:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EFCD682E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:45:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z11so1940646pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+RbLucXFRxTah8kZ+jl2a5HS0Pr8cEZF8tVZzhFz8Rw=;
        b=VTTfvSBKq+WmDXM0HZ8z+rbfgMlszuIkE5XXSA9MVpVtUBM0dh5XAORtdBRuhwFpdG
         +fRQ5fPA2wvPliUOJuiuKXzbcyhlBmi3PuebPlabzgVCUcWkNo6R3xGy/DlsF2dsQPnK
         e7zCpLnRvT+QzndGdLRekSFJoLQxTMIq4cGPsgKLt14JNqwTyt2kjN1Elb23mkNs5Qfz
         AfGv0t1+WYgAvuLi1fw31O7zB8vz6/JXGceKPPiwai6d/3oMHwliAvskJloYKFpjLM1Y
         FYueK4JMlxzlSLedpXavCfTOo2lkV4YWsVgfi+1KFg3gcjgJmsHaYqNqo/PQKagjUqFV
         QYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+RbLucXFRxTah8kZ+jl2a5HS0Pr8cEZF8tVZzhFz8Rw=;
        b=J0nFBwj5hSIsmsJBgUO2TMw5NrAZV5yB/KKp9b2pXsFshzWNDuA6sdSuA8MG05vTAq
         SGtaT3vhBpoSYnW8hujw63hiBEThH598KStZ8yQ+8hHSfVsmis6e0EebSZ8s6Gb4YgYL
         EIg184dtlrn5m9zxHjySzsURXD8FpMtA3E9qKH88zNzVSeLnHaqCzvqWejrtRsSnYT0w
         h5dtIoddqt9qQahxczUAM0EhYdEdSruTQXmC/0Nfc8xTzSzpIhJ6PlVhUuVEGRReINDL
         kQJJ+1J7YoR8tUeV2Y59/YZESV6FlemZhgo3FidI8xD6bIq15rRZVptv8Li5EAMhu39O
         lOXQ==
X-Gm-Message-State: AOAM530ApxLjQHmXvfI1jChD9uO4NJuvvUJCiBn3dtw0WnxDXp6KApiL
        C4ruYi0wvx+lYZ6+ARPIZq3zcg==
X-Google-Smtp-Source: ABdhPJwXNqAMHg5wxewtScCEWWIVKUg1NiL/cGKvS+oTPPtDWE9rp4KUd21tfnPif4/FUV3Ux/IPvw==
X-Received: by 2002:a17:90b:4c4c:b0:1df:bab5:4f56 with SMTP id np12-20020a17090b4c4c00b001dfbab54f56mr2999734pjb.202.1653576300894;
        Thu, 26 May 2022 07:45:00 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id z17-20020a170902d55100b0015e8d4eb269sm1633098plf.179.2022.05.26.07.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:45:00 -0700 (PDT)
Date:   Thu, 26 May 2022 22:44:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Joe Mario <jmario@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com,
        Jiri Olsa <jolsa@kernel.org>, kjain@linux.ibm.com,
        lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v8 0/4] perf: arm-spe: Decode SPE source and use for perf
 c2c
Message-ID: <20220526144453.GC795802@leoy-ThinkPad-X240s>
References: <20220517020326.18580-1-alisaidi@amazon.com>
 <YoQRg1r7HuwiO3bZ@kernel.org>
 <20220518041630.GD402837@leoy-ThinkPad-X240s>
 <32e5a3b7-9294-bbd5-0ae4-b5c04eb4e0e6@redhat.com>
 <20220522061533.GA715382@leoy-ThinkPad-X240s>
 <7bf021df-2755-6937-629f-b3ed9281804d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf021df-2755-6937-629f-b3ed9281804d@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Mon, May 23, 2022 at 01:24:32PM -0400, Joe Mario wrote:

[...]

> Hi Leo:
> I figured out why my output was different than yours.
> 
> I did not have the slang-devel rpm installed on the host system.  
> 
> In my original perf build, I missed the this output in the build log:
>  > slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
> 
> Once I installed slang-devel, rebuilt perf, and then reran my test, the pareto output looked fine.
> 
> When the TUI support is disabled, it shouldn't corrupt the resulting stdio output.  I don't believe this has anything to do with your commits.  

Thanks for taking time to hunt this issue.  I checked the code and
sent out a patch to fix the stdio interface if slang lib is not
installed.  Please see the patch:

https://lore.kernel.org/lkml/20220526143917.607928-1-leo.yan@linaro.org/T/#u

> Last, it looks like you should update the help text for the display flag options to reflect your new peer option.
> Currently it says:
>    -d, --display <Switch HITM output type>
>                           lcl,rmt
> 
> But since you added the "peer" display, shouldn't the output for that help text state:
>    -d, --display <Switch HITM output type>
>                           lcl,rmt,peer

Yeah, will fix.

Very appreciate for your detailed testing and suggestions.

Leo
