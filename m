Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5A4AC2B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443129AbiBGPKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442593AbiBGOzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:55:44 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432E4C0401C2;
        Mon,  7 Feb 2022 06:55:43 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2178cwPd010319;
        Mon, 7 Feb 2022 09:55:41 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3e1ky9n9n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 09:55:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsiNns+MlUnqJbdBTGr7diWjzd/nttdXyYkHQJSTISZvTllAKNyaDns9QF19Q/ZO7kXS+K80pe7v5MI63IfrsTK4O6JaUBkhmmAB9kK7OJyChET9mxlziEyE2Vh+SGe0vp3DD2RT55xYjRcTw8waz37WJ8+R0IVo9hPN4ak8OFr4P52loaDQdABFCtZuJ2ATsW4CwmXDO1o3IztxlAqdOt6Oe55UTdLZAhvvq6Hx8vwjGpnnhmOJOH1H8Z60tJRj+SMUZSMsVKyaoRIcM6lHeXyUOdj2LlmWFHUPStXfBy+G2khXSi+c+wbsQ5Uc5OS4wVSrjA16vFAbZdEp9Jqplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGQMpm+1+U5ksosUgg5N4kIs2GExYCMUW+tDtd49CyU=;
 b=mQeNcMRYIGtB/iqu6+zL9mCWQtv86AWPGZU6zep10F2qEfXNMtlWOrooValPJ+DcRAAryPcIxeZ/v8yhdub00nYmBYqRokx6Ti6l7A45pjJHnVBs8rcxX+F6RCaL87mIU3jpGfqmUaK//Z0P89+6cO/HD3AyyyqP22EPHASH+r7ZxCg12+MDuj6MrNhyd2PSiuviRzv3gJCZz++4HAZbwVmMzgNblunWPD/23CgST/mswX0I9Who7odjy8d/W8RafbbfMOs2CkCIcoX+Mu4A3ALIURkyFCb2dc/FaF95T5XgtRENtyRqTYU6Qypj/TTHT+nJO9+N1K82fomoITW7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGQMpm+1+U5ksosUgg5N4kIs2GExYCMUW+tDtd49CyU=;
 b=uaYgmHbEt6rQOJnXAeXas3NgNOF2L1q9kvHe2A00GN4o+ZGQMakgujrMTHrSM2azWBGyPnxwvoZhBhlZXRXCBJlcYNCoOZLn4NfQnUlWXDw4SZaLH453Ay9Ijjnyu4Ol1lXsziDGHliFz9lqV5O92GZXSYwvu7tBplijaJCHQPY=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BYAPR03MB4439.namprd03.prod.outlook.com (2603:10b6:a03:c6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Mon, 7 Feb
 2022 14:55:36 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1964:eb68:12be:426c]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1964:eb68:12be:426c%6]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 14:55:36 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 3/4] Documentation:ABI:testing:admv1014: add ABI docs
Thread-Topic: [PATCH v6 3/4] Documentation:ABI:testing:admv1014: add ABI docs
Thread-Index: AQHYHCTSQf3KNu31TEmGNNi898YNqqyILOOg
Date:   Mon, 7 Feb 2022 14:55:36 +0000
Message-ID: <CY4PR03MB339929F700810DA7BB36D43D9B2C9@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20220207130549.98415-1-antoniu.miclaus@analog.com>
 <20220207130549.98415-3-antoniu.miclaus@analog.com>
In-Reply-To: <20220207130549.98415-3-antoniu.miclaus@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1mZjdhM2M5YS04ODI1LTExZWMtYWMzMS?=
 =?iso-8859-2?Q?0xNGFiYzVmM2QzMjhcYW1lLXRlc3RcZmY3YTNjOWMtODgyNS0xMWVjLWFj?=
 =?iso-8859-2?Q?MzEtMTRhYmM1ZjNkMzI4Ym9keS50eHQiIHN6PSIzMTE1IiB0PSIxMzI4OD?=
 =?iso-8859-2?Q?cxOTMzMzMzMTEyMjIiIGg9IjMwRTFwVWhhc0J0OC9Pam5lM2ZRTHltZzVm?=
 =?iso-8859-2?Q?RT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBRDJwdFRCTWh6WUFmSEV4QVU3bEE2dzhjVEVCVHVVRHJB?=
 =?iso-8859-2?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBWFEvampRQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-2?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-2?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-2?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-2?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-2?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-2?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4a2fdd4-5a39-42c2-a68d-08d9ea49e63c
