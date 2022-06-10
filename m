Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837D0546F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbiFJVUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiFJVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:20:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB913FDAB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654896011; x=1686432011;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pqG+Qg/ylT4j8GOZY6J5PxKZ3poP9l+qi4+yhxajZUU=;
  b=m/Y49UuJp0usoWDXzLgbuK7fecf0SxP/mzc+zVYu3WkhvHAxL+2hyKhj
   VFFpUJmt5zvNf091kusgP9TnRPeW9sGDr+U60yJDrkwwJhdpKTU+OaldC
   BTbYNJCEz38wZpA+IptmLciTly95reWLXRq9/L79a9kppTAjiB/JR9I5H
   Z3A/zkkJjPvlQVUu/ocsR2jlu5Z+ycmZ4szMy7hZ2ePtpfMwFmfNaLa7F
   U52ofuTdA/WHxhpmapHu1P7ReIBjWGN27n4i4tFcZ8OzoArQe2qDYVMLW
   fWQQnfk7+MBMHNGPebXe4WeDjZiz8L15HK+eNWDLsBmQrg+ArZMd8b6ib
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="364079608"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="364079608"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 14:20:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="610887491"
Received: from schen9-mobl.amr.corp.intel.com ([10.252.137.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 14:19:58 -0700
Message-ID: <f7a0d098ac635c9596d739515efd4f1bc383c73e.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Yicong Yang <yangyicong@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        guodong.xu@linaro.org, hesham.almatary@huawei.com,
        john.garry@huawei.com, shenyang39@huawei.com,
        Chen Yu <yu.c.chen@intel.com>
Date:   Fri, 10 Jun 2022 14:19:57 -0700
In-Reply-To: <4ab2c422-04ae-3199-ae2a-357c3270cd05@huawei.com>
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
         <20220609120622.47724-3-yangyicong@hisilicon.com>
         <c3fa2b4f5884e5ad4efda48b1bb2ab4f7a2e532a.camel@linux.intel.com>
         <4ab2c422-04ae-3199-ae2a-357c3270cd05@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-10 at 14:39 +0800, Yicong Yang wrote:
> 
> 
> I've tested this patch with MySQL as well (like in v2). This won't hurt
> the MySQL case with SIS_PROP but observed some improvement with SIS_UTIL
> posted in [1]. We leverage the nr to suppress redundant scanning in the
> current approach and seems SIS_UTIL is more efficient in this case.
> 
> 			 5.19-rc1		   patched	 patched+SIS_UTIL[1]
> TPS-16threads		  6215.11	  6172.74 (-0.68%)	  6217.33 (0.04%)
> QPS-16threads		124302.21	123454.68 (-0.68%)	124346.52 (0.04%)
> avg-lat-16threads	     2.57	     2.59 (-0.65%)	     2.57 (0.00%)
> TPS-24threads		  8726.40	  8690.87 (-0.41%)	  8833.08 (1.22%)
> QPS-24threads		174527.88	173817.42 (-0.41%)	176661.54 (1.21%)
> avg-lat-24threads	     2.75	     2.76 (-0.36%)	     2.71 (1.33%)
> TPS-32threads		  9555.42	  9514.86 (-0.42%)	 10010.87 (4.77%)
> QPS-32threads		191108.37	190297.28 (-0.42%)	200217.35 (4.55%)
> avg-lat-32threads	     3.35	     3.36 (-0.30%)	     3.20 (4.58%)
> TPS-64threads		 10290.10	 10324.75 (0.34%)	 10819.77 (5.15%)
> QPS-64threads		205802.05	206494.95 (0.34%)	216395.40 (4.90%)
> avg-lat-64threads	     6.22	     6.20 (0.38%)	     5.92 (4.88%)
> 

Thanks for the numbers. SIS_UTIL will keep off migrations off the cluster
that doesn't really improve overall utilization.  We have higher chance that
L2 cache is warm.  So it makes sense that we see a bit
better performance there.

Tim


