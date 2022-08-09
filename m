Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB45958D5F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbiHIJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241868AbiHIJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:04:56 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0662F2251C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 02:04:54 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2798PRL3009090;
        Tue, 9 Aug 2022 02:04:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=k7U9HogEv4Gr0EhpGvcbjtNzaSLUHi5ZPQPi6A3dfr4=;
 b=cnQjnPhWxw3rFcZR1GWJl9EdR0+oNo90ZlmhPGp+/uW83uPQz+UWyY0IEzRhkZowR6Fg
 nDZUBJc8fvmp6eBrthqDnLsuLlV1wDuvq7Epc2uyvODJ/Uk+72guG42ta7q15SQcZSvo
 FXI9kkqYyjZkQktUY7TDB1Ift0mdsFS1c0MNlsl0SoFRUQKD2gX6DOH1S7mDtls4+FcI
 pscQ8ruv8CwaY1Sl0tKTpcnZY9hL0OVXv8u+563kidZPJv1GgxKQje6EFbAyviBr4cRK
 P9QEU4eGwM0PTfxS733So/yJLfF9skmajiSTTrWHXziqz25BnljizTStP44MB32QqJyb Tg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hsqtka4sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 02:04:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UG3iYauW8V2l+TiTAPHB6soF/bMdnP027ZrSwcNTV1ZUDznjfQ+CIb++HgIoXrXQa8Y6qLrRRjN6PeLVkfSaPbFyTwFhw5ocl9dzqeVnvodWCddkBLHetvEcgCpmvlP9slLG/F44mJZWWUqRC/1fllvRC3xhbVmlgNmBJn09zEm9KRY4RpcQC5b+VLzV9AJY/G55JhbKpNuTeqTBvFEIuSM6Klpb154GdRlcXUrCmfpi1tIS08XE6yRr2j4FBX441ekcENN8tp+kLH+pwo8ItdI3eppn80bi0T4aaAxxMJ+V/iSzGnwZpdXbOkii2XHo/vo5B0cFOVoEphU9/72CNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7U9HogEv4Gr0EhpGvcbjtNzaSLUHi5ZPQPi6A3dfr4=;
 b=SiP172QHLHzMMQciXchscpbxIfR+H6l0yCXVcF35N/umSYs5/+H0+7N37JexanG+neGZN8w0IDGNBtM4isZZCFDtuZ/r1Hyx3IY6eLYClE0I7bRPQK6q+E+IWKphIBRM0SCDr/zgG9sLML8tL3I4ZW+QVxHOBsD2o57EopPLgJLxuuVD4jeS5ENZlgRJ6XSRZ08opD/PQMzPhTV09FJI8XNBCGWq8/7jwBTW/rFv6oeQ2YnslX75hH4vua/gaWCi688wzDI73wOz4pIFRXXe4qu9I3eB7Nlkklud7lcbTPDoKfZx92mWesyIsWsCqje6qatEiEBosWr+TqxHxznXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16)
 by MN2PR11MB4272.namprd11.prod.outlook.com (2603:10b6:208:196::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 09:04:37 +0000
Received: from CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::d504:d329:815b:10ba]) by CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::d504:d329:815b:10ba%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 09:04:37 +0000
Subject: Re: [PATCH] mtd_blkdevs: add mtd_table_mutex lock back to
 blktrans_{open, release} to avoid race condition
To:     ChristophHellwig <hch@lst.de>
Cc:     MiquelRaynal <miquel.raynal@bootlin.com>,
        RichardWeinberger <richard@nod.at>,
        VigneshRaghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220809075753.21950-1-liwei.song@windriver.com>
 <20220809080809.GB14727@lst.de>
