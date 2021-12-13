Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0302B472345
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhLMIz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:55:59 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:47582 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229744AbhLMIz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:55:58 -0500
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BD8SPdo021827;
        Mon, 13 Dec 2021 08:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=FBl5SgSKI9Pfib1DgmFDw6HAyBSF2W1yPct91Y89Ww0=;
 b=UtXMnkLCGq9JBvQS2nhrKwXDjdgxIsZFOA1GJmZIMdWo5MwzbgLuuY73FOnf0AEtbM6k
 0H70R0E28yHGhxJIEm5inwEphehubX1L1GsAChPkZMzHIALgUbc5cHFk+RX7gQ23IS1h
 h08H0YOsCaNuxzGec8araHwY/KAiLn2JaCFR92Xkb9OCdJBEvPszr+dhze3ySxrArNRP
 5N4gtnBg7/jn+BOSFOanRo5B1NgJpC4mvnkCTGRHZSt7fqgCZzUwfcI+lWnR99kxCKyx
 XHU7qrSHCgCSlOOJNDfMo8VCOEAZtas23RzrtBp2abUQHRCCNOXW5IYOhQ7qSZOtCa+j ow== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cwby30na9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 08:55:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/RD783GBHJ+5Uma/cFXgNpHo5iUcB11sFQt3NPVkirMXmt8tC9hQuDrobWYDc7QyAoZOpOn/fW+XiVMAxaaCR3a+OVkokI7qFiucnjgJzmv2nHPdu8hLA5matnpJVisHz7xjIxWKcvADE+B96isZFBpvqqM45tVHJaJGAxVAjn16pMVTkK/BWUB8k+dzVAUcQk45twMdeEhHyCtQXo65ZtVX3S9M/NtNs2fIHDK+XVF/A65abzSZ6HfR6rZHtKAjCvL/7PPG4m76ke5dnCxgIpXXVz+i/V1yrgR+QusVIcXNVDDtOy1Qwv6FuvgoncJd6HxERK2znG6csKB3KyEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBl5SgSKI9Pfib1DgmFDw6HAyBSF2W1yPct91Y89Ww0=;
 b=cUwltgpdX+FExbCn7S2uYuERi1svsm+fYHCYZgBrJqKbUH7dVhycDpYc2rn7a416EYkgSAEPm9n3S5VieDzczR+MsGmMbmLhRbOBfNpY+ANhPxYnaXtnvSFwrTa88+cN3qe58ESla3Te5j0GfSEJbXYqlxA8AHRxNTvTMQhMiS7xoUlq9nxyMjF/2zdjEzHRGWB550QM4w4as1zRiJiDoFJAbGV0RWoAvt2mFyF5qcXkD5rC1gcWBbteAlwM7wGVgERb0cQBB3Oqw8J8DvfihYtqDAAHLpQNnY6n6g4rNT8MFTw/6h0PFr4Ie4SHc5pe81MMy2qBdlAG23UmG3SNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB5173.namprd11.prod.outlook.com (2603:10b6:510:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 08:55:52 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::5d3f:f38f:ee6d:b7f6]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::5d3f:f38f:ee6d:b7f6%9]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 08:55:52 +0000
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
To:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome@forissier.org>
Cc:     "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org>
 <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
