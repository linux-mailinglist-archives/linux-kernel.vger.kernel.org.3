Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1EC48BCE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348208AbiALCHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:07:21 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:6896 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234988AbiALCHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:07:18 -0500
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20C1gAQl022595;
        Wed, 12 Jan 2022 02:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=2LRk+p+U/AgAv1x5YAxZw9tbesRQ913FOWrXDty9ar8=;
 b=d/djdf0FFSjzXY5VQAIqs6BjcrDfWxH4EwlFLk4Vd+sl8euQ+ilTklh7e3U0dh2E5Psn
 8heq2cLwuIK5YCeVXFwlATjD7cGVx0HS1Whu78JUyBS6WVcyp/ckn7f/p0OJ8j3Csce6
 UR577R/gNwTGcK4zcqKGTrEEObXaKU7Bb1VO19QUE+ipA67Zcq3TxOAzerJeH6Rf+iE9
 Jz/uAsRjwPaTJrleLdw8GssgwVQplmJNmn4Dxdu52HanxYb6pSPFJs8Hr6jEEpMCe0es
 Pi87PA/XQwrYwNJJgf114zIJGQ6e5lHmqFS3C0nuIN6u2J26e8GtgsxyIOkh+tQEO2c1 DA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dgd99hjw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 02:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMX1CDxPFUI2iIx+lfBD7C+Q6BF6gzDlAzDzfxYcMW6pc0j+b3qzyLPorQX/OpMSTd5+HM0ExthN2akayno3aYdgFAcp8nXao6wHc9fiiuSofAEOZFWR3g4bP5JgJYSuQw5YdQ4mGMey+lWe2gbVOAksyHtJRlE00j4g+8gdssNp/T7U7o+Wp54h3LnDpPfgRvGvESm1wgpf2rI3O+dcLM7A7TwfEcSbmngMaywe6shKzBJyqNjcjF2lsvzsKlRrd4J4G50W89PZYF1Kh1eLNHtYy8c6UgaMR2HEfh/uS2k928z4t6ZpD69W7Vcv714DqgLCAT/jxlKnCfQV8ejaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LRk+p+U/AgAv1x5YAxZw9tbesRQ913FOWrXDty9ar8=;
 b=LXo77cV90afmeEiYoaulmSFgmCYSQw2esKj+DRcnlrREKXxmQay30ThOW87pJOuAYz0QO1yHohpdJzcRNe+9OLJRBI/kSIEKzBj8+hfWeDWQ40CsXsCOOUbndgFp13jc5X3PoolP3U1QtPkhdsL1P+h4fMHDqXl5+YsjoLC/Tv++6gtwNoctUgQiTeGWF1U6ymOwsZhDcYcbcoMtgB9XSImuxlgSqOS5RYIRpJ9XWINYEwitGQ4oK5RdU5qkSsp8NmOsg3em5NifEPxL569GVOGZWLE/USQw6MKzTdI/lWMVnRZ4dhTjWyi0Yxn/nJZqA2x39nrOq3XagklNZbYF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16)
 by BN6PR1101MB2209.namprd11.prod.outlook.com (2603:10b6:405:50::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 02:07:07 +0000
Received: from CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::dd33:eca5:868e:f800]) by CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::dd33:eca5:868e:f800%7]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 02:07:07 +0000
Subject: Re: [PATCH] platform/x86: ISST: do not hold lock punit_misc_dev_lock
 when register misc
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        HansdeGoede <hdegoede@redhat.com>,
        MarkGross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111103122.32362-1-liwei.song@windriver.com>
 <3d677ec215006f2b4d08f1bd32c040e88d53ebde.camel@linux.intel.com>
