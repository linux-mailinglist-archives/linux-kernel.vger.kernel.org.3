Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A31556DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357741AbiFVVWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 17:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiFVVWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:22:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81352E9D2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655932926; x=1687468926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D3Ij7TP4hU6Wr3f6pJziCsfFHVgXKs2ja8aPLEb0PQQ=;
  b=ZI6pgVTKQ4/dqNYW9CcLiSiS+/IETzZukX6Luz3XqI80sjFvtPK1yjH5
   aormmqUucM4Y43f2fsy43IvUPuVxUWgm99A56ddv7NBSdqctSLW+cMsHo
   bIoC9uj8/UsOY831JD8ClK5CZpX+OS+dskn/8KSzgYA7nNbltI03y/xoY
   LxkO+sR6UmbhLLhdcr8idRBg9EyJLO7b5yP/TazX5zXEKRkELK9qqgs1K
   4korjwywxE78xb5UCr/lOaa501Z647PTPVZlhcPG/v7t3/+6kwJZbsGsI
   0ukakcruJ7cl6RSgBx4yDk8YvvMnS80fOAYVxL4k8F6tYFlQ6SqqL2EKJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260368251"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260368251"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 14:22:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="588362060"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2022 14:22:02 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o47nV-0001hd-UB;
        Wed, 22 Jun 2022 21:22:01 +0000
Date:   Thu, 23 Jun 2022 05:21:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v7 11/12] mm/demotion: Add documentation for memory
 tiering
Message-ID: <202206230554.5tVWF6UB-lkp@intel.com>
References: <20220622082513.467538-12-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622082513.467538-12-aneesh.kumar@linux.ibm.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Aneesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Aneesh-Kumar-K-V/mm-demotion-Memory-tiers-and-demotion/20220622-163031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Documentation/admin-guide/mm/memory-tiering.rst:5: (SEVERE/4) Title overline & underline mismatch.

vim +5 Documentation/admin-guide/mm/memory-tiering.rst

     4	
   > 5	===========
     6	Memory tiers
     7	============
     8	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
