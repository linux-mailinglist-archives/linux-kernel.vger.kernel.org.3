Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363294C956D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiCAUIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiCAUIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:08:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA525205CA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:08:02 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221ItK36030728;
        Tue, 1 Mar 2022 20:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TyfgK9yB8lcSfAq5emk380TpwynpH/kY35P0zXioQYo=;
 b=VUaLWmv9Z6GerXkZ12RfuodpXGtpNo+HdTxq38Mvez+U5TF2UsqLro9BfqZ4AOdofF5+
 lnx8UFbJ69jjNa1q4k0wn2HyUzozjPVk3fDC6sOBbKT/n1eYjVTrLnt3IrNZTVLuc5Cl
 ekBss3YT9WmUPjuT0v6eXmROs6vpEUCE8TpdEH5oMP33sClsAOdX9hR1WgEXOfYe9P+E
 Qn8xL+Bg4ZRIlURXqStdCg4Kpbs/a0yeoYbm4gipNVQWqtnJJMIVan/SaIpFTx0XNsAR
 HNBdsRG6VNdnVXaW2XpaPS+JhmHtDLUhIzsiZsd7cVxHb2vcx+pKieTmUSantqOoJ/X+ ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh14buy0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:07:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221K6o53018225;
        Tue, 1 Mar 2022 20:07:40 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by aserp3020.oracle.com with ESMTP id 3efc155b2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:07:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvzLTTlTUqd0WiFB1CPh7femG5LoaLNg5vGq4fSP7iZzzxPLa+RWzyiyDm8PkyKAiKhZghx+PzT1/3gyy8j7gi0EfOmEoP9NCLGusP6eFm0cP/bJYsfX4xiiZTsYE9A1urOdFWzCwWm8SYF7hu6qQBtYYdeAbFO5b/aamy9yj3unHA/5XAym+pgaCHIaSOMQhVNA8TQel4D/LxttwLdJQhtJppDs4V0FWbvAVnrN6GqNLQQXrxtuyxdHzkQjYjwXRUY2Qqxp7j55FA/GJdhzKklMA2fh6E5rgbXWrqE92cji2UMsdOIg8JUBy+WbNQWrI8HNPjrec62gj3Np4e/F2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyfgK9yB8lcSfAq5emk380TpwynpH/kY35P0zXioQYo=;
 b=OPrSLxEMdnkCqUvkqGaYtI0oHBtGGn7emEmH0VO89GgNWWKNwjYvSnNv0vrlNqljxlDeEChrTy73G7XezKNRVj1u6AsWcxcipbKPgFqmZdyDVlPj7BYg+yzWaHBKohYrQnQBiydom/u1ZUVFqvsWvrRlDA6a26fH9E+L0Z3Q+1AlFs3TmlGExg3xDc1/vBHd8B8wHbYrNclsyaDBpU7c4WaApyAocXtL6FdYd7mn/NjcE/O1YlSgHYhFZsQsduHG3l4FgYLB6cN5FTs1/Zilv91CoYWR6v42C2rTUDxnjoNClFfbllvnPv7wvx002lI1q4mvU24H0Ckjp1xhA1fwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyfgK9yB8lcSfAq5emk380TpwynpH/kY35P0zXioQYo=;
 b=xymb1pT/0KB57L7WJM9Tsm3jSnUJv2RpgKAWnL6JQpBq8+cy/msC15dqYyF4vUoBUialv4pladCZsTQyOiKTburjAnucRLbma6vXLUozsR//2HF1a3SSI3oNjpakfzIsaaGvG/NBZqriTXuLj+qzZAmC9zYhDjukNVi6OkfGo/g=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BYAPR10MB2837.namprd10.prod.outlook.com (2603:10b6:a03:81::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 20:07:36 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 20:07:36 +0000
