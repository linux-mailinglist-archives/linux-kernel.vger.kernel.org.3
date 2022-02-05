Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB0F4AA59A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 03:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378851AbiBECST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 21:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355924AbiBECSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:18:18 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8571AC061346
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 18:18:16 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i186so6648097pfe.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 18:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4AAS8fIWh/l0yT84s2N0OwpkJuu2uO5DCn5UAAepPhI=;
        b=VHRXLlIcWZnN2D1y9h1C+Vq4zRVvUl4BtfdOD6iegKziQLHIMCBOZ4Rgq5+NovJ7Um
         9IVwLk3bR262kkdTxl2NJjZnO6pfTBpOL9yDinpotL1dk2cfRCVHIZTIjW8AIqmeEIoh
         FOoSxR7Sj5IxSy1jSz8oSfIMfnva396UzSAA3AhobE0j1YqEUUlE/g5DPK5seMK+0YL1
         oUv/C9c6kMRD/ILQULmtNL+YJgHIUImDRl41zqhUe82YB4ch5QKkEzm/ICCC26Bnhtjo
         ec9FMrrpwpqdSG0phj9fr2c/Ljdb87g/hTID1QcTizNVBNnPdaSeExFYvtslnuNwsUYe
         5wXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4AAS8fIWh/l0yT84s2N0OwpkJuu2uO5DCn5UAAepPhI=;
        b=xXfg/ojc9iV+gY0DRBj4sDXc0XFFAV4KCwqVgLuKuderTDJl0D6hG8pGaqGmrElANI
         9X/7M39dazR5xEZa9CVlAiIsoh/lTQkt+I0tmn/LR87VZ0ku8Ni5KsjvAp3mKiwJ+R9/
         GmC+dA64pAvvnH2MA0QRbhQRAFg1XEle8Cg/PpRFxueGgr0FG0kYZDEYOqp8hCsOCrxU
         fURnLwlGG/PqBqDkYjIg1y4Ph2hiepuizAyEmAwWcto9WjjJki59uq3t+sFAH1kjjGaW
         +71vluNYukMapdadJAHT9qNWetg2okem3cccgkdMKdTxeHMgjuH7GWmI/yY6YC2sM1jH
         iKNQ==
X-Gm-Message-State: AOAM5320kDsQOBOJQk29EAk/odqVdXIp6OvKWRXbYMO2bm1DWxtWAktt
        BjHtm+OkhAw/IpH31S83eCn5kA==
X-Google-Smtp-Source: ABdhPJyZI3AfMW4t77AbseKGIcD64WMJHKUx1HR9M/YEqj/rMfqaYAYSLrt0WVjVosStWhUjTwn0hw==
X-Received: by 2002:a63:87c3:: with SMTP id i186mr1483051pge.311.1644027495282;
        Fri, 04 Feb 2022 18:18:15 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id m38sm2530918pgl.64.2022.02.04.18.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 18:18:14 -0800 (PST)
Date:   Sat, 5 Feb 2022 10:18:07 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     Al.Grant@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH] perf arm-spe: Use SPE data source for neoverse cores
Message-ID: <20220205021807.GA2052922@leoy-ThinkPad-X240s>
References: <20220203091934.GA2013381@leoy-ThinkPad-X240s>
 <20220205000719.19986-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205000719.19986-1-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali,

On Sat, Feb 05, 2022 at 12:07:19AM +0000, Ali Saidi wrote:

[...]

> >Alternatively, we can support HITM tag for L1/L2 cache levels in perf,
> >this can allow us to match memory topology on Arm64 arch, and it should
> >not introduce any regression on x86 arch.
> >
> >Could you confirm if below code can fix the issue or not?
> 
> Yes, that should do it. Want me to repsin this with the changes we discussed?

Yes, please go ahead and thanks a lot for your effort.

Leo
