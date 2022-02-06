Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72B54AAD84
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 03:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiBFC1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 21:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBFC1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 21:27:17 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BF4C043186
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 18:27:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2161E7mD011282;
        Sun, 6 Feb 2022 02:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IcF7YkRGXGDWvGSZlKMm1pcqLPm5jQJuy6dg9dYABhE=;
 b=xDke9j7Azwv1P6D0ISyLeuqlxykoFtm7oci2Q4W26bubdVtjXRVIT03opo/sZLh9N7fQ
 3wk1bt2G9Ebl3MvDD9C0C0Yarr0c7XuIFWQ7/H4uOBhGOa6IHQnCmPrN4Kunu+hkzGDp
 zxnCiho2BS4EKgpbXlgr+/N2gfD0qYJtybjo+LMIrGI2F5RaM/qp3rxrayW5gGwlA+Rr
 iUTwOkCPmP+Z6McCjn8rqqWKeGe0pTkWtXj0aVLE7ZB6UClfah66cAZu30njdnWtZ+YB
 xBq9O8dcmgpxRl2Non/ThWeRtrAFgXmWUnE33TLsUmvFGu0350T8UTgCDWcgESOGIw47 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1hsu21tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 02:27:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2162LOPf053374;
        Sun, 6 Feb 2022 02:27:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3020.oracle.com with ESMTP id 3e1h22f3sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 02:27:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVNBd/ftdh29TX9TzCCdnblYoetarLqnPVPaSUshxhlCbBy2Tca1IypO0z8/kJ0SeIUgYGihwSBItfscaRLIM/FDtSxeVs61HsFBeskSFrcjfBHrQgbGj7FDocUe11AZAA3gfxIalnhNBNgtgeEMdeVZXDN+bbrbRDI1KleJwKv8/oReg7A4d9Ww6aqCaERvQNnNUJZ3DJPXycvkcfZ6CULVw+uStatOehERQZkt8YXcstynzyvUql9KBUO6YGzbk/nJCe7B/zY/YfPyR7RZbzWnHBh5ephFAHfyPVMwcJgR7Iu/JeiXypTW9mbkQnzKItg/hLVlC+5Jgr1Z56vszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcF7YkRGXGDWvGSZlKMm1pcqLPm5jQJuy6dg9dYABhE=;
 b=J4MBu7lWEWumQuu4m2K9adwWraKI4yqqVNdDvKIYb5sBGTL/yhdPpP6cNeddsG4Fq0MGsUXP5HzqfRuZzgFAuzcghGB285wwY90tpRHzr74K6Fh9X8GW0m6oTM7bi/bsOxbiTuQqe9m/8rHbhYbPikokHJebLvrq53Ymqi/x29Tq3hX264kR406RYTh+2MeWMXkC5LrpnNCwnEYnTNR8GGXzjiDkwQkzsX2gJZCPZvBU+1tKWitBoM26PvV93iMKwileIboJ3Cq2w6Z0joV7uw831RbeCrQyoU6Pz7tK6WA4zLShgxNaZxdhbpw8eGXIoWrgXIygwrq81ndYpLwAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcF7YkRGXGDWvGSZlKMm1pcqLPm5jQJuy6dg9dYABhE=;
 b=IVZJonElNMxktVV3Jky965yAmWhkZe9qF6JI0LZhEkNtHEvL2gdhYjOODN9XuMuKDIhEwz7E7r2mTG/Akp/M/vwDQatMgWbpZbkcLRMvXy1qOcAdxCTZcPEIP3FiQZ+jfzWU58TOaIfLyDEVlgpW5j6oIUo4dm9hjW+NV4D4WfM=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN7PR10MB2658.namprd10.prod.outlook.com (2603:10b6:406:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 02:27:07 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%3]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 02:27:06 +0000
Message-ID: <48488314-f050-f388-b3a7-9d24db8ab2f1@oracle.com>
Date:   Sun, 6 Feb 2022 13:27:00 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v4 0/2] kernfs: use hashed mutex and spinlock in place of
 global ones.
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
References: <20220202145027.723733-1-imran.f.khan@oracle.com>
 <Yf1EUCgLIzb+rnIQ@kroah.com>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <Yf1EUCgLIzb+rnIQ@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::26) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc51af82-2a50-4a11-02bf-08d9e9182aa2
