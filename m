Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50D74E9A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbiC1Oqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239971AbiC1Oqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:46:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0484D1FA4C;
        Mon, 28 Mar 2022 07:44:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22SCuEk7031737;
        Mon, 28 Mar 2022 14:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Z4RzUD2bzYe1H+/4uKesyaMX5qOf3cJFPwaSYDm97M8=;
 b=nJ93vlju8rgIdAVkIFL2KPYbW51v7WFoETUJlb5ickRzKdC6J/khfVxLLd8PXXrz0lK/
 O/lsR1Plusam8xMKnaHNK/a1vD1tSjw8P8nGl+EZtjhPQB3W+DMuHBuJuCiDfVl+MUUf
 tGmP8glk2Bg1hD4dRstQFDZbecHbsKBBgl2EqR++6XE3pqOU76sl5eiYBOCRYBiaBlUl
 F21SdBm3TpefmUHxhdQ4Iv6otk33gCfkw69W4wVsaC5KDOmUNODS4WEZSSsznaeiLb94
 prme80fOgL5oe2DvlQkOy/LHB/FWSDkVxTJ/tM1xvdgHC4IIk32izq076M88GJg7WOBX /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1teruqmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 14:44:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22SEeixC117433;
        Mon, 28 Mar 2022 14:44:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 3f1tmygdwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 14:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1ZRHbKbRggq3cQXDJEpiQJOJ1qAQfAYrx2c/O+GdonI/ceLtMsGWWBsDNw8HVzYcGnlFmu5MJ2IRTcraEtx9zBLD1DlosGPLS2kDR0tj94z3GtO+bGQeGTrfmOIcDZz4JUAqaORY0aiNeasWHlQShvf9SQLV6+9XLZJOBWrbI7zIGFOWfULtChAUBL2qVx3xQ8yJqMXDpchKcZDbGo0H1eRuPCB4UeL021DJMqVcpmM+MlOA8W2HeWMFF9MGrPx3ITYtie3sfqaFWZRgih9LGiKtRiOIlvB6SEoz+uTJhFkgcpmAeDSSFMbPMWVvSsz4R1zwME5gviH1L4A8RwYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4RzUD2bzYe1H+/4uKesyaMX5qOf3cJFPwaSYDm97M8=;
 b=PGBeP/USjeScsoM/hb8noJxNaqZZFWtKUYsRHJ1HiL+k7QajcJPbirYYhb9YXUwkWkULChIHOGFb9/mHDfWV6EZhHI4+TyVqp+J7JAV0PHoESOiwiZ8QwbLo6amyIkCTQwMo6g7wPo66jGdTB6kPXUe2mFBkO5Jm0GgcriS+YU8uaD+oXLSdBU2ZE315Nqjq/H3ZJoLmfYUzA/g6vSH+Gc49z6KE/ZOR5OmEE5uT/B+lr3qa4EddBYXLqKZjpxwF9SiClcP40VAjK8Jpd9a6upeRaxSu4oi5QDaN/ENxr9e81psDu09MQMTS65ochM4JyGr3dlQOuOcOs6TIfBkvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4RzUD2bzYe1H+/4uKesyaMX5qOf3cJFPwaSYDm97M8=;
 b=bWyEn82PrqHpOcsm65iBZaI1CY+y55pEyhDUvN4b4pMHNEKhgwIu5JhG4xJXLPK8FNV5dC3JLuLkkqs3P8EUWQrs77j54CqJ0doSLtcU4rJV2DfkHabWpfXWorEFvyX/kxPzGNi2fLpo9ViGMMHy1tNLX0EepBUqtFXM2dGbaU4=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM6PR10MB4106.namprd10.prod.outlook.com (2603:10b6:5:17d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Mon, 28 Mar
 2022 14:44:30 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a%9]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 14:44:30 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     joeyli <jlee@suse.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        =?utf-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>
Subject: Re: [PATCH 4/4] module, KEYS: Make use of platform keyring for
 signature verification
Thread-Topic: [PATCH 4/4] module, KEYS: Make use of platform keyring for
 signature verification
