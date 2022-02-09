Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612904AFDEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiBIUCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:02:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiBIUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:02:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE9DE016CFD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:02:03 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HQ8Au020178;
        Wed, 9 Feb 2022 20:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pszRyXmojjnXroPjZ0M3U4o91gQok6J0t3OsoYXQRPc=;
 b=QZ/0pnCtQGkGJ/ePVTpNKDOCZtPOUKHCIw+V75ESB4FgW+7dHQpH5WZAOSfOFJHTSrYq
 uXJIer/TLAbl/GcPeBngLK1oi8DRJsRUhS+R/vwVQqW5n3ZcwFE7rXVW0/3+Nr7ukfCz
 CQSepwEZKRkaY4oecUTeT456FECnkZknbL/+gc75N6jak7oSjwvHihHNcsM5ULy6HZOG
 qEHUHeBCHeqo5+uTfyzdiGcuCJKdln+nCRv9NrZNGLknAGuzEnPi1/AAyweRoK6xadl6
 viZmXbHbiJZS95UiM+Q+f+7L66EcSUX+7djeF/cGo3BLNfM9K9PnKz4I7hG8LQhrti3T Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wxyuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 20:01:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219JtRfk179048;
        Wed, 9 Feb 2022 20:01:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3020.oracle.com with ESMTP id 3e1jptnqk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 20:01:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHmWMABkhVgbv2ILlCKAiejqos/g3tJDtC1NnwcEvTI+iFMPb3GUd9a2agb1TkNqxGWFTfWXTTjwLIaXWU+/HJ3eQVejbwaNs0kuXO706Js6wOCSfb+V/ea4Z3eYkrgMyQtWPazrw7iR/ZDMc2B6Lpg6LrTSDZ1UZYp/s/Ks7VL2HxIHkOuBi5ujX1iumPgeG/oK7bU/XQV4nSAdThCYGFX2iCjv4THUMCyrehmpbrQrJCNyGtD5xoFJqTRVEkQ5MBZYc6U60BDetwYEq+n/0oeiZO3BfQYAoQoKic3aWJj0p1qDBCnO5tgzgaH1sb1gdF5oLrVMVfK4r8nAHaCe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pszRyXmojjnXroPjZ0M3U4o91gQok6J0t3OsoYXQRPc=;
 b=UzdFl2l2CarDMRcELiXkFXG3RRtATgOP6pIH+5pRMCLtdVV3BKjLG/x8llZtzxk+q0aachj2DtszF/jAz5y0eK/CpbrdmN4vcww4yeqIoCPoHJj3zoHLnOTDYIMdjCDEBdkS4ir3mtRlB715q/HQ8vJ/bbMIlPE1BAucLb0hW6FNR9pQUx0WrC3fvTTDCKQRfYgcIP6tpn+G9r/E2CS3ciK6F+CI860uchUPFLslS/cF9lQOGT8i6OcQOTtI+Z14tMtqjadByGfXT+Sd1Ojom1V8oOJ4lTKxqvm90nksCcihDt1TyXCxHcXBc+3zvDD1hfX3I3joHZRuHtequKMHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pszRyXmojjnXroPjZ0M3U4o91gQok6J0t3OsoYXQRPc=;
 b=YHELH2o2N/r57JM9YFK6aAA09TecgXKSnTAybBdr5a1fUt+0whRlPIAR/liNY3Diac3Ts3mXsGd+oQTycl7qGUjJPVNfKZbuuBRa7HTLU1n9ZtYgNWmT11lSfOBWZjJHYCFnDqCTH0W9tJ1OcyGHeia/RuwgjZOoeYi5l+Fo0U8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA2PR10MB4652.namprd10.prod.outlook.com (2603:10b6:806:110::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 9 Feb
 2022 20:01:19 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 20:01:19 +0000
Message-ID: <041996fd-a8db-8434-c8bc-dac89a93b9cd@oracle.com>
Date:   Wed, 9 Feb 2022 14:01:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 0/6] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220110195727.1682-1-eric.devolder@oracle.com>
 <20220127065101.GA13508@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20220127065101.GA13508@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0159.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11cffbc4-5593-4d93-ef61-08d9ec06f013
