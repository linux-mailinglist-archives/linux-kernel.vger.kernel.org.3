Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF84F8CAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiDHBIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiDHBIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:08:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493C910FDEE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:06:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z16so7088622pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 18:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L9V8khs2Pw9oU0MoU+h4vOiXzP1pcSaWg3ChFlkePHo=;
        b=vo6sJW3cBrcN6VOxtEd/FAbg7J4ohvujEc1YI4GFeoJGmubYimrIMWVg4e0SLCS9Vj
         spa5FKQkLJaElouFG7Eucrhp+SDVBXLSKlmpDfjUlhmkX0XEDlvcKuIi/POHIBlyJvAP
         rmzeqAM+ByuXCtq4ZThmrWSVfq/N6otsXfCQaaK6Dw4IDAzpiIcze7d2mgQiZTTjkDQf
         gNLQqaKqr0ui7cMTfO9SlJOub05PARpSUvGFFD95r0xmCzsewchhT4RCaRg9Zlya3V5V
         Idc8Si5TdIz9d68/Gg7bJRcw6XR5iA9PKeJEXPIXVBlaHqTHcifguf2AeFl2C8rPyBVx
         o4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L9V8khs2Pw9oU0MoU+h4vOiXzP1pcSaWg3ChFlkePHo=;
        b=goYIgfvTIFCeuZ0ClJOHqQhqzHdy+OlLYSidJBOLQOug+m8kunTrZAk+F88qzPqBxm
         XvhJCpfH3oUVJ2FV7oA/Pybec+Xyag6cObByrcx+v/7Ws6xgsb3JuMGSnhyyRC6qaeX5
         u4JDIzY4u3bqpaOkZpDjCWHd1hDveMx3M7F/XIAeXk44FI8XcQxOzWmq7qg32PhmPSQa
         fHb7OgpHlKFX7SkbaJAXegpWGThmz3SN+/MievjS4G+JRV3bc+dN2IEjkylB9TccTsdF
         uwFAhIe6qK4GhpjRbUfKbHP2X+8H+0T+mwJ8vSk1rhsst5tgLBQzl0IW3NvNUUML2KQx
         NLLw==
X-Gm-Message-State: AOAM533y/5KarcAf5qVYB2cYyJQPCbMCsy+/FUiQtInBTd54cFbqbT+E
        z7UIABajuvcLthKQMoMPOiIW9A==
X-Google-Smtp-Source: ABdhPJzbk8Fz0L2VMqW+YNbTDb7UYvDsO8em7MsCInr1vKUKjCrkwBfYbotqI1S94QdwLgc1/2hCpw==
X-Received: by 2002:a05:6a00:3316:b0:4fa:80fd:f3f6 with SMTP id cq22-20020a056a00331600b004fa80fdf3f6mr16682002pfb.65.1649380006462;
        Thu, 07 Apr 2022 18:06:46 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id a11-20020a056a000c8b00b004fade889fb3sm25226056pfv.18.2022.04.07.18.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 18:06:45 -0700 (PDT)
Date:   Fri, 8 Apr 2022 09:06:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220408010635.GA973239@leoy-ThinkPad-X240s>
References: <20220404151218.GA898573@leoy-ThinkPad-X240s>
 <20220406210017.11887-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406210017.11887-1-alisaidi@amazon.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 09:00:17PM +0000, Ali Saidi wrote:
> On Mon, 4 Apr 2022 15:12:18  +0000, Leo Yan wrote:
> > On Sun, Apr 03, 2022 at 08:33:37PM +0000, Ali Saidi wrote:

[...]

> > > PEER_CORE -> MEM_SNOOP_PEER + L2
> > > PEER_CLSTR -> MEM_SNOOP_PEER + L3
> > > PEER_LCL_CLSTR -> MEM_SNOOP_PEER + L3 (since newer neoverse cores don't support
> > > the clusters and the existing commercial implementations don't have them).
> > 
> > Generally, this idea is fine for me.
> 
> Great.  
> 
> Now the next tricky thing. Since we're not using HITM for recording the memory
> events, the question becomes for the c2c output should we output the SNOOP_PEER
> events as if they are HITM events with a clarification in the perf-c2c man page
> or effectively duplicate all the lcl_hitm logic, which is a fair amount,  in
> perf c2c to add a column and sort option? 

I think we need to handle both load and store operations in 'perf c2c'
tool.

For the load operation, in the 'cache line details' view, we need to
support 'snoop_peer' conlumn; and since Arm SPE doesn't give any data
source info for store opeartion, so my plan is to add an extra conlumn
'Other' based on the two existed conlumns 'L1 Hit' and 'L1 Miss'.

Could you leave this part for me?  I will respin my patch set for
extend 'perf c2c' for this (and hope can support the old Arm SPE trace
data).

Please note, when you spin new patch set, you need to take care for
the store operations.  In the current patch set, it will wrongly
always set L1 hit for all store operations due to the data source
field is always zero.  My understanding is for all store operations,
we need to set the cache level as PERF_MEM_LVLNUM_ANY_CACHE and snoop
type as PERF_MEM_SNOOP_NA.

> > Following your suggestion, if we connect the concepts PoC and PoU in Arm
> > reference manual, we can extend the snooping mode with MEM_SNOOP_POU
> > (for PoU) and MEM_SNOOP_POC (for PoC), so:
> > 
> > PEER_CORE -> MEM_SNOOP_POU + L2
> > PEER_LCL_CLSTR -> MEM_SNOOP_POU + L3
> > PEER_CLSTR -> MEM_SNOOP_POC + L3
> > 
> > Seems to me, we could consider for this.  If this is over complexity or
> > even I said any wrong concepts for this, please use your method.
> 
> I think this adds a lot of complexity and reduces clarity. Some systems
> implement coherent icaches and the PoU would be the L1 cache, others don't so
> that would be the L2 (or wherever there is a unified cache). Similarly, with the
> point of coherency, some systems would consider that dram, but other systems
> have transparent LLCs and it would be the LLC. 

Okay, it's fine for me to move forward to use MEM_SNOOP_PEER as the
solution.

Since German is looking into this part, @German, if you have any comment
on this part, just let us know.

Thanks,
Leo