From:   Liwei Song <liwei.song@windriver.com>
Message-ID: <7f925359-69b0-49b1-cdbb-337912da4f9c@windriver.com>
Date:   Tue, 9 Aug 2022 17:03:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220809080809.GB14727@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To CH0PR11MB5348.namprd11.prod.outlook.com
 (2603:10b6:610:bb::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eafbb9e-3a2f-450a-ce70-08da79e62f53
X-MS-TrafficTypeDiagnostic: MN2PR11MB4272:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIMSFaJzC7QTnStFz9H1JGlJX6MbhLx3hU8aY8MmAI0gqvxnI0U/5y3zZxY/jayvt43fXlYuCadGE15fw4cm0c6tgm3UHCkOfdByaGTwVPln5sd6NQazm8bOU6cSU/j2+Hv2pjEZCFOJ5O+YGREpHK987TPLlqqg1WPZHUO+wIiQjVTtYQVFy5c6K45/5GR3y9+pzWrXod77UML104LoDHYNPKCEe4kOcFWOyqcci66okwi6EBhXavuTmlCzxHRZ5PVgmNo2I+u8nGXcalBlxN3F8y0eB2BD3p8EHWkcSMUpMtBi79PvBn4P9jgkUFnxa2KfYC5ZbWOVprHygOSox/p+QwGBLdvoGQlxC35ZXUuzvT1Gd17g3vmjBnEhlQk1g3GiEdR+ZPQ9GBCnw+jFQWWKj1a0aJckjwfxlzru1wc56R+J9ek2tjeCE8ia3dzAYYYvfpgQJ8RjKpztqAUzJlVyUgGpFcG602CMDw1yl0Zv8965Cr/KwiajqrwXqiYRJ6DCBOugP5XuhGXQCO3LJXZiY6p8i7lKIdFdrse8ceGwt1KHUEYxbMIZ0u2Gs1lDOGrhlPuxgbRlf6rPUIfSN5TbAn0Qbc3uK8tH+dEUUxqDC0xFVdHNY07HWyuBbNDnr4+mqGerqI3k9IrKXjNYXVvlDaNwldQCM348atiYRD4nj4cItfXPY8OOd7AajtWRoAIKUt4vqvvtDNO2qpRIrU0sooVT2nj7T4v9c80hGc31L2U4RZFpfEL4s6K9NHMTiKFjlArcRnfbbqCa/pvSXJ6ifCJfjzButqxvlnV4z2n72feJ1fIzHI9luUia0MYBBMMhBtmAdXvr5gRFQVaerYv7PHUmza3Rac1BrXVh1qM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5348.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(39850400004)(346002)(83380400001)(53546011)(41300700001)(8676002)(6506007)(45080400002)(52116002)(6486002)(4326008)(66476007)(6666004)(66556008)(2616005)(316002)(186003)(66946007)(6916009)(6512007)(26005)(54906003)(2906002)(86362001)(36756003)(38100700002)(38350700002)(8936002)(478600001)(31696002)(31686004)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG5NdGVHNXk3MythWXU5YTU5dWVhL2MvL2xwQmY4RWJpSmYydzJNTE1GN1Nj?=
 =?utf-8?B?Y1hQTlJjNGJCZ09hZmRKNFdVS1daZlFVRytMWEkwT1Z2Qk9QcVJUUjZkSDhI?=
 =?utf-8?B?OUMyTHdLOHFiK1Njb080RThWTGZtTjJad3pWMDlYNGZ1YkFGTkZxb1NWalZU?=
 =?utf-8?B?b1pBcG1UNEkzZkliTGtlTnpqYVM2ak1LbmlJbitDUEhWNzM1T1I3NURRWDNE?=
 =?utf-8?B?M0pNLzVlTXFBc0Q3QTFmREk5bXVXR0NqdVduME91SGtwdEt2WTFSeWNkSUdh?=
 =?utf-8?B?YW04a2U1eXRYSWk0eDRzU2N5ZVFHUGVlQ0cvTmlnUXJQZGE0a0ZDVkduV1Uy?=
 =?utf-8?B?THFzMmFjblcwUlorcXhvTkpIU01SVVhLL1N5QU9IVzQ2KzBGRHRyUHJXUUtO?=
 =?utf-8?B?RmxjUGVUTGIzZExxZVVQcXYwOXJuQ1NmeTdlc09GR2xaenpoNTVERGxrd2Yw?=
 =?utf-8?B?SUtHMDU2LzhPNFJ6amZ4NytEY2J4ZkJmMWZsRVFOYWJzQWVtNUFVTEREZkhh?=
 =?utf-8?B?ZUJpc0pDTG5XaTJpcVFOTXc4eWN1L09PQ0ZaK3RyQU5FN2JYclBTZitYdGFy?=
 =?utf-8?B?K253ZVpmeGdmNTBqd21vNXJMWElrUEFnYnVoY3l0eWJ4R3BVTmtId1ZaOXlu?=
 =?utf-8?B?dUVlWnluNngvRzR5Tm8wTHNDOTZFeVJLdmJGUTVURFpadEhVWGZPUmEySUEv?=
 =?utf-8?B?SHBHMDdlSFU2WmJ0UWNYbnNBYmxQbEpFeWdEbDhIVE0rZ1dkaERBdlp4b21k?=
 =?utf-8?B?UlJVdFVraitDTHFnbW9aR1hnYit0dU9jMXZXRUl4b0RCbUZ1WSsvVFNQSzgw?=
 =?utf-8?B?TjRweUtFajlMUWZkNG11U1BEcTZFUWtJWG1XVG1jTU8zYVd3QXJoNW5MUXRv?=
 =?utf-8?B?SVA1WVFkQkN5ek50Q0FsSUZoclg2VE0wdVB1Nks4UE4wWVJVQXdEb2NmekhP?=
 =?utf-8?B?Z1J6K0xpQjNiQm85NFk0NnNmUmpCSXVuc2hyNkZCVGFSL1JpZWNoT3VidTNs?=
 =?utf-8?B?enhGUnZOVnZpSGRjKzRGbGdaQTJXTlQ1WjdMMFUvSjM0RjNIV0RaNXVLSXZX?=
 =?utf-8?B?WjBXQ1lnaWhqOUVCSFZBaCtTMUdXbjUvSkZqNm9kamdDVjZSREFmdStlNmpZ?=
 =?utf-8?B?Q0FzNm1wT1VpVUVKQUdIMDZmd3hZK3BhalF4OUZacWRVVnZobjc1bU44S2ds?=
 =?utf-8?B?MmtMOFAxdjVjSU9HZTVBdG1pOUd0bzBoMUZtRlNLL3Z2bVFlN3JCckl3NUox?=
 =?utf-8?B?WUE0Y2xBNGh6NWdWNUw4ZFAyRTFLRU1mSTF3QnBFL2V6QzhFeDdUR0w3RkxB?=
 =?utf-8?B?bUFYY2hYeTBKeVY3QURKdDg2NzNoUTJ3R05yY0w0Z3hXVmUxdjYvaytrUlRj?=
 =?utf-8?B?NTE3QUloZVJ3RHkrTzFDODB1VVFVeW5ENWRFZ2lpbTFBOWZaR2ppU2ZXN1Ra?=
 =?utf-8?B?WEhLK0J3K1NhMHkzUktDS2x0MzNISDBiYjY5WW1xa1RvQWhSWkZBcnppdlZl?=
 =?utf-8?B?dXlmSXhQNTNjaytrVkliM2RqOVY3NHhXNGo5WlpQelZsaEVFVzJDem01c0Yr?=
 =?utf-8?B?ZXR6dVpteDlwblVJSks0aWtveGgwNjRWMFo5R1VEanRXMFZncmtKTU9NUmF1?=
 =?utf-8?B?emtLSkNNelVnRiszTkZHejhCOVIvT2E4NzM3UUN1QmcweFlHOUxQRm4rMzhZ?=
 =?utf-8?B?QUpmVm9UNk1YSjNTQ2c4SnhLckgwQnJBNnVpZlBwTmJ2VHpZS1NZZnFud2h5?=
 =?utf-8?B?UExOV0R2cWptYnhwV3BTNGlSemRkTklER0RacXQvazFjK3NDQlRJQnAxZjl3?=
 =?utf-8?B?RS9pbkVMY05IYVpOTWNUK3BkOGJPdFZDa1liQ3VJKzg5azJ4R29aVUhaNU5a?=
 =?utf-8?B?NFkyaFgzb2NJdTY5UHI0OTlXbGtmOC9yRUhOOUMrVDh4V25UVlBkTUYrZEhH?=
 =?utf-8?B?d0oybDk2cFdFWm1lQjJiak5YQ29xT1VRWVU3SDFFK2I1ZmsrN0hXMGRSRW53?=
 =?utf-8?B?ekRRc0VtZ2ZqdUJnQ1BZWUE1OFh5bTJRRkFhc2QvQ2cwVXdWL2R5bm1paWha?=
 =?utf-8?B?aFBIUmtsQVU3K21Ka1lXODk2aEhpZHZMMDM1VjQ2N3pmSG1NcFZRS0JOQUdJ?=
 =?utf-8?B?b3NRNlpvOTBzdDhISXExTTQwMm1XRkxpcHlzY1NYT1MwT2NBTE5CejdJZmV0?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eafbb9e-3a2f-450a-ce70-08da79e62f53
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5348.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 09:04:37.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaG6tvRjPiQQOZ+61ToapM0wkxIVpc1zBTXg6VwVgtqx95ABc2410JP5/y8u+4DAEHUce6fpoSGUxHp1gZRxYRbZ6iSmCKso7ZQf7lWH7E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4272
X-Proofpoint-GUID: xUUPy97R1ViKErwmEPEodwwDRdOVWoY-
X-Proofpoint-ORIG-GUID: xUUPy97R1ViKErwmEPEodwwDRdOVWoY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=947 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208090040
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/22 16:08, ChristophHellwig wrote:
> On Tue, Aug 09, 2022 at 03:57:53PM +0800, Liwei Song wrote:
>> without lock mtd_table_mutex in blktrans_{open, release}, there will
>> be a race condition when access devices /dev/mtd1 and /dev/mtdblock1
>> at the same time with a high frequency open and close test:
>>
>> kernel BUG at drivers/mtd/mtdcore.c:1221!
>> lr : blktrans_release+0xb0/0x120
> 
> This does not seem on a current mainline kernel and seems to be
> a somewhat incomplete backtrace.  Can you send the full dmesg of
> a latest mainline run and maybe share the reproducer?

Yes, the kernel I used is 5.15, unfortunately this is the latest version
that worked on my board, the whole log is:

[   31.301343] ------------[ cut here ]------------
[   31.301343] ------------[ cut here ]------------
[   31.301365] kernel BUG at drivers/mtd/mtdcore.c:1221!
[   31.314981] kernel BUG at drivers/mtd/mtdcore.c:1221!
[   31.329328] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[   31.374117] Modules linked in: 8021q sch_fq_codel openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fuse
[   31.395820] CPU: 2 PID: 390 Comm: a.out Not tainted 5.15.58-yocto-standard #1
[   31.412672] Hardware name: SoCFPGA Agilex SoCDK (DT)
[   31.427372] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   31.444058] pc : __put_mtd_device+0x4c/0x84
[   31.457977] lr : put_mtd_device+0x3c/0x5c
[   31.464122] sp : ffff80000c26bc50
[   31.466126] x29: ffff80000c26bc50 x28: ffff000285785100 x27: 0000000000000000
[   31.471945] x26: 0000000045585401 x25: 0000000000000000 x24: ffff000285785768
[   31.477762] x23: ffff0002803ee520 x22: ffff0002804f8900 x21: ffff000281956800
[   31.483580] x20: ffff000281956800 x19: ffff000281955080 x18: 0000000000000000
[   31.489402] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   31.495219] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   31.501037] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000088a79b0
[   31.506855] x8 : ffff80000c26bcb0 x7 : 0000000000000000 x6 : 0000000000000001
[   31.512673] x5 : ffff000280959488 x4 : 0000000000000000 x3 : 0000000000000000
[   31.518491] x2 : ffff000281956800 x1 : 00000000ffffffff x0 : ffff000281955080
[   31.524310] Call trace:
[   31.525450]  __put_mtd_device+0x4c/0x84
[   31.527979]  put_mtd_device+0x3c/0x5c
[   31.530333]  mtdchar_close+0x3c/0x84
[   31.532604]  __fput+0x78/0x220
[   31.534357]  ____fput+0x1c/0x30
[   31.536193]  task_work_run+0x88/0xc0
[   31.538467]  do_notify_resume+0x384/0x12a0
[   31.541261]  el0_svc+0x6c/0x80
[   31.543015]  el0t_64_sync_handler+0xa4/0x130
[   31.545977]  el0t_64_sync+0x1a0/0x1a4
[   31.548338] Code: b9448841 51000421 b9048841 36ffff41 (d4210000) 
[   31.553115] ---[ end trace 9652b26ea1d7daa1 ]---
[   31.556420] Internal error: Oops - BUG: 0 [#2] PREEMPT SMP
[   31.556420] note: a.out[390] exited with preempt_count 1
[   31.560588] Modules linked in: 8021q sch_fq_codel openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fuse
[   31.575265] CPU: 3 PID: 391 Comm: a.out Tainted: G      D           5.15.58-yocto-standard #1
[   31.582466] Hardware name: SoCFPGA Agilex SoCDK (DT)
[   31.586115] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   31.591757] pc : __put_mtd_device+0x4c/0x84
[   31.594642] lr : blktrans_release+0xb0/0x120
[   31.597603] sp : ffff80000c22bc20
[   31.599608] x29: ffff80000c22bc20 x28: ffff000285785e80 x27: 0000000000000000
[   31.605428] x26: 0000000045585401 x25: 0000000000000000 x24: ffff0002857864e8
[   31.611247] x23: ffff0002803ee520 x22: ffff0002803e3470 x21: ffff0002803e3400
[   31.617066] x20: ffff0002803e3020 x19: ffff000281955080 x18: 0000000000000000
[   31.622884] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   31.628702] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   31.634519] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000088b0230
[   31.640337] x8 : ffff80000c22bb90 x7 : 0000000000000000 x6 : 0000000000000001
[   31.646155] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[   31.651973] x2 : ffff000281956800 x1 : 00000000ffffffff x0 : ffff000281955080
[   31.657792] Call trace:
[   31.658933]  __put_mtd_device+0x4c/0x84
[   31.661462]  blktrans_release+0xb0/0x120
[   31.664077]  blkdev_put+0xd4/0x210
[   31.666175]  blkdev_close+0x34/0x50
[   31.668355]  __fput+0x78/0x220
[   31.670108]  ____fput+0x1c/0x30
[   31.671943]  task_work_run+0x88/0xc0
[   31.674217]  do_notify_resume+0x384/0x12a0
[   31.677009]  el0_svc+0x6c/0x80
[   31.678762]  el0t_64_sync_handler+0xa4/0x130
[   31.681723]  el0t_64_sync+0x1a0/0x1a4
[   31.684082] Code: b9448841 51000421 b9048841 36ffff41 (d4210000) 
[   31.688857] ---[ end trace 9652b26ea1d7daa2 ]---
[   31.692161] note: a.out[391] exited with preempt_count 1

