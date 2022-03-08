Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492944D22B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350269AbiCHUgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349986AbiCHUfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:35:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA7522C0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:34:57 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228JlRXX018600;
        Tue, 8 Mar 2022 20:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UGMN0SyJpc+PH5wPfmAFhq+VUsh78hfF05xbPXftKbk=;
 b=eztjSeWQUfRGKjBSsJx/JgeH4iO/SwZ69kXiyGXaKaFU8g1pBz7iI12rgCD3r1QN87px
 xggTUhEXM0YWx8myldz2ZWI22tZOuPTFmhzV/kjqMB0hnhtek60pZif5MW6RMtFfTBrQ
 /Tw7keLTiMG7UzvCxJoDU1mRJKd6RJ0gfkQG++DdUCN7DsM5k73Qrt1fj5HoC5KQGJQf
 0TNiuWWrRW0YfJkrGA42TKBbogRK2DA8Hsam97q3dLXLcQRR4aMXBy3olcAxpZx7kcGI
 4U2TaSijv/4T/v1kitY/dgeoxdEnqcDkDkeGfiJotm0qYYfS+v9uInuwRXtGDGdJkl7g 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2g74d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 20:34:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 228KHC9N084522;
        Tue, 8 Mar 2022 20:34:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 3ekyp2j7s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 20:34:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wx6NAoSr7l9Pjj2tc1KYumHenYWb6RGWP5AiWC1F0b8T0xUIGlc5o/oDS/uuNxTDGY9jAYehtQg8YV6R/TKD+kPlC3+hobFmahbnRHmTn9Zptt2WIlkxy6Y+eUCr2kPyt4fV1avFu8FDFWto4KOAZGcZlBgTZ6/1v2dQ03tMCdMvID+CoXEkZd9INKiFr3mSWiH2Lq9vKCf6V5f+lg4utOX8rZTcTnaVw+Wh19QnJgjaaXUkZAL7LoRk4a2BFXwwCj4jxO0iwyuCVSp5p8yDCWwVeQVbUCgQDOHm9vy6pDpaiOwOwnhhgEoU5XW18gT1i4yOD3nVALBsfnRYu7mNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGMN0SyJpc+PH5wPfmAFhq+VUsh78hfF05xbPXftKbk=;
 b=n3gmbLyrevzVgVvwAIAAtOcv6EFWiFWKxlLsMeMVpg3WIJaeU05ClC5AIPXaQ0wHwoRvdW+CaTjl/zOZZN0FVZ7nDtP16SysAPjiXApF0AmnAfl0ALgLEAV77g2uRh4wQ36lfrMbxW1Wh36KCveEtttg0/zAIjbbFJ/hGHP3PJtiCCir+mxbiX1o4s7CsFHAfHMR4nP0DIYs+AzHHODOnv/kqTezoCKSMeSheTHzTAeKt/IpQ+CKT4ZgjxRDt20/4mitOnXYVPSFj05vHv1k5O4YvcOTRd1OYLZVuT2bySHZ8IJ56C8h+bUT2Jfpd7oOdDbxLcItqb8FFQePuqbypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGMN0SyJpc+PH5wPfmAFhq+VUsh78hfF05xbPXftKbk=;
 b=YGjRGHlXOUHveLo9wyk2+Mmoh0/koI5XMg4i0lDGVehPc60/XIK2ncRDFzF+2JqTGXm7Uu0yiDF/Z7HupMqi6Oml1a3jlYMGtHvjfOiFROPVWK/R2l/gh+laWrisie3HSBX13+J4STMkObEObcYSs7Kr5rO6biEorXjbmaU3gLc=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM6PR10MB3913.namprd10.prod.outlook.com (2603:10b6:5:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Tue, 8 Mar
 2022 20:34:26 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a825:7455:e3c8:3b65]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a825:7455:e3c8:3b65%7]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 20:34:26 +0000
Message-ID: <ca174698-3790-7ed8-fbaf-674d547d4b76@oracle.com>
Date:   Tue, 8 Mar 2022 15:34:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/2] x86/boot: Fix setup_indirect support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
        Daniel Kiper <daniel.kiper@oracle.com>
References: <1645668456-22036-1-git-send-email-ross.philipson@oracle.com>
 <20220225211730.2oxumw7ixfe7cyoz@tomti.i.net-space.pl>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <20220225211730.2oxumw7ixfe7cyoz@tomti.i.net-space.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:23a::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e13fa15-1e80-4278-007b-08da01430966
