Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88DA5526A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbiFTVgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiFTVgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:36:53 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611A714D39
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655761012; x=1687297012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ewUfh4XnkrDqRrJMBTCAGz/x057Ml+6QHcW8sFq1wII=;
  b=aQ+WWpY1Jns68K4HF6Z8Y/6/yejGrFSde1UZR//75PNtRPGMIKSAnn4E
   zP2PJ7zYPGOQWTVvEY7U8DK+U55lDlNpdsdn8J1SGDOMLSnmIQ0OSzWYX
   yBm+OYv1iuAKFtJocqifc1Sq2N95xWbh7+aSB4DVnUq7oIAKTUHBAKuxk
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jun 2022 14:36:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 14:36:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 14:36:51 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 14:36:49 -0700
Date:   Mon, 20 Jun 2022 17:36:47 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>, <akpm@linux-foundation.org>,
        <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mm/swapfile: fix possible data races of
 inuse_pages
Message-ID: <YrDob8+9Xgig6mZw@qian>
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-3-linmiaohe@huawei.com>
 <87edzjrcq8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <13414d6a-9e72-fb6c-f0a8-8b83ba0455de@huawei.com>
 <YrA8kxavqsDfH5R7@FVFYT0MHHV2J.usts.net>
 <09ffac27-7fe9-0977-cb33-30433e78e662@huawei.com>
 <b61771ad-9daa-741e-27e4-fdb50a7c5e38@huawei.com>
 <YrB6R5uHQaz1adhK@qian>
 <YrCCFwgoLKhDn7Fo@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YrCCFwgoLKhDn7Fo@FVFYT0MHHV2J.usts.net>
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

On Mon, Jun 20, 2022 at 10:20:07PM +0800, Muchun Song wrote:
> The lock does not protect the read sides. So the write side should be
> fixed by WRITTE_ONCE().

https://lwn.net/Articles/816854/

"Unmarked writes (aligned and up to word size) can be treated as if they had
used WRITE_ONCE() by building with
CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y (also selected by default).
Experience has shown that compilers are much less likely to destructively
optimize in-kernel writes than reads. Some developers might therefore
choose to use READ_ONCE() but omit the corresponding WRITE_ONCE(). Other
developers might prefer the documentation benefits and long-term peace of
mind accruing from explicit use of WRITE_ONCE()..."
