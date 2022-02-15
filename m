Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005564B6B44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiBOLhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:37:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiBOLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:37:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC67BF54
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:37:21 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FAZNxE005194;
        Tue, 15 Feb 2022 11:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OV6coui6K6zY9SDU0HYS3ZFSOqCr9Ia/uF0Uh5pkMjo=;
 b=BAQK9VCtnclJ7TfVqK8oe7+lVSs8rgnjuslwTdKhXveH87bBMTdIzPHA6jqzFTpFK61s
 QWGuaW6u9vc+x81/VH8F+X8ZmCYfQ8k1ee6ANSwwwxasUef+HFJFD/BFMYSp4Y7iX33L
 qB8KcEQ7yfYk49d7KBCW7tSkdT0NSba+M6DqJsi7TUWpDGg+w0ELBlbiyqXa1r4NftNU
 YtDM+MX48+DBU9Vjg8WVmA+ploObYS3dpVNn7S6doVsfV8ImLVm9YLmVAfAJRYHVEK0B
 2VsIc5ZDaemwAH2gfcsiTqCxlJE1boMv3GcNuLGjTf4lrnh9ciO0IHGvcuwRqeT0/khe 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8570s25w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 11:36:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FBW4kb174545;
        Tue, 15 Feb 2022 11:36:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3020.oracle.com with ESMTP id 3e6qky1dp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 11:36:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpNxDQBKvDy8d1rIcq6a8gzilzV8ae3vJPF93m4SyPmrwAqes82WOgJqeViVdFLt4hucTOrjGGG+/h8isxpxLyf5m5FRZNunsn5Hzdez4ewc228jg3SZcNy+o/p+C2/6GF0VcTnZR60mIg9S/9C+INQoLkTi+arUAmheCyzCZu0QSyAmpsTg7lpQWkndw9h7CNg8G3MIilKBtGYka7SHvgKJ60cVy1SmJ3cmZJkESQvV5ljkc+IGBWjAIXuSsu1reb7536WptY89s59DVLBNOxyYT8D1giyANAaHlvI+Z8bwQYlfvcJ9qeFQ7Di0/M2kx1W9JtdZRLdOS3Dj8q0qxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV6coui6K6zY9SDU0HYS3ZFSOqCr9Ia/uF0Uh5pkMjo=;
 b=QwtLj9doUHBUr7N4YBxaFOkCjbis1C1bc0u3euZuMIpcahg0w80kj2kuUyWKhJyx7tRW77PmjKTJUewU3pZusEWH+5Eud6TSUEciidaKFuKEdX0p09L6VA5/hHEXOsRBXP6fdtfU8KYxP67sVOrbRXfH0eur/Un2cvjbTBMGWXOsShl3G+o4gHTXFPo/r8H/hQJ4GGqZ32RrJadDY27yhag2Rw1FOjgM5Mo6zbPiGcVN4gmQUE4SNOZBZiTGNzxWK/uoE889WqhjP9NKolBp4L4YHf5NieWpa8bPYQgwszO8eiYK63vJ3ZF9lMPMFJBkVdw7aiTqx19I45NOucRKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV6coui6K6zY9SDU0HYS3ZFSOqCr9Ia/uF0Uh5pkMjo=;
 b=alVSBizRMBuW2rdDmNaXL6W2mHHJtOrL1TvpLCjWnaOkMA7IFDKR/K4EHWraJKUjWxyFXgQSUDjXxEEiWMp0fZ5nk2ldkAwh4zDvC5mhWqExWuDmkFpdFCGZdkZoM5f6V+e+SiY6vtcjrM+l8uMXN1tZGfymBJHReyWEpsyglxk=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BN7PR10MB2673.namprd10.prod.outlook.com (2603:10b6:406:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 11:36:53 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 11:36:53 +0000
Message-ID: <bfb76327-0054-a4be-51d6-f6bf3cc2e7ee@oracle.com>
Date:   Tue, 15 Feb 2022 06:36:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] x86/boot: Add setup_indirect support in
 early_memremap_is_setup_data
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        daniel.kiper@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
 <1643303056-22272-3-git-send-email-ross.philipson@oracle.com>
 <Ygat0FvdP3bWlJbx@zn.tnic>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <Ygat0FvdP3bWlJbx@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::20) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1898b8a-24f4-4d80-317f-08d9f077766e
