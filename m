Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149B24F1807
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378469AbiDDPO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378450AbiDDPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:14:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C63B297
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:12:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k23so17175399ejd.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ltdVIr5hib0+ak/jhu+JrlIb6MgeCdcOgL6iYru4NN8=;
        b=dGNHzuEdI9Z2soncKftgc697gXjduv24OkaB/tZG9kZYBD7i61c5sGcz57Fokrhcpi
         xJsjFdfQfQitpicNqmI+ujEeoVo6k4AwomQDVht0os6sDOZsfXEJujdRcP+EOpaGzUUu
         jF8+yuYK/FYeSYTxhnAuNTQDG3goXouXX+nr7RTFOnkYC0150RpTnYiKCZorDYNtei6B
         FEDi9wI+SKG2Haudn5ZiK7bY7OlKoic79yC8qP1ZKnPhDb4l9QBNp6xofa0BVYsbpR2F
         E5/cCZ+DCbLDBBNzQBLYh/2dNE5eWCqHP24rmqF3oTa4LgjU5T5nBgAXwrValSVeGonw
         /rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ltdVIr5hib0+ak/jhu+JrlIb6MgeCdcOgL6iYru4NN8=;
        b=a00VPbG4dPIRT2gEIYGIC83WC45Xma8gHAow6V/Lg4OVSy+QpWpKo6lZi/9LuyCfLT
         jcb0VHkKUzjNQRkmd+IollSOXyq7xL0f1gSMvmh6/lmXe+mCJ4D+ZO6Y41rZyn8wzWxA
         GY4Y3F9rHRUCb48LDGR2JMB1VkT5bANfc+YRSDfFuVSzr8Yq0za5F/hcfTR1qtuL/Jh6
         loRzL2OQfLHjIRPQcaQQZI4102mbctxf7JtcG6KKLkJjB13zVW8V0KFre+FxeEn3r+NK
         BortSq3NFUHzNDgDu2AaBzK84wbV+nHCHX58qkzjud1cPJNQ060XRuSFd1GjrglCJZL8
         KnSw==
X-Gm-Message-State: AOAM533QLxTZKPqZxidzrhx6bFP1nd78qYGPtmM27Sxg6jKeruDPnYPE
        sQpTkj90fyZH8AITNCBr72Vz+A==
X-Google-Smtp-Source: ABdhPJxQD8Njo17IzsiD3bfKEKw15dT8Rosm9yTKOGFbyCoTmFHNxteksl2NZVUZ/FV36zDfslA6/Q==
X-Received: by 2002:a17:907:1c1b:b0:6e0:6618:8ac with SMTP id nc27-20020a1709071c1b00b006e0661808acmr573509ejc.82.1649085147161;
        Mon, 04 Apr 2022 08:12:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id r16-20020a056402019000b00418ed60c332sm5456100edv.65.2022.04.04.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 08:12:26 -0700 (PDT)
Date:   Mon, 4 Apr 2022 23:12:18 +0800
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
Message-ID: <20220404151218.GA898573@leoy-ThinkPad-X240s>
References: <20220331124425.GB1704284@leoy-ThinkPad-X240s>
 <20220403203337.18927-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403203337.18927-1-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 08:33:37PM +0000, Ali Saidi wrote:

[...]

> > Let me just bring up my another
> > thinking (sorry that my suggestion is float): another choice is we set
> > ANY_CACHE as cache level if we are not certain the cache level, and
> > extend snoop field to indicate the snooping logics, like:
> > 
> >   PERF_MEM_SNOOP_PEER_CORE
> >   PERF_MEM_SNOOP_LCL_CLSTR
> >   PERF_MEM_SNOOP_PEER_CLSTR
> > 
> > Seems to me, we doing this is not only for cache level, it's more
> > important for users to know the variant cost for involving different
> > snooping logics.
> 
> I think we've come full circle :).

Not too bad, and I learned a lot :)

> Going back to what do we want to indicate to
> a user about the source of the cache line, I believe there are three things with
> an eye toward helping a user of the data improve the performance of their
> application:

Thanks a lot for summary!

> 1. The level below them in the hierarchy it it (L1, L2, LLC, local DRAM).
> Depending on the level this directly indicates the expense of the operation. 
> 
> 2. If it came from a peer of theirs on the same socket. I'm really of the
> opinion still that exactly which peer, doesn't matter much as it's a 2nd or 3rd
> order concern compared to, it it couldn't be sourced from a cache level below
> the originating core, had to come from a local peer and the request went to
> that lower levels and was eventually sourced from a peer.  Why it was sourced
> from the peer is still almost irrelevant to me. If it was truly modified or the
> core it was sourced from only had permission to modify it the snoop filter
> doesn't necessarily need to know the difference and the outcome is the same. 

I think here the key information delivered is:

For the peer snooping, you think there has big cost difference between
L2 cache snooping and L3 cache snooping; for L3 cache snooping, we
don't care about it's an internal cluster snooping or external cluster
snooping, and we have no enough info to reason snooping type (HIT vs
HITM).

> 3. For multi-socket systems that it came from a different socket and there it is
> probably most interesting if it came from DRAM on the remote socket or a cache.
>
> I'm putting 3 aside for now since we've really been focusing on 1 and 2 in this
> discussion and I think the biggest hangup has been the definition of HIT vs
> HITM.

Agree on the item 3.

> If someone has a precise definition, that would be great, but AFAIK it
> goes back to the P6 bus where HIT was asserted by another core if it had a line
> (in any state) and HITM was additionally asserted if a core needed to inhibit
> another device (e.g. DDR controller) from providing that line to the requestor. 

Thanks for sharing the info for how the bus implements HIT/HITM.

> The latter logic is why I think it's perfectly acceptable to use HITM to
> indicate a peer cache-to-cache transfer, however since others don't feel that way
> let me propose a single additional snooping type PERF_MEM_SNOOP_PEER that
> indicates some peer of the hierarchy below the originating core sourced the
> data.  This clears up the definition that line came from from a peer and may or
> may not have been modified, but it doesn't add a lot of implementation dependant
> functionality into the SNOOP API. 
> 
> We could use the mem-level to indicate the level of the cache hierarchy we had
> to get to before the snoop traveled upward, which seems like what x86 is doing
> here.

It makes sense to me that to use the highest cache level as mem-level.
Please add comments in the code for this, this would be useful for
understanding the code.

> PEER_CORE -> MEM_SNOOP_PEER + L2
> PEER_CLSTR -> MEM_SNOOP_PEER + L3
> PEER_LCL_CLSTR -> MEM_SNOOP_PEER + L3 (since newer neoverse cores don't support
> the clusters and the existing commercial implementations don't have them).

Generally, this idea is fine for me.

Following your suggestion, if we connect the concepts PoC and PoU in Arm
reference manual, we can extend the snooping mode with MEM_SNOOP_POU
(for PoU) and MEM_SNOOP_POC (for PoC), so:

PEER_CORE -> MEM_SNOOP_POU + L2
PEER_LCL_CLSTR -> MEM_SNOOP_POU + L3
PEER_CLSTR -> MEM_SNOOP_POC + L3

Seems to me, we could consider for this.  If this is over complexity or
even I said any wrong concepts for this, please use your method.

Thanks,
Leo
