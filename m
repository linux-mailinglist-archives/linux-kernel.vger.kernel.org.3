Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BD24B8FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbiBPSQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:16:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiBPSQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:16:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081C02B1012
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:16:22 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21GFl6le019159
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:16:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=d3gg3Ir9vmwiYQYhMBUZLt432ul5j8iUIzQyvsAYDKw=;
 b=JTGP6yvaIfiiG3UCDR6HDb5OEQXm2QYYlXMss0al5SCC6RYNPIiwF6asOYU0gV9kTYjC
 lu9Pj9x6TacKnZQYiFGMuGEinSLN8TU6j/wITBNWNXzvdYqnRpcle9oFxwsSM9vDBhmz
 uQT8vGqzNtQ5JphbETiRpXgzggSqxGdiORc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8n4becqu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:16:21 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 10:16:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJZhEWbB1NtYIjZLPy66dk2d5mCjlXUdC8OJn/hrNzEzbvFg6nabQESxDIZymkQ28kzQH2+Y3dhQoLbl/tLLTp+d/hYrrfzK/ujq1Kx/UnAhPFHFXUEt64dx61jvkqauZXg4LL3kUbLHzOX77kZ0oTivpkFVrHqOEQ3/HLFE5l+gMk/lISWzI4SDOPrhoXrtgwLWtciOeGoK5M3lV0pRORVWMtSu1710efufSnWfBYNK4nsFfL3VtzY9/Wj/HAC4Sl+6aIhpV5KjWUtRXXbHj+CPYFupdkHAB70o+7bx0rY/qnYQG/U88+wdsrz2tmmhNlXeszJLGxLQejMKZpl+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdpDJpv/iAzJ7+OoSev/dSpfaFMyCGXiauIEa4QLNHI=;
 b=MOzwuAhcettU20+fk8p+gpRrgHcb5fz8/jvD5Y0Fu4gTnswPwl57Uj/oN4ekdGgrvKMbwlT0iC1DKaXvjGXQJ5DgV14OPwvaswt9hHocY27oB9cHTcOlKys443ySNiFOvauvACYV7nPXnyqyOPnCFpkS4dSa+tlqNQhl9ptl70DdBADL+vvTwVpGCK+5bRRZGIKjy+nq0oRV+16K68qsJB5WVTIES/wL7/+Bk87CSpryCx5HVyMg/4uaj7DZpvujNStpcaZRx4UxUUuJy2BQEatLfIJGPBnDIIK6qnV3iI5vsFe5z+e1Le74K7jzhiar4v+itSpGncl0oMDwmpCwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CY4PR15MB1686.namprd15.prod.outlook.com (2603:10b6:903:13c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Wed, 16 Feb
 2022 18:16:16 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7da4:795a:91b8:fa54]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7da4:795a:91b8:fa54%6]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 18:16:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     kernel test robot <oliver.sang@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKP <lkp@lists.01.org>, "lkp@intel.com" <lkp@intel.com>
