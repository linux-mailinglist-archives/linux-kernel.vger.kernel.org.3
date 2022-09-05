Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD295ACD9C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiIEISC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbiIEIRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:17:41 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8152B3122C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:17:14 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28577G9W020785;
        Mon, 5 Sep 2022 08:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : from :
 to : cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=xMhFJdF06PB34DArR3EQD+O+etRNDNPcsVIOUI8Pacg=;
 b=QLkPVF9m03mcAg0BViPE7UBOyIVkpPE6W5vsW//Ol9PUu3okbH7HhgQqApni3YiMceBY
 C7XeetKMi8TAHjSeEZf1Ghw4BR1Xph/lKO0RFdYWR/y0qqmCToLfyDMru9XuDZAVkfKc
 97rz7ngPR5mpR+Zj7sbh+6u5QxsIqDthBJZMbN1NNL/aL9gP8STcYbW2DTBXmsP4Ovw7
 Y0uYe7TKJnvDu8dKGwLmyW+LzXh8XJ/cK3ErYcqnLCEYb2XLIZqvDTHwNC5BCa7d6hAV
 qyWGwnA1htBpYlDwMABDWqkUco1a59Phnqj4EA+BQEy2bpqG0fLCHmCV1VRnkpJxEId8 cA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3jbww79gpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 08:15:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh2YO18hODd+T6wSoteYjQpadFCCflX27yJnO0Vy/b7yZF7WU2gLoLiODK3qUY94cn7pn56TEUXy+MfOL0l/AZth8p1/0D40jh1gfIdGt1n+LEFRQ5e47ZaZlMqlV6mScCaqGjQYedM5oj6AfgdhuL0ttj0o0EWvxvDpPhlBeg/I1aZeNLmcGpezfoa17xhBifozHMZLM77NG4otARIBx3oeYwvSKhkIpHaPW6UsNFjBhFSdHk6M3MpVbzrotIoum3zaeGxf9xR6HFpzfJBGCZLRO1S10qEjjAx4Pv6YjcwyaBHbg+m+Ln9RwIRXLckRRV0fze4iV+wQa7n0k7IXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMhFJdF06PB34DArR3EQD+O+etRNDNPcsVIOUI8Pacg=;
 b=VxRQtIOS2F00l9GK5F5CY8KIKW8Je98qfwnm8Dytzyph2Cun9a4kK/3Ur0xC1JNLaBWNF7EulkLtb/nL3DfHL3O2TsFUqELDhni97VvEzuo7F99IxIsXUd5TCB5QnNaTm/G4bMSOAdCLUmFNuPRPN3UKwJtuDUCWl8uDqf8bPtCItoMm+YvP/4Gi7UoMsKriG4S6i02cmx3qV2fvTBCOvFpgvegxO4Vc9w/b3LwTM8BYU7FPgadtmavb8bEeiOK8j+3D/+c/H28Y8ZZ5OartWFJlaAr85I/iUKllwK8WwoLAdRPT5fcrUMdI0CGmCRGR5LWjx9G72HWz17YhHJFakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16)
 by CY4PR11MB1831.namprd11.prod.outlook.com (2603:10b6:903:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 08:15:56 +0000
Received: from CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::d504:d329:815b:10ba]) by CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::d504:d329:815b:10ba%8]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 08:15:56 +0000
Subject: Re: [PATCH] mtd_blkdevs: add mtd_table_mutex lock back to
 blktrans_{open, release} to avoid race condition
From:   Liwei Song <liwei.song@windriver.com>
To:     ChristophHellwig <hch@lst.de>
Cc:     MiquelRaynal <miquel.raynal@bootlin.com>,
        RichardWeinberger <richard@nod.at>,
        VigneshRaghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220809075753.21950-1-liwei.song@windriver.com>
 <20220809080809.GB14727@lst.de>
 <7f925359-69b0-49b1-cdbb-337912da4f9c@windriver.com>
 <4910c707-ad97-362f-911a-79e438e6e8ff@windriver.com>
