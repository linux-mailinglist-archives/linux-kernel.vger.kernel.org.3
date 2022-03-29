Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C64EAF67
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbiC2Ola (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiC2Ol3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:41:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421942FE40
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:39:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TCaJ4L017293;
        Tue, 29 Mar 2022 14:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : subject : from : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=NCjtGszl+hg1EfvcxXtF71YX5QeEwGdi5JEQNCrazOc=;
 b=kAC9lE4tFAea1i+URN5mzhoNpgPt6ZscwYT/VcBMdeN8stuq7jBoKyVt6erfdsT/V1hH
 U4o6NLUjKkG0Oz19W2PxoxJ4lR/nBkh9g/xPk2CRMxnnOwy/0YFRyaO4kMD/LX1tLBlM
 ykA2+83mVUuLm40oZtQuVn3NFjU8mdKsQl+rAXPczE3GuWpifC5VYmZYZ1/jTocVUOwW
 EivGBC322DnxmjtxcsJvVvgJcsLWORRT3mkrFzj0s4n8+Jh9sCZRRbuRKMmltJkWnb1A
 6Oqf+VXyfOLxrvtPClnS5HOI3YEc6NbbxSzl2exrczLSvkLW+CzJpem5AGHkRlCtrpw0 MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cpnm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 14:39:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TEahh0003469;
        Tue, 29 Mar 2022 14:39:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3020.oracle.com with ESMTP id 3f1v9fgnqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 14:39:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZ5gBVVb/HVoMUzcxZM9vfV8eS/v/DA295m3RoW5nWMISX5vZRXhJzOOitwSCpYEBZsnEQkR8iDDD/dhj13p+WSWeRn+kOLbSpI+bS9dIsdx1XBBwUx8fnw0XQgACIuvAsRepqKJwolA4FWoVhvZykjX6YajbItZGQIbEgzBa3gaUhlQbLjBqTbLW18JGu1Zt6XOxis+70wRLIY9isfcHm2ymgyHCfGfpsf+ohqH+qUZlfoV34NVpe58JisjMFKVIZ/gWvtnestG98N7s/iQgaaAFEdPPGdQV0Ik9IREvcxzI1atNAzvm2QLKvMO1ZaGJDid8FHPEfbbNuBMmGRGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCjtGszl+hg1EfvcxXtF71YX5QeEwGdi5JEQNCrazOc=;
 b=ZrKrHMm9Muoata6ICgObH4ojNVSwUDAYMcSRTVANP9LBVqd2fO2AjDRW4dy6PaopDmeW2pzU8g1XzAhpz6xfDv9wzyUY/4Uz2OpGnmFuzZwmEIO4EKXn29KD4xEYVZz5bEGUu3oqXDGN4QFdks3eB+8IBHUn/PaxWYhD0VwLlkKxJQ21uQlHaSQxnEP+oYyfTGR1+Eg1pYfEcZnLJyDGTsXkDTePzEc2+6LS/GXDw9K3rPMKxPp/4Hnypg3gpBGAoW5+txMtDvP+m5BPfWJgZFK4qBIrVGuHoOSxK1+nfDtm/R1rN2SdpHRyykXAv2H1kZFNqh6usMKxCjbOJFkDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCjtGszl+hg1EfvcxXtF71YX5QeEwGdi5JEQNCrazOc=;
 b=uU9e5RP/eepHQ3jHR9InzSpFPgWSGfPG92poCuXPOVBmWve7zzvG5L6XzK6q1lo2lN3tPuXz3Q9Tu8/Lrz/iCVSAuz5ZiZuO6W9zkFHTp7K83EId7/S82LZFMbu4fXHs6Yg/aKRrlaLO5t83A//8fhqAtvLAss2l/meysnkkEqU=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BN6PR10MB1971.namprd10.prod.outlook.com (2603:10b6:404:fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 14:39:33 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::e05a:1300:5339:b87b]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::e05a:1300:5339:b87b%4]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 14:39:33 +0000
Message-ID: <4af677c0-e9ca-fd27-8c20-66b6b4ba6c11@oracle.com>
Date:   Tue, 29 Mar 2022 09:39:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] jfs updates for v5.18
Content-Language: en-US
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:5:174::28) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd45d281-aeab-4670-a814-08da1191f064
X-MS-TrafficTypeDiagnostic: BN6PR10MB1971:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1971D32EA4E9086E92EA4475871E9@BN6PR10MB1971.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MmkRI8W7jzfn60jyS/Qf/xz3OZlyMNaltbIXN7KeEwDdAoHuh/InQyhYWgB72jigIqlzvkdN2Ay9HrH/Dnyd/9n/IfmUAnqSCM+qeTirjsAmPKmsb06Org6TZJo5BNSV+5u+xBdB7v+wG5SF4QbGS3JcrH7Mtz0HjeONmOMVLsuWQIanc9RI3BgtozYWwwkMZzx1xoXlzWTplYKQ/eFspsK950DdOqPjDo6k72XJRjlq1zYpK3WgfFk1qiZ/CRJQ0z9UM7L6nQNF+MFI3OWkaGioOsklIQKSh6HmTT/P9kjn5vQjXnW05coCsiccL9myoiRWA6y0bLfuBEp7lGSAY+/4EJ6B1XqzNTY86qJ0NX9Uo1PLfYkveP1uW11MTztEEqb6dM3G9jkZY994Qn6AtSHl9+MB+5DgtFGpFfsx1DbS3x/c3AVECJsiPNrhiF3/VsLqblTuuWXAZpiufSDdXlG+haOz9T0CPQvMOdiUmh5IQG57AOM+GGh3fCgdQhEEmphNGFz7Hv05GslSb10nqwCAmNXlSZR2Su7DN8qZwXQ2IzHxlnPiYIhXyvi/oA2hMO+iC1zxHKgzKK3tAU3YFUyvc5nq7jWp/8bmsnII0CuUWuH0olFkYVXfXgvGssumWKYC4rS0LP9FqQdHe4S8K1o0GBNYoWnDy7yIOny4tbZfsT+dJWsVVI0bAzZ/LeHWKDXc5V/9V8s/lRIgu907BYP1Mqba03DYbuj4392FuCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(66556008)(66476007)(508600001)(38100700002)(6506007)(6486002)(86362001)(6916009)(31696002)(316002)(83380400001)(6512007)(8936002)(2616005)(186003)(2906002)(26005)(36756003)(31686004)(4744005)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTR1Q3FBRHN3a2VnVktjSTV0Q3BxbFJmbmhpbVpBb1JkVFpoaGxmMTBwdzZp?=
 =?utf-8?B?T2hFZHJhbDZtT3Jqdzd6TXhBLy8rZVVDNXkrdmlCV0QvU3M1d0JOQVpDZ3BH?=
 =?utf-8?B?YzlFQlhycGxYbFdlUGUvSmdZSjlyZ2JiNVFCc3ZPT1JIMHRSTmRWNW1jT1lH?=
 =?utf-8?B?RVBVYjYvUDh0enRVekdabW5JZ0tzclVReUN3U0RkcVNWR0lZbWZXU0FQZzdH?=
 =?utf-8?B?TTNJT1p4QmdmQm1ITDlMS3NpeDRaRDBBWDAxRTVuRDFhY0FUYms1aWpnLzNN?=
 =?utf-8?B?UTVkMEYvSzRQaG02L2daa09iQXhXdmlQWnhuckFjTUsxd1FlT2xOdldnRjBX?=
 =?utf-8?B?RG52TndtSzVoWGNBVnRZRVJXQ3pVNmVqdUc0ZXVoenk4b1FLRHUzVkx6ZEhT?=
 =?utf-8?B?ZDRHeHpiNlJkM3pib0NIdnB2WlZwc25LSis2N21DM21qbXhyNTJYUnB4aGZo?=
 =?utf-8?B?K051QTc3aTdQMHRYUEpwN1phdmdkQVVGTFZ0d2RaRjdIZ0V2Y0tzdzdRaTZH?=
 =?utf-8?B?eWluMG9XV3RMbG41TzI1MTdKZktOanlwM21CSlZzUTlWb0JOdDh3ZXA2RVlx?=
 =?utf-8?B?MGtucXlOYnc5YWNtdjE0S0RmcGZQbzBkS1FadWhFUXczNG5pRTNja2JMb2pD?=
 =?utf-8?B?bWZvRUxVTDF0N21QR2M1LzhxcGRRN1lRRkdPbzBkcGdtL1BoNkpMZW1iWXlh?=
 =?utf-8?B?MkNLRm1Pd3M5VkdBUHRuRnRVK00wVExjcXh6d1NsYTBocGF5UzdvQ1Boc2c1?=
 =?utf-8?B?L0JlRml6U2o5REFqVXJiRkZQZXA4bUJ6UVRaMG1vV3ZESElCcklIWEZhaWI4?=
 =?utf-8?B?SVM0emdRdnhzcTVZclBGR1hBTWp3K0dpQkY2YWw1Y1J2b1ovdU9BaisvRVJ6?=
 =?utf-8?B?MEpxMkViTG1EcFZXd2pHakZ0eDNKem1ESHNidERmWmtjd0tJZDB2NVowZDNa?=
 =?utf-8?B?UVlKN3VRYmY1eUd6WWtHV0hPTFV1bnFoNGxrTkdPZHhmTmh6VUJkUFBTaXlr?=
 =?utf-8?B?TmtRTVJCeGtHdGY4bFZ6bEMzRlV1SFJCMEJxblVzYWFSb01PQ3VMeDdOeWNO?=
 =?utf-8?B?eCtvQXZKY3VhcThKRGdiY3hGRGVublNEUWJpSUJvRGJtVlNBZnZYZlN4blNs?=
 =?utf-8?B?ekdSU1czbmcvWkFUVC9YcGpUUkYzWWU5TzZNY3AySEZDbzlJaW51VldDTXdV?=
 =?utf-8?B?MG92cjB1ajZOMmxVbllyYW5LWGJlUCs2MU1iYllKT0F5a0t5RnBCb05BNlBa?=
 =?utf-8?B?VjUyMG9oSXdyVmNJdXp2aGt0cHpmZ2kxTlBsQk9lRzZhUHRDK1V3bTZwUTVO?=
 =?utf-8?B?YmVKU1BKeXNzWTNGM2VjUzJWQWVHdlgvYkh4RFFZVTlxWTRGRStWbkQyN0JX?=
 =?utf-8?B?VkZnZVZ0K2xWQXI2T2gvNE5FSzZaVnpsNHZJWmd6YnZQZzV5enJmMzBtTURI?=
 =?utf-8?B?SlBYUFJpYkN2bVFlU1JWSnE0V2ZDN0JGR0xqV1REOUUwYm1vcmdIR0dEZys1?=
 =?utf-8?B?TTVaZ3Z6N0lEdklWNHpCd01xR1dsdng3M2p2RnNNOVZEUVNmU1lsYzdpSVpi?=
 =?utf-8?B?U0FhcEVNTHFvL016T3pWa01iK25rNGNwVDVtNExkYjFqZHk4dTNCTWJGdTNo?=
 =?utf-8?B?b2FRSk1yMHpINDhxcVBUVktZYnBBZFF4UDZZQkZRSlVVb2U0MVNjdVA4WEFK?=
 =?utf-8?B?d283eTlHUUxqc2RHV2M4ZkNMelVZSG9rbFpCNGs5TDFvZGdvZUdKdDNhYm85?=
 =?utf-8?B?cHFqTytxeU4rMDc4c2RJTTJ3Y3ZQY2ZKN1M3ck5LTW1RUjZNMXg2Vkc1VmVq?=
 =?utf-8?B?Nm55Uno0VDhKQjlrY01KVmg2RkxiOTdIYUMyVjVURGg4ZmxzT0pPcGtJWGxR?=
 =?utf-8?B?YUtrNncycXUrSU1UZ0hGWktkb281K0tzNVBCR1ZjZ25ockxLMmhSMW1ldUNV?=
 =?utf-8?B?bERtaFI2MjJSYWRvQUw2SEZnLysyZitrZ1pHRHk3c1dQTDNUbEhNTzNEanVq?=
 =?utf-8?B?UUdiVURXQlNORGd6aVRMMDFjTllNT1hjdkVzQ3BaUlZMSVh1TVhqWkd0eHB4?=
 =?utf-8?B?N1RMaTJXRGhFcXFvZnNMeXN0RG96RDNqelhNUWFJcXIvbVczS2NRcXpocXRE?=
 =?utf-8?B?U0tDaVRvbHBGT2RJT25LamFIMjNzNWNiVEJkbDNVUit1ZnN4K1lQS2x6c3Yy?=
 =?utf-8?B?OGNjcHZweFZoVmRQL2JydUUzNDZseElJOWZhVjcxaGFKN1d4Q25NSXpjTk5G?=
 =?utf-8?B?NVVYazVkUlFuWHd6dFZBa2FmNkpleTdIVTRldWkwbmRzbDhZYzhpNDFTcExo?=
 =?utf-8?B?b3UwdndSTzgvUy9XMFU2MmREdFgyYU5PUGVDYU16cmI3TkV5YzhLamQxZjIr?=
 =?utf-8?Q?Bpr3W6W3vt8T5VSo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd45d281-aeab-4670-a814-08da1191f064
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 14:39:32.9592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxbuK5/imhgMpBASxqC9gMDp0w9qTmo63+xQCjuBGgC2TtFKuw2a1wuMvsWBO/q/Lr7ZSIuc7B8GPsj2H9MPApWOvPgIFK/niiY8TlCuFrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1971
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=877 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290089
X-Proofpoint-GUID: AIxT9aoNoBUWIoVeg7qn87DiYxmTnkPi
X-Proofpoint-ORIG-GUID: AIxT9aoNoBUWIoVeg7qn87DiYxmTnkPi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b47d5a4f6b8d42f8a8fbe891b36215e4fddc53be:

   Merge tag 'audit-pr-20220321' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit (2022-03-21 20:53:11 -0700)

are available in the Git repository at:

   git@github.com:kleikamp/linux-shaggy.git tags/jfs-5.18

for you to fetch changes up to a53046291020ec41e09181396c1e829287b48d47:

   jfs: prevent NULL deref in diFree (2022-03-22 10:09:19 -0500)

----------------------------------------------------------------
A couple bug fixes

----------------------------------------------------------------
Haimin Zhang (1):
       jfs: prevent NULL deref in diFree

Pavel Skripkin (1):
       jfs: fix divide error in dbNextAG

  fs/jfs/inode.c    | 3 ++-
  fs/jfs/jfs_dmap.c | 7 +++++++
  2 files changed, 9 insertions(+), 1 deletion(-)
