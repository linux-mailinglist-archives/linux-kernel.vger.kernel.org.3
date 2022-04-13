Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0E4FFA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbiDMP2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiDMP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:28:33 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ADE5EDDE;
        Wed, 13 Apr 2022 08:26:12 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23DClx9R012968;
        Wed, 13 Apr 2022 11:25:51 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3fb7w8cbkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 11:25:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jyuyql8jNPS9GrQ6n+HQVhpkivB3GdU61WCHjaAIsdPuG5JPuub4NMStcV6KRjzD9np+jfJ8msmtyQDxbWXr9zSQfF4xsta9e1okdTsgdyzV0vcEDM6QsdwFAoTSG0p1uCGqouBVLGRy8/1QwZMoT68+z7OZae22QQCLogt20wColXkjCvAFf0niyvC2mKei+O44OeTscQ3hzCYpDoKPCDZ0gdN0HOfBL/AKH3I9i3skCj6ZSHRVd+jAUAJfpZ6ie16Z3w0I0/Lvp4spt4aRU1+5VqQeQv7BLAqpGstbvYr1vI3oMSQokKJF5ZYl4imFtSswLfvo51gb0y2/jfxOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mhFtm2R4Tk/xQkALF+56pj1AcIDfGuzH5UWyI2JWrI=;
 b=MFCUfcUNO0hyipQ7/pZiksYsot00rF1FOo7CQ7x42jMTJAS326EmhDFTbYRErJOkXryBKKecmwmqRVlhWSXULJT9E/oYls4ly7vmubT/7yHK6cXhQVm1JWleWAjwU6yni+xEZhBLN6eMSRQn98ZzUq2V0ZQMSBhK/32vRx7IgTKsZauB+YoBlJt7t1mACygYb7YS/acmmTJlQdKNtGUPk8XGRWVs4jEmIBleQfNx6004WXp9U68YyDjj4lPtBEE2pELoQDxjyy6br9KKZbFiA4jEffoJHxwbSoVwoUPkvKNFYmZ1V6rcegZ4hA4cfkyJuN0CTyHbFIFi9qADzugzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mhFtm2R4Tk/xQkALF+56pj1AcIDfGuzH5UWyI2JWrI=;
 b=K1HjbE8arGorrhlZhnJ9S9FQRXB1kYhYafdp2vWRgrpq/4UXav0fOh3L2ZSiv2knAUlgmUuIEFzsFXl1kUqd8vo6ZpyaH43TxZHx4OoHJuqOk7WDz8syNQfKH+iZ+o6Eu8zG/OhQk+deV9eYNCVxKO/gF3HIHaFRdlOBWT2rPXU=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by CH2PR03MB5366.namprd03.prod.outlook.com (2603:10b6:610:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 15:25:49 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%9]) with mapi id 15.20.5164.020; Wed, 13 Apr 2022
 15:25:49 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: RE: [PATCH v1 1/3] iio: imu: adis16480: Make use of device properties
Thread-Topic: [PATCH v1 1/3] iio: imu: adis16480: Make use of device
 properties
