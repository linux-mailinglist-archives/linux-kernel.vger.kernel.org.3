Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FE54E49D4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiCVX7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiCVX7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:59:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26032CC92
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647993503; x=1679529503;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=/GxhdKQcRNqZKx1OxrK2UpO2g0Q4Le5EpadCPUv1Y3U=;
  b=E2Qojn6pbYYVpCUXjTHGrwhZ6B5cr9oIaBTm3ZiNAkt1tO+tNZWSEM9s
   zMu1ek5+GGuOrntUgIdGz/CVQlTFrlxXcKaabHXvuUshg7YkgSrbrX54z
   EmUoihUT/fvSNyU44F97g88Jh1386SUMUaIhkHNyr1GXmCwzzQffEV8l1
   USD9I/ACC/i0icVmfloW8VxfDKapd764PvgUAMyGJ4fqW08/Z272S4PwG
   7voFA5Mce0bd9JPAGUAfXgV6FIiTKQTKp0pwAJYuHtI1pp4vPGmoR+6Z1
   XoL/zvRzQdSLTSQZk20igb1YBjteYtuAFkzG/Asav27nquA0fJv8ey5LM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="321182437"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="321182437"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 16:57:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="649222711"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 16:57:20 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Untangle config dependencies for demote-on-reclaim
References: <20220322224016.4574-1-osalvador@suse.de>
Date:   Wed, 23 Mar 2022 07:57:17 +0800
In-Reply-To: <20220322224016.4574-1-osalvador@suse.de> (Oscar Salvador's
        message of "Tue, 22 Mar 2022 23:40:16 +0100")
Message-ID: <87ils535ia.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> At the time demote-on-reclaim was introduced, it was tied to
> CONFIG_HOTPLUG_CPU + CONFIG_MIGRATE, but that is not really
> accurate.
>
> The only two things we need to depen on is CONFIG_NUMA +
> CONFIG_MIGRATE, so clean this up.
> Furthermore, we only register the hotplug memory notifier
> when the system has CONFIG_MEMORY_HOTPLUG.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>

LGTM!  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying
