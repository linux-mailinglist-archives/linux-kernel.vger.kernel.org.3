Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFE84CBEF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiCCNfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiCCNfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:35:02 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F917CC47;
        Thu,  3 Mar 2022 05:34:16 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223DNH89020643;
        Thu, 3 Mar 2022 08:34:02 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ej1u1yqv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 08:34:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0TrUu+UrzIxzmCR7hMZev/SBe1nkKGzKGVxAHfYypilH9G8jEJWMNR/1PpcSq9fcUpI9STCTlVzYQJg5JTh/BcEJI3nHs3VlFS68S3urIvDV3ZvDJG+Iy3wbiXqSqIIb2iSwgPvc17KnurbpD0PbHl7EqTjPMNzqR5xkA7lGYm82JmZIJHsFnmELjRgSkpUqKbDwYat+pxmXXKPj7jcrK/MuR9duviGK0cs2I5U/O/Lfj6PrsUeGfDJnCo8cjLx5lJWfj8INZaWFBn+b9N45N+yfWIDi6/rJztE18Z8qdm70soZk48Oran6tJxxkEOHYxDA1kvUxFaAp0Tmd9eKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09HKRTZ53WykHYPS8OoU7DpxCW4qi7vRVhjdkMXpQ8k=;
 b=XrbrYNdT5f5zUPmYtJX+IXdUNKSBd4xwxOGD7SJVXngFmhKBkoHJYCSkQxzsTMp2Gp2BU5gFuo5meV2xk/BTIrIzKnoVEyIhQV80KmiEH5kxqAZcJGzlbGley1RVbD+giYh1WDEKaGa1KTlXPYSJe4sA53NwUwImq4I4+yZm+LwDSRv9kMwHCp2WmcI3FxLMeqUB2cnE/KjzoCzBjcF6XOOAT6pGTlhx1C/gBFcfzwJXSIHLrnauK+ePr142s7GDmfpj3fFrdHSVXUCe31tF3COhCc5y5ZlQum6/8ohoTe/Np8NDS8vzcEagvaoAP0Rbz6+cHMkAygVe+ygAy/glLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09HKRTZ53WykHYPS8OoU7DpxCW4qi7vRVhjdkMXpQ8k=;
 b=pL2cyaiYl0fsoQTo6UjYQk58IB/e5NRUZjp1zjH3TqRDPU8JB/hJw+K0y4UztjQNLCv+6D4IvoHj1/nOWlBmUhgJOc2CjkvEwsWUWUc2xWTblETNMz+aCVEMColJnZjz09s80JLYHSI58ITtsmM9x8orjHxv/tPF565hFLPOtgc=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by SJ0PR03MB5934.namprd03.prod.outlook.com (2603:10b6:a03:2d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 13:34:00 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794%5]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 13:34:00 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v1 1/1] iio: dac: ltc2688: Use temporary variable for
 struct device
Thread-Topic: [PATCH v1 1/1] iio: dac: ltc2688: Use temporary variable for
 struct device