Thread-Index: AQHYT0Scayim55zviU+m0GokmBcEa6zt9nCw
Date:   Wed, 13 Apr 2022 15:25:49 +0000
Message-ID: <PH0PR03MB67867FD2A0043F5331D1C5E399EC9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZmNhMGNkZWEtYmIzZC0xMWVjLThiZGQtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGZjYTBjZGVjLWJiM2QtMTFlYy04YmRkLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTA0MyIgdD0iMTMyOTQzMzcxND?=
 =?iso-8859-1?Q?U3ODgzMzcxIiBoPSJjOWliTFRNQzJEV0tERWk4M0FYV281UFFQNjA9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQURyYlAyK1NrL1lBZUFwV0xiUU4xTFY0Q2xZdHRBM1V0VURBQUFB?=
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
x-ms-office365-filtering-correlation-id: fd3b2caf-43c3-4cd2-7006-08da1d61e376
x-ms-traffictypediagnostic: CH2PR03MB5366:EE_
x-microsoft-antispam-prvs: <CH2PR03MB53668FC2D1D57918B1C1DBC599EC9@CH2PR03MB5366.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u4UJwn3Vpwz+w+cGsWZgHyOGl8p/n9U+x1k+ubz4Aoybn6Jk3bUe3dkREOtpOUr435eo9SY75wbQR0rvR4zeijyGNMhcxu0IQmXBuVWkjqantRNnbx8Cp7str7slEfpL5VMmOQQ6OWPCYt+7rSJT6GvTUpsLiBVG0wuf7HNNMMyA5HyJ9vf19VEZGkZbhjpgG0oboJhRYQ8mEyeq7pZwV/Yf/DY09QR088QRhXxWswImC3tL05+aVy0kPEAxBL4/DZbptrJzHYe/nVS+X1WS9zpp5n0LHzLOEWQz8/61rSrSVMsvgk36ABQwbDK12ysRYztCb2wkVRglZQ6y6b/X8UpxVoDAwMQOP8/6yKWblp9iZ8jQtBdzHsFM+nzy1Gt/m4LLrRiCjYQzO5PUyq2E2A1SPnXEa5ZnH+LNMwTn37gWowtjneVxexXIirpK+rY9+hFvC58zm7zeiwCSfeZytAyRW5kCaitlPpmuMFgPHWdVYPCrgejTiOioW23l7D1uojtrCtNREcGKu17KRiiX+AF1s+mfwvdCL7cLqhoKAGQw7loQvkkWTHQ8pu/eyqTg7kUiH+hICutfQbNl/PXWEmVB5sRT6+w7FATkC6E0CqRJ6NGI7SBxTa7ZvGu8uxdAa9m2fdjOlmHjn4H0BsUtBgH/AD92yhgwShfl8mSwW/EfBVbz4EII6C/AmhAYkSEnj+t9XHEnOhGsCH+Kiskyrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(54906003)(86362001)(71200400001)(33656002)(122000001)(4744005)(5660300002)(508600001)(66476007)(66556008)(66946007)(76116006)(4326008)(8676002)(38070700005)(66446008)(7696005)(53546011)(6506007)(9686003)(64756008)(110136005)(2906002)(8936002)(316002)(52536014)(186003)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iYbwEDyGozr81USm2UqnN0sfLzvMAPa4Q3dvxh2HvzTn6v+spSJvgFAK/J?=
 =?iso-8859-1?Q?csdmTsrQ9GgOHF+0mvgPIK/2/6sHI5nnkVs8FFfLy5XnAQHv7t9UBrnQvT?=
 =?iso-8859-1?Q?XyFD6hz3+S54b8wvYGivuYQycyhwg8RO/eD5VCJl0K4vSAUUI4xTcc50vG?=
 =?iso-8859-1?Q?TYUtxcG2dIZoYl63L7EkYxzOaCkT0tIoqyNo+e5H+8yMk7WqFVA7BklplD?=
 =?iso-8859-1?Q?HS/I/Qdh0mjg7Tn1OgyAAV8CNBjBDcJKCEgso5rriRM9sbJiHKBYsiJN5O?=
 =?iso-8859-1?Q?KHa0J3AligG+rqK0fbsyv3/M0sIXhIIzCClxq/2uBtbbCD2ikI4t0wyOKC?=
 =?iso-8859-1?Q?XKfIR01y/TJT4LGlTU2kl97+f79EqLk4NXfknXFewah31M3D66bcAb3W81?=
 =?iso-8859-1?Q?ysa4zkSL26QG2t2YhYLCXIvaPc3Tw/eMv/YarAEM7L2jUXdkO9a4YMYmHh?=
 =?iso-8859-1?Q?smcqMwjdEPEkrRf1W6BddbX5mQfvL/tsMQ8eodDvBt3Td+Hy8d0nA2SbSS?=
 =?iso-8859-1?Q?8kyQpO1Zjxv55lZHBh/gKEDL1zwTBMcyszPikUBOdWjxSS4G0Oy1uWe5DA?=
 =?iso-8859-1?Q?TehCVDfm/59SiLygg7cjTu2jJc0UU+WmbEZRS+htclNjwCp0KDbm+Gzwn6?=
 =?iso-8859-1?Q?UeQaS3Tj8T0jQt1/fq7oTz2po1uK4N+hR+wo1HZNdlpgruI5m0oJfrToEL?=
 =?iso-8859-1?Q?Pi6W/JCqVzUfk0s157TIRI9798OFLpErG81IoH8laPAdixn3WiAo6X8zEZ?=
 =?iso-8859-1?Q?dr+PusqVUdAZUlU9eLtD5Ipr+y543ZVdwLGSZ9HPybH3R/49V1ft1EyxXF?=
 =?iso-8859-1?Q?0HKDXU7hHXUg1LGx99secj44XqIZpHo0esYEoLVwOb/LDqEBi2NYUMiHZp?=
 =?iso-8859-1?Q?PXBtnUWffBoy9JozQpiMZlBAI6vTAcHGCoIy/sPoBLyS9T7ryM8BunzYhu?=
 =?iso-8859-1?Q?HXmU6y4saQ5YQ17Hv9Guq/J3EqYH+L47GpEQTRlsqGg2mw92TB64Xjdoj5?=
 =?iso-8859-1?Q?VWBg0w4zWslyHbGeSLPtOGi3sWQJpSg4XX/H35JZHScqUBJYGV/2yBfs1l?=
 =?iso-8859-1?Q?LYn564AaOrm0aDDnk4sbFQN32kHhC1gcFaao038ispVv9viV83ModKQi5d?=
 =?iso-8859-1?Q?9HvaHq+7Rm6X7P3ar0jnARBAjP1c/UocYRreXjC3wyGAo/I/WkmUrASIvI?=
 =?iso-8859-1?Q?kBiIW9snU0qRum5KN5RUGy8HwwCxTpTecSFwaRpAPGY1oHaHVRGKjVPgr3?=
 =?iso-8859-1?Q?5YrAnuyKdDriK+ijYBazT+BUO+gPP7PiYWl1aqIHIZzqnmy2LTFsKzrLDY?=
 =?iso-8859-1?Q?HWPIQ0F9VflEpLdMqeiiJzQpNlHTVSbfpBVXOIDiVGhgPUtIyiMMLmIVJw?=
 =?iso-8859-1?Q?yjNUaFjm5NHMg6IZXXWR0Hv1o7oqvQjaYM8keaNogV1Qvf6KZV9NwSLyFe?=
 =?iso-8859-1?Q?Cztvi5mus2q77Yzj2VfuCJ+qEe2cW+dr1UR8yWk+YjL4GYYUkrbr2On4T4?=
 =?iso-8859-1?Q?PiD9DTe/tNN+pst88XmReyNPktnTcdWM23tVs/WcrFVNR0ac2v1Dcr/pOD?=
 =?iso-8859-1?Q?UyHE3wukzvmsHSKwXELuRDAVorj5UmufPrBBTWF88lFFIw5/DA+fG2sf77?=
 =?iso-8859-1?Q?8kdLSAgZWvMdpGBZJBosDxyvVp4FTiV4EVcj2LJpWlMuneI1Xr/6cpxtTZ?=
 =?iso-8859-1?Q?7E+CcOzhV4TNPOXjgUs/2SH3QpxXQPzMyGjinS3M0rbUkBaAqk8zOhI82N?=
 =?iso-8859-1?Q?P19TEJp9O+2szAJ0Bqv6BdWOIodEhqC3QvKChZ1JZRHfSfwKp6w5fPbcAN?=
 =?iso-8859-1?Q?9+WBy+Wwf1JuWQhEYPjya5D/D9SjS7npHLJGWASC1KzAbvfr4v6ofzYGBg?=
 =?iso-8859-1?Q?oV?=
x-ms-exchange-antispam-messagedata-1: s2THgxguHaoVOA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3b2caf-43c3-4cd2-7006-08da1d61e376
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 15:25:49.0787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4Aj/OND7leCt7kHH509oLxdyOsaO6wrAt10q51ys30+ZyOS8QOP9TpzDEZqbjk5PjOz9wHGAXu9Id9RRCQ1Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5366
X-Proofpoint-GUID: ZnFKHAofU0CJ09326nsTxVAp3KsF0fKg
X-Proofpoint-ORIG-GUID: ZnFKHAofU0CJ09326nsTxVAp3KsF0fKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_02,2022-04-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 mlxlogscore=516 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130082
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, April 13, 2022 4:41 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; linux-iio@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>
> Subject: [PATCH v1 1/3] iio: imu: adis16480: Make use of device
> properties
>=20
> [External]
>=20
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>=20
> Signed-off-by: Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>
> ---

You beat me to do this. I actually had planned to do this next week
once I saw we already have fwnode_irq_get_byname(). Anyways...

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

(I will still give this a test next week)