X-MS-TrafficTypeDiagnostic: DM6PR10MB3913:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB39133BE5C297FE5CE49F6A7EE6099@DM6PR10MB3913.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQXuf3plDXh/IjBUH5295gU2uVf3+Io01NsVyJOEUWeHNP8KTp/KYjCw0eciyWX7Q+RCMtoHPGRyP3daccMHVzc8fyb+5ot79XPwdSSCRY1AeeVh1mSdosOHTWIM9qw/3WqXMdYCCPmTYjjVucO3ZJpvQrn7iGAQLjlEjKLg6ttparm9QRWu9h4rXrw4PovM+NXO8C+Rae0/zcYZy2vU/UgIuF8PXX47gUczRfT3Xasu6C4NNF/kgOQQcD75mKtopjySTUaBFer3HpQYcd16FT5JqGrOsZPhITD36sVwL/8aANTbQ35oIxc5IzJr1/LbdFgxUq9Uh2gGYDu2+0KZ6JFPZV5QVJDtUVojH7c6KXwA9BpwbxmWkP79lxuWdB8h5LuSxh8muFDWbI9rUN+YxI7lg3e7QLlrWFKTaD3z4R4fX1KHdIxCO8MievIuzSSU6CwlGMi7BlAmIy/6pa2RIr4+rRfzybhMwaAtSFGMUoSoMHl034fo2XzDgyuBmQsNewG9/3sD2FBGfvhWyNVfGd5jxvpuO72oXI6qw4b1ZOQoX57Vc+qc3RLzHYthhfGcZL3iL6gzNNDauMThIMub5HWDkrMMgxZ1Ad3aV2xLRk++kLutmXul2dO7rnWY/xB4xnp4nVn36SHgBl91PgKT7cTg0HCy3+x1E3XDl8UHCaSpSxIz5P/qLOgQ+SMr5JWwuyxnqypEU7vpVopIP36kG6hPX1/SLkAQUnJDa2zwOF1q101s6nAUoUMfRiCxlELL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(8676002)(7416002)(4326008)(44832011)(2906002)(31686004)(6486002)(6512007)(38100700002)(508600001)(6506007)(66476007)(107886003)(6666004)(83380400001)(66946007)(66556008)(36756003)(31696002)(86362001)(5660300002)(186003)(53546011)(316002)(6916009)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXU5cS9tTG1mSjA0QzNIOGswbkdkSnBzNDJkWXRKelc2NDBOZ1Y1eEJKSkFt?=
 =?utf-8?B?emFnM05jaE1jemRVRm9JRVFXbE9EMjR0RllpdXZLUktLNnZsY0JqR3hBTlhi?=
 =?utf-8?B?WGVLQTVFMm1tVjZEc1A0RndOazJ4aStxZGdCQWhkWjJLMzRRNmxNNEFVMWZh?=
 =?utf-8?B?bFYwVFpSV3d3WXpCSUs2b0dlVGdhczBuc0pQOGZFcGg1N1RoRDNQa2VtTWc1?=
 =?utf-8?B?WUVpYzBsVlpJK3pSU3JVamhqa0VpZWFldCs2enBZSlhkdzlPZ1dxVTY2bldy?=
 =?utf-8?B?RlhWRFdvWXRJaG8yaUN5aGFaQVprWXpEdzNLWGdXWUU3Q0FHaDBpNXROdzZT?=
 =?utf-8?B?dTJSSVZGanluWmRJZ01SUnd1SUdXQlNaY09pU1JSSklONEVKZHBsc1NoWU91?=
 =?utf-8?B?VXB3em5vSUp6QXNCcTRuSEx3YWZoajBDa214R0JuNDZ5emVaQnp0Y0h5SHB4?=
 =?utf-8?B?TkxucERhVjFHOFZJTGtHYjZ3Um4rZnlNc1ZkVXJBVkxFKzQzVzFOZXI0OUNZ?=
 =?utf-8?B?RU1zcjN6NU10UHFPZEtrZys2Q0F2OUxXNGFDUVZuYU15d3UwZlIveEkvRDJ3?=
 =?utf-8?B?WVlMaVpRTjJnbEZEWWltckxnaG5rNEVhTjV2bjU0bkVVcmhxTERnRHBmTHlT?=
 =?utf-8?B?bjN3ODZHTW5jV2cxN3QwdksxS0E1eHZ0NUhScjcweGdjT25JOWh1YUZ4a0Mz?=
 =?utf-8?B?TWZTQzYycVlZQ0RMcGpRdVFMZUwwOUNnK3VsaUlXVXRCZXJuWUZYUngzQU5Y?=
 =?utf-8?B?cjZjcjNZTGdPNWpTcmlZYUZ6a1ZlVVBMLzZuVTN5SjIybVY0UjZ5a0lRKzAr?=
 =?utf-8?B?UkxIUXNYUnJXSEt0bWJjNTBYRG80cTcwcWtESEs4UEhFRTJnMFZTd3JYSGlW?=
 =?utf-8?B?Ny9hZng5Rkd2bkhIZXl4QnBjMnd2OHJLbkNMSWVDYmxWLzY1WE9qWlcwUzVW?=
 =?utf-8?B?T1l4cEI0QVRPOURYaDNHTERCSHZuV2xCSFdrQ0h4U29Ic1I5UE9ac0ZveGJx?=
 =?utf-8?B?cFdXcEdvN01ZeGxCeFp0YVlXRTBMKzhiUnhGSmcxRjNpUGZrYkxlRCtFc3l3?=
 =?utf-8?B?cm9VbkJWZjlWWGhQallxQ3paZUhvY0ErK0RSL2owVmg5dGJ1dndSZWNmSFhJ?=
 =?utf-8?B?b1lLeCtIeTBUdldKd1U5ZkNrdGlweE5nZmY0cjdKODBneERlSDlNVEN6VnZG?=
 =?utf-8?B?QUtWQ0dWZjdTUGQwRTVhWGgzcldOSVN4YVAycUdXQ3ZydzRYbExLazc1Rytx?=
 =?utf-8?B?UFFiVTNISXg5ZEk4NEVQaGFsdWlNTGhZTjJ4bDkyajN5QU10VkJzeG1KRlhQ?=
 =?utf-8?B?eHdvZ2VITjNXcXFlNVU5VzE2UDVTbFZkdUovb3NPNGxBNng2bWI2V1BPNlFj?=
 =?utf-8?B?dDd6WHFBSHBZWUlyUGh3dG52NHhBZkxabDFyOXc2aWFBbHdDblcyM05mbWpO?=
 =?utf-8?B?TTFTam8xZmN4TzNKWTZVakhiS003cFZQZ0t3SnNuaitQa2cyejkzOWVMelox?=
 =?utf-8?B?Uzh0SUQyc25yemxMeVJOWnA0VEJWY05qcjFRdkQ5WHhGNGFPMFh3aEpqTCtL?=
 =?utf-8?B?NXByNUhqU0ZNL0VXNTU4aVZPdTFkQVAzZ2ZJLzI0TEZFQkpnQ25FUS9MV0cy?=
 =?utf-8?B?dEpFcDM1cTRXUTJWUDBTYURTY0F6N3FoREdJZTJoRS9xdDJKQXBFRzNjb1VP?=
 =?utf-8?B?OTAzZkZwV0hwQVZucGRkMDdWMVZ4S1RDTloyUTljendYQUx6dzF3d0MzUWFE?=
 =?utf-8?B?WU44djlFM045UEQydjhObE5aL0haalZpOXBFNXo0VncyVmJ3ZTBUU2hXKzRX?=
 =?utf-8?B?enRsWFl0UmszWHRoODZZbmFZcFYvWElrdmhpdlB5S1V5ckJuUDQrRVRKWXNJ?=
 =?utf-8?B?QWU3SzAvUll0czVOQW5oQ1ZmMHJraVdYNG1JZ0c2NkdmWlJ0QmZFbTdIZ0p2?=
 =?utf-8?B?Q1BBblpDYXJlT3pMSWh6TVFBVmpWVzhDaFJGMFZNTGFaOFZqNVZaMFlxb0g4?=
 =?utf-8?B?WEkvZWlZMk9VeGExZHJENkY4bWlxL09XNmFRQnoyczZ5VWJVRzZxdUF2UnFs?=
 =?utf-8?B?T0FmamY2MFRXa0hPcHJybkx5VVM2clRueEFTYk5VNE14bDdPNFZVNndRbSsw?=
 =?utf-8?B?Qy9SbDdZemw0TnhoWEY2S3pZYWVqN3pDSUdzZkdoNzlhTFU3K3dJU3hCVG45?=
 =?utf-8?B?UEpnekE3dENsR3ZVYkRPbGh5V0tKc1h1U0pyOFZmOEJFdEpHVmNhWE1lKzNs?=
 =?utf-8?B?TEZKTGZWUEJEak9tUTB3b0lZUUlKa0Q2MzM3eG1HUDBLeWh5LzRiYXdrVm1E?=
 =?utf-8?Q?/04y15mdWXP3KA5P0T?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e13fa15-1e80-4278-007b-08da01430966
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 20:34:26.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADagEftx1d0+Olk6LtgmiVfJKJLVKZmKPInLdA5kOjzCC9IcRa4Hdh5xLo4GMyUGSnsywQ1HM3evkHPu3nUWVK/duUu2x52LbWMC4ZDt2y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3913
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080105
X-Proofpoint-ORIG-GUID: Xxh5o5NbgP1ZaQUsV5OfptSuFCCmHlvC
X-Proofpoint-GUID: Xxh5o5NbgP1ZaQUsV5OfptSuFCCmHlvC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 16:17, Daniel Kiper wrote:
> On Wed, Feb 23, 2022 at 09:07:34PM -0500, Ross Philipson wrote:
>> The setup_indirect support for x86 setup_data was added in November
>> of 2019. Several issues were found in the implementation and these
>> two patches were created to address those issues.
>>
>> These patches were originally posted as part of the larger TrenchBoot
>> patch set but are now being posted separately since they can be merged
>> independently of the TrenchBoot work.
>>
>> Changes in v2:
>>  - Add checks and failure modes for when early_memremap and memremap
>>    fail.
>>  - Fix variable declarations to use reverse fir tree format.
>>  - Use local indirect variable and remove all the inline casts.
>>  - Misc. fixes to the commit messages.
>>
>> Ross Philipson (2):
>>   x86/boot: Fix memremap of setup_indirect structures
>>   x86/boot: Add setup_indirect support in early_memremap_is_setup_data
> 
> For both Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>...
> 
> Daniel

Borislav,

Sorry to bug you. I am going on vacation starting next week and I just
wanted to get an idea if v2 looks good for merging in to you? If not I
could probably get a v3 out before I leave.

Thank you,
Ross Philipson