Message-ID: <4ca0e693-5ee0-9ebc-64a3-e902e60c119f@oracle.com>
Date:   Tue, 1 Mar 2022 14:07:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 06/10] crash hp: generic crash hotplug support
 infrastructure
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
 <20220209195706.51522-7-eric.devolder@oracle.com>
 <YhWxOoB3n2O2vLHB@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YhWxOoB3n2O2vLHB@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::34) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 477ffec8-c6b8-47ab-de24-08d9fbbf20f8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2837:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB283785D2AABB1D016E506AD797029@BYAPR10MB2837.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scNjBn7z+wUC125yviXoJCJqzcEHCR08v4KUl7sjk7e7FxRYX8iUC+OtC+bz1Y85lnrjG5VQH16viKdCSRHSDl6hHWuQhhPfjLBpWUGO/4K6OYHvB+8ppbW0odwx1FazbuH2nDm6s1ecPoQKh4MpNu/7UJDsNHJQrEmDUuuLNfZWTWfTyw1xneLuR307KJET0hFnTYzLt6+7FwOnyV8qQPMh+159Bd/0IfYnNqJuS21W6vzWeFr9ePnt6pUkKQKYD7v8gJZ2qsdpKjq+I3JGrjZF228gAbKwXN2V2lCpJnvBX4VvIGpi5O2Za2U7zQ6Va6j3CWM94XbmaNM0HrRrYh4lDwisCq8JlFeEVdSAEUwoJbggIY+Lt6v/gSFnMGZMwUn0twNtSAEe1redwyfRAJciVAOVhX9EDmV2MFCcrTji0PNd2nR/+25UfPM4Ky6evOM616PReOGVCAaR4W0e9a8QCQoShRAw9tl48KZWmBT6IHPfKG+jLo0Onv2K2h2W9lf4o76WuDPft0pU9e4LSg/qfHqafJbkpKFLJA/kpDjgh+F4OuSNkO2q3Hq6nFhlf6ojQkEysmf6oOZXXWTbAMBKEm02NauIcfkMQNFsVTkjBjEbcHfxlKCtLC9zmuZDfOtpdCy67eSkKSiUSlQqOdrxuXUU7QV+q60I49sqsxAfGWRrq7fnVIRvs6PXF6n0t2PIjo6N6l1g6rA0RlspqRlBtBkaG4ySdDQ/itxtA6df0ddxP1Wt6xagQntjba4z8rCgBmh/trEm347aV1eHvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(2906002)(31696002)(4326008)(66556008)(8676002)(6486002)(5660300002)(66946007)(36756003)(38100700002)(508600001)(7416002)(8936002)(86362001)(31686004)(107886003)(83380400001)(53546011)(2616005)(316002)(6916009)(186003)(6666004)(6512007)(6506007)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRHYjZaZEcvbVFFQVR1dWs1NzhTZVRXcHpjeFIvNkkyMHp6WGFJYTlJZVRt?=
 =?utf-8?B?TEYvRTdsOGhtSTVQMkhxUjRwelRRQS9halN1ZXpwM05TQUNDNDRkZXF1S3dx?=
 =?utf-8?B?Q0ZLUlpyQjJicGp1UDZGbEoyNXpGaVphRjNJZEFSUTU2SUJRVHdRZE54eVF4?=
 =?utf-8?B?RHVBNDN3ZGR6UHI1K25teWs2NU1RTVFWYVpjLzNGV1FBQUp5elFOdFowb3ha?=
 =?utf-8?B?TDRtUHM4VVdUWjliVlhwTldKS3E1aThkSlVzT2dId2lrNzJKdGdtNEVDZXBC?=
 =?utf-8?B?UFZmVWpuSGFqSmc3eTJYU2xIYWtDbmNlVVRaL1NvaXJkcFFiaVZWTVBFRUM0?=
 =?utf-8?B?Nm5oTVhnU0dLVDlzRExmaDZqenFtZTBsTDhZRExyZ0RJbHdnNDR0OUZGb1Z5?=
 =?utf-8?B?aWJYckM0djJXaEw0RXhMbUJ1anJON0hoZTh0LzY2QkwvdzRtLzZ3NTNab3Rp?=
 =?utf-8?B?WStGT1VsZEUxWXkydXg3aWxRQks1SkxrVW1tWWpKMGJyUERFd3dZM1ZoYW1P?=
 =?utf-8?B?M2VuTEtIbFMyaTdZMkJUZkIrRzhEalloSjk2dHZjbkFZalQ3d1FtU29QNk1G?=
 =?utf-8?B?cjFEYkZqbktBN2VmM1Q1NVFaSWpTMkFRRUc2ZkVNNDR4VlEyWG1MeXE0WER0?=
 =?utf-8?B?cUFIVTV3NHlIUEZHMXRjdzVUU1ZmdkxwcXN0YlJab2l2TlVWSHE1NThyTVlS?=
 =?utf-8?B?UURaL3kyTEt1MW11M0tkSmpuQjU3b2lZY2JIc0lYVndjQnh5Ym00NGVtN3Zo?=
 =?utf-8?B?RkR6cHVwU3RpMlp3dTdOU0lUS3BmWnVLYkEvcVEra3RSc1lmRlVScm81c0Rk?=
 =?utf-8?B?NnhyUWlkQlZJVWdCYXd0Q3lwbVNqNDVFN1hOcVNYSk5jbXRDeXpiZUtlQzFT?=
 =?utf-8?B?NUN5SkpxaVdCMGh3TlRadHA3UXptUkM3Wks0YzFXcW5wb2dJcVZmSGo5Wlpa?=
 =?utf-8?B?aWFtMnhOSFllbUc0NWwwU09HWHZyWnhHT0ZwTkp5dVdpV08wQzZkZGtUZnox?=
 =?utf-8?B?R29GbDNBbndPTVNkTmRCZWkxdnArY0RkVWpXc25jSUh1azVVcnRMaHRIVFR4?=
 =?utf-8?B?NUdZakM5VDlkQzMzT251TUQ2S2Nrb3d0YmRSR3Fhd3djMDB2WGNtSlZpMnlM?=
 =?utf-8?B?UkpNOXBybGlML09lT3ZXbUVySUs4WjY1U1h1M0pjVjZselBZK2wvbzY3OWVy?=
 =?utf-8?B?SnhFcXRKT0ZsWUFTeGpWUW1jQmVhWCs2dFJ2cm82S0E1NmJ5OVdMZFZVRkMx?=
 =?utf-8?B?Q0xCT09zZUdGZEkxRHVocjE1UEVENjJBRDdPcFhnWUwwSXdkT1Q1bW1qM0lx?=
 =?utf-8?B?NWVwZTc1azhXUWtFSDM0b3cvZTdpR3NmOW4vN1JpQTlRQ1JYaG12S2p2VE1R?=
 =?utf-8?B?UkVqakJWUHpEa0ZvZk51aGt2VUNxWktEbzhSa0JMVDRldmZmUjVUYU1Ra2V0?=
 =?utf-8?B?eGpBZUE4MjJjYzVPc2hzUkMyUHM1WTl4UCtVSmh0QTRCMnAzWnlhNmJYYkli?=
 =?utf-8?B?WTZqQUprYjAvOXBrYUNKNFk1dFNhTDA5bWgzaE5LbjVFS2tXZExlUHQ5NlVG?=
 =?utf-8?B?eS9ucG5LeWtFTm1BSE9rV29hOXkzUzE2WldMem5sMTJTTnRNUFVNc3FBMzd3?=
 =?utf-8?B?b21Ib3JyeDA3MUZ1WlBpUVBKYjg4M1lqWUQ1amFnLzlsMUpIMU15Wk13ZStT?=
 =?utf-8?B?VFBpNW93OTlVSzBXQ2lUSnlHL2JTQ2RzTG5GSmRjVXZ2dUxJVnU5a0gvT1lF?=
 =?utf-8?B?cGkybm1QN2pYay9EQUdkUjRzc0ZYQ2pGeXBlTkFvV1JhYUE2Qi9rdkp1M29T?=
 =?utf-8?B?ajNHV1c1U3I5K01hRk5XZ2phS3ZFelQ2QjR5cEwyYUZSekpEOVNRYVh0YS9Z?=
 =?utf-8?B?TjdBR1BYbS9sVTd5NTdvSnhFZ3dSQVY2SjhuNXpXRjZ4eCszZWhSTG43bzYz?=
 =?utf-8?B?d0xaT3F3ZWY5NnVpZ25wTkY2bVVYYnYreHZBQ2ZZQ1RNWElTa00wQjRrOGtn?=
 =?utf-8?B?TEhwNllsNFVpYW05aVN2TDF4UTl4Q2huMVpVdkpMOGpueisrVUlHRzhVMHIr?=
 =?utf-8?B?czZQSnE2Ni90a0lTemIvUDBEUXpTd0NsbE9SZ0lwcnBFR2FNSHVCb2REcU56?=
 =?utf-8?B?OUg5UkorQnErNmFTeHBKeDRPUnR1NXJCTzRibmR3Q2dqbDVHbnorVVFQaDd6?=
 =?utf-8?B?djRlZWdxNU1yRzAxRERJS1RIK2J4ditEcFoweFAvS0F0dEJCZlRwWGlJdWJt?=
 =?utf-8?B?cE9lMHhzVkxaaW1FZm45dEhxU3NjaEJhdWJxdlBtMnVLYXVYUFNOSUxseTNR?=
 =?utf-8?Q?TmhfpQICT+L5OUFV6o?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477ffec8-c6b8-47ab-de24-08d9fbbf20f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 20:07:36.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIRn7J+sm54cSqLx0sGAz8T0ge5MhN2Z6o49ypn9NyPQ+En12Xgu0vhrXSxaiXhefnspqwlHxipNvP8bYwV136PYTKi7GrtZwiUyVb19Wts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2837
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010101
X-Proofpoint-GUID: Ep6B9N7i2OenQZCgPKKZoW2u1X830BPZ
X-Proofpoint-ORIG-GUID: Ep6B9N7i2OenQZCgPKKZoW2u1X830BPZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 21:59, Baoquan He wrote:
> On 02/09/22 at 02:57pm, Eric DeVolder wrote:
>> This patch introduces a generic crash hot plug/unplug infrastructure
>> for CPU and memory changes. Upon CPU and memory changes, a generic
>> crash_hotplug_handler() obtains the appropriate lock, does some
>> important house keeping and then dispatches the hot plug/unplug event
>> to the architecture specific arch_crash_hotplug_handler(), and when
>> that handler returns, the lock is released.
>>
>> This patch modifies crash_core.c to implement a subsys_initcall()
>> function that installs handlers for hot plug/unplug events. If CPU
>> hotplug is enabled, then cpuhp_setup_state() is invoked to register a
>> handler for CPU changes. Similarly, if memory hotplug is enabled, then
>> register_memory_notifier() is invoked to install a handler for memory
>> changes. These handlers in turn invoke the common generic handler
>> crash_hotplug_handler().
>>
>> On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
>> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
>> the CPU still shows up in foreach_present_cpu() during the regeneration
>> of the new CPU list, thus the need to explicitly check and exclude the
>> soon-to-be offlined CPU in crash_prepare_elf64_headers().
>>
>> On the memory side, each un/plugged memory block passes through the
>> handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
>> memory events, one for each 128MiB memblock.
> 
> This looks good to me. As I commented in patch 3, these both may need be
> merged.
OK, merged with 3.
eric

