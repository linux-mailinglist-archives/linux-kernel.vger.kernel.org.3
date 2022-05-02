Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4185D516FB9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385056AbiEBMpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385036AbiEBMpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:45:20 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE313E9A;
        Mon,  2 May 2022 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651495312; x=1683031312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PFv7xf39B7dctfrpvPmGz6siPWZ4sWErtUwGztT4Aps=;
  b=M1+WM26SdLQ/uKqeLT+JqIOS7EUqtHHaqSna5UV/j6OIW6nDNxVRFeoO
   dQjTCiP6D/mY6yKW/eTPj4g0UDG1JbPrBLPY8zu1NTBjfXBaliZp7UqQA
   hq5HpZMUVMeRBPTJVVkMKIP24V0XSI2BuqSy+Hm5D5/+zhtNCxNwXcdHD
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 05:41:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 05:41:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 05:41:50 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 2 May 2022
 05:41:47 -0700
Date:   Mon, 2 May 2022 08:41:46 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, "Zi Yan" <ziy@nvidia.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David Hildenbrand" <david@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>,
        "kernel test robot" <lkp@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        "Oscar Salvador" <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chen Wandun <chenwandun@huawei.com>, NeilBrown <neilb@suse.de>,
        <joao.m.martins@oracle.com>, <mawupeng1@huawei.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Song Liu <song@kernel.org>
Subject: Re: [next] mm: libhugetlbfs: WARNING: at mm/page_alloc.c:5368
 __alloc_pages
Message-ID: <20220502124146.GA71@qian>
References: <CA+G9fYveMF-NU-rvrsbaora2g2QWxrkF7AWViuDrJyN9mNScJg@mail.gmail.com>
 <20220429160317.GA71@qian>
 <CA+G9fYui9OuyFbg7SV8D_4ueC_Jc=71ybbhBeif0bczo957Hqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+G9fYui9OuyFbg7SV8D_4ueC_Jc=71ybbhBeif0bczo957Hqg@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 03:41:41AM +0530, Naresh Kamboju wrote:
> The reported kernel warning was not solved by reverted above patches.

Thanks for the confirmation. Then, I can't think of any other good
candidates at the moment apart from doing brutal-force bisecting.
