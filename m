Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45526528562
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiEPN3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiEPN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:29:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC502C649;
        Mon, 16 May 2022 06:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81A0FB81210;
        Mon, 16 May 2022 13:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BCCC385AA;
        Mon, 16 May 2022 13:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652707744;
        bh=1O5uoTJPvGLVwXqq+FvJNotaS0MSkYwHeysQaW4/cK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bINPCiQm73NGuVQaqb2skBtoEDRMBaQfLI2ZReK/JrIQOop1A7wWW0cQRlELsjYqG
         gUC2EJ2y5PyTHbFx2bLw2O1W0K0DeuYuxpqxZXY2ebmqxvu3S0ZVUqfyKtYiFbZIaz
         e0VvJHVs19p/f+6HQgPiwfUSmDzCHFBoboUMhwMGJrG6wyFMLR87nUmWn+YhDf+hkt
         hEQ4xYzcaAUi9G6NPX3yuwoWvfHMOxxTcGGQK3Ts5U6fSZCMkqUvrFPyAezibzbJLU
         GyUAZ+LhddnA24zp9qJhJutRbreCGjGM+VC3jBNYhNMsHnELp8+6RisiszYdVa9yxf
         U1RQ1/plmWhog==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B7E83400B1; Mon, 16 May 2022 10:29:01 -0300 (-03)
Date:   Mon, 16 May 2022 10:29:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, irogers@google.com,
        yao.jin@linux.intel.com, james.clark@arm.com, leo.yan@linaro.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, eranian@google.com,
        like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2 7/8] perf script ibs: Support new IBS bits in raw
 trace dump
Message-ID: <YoJRnfASHY+uq1f/@kernel.org>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
 <20220509044914.1473-8-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509044914.1473-8-ravi.bangoria@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 09, 2022 at 10:19:13AM +0530, Ravi Bangoria escreveu:
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/include/asm/amd-ibs.h       | 16 ++++---
>  tools/arch/x86/include/asm/amd-ibs.h | 16 ++++---
>  tools/perf/util/amd-sample-raw.c     | 68 ++++++++++++++++++++++++----
>  3 files changed, 80 insertions(+), 20 deletions(-)

Please separate the tooling part on a separate patch.

- Arnaldo
