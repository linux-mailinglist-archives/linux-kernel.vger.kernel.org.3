Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0064D1E24
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbiCHRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiCHRIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:08:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25508BC81
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646759254; x=1678295254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rbzyGGxkDdg5MrfDGdFxARpZaSodeNWFg/OZHJmkfrw=;
  b=AcWJA2gAnz2tlstm7dJTNF3qJbaLdhwFx8g3beXHTsIEGPEkYaauDv+C
   3ABtYZUGMJURvjEV/SArZvzg5vV/6i/8KHPtnCuSA77lD/Ztsx6RATuJb
   vBeq/7rqfn3TgWbmX2jA777SoO3LcRAnly7tNlGmKNTiAXlIyc/jwBqRC
   FHtoIghDgdSxLEgdE8VR7dvM+DZU1sLAxkwwYgIx/sylrKmS7kajGT42c
   VVuJrfBge1pfbszHfF0WxZ0VxY83OShPEIwqQxDVdxpprPJyudxCV1TRL
   0jBn/mmZATvFy6DfBQr3rjz2pkEK1pheovUuJAyqhe7JMj/LFp/EL8r8X
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242184069"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="242184069"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 09:07:30 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="632297352"
Received: from ralphala-mobl.amr.corp.intel.com (HELO [10.209.117.92]) ([10.209.117.92])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 09:07:24 -0800
Message-ID: <86383ac9-e5f2-1a2e-dd19-02e39714a3fd@intel.com>
Date:   Tue, 8 Mar 2022 09:07:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -V11 2/9] mm/migrate: update node demotion order on
 hotplug events
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-2-ying.huang@intel.com>
 <eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com>
 <f5edb9dc-8b25-47c2-9905-09e88e41861b@intel.com>
 <4e8067e1-0574-c9d2-9d6c-d676d32071bd@linux.vnet.ibm.com>
 <87pmnb3ccr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YicvnkVODh5qbxTC@localhost.localdomain>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YicvnkVODh5qbxTC@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 02:27, Oscar Salvador wrote:
> @@ -2043,7 +2044,12 @@ static void __init init_cpu_node_state(void)
>  static int vmstat_cpu_online(unsigned int cpu)
>  {
>  	refresh_zone_stat_thresholds();
> -	node_set_state(cpu_to_node(cpu), N_CPU);
> +
> +	if (!node_state(cpu_to_node(cpu), N_CPU)) {
> +		node_set_state(cpu_to_node(cpu), N_CPU);
> +		set_migration_target_nodes();
> +	}
> +
>  	return 0;
>  }
> 
> @@ -2066,6 +2072,8 @@ static int vmstat_cpu_dead(unsigned int cpu)
>  		return 0;
> 
>  	node_clear_state(node, N_CPU);
> +	set_migration_target_nodes();
> +
>  	return 0;
>  }

Yeah, those callbacks do look like they're reinventing the wheel.  This
is a much more direct way of doing it.
