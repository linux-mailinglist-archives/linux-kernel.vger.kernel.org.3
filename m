Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD124B8A79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiBPNl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:41:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiBPNlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:41:25 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCB22AB53D;
        Wed, 16 Feb 2022 05:41:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcWreUlyG7lEUcDw1X159FgVaSMEOd4rr8E+WBaw8OVWEUhre7S0V2tjicIbOXKWGlEpTzyI8ppIY8RLhFR3LvCe2sOE2lG4MTJe+WMqpILM+YsOZt0a0Zx0dBuFwhOszHHVBLzkVi9aec9RbGoa8bcQVEqyYUdJDL0E6sokm7GsQFPRTblWcDpxhFZb5RDkkUZElZMunu28IauqTkTu6lZlrGS8LvJ962BcyyeXd5sgb3t2hGuYPdD6dsgomxkqhGifNOS81AQ4cqVCWcf7PzhK4w98PPxeREwLV6Edkzkc8xp2pVDhJEV75n00IxxS5MauN+dOHT2pnCAjuC78jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH+V5lVRuO9jm33WJ3isjOizC7F49kVn7CyftNwzAXM=;
 b=JaNTgt6Bw8O0i2FXO2kHOBSjGlyE0SSTDxmFMYd5Z7FYbM8ZwbQKLf3Rs8VkopsRSUumZ1YZh+TfDLs530VpX/AmoITH3BSGHdvZ6XVQFkajMBAsRMausmhsXVYKOlJcOGhP3ijb5QQ679DNohQ03uVnjpOcqVJJtLOO/zj6a6kVqiF7IFYcdABIpRRXqqWc73Xly0jou8mFmvBPO7z365uywT0U8nnjWb1CJAgOGu+1xs9Jmwk3ON7jKDfyRc/vHMYipLWm8cFrcY2ZG2CMHGgoE43dgbvTh92vjZduOdGULUrvVclt7zgYha4zbTAiwBLqClQKUJGRcqHr2Qb9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH+V5lVRuO9jm33WJ3isjOizC7F49kVn7CyftNwzAXM=;
 b=y7uFSvKqEb9DwPTpf70aZAwSG/XZ60KKQyWg55ZVB+BJCtnwvOuTP3KT4DDhoTcwn9iO6UIRFLmlchbVCJP2lIQtKZojRNmVLwqG2XBVXyJHDs/TN2GoX56mqNhoZgF5bC9K6Y9DHvO2t/VG5IWuMX9hTqiUqpZh/tWoV6ivc14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BY5PR12MB4819.namprd12.prod.outlook.com (2603:10b6:a03:1fd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 13:41:10 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%4]) with mapi id 15.20.4995.014; Wed, 16 Feb 2022
 13:41:10 +0000
