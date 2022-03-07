Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F34D0706
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244895AbiCGS4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244887AbiCGS4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:56:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618D292840;
        Mon,  7 Mar 2022 10:55:40 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227ISenJ028197;
        Mon, 7 Mar 2022 18:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CPARXGQJZTtX0P3gqxxWbfPKuOxoNj6SCY2gUJaR2gY=;
 b=mfbR6o2PjnZPxVMJ614mU97Og6Ihdk4cLS9ZXHZoNTupRz4p/Lo/42ktoO+sBeX/HeEq
 gx91tS9ug7L5QNtbaQ/BTstl/W2VU+8RGLruZJbAoP+T+F1v7lX/VTBoCjbATBmhILaw
 HuvjW1GGPT4hcLATKIjb8/CjGEOR8TzWz0ex58Gy37WT7e7RAExJlKiMdiXaEdc05Lqk
 vaCwnmz47njg4IofFahwfkft5wBTpR+dYJexjz53eOcGXDkp0UkGS7NIgiYdQLKy+wyS
 RNxLEbqsJfglq6BMUupRtYxpZKfCVcs9wsTF2EpbwCZmfEJdTlCsr4imhbRBB8NOOqKl jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2cukv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 18:55:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227If8Di065704;
        Mon, 7 Mar 2022 18:55:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by aserp3020.oracle.com with ESMTP id 3ekyp1d4w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 18:55:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+Xs8ni7q7NLYyVaJu87cIv+RWAwG/PeYfnXUR8McJ0vNJ0jK+bOPw2b5QIhAbUxaDCWdhynDzuI68lHbBRCm7fZTy4BQf62WI+PjyniodKSgg9thgY2YOEH+dBeKM/YdIemf4Hk4MU33K9cL6UDN8d8eXrLwfCYh6RbiioksRrKl3tt2JZjMSA5dlZXU6HT4u3IqV3KoHCK/GSSu5Ihsn1ZOXDeiETdeQPAYVGmmjXNdnC7/M+grMLxZahZCtsgJf9ooHKaNp9Gw/xZw8C3VJNSnGCd+B7izdaF3NAKN2qjRd3Mpv/SJlD1pq8fUXzuPDwcrgRhN/vkSgHQMbmyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPARXGQJZTtX0P3gqxxWbfPKuOxoNj6SCY2gUJaR2gY=;
 b=n9sAYG5HD6nL0a4NtLNpDEE7QyZ8Kw8mfnp/C7+0VJNBIxtCVdB2ti8FsjL9YaMWeMqj01LkN3vWjfKw4fz3GCLtHpugmW8UfaY+t4QFQsMptA0H4nqgtrO1XAUSb84z3QndgDOzuY7YqGvTtd3rUW/3PCk8LhwJArScFFtja+wuzlD1RaQWkTzlE6HL/KFeDL3PPX12fTsBtei4DqyT1XpLB8VwhEm2rKClzoSU3PyhsltVV7iBVLvTS1SBBsLeyEMJJiDUmh/9TB2rijXN5K58+ga5VC3wU3nOJU3UotCvVQxQQVUtVJOrasP3fQIN7eJPyrrM/D72f3fmJ9Ca1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPARXGQJZTtX0P3gqxxWbfPKuOxoNj6SCY2gUJaR2gY=;
 b=BJRLJ3sgZgtaOxM42RRZL00OVrf0YA6nhy/IHQXvvUdzwr8JZWXqgHwgCS8GDNXkTZO6qEoZ3VcFnZfErq/DZQrN+hnFilqmUtuf3KugSi/0D0G/cHl04ux1eHuXIGey5PyxHhcZVrBfO5u8f0TEXYqZ44MrdeX3YY8SlWsYx1k=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:126::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 18:55:19 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 18:55:19 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 0/4] Add CA enforcement in the machine keyring 