X-MS-TrafficTypeDiagnostic: BN7PR10MB2673:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2673F602CB970C72985BF9F2E6349@BN7PR10MB2673.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vW1Vk/mMZMDifdG43DX3ImDlVSW5/6vPYr3RxYw2uHsPPLTXlNNCd7eh/pfgDzAEFFpY8uGBM88ceRjRxsubq4HX0LhprNPEXGQna8YgUU2Twzch9Kl5xxuRxC+oPXhjzMjoHbFU2d62D1+CSO3LqS12pMc7cWFD8GWJUe0NFdqeHqyTOA16YTDcw/2Rkv6gEHed3umqnudLIg0IPfx2ELi1Ukc0cJNbPdiSv79dCYQ7ziZkgAabbUzB3wPd0vLQEWI8npuhe54lKjIxZlnFMeI0MgN44dm2LjMpNAfmMKg1jZjU2rJqSahVIQw+1LZQp5vHy03cjFGOX6GnRh4cOX2dxFRWDxCW1lGUiNFRsGIE7ASHo5EdMdtYKDy7Hjm28cESeGnugS31dQD3BaZcpUTxDK2+0LwCfeI6VC6f93ezOp/j+zI4h5M2Mxga34P70Xxki+NLv3BT63rjPQKGXRwjOgqNW6rmdG2+xVTHpdnc0Dee40SUJy/MSTSbTCCVdeGa28uOMPB+oFYHwBk315e2FToFZeAti4OCnTL+8qYkTpQFcFTFLRbpa8iLl2CO8UcNMNqMsvyqsWjxl3xkofvGpgVFoTtSA+R6wFcy+1zk0MpiTLibu90EU+QSsEkQUtWbYdGTZ/r9H6UXeKZzp1yGHtMHxwf1rKKQahgvuJ8s/G8xZmNRX1kKVT1P4f2C30pKDLz7K4u4e3p+bWb7QHEy06XhpebxwQwqBEmRNpahz0OjRg6KQ+BjBBusWNUl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(6916009)(2616005)(8676002)(4326008)(186003)(86362001)(31696002)(66556008)(66946007)(66476007)(6666004)(6506007)(6486002)(38100700002)(8936002)(6512007)(53546011)(44832011)(508600001)(2906002)(36756003)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm1EbGRyZ2tQZVJKRDRSSS9scGdYV3dEaEYyM0piMktlRlp0TmhSRFhJMXUv?=
 =?utf-8?B?cG51ZVV2RHgxd1l5VHhKVmhxVVF0bXFRTERmQjRJQjFoYnRlTVZLUitDMG5F?=
 =?utf-8?B?aGxUUzdLUFJ6d1lZQmVwYzRIY3NralA0ci91U1VFUW1BaTRFL3J6VVVaUFMr?=
 =?utf-8?B?aUhmWTdqQ2tmeFo2QzRQUmd4V01vQlVHZ0xLNDQxNGVHTklKNWZNZDA0Z3ZC?=
 =?utf-8?B?NUovdkZPN0R5bUNISHlXdmt0MzVjNXA1TGU2dVFqak1FRFVqUVNlWU9zdk9I?=
 =?utf-8?B?UWtRWm5aNlh4WGdhNGhuZmhtV3YvQnFyUkVLNWw0MTZNTzQrQWY3VU9nNUZQ?=
 =?utf-8?B?RlJTZm5rTmhLVXZ0MUJCYWlIdDQ4VzNOLzZweGtad0t1THhYd2haY1FSb1ZN?=
 =?utf-8?B?MDZxdzVtM04vY0JFd3BxRERlaWRCQk1IazVmUEhoZndHK0NRRjVDVUtKc1V1?=
 =?utf-8?B?RklMajJzai83ZFZrZkN4R0VyRytsUGxkZG1INmE4Y3hNSlZVL0pyN1c3Vldw?=
 =?utf-8?B?MDN4VmpKTS9HMm5MbnVYamExd1FVWXhSUExMclRhaEJMdVdCRkpaNG5PZk9W?=
 =?utf-8?B?bHUvTU9US2JHcGdsV29HWWs0MDBoalhjUlIzQ2d2UWVzNkZkbnU2STVnYXNC?=
 =?utf-8?B?bjlZbDFldVR5T1pBRWprTE1TUEdMNFpKRHRlWWo3Sk4veWc1RDVCTDZHYk9m?=
 =?utf-8?B?M1NqQnBMbEJZdjROZ1J0Z2dqZmFZa0ExclFYNGRIRXZ3KzE0cWZkVWVyUUtj?=
 =?utf-8?B?QUhCY0Jma2hUYmpVUHUvb1ZTMC9KZ2p0WjZXMmsxVDNnTFNxaVN5MDM0WHFa?=
 =?utf-8?B?R2dqSFF0NmdObjI5cnUzbnA1dXRBQjdOWnRYS2lOelpSZVQxQmJCYnZPcVhs?=
 =?utf-8?B?aW9sVlZXWHVGbEVCTkRaRlMwcGdrRUdjSE54UEFQcTlnV2RZd1pUZTVTbmVq?=
 =?utf-8?B?S2hDcUxOaDVjeGd4MUZBeVRIVDYzMEUxWkk5eXRIeDJ1NFpMOWlzam9qWGR5?=
 =?utf-8?B?bUwwSXZVZGlTREhRTHpLeGdCNXo2UFg5Sm56cXVZbnBVazdKejZIeitvbU9S?=
 =?utf-8?B?TmNRWDBoL2F2S2NXR2FYKy83eW4vODFRNm9IS1dCRnY1eGNaNDdSaEhYaHFu?=
 =?utf-8?B?RXpkY0dsRWgyRVljYWNJWk1uWkdUUUtTOUYybi9mWlI5MlhnT1p6MUJqb1VS?=
 =?utf-8?B?N3hiSmxBZzBYOE5BT3E0cnlQbldra2J2ckJyVlNUSDB6WFY2ODk3dnA0UXk2?=
 =?utf-8?B?aTQrZXpoVEt3NkJmSHVXMkhHT3lVcThON1NDOHFyS0NUWXlKbkxiUGZwMGc5?=
 =?utf-8?B?OXl6a1FsTWJMRnJHTWZ3NDlmQ1JqcWo3aEk5ZVdWdjNJYlVwMHpzR2U3OVBV?=
 =?utf-8?B?dW9OL2d2S0NrbVBqcXphb0FBcnUveHVrYWs1RUNyTHlhZHpBU3dydFV6Mjd5?=
 =?utf-8?B?S2hUV2RsZmwxaWR1YzB0SlVWRENkTnc2NVpFR1VnM256RndmKzhwWnA2Wkw0?=
 =?utf-8?B?L2NGRHV1WG1aVVVrejZ3YWFlTG41UmJESnBNcWRyS3NPcVNIN2c0Zm50S1Iv?=
 =?utf-8?B?OUJXTFhPNzVoOUt6bmk3a01KeGhRN3Zmcmc2NElQSEZqWGczZjBuRUNGTGxt?=
 =?utf-8?B?RmVvUHczcWtEc2pEYzdpQzcyckNUNGRlTlU5OFQwcE1pRGg4MmNldGRob0ho?=
 =?utf-8?B?eDZnWFF1aHVLSGFabTVJdHk0aEtrUU84d0t4K3FoY2ljYTFrWUhrc3A3eE4r?=
 =?utf-8?B?dFdNRGwvQ2dNMi9LMlZsc2RtTW9ONzNWV1Mrd1Iyc2phYVhsdWVxZExWaTJh?=
 =?utf-8?B?Z3BFRnF2bnQxQnFpSzI3Q254SkxtaXc1eDBlbUZpNEFOVjV1bFoyei9Hd2Mr?=
 =?utf-8?B?bjNVVHk0VGhIemlyenRrQmZQczNZdW1RQ3UvTVJDWk1WS1BETWFtRmhTNjI3?=
 =?utf-8?B?RiszVEZLbjFuNFpweXdyMFZPeGVZTVo3cUhzOENVa1YzWmZOalBaaTFHQjhK?=
 =?utf-8?B?SjdoV3NOZVJJL0J1c0o3K2JHblZNRHVtc3o1Q01CMEk5UTVSNlM3Mk1GVE5Z?=
 =?utf-8?B?QXROeE5VNjMvSjUzdkNubzBZSC9VMjlEWmJsbEU1S0FLd3pTSHRwbTBvamJ2?=
 =?utf-8?B?bDEzMURETXZXSTQ4VzA3aU5yWGtoVzAzbnJrTUdzb00rd2NuT21raGlZWnM4?=
 =?utf-8?B?cEdYRHFNclJEMFROQ29hd1dpUGtTbEpxUEtpSnYwME5lMWR0Z1lPekFiT3d6?=
 =?utf-8?B?d1dhNTlMSTR4UzRIMnRJbHRSQU9XSkdDMmdxeU5xV3c4OEs4SWxYaGFKUVJt?=
 =?utf-8?Q?GYwu8+LtVjkobnRGAx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1898b8a-24f4-4d80-317f-08d9f077766e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:36:53.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScBp6CIvhB6xBQnw+5e36xKh7AX2qTVkAtQI3o8uVVLO9HQxP5F4h7DqmWkgFvWDb+iJZhqyLdnBPVKD3pXHqUT9znmoFE1bLXpxw2A3jWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2673
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150065
X-Proofpoint-ORIG-GUID: ft-lX3OMqVd3HkfpxOYaPpSM9TrRQnG_
X-Proofpoint-GUID: ft-lX3OMqVd3HkfpxOYaPpSM9TrRQnG_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 13:41, Borislav Petkov wrote:
> On Thu, Jan 27, 2022 at 12:04:16PM -0500, Ross Philipson wrote:
>> The x86 boot documentation describes the setup_indirect structures and
>> how they are used. Only one of the two functions in ioremap.c that needed
>> to be modified to be aware of the introduction of setup_indirect
>> functionality was updated. This adds comparable support to the other
> 
> s/This adds/Add/

