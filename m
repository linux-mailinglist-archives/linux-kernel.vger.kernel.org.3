Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2E14B16B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbiBJUHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:07:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbiBJUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:07:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65F5F5A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:07:21 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AIfSDG013525;
        Thu, 10 Feb 2022 20:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6SuYjjFZMSFzxywXubtueUYjL9bS5BxjQslBpEV/dMY=;
 b=apPdujoEclkQVeGw/EmyEPZSJJDV2t1fLk+VK1tfAT+7oNtVp22Vh/SqAT66C9s8WFWL
 IePzb5qDte7vXN/YJHxBnaXq5JjFEdV7LysCZOxSLjHPIhz3681WrVOnMspAGK2eKyvJ
 cRoV+adkcKU/13l1rYWDzOjbBw21xqNJv0/AYSj43n+8iO+vGkXoMXsqIgwNHNgSH1my
 94Ebv+e1EG6Zuayt2855SB2W1TNjQQSkjqVEFbCv9G4TDRWNv6eaOEBepxTn7+RMLFuT
 ivTJ1Tnu4avH5Z5LDkR8f1ZjICOlLZ/ea4ng3+outgWY/c13QiV65cELgJl9r0f0QRf5 Vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345su4et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 20:06:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AK6DwA028258;
        Thu, 10 Feb 2022 20:06:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 3e1ec5qreb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 20:06:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFY8PybNeGG8aX86qIHdHceFCbxcnodvKLLwyy0n3+Nf8WU+WMZzbtqxKYzE50t7l3kORX3+Gj+y2IM35ez5GJVvajKjNNIFAPpu3ZKXDel3XcnHreCNSRj3IJOv+SA1YSWwFXPop/RB4OGGup+LqEDpwFKnNJxT7fGiBjGgBp5pKKwx5JIupqUibhYIzptRZ1YOt6mBgcoB6Oceueti4abRZEcOlZgLyBPmDqAOwkJIyeHOuAR2xsl701DzDztJ1n5U193RVcX0TOl96tN6QkdV+RePoCkBseU7f44oM1iHGoF4W/0nSdkr1wUoOQ++0KG+J3gGoxUWseC2o5aRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SuYjjFZMSFzxywXubtueUYjL9bS5BxjQslBpEV/dMY=;
 b=OJSDaAheLLrKHrcTSy6ZVFz1LiE0yezheLnJA42ZouR8Fuk3H3m3VGjOO9Y0y/Sh+Ph02pZ5S3jsl5X0OFGnUoYeBj9clyLaf0Wy+hIMa/JTqSxqPl/2LveWQKoZvpfAk93xDcvL9vzT1EDOWndGEz69lbJCAnIJraGqqJkL8e2lR0LPks7kXH9f3s93TvhasJ/8fIqVu2Mut0xzG452o+JZx2tnpHW5SBdbs3ZNdZeHew56A1WDmLwqtZ6HcW9UWeLcGGKroZtMYxeism7izU69CdG8HH7t5CiwYXvMloouZMfgromMljgaaqokG7mPrppJXVdM0HsISuixvsuPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SuYjjFZMSFzxywXubtueUYjL9bS5BxjQslBpEV/dMY=;
 b=feiOO5BlVeQeQpWbZwunAJdOv1GzcARIr4cX8NNBTbJJGPk09p69F8coUqI6Cp1oYasRvaMP3DmcjRoTvRFh92NpVd8AnnbrPSRYIsdmFgH0g28So9fdk/fc8bp6lsLCqcFB4zttQKvmZPBXh8gR6njlkkztwDGC6A29PEN7Qww=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SN6PR10MB3005.namprd10.prod.outlook.com (2603:10b6:805:cc::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Thu, 10 Feb
 2022 20:06:48 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 20:06:48 +0000
Message-ID: <8f08bb64-ee8a-9555-f4a1-6d55d3c77531@oracle.com>
Date:   Thu, 10 Feb 2022 12:06:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 0/4] printk: reduce deadlocks during panic
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
References: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
 <YgTZPQEay6T/nhu6@alley>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <YgTZPQEay6T/nhu6@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:805:ca::38) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d3588da-2dd2-44d2-4468-08d9ecd0de65