Subject: Re: [x86/Kconfig]  fac54e2bfb: kernel_BUG_at_arch/x86/mm/physaddr.c
Thread-Topic: [x86/Kconfig]  fac54e2bfb: kernel_BUG_at_arch/x86/mm/physaddr.c
Thread-Index: AQHYIzVSQuEfmFgs6keqwVVvG4VZRayWfCeA
Date:   Wed, 16 Feb 2022 18:16:16 +0000
Message-ID: <087FD6B7-FC82-4868-9A15-F094C2EB7C61@fb.com>
References: <20220216130040.GA14084@xsang-OptiPlex-9020>
In-Reply-To: <20220216130040.GA14084@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0085d2c6-88de-4ee1-3955-08d9f1786c48
x-ms-traffictypediagnostic: CY4PR15MB1686:EE_
x-microsoft-antispam-prvs: <CY4PR15MB16866A2DCD03C3F820AAB5E8B3359@CY4PR15MB1686.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +S2N6cj0LBQ7WONfvx5XoNuaX8n8HTKN3fh6bHORCMmdfZM2l84Nz5Pa+y444vSPcsw37t2rmPqydBSrkKVsnQJn85QcPKCB9QsyrIkVqTYam2z4kqsi8Ek+VCrNlgshfuJXatQDEI8oyZMZAfSg2LZTnwYouQeDhiAsCpF4aibMCFXQ1iDl2b1MJCjDHAajPuAzD1630I2XgkECkvQMsl+gD4fwV9mpMi4uNHEprZ6tP1hAPEwhQsPR7zLbsOvIVgjS/H0731pBe7IWtc3FcKH9aMje/Xibbi+Ms5i6xEzvJMWig9DeSMxQOrWb+unR+5iJ2HN247SSVgIYOgDEj0JZ4IUQUJDy2cKdh5hiyBq2ibKxWyf3Wc583rnVifaZw2lJHk43juAGE/9UagcG01e9YUar0YkBX0kCSOeURX4+pgql1JVriloLNplQnPjlSafHCslERKSI7VKT4bddiFXztTYO0OIXlvfn7FgamzU/Ay7r3V7VG4802u+d07Hs+A8WE4PVnJNVrf612Ty1LN9Cssdfl4rATzm99uWTpBhj1wceH7JtR+d3BFHSzTeRu2bzMulbKBAfwzRGG7bHujJKVG4wiJguGlzGPgMyGN/GIp6wegCuXY6i8y5XRlYKgzNAWn98Qfk12A/PEoX50+MFrzuTdK18dQVZc+FNuKJSOyfgpulGaLZs/9CpEQLSsriTDSXLjUYIdHCbWaS1tlTADfebU8gZCBc1bG/JIlnwYAM4FTqKXE26eQDQVnn4HjWK9gcYP3erVbQzk3qGqoIemsjq2ZJROz9piZ4Fm1UYWyMnhnCzLI+KnsTu2gsxWQnlWzUbMRyK8bJ5BAv8S02HYuxbq+JndQeIFJ2lb/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(122000001)(64756008)(53546011)(316002)(2906002)(6506007)(66476007)(38100700002)(91956017)(36756003)(66946007)(8936002)(66446008)(54906003)(38070700005)(4326008)(66556008)(5660300002)(110136005)(71200400001)(6486002)(508600001)(186003)(33656002)(2616005)(83380400001)(8676002)(86362001)(45080400002)(966005)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xZ9YoU3qqyhlHIU08l0/vBDZZkz7ERN+vy+ymftiSiLf3GcvjAiWaYXElWqp?=
 =?us-ascii?Q?uvyawjaEYTqF+LH86cQSiMLx/NXjfERShcxXbo9m+y1RzntwN5Cilm1oKIPm?=
 =?us-ascii?Q?FuAzlPSF/Rf2ai4DotQVL8dTdA5gyyQYfjFVcNF2dGrdvM+kOSnMePa1Dod/?=
 =?us-ascii?Q?IMvzYJH2/uEeuaEftGnTDz//RbApPNfTyYS+Uivs47EY+madTUL2actGgFJ/?=
 =?us-ascii?Q?vwLLxHTeMg2y6on/Q3zaVo9qlLtN2TYFaY+1wRNNIL5iYs5EWtr/PvgY3yIz?=
 =?us-ascii?Q?bFvoW508kBfL8V6ueYQTS/Lt9bb8FEUvt5ml1JxiiXbQ45u8HPPnJrafvQyS?=
 =?us-ascii?Q?Qt/yaABrGKRImp/X0K9SfYlyVvpU7cNVHlJOS/9ohjBJxvLRUAJw92/qI1nn?=
 =?us-ascii?Q?6K44WZc/ObR1gEyGDu5QY0Pg6kX0uEtIfFs/vOL3H7p4le+E+wAcllJ2+2Xs?=
 =?us-ascii?Q?MNmVHRmvbduvvzqoo7CjBRO3Dt5tKYTuoXep0wGTAw3sSzOGsfkOoGgymHCB?=
 =?us-ascii?Q?XnR4IOEzjV8DhGhcgfnWomuB0eX3E9c5lXbC8iX9yRRW3q9zzVRQmNslNw8i?=
 =?us-ascii?Q?+j0vrh54XWS00236a/8Ko6aLpfaT2KkCtAQkwr+mq6vL6Ebxj3uQHHuRKE2p?=
 =?us-ascii?Q?k8K0zIIpDQ0JcBHAJ/ZnVoOtDrZU/tfs+fJolqzLGGtS0Q+522QyNYUSSh2J?=
 =?us-ascii?Q?PNT3OBpCw4mp7FyyJFE/W3g+HnSNWD37pgI8IdL8uLpKlbv1yOXe899pG4fm?=
 =?us-ascii?Q?XZYohlzZuWn9KSe87kI/lJXKuCkcvlupaorL7m+utUPzAQ8GhQx+6wQNc/R9?=
 =?us-ascii?Q?NiuCMugeA5/9G6kWjMPyQwEf0Ewy8qDxsQzaX8WEKqV3sJ689zaUWS6C7ChG?=
 =?us-ascii?Q?TPhMiRA4YW33UMTKR+CT3L0R0W533YI5WoEcNTjas3BzZrSrS+V5umINLKR+?=
 =?us-ascii?Q?p3L8Vd2WPrkTzmsZ9MYB3qg3NI72WkjDpZOZaCPo4h1iHJQ3p/v9OSB911LR?=
 =?us-ascii?Q?HM+4yIrOItOsZnDKim1xkvljSmrFr789s2bIg+Ocvvw+F5RSNCeZTF8/v9ZI?=
 =?us-ascii?Q?7Sm7Kf2RUX7BopfmfxYB/rhTmie3oSWDbZygEkATNE52nfE6mvNTfAlmR/Ty?=
 =?us-ascii?Q?2r0CwouVCSPJu57rJlNFvYAF7DKqG8IOU9NOI20/Sx8nATHoezjWI+aftHSB?=
 =?us-ascii?Q?1kmD7IenY5sG4kBL/WNylDdNQ/ogkBB1+jDjwPwnXLrG8TPvRdN1IO76l/N5?=
 =?us-ascii?Q?ZaBk3uPnyPGNnr1XAjQePbObRTxkhQ8l+ZHIqZpCvkf+VPIX9rh+TgNLEX0L?=
 =?us-ascii?Q?Rj2KRx/pc5RGwjSquYLtrmFpRUb06b7NVxmUNB4whbFaSQGww9hEiNmJX62v?=
 =?us-ascii?Q?g1yamTYsQPc7w7MO0m+SsNb6hvWpKnWEDT20UO2bs8ZKrJAPJ4kFu78wvtOJ?=
 =?us-ascii?Q?b4x2q01j6BZk5cci8uNs1R9qZLfqepsfpyECElds99ek1NszZlV0xj3JaHsA?=
 =?us-ascii?Q?Yy6scXNSJXMQg8FvGYZg+3mAW5rRWrK5hrzbEMIAaIXRUsReFxRWkJL+Iz4m?=
 =?us-ascii?Q?8eKwHqnDFLabXL97ECmqbuByustuyQHUWGbaivBc8c66QRSy1b59iXc8ZjtI?=
 =?us-ascii?Q?XWGN0jWOAPO8iJ6ZQ9BoYKQ2Lz1biyQKZ3KMbVU2UXUGPn1N5VShBFedBCD7?=
 =?us-ascii?Q?susgOw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6970D4447019546A7B26B3F68A5C342@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0085d2c6-88de-4ee1-3955-08d9f1786c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 18:16:16.3271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhQSpLPkFuL93jEqR+Ik+XP6u6PAEnwz+Ak/Lt+6trcDzFLZkc+nW41gRf9teZYjqetqsLoHMb7vA8i1iVxtmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1686
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: nPv0_LOPBNgo9Cs8tJwmlE2fkWremNUl
X-Proofpoint-ORIG-GUID: nPv0_LOPBNgo9Cs8tJwmlE2fkWremNUl
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_08,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160102
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Nicholas Piggin

