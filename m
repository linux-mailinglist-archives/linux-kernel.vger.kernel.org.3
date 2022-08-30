Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D11E5A6217
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiH3Lhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiH3Lhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:37:31 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76207153D10;
        Tue, 30 Aug 2022 04:35:57 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UAdOve025958;
        Tue, 30 Aug 2022 07:34:29 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j7g67anwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 07:34:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClBu52gFMNrEgJ0CyFyGp74YqPu4Bjr3lPKVoRx4i2+u0Rtj1RJA6Q2bVaQPYlNtosgSLyFCFgor/5hWoKSRrrXKwElhZZIyQuupJk9y1yYVLTGuTYSKTNz7qig4Ue8+NhOau1wvV4YWQQYWMO6WHhuG+IserAWGGQI5GYeC6Ieb4mhvWL1IuO0/Kom5/cAZiLGFgzr1mKlKR88OQDHoGCzN0CtpF8eLr6LeNIwHb96Wyb/4YeH/7vJImnGOLQIrv2UiePMXyc4zIj35G7xu7dFJfRdgybVsdcf0b7T2kx3b13drTF3Jxw4xokawOrc5uXi/+/6ECthqBuNXHbaOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jM85vW1hMN0ttDZBQMYpoAf/18EO1HCE8Am3gddrQ8=;
 b=Oxm31GX5nLjXT6oiwEqkLz44zn2hiEpVFdjHmmRIuWwns+FwXeQt1DRwPTW1vKMga0bVrhaNlDrMtdWkKgwjBQVfoeifD4CwmsAJM3sju0ad9DqDl76ixDqAYd1sMwW3VjFh0TrGSVSO9hnYBAPrKgixu9jdzr3Ut7Sfs1fewzNIOSfvlzQtM4SO+SRnnK+/+c50PpDdaQ7wBiOwlI4FmyeZaY7HRsPY8hCYurNGP3gqvyFcdSXPzszg2UyzZBqdzGlOxyT8EXj9d0L1kwq7u1Oo8HDxpUEEsUdOwMOnssrN7Z7tinVPtpmFXZnqVsrPejOjTLlRjwCN7K9FC0FxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jM85vW1hMN0ttDZBQMYpoAf/18EO1HCE8Am3gddrQ8=;
 b=UmuN5Tf5J/IVYD3jWHqA+LsUv7aWvc2OeY3UNDhRwVvZMm3LoDSE4IlMBmfoHI+LGyzYtsnLlslr9usgCtNGkWes8x3OAkd33PrDu6VNSDdvtry82fwCEigvxewxIoXxZBQhnYh7aZg4YFwK0q3NjkfNmDywUPgvZkaCAzgiMmE=
Received: from SN4PR03MB6784.namprd03.prod.outlook.com (2603:10b6:806:217::17)
 by SA1PR03MB6372.namprd03.prod.outlook.com (2603:10b6:806:1b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 11:34:27 +0000
Received: from SN4PR03MB6784.namprd03.prod.outlook.com
 ([fe80::6c7f:65b9:118c:7cbe]) by SN4PR03MB6784.namprd03.prod.outlook.com
 ([fe80::6c7f:65b9:118c:7cbe%3]) with mapi id 15.20.5566.016; Tue, 30 Aug 2022
 11:34:27 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 07/14] iio: ltc2688: Simplify using
 devm_regulator_*get_enable()
Thread-Topic: [PATCH v3 07/14] iio: ltc2688: Simplify using
 devm_regulator_*get_enable()
