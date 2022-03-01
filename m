Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479054C9562
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiCAUHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbiCAUHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:07:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8274B70CDB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:06:19 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221JCQXp021791;
        Tue, 1 Mar 2022 20:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Lf9/beMKlRWSdM9E3qXS0nCnsv0zKhjN7RNSRg0M3Ps=;
 b=anW71N3YcHcj1CPTRpTwn5F9G+yYcI1WQeDxI2UgzGEyuwSUcl4EVpH8qQRtWX2Sdt7Y
 0Tl96XywTf0FvwnJ1oBExJSmohxJ3gdaD7/eL+pd8I+KfaQPewmRP9jVxq49URykCXuL
 Po0S6zrOhhsggT6pKJq4NZzAtrsBfBsPR+XT+gw55jyK5MVoRCTtMRtI3mJEG1gWcpqS
 IRF94JploT2u/5xI5zXzbjsBizG7MlUDaIUdnHkWPcNRmoH6Vcx4zOWZaZ/jjdopLogV
 nr/AHua6EzXxmtTAmizBQTjJouXlZ+VT9G9C2uCg1BmnaLo++SO2mUDdIa0P1h5VtQs7 wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehdayt6p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:04:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221Jupa9194426;
        Tue, 1 Mar 2022 20:04:49 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by aserp3020.oracle.com with ESMTP id 3efc1557nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:04:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls9i7BCYEE3vHZR3dboe88L0ehs9toqFYkB7ImOP7Ph4x4arv3LAiPxfZevw1BAb41IacVRDGKulHTm9FPtqDNAs7a4TuZLF7jDg+pwqxHlrcik5mpiMZfiorUnZhJVZvOpTQ95F0htyeD22Fo8FcSmZ5KHJ8unupgFcaME7MeBikQxIIpKMDrxUc/kSzsZUSdvIDDSWSXH8/TCcA/DhU6AmWaWDex00i8FWw1Rq6BkB9xSh4OEbneURMOu9kXOQpM6If2lM9sKzsCH/9xLGy4+PH6KPNWTEShkR3AB9weqejaSGCy86qoxLwhyIMNFm9zSXjHJ8xY5BUlRGQ7yOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lf9/beMKlRWSdM9E3qXS0nCnsv0zKhjN7RNSRg0M3Ps=;
 b=mnqePh+KuDW+sv0SxhMEz/jntnoSDA4Cyu/DxQc6sdlT5xGJwqaNTNmjsf9SxNmx76KjYRZaIugLoVGbtD0HvFz4UeqhdZWtsfwwTATc/exeHcDGRQtnRcUmSz7hjbUlHbah5UrlWVMgO2wfE9O7RdOkTzF/BPIAcRl0nhndZwUtKXLX7Iwighe7aZTKH9R5dl5pIGZhRZomgl0rc79wAgFRQ84yxVwlkDRllsrGmlezD7dYc6/fmTuQL6W16QC8rv7aJEt5bUDZhORRNh15MnBbJdKonrJVdBkJlhM1aNqPPYQAAbtVxwNqPsmDvJWOK6gZOTzy3KedvNlwif8j5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lf9/beMKlRWSdM9E3qXS0nCnsv0zKhjN7RNSRg0M3Ps=;
 b=qaGZEe4pG0FusCEIcLDlUKHQxKFFn7/zgs/gWBRw4ewIkF9U2mAdFoUHFQhXfoRRU1APK+yS33MoZVVcObMKu4QvAw8YwvxUSs8PAL9nWedfQG75ms2I1xI/PAK035rmH90kJXxFNWYm7FZ7+QFLJSN3Ryd3zALHQSKbW5lC2sc=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BLAPR10MB5298.namprd10.prod.outlook.com (2603:10b6:208:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 1 Mar
 2022 20:04:46 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 20:04:46 +0000
Message-ID: <4645ff8f-d4ab-a6a5-b4dd-df2b652daaee@oracle.com>
Date:   Tue, 1 Mar 2022 14:04:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 03/10] crash hp: definitions and prototype changes
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
 <20220209195706.51522-4-eric.devolder@oracle.com>
 <YhWtSWbKbr6aLezO@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YhWtSWbKbr6aLezO@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0063.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::40) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 093390d0-0465-4714-0ed3-08d9fbbebbb4