> 
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   kernel/crash_core.c | 104 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 104 insertions(+)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 0ff06d0698ad..524470e18883 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -10,12 +10,16 @@
>>   #include <linux/utsname.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/highmem.h>
>> +#include <linux/memory.h>
>> +#include <linux/cpuhotplug.h>
>>   
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>>   
>>   #include <crypto/sha1.h>
>>   
>> +#include "kexec_internal.h"
>> +
>>   /* vmcoreinfo stuff */
>>   unsigned char *vmcoreinfo_data;
>>   size_t vmcoreinfo_size;
>> @@ -521,5 +525,105 @@ void unmap_crash_pages(void **ptr)
>>   		*ptr = NULL;
>>   	}
>>   }
>> +
>> +void __weak arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned long a, unsigned long b)
>> +{
>> +	pr_warn("crash hp: %s not implemented", __func__);
>> +}
>> +
>> +static void crash_hotplug_handler(unsigned int hp_action,
>> +	unsigned long a, unsigned long b)
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	if (!mutex_trylock(&kexec_mutex))
>> +		return;
>> +
>> +	/* Check kdump is loaded */
>> +	if (kexec_crash_image) {
>> +		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
>> +			a, b);
>> +
>> +		/* Needed in order for the segments to be updated */
>> +		arch_kexec_unprotect_crashkres();
>> +
>> +		/* Flag to differentiate between normal load and hotplug */
>> +		kexec_crash_image->hotplug_event = true;
>> +
>> +		/* Now invoke arch-specific update handler */
>> +		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
>> +
>> +		/* No longer handling a hotplug event */
>> +		kexec_crash_image->hotplug_event = false;
>> +
>> +		/* Change back to read-only */
>> +		arch_kexec_protect_crashkres();
>> +	}
>> +
>> +	/* Release lock now that update complete */
>> +	mutex_unlock(&kexec_mutex);
>> +}
>> +
>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>> +static int crash_memhp_notifier(struct notifier_block *nb,
>> +	unsigned long val, void *v)
>> +{
>> +	struct memory_notify *mhp = v;
>> +	unsigned long start, end;
>> +
>> +	start = mhp->start_pfn << PAGE_SHIFT;
>> +	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
>> +
>> +	switch (val) {
>> +	case MEM_ONLINE:
>> +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
>> +			start, end-start);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
>> +			start, end-start);
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +	.notifier_call = crash_memhp_notifier,
>> +	.priority = 0
>> +};
>>   #endif
>>   
>> +#if defined(CONFIG_HOTPLUG_CPU)
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
>> +	return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +	int result = 0;
>> +
>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>> +	register_memory_notifier(&crash_memhp_nb);
>> +#endif
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU)
>> +	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +				"crash/cpuhp",
>> +				crash_cpuhp_online, crash_cpuhp_offline);
>> +#endif
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> -- 
>> 2.27.0
>>
> 
