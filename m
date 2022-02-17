Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961C94BA79E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbiBQSAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:00:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiBQSAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:00:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49F0172888
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645120824; x=1676656824;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QvzSf/Iy9t2BsT/kBvdThe7NB8mTuuobovoJNAH0OYo=;
  b=WlunBMd05umWqvXdGoNYjs7kILQPOLv0S4z63VvYyXrNoSvmTxphXPBg
   uDYirbdECg3RAM9MpWE0QDuHnOtGW4pURJK8vSH8H3tXK3aFgCPwHo8rE
   j7RB6DhLDOts79uvT6J1iLITOFrwQhZhMDWizk2TQjPW60nK9VVTj7iZd
   ojhm+cdTlrG3koDm4iQ1PJ5xL77SeTVid055yqNRoYlRKg0DDYH+i1UAf
   sqRCXg67CEOYMkenFb6EEiQ4lvnYRbQ4Qftn6koGV5XUE/d1OrBz7UQlP
   cTkyV59JpT+w3KRzqb0CnlBlFHEPWIgKXDDkr2C5eLYtII8+DJuoKHNAl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="248531691"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="248531691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 10:00:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="503619073"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.87.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 10:00:24 -0800
Message-ID: <2627025ab96a315af0e76e5983c803578623c826.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Yicong Yang <yangyicong@huawei.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Barry Song <21cnbao@gmail.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     yangyicong@hisilicon.com,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>
Date:   Thu, 17 Feb 2022 10:00:23 -0800
In-Reply-To: <eec56eba-59fd-5b12-d8f1-74a803ba7044@huawei.com>
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
         <20220126080947.4529-3-yangyicong@hisilicon.com>
         <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
         <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
         <20220128071337.GC618915@linux.vnet.ibm.com>
         <CAGsJ_4yoUONACY-j+9XxSNC0VgmdyRdHC=z87dWvZvVSASzXRQ@mail.gmail.com>
         <20220201093859.GE618915@linux.vnet.ibm.com>
         <CAGsJ_4z8cer7Y5si+J_=awQetFJZMVeaQ+RDSXQz9EGOPTGMQg@mail.gmail.com>
         <20220204073317.GG618915@linux.vnet.ibm.com>
         <CAGsJ_4xjgy3D0VzbTdmJihJ+nut_NeTEb4krh8jup4rbvTY_ww@mail.gmail.com>
         <YgE3TrBrB0psljDk@BLR-5CG11610CF.amd.com>
         <CAGsJ_4xg6heV-0yqvcwNNEyOcrfwv3uN45YfR1Jcawys0ROrow@mail.gmail.com>
         <CAGsJ_4z-YxcPytzmGViRzEueL1F7HEE4OEuezvDg6TvEs1HJEA@mail.gmail.com>
         <dd9a5329e35241f6ab0bbb723ad72813@hisilicon.com>
         <eec56eba-59fd-5b12-d8f1-74a803ba7044@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-16 at 18:00 +0800, Yicong Yang wrote:
