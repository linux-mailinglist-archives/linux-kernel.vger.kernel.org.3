Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD24E8F42
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiC1HrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiC1HrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:47:12 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3230252E29
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:45:32 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S75ird013297;
        Mon, 28 Mar 2022 03:45:09 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3f1vp6ccta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 03:45:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvKiO74LNsa+7qd0YudJeTvqkUM+q9fy8HoROhXKrYWmEsmqPWSLEf//grEu3us9Rw24HaBMUjuKlEdvaqSUOgf+N7MOJ9jtoBdqStxrz6p2pds/xyEPo5AtDh1TpMHblvHOco9B0zP2vNxylnXRmA1AQ45NMPL/12Rny0WK2nbwy1rIwgvsKiDrdwZcfUc520Qsh4bPlrQCskRKjlj9ImnmMQL4OfIPxk7zi6FAmFQMLDEL95kIZOfHM3Y8IJ4JBmP7ycz6xXXZmQBLkLP9X12w3uxLpzpv/s0fkMxfZHrJA6KrNy6TAwTUvN4gHkoITSx2qb9Eb1xPYM4HsYNO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNMBWDbYusd+gYobR/u50rUawuiUzi4q1jLbXB+TMJ8=;
 b=Y4v2VS31sK86GVBjPQ8mquW8ldi1WlWSV/pC8QwJ0mX9FxGx+MmMxjpP9o+yXErTUX3YMTLBn52eu4NGk5bnzbXBRaYj8QW0T9xfBfGQYckaEAkJCn+8Ofps/k9BHAhVfjuzxeSbFaRKjNHF3SJ1P5Pu0iBtzNOy87bPll3IgeZb063yO2AsXSIAerM0ttm8alaodyB6JzhzdiMxL0Lt4/4LzelCCold/Pzba6rlkZfjhWoyYeYvJ4dSTG3fLm+yMBfcu2gLv0zjRwTi9AnDcsT3KnsGFpm1iA5+ux94X6GWUSd6st6LMwyE1U5HKSkyNFW/8DMs3j5jK8PLDRw3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNMBWDbYusd+gYobR/u50rUawuiUzi4q1jLbXB+TMJ8=;
 b=XmEgPtGlgwoKpF8CYMF1TjLMEsWeDfddFTIgiTuV8TFhHbMLalYSX9AMiMxoQwUx5epcTmm8zvfYM2dpu8fFlwDU2IVNemOGf9VNPkhCSIwtAIHglSmKiySOJ3GfmnKxsKLwkEsK+R9/m+F6y+aNuyE5r073eVgvXhRqyKKpFvc=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DM5PR03MB2777.namprd03.prod.outlook.com (2603:10b6:3:3f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 07:45:07 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97%2]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 07:45:07 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Stephen Kitt <steve@sk2.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Wolfram Sang <wsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: ada*, ssm*: use simple i2c probe function
Thread-Topic: [PATCH] ASoC: ada*, ssm*: use simple i2c probe function
Thread-Index: AQHYQGg3+QHZtdB320GP4uLrqKukcazUbnyQ
Date:   Mon, 28 Mar 2022 07:45:07 +0000
Message-ID: <PH0PR03MB67869E32589AB628CBA3DCE6991D9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220325164828.1209201-1-steve@sk2.org>
In-Reply-To: <20220325164828.1209201-1-steve@sk2.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZmE4NTdhZjMtYWU2YS0xMWVjLThiZDMtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XGZhODU3YWY1LWFlNmEtMTFlYy04YmQzLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iODkyIiB0PSIxMzI5MjkyNzEwND?=
 =?iso-8859-1?Q?Q1NjQ4NTkiIGg9Ii9BMzhSa3FNdmdCZU1EVkhBUFZqV0Z4dzVqWT0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBQjc1OXk4ZDBMWUFmQzEvUVh5L2s0ZDhMWDlCZkwrVGgwREFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRB?=
 =?iso-8859-1?Q?QUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQm?=
 =?iso-8859-1?Q?xBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdr?=
 =?iso-8859-1?Q?QWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWk?=
 =?iso-8859-1?Q?FCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?iso-8859-1?Q?SE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdC?=
 =?iso-8859-1?Q?ekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSF?=
 =?iso-8859-1?Q?FBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 243d9c6e-d2e9-47c3-41f9-08da108ee0f4
