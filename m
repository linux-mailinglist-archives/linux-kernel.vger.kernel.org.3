Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B444A7446
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345343AbiBBPKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:10:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16904 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231908AbiBBPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:10:38 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212DnsrB004746;
        Wed, 2 Feb 2022 15:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DYqbrEQXWKB1ih6aUkuALNEjAbGPJNSp7kehGlIBDSU=;
 b=pfkw5St9aGEtSQA9BgejY2siatX0vyWHMbFvtCM5UIbps90+sFYVTJc2Gc3dpkoce8wf
 Fcf//6PBE/d+SuQPwXZQzqJiY0g4aF7tfWPwXr1nTOujNZaPktPOT89KAKJJiqiXylyG
 14MOteQpmpawRUcA2TdGJrJw2PjJ4TN7hxMikf8lI2kKdPL8XBbv9ivTswY3kJg5mItD
 YcnW/dz3k8SUUj4KlbFS/KN/AttLp1IiKigipwAjR7nkUYL+CVbnaRRzw9yvDET3LNjv
 aH9969tYs1gYiuym+gTe+sx1Z3RV22mcjjffVkxZdnpq8JvguWDh+mN398BfwOAUrgk3 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac68t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 15:10:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212F7TaW034195;
        Wed, 2 Feb 2022 15:10:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by userp3030.oracle.com with ESMTP id 3dvtq2thy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 15:10:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt4in1oEGZ7wocIPjsyzKtFjQU7yAlnagVN1b8NA4sTRpnZI4QVo29NdpHlzU9fJzQUvp4gFV4RYC6mwKSCqh0CWw1rvyv4AFqjhCAX5Hk8KjVxAOc3ycxTjkp66y7ADB46NhOYoOKyfecaGcXGaxMc6OXOg51lX9qVOnqc73pZpm99UNEVq6C9SHkDEUHY7cCXnk7HG4lPL3DPmhf5WHgHJ1VpQKiLsxNB8Cd8Y1z0a/1s4dOwQfRONjs/afDRTgye+XmHOJ2seKBPcCjrQklec6wv0V4x7kWR1F6xD3yDBcUOuWhvM4dof0/x06/0HvfdKRE3FhTsPA6vKw6ReFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYqbrEQXWKB1ih6aUkuALNEjAbGPJNSp7kehGlIBDSU=;
 b=k4pt9fvGGNsT7GX3NnV64SVvvVd5ZFC0AQZ7GF/c7wS4eb/WXcJSMpZy7+rPUILHhLoSkIIyw2gjbSygWScF4pZ/Xl6F4QBBZXL56WozojQvd6sgNIx4bikE5TxqAcRfXznaIJXhkcmLoVwKAqI+RpEv7ZgLv3tQa+kHcr/Ye5mnObFlxtfPaswBxFxZrFl1Q9r5hJ/v+PFTAJOfyaXqOg64m9DxB/MDNJ7qSDG7ctt3d3b/QL0ry0rf7IOTrOpYNyvZg9n4EbTUZWtmucmRoRJWcY5EOUL13mLbaysao3Vy+mkDSPepS+JoCk/6XUKvuxNV87eHByMsnPNndFgzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYqbrEQXWKB1ih6aUkuALNEjAbGPJNSp7kehGlIBDSU=;
 b=OtXYVS754gLg5Gpf4sOGwESwEv6szlZheGU4mi53xirSG/LdczjR5kABSyDy5OXxGAefVgWfoFmvJ8t0voTE671hD3Q1koiiRdCyitj+E5XLYweSzARIgxRVH+TcMaDXGAbMiNScBwsHQbrpbOYP2bi3J9AJx41ifgXOkukuQeQ=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB3499.namprd10.prod.outlook.com (2603:10b6:5:178::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 15:10:30 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%3]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 15:10:30 +0000