> On 2022/2/16 17:19, Song Bao Hua (Barry Song) wrote:
> > 
> > tbench running on numa 0&1:
> >                             5.17-rc1          rc1 + chenyu          rc1+chenyu+cls     rc1+chenyu+cls-pingpong  rc1+cls
> > Hmean     1        320.01 (   0.00%)      318.03 *  -0.62%*      357.15 *  11.61%*      375.43 *  17.32%*      378.44 *  18.26%*
> > Hmean     2        643.85 (   0.00%)      637.74 *  -0.95%*      714.36 *  10.95%*      745.82 *  15.84%*      752.52 *  16.88%*
> > Hmean     4       1287.36 (   0.00%)     1285.20 *  -0.17%*     1431.35 *  11.18%*     1481.71 *  15.10%*     1505.62 *  16.95%*
> > Hmean     8       2564.60 (   0.00%)     2551.02 *  -0.53%*     2812.74 *   9.68%*     2921.51 *  13.92%*     2955.29 *  15.23%*
> > Hmean     16      5195.69 (   0.00%)     5163.39 *  -0.62%*     5583.28 *   7.46%*     5726.08 *  10.21%*     5814.74 *  11.91%*
> > Hmean     32      9769.16 (   0.00%)     9815.63 *   0.48%*    10518.35 *   7.67%*    10852.89 *  11.09%*    10872.63 *  11.30%*
> > Hmean     64     15952.50 (   0.00%)    15780.41 *  -1.08%*    10608.36 * -33.50%*    17503.42 *   9.72%*    17281.98 *   8.33%*
> > Hmean     128    13113.77 (   0.00%)    12000.12 *  -8.49%*    13095.50 *  -0.14%*    13991.90 *   6.70%*    13895.20 *   5.96%*
> > Hmean     256    10997.59 (   0.00%)    12229.20 *  11.20%*    11902.60 *   8.23%*    12214.29 *  11.06%*    11244.69 *   2.25%*
> > Hmean     512    14623.60 (   0.00%)    15863.25 *   8.48%*    14103.38 *  -3.56%*    16422.56 *  12.30%*    15526.25 *   6.17%*
> > 
> 
> Yes I think it'll also benefit for the cluster's conditon.
> 
> But 128 threads seems like a weired point that Chen's patch on 5.17-rc1 (without this series) causes degradation,
> which in Chen's tbench test it doesn't cause that much when the 2 * cpu number == threads[*]:
> 

From the data, it seems like Chen Yu's patch benefits the overloaded condition (as expected) while
the cluster scheduling has benefit most at the low end (also expected).  It is nice that
by combining these two approaches we can get the most benefit.
 
Chen Yu's patch has a hard transition to stop search for idle CPU at about 85% utilization.
So we may be hitting that knee and we may benefit from not stopping search completely
but reducing number of CPUs searched, as Peter pointed out.

Tim 

> case            	load    	baseline(std%)	compare%( std%)
> loopback        	thread-224	 1.00 (  0.17)	 +2.30 (  0.10)
> 
> [*] https://lore.kernel.org/lkml/20220207034013.599214-1-yu.c.chen@intel.com/
> 
> > tbench running on numa 0 only:
> >                             5.17-rc1          rc1 + chenyu          rc1+chenyu+cls     rc1+chenyu+cls-pingpong   rc1+cls
> > Hmean     1        324.73 (   0.00%)      330.96 *   1.92%*      358.97 *  10.54%*      376.05 *  15.80%*      378.01 *  16.41%*
> > Hmean     2        645.36 (   0.00%)      643.13 *  -0.35%*      710.78 *  10.14%*      744.34 *  15.34%*      754.63 *  16.93%*
> > Hmean     4       1302.09 (   0.00%)     1297.11 *  -0.38%*     1425.22 *   9.46%*     1484.92 *  14.04%*     1507.54 *  15.78%*
> > Hmean     8       2612.03 (   0.00%)     2623.60 *   0.44%*     2843.15 *   8.85%*     2937.81 *  12.47%*     2982.57 *  14.19%*
> > Hmean     16      5307.12 (   0.00%)     5304.14 *  -0.06%*     5610.46 *   5.72%*     5763.24 *   8.59%*     5886.66 *  10.92%*
> > Hmean     32      9354.22 (   0.00%)     9738.21 *   4.11%*     9360.21 *   0.06%*     9699.05 *   3.69%*     9908.13 *   5.92%*
> > Hmean     64      7240.35 (   0.00%)     7210.75 *  -0.41%*     6992.70 *  -3.42%*     7321.52 *   1.12%*     7278.78 *   0.53%*
> > Hmean     128     6186.40 (   0.00%)     6314.89 *   2.08%*     6166.44 *  -0.32%*     6279.85 *   1.51%*     6187.85 (   0.02%)
> > Hmean     256     9231.40 (   0.00%)     9469.26 *   2.58%*     9134.42 *  -1.05%*     9322.88 *   0.99%*     9448.61 *   2.35%*
> > Hmean     512     8907.13 (   0.00%)     9130.46 *   2.51%*     9023.87 *   1.31%*     9276.19 *   4.14%*     9397.22 *   5.50%*
> > 
> > > like rc1+cls, in some
> > > cases(256, 512 threads on numa0&1), it is even much better.
> > > 
> > > Thanks
> > > Barry

