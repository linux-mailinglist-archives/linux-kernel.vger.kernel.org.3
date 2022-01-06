Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2187486A50
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243188AbiAFTHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:07:16 -0500
Received: from mail-bn8nam11on2075.outbound.protection.outlook.com ([40.107.236.75]:35777
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232414AbiAFTHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:07:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvd0lSf9FXfzDTXOGNgfw9XH6SOhhb75C6OjD0auIU7124pf37GWGX+kYZhinhXqX/L0Kr3b5/f5Ju5HZMqSqYxVJgvEcI+7R1Xg7O08Epv0kyMSGhcGnbSk6SxIGEDpqeuai2KVpjIvOIzrm/+2Ezr97yxmCmqDEAEZYLIrlu6nYNd+qUL7sI/lt195hlDV3oOK9odvEPyQG8+lG+Gx/K4TMyhtw+qbP359K1cYGq0ba9o2S4fFZcua4YcDHxYUAOuYTRAKB663k3hhPUcXzqs+Vm0RC1dcLYT9iQhAEzAGvP9/piklGctHo8lH6T74AgDz3ZzIM+FmJXQQJoX6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7EAbDkkT/KxGq3NgJyLmfAd1f+z5p2gH7pEST2iAjs=;
 b=DF/f+wXjGsn79ABy7pWL91ZltSocmDV7yXilympzWyRum/L9sqtEQrDG+B7AvWynHwF3VMvV1KXukfOqFc+uLCrSUoezuyARGI4NFWzjIkenifv0bgin3cNZ1Ttw49IA5SqkWATbZ+ZuQ830B1aPI32a+dMQtiZHfjVA8y4j7cWdFX52ofFPzhu2ZrEc33UDGo5GEKTdxHYpARlaT4K+qY6Sx/3TXqAop5lO8YGwEKDs9AvuAT3cKCrO64cdr0HjJxYUOaahq1w6ekqwdrsvaiuD4dDeyACpMoI2m5EF52rnLoc2tRzlVNni+JiIdAIumjVF9weqn7VlZMu3HwrkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7EAbDkkT/KxGq3NgJyLmfAd1f+z5p2gH7pEST2iAjs=;
 b=YKZthvU94t8Wt4gNAlZ77bLuRZcByUk5NeROOQe3A7JN+THbWq8x9nmm9fcUvYFoztoxZpNQqb0GHiK+ggsFBuhT3Pq0BvXUS0+SGl4JtQn7y7eRbRpUjWHTJlZA7+OkS8yZWgj62jbF9w+71pajqv3Eq3I6xf8eLuYblA/MxP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 6 Jan
 2022 19:07:13 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::4843:2718:efe2:f1aa]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::4843:2718:efe2:f1aa%7]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 19:07:13 +0000
Subject: Re: [PATCH v2 3/4] Watchdog: sp5100_tco: Add EFCH SMBus controller
 initialization using MMIO
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        ssg.sos.patches@amd.com, sudheesh.mavila@amd.com,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>
References: <20211103161521.43447-1-terry.bowman@amd.com>
 <20211103161521.43447-4-terry.bowman@amd.com>
 <20220106181809.GA240027@roeck-us.net>