X-MS-TrafficTypeDiagnostic: SN6PR10MB3005:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB30053A26FF534775F8065235DB2F9@SN6PR10MB3005.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n06TZlmh8kTs3XBzCbSKp7P7R36PMOftKS5TzatmvdlVPE4E05pWZFYMQq+ndGw33fuZf+tJ45zk+Mtz2oHOpkkk0brw1MvNe9WM0hbDKCEJI0KBBdnM+pmClfYVVoJSvPOaBi7/dBxUALt+sOZoxU5ype1r2/TvVfgyd+43NkoPcz/4cs85z6G3WKrzLJo5PG3elMFQPJ0hg03gkpIYLy/FmVG+9noQSsDDEvsIVC/en+pg0MWFyPCbDv/6RcCxfjRQ2ab+kEvWClPcOuxJxGuIpdBKbTqPRBGhdgk7yE8AGuQY/beLoOKDqxIJ28/Oqc7XEuTPHYUn7r47bFnqC3yBJkxoez7L75g10Povyk5Od9qGSnmI3/lHuXFG3jQXLDQEc88mYeNTPtZylw6EmeIGZdZkMJ8L/hbO6qYNEucerXKElMkyaMYAdd4D9J8xMPTZC1L+7omRy/tiihnlbQUxd4xDteqXmvc4cNYsTdvK3TWGWJQqvq/SD8xNQc6ZTvny97CqlXPCPdxJ+Bv7j17t2/Ww6Z+tbBq4lfYqfrtDUad3GtOhH8sWD69WLH/4fsWYQfO8Zg/suo5VC7NbuXV4gYwlmqu+hAeRYr9Ttb+FKDprucUvZ303E7Z8J1OKiZilzlhrmVErvQmmXPjA0RjnpiSiSNppeulJNb/wYAfygti9BFaGjqw1afIFbtGd5JAxt7cnOBiOb5Q/7N7wkMo6mMy5rGEoD+bh71P1uqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(6512007)(2616005)(31696002)(186003)(4326008)(26005)(86362001)(316002)(5660300002)(8936002)(8676002)(6916009)(6666004)(66476007)(66556008)(53546011)(6486002)(6506007)(31686004)(66946007)(508600001)(2906002)(38100700002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkM1YVcrQ09oWkYzOWRWNXduTUxYV0NVWHVQMUJjcVQ4YU8wS0R1azVsam5P?=
 =?utf-8?B?clZUaC9zbzNraWJhYkZWTjZJeXkwS0szR0VvSEduWWRRTjNVOExNQjRzdWNl?=
 =?utf-8?B?WmgvYXhlb0k4VHplcjUzYThycFpOek1IWThUa3VjcS9mVTNjdkRMdVZyamZR?=
 =?utf-8?B?RlJPVXMrMW1FclJoQmpySHA2SjROcSt0THdRSWVMVW5LY21UUXE0RTVEVm9Z?=
 =?utf-8?B?SkpDT3lHb0pNbWJNZHZWdmp0L254RW4wYWJRRC9mUmZmTm5BeGRtMmxtN2Z1?=
 =?utf-8?B?YnpSZldRb0xsWlY4V0o3OGI2cnZ5NmNpMys4WVVqdVkyZ2xIbUlubnVHVDNw?=
 =?utf-8?B?bWlqaFFiNXkzNlBJT1kxRG5QNTA0aTM2Y095RFdHV0N5NEI1YVdjNXlnd2xz?=
 =?utf-8?B?VitJRG1GdG1FRldmdXlqK0d5Q2poR0tlV09jR2VxaTNVOHgwYWtyaXN5YURy?=
 =?utf-8?B?VGRVSWRacFRUeXlsNHZEcU9NNGZTcG5MNHhCaUNIRUtSanpGQmRGUS9HN2Yx?=
 =?utf-8?B?QUxFbCsxbGlrQXVNWWtUSGhSZjZubEtCczhFYWVlTTdvUzlqbWxoMGZBcW1y?=
 =?utf-8?B?UjJDVzlhRmk5ZWpReHROdWQ1anpXdWhzNmdSdDAwQ05aQkFkbG1PL1RzWnBG?=
 =?utf-8?B?cThCWTBCam5rS0xGcm9kTWc2emEybDNuOGFNQ0U2UWs2ZGFHcEtJYU8zSWJw?=
 =?utf-8?B?S3RqNW1yZXlSaVplY1RJYm9yc0VxUi8rSDkzeU10YlY4YXhpUE9hcldieGkr?=
 =?utf-8?B?bm5jRXdlWXRtYS94RTFVbkhDTmM1cXhpbGR4RzUrbU04VkpmTGRqckxuMk0x?=
 =?utf-8?B?VVU2K3NqUWszbFFZWG03QXMrY0ZsaTZtY2dwNkFlQkc3SXNLOXM0N0VWVnVR?=
 =?utf-8?B?eFRHazZsc1R0S2h2WFI2bGd6akRncHArdnBKMHRyaVZsTk1KaVNuMGpSQnVp?=
 =?utf-8?B?S3NRT0VCR2FPeHJJQ1NlTlBSZHBYbWpQUU55eWdla0xEMk9RRzgyL2o0STcy?=
 =?utf-8?B?Q05sWUhQYzlWaEFTeDRVT1YyQ045QTJIUC9UK25yd1REYVJUaFAwTnVkcDl4?=
 =?utf-8?B?aGRZaXhnWXNkbnp1ZHN2VG1UTVJPcEM0YzVxTGMvZkc1RURqSk0yUlc0WTB6?=
 =?utf-8?B?UllIYTUzRVBNb0g0RUd1VmZFQlhJdXFhNEU5eDM1bGpZdWRWaG5pdUxGV1I5?=
 =?utf-8?B?eDhJbWJWc0JHTVNCS2RQVmJNaWJIVFMxTXJ4NytBRkJjMmZ0MHFNM1AxQmhm?=
 =?utf-8?B?MWMrR1ZXcHdteGtjUDBDNitiaVNIa2p1OTUvbjlmYmV5YVFLS2cwMWpEa3Qw?=
 =?utf-8?B?T2N6Nm9NQVlzTUtYbktPMkFmUEhnOVpxUmQvNitNb2llLzFlcWRjcmFzUTkr?=
 =?utf-8?B?N1BadmVoQ1M5SytpVWUvVDNJM1BIeXhNVFJnYW1Mek9iSzRLRU1EcXE1U1NC?=
 =?utf-8?B?cXNuVFR0amYzOWNnM0V5S05ZSFkxRUYyb1FKbytoYVllNUwxeU5UZUpMeGVI?=
 =?utf-8?B?VGVMcUFPTVk5UGtwUmExU1htbVdLVFJmaW9lN2txTWNyWEZ5b3QxQmZ2Sktw?=
 =?utf-8?B?L0hqRlZqWnQvSFJQb21NcVgwV1NzS3VDRDJRdmtjMzViUStPQklHRDhtTHlQ?=
 =?utf-8?B?ZFdRdUlRQUM4QVp3TGtHWDRuVHpwbkkzSWRiMWM3NTJpUEdweDIyMXR2ME1Q?=
 =?utf-8?B?MGRQeFMwamJvdEZkQXJzMTVrMzRVWU15WUFzQmNjYVAvaEhLZCszMy9RanNi?=
 =?utf-8?B?QkVNaXdkSzNiTGt6emp1RW5zRXNLK0p2dkZWWnRwUExIam5TTUEyelJuVFVq?=
 =?utf-8?B?Z0NIcnVManBtQWhKaGQyTWJRb1F6N1RJMHhLSGxxYlA1bkc3WFRzSGhraW90?=
 =?utf-8?B?bTJjR2tjTUpUUGNXeHJhVGovbFVWcncvTCtXNkZRcFZPZzNZa0VlVFFGWmxq?=
 =?utf-8?B?RlNleGZNMHdtMW1kV1BxcDhIaG1oVEwzejE5UkZlUFo5STl4Yk53aDVFQmp4?=
 =?utf-8?B?NnRLVmMrYXhYeDQ0MTNDazBlUk9xUWJISTJrSno2VGFmSkEwemxvZFpvOExu?=
 =?utf-8?B?bWI0bExDREhmT2E3MDJRaHBNTnNxMlRMMUNPNHlpNE5ad2lZeFpFZk1mTkpI?=
 =?utf-8?B?ek5McFFPRHZHWWFXSEpyNFh3dFU1Sy83RmJUeS9qN1FnUG0wS3NHUmM4MlVk?=
 =?utf-8?B?WXYvL25xY1A4cndIaGVucWpKbTBvMW1wOHRrNzh6U3hiSGdzWGpia2xERjA1?=
 =?utf-8?B?RUYwMFVtT1o1UnVVT3l4eUtWMnFRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3588da-2dd2-44d2-4468-08d9ecd0de65
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 20:06:47.9885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozlSmX6qIuSUpgHOkXd5/lEruYyIKa0lAoyIQO+vgCNmpNYeFUayGsGwofCisqKXAaoOfExQdM3Xgl0DiU+/MNjrS9Mgzh4ie3YomZcfWl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3005
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100105
X-Proofpoint-GUID: VHhy8P3zNCQaq7kKZgr9rLkW7w5AGDrI
X-Proofpoint-ORIG-GUID: VHhy8P3zNCQaq7kKZgr9rLkW7w5AGDrI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 01:22, Petr Mladek wrote:
> On Wed 2022-02-02 09:18:17, Stephen Brennan wrote:
>> When a caller writes heavily to the kernel log (e.g. writing to
>> /dev/kmsg in a loop) while another panics, there's currently a high
>> likelihood of a deadlock (see patch 2 for the full description of this
>> deadlock).
>>
>> The principle fix is to disable the optimistic spin once panic_cpu is
>> set, so the panic CPU doesn't spin waiting for a halted CPU to hand over
>> the console_sem.
>>
>> However, this exposed us to a livelock situation, where the panic CPU
>> holds the console_sem, and another CPU could fill up the log buffer
>> faster than the consoles could drain it, preventing the panic from
>> progressing and halting the other CPUs. To avoid this, patch 3 adds a
>> mechanism to suppress printk (from non-panic-CPU) during panic, if we
>> reach a threshold of dropped messages.
>>
>> A major goal with all of these patches is to try to decrease the
>> likelihood that another CPU is holding the console_sem when we halt it
>> in panic(). This reduces the odds of needing to break locks and
>> potentially encountering further deadlocks with the console drivers.
>>
>> To test, I use the following script, kmsg_panic.sh:
>>
>>      #!/bin/bash
>>      date
>>      # 991 chars (based on log buffer size):
>>      chars="$(printf 'a%.0s' {1..991})"
>>      while :; do
>>          echo $chars > /dev/kmsg
>>      done &
>>      echo c > /proc/sysrq-trigger &
>>      date
>>      exit
>>
>> I defined a hang as any time the system did not reboot to a login prompt
>> on the serial console within 60 seconds. Here are the statistics on
>> hangs using this script, before and after the patch.
>>
>> before:  776 hangs / 1484 trials - 52.3%
>> after :    0 hangs /  15k trials -  0.0%
>>
>> Stephen Brennan (4):
>>    printk: Add panic_in_progress helper
>>    printk: disable optimistic spin during panic
>>    printk: Avoid livelock with heavy printk during panic
>>    printk: Drop console_sem during panic
>>
>>   kernel/printk/printk.c | 55 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 54 insertions(+), 1 deletion(-)
> 
> For the entire patchset:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> It looks ready for linux-next from my POV. I am going to push it early
> next week unless anyone complains in the meantime.
Thank you Petr! It occurs to me that some of this could be 
stable-worthy, depending on your feelings on it. Patches 1-3 resolve 
real bugs on customer systems, and they'd apply back a decent way. 1-2 
apply all the way back to 4.14, and 3 would apply with some minor 
changes. I suppose the question is whether they are simple enough. Patch 
4 is useful but I don't have a real reproducer for a bug it fixes, so I 
wouldn't say it's stable worthy.

Of course we have the logbuf_lock in 5.10 and previous, and if a CPU is 
halted holding that lock, then printk hangs even before the optimistic 
spinning. I have patches which reinitialize those locks after the CPUs 
are halted if necessary. I think they are reasonable for stable - printk 
is guaranteed to hang without doing this, so in the worst case you trade 
a hang during a panic, with some other sort of printk log buffer bug 
during a panic. But in the common case, you eliminate the hang. I can 
send that patch to linux-stable as well.

What do you think about these patches and stable?

Thanks again,
Stephen

> 
> Best Regards,
> Petr Mladek