Message-ID: <cf66e306-f216-5247-7cff-36ce08eb4512@windriver.com>
Date:   Mon, 5 Sep 2022 16:15:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <4910c707-ad97-362f-911a-79e438e6e8ff@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bbe2cf1-7e75-4437-a023-08da8f16db45
X-MS-TrafficTypeDiagnostic: CY4PR11MB1831:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6D5Ba4CFWCs2RhamfdrD59ZpMjtD5dQCMopTseI2AyGmr0Du4gMh08b8bHwkuqb9JyIFR9zgvmEHKHfcoUxs3nCsAtHQxD0dr8iuwxV16tHlK2BrquL5FD00/qaeWyipruqGVtnAln2FAUXC2vAKlT9kws6QyxipInlVKjFuH6wo78rLixL6465Ztr54T1sq6LEeBTugUUCcAr8tfew5svmc0cQVPuZBBYatysgLnTLFmHe5Y2zbbup79QPB2Vxb0+cOo9xe2TiYdHE8WjZAKrg6HDNFrDZQpbjmthPRwCMT7hqwbX6UlX01jQIB6jn+I+8M69YuF/mMR07kg4FiKrm69PO6sAItB8DcM8aFDY58oH+eN/QLk4bcUp7L/XecM75dl2OI5EwJHz48F6qBNEjc3DHMjAFEoKwnSp2MlqtQmN1JZ0VIkXk++PGjj+DNtgSd02c3As9PvarG9QnoB9xvNpc647Knwel0+/uLtWt8ZrQH4FEnbiRUcuUy5Tg9eTxoA3ODJdqqZ7if7EsxGjXKeSrl9EQda+H57X5In/Eiookj7NW++1yKpAN+7Bn+ahbHlTGnfpCBUJlhlDP5M3hKNR3MVTwJI585joTNyvzGoRbMZXDoB6XLiKhxlubqRl0ADDQeF8PIkmn9d3PrWyXPhGEbWqARwAelZFohS2ZgdUzSYLBLci3pYGfbUfpqIYfpuW1EnTeZk166MJxwQlmElAwVU6xObWjM+PUF/SzcLFMUgJDm7LQjV/zEQLgK9NEBaXjKnAFJR/ohL0GpoOi2ezorGyaN5hOloiSCQ7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5348.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39840400004)(136003)(376002)(346002)(6916009)(45080400002)(316002)(83380400001)(6666004)(6512007)(26005)(53546011)(6506007)(54906003)(478600001)(8936002)(31686004)(31696002)(36756003)(86362001)(2906002)(5660300002)(4326008)(66556008)(66476007)(8676002)(66946007)(44832011)(186003)(41300700001)(2616005)(6486002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3JZMDhsNk01eis3OWZKdzEzWTEwR3NTWXFWSHQ2WVdJM0ZFWkFweDNRMUEz?=
 =?utf-8?B?YlY1akJHRzBtM3QwTW13T204YUFjNWovREF1WFc0bDAwd0VLSksvVFhlZW9X?=
 =?utf-8?B?QXZsQnJGbzZVTFNzUkFpdkJhc1ZjejQ3NVhxOHFMQ1JxTko4M2xnSjhJN3dY?=
 =?utf-8?B?UHpVcGZ5QnlSYnhoSmJTM1hQa3NMeEt0YTR0WEQ1eUR1YjQrQU5rTkVGeUx0?=
 =?utf-8?B?WHA3aCtZLytoSUUxZ2VtR09BSlBHRWd0cHBPVkY5eSthcFpmekpsUVVHVTF6?=
 =?utf-8?B?Z2VsenUvWXoxSExqTGN4L3R2VGkxeDRmemFJSXFEcTlaUlBSbUYrV05VQ3JB?=
 =?utf-8?B?azZXY05hTnozMkhmWnVOaml4ODFUN2NON21BQU9OYnY0Q1ZjNlcxN3ZNVVBj?=
 =?utf-8?B?clE4bDNqeXEvbkVzangzd2E3bDRQdHhpait3RXRGWG5WNlFPVEZRd2hNK0VN?=
 =?utf-8?B?NDVzdXgyejdiY2djZ1FmQVBVZFE3cDA2SlFIUW9IbExPMzRKdGZReGptRHAw?=
 =?utf-8?B?UXRDQ3hHZVJqVlllVFM1Ty9wWnhaSFg3dTF5WDVFV3NkYmRUVlJKeXpMWldw?=
 =?utf-8?B?UjRlaFY5bVZZVklWbDVPWDY0U2ZZbzQwWEhYUDIrcS95cVRXcmRsbnNrSVlx?=
 =?utf-8?B?bTBsSmZ5ckVSeFFGeklBMjBmVVJMRmMwYzRISytrK2JyQXdjRkFJbmdrL25k?=
 =?utf-8?B?NVdaTVBpUzBIMis3ZklLWmprNTdMVFk2SnVZdURYN0Y3b3BMcDFkYTBLbnBl?=
 =?utf-8?B?TXN0YVNmVmxnbjZyQUl0ZFpBK0Q0aFUrenNjMzc4M1lVVi9HaitEMzFOMktY?=
 =?utf-8?B?aCtKSklURUtJY01wUHBjM1puN0llUHZqVUtDdStoZUVqcy9lRHhNNXl0bjFp?=
 =?utf-8?B?Y1l1M0NUMlkxOERLSUJtanpsKzAwTGRNSi9tMEVrcEZOUFFJZmxINGh1d0l3?=
 =?utf-8?B?ZUxJQkg0TE9EMjZjWjRJQ3dYUHI2dng5SUVlNjczOGpsWGZVNnBYdDJkN1Er?=
 =?utf-8?B?bk5LSTBmWXR1c2N0ZlVIRUdCaC9yNmhhcElLdlpxWmRFYjQ4SGZoZXp6NHFh?=
 =?utf-8?B?bER1ZUo2czl2NGxHY2RZKytxUHBCa0FSSzBpYlY4S0lBbTNpeStwRk05ZWll?=
 =?utf-8?B?V0Y1TzdCbnpmY2VaU1Rta2RCMVVuTUd4QlpobnV3NXJ6ZWlzRzNhRjNMN0dY?=
 =?utf-8?B?VFA3cEUwbC9STmpOYURzTnU5RTNBakcydzRXbmVKZ3haZFhsaC8rOU9vZVJ3?=
 =?utf-8?B?SmNOVDdsMVRsdlZRekNzVFB4YStXMEZjaDVlY3ZTU0pUNTgyTFQxMnVNczhL?=
 =?utf-8?B?YWdFMlp3V3FQT014Yy9zKzRBQklvbnZ3NDIrNnVIWTROb1E1Q215bi9NbEZk?=
 =?utf-8?B?dnIvVEt4dStzUXZHRlNWT0wxandoUnFOUUJRV29YVXJJdDdtRyszMlFvVklr?=
 =?utf-8?B?b3JQL1dnZmFGSWl0b2ZTRUhZbnU1aFZVM25UNU0zaGI2MWhpcUdZTzBZam9q?=
 =?utf-8?B?bjhDd3hDWk56bW5qZEpGVlI5ZFVUMElDS0pQR2JXcTNMZFR3MXBnbGxFMkNF?=
 =?utf-8?B?UHd5M2pVTEh1UU9CN3YySi9nNG9LTFg4RDYremFpN0xaL2t3UWRMZlIwK1Yw?=
 =?utf-8?B?OXlsME14VmJQeVZHYXF3N2JtMjlpSzB5eVBFN3RiVHhSOWcyY0d2aENCU3A1?=
 =?utf-8?B?TUpzRzJraGI3SFhQWWdvdFhCems1M2I2TG9YOEJ4WHNYT0tDTkt6TVNvSWd2?=
 =?utf-8?B?L0N0Vm9QTXFUL3MwL2ZKRDVKcTZxajd5U3JHRzFjeldsaVpnZEZhUFFBVVlY?=
 =?utf-8?B?dUF5dVdHYSsyRWpmVElLalRVQjRVT01jZnlpbVhEUTJ3OHJ3NlNiYUZ5Q0xr?=
 =?utf-8?B?ZHJKTmNqSlBFNzZFL0FwbmlnSGtKdVNNcDZIRGNSRGdPSHNndEdscUV5c0pO?=
 =?utf-8?B?THQ0V2ZPczZiNE5nS2YvY2tBSktQV1RXNFAwdlZ6dnNBRHJ0TVFEMk00Tzhn?=
 =?utf-8?B?NFgrT3JySEs5cG5IMlMrb0RZcEVHYWVoaUIyc0ZrYm9tVUJ0REI2cFJBa2Nj?=
 =?utf-8?B?c3FURFBod01CNkZ3U0t3ZXJOeSs4L09uUTNrbXhCc0F1RGJDbWVHMFJqSkpR?=
 =?utf-8?B?QVpJMU4vTmFTYy9PNWdmdzhNMjNESjAvZEV4MHlOakwzVi80ak8xTzlza3A2?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbe2cf1-7e75-4437-a023-08da8f16db45
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5348.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 08:15:56.0609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9hQxpCxJ8uRHEFSR7yAP670m+1VuZ3M6vWvLek7E14v4PXym5Af+qXDFFBCHwZbt2E0K4vtnKSm5o+XU5jLuNTN7OsY27rGdHI2zw8pYz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1831
X-Proofpoint-GUID: twnv4GzzuZ4HgVPju-nNcouGyW5c4LRG
X-Proofpoint-ORIG-GUID: twnv4GzzuZ4HgVPju-nNcouGyW5c4LRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_05,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=982 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209050039
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/22 15:47, Liwei Song wrote:
> 
> 
> On 8/9/22 17:03, Liwei Song wrote:
>>
>>
>> On 8/9/22 16:08, ChristophHellwig wrote:
>>> On Tue, Aug 09, 2022 at 03:57:53PM +0800, Liwei Song wrote:
>>>> without lock mtd_table_mutex in blktrans_{open, release}, there will
>>>> be a race condition when access devices /dev/mtd1 and /dev/mtdblock1
>>>> at the same time with a high frequency open and close test:
>>>>
>>>> kernel BUG at drivers/mtd/mtdcore.c:1221!
>>>> lr : blktrans_release+0xb0/0x120
>>>
>>> This does not seem on a current mainline kernel and seems to be
>>> a somewhat incomplete backtrace.  Can you send the full dmesg of
>>> a latest mainline run and maybe share the reproducer?
>>
>> Yes, the kernel I used is 5.15, unfortunately this is the latest version
>> that worked on my board, the whole log is:
>>
>> [   31.301343] ------------[ cut here ]------------
>> [   31.301343] ------------[ cut here ]------------
>> [   31.301365] kernel BUG at drivers/mtd/mtdcore.c:1221!
>> [   31.314981] kernel BUG at drivers/mtd/mtdcore.c:1221!
>> [   31.329328] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>> [   31.374117] Modules linked in: 8021q sch_fq_codel openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fuse
>> [   31.395820] CPU: 2 PID: 390 Comm: a.out Not tainted 5.15.58-yocto-standard #1
>> [   31.412672] Hardware name: SoCFPGA Agilex SoCDK (DT)
>> [   31.427372] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   31.444058] pc : __put_mtd_device+0x4c/0x84
>> [   31.457977] lr : put_mtd_device+0x3c/0x5c
>> [   31.464122] sp : ffff80000c26bc50
>> [   31.466126] x29: ffff80000c26bc50 x28: ffff000285785100 x27: 0000000000000000
>> [   31.471945] x26: 0000000045585401 x25: 0000000000000000 x24: ffff000285785768
>> [   31.477762] x23: ffff0002803ee520 x22: ffff0002804f8900 x21: ffff000281956800
>> [   31.483580] x20: ffff000281956800 x19: ffff000281955080 x18: 0000000000000000
>> [   31.489402] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>> [   31.495219] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>> [   31.501037] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000088a79b0
>> [   31.506855] x8 : ffff80000c26bcb0 x7 : 0000000000000000 x6 : 0000000000000001
>> [   31.512673] x5 : ffff000280959488 x4 : 0000000000000000 x3 : 0000000000000000
>> [   31.518491] x2 : ffff000281956800 x1 : 00000000ffffffff x0 : ffff000281955080
>> [   31.524310] Call trace:
>> [   31.525450]  __put_mtd_device+0x4c/0x84
>> [   31.527979]  put_mtd_device+0x3c/0x5c
>> [   31.530333]  mtdchar_close+0x3c/0x84
>> [   31.532604]  __fput+0x78/0x220
>> [   31.534357]  ____fput+0x1c/0x30
>> [   31.536193]  task_work_run+0x88/0xc0
>> [   31.538467]  do_notify_resume+0x384/0x12a0
>> [   31.541261]  el0_svc+0x6c/0x80
>> [   31.543015]  el0t_64_sync_handler+0xa4/0x130
>> [   31.545977]  el0t_64_sync+0x1a0/0x1a4
>> [   31.548338] Code: b9448841 51000421 b9048841 36ffff41 (d4210000) 
>> [   31.553115] ---[ end trace 9652b26ea1d7daa1 ]---
>> [   31.556420] Internal error: Oops - BUG: 0 [#2] PREEMPT SMP
>> [   31.556420] note: a.out[390] exited with preempt_count 1
>> [   31.560588] Modules linked in: 8021q sch_fq_codel openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fuse
>> [   31.575265] CPU: 3 PID: 391 Comm: a.out Tainted: G      D           5.15.58-yocto-standard #1
>> [   31.582466] Hardware name: SoCFPGA Agilex SoCDK (DT)
>> [   31.586115] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   31.591757] pc : __put_mtd_device+0x4c/0x84
>> [   31.594642] lr : blktrans_release+0xb0/0x120
>> [   31.597603] sp : ffff80000c22bc20
>> [   31.599608] x29: ffff80000c22bc20 x28: ffff000285785e80 x27: 0000000000000000
>> [   31.605428] x26: 0000000045585401 x25: 0000000000000000 x24: ffff0002857864e8
>> [   31.611247] x23: ffff0002803ee520 x22: ffff0002803e3470 x21: ffff0002803e3400
>> [   31.617066] x20: ffff0002803e3020 x19: ffff000281955080 x18: 0000000000000000
>> [   31.622884] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>> [   31.628702] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>> [   31.634519] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000088b0230
>> [   31.640337] x8 : ffff80000c22bb90 x7 : 0000000000000000 x6 : 0000000000000001
>> [   31.646155] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>> [   31.651973] x2 : ffff000281956800 x1 : 00000000ffffffff x0 : ffff000281955080
>> [   31.657792] Call trace:
>> [   31.658933]  __put_mtd_device+0x4c/0x84
>> [   31.661462]  blktrans_release+0xb0/0x120
>> [   31.664077]  blkdev_put+0xd4/0x210
>> [   31.666175]  blkdev_close+0x34/0x50
>> [   31.668355]  __fput+0x78/0x220
>> [   31.670108]  ____fput+0x1c/0x30
>> [   31.671943]  task_work_run+0x88/0xc0
>> [   31.674217]  do_notify_resume+0x384/0x12a0
>> [   31.677009]  el0_svc+0x6c/0x80
>> [   31.678762]  el0t_64_sync_handler+0xa4/0x130
>> [   31.681723]  el0t_64_sync+0x1a0/0x1a4
>> [   31.684082] Code: b9448841 51000421 b9048841 36ffff41 (d4210000) 
>> [   31.688857] ---[ end trace 9652b26ea1d7daa2 ]---
>> [   31.692161] note: a.out[391] exited with preempt_count 1
>>
>> the testcase  a.out is compiled from below code:
>> when run the case /dev/mtd1 and /dev/mtdblock1 will be used for open and close test.
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <sys/types.h>
>> #include <sys/stat.h>
>> #include <fcntl.h>
>> #include <string.h>
>> #include <signal.h>
>> #include <unistd.h>
>>
>> int main(int argc, char *argv[])
>> {
>>     pid_t pid, pid1, pid2;
>>     int fd,ret = 0;
>>     int status = 0;
>>     char device_char[12]="/dev/mtd";
>>     char device_block[17]="/dev/mtdblock";
>>
>>     strcat(device_char, argv[1]);
>>     strcat(device_block, argv[1]);
>>
>>     pid1 = fork();
>>     if(pid1 == 0){
>>         while(1){
>>             fd = open(device_char, O_SYNC|O_RDWR);
>>             ret = close(fd);
>>         }
>>     }
>>     pid2 = fork();
>>     if(pid2 == 0){
>>         while(1){
>>             fd = open(device_block, O_SYNC|O_RDWR);
>>             ret = close(fd);
>>         }
>>     }
>>     sleep(10);
>>     kill(pid1, SIGKILL);
>>     kill(pid2, SIGKILL);
>>     pid = wait(&status);
>>     pid = wait(&status);
>>     return 0;
>> } 
>>
>>>
>>>> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
>>>> index b8ae1ec14e17..147e4a11dfe4 100644
>>>> --- a/drivers/mtd/mtd_blkdevs.c
>>>> +++ b/drivers/mtd/mtd_blkdevs.c
>>>> @@ -188,6 +188,8 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
>>>>  
>>>>  	kref_get(&dev->ref);
>>>>  
>>>> +	if (!mutex_trylock(&mtd_table_mutex))
>>>> +		return ret;
>>>
>>> No, that's not really the solution.
>>>
>>> Turning the kref_get above into a kref_get_unless_zero might be better
>>> path to look into.
>>
>> Thanks, I will have a look at this.
> 
> Hi Christoph,
> 
> It seems this way can not stop the race to decrease/increase mtd->usecount,
> the race condition is between mtdchar_{open, close}()->(get)put_mtd_device()->__(get)put_mtd_device()
> and blktrans_{open,release}()-> __(get)put_mtd_device(), when operate the same device
> as char device(/dev/mtd1) and block device(/dev/mtdblock1), the original fix for
> this issue is 073db4a51ee4 ("mtd: fix: avoid race condition when accessing mtd->usecount"),
> Could you give some suggestion about this?

Hi,

Any suggestion about my new found?

Thanks,
Liwei.


> 
> Thanks,
> Liwei.
> 
> 
> 
>>
>> Liwei.
>>
>>
>>>
