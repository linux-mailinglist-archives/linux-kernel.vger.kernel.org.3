Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB2051A581
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353449AbiEDQaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351902AbiEDQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:30:03 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E683B46B2B;
        Wed,  4 May 2022 09:26:26 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244EmYD3000798;
        Wed, 4 May 2022 16:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=sMImAWrckN+jIt5nMm84nC4ZYeKDEMEEzxEG0zbP07o=;
 b=OCsMQFoNeVH+g3+qG91/mFzIe0Egf/1WkDIsQ+Kp5xwJRvhJsoyp5G+Js+4Y0lfibq6Z
 CEMWTAB6C7eY4xcHj3i9cMHEMUuWkyS1rU83CKPxT/i/Cl7tgXdiouw7SOUwmMZ8d+BI
 5kTaqrfXi/WL+wUerc1heoEMVahaOe225XimLvJpIvUSbc7xLSyFByx6TwkL3Ok3TzZm
 zqM2ErXgBAahdVCR3spJdk3vQpqDTAuEdRJNDeGimrBCz+t5wIw8rYhau3/YhjA5bykw
 7INWzUA/N/A4+a+cCrd/81AxQdGaQq/Ohv9AMrU0B3ssPVbITnQ1XsD7Xi7tLQhwa7Ku ew== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fuujh91wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 16:26:03 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 9AED6805E02;
        Wed,  4 May 2022 16:26:01 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 4 May 2022 04:26:01 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 4 May 2022 04:26:00 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 4 May 2022 04:26:00 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 4 May 2022 16:26:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDoNmZwUlxX9/3gPXQpMAPLjQtHX1V3vlBKJxCXXf1Do75GODPU9riXhTgpg2KNNcHC1uhHxVAysXQl+GJPoI6iLHwHpRSMCajXUL+flxmAHouC5/pFYEwY7+IM1WPopRKZ1GHFMLXGbNx0TCxLGTXJQzJhaTstunYUp5q521LOTwT23yU2hl30ZIXVFJlpvgk7IAthUN+iQUQfeYas8948/Qyh2tD2fsuygtJGRGJY6EoPsDhCWNEapRdc5aQ5F+u5f3K6qa+dM+nL2Qka8Sb21MrPCgfM/Ef81zLTsE1epMWo5udMnE5P9TJKKXZEjjWwlwSWhrqkqlXFHPGTtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMImAWrckN+jIt5nMm84nC4ZYeKDEMEEzxEG0zbP07o=;
 b=Xgph3b1Z9O50bTdzWhZFWesFa0l1K0E0Uu4UtjtCeC5eDWS5yAB7X9YMepBQYna1IEGc4lUokH8KkHmCTGxcgphDVjsSc+oljR4WfTDyvFzI43vPXLDT9w/YTXn1NB2nH0YwCiABCVd/OIdr61Lvvi7sQxtfX+DXDqQuJTXuOyGNg/eG7rtiHeVATCeD3wgSfWjlwFwwqNYXGCFRv7apAYbJuFkdPBOmepgby/2MQ1tZPtAgoyM3hTrc/o8UcTcRqAL8EH1zRKKnek/17zpiYyfRQwFzVK0W9Bln3W54eVU9553nBTGtovSOjncoqHhwE3vD2FC1LwbxJhXQaV/wHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by SJ0PR84MB1775.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:435::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 16:25:59 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 16:25:59 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v6 3/8] watchdog: hpe-wdt: Introduce HPE GXP Watchdog
Thread-Topic: [PATCH v6 3/8] watchdog: hpe-wdt: Introduce HPE GXP Watchdog
Thread-Index: AQHYXmTBU9QpRPETyU+LLmyqVzG+B60Ma8CAgADeuyCAABVlgIAAIRCAgAFjtqA=
Date:   Wed, 4 May 2022 16:25:59 +0000
Message-ID: <PH0PR84MB1718D0238BEF9173AF5D5B7688C39@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
 <20220502204050.88316-3-nick.hawkins@hpe.com>
 <c0262cf4-dfeb-c9a9-bcb2-24af006e6d4d@roeck-us.net>
 <PH0PR84MB1718D28F1846F54DB5766E6D88C09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <d88523a8-a240-915d-9ae7-54b2277e424a@roeck-us.net>
 <CAK8P3a3t7-ozDHu18vMKEWxfNS4yd_BNHUh7hQ24rfS20tssDg@mail.gmail.com>
