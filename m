Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A99533FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244866AbiEYPLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiEYPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:11:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EF8AFACE
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:11:22 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L7ZJS2Ww8z67tkx;
        Wed, 25 May 2022 23:10:48 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 17:11:19 +0200
Received: from [10.199.170.112] (10.199.170.112) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 16:11:06 +0100
Message-ID: <853b6d52-da86-1c06-3604-3085ece331a4@huawei.com>
Date:   Wed, 25 May 2022 18:10:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] coresight: etm4x: Add Support for HiSilicon ETM device
Content-Language: en-US
To:     Qi Liu <liuqi115@huawei.com>, <gregkh@linuxfoundation.org>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <abudankov@huawei.com>,
        Alexey Budankov <alexey.budankov@huawei.com>
References: <1597323562-3706-1-git-send-email-liuqi115@huawei.com>
From:   Alexei Budankov <abudankov@huawei.com>
In-Reply-To: <1597323562-3706-1-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.170.112]
X-ClientProxiedBy: saopeml500003.china.huawei.com (7.184.65.141) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Qi Liu,

On 13.08.2020 15:59, Qi Liu wrote:
> Add ETMv4 periperhal ID for HiSilicon Hip08 and Hip09 platform. Hip08
> contains ETMv4.2 device and Hip09 contains ETMv4.5 device.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x.c | 2 ++
>   1 file changed, 2 insertions(+)

Thanks for your patch.
I would like to test HiSilicon ETM device feature on
Kunpeng 920 based server.
I applied the patch and booted the kernel with the changes.
However I don't see any device files neither here:
/sys/bus/coresight/devices/
nor here:
/sys/bus/event_source/devices/cs_etm/sinks/
What should a user expect new in os with this patch added?

Thanks,
Alexei


> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 6d7d216..7797a57 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1587,6 +1587,8 @@ static const struct amba_id etm4_ids[] = {
>   	CS_AMBA_UCI_ID(0x000bb805, uci_id_etm4),/* Qualcomm Kryo 4XX Cortex-A55 */
>   	CS_AMBA_UCI_ID(0x000bb804, uci_id_etm4),/* Qualcomm Kryo 4XX Cortex-A76 */
>   	CS_AMBA_UCI_ID(0x000cc0af, uci_id_etm4),/* Marvell ThunderX2 */
> +	CS_AMBA_UCI_ID(0x000b6d01, uci_id_etm4),/* HiSilicon-Hip08 */
> +	CS_AMBA_UCI_ID(0x000b6d02, uci_id_etm4),/* HiSilicon-Hip09 */
>   	{},
>   };
> 
> --
> 2.8.1
