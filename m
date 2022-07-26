Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0C25814B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbiGZOAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbiGZOAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:00:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD86254
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRuLbsFFrv2I2R2OQ4eo9KLVbhuZIdaK7gKl//rWnz1QJME37y7o+WLwMPcLuaex8qlyvJtl/ZITHq6NWZefbfS7MRoj8qYJ6v+BZVSV5+v3mtAeOUeAmklzP4S/XTd4br/uh+G95RbqCeuGBcdYh+yVAdkBBb8ZipQX2cCITVW2FaXlmj5UNCiln+bQcKuobhModPbzd8VSmVNRIbQY7ddBr7BxKeohotK9me3KF+qttfvSlnsqNxc9j/nQf8K9f6/cWRdQhJNWK8O/PCDFGQZdaRYFyTx+uIgtBSzTn3uqeZOgeJzghoiIcrT4cht3mFnnqo7BBbEAh3lbuIQRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMsEOEgRkfe8XeThMr+RXdDLR7xaUnyXnTH+MYQFVVE=;
 b=dAAcyjTQBCE7AE4JB66NTM8NPovyaZql6koecPFrZ1wDZNa6CHBB13ucKNLko631dlJl4f+1DBgFncxxyakkHQUrhQsuvUS+mAK15wLuisCyWOW2AD02pEekXmHFhgJkhKtPaxx6LuwlbXquldS4GnHYv0FwWc1NQLTvft8QfGZrASByZzWCG4o/NMYH05ZY9spE7GEq1uEJt879syw4k/MnLGN7i7NQPK6EL/OduQnZHYLEsdrnwF4Sv16Rvy07K+CLr7ndMwGb3TN1z1XcTy8F8YbX7s8HTlxNGrmvbUcZSl2MElmlhRvZQbbyytc7DAr1mU6eVdRRwNiLHokegw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMsEOEgRkfe8XeThMr+RXdDLR7xaUnyXnTH+MYQFVVE=;
 b=5AwzQJufw9vtzRMsQOgN4eFpxC0V7mOtucr/wvKxh7AhDnwSYIA3Bw5yZsD1mR11EuVlWZSnwX+JvUyV+UaADP5Y0ZTpROpuIZWytIydrisLsAeeBeS1QYSe3CbcJ9MJbCWcXTVb7KV6AEoQryTZROcjpQHOYPHP8/UcK+0IJbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CY4PR12MB1382.namprd12.prod.outlook.com (2603:10b6:903:40::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.20; Tue, 26 Jul 2022 14:00:10 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::d4af:b726:bc18:e60c]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::d4af:b726:bc18:e60c%7]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 14:00:10 +0000
Message-ID: <d3d885bc-accd-f5a3-d760-f095c7bb1c0f@amd.com>
Date:   Tue, 26 Jul 2022 21:00:03 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] iommu/amd: Disable guest vapic logging during early kdump
 init
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220721003439.403435-1-jsnitsel@redhat.com>
 <Ytq2GRX7UJjvXk4w@8bytes.org> <a07eded4-c1d7-edf5-9c0e-dfa0c3373e4c@amd.com>
 <Yt+T5ZcvhGaK1e/h@8bytes.org>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