X-MS-TrafficTypeDiagnostic: BN7PR10MB2658:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB265814183378738A65C2DCA3B02B9@BN7PR10MB2658.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HQa1pTJ731fzHAEuzYMAkl323sH4Lda/hhGdmQLkr3xFlMgscRyjyliGqMQFhJ7oAlJI4j1h+XcPo0gO+2tjdXiwRFdqMKkwRy9lMNiycQUcRhXIlm5+G/U9v/q7alCY9BSHJqBFKLSyJiPMTfa646qt2XndPF66x/rcn6qdOex4t10vXlWtCLW+691mBf/BzjYeeLC4rxzdnBa39Cg9LLlLU4fBciwV16oVrlmCcMCSm7ZUr3ge0O7cz91bDGb/Am/YrDjpP//JE6DTjWVZ5wm++FiyGKjtzHrXr3qKanY4IqQY2wgyOLWSoheRns4cHLSIvvfiCitgnfUjS+bFklK/Gk3p/ciforuaVaaADBYHOGtniiTWV855XCg9Wu53A00rbEnJr9GOIJIYGmbdLV+pX47URfVcUdS/8g9eyRS944rktfRWAzBp1j1EcPnTXq1hnyDbjaDOZn8AUE9HFUAXGvpdQ2155VH+kc/t38ta9fDqbPI3LtWiq1nRu1Qxztwu2oingPF1KQRWMhqxA9g5j40yEHeeagZc0zhOvZJJ3InFkrcj/9/fz/Dg9zdypkVKm4ydaVQ88ua80Xxc9sFuW6tOJOePvg02FIzuooUWrLbfW+XJ+uJ2xRjQE5375QYzvpZGjfXct/wiMfZqUeqH2v+ZtP3J3zoFAogNrX9/aCTB6lbBoUsHjkIxgrBH02cvkiXWbPnhQGlK/VmxDMTShmFw+AEVXlkZgR5XVvx2Ly45nfZuMBoISPWkHdEp7vaA4RoYXa+CMMUvYb8Mr32orJwedmxr/OwsVuNZMKoM5pxxUJ8I+FCVilkwQPs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(316002)(38100700002)(6486002)(966005)(6916009)(86362001)(4326008)(5660300002)(558084003)(31696002)(36756003)(66476007)(66556008)(8676002)(8936002)(66946007)(53546011)(83380400001)(31686004)(6666004)(6512007)(6506007)(26005)(186003)(2616005)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzBZY2QxbzZhR2FiT011aXV4dEZhMEJSRTFVS2c3c3pxMWFlRjlpQUpPZTRD?=
 =?utf-8?B?c2hRbms5UVBMRWI1K1NncG5sY3c1dHFPUHZtK2dqbklob2JacEl2SVdiNXJV?=
 =?utf-8?B?UTJNZUsxMnVlRmpSK0h6MWhGSlNseWQ3UjRvQU5teWxEYmgvUUw0b2pZS2cx?=
 =?utf-8?B?ZHZwSHMyL1pXejg5ZytBTVR2ZG5PWGJuVzBwWEl3aUcxdFRuaXd4ZHN1VWYx?=
 =?utf-8?B?YTJCcklEaVhnaXZNdEhaQjMwbm9FcUhKS3lpbFBPNzQvOUdxSTZhT1QzTXUw?=
 =?utf-8?B?R0plQytjd2tveTRVZ01JTzlsNDRmTUZ2cjBNcE1kVkpCUmJYZWFuei9qMlB4?=
 =?utf-8?B?dWhsYTZPMzk4NDVJRUx0VDZDNW9pd1oxL2Y3eVZ5OVZzdzhqeDA2dnpLYzY3?=
 =?utf-8?B?c0x5d1p0YUg5em9kQTJlRk1PRFZaNXlrRmtuM0RvaVQ5ZXppdEVseER4d0Jq?=
 =?utf-8?B?TFNZMEMyQmpWQit5NUNpdlNVMEx3VmoxRFpoUUF0dmVMODE0NDkvVzZtaklW?=
 =?utf-8?B?VE0rTVowQmdGVldKTE5BU25adGU4ZHQxNlJIYnZaL0RkVUpwOG1YYVJveGRL?=
 =?utf-8?B?TjM5VWZ2VjJ0c2FMTlEzVlE1aGlaMzBFbUdjNEhmVFdkYjZqbnFKdGJGRGd1?=
 =?utf-8?B?SkJyOGI5Z3JPbjlZVHd1cG9EMng3UU1OMDhZUG9MdXVDamZBTklaZUFIMXRt?=
 =?utf-8?B?Rktha3RzOHZIZWtER25mWkxUTjZ1TVIyZU1aUXFNT0R4Wk12bU9nMEZOK3Ey?=
 =?utf-8?B?UkRYM2JqS0tLRGEwK3dFMXJhYng4cElqeXFHZEovcDBEQVowcXgyRkJ4RktN?=
 =?utf-8?B?YTlwRXh5WDU1dmQ2YmFyaTMvdXp4WEtaMU1jR1hCMWdhYmVBZ3djcEdHN0NZ?=
 =?utf-8?B?T1RHdzJQZnZEMmlFOEdxOEllREFXWWJKUE9LSmVRY2JscmZ6a2R1VW5nNzdz?=
 =?utf-8?B?V0l0S0ZnYTNBL1JzL1N4MEZKQmxQaUp5Uko1RjdzaUJhaC95dzd4YjY2WVFY?=
 =?utf-8?B?LytVd2dvdm81clZZQWx4ZHVlbyszc1FveWFPRTNTM1VNRCtjcHhNR08vc0JT?=
 =?utf-8?B?ejNZTG1YZ0F2RlJ5b3dKd0xCZWk5b1pWNGVkbTJweG5ucm9HcHRwa25aRmVh?=
 =?utf-8?B?eHEwdkw2WVJlWURhK2VVV0cwZ0NmWGlIeXo3dVZteHI5YVNnL2tzcjQ1WWdh?=
 =?utf-8?B?OHhCZGFjTkJrRERNbkxkZmt1bjVTbEpGdGNVQlJmYmU2elFMNWl1d20vS0lZ?=
 =?utf-8?B?L1dzcHEwdytUdFV3WXQvQWFYRHBuYkFvRlhOK0plTytLalFpRVFhRlhDeHJq?=
 =?utf-8?B?RmFaeEp2RytSa3h5enczYVkzZkxnenJjS3NBejl3aGtpMUJFOW9HaitodGZN?=
 =?utf-8?B?SnhjOSt0cktQY0pUdXRVamh1b0JoRW5UWlJ5YzRWZXZ1S3d6VUxTcmMvbVRX?=
 =?utf-8?B?RHBkSlJRSTRoS1VRWUZ1bDd4NXN3ekx6T0htVGVJdk1XUEhUVlhFMDA5Z2p2?=
 =?utf-8?B?UTdhMUg2dTNiZHY4ZzdxS0ZGcS9ySjI4akdwNXB1YUIvdXozWmJYMGtHYm9H?=
 =?utf-8?B?VHhBQmtYd0thcll1TWkvcytxWHo4RGYwcmg0MEpaZlNjQVVONjNvenVUckxS?=
 =?utf-8?B?aXg1Vno5ZXgxSUdCZDdzNi82MmlNQm1lNDQ5UDZyb3ZKcEMvblpicWpmVFg3?=
 =?utf-8?B?aWVSZld4dFZacnV6c1g2T2NXL1dveFVFWmNjbUJHZDZGeHA0TGhEb0ZZL1lG?=
 =?utf-8?B?b24rSGRpWFZWdWM2V3ZpOVR2emVjU1pXckhJSXo5L3VpeHFKYzh5bjR1Q3h2?=
 =?utf-8?B?d2JoL3RjckFsNlVseTgxczlQSEplR29zN3UwQkp2eFFQY1BCRVFzYXAvWi9o?=
 =?utf-8?B?RVNMWk9MYUlYeFFBdk1LWlNPUnk0T1ZnaXllMnBpdFRuMWtCN3dvZ3RSbDNM?=
 =?utf-8?B?QmVjSlkyRW1ZTEF3aTR6d2trMHFnQWJaVE1mbmVVcmxMQklCc0FNVUtmMHU2?=
 =?utf-8?B?NG00bWN2N0pJR0ZhMTFRdEdhenZDb2hTd2J5Q29uUnBsZHdrSWVVZVpzN081?=
 =?utf-8?B?UU9lTnovcFY2Sk5oNkVmanlEdU9jbkFSbnYwbjhwWTdnd3poUFhYQnY4ekFS?=
 =?utf-8?B?NVFLS2RtSkhTTmlNMkRTREludjVZVWNMYlZpaloyZFM0ZzhFZVplelpNS1hG?=
 =?utf-8?Q?hGx4bixSq3fSC0Z59E/xGl4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc51af82-2a50-4a11-02bf-08d9e9182aa2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2022 02:27:05.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64CkOaEo0u7f9loe7/sC650n9kEPLfPCYEmqZQyMVsyngjpwWdwuES4MXvRU6la1pSRqmPjbHGJlcM4j1aHJ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2658
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10249 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=812 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202060014
X-Proofpoint-ORIG-GUID: Y4z4nldhKzu1NGa_ytCAZxffLjjFUglf
X-Proofpoint-GUID: Y4z4nldhKzu1NGa_ytCAZxffLjjFUglf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On 5/2/22 2:20 am, Greg KH wrote:

> 
> Can you fix the issues found by the 0-day bot?
> 

Yes. I have fixed issues reported by 0-day bot.
The updated patch set is at: [1]

[1]:
https://lore.kernel.org/lkml/20220206010925.1033990-1-imran.f.khan@oracle.com/

Thanks
-- Imran


