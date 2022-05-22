Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E21B530357
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbiEVN2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 09:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345952AbiEVN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 09:28:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59B53B036
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 06:28:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l14so11795122pjk.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ODCcZqtARQzQ4GGmhDAMqDnN52rPA8Uu34tLe5UIzMU=;
        b=vhwSXwGc/fbz4Js0Ua+WwXL6PC7yUZrdvIN4VKjt0SXfmp2hl4hhvJ0gp1IMdzx+sx
         SEhunI/FFODzeLCKRy+diJhiwSJcvaC/VjfSSxBan2XzJZx/Yuih12qxXIFmnTuWdkv2
         llx3lsVNe6E3ux+uAc7rBbTTk2oPhmOEN3dDOI+vccclG1cD8hbcRX8Yc6CaJZz9NK1z
         UGHEeUEQ83P0xZ1zKa3StaKdnwPxWrnf2HQtoNoQNUjGrZkvfpgMkznzl6xKBPetay9v
         jhgPQ0gqKJUra5M9mf4x90H2/X8YG/+JZEvPEE8vX7RXfwUWIj7TA3HngA7EnCTr5k+W
         JRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODCcZqtARQzQ4GGmhDAMqDnN52rPA8Uu34tLe5UIzMU=;
        b=uxfbTzuPg+Gow4OkCN3BS8VB1DVIfbZ3yyl0xP80pLp1ax5LzOLmP+D6tGPv4SzkTC
         jwgqs0/24AwfJ6rx4UdiO7ymfjFGFYYbooC6TxnyDQhPbaDqZWJ1iL9JCc4mOXqKdzyo
         bitYPkWxjdDGQBjaz4cMmmMvT1NaYNXaajDz8tYgrJkNksWdUtlkvgG8DOEJJ66j0TsT
         PxFsD27q1IXVrHSHLM/QzImV8SGpnIc9Hxfg55Z3Ejyuo+0lGJQX4VkD9i4gGghc2qL1
         rL7TbhfJ17CGxCT/2QjCCNhOx3xQRL816O8j6X148hiKxT7YFJSZXDb8W7HVzLb9ZAXE
         xsTQ==
X-Gm-Message-State: AOAM531pyM87oUQkoM5kGkqKL4c29ytgH43Qjp8vO8802OzQ/VtdUBIP
        SzORcDdPvEizO3mP2fVEPErfEw==
X-Google-Smtp-Source: ABdhPJy5qH6tJV1FmBBPDXG5uzbO+MIWPZedP729Ih+V3nlqSanV/jF6N74yTgSOklzN9r4P0euIGg==
X-Received: by 2002:a17:90a:e388:b0:1df:ac20:df7d with SMTP id b8-20020a17090ae38800b001dfac20df7dmr22146463pjz.208.1653226082306;
        Sun, 22 May 2022 06:28:02 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([137.184.121.66])
        by smtp.gmail.com with ESMTPSA id j195-20020a636ecc000000b003db0f2d135esm2983622pgc.49.2022.05.22.06.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 06:28:01 -0700 (PDT)
Date:   Sun, 22 May 2022 21:27:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adam Li <adamli@os.amperecomputing.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Ian Rogers <irogers@google.com>,
        Alyssa Ross <hi@alyssa.is>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/11] perf c2c: Sort on peer snooping for load
 operations
Message-ID: <20220522132752.GC715382@leoy-ThinkPad-X240s>
References: <20220508092346.255826-1-leo.yan@linaro.org>
 <20220508092346.255826-10-leo.yan@linaro.org>
 <fefc1f23-ea1c-6339-77c4-b0974cbd6e93@amperemail.onmicrosoft.com>
 <20220518061221.GA430350@leoy-ThinkPad-X240s>
 <e87bc3d7-6664-a1b7-faee-6117aa1d121c@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e87bc3d7-6664-a1b7-faee-6117aa1d121c@os.amperecomputing.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 05:06:18PM +0800, Adam Li wrote:
> Hi Leo,
> 
> Thanks for the update.
> On 5/18/2022 2:12 PM, Leo Yan wrote:
>  
> > Please note, in the total statistics, all remote accesses will be
> > accounted into metric "rmt_hit", so "rmt_hit" includes the access for
> > remote DRAM or any upwards cache levels due we cannot distinguish
> > them.
> >
> 
> Agree that "Load Remote HIT" makes more sense than "Load Remote DRAM".
>  
> > From my experiment, with this updating the output result is promised
> > for the peer accesses and it's easier for inspecting false sharing.
> > 
> > As you might see I have prepared a git repo:
> > https://git.linaro.org/people/leo.yan/linux-spe.git/ branch:
> > perf_c2c_arm_spe_peer_v3, which contains the updated patches for both
> > memory flag setting and perf c2c related patches.
> > 
> > Could you confirm if the updated code works for you or not?
> > 
> 
> I tested v3 patch (perf_c2c_arm_spe_peer_v3 branch) on 2P Altra system.
> 
> Compared with v2, "Snoop Peer" can better indicate cache false-sharing,
> for the 'false_sharing.exe' test case.

Thanks a lot for the testing and confirmation, Adam.

I will update the patches based on the comments from Joe and James,
after get ready will send out the patch set and loop you.

Thanks,
Leo
