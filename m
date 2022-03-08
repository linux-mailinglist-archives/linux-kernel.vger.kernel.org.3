Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8224D1FA9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349365AbiCHSGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiCHSGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:06:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292149914;
        Tue,  8 Mar 2022 10:05:26 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228GmsH6004824;
        Tue, 8 Mar 2022 18:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nPigsk/c+QDDF+t0+LdmZzakg6Xnf3UzZTu7CgA2BdM=;
 b=FXbf8Pp9hWkY/1dWZMg4aca0u4yGjtIPcRHvzDkWOS+EZQtUGgAWzgEG8+TJHHkL4/J2
 KAKe554mRH3aYmP9f5BfKHTTKdenWtjQzzJvQXb/b0kpKNeo/uLFeNAGkjjkeaM+6q2m
 vPzldqdlAtvq955qWcIi+3Vaq5wKwDLpR/0R61zSJrXAU8PNc4XrkvW6jCrv9eOpo4f8
 jqzG6NUXmRvltBzyw2OOqVyfDEfJFgsQB3ehxC9oou+UeNU4hw5rUIHbpUY3KvA5QImM
 NDuV4lEGdzddVXnRi9uXK+2mhc/mu85Q1+Nv0b6EpnP40DDviHC3P0dkltDl61uBakPQ WQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyfsfs9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 18:02:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 228Hw3GA103401;
        Tue, 8 Mar 2022 18:02:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by userp3020.oracle.com with ESMTP id 3envvktsak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 18:02:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3mDaTmAaYYVxC6VLqfv3kQiCWMv3GSvQRabexJXdQaqRcQgpBO6iVaEeDVeAiSEC9Z1/HHcw0L80/oUTgNdxzQ8sjFMDiXFP6eL3vUi2p1sW+IGGIUsmycfM1ifqV/XLbpbYxfaXtIbyS1RlM9bk0+/02K979z/XKdTq++KYfe+DGtkZ20+trK+x6SeZsO579TSc/pbSeoDoh6ieZWHgubLk2FNTl98+tyQG+6isVhtGGNH1dacblJDX08sf+z1YLynfFC+PnS43QMxsJiBR0bwofYrotZTIp1M4VL34GjuTGQMXQj2XvKgk94iIHWuSkplqVeN62YaKWjnE0QWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPigsk/c+QDDF+t0+LdmZzakg6Xnf3UzZTu7CgA2BdM=;
 b=VNAFYcMWl2YlS0BL6EBYfHqRwTTO/jc7jt6pBSq8fljzc33YBAeakfTZnf9qZ4ljJdBqpUGHl+g+pYK2iPmL1BKaWuxR1jZnBcii/nmoGjDRn+aAeCggUPpwajruHidz5vfW3BxZDrbWoKYWiJKf2Jc23XXbMFmCqrRu159iCRsq6ObHvqt13FyzPSH/6d6BiwM9xWEnl7ySDdzXoTntuEKGXFQJkNt0JqfTfD8Otpu3uLi/Zyq7bJciTPoPJ22RLocMnO531wNJjCqnsMealMh5IZT5tt9Q3SRnB1vyL+icACMz6NMwNm4/MXiQWV2Tg4DsO86+vejKvTsr9gw42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPigsk/c+QDDF+t0+LdmZzakg6Xnf3UzZTu7CgA2BdM=;
 b=c5V5T/pHlz8hnR+fSYRhmwj/Q3J+IySPBJuwOfwDnYLS2WhQPfVKSYKZA9k38gT4ZvPkpgr3EiXEcDWsuq3c9sFuGN+CiNm31jQxNIbEdVjJZshgxmdR8LPZO4rJRjwBe+pM/Y+9iI+8w3SoQo3pFCdZbL/qnrtnIQD53Gci0ZU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SN6PR10MB2734.namprd10.prod.outlook.com (2603:10b6:805:41::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 18:02:26 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a%7]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 18:02:26 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] KEYS: CA link restriction
