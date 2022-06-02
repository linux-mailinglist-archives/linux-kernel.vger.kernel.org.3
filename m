Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2867853BD08
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiFBRLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbiFBRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:11:35 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649042A80F6;
        Thu,  2 Jun 2022 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1654189895; x=1685725895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lieI59ITfoRtC4B8Ptaya/6xFBTQt0IMD/X5QvUWlUA=;
  b=ZF911keks4gBMybxAOM6MwHyDTU3vNKvEMnUlGy7vCU+Bk7te99n1MLK
   LGrq9iPkAaBN+gM+zHPNAbvGSHDoXjlVgB6ur324YfHWg5J16C7ADd/Kb
   lUMXy3ADXXLreyexi18tnHc6T4kTm7FbypdjP/6w1GY3LnJiHYAg3SwHr
   w=;
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-1f9d5b26.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 02 Jun 2022 17:11:32 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-1f9d5b26.us-west-2.amazon.com (Postfix) with ESMTPS id 13DE340BC6;
        Thu,  2 Jun 2022 17:11:31 +0000 (UTC)
Received: from EX13D02UWB001.ant.amazon.com (10.43.161.240) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Thu, 2 Jun 2022 17:11:30 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D02UWB001.ant.amazon.com (10.43.161.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Thu, 2 Jun 2022 17:11:30 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.36 via Frontend Transport; Thu, 2 Jun 2022 17:11:30 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 507B5213F; Thu,  2 Jun 2022 17:11:29 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <leo.yan@linaro.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <hi@alyssa.is>,
        <irogers@google.com>, <likexu@tencent.com>, <kjain@linux.ibm.com>,
        <lihuafei1@huawei.com>, <adam.li@amperecomputing.com>,
        <german.gomez@arm.com>, <james.clark@arm.com>,
        <alisaidi@amazon.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/12] perf c2c: Support display for Arm64
Date:   Thu, 2 Jun 2022 17:11:20 +0000
Message-ID: <20220602171120.31166-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220601102505.GA408721@leoy-ThinkPad-X240s>
References: <20220601102505.GA408721@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Wed, 1 Jun 2022 18:25:05 +0800 Leo Yan wrote:
> Hi Joe,
> 
> On Tue, May 31, 2022 at 02:44:07PM -0400, Joe Mario wrote:
> 
> [...]
> 
> > Hi Leo:
> > I built a new perf with your patches and ran it on a 2-numa node Neoverse platform.
> > I then ran my simple test that creates reader and writer threads to tug on the same cacheline.
> > The c2c output is appended below.
> >
> > The output looks good, especially where you've broken out the (average) cycles for local and remote peer loads.  
> > And I'm glad to see you fixed the "Node" column.  I use that a lot to help detect remote node accesses.  
> 
> Thanks a lot for your testing and suggestions, which are really helpful!
> 
> > And the "PA cnt" field is working as well,  which is important to see if numa_balance is moving the data around.
> 
> Good to know this.  To be honest, before I didn't note for "PA cnt"
> metric, I checked a bit for the code, this metrics is very useful to
> understand how it's severe that a cache line is accessed from different
> addresses, so we can get sense how a cache line is hammered.
> 
> [...]
>
> > Thanks for doing this.  It looks good.
> 
> You are welcome!  And very appreicate your helping to mature the code.

Seconding that, thanks for progressing this so much Leo. 

> 
> > I'll assume someone else is reviewing your code changes.
> 
> Yeah, let's give a bit more time for reviewing.

I've tested and given each patch a close look. I haven't found anything that
looks to change other architectures and the output on my Graviton systems looks
great. I pulled in your patch to add physical addresses to the spe records and
as expected I saw the Node properly populated and PA cnt is no longer zero.  One
nit is the documentation still says that "Total HITMs (tot) as default," while
the code now defaults to "peer" on arm64.  Other than that:

Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>

Thanks,
Ali

