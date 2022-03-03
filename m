Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD54CBEEA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiCCNdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiCCNdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:33:05 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B36188A22;
        Thu,  3 Mar 2022 05:32:20 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2235UN8T019082;
        Thu, 3 Mar 2022 08:32:00 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ej1u1yqmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 08:31:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiBVsbLjzZc6o71Nlz1ZLngmfW+yxwvJ4jxJasFaKCa8l14/H4CM/fWqUQAEIdTn43eDVGRTiLgITji+iFGLcO8o5RnkhNHhXrDY/1DWWqufpntkz1L9oz3cgVF1mSVmLvMdffVgr2iexp7X+UN6OSFHtkLWZDSoT2Y4SA7Am5I1xcvXICyulR+1OTQZNXZDXJw1aQp7xcUgZ6nH4VnNIWnaG3UKna+N8I19XS6gTTiT0bNXelPFRvWRvamHi9FpS0rSeBKjb/DpM7fqQ9dcqs/A6OiQ5h7lGGu8u1R+SvB4aoww7rpWyFzE2/7YBUyc7dEonIHJhI4bNhZjMC+bSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViVDzmhPidtn9sfO1QWWqnBsqj5l/DTtrAD4brNY0fg=;
 b=QaA8OYZAALjNEDyNpg5Nn0V+qSvfBYKAJGxUFJcfj+BSmrUAEb3sghK0iqsDDiDc52B39BXjh37kjpVo2jDmI/TVqnRUWWjKrdXVRWmDrrIBKa6iK5CUnyheERZM7bl1gAcyNMUoKa6PjkNrtoPEq6ch+W2vHZvkpS5sNrhkw6pfjoSxTa6p9Y3JMMgMjjxmDle1Ha5np8yVoDmvPtNBSURbcjYYRh5TfEfB5pfbaEFD949p6Qm+uj8X95A8Ld14uVfYySJDyzHxahFVobEIvD04v6noYhVxfbzkgSA2fYPA0hPBYQavl70KZB3NDLomw2ZlJ0ZSd4OBg688sLm9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViVDzmhPidtn9sfO1QWWqnBsqj5l/DTtrAD4brNY0fg=;
 b=AGs9o6uQLEU0wYAYOrjLWSBzHcJEgbIbO34HiTROxrzAkcLXYBHBgUSbxJFgpFxEPB+OQSZ8B5NiPT84csG+rJWq/f968BAmUX11MjkCszP2pT6v7bu11bEWDmhZHi8ZsitMQR0Yda8ZVqVmUTfcwsVKxxxHqsrDsWwsGSrIqWc=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by CH0PR03MB6116.namprd03.prod.outlook.com (2603:10b6:610:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 3 Mar
 2022 13:31:57 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794%5]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 13:31:57 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v3 3/3] iio: temperature: ltc2983: Make use of device
 properties
Thread-Topic: [PATCH v3 3/3] iio: temperature: ltc2983: Make use of device
 properties
Thread-Index: AQHYHoXV68rIrkrTnkK2YIykAkr2haytxoqw
Date:   Thu, 3 Mar 2022 13:31:56 +0000
Message-ID: <PH0PR03MB6786304A458CD4B11AF5C42699049@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
 <20220210135522.26562-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220210135522.26562-3-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNDlmM2RiMmQtOWFmNi0xMWVjLThiYzctZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDQ5ZjNkYjJmLTlhZjYtMTFlYy04YmM3LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iODgwMCIgdD0iMTMyOTA3ODc5MT?=
 =?iso-8859-1?Q?Q1MDkzNjM1IiBoPSJBSCtJaXgzOFo3MVNWak0zaUNiQjZjSDkvSFE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUFET2tzTUF5L1lBZnhJUWUxTFJ3S0EvRWhCN1V0SEFvQURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62808b92-767a-4ba5-07f4-08d9fd1a3041