> On Feb 16, 2022, at 5:00 AM, kernel test robot <oliver.sang@intel.com> wrote:
> 
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: fac54e2bfb5be2b0bbf115fe80d45f59fd773048 ("x86/Kconfig: Select HAVE_ARCH_HUGE_VMALLOC with HAVE_ARCH_HUGE_VMAP")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   44.587744][    T1] kernel BUG at arch/x86/mm/physaddr.c:76!
> [   44.589159][    T1] invalid opcode: 0000 [#1] SMP PTI
> [   44.590151][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-11620-gfac54e2bfb5b #1
> [ 44.590151][ T1] EIP: __phys_addr (arch/x86/mm/physaddr.c:76 (discriminator 1)) 
> [ 44.590151][ T1] Code: 00 8d 76 00 83 05 20 92 8a c5 01 83 15 24 92 8a c5 00 89 f0 5b 5e 5d c3 8d 74 26 00 83 05 e0 91 8a c5 01 83 15 e4 91 8a c5 00 <0f> 0b 83 05 e8 91 8a c5 01 83 15 ec 91 8a c5 00 83 05 f0 91 8a c5
> All code
> ========
>   0:	00 8d 76 00 83 05    	add    %cl,0x5830076(%rbp)
>   6:	20 92 8a c5 01 83    	and    %dl,-0x7cfe3a76(%rdx)
>   c:	15 24 92 8a c5       	adc    $0xc58a9224,%eax
>  11:	00 89 f0 5b 5e 5d    	add    %cl,0x5d5e5bf0(%rcx)
>  17:	c3                   	retq   
>  18:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>  1c:	83 05 e0 91 8a c5 01 	addl   $0x1,-0x3a756e20(%rip)        # 0xffffffffc58a9203
>  23:	83 15 e4 91 8a c5 00 	adcl   $0x0,-0x3a756e1c(%rip)        # 0xffffffffc58a920e
>  2a:*	0f 0b                	ud2    		<-- trapping instruction
>  2c:	83 05 e8 91 8a c5 01 	addl   $0x1,-0x3a756e18(%rip)        # 0xffffffffc58a921b
>  33:	83 15 ec 91 8a c5 00 	adcl   $0x0,-0x3a756e14(%rip)        # 0xffffffffc58a9226
>  3a:	83                   	.byte 0x83
>  3b:	05 f0 91 8a c5       	add    $0xc58a91f0,%eax
> 
> Code starting with the faulting instruction
> ===========================================
>   0:	0f 0b                	ud2    
>   2:	83 05 e8 91 8a c5 01 	addl   $0x1,-0x3a756e18(%rip)        # 0xffffffffc58a91f1
>   9:	83 15 ec 91 8a c5 00 	adcl   $0x0,-0x3a756e14(%rip)        # 0xffffffffc58a91fc
>  10:	83                   	.byte 0x83
>  11:	05 f0 91 8a c5       	add    $0xc58a91f0,%eax
> [   44.590151][    T1] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> [   44.590151][    T1] ESI: f7000000 EDI: f7000000 EBP: c6d85dd8 ESP: c6d85db4
> [   44.590151][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
> [   44.590151][    T1] CR0: 80050033 CR2: ff7ff000 CR3: 05854000 CR4: 000406b0
> [   44.590151][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   44.590151][    T1] DR6: fffe0ff0 DR7: 00000400
> [   44.590151][    T1] Call Trace:
> [ 44.590151][ T1] ? vmap_pages_range_noflush (mm/vmalloc.c:594) 
> [ 44.590151][ T1] __vmalloc_area_node (mm/vmalloc.c:622 mm/vmalloc.c:2995) 
> [ 44.590151][ T1] ? __get_vm_area_node+0xf5/0x200 
> [ 44.590151][ T1] __vmalloc_node_range (mm/vmalloc.c:3108) 
> [ 44.590151][ T1] __vmalloc_node (mm/vmalloc.c:3157) 
> [ 44.590151][ T1] ? txInit.cold (fs/jfs/jfs_txnmgr.c:296) 
> [ 44.590151][ T1] vmalloc (mm/vmalloc.c:3190) 
> [ 44.590151][ T1] ? txInit.cold (fs/jfs/jfs_txnmgr.c:296) 
> [ 44.590151][ T1] txInit.cold (fs/jfs/jfs_txnmgr.c:296) 
> [ 44.590151][ T1] ? mempool_free (mm/mempool.c:509) 
> [ 44.590151][ T1] ? mempool_create_node (mm/mempool.c:270) 
> [ 44.590151][ T1] ? mempool_alloc_slab (mm/mempool.c:517) 
> [ 44.590151][ T1] ? init_omfs_fs (fs/jfs/super.c:934) 
> [ 44.590151][ T1] init_jfs_fs (fs/jfs/super.c:959) 
> [ 44.590151][ T1] ? init_omfs_fs (fs/jfs/super.c:934) 
> [ 44.590151][ T1] do_one_initcall (init/main.c:1297) 
> [ 44.590151][ T1] ? rdinit_setup (init/main.c:1354) 
> [ 44.590151][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
> [ 44.590151][ T1] do_initcalls (init/main.c:1370 init/main.c:1386) 
> [ 44.590151][ T1] kernel_init_freeable (init/main.c:1405 init/main.c:1610) 
> [ 44.590151][ T1] ? rest_init (init/main.c:1491) 
> [ 44.590151][ T1] kernel_init (init/main.c:1499) 
> [ 44.590151][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
> [   44.590151][    T1] Modules linked in:
> [   44.630667][    T1] ---[ end trace 0000000000000000 ]---
> [ 44.631743][ T1] EIP: __phys_addr (arch/x86/mm/physaddr.c:76 (discriminator 1)) 
> [ 44.632726][ T1] Code: 00 8d 76 00 83 05 20 92 8a c5 01 83 15 24 92 8a c5 00 89 f0 5b 5e 5d c3 8d 74 26 00 83 05 e0 91 8a c5 01 83 15 e4 91 8a c5 00 <0f> 0b 83 05 e8 91 8a c5 01 83 15 ec 91 8a c5 00 83 05 f0 91 8a c5
> All code
> ========
>   0:	00 8d 76 00 83 05    	add    %cl,0x5830076(%rbp)
>   6:	20 92 8a c5 01 83    	and    %dl,-0x7cfe3a76(%rdx)
>   c:	15 24 92 8a c5       	adc    $0xc58a9224,%eax
>  11:	00 89 f0 5b 5e 5d    	add    %cl,0x5d5e5bf0(%rcx)
>  17:	c3                   	retq   
>  18:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>  1c:	83 05 e0 91 8a c5 01 	addl   $0x1,-0x3a756e20(%rip)        # 0xffffffffc58a9203
>  23:	83 15 e4 91 8a c5 00 	adcl   $0x0,-0x3a756e1c(%rip)        # 0xffffffffc58a920e
>  2a:*	0f 0b                	ud2    		<-- trapping instruction
>  2c:	83 05 e8 91 8a c5 01 	addl   $0x1,-0x3a756e18(%rip)        # 0xffffffffc58a921b
>  33:	83 15 ec 91 8a c5 00 	adcl   $0x0,-0x3a756e14(%rip)        # 0xffffffffc58a9226
>  3a:	83                   	.byte 0x83
>  3b:	05 f0 91 8a c5       	add    $0xc58a91f0,%eax
> 
> Code starting with the faulting instruction
> ===========================================
>   0:	0f 0b                	ud2    
>   2:	83 05 e8 91 8a c5 01 	addl   $0x1,-0x3a756e18(%rip)        # 0xffffffffc58a91f1
>   9:	83 15 ec 91 8a c5 00 	adcl   $0x0,-0x3a756e14(%rip)        # 0xffffffffc58a91fc
>  10:	83                   	.byte 0x83
>  11:	05 f0 91 8a c5       	add    $0xc58a91f0,%eax


Hi Nicholas,

I guess you know the HAVE_ARCH_HUGE_VMALLOC best. 

In the commit

fac54e2bfb5b ("x86/Kconfig: Select HAVE_ARCH_HUGE_VMALLOC with HAVE_ARCH_HUGE_VMAP")

I was trying to enable huge vmalloc for x86. This report shows that
it doesn't really work for 32-bit x86. 

I also confirmed the following change fix it by 32-bit x86 (by 
disabling huge vmalloc). 

Do you think this is something we can easily fix for 32-bit x86?
If not, I guess we should just go ahead disable it for 32-bit x86.

Thanks,
Song


diff --git i/arch/x86/Kconfig w/arch/x86/Kconfig
index 995f2dc28631..0d08c36dfff1 100644
--- i/arch/x86/Kconfig
+++ w/arch/x86/Kconfig
@@ -158,7 +158,7 @@ config X86
        select HAVE_ALIGNED_STRUCT_PAGE         if SLUB
        select HAVE_ARCH_AUDITSYSCALL
        select HAVE_ARCH_HUGE_VMAP              if X86_64 || X86_PAE
-       select HAVE_ARCH_HUGE_VMALLOC           if HAVE_ARCH_HUGE_VMAP
+       select HAVE_ARCH_HUGE_VMALLOC           if X86_64
        select HAVE_ARCH_JUMP_LABEL
        select HAVE_ARCH_JUMP_LABEL_RELATIVE
        select HAVE_ARCH_KASAN                  if X86_64

> 
> 
> To reproduce:
> 
>        # build kernel
> 	cd linux
> 	cp config-5.16.0-11620-gfac54e2bfb5b .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>        git clone https://github.com/intel/lkp-tests.git
>        cd lkp-tests
>        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
>        # if come across any failure that blocks the test,
>        # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org        Intel Corporation
> 
> Thanks,
> Oliver Sang
> 
> <config-5.16.0-11620-gfac54e2bfb5b><job-script.txt><dmesg.xz>