Ack.

> 
>> function where it was missing.
>>
>> Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
>>
> 
> No need for a newline here.
> 
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
>> ---
>>  arch/x86/mm/ioremap.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index b45e86e..9129b29 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -670,17 +670,34 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>>  
>>  	paddr = boot_params.hdr.setup_data;
>>  	while (paddr) {
>> -		unsigned int len;
>> +		unsigned int len, size;
>>  
>>  		if (phys_addr == paddr)
>>  			return true;
>>  
>>  		data = early_memremap_decrypted(paddr, sizeof(*data));
>> +		size = sizeof(*data);
>>  
>>  		paddr_next = data->next;
>>  		len = data->len;
>>  
>> -		early_memunmap(data, sizeof(*data));
>> +		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
>> +			early_memunmap(data, sizeof(*data));
>> +			return true;
>> +		}
>> +
>> +		if (data->type == SETUP_INDIRECT) {
>> +			size += len;
>> +			early_memunmap(data, sizeof(*data));
>> +			data = early_memremap_decrypted(paddr, size);
> 
> That can return NULL.

Although there is a bit more indirection here, it is the same reply with
questions in the first patch.

> 
>> +
>> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
>> +				paddr = ((struct setup_indirect *)data->data)->addr;
>> +				len = ((struct setup_indirect *)data->data)->len;
> 
> As before, use a helper variable here pls.
> 
> Thx.
> 

Thanks,

Ross Philipson
