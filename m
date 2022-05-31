Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1656B539565
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346521AbiEaRXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240539AbiEaRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:23:34 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C1290CDB
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654017813; x=1685553813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SS4f2RJO4J6Dl+skZQyymBm8JwW6+FCYen5Pp0Bb79k=;
  b=a6FcR9Upput7srAQgwjIlBF8b0f4F6iCyIYTLZjBE5bJpSMSjEDdR2Wk
   tfJ7yMHbfgD6WBl2VHK9/T3px/bdipSv4MQ294FeoAiL7dEMtSMXV9n3S
   DUAcQMXXEBW8si8aUUXx19jj297OfgFpErzscIbE7WNqeBIybySuhy5zk
   E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 31 May 2022 10:23:33 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:23:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 10:23:32 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 31 May
 2022 10:23:31 -0700
Date:   Tue, 31 May 2022 13:23:29 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Will Deacon <will@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: arm64: Fix memory leaks from stage2 pagetable
Message-ID: <YpZPEStUD02jJ8C6@qian>
References: <20220526203956.143873-1-quic_qiancai@quicinc.com>
 <20220531165710.GB25631@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220531165710.GB25631@willie-the-truck>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 05:57:11PM +0100, Will Deacon wrote:
> On Thu, May 26, 2022 at 04:39:56PM -0400, Qian Cai wrote:
> > Running some SR-IOV workloads could trigger some leak reports from
> > kmemleak.
> > 
> > unreferenced object 0xffff080243cef500 (size 128):
> >   comm "qemu-system-aar", pid 179935, jiffies 4298359506 (age 1629.732s)
> >   hex dump (first 32 bytes):
> >     28 00 00 00 01 00 00 00 00 e0 4c 52 03 08 ff ff  (.........LR....
> >     e0 af a4 7f 7c d1 ff ff a8 3c b3 08 00 80 ff ff  ....|....<......
> >   backtrace:
> >      kmem_cache_alloc_trace
> >      kvm_init_stage2_mmu
> 
> Hmm, I can't spot a 128-byte allocation in here so this is pretty cryptic.
> I don't really like the idea of papering over the report; we'd be better off
> trying to reproduce it.

As far as I would like to reproduce, I have tried it in the last a few
weeks without luck. It still happens from time to time though from our
daily CI, so I was thinking to plug the knowns leaks first.