Thread-Topic: [PATCH 0/4] Add CA enforcement in the machine keyring 
Thread-Index: AQHYLZM8jxuG29fUVEecQcvisOPy/ayzCf2AgAFEowA=
Date:   Mon, 7 Mar 2022 18:55:19 +0000
Message-ID: <29935472-CA86-4B5F-A1B5-1B12FC563748@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <4235e559d00cd90701e05befe87b06e904f008b2.camel@linux.ibm.com>
In-Reply-To: <4235e559d00cd90701e05befe87b06e904f008b2.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b56f6bd-bd57-4c85-24ed-08da006c06e6
x-ms-traffictypediagnostic: PH7PR10MB5879:EE_
x-microsoft-antispam-prvs: <PH7PR10MB58797B3C475858FCC971859787089@PH7PR10MB5879.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ITVbFicxd7oiky7fkAYC6WBzWH6agDvA5mplMTorX0xtFoMuleEaoFgdJ+m+C31twd8D69gbjFRPu891oeuSm/kDOBncHGuOrKMM/cRplRVfNUZUWZmwrhXC3JFJxEgFVJpvRFRuhDl10BJXq3EViTOrWcP9rLj1rFeNKRxipFDOIdRGEnHINCD8g2QXppfPuH7OSHeYrMeg5NZG9hLPZjqykWL1N4+NSpGknfsKdOh7yK+EgeCaoSGE1O0T2yg+aiku/ZDu1hG5WO/QkEmHyq2eHAdrnFWb1SuECgsAO7qcHzdS2xfxZhE9oLV7OjcVsrLrbaSf3qGSL3Jz4wRf+rQhbt/wRVAz6xYz6nTF00x+/ociHnffkCjBt7LOhoPiBI2UV1bd/bm8LDZlfFaG5R0MG4oVrSAsiVuRjCxoWM1693snLZUHNGNqTNW+6LQj5thmuWtgOQEqX43dAjBsDA/BxS6efWPW/zkJQ0heOc9rhz3xgua11kO89hUdluUubPbeqdQtIBVUumeSos3PqELnbdNCVgMdgvJ+fFuDMw9RC0fOlvxqU2gkhx3q7LlFxgVx0LQmCE1KkNTIfKXLh7Mow2aPQI3jLSCget+iDCg8yBCpZFYpLT/aCixPG2Jctb0F9CDKZq8Qa6s1IzC3Ur2VDrs63TCN19pzvVpQPaEOtlZyur2hCvU0GFKWLE4AiqxoSDPSdphUh6fjk1++i6YdcR8ZzOPN71um6De7Eao=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4743002)(6512007)(44832011)(33656002)(5660300002)(7416002)(66476007)(8676002)(66946007)(6486002)(66446008)(4326008)(71200400001)(6506007)(38100700002)(53546011)(91956017)(122000001)(8936002)(76116006)(64756008)(54906003)(6916009)(66556008)(83380400001)(38070700005)(2616005)(26005)(86362001)(186003)(36756003)(508600001)(2906002)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmhPZFB3VkRHUmFnbzRRVWU3MnAwV2Z5cE1ub2ltZVpjRGJqeS82anAxZGZ1?=
 =?utf-8?B?QkYxUk5rUStraXJrV1NDZ1N2elJXczQ5UWIzNGZUN0o2MjBjN21aOUxGRGVI?=
 =?utf-8?B?Ky9ZQnJId1ZOZDI3VXlJSjk4UW9FbC9uQ2Y4cjBVV0xNNE5yK3B3cDlwY04z?=
 =?utf-8?B?U0svczdaS0hYZVoyakJYdGdxTkNrUk1remZUUVQwTTkxVUMyZVJUQTExd2JL?=
 =?utf-8?B?VUh2Z0lJTEE0Z25nanhUQWxKMGlTeE90WFhMU29MYUFDTUp4WEdvTWttTVhz?=
 =?utf-8?B?cWNuNWlQK1BML3hHQUR1VWkzWkticXBKcy9YWTIxTDhNb0NlNGhMRzlPb29F?=
 =?utf-8?B?ekxJY0tzamoxc25zd21YdFRWK2hlWnpkcWVKMk9ZTjVYRzBqTFd5V2VnNFgx?=
 =?utf-8?B?SW9wcVBCUHlwT3QrbGs4M29WL2E4cVJVaXJ4TWxsVHVKVW1SZHptQzRyMnFV?=
 =?utf-8?B?RjkxNTVCQitENG8rRDgrdDQrY0pTeHMwMS9TU3BWOHc3S24rR3ZqdDN2RGpX?=
 =?utf-8?B?VTU4STFYZ1JZamZoMTkvdERYK1lUaThFN3B3S21SYXlxY1lITjN0UE5LcVYr?=
 =?utf-8?B?TStuUFpQVHNwZDQ5VjFBdkE5Y0FlcGxIQVRBVURwRU1kZE90ZVRYSEJTMEpX?=
 =?utf-8?B?UGthcitUNUI1WktkUFFJdFNZdG95TVVGWGhCa3NpbmUxZ0owcW0zcWpSazBm?=
 =?utf-8?B?WVk1SDIrSjJFUmdIRjFVamFCTzNzQkVESnl3akdVY0xMZDhhQ01KY2N0N3dE?=
 =?utf-8?B?bmxZY2NRU0ltSVArNmtpa2VuRndZbDNBbnRVV1lwdHBvTEs1MmJhL1lQekt4?=
 =?utf-8?B?aDRuakl0dW1nTmZGNWdUTUpldFlBTHo2L3huMmRCODVHZnpnaitSdkJycVN0?=
 =?utf-8?B?TmpsREhQVmRjdWJyeTkwQlN0eFJSc0Jma3N6M2Z3elhUdCtSR293cGZJSFhp?=
 =?utf-8?B?eWhwZitsdUNCR01XN3ZkYW91NlJKZmRlZk1TS0dEZGZ4dDlSUnh1ZHVCRE1u?=
 =?utf-8?B?YVlIWit0R0lNcjlDYng3ZHRUU1dadUxlRjJOMUM4K2tBRkk0eUQ4MmJGWnVB?=
 =?utf-8?B?UU5TaHc0emhycmk4YTRnR2dJRUNwYVVib3JVa3dlS1Jtdzl0T2sxc0FONGRz?=
 =?utf-8?B?eFlqRjNKVWhZL1F2Q29saTRiV2FwQnBxb24vckNaeldWT21WalpLUE9mSW55?=
 =?utf-8?B?VGMzVkNQeTJHRC9mMDk1cExLTHNGeXRyOU94MURGZ0Q0YWtHRFhiZzl2RGs1?=
 =?utf-8?B?OW5keWM2a0VPblRhcFNFR3RFMitYK2Zma2lUVkQ0MVV6QnFCeGRrbUg1NkdG?=
 =?utf-8?B?T0ZFZ2pTOEk2bEtmRXBKT1M4bHBJQ3hVRVY3aWRkSmtSb0ZUYkc3Q2pyL3lY?=
 =?utf-8?B?cTA2VWJycGdadk85NGxBeXB2aUhYNThhb2ZSd09LNENYZm9WdmNRdEUrSi95?=
 =?utf-8?B?ekZwS1QyOWhRWlpYaWRzSXNhUVNQRjFUVlhrYXBWclE4U25wY1hMY1pMU2Nz?=
 =?utf-8?B?dEtFTk8xVG9oN0E0S3V0bExJM3Y2enlGWnFKT1FRd1B4OEQ3ZTJsMHlYOTRa?=
 =?utf-8?B?RHJiTHhyTlZVYXQzM1FSc0lIZlFuVTF5aU1tMzJjUUFCT3Z3c3ZaYUROT3U4?=
 =?utf-8?B?c2NyZzR5bVIxOUpheGRVa3NzQzdrZXhBZlJqeXpuc29LaG8xWUNHc1BVdmdD?=
 =?utf-8?B?UkNjQXo0QVRVS0ZQMm41ZlZvNVlVaVIvYXlBUmVQbDl0N0kyY3dWSjNXNnYr?=
 =?utf-8?B?S3FTc0ZsR05nWDEybC9QNjBQWnRNYS9yTUdDY3hMc1dGSTZLYWxlZ3ZQaEhq?=
 =?utf-8?B?L05NcFUwRWJ4aFJJUCtsbXQzWG1iMnp4QTZNMUFoOG9OU3Bqc05EV09Ub0Nu?=
 =?utf-8?B?ZjQ0blpNb293R1NmSTdyaEJZNjJwc25MNStGaFM4Q0NPNFdjSXQwUUwxTWVp?=
 =?utf-8?B?dExHNDcwSkVEeXFKUFZGK0xlc3JQRG9MYk9EbFhWOC9XWGdKZER1cTNXc2pN?=
 =?utf-8?B?L2tRMG5Dc2czOXlDbGJsQkU4T0tTZjA5OEpQc05rM2xiYVA3T0ErVExzd01N?=
 =?utf-8?B?K0NsN0lUT1NLK25hajFOYllVMkd3REQ5bmVsR2V2WElJODJJU1dCR1dtQXFh?=
 =?utf-8?B?Y0o5cmVMUWlVUEpTN1M3MUhXaklsd2RRd1JGaWpvQXduaUdIR2ZuNTNHYkxK?=
 =?utf-8?B?TmRRV2U0YjFzSFdaUmRWV0lCbDlIT0RNTnhST1N0a2V5MjlTVjcyZzFwbFFl?=
 =?utf-8?Q?RpgYS6Hk0afyQA5BOvzx90MBxngNNiIwWWv/TvnX3Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAAAC74A721A7B4B9D2102CC96C5C258@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b56f6bd-bd57-4c85-24ed-08da006c06e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 18:55:19.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOdbLFXMMkCgcO/lCC6ydYUkToq4+ntT1s7DLz3Je8SyPBM3XGg8e8gAS0eS9YGLli7fJ1zM13TTYjS+gb8M5IGPYCf0ev2luxxeRxIida0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203070105
