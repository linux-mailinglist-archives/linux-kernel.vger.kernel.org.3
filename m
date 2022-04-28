Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11129513E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350589AbiD1W1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiD1W1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:27:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4B1C0E5B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:23:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SJX0GC015475;
        Thu, 28 Apr 2022 22:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cNmCZ8F2tlfB7J/NLr40W8Mf52KRdprl4SiZBfq9pY0=;
 b=EIJrtdB0YIP1FUGp2R91qnJI7VeUhxD6nraFxqvAm9pJjKkqEVkXvOBKKdImvbsxMdkB
 7Z4UJdPrmt++bYLc3l5F3ckgDMYGnwV8RLmT1Nw5lGjnJ/e1pEkxTnXDoHxy0maucQES
 wybhzDz2ajABKbXfkR7AxxMbXzQTWo9fhHvefd4fi2vxIr3MEm7GOsL9tpho5Vv0sX78
 gHbvBLEO2z/Qi7bmhrDa6ubdhGgqpVffvHEdYFNwbMTxVlq1C1UBbEHVKVrUOpbBCrHz
 DGXRX0Y+yj3N235iots+aJOI1V/aU7KMHflD/E/p5/GWbPL6ky8N9nKWnSKdmZ1klRls Tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9aw9jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 22:23:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23SMKqPe014493;
        Thu, 28 Apr 2022 22:23:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ypgb0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 22:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTvqgw3HzgDn3eJ6j6zcLJfGutiarGAnIbfylKKt/q9nXnKnPJZzR+jNs/7rWR0yiAXXpVZ3Iqlqk4tdPpi8bXfl/up1NgW07a9kUqP0iav+9kT8bANwPyIsy7fkfsii2TO37eTXv6PAXe0/boPp9DQNLiGSZtT1IeBb5QcpxUaChe60R+kVYasXZaTULFAkUSXoKVYUdfcKEp8dmurZ2Lsn3Uhnc3PnLWqiVAbL6SgHfet4et4im19iyhw/d99HJFLhoEHUQhYYEghTDboeF/TiowFkFJ6tjORg+/Y0aw/J6E7DFvu+gGO07AeWia52AVr7EIeAMQWQWaNVcA0q6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNmCZ8F2tlfB7J/NLr40W8Mf52KRdprl4SiZBfq9pY0=;
 b=VDm6uXla5FyW98ZLDGW/Nw5PzcldktKH2RLmEJVBW6djrNvXUREEHu7sclA8tFPtT26J0SZ+K7jHHWdvDRKRh4vt5gtTkaXcB+RbggD/3ve+l2l+Yv3DuukoLH25P3pSbLMqoNho/myHNmRKATpGSihwDo/XOzrqGrlpXaCrRZzct5aoROpsHV/xPumhTTe3+6gPb3me858osHPULswW7omHhnomNEU80YwpCtnF0tD2cWCYwJn7RVf/hoXw80uzo/HG2nOYnPPVdw5tfyQHWQH6QK8kRyttxq8T//b943zi412MnsjhHbiinQVgDa2vU2iCklGYys8zyyhtIeqsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNmCZ8F2tlfB7J/NLr40W8Mf52KRdprl4SiZBfq9pY0=;
 b=KofooPcsR7uLbaJJck9bwU0UloGrU2vwOwhYYpIUFqmIk6Ow6ZNCUZBfMZ+2xzPjzka95kQqYuJ2dt01PxBp6Sqq3H9lSQI11BFXCx44kuJxEbUVKQ/0CfQBO/XCOMyWHxbETOdRMOrEaQnpFE7pp+IHwYUa6o4CkEoJI4gDkiQ=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by DM6PR10MB3020.namprd10.prod.outlook.com (2603:10b6:5:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Thu, 28 Apr
 2022 22:23:40 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 22:23:40 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "manfred@colorfullife.com" <manfred@colorfullife.com>
Subject: Re: [PATCH v3] ipc: Update semtimedop() to use hrtimer
Thread-Topic: [PATCH v3] ipc: Update semtimedop() to use hrtimer
Thread-Index: AQHYW0ECZ628czOVi0maPFqsoUiRXq0FzIyAgAAUO4CAAAXtAA==
Date:   Thu, 28 Apr 2022 22:23:40 +0000
Message-ID: <5FEE7AB6-7560-4998-A7A3-B60A4B32E1DE@oracle.com>
References: <1651178767-447-1-git-send-email-prakash.sangappa@oracle.com>
 <20220428205001.hiuzwpn5emxtrh4s@offworld> <87zgk4ooi6.ffs@tglx>
In-Reply-To: <87zgk4ooi6.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 130092b6-0b29-4bd4-52da-08da2965bf19
x-ms-traffictypediagnostic: DM6PR10MB3020:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3020A58DE84C5C93887DA625E4FD9@DM6PR10MB3020.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJDmUdT0MC1z9hAhnjKhkQB1lflL87EbsVG5IlM+7LqOjBrCil9sWirxbbNA0quEU3yE2XYvaw6xTSsVi1og2lOMBa+Qq7f/VTLzSHORc4j6vrrkVYq7qX8VYCHYgGkJhXr0Ad+LMD34caGgNbnxma2wJxlYB7B5j4Ul8HhQ1CdbOXPkQ5N5mAXHBOTTHEsQCCYTuVqSr3sHXAmCRaDwK171/BeearwPvpHJz3NF5k4zhYKC0GoWalUGzRHlws1lzNYE3l0os+zJs+uufHyssyo4xUUIM0S0s5sHfROi0ygONzs6lVyibcSUMyQA9PmgjYEFuI67gLIqDDlbMrfeA05MeIbQ2qH5R8zQ46Gjkpeggz6PrSV4QQiiMdibRuAOliHS8YW2N5yiPQkc5xc2jSKWDsKvDaC6caAcGOMZrE/GL4VZoEJiWnFmmT0bWVmhlMZVkub0HzDQZHpcUhCvw2JANBUNk/LltantGwJcY4/SyiFbKje5+mUJeU4UFlLqjaRlCaDWZQ6EfzMeYdtPGdHWG5EbXUexjhgNBra5pWQls7xVA+MCzWAWR5G7FF71/BePWGLrNOzWHSeV6OXj3ccSXMeoWDaaGHX8ekR0rAKlvI7vDBpfhhNPg8gsItvE65aCyR0C4U8otcZlZ3uBnUEl/TMpe+UcnlokRTS+sSTauu6cQeqjgbVyR9M+2EPN6Ue20O79qGs7Kz/HSX3uNY5ICi9fkSc6RHloHNOs4OI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(33656002)(83380400001)(6506007)(44832011)(4744005)(6512007)(6486002)(53546011)(508600001)(86362001)(2616005)(5660300002)(8936002)(186003)(38070700005)(38100700002)(316002)(6916009)(54906003)(122000001)(91956017)(76116006)(66946007)(66556008)(66446008)(36756003)(66476007)(64756008)(71200400001)(8676002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bP2y4jZgoLXE3Fo3F45Zi8szx3NrYQgGI6trXhxCjx5BBsl/AXOjRyMLo2ES?=
 =?us-ascii?Q?kqYDHVykNL4F6BfBbIXehvZH1Q5fDAWcLdHXwOpdzQYsoAq7M7JTHh4ixHzQ?=
 =?us-ascii?Q?ks/e2cHkojf5ZIaF73zCkvyUt7T0WP/4kOeoUMyw9Lu/YGtEq83YutSLOl/k?=
 =?us-ascii?Q?ZfkJ2uC5/nV4oDs2NGz2DFtfGmwcrD6yVwJqz2VmAeSQYtQStGXsUk3k0phS?=
 =?us-ascii?Q?chod1BZTqIOtFOFsF8vzX3HjP2ochTT7wvRKhBG7OEpZNv8+TE8GQpdmFOai?=
 =?us-ascii?Q?bp/9PrhOeOaVfmAQSH1k8QcfbTyX4W1WqMaVz+RtjZyepD4O65pFpYwJmG54?=
 =?us-ascii?Q?qq+sJEJZWjD2IwNoulsd1sJ66NUILLHutskAkK+fQtvELdl7p5B/N7eEXun5?=
 =?us-ascii?Q?CkQnSILmFEkPo67SWcx5d2pyiDSGctkfxypiIHaX80xs8YPFvL+/5S3iPdvJ?=
 =?us-ascii?Q?79/wp5klqCiRL1uKRUiIQ4RlEBIMbpuD3pO0R4KE+j+m2D3NjDtqe9n1piUE?=
 =?us-ascii?Q?OmwcH4ITgtmNP1rteWcx/lfSL4z2agoOUPko+oxIvQcIFPvyNoP15H+o1GNs?=
 =?us-ascii?Q?uluRviWofwEw/usqtJawvurfLBJBvJ/S1ZZIRfRfaMIVxkvbU2OjYV4ACz6F?=
 =?us-ascii?Q?8nXP63ef32dFugvlaq5UNO1i5TW+JGFi/8PKlq11pochjdpErlW0fsfWzsEF?=
 =?us-ascii?Q?Vcgn1zIjXmhg0aDB674E4ehB7urzsFopWWULVNyQmBGU4XCdVONPie2zNccR?=
 =?us-ascii?Q?g2jB6XSBIDQ5batqnjK1ohQC+hHeHdGDi/DJYC3EulB5+PdbmpVPXLYB9xiL?=
 =?us-ascii?Q?SrLAo8PS9V6d+bxNQ3BRPfWSiil5vXv/Pfr/2U/FgS0aNgjR+4UMXbAvs9Mg?=
 =?us-ascii?Q?Xiu0cMgjn0ogbT3gHm+eL2otnZwMbCiSRR2wSE7m8EB18HKTjw8E6FwDAyDs?=
 =?us-ascii?Q?ox0TkeBXCE0R4NTQoI+PocGcrCtKUIEBvBI1JN8XbdPJyY6IsVb+rrBVuCKn?=
 =?us-ascii?Q?UqrkkAuIV0hCCY2a5bDPL3R42gopkYHpXuedpb2P2ORpypXST6G3QOJE6iqx?=
 =?us-ascii?Q?8vPcef284C+SHf0rTL31f6h40qirPRsQqDlHwn3wwW9f5XEmJb/NMxVpKOif?=
 =?us-ascii?Q?glCwQUANeOJx0EvbSTBiXcMrHo5CyYBRM6eF47f5pZhXKC0xWFqk4PHPcsbR?=
 =?us-ascii?Q?GPo9xYD3vVPJWCppjnpsE08b6Gu7Xbb22iMoZFn+eM1Gdnat+rpCpfVqaCUy?=
 =?us-ascii?Q?H230v8eQhK4fauTcHzgxTLfBNms2Qzwr6yauRMlLOCAqYVlm0NSTgJFTrJ8q?=
 =?us-ascii?Q?xBwX/IffeprcwhLFa6K0C+Tgu4MaKflTNR/V2QReR5zWsMsFZREdWSAJFlmf?=
 =?us-ascii?Q?1QfDJWd2a7LrA2+aLWhsC/nYvYrs6Vqr5uHCHNtP6k5Ko7x2M9JUDnNOO+U5?=
 =?us-ascii?Q?CY7diWiOkpYJO1Jz64hQ0DptBJNzRLGZfEyUOUUqX8pit0jG8Aq5Ib5OWlBd?=
 =?us-ascii?Q?ze9hOYB3XCF8ItskVCBYbv/Q7eQC7EdpuIUFKNK+nUIOGLh8t8uRGadPaNw/?=
 =?us-ascii?Q?Rh40V8SRHD2ICHRrr4ObB3S8PzbneYVajlU8jd0Mk7x4tQH56zoKAYsJVJnr?=
 =?us-ascii?Q?C7fgis/3PjMTnGmDufucN8BB63o3ZYaNQJFMF91LegxJpwAzFJPc8395bioQ?=
 =?us-ascii?Q?UJswr0v6Guz9ogiLULdOYRel26gyTJXeMQHS+nvo/ulpurnXPiFpV7RAxMCw?=
 =?us-ascii?Q?4fShktG6L04Vjotf996Kvr7C/fm0aQvyTNcDdzOo9k7wyscNEruo35lozI8p?=
x-ms-exchange-antispam-messagedata-1: 9qrsGbq5O1ME4g==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F6904B476043748B4087A1EE053353B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130092b6-0b29-4bd4-52da-08da2965bf19
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 22:23:40.0265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gs+YaAZul4szpHvtg17eO3IfUIzbSWp/dfkPSvrbgFLMjeiQD2SMj1iJuJPx4OxzQNhtZXYMXioV/1UINL3ATyzC94iDevBaRYFEq7qqcQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3020
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-28_05:2022-04-28,2022-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=848 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280129
X-Proofpoint-ORIG-GUID: YHih4_4Utf-NZocrL3SwIDw69nwOtP2B
X-Proofpoint-GUID: YHih4_4Utf-NZocrL3SwIDw69nwOtP2B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 28, 2022, at 3:02 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> On Thu, Apr 28 2022 at 13:50, Davidlohr Bueso wrote:
>> On Thu, 28 Apr 2022, Prakash Sangappa wrote:
>>> -		if (timeout)
>>> -			jiffies_left =3D schedule_timeout(jiffies_left);
>>> -		else
>>> -			schedule();
>>> +		timed_out =3D !schedule_hrtimeout_range(exp,
>>> +				current->timer_slack_ns, HRTIMER_MODE_ABS);
>>=20
>> I'm wondering if the slack parameter instead of passing the timer_slack_=
ns
>> value immediately, we should do a rt_task() check and pass zero if so.
>=20
> We should have a wrapper function which takes care of that instead of
> having checks all over the place.

Ok  it can be an inline function in sched.h which returns appropriate=20
slack time. Use that in  futex_wait() and sigtimedwait() also in addition t=
o=20
semtimedop() & mqueue codepath?

Should that be a separate patch?

Thanks,
-Prakash

>=20
> Thanks,
>=20
>        tglx

