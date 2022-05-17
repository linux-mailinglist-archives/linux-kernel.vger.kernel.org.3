Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5C052AD6B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiEQVUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiEQVUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:20:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B57C5373D;
        Tue, 17 May 2022 14:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 169ECB81C9A;
        Tue, 17 May 2022 21:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727E0C385B8;
        Tue, 17 May 2022 21:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652822406;
        bh=aX1+u5HBdpWoig4ZwAPYlKgTcAPJ21XxVvwtnQz2jbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHMPGBTGSfBXoLopt0wrrmclau7vQDAWu7hpWA1/jp38l1+fm8t4iS//LscbKhR2q
         EqC19rIFIWIsQAwDFVqhTYNbPejFfKR2HpGKt0rK6uK+WqTdjVoPJRQVIg+BcIE0Iw
         3NKQmiJKBAUQq8bIU5PqqrUaua/zxWRJvQ6dkeUuIHINp5lrIILVyUwVoqPVVrZftq
         uUPfgvImA3KXWYi2XtAQluTwD1Sf/3aLHcet/L0yyqycsBSdwStLtf2ZrNbXkx/kdL
         3N8AXCHVMMP/P5X9hIWixtR7FzFR2/NT1x0j6atMaB8En/0va76rYNxCkxzTzTLVnd
         1f/CBQWE7Tw5Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E4364400B1; Tue, 17 May 2022 18:20:03 -0300 (-03)
Date:   Tue, 17 May 2022 18:20:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        leo.yan@linaro.org, benh@kernel.crashing.org,
        Nick.Forrington@arm.com, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, james.clark@arm.com, john.garry@huawei.com,
        Jiri Olsa <jolsa@kernel.org>, kjain@linux.ibm.com,
        lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v8 0/4] perf: arm-spe: Decode SPE source and use for perf
 c2c
Message-ID: <YoQRg1r7HuwiO3bZ@kernel.org>
References: <20220517020326.18580-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517020326.18580-1-alisaidi@amazon.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 17, 2022 at 02:03:21AM +0000, Ali Saidi escreveu:
> When synthesizing data from SPE, augment the type with source information
> for Arm Neoverse cores so we can detect situtions like cache line
> contention and transfers on Arm platforms. 
> 
> This changes enables future changes to c2c on a system with SPE where lines that
> are shared among multiple cores show up in perf c2c output. 
> 
> Changes is v9:
>  * Change reporting of remote socket data which should make Leo's upcomping
>    patch set for c2c make sense on multi-socket platforms  

Hey,

	Joe Mario, who is one of 'perf c2c' authors asked me about some
git tree he could clone from for both building the kernel and
tools/perf/ so that he could do tests, can you please provide that?

thanks!

- Arnaldo
 
> Changes in v8:
>  * Report NA for both mem_lvl and mem_lvl_num for stores where we have no
>    information
> 
> Changes in v7:
>  * Minor change requested by Leo Yan
> 
> Changes in v6:
>   * Drop changes to c2c command which will come from Leo Yan
> 
> Changes in v5:
>   * Add a new snooping type to disambiguate cache-to-cache transfers where
>     we don't know if the data is clean or dirty.
>   * Set snoop flags on all the data-source cases
>   * Special case stores as we have no information on them
> 
> Changes in v4:
>   * Bring-in the kernel's arch/arm64/include/asm/cputype.h into tools/ 
>   * Add neoverse-v1 to the neoverse cores list
> 
> Ali Saidi (4):
>   tools: arm64: Import cputype.h
>   perf arm-spe: Use SPE data source for neoverse cores
>   perf mem: Support mem_lvl_num in c2c command
>   perf mem: Support HITM for when mem_lvl_num is any
> 
>  tools/arch/arm64/include/asm/cputype.h        | 258 ++++++++++++++++++
>  .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 +
>  tools/perf/util/arm-spe.c                     | 110 +++++++-
>  tools/perf/util/mem-events.c                  |  20 +-
>  5 files changed, 383 insertions(+), 18 deletions(-)
>  create mode 100644 tools/arch/arm64/include/asm/cputype.h
> 
> -- 
> 2.32.0

-- 

- Arnaldo
