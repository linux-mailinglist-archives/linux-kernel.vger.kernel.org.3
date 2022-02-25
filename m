Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4CF4C5008
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbiBYUrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbiBYUra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:47:30 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589A422322C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645822017; x=1677358017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vp7PvvU0McdaVrPYpSN85JmBJLOwXieWY44J5jo8UNU=;
  b=L4gnXs+UyfzF3sdr3V/XHJGLg7N6QyP7G1/lgQpVglXGez/ukuqvfqqx
   6LAXfyILObuXe/IdzFgXGM8bZpT1UdHeI8uk+fYcH0/2EAgkxK6LNY9qa
   8VxM/mgHnhomylo+QKazdRnbasFAhFwd6l7R1AdJKhkjjUnzSauT5UGV+
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 25 Feb 2022 12:46:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:46:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 12:46:56 -0800
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 25 Feb
 2022 12:46:54 -0800
Date:   Fri, 25 Feb 2022 15:46:52 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Message-ID: <YhlAPOquxUICyGsR@qian>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <YhhRrBpXTFolUAKi@qian>
 <20220225190846.u4fwebimd5ejfdpd@revolver>
 <20220225202334.bsw5t3retcchpn2e@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220225202334.bsw5t3retcchpn2e@revolver>
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

On Fri, Feb 25, 2022 at 08:23:41PM +0000, Liam Howlett wrote:
> I just booted an arm64 VM with my build and kasan enabled with no issue.
> Could you please send me your config file for the build?

On linux-next, I just do:

$ make arch=arm64 defconfig debug.config [1]

Then, I just generate some memory pressume into swapping/OOM Killer to
trigger it.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/kernel/configs/debug.config
