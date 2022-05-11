Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEDD523C71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbiEKS2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiEKS2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:28:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD8F6AA4F;
        Wed, 11 May 2022 11:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D367FB825EE;
        Wed, 11 May 2022 18:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B492C340EE;
        Wed, 11 May 2022 18:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652293684;
        bh=/VvwCFsR4qa2pGVRNBWXPPb4KRFIFDVjGE8YFXWvrkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJEciWN6ZTobAQcS3uVzrxRXBQQGYa/SotmpKnjpv9Gt4AFGGz7YaMkvt/cB2rPPB
         4G3/eHuwZc7Jfm+uUddV/qTbbJYDUwF5Y3RpJ0G6joXKYXORQCmReqWOMwflIcmIRi
         wIMJzaZjh222kDiphBkCrEFqlGZdpRqchr8CbvYZmBU2e0OK1A0tnfZ5lKNx7/dTnC
         goWjvxD6FKBKOGHcYDLHR5jk4pl835EE1Iy/DFCOWiLqez0XDoFlWd06oIfVMz4k3K
         WxaclYUgj3i+CBMWtLKt+VI4MtMCnkoBwjGdGuEPbZmpqzpZHWekuOTJFyWXkGxnH9
         Ntk8yCWBXJGzg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DFAC5400B1; Wed, 11 May 2022 15:28:00 -0300 (-03)
Date:   Wed, 11 May 2022 15:28:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v8 2/5] perf tools: sync addition of PERF_MEM_SNOOPX_PEER
Message-ID: <YnwAMNLN/538ggJd@kernel.org>
References: <20220504184850.24986-1-alisaidi@amazon.com>
 <20220504184850.24986-3-alisaidi@amazon.com>
 <YnqStjaWInPqLnsX@kernel.org>
 <20220511022004.GA956170@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220511022004.GA956170@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 11, 2022 at 10:20:04AM +0800, Leo Yan escreveu:
> On Tue, May 10, 2022 at 01:28:38PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 04, 2022 at 06:48:47PM +0000, Ali Saidi escreveu:
> > > Add a flag to the perf mem data struct to signal that a request caused a
> > > cache-to-cache transfer of a line from a peer of the requestor and
> > > wasn't sourced from a lower cache level.  The line being moved from one
> > > peer cache to another has latency and performance implications. On Arm64
> > > Neoverse systems the data source can indicate a cache-to-cache transfer
> > > but not if the line is dirty or clean, so instead of overloading HITM
> > > define a new flag that indicates this type of transfer.
> > > 
> > > Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > 
> > Was this already merged on the ARM kernel tree?
> 
> No, I don't think this patch has been merged on Arm kernel tree.  I searched
> Arm and Arm64 git repos, none of them has merged this patch.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?qt=author&q=Ali+Saidi
> http://git.armlinux.org.uk/cgit/linux-arm.git/log/?qt=author&q=Ali+Saidi
> 
> P.s. Ali missed to include German's review tag, see:
> https://lore.kernel.org/lkml/458a2de1-dc93-7e2d-5dc5-fbcd670572b6@arm.com/
> 
> Do you want us to resend the patch set for adding tags?

I use b4 and it should collect Reviewed-by, Acked-by, etc tags, for
instance, if I use the message-id in your message:

