Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA895A5ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiH3JC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiH3JC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:02:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20119F1A6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:02:24 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U6Pxh5022426;
        Tue, 30 Aug 2022 04:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=V3JwjUYaG9//thPC4BpkFa4sbgYWP5F0GzkhlFPquZQ=;
 b=jvdfEASyU4UXTzp4w6xu8HKKXzcfqcLG2X+fVA52ElRbAiESJJil/D043us5JqGoWHoD
 fFjfn0/KkOYkcIL7eoSAsy1du0Z+c80QnD5xtWgXzuwM+Mr4X8Hl0jnUFlvJ3dDupGJJ
 7oxtQHxMf3Q4/C+C51GrsByRNFado2tZyisBhw25HAMv1QefDNUaXFZESuwPHRqqzV6+
 ZcvUzgIfJHaA6Lc8/lFaPwGreROS/vZsVmzdZSHUPldp0L5od5cgoXQ4y6vCXA4CVy8w
 Jcc7QYcY+t8zxTIQE8XKgJsmyRx4kdc7McTWoEagKHEED2c+n2zoLAan7GqIJxvoxco6 Ow== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3j7gp233mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 04:02:17 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Tue, 30 Aug
 2022 04:02:15 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Tue, 30 Aug 2022 04:02:15 -0500
Received: from [198.90.251.95] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6926F46C;
        Tue, 30 Aug 2022 09:02:15 +0000 (UTC)
Message-ID: <40352b26-97fb-374f-dd3d-52e241399dfb@opensource.cirrus.com>
Date:   Tue, 30 Aug 2022 10:02:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] soundwire: bus: Don't re-enumerate before status is
 UNATTACHED
Content-Language: en-US
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20220829094458.1169504-1-rf@opensource.cirrus.com>
 <20220829094458.1169504-2-rf@opensource.cirrus.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20220829094458.1169504-2-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FpYuGQwy9hoEBeNCqTnUoXKZwco1UU_K
X-Proofpoint-ORIG-GUID: FpYuGQwy9hoEBeNCqTnUoXKZwco1UU_K
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2022 10:44, Richard Fitzgerald wrote:
> Don't re-enumerate a peripheral on #0 until we have seen and
> handled an UNATTACHED notification for that peripheral.
> 
> Without this, it is possible for the UNATTACHED status to be missed
> and so the slave->status remains at ATTACHED. If slave->status never
> changes to UNATTACHED the child driver will never be notified of the
> UNATTACH, and the code in sdw_handle_slave_status() will skip the
> second part of enumeration because the slave->status has not changed.
> 
> This scenario can happen because PINGs are handled in a workqueue
> function which is working from a snapshot of an old PING, and there
> is no guarantee when this function will run.
> 
> A peripheral could report attached in the PING being handled by
> sdw_handle_slave_status(), but has since reverted to device #0 and is
> then found in the loop in sdw_program_device_num(). Previously the
> code would not have updated slave->status to UNATTACHED because it had
> not yet handled a PING where that peripheral had UNATTACHED.
> 
> This situation happens fairly frequently with multiple peripherals on
> a bus that are intentionally reset (for example after downloading
> firmware).
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>   drivers/soundwire/bus.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index cb77da84a4f9..a3d3d66b3410 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -766,6 +766,13 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>   			if (sdw_compare_devid(slave, id) == 0) {
>   				found = true;
>   
> +				/*
> +				 * Don't re-enumerate a device until we've seen
> +				 * it UNATTACH.
> +				 */
> +				if (slave->status != SDW_SLAVE_UNATTACHED)
> +					break;

This should return. We're going to keep seeing this peripheral as the
next to be enumerated until we program its device ID.

> +
>   				/*
>   				 * Assign a new dev_num to this Slave and
>   				 * not mark it present. It will be marked
