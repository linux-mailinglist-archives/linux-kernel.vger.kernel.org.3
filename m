Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973B850E40E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbiDYPLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242751AbiDYPLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:11:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C2068FAF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650899290; x=1682435290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wQnjSWMkT1Rr15X7pNbO5/y1mdqNp9x3OoIAYE6/qS0=;
  b=e7fNyzjNtaGap6+ZJvsEEr5USXLvKSkVtkdIZJAS+dYTUsmknGqROZZK
   JDOPDDY08gWbWny7t8Mq56sDvZMpO5ZYI1WvkO6o0u64XKXxk2jfw/pu2
   W7yJOYdD78jKxLnwJasu2J8+lyWWFnMGb4T5lrrCCt6ZHM9Wor7HBGakx
   w9QJe43sd4HFObuclLvl4OecmOtyYLj6bHz8j/jBCGmOtPllxK5WkQXYZ
   r3CuCMqA9VMGC+Hd1TOM/yXQGKJrF3qIgLLP3r6wQT19GiH7lNBrfUcnz
   ACg0gppOLQGvx5s/tzG5sOJgR4sWtMmtWSfu2DnqBx3MZN0m/4+IFwxj9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="351719122"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="351719122"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:07:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="729779664"
Received: from hungyuan-mobl.amr.corp.intel.com (HELO localhost) ([10.212.88.155])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:07:43 -0700
Date:   Mon, 25 Apr 2022 08:07:43 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     cgel.zte@gmail.com
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ran.jianping@zte.com.cn, jane.chu@oracle.com,
        rafael.j.wysocki@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] tools/testing/nvdimm: remove unneeded flush_workqueue
Message-ID: <Yma5P3b7HceTyUD6@iweiny-desk3>
References: <20220424062655.3221152-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424062655.3221152-1-ran.jianping@zte.com.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 06:26:55AM +0000, cgel.zte@gmail.com wrote:
> From: ran jianping <ran.jianping@zte.com.cn>
> 
> All work currently pending will be done first by calling destroy_workqueue,
> so there is no need to flush it explicitly.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  tools/testing/nvdimm/test/nfit.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index 1da76ccde448..e7e1a640e482 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -3375,7 +3375,6 @@ static __exit void nfit_test_exit(void)
>  {
>  	int i;
>  
> -	flush_workqueue(nfit_wq);
>  	destroy_workqueue(nfit_wq);
>  	for (i = 0; i < NUM_NFITS; i++)
>  		platform_device_unregister(&instances[i]->pdev);
> -- 
> 2.25.1
> 
