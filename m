Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1164C9566
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiCAUIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbiCAUH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:07:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4807090A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:07:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221J0e0U032600;
        Tue, 1 Mar 2022 20:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GlAgknVKg9T0TSWPNLBUjaLcsJjOO5mLa3D3kRVz+yE=;
 b=AUev5CTRl8jHIKUntzwDB4Mag9cy0X5c3ywrhxoKRcEF5KOO25w3uv9Gn31DRojqGTkn
 Sp9RXyk4dLveWK6OEXJpcIgfcMUg2cta7fC83iiPnhvSHuqpqCgSD6xOqYHhMcngheYI
 lnnq9EoPsp/SrO8ts0717JN2iETuDH4b2ImtD27DqS8YId7wzcD/0HLhpRnyaIj+dbZ+
 K7sd4GNEq36h7Lu68IDjXhnejqys2oLdlEqpSRGbZfygD6mpMz46XCFP4RyDVoRH+RNd
 i/62N2dsrjSeNfPwwaiFTeyRUhuG8gnlM79LZACIcHyLTQocbtIn2QU1Uo3VwBd3+B83 XQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehh2ehpx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:06:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221K60vw034192;
        Tue, 1 Mar 2022 20:06:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3030.oracle.com with ESMTP id 3ef9ay4r43-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV8PJTA6EeRKgX+/1hcUDCV+AiozGW31lJywnyLwNEJUneynSnulqsF9ZsVMI826vKlbej+RML5eRzzfRRzEjyGYK/Akv5Wha2wA/VXqUGrk3yCEXlpcaGf8wQKObnkgWt/AkcBNrfrM4W6ovYPOASTh21r9LuVVORLsUH9ccIguOuicQzDoZVAl9w31guVspFmWnj6LjtaH0uZStO2RIac4SZjSw9gvW1WO0avzBueEmlSd/74blR1TepKpR2uViWg+seVedUh3rlr/YNp9fHHDLgcBTSl7GOdcbddO31IkI8rdGnljjWLWc2+inZ7dn1LV+1bQtb5rXzhn7fJhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlAgknVKg9T0TSWPNLBUjaLcsJjOO5mLa3D3kRVz+yE=;
 b=jw1klxeGed+g3GdaPGbqn3d8+EsMl2cGfCGigTS5UfEAg8cFf7WWzQLjegv9sDY9KqFSojop7SqI+d02bdkxjPjji7MXfBKJe9oFisQRi29gq93gqE+LrW/PkPaKyzd/lFls4eAwpt+EbYhjTBm/m6T6wtdE/z+hEBiNj0IYJGbYk2eYQxk1fsKnJm1I0v/qsXc+3o/fZmgKq4K1CvNeSs4nvcfEmBvhbPE06CgVsn1MN7wY10trhDrNr+IQj3Lm4LG6Rwz2ivDnxNO/0QAyznDYa7J2sGpJMwCapp1hC+LczmfIBXkKhvDKmBPnTK9AZ/0vG2LBbhdGb/7SnaRvjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlAgknVKg9T0TSWPNLBUjaLcsJjOO5mLa3D3kRVz+yE=;
 b=AYT6HRbqUJf1zsDo5KtuJz/DrQIjwkUqt2uDnW3GxNGHMNfmIngcYsBlbjalkWNB2UiqaxhRupf4MJD8nSYFAaAMnwt/Em8f1DOHnuK/dJxR9SEpw+zJFCHGZoyjerNewKOg9e4EXeQzkQUdiyIYsdMdpikp8tf7e2NfiqO0pJ0=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by CY4PR10MB1415.namprd10.prod.outlook.com (2603:10b6:903:2f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 1 Mar
 2022 20:06:51 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 20:06:51 +0000
Message-ID: <658cb684-5250-6acb-f3d5-308456d81938@oracle.com>
Date:   Tue, 1 Mar 2022 14:06:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 05/10] crash hp: introduce helper functions
 un/map_crash_pages
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-6-eric.devolder@oracle.com>
 <YhWwyTZuXxM4w+Fu@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YhWwyTZuXxM4w+Fu@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0203.namprd04.prod.outlook.com
 (2603:10b6:806:126::28) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dbc10f0-6987-4bf4-2792-08d9fbbf0673
