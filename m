Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238AA542244
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381210AbiFHBfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457009AbiFGXVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:21:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392A43E1C51
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654637107; x=1686173107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O0gxBHe3lcF2rzmOwsxlpBys5l79rCV1UE/MlMVYKkY=;
  b=P42Sy/1SAkdXJaTfr7JTttBFCKG/E7aIRsBpfk6gdmSPb5BHBSD7MwnG
   LIIFtyYEY0hX7aj3uU9vQrpwXeJklQQJMWTCoI3QsAh68hWG4IqXkmHc/
   qFxe6LW5M2BAYIjAj/sfuM//iXJHPAH+gS+6AcUFSoOeuml+OHwxSQ0D8
   2KqOVGfujiFea/Y5p4zmT1wcghIigCx66uaiwQ/AGi7sDz2t810q2rvx9
   1mfj3SFSyDjHvXXce8r/r1DegUu0QoNcj7+eZguB4TqS54V5PnB0C27v8
   tvP7ZOH9djDPPdSjuSq3wgB3i8ELhWmYhRxZeFp5p9Tm0HoT9FWqSxjDl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="265399559"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="265399559"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 14:25:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="648246682"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 14:25:01 -0700
Date:   Tue, 7 Jun 2022 14:25:30 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com
Subject: Re: [PATCH v4 15/21] x86/resctrl: Abstract __rmid_read()
Message-ID: <Yp/CSofc1ssvof8H@fyu1.sc.intel.com>
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-16-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412124419.30689-16-james.morse@arm.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:44:13PM +0000, James Morse wrote:
> @@ -343,7 +355,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>  		 * Code would never reach here because an invalid
>  		 * event id would fail the __rmid_read.

__rmid_read() needs to be fixed.

>  		 */
> -		return RMID_VAL_ERROR;
> +		return -EINVAL;
>  	}
>  
>  	if (rr->first) {

Thanks.

-Fenghua