X-MS-TrafficTypeDiagnostic: SA2PR10MB4652:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4652B1509500D202A73635E4972E9@SA2PR10MB4652.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KE3YUTSk6uyX1P0oSoS+jrUmK3CBaf0/sKJR/RPf4of+i5s/nJgVuidYWQFtnsQtdoSseyX6Ak869pQ9w4PcvZ9stsWAfwvEQOstiRImCiTSpIcQpsvQj4zbgQHuJ06ai/r0vFxZ1VC5vJMMxC5f4OZb2D17ObrWksCTbY9itqlzeHgeU/Cbwho9foYnyRtGVTujrYsxfGpKtfHSPapftu9uxlYb864R07ob/FapjM0LndxPmA34ZR2MqFKvPosmjpCJaSGwPx1Jmh0QyiooCWGV0JpoKTbSWhYDPHrBw6Qmov0t/agE9beCeScKTZqIVadMIrg5z9poM4Ji5/nWNomjEzqVYnAHDCcn4GMQiLqo1dhXX4CeZhoay7iTAPtE4rTQC7xORp0NtNWQ4rsCdgvtYOtO73mtHIR4ZPdVOKgfkcqvTV99f3T23HuFQnpgC4BFyTaOOlhUtPZbja6fxbNrW1EoQTL3L4O/yMQHDWwGpb8u2AJyermwuirv1Rtyq7DQ1jtJDuFgMe+SqbfBiq9sVtsRFzxvyfll9BMxg3ETlSTswX1IkW2QUlsjj1ycxXnwwh08vNAm3NMSAx1DVb213gejGVgC1XIWzn60kPizj4EobiHqtv2eaO+L7yOkVRYqIJPhyJvBIC0qdmwHJL75EEb7YgHnpifdk4DDruVARre6UjyM0zKfix9PWYGurJzWOg8VE17Kvt7jBqyvfA/hBKtUohjRrjDC5T0UZ1c7/Y7OFBAUBk0kJN5PVlWB1m6FaSIyAi0u7e06F1UlqdUf5aa1c/RWRhDNAxcoiIzGfqzbxJc36/oyHOtO/PhCtf5GZBynOzsQ4uprFNdRVFrQ6UnF79jbgn3T52rJ6SU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(7416002)(6486002)(966005)(6666004)(5660300002)(316002)(508600001)(107886003)(66476007)(83380400001)(66556008)(186003)(2616005)(2906002)(6512007)(31686004)(6916009)(36756003)(86362001)(31696002)(8936002)(8676002)(53546011)(4326008)(6506007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTNVd1NaWmhQeXlWTFV0bnA2MHlYeGdvVzJaMUxOeTlEMi9HQzNuVHR3eUVj?=
 =?utf-8?B?YmF0anNmSXZJWkhzNWhHTzQvZDlMNEQ2alNiaEtsbjZnb0VocHZSbVEwditl?=
 =?utf-8?B?RlNIc2ZOTjdnTXBxeGc4Qkp2WU5EalNLMjEzRndiaDFsc1dPb0FsVWdxTkdD?=
 =?utf-8?B?R1ZEWjRzanlJSDZvR3lEU01JMURuaEp5RWxadTJNdThNWW5HY2l4ZFE1c1Bl?=
 =?utf-8?B?VGhhbmF5T29oc05DK3dJc2NoRDlNSEhHR3RMVy8rR3NjTVlQYWNNcElDeXFV?=
 =?utf-8?B?YmowS3kxK1hEY2ZEaElsQktrWDI0dklIVGV4SW1lS0VxeVk2UnhyeHlRN0R0?=
 =?utf-8?B?MnBKZ2JyZi9ueDYrc2Z5R0hCZjJBYVBQZUZBdjhvZHdJU0FPdTNJMXV1akVo?=
 =?utf-8?B?YkVJZThTUDg0SWtXRGJpM0lWRHBYbUlMOUI2dFpWSW92VFlndmF0ay9GcEoy?=
 =?utf-8?B?ajZobUNJV1QzenkyYnB6R1FTZXptTDVoU01lRnFQTFgyZWZKcGpYdzdYakFm?=
 =?utf-8?B?RWI3bTYyKzhQRnVHelpNakFLUXdvVURrWnFhT1dna2p5R1N2L0hlS1owaUQ1?=
 =?utf-8?B?Q2hVYlhYVGhDNDF2TzlrclM1cy9wQWVhUFROZHl6NWdkRUlTa3ZYNkJBSE5W?=
 =?utf-8?B?SWEvN0piRmFKR3ZFMHBlRE04MEVPNFZIMTI0TzZwZHJWRE1pYWcxUzZ1bHp1?=
 =?utf-8?B?RWU2NW9RNlltdVhrS0hLSURrWHBHRmV3L2VJWlVOMEljdUh3UHJWZml4RXBK?=
 =?utf-8?B?RFNkZFY0aFBudmorUWFmWWRtWTcrTlVvNGFuSHJnM3N3V3ZaZGtyZEdvSzBI?=
 =?utf-8?B?Z25xUjlrbTlCaFVVNDlkb29OK25wSzZvRG1xendML0U3N1NqL0h1a0pGU3hL?=
 =?utf-8?B?Q1haYWVROUNORC9QcjY1N0k2OVMxNy9DWjhOOHY2V3pTY0FsaEFBZ21WZ2xQ?=
 =?utf-8?B?cWFqQURJVE9EZFBXVzAzMVp1VlNmeTRZVGFia1UwNmMwVERKQ3Z1UmtWcFUy?=
 =?utf-8?B?M2QwcEQxL1ZndlBSTXlnZFRueS9jQXpQcjh3QVMrRXZNSGZTaTZhU0laQ3Ay?=
 =?utf-8?B?TmVZOXZ3MDArVVA2ZG50dmF1cFVtcjBVdGNYL0xLd1FRQ0tNaDl4WTg3T0xK?=
 =?utf-8?B?RFBVZnJHVDNhTXhLVTYvUUxjVE1mWCtOakozd2k1aGxrc2J1SFNJOXd0UVpw?=
 =?utf-8?B?N21DbHNHZVJwL2NzV1RlazJKVFV4U1VabThONjJhQUJ6cnoxOURPbmtjRUVM?=
 =?utf-8?B?S1pqQWQzOVdRNHBoalR4ZkxsRUd0OUxXNmFQVkEwaldqMzFwc2VxcGpiWVdZ?=
 =?utf-8?B?VmVGdDNFVjNXRWoralBpUTBXSnFJQmNwOHV3TU85Z29GL1hOTDhiY0xjNjN6?=
 =?utf-8?B?MUgvWWFjaUpFaGZmZldZZnlyZnVyaUY2ZGZneDhDdmJzV0VMemtSQVkzWDF4?=
 =?utf-8?B?by9sajliS21NZDVlRXBDNnJYakhGSGsycytPaFdlSVhUYUhuVVYzajhiUHN0?=
 =?utf-8?B?ZkIycjlmOG43UGVLaGVERmE2akZVSXZ5MG16L1pncUNjdWtqRDBqL3lmMzVT?=
 =?utf-8?B?Q2ZhSnhvb3hPVUZHQ2dOMm9pbVI5c2tIdFBaS0JNd052S1Y0WWZsT2JRcUhM?=
 =?utf-8?B?RklQSkVMQVNGUllRK3NicDl1SW5MOUFqVUtBcmcvVTdKUTN2aU85aldzVG1Y?=
 =?utf-8?B?UFY4Z0Nmb0htRjMwNElUejNhWnAvVktUS3dWNWMyTnkvUTFRYkR5akZDT2N1?=
 =?utf-8?B?M2tPbkVReTR3dC9YS090Y2NNWGdwWEsyZHEzQ2xpVE9wUE9aWUdqTjdXODM5?=
 =?utf-8?B?OW5iYysyUEVsWHpRdGRNUGFERHFhRUxmcTdzSzBoOUVlOWVDV0pmKzM2aWRJ?=
 =?utf-8?B?dUJPVWFINFhQMk5DMmhha3U3QzVTbUN0ZVk1bFlwTVRLNzNVNXNPenpZOGhV?=
 =?utf-8?B?QU90MFFGN25pUHBGMTNacXIxcDlGbS9uYm8zUFVyK3p5a2FMR0ljMTFVVEpq?=
 =?utf-8?B?MllHTzY0YlhwdmJ2RjZHUEtlMXhlUFN6bmR2RWxRL0xnTnc1YnRmcG02MGZB?=
 =?utf-8?B?MkwwZmhSNXE4bW5CRzFmcVJkN0ZFUkJOc0NsZVZ4dE9WZmxJczZ0VmM2d2Yy?=
 =?utf-8?B?blIxdGlZVEhNczdGSFcyelR0Vm16L0tBc3pCcEVKKzFuQ1JxanU2UURyUFhM?=
 =?utf-8?B?dXRLWm84N1hpaTBwQXdwTVdCNkFQcVlMdXFOajRObzZEb1VYb0pSYzloUnVW?=
 =?utf-8?B?eHl2TWVHWkZvZEZrTmVKZ2tEL2FXOXlLWE13Q2RFMTZiVXVLaUZScnZNM1lq?=
 =?utf-8?Q?1hIqKabOJXKiDAg08z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cffbc4-5593-4d93-ef61-08d9ec06f013
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 20:01:19.3620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnJblfwOmxnXAmRVCOSmHKWYl0h2x7/eEScEu97gcWy9B/fjLkBhcOczpTEmWu4CmrS9KSmA5e0VK5rnpi+mPLsBREbvvEGnCRJjVDbPsEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4652
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090106
X-Proofpoint-GUID: FHLUvHeaHEVb5sUyzYN5-aK4bY5oBNPq
X-Proofpoint-ORIG-GUID: FHLUvHeaHEVb5sUyzYN5-aK4bY5oBNPq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan,
Thanks for the feedback! I think I've incorporated all suggestions in this message and others in v3. 
As a result, I just posted v4.
Thank you!
eric

On 1/27/22 00:51, Baoquan He wrote:
> Hi Eric,
> 
> On 01/10/22 at 02:57pm, Eric DeVolder wrote:
>> When the kdump service is loaded, if a CPU or memory is hot
>> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
>> and memory in the system, must also be updated, else the resulting
>> vmcore is inaccurate (eg. missing either CPU context or memory
>> regions).
>>
>> The current solution utilizes udev to initiate an unload-then-reload
>> of the kdump image (e. kernel, initrd, boot_params, puratory and
>> elfcorehdr) by the userspace kexec utility. In previous posts I have
>> outlined the significant performance problems related to offloading
>> this activity to userspace.
>>
>> This patchset introduces a generic crash hot un/plug handler that
>> registers with the CPU and memory notifiers. Upon CPU or memory
>> changes, this generic handler is invoked and performs important
>> housekeeping, for example obtaining the appropriate lock, and then
>> invokes an architecture specific handler to do the appropriate
>> updates.
>>
>> In the case of x86_64, the arch specific handler generates a new
>> elfcorehdr, and overwrites the old one in memory. No involvement
>> with userspace needed.
> 
> About patch splitting, it is always a headache to me when I post
> patches. Both too coarse or too small granularity are not good. But we
> should obey two rules:
> 1) commits had better be bisectable, so that later we find out which
>     commit cause issue or regression easier. Here, your patch 5/6 and 6/6 are
>     obviously breaking the rule. Because crash_prepare_elf64_headers()'s
>     protype has been changed, its invokation is not modified accodingly.
> 
> 2) Each patch only cover one action, bad better not stack too much in
> one patch. Surely, we should avoid to scatter one thing into several
> patch, it's not easy to reivew. E.g in this patchset, kexec_load can be
> taken out, for this we have discussed. Skipping the elfcorehdr digest
> can be taken out, its code change is simple, while it's worth to tell
> the reason in a patch.
> 
> So my suggestion to rearrange the patchset as below, please take it as a
> reference.
> 1)crash: fix minor typo/bug in debug message
> 2)crash hp: Introduce CRASH_HOTPLUG configuration options
> 3)crash hp: definitions and prototype changes
>    Note: this patch need cover those invokation of crash_prepare_elf64_headers.
>    Otherwise it's not bisectable.
> 4)crash hp: introduce helper function map_crash_pages/unmap_crash_pages
> 5)crash hp: generic crash hotplug support infrastructure
> 6)crash hp: exclude elfcorehdr from the segment checksum calculation
> 7)crash hp: exclude hot removed cpu from cpu notes of elfcorehdr
>    this includes the assigment part in crash_hotplug_handler() and
>    usage part in crash_prepare_elf64_headers().
> 8)crash hp/x86: add the crash hp support for x86
> 
> Above patch splitting and patch subject may not be appropriate, please
> adust or change with your understanding.
> 
>>
>> To realize the benefits/test this patchset, one must make a couple
>> of minor changes to userspace:
>>
>>   - Disable the udev rule for updating kdump on hot un/plug changes
>>     Eg. on RHEL: rm -f /usr/lib/udev/rules.d/98-kexec.rules
>>     or other technique to neuter the rule.
>>
>>   - Change to the kexec_file_load for loading the kdump kernel:
>>     Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>>      standard_kexec_args="-p -d -s"
>>     which adds the -s to select kexec_file_load syscall.
>>
>> This patchset supports kexec_load with a modified kexec userspace
>> utility, and a working changeset to the kexec userspace utility
>> is provided here (and to use, the above change to standard_kexec_args
>> would be, for example, to append --hotplug-size=262144 instead of -s).
>>
>>   diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
>>   index 9826f6d..06adb7e 100644
>>   --- a/kexec/arch/i386/crashdump-x86.c
>>   +++ b/kexec/arch/i386/crashdump-x86.c
>>   @@ -48,6 +48,7 @@
>>    #include <x86/x86-linux.h>
>>    
>>    extern struct arch_options_t arch_options;
>>   +extern unsigned long long hotplug_size;
>>    
>>    static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
>>    				  struct crash_elf_info *elf_info)
>>   @@ -975,6 +976,13 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>>    	} else {
>>    		memsz = bufsz;
>>    	}
>>   +
>>   +    /* If hotplug support enabled, use that size */
>>   +    if (hotplug_size) {
>>   +        memsz = hotplug_size;
>>   +    }
>>   +
>>   +    info->elfcorehdr =
>>    	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
>>    							max_addr, -1);
>>    	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
>>   diff --git a/kexec/kexec.c b/kexec/kexec.c
>>   index f63b36b..9569d9a 100644
>>   --- a/kexec/kexec.c
>>   +++ b/kexec/kexec.c
>>   @@ -58,6 +58,7 @@
>>    
>>    unsigned long long mem_min = 0;
>>    unsigned long long mem_max = ULONG_MAX;
>>   +unsigned long long hotplug_size = 0;
>>    static unsigned long kexec_flags = 0;
>>    /* Flags for kexec file (fd) based syscall */
>>    static unsigned long kexec_file_flags = 0;
>>   @@ -672,6 +673,12 @@ static void update_purgatory(struct kexec_info *info)
>>    		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
>>    			continue;
>>    		}
>>   +        /* Don't include elfcorehdr in the checksum, if hotplug
>>   +         * support enabled.
>>   +         */
>>   +        if (hotplug_size && (info->segment[i].mem == (void *)info->elfcorehdr)) {
>>   +			continue;
>>   +		}
>>    		sha256_update(&ctx, info->segment[i].buf,
>>    			      info->segment[i].bufsz);
>>    		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
>>   @@ -1504,6 +1511,17 @@ int main(int argc, char *argv[])
>>    		case OPT_PRINT_CKR_SIZE:
>>    			print_crashkernel_region_size();
>>    			return 0;
>>   +		case OPT_HOTPLUG_SIZE:
>>   +            /* Reserved the specified size for hotplug growth */
>>   +			hotplug_size = strtoul(optarg, &endptr, 0);
>>   +			if (*endptr) {
>>   +				fprintf(stderr,
>>   +					"Bad option value in --hotplug-size=%s\n",
>>   +					optarg);
>>   +				usage();
>>   +				return 1;
>>   +			}
>>   +			break;
>>    		default:
>>    			break;
>>    		}
>>   diff --git a/kexec/kexec.h b/kexec/kexec.h
>>   index 595dd68..b30dda4 100644
>>   --- a/kexec/kexec.h
>>   +++ b/kexec/kexec.h
>>   @@ -169,6 +169,7 @@ struct kexec_info {
>>    	int command_line_len;
>>    
>>    	int skip_checks;
>>   +    unsigned long elfcorehdr;
>>     };
>>    
>>    struct arch_map_entry {
>>   @@ -231,7 +232,8 @@ extern int file_types;
>>    #define OPT_PRINT_CKR_SIZE	262
>>    #define OPT_LOAD_LIVE_UPDATE	263
>>    #define OPT_EXEC_LIVE_UPDATE	264
>>   -#define OPT_MAX			265
>>   +#define OPT_HOTPLUG_SIZE	265
>>   +#define OPT_MAX			266
>>    #define KEXEC_OPTIONS \
>>    	{ "help",		0, 0, OPT_HELP }, \
>>    	{ "version",		0, 0, OPT_VERSION }, \
>>   @@ -258,6 +260,7 @@ extern int file_types;
>>    	{ "debug",		0, 0, OPT_DEBUG }, \
>>    	{ "status",		0, 0, OPT_STATUS }, \
>>    	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
>>   +	{ "hotplug-size",     2, 0, OPT_HOTPLUG_SIZE }, \
>>    
>>    #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
>>   
>>
>> Regards,
>> eric
>> ---
>> v3: 10jan2022
>>   - Rebasing per Baoquan He request.
>>   - Changed memory notifier per David Hildenbrand.
>>   - Providing example kexec userspace change in cover letter.
>>
>> RFC v2: 7dec2021
>>   https://lkml.org/lkml/2021/12/7/1088
>>   - Acting upon Baoquan He suggestion of removing elfcorehdr from
>>     the purgatory list of segments, removed purgatory code from
>>     patchset, and it is signficiantly simpler now.
>>
>> RFC v1: 18nov2021
>>   https://lkml.org/lkml/2021/11/18/845
>>   - working patchset demonstrating kernel handling of hotplug
>>     updates to x86 elfcorehdr for kexec_file_load
>>
>> RFC: 14dec2020
>>   https://lkml.org/lkml/2020/12/14/532
>>   - proposed concept of allowing kernel to handle hotplug update
>>     of elfcorehdr
>> ---
>>
>> Eric DeVolder (6):
>>    crash: fix minor typo/bug in debug message
>>    crash hp: Introduce CRASH_HOTPLUG configuration options
>>    crash hp: definitions and prototype changes
>>    crash hp: generic crash hotplug support infrastructure
>>    crash hp: kexec_file changes for crash hotplug support
>>    crash hp: Add x86 crash hotplug support
>>
>>   arch/x86/Kconfig        |  26 ++++++++
>>   arch/x86/kernel/crash.c | 140 +++++++++++++++++++++++++++++++++++++++-
>>   include/linux/kexec.h   |  21 +++++-
>>   kernel/crash_core.c     | 117 +++++++++++++++++++++++++++++++++
>>   kernel/kexec_file.c     |  15 ++++-
>>   5 files changed, 313 insertions(+), 6 deletions(-)
>>
>> -- 
>> 2.27.0
>>
> 