From:   wangxiaolei <xiaolei.wang@windriver.com>
Message-ID: <2c9f2f34-9dab-4f1b-bc10-48212fb70335@windriver.com>
Date:   Mon, 13 Dec 2021 16:55:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To PH0PR11MB5077.namprd11.prod.outlook.com
 (2603:10b6:510:3b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7856a6c0-1ebb-4a86-d2ee-08d9be165dcd
X-MS-TrafficTypeDiagnostic: PH0PR11MB5173:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB517362E5DDEEE7E63400883095749@PH0PR11MB5173.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyiESeTzbKAR+TyIzvHL/2UIHH0DiYwMnQCEzptTELajjWJQVE2f6Zo0Z3gB71Y+otOP2Lk/Pjg4dDOxc78d0WH/RbO/V7jljl9nYj5J5/KVoZZvnPFUfURFi2EqRPRGEWh8KrwjqbzSw4pWLAescHU1gion8pJHUaEHBFRgc7eqP9KTsJhLqAikAqL6O5HlQsmbpiCH+gtV5arFguH2pFS8agYq+sH7gaCpNOPZVjFk5EAVrxvRjMHDiLfpYAoQuq6GsdEuPTY4o7OGAtKb4LERJKFsu+1ifA1IZ6XGSSL4eimCCca8FbakU1gzjXT0LfwL88nyH0EWYjQMOzdW79CiM7gWWSotJjLoNl9/0p+vSgxbEo4obr0XFrlShlIV0WLXSDyMOeRH5kJ1PU3Fd1KDNctCzQD0dwOvZGo0yEWkNdh7KNSFQI6SMzv2SB26pqV8pHK8W+8zaRPh0k/XdGhw2plcfyp/ZTkPq/pqHapFleI2qTClDNZzMQPghy+6HRVivdkyUFuHUKC4o9/GWF6MEmt6ZKGBH7sUj7sEZPR1eoLwUQnJF9pSx3Cy3hrOFPcKPTLKcrxhostn9EPnHPP3s0Aj/P1i9FtbW7uc2SSWukyBBCTmAp/YM71mz9aWi++L7qi7knLGNjLRddSBIc9ferRZHVPo2zOU/vOCvhxQCjVUAt0aJlWAZ7ik9UJvRriuanD33+radOj3zwVDJyxd1MVVh79Sdy88bAk8O4MqYB1Ur2qhgLp2kYsoPfIF+WzCpBA3etfmJ1EHrlT6bH83UYiCz1NyQYzCJ02IDZvFw6wmq36IF5uqFGm5GKxaTTxpOBP82gd4aFQw1/Z8OQhZEdy9GyIx5BRxh2lcXuPOewRnKk9kpCkzrNRH4LGMqXf9z+J6zuzTB6IUzkw2fhijAzneYqEXn5cP3UTdFZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(508600001)(8936002)(4326008)(31686004)(6486002)(2616005)(6666004)(186003)(86362001)(26005)(316002)(66946007)(66476007)(53546011)(66556008)(31696002)(54906003)(110136005)(36756003)(83380400001)(38100700002)(6512007)(5660300002)(38350700002)(6506007)(52116002)(966005)(2906002)(43062005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFpXYmk1OGJwM0loU2NYUlRSQ05CeDVYQWswRzRRalV3aEtyUVN3MEhnQWpB?=
 =?utf-8?B?WmtvNXlCZ3BFRUNjUnpJRFJ2UFIrOE9GUVZycnZiaVdERHhOc2VYWDAvNnk5?=
 =?utf-8?B?TTFxSE5nekhCTlErdTFEaTQxVU9vQ3dCRG9SdGMzeTNwWSszcmxTN2xWOE43?=
 =?utf-8?B?QXZqeTU0UGFhRHcrWUNBUGlGZEZzR1NTdnVpaGI5M3NGMHNPUzdWMDRtd2ls?=
 =?utf-8?B?dzlsamlaNmV3dDcyQUVTMzdnTU41U0Mycm8yTkp2T09Udmpla1l1ejlpc2Vy?=
 =?utf-8?B?ZXVHY1FoSWxIdHltQmxrQWtydUhpb1YzNEZaZUJPUnEvUG5TY1pINW5NRnVL?=
 =?utf-8?B?c05hRVVmeU5ZSGZ6R1VObTdOdDdCbnl6Ym5VYk55Um1IcWY3WkZhSWFLSTFv?=
 =?utf-8?B?V0F2NHZYY0hmNm5NMnk0UVptRGVBVUlaSkpmWEVvdis1WlVyYk1EWkRQekx3?=
 =?utf-8?B?b1ZteUVZa01ObU9sT3JtOHhyRS9JYlNsd1dMSTNwUGtJbEtjYUNOTTJGQitK?=
 =?utf-8?B?RnZpZDJXVCtXNm9HTkFQN2lzMjlYWHhCdC9IaGQ1dGZtOWtPeG95SlRkL0Yw?=
 =?utf-8?B?QytQY3VtM2Vic2txSzhxdnpWNU0rby93dG1FalpvbkFFZGNtYndHNUU1Ull4?=
 =?utf-8?B?aVVWcDhBcy9nZ0JVc21qbW9tMXcrTHV2VzhxQVcxWVQ0elVJcEhaMGdyeWY2?=
 =?utf-8?B?SGF0K0Fjei9oaW44bG55TEMxRWViRVhad0tjZ1ZEUnNkNXpSRC9FMUtncXBx?=
 =?utf-8?B?d1RXcmdUbFA4NUxTWWdkcjhwd2g4a3RLYWVTbmdsdU5VQjFLb1YrTFYzczdo?=
 =?utf-8?B?U2NYd3hvUjMvaThqL203ZysyMWh4eHJCbFc1Tm9GckNjK3NsQWUrQVg2azd2?=
 =?utf-8?B?R0FUNDJDWnFuaDY0dXdEbTV2UHN4VWc3dndRUXlteFhUL0dFMTJQL1pCOG9q?=
 =?utf-8?B?QUwrTHZvWWZDc0JPOTdXaUVtNXFBK2Rici93Z1ZickNNcGFNTGdnRVZST2hB?=
 =?utf-8?B?bmx5K01KT0FUVDZ2cUM4NTE1cUU3WWdRVEM0MWhkSVl6MnZiVWVyUks1YXBV?=
 =?utf-8?B?NTdvNU1LUWlMOGJaV0hmdStteGQzTTFrdFRsS0F5c2pDODFJZ2Nqa3RCSis4?=
 =?utf-8?B?QnBYR3R3d2V4TXFxeHU2dXNUblVWZmNTOTA1RGp1bHNqam5FKzRnbTkzcUFY?=
 =?utf-8?B?UWVqR3lndzFGT2JrazRQUldZalhoa0FZMVFaRFgxeksyUHpTMFhmZFExSk9L?=
 =?utf-8?B?Ymo3ZFBTWGV1eENFZlUyL1drTUFxUmRmNU1aWkdHMDROUmVtbFZ1ZjhzRFhD?=
 =?utf-8?B?aXhZV3l0SVcyK2d6ckZmMWhiL1E4YXc1cHlZWlhoWFhDWXN6Mks3VUkramFT?=
 =?utf-8?B?WWM0TmN1VStJUGtBMEIweFlrZ1B6VTZKN0VGZEIxbzZMVnJTc01JZlVTSjRB?=
 =?utf-8?B?S292ZUZ4YVUxV1BLSHE1WHB4VjdGV1lLOXFvNHc3MFdxd3k3Q1dPVjcwdDlj?=
 =?utf-8?B?cEYyYndDYXltUlhwYXpHbUNKM1NHREhEYnM2c2RGYUJORG5IajVFLzREc0hQ?=
 =?utf-8?B?K3Jwdmg1MVAvL0lZR3lKdkVweWl2c2p1SC92b0tKY2VhV0t0Z2RuZGIvRTNa?=
 =?utf-8?B?VzJZYnNCbDN2U1dVa3ZwUmpsZ0dLVHBleFFCMVg5RzY4OFZSMTJuMk5nZG1o?=
 =?utf-8?B?bmVWb09Gd3RZWFg3ZlhoYUEwWmxneVdiREM3VWxuUS9MSXI1ek1vN3YycnFp?=
 =?utf-8?B?UER5MkpSRUYrMk92ZnU3Y1Y4bVdVRUR5Rk1FUFJBNis5YlZTWnFNOGlkaTdP?=
 =?utf-8?B?cEhpWDVENWVZdGpBcVRFbnR3MEdHdGsrRGgrN2tCZUJSZGplRXJCWTgyRDF4?=
 =?utf-8?B?dXdlVHBOWi9kcE8xbnFQWGhZaktuQjZBbTA0L1JpK0tlR25zRVpYV0taa1F6?=
 =?utf-8?B?K1hqL2tCNkRiSTVlbkloMkpzVjlycXRBbFExT0dHeEx3NStLN292WXhsak9M?=
 =?utf-8?B?S01ma21uUlQyQmxRNEp2bmdvek8vZC9tV3VJdVJCR1NoUjJqMjJOV2Z4TlFa?=
 =?utf-8?B?cTN2VzBmS1pZb0tMQ0ZNQ2p3Y0dKeGE4cHNHMm1OUm1Ec1hDK1JKanU4T2Z3?=
 =?utf-8?B?WFg3SDAzYXZjVFZPZ1VPYXh1VFpOU3pSZGxXU0ZmNU91L05YWW51VEg0R08w?=
 =?utf-8?B?Z0tXQUkwREpMd2tsNFFwdXhrUHova3c2MHFuL1R4SXl1dEFFQ3YyOU1yc1A3?=
 =?utf-8?B?am1jdnZVbFFyQU9rQVNvOEphV2t3PT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7856a6c0-1ebb-4a86-d2ee-08d9be165dcd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 08:55:52.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THkmgAp2AOD3ADFR5gBIXr0XtT4b5otUCG7Vg3hpyc6zvRg+LLByZsUQFJPvh6I+49Zgeudf8ye2jEpPFi0gBR2DwIJ3D/JNQjvWxi9ueyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5173
X-Proofpoint-GUID: piBCVRDROsHek8QIctGD7rC4oqIXU8dc
X-Proofpoint-ORIG-GUID: piBCVRDROsHek8QIctGD7rC4oqIXU8dc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_03,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 malwarescore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/21 5:38 PM, Sumit Garg wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
> On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> wrote:
>> +CC Jens, Etienne
>>
>> On 12/10/21 06:00, Sumit Garg wrote:
>>> On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
>>>> -----Original Message-----
>>>> From: Sumit Garg <sumit.garg@linaro.org>
>>>> Sent: Thursday, December 9, 2021 7:41 PM
>>>> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
>>>> Cc: jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
>>>>
>>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>>
>>>> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
>>>>> We observed the following kmemleak report:
>>>>> unreferenced object 0xffff000007904500 (size 128):
>>>>>    comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
>>>>>    hex dump (first 32 bytes):
>>>>>      00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
>>>>>      60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
>>>>>    backtrace:
>>>>>      [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
>>>>>      [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
>>>>>      [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
>>>>>      [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
>>>>>      [<00000000c35884da>] optee_open_session+0x128/0x1ec
>>>>>      [<000000001748f2ff>] tee_client_open_session+0x28/0x40
>>>>>      [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
>>>>>      [<000000003df18bf1>] optee_probe+0x674/0x6cc
>>>>>      [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
>>>>>      [<000000000c51ce7d>] really_probe+0xe4/0x4d0
>>>>>      [<000000002f04c865>] driver_probe_device+0x58/0xc0
>>>>>      [<00000000b485397d>] device_driver_attach+0xc0/0xd0
>>>>>      [<00000000c835f0df>] __driver_attach+0x84/0x124
>>>>>      [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
>>>>>      [<000000001735e8a8>] driver_attach+0x24/0x30
>>>>>      [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
>>>>>
>>>>> This is not a memory leak because we pass the share memory pointer to
>>>>> secure world and would get it from secure world before releasing it.
>>>>> How about if it's actually a memory leak caused by the secure world?
>>>>> An example being secure world just allocates kernel memory via OPTEE_SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
>>>>> IMO, we need to cross-check optee-os if it's responsible for leaking kernel memory.
>>>> Hi sumit,
>>>>
>>>> You mean we need to check whether there is a real memleak,
>>>> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC_ALLOC and until the end, there is no free
>>>> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak, wo need to judge whether it is caused by secure os?
>>> Yes. AFAICT, optee-os should allocate shared memory to communicate
>>> with tee-supplicant. So once the communication is done, the underlying
>>> shared memory should be freed. I can't think of any scenario where
>>> optee-os should keep hold-off shared memory indefinitely.
>> I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
>> the config file [1] and the commit which introduced this config [2].
> Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
> RPC shared memory remains allocated. I guess that is done primarily
> for performance reasons.
>
> But still it doesn't feel appropriate that we term all RPC shm
> allocations as not leaking memory as we might miss obvious ones.
>
> Xiaolei,
>
> Can you once test with CFG_PREALLOC_RPC_CACHE=n while compiling
> optee-os and see if the observed memory leak disappears or not?
>
> -Sumit

Hi sumit


The version I am using has not increased the CFG_PREALLOC_RPC_CACHE

switch, I checked out to the latest version, but because of the need for

additional patches for the imx8 platform, I still have no way to test the

CFG_PREALLOC_RPC_CACHE=n situation


thanks

xiaolei

>
>> [1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
>> [2] https://github.com/OP-TEE/optee_os/commit/8887663248ad
>>
>> --
>> Jerome
