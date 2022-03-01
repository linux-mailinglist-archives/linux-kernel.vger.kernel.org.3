Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F11E4C916E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiCARYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiCARYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:24:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708AC3630F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:23:27 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221Gb1kJ030734;
        Tue, 1 Mar 2022 17:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2VvizOzOuPTAj7HuT3zbIn+GnTrob2/mtqBRbU1SXiU=;
 b=mzjnXb9BbJbkntKi2URx6woevpzghgDqWOrIuLecA2Onej+RPL3My9Ne0q68kzdDnVAu
 e0Bn6d78tqz7lKgMz+NOfkZbxNGx8d1GMIvfq2Z0AdaCkxnPFvoPcrZQo88amL9XIo2y
 iKmJNXLxGDIl8vbnSr2eOR1n7hiNxdDbP/dP9M0RzSt4j4B3I7aOxJ508Xbt0Gc9U/Wr
 8rbZQl3vvQlTQWMGkluEszYHXzgPy0riqwRf9I1M4SZtjIxwUMXGCejMHJkOyPWdxuea
 NRkT7mIWjGvyQddBOJuvPtTC50Y/TRNH4Cq7GEB3Z/gM4oRvPbhdNPgVLJQnYBUEgyLJ 3Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh14buhn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 17:21:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221HBKKS133310;
        Tue, 1 Mar 2022 17:21:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 3efdnn67g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 17:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atkh1ZJrWfbdwrvgrSPNlz9Y22EqE9Xtk8QNmDvI780heD4DgvqcBMinkeg2pDUluW7cvMODFTAOCZGVI6XrSChzWuiHg/krndycJ/ZdNieOCDPOG+7FmdQQy/PG8hn19mDw+cN1y9L2yfZ1RihHJohKuhOb4qppySIXHzygmoYQKtcStzVWqr0qCK79IOWS5cbkDDQo70ObGU8tXVHRFehxiZjf7i/bMmdbdB2YDO6EBGhLDBJVRAqNA6o2hrfxqyrgLJ75szun0qPY37hlTpfuYkJRZwaPdXXH5KYHfMPyoa8oh4eZ/kookUPJObntwdhhCLgpJHQM3H91d/FguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VvizOzOuPTAj7HuT3zbIn+GnTrob2/mtqBRbU1SXiU=;
 b=KIkFMOK3jyF2xgzZwhp+lN1x3q7YNYX2StuQ7pgQIj2qn6dLBq22DjX2tcYFB6BJbRBTeTTVjlJIX8k4lO0YsIxiCzuUcx+tV6JCdBF2lYoxqZRtK0lpEE8ABJSO33gNV96OL1P914LJYQiliResKQ++EZa0AugulA2LZeiHEoWB8EbnGyju/lGHyGeMDeh9k9ceiMQGjOkGo6vcThXvbgnAW5EfLInTbeyQy4Qfvvr5+DxNF+IJh73XnLRPI8SyD4uhy3Wd73l1Lfsi3To2Nc2CoJaTmWtHHlerxLczBEfo4fGYXXbYtiALJJ1FrzZvHoMhiOrirR0RIddiM3DuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VvizOzOuPTAj7HuT3zbIn+GnTrob2/mtqBRbU1SXiU=;
 b=srxrjkWJ/7NzED2+Trk6grYZIeStN7H4GbSa13XBcFwXXIjgu/EfOFceOI0y6udgWlZE4jFlzu3f2pjJ2zcCOZSz7vTa/lDkac5RiaYz/3CPgTRnwPciJTTBg6ElKbMjR3YRSPlZeNPL5knJujrKJCjFnG9agr/bGA4P5BD8Su0=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 17:21:46 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7%3]) with mapi id 15.20.5038.014; Tue, 1 Mar 2022
 17:21:46 +0000