x-ms-traffictypediagnostic: CH0PR03MB6116:EE_
x-microsoft-antispam-prvs: <CH0PR03MB611647CF7B5DD7BF592EEB1F99049@CH0PR03MB6116.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7oBeFv+9tR7v2yCuhEJ4klw9fRE+xeIyOFSAkq4UWagB8jT8H8RY4op9fp3eEO796UQvfdsNXbFUfUgq7t0z3t+zHoQ8CHDsFAPYFzPbfkEyQG0h7LiGRX5m4t/b70tQtQQw6tIzGUpC4zyjVFay6PuaWF9KbI87G0KAVKavvDAv/j0G6w+uZB5hkcbonc9lc7PJGTRscOhuB+d9H4FfxNACBCjR3sVdJ4qsBccI6UkTvZRVclbAvCV3LmF8BrHvBXV/mCGR0CSANRnrxRG1RlxjbIvsdxZ2Ae3ID0pVoCcGhkEx2JKkZKAwfZn/kT2pSy0m2HjgjNaDpxe9tfNAjLs7niJXKsKBefNWKm5H2yjkuoRdxBMLj7jJWH4efdChmj4rNpy4GwN5uFUbSKWqW0nNBWHYvfMwUrzdyVJ/KgD2SzD/Zry3I6d0fQ2DMSlsk2j/HJfCw0EQZsGf+HiwAVZ+6Nf7CcSbLhQmyFUu2+XCo/C38rgchuQlK5ueeZQUBOrK1t2wYuRAZJ1rX5Af7GyQn+ekSBw9bX4/WqxE0IR+KEez1B0Z3iZGo/LSNtyoYIzQYZ3pgsP0v2faPUT9eO7f4qTHFOhpaw/HxtAkqdKOW/1wR9gOIxHSd1mDcSupc8pwP5GJXZPR0FbiieJz5L/FXwef9b7F1rbcDV5T2MudNSmSctekj/oCsFhOJjX9nX0Dx2ELoZ4ec0SdMy7GA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(33656002)(2906002)(83380400001)(8936002)(53546011)(6506007)(86362001)(7696005)(9686003)(5660300002)(26005)(186003)(52536014)(71200400001)(38100700002)(55016003)(110136005)(54906003)(122000001)(64756008)(66476007)(66446008)(66946007)(8676002)(4326008)(66556008)(38070700005)(76116006)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E82TwAFAkwkRtPX33WsXAxHO7C5VmCvFJKok/fb6Ttb0HlEt8Hz66jBYk6?=
 =?iso-8859-1?Q?4+e0++jn0yl2+WwzxOqzrLlc6JbBzB+SdGl4CyFcQWhg59FnD/mYXzdfA+?=
 =?iso-8859-1?Q?KyqiZkipfJrpAMPMM6FEwnzHZM1/v5zQAme1xx3hVbwOAJIL6oryc/ka4p?=
 =?iso-8859-1?Q?rB+d1Yaym+T4vafjj4bb3z9O6MnFhyqt3i6L+CIxXh3jnvU+rtzujZ9SPw?=
 =?iso-8859-1?Q?8E1pjv/NYE+XKyNjMMPcxdVQCMYK2fDMnqrws/glTH5MGESzOifHdm3Pjt?=
 =?iso-8859-1?Q?BDG1uLIrn0Y2zUJIZEtg8wDcFtprIC9zumwL3Zc7/9vp6c5Pc4hO9UNtgV?=
 =?iso-8859-1?Q?2xbv0B1CoiNaK940zrTciFvIwaS9n1IhqrtMEUYoCRdBs6mZ6S31N5BmkY?=
 =?iso-8859-1?Q?ao41Cg3iSza9Wnj1elZWHlmhbnsKfb9RbkvO1TlbdkyJoQnWm6utM4lVgT?=
 =?iso-8859-1?Q?Jx2WCvAgHMocgtPrhfTRNQJ/ZyK35ndpAGp40l8+zSAoimpPqxqqFFYC7a?=
 =?iso-8859-1?Q?dgSTOFzyTSaTwg4akHqb6a+1ULmPxpwFI43iMWChokx6WscNQYcZfn7jHT?=
 =?iso-8859-1?Q?Gv0+DqLgGnch6m+fSeVxyJa/OLOiAwVUUuXv+Mx6/HDY8uwQG8F52PG/0n?=
 =?iso-8859-1?Q?QvuyeIKrTZFnuA/0OKBY606dJUlS+SGB6/bymTiCr/JQYHZ7MngNq3jkaM?=
 =?iso-8859-1?Q?ULAFLbfxYctfQkmE7s8ykNBTI5OaTrns6O63BQTL/dXnqbVJQNESiKA9cF?=
 =?iso-8859-1?Q?V6rFnxE8qv1Jv3oNrJ5C633j6H9Ctk8PQeP63eXrtd5lHgJ/t4jpxa2v6w?=
 =?iso-8859-1?Q?6nyXTqFsTNfUoOTxwMQbK+GbRN9iK5CKkJPwrhd3E8xHooO+GPArasqH00?=
 =?iso-8859-1?Q?JMxm+PMTmhHydhu/lxpQt2Xm9akSVbPmpD1+jPykkqDNKaeyjRU3MehwzH?=
 =?iso-8859-1?Q?bStvCAcTfC1AqCrc0sIzx8jrU9lvVBoBxN477+7XeOh4AraBaNi8AlMFg5?=
 =?iso-8859-1?Q?eP5Exij1ULGPOUgJKGx8wBJj4YimJ7g8eoksjxNjtX37MQbWmbDBy/SlG4?=
 =?iso-8859-1?Q?dW+gfZMQGEKD70pWtkoSpROq9saZ8r9xQhEHETcRQ10R1AbQiFGPTRnver?=
 =?iso-8859-1?Q?aZ/nFrCNVedvxxfe4iUvUZ/mJvrXjOVL7JXZsHfaNVu4SATVcMHVLgO+fT?=
 =?iso-8859-1?Q?YhhWoqHrLbim66u9abNmoA5OlHoGjOBCYrTwSH7p2o34YVnoiYzgOSURnV?=
 =?iso-8859-1?Q?vYQP+9rGKoJiq5G6i/OfiSbNYqp8F28s5FilREBsqu+HdlrRyACVXaS2GI?=
 =?iso-8859-1?Q?Al0v87OlTnaR2Ozjip9bSgFO9f6GpWlYU/AFnG7aA9HuPcM+6aGI0Clp3r?=
 =?iso-8859-1?Q?/ZvBlAqgx7TDrET37xeeRnM9D/NTMcx9+1yH13og+vc+ECC+7DYunqrGY7?=
 =?iso-8859-1?Q?7lgpW8hWM/jTTMwXbFF2cS2FxapNGLZoQnL7fyH2OXGQkw9ygSLyeGihmh?=
 =?iso-8859-1?Q?dtFoshsCZTP7IpJkkckiX4WS/obI0ekORbJ+VG8H8f2xrAEhYxfLFzKljS?=
 =?iso-8859-1?Q?p5lDpOu5/YQ+DMHbidiAChV1kHuaFhhDpVdUbLjLmjOO5IeOnuMM8LhYeN?=
 =?iso-8859-1?Q?8If2NVI3o2RQspOxIROOYDLoyRrR/gB7akADBwueKXYiqos9ARZEiaFA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62808b92-767a-4ba5-07f4-08d9fd1a3041
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 13:31:56.8931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7VOlY1K4MrPyg2DDyWAUJyfJ5ooPk42v7fuUgLHUIJcDIgPCvhOjdTepK2ovwPMGuJr96kVMLhHgcFTzY+vAKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6116
X-Proofpoint-GUID: PMKtFni_BCkCj_TbSCdQPOGBLyPfS-2b
X-Proofpoint-ORIG-GUID: PMKtFni_BCkCj_TbSCdQPOGBLyPfS-2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 suspectscore=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030063
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Good that we waited to test this patch. The fundamental logic change
for fetching and writing the custom tables are fine. That said, there
some issues that I had to fix to test the patch. See below...

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, February 10, 2022 2:55 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>
> Subject: [PATCH v3 3/3] iio: temperature: ltc2983: Make use of device
> properties
>=20
> [External]
>=20
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>=20
> The conversion slightly changes the logic behind property reading for
> the configuration values. Original code allocates just as much memory
> as needed. Then for each separate 32- or 64-bit value it reads it from
> the property and converts to a raw one which will be fed to the sensor.
> In the new code we allocate the amount of memory needed to
> retrieve all
> values at once from the property and then convert them as required.
>=20
> Signed-off-by: Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>
> ---
> v3: no changes
>  drivers/iio/temperature/ltc2983.c | 203 +++++++++++++++-------------
> --
>  1 file changed, 102 insertions(+), 101 deletions(-)
>=20
> diff --git a/drivers/iio/temperature/ltc2983.c
> b/drivers/iio/temperature/ltc2983.c
> index 636bbc9011b9..d20f957ca0d9 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -12,11 +12,15 @@
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
>  #include <linux/list.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>=20
> +#include <asm/byteorder.h>
> +#include <asm/unaligned.h>
> +
>  /* register map */
>  #define LTC2983_STATUS_REG			0x0000
>  #define LTC2983_TEMP_RES_START_REG		0x0010
> @@ -219,7 +223,7 @@ struct ltc2983_sensor {
>=20
>  struct ltc2983_custom_sensor {
>  	/* raw table sensor data */
> -	u8 *table;
> +	void *table;
>  	size_t size;
>  	/* address offset */
>  	s8 offset;
> @@ -377,25 +381,25 @@ static int
> __ltc2983_chan_custom_sensor_assign(struct ltc2983_data *st,
>  	return regmap_bulk_write(st->regmap, reg, custom->table,
> custom->size);
>  }
>=20
> -static struct ltc2983_custom_sensor
> *__ltc2983_custom_sensor_new(
> -						struct ltc2983_data *st,
> -						const struct
> device_node *np,
> -						const char *propname,
> -						const bool is_steinhart,
> -						const u32 resolution,
> -						const bool has_signed)
> +static struct ltc2983_custom_sensor *
> +__ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct
> fwnode_handle *fn,
> +			    const char *propname, const bool
> is_steinhart,
> +			    const u32 resolution, const bool has_signed)
>  {
>  	struct ltc2983_custom_sensor *new_custom;
> -	u8 index, n_entries, tbl =3D 0;
>  	struct device *dev =3D &st->spi->dev;
>  	/*
>  	 * For custom steinhart, the full u32 is taken. For all the others
>  	 * the MSB is discarded.
>  	 */
>  	const u8 n_size =3D is_steinhart ? 4 : 3;
> -	const u8 e_size =3D is_steinhart ? sizeof(u32) : sizeof(u64);
> +	u8 index, n_entries;
> +	int ret;
>=20
> -	n_entries =3D of_property_count_elems_of_size(np, propname,
> e_size);
> +	if (is_steinhart)
> +		n_entries =3D fwnode_property_count_u32(fn,
> propname);
> +	else
> +		n_entries =3D fwnode_property_count_u64(fn,
> propname);
>  	/* n_entries must be an even number */
>  	if (!n_entries || (n_entries % 2) !=3D 0) {
>  		dev_err(dev, "Number of entries either 0 or not
> even\n");
> @@ -423,21 +427,33 @@ static struct ltc2983_custom_sensor
> *__ltc2983_custom_sensor_new(
>  	}
>=20
>  	/* allocate the table */
> -	new_custom->table =3D devm_kzalloc(dev, new_custom->size,
> GFP_KERNEL);
> +	if (is_steinhart)
> +		new_custom->table =3D devm_kcalloc(dev, n_entries,
> sizeof(u32), GFP_KERNEL);
> +	else
> +		new_custom->table =3D devm_kcalloc(dev, n_entries,
> sizeof(u64), GFP_KERNEL);
>  	if (!new_custom->table)
>  		return ERR_PTR(-ENOMEM);
>=20
> -	for (index =3D 0; index < n_entries; index++) {
> -		u64 temp =3D 0, j;
> -		/*
> -		 * Steinhart sensors are configured with raw values in
> the
> -		 * devicetree. For the other sensors we must convert
> the
> -		 * value to raw. The odd index's correspond to
> temperarures
> -		 * and always have 1/1024 of resolution. Temperatures
> also
> -		 * come in kelvin, so signed values is not possible
> -		 */
> -		if (!is_steinhart) {
> -			of_property_read_u64_index(np, propname,
> index, &temp);
> +	/*
> +	 * Steinhart sensors are configured with raw values in the
> firmware
> +	 * node. For the other sensors we must convert the value to
> raw.
> +	 * The odd index's correspond to temperatures and always
> have 1/1024
> +	 * of resolution. Temperatures also come in Kelvin, so signed
> values
> +	 * are not possible.
> +	 */
> +	if (is_steinhart) {
> +		ret =3D fwnode_property_read_u32_array(fn,
> propname, new_custom->table, n_entries);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +
> +		cpu_to_be32_array(new_custom->table,
> new_custom->table, n_entries);
> +	} else {
> +		ret =3D fwnode_property_read_u64_array(fn,
> propname, new_custom->table, n_entries);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +
> +		for (index =3D 0; index < n_entries; index++) {
> +			u64 temp =3D ((u64 *)new_custom-
> >table)[index];
>=20
>  			if ((index % 2) !=3D 0)
>  				temp =3D __convert_to_raw(temp, 1024);
> @@ -445,16 +461,9 @@ static struct ltc2983_custom_sensor
> *__ltc2983_custom_sensor_new(
>  				temp =3D __convert_to_raw_sign(temp,
> resolution);
>  			else
>  				temp =3D __convert_to_raw(temp,
> resolution);
> -		} else {
> -			u32 t32;
>=20
> -			of_property_read_u32_index(np, propname,
> index, &t32);
> -			temp =3D t32;
> +			put_unaligned_be24(temp, new_custom-
> >table + index * 3);
>  		}
> -
> -		for (j =3D 0; j < n_size; j++)
> -			new_custom->table[tbl++] =3D
> -				temp >> (8 * (n_size - j - 1));
>  	}
>=20
>  	new_custom->is_steinhart =3D is_steinhart;
> @@ -597,13 +606,12 @@ static int ltc2983_adc_assign_chan(struct
> ltc2983_data *st,
>  	return __ltc2983_chan_assign_common(st, sensor, chan_val);
>  }
>=20
> -static struct ltc2983_sensor *ltc2983_thermocouple_new(
> -					const struct device_node *child,
> -					struct ltc2983_data *st,
> -					const struct ltc2983_sensor
> *sensor)
> +static struct ltc2983_sensor *
> +ltc2983_thermocouple_new(const struct fwnode_handle *child,
> struct ltc2983_data *st,
> +			 const struct ltc2983_sensor *sensor)
>  {
>  	struct ltc2983_thermocouple *thermo;
> -	struct device_node *phandle;
> +	struct fwnode_handle *ref;
>  	u32 oc_current;
>  	int ret;
>=20
> @@ -611,11 +619,10 @@ static struct ltc2983_sensor
> *ltc2983_thermocouple_new(
>  	if (!thermo)
>  		return ERR_PTR(-ENOMEM);
>=20
> -	if (of_property_read_bool(child, "adi,single-ended"))
> +	if (fwnode_property_read_bool(child, "adi,single-ended"))
>  		thermo->sensor_config =3D
> LTC2983_THERMOCOUPLE_SGL(1);
>=20
> -	ret =3D of_property_read_u32(child, "adi,sensor-oc-current-
> microamp",
> -				   &oc_current);
> +	ret =3D fwnode_property_read_u32(child, "adi,sensor-oc-
> current-microamp", &oc_current);
>  	if (!ret) {
>  		switch (oc_current) {
>  		case 10:
> @@ -651,10 +658,9 @@ static struct ltc2983_sensor
> *ltc2983_thermocouple_new(
>  		return ERR_PTR(-EINVAL);
>  	}
>=20
> -	phandle =3D of_parse_phandle(child, "adi,cold-junction-handle",
> 0);
> -	if (phandle) {
> -		ret =3D of_property_read_u32(phandle, "reg",
> -					   &thermo-
> >cold_junction_chan);
> +	ref =3D fwnode_find_reference(child, "adi,cold-junction-
> handle", 0);
> +	if (ref) {

This is nok. It needs to be 'if (IS_ERR(ref))'. We then should return
ERR_CAST() in case of errors inside the if block. As this reference
is also optional, we need to nullify ref in case we don't find the
it. Otherwise fwnode_handle_put() breaks.

We also need to use ptr error logic in the other places where
fwnode_find_reference() is used. Although, in the other cases
the ref is mandatory, so there's no need to care with breaking
fwnode_handle_put().

After these changes (I think the changes are straight enough;
but I can re-test if you or Jonathan ask for it):

Tested-by: Nuno S=E1 <nuno.sa@analog.com>

