Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A66A52DEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245007AbiESVFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiESVFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:05:09 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7EBED784
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652994308; x=1684530308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q/iVT6eHGUL7xt25EZCD9Iruv1QN8td0bn1+mXm/2MM=;
  b=auTvNIBTblJGAcXySRkBRkOmWubNHqjK7L4lGbL/u3GM5XNsA8DwnFsD
   XrHyNeolV2TjvFbJP1ayPGdzBKRu9S83k+nUTc5lPpmDqVTpXPS4Ij7YM
   PNlpPsD6H4uZiVwkVYEZbleI1bixAgEgFEoIA4R64cu/UdOo9+xqXvdL2
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 May 2022 14:05:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:05:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 14:05:07 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 19 May
 2022 14:05:06 -0700
Date:   Thu, 19 May 2022 17:05:04 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, <kafai@fb.com>,
        <kpsingh@kernel.org>
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
Message-ID: <YoaxAMvQwHzDPxyi@qian>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220517233507.GA423@qian>
 <20220518125152.GQ3441@techsingularity.net>
 <YoUealVA1bMaSH2l@qian>
 <20220518171503.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YoZGSd6yQL3EP8tk@qian>
 <20220519191524.GC1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220519191524.GC1790663@paulmck-ThinkPad-P17-Gen-1>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

On Thu, May 19, 2022 at 12:15:24PM -0700, Paul E. McKenney wrote:
> Is the task doing offline_pages()->synchronize_rcu() doing this
> repeatedly?  Or is there a stalled RCU grace period?  (From what
> I can see, offline_pages() is not doing huge numbers of calls to
> synchronize_rcu() in any of its loops, but I freely admit that I do not
> know this code.)

Yes, we are running into an endless loop in isolate_single_pageblock().
There was a similar issue happened not long ago, so I am wondering if we
did not solve it entirely then. Anyway, I will continue the thread over
there.

https://lore.kernel.org/all/YoavU%2F+NfQIzQiDF@qian/

> Or is it possible that reverting those three patches simply decreases
> the probability of failure, rather than eliminating the failure?
> Such a decrease could be due to many things, for example, changes to
> offsets and sizes of data structures.

Entirely possible. Sorry for the false alarm.

> Do you ever see RCU CPU stall warnings?

No.
