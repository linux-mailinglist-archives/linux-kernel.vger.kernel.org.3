Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95BE5AB8D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiIBT0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIBTZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:25:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B21CFD3;
        Fri,  2 Sep 2022 12:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5DC21CE30C7;
        Fri,  2 Sep 2022 19:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E10C433C1;
        Fri,  2 Sep 2022 19:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662146754;
        bh=OXshCiSi6O3h3plOqJ6wkUls2kJW/yXQDTlsExEXJM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBWrJjJgGcCxYju+mSj+YLLLLYmYnb2DHtSDcBsriTOVBRFpSrHXCRdg6huRhmo2O
         v7N5lxKS+DtwxXQ0lNQ8oL5WaM6icuXqVaqLnUiHFg+5wjo2uiymILQe+CtAfAx8cY
         4ojqRx2WjCPLfGWA6RSWU7AAqIPU0H9DiNm+C1I+/PQjGW3MrTbadMa1bKDkMsSYOJ
         iO5VFPVX5OOniUcLse1J5VDQu4Q3jz1JRIZom2rlk9IJW/BIFyY63W6AZdRuOhG1Z5
         AABB3sUen+CJ1zfW9f7I3AfdQiYtHoiQPHVBTuqTjUV1po+5fkOGi5cDTxre3ohCpq
         0BRKf3TbrrGoQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AA4CB404A1; Fri,  2 Sep 2022 16:25:51 -0300 (-03)
Date:   Fri, 2 Sep 2022 16:25:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf vendor events: Add missing Neoverse V1 events
Message-ID: <YxJYv0IfvmL1BTrX@kernel.org>
References: <20220901151804.294823-1-nick.forrington@arm.com>
 <c17d8229-6029-3fd6-1ce5-f406962eae8f@huawei.com>
 <6813a737-736d-7e15-a44f-d800ed9248be@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6813a737-736d-7e15-a44f-d800ed9248be@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 02, 2022 at 03:12:49PM +0100, Nick Forrington escreveu:
> On 02/09/2022 09:04, John Garry wrote:
> > On 01/09/2022 16:18, Nick Forrington wrote:
> > > Based on updated data from:
> > > https://github.com/ARM-software/data/blob/master/pmu/neoverse-v1.json
> > > 
> > > which is based on PMU event descriptions from the Arm Neoverse V1
> > > Technical Reference Manual.
> > > 
> > > This adds the following missing events:
> > > ASE_INST_SPEC
> > > SVE_INST_SPEC
> > > SVE_PRED_SPEC
> > > SVE_PRED_EMPTY_SPEC
> > > SVE_PRED_FULL_SPEC
> > > SVE_PRED_PARTIAL_SPEC
> > > SVE_LDFF_SPEC
> > > SVE_LDFF_FAULT_SPEC
> > > FP_SCALE_OPS_SPEC
> > > FP_FIXED_OPS_SPEC
> > > 
> > > It also moves REMOTE_ACCESS from other.json to memory.json.
> > 
> > Any specific reason why? I see that neoverse n2 and a76-n1 still use
> > "other" json for REMOTE_ACCESS. Nicer to be consistent.
> 
> Thanks John, I agree on consistency.
> 
> I think memory is a better categorisation (for all CPUs), and this is
> consistent with what I submitted for various Cortex CPUs a while back.

Were those patches processed or is some still outstanding?
 
> I'd be happy to remove the REMOTE_ACCESS change here and update (or not)
> REMOTE_ACCESS for Neoverse separately.
> 
> > 
> > > 
> > > Signed-off-by: Nick Forrington<nick.forrington@arm.com>
> > > ---
> > 
> > Apart from above:
> > Reviewed-by: John Garry <john.garry@huawei.com>
> Thanks, Nick

So, how should we proceed?

- Arnaldo