Thread-Index: AQHYtACfhZMnLhQ7Ekqxj77M9Mars63HX3jw
Date:   Tue, 30 Aug 2022 11:34:26 +0000
Message-ID: <SN4PR03MB6784F7C3B98332410CC97F0499799@SN4PR03MB6784.namprd03.prod.outlook.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
In-Reply-To: <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYjI2MWM5YmMtMjg1Ny0xMWVkLThiZmItZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGIyNjFjOWJkLTI4NTctMTFlZC04YmZiLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iOTczIiB0PSIxMzMwNjMzMjg2NT?=
 =?iso-8859-1?Q?AyODc2OTUiIGg9ImttN3VnVUIwV0dIRlU5NVBqYzg2aTFObWFQcz0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBQlAydFIwWkx6WUFmRW1xMkRYRVhEdThTYXJZTmNSY080REFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBSnJqSklRQUFBQUFBQUFBQUFBQUFBSjRB?=
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
x-ms-office365-filtering-correlation-id: 22dfec3e-0c7e-4291-14cb-08da8a7b987f
x-ms-traffictypediagnostic: SA1PR03MB6372:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5+PO+pkNVQ6XPNjad9ZTDF6hnZmRL4Rf5cjeHspsHdvpTiV+xazMjAIRP/Lw5fLK8w3F+erG6K7Q7+N7cIrxwm+j3Frl0DkN68fw/hgg17h+krZMIsy8aE4JGY8zIsoESRV0QwcrQYs84bmiW7j0SGKBbLhdDCaCLFzaoJLNkm/k62JBlJ1B0zrxY9Wo6p4e4+xkPlQFjAbe0Dyg65aEzt4Q5wCPQuQAEUSbgf+VgnvY5c/Ef6R5jQJGjVpzMMOMi/W4UHu1n3K624Eeocc0deP4bnqVO4yn8coBLY1GaR7G5blVsm4oBrpPnKUNku2LVPUjLes2SNHlzOJ/0jpbgrKZe0J/i9R5lS5MAysHunAMXnnXCv4vbzOcJMCgpTJbA7tQyNIuJEekxVa6s2RwhPJOa4zeFqfMLjHhCjFUW1HSkm4AsPvQ6/Io0I9B+GTlVad2h2sAoCJUosyLFjZJotJFjbi/CQ2fnods3YYsBLFqkEU93s5mCCVBcMJe+1H86Ay5Wz/bRkXOjatJEv6zXMO7xvtzoQ6VgDJTS01xd1lJdxQfbzB1nBHTNnEjLVPkuspAD/YbRs4CKK1H3JZdQWzIuv6VRhBYq/6zPUvwCnmVxrmdz5zQKtqmTxpDljRy7wkqgK8pvFtrkBTFIZHHB9/92Pt7iXZepdHrYsKCMQQfw34MbHoMtT8ZRy6fHS4YpIy3Z161KfQ2YRzH2+w3EkFFCzeGM+im7qeB9/51T+UCEmJzTkpMHsyxuGxKK60ibbeVpfct+MhvcD8eQZLgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR03MB6784.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(41300700001)(38100700002)(122000001)(66946007)(4326008)(64756008)(66476007)(66556008)(76116006)(38070700005)(33656002)(86362001)(53546011)(83380400001)(186003)(7696005)(4744005)(6506007)(71200400001)(54906003)(478600001)(8936002)(8676002)(110136005)(2906002)(66446008)(316002)(55016003)(5660300002)(9686003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0WjS2sAztl9XwCOt1t5QUY1hy8Tu1Stb19CZyMj2iSPpbIbRMpw4EHUN2K?=
 =?iso-8859-1?Q?FQzGT6t6ykz3Gc2PeJu+BXfG1616cPyWfKRZKQJw0b4Bbc5c8qyPk1KI/v?=
 =?iso-8859-1?Q?LUoqPxmozorU59Q52N/xFDNSPcsNwBJHGPCQS0aw9yN178qRj99/PZXir8?=
 =?iso-8859-1?Q?+tNuBzPytVVl875S0766KOL+VgYe/63KFpoQzEWXWZOns6FD07GMnUYeJG?=
 =?iso-8859-1?Q?O11AlbB6k1IgeJ8kDwqs/JlGe6iyEzl+kIE1yNSQiJVDeqDHERO84mmUdY?=
 =?iso-8859-1?Q?smmQ7owL3bJkeGinWEYLxtWYB5og2pd0Nlyzf1anNw4R5/KaTdg6JgEufz?=
 =?iso-8859-1?Q?4tvhWcCauAyAmSZhP8NluvY/z1CLua0qzBw00dLzIjwj7eiTdWkwbwVk1G?=
 =?iso-8859-1?Q?l+bMu3x+xBC3m2V650mwCLRdPdNbV2u3x7ORPEXeoG2st8kaozEvcmyFqh?=
 =?iso-8859-1?Q?gjmJHAyjp6m2lPWfoNOip7UtWGQq3keRmfB5qX3LK9U6JAH1gyptfi4+0m?=
 =?iso-8859-1?Q?Ea3iEX82JQuc4E+6qWAVgVh62zq1Hj84I73ULISuHQOx4ulkfnhhrfHewl?=
 =?iso-8859-1?Q?+5Cmm1X8Zat9zrPyf0YQLsaqGLarxQoOw69MYmyHLJhZoHynBavKOGUWP8?=
 =?iso-8859-1?Q?jCaP2DX/9P5Gqdg73hjrZjdGgwtFxfBJ7CLKDU5I6CAEnDMeqsUOt1Fy07?=
 =?iso-8859-1?Q?Jh3x5bgo3j3cZG12OJ+HvMIbHyg/aw++gvFzdtJ6gG25qBWdzbrTO37zRF?=
 =?iso-8859-1?Q?WyQBb2p+Qddd18nd/V2T/qXBWeQa3l1w47A2cVf+cHoBWctuuwS2n9Otld?=
 =?iso-8859-1?Q?DiZ2hzliLDTOfSWVPLd0ACke2O345bNN2+JAXb8V4sSw5noBCTvvHaW6R2?=
 =?iso-8859-1?Q?6ViZid+/Q2/wY/jDr+oOdtWW98fh99U91mUiWPrQVb8lhbKtoMmtOHx12z?=
 =?iso-8859-1?Q?SLQSKWXvWt/5vRdi8ChwoA9fYA332jefv4vNAnOqQlqLgsaD3DSRitWLcE?=
 =?iso-8859-1?Q?bpp1begPKW85mMCC3HEMIWbAfVx1gTc1LfdH2ZnQDvSkWvEZJGXRM5zN/o?=
 =?iso-8859-1?Q?Whx/ohF5fETxXl5lpC7b5x3ESbj1wtWiviCUpCKKyo6IheMKuG3Rccac8y?=
 =?iso-8859-1?Q?DdhKKtpn134bT9H1YbIVcdmoHQOdoABUQ7cgL3L5eorD2Gs2IirWckVD2H?=
 =?iso-8859-1?Q?eUgdKl7yMMnT/SK1uHv1XSUDMOLOPhCVGzdKTHoIXHQDo+uVkWeopDlwgP?=
 =?iso-8859-1?Q?UxDDMI/zKn1GN01sXFUq2mBrfnyPODonRCRWyvzlTkN4HJnB4eIcAXEa++?=
 =?iso-8859-1?Q?QsgwMbktmqv7FiO8eCwCRyCv6MWwYGhQ8AjAxCFzKaG8OgBnmZdGnNULU9?=
 =?iso-8859-1?Q?YNCxxQ6KeK3PDIBxcDQY16Fd9EWxEk3GnFlcCE9mtTE64g1EEPBdqedQNu?=
 =?iso-8859-1?Q?Udp5+LazEKYk8Aaf7X+iyKhicT0LBm6cYfmf1O5nsEq5TRsFniKxX6eBnZ?=
 =?iso-8859-1?Q?V4hUAsw1N8R6ATHpWdGyJ59XCPdNOtOVtX3r6hUWZAYrUo8odS0+s+5jQu?=
 =?iso-8859-1?Q?SbVOuZrfvtonn7J6zntdFw3pu4+keEyzap8eLCrzx/iJ3vocm4ayeVUfrV?=
 =?iso-8859-1?Q?TZSc3irBWzbmKh8FNDmDMAp4Nc6MsJppHRjdEaRLo+wRtjclLFW0edeOWY?=
 =?iso-8859-1?Q?813aMUcWY2ZPJlwSPwpkA9Wlg+Sj5zibLRlQIREv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR03MB6784.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dfec3e-0c7e-4291-14cb-08da8a7b987f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 11:34:26.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GyoDnSusk7VGCZIqqzR+mMEo9YQYy3Lzs8PMKQE14mzjjKSwezzIsOkQpLzIFBo5xcQjB/OpFqHytJsnvg/Lsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6372
X-Proofpoint-ORIG-GUID: 88MagQ7ClGc3Gmy6BEIDN2bAQ0pRBlmm
X-Proofpoint-GUID: 88MagQ7ClGc3Gmy6BEIDN2bAQ0pRBlmm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_06,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=920 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300057
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> Sent: Friday, August 19, 2022 9:19 PM
> To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com>
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v3 07/14] iio: ltc2688: Simplify using
> devm_regulator_*get_enable()
>=20
> [External]
>=20
> Use devm_regulator_bulk_get_enable() instead of open coded bulk-
> get,
> bulk-enable, add-action-to-disable-at-detach - pattern.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20

FWIW, I also don't care that much about the whole variable scope
discussion... Hence, with the change requested by Jonathan:

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
