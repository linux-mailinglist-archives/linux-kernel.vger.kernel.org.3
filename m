Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3082255E30D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiF0NrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiF0NrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:47:21 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955B660C0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656337640; x=1687873640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gnsf+QTLVChURM0F3ZGZR9Oqi9oIQdMjnKYpZYGncic=;
  b=NeNb2Jvn13siisZn8tYNSaWW0Os0tl1v80PguT//2FobrSsOLLakN7i8
   Mch9B6CYPFgdTl2m3nejAkoJLqeyL1c1Q9SyuVC2ddFKUppwiMc8aSq5k
   tX8J0AYRnrWUMsYoUA9HuL1BcUZMLjpxdqYahaXAlb37wbM6Ed51alvxU
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jun 2022 06:47:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 06:47:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 06:47:19 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 27 Jun
 2022 06:47:18 -0700
Date:   Mon, 27 Jun 2022 09:47:16 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] mm/swapfile: fix possible data races of
 inuse_pages
Message-ID: <Yrm05NQs5+tCZawR@qian>
References: <20220625093346.48894-1-linmiaohe@huawei.com>
 <20220625093346.48894-2-linmiaohe@huawei.com>
 <Yrml4mB3sa5fZVJa@qian>
 <fe3c4834-71a6-7867-2108-eca43fde62fc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fe3c4834-71a6-7867-2108-eca43fde62fc@huawei.com>
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

On Mon, Jun 27, 2022 at 09:27:43PM +0800, Miaohe Lin wrote:
> On 2022/6/27 20:43, Qian Cai wrote:
> > On Sat, Jun 25, 2022 at 05:33:45PM +0800, Miaohe Lin wrote:
> >> si->inuse_pages could still be accessed concurrently now. The plain reads
> >> outside si->lock critical section, i.e. swap_show and si_swapinfo, which
> >> results in data races. READ_ONCE and WRITE_ONCE is used to fix such data
> >> races. Note these data races should be ok because they're just used for
> >> showing swap info.
> > 
> > Was this found by kcsan? If so, it would be useful to record the exact
> > kscan report in the commit message.
> 
> Sorry, it's found via code inspection.

Well, if we are going to do a WRITE_ONCE() in those places just for
documentation purpose now, I think we will need to fix all places in the mm
subsystem to be consistent.