the testcase  a.out is compiled from below code:
when run the case /dev/mtd1 and /dev/mtdblock1 will be used for open and close test.

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
    pid_t pid, pid1, pid2;
    int fd,ret = 0;
    int status = 0;
    char device_char[12]="/dev/mtd";
    char device_block[17]="/dev/mtdblock";

    strcat(device_char, argv[1]);
    strcat(device_block, argv[1]);

    pid1 = fork();
    if(pid1 == 0){
        while(1){
            fd = open(device_char, O_SYNC|O_RDWR);
            ret = close(fd);
        }
    }
    pid2 = fork();
    if(pid2 == 0){
        while(1){
            fd = open(device_block, O_SYNC|O_RDWR);
            ret = close(fd);
        }
    }
    sleep(10);
    kill(pid1, SIGKILL);
    kill(pid2, SIGKILL);
    pid = wait(&status);
    pid = wait(&status);
    return 0;
} 

> 
>> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
>> index b8ae1ec14e17..147e4a11dfe4 100644
>> --- a/drivers/mtd/mtd_blkdevs.c
>> +++ b/drivers/mtd/mtd_blkdevs.c
>> @@ -188,6 +188,8 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
>>  
>>  	kref_get(&dev->ref);
>>  
>> +	if (!mutex_trylock(&mtd_table_mutex))
>> +		return ret;
> 
> No, that's not really the solution.
> 
> Turning the kref_get above into a kref_get_unless_zero might be better
> path to look into.

Thanks, I will have a look at this.

Liwei.


> 