In-Reply-To: <Yt+T5ZcvhGaK1e/h@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1630a1-1d8f-4adc-4bea-08da6f0f277d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1382:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvOeFBxqJGtNgpbnvM41ZNpqmaxEQn6m8ldPQQnUwMfHjbk37Ti02Xg3Kw28EBqnsza49dXsjB9en2mPCTuyRWRkZ+ZDAWmy6BC+yi+50Fivy6u+i7koW6HtGnpe2ZGL2C2f/aA6GJsmJE9cqQapNg9d4XKBqMa2SjmNyuXYv4M3vUAC/TWqEMnCl2UJ657FbVpDleL18jP0R01UpETrc2jYQsDvuaN5MlsnBFOq90lmIJ7iatW0r8pujWF/SX+rWsB9zG4oRcmxkuC2PNWpksLbgTKWmM5s9nWhnMU9y9nj9GWRisx7bNUr848KFh5YgfQW9qFXhAVcq31TLTMVLB/Osztamnyyk1rIRF+n1+GBhTljYbFxLtKzl00I05o11eyAQPKT36huiQwDGE2Gdf6aeHVoqRwRlTcday85ThbX083ruOGxqfdlxt3ZhyRfZHlAjBTJ52qGFnU3qxd5ePNe4HpgMDe3BmoRJDjlqF76UPvG15c4+j5mcE8338RE77ILBTzgYwY/WdEDO5ViiGChao8c3EPSqjvkaBt27XpW0VmVJRy+ufjv7Rh/zF7Zd1BQtyk2Aml4trhv3PR32prSe90KyUbdaDFLo3K6Xvajs1FDtbbYn+VSpbasrYek3r0aveE8xKLPLBcfuxX+CK1N3r5EBG75GFTSm3ixnwaYt4XKvQipQ4VK3wMPASzroEd3vorUnaHxjcPaocUd9DZyUG5GpX4b7yRTrT4tiA5akyjwcj9qQfm0mJhKh6qZxyfCHUrteVj6fRA25i+TyzNfaMBH+PAWYQVxiNyTnRcF8KxZkexLgezMqgWZLnFJnAJ/tsm4X6evg3zDL8YQ0ZjmE74C8M2G5D0l3/k0fsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(8676002)(4744005)(4326008)(66556008)(6916009)(66476007)(66946007)(54906003)(53546011)(6486002)(478600001)(966005)(44832011)(6512007)(2906002)(6506007)(316002)(2616005)(8936002)(5660300002)(86362001)(6666004)(41300700001)(36756003)(186003)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azFmajMycXVpcllPTVJjbkNoWWdSWGxBYzNlMHQ5RmR6MFl6S2VsWTNWdDB4?=
 =?utf-8?B?Um1rV2c5Z01HYjA5RXgvckdLNHpjL0hWNklqcGpESVZBcjdBL3NKSC9tbzZ2?=
 =?utf-8?B?MXZ5MWt5RUcvL3pHOHpyaXNLeEI1K0UrK0puc09NSEM5bE9TZEUvNWpTYWF4?=
 =?utf-8?B?dVd4alVNbkFtWDBMdGNRQTdKZGRpTjJuR1FNQS9NK0NtU2FtUFhTZUQ3T3dL?=
 =?utf-8?B?RFpvRVZ0dktyeEhLR0F4QXN2VXMxWmdvMHhmMno2c1N3ZGlPcXQ3QVVtTkx0?=
 =?utf-8?B?YU92UXpvdjZVWHFTYlNzTDVYTXY5VkhuMDFOdnltMFhmKzFIRjVWTWdhL0xa?=
 =?utf-8?B?OWlOWjk4dVlIRjlodmtwak5lUzdQMGpvbDlRYTFtTFhiRTJtRThJclZ2dGFC?=
 =?utf-8?B?RS8yV3VXZDBVc1J6L09RdkNYQjVIQjRJMWhWN1FySTBBMDNpMDl2d2E1ajVx?=
 =?utf-8?B?aDVicVRJRXNsVXhzMkxRR2orQWUwVnJCUHFtcVJSbDVvTTJnV3I2K1ZHWjJs?=
 =?utf-8?B?TnVQOURDNEFLZHI4c2pWNXZiYjRqZzk0aEpmNnJuMUhVOG9jTE1tYTFGV3ho?=
 =?utf-8?B?Vjd3RWsvUTl6anRReFR3ei9mUjc2UWhoN0pJR1NDcDhhVjlTczRsNFZGZmVE?=
 =?utf-8?B?OWFGOXcxaWhrMlN0ZWdmcVJWbTdxOExFTE9FUXVDbnZtT2VuNG5SL2VXTUNI?=
 =?utf-8?B?QTRxUEZEWXVRVUR6WUZaOUFTR1JCTEFoVSthazFuSGRNT1lDT2wwcGdMdFFF?=
 =?utf-8?B?eVE0dWx0a1ZSam5qK3Rkd1paSElmVis4MWQ0NXdRQXdlWDh5TEhSTXp6b3dj?=
 =?utf-8?B?SWZDK3NFczFldkJ0eVBLVG5wUkNhZ1JmRGJVUFQ3VG1BZms2bjVqOU9oQWVZ?=
 =?utf-8?B?WlZaUW5pd3RlVVNLeVNJMERmWnkvQWdsdGNBNFV5OTNrTlV5ckwwOUhkS0tO?=
 =?utf-8?B?cU80SVR4UHI2aG1sUURUS3hXR1h6aHppNjFMRGUrQU85YWNOYmwzUllhTVhl?=
 =?utf-8?B?MlpDZGEzQnVCWjhVcFNsTVdZUGFUNkpBVm42NzFpaGhGaG5vRkhGRzJ1dHdj?=
 =?utf-8?B?eXBkYlVYNitRUnUyME5RM0FBTU5kbG5ES2U4TjVJOTdtSVhYdjF2RytaNys4?=
 =?utf-8?B?eHJ1YXQyUHpMMXBIZ0J1eGh6MDZBRmYveXhmK2VYdzdVa1hvL0VwMzYyc2V1?=
 =?utf-8?B?U0tTKzJ3TSsvMVZVNVVxQlkvWlovK2g4dVFpdUF2TVp1ZjhuNEtFS2hRQmFE?=
 =?utf-8?B?SzA2b3hLOENiU2ozOFVsaWJ6NmpWYWZsRDMrQmZIN0oxZWhESUZXUzhHSlNC?=
 =?utf-8?B?QXFyTzFGRE50RU9iVEpFVVpub1B2MDNUR1NMU0pHaU9QZmR3MWp0M2I5ekZm?=
 =?utf-8?B?N2lYYzAybW91a2RzRjRYM2ZCcHV0ZUsvVnBhZWdvWFZsOXhKbVBIN0h3SUJ5?=
 =?utf-8?B?OGY5SVZiVS94cEVWNEJaZzRNMDJiRjV5c0RHeW9qYzNvbXJUTE5kbDk1R0xz?=
 =?utf-8?B?L1VFcFEyRWlUOXBzSVNONGMxZ0lLYk41TmhvcDBLTWVUMUw3QjlJUjVpN2VE?=
 =?utf-8?B?R2FRTWZOcERvbE4vM2dDMEFaS0MyZFhobE4yTlFTanB1dlFEYjNDVzh4Y0lI?=
 =?utf-8?B?c3d0U0NiWi8xN2VoRklMZU9oekdSU3dIUkQ3M3VtVzg4ZVhFMUxTdGZSbEFJ?=
 =?utf-8?B?N3hML2h6YjNHL3MwQjAwN241WmdtUDM3Zzg2SnMvZ1pQcENyZjA0VWs1dGdO?=
 =?utf-8?B?a09yQTVjcnl0ekcvaGhvbFUzWXNRM3ZnOGRYQzFrZEh6NTNWYjFpdS9ZbHhP?=
 =?utf-8?B?ZEltNjl0V0FKSDZMQUhQblJMYUJjRjhTbmhSTDlJRVordHNkd2pZY2ZGWTQ2?=
 =?utf-8?B?WXlmS0RpZ3VDZWpUWDMwMUZ5Zmc4SmIyRndRT3dGVUx2Lzk2a3RkRFdsdGlB?=
 =?utf-8?B?UHhFd3JUWmxad2dxdHBJSVBUL1ZtVXF2TUdxckVPOFgyVE84VGRzU0F0Y1Ev?=
 =?utf-8?B?YlpSK2JnblBsOEJqa005SVV2cnFOMnRPRUhuQmptNE1GZytEWlkyZjNjQlhU?=
 =?utf-8?B?MTZnd3hNSHEvbmZLNXQyZDc4VXhJU216Z3lVYnFRTVEwTzlTUjFmL2ZRQ1A5?=
 =?utf-8?B?bTlUSkEzbTN0dlBRT05ZcllyZjl6SHRmMVZpSnFXZVhkUDJ2NWY2bkZ6ZDFj?=
 =?utf-8?Q?zUEptl8GO6DjBgjg5leWMewK88fhBM0fQ+QNC24dl9zi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1630a1-1d8f-4adc-4bea-08da6f0f277d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 14:00:10.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUUIquUZEN7Ju0X2sw2VXRNZXfyvCjZ+fjr60FZ4tRyHCn5ksFNC0bHxQS8waaD0F1AhJYNOQcONr+fOyXTV6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/22 2:12 PM, Joerg Roedel wrote:
> Hi Suravee,
> 
> On Mon, Jul 25, 2022 at 02:05:59PM +0700, Suravee Suthikulpanit wrote:
>> Sorry for late reply. I have been actually working on the new GAM and GALOG enabling code,
>> which should also address this issue as well. I'll send out the patch soon.
> 
> Okay, how about basing your changes on Jerry's fix? A backportable fix
> for a real issue is always better than a bigger rework (which can still
> happen on-top).
> 
> Regards,
> 
> 	Joerg

Ahh... I have just sent out the new patch

https://lore.kernel.org/lkml/20220726134348.6438-2-suravee.suthikulpanit@amd.com/

Please lemme know in case you want me to rebase this on top of Jerry's.

Suravee
