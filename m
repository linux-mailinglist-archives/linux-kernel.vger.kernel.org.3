Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4D51CF60
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388521AbiEFD1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388514AbiEFD1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:27:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6046D5EDF3
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651807399; x=1683343399;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gJAhDIHMWpivM5Pb0+lUmlrgmemgOFXzFUKg/utqTFs=;
  b=ewNcwe4LmzPv9AdsDBCK0640PRoGEVCujQoyks3SW/saVxVCCBVM6BXu
   bjdRxybUwpCXEdwG5hVP0by8EUxstl2gWX35mBind3SguqgMksfpXHKGx
   d4/l9ZcBmSzgZrd5HLZrCwgqTxUNmiwxCwG57fiJCB0qf/ARJwBiTCmPs
   l2+FJRjMi+FnpqGVnvKjnwXB8TxNK25RdF7Tt6Mlz3kvyYhlflwk0FfG7
   HtFio9Z8Cg2xhZJvy9tce9U+dkU6/G9Oe5W04iWX+732fS8cW0VJYr5KC
   Dai3u3N+SLmcrwThWG6CudcpX0wKpBLu6iqpuE2JYr5wDydME1+nQbw9D
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267173951"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267173951"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 20:23:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="517828846"
Received: from fulaizha-mobl1.ccr.corp.intel.com ([10.254.213.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 20:23:16 -0700
Message-ID: <d260e8b178defbe4facda3cd8f0b534ec812268a.camel@intel.com>
Subject: Re: [PATCH v2 1/4] mm/migration: reduce the rcu lock duration
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, naoya.horiguchi@nec.com
Cc:     hch@lst.de, dhowells@redhat.com, cl@linux.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 06 May 2022 11:23:14 +0800
In-Reply-To: <20220425132723.34824-2-linmiaohe@huawei.com>
References: <20220425132723.34824-1-linmiaohe@huawei.com>
         <20220425132723.34824-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 21:27 +0800, Miaohe Lin wrote:
> rcu_read_lock is required by grabbing the task refcount but it's not
> needed for ptrace_may_access. So we could release the rcu lock after
> task refcount is successfully grabbed to reduce the rcu holding time.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Christoph Lameter <cl@linux.com>
> ---
>  mm/migrate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b2678279eb43..b779646665fe 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1902,17 +1902,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>  		return ERR_PTR(-ESRCH);
>  	}
>  	get_task_struct(task);
> +	rcu_read_unlock();
>  
> 
>  	/*
>  	 * Check if this process has the right to modify the specified
>  	 * process. Use the regular "ptrace_may_access()" checks.
>  	 */
>  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> -		rcu_read_unlock();
>  		mm = ERR_PTR(-EPERM);
>  		goto out;
>  	}
> -	rcu_read_unlock();
>  
> 
>  	mm = ERR_PTR(security_task_movememory(task));
>  	if (IS_ERR(mm))

Hi, Miaohe,

Please check the previous discussion and verify whether the original
reported race condition is stll valid by yourself before resending this
patch again.  If you find that the original race condition isn't
possible now, please add the analysis in your change log.

Best Regards,
Huang, Ying