Message-ID: <f0245f52-9c8c-8526-a99f-73c0073b9866@oracle.com>
Date:   Thu, 3 Feb 2022 02:10:21 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] kernfs: Reduce contention around global per-fs
 kernfs_rwsem.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20220113104259.1584491-1-imran.f.khan@oracle.com>
 <20220113104259.1584491-3-imran.f.khan@oracle.com>
 <YeBWWWa030xTftWe@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YeBWWWa030xTftWe@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0103.ausprd01.prod.outlook.com
 (2603:10c6:10:111::18) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0a53145-6027-49aa-0ecc-08d9e65e26bf
X-MS-TrafficTypeDiagnostic: DM6PR10MB3499:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB34996A1013FAE90395033DA4B0279@DM6PR10MB3499.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4I4vogZJCC7pKIKwZ+S66GY4NrbLLFSqxvJYuqwmpC3s91VNRrZ8R93VJMyL/5nO+PxAGO8jMN77icW7R8CyrX7WrJQgKM90glpGnEhFUdL6pQXGRjfpXX4fcG4Y/xG8J5BN373xRnvYNh+u9UmPtQG14ZeDrIoRhNUs0+v8tQbSqaWdmTgiSF6d7qkWZ+819+ii3KbHCY2KbGGfN8Zc7P+XKQ/NlpFPMsnBF01W33COsJrJrW0LY/QeGC0qeK7Vsuk3tbUUXk0PgGsVvAdHe9+v59aTDS3E71fm9FNEpBFXpRUK0X8k/TbjEAsvxnvlN8U8SJPPGBedF3S62KF8Ek/nM6oK0LPROUqkH038Of/TDj65DbSwPNinlHxbLOM976Fbia7v/Zv9htfxxNTOCNglFysMOEUz/7l6AkWWPVZkSiA13lfX+0JRotPl5PDNcU9Ct8sp3e9dgPJiMFHLsPABe2PqsUnVM/JlyzytptlPHyICd7+jC3mC8cj+q9kfD5p+8Jk3DZPEfzu8lXwHe8AE7Ud3JwdRSYHUvoTuR6NtiKoTFcsXw4G/22bDzfj8L8ec1r9EdjCO9a9uDlXN0YW4V8MGgVwwgVLUHNgEnYpaRI7nGakT3vknegJq6PjVoZtoemT9tPGSqtbMwe901YNINhUCGBuaOqZvGS/czuiOjjjVvYE3ZeXcS0DFFyuV8gh6FO/sVjX0TPEPOYydWXCikEpV1A8Y8Gr9bMMmCjikqAHK209gVgy8/oeCllJ4w5ZD/0ryjRZ53m8gM00Q58i6dsXkzEduEvLXXjXx7pOeqZNJQCUXBrK4tiHU3Be
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(6512007)(4326008)(8936002)(8676002)(86362001)(6916009)(66476007)(31696002)(66556008)(2616005)(508600001)(6486002)(966005)(316002)(6666004)(83380400001)(38100700002)(5660300002)(186003)(26005)(36756003)(53546011)(2906002)(31686004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTNzUDlXL1dOTmgwZ29CZWdUYUs5MDM2R0t6a25uY2VoYlVlVFBXdkVIc1hs?=
 =?utf-8?B?OEdhMmhONnBnWEdpOXI0S3VUSm5kWDJscDZzMUNYby9nTEZpTVNPd1hoZ0JO?=
 =?utf-8?B?eCtyNGVEOTdhbzJMQTVMZWQrM1BSR0h4eHdUZTRSWmxocWxjSDZHWHQxM0FJ?=
 =?utf-8?B?bVA4WmZmWnNRN0dOeGMxNER2MEV2MXNnQlE1YTBINUwwT2d3RWVZTjR1SHJh?=
 =?utf-8?B?cFBjdEl3VUZCaFBBWS94OFp1T1NtZkliMHUyZjcxc1N5QzRZUWw1NzByakh3?=
 =?utf-8?B?OFVvSUdHeGpLOHhMU1RUTFdueDZhTGNGbk1uWHNSVXpwa3FTYmRwVmlyVWtN?=
 =?utf-8?B?NjdsUTJzSko5L3pIVGVBY2owQklpaWpqOC9lbDFEY2ZxNnhud0dZbmxKU0s0?=
 =?utf-8?B?cURsTEs2ODQySTFVY2dKRGFIa013UXBXRDJqa0ROZHcvbXJDL0hHMkFyVFU3?=
 =?utf-8?B?YkVjSWViYnpQNjZBckNnNXNSMGkzT3VmMXRtaWZZNjVDNExhaTJVdjM4NzBI?=
 =?utf-8?B?R3E2ajJuejd2RXJrY3IrVXRqMlYzekh6emZ2WFFpWW8yLzJJaDJudkxUNStx?=
 =?utf-8?B?ckF5OUdhejhiVGJZOCtmZS81VGYyYm9ndDNHRGtLN1owY0JuYXdsRWpMUEcw?=
 =?utf-8?B?VGhTYklPZzNUM2VLTW5jbS9CYkdMSGFzMHZHN05zZUVKUnNsQ3IreTVab3VB?=
 =?utf-8?B?cnFqYXRFY2VycTBweGZjaHVsck1XcTlISkxBOGp4WEpmZFluNm9mdHhuYTZq?=
 =?utf-8?B?ZGNWZkUwZ0VRTjBqY3EvT1pzanM2QlJ3MFJ1OGI1cUVxUmNER3VyQXU5blRy?=
 =?utf-8?B?Q3cweGFyRjZITUJEQmIzMzVwV010RWl5dm9HRWpqS0diUjRndXlENVhWeTdi?=
 =?utf-8?B?aVZGYWNNQWRPZWcxcUtkeW9rOUJvamZRbUFwZVczeWZRd3U0RmJrbTFVL2Nw?=
 =?utf-8?B?TFlFSFRmTEtkbWt1MlhibnVXUWh1V0FiejJScUhueFo0REFLS1BySmQyNnBl?=
 =?utf-8?B?UG9hb1A3WDdUUVJHR3JTTkpscFpzTllxL2JVVEVOTVdnN2I2MFlRVkhoUjZD?=
 =?utf-8?B?aWZMZUdYa09NdENXM3U2bldSS0JZY2NPOTJCbVNpbGRFWS91L2JhMEE2L1hQ?=
 =?utf-8?B?VnBWbFczVmRHeWx1V2QxSE1XRG0xNkYrbUh4SGFRTVp0VnVML3Z0bWRoQUZh?=
 =?utf-8?B?dmdFbUg1UWdxMWdFN3ZLcVVxY3BvRlZHalVCdTg1djM4NTRyQ3VRS2dBaFBq?=
 =?utf-8?B?d3hDRmRESG1xR2kyQ21uN2dnSUNFdlpJRVNQNVhhOVhVeGNjTC9SbXFiTWdl?=
 =?utf-8?B?dFdmRlBZeWRLWWxNeCtaSlgwb3c4NnJnKzNlaWNUTmFqVU1wM0dLNWNFSElR?=
 =?utf-8?B?M21QWXZRemgzcDY1MWZmeU0vaTdkdElUeGw4c25XeUtHMUVTMDE0d1VEUGsy?=
 =?utf-8?B?K3Fidm1MWHdTelV0NVBpWUtzYWoyQXhtQWxkNGYrWG1GakQvUm1KNUJ6M01L?=
 =?utf-8?B?WW5TYnVhZ1lhV2tOYjNmQm4rUS95ZGgxV05DUG9ZamZacEE5SzAvYURoY0FC?=
 =?utf-8?B?NVlLdjNFZk5tYld6b20ydWx3OHVQQkN3OXpRakJ0ZU5YZ1pYNEZhaHpkTFY3?=
 =?utf-8?B?N1p4V24wN0VKeXdkV0thRmFVTy8wMnFqL3B0WVdJUXorM2ZVcERqMWVjYVls?=
 =?utf-8?B?dkJtVngzZi9lT0dxT0pTVUs1TStIUk5XRXg0dnhvY0NNUldlalFaVjhYT3lv?=
 =?utf-8?B?UXJuVHhDZFpCeDNtR0dGbFlZKzh0YTV6cmpwL2dzOHluT3AzWUlDaVZLc1Zn?=
 =?utf-8?B?K3libDM3U3d3YkJLdnM4aXZhS0ZZQUl6ODdoQkJpVXF4U0x4cnN5VjExUmdG?=
 =?utf-8?B?dnd2T2NXc0E3NlE0MmViZllDQnE0NkM3NGFCR0NGVTI5RkhIdElDNk9JOU1O?=
 =?utf-8?B?dTBobUhEYy9oWXpvTjFXME92MXBWTjJsSUdMOC9iQUxaQmlyTy9BMHl1U3Q3?=
 =?utf-8?B?bUNWcWxFYjNXMjlFL0krZ2Y4M202ZGVZaDJ1Rk43OG5XMXgzZk9wdFlSTnJu?=
 =?utf-8?B?d3dldjZGM3NuRHBPdGlMeGg1bzdZdjB6b3ljdkZHNFRlRzl5bkgxbEIySmFT?=
 =?utf-8?B?WXBTalMzVXVFVXVoUEt6cEpQaVlBWWpkOWlZKzdGWUtmSU5pci95eVhsMHB5?=
 =?utf-8?Q?ryO6sWmAqeK1+TeUvYl1CU8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a53145-6027-49aa-0ecc-08d9e65e26bf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 15:10:30.4129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdQ0O7Hp+o5aEfnCqdhnZI4V47+wKizb3e9fVgPyYmdVgZ5ZXaKa1XAbRNziYwyMncDcX5khEHrEbidURC/TcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3499
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020084
X-Proofpoint-GUID: QyIfjMpfo4YJ9Arl0lJgKiPeChVd9Jwp
X-Proofpoint-ORIG-GUID: QyIfjMpfo4YJ9Arl0lJgKiPeChVd9Jwp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On 14/1/22 3:42 am, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jan 13, 2022 at 09:42:59PM +1100, Imran Khan wrote:
>> @@ -748,11 +749,14 @@ int kernfs_add_one(struct kernfs_node *kn)
>>  		goto out_unlock;
>>  
>>  	/* Update timestamps on the parent */
>> +	rwsem = iattr_rwsem_ptr(parent);
>> +	down_write(rwsem);
>>  	ps_iattr = parent->iattr;
>>  	if (ps_iattr) {
>>  		ktime_get_real_ts64(&ps_iattr->ia_ctime);
>>  		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
>>  	}
>> +	up_write(rwsem);
>>  
>>  	up_write(&root->kernfs_rwsem);
> 
> Hmmm, so the additions / removals are still fs-global lock protected. Would
> it be possible to synchronize them through hashed locks too? We can provide
> double locking helpers - look up locks for both parent and child and if
> different lock in the defined order (parent first most likely) and record
> what happened in a token so that it can be undone later.
> 
> Without going through the code carefully, I don't remember whether there's
> something which depends on global locking but I'm sure we can fix them too.
> It'd be really nice if we can make all operations similarly scalable cuz
> with heavy stacking addition/removals can get pretty hot too.
> 

I have replaced global rwsem with hashed version in v4 of the patch set
at [1].
I have tried to avoid nested locking because of the following deadlock
scenario:

Say node N11 has parent node N1 and node N22 has parent node N2. Also
N11 and N2 hash to same lock and N1 and N22 hash to same lock.
In this case if we have 2 parallel contexts such that one is locking
N11 and it's parent and other is locking N22 and it's parent and
execution happens like below:

Thread 1                       Thread 2
Take lock of N11               --------

----                          Take lock of N22

Wait for lock of N1           ----------

--------                     Wait for lock of N2

the testing that I have done with v4 are:

1. Multiple boots with systemd and udevd in place to create/remove
sysfs, cgroupfs entries

2. CPU hotplug and reading topology attributes from sysfs in parallel

3. sysfs LTP tests.

4. Above 3 tests with lockdep and KASAN enabled kernels

I will wait for your feedback about approach taken in v4 of the patch
set  [1].

[1]:
https://lore.kernel.org/lkml/20220202145027.723733-1-imran.f.khan@oracle.com/

Thanks
-- Imran