Thread-Topic: [PATCH 3/4] KEYS: CA link restriction
Thread-Index: AQHYLZNA834T4wj1IU2tnKIEwT0iJayvXcOAgATjNQCAAFKBgIAACluAgAAwN4CAAKt3gIAAWKsA
Date:   Tue, 8 Mar 2022 18:02:26 +0000
Message-ID: <068F32E0-B202-4B20-9DE7-57373EF71BFE@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <20220301173651.3435350-4-eric.snowberg@oracle.com>
 <47f3654e-892d-a35a-e77c-70ada1ebcf43@linux.ibm.com>
 <2415444C-AD8F-4F03-8B1C-C0770F83ADAE@oracle.com>
 <e2dd58cd6074ae692256333b43b5ecde70bcdbdd.camel@linux.ibm.com>
 <67456A73-8B72-4DB6-8E23-7C603661A0A4@oracle.com>
 <22860730-d615-5683-6af0-05b6f4f3e71d@linux.ibm.com>
 <e10f2161aaa69a9d301b3a16a37cbab266318aee.camel@linux.ibm.com>
In-Reply-To: <e10f2161aaa69a9d301b3a16a37cbab266318aee.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e59d61d2-4a3f-4a37-74ed-08da012dcdb1
x-ms-traffictypediagnostic: SN6PR10MB2734:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2734F1D0B5F68AF93A6DDAE587099@SN6PR10MB2734.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6vuy+9FC/GkLqjDi7Od/r6jtfrDDJ9sQqE4tz7ppGdoYTrD5lNfc4y+vkVRKzqQO+TRWQh3huYWA5ptW711E0+NEOShZEDSVJS5gfSXJJRDqKna9DaTMDhn0Bq2doz1/jRDcG12yMhFCs+4c9nBFmGCGC5w+J0Ru4Mt6ypKgW9B/h5JNhbSxXM5Mc19jAQJ1AEVOWkD22tEnu/OFrSYge9oIGg8IQDxKji2bujIYVlL/ai7M65qaXF9571qYO+VJWN4S8erGWfCA3MN/WR0vxrAcN9kiPUqjitAbpJzbJ3DBJzXElV62Tq2bqTgE7H99cn0FJOQnzBPaPLLAPQJ4mDql8xjQe3+62+PLMMN8fIU4/k706j3wF+LOS8LPWk4GcycQK1/g20YlgzRB2jP5nmJgzcirZmI0ZDv3x47/D6bTn+c/CvOUX2ZEiuROIv7lq9dsIQ1bBXfSrvF7UzwfON7EfOZWxc79YUsJyBBk+btjtq2BuJtuAspwnlpQ4D/RuPhzY4dpEFIUByOUCzCbwrxoLaUq3ZhxQtxHKFl/N7a2yM79E5ufzIyhdUAbj8+oeEYgwkpekzssWTczGTXVPnN63nTq8M5jnZjEBTwzNCWnQaA2VaQzrGe2elzgPd0tiW/ZTvGxz26T6K2FOEwro9uAcYWSnU5KPCjSb2SQQE8jZSQrMG8I72r1KISErtsNmzZCxo2fkQAivznuPd3Vmltj7fOW5dfj+KCtWx+h9VuxJON/48cVc6Dl6DCglesh2P1Iz+ckY3ASDJRmiSN0jopTtOJCNf4uSYx1vmrW7GwE7wos90ziC3ZLXaOckJKI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(7416002)(44832011)(6506007)(53546011)(33656002)(86362001)(8936002)(2616005)(508600001)(5660300002)(6486002)(2906002)(6512007)(186003)(26005)(64756008)(4326008)(8676002)(91956017)(66476007)(76116006)(66946007)(66556008)(38100700002)(110136005)(38070700005)(122000001)(316002)(71200400001)(54906003)(36756003)(83380400001)(966005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzIrTi8xRFZjQVFlNG1MTldETTJxTUs1YS9ZeTllSnBBcEp4NytBYUp4Skd0?=
 =?utf-8?B?YlZsYXN6Um13RHF3Z0Ryd1JXazF6SUYyeUwwMWVWN1Q4T3REeGczMzlKQTAv?=
 =?utf-8?B?c2FkQ25pMWNUWkRIR05NUWtNSVVDOW85aS9rQzFVOUVFenl6TTc1aGE5UjRh?=
 =?utf-8?B?ZUlzRzdOYkQvbmcxTlpRejVxQzVqMjJNRDZsdWF4SnQrR09RdmYzemt4ZXlp?=
 =?utf-8?B?cXAwck1DTW1vQjVkUHVFdEJGSDFhYzlMWDZoR2trMkN5c0I4bUtHZkJsck14?=
 =?utf-8?B?Z1hOUTRXbW1pMlM3OENNWFVQU2wzMjRFKzUrK0kzVGhCWjdDVk95SElDb3FW?=
 =?utf-8?B?TnF4TkFUMExNU05ISmR1NTZVZXpZaEUrck5Bd1MrMUZlQzlxUUYyZ1lIVE4x?=
 =?utf-8?B?Y3RHSDVZWGJLSmxSUndFMGE4TUtuT3UxbW56UE10WFZ6Y3E2dTl5bFZBMHEx?=
 =?utf-8?B?d0xoaVhZeDczTGFSS0ZoMnR0MkJqNUdyMnFmeEhXOXNnWjdiaXRoMzltL1FX?=
 =?utf-8?B?NzZYd0RFb1RYN2h1aHdBcXlJc2ZLWDl2ZVhHT1hYT2VzUnZCQ1RuSVpHZ3lC?=
 =?utf-8?B?cVpkQW0yS3JUWitnTmFUOThWQW5sa00zcTB4V1pUc3BoYVNOTGZ0RVpRbDdY?=
 =?utf-8?B?NHg4RTBnd3dyMUttVmNpMzl0U0JxcTA2MFpqcDBYSVlING9WVTJSMDR2K0VQ?=
 =?utf-8?B?bDVtdEUxbCsxL0ZmTVl5cTUxZWY1TFJodmYxaGRNRmhzYXN1U0l2YlNhS3pQ?=
 =?utf-8?B?eEIzaEtYa3A1dG5RRitPWUNzZGhLRVpjbUgvN1NiNjllK1dQTnFiRXYwZ25C?=
 =?utf-8?B?VUhjK1NoRkZTMzdmTlVSbW9TNmFOZGdDMGwxc3prckhScXpMRnRGS2liV0lT?=
 =?utf-8?B?OTNYeS9IeVcrYzNnQnZKNWMzQ0wwbkkvSzVpWHlMaWlRZkJ0NGpKeThNb1hC?=
 =?utf-8?B?UmpUeDJyeUNuLzlZSFd2U1gySURFN1dTV0RyYzVOWjVDRUNRdDNrQnB0cnZ1?=
 =?utf-8?B?MlRJLy8rSFp3MTJEdU81WjN2aFFiZWxUNjBsSU9uaWhFYlZtU1hya2FRZDdU?=
 =?utf-8?B?a040MXdXeVBUcmFhVlZMUnpINjJLVEsvUDJmeEUrbTZVVDlyQmo1N01iZkFm?=
 =?utf-8?B?bTVjWWhkVmR5cTlJMXdjZm5zU2ZiRnZ5N1dMU2JsM1hsSTMvQU1ZaGZxQTR0?=
 =?utf-8?B?VEIzVTMzcWN4dzdRVjd2TVFYTHBVcWkwc3JGTXFGV2xsY1V5endhaW4vdTdG?=
 =?utf-8?B?SGhVLy9LWnZDbTBrTEV2WThiMEdpdmdvTTBjUzZZZ0pSaTVPYm5mdWcvaDRs?=
 =?utf-8?B?NDQrdXNKNGZCaDVUZXYwZS9lcGg5TWIyZEROWTNMZXJ2OVIySlBKNTdCMWRn?=
 =?utf-8?B?MFU1WnhLd1ZYWmo3Z1o1RFc5OFBqVm5vMEJ1ZGcvQVBzczdRdzBrK0xUeHdn?=
 =?utf-8?B?Y1pnWWU2TEJ3TzFHdExoelVEcmRwejYzVjZuNmZac29hOGdSajI5cTRvVEhL?=
 =?utf-8?B?cUtuMVJnZUFtMVdOWjgvZWFmV3pSa1hucS9xdHlyZjg3clgxVGNBRTBoa2FS?=
 =?utf-8?B?Ym5ma3pCTjVVWWNzNUZ6bnJJaWV3WUdoUElsZXhtYVFWREFpcS9jNGtCNVNR?=
 =?utf-8?B?ZlFwSU5IeWU0UEc5NGp2ZS9OdDlDYi9rVDliYkpxQVZNcUF0NUF1NUF5MGRO?=
 =?utf-8?B?bGp0d0tzSjlYKzBldmcwSGoxanF5dUxReHFRV3lSQ0FFcjRsWDMwbWdNL1dy?=
 =?utf-8?B?WGVUMFhGQmNvVTVXSk5ITnp3bzd3ZmZ0M1FrNVMrZjhpTkY3NGZwYys2dXVN?=
 =?utf-8?B?UFpiMkpBT2FnalB6VnVwQzFGV1Ztd3NCK2JLRHpHTldEZENOaStDMmhBU25s?=
 =?utf-8?B?UUlXVXQ1THc2amdJMEczV2tRUXNzWVB4YlBWMTM5elVnODVvVzlZN3dhT0xZ?=
 =?utf-8?B?VHFlYUpYQjY3OElBWE1lM2NvYVVKTVB2UHA3WkNlZzQ4clo0dzlBT0Y3aFp4?=
 =?utf-8?B?eWorZHpocWU2VEk0a2xLRm95Wll6SWtqVTIzQ3FoMVVjT0VvMVR6Q21nQ1dh?=
 =?utf-8?B?VTNEVFFRNERnenFTcVlXaGZuUHJTVWZvbmtVV0hWSVNhVU43bFl2WXdjdEla?=
 =?utf-8?B?Y2ZsOHJuYys1cVd0ejNPZDBSTytnMmlZcW94akx6NnJ5eXFMV1FtdXJOcklZ?=
 =?utf-8?B?QmJzYmFVTnFOektUeVB3UnZTemI2SFJXMncwV0ZYZy9CQUtGRlVlYmZaWEZy?=
 =?utf-8?Q?klMVQ1X0Q6wxmS9WUJjEAPZqZcWXc6VP/ylivr7vvg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <042FCB20DD98D9498C651AEAACA24767@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59d61d2-4a3f-4a37-74ed-08da012dcdb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 18:02:26.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0i5rA+MVfRkSyd5bCIf2Nnr+TywGK5e2OwDNMpL/KzwObiJcQAa8P55WunbgzRetNee8vYfgI/+aSY8mzpUwwEnu/QGVS+MtxS3pqHDzYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2734
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080093
X-Proofpoint-GUID: gDYfzMTZdtka5UT2DjEjOp_azWwzQVvX
X-Proofpoint-ORIG-GUID: gDYfzMTZdtka5UT2DjEjOp_azWwzQVvX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDgsIDIwMjIsIGF0IDU6NDUgQU0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAyMDIyLTAzLTA3IGF0IDIxOjMxIC0wNTAw
LCBTdGVmYW4gQmVyZ2VyIHdyb3RlOg0KPj4gDQo+PiBPbiAzLzcvMjIgMTg6MzgsIEVyaWMgU25v
d2Jlcmcgd3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4+IE9uIE1hciA3LCAyMDIyLCBhdCA0OjAxIFBN
LCBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IE9u
IE1vbiwgMjAyMi0wMy0wNyBhdCAxODowNiArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+
Pj4+IA0KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9yZXN0cmlj
dC5jIGIvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9yZXN0cmljdC5jDQo+Pj4+Pj4+IGluZGV4IDZi
MWFjNWY1ODk2YS4uNDliYjJlYTdmNjA5IDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS9jcnlwdG8vYXN5
bW1ldHJpY19rZXlzL3Jlc3RyaWN0LmMNCj4+Pj4+Pj4gKysrIGIvY3J5cHRvL2FzeW1tZXRyaWNf
a2V5cy9yZXN0cmljdC5jDQo+Pj4+Pj4+IEBAIC0xMDgsNiArMTA4LDQ5IEBAIGludCByZXN0cmlj
dF9saW5rX2J5X3NpZ25hdHVyZShzdHJ1Y3Qga2V5ICpkZXN0X2tleXJpbmcsDQo+Pj4+Pj4+IAly
ZXR1cm4gcmV0Ow0KPj4+Pj4+PiB9DQo+Pj4+Pj4+ICsvKioNCj4+Pj4+Pj4gKyAqIHJlc3RyaWN0
X2xpbmtfYnlfY2EgLSBSZXN0cmljdCBhZGRpdGlvbnMgdG8gYSByaW5nIG9mIENBIGtleXMNCj4+
Pj4+Pj4gKyAqIEBkZXN0X2tleXJpbmc6IEtleXJpbmcgYmVpbmcgbGlua2VkIHRvLg0KPj4+Pj4+
PiArICogQHR5cGU6IFRoZSB0eXBlIG9mIGtleSBiZWluZyBhZGRlZC4NCj4+Pj4+Pj4gKyAqIEBw
YXlsb2FkOiBUaGUgcGF5bG9hZCBvZiB0aGUgbmV3IGtleS4NCj4+Pj4+Pj4gKyAqIEB0cnVzdF9r
ZXlyaW5nOiBVbnVzZWQuDQo+Pj4+Pj4+ICsgKg0KPj4+Pj4+PiArICogQ2hlY2sgaWYgdGhlIG5l
dyBjZXJ0aWZpY2F0ZSBpcyBhIENBLiBJZiBpdCBpcyBhIENBLCB0aGVuIG1hcmsgdGhlIG5ldw0K
Pj4+Pj4+PiArICogY2VydGlmaWNhdGUgYXMgYmVpbmcgb2sgdG8gbGluay4NCj4+Pj4+PiANCj4+
Pj4+PiBDQSA9IHJvb3QgQ0EgaGVyZSwgcmlnaHQ/DQo+Pj4+PiANCj4+Pj4+IFllcywgSeKAmWxs
IHVwZGF0ZSB0aGUgY29tbWVudA0KPj4+PiANCj4+Pj4gVXBkYXRpbmcgdGhlIGNvbW1lbnQgaXMg
bm90IGVub3VnaC4gIFRoZXJlJ3MgYW4gZXhpc3RpbmcgZnVuY3Rpb24gbmFtZWQNCj4+Pj4gIng1
MDlfY2hlY2tfZm9yX3NlbGZfc2lnbmVkKCkiIHdoaWNoIGRldGVybWluZXMgd2hldGhlciB0aGUg
Y2VydGlmaWNhdGUNCj4+Pj4gaXMgc2VsZi1zaWduZWQuDQo+Pj4gDQo+Pj4gT3JpZ2luYWxseSBJ
IHRyaWVkIHVzaW5nIHRoYXQgZnVuY3Rpb24uICBIb3dldmVyIHdoZW4gdGhlIHJlc3RyaWN0IGxp
bmsgY29kZSBpcyBjYWxsZWQsDQo+Pj4gYWxsIHRoZSBuZWNlc3NhcnkgeDUwOSBpbmZvcm1hdGlv
biBpcyBubyBsb25nZXIgYXZhaWxhYmxlLiAgIFRoZSBjb2RlIGluDQo+Pj4gcmVzdHJpY3RfbGlu
a19ieV9jYSBpcyBiYXNpY2FsbHkgZG9pbmcgdGhlIGVxdWl2YWxlbnQgdG8geDUwOV9jaGVja19m
b3Jfc2VsZl9zaWduZWQuDQo+Pj4gQWZ0ZXIgdmVyaWZ5aW5nIHRoZSBjZXJ0IGhhcyB0aGUgQ0Eg
ZmxhZyBzZXQsIHRoZSBjYWxsIHRvIHB1YmxpY19rZXlfdmVyaWZ5X3NpZ25hdHVyZQ0KPj4+IHZh
bGlkYXRlcyB0aGUgY2VydCBpcyBzZWxmIHNpZ25lZC4NCj4+PiANCj4+IElzbid0IHg1MDlfY2Vy
dF9wYXJzZSgpIGJlaW5nIGNhbGxlZCBhcyBwYXJ0IG9mIHBhcnNpbmcgdGhlIGNlcnRpZmljYXRl
PyANCj4+IElmIHNvLCBpdCBzZWVtcyB0byBjaGVjayBmb3IgYSBzZWxmLXNpZ25lZCBjZXJ0aWZp
Y2F0ZSBldmVyeSB0aW1lLiBZb3UgDQo+PiBjb3VsZCBhZGQgc29tZXRoaW5nIGxpa2UgdGhlIGZv
bGxvd2luZyB0byB4NTA5X2NoZWNrX2Zvcl9zZWxmX3NpZ25lZChjZXJ0KToNCj4+IHB1Yi0+eDUw
OV9zZWxmX3NpZ25lZCA9IGNlcnQtPnNlbGZfc2lnbmVkID0gdHJ1ZTsNCj4+IA0KPj4gVGhpcyBj
b3VsZCB0aGVuIHJlZHVjZSB0aGUgZnVuY3Rpb24gaW4gMy80IHRvIHNvbWV0aGluZyBsaWtlOg0K
Pj4gDQo+PiByZXR1cm4gcGF5bG9hZC0+ZGF0YVthc3ltX2NyeXB0b10tPng1MDlfc2VsZl9zaWdu
ZWQ7DQoNCldoZW4gSSB3YXMgc3R1ZHlpbmcgdGhlIHJlc3RyaWN0aW9uIGNvZGUsIGJlZm9yZSB3
cml0aW5nIHRoaXMgcGF0Y2gsIGl0IGxvb2tlZCBsaWtlDQppdCB3YXMgd3JpdHRlbiBmcm9tIHRo
ZSBzdGFuZHBvaW50IHRvIGJlIGFzIGdlbmVyaWMgYXMgcG9zc2libGUuICBBbGwgY29kZSBjb250
YWluZWQgDQp3aXRoaW4gaXQgd29ya3Mgb24gZWl0aGVyIGEgcHVibGljX2tleV9zaWduYXR1cmUg
b3IgYSBwdWJsaWNfa2V5LiAgSSBoYWQgYXNzdW1lZCBpdA0Kd2FzIHdyaXR0ZW4gdGhpcyB3YXkg
dG8gYmUgdXNlZCB3aXRoIGRpZmZlcmVudCBhc3ltbWV0cmljYWwga2V5IHR5cGVzIG5vdyBhbmQg
aW4NCnRoZSBmdXR1cmUuIEkgY2FsbGVkIHRoZSBwdWJsaWNfa2V5X3ZlcmlmeV9zaWduYXR1cmUg
ZnVuY3Rpb24gaW5zdGVhZCBvZiBpbnRlcnJvZ2F0aW5nDQp0aGUgeDUwOSBwYXlsb2FkIHRvIGtl
ZXAgaW4gbGluZSB3aXRoIHdoYXQgSSB0aG91Z2h0IHdhcyB0aGUgb3JpZ2luYWwgZGVzaWduLiBM
ZXQgbWUNCmtub3cgaWYgSSBzaG91bGQgYmUgY2FycnlpbmcgeDUwOSBjb2RlIGluIGhlcmUgdG8g
bWFrZSB0aGUgY2hhbmdlIGFib3ZlLg0KDQo+IEFncmVlZCwgYXMgbG9uZyBhcyB0aGUgb3RoZXIg
dHdvIGNyaXRlcmlhIGFyZSBhbHNvIG1ldDogQ0EgYW5kIGtleVVzYWdlDQo+IHNob3VsZCBiZSBy
ZXF1aXJlZCBhbmQgbGltaXRlZCB0byBrZXlDZXJ0U2lnbi4NCg0KSSBoYXZlIGFkZGVkIHRoZSBr
ZXlfaXNfY2EgaW4gdGhlIHB1YmxpY19rZXkgaGVhZGVyLiAgSSBjYW4gbG9vayBhdCBhZGRpbmcg
dGhlIHVzYWdlDQp0b28uIEJlZm9yZSBkb2luZyB0aGlzIEkgd291bGQgbGlrZSB0byB1bmRlcnN0
YW5kIHRoZSAibGltaXRlZCB0byIgYWJvdmUuICBNYW55IENBIGtleXMgDQp0aGF0IGhhdmUga2V5
Q2VydFNpZ24gc2V0LCBhbHNvIGhhdmUgZGlnaXRhbFNpZ25hdHVyZSBzZXQgZm9yIGtleSB1c2Fn
ZS4gIEZvciANCmV4YW1wbGU6DQoNCmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2Vy
dEVWQ29kZVNpZ25pbmdDQS1TSEEyLmNydA0KDQpBcmUgeW91IHNheWluZyB3ZSB3b3VsZCB3YW50
IHRvIGV4Y2x1ZGUgYSBDQSBsaWtlIHRoZSBvbmUgYWJvdmUsIHNpbmNlIGl0IGFzIHRoZSANCmRp
Z2l0YWxTaWduYXR1cmUgdXNhZ2Ugc2V0IHRvbz8gIA0KDQo=
