Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBED5071F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353931AbiDSPkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbiDSPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:40:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714017040
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650382650; x=1681918650;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4N2SkFIST0VyNGwkWWx2ut7F+Xkhd+EsUCbxFRceHsA=;
  b=g1pNkLIpqnXqyzRdia/1gijCdPuOhgj3cDFzIS8sv4wFFay7MlInQ3dQ
   eiGq+N5A/KOcrPBU8aYO+SzH+FnOZU4TwxXW8kjD7rcAYr+zFIdD95VL6
   vRe9rBx1C5fvxfzraE+pIIwWNh1I02J7zl2glOTgWadZPynijj+Uj7yT/
   PmNqzwUK+pQawMK192HUePlQTQV3EDClKHoL/rvrtSYeUY8Xn4xn1gRYV
   8Ng+oJ71nTBcXkO/ZQbDbNyWJThvSUIRyqUPc/T4NcEsw1HVZdfT0lMIF
   ZJp8LIjOBThxtWfXDELJb7f0zKnEDov7R2H+lZUrI/m7uh8F5DzP/btxd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="326694709"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="326694709"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 08:37:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="727110814"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.111.34]) ([10.212.111.34])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 08:37:29 -0700
Message-ID: <d8240552-acea-0214-a5a3-6bf07ad6b007@intel.com>
Date:   Tue, 19 Apr 2022 08:37:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ntb_perf: fix doubletest cocci warning
Content-Language: en-US
To:     Guo Zhengkui <guozhengkui@vivo.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com
References: <20220419071855.23338-1-guozhengkui@vivo.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220419071855.23338-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/19/2022 12:18 AM, Guo Zhengkui wrote:
> `!data->ops.init` has been repeated triple. The original logic is to
> check whether `.init`, `.run` and `.clear` callbacks are NULL or not.
>
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/ntb/test/ntb_perf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index c106c3a5097e..dcae4be91365 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1451,7 +1451,7 @@ static void perf_ext_lat_work(struct work_struct *work)
>   {
>   	struct perf_ext_lat_data *data = to_ext_lat_data(work);
>   
> -	if (!data->ops.init || !data->ops.init || !data->ops.init) {
> +	if (!data->ops.init || !data->ops.run || !data->ops.clear) {
>   		struct perf_ctx *perf = data->perf;
>   
>   		data->status = -EFAULT;