X-MS-TrafficTypeDiagnostic: BLAPR10MB5298:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5298293E97C445C3DE8DF3DB97029@BLAPR10MB5298.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdzCazsd6Tg4/aGtOmbsMseA3A2ImDZ/LRYXECZwRr3CNvjfdEUV/fUsLzciDQ2JyBlAySZd9b8bEx2F6qCTGn66uLN+YgXcTW1qBaMc62QCRQSL71EHUYqlgD6wKSdWD2rSjtxsMrHiprc6wxKk854uDhxU7KlT2ZdILzlx6xYxQVtCYpR1iNMSvfeLWmjSLIB70B+wUUxFYKmR4G+Tw4sLae+4IT/AzVJZB5XqCepbXfFJ7c2uOtrYNkE45GzPZ3ZuFpRiU4xeHSvcBivotktbLDg/+4mbBnVjC2+A0HjYvRjhBe57jhC1QQC7fcd3SNEQYCnianJj8PuQPlU04KynhXLGeEqa1Ir5a73d0kSqHAaw9Z4+Y5b8GYWyo6GjsRDszWmHMm63X0dsAmTWoXGHqJgtLrC2Eh23y6Iv/bUTLQ73j4sIsewxps/+NNlyeqTxDyTm9SGwqsmdLS+wyHfLkORkkBtnlgRKI17ItI/Jt2CgVKeAMGKvtXByvZ5QBqjjwge5D/37J3hER31b+hlF8ep3qLaBEbLMinW076JAIc6qBB8e06ggklXOCLIe21R95nW5z9sp++Oz0LDCUr3uUi4ZKlpcF+JkUAzpzom0LIF8fUkQJqzEqbyV058UJSaJDyVg3Fv5Tj2crANGAPJCXtXjBbBt1Wbh/Ln47iupk+OFnVaiu5vZf2TbcMS3QyRa66gdMiRXj/ALnR+LSax+DScfke8uVnEgvIB6hTnRrm9NM8bsPJL4RtDBhGAu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(66556008)(6486002)(5660300002)(36756003)(38100700002)(2616005)(316002)(186003)(6506007)(8676002)(31686004)(86362001)(31696002)(4326008)(7416002)(107886003)(8936002)(508600001)(6916009)(6512007)(6666004)(2906002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDNtdVo0OTZBN283WEhIZWpNUEdsZkN6bFJKemF6cWJBeTFSL2ZOVEY5b0Ju?=
 =?utf-8?B?MHdINWx5cmN0SVQ4cUVDT09mM2pKdW85TVl4b1prVmdqZXQwbGdMa0tYVERX?=
 =?utf-8?B?RVFlOXZiZ1FHdW96b0tKb3pqZTZnd2Y0QkJ5d0tneUtGZXd1TXVDaE5Bd1B3?=
 =?utf-8?B?Q0M1cmNLTHdoY3A4a1UzaEt2L3g0TWxjM0s3Y0w2c1gyeFo2VlhWcEVuQ1E1?=
 =?utf-8?B?ZlRoeDRFeWdpNTRwL1B1ZjhYMVA3SXFxWkFHcFJQclE2Q2poS0NBa2c3T3VY?=
 =?utf-8?B?MVFxMmNCb2FtbmhaQUtRVms2NnFaRmR4cEViUUhyM0dFcGEzSnR6MjZWNUtS?=
 =?utf-8?B?NTF5Mm1udkxZQjVjTEZJdkJsSjFDMERPVWl5azBaak5zSHJpcDV4eFJQR3lw?=
 =?utf-8?B?dDlad0dvNmNaVytiNFNUZWIrK21vNUNHVFovZzVZMCs1OHRQbUdJS3Q1ekNU?=
 =?utf-8?B?Z01GVzBHQWNsZXNIaXlHMFFaa2VmOVF6ZnFSL0xCalVNR0U1SmFuYlZoS1Br?=
 =?utf-8?B?MFZSdkNhWng2SGovenVwbU1GZFU0VXdjbU41WmZJRXBheDUrbjlQbStNaEtt?=
 =?utf-8?B?MlpmTmRCemhVTm1tKyt6bjc5UGdjTGVEZmY1SFJKMCtlaDYvbHo5Z1E1a0N6?=
 =?utf-8?B?VS9NVXdMUUYyUmJndFVWaWVEMDBGM1o3K2NpNllsbHRmMlJtNUF3WHF5T0ZL?=
 =?utf-8?B?czhnNmxsZlRkdkQ0ZUdlNWM3T0ZKaFlCUy9rdWtraUZHaTVXbkRiK0phb0wx?=
 =?utf-8?B?Q0FmWkNDK2t0dEVMRnhxK2w3QlRvUGFyU0RhTHZBdC9wODVuWGxQN04zejN4?=
 =?utf-8?B?OHZnbEJ3dStORVlJQ2ZnR1ZBOTFYd3lVVjVSUEtOYUNmNHVUdEZEb21jY1lY?=
 =?utf-8?B?djlBeFZoMEo5Y01LanlYVWp6LzRrOXRTOG0yQ0FCbm1CRm5SYk5lYTBDc2NX?=
 =?utf-8?B?WWtyNjhia3F6aEFhQUhSNEFuUG9weG5hVVdCQUcwblhzaTJ4ZmFuZ3M3N200?=
 =?utf-8?B?VmF1ZXQ4OXV3T0FUZE44OEEvVWdBeHlycFhsNkdZc0p1dUpMSlFLSU5SMU1K?=
 =?utf-8?B?Skl5RWdVQjRTN0RtUm1FMnlDVElQUStiVnJweEpDcGlWaStjcTJyZHlCcDBF?=
 =?utf-8?B?ZXRqODZKTG15aWJTa2RSUGxSQmNuVVl6YmNCY1RvalQ3aXFEaUw3bmdLS0hz?=
 =?utf-8?B?M0FpSWJ1aGVtN1Roandsa1ppTTdpWVpnTHkvVXJiNXRvMmE0WEQzeW1ZRjdr?=
 =?utf-8?B?Vkg0TzBWaHJUdWhhNC8vbGZYQ3hxdGExUFV0TnpLSkVRY1V5M0luM1VsbWk4?=
 =?utf-8?B?UytMMUNXTUVHZmVIc2FpS2YwQnpBc2ZGWWl0UWR0QS9aTFkyWWh6dWdRMzgv?=
 =?utf-8?B?NW9wL0FyT2p5cXFhcHM2WlQyYUplSWpyUXQ5RlJhNXc0azNvbWJDN0FZK1JL?=
 =?utf-8?B?NDBBQW95ZEhIZWIwdWlRdnpkQnJBL0Z4RDM4NmhObmJBZEhyMWRnVk9NTk9i?=
 =?utf-8?B?S0NWVHFlL1JyNlBFbWovVUMvK240VDVIQzJ5ajc1N3lsVzVRMm5vb1ZIK1FJ?=
 =?utf-8?B?bUpnTi9FN1JhdlFveGJhL3dpMVE4bzFhWmhmajFmakRCMnp2OGRabUp5Q0Ir?=
 =?utf-8?B?N3o4c0dEQ1JSaHl1dEN0L0wrS2gweCtBNThRdmxaNXg5dm1UVVhQWENiVUFU?=
 =?utf-8?B?ZCtsNFJuYWZlWEJyOE9XNE53TUV6M21oYmcxOVZmSFVVWWFzbWdXL1daVS83?=
 =?utf-8?B?QzFIZ2NsdFdnZE4vODVjVDBUc0p0alV3TlhrMnQ3N25iWnRqQ1BvRUF5Y3VD?=
 =?utf-8?B?RnRCNmpIeHV2TXZSODZzTXVEdy9laEFYU2lWUjM4WGdsNmxkYmZENERtdmxS?=
 =?utf-8?B?L3czS2ZzcDZvM2Uxdk5lSkxsUko0c3lySE52a2trT1lDcVBHdFRWZXVEU1Qr?=
 =?utf-8?B?TlBjTUZGOTlPZnMxL2E5dXJBaG0rZjJxSTg4OVkyQnh0Q3ZjTEI0UmJoZWp0?=
 =?utf-8?B?NW9VVFRlZmVjTHcvd0VTZnh2SDZ0eTZnLzRoWk9Cay8xZmI4VzY0c2lhcC8v?=
 =?utf-8?B?V0hYSjJKVTZSWHJQcUJJQy9wb1JMaGQxdVNoK3AvazZUQzlic0NBS2NPOXc3?=
 =?utf-8?B?VVBtS3EwcFhFYTd0ZTA1azdGNjkvSkxFTDllMTZvRzVxOG5Xb1BFamlUU3FI?=
 =?utf-8?B?clFwdjBxUGkzV1lrQkdNdERYSFppRm1qVzRraWI0bnE5RmRvYTRMQnZ4U0RU?=
 =?utf-8?B?SXhBTGtRYlk4YkVxbEdacFQ5Q3ZpVjA2TTJMaE1ZZWl2RDZSa0Ftb2ttcFNh?=
 =?utf-8?Q?PNnc3/aHSW+YEgPJSO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093390d0-0465-4714-0ed3-08d9fbbebbb4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 20:04:46.3623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fv0U+h2XD/ToCAXgCVWfvJdpxNGmmQ+VvteDw/bPZlZNs0qH704+a+GUMrpjmBnjG585UNO+WxLRHEj/YrrP2iL6WeueMPuRlTKohpsGgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5298
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010100
X-Proofpoint-GUID: SlSLH4Mq7BRsM7y4gdBpKjJwakhqCrdB
X-Proofpoint-ORIG-GUID: SlSLH4Mq7BRsM7y4gdBpKjJwakhqCrdB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 21:43, Baoquan He wrote:
> On 02/09/22 at 02:56pm, Eric DeVolder wrote:
>> This change adds members to struct kimage to facilitate crash
>> hotplug support.
>>
>> This change also defines crash hotplug events and associated
>> prototypes.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   include/linux/kexec.h | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 0c994ae37729..13c238c2da48 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -299,6 +299,13 @@ struct kimage {
>>   
>>   	/* Information for loading purgatory */
>>   	struct purgatory_info purgatory_info;
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	bool hotplug_event;
>> +	int offlinecpu;
>> +	bool elf_index_valid;
>> +	int elf_index;
>> +#endif
>>   #endif
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> @@ -315,6 +322,15 @@ struct kimage {
>>   	unsigned long elf_load_addr;
>>   };
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +void arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned long a, unsigned long b);
> 
> Seems this patch can be merged with patch 6/10. I don't see prototype
> change in this patch.

Ok, done.
eric

> 
>> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
>> +#define KEXEC_CRASH_HP_ADD_CPU      1
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
>> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> +
>>   /* kexec interface functions */
>>   extern void machine_kexec(struct kimage *image);
>>   extern int machine_kexec_prepare(struct kimage *image);
>> -- 
>> 2.27.0
>>
> 
