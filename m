Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42424507223
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354040AbiDSPxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354077AbiDSPwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:52:50 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799641B7A8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=bn5gyY+3+xnocaEXQ1ub68fqvMC/+QyIGS1VbmoqLzQ=; b=JYMbw00HEy1svWGf07hspaVsEQ
        xxqaDgs+25Q9sfbTe402CuAO9HkfXNEKpLfcFKpb4fAChFXUiOwkNLh6wua7vFlS+W+kZ/dmdFidN
        Icr0t+fABKKCRc3zxG8FEG1u2hBnIY7LTqY15YHDKVpuUUwv7bl9Cq1N7YwRrVMqLjdHyG666Qkjd
        mXQaoH95+jXgftDPCiRaxs9NTsYyeYmVa2Z+CnUjFOb7L6vwk4o0tzVStv9xbRotdHo7Oq1HJlgLI
        siVQjwQjL5JWv9SCzj+ySXUBiO6ovIjNu+bF1Ev1sx6UO7+0fMewlC30tvEU8dMKNvMpJYrGAJFAz
        RylFh2zQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1ngq73-00BbRv-Ru; Tue, 19 Apr 2022 09:49:58 -0600
Message-ID: <7cb4d3be-925f-05bd-78fe-67a69dfee18d@deltatee.com>
Date:   Tue, 19 Apr 2022 09:49:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-CA
To:     Guo Zhengkui <guozhengkui@vivo.com>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com
References: <20220419071855.23338-1-guozhengkui@vivo.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220419071855.23338-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: guozhengkui@vivo.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, yang.lee@linux.alibaba.com, fomichev.ru@gmail.com, fancer.lancer@gmail.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, zhengkui_guo@outlook.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] ntb_perf: fix doubletest cocci warning
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-04-19 01:18, Guo Zhengkui wrote:
> `!data->ops.init` has been repeated triple. The original logic is to
> check whether `.init`, `.run` and `.clear` callbacks are NULL or not.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

This appears to be a patch against Alexander's patch which has not been
accepted yet. Posting a note on his patch so he fixes it for the next
posting would be preferable.

Logan

> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index c106c3a5097e..dcae4be91365 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1451,7 +1451,7 @@ static void perf_ext_lat_work(struct work_struct *work)
>  {
>  	struct perf_ext_lat_data *data = to_ext_lat_data(work);
>  
> -	if (!data->ops.init || !data->ops.init || !data->ops.init) {
> +	if (!data->ops.init || !data->ops.run || !data->ops.clear) {
>  		struct perf_ctx *perf = data->perf;
>  
>  		data->status = -EFAULT;