Message-ID: <a60bf68f-51a5-70e6-e525-09a62cd6fb74@oracle.com>
Date:   Tue, 1 Mar 2022 12:21:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 0/1] xen: fix HVM kexec kernel panic
Content-Language: en-US
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        joe.jin@oracle.com, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20220224215049.2845-1-dongli.zhang@oracle.com>
 <9de1059b-6b48-e2c8-60bc-f29b42b217f7@oracle.com>
 <36014dbd-e63c-cf49-dafd-2d7a8b84db5d@oracle.com>
 <8e3e4716-22e7-8684-394c-b5a457906975@oracle.com>
 <a6d64481-cb70-d797-fafd-b827288f7e53@oracle.com>
 <1a5a683d-17c8-9730-d2f5-745262430569@oracle.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <1a5a683d-17c8-9730-d2f5-745262430569@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::10) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dcbc3af-9376-4339-9145-08d9fba7f686
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB37354B1E5FE8460279FFC6718A029@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYM04L6TQ8yMr/FSKYUWVCeRzxf6ipqyH4SYjBX52V8PFr8xhzZjo/yZ5oadRmM/IrZtDPBHGF0czqPNja0mietVHgwbdZlHkBtoif04dEQBOX5ljDfavnl750WIxQxPCMzOGYcacxN4D2Wy8KmycXT7FE2+SiR+nvtr91fNHW704DeKY15kkOz9n+KSWYoZv651KVz0ALoYxRxiQWC6y5ezU2vm7kpbHCJTYw3Mucfey3FPmYamEM9nZSnsy2967RWF7wRFFUV8I7M85kvuaKtPRQhgUpuOejIMz67VMTn6zJLcqYn7cTweF1qXb5yz7M+JdxjGfOEdKPUvLeghfAXyZeyLj53W1qoIyvciNjg3KvDUGmwj0oOKPqR7wBwdsgObZZjOv4saND7epzbPJk2X/KD75IDdlFsn7MzvY6tu6zIXRwxqba1Scspt5ZUnkrvbrl2/tC0C4X5k5ncHTsrX0Cl30doFjWy7ewZVrM/Q2RPb8PRs0s7Wx36UUUdRTeqA/5bffEK1kcnBWYeYtYSZjSiOm4o2yfd11JHzqDGojQ202alkLQO0LlCejQaB4GM2jOB80GkOF28X2yhr43B+uTVbrDwSdTjIXpkRmgufT7ItvYsBeYgZVe4j4jbM26eKI/e1MbzGZ5Zu0K9k1OE4KzaXiJCbkF/62OsePHsfy0Q/7qlxk7aQNUOrHqpE4q3QAxDl+6c4pf28O44hv1FyIWAvp8CHVfx8mzkyVe4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(6862004)(2906002)(31696002)(4326008)(66556008)(8676002)(86362001)(5660300002)(66946007)(36756003)(6486002)(508600001)(7416002)(8936002)(31686004)(44832011)(38100700002)(37006003)(83380400001)(53546011)(2616005)(316002)(6512007)(6666004)(6636002)(186003)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S01UR1FYUEJ4c1RtQjg0SWlzVXkrMjg4bVNjd0U4dy9mRGJnc2E3MEl4T0pI?=
 =?utf-8?B?RmlmSnhCM3grSEJUN3BlTWVkQ2JYVXl4bkNvRkRZaFdhV2sycWg4UUtCK1JX?=
 =?utf-8?B?emV5OGw1ZEw5bVRJaFRrY2ZZNGp6bFJKOTFRdUxmME1hbE9PU3N0VXdjaHVP?=
 =?utf-8?B?ZWhhdTUxcWdCWldwVTMrWE92ZExZc3ZvNWlSbndoTU8rWkJKYndxVmxvVnBF?=
 =?utf-8?B?VnhMWHRFUDYwUHdLRWhBYlBGc3UzOUlnc0RqZFk3NWZRZjlBcFF5WVhyb0pI?=
 =?utf-8?B?RGNSbWpVeGowcjRLTHdsTmdCczhPc2NtNmJ5TGdSbmpHaTZJQUlCZFZPdFFS?=
 =?utf-8?B?RHZtUnFnbFBYK3FEZXp0eDVacksyQndKU0t5eVhkdFU2TlJ0OFpCR0R2QWVE?=
 =?utf-8?B?TDJocDV3M2Q3Y2Q5SXFmVkJFU2k2bXNlWUdlQkZOVlQ4aDAwd0s3RVVWbnBz?=
 =?utf-8?B?M3p3eENGc054Q1FNb3A2MjAyZGd0ZEgvRW9lWDVGSkFWUDlwSHpZMENFSTdE?=
 =?utf-8?B?K3R6dzRRMk5mc3ZiUHFqV3NEUXB6VkczTnRDZkVXRlNhSVlRNHM0eXo4bDhI?=
 =?utf-8?B?YnhJMjFGRmFqa2RtMiszR1hCYmY3THFyMTZNaS9jWUlQSEkzeGlqdDJlbUtM?=
 =?utf-8?B?cFA3TGZLYnRwdFlDYUJRNk9mUzRzOTMxbkhycmdjMFByR096VE9iZk1rL1Ev?=
 =?utf-8?B?SEZ6Z1VXYnRIbkR0UGF4My9SNjRPbnFEbmI3SW1mdUsyWmc0RjRJa2c4Tk5L?=
 =?utf-8?B?RFhJMThNdG5YTlN2Y3dBVDZXZHBHQVFSQjZ6bTF2TEJaWUlLZlBNZldpWFox?=
 =?utf-8?B?V1IvQjJRazU5VTkzbnFlTjRIbHN3SC80blBkQjZXWStldm43QlNWcU1VZHVN?=
 =?utf-8?B?TTljTlRGWklvRTNta2FCdUJFOGl4dFlNSy9NN2piNHNmSDlBRWwzaXRtWENm?=
 =?utf-8?B?SVhGSGU5N3dzYXh4bExnM0hhMWtYNVlxdFFXVDN1WmJiSmhMaDlEempoV2Nm?=
 =?utf-8?B?QXRJalh1UURrdGYzVEJNdWxGOHp6NTVmdmc3Y2E4RSthOXk4OWQ4Zy9neXNN?=
 =?utf-8?B?M1R1TWdqdUlaSUFMVllhNCtlS2pmNENBNjJLUlVlMkRyZWhpWWdtcnlXSjBY?=
 =?utf-8?B?WHhtMEsrVURtL25hT2d0T1JTSTlPb09TbXNSNmRObVJnL0t3VTVLQ3VZbWVi?=
 =?utf-8?B?WGVFNGlBTzFhbnQ1TWFJVzB6eVp2WDc4K0FIdHdwOVlqYWtxSE0yWFNOTTc2?=
 =?utf-8?B?dFdDdldEeWMvanhOeSs3SU85RHVCaFlOc2V0UWNmaVFzTmU0dEJ6dFh6bHYv?=
 =?utf-8?B?NVp4WWM3NFIvU2JIMlI5NGcvSnMzaFhkVVRxRFBBRGRiemRzb2xVazVoUjRu?=
 =?utf-8?B?NGNad3FFYkduU1JhZHF0Mk9YZGlqRlV6ZU1idlpENVo3OSt1QXByYktpL2dX?=
 =?utf-8?B?WHpLRldlcFhJb2VjNjlrWFo5K3c1aG9LSUJrTmtQUW9idit1aUhtKyt2S2VF?=
 =?utf-8?B?c00xRjdLSXQ3UWJUR25ob1htMUo0SGJ4dFN5WHY2YmdtNXk5YzVya0V5L1A3?=
 =?utf-8?B?K0J6ZTg4bmw4NTduUGNDQ0N0N0Q0Z1JFZTAwSi9tOTdYVUdBclRBZ2RIZG1K?=
 =?utf-8?B?ZXNZRUNaTUlLclpQcHhrcVVBOG04TGxJNktOT21Hb0NLZitWRHQ3c3dSSVgw?=
 =?utf-8?B?aG1EZ0M0TndDTVVKMDBydmQxYkhMa3JUSmZHYjUyejljVkh4YUsvMFdGM3M1?=
 =?utf-8?B?cEJaaWNXaDJPbEMxUmIrdHord3NBTkhFa08vbUZPT2VhWXRUMVY5OEFTcDhM?=
 =?utf-8?B?RFZETHZ6TzhYdmxVM2hSTFQrcXVRT251TDdqSVQrYW5hZjlVZTVIMzhOOGtP?=
 =?utf-8?B?cUdwaWs5emFYZjVrNnllVk5kS0JnUDcyc0ErQW9YVWNDaDBXc0c1WWt0TGxV?=
 =?utf-8?B?Sk5SQkxSNlZXNkkyNHA2bjQ3eHJKa3hzSzhNMnZ2TmdWRytaektYY2JmaXJC?=
 =?utf-8?B?d0ZtTVpxQ0pvMXY4N3B0aVhCK1IrNUVGd0RKeTB0L0lXcmtQakNJSCtnaDJG?=
 =?utf-8?B?UE1TQnNRSGxOelFpV2ZyVHB5WkxsZ3YxMmpacnR0U2M1Wi9KYnFGQ0NrUmZZ?=
 =?utf-8?B?eHpiWkRCc2lJL3o0UzhvNUF3MkhBM011UVIwR1ZVYTVlMHc3ZDF4M2RjRTht?=
 =?utf-8?B?V0NWdUg4anhmNGhOWFFwcUo4UzBlQ29kNFZydjhEODk3dUJ4OFZTODV2YzZX?=
 =?utf-8?B?Z0h0M010eXVjMXNybXVZSjRjaFNnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcbc3af-9376-4339-9145-08d9fba7f686
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 17:21:46.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mQFtqQMEuKoGfp+IqX0ILB6SdYjABqFtiDGxc0ssjEItl0XKnEZzfrl5Yn1/PjIgIBUkXIbvVyGBMeWjQMw6OgrVE8L/leb29JZU0kTVFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010090
X-Proofpoint-GUID: xKoXMw0UF3TN4vlVI_TJUE4uNaFuIwYy
X-Proofpoint-ORIG-GUID: xKoXMw0UF3TN4vlVI_TJUE4uNaFuIwYy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/28/22 11:56 PM, Dongli Zhang wrote:
> Hi Boris,
>
> On 2/28/22 5:18 PM, Dongli Zhang wrote:
>> Hi Boris,
>>
>> On 2/28/22 12:45 PM, Boris Ostrovsky wrote:
>>>
>>> On 2/25/22 8:17 PM, Dongli Zhang wrote:
>>>> Hi Boris,
>>>>
>>>> On 2/25/22 2:39 PM, Boris Ostrovsky wrote:
>>>>> On 2/24/22 4:50 PM, Dongli Zhang wrote:
>>>>>> This is the v3 of the patch to fix xen kexec kernel panic issue when the
>>>>>> kexec is triggered on VCPU >= 32.
>>>>>>
>>>>>> PANIC: early exception 0x0e IP 10:ffffffffa96679b6 error 0 cr2 0x20
>>>>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
>>>>>> 5.17.0-rc4xen-00054-gf71077a4d84b-dirty #1
>>>>>> [    0.000000] Hardware name: Xen HVM domU, BIOS 4.4.4OVM 12/15/2020
>>>>>> [    0.000000] RIP: 0010:pvclock_clocksource_read+0x6/0xb0
>>>>>> ... ...
>>>>>> [    0.000000] RSP: 0000:ffffffffaae03e10 EFLAGS: 00010082 ORIG_RAX:
>>>>>> 0000000000000000
>>>>>> [    0.000000] RAX: 0000000000000000 RBX: 0000000000010000 RCX:
>>>>>> 0000000000000002
>>>>>> [    0.000000] RDX: 0000000000000003 RSI: ffffffffaac37515 RDI:
>>>>>> 0000000000000020
>>>>>> [    0.000000] RBP: 0000000000011000 R08: 0000000000000000 R09:
>>>>>> 0000000000000001
>>>>>> [    0.000000] R10: ffffffffaae03df8 R11: ffffffffaae03c68 R12:
>>>>>> 0000000040000004
>>>>>> [    0.000000] R13: ffffffffaae03e50 R14: 0000000000000000 R15:
>>>>>> 0000000000000000
>>>>>> [    0.000000] FS:  0000000000000000(0000) GS:ffffffffab588000(0000)
>>>>>> knlGS:0000000000000000
>>>>>> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [    0.000000] CR2: 0000000000000020 CR3: 00000000ea410000 CR4:
>>>>>> 00000000000406a0
>>>>>> [    0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>>>>> 0000000000000000
>>>>>> [    0.000000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>>>> 0000000000000400
>>>>>> [    0.000000] Call Trace:
>>>>>> [    0.000000]  <TASK>
>>>>>> [    0.000000]  ? xen_clocksource_read+0x24/0x40
>>>>>
>>>>> This is done to set xen_sched_clock_offset which I think will not be used for a
>>>>> while, until sched_clock is called (and the other two uses are for
>>>>> suspend/resume)
>>>>>
>>>>>
>>>>> Can we simply defer 'xen_sched_clock_offset = xen_clocksource_read();' until
>>>>> after all vcpu areas are properly set? Or are there other uses of
>>>>> xen_clocksource_read() before ?
>>>>>
>>>> I have tested that below patch will panic kdump kernel.
>>>>
>>>
>>>
>>> Oh well, so much for that then. Yes, sched_clock() is at least called from
>>> printk path.
>>>
>>>
>>> I guess we will have to go with v2 then, we don't want to start seeing time
>>> going back, even if only with older hypervisors. The only thing I might ask is
>>> that you roll the logic inside xen_hvm_init_time_ops(). Something like
>>>
>>>
>>> xen_hvm_init_time_ops()
>>> {
>>>      /*
>>>       * Wait until per_cpu(xen_vcpu, 0) is initialized which may happen
>>>       * later (e.g. when kdump kernel runs on >=MAX_VIRT_CPUS vcpu)
>>>       */
>>>      if (__this_cpu_read(xen_vcpu_nr(0)) == NULL)
>>>          return;
>>>
>> I think you meant __this_cpu_read(xen_vcpu).
>>
>> I will call xen_hvm_init_time_ops() at both places, and move the logic into
>> xen_hvm_init_time_ops().
>>
>> Thank you very much!
>>
>> Dongli Zhang
>>
>
> How about we do not move the logic into xen_hvm_init_time_ops()?
>
> Suppose we move the logic into xen_hvm_init_time_ops() line 573, the line line
> 570 might be printed twice.


You would need to make sure the routine is executed only once so something like a local static variable would be needed.


>
>
> 559 void __init xen_hvm_init_time_ops(void)
> 560 {
> 561         /*
> 562          * vector callback is needed otherwise we cannot receive interrupts
> 563          * on cpu > 0 and at this point we don't know how many cpus are
> 564          * available.
> 565          */
> 566         if (!xen_have_vector_callback)
> 567                 return;
> 568
> 569         if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
> 570                 pr_info("Xen doesn't support pvclock on HVM, disable pv timer");
> 571                 return;
> 572         }
> 573
> 574         xen_init_time_common();
> 575
> 576         x86_init.timers.setup_percpu_clockev = xen_time_init;
> 577         x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
> 578
> 579         x86_platform.set_wallclock = xen_set_wallclock;
> 580 }
>
> I feel the code looks better if we keep the logic at caller side. Would you mind
> letting me know your feedback?


My preference is to keep logic concentrated in one place whenever possible.


-boris

