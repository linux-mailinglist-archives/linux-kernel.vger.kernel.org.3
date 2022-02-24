Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79DA4C2CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiBXNIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiBXNIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:08:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCDF230E48;
        Thu, 24 Feb 2022 05:07:48 -0800 (PST)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4Cpn543Lz67Lnh;
        Thu, 24 Feb 2022 21:06:41 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 24 Feb 2022 14:07:46 +0100
Received: from [10.47.86.126] (10.47.86.126) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 24 Feb
 2022 13:07:45 +0000
Message-ID: <93ca25b8-db43-3ce8-0923-3acad41d0856@huawei.com>
Date:   Thu, 24 Feb 2022 13:07:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/2] scsi: libsas: Use bool for queue_work() return code
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <chenxiang66@hisilicon.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <1645700699-82369-1-git-send-email-john.garry@huawei.com>
 <1645700699-82369-3-git-send-email-john.garry@huawei.com>
 <4b107020-2494-2470-ba1b-c2000eae1355@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <4b107020-2494-2470-ba1b-c2000eae1355@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.126]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> -int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
>> +bool sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
>>   {
>>   	/* it's added to the defer_q when draining so return succeed */
>> -	int rc = 1;
>> +	bool rc = true;
>>   
>>   	if (!test_bit(SAS_HA_REGISTERED, &ha->state))
>> -		return 0;
>> +		return false;
>>   
>>   	if (test_bit(SAS_HA_DRAINING, &ha->state)) {
>>   		/* add it to the defer list, if not already pending */
>> @@ -28,11 +28,11 @@ int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
>>   	return rc;
> 
> While at it, I would cleanup this function like this:

ok, fine

> 
> diff --git a/drivers/scsi/libsas/sas_event.c
> b/drivers/scsi/libsas/sas_event.c
> index 3613b9b315bc..38e6e91aaf36 100644
> --- a/drivers/scsi/libsas/sas_event.c
> +++ b/drivers/scsi/libsas/sas_event.c
> @@ -12,20 +12,17 @@
> 
>   int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
>   {
> -       /* it's added to the defer_q when draining so return succeed */
> -       int rc = 1;
> -
>          if (!test_bit(SAS_HA_REGISTERED, &ha->state))
> -               return 0;
> +               return false;
> 
>          if (test_bit(SAS_HA_DRAINING, &ha->state)) {
>                  /* add it to the defer list, if not already pending */
>                  if (list_empty(&sw->drain_node))
>                          list_add_tail(&sw->drain_node, &ha->defer_q);
> -       } else
> -               rc = queue_work(ha->event_q, &sw->work);
> +               return true;
> +       }
> 
> -       return rc;
> +       return queue_work(ha->event_q, &sw->work);
>   }
> 
> No local variable :)
> 
>>   }
>>   
>> -static int sas_queue_event(int event, struct sas_work *work,
>> +static bool sas_queue_event(int event, struct sas_work *work,
>>   			    struct sas_ha_struct *ha)
>>   {
>>   	unsigned long flags;
>> -	int rc;
>> +	bool rc;
>>   
>>   	spin_lock_irqsave(&ha->lock, flags);
>>   	rc = sas_queue_work(ha, work);
>> @@ -44,13 +44,12 @@ static int sas_queue_event(int event, struct sas_work *work,
>>   void sas_queue_deferred_work(struct sas_ha_struct *ha)
>>   {
>>   	struct sas_work *sw, *_sw;
>> -	int ret;
>>   
>>   	spin_lock_irq(&ha->lock);
>>   	list_for_each_entry_safe(sw, _sw, &ha->defer_q, drain_node) {
>>   		list_del_init(&sw->drain_node);
>> -		ret = sas_queue_work(ha, sw);
>> -		if (ret != 1) {
>> +
>> +		if (sas_queue_work(ha, sw) == false) {
> 
> if (!sas_queue_work(ha, sw)) ?

ok, yeah, that's the pattern I see elsehwhere in the kernel

> 
>>   			pm_runtime_put(ha->dev);
>>   			sas_free_event(to_asd_sas_event(&sw->work));
>>   		}
>> @@ -170,7 +169,6 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
>>   {
>>   	struct sas_ha_struct *ha = phy->ha;
>>   	struct asd_sas_event *ev;
>> -	int ret;
>>   
>>   	BUG_ON(event >= PORT_NUM_EVENTS);
>>   
>> @@ -186,8 +184,7 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
>>   	if (sas_defer_event(phy, ev))
>>   		return;
>>   
>> -	ret = sas_queue_event(event, &ev->work, ha);
>> -	if (ret != 1) {
>> +	if (sas_queue_event(event, &ev->work, ha) == false) {
> 
> Same.
> 
>>   		pm_runtime_put(ha->dev);
>>   		sas_free_event(ev);
>>   	}
>> @@ -199,7 +196,6 @@ void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
>>   {
>>   	struct sas_ha_struct *ha = phy->ha;
>>   	struct asd_sas_event *ev;
>> -	int ret;
>>   
>>   	BUG_ON(event >= PHY_NUM_EVENTS);
>>   
>> @@ -215,8 +211,7 @@ void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
>>   	if (sas_defer_event(phy, ev))
>>   		return;
>>   
>> -	ret = sas_queue_event(event, &ev->work, ha);
>> -	if (ret != 1) {
>> +	if (sas_queue_event(event, &ev->work, ha) == false) {
> 
> And again.
> 

ok, thanks
