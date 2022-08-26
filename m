Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C2C5A2045
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbiHZFR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244839AbiHZFRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:17:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBC8C480E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:17:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id jm11so647861plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NBhfmm8W18tg1OR8/OfEDDSqTYoAFyUg9RoO0VzD8D8=;
        b=fSgJj9xMVH+ALryiwxjs0GoztWALmqpSifZtVfIzEOzGmUfDMMql4hyhlzyLm2eC3B
         5XRxIQTdIjSkhmtQq9m9tI6eA2cuUnnSrXOX0xtDN56dOteBG0n5PqAmyQxXmrmJM5Sy
         ba0ErZ+Vps1Un4uWAn8BOQ30hGPFEc+uFJa8daE4x8Qh8Z925yym/aUQoW5Ub4SdVH33
         ZKVnadh/y1tVPSt0ZRXJhuyZIzKHmOowYiUlho9wmHh2T3qw8tQGRoqmQLhyX+6/LOkz
         CXpoXy3rru1czRbf8BIppIZxIxzBwmtXxlEnzoqoJhytx295PPB0B7O1EvyQBNS8+ZvU
         5DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NBhfmm8W18tg1OR8/OfEDDSqTYoAFyUg9RoO0VzD8D8=;
        b=nGa1mcqkmRCPVMVanSZ/c0iGK9efCKLDv3JFy6CPtUZNR9UFFRPfQmsDP2IJV/kSmg
         Ke4Bwmzrr5rod2tVBPGkqHtFRDRF7gtlCCSvYlHMn9sB5j4gXxcs6NoDnOk+ly/7Mj7z
         KzHTjmh03T39PVOVz5PLiduFJ3RsX5QqyHSODqoNmWZb9G4WX7T27tT42imjKVuGvTnl
         30gFzK7ocNUE1M3dK7gJcPvJNuKg22gPdnLCP2QZDsQVTs+lYkb0SjsUe36IZrMdagGW
         /63hA29kP/p2W806oqs2cKA+KenERg9Z4bEFih/B1q6l7EAuQPzH3mczCH0Duz7+iRjw
         lNhw==
X-Gm-Message-State: ACgBeo2GnpvL7aj81nxk+PcRY5NeqHdrMGOx3XBKoL9qc6EhtgJzCY2R
        /H2sXhR/uIHztgd0n9m28upLnw==
X-Google-Smtp-Source: AA6agR7190F/JL5rPrzWrxKmaQD+YMfLjdIkVhVkKzPZLa52R9MrODF+m+RAaJl4J0g5a90WWBSAKA==
X-Received: by 2002:a17:902:ce81:b0:172:9ac1:6ee with SMTP id f1-20020a170902ce8100b001729ac106eemr2106143plg.93.1661491044200;
        Thu, 25 Aug 2022 22:17:24 -0700 (PDT)
Received: from leoy-huanghe.lan (n058152048222.netvigator.com. [58.152.48.222])
        by smtp.gmail.com with ESMTPSA id r7-20020aa79887000000b005367c6db0a4sm377642pfl.183.2022.08.25.22.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 22:17:23 -0700 (PDT)
Date:   Fri, 26 Aug 2022 13:17:18 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ali Saidi <alisaidi@amazon.com>, Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH RESEND v6] perf: Add SNOOP_PEER flag to perf mem data
 struct
Message-ID: <YwhXXiuQ2VysVint@leoy-huanghe.lan>
References: <20220826051603.174792-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826051603.174792-1-leo.yan@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 01:16:03PM +0800, Leo Yan wrote:
> From: Ali Saidi <alisaidi@amazon.com>
> 
> Add a flag to the perf mem data struct to signal that a request caused a
> cache-to-cache transfer of a line from a peer of the requestor and
> wasn't sourced from a lower cache level.  The line being moved from one
> peer cache to another has latency and performance implications. On Arm64
> Neoverse systems the data source can indicate a cache-to-cache transfer
> but not if the line is dirty or clean, so instead of overloading HITM
> define a new flag that indicates this type of transfer.
> 
> Update notes:
> 
> This patch is to sync the headers between kernel and user space, commit
> 2e21bcf0514a ("perf tools: Sync addition of PERF_MEM_SNOOPX_PEER") for
> updating kernel header has been merged in the mainline code.

Hi Peter, could you help to merge this patch?  Thanks!

Leo