Message-ID: <fa6f84e9-3a17-c97d-285a-82051481ca11@amd.com>
Date:   Wed, 16 Feb 2022 07:41:08 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/3] ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY
 configuration item
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, pmenzel@molgen.mpg.de
References: <20220216025934.1892723-1-mario.limonciello@amd.com>
 <20220216025934.1892723-3-mario.limonciello@amd.com>
 <d3287f3c-a0d7-7540-c4b5-388363b34628@redhat.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <d3287f3c-a0d7-7540-c4b5-388363b34628@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:610:60::13) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52157ff0-d007-404e-fa63-08d9f151fdd2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4819:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4819CE717DB1330B6942AC38E2359@BY5PR12MB4819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgPSflpRbpdcYwvIp3OS6+7SUVOz/+Dvq4JKd8hYf4tnThwEix8j2YzQovLcKVNDscLBbnuo4GPXBvBtmdUuMFkYzwlDg/nOurQ1dJB5PC0GtBriCRE5UdSsA8h1fN1PdvcKBHM+pX49qcAbNLnt92/fWztfROvutRKD25ydAOg9wq2TuqJONk0cFDrD30+dYeUza/Uz3luUpIYaSdZCWawl5FS/VsUYheisIqUGsanQTj+DT4KCJKEwVOFwBl8jr3Ti8dXESAyDf6IRU93TiI1mBJhLqyQ8XC0v/USxT21BJSPRb+wp37jLOx1LQaqutTjJd2RBRQw5tKh0aim0quiYJ2XudlfkauzJt27rVOJoqcl5Y6YsTnkj44IcnOFK5Vfe4p5UblUUKKzQSATNjIPIVhEFz/i7t28bPC/YG/ZY068fJGEJC/J5PokyTwxPEeWHy1cqPC9lhmhM4WoJ6vbRm8QSiVM/WIs3YDzECpXY6/hR67UT1FRrR/8+ld+Kwrg1xcBiE0u6F5y6cKcbaO9H1ymqnnSxftz0imOj3BeOx9//ycKzPd2xi+s1ErHn4u4Ad+pr6wxmNoZpyInqKNx8QytGIM8V96SkNhYBiUK2nG5u5O12IsJrE3FpZl70v2y7wDg7NcHYo7E+tbRy1f4xnD60FllrXlUxyWIyQD/KTiy0X9kI7a8eHIJxXnlcEKCLy1FGkP6j77nTSirIuZqlzDX+knHmeZH26WE0azc3gZXIOp3dAK2vPQUUMr4U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(5660300002)(8936002)(508600001)(2616005)(186003)(26005)(110136005)(54906003)(316002)(31696002)(66476007)(83380400001)(36756003)(66946007)(66556008)(4326008)(8676002)(38100700002)(6512007)(6506007)(86362001)(53546011)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlVDTXIwRzREMHNwbFdMMkdrS3FLTmd0cGtMYmM2dXFjUEM0aVA5T29rWGJF?=
 =?utf-8?B?T0lVZVNwWnNRa1JlcmgweEhqbXRRbWJlNmlHcitleTlSU0JJenhJdHo1Ylc4?=
 =?utf-8?B?cnk2MEl6SGVVbVhzV3A4T3JHNy9TUWIyWVZBTGl3TTlZOXhIZkJURzludy9G?=
 =?utf-8?B?a2Fud1RwZGtLTWN0RmI0YWlGMHc0V3ZlOExLSkZ5aEtIM0ZDdkhSaGpjZ21H?=
 =?utf-8?B?L1E1WGxMbTFsMis0M1ZldDd0UlJROUNFbnIrRk04VXVEOWRCeklWcEtBM2xq?=
 =?utf-8?B?Y0FRM05sK0lKLzg4TWlwZjUvT0VRNXhaSWpRb1FaRURPMFIyUitwbmVJWC9P?=
 =?utf-8?B?OStHbGk3dEhZcVVFN2NUTGhuZ1lKeGtkb2E0NGxTOTJXem5KeFEyZFQxQjBS?=
 =?utf-8?B?cXVnQWZLQUxibi9PWml6N1kyeUMvZG5zcFQzUVRXY0pvZHdyWFZxT1c0Sk5G?=
 =?utf-8?B?UllnSzFUaHg2Q1ozUTNyQUpsaVZtM3E5Y3JnRG5tUHpEN0YyK0locllQM000?=
 =?utf-8?B?RWtoTTRDZ0V2NzJMYU1ZL0FCYXQzRTF6aHBOZ2hRQWdMWUwwa3pDa2JDbG1I?=
 =?utf-8?B?dkd4S2p2VXRIZEhjOEdIN01zVGRGL1hZb0phQkxocXhRalF6T0p2VnRiOWZi?=
 =?utf-8?B?SC9YQUZ4dTBZUEN0Qm1pZmErdG1QOXJTNFd1bXFteFk1Vjg5eHVZYlhzK2Ry?=
 =?utf-8?B?SkN6ak0vdDduK1p5NDJScE1Qa3ZRN3ljWE44UnJDOURQb1NwZXBEbjl3MDBI?=
 =?utf-8?B?ZGhra2pCdzVnZDB5YTc3Y29GM0J4c0F4MjlVNmVRdmU3WTRPdFgydWFhbEdV?=
 =?utf-8?B?TndYdDlJMys1SFhrcW9SUmhQbXRsNU5CSTlxN3NIUzB1TzB2djZDWHRjeER4?=
 =?utf-8?B?QS92V1FWdzErWXlZTUVGZHRYVkoxcDFYTVZvUFNDVnVoaFIwZys2YkNRVHpI?=
 =?utf-8?B?K1NvV045ZTJ2NGlHZ2x3QjlrODRVNnhKUURZUVFsUG1VOCtPZUdGQllhRHgv?=
 =?utf-8?B?Skl1SmloWC9wa3ZnalNsWTJISDRtWkliM0Y0TXNJeWJFY0xBVzc5aXJWV2lX?=
 =?utf-8?B?VmpBMW5NMk9UWm5pRFRmVjl1aWtoTnNrNXhuNW5JUkdMdUtsRmYzZEdzNmFY?=
 =?utf-8?B?ckc5bTdnbnNsQ01sMitTRUpsZ1dsK1c2NG1zYnFyckIvZUkwNGRvdXhnKzd3?=
 =?utf-8?B?b2pIS3lsMzhST0NidmVpSWtLZVRvb3NEUzVidUFhY2pZVVNjQjFQMUIvQk9V?=
 =?utf-8?B?Vjlud3VNRnNGNjBtcXZmSlllYzNlVWxFNVBXQkxMVVkxQUR0T3pZMjR3K1FB?=
 =?utf-8?B?STFLRTE3ZlJPdEVScS94VzNXRDhtTWJ6M2RlR3JyNXdQdzVKblgvekxhSnJD?=
 =?utf-8?B?YWlQV0ROVkpQVHAyenVnL1gzRGlHVStCd0YvTmZqc2tLUGkxOU9DVlA4cUtG?=
 =?utf-8?B?cWhLVjdGcFNrT0pQa1RoMWFJaHJDblVBOFlXd0J3a0l1dFV0WnJsVVlESE9x?=
 =?utf-8?B?VDB0RnQ5bjFPazg2MkRPRG9EL3JYVlB3V1l6d1l0M3ZYMWJVUFVkY0owYnMr?=
 =?utf-8?B?UC9JdThJY2hPYURGQ0RjUnJaKzdvcGxhT3hScWRJOWt2SHZmMkhMc3B4MytB?=
 =?utf-8?B?TnhKeFlCcURjUi9FRXZ6UHJ0WnMrUHBpdldBOFN5dFdvNUFoWmRjbGQ5WDdR?=
 =?utf-8?B?aUZqQmVXRkVpVm9Wd0E2QWs3YWNhblNXSXJkWXBDQXFySGtrQ1ZzUmJualFq?=
 =?utf-8?B?RDBnVyszdTg3ZldHb2p6TXB4S1FuZ2ZrbU9jRmhhd0w2cDg3Q2sxYmR5K2I0?=
 =?utf-8?B?YzBtVU1rL25pREQ3YTc2RlNoVFJNQXZBVGU4N3d2MWdyOWRLU0p1MXpSb29a?=
 =?utf-8?B?YlpEbDRIc1hpQTY3WWFlYW1rREdlMzR6SWU2dDhhNkNsVW5RQ2tZQXpjRHB2?=
 =?utf-8?B?RTFMeVdwckV5dWN0cEx3eFZwMEsrOG1pNkFUUmZrUUJLNzhaRmZJbnhqd2Zh?=
 =?utf-8?B?YXVpTXhoVVRZZDBOalVEMVd0K2FHbDRIMnhUVVo1RU4yaXBrTFRkT09xZUxS?=
 =?utf-8?B?R3FOanlwOGh4MVFpYlFUUXlGaTFuY0wrSHFEdE1wdFJxa3hoQVE3SmE4dmdZ?=
 =?utf-8?B?Q1dkMnpyT09zYzBpK1M3Y2tOd1VzSlI2aXplWWRTWDBFdTFGanNaSFRUeUdt?=
 =?utf-8?Q?UtwbilHKcnHIUMS/mj55w7M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52157ff0-d007-404e-fa63-08d9f151fdd2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 13:41:10.6336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ons8PGw4vDMfNX/kUXbLW3w8t9rLP9rW7DF3cDKAU+v7ChWuK/jzQOj+8wVdFDaMnXSqYiDc75VlPNJx1/w5dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/2022 06:44, Hans de Goede wrote:
> Hi,
> 
> On 2/16/22 03:59, Mario Limonciello wrote:
>> `CONFIG_SATA_LPM_MOBILE_POLICY` reflects a configuration to apply only to
>> mobile chipsets.  As some desktop boards may want to use this policy by
>> default as well, rename the configuration item to `SATA_LPM_POLICY`.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/ata/Kconfig | 6 +++---
>>   drivers/ata/ahci.c  | 2 +-
>>   drivers/ata/ahci.h  | 2 +-
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index cb54631fd950..52c086f155f0 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -115,14 +115,14 @@ config SATA_AHCI
>>   
>>   	  If unsure, say N.
>>   
>> -config SATA_MOBILE_LPM_POLICY
>> -	int "Default SATA Link Power Management policy for mobile chipsets"
>> +config SATA_LPM_POLICY
> 
> Maybe "config SATA_DEFAULT_LPM_POLICY" at least that matches the summary text better ?
> 
>> +	int "Default SATA Link Power Management policy for supported chipsets"
>>   	range 0 4
>>   	default 0
>>   	depends on SATA_AHCI
>>   	help
>>   	  Select the Default SATA Link Power Management (LPM) policy to use
>> -	  for mobile / laptop variants of chipsets / "South Bridges".
>> +	  for certain chipsets / "South Bridges".
> 
> Maybe:
> 
> for chipsets where using a different default policy then max_performance
> is deemed desirable.
> 
> Yeah no, that IMHO is no good either, but "certain" also is very much
> not helpful in this help text.
> 
> Looking at this patch I'm starting to think that maybe the maybe mobile was not
> that bad of a name after all :)
> 
> Maybe for v2 do s/mobile/low_power/ in each of the patches instead?

Sure, I'll do that and see how everything looks and reads.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
>>   
>>   	  The value set has the following meanings:
>>   		0 => Keep firmware settings
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 5be889de9b1e..7a7fa1090bb0 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -1592,7 +1592,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>>   static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>>   					   struct ahci_host_priv *hpriv)
>>   {
>> -	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
>> +	int policy = CONFIG_SATA_LPM_POLICY;
>>   
>>   
>>   	/* Ignore processing for chipsets that don't use policy */
>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>> index 1ad48e2fe573..5badbaca05a0 100644
>> --- a/drivers/ata/ahci.h
>> +++ b/drivers/ata/ahci.h
>> @@ -236,7 +236,7 @@ enum {
>>   	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
>>   							only registers */
>>   	AHCI_HFLAG_USE_LPM_POLICY	= (1 << 25), /* chipset that should use
>> -							SATA_MOBILE_LPM_POLICY
>> +							SATA_LPM_POLICY
>>   							as default lpm_policy */
>>   	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
>>   							suspend/resume */
>>
> 