In-Reply-To: <CAK8P3a3t7-ozDHu18vMKEWxfNS4yd_BNHUh7hQ24rfS20tssDg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5273fbc7-47cc-4dbf-72de-08da2deac5e3
x-ms-traffictypediagnostic: SJ0PR84MB1775:EE_
x-microsoft-antispam-prvs: <SJ0PR84MB1775BEE9721DDC269C4CA34488C39@SJ0PR84MB1775.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fFDqWXknRYQ8psd5dV6V47IuEJhR8gbbUvb+910lRoRCFshtraRVwJm+X9HOE6tjbQMV3VBHl7vVNkcvbrPKKH6OMFEHnryP6B9q3X4drblM/UDQuzluquf5xWI+P3oKvFVGFi+yoPM53bFWsN1MuWXJmWHC2P2cMsyVATAYKlwKG35hYwJK1BBFnJ81XKocv9fKGbKL7b4A3/RIeeV56lbvIgAoJd7rGAPxEwgMcG59bBsV7zHd3woGPhR2MTtEpRu5luC9zX0c41E0RnBuT2G3O0bkDqgY8h8tVZ6NoKUFTvBMOLCrue3m9cGVbrpPJwI24SOpmPqqSnVSi46Q0UAhAtgwxg/kc7j3qWdwkcF5rmbWmXKeAnmO0hRus7ILGVb4pBpFjSF65jPnyGTnqZTCxMI4CDU4etCx8U1v7+k04/XwjiGBxGUtrXX9utfPsfLT6cmS8W8BKC47YvY8DVCsDOUNCBtKV+OeNJXJmSbZU7ksbJ+FHO2p1Rebb0IIo6FWBBiQa+zK4C/vcZS5XH8kOXT9U2LdLOS3hmbp+YpgvcU6c6rIsAsM9imJjv/WLv+yOriswxKbnTY/TcxwDZWzHBgjQMybqI7GsDXTRa0mqEcLHpmKLbhHizgdmtALeiffPxbdycWF9nq+GoaWiMKpT0+eXtA0MV5uqrU2Xbgs56bS2LvtYgA6Y5L44GrQzn1qiJYG1xNkSwsxwK+l1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(26005)(55236004)(6506007)(53546011)(55016003)(86362001)(9686003)(38070700005)(122000001)(38100700002)(508600001)(52536014)(8936002)(71200400001)(5660300002)(82960400001)(4744005)(7696005)(8676002)(76116006)(83380400001)(64756008)(66946007)(66556008)(66476007)(66446008)(4326008)(33656002)(316002)(186003)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3Iram1xTTYyMzVmR3Z6OXZVaTVRaHQwOVlSeXFJSkkzeFRCVGd2WlZjeWVF?=
 =?utf-8?B?V2RkZUhaTDV0SHhhY050emVTUnU0NUVacUtnN0ZSSHdZOU1tMm84RmRtMDgy?=
 =?utf-8?B?U3JFMWMzMEtCeFRINjkrc0NpalNUeUxlV0NRbjVUUHkzQ1kyMHRRbCs5ODhy?=
 =?utf-8?B?ZDQ4S2hMK1VYd2piMEZFT0tkK2FxTEJldFVYRkQxamhYNWZhTTJCVXRidTBO?=
 =?utf-8?B?UDlDTCswUDBIeklyMUQ3TjhnVUQxby9VU0d6a09KdnhETXh5UW1EWmR6TXVC?=
 =?utf-8?B?TyttMStOUitwVS92Z2l6ODQ3VGdMRmh1TWdNS2xvbmpLcC8xODBQaHhaTGxX?=
 =?utf-8?B?ell3aFhVd1I1NEFMQTdqeDFCc1FmNlBNNU05dWRubndobmtEVkt0aXBndmpV?=
 =?utf-8?B?L0pvY0VGWE5BWjhZRnRzckZlYTAzZDJiVzQ4blFsUWQzbzRKN0ZFYTFqV3RN?=
 =?utf-8?B?WHl6MVdXcTcyWTNGdENhYjFRRjE5WGl0WWVkSHNxQ3JQZEpneks3SldFVTNo?=
 =?utf-8?B?MERLODZMRnI5MTNjVTZBL2NFcDZ0RjdZRyt3US9veTh0NHo5WnZjbzVUbmo2?=
 =?utf-8?B?Zk9TQ3dwQkpjaFB3UUxBOFpCUGU4TUp2cXJ2ZXZ5aHg0VW1MNXphZk9nODV3?=
 =?utf-8?B?Y1pyVFpFOVE5cEQ4YXBvRy9lYkZRN1BsbWg3dWkxSGJHdERhMTMzZmpkbVBw?=
 =?utf-8?B?WGE2LzNWWHQ2VkhoS0R2TWF2TmgzdkdhSGZ4aXh1cDYyY05CUlU1SjFpWFlP?=
 =?utf-8?B?YkJYbGxEajhPZ1BwcWNxK0lLb05FVE1RdmpuNmpMa1cyOXRpKy9IejA3MFov?=
 =?utf-8?B?Skl3a2N1dGQwbForTnhtTU1keEhsc29GNlVjaXpxbHBtOHhqY3hCTTRRSURO?=
 =?utf-8?B?S1ZaK3c1RlM3VFZIT210WWlzYVAzd0MzbkhBcU0yd3JoZDNiZDBpRXdsU0dY?=
 =?utf-8?B?bmhZQUNjaEluNi9kTnJsTm1SRGdIWTBJcjZqWGc3Ym9UeVoyUGNQblAwYnRU?=
 =?utf-8?B?S3VaMzh6M3laUjFIOG4wd3VwOHJYc2pDSW1FQ1VFalpkODRzZ2d6R1BCMkxI?=
 =?utf-8?B?M2M5aS9OcDFUSmdmeWs3SExkS3A0Q2ExN3djUUNwdEpuMDErVlM5UEcxdC9p?=
 =?utf-8?B?NVozeFp6Q3pLZkpzU0k2Z1hYU3BVUDE5THRyRXc3MzgxQklaWHF2dW15RXhR?=
 =?utf-8?B?TWxNRnBCSDNwQVhWUGN5WG5yajVZc2VkWnBuN0RIckNXZkJld3RHYnZwZWFs?=
 =?utf-8?B?YzgyTTk5QzVZZlFEUm1xOVBaZzJ1K0dIRDR3MEllaW1ob0NCUEU2N1pKYkxZ?=
 =?utf-8?B?ZEdrWmhDLzBuQkgyQ3JQUUZqUGVDdUNHWjJ0MFZzdThlak1ZeS8wWVlVK05p?=
 =?utf-8?B?YnY1YXNvaDEzUTg0ZnU4Y0dFNE1ka0kwS3pHbW9wK0dwb2w1elpYSGZVNHlR?=
 =?utf-8?B?QzlKMks3b253dkpBUDM1RllLVnJ1dUQ0dVlIaXFrVFlDU0wzMlZ0UjVIalZk?=
 =?utf-8?B?d1pDK3lkaG03czc4eXp1WmR3K3FkOS9tUDc4NjVhZDErK3JIU0N2Tk1PRXVh?=
 =?utf-8?B?ZFpUa2tLNHI5djdPZG4xQXpGSHN5Wms2VExRQXNuQnVUek1QVmo5YmxLVWlZ?=
 =?utf-8?B?c083eDFMaTZUemNKcDFUbjlmNGd0ZkdxdGtkMUcwRVFyZ1B4ZEJGdXJKS25M?=
 =?utf-8?B?bDlnZlFEVjlEc1BzSncwcWRsSyt3VE5pT3NCUnMyTytiOW9IL0xkemdhVnNO?=
 =?utf-8?B?bGVlVVNNQjhXL05OYm1mUkVKVy9aR3NPUVZNZWdUdmcxSmVWY1Nvby9Rd1di?=
 =?utf-8?B?QjYzYVphYnoyaUx1Y3RzcGZzSnh6Y3c5SVhtdnU5Sk1Hc2NkbW9XZW54ejhy?=
 =?utf-8?B?TTdrVkE3OENvWnRRSk41ekswSHgvZzg0cWVGRTI1ZmpvNGgrQU5vZVJqYkto?=
 =?utf-8?B?ZEQwYVVMYXB5Szc4d3ZOTjNzMWVzYzBsYkVBUzFuclBhdGtmWTNESmdldGli?=
 =?utf-8?B?ZVk5d1pwSWRnOGRXL2ZSdnh3R1AraWtSdUR4SHFuZHpZUDJabEtYbEdCLzBy?=
 =?utf-8?B?NW84UlRZVHU5UGZQa1ZTdE9ZelkrMjFFVTB4YnN4dHdKeU5GdEhTemF5dFdT?=
 =?utf-8?B?Y2hudURXTmFCVzdHOFpPbTZVM3hnUmdSZDNSRk82RGtXTmRvcjJuYzV0VmRn?=
 =?utf-8?B?K3hnNWlWRHFVMDAzU2Q4aWo1ZFhZalFHazJidkEyT3FNTlMzbjBTY0hLNUdo?=
 =?utf-8?B?S3QyNW82NTFBL0FGbE1yVWpRc0R4MVdFUVUxVUdmUi9pRnlDMU1rWTkwZnlt?=
 =?utf-8?B?VEgwMEZzN2k5UkdPSjcwaytqWHJnbUIxVGZFMWpUNGxTTWpGTXpBQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5273fbc7-47cc-4dbf-72de-08da2deac5e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 16:25:59.1336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vh+KLZOUuP5tzY9je4cNeg7h3rEwka9FSAOORwIftvjbZktS06SIEMrCK3n1jYXAOt4qJjxpQXu5Uax0dT1aTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1775
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: rfIZlIiE7pFQPeHphVHPmndBN3pS8IRc
X-Proofpoint-ORIG-GUID: rfIZlIiE7pFQPeHphVHPmndBN3pS8IRc
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=833
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040103
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUdWUsIE1heSAzLCAyMDIyIGF0IDY6NTMgUE0gR3VlbnRlciBSb2VjayA8bGludXhAcm9l
Y2stdXMubmV0PiB3cm90ZToNCg0KPiA+IE9uZSBiYWQgZGVlZCB0ZW5kcyB0byBtdWx0aXBseS4N
Cj4gPg0KPiA+IE5vLCBJIGRpZG4ndCBhc2sgdG8gcGFzcyBhIHN0cnVjdCByZXNvdXJjZSBhcyBw
bGF0Zm9ybSBkYXRhLg0KPiA+IFRoYXQgd291bGQgYmUgbm8gZGlmZmVyZW50IHRvIHRoZSBjdXJy
ZW50IGNvZGUuIFJlc291cmNlcyBjYW4gYmUgYWRkZWQgDQo+ID4gdG8gYSBwbGF0Zm9ybSBkZXZp
Y2UgdXNpbmcgcGxhdGZvcm1fZGV2aWNlX2FkZF9yZXNvdXJjZXMoKSwgYW5kIHRoZSANCj4gPiBw
bGF0Zm9ybSBkcml2ZXIgY2FuIHRoZW4gdXNlIHBsYXRmb3JtX2dldF9yZXNvdXJjZSgpIHRvIHVz
ZSBpdC4gVGhpcyANCj4gPiB3b3VsZCBtYWtlIGl0IGluZGVwZW5kZW50IG9mIGEgInByaXZhdGUi
IG1lY2hhbmlzbS4NCg0KPiBVbmZvcnR1bmF0ZWx5IHRoZXJlIGlzIG5vIHJlc291cmNlIHR5cGUg
Zm9yIF9faW9tZW0gdG9rZW5zLCBvbmx5IGZvciBwaHlzaWNhbCBhZGRyZXNzZXMsIHNvIHlvdSdk
IGVuZCB1cCBoYXZpbmcgdG8gZG8NCmlvcmVtYXAoKSBvZiB0aGUgc2FtZSBhZGRyZXNzIHR3aWNl
IHRvIG1hcCBpdCBpbnRvIGJvdGggdGhlIHRpbWVyIGFuZCB0aGUgd2F0Y2hkb2cgZHJpdmVyIC4g
Tm90IHRoZSBlbmQgb2YgdGhlIHdvcmxkIG9mIGNvdXJzZSwgYnV0IHRoYXQgZG9lc24ndCBzZWVt
IG11Y2ggYmV0dGVyIHRoYW4gYWJ1c2luZyB0aGUgZGV2aWNlIHByaXZhdGUgZGF0YS4NCg0KSGVs
bG8gR3VlbnRlciwNCg0KR2l2ZW4gQXJuZCdzIGZlZWRiYWNrIHdvdWxkIHlvdSBsaWtlIG1lIHRv
IHByb2NlZWQgd2l0aCB0aGlzIGNoYW5nZSBzdGlsbCBvciBkbyB5b3UgaGF2ZSBhbm90aGVyIHJl
Y29tbWVuZGF0aW9uPw0KDQpUaGFua3MsDQoNCi1OaWNrIEhhd2tpbnMNCg==
