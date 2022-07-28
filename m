Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC908584686
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiG1TKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiG1TKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:10:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA632DB3;
        Thu, 28 Jul 2022 12:10:33 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lv0Y2661Yz67F4F;
        Fri, 29 Jul 2022 03:08:22 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 28 Jul 2022 21:10:31 +0200
Received: from [10.126.174.188] (10.126.174.188) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 20:10:29 +0100
Message-ID: <f93045ec-569c-bd09-3617-d7d7aca4e5cd@huawei.com>
Date:   Thu, 28 Jul 2022 20:10:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
To:     Can Guo <quic_cang@quicinc.com>, <bvanassche@acm.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <beanhuo@micron.com>, <quic_asutoshd@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <quic_ziqichen@quicinc.com>,
        <linux-scsi@vger.kernel.org>, <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.174.188]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 08:01, Can Guo wrote:
> +
> +	hba->nr_queues[HCTX_TYPE_DEFAULT] = num_possible_cpus();
> +	hba->nr_queues[HCTX_TYPE_READ] = 0;
> +	hba->nr_queues[HCTX_TYPE_POLL] = 1;
> +
> +	for (i = 0; i < HCTX_MAX_TYPES; i++)
> +		host->nr_hw_queues += hba->nr_queues[i];
> +
> +	host->can_queue = hba->nutrs;
> +	host->cmd_per_lun = hba->nutrs;
> +
> +	/* One more reserved for dev_cmd_queue */
> +	hba->nr_hw_queues = host->nr_hw_queues + 1;
> +

So this would mean that the host can accept .can_queue * .nr_hw_queues 
numbers of requests simultaneously - is that true?

thanks,
John