x-ms-traffictypediagnostic: BYAPR03MB4439:EE_
x-microsoft-antispam-prvs: <BYAPR03MB443990977E04A9DE94D426399B2C9@BYAPR03MB4439.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jaJpQ8Qx3HJufLI6EfFIT5k/b0Q4O2Mq8Jb40ACkaAIj3os9kJ9jQpaculyDFvGcoQVtEoo7nGHM2WFyPQ6998u0s4W+AzcYDgfTdL5Kuo4mC0E3ebOiPjVBxGNu9Vt3hJgJPTU/CAwwkFIBz5Hphjhr8y3c8nabdQlOUe36aDj9UnZG2noCeEMjYZBNo2dDrFO2AAdSsM0h1BZ2m3UHoV/CzYh0duQzit1xfe58fgSb2qS+YfirpEwWsrFpbSSDWjalV0qxWISJXm+Qv1lMWHFQLYSXxg+nyM+k+821VbGTT3VDCWNkpMPT2c03SD5ruWuNdTMTEtzWr9Ja/d8jtoD9GTNJJCd3q5VCeVTTckmB5IQPYyOhcI1dhaN8kk+807YO7hSzWk/1GaBmQJ8ErjnbpRuBMS6SWsDq4JNNclJHFgBCWbBkBo+IDnwUwdj0Gm0gsLcvHzeIdQk82VjgQN9l4I0FHp/vLuApXcs4xIiciVmmuD6E2L3qe1gQqLGRBmIuuj+smJbdsjUbcvFrHA04jQS88TDLV6QWCfgznu0N0+lrFOCJTSaErSSwqv53NBkXbj4Bw7v/bOCVXghGLNIksCHnrlcM+1HyCOqUC0g1TavZ9Qxz7USoZv2FDGCgYbp542OjKHi1SugG6e9jgV6O33wW3MEEjqFqyw2/N7Wf4VqOjUNT2cxTjRZwG1LKzNTDpkS2davBC0xd/T8e4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(83380400001)(2906002)(38070700005)(86362001)(38100700002)(66476007)(110136005)(316002)(122000001)(66446008)(64756008)(8676002)(5660300002)(66556008)(66946007)(8936002)(52536014)(53546011)(9686003)(7696005)(6506007)(33656002)(71200400001)(55016003)(508600001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?eoNw1Z0kcOWgpsqML/l1UZ3OQLfg8I86kF7XtbMlS6fVlCvSkDHyqSpyIc?=
 =?iso-8859-2?Q?StZbPCHhaKU1DmN0u4y9sI31gmxPUZSEBQji6EWEJXGcWkkwnxQGNA4Rjz?=
 =?iso-8859-2?Q?urS4XSL1Q+/YTJR8Wq/tfsxZXghCCmr8AN6hr1TrTOZBN+oXTSDoPpjDJ9?=
 =?iso-8859-2?Q?ztw5I+dFEWzrjFnJI0nitWwrHbQyzznpmPBQyERh+eQgBPMMHXiZTmfwL7?=
 =?iso-8859-2?Q?OyV7LlKZNApU7blFJ7Sf/+nFH4sQcDHwqVrAcFILdKipV+BQa5Q+bXMiy6?=
 =?iso-8859-2?Q?vVpZYjAj7IveIGG9XdetKzCNHC0mKo/et+KkoACnMMAuCBpVMOsA8uLM9y?=
 =?iso-8859-2?Q?c7ZO3hTnw6wfbDdEdnMRiXLDjyzlzPs3KwkewzF8AHofaNawNHqcvyYZdx?=
 =?iso-8859-2?Q?fGd3/HswPOTgP9uiBGEEGYF/7mhZXjn+0qYU1jpnIoAGHdqCjYn+Lvus02?=
 =?iso-8859-2?Q?HB2w9yOCXdaDc9foE2P7oVJQ5x69QgLAlLlu8HAN9uahrS1Ks0MSdDMd3l?=
 =?iso-8859-2?Q?ZdOzfHKP6rnia3GEw91rjugP8zAJqNm0xsYRLy5Soj2iJsCzYqlypJkIcj?=
 =?iso-8859-2?Q?JO3bGPs5u3O+dyrPRrB5YSYcKKZuOIZRkbn/QD0S9lCgruODmntT3CYCEE?=
 =?iso-8859-2?Q?Fd3H9EdLyl023Cqesfso3V/gcdqs7xCmRU5JPIS94j3CfAG8dfgMUsKzra?=
 =?iso-8859-2?Q?B+R/UQLkK+t9pcp+xBVRQbU7xN9ACwEklQOPhgok+QEIA76lm81vCrN9mM?=
 =?iso-8859-2?Q?QtRmO20YpIOuyefzuBkWmktLYJV0CHp6RhSycHWYGjJhY8nBs5pTLcP15a?=
 =?iso-8859-2?Q?ixVI/9CQePoN/PsEbF6gOdjQ9gLWwsmjyZj9WnMkDrjoprKFr6Lmcbs3z1?=
 =?iso-8859-2?Q?s3hRPvwKzfQx2nS1K+pzZA0AMYjnFnEEpKbpp27C9EuiDL4+hjG+bWkiXQ?=
 =?iso-8859-2?Q?IGWgxfcmXu2F76lWXOc4Htl/ZQn/y1DNxpUnH8il5ap11irFNLGSIbKwIf?=
 =?iso-8859-2?Q?PmVk+WjMsI5F4VYkDBISF8WwheHWglgzTzW3biGhEVCPOslTbB+Y87+jiv?=
 =?iso-8859-2?Q?5edOdeUZUBPmd9KbRjYRNEgaaQyci+c0y4uo79VjwGbY205RGNP8Ljdbob?=
 =?iso-8859-2?Q?c0d/Km0LwqOXwdc2zXAYVBR/rbuQe7ONVjlQ57JoTIZ3VsDd8XWSXnC9YS?=
 =?iso-8859-2?Q?dWhQyWUuhEgVNgS7vc2rCUvRjIJwPBbQwDZ6qAkwbvV/+C2ynrknwIrxtm?=
 =?iso-8859-2?Q?8knWH2BfPi5kPeYVPrycQf8sAhECZBOqWktBd/ha12y8+HFQdVPFQqlKsv?=
 =?iso-8859-2?Q?u80To7sronqbIA/i/7Ccc61EhDkI723YBGBbsg1ajk+LwL31M+daJr7kaO?=
 =?iso-8859-2?Q?FagqLCVo3x900S+MlMfrEfe9kjqTDFKLqkc83guaoRpVwLqBgL0QPQMdmc?=
 =?iso-8859-2?Q?IeZ9kDxjmW1yEkCRCO9ACbNTRSI4gah6fjrhnQYO6JKzbid1ku8t7+qp9Z?=
 =?iso-8859-2?Q?2OMCGGW8Seu2d88DOia1wK1CTbfKVv7i+MjsxIghCPCKWqwfq16gG6520Q?=
 =?iso-8859-2?Q?oQ/GhX1PlYT+H5Q3yhfb451kSmTta/oWknxKTqHcTeoBqN7n0fjlvPGPA0?=
 =?iso-8859-2?Q?7Q9ZsEwjSfiQ3lY6d4CHN4DXlAVweU+mW6rS6G97A1rXIXw1tl6YChUfJ5?=
 =?iso-8859-2?Q?rDeKzcZcil/vlr/VUUmLqBb19k6jZl1VrtSnQEplNzC8zkJVHIbO3UDeYy?=
 =?iso-8859-2?Q?UKxAf3bfDNotUJ37YXJSik3YXpSdYk9ZndtyVtGL7kneXPFr4it5Kp/WMc?=
 =?iso-8859-2?Q?HGLchHTHmA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a2fdd4-5a39-42c2-a68d-08d9ea49e63c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 14:55:36.4788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSWAFk4Ge18986oNmlfD3Z8PrzEFR7+1lqgLxqK0xGCdosUHeD1akpcLgX9eRG1Mgr10m+3uW7+NYkMra0z93DoDl5IwAPAcJ8ZVj0S4vrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4439
X-Proofpoint-ORIG-GUID: ItjAAZ8X3E8Inr4gOimlIHG2bOF5nnzm
X-Proofpoint-GUID: ItjAAZ8X3E8Inr4gOimlIHG2bOF5nnzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_05,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202070096
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Sent: Monday, February 7, 2022 3:06 PM
> To: jic23@kernel.org; robh+dt@kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Subject: [PATCH v6 3/4] Documentation:ABI:testing:admv1014: add ABI docs
>=20
> Add documentation for the use of the Digital Attenuator gain.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Forgot to add in v6:
Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> no changes in v6.
>  Documentation/ABI/testing/sysfs-bus-iio       |  1 +
>  .../testing/sysfs-bus-iio-frequency-admv1014  | 23 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-
> admv1014
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> b/Documentation/ABI/testing/sysfs-bus-iio
> index c551301b33f1..2b5770017a84 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -476,6 +476,7 @@ What:
> 	/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> new file mode 100644
> index 000000000000..395010a0ef8b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> @@ -0,0 +1,23 @@
> +What:
> 	/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_coarse
> +KernelVersion: 5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_I) with
> coarse steps.
> +
> +What:
> 	/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibscale_coarse
> +KernelVersion: 5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_Q) with
> coarse steps.
> +
> +What:
> 	/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_fine
> +KernelVersion: 5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_I) with
> fine steps.
> +
> +What:
> 	/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibscale_fine
> +KernelVersion: 5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_Q) with
> fine steps.
> --
> 2.35.1