Thread-Index: AQHYIqP0m4xPRRezdUuRjweyW/VIj6yVCkMAgAAK9ACAP78igIAASweA
Date:   Mon, 28 Mar 2022 14:44:30 +0000
Message-ID: <6A29007F-F1B7-4CDE-B3ED-7BF700B5ED2B@oracle.com>
References: <cover.1644953683.git.msuchanek@suse.de>
 <840433bc93a58d6dfc4d96c34c0c3b158a0e669d.1644953683.git.msuchanek@suse.de>
 <3e39412657a4b0839bcf38544d591959e89877b8.camel@linux.ibm.com>
 <20220215204730.GQ3113@kunlun.suse.cz>
 <20220328101557.GA11641@linux-l9pv.suse>
In-Reply-To: <20220328101557.GA11641@linux-l9pv.suse>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da9f02f4-101c-4669-77c9-08da10c97754
x-ms-traffictypediagnostic: DM6PR10MB4106:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4106E993D29715DF65A75079871D9@DM6PR10MB4106.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KfW9j9SgQmm1FYwjLjgSux/hnD8ps3W3pDdYGvPeepx/tPc2TLiBR9M45oqoes8/Fa2nJ5HYb2DIfoehrmZ9G7XnMb8NegILeMspSLhfxo0sOext+m2RBV2FHewe3uia8JwDDQ7087P4cI7T6UyMFI+k5/fS00vhAkjVlZt6IjDZYKvcXSNWCi1GPxRbPwJzYhWuS2HrMcn3/jTNcX7aP1S+0rNhflvt31yuv1L3CXF5mKVS0CiQ8EotUt6p2LZcbIoum8wlg5jz3QqHp/voMJqyrvE73A5LaJ++so2XlUWjeIkrOUWhseywvxursK9LM7acEdvAe7EqQEuq1+YleOdvu1CnkSm0CXUVWIDnerbW6iPXijIRb0YpWHg15wZ9zSQp6SPN+HmKvLZguE711LApsN0FEkN8KhLw8oEGliY4NUbFH0B5CLJ0yagAR3tDfr5mbaxftucoCfm45YEfszyAC5G/WFp8uthgAP2hmgUOCbcbWXLMe3eIbizF9xdSMaYYVUIIAvHqAHt8EzWKH6Yp4pSZ+FEhGpNHNqr8TJcYwh+UVEZSxo35dWzgDIKP0lPWbp7G48yJNi3nRO78vQedpoHQ5S36zmAAho31y5TmK+b9unjVQSndfQlIgqPJOlox67JBbpwo8BX9it1nexrZVEmqpgybh1hfDU48+psU1+hlMjVsqSBSEJjcbwKawpmO4SWknKQOBBt+sZHI0/sMLwExN9JFHbsylQ35cNuFC1uLLjSYHTod+qaqSpPrWqX35npY99unH0ida7HLRtNo+JXdbo9gH3G4Ul+czppRa07EqJWjBk7XzGVIumlu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(2616005)(6916009)(76116006)(4326008)(186003)(38070700005)(83380400001)(36756003)(54906003)(44832011)(66446008)(64756008)(53546011)(66556008)(66476007)(6506007)(45080400002)(66946007)(122000001)(316002)(6486002)(2906002)(7416002)(33656002)(6512007)(508600001)(8676002)(966005)(38100700002)(86362001)(66574015)(5660300002)(26005)(15650500001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW1TK0JuSjR3c3pmeGttZTJTcnQ5NFRwNWVBcGpCK1ZNbzljS1lSL3RsQ00r?=
 =?utf-8?B?U1RsRmI4SzFFSExlbEZBeXUzQyt6aGRZZm1nV2hiOVFVV1FjSlVTaTUzeEpm?=
 =?utf-8?B?TkFXU0o5KzBWMWlyNHJqaTJBcVRKWklsOEJoMDNVYmE0YXFFYzFHTmRLb3NF?=
 =?utf-8?B?WkVWU1NDTGx3WE1FOGUyRXF4TENZR21BOXFUbisxN1RJV3V1cVU2RTR5VStB?=
 =?utf-8?B?NlRBbWYvLzkyNjhIbmhiY01BeFBhL2RPTGNudUNqUmpHMTYwYnVEYVdGR3cw?=
 =?utf-8?B?ZG8rVXRmbnNiRUdTZm10YW9xbGwrWE9ZZWJjck9WbzJNZHFQeHB5dng5Y01B?=
 =?utf-8?B?bXp0RDFvZFJFb0doc3hucVZqQnZkRjh0eWZoRWFlTDQ0N2xKaDFxTnlVY1VK?=
 =?utf-8?B?VEZFSmVqeUJPa0MwMlR0Z2NUb01hM1lwS1Zoc3BYQmFKcUZ2RlUvT1o1VVZx?=
 =?utf-8?B?NWlnaFhzcy83UisreDJUUnk3MDFQelpGY0F2QnpybDNMb0tzTXlRUmI4V1JV?=
 =?utf-8?B?RGMvSzlSMklYbXlJSXh2SEJrZXNmOXllSDE0d2M4RkFUYWNPWmJ4UDgyQlNa?=
 =?utf-8?B?VTZhM1BnWTVzdmlyczhXZ2pyTitpUFNCaTNOakVISnRSZElqalpLTVczQi9r?=
 =?utf-8?B?eWdVYlJrdm8rUkpGU0YzSUNpbXh0YkNVYkFKK0JLSVBWaE02eW5IdXVpNGJO?=
 =?utf-8?B?WHpJcjlkNHFDZ0QyaUxOMWNIeXp3cEtOUzFkYVZTcGNZTDlXbEVmdDZhY29O?=
 =?utf-8?B?MjlycCtselRPN3JpOE1RRUsyclNiNEdRUDF2SmdyT3JpRlpHWGNVSWY4Y3JN?=
 =?utf-8?B?ZGdJbWo2OFoxZWVVM1FuY2dnb1pPdFBKWUlvZnp1T1UxdU94UFZzTVozTWRY?=
 =?utf-8?B?SGtIbEZCR1ZGeE00Z0ZMMUhhS08zNGNLTlQ3K1FJeHVQeks0Z29xbDBwYmlv?=
 =?utf-8?B?RzNSMHBiZUxXa2lsd1RvTDJNOUNZc2R4OHdUTkRsWHFTRG1JRzdTOTFheU5s?=
 =?utf-8?B?eXFudjZ6eXMvT2xmV0JRWi9ySHZwOWFFaGwvT2hjdUpjZlNRWnFRV2FKZGZu?=
 =?utf-8?B?RnEwcW1ZUzVJMWRGR0x2T0NxSmR6aG1tREl1REJqS09MMzFIR3R6c3NwK09t?=
 =?utf-8?B?c1gzQ21wVTVCYTZWd0dTdzBWdUo0VVJqQWNiMmdoWHQ5TkZMYStETndxVjVv?=
 =?utf-8?B?VWxURU9mOU10VEFCOHVCYU9QMHhzYW8vOFFwWDB5U003VWwxYmVNQlN1ZHBB?=
 =?utf-8?B?VnhVUTV0T3VCb0NpdTJkRTQ4KzVnb1JlWlc0VzRnL2dhZGh6cTkyc3dMeDVW?=
 =?utf-8?B?SEloSGFDbmFWMGNlRS9GL1B1RlVQYlNVSGlmaTRzamJvaXNrRHRZOS9KZ0V1?=
 =?utf-8?B?SVFpb2hlWTY3MHcwMkw5YzFOa3g2bmNqT1RPWi95MFI3ekZQeEc1d2c2NC9v?=
 =?utf-8?B?YWpzYTVxZUxPV2d5akhNWGNXRkg2RzNFUlNlNWswQnFIazBPK0tNV1FoUkNt?=
 =?utf-8?B?U0FscmFsdHpTYmRtQXZZSzdmUHBpaE9lSTdUSzJsVVRWRmxsKzQwZkZPMGMz?=
 =?utf-8?B?YUNiRFhiNDJiZ1MzU3NMenBLQUJ4ZStHL3hpRWtxem1MbHVZZVVVUFNtbkxN?=
 =?utf-8?B?QXZrMFVGNC9VVTdUWXdhcis2T1Njdzl5U0xzd0hrTTliV2E4Nm5DQVdYTGY0?=
 =?utf-8?B?VHRoN2l0bmR1RjJSNjNDSDJRUkFGNjVCRGorbHBlVmZvOEludnUvU055ekk0?=
 =?utf-8?B?ZWFHSUNYSFVSVFZBdFJERm9mS096b3dzQmkzeFgvbTR5dU9ORFM3U2h6NEhj?=
 =?utf-8?B?ckh0ejB3Sm9TWmJJeGhuR3QrOFdLNHV3emEvTjYwaGJEQS9jSTlid1dnMHcw?=
 =?utf-8?B?enE2QXN2TGwxR1NIT3hNNmZxNFIwL3BCMktHZ2psQmdsVCtTeks4QWR4ckJP?=
 =?utf-8?B?N0NNSERpTE1VMDlIaWhGemNscmoraWNrWXp0dzd6dDFjNVJ3cURXQXNuYjhQ?=
 =?utf-8?B?WWpJR1BUa01waEovTDdROHhPUmZWdFM5K2RFa0E0OHhDVGx2MWl5ak9SNUVq?=
 =?utf-8?B?Z3pRUmY0UWxpNmcrcUFqVzByY201dWl6Rnd6S2hKeVlpOVFNRS8rWEl5YVNK?=
 =?utf-8?B?YytaTzl2Y0NMK1pkL3RPWExXcENsdGJFanJ4TU9lUHUxUkNOZ21XWFlLWExL?=
 =?utf-8?B?K3hIVjlJbTJWQUYwK1RsVU1abS94QzhtdXU3SmZTTVRZdUJXTGhDdEQ1d2o2?=
 =?utf-8?B?MDFuVjZJdzcyTEVHeXkzMjhBSzdaZ0NHb1luRUxCVDdKNHJ3OHJsL3hncG9C?=
 =?utf-8?B?VU42MXpCUzU5R1I1MlJ4Y0pETlRzZCtYb2VQaGFkek55ZUZpdEdmb2NLUUdy?=
 =?utf-8?Q?NoYJUN1lABxFkrMA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4A2E3B010F0A745AA30969BA6A88182@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9f02f4-101c-4669-77c9-08da10c97754
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 14:44:30.2216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkSWf1wPsSjI9oeH877KqKcp7Kw6b/Pbf14ibE7RqrmKah8Ivbu6cP7RN6TMk47FUe3zB5Gu+DflG+l48OMItJ+HcyF+iwo+X2i4FQtBmiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4106
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203280083
X-Proofpoint-GUID: -iz9EfrK2IZSwaG0A5uxIwvbqTtrzIMk
X-Proofpoint-ORIG-GUID: -iz9EfrK2IZSwaG0A5uxIwvbqTtrzIMk
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDI4LCAyMDIyLCBhdCA0OjE1IEFNLCBqb2V5bGkgPGpsZWVAc3VzZS5jb20+
IHdyb3RlOg0KPiANCj4gSGkgTWltaSwNCj4gDQo+IFNvcnJ5IGZvciBib3RoZXIgeW91IGZvciB0
aGlzIG9sZCB0b3BpYy4NCj4gDQo+IE9uIFR1ZSwgRmViIDE1LCAyMDIyIGF0IDA5OjQ3OjMwUE0g
KzAxMDAsIE1pY2hhbCBTdWNow6FuZWsgd3JvdGU6DQo+PiBIZWxsbywNCj4+IA0KPj4gT24gVHVl
LCBGZWIgMTUsIDIwMjIgYXQgMDM6MDg6MThQTSAtMDUwMCwgTWltaSBab2hhciB3cm90ZToNCj4+
PiBbQ2MnaW5nIEVyaWMgU25vd2JlcmddDQo+Pj4gDQo+Pj4gSGkgTWljaGFsLA0KPj4+IA0KPj4+
IE9uIFR1ZSwgMjAyMi0wMi0xNSBhdCAyMDozOSArMDEwMCwgTWljaGFsIFN1Y2hhbmVrIHdyb3Rl
Og0KPj4+PiBDb21taXQgMjc4MzExZTQxN2JlICgia2V4ZWMsIEtFWVM6IE1ha2UgdXNlIG9mIHBs
YXRmb3JtIGtleXJpbmcgZm9yIHNpZ25hdHVyZSB2ZXJpZnkiKQ0KPj4+PiBhZGRzIHN1cHBvcnQg
Zm9yIHVzZSBvZiBwbGF0Zm9ybSBrZXlyaW5nIGluIGtleGVjIHZlcmlmaWNhdGlvbiBidXQNCj4+
Pj4gc3VwcG9ydCBmb3IgbW9kdWxlcyBpcyBtaXNzaW5nLg0KPj4+PiANCj4+Pj4gQWRkIHN1cHBv
cnQgZm9yIHZlcmlmaWNhdGlvbiBvZiBtb2R1bGVzIHdpdGgga2V5cyBmcm9tIHBsYXRmb3JtIGtl
eXJpbmcNCj4+Pj4gYXMgd2VsbC4NCj4+PiANCj4+PiBQZXJtaXNzaW9uIGZvciBsb2FkaW5nIHRo
ZSBwcmUtT1Mga2V5cyBvbnRvIHRoZSAicGxhdGZvcm0iIGtleXJpbmcgYW5kDQo+Pj4gdXNpbmcg
dGhlbSBpcyBsaW1pdGVkIHRvIHZlcmlmeWluZyB0aGUga2V4ZWMga2VybmVsIGltYWdlLCBub3Ro
aW5nDQo+Pj4gZWxzZS4NCj4+IA0KPj4gV2h5IGlzIHRoZSBwbGF0Zm9ybSBrZXlyaW5nIGxpbWl0
ZWQgdG8ga2V4ZWMsIGFuZCBub3RoaW5nIGVsc2U/DQo+PiANCj4+IEl0IHNob3VsZCBlaXRoZXIg
YmUgdXNlZCBmb3IgZXZlcnl0aGluZyBvciBmb3Igbm90aGluZy4gWW91IGhhdmUgdGhlDQo+PiBv
cHRpb24gdG8gY29tcGlsZSBpdCBpbiBhbmQgdGhlbiBpdCBzaG91bGQgYmUgdXNlZCwgYW5kIHRo
ZSBvcHRpb24gdG8NCj4+IG5vdCBjb21waWxlIGl0IGluIGFuZCB0aGVuIGl0IGNhbm5vdCBiZSB1
c2VkLg0KPj4gDQo+PiBUaGVyZSBhcmUgdHdvIGJhc2ljIHVzZSBjYXNlczoNCj4+IA0KPj4gKDEp
IHRoZXJlIGlzIGEgdmVuZG9yIGtleSB3aGljaCBpcyB2ZXJ5IGhhcmQgdG8gdXNlIHNvIHlvdSBz
aWduDQo+PiBzb21ldGhpbmcgc21hbGwgYW5kIHNpbXBsZSBsaWtlIHNoaW0gd2l0aCB0aGUgdmVu
ZG9yIGtleSwgYW5kIHNpZ24geW91cg0KPj4ga2VybmVsIGFuZCBtb2R1bGVzIHdpdGggeW91ciBv
d24ga2V5IHRoYXQncyB0eXBpY2FsbHkgZW5yb2xsZWQgd2l0aCBzaGltDQo+PiBNT0ssIGFuZCBi
dWlsdCBpbnRvIHRoZSBrZXJuZWwuDQo+PiANCj4+ICgyKSB5b3UgaW1wb3J0IHlvdXIga2V5IGlu
dG8gdGhlIGZpcm13YXJlLCBhbmQgcG9zc2libHkgZGlzYWJsZSB0aGUNCj4+IHZlbmRvciBrZXku
IFlvdSBjYW4gbG9hZCB0aGUga2VybmVsIGRpcmVjdGx5IHdpdGhvdXQgc2hpbSwgYW5kIHRoZW4g
eW91cg0KPj4gc2lnbmluZyBrZXkgaXMgdHlwaWNhbGx5IGluIHRoZSBwbGF0Zm9ybSBrZXlyaW5n
IGFuZCBidWlsdCBpbnRvIHRoZQ0KPj4ga2VybmVsLg0KPj4gDQo+IA0KPiBJbiB0aGUgc2Vjb25k
IHVzZSBjYXNlLCBpZiB1c2VyIGNhbiBlbnJvbGwgdGhlaXIgb3duIGtleSB0byBkYiBlaXRoZXIg
YmVmb3JlDQo+IG9yIGFmdGVyIGhhcmR3YXJlIHNoaXBwaW5nLiBBbmQgdGhleSBkb24ndCBuZWVk
IHNoaW0gYmVjYXVzZSB0aGV5IHJlbW92ZWQNCj4gTWljcm9zb2Z0IG9yIE9FTS9PRE0ga2V5cy4g
IFdoeSBrZXJuZWwgY2FuIG5vdCBwcm92aWRlIGEgS2NvbmZpZyBvcHRpb24gdG8NCj4gdGhlbSBm
b3IgdHJ1c3RpbmcgZGIga2V5cyBmb3IgdmVyaWZ5aW5nIGtlcm5lbCBtb2R1bGUsIG9yIGZvciBJ
TUEgKHVzaW5nIENBDQo+IGluIGRiKT8NCj4gDQo+IEluIHRoZSBhYm92ZSB1c2UgY2FzZSBmb3Ig
ZGlzdHJvLCBwYXJ0bmVyIGRvZXNuJ3QgbmVlZCB0byByZS1jb21waWxlciBkaXN0cm8NCj4ga2Vy
bmVsLiBUaGV5IGp1c3QgbmVlZCB0byByZS1zaWduIGRpc3RybyBrZXJuZWwgYW5kIG1vZHVsZXMu
IFdoaWNoIG1lYW5zDQo+IHRoYXQgdGhlIHBhcnRuZXIgdHJ1c3RlZCBkaXN0cm8uIFRoZW4gdGhl
IHBhcnRuZXIncyBrZXkgaW4gZGIgY2FuIGJlIHVzZWQgdG8NCj4gdmVyaWZ5IGtlcm5lbCBpbWFn
ZSBhbmQgYWxzbyBrZXJuZWwgbW9kdWxlIHdpdGhvdXQgc2hpbSBpbnZvbHZlLg0KDQpJZiBzaGlt
IGlzIHVzZWQsIHRoZSBuZXcgbWFjaGluZSBrZXlyaW5nIGNhbiBiZSB1c2VkIHRvIHNvbHZlIHRo
aXMgcHJvYmxlbS4gDQpUaGlzIHB1bGwgcmVxdWVzdCBbMV0gYWxsb3dzIGFkZGl0aW9uYWwgY2Vy
dGlmaWNhdGVzIHRvIGJlIGxvYWRlZCBpbnRvIHRoZSBNT0tMaXN0IA0Kd2l0aG91dCBnb2luZyB0
aHJvdWdoIE1va01hbmFnZXIuICBIYXZlIHRoZSBlbmQtdXNlci9wYXJ0bmVyIGNyZWF0ZSBhIA0K
c2hpbV9jZXJ0aWZpY2F0ZS5lZmkgY29udGFpbmluZyB0aGVpciBrZXkuIFRoZW4gc2lnbiBpdCB3
aXRoIHRoZWlyIERCIGtleS4gIFdoZW4gDQpzaGltIGJvb3RzLCBpdCB3aWxsIHZhbGlkYXRlIHNo
aW1fY2VydGlmaWNhdGUuZWZpIGFnYWluc3QgdGhlIERCIGtleSBhbmQgbG9hZCB0aGUgDQprZXkg
Y29udGFpbmVkIHdpdGhpbiBpdCBpbnRvIHRoZSBNT0tMaXN0LiAgTm93IGJvdGggbW9kdWxlIGFu
ZCBrZXJuZWwgdmFsaWRhdGlvbiANCmNhbiBiZSBwZXJmb3JtZWQgd2l0aCB0aGlzIGtleSwgc2lu
Y2UgaXQgaXMgY29udGFpbmVkIHdpdGhpbiB0aGUgbWFjaGluZSBrZXlyaW5nLg0KDQpbMV0gaHR0
cHM6Ly9naXRodWIuY29tL3JoYm9vdC9zaGltL3B1bGwvNDQ2DQoNCg==