X-Proofpoint-ORIG-GUID: PmU1FG2M0lqZpCH6tDUo3gBVq9pfdaBN
X-Proofpoint-GUID: PmU1FG2M0lqZpCH6tDUo3gBVq9pfdaBN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDYsIDIwMjIsIGF0IDQ6MzMgUE0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOg0KPiANCj4gSGkgRXJpYywNCj4gDQo+IE9uIFR1ZSwgMjAyMi0wMy0w
MSBhdCAxMjozNiAtMDUwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IEEga2V5IGFkZGVkIHRv
IHRoZSBJTUEga2V5cmluZyBtdXN0IGJlIHNpZ25lZCBieSBhIGtleSBjb250YWluZWQgaW4gZWl0
aGVyIHRoZQ0KPj4gYnVpbHQtaW4gdHJ1c3RlZCBvciBzZWNvbmRhcnkgdHJ1c3RlZCBrZXlyaW5n
LiBJTUEgYWxzbyByZXF1aXJlcyB0aGVzZSBrZXlzIA0KPj4gdG8gYmUgYSBDQS4gVGhlIG9ubHkg
b3B0aW9uIGZvciBhbiBlbmQtdXNlciB0byBhZGQgdGhlaXIgb3duIENBIGlzIHRvIGNvbXBpbGUN
Cj4+IGl0IGludG8gdGhlIGtlcm5lbCB0aGVtc2VsdmVzIG9yIHRvIHVzZSB0aGUgaW5zZXJ0LXN5
cy1jZXJ0LiAgTWFueSBlbmQtdXNlcnMgDQo+PiBkbyBub3Qgd2FudCB0byBjb21waWxlIHRoZWly
IG93biBrZXJuZWxzLiAgV2l0aCB0aGUgaW5zZXJ0LXN5cy1jZXJ0IG9wdGlvbiwgDQo+PiB0aGVy
ZSBhcmUgbWlzc2luZyB1cHN0cmVhbSBjaGFuZ2VzLiANCj4+IA0KPj4gQ3VycmVudGx5LCBhbGwg
TWFjaGluZSBPd25lciBLZXlzIChNT0spIGxvYWQgaW50byB0aGUgbWFjaGluZSBrZXlyaW5nLiAg
QWRkIA0KPj4gYSBuZXcgS2NvbmZpZyBvcHRpb24gdG8gb25seSBhbGxvdyBDQSBrZXlzIGludG8g
dGhlIG1hY2hpbmUga2V5cmluZy4gIFdoZW4gDQo+PiBjb21waWxlZCB3aXRoIHRoZSBuZXcgSU5U
RUdSSVRZX01BQ0hJTkVfS0VZUklOR19DQV9FTkZPUkNFRCBLY29uZmlnLCBub24gQ0EgDQo+PiBr
ZXlzIHdpbGwgbG9hZCBpbnRvIHRoZSBwbGF0Zm9ybSBrZXlyaW5nIGluc3RlYWQuIFRoaXMgd2ls
bCBhbGxvdyB0aGUgZW5kLQ0KPj4gdXNlciB0byBlbnJvbGwgdGhlaXIgb3duIENBIGtleSBpbnRv
IHRoZSBtYWNoaW5lIGtleXJpbmcgZm9yIHVzZSB3aXRoIElNQS4NCj4gDQo+IEluIGFkZGl0aW9u
IHRvIG9ubHkgbG9hZGluZyB0aGUgTU9LIENBIGtleXMgb250byB0aGUgLm1hY2hpbmUga2V5cmlu
ZywNCj4gdGhlIGtleVVzYWdlIHNob3VsZCBiZSByZXF1aXJlZCBhbmQgbGltaXRlZCB0byBrZXlD
ZXJ0U2lnbi4NCg0KT2ssIEnigJlsbCBhZGQgdGhpcyBpbiB0aGUgbmV4dCByb3VuZC4NCg0K