Thread-Index: AQHYLkqblelziX2oSESLZSPKaYXKpKytqZnA
Date:   Thu, 3 Mar 2022 13:34:00 +0000
Message-ID: <PH0PR03MB678602F6E1B491B2A882BC7C99049@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220302153142.52743-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220302153142.52743-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctOTM3ZWU1OTQtOWFmNi0xMWVjLThiYzctZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDkzN2VlNTk2LTlhZjYtMTFlYy04YmM3LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMzQ2MSIgdD0iMTMyOTA3ODgwMz?=
 =?iso-8859-1?Q?c5MDIxOTQ1IiBoPSJWaHduRS84Z01EZEgreklDVjlTV3oyMDdIaGs9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUI1ZXRkVkF5L1lBYmdnOWRrMEZ4K1Z1Q0QxMlRRWEg1VURBQUFB?=
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
x-ms-office365-filtering-correlation-id: 15f51bfb-ca4c-4d1e-e527-08d9fd1a79ae
x-ms-traffictypediagnostic: SJ0PR03MB5934:EE_
x-microsoft-antispam-prvs: <SJ0PR03MB5934803B085A1A8ED0371A4D99049@SJ0PR03MB5934.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIz1xqP4m6i/EaU9YBD6uv5YqfMQQvyCNU1jPg1JzFTX2zMviHoLo5Lg2qTs2RdWheYqJlI8jZkupyD4x/CWYSqldaO8lZQWeM8ZZ0h7tKBp8xxyflpLf+59rIptix/7dUjlO0x+Ccxm6PzA2Zwwb8eln+J/U8tFAVC+3fZWOykrxRDGpLHChG9grNXee8jzAJW03liR2BtmIHTVh7pRvQASlIGWiGS0pvWt/S1Ypi+E8UXxIkdW/Zn1nYpJ8Scn7ldNZlUNWvoxkDwls6M6ATTt3SZQVpHVulcifEfiHsSzmPo7eh52jYcLE8EjPnfD0gsfx4sNYIsFTTI4Dj6o4F/m/LJBTCvXvNQvkJHpb5NCm0Kz4wxlRw4cU9CXLQV40k0FLVfDJ7GrnxUn4Qn306wDjFsjbNTe5bfKiX1YovGM3KAoxvHMe/nIvQbMw1cEkeV+Oqn+yVllQD1vrcsJSXTZSOs14VR23Rs83PheBDWB1t8ThQA92ZpYeI8gXFvDU4/5/EX8qZxz/3yg56+X32aIDfSkqEaHMq3aBJwllRGvawafhHDCwTxKGYya1kevwZWVgMOsm9iHpqoiZe1LYV6bZ24Ggo0rCx8rCRnfni6hfZlLeL3Tfg3J7zw/2J3umKB0xHV1nUaJKrLemQRUgFiCeWWs1LC2Blrgqjy2FNXItFDJePhjc0zNTTJ/7BrJcC2SHT7KhBf9RBMcUVWa8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(9686003)(6506007)(7696005)(26005)(186003)(52536014)(4326008)(33656002)(86362001)(8676002)(64756008)(66446008)(76116006)(53546011)(66476007)(508600001)(66556008)(2906002)(71200400001)(38100700002)(110136005)(66946007)(316002)(55016003)(54906003)(122000001)(38070700005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Wk0Y/0sLuzmINrrF9DnZIGkPadZI93EDakgQ4NRKyieodbn8sM1tJS1rPt?=
 =?iso-8859-1?Q?UCIyNN2iykvOVOMNZubDnkYL73S9IBXvLbD/qzGFJ0ZU3acrmhydq+GocJ?=
 =?iso-8859-1?Q?EBHWeHSg9IwFLqXXMTqoPA3pabQIHfEafoe/h35DVMKrq1O2QYfH1CzZen?=
 =?iso-8859-1?Q?+ut5fVQCjgwSoRG+iyJKBJg+JfG6gnAzWJrYbSAv/PLRKQNjb/CBn3uQzx?=
 =?iso-8859-1?Q?Yc+gMX/Ep9cfIkMQRnIQpltHd6xtGsyK0yVk4bytLcetN0/otBBiqI9U04?=
 =?iso-8859-1?Q?8hQOvgWBR50rKMpH9m7vrH7uUNA8bgNFXPia8AlyIHlXxUptbvJZi+qDwV?=
 =?iso-8859-1?Q?tAiPqYwf3np99ysi9ZBFVid0pSqE2gjTuVB+YSS02PGVCISihAxK+rgPUh?=
 =?iso-8859-1?Q?ayTZZHmbeojAPspMutnwK8lM7khQyLLQLxyaOYkkpIseS4tGPOB0PsAv4S?=
 =?iso-8859-1?Q?9i8weN9fG8Hsj86rZXKs/tMtZjvcjSsD77XIBY76xrXgn23PBxdl67U4Uc?=
 =?iso-8859-1?Q?ulf7WYrdRW5c0RyV43Erqn3N7hnN59L5zd/wKxWKUHsMRIiJwELkWaMKev?=
 =?iso-8859-1?Q?Fo+QnAIWoVEnSQvKvxWOMaCrj+jYNxS8uLd/pLDkG2wY6z+aZidxdeoHhG?=
 =?iso-8859-1?Q?tVBeFwd3tu1q33y5UenLoWdkoVV8wvIKj0O1FfQNYq/m3/5ab98s/5GVMP?=
 =?iso-8859-1?Q?vJIWAGjFFSXI+haLIJpd0gywC6vt4SZunboqI1FfxFt9MzA8veyyV7bIvK?=
 =?iso-8859-1?Q?fq6+0GosQk9rCLqS/IKogMbShi8nef284Cpaqx2xigjPbAmERfME8SiPw8?=
 =?iso-8859-1?Q?4IIs+qnpR5mV8y9cBY9hpTVFexI87paS0xmjLFacL40XFae9HXeqwq1F/P?=
 =?iso-8859-1?Q?0L8XKt8mqF58a3uTJ5IMUHK3nhOoBpfzHMm+St6sOwsIpTndZt4gRpR6mK?=
 =?iso-8859-1?Q?+RmpjDmBoChp/CZr9WdxROOGFTmpXojlEV5m3n557yLLygcYGQSfsnNmYd?=
 =?iso-8859-1?Q?0ta6BJw+Csr4Wbg79fgWZB7VBwmLsYoJ9ZUSQrVW/6Y6yLcf8iwWOOWvST?=
 =?iso-8859-1?Q?EpYew4cMCJ4ZvTClTItZhQffUi785VccY9tvC7in4dWQ6rC1QMMwOcIeRD?=
 =?iso-8859-1?Q?xVa5pxdqPOf54c8UX3r1KPnkPaQgGWxu0zN9u93DejhpS6GBj7Sa7tsY16?=
 =?iso-8859-1?Q?EjfYf1ejLYTDPcO7uFZ3POIAwJDyOltEM0aYSnLtFZautgwb01iq2p1baQ?=
 =?iso-8859-1?Q?lJtJuNq8ncRzvFBdIKn9lrqxcZdwetKpS0CbIp5AW/GIwZfERejEYIpKEA?=
 =?iso-8859-1?Q?aXNtEMZvG/zSCt+G8Ua9Oqx7hDTqAYRqazLbeXQYMINKJlK+7IWlK8rUkp?=
 =?iso-8859-1?Q?+EoffpZ+npAmE1TxWZz8dXXj1mnfKRJ+t8hMx2T1kxwtLp/FN3KoX7DO7U?=
 =?iso-8859-1?Q?K7IYEHtg0uEYzSM4qPKQxdEBXN48eaG718h+oNH3eMANzTX6onOO2RSDm+?=
 =?iso-8859-1?Q?TkteO+hFhQKWdE+fTTsPkxKmbvsyvqKqCgqNk6A+uJwDaOfwJmqf/ZRHFA?=
 =?iso-8859-1?Q?uM7oNM3LlwI67g7QJVgpO0HTRzlcYlI5/K9zcciml8/c9C541zzddFw2lh?=
 =?iso-8859-1?Q?y7UQNMx9VytuKQwEZDd54BbjYlZZvuoOCbNbLD7uP1nVeRfTTQjKXFrw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f51bfb-ca4c-4d1e-e527-08d9fd1a79ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 13:34:00.1180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ig7lWN0cwurmsTYhtGgN6nAKrSsboGMxBujINOX8vA2SJrxE+eUc4LQx+jHE9IJSkpwMjxb3VSrnV2GN5LAH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5934
X-Proofpoint-GUID: W6gF0lQEJmlD0jJHP3Kj98A2N3jmxSe1
X-Proofpoint-ORIG-GUID: W6gF0lQEJmlD0jJHP3Kj98A2N3jmxSe1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 suspectscore=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030064
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, March 2, 2022 4:32 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; linux-iio@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>
> Subject: [PATCH v1 1/1] iio: dac: ltc2688: Use temporary variable for
> struct device
>=20
> [External]
>=20
> Use temporary variable for struct device to make code neater.
>=20
> Signed-off-by: Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

>  drivers/iio/dac/ltc2688.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
> index e41861d29767..d249fa28202c 100644
> --- a/drivers/iio/dac/ltc2688.c
> +++ b/drivers/iio/dac/ltc2688.c
> @@ -703,21 +703,20 @@ static int ltc2688_tgp_clk_setup(struct
> ltc2688_state *st,
>  				 struct ltc2688_chan *chan,
>  				 struct fwnode_handle *node, int tgp)
>  {
> +	struct device *dev =3D &st->spi->dev;
>  	unsigned long rate;
>  	struct clk *clk;
>  	int ret, f;
>=20
> -	clk =3D devm_get_clk_from_child(&st->spi->dev,
> to_of_node(node), NULL);
> +	clk =3D devm_get_clk_from_child(dev, to_of_node(node),
> NULL);
>  	if (IS_ERR(clk))
> -		return dev_err_probe(&st->spi->dev, PTR_ERR(clk),
> -				     "failed to get tgp clk.\n");
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get
> tgp clk.\n");
>=20
>  	ret =3D clk_prepare_enable(clk);
>  	if (ret)
> -		return dev_err_probe(&st->spi->dev, ret,
> -				     "failed to enable tgp clk.\n");
> +		return dev_err_probe(dev, ret, "failed to enable tgp
> clk.\n");
>=20
> -	ret =3D devm_add_action_or_reset(&st->spi->dev,
> ltc2688_clk_disable, clk);
> +	ret =3D devm_add_action_or_reset(dev, ltc2688_clk_disable,
> clk);
>  	if (ret)
>  		return ret;
>=20
> @@ -858,6 +857,7 @@ static int ltc2688_channel_config(struct
> ltc2688_state *st)
>=20
>  static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vre=
f)
>  {
> +	struct device *dev =3D &st->spi->dev;
>  	struct gpio_desc *gpio;
>  	int ret;
>=20
> @@ -865,10 +865,9 @@ static int ltc2688_setup(struct ltc2688_state
> *st, struct regulator *vref)
>  	 * If we have a reset pin, use that to reset the board, If not, use
>  	 * the reset bit.
>  	 */
> -	gpio =3D devm_gpiod_get_optional(&st->spi->dev, "clr",
> GPIOD_OUT_HIGH);
> +	gpio =3D devm_gpiod_get_optional(dev, "clr",
> GPIOD_OUT_HIGH);
>  	if (IS_ERR(gpio))
> -		return dev_err_probe(&st->spi->dev, PTR_ERR(gpio),
> -				     "Failed to get reset gpio");
> +		return dev_err_probe(dev, PTR_ERR(gpio), "Failed to
> get reset gpio");
>  	if (gpio) {
>  		usleep_range(1000, 1200);
>  		/* bring device out of reset */
> @@ -887,7 +886,7 @@ static int ltc2688_setup(struct ltc2688_state *st,
> struct regulator *vref)
>  	 * Duplicate the default channel configuration as it can change
> during
>  	 * @ltc2688_channel_config()
>  	 */
> -	st->iio_chan =3D devm_kmemdup(&st->spi->dev,
> ltc2688_channels,
> +	st->iio_chan =3D devm_kmemdup(dev, ltc2688_channels,
>  				    sizeof(ltc2688_channels),
> GFP_KERNEL);
>  	if (!st->iio_chan)
>  		return -ENOMEM;
> --
> 2.34.1