x-ms-traffictypediagnostic: DM5PR03MB2777:EE_
x-microsoft-antispam-prvs: <DM5PR03MB2777B706C1EBA803D0421374991D9@DM5PR03MB2777.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /9bNhWoiv50SBB80khgkDqsRfCTE1ZDS45R37GH/XL/9mORSbIgKJP6I9DnMu1M/FvEGZ1SWfKp/n/HmA3HW0Bvo3sd5fgIluGWaz8kPVEwCUjBhuKAhXk8onO2LRWfWXnlHOuwj05TJyMy9lsSyb/DnmlF8SKr7zWUWwY7WqUrXmiwVVPTNU2IYy96VmLIEzJ0YT/qlxMHD2JBgS9/ObLgp7RZjuMIgVGyt2NVovIdk4zTum12vGnv/uowxUTgtU6T1d4aXskM8lzdRTWc5TFCpcw0Dom7X7SHT08fYE6fe4t96VX+K6zyejegaJRncvRCgnzREJTfWy8+WUqwCggmTLXb/coWt1O4A4G6qy2UTdRtsvUT0mD9Os8Gvk5yySFVI2ECB8bBch7wTR4QpkXrew16XwGAHzU3tD65YZbBSSscW+9TIYcgmo3oUU5n0XppjPcmAb3c66HQBUf6v1wL98sqnQ2wIadSFaEhUorLLdmClFjlv4/W3dbKsX38SN0Z7STyutlfeFoDWc+FvWYp7AqLYpy7bpyIaKwh65Ano2wA3VHtvs/ZzhL1ni5R/JjTInJtlrpZ0lybzQezTulqgT1Wq/ey/tXgkskyokpDkt2BMjX1Ci9lkRY712B/0jluk93h8Mb1IVu9RCXd5hC/d0Vc8Pf6g4JYfnKtVxbZ6Hk50cP9Cte7TyraGyF4PXO/r5n9hrh/cXKMF/xmeYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(316002)(110136005)(53546011)(4326008)(66476007)(66446008)(122000001)(26005)(86362001)(186003)(38070700005)(83380400001)(54906003)(6506007)(508600001)(9686003)(4744005)(2906002)(33656002)(8936002)(38100700002)(64756008)(8676002)(52536014)(55016003)(66946007)(76116006)(66556008)(5660300002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oQ2T2rAY8OohPNfl8EYHPz2GXXXC6mF/7MEcR1V/Y3DDenFj6Xye0F9c7Y?=
 =?iso-8859-1?Q?zIhNTSnA+jBpvNu/cKrmMCCmuOyZsfdNm5V7uQ8R3T3QcpSpauNP3hR1Rs?=
 =?iso-8859-1?Q?zdrVeCq97Mh/jTNq5Skw12in18cLLQZnnNIryFMbVixtmSvC1SqFH1UhKt?=
 =?iso-8859-1?Q?wpRjJFJHa8BGHskizZK1SgsJaeivoRRn+FBoLvZk6bc69+CDIvVy2IyxKJ?=
 =?iso-8859-1?Q?PPm5j8sU+yg1DIB15IoPZazhslZvuSk7eGZvCSrSqXTPHrsIvHFWMez99m?=
 =?iso-8859-1?Q?YM9x0p2b1wVeRGTHV6OQC5dgMdyMv/xwj34vpFO/r/zc3MsR7HRjvfOTjb?=
 =?iso-8859-1?Q?vJaiPpyjxt2DG7H92uomLu0MPk2WGtRVv3QQaGVlVyECynk1ltNEvt0d39?=
 =?iso-8859-1?Q?5Hz8trojknthXaIvmFg4HxfQqetql/7vO6cOKnl6F0gzml4CSuIkTcjbhy?=
 =?iso-8859-1?Q?jv5qHIegbwIclthB/lCahQdW9B2jJOwHzB2Rt9pOk1eyiOPXNtRgBgcAsq?=
 =?iso-8859-1?Q?6GGj7nF9fh/xHZmftzdw6Ik8qfXS7Ix0bCm5dTmTH+amsyTu+tpqnk7wxx?=
 =?iso-8859-1?Q?B8hWLL5Y9rl1HSQ1SHDDqG7EH+ru7DcQ+p8/1sWnJ07ixBd3kC3XfOQyO+?=
 =?iso-8859-1?Q?qhMD+ZL//7d3Y1ykBqbw1JUUzetwL4dopGBWZfI+hI0a3rEc9E8hu/hBNU?=
 =?iso-8859-1?Q?n1CWPr0hFq9Zv4bIiV+aPSXY8t2y6+GPgMw0pxZlHUciFZ+rWwI9q38Jly?=
 =?iso-8859-1?Q?I972KJpedCXBFyPWi09y/3WPrnX51dR6pnlpXfHejI1MxMgNuZ5lRXNk75?=
 =?iso-8859-1?Q?ugmxo/lRTC0bgmVxEcz5ahsoHpfcpqNCNUthN0Der+NbHEY+SqFY3h+ctZ?=
 =?iso-8859-1?Q?8eiEW3CA+NDlK74x6U7uGRKRg35RZmGjVrGzFv/Sd7jSOjabXM5Ay5w67J?=
 =?iso-8859-1?Q?0eMZVIgbLOIakl8c3RQz0hshgZlqlNyqB7S79biE+ei7h7oN8gaBg/1THg?=
 =?iso-8859-1?Q?nWe96+XqWQ4R/F442i0qa26a1boiELPagXYYX01WyWUBZ3MzD29sJjJeak?=
 =?iso-8859-1?Q?q80SU870mpzYZd8e5H67zbhCceHsU/OXQDaisL6AbRhHPaVTB4i7nYbh38?=
 =?iso-8859-1?Q?SnzcHH94AFjmTa6ySWN6Jl3sRKHh38dDzvDFhqovjP3T2jyllI/bkzNEkt?=
 =?iso-8859-1?Q?PAl2kqkbE9lD9Kzhb5aB8LYmJPtc/pTVitFrSbkZ4e9jf+Be/n+nQin5Z0?=
 =?iso-8859-1?Q?LWZfGEGb8NvR6AZ/iaKRvhrhWs0NApWLbFxJcBZbMNadj8hfRdPuKq6Xq6?=
 =?iso-8859-1?Q?tI8rCa8A+ggVu523DaqKsOWo0f3wWg08hikEWAwFbPegXz5zQ/6FrugaBt?=
 =?iso-8859-1?Q?W6ec7UbeSSSYY0Un5PEItu5fu6eG71JjC1AA7aeQ8XEQ0KsVvvjjlwvgqN?=
 =?iso-8859-1?Q?64mCKOq1JxVO+RCbFWzTfv70hkfJHQQ23aC0su5nSlFUKNa45dYI+6wMIo?=
 =?iso-8859-1?Q?OXwinMVQdnRkDcR5X9rva7JuLa2DePx1n22W0YiN0GslOoKlKgIBCGGnWI?=
 =?iso-8859-1?Q?Gr7HA4KdqJFreBZGBaGgqOaLsWKS0xWGWYfa5M71Xr94QaKEO+ICEIWcWB?=
 =?iso-8859-1?Q?j1cHAW2tTKgiP6W+6k6ZGzdm908v2Tua1thmRHLpIBMDFK2FB1DngHwIAV?=
 =?iso-8859-1?Q?GwV5q8C/v4/BwRa6ATRqSbvqm1NqMZJwChU4olL7N1sf/FKPa5dxTy8M6z?=
 =?iso-8859-1?Q?Qw5bHab49ETf+h9F4zhyCCr8Bp/1FLcYEMxOE5XWMBycACABQcUD2SqnUl?=
 =?iso-8859-1?Q?KQ1bL4a6Og=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243d9c6e-d2e9-47c3-41f9-08da108ee0f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 07:45:07.0601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Fb04nc36RvQZs0jzAtOU8ZCJx+BRzk+wooK5GAp4eFmbblAkoGzUSsgZcbngBP+6/89tWFbN8xsaEa/21rRbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2777
X-Proofpoint-GUID: 4IZmBmrA7FYNGzqRaKkaZjTNAocxv4E8
X-Proofpoint-ORIG-GUID: 4IZmBmrA7FYNGzqRaKkaZjTNAocxv4E8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-28_02,2022-03-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=643 spamscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203280044
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Kitt <steve@sk2.org>
> Sent: Friday, March 25, 2022 5:48 PM
> To: Lars-Peter Clausen <lars@metafoo.de>; Sa, Nuno
> <Nuno.Sa@analog.com>; Liam Girdwood <lgirdwood@gmail.com>;
> Mark Brown <broonie@kernel.org>
> Cc: Wolfram Sang <wsa@kernel.org>; linux-kernel@vger.kernel.org;
> Stephen Kitt <steve@sk2.org>
> Subject: [PATCH] ASoC: ada*, ssm*: use simple i2c probe function
>=20
> [External]
>=20
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