From:   Terry Bowman <Terry.Bowman@amd.com>
Message-ID: <9afabe55-6429-2284-cafd-d59ce481f067@amd.com>
Date:   Thu, 6 Jan 2022 13:07:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220106181809.GA240027@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:610:b2::20) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bea8c56c-ef9d-4764-46a8-08d9d147bf1b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5043:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5043B44465D96D909CC2D2D1834C9@CH0PR12MB5043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xQBzJK7cz8CA0seYrI3UPeOMhoQhbQqII7pSPPDyPN/02t8TppcqJ9rhAQ0oIicVk3kImLY3FsYacJD95V0WRUz9BEk1CJ+w8W8aIAnrmHq0qfFXBLxj1sON9R1KN7hg1/p2KZ5760+yiLUoGSQ+jLxU1K3d3acpGoV+/UlLVzoDYSF8tTBqHWlgL58Q3t7xNyN+OAfBsMPukqLwfqVVxl17xxDLzOj+ztMWMMWJwCTIa26Rky+nslkQVsek0ZJPu41NkdYYhDNH0Q5eJ2X75Ao8ygzK77zqj6nMl3el9M3vvmJCNGqb7ZfnZvnpZyln64nBkTNKIfaPMRj7QkfAjorTV6XTpo1Dw74/JjeUOfCkXUrj5joOmqdXrZWo/laTVSMaC/C0gWQ1lR/7HgBmLRmk0USOkU7yoZiIuRwkBqD7Mx75fRZ6kdyVJRxZSd22G6XB9FFkcqHq/Fc5l78bVLbci1PuZmTU2pjmnXeLiD1Lef0x0m6NlqI2MbroYqQK1XSKTKZafSXTqETv3dCJTBZua858Tm3A/T3sT4ayYPd9wVmq9MuTMXt9Pvol4/mkqny0KQazF6L93mG+TNySpC8sHJQRmL1P3QYSSHxHliVM5R50QwLVfNcSENtMfjBcapqAcNrIpEWw6439XczhgXtFlOZxTzFgHvf7DUHYqCZh+d++iuyZpQzuY1UMJJRarg1u/wOH93qATSWcDeqt3kEg1/iEEEpB8WDBgqoIZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(6486002)(2906002)(26005)(86362001)(4326008)(5660300002)(6512007)(6916009)(38100700002)(66476007)(83380400001)(66556008)(186003)(2616005)(36756003)(53546011)(508600001)(8936002)(6506007)(66946007)(31686004)(8676002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi9UNWF2UnpVek9wK0hFQkNCMVJFaVAreFhOa1NNaDNCeVlhWENSbFZybG5L?=
 =?utf-8?B?OGFpNlB1VXltQld1OWd2dmR2WjQrSWxnL29jVkVOZDg5ZHhjelNYS0VacEdh?=
 =?utf-8?B?M3RkeXkvSFdUMlVidm5vSXJQQkpIV1V4QjY5RVEyVFZkUjRKQUlZdE1oVUY3?=
 =?utf-8?B?UXlCaUphU0VBd1V5YWgxbHNETytuMjNUbDZ4M3BXN1FKZFUwU0ZxclpGS05E?=
 =?utf-8?B?T1dQd2xuYngzdFBuWittUmxmejNjOWt1WEZZUW84SHBXRGZtaCtpK0NDcmhB?=
 =?utf-8?B?WXVzL2NtdmljT3RKMzR4Wm5IWFZxRDR0U2JreTBxcXQ2MWowRzN1aFFWaThP?=
 =?utf-8?B?dGtNaVlIZ1oyY0daNFI2OEx3Y0ZTL29FVVFSYmJQVHV1enIybUJjczV6YWhh?=
 =?utf-8?B?cVR1Y3BHUkFTRi91dkxKbVFhTkFYQXlUT2k5eEwzRTl2RlMwVU9GRGQzMWN0?=
 =?utf-8?B?TWV3QkQ5RHoxbWl3NnpsWUFqcXpMWTduaUduMGJqUy9OeVEyMEoxSFZibzdG?=
 =?utf-8?B?ZnU3YjQzb2laUENldndmbG9ldXY1MkJ6UGZjYmxMSkkwaEFpMXhpUjdLWGxv?=
 =?utf-8?B?ZmUvWEkrMFZXRG9hd1o2THhDa1U4emFURjNaakQyeWhicktPU0lPakhaNmFp?=
 =?utf-8?B?aTlCSWxZcjQxck1SY2pYMTNnUkM2WVg3YkhKY0JORWthNWdJSXBUUGJ5MGI4?=
 =?utf-8?B?elRmVHRheEhENDJBT3VGako5SWxEYmVvWFptdTgxK2NWd3RnUXg3MWhpc090?=
 =?utf-8?B?NXBIeXNNa1JXb3U5Z0xJSUEyNTNLRjZQZllhWlB4azRveGtHRXZUSDNoZzQ0?=
 =?utf-8?B?SklQRVNMSlJkV1lhT1hpUWxtRVZyRitLUmo3ZjFiTXl4ZjVKUWVyeGh3YlAx?=
 =?utf-8?B?aVlFam03S2RQTnNTcGMvL0gyb2NrbmVtQjRLZHBXSFFuUUVwMUZTMnBrcjdS?=
 =?utf-8?B?TFVYUVVIQTBWdFlBNG5ITCt1UFMwQXd6WHpwTTgyNmxFbHp2RW1keGVMK3Nu?=
 =?utf-8?B?QldCQVA4UEwxTEU1NG5RWGN6di9HYUJPWkc5dTF1WjdaSVNTdUpDQkhDaUpa?=
 =?utf-8?B?MDluSXZxU3VQM013b0tscnVyaG5rSGxKYTRzazFVR21PblphbWdZWEdOV3dt?=
 =?utf-8?B?SzROWW1NQ1hWWXFPMlhuNkcwU1RaTmdtN0JKMGdVNldWY2hEUGhGczM0SGxW?=
 =?utf-8?B?YUExNTNNbmIwMTJBbnlISzhzZ0RMMmFEUzJyUE9tZVdocHV5dk44RVp0Z1cx?=
 =?utf-8?B?eStCNlBNT05uQkl0aFhtZFMyVHRENmp4cEkycGlkb3g2R0VrMTBlc2pZaVlv?=
 =?utf-8?B?NjlrWlpHUzJkWFFjdjdDUFhGM0VXeDJwU3ZBVFR4L1NkZUpmTkZ1cjB6SjJ4?=
 =?utf-8?B?WHlvVkpvUmJXWHFpeTFiVVdOb1F2eFc0UnQ1RzlRQzRUUm04cHEyOHdXRG0x?=
 =?utf-8?B?dzVHQ1dBbGdqekJmSXZFUktEVWtQMUx5Y3RZbGFsUXhBR3BxTXVEcHNIaVAx?=
 =?utf-8?B?L3RKeHJBd3Vsblo3a1hTeGQxVnpDMnczVW1CdUJmTnFvSW9kMzY4TXRFeEw5?=
 =?utf-8?B?NWo4MnUvMEV2N2FhRXY5UkRmNUlPbEtFcmp1MXFraXhuOUc2cE1sVGdnSHBQ?=
 =?utf-8?B?eGk1bmdpdDhXZ0JtNkVJRk12MFB1TE82VDUxYXNsKzJ3d1EvdzRjcmQwZzVM?=
 =?utf-8?B?NzA4QXdaSVJVRXdJVUNKLzY1VUE5bWYxRHVYVXFnYkMzNFFuZCt1bVg1bEVx?=
 =?utf-8?B?WTlrcmJwVGhGSnVsM3JGd1BISFFaQlNDcWFWcnQxMjF4cmNEaWlYTUtCNWt0?=
 =?utf-8?B?SkY0R25PUHZYQkd5VXNNZlVNbkxUakQ3M0EvS0hqcGdFL3RQZjZua01Ha2w1?=
 =?utf-8?B?NG9ycXJoMGt3U2U3cHk2VmplTWphbUM4eGhQM25rSGNSSXdiVjh5WnVLZzVO?=
 =?utf-8?B?Mlo0dVFCdUtLK3VndE9HT3BIcW5ITmt6cXN4QVF4cHpraWk1Y28vZUc5VndL?=
 =?utf-8?B?cVhQbnNKWmkvT0E2L0tadVVnQitveHo1K3lPSnpvZHNhaDlxSzlEVXYzUWxF?=
 =?utf-8?B?ZFJpSmY3djVNOUp4TVp1QVEvcUVQL3MwU005VjhVK2xRb1Y1bWp1S2hnTWxh?=
 =?utf-8?B?ZEQ0MUNEaVJVSjdPYjltNThQNzVNZ01nVjI0OU9uK1RSSmhVOEIwRUNSNGRJ?=
 =?utf-8?Q?VuZrwf9nppo91w+v4UzO9rA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea8c56c-ef9d-4764-46a8-08d9d147bf1b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 19:07:13.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+gkpON/HUrFATma7DViyfSYVbsQR9f97AUPbuIuQ1zR6FHIatRssvKBCDiYyf2ohlCiPWoOS+hIUsrQjM3PrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Tom Lendacky

On 1/6/22 12:18 PM, Guenter Roeck wrote:
> On Wed, Nov 03, 2021 at 11:15:20AM -0500, Terry Bowman wrote:
>> cd6h/cd7h port I/O can be disabled on recent AMD hardware. Read accesses to
>> disabled cd6h/cd7h port I/O will return F's and written data is dropped.
>>
>> The recommended workaround to handle disabled cd6h/cd7h port I/O is
>> replacing port I/O with MMIO accesses. The MMIO access method has been
>> available since at least SMBus controllers using PCI revision 0x59.
>>
>> The EFCH MMIO path is enabled in later patch.
>>
>> Co-developed-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> To: linux-watchdog@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Robert Richter <rrichter@amd.com>
>> ---
>>  drivers/watchdog/sp5100_tco.c | 104 +++++++++++++++++++++++++++++++++-
>>  drivers/watchdog/sp5100_tco.h |   6 ++
>>  2 files changed, 109 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
>> index 80ae42ae7aaa..4777e672a8ad 100644
>> --- a/drivers/watchdog/sp5100_tco.c
>> +++ b/drivers/watchdog/sp5100_tco.c
>> @@ -48,12 +48,14 @@
>>  /* internal variables */
>>  
>>  enum tco_reg_layout {
>> -	sp5100, sb800, efch
>> +	sp5100, sb800, efch, efch_mmio
>>  };
>>  
>>  struct sp5100_tco {
>>  	struct watchdog_device wdd;
>>  	void __iomem *tcobase;
>> +	void __iomem *addr;
>> +	struct resource *res;
> 
> I must admit that I really don't like this code. Both res and
> addr are only used during initialization, yet their presence suggests
> runtime usage. Any chance to reqork this to not require those variables ?
> 
> Guenter
> 

Hi Guenter,

Yes, v3 will include refactoring to remove 'res' and 'addr'. I will also 
correct the trailing newline you mentioned in an earlier email.

Regards,
Terry

>>  	enum tco_reg_layout tco_reg_layout;
>>  };
>>  
>> @@ -161,6 +163,59 @@ static void sp5100_tco_update_pm_reg8(u8 index, u8 reset, u8 set)
>>  	outb(val, SP5100_IO_PM_DATA_REG);
>>  }
>>  
>> +static int sp5100_request_region_mmio(struct device *dev,
>> +				      struct watchdog_device *wdd)
>> +{
>> +	struct sp5100_tco *tco = watchdog_get_drvdata(wdd);
>> +	struct resource *res;
>> +	void __iomem *addr;
>> +
>> +	res = request_mem_region(EFCH_PM_ACPI_MMIO_PM_ADDR,
>> +				 EFCH_PM_ACPI_MMIO_PM_SIZE,
>> +				 "sp5100_tco");
>> +
>> +	if (!res) {
>> +		dev_err(dev,
>> +			"SMB base address memory region 0x%x already in use.\n",
>> +			EFCH_PM_ACPI_MMIO_PM_ADDR);
>> +		return -EBUSY;
>> +	}
>> +
>> +	addr = ioremap(EFCH_PM_ACPI_MMIO_PM_ADDR,
>> +		       EFCH_PM_ACPI_MMIO_PM_SIZE);
>> +	if (!addr) {
>> +		release_resource(res);
>> +		dev_err(dev, "SMB base address mapping failed.\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	tco->res = res;
>> +	tco->addr = addr;
>> +	return 0;
>> +}
>> +
>> +static void sp5100_release_region_mmio(struct sp5100_tco *tco)
>> +{
>> +	iounmap(tco->addr);
>> +	release_resource(tco->res);
>> +}
>> +
>> +static u8 efch_read_pm_reg8(struct sp5100_tco *tco, u8 index)
>> +{
>> +	return readb(tco->addr + index);
>> +}
>> +
>> +static void efch_update_pm_reg8(struct sp5100_tco *tco,
>> +				u8 index, u8 reset, u8 set)
>> +{
>> +	u8 val;
>> +
>> +	val = readb(tco->addr + index);
>> +	val &= reset;
>> +	val |= set;
>> +	writeb(val, tco->addr + index);
>> +}
>> +
>>  static void tco_timer_enable(struct sp5100_tco *tco)
>>  {
>>  	u32 val;
>> @@ -201,6 +256,12 @@ static void tco_timer_enable(struct sp5100_tco *tco)
>>  					  ~EFCH_PM_WATCHDOG_DISABLE,
>>  					  EFCH_PM_DECODEEN_SECOND_RES);
>>  		break;
>> +	case efch_mmio:
>> +		/* Set the Watchdog timer resolution to 1 sec and enable */
>> +		efch_update_pm_reg8(tco, EFCH_PM_DECODEEN3,
>> +				    ~EFCH_PM_WATCHDOG_DISABLE,
>> +				    EFCH_PM_DECODEEN_SECOND_RES);
>> +		break;
>>  	}
>>  }
>>  
>> @@ -313,6 +374,44 @@ static int sp5100_tco_timer_init(struct sp5100_tco *tco)
>>  	return 0;
>>  }
>>  
>> +static int sp5100_tco_setupdevice_mmio(struct device *dev,
>> +				       struct watchdog_device *wdd)
>> +{
>> +	struct sp5100_tco *tco = watchdog_get_drvdata(wdd);
>> +	const char *dev_name = SB800_DEVNAME;
>> +	u32 mmio_addr = 0, alt_mmio_addr = 0;
>> +	int ret;
>> +
>> +	ret = sp5100_request_region_mmio(dev, wdd);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Determine MMIO base address */
>> +	if (!(efch_read_pm_reg8(tco, EFCH_PM_DECODEEN) &
>> +	      EFCH_PM_DECODEEN_WDT_TMREN)) {
>> +		efch_update_pm_reg8(tco, EFCH_PM_DECODEEN,
>> +				    0xff,
>> +				    EFCH_PM_DECODEEN_WDT_TMREN);
>> +	}
>> +
>> +	if (efch_read_pm_reg8(tco, EFCH_PM_DECODEEN) &
>> +	    EFCH_PM_DECODEEN_WDT_TMREN)
>> +		mmio_addr = EFCH_PM_WDT_ADDR;
>> +
>> +	/* Determine alternate MMIO base address */
>> +	if (efch_read_pm_reg8(tco, EFCH_PM_ISACONTROL) &
>> +	    EFCH_PM_ISACONTROL_MMIOEN)
>> +		alt_mmio_addr = EFCH_PM_ACPI_MMIO_ADDR +
>> +			EFCH_PM_ACPI_MMIO_WDT_OFFSET;
>> +
>> +	ret = sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name);
>> +	if (!ret)
>> +		ret = sp5100_tco_timer_init(tco);
>> +
>> +	sp5100_release_region_mmio(tco);
>> +	return ret;
>> +}
>> +
>>  static int sp5100_tco_setupdevice(struct device *dev,
>>  				  struct watchdog_device *wdd)
>>  {
>> @@ -322,6 +421,9 @@ static int sp5100_tco_setupdevice(struct device *dev,
>>  	u32 alt_mmio_addr = 0;
>>  	int ret;
>>  
>> +	if (tco->tco_reg_layout == efch_mmio)
>> +		return sp5100_tco_setupdevice_mmio(dev, wdd);
>> +
>>  	/* Request the IO ports used by this driver */
>>  	if (!request_muxed_region(SP5100_IO_PM_INDEX_REG,
>>  				  SP5100_PM_IOPORTS_SIZE, "sp5100_tco")) {
>> diff --git a/drivers/watchdog/sp5100_tco.h b/drivers/watchdog/sp5100_tco.h
>> index adf015aa4126..73f179a1d6e5 100644
>> --- a/drivers/watchdog/sp5100_tco.h
>> +++ b/drivers/watchdog/sp5100_tco.h
>> @@ -83,3 +83,9 @@
>>  
>>  #define EFCH_PM_ACPI_MMIO_ADDR		0xfed80000
>>  #define EFCH_PM_ACPI_MMIO_WDT_OFFSET	0x00000b00
>> +#define EFCH_PM_ACPI_MMIO_PM_OFFSET	0x00000300
>> +
>> +#define EFCH_PM_ACPI_MMIO_PM_ADDR	(EFCH_PM_ACPI_MMIO_ADDR +	\
>> +					 EFCH_PM_ACPI_MMIO_PM_OFFSET)
>> +#define EFCH_PM_ACPI_MMIO_PM_SIZE       8
>> +