⬢[acme@toolbox perf]$ b4 am -ctsl --cc-trailers 20220511022004.GA956170@leoy-ThinkPad-X240s
Looking up https://lore.kernel.org/r/20220511022004.GA956170%40leoy-ThinkPad-X240s
Grabbing thread from lore.kernel.org/all/20220511022004.GA956170%40leoy-ThinkPad-X240s/t.mbox.gz
Checking for newer revisions on https://lore.kernel.org/all/
Analyzing 12 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v8 1/5] perf: Add SNOOP_PEER flag to perf mem data struct
    + Reviewed-By: Kajol Jain<kjain@linux.ibm.com> (✓ DKIM/ibm.com)
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    + Link: https://lore.kernel.org/r/20220504184850.24986-2-alisaidi@amazon.com
    + Cc: Nick.Forrington@arm.com
    + Cc: andrew.kilroy@arm.com
    + Cc: german.gomez@arm.com
    + Cc: james.clark@arm.com
    + Cc: mark.rutland@arm.com
    + Cc: john.garry@huawei.com
    + Cc: lihuafei1@huawei.com
    + Cc: peterz@infradead.org
    + Cc: benh@kernel.crashing.org
    + Cc: acme@kernel.org
    + Cc: jolsa@kernel.org
    + Cc: namhyung@kernel.org
    + Cc: will@kernel.org
    + Cc: mathieu.poirier@linaro.org
    + Cc: alexander.shishkin@linux.intel.com
    + Cc: linux-arm-kernel@lists.infradead.org
    + Cc: mingo@redhat.com
    + Cc: linux-kernel@vger.kernel.org
    + Cc: linux-perf-users@vger.kernel.org
  ✓ [PATCH v8 2/5] perf tools: sync addition of PERF_MEM_SNOOPX_PEER
    + Reviewed-By: Kajol Jain<kjain@linux.ibm.com> (✓ DKIM/ibm.com)
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    + Link: https://lore.kernel.org/r/20220504184850.24986-3-alisaidi@amazon.com
    + Cc: Nick.Forrington@arm.com
    + Cc: andrew.kilroy@arm.com
    + Cc: german.gomez@arm.com
    + Cc: james.clark@arm.com
    + Cc: mark.rutland@arm.com
    + Cc: john.garry@huawei.com
    + Cc: lihuafei1@huawei.com
    + Cc: peterz@infradead.org
    + Cc: benh@kernel.crashing.org
    + Cc: acme@kernel.org
    + Cc: jolsa@kernel.org
    + Cc: namhyung@kernel.org
    + Cc: will@kernel.org
    + Cc: mathieu.poirier@linaro.org
    + Cc: alexander.shishkin@linux.intel.com
    + Cc: linux-arm-kernel@lists.infradead.org
    + Cc: mingo@redhat.com
    + Cc: linux-kernel@vger.kernel.org
    + Cc: linux-perf-users@vger.kernel.org
  ✓ [PATCH v8 3/5] perf mem: Print snoop peer flag
    + Reviewed-By: Kajol Jain<kjain@linux.ibm.com> (✓ DKIM/ibm.com)
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    + Link: https://lore.kernel.org/r/20220504184850.24986-4-alisaidi@amazon.com
    + Cc: Nick.Forrington@arm.com
    + Cc: andrew.kilroy@arm.com
    + Cc: german.gomez@arm.com
    + Cc: james.clark@arm.com
    + Cc: mark.rutland@arm.com
    + Cc: john.garry@huawei.com
    + Cc: lihuafei1@huawei.com
    + Cc: peterz@infradead.org
    + Cc: benh@kernel.crashing.org
    + Cc: acme@kernel.org
    + Cc: jolsa@kernel.org
    + Cc: namhyung@kernel.org
    + Cc: will@kernel.org
    + Cc: mathieu.poirier@linaro.org
    + Cc: alexander.shishkin@linux.intel.com
    + Cc: linux-arm-kernel@lists.infradead.org
    + Cc: mingo@redhat.com
    + Cc: linux-kernel@vger.kernel.org
    + Cc: linux-perf-users@vger.kernel.org
  ✓ [PATCH v8 4/5] perf arm-spe: Don't set data source if it's not a memory operation
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    + Link: https://lore.kernel.org/r/20220504184850.24986-5-alisaidi@amazon.com
    + Cc: Nick.Forrington@arm.com
    + Cc: andrew.kilroy@arm.com
    + Cc: james.clark@arm.com
    + Cc: mark.rutland@arm.com
    + Cc: john.garry@huawei.com
    + Cc: lihuafei1@huawei.com
    + Cc: peterz@infradead.org
    + Cc: benh@kernel.crashing.org
    + Cc: acme@kernel.org
    + Cc: jolsa@kernel.org
    + Cc: namhyung@kernel.org
    + Cc: will@kernel.org
    + Cc: mathieu.poirier@linaro.org
    + Cc: kjain@linux.ibm.com
    + Cc: alexander.shishkin@linux.intel.com
    + Cc: linux-arm-kernel@lists.infradead.org
    + Cc: mingo@redhat.com
    + Cc: linux-kernel@vger.kernel.org
    + Cc: linux-perf-users@vger.kernel.org
  ✓ [PATCH v8 5/5] perf arm-spe: Use SPE data source for neoverse cores
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    + Link: https://lore.kernel.org/r/20220504184850.24986-6-alisaidi@amazon.com
    + Cc: Nick.Forrington@arm.com
    + Cc: andrew.kilroy@arm.com
    + Cc: james.clark@arm.com
    + Cc: mark.rutland@arm.com
    + Cc: john.garry@huawei.com
    + Cc: lihuafei1@huawei.com
    + Cc: peterz@infradead.org
    + Cc: benh@kernel.crashing.org
    + Cc: acme@kernel.org
    + Cc: jolsa@kernel.org
    + Cc: namhyung@kernel.org
    + Cc: will@kernel.org
    + Cc: mathieu.poirier@linaro.org
    + Cc: kjain@linux.ibm.com
    + Cc: alexander.shishkin@linux.intel.com
    + Cc: linux-arm-kernel@lists.infradead.org
    + Cc: mingo@redhat.com
    + Cc: linux-kernel@vger.kernel.org
    + Cc: linux-perf-users@vger.kernel.org
  ---
  ✓ Signed: DKIM/amazon.com
---
Total patches: 5
---
Cover: ./v8_20220504_alisaidi_perf_arm_spe_decode_spe_source_and_use_for_perf_c2c.cover
 Link: https://lore.kernel.org/r/20220504184850.24986-1-alisaidi@amazon.com
 Base: not specified
       git am ./v8_20220504_alisaidi_perf_arm_spe_decode_spe_source_and_use_for_perf_c2c.mbx
⬢[acme@toolbox perf]$

Somehow it is not being collected... :-\

Not even when I use:

> P.s. Ali missed to include German's review tag, see:
> https://lore.kernel.org/lkml/458a2de1-dc93-7e2d-5dc5-fbcd670572b6@arm.com/


458a2de1-dc93-7e2d-5dc5-fbcd670572b6@arm.com

Will try updating b4...

- Arnaldo