From:   Liwei Song <liwei.song@windriver.com>
Message-ID: <bdcdc712-318e-d44c-d11e-d49ab7886e2b@windriver.com>
Date:   Wed, 12 Jan 2022 10:06:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <3d677ec215006f2b4d08f1bd32c040e88d53ebde.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:202:17::25) To CH0PR11MB5348.namprd11.prod.outlook.com
 (2603:10b6:610:bb::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dc2dcdc-5bd2-409f-4d6f-08d9d5703be4
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2209:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1101MB22099CA45F1D4F510D1EB2B39E529@BN6PR1101MB2209.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUxdbs/GTMMdN4W7iFDNYwoT8iSJFZs8BQeqVESDTmrAdEY9iwZkOc01rJetzHezb79+oN5fAtorTx/661PQclu1PCYurHN+rSbGUoefM9BwFHng5q+MqTTGnVOD/ruXtHG0FPINMv/3Lr2fDJ3FQTZeREyRJRSo38nqKw3XMyciwfBy1YWYxQhVVAhpdb48MYqPwV3nVpMo89grJIry93P4X7kFtURDA2K3HL0nkAwkv7M/C2j+rOrATiXkpcirDhApx2dUz3+WOLI215GPscbIssdoSVCNktm52lICg4z+lwCidGp8gp8S2n8KlFHypZ/eczwwWeDd93LuU3IqgVu0zD/yALiHqlyIaKFUMujRowpzoVzb/YWWrHH0d+H5Bg3q3WVP0OqKrJX6wsSBpDAGL5TeNqL5dRc4+qMtr7g0Ivm1dNlXOMvj0+XzqXt+o436cn0Rf17RW5VlcZ4DxV2glZv+mzR2nJcakNqrY8cfANOUS6G/t0EItNExPlOMMU61yUkbh3daZoo2IMgAkj3RfbuSP+8yOgGrP/2bwHvHL6hvRv6cOa+7Vog/6OZR5OSxoPf/Lsqnw6GWLTIX89xJcvnqJnf342bd7CmGXsA2zmiNyeZdcJxRdqxIAmTC6gknE+t80NJ7Zggq/gfuoDdjjw4UJEagzpcaWOIYObNg4ro23NE1/PcT+MpXzqcuDNj9NQjYjB704J3N852EMegsVhkt9LPyPZt4emTtNLhbWItDG8oZUz5ljRgC4PtDShimb6DMmkRq1Wwb70Ouug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5348.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(36756003)(6666004)(8676002)(6512007)(316002)(66946007)(6506007)(8936002)(53546011)(110136005)(66556008)(66476007)(6486002)(26005)(2906002)(186003)(5660300002)(508600001)(52116002)(44832011)(2616005)(31686004)(86362001)(31696002)(38100700002)(38350700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUpBRHFJdTAxT1h6Y2ErOHJkYXJDdDJXOWhTWW1yWmdjVUJ1Y0wzOFRydndQ?=
 =?utf-8?B?YkliMjV3ZjA0Z0RIV2NJbU0wNW9RTUsxSHZrVndmZjBmaHdiWERDU0s5OXhF?=
 =?utf-8?B?VU01UkM0MnNQWEhISENWL3l4czkxZXltblQyZmp5RTN0K2NEY0EwUmVwV1ha?=
 =?utf-8?B?UlAwdkJDbzIxbGsycmNvamkwV2psWU9GSVZPK0V6M2ZJbXY5RE0xL3g5WWNZ?=
 =?utf-8?B?UUFxRjFOT3NVcTZ3WmVObTNibHNuU2hCWWMwamxOSUhlUzhhTTYraEVuMjBR?=
 =?utf-8?B?bENuWHZiMDJmZUhiZ2hEcWd0blE2UzdNZEYzVzFtbE92Y0JQdnljVjYvenkx?=
 =?utf-8?B?TWZOUldTYWZCNWRvV2Y1aWpwMW1tR1c4ZXhhZVVSY0RZR3BjTE9HT0N0ZW56?=
 =?utf-8?B?MFc2RXdRMS8wSHdXZ2JXTjJWNTBBV0s5d2p2WGZ1Zi9RWEtzdVNpNEpiQjRi?=
 =?utf-8?B?RU1QOVVSQnJVMVp5YW9sUEE2dG9CY0NzR0p1REI5VVRBSzk4MnpDSW0ycjc4?=
 =?utf-8?B?eFFTWEVKeTFjZ3FIWkJYeENKalJaL3dmZDBPanZBR3FpcUozVXpHYjJRK1Jj?=
 =?utf-8?B?MGNJREdyN3Vhd2JIUG9qSHBiNXNCNkdoYUVEMnlKbmtXV0UvYUMxcmRhK2Zx?=
 =?utf-8?B?cSs2UDlTRTArRy9lUVpFTlBNVWdQdnc0aU9TRGthUXRMVHNRS1UrWDNkaUJP?=
 =?utf-8?B?eGhySWNuS3FXd2svZ2k3QUVTdU1HYUtxV1BONVJPc2RVL0JLWHZ6SjdRM21r?=
 =?utf-8?B?K0JnNFh5K090NUtrT05RQmZndHJncHVNTVgrWkxROU1adHZCNzdTZ1lZWUFm?=
 =?utf-8?B?U1E4dU5jV0xVWlAwMHZUR0xFQXpXTGVLTEwvOWR5Tlp0M2lSRU9tTmpSbktJ?=
 =?utf-8?B?RHkyNlBvbjJrMlp5UlJUcnZQUzg5SHA4aHc1TWU2NkRHSU1EclBpWjNSZHRj?=
 =?utf-8?B?ZlpGOGNlTnc1Zm1CY1UrMXhKNFRlNlQ0V2haU3BPaVRsVWZjQTJ4UE53Nm42?=
 =?utf-8?B?K1QzbmpCNnl0UXZwN1NiWW9BMDBKakNsTjdkc2lCZWxiQ282eEcwVlQxanl6?=
 =?utf-8?B?cHdlMkMxM25BM05kVVRTNTRXZEZ4b3BIR0RJWHI5ZUJ3ck5PTlpaMHMxcWpq?=
 =?utf-8?B?ckZzVXUrRlliRmRXdFVMS0dTVjhiZUcxZmNkMzF2N2NBamhURTZRS1pPbEhH?=
 =?utf-8?B?RUNXRWxhZGtZRG9tZStxRTM2V1pxRUZnMEE3VE9vaUZFQ2FCbGhWNlJDS05j?=
 =?utf-8?B?TmNxNGIxeHp2RVhab0YzTFFOTmRrZkNhanJxU1RhK00vZVVSM2RpTXJ2MEI2?=
 =?utf-8?B?VElzcjRTdmtNOWJTbjJZYWg4UXloejFmbmE4dzZkQXNzUlRWcTdUMVZiNXdY?=
 =?utf-8?B?cXJ3V1pGZVRCUXZROElEMUNiVk9TTnl6cmhLN2NSdTh6WThVZ2I0Z1lxOVU3?=
 =?utf-8?B?bUJoVGpTNTB3TlRDWkIzWGRDWlFON3RkbHQxOGZmalNnTFc0OUM4cVFKVXZJ?=
 =?utf-8?B?ZlZhZi9Sa3VMVUY0LzJ2R0s5bDF5RDNnMFpKUEo1WkF3b3ozeHFRMDE2NTdu?=
 =?utf-8?B?WkRYZUxzN2h5Z2hRVnY1SU03WG50cHRXQzhEWm4xR284bXhxaUZ0U3JzMlE4?=
 =?utf-8?B?TFVnZWluZi9iZFkzQzRmY0tvby9YNXdrSDZzMnZLS1kyTUhYY1NseDJJWjg3?=
 =?utf-8?B?RCtMeGxYUmhiVGJxNitnUjB3TlM0ZWFYUFRYM1p3RGhmZDM1Q3Z2aUY5aDJJ?=
 =?utf-8?B?UEczM2NoTHUzQ0F2Q1ZDdit2TWJNazdDaWFJNFdLS2JBYUppa1hWOERoL0RJ?=
 =?utf-8?B?eVRNeVJEM0s5M2FsRjdDV3hkWWVEZE8xbUVPb1pNOGVvZkIvNE15RUhla3BQ?=
 =?utf-8?B?L2RHOXoxVEsvRDE1d1BhWnFCUlNXbGI1TTkzdWNIT2NsSEp3aktVNXl1WWdB?=
 =?utf-8?B?UndYc0praDRPSjFGbGdyM1M5ZG1BNFl5OEVVbFE1SndrWW1rdjBqVWtLV2V6?=
 =?utf-8?B?VFpKV093TGd2by8vWFJ3NExFZ2tZWVNIOUphdC9PVmN6Nm5vRHNJVXp2b3pE?=
 =?utf-8?B?cWFYNDFZeUcrbE1GUXFJRnRMRGdTeTRzUENIUlU3Vms5emF1U2locVBaeDIz?=
 =?utf-8?B?ek9PLzdwOXZkU3QxYnhwRnZxWGF0S0F5RjFWU2JuZGRrSlg4Ykw4K0s3K1hU?=
 =?utf-8?B?WUowbm1NTnNkZkM3UDFTWDFLODZhbzRkZjJURHRPemZIWE1ZY1d5SjM0MWRI?=
 =?utf-8?B?WG8xTXNySWFFNlpmZ2NlU0gzK1pnPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc2dcdc-5bd2-409f-4d6f-08d9d5703be4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5348.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 02:07:07.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3ny046LEAV4vNMAEuEAo+Wy8/z8eNnMxZdA0bj4GdlG5dn0Mc+jm/4GCRNywlSsTGqJ639wRtiMSJ+HUigob6dsgEUqN0eokWNbhqdzk0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2209
X-Proofpoint-ORIG-GUID: VzNO-qnK6TBsKJPJD-7k0f4TRDVxZdhW
X-Proofpoint-GUID: VzNO-qnK6TBsKJPJD-7k0f4TRDVxZdhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_13,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/22 05:20, Srinivas Pandruvada wrote:
> Hi Song,
> 
> Please check the attached and see if you can reproduce this.

Hi Srinivas,

The attached patch works well without the deadlock warning, thank you for your help.

Thanks,
Liwei.


> 
> Thanks,
> Srinivas
> 
> On Tue, 2022-01-11 at 18:31 +0800, Liwei Song wrote:
>> exist the below call sequences may cause deadlock:
>>
>> isst_if_probe()
>>    --> isst_if_cdev_register()
>>       --> mutex_lock(&punit_misc_dev_lock)
>>    --> misc_register()
>>       --> mutex_lock(&misc_mtx)
>>
>> misc_open()
>>    --> mutex_lock(&misc_mtx)
>>    --> isst_if_open()
>>       --> mutex_lock(&punit_misc_dev_lock)
>>
>> to fix this do not hold punit_misc_dev_lock when call misc_register
>> since it has misc_mtx lock for sync.
>>
>> [  256.104522] ======================================================
>> [  256.113783] WARNING: possible circular locking dependency detected
>> [  256.120093] 5.16.0-rc6-yocto-standard+ #99 Not tainted
>> [  256.125362] ------------------------------------------------------
>> [  256.131673] intel-speed-sel/844 is trying to acquire lock:
>> [  256.137290] ffffffffc036f0d0 (punit_misc_dev_lock){+.+.}-{3:3},
>> at: isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.147171]
>> [  256.147171] but task is already holding lock:
>> [  256.153135] ffffffff8ee7cb50 (misc_mtx){+.+.}-{3:3}, at:
>> misc_open+0x2a/0x170
>> [  256.160407]
>> [  256.160407] which lock already depends on the new lock.
>> [  256.160407]
>> [  256.168712]
>> [  256.168712] the existing dependency chain (in reverse order) is:
>> [  256.176327]
>> [  256.176327] -> #1 (misc_mtx){+.+.}-{3:3}:
>> [  256.181946]        lock_acquire+0x1e6/0x330
>> [  256.186265]        __mutex_lock+0x9b/0x9b0
>> [  256.190497]        mutex_lock_nested+0x1b/0x20
>> [  256.195075]        misc_register+0x32/0x1a0
>> [  256.199390]        isst_if_cdev_register+0x65/0x180
>> [isst_if_common]
>> [  256.205878]        isst_if_probe+0x144/0x16e [isst_if_mmio]
>> [  256.209991] hrtimer: interrupt took 10370 ns
>> [  256.211582]        local_pci_probe+0x47/0xa0
>> [  256.220384]        work_for_cpu_fn+0x17/0x30
>> [  256.224790]        process_one_work+0x26a/0x650
>> [  256.229456]        worker_thread+0x1dd/0x3b0
>> [  256.233861]        kthread+0x191/0x1c0
>> [  256.237745]        ret_from_fork+0x1f/0x30
>> [  256.241976]
>> [  256.241976] -> #0 (punit_misc_dev_lock){+.+.}-{3:3}:
>> [  256.248552]        validate_chain+0xbc6/0x1750
>> [  256.253131]        __lock_acquire+0x88c/0xc10
>> [  256.257618]        lock_acquire+0x1e6/0x330
>> [  256.261933]        __mutex_lock+0x9b/0x9b0
>> [  256.266165]        mutex_lock_nested+0x1b/0x20
>> [  256.270739]        isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.276356]        misc_open+0x100/0x170
>> [  256.280409]        chrdev_open+0xa5/0x1e0
>> [  256.284550]        do_dentry_open+0x23d/0x3c0
>> [  256.289039]        vfs_open+0x2f/0x40
>> [  256.292836]        path_openat+0x87a/0x940
>> [  256.297064]        do_filp_open+0xc5/0x140
>> [  256.301295]        do_sys_openat2+0x23d/0x320
>> [  256.305782]        do_sys_open+0x59/0x80
>> [  256.309836]        __x64_sys_openat+0x20/0x30
>> [  256.314324]        do_syscall_64+0x3f/0x90
>> [  256.318552]        entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  256.324259]
>> [  256.324259] other info that might help us debug this:
>> [  256.324259]
>> [  256.332394]  Possible unsafe locking scenario:
>> [  256.332394]
>> [  256.338444]        CPU0                    CPU1
>> [  256.343105]        ----                    ----
>> [  256.347768]   lock(misc_mtx);
>> [  256.350870]                                lock(punit_misc_dev_loc
>> k);
>> [  256.357441]                                lock(misc_mtx);
>> [  256.363058]   lock(punit_misc_dev_lock);
>> [  256.367110]
>> [  256.367110]  *** DEADLOCK ***
>> [  256.367110]
>> [  256.373162] 1 lock held by intel-speed-sel/844:
>> [  256.377824]  #0: ffffffff8ee7cb50 (misc_mtx){+.+.}-{3:3}, at:
>> misc_open+0x2a/0x170
>> [  256.385531]
>> [  256.385531] stack backtrace:
>> [  256.390021] CPU: 12 PID: 844 Comm: intel-speed-sel Not tainted
>> 5.16.0-rc6-yocto-standard+ #99
>> [  256.398678] Hardware name: ACCTON MOROCITY/MOROCITY, BIOS
>> IDVLCRB1.86B.0021.D09.2111010103 11/01/2021
>> [  256.408028] Call Trace:
>> [  256.410605]  <TASK>
>> [  256.412837]  dump_stack_lvl+0x5b/0x82
>> [  256.416635]  dump_stack+0x10/0x12
>> [  256.420085]  print_circular_bug.isra.43+0x261/0x2c0
>> [  256.425095]  check_noncircular+0x126/0x140
>> [  256.429326]  ? __this_cpu_preempt_check+0x13/0x20
>> [  256.434167]  validate_chain+0xbc6/0x1750
>> [  256.438223]  ? validate_chain+0xbc6/0x1750
>> [  256.442451]  ? validate_chain+0x236/0x1750
>> [  256.446687]  __lock_acquire+0x88c/0xc10
>> [  256.450658]  lock_acquire+0x1e6/0x330
>> [  256.454452]  ? isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.459726]  ? __mutex_lock+0x79/0x9b0
>> [  256.463610]  ? __mutex_lock+0x79/0x9b0
>> [  256.467493]  ? isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.472764]  ? isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.478038]  __mutex_lock+0x9b/0x9b0
>> [  256.481748]  ? isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.487021]  ? __mutex_lock+0x102/0x9b0
>> [  256.490993]  ? __this_cpu_preempt_check+0x13/0x20
>> [  256.495837]  mutex_lock_nested+0x1b/0x20
>> [  256.499893]  ? mutex_lock_nested+0x1b/0x20
>> [  256.504121]  isst_if_open+0x18/0x90 [isst_if_common]
>> [  256.509222]  misc_open+0x100/0x170
>> [  256.512759]  chrdev_open+0xa5/0x1e0
>> [  256.516386]  ? cdev_put.part.1+0x20/0x20
>> [  256.520441]  do_dentry_open+0x23d/0x3c0
>> [  256.524414]  vfs_open+0x2f/0x40
>> [  256.527689]  path_openat+0x87a/0x940
>> [  256.531399]  do_filp_open+0xc5/0x140
>> [  256.535112]  ? trace_preempt_on+0x28/0xd0
>> [  256.539255]  ? alloc_fd+0x152/0x230
>> [  256.542880]  ? preempt_count_sub+0x9b/0x100
>> [  256.547200]  ? _raw_spin_unlock+0x2c/0x50
>> [  256.551348]  do_sys_openat2+0x23d/0x320
>> [  256.555320]  ? do_sys_openat2+0x23d/0x320
>> [  256.559467]  do_sys_open+0x59/0x80
>> [  256.563003]  __x64_sys_openat+0x20/0x30
>> [  256.566972]  do_syscall_64+0x3f/0x90
>> [  256.570680]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  256.575866] RIP: 0033:0x7f9be4b97c27
>> [  256.579576] Code: 25 00 00 41 00 3d 00 00 41 00 74 37 64 8b 04 25
>> 18 00 00 00 85 c0 75 5b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00
>> 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 85 00 00 00 48 83 c4 68 5d 41 5c
>> c3 0f 1f
>> [  256.598474] RSP: 002b:00007ffd8fc01b70 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000101
>> [  256.606177] RAX: ffffffffffffffda RBX: 00005572f20332b0 RCX:
>> 00007f9be4b97c27
>> [  256.613443] RDX: 0000000000000000 RSI: 00005572f202936a RDI:
>> 00000000ffffff9c
>> [  256.620709] RBP: 00005572f202936a R08: 0000000000000008 R09:
>> 0000000000000001
>> [  256.627974] R10: 0000000000000000 R11: 0000000000000246 R12:
>> 0000000000000000
>> [  256.635241] R13: 00005572f20332b0 R14: 0000000000000001 R15:
>> 0000000000000000
>> [  256.642513]  </TASK>
>>
>> Signed-off-by: Liwei Song <liwei.song@windriver.com>
>> ---
>>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 6
>> +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git
>> a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>> b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>> index c9a85eb2e860..bcbc0d508ec4 100644
>> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>> @@ -693,10 +693,12 @@ int isst_if_cdev_register(int device_type,
>> struct isst_if_cmd_cb *cb)
>>  	if (!misc_usage_count) {
>>  		int ret;
>>  
>> +		mutex_unlock(&punit_misc_dev_lock);
>>  		misc_device_ret = misc_register(&isst_if_char_driver);
>>  		if (misc_device_ret)
>> -			goto unlock_exit;
>> +			return misc_device_ret;
>>  
>> +		mutex_lock(&punit_misc_dev_lock);
>>  		ret = isst_if_cpu_info_init();
>>  		if (ret) {
>>  			misc_deregister(&isst_if_char_driver);
>> @@ -731,7 +733,9 @@ void isst_if_cdev_unregister(int device_type)
>>  	if (device_type == ISST_IF_DEV_MBOX)
>>  		isst_delete_hash();
>>  	if (!misc_usage_count && !misc_device_ret) {
>> +		mutex_unlock(&punit_misc_dev_lock);
>>  		misc_deregister(&isst_if_char_driver);
>> +		mutex_lock(&punit_misc_dev_lock);
>>  		isst_if_cpu_info_exit();
>>  	}
>>  	mutex_unlock(&punit_misc_dev_lock);