X-MS-TrafficTypeDiagnostic: CY4PR10MB1415:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1415EE1D5020BB0EAE296C3A97029@CY4PR10MB1415.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ud3EQ0XUyWnfZphiAYUr3JrUx0kUmgIlugg7V1Qyr8ckXTNMyagRm3hQYHrtAOp7qTffvQaELYB0zr4FkTX6iUzWrbCbjUuVsFXpiDIH+s2kGE1uh0gCmZ5CU2Tw8uDEEyr8o5vniw06BCh1dQqkV1+l4xVLLeJAMVrQ5tCQya3SCxc7Zm64Yp+tpMly8ROvIKIyn0SVKa0bv9/63kN0FKUY+CcgB9NcbmO6uOBVynBftlaDxGhvyyUAddRMtiOkaICXN29L3k/UQXDNYXAsf8v95B5g/pzKJG8n3lDsRJzgbx5J5r7KVFdSV2huCRLpbJeSdev0VxTuWIhpIx/XjUGJE11dHsPTglgGUpj5zskMSitWM/6ug5d3vPucFkalAQ99jMvCsWx/UbrJme/4f/XBr57kvnj4aeO+KKoFsBFtUaEH2JMCA3N1kK8eYbd8+e4GM4UxPS3SBYYmUKFmwQ1BJMCFYwwv7+g31BtGWtNBX8ZO+AYankr+i8mEAxbwkxQ3ZOGA3DwuXMvie6KooqEUvv0xBltX6n2ZtIrRQzPDJjKeqFPnyWP+xWWUYdmsu8TJrLmrRsgR7jl4aEX2n8KkvXNZpLpfNynXYrjesnCewspl46DtDzBRcfHgoEOmg7enLAHyNTQTAwFJS2zQb5enbJFgrZCieKrNZqufK3uTrvfToikXEabEVrxtxIc6oN80BRgg88t1t3lX6IrYxXQ9SZCL2zr+QKPjV294MrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(2616005)(83380400001)(6916009)(36756003)(38100700002)(6486002)(6512007)(31696002)(86362001)(107886003)(186003)(66946007)(316002)(53546011)(66476007)(8676002)(5660300002)(4326008)(2906002)(6666004)(7416002)(508600001)(66556008)(8936002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU1wRkJWYUhVdXUwVVVqZnVIdXVxSFVNYmx5T1pNd0ZaR1FOZ2Q3Y3djeTR3?=
 =?utf-8?B?UU5YeXRHY2txakZkejJCOHhPTjZHWkdzZFpnNDhScGhZbHVGQnUwc0tGK2hB?=
 =?utf-8?B?TEtqVThRbC9kTkFDQVMwdUs3MkxlUkpFZ2h4OW1aSnhGRUFKNmRNTHRZbGdC?=
 =?utf-8?B?WS9ad1BHVVNjOFVkLzdDUnpxeU1ySVZhOFluTXRzZStiSWp0aW9zZHhoVG9n?=
 =?utf-8?B?OTZ6d0RCcFZHVUFQR2FydVlYK0Z5NWs4MnhYcGMzZ0h0d3R4NXUzUGtObWdF?=
 =?utf-8?B?dW9KK1hUajBaNXFrOUJvdEJ4NjBFa24xU2xuR2tFRU9JemkxWnBwL0Q1ZEZv?=
 =?utf-8?B?eU01TDdvcVQveXBhYUtzN2s5dEMzTG45STdWZG1McTBLbVZiWXc1UmFRenRG?=
 =?utf-8?B?ZC9DTFBPcFVGQnd6NEFZQ3NheGJPR1F6TGNiQ2N3WUw0R3ZsRDRkb1AvNHUw?=
 =?utf-8?B?YW5VQ2hqZ3BYMEpoQmdzVTM4bUdTVDIzOTVpR2pFOW8wWVFOWmxpVUY0cU1s?=
 =?utf-8?B?NnFRbmZjVmErVCsvRWMvQ3FzWnV5aGdGYzY4VmhIdzB5djhranlZVHJtbFo1?=
 =?utf-8?B?U2hVbFBYOTRFR3hvL1JWd3dDVzA2bVh1dERHcTRuYnhlNjV0dUwyYTJtdEFZ?=
 =?utf-8?B?aEV0aGJwMFhmcDJsTTE0RXRXU2FuNG01ZlR1L0VzNUNHRVRPZHlGcW53Um1J?=
 =?utf-8?B?WG1IU2pJZlVteTFkZVVCbndEZmUyM2lkMlFUOXY1T3F2V1R4cVorVFNSSVZB?=
 =?utf-8?B?bFFsU0M0dUpNeFRhTGZTa01ra1JGQU16QzRRL1VmczlLcm1jaDlwMzZZcGNa?=
 =?utf-8?B?UmU5K2o5L2JWcHpIVmwvZWtDVnF3TmRJYVoyLzdjbmNYdVNwaFEvN1I0c29l?=
 =?utf-8?B?Y1VET1Q3QzR4MVRaY0NBUTdlY01TQnBiaU9lV0ZmMlA3SGZUazBIeXV2a2RK?=
 =?utf-8?B?eEk1WHVNTjFxVjI3Q1YyeHRnbTFMUk5HSVVSZHlqUEYrQmpkZnBtaEE4OEhz?=
 =?utf-8?B?RTFXS3JJUlc1MEJiNXBTMnZMeExwWFpSTXhDK0QvYVJ6MUxveTE3bEdvdUgz?=
 =?utf-8?B?akJ5Mkl4TUwxUGEvK1RHUWtZMmFLd2RjNGExQk1wMTBRWTBmSjUxNFQ2akR3?=
 =?utf-8?B?YkJyUTFOVlg2ZFR3SHBmZ1RHb0F2eW9USm9BK1JqN2U2Zkd0NStFWStUTGp5?=
 =?utf-8?B?ZE1EdXUrbkNtb0V5eUc1TWFLNVRHWUVPaUkxMFNHL1pGLzc5bE9zQ1dJenc0?=
 =?utf-8?B?SEp3Q3Vob1V0L2dqdjVLT2pGbFlvLzlURHhhSWV6amxqcTBmdXgzWE9Hd0d2?=
 =?utf-8?B?Ym9JWGVKRkZQV1VWaXp2NXZYemJXczFOZkVJM2lzVXdWNVZ3ZkZrNkF0bzE3?=
 =?utf-8?B?UEtab3dqRDNlTzZZZVBNMWQrSUhaVUJRNTRhUlBFcldjcVFJZ1dYMFFxVk5I?=
 =?utf-8?B?alVITHVIT0NpNVpBS2htcWxEVWx2Y3psM2lydU1yOHZrTTNXQ0svN1Ryc0Vp?=
 =?utf-8?B?K0hLdDlpZmlYUDlwRnY1UTZGN1FuRVdpVTRqS294b0dJOGx0RTY3akhVUGZG?=
 =?utf-8?B?bDBmekRYVjJVOVBJdWd0RW1peXVKSmFhMGladkoxamJUakd1RXBJWDBUblVi?=
 =?utf-8?B?MElYZmFSbE1WdDhHcXBPeEcvMFpPYnNFRFFTclhsUGtNTkpBQVh0R01OclJq?=
 =?utf-8?B?MVRIN0s0d092dktUaGJlNXh6NEZPOXNGV1FRUmJEWUlPODZqQ2cvd2ZZQU5x?=
 =?utf-8?B?MDBDa1h6MFA1Um8yR2orVU5oUFhEMUtHemw5YytTVnh4WkErUjN6M3oyZnoz?=
 =?utf-8?B?UmZzUFJjSFRnU1dLYTVMLzU2RklYbGNMRG1yZ2hraXp4eEVpOWlCOXdiRGpo?=
 =?utf-8?B?OXptTjN1R0ZOZCtCcFBOL2NIK1JCTEcvaUs3SkYyYlJReVI2N3lmcTFtbG5I?=
 =?utf-8?B?ZWFBQm4xUFN4dlhXUngwcGR5RFNadmNYNmhOLzVzUys0YnhudllhNFB0VnlU?=
 =?utf-8?B?VEUzMHNIN0lRc2RRUUZybE9sd01hdmNEOSttSFlUOFBmSVZYWE1EN0s3bWxY?=
 =?utf-8?B?bWtmMVUzaVdvcnIzeFJCNmdqUTlhN2lqbUExZzBoM1hxSzJjR05ZOTZwREtD?=
 =?utf-8?B?L0c1SHdOMUdKdEhQeGUwQUN6Vll4SERTMEZPUGdwb25SM1R3QUNZZENYeEFL?=
 =?utf-8?B?aFErQ0VMdENqNlBnbVcxa2dWWjN3dnJqRG41RVVlT0xET3Qvc2FiRTlvdS9D?=
 =?utf-8?B?Z3A4RncxYXpBb1c2V01RVy9MeENnZ01keWJadUMyS0krRmZMdmZ0LzQ4c1Rl?=
 =?utf-8?Q?Lp9if9P/S1hKMpKN46?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbc10f0-6987-4bf4-2792-08d9fbbf0673
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 20:06:51.6889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3n40J3IJ92nd3zfugCtjIz1Pm2R8MzQXkg7NEaOKb8BOTrs0RhPBkatXieqKBHNk3JSoP8PClPaA70767x3eRE7mZt5ggf5Bqtjm4kZmJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1415
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010101
X-Proofpoint-ORIG-GUID: y2Rbj7UY-oJz2AdcmB4qEDtMmWMOGKw8
X-Proofpoint-GUID: y2Rbj7UY-oJz2AdcmB4qEDtMmWMOGKw8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 21:58, Baoquan He wrote:
> On 02/09/22 at 02:57pm, Eric DeVolder wrote:
>> This change introduces two new functions un/map_crash_pages()
>> which are used to enable/disable access to the segments in the
>> crash memory region. (Upon loading of a crash kernel, the
>> crash memory regions are made inaccessible for integrity purposes.)
>>
>> For example, on x86_64, one of the segments is the elfcorehdr,
>> which contains the list of CPUs and memories. This segment
>> needs to be modified in response to hotplug events. These functions
>> are used to obtain (and subsequenntly release) access to the crash
>> memory region in order to make the modifications.
>>
>> QUESTION: These might need to be in arch/x86 as I'm not certain
>> the implementatin is valid for all archs?
> 
> Since only x86_64 uses them, I would suggest putting them into x86_64,
> near the caller.

I've moved these to arch/x86/kernel/crash.c within the #ifdef CONFIG_CRASH_HOTPLUG.
eric

> 
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   include/linux/kexec.h |  2 ++
>>   kernel/crash_core.c   | 32 ++++++++++++++++++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index b11d75a6b2bc..e00c373c4095 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -324,6 +324,8 @@ struct kimage {
>>   };
>>   
>>   #ifdef CONFIG_CRASH_HOTPLUG
>> +void *map_crash_pages(unsigned long paddr, unsigned long size);
>> +void unmap_crash_pages(void **ptr);
>>   void arch_crash_hotplug_handler(struct kimage *image,
>>   	unsigned int hp_action, unsigned long a, unsigned long b);
>>   #define KEXEC_CRASH_HP_REMOVE_CPU   0
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 256cf6db573c..0ff06d0698ad 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/init.h>
>>   #include <linux/utsname.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/highmem.h>
>>   
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>> @@ -491,3 +492,34 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   }
>>   
>>   subsys_initcall(crash_save_vmcoreinfo_init);
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +void *map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +	/*
>> +	 * NOTE: The addresses and sizes passed to this routine have
>> +	 * already been fully aligned on page boundaries. There is no
>> +	 * need for massaging the address or size.
>> +	 */
>> +	void *ptr = NULL;
>> +
>> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
>> +	if (size > 0) {
>> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +		ptr = kmap(page);
>> +	}
>> +
>> +	return ptr;
>> +}
>> +
>> +void unmap_crash_pages(void **ptr)
>> +{
>> +	if (ptr) {
>> +		if (*ptr)
>> +			kunmap(*ptr);
>> +		*ptr = NULL;
>> +	}
>> +}
>> +#endif
>> +
>> -- 
>> 2.27.0
>>
> 
