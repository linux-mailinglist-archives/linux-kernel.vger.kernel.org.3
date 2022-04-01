Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8554EED62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345944AbiDAMpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbiDAMph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:45:37 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B984195D97;
        Fri,  1 Apr 2022 05:43:46 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 231AWHcv003760;
        Fri, 1 Apr 2022 08:43:23 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3f5yqsgq5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 08:43:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6RsGyUHc/pCaawGJyGxuwtFA9o7kl8RgHObjffDnemaCMfDYBgHccsr2xjjal3dryQveVd5Xcv5g/5jA80K2vvpXnk6cfZF8P8/zngMfZSf0X1RabeHYGTQMSsp9qHanUDRCx0yC4z03A3q0ZPRtE77+0KRTfgXMGvs0Q0FScn3dMBIGsQYL2hojCnhb0MleyAodqz8GxY9Aa+FnzMiR8AHY/TCTpjx5xWayJhX7sSHuqBr9f96VBZ+ZkVOiojhVdoesWJcLO962rZ/10HNDJ1ih9u/z48tHquh/FEmuxRwz0Ezi1dnv3RzGS/G1Pi4/vhBj/v/2DwRyendHXPZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRaP7JEVptUab6SpzX8T/MXeSSE65ZVBbDVY85xw71E=;
 b=H2sbB4/pwnHsxg3CKEgHt7c3sYz6sNoWxBfMupnC5bWICFdS0Ut3IUL56nv+WHUg9fxiQwWq5WBGUXVTAExDeHIdE43C1CjUr6nDmhMYLd8NWv9ZaA2Ce8RgG4MxBRFf0to5rCn/XyKeyiaL5gEDRB/udT2HzR4wGpNbdaDt38sZmfuKY2Su0oOUl4AI5Z1oyuk8ZV+hhVJtIFBDIvxRHWH27XsFusoxkKZRvQNRw2IdnSSzcaIK8xQSMdPvK/7RwvlDiyTDeoKGx29lyZDYxjeW108eZnCNjCBDZvcZ06KOmr3YBZO0ohzxChMgtNLAudUbpt2AsKu/+Qeczkdb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRaP7JEVptUab6SpzX8T/MXeSSE65ZVBbDVY85xw71E=;
 b=OqcQA7yj+bnQgmH0LPp9QAoy9T74kq0Z7UFh9TpUcEzGHb9MSTUheodUNWMpFdCRjGVLKTHML+UIdmpXaJ3AW67l1m95QxJua7+/vyp7sVa1axEig9Q9X3fBhWAQSwCL4aXG+dhiSqHRmSexBkwQ1TemlZ2kFWmDhH7DwU2Aj4c=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Fri, 1 Apr
 2022 12:43:21 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%7]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 12:43:21 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: RE: [PATCH 2/3] iio: ssp_sensors: replace usage of found with
 dedicated list iterator variable
Thread-Topic: [PATCH 2/3] iio: ssp_sensors: replace usage of found with
 dedicated list iterator variable
Thread-Index: AQHYRVQWzVTHnxHR10i24e3FWXGAAqzbAR8g
Date:   Fri, 1 Apr 2022 12:43:21 +0000
Message-ID: <PH0PR03MB67869AFC7667ABCD9A57CB9099E09@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220331230632.957634-1-jakobkoschel@gmail.com>
 <20220331230632.957634-2-jakobkoschel@gmail.com>
In-Reply-To: <20220331230632.957634-2-jakobkoschel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNGVjZjA0MzEtYjFiOS0xMWVjLThiZDUtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDRlY2YwNDMzLWIxYjktMTFlYy04YmQ1LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTU4NSIgdD0iMTMyOTMyOTA2MD?=
 =?iso-8859-1?Q?AxMDAxMzMyIiBoPSI0VU1kWkpNTllXQ3lQWTdQRlFHY2FtSjZDaGM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUIwYXlZUnhrWFlBZVE4YlRNMzJzb3M1RHh0TXpmYXlpd0RBQUFB?=
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
x-ms-office365-filtering-correlation-id: 763f85af-5a24-4ffe-11c3-08da13dd348d
x-ms-traffictypediagnostic: MW5PR03MB6960:EE_
x-microsoft-antispam-prvs: <MW5PR03MB6960FB43C4213C7502C234BD99E09@MW5PR03MB6960.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vdIPtrOvFQxy/+He1AazoNnDq01N858qkTwfyflCIAftGEedahN5h2oBWQtRrZ0gsi6qzYJqsvvZa7ibOy9l3F72oG1QoRR4xDcvO5+6shQqCPdYKWMQdCPDTGc9XT5pvdU7AfXJXrlW+lTc6yeT2rXP4IoYKpXNnjiiej+7QsIhZDh/avMXyOeq4ZoWxN2JwEe6bjHJjAoQa9tSoTiU3GgD+Z1xv5MmxaVCNHE6VUcpqPr1Cb5xvwxGbCveElIqDcMt3R9qaDZ3Aplv4pjOR+33t5DyB/zZ/lyfUPPfxXRcgLj/iku/Vy5pQ7iVmvQOuMoovCRVP8NWnFlkyp897CBGMBAUKT7mIyT3JrUtbJcP4hUeDEDZHxLx0jMcP/4fu2DioGy49Pjjk8HlDypd5B/hy3H5csv9wExd9H3ZCEBgdlKBjikUEQJ1uCHCTGZ1CQrwPeryTw3TUTaTMUHZyuGQDw28lZo4wZsImjG/HhnQzadYaIf0QZ8XckRomz8gebhZ6KXsQs4RT7a05MnmsC4Q3aC314zEFiEW5FVyHmlFXHIlo1HEOJ7gLIsmdsDlZkYUDt8IsZ1dqmDz1dZGPN0utdfvC1qa9kNwm3EhS/WWY1rUK27M7gZkM6+r5YkBITIrK2XsaNjCQh2BQSL329kny3FltXS+UOCUKKt4csa9XV6NhaKOqJB7ScdH+7UWoKktLOJE4KqVwLLmJl+XwTBdAzDu3ZGn7v0u2S3/SPVqEdArFfofXCkVxdSjjCAq0jGOu5SWZ0itVI9xJVRKx4iiQ8UkUbcwhgewwpKumTE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66476007)(122000001)(53546011)(8676002)(9686003)(64756008)(66446008)(38100700002)(76116006)(4326008)(33656002)(7696005)(71200400001)(66556008)(55016003)(6506007)(38070700005)(966005)(83380400001)(8936002)(5660300002)(508600001)(86362001)(186003)(2906002)(52536014)(7416002)(110136005)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?orVnz4qiXyq4J6seUMT4ZxgiTpKhzp4SzkkMtM2zA0g7UrdkbGbq2Xb7UX?=
 =?iso-8859-1?Q?bcZETTcM46bfmyf9LVpoK6ntotJ/wrQKf+6Y5eomH+RKyDxwea/SJFE8ns?=
 =?iso-8859-1?Q?9z+mvvkTeHluB9KZH17/Y0IIi2kpJ5cjT1DhJdrwIAuCcFgvmIIYEz0rmx?=
 =?iso-8859-1?Q?1qqrSgyVnjZPzF/uHged8xVn6C6dbCOfaVRLyh02bpbS9OzS1Ld4HD6azq?=
 =?iso-8859-1?Q?HMkqrjUURDHag22322XSpbLsJo5bACZGpTo9ycT+3bS8zPh21LxQ/jtHrg?=
 =?iso-8859-1?Q?IE7DBUAiPtDsGiQOmrWZrNwTEi7sF8hEXs8/0GLG9rN4QW5RZXVFl4UeFx?=
 =?iso-8859-1?Q?VwJ3P2zqgwNKt+D/lcVD9hsabTLe45Ah457EhPl28ToZp1T1GUngDJJG36?=
 =?iso-8859-1?Q?C5wC9p/YnzHJGUksGLaXvwqbkIjn9Gb5AErp+B1Qo85kPAm8MzUrR+tEa6?=
 =?iso-8859-1?Q?phKeWX6jAAalU2klHVIcjQxJl8+lwgJMVX3QUPSL9WGUFI0Mu8wqTn+4w+?=
 =?iso-8859-1?Q?pOkQSnZGTRNXQlVLb2YJpt4bOVhw1504N8/TOAx5A+e8Qmf+Gtsa1TrKXt?=
 =?iso-8859-1?Q?wldZ30zDhXK52CD5iiUPrGZT7FJy6bsTQ0k095T7DL7aqOk/DEVERu8ilI?=
 =?iso-8859-1?Q?xPgzLAlCzUExJXF0wMST+yTHcg+tQuFPccVZVJuwv9wD3THSe0foa39N9w?=
 =?iso-8859-1?Q?eC5MtMECf+fhvQdBbRGsRN8ATD0St5dcKfdimoEMQeaFsBJ7wADfJb0Cru?=
 =?iso-8859-1?Q?JVZmVwJPoXFCm7Zmszni0z5rydRw3SQhjqbIsLbYmKlf6RTGgMdFQjAs3l?=
 =?iso-8859-1?Q?eQ4KkB+BzzG4JbRZg1+QXIePuaU/7KfTma6+wZTaMMTbhX9jFccJJXKlYY?=
 =?iso-8859-1?Q?tiMgi6cQDHdTibhIdPoRGOs9+VqyBT9zImgyr0QBNsq2wz+VC9A33ot1ep?=
 =?iso-8859-1?Q?zSG3zy8cPR0C9Uh1avgM2tUDsWutrqe3pYDhQjUhYrEh5AbyOPt2pmu0ku?=
 =?iso-8859-1?Q?xZ0EhZrfm/EJyKQLMQ6KMwKjaUtZWoz9QtDXtUclU6Q6wUaVYfN3un6eze?=
 =?iso-8859-1?Q?atZgCSwwPZJ4VUYwLd261z49E+rv9c4sy0CA6MfZU3dLWV29S5wEdfiV8Q?=
 =?iso-8859-1?Q?5i+V5/MTg1a1ZH8XcCuW2t6oIc0MHcMC2FrTzj6WHa9Lqzyn50iaKBmds6?=
 =?iso-8859-1?Q?WAUNPB77IeT4kGsF7+9XNaGStd1oomacDtlfvVuJsOPntL58dbV3udhCnh?=
 =?iso-8859-1?Q?psUg7T/A1U+F56EmF2KhtmuoU3oJqHJhIiDyRzhdCdfpx0aJHsbd2QuFI9?=
 =?iso-8859-1?Q?c0Y2mJtCh1VMWQkjwKO7pzkK84F6UK8M/GBuaHgoF5IqZugZYAXylGEloS?=
 =?iso-8859-1?Q?YZmnJQ2orRIC5v1SSxRiYashxgyQTrw+t7bfVrbR0thw2ZdbLEJ/Lv4j1v?=
 =?iso-8859-1?Q?Nha5siEy9UDofhI8jyurYcr/XIRPlX9dA6KvVlXCYreII/jq14gZIgF0EO?=
 =?iso-8859-1?Q?o/oA28BZfYkWDsJR0x1bM07cCmzVEzwBStLqBW3QE2WXzaONTWivMRduum?=
 =?iso-8859-1?Q?0e6ow6XA2xUuN6F1fM4RVZHYWbg8wENzucckWJpwRD+JIJJv+NFH3pHYwL?=
 =?iso-8859-1?Q?W3nIsHC2RBlkl494BahocBmYxxjRLhdBEbNEnDtDktC6KJn618mO/sEhp4?=
 =?iso-8859-1?Q?9TF0fAOg0m2chsM3IIHe7bqCwOD/8kScm7t6isM7qtgXH7uSTb2sKfhx22?=
 =?iso-8859-1?Q?iUItUb3z9vByVGKSi6wCoQY071QOP0P3j4p/Deyayp+Z9+D6XbymkXTflu?=
 =?iso-8859-1?Q?A/oay1Fj8VeiqL/gktIARv66WqPujBmhKtv/9JwUjrPY6Wu4WQ4GG4W4ZL?=
 =?iso-8859-1?Q?hA?=
x-ms-exchange-antispam-messagedata-1: zOsSx7HcqoRBfA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763f85af-5a24-4ffe-11c3-08da13dd348d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 12:43:21.5925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khCIDRUwhqRrFGJx4Tr+0sgdWjWcEDXVr2H0DvtOnw4JmASU2kdPPi9NzKXeDVHcNMUdYShkNnQ89OVtNLPszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
X-Proofpoint-ORIG-GUID: LyNk0mjSCb4XdwVh-FwtvnHlQLCPgT7C
X-Proofpoint-GUID: LyNk0mjSCb4XdwVh-FwtvnHlQLCPgT7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_04,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010058
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jakob Koschel <jakobkoschel@gmail.com>
> Sent: Friday, April 1, 2022 1:07 AM
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Dan Carpenter
> <dan.carpenter@oracle.com>; Jakob Koschel
> <jakobkoschel@gmail.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; Mike Rapoport <rppt@kernel.org>; Brian
> Johannesmeyer <bjohannesmeyer@gmail.com>; Cristiano Giuffrida
> <c.giuffrida@vu.nl>; Bos, H.J. <h.j.bos@vu.nl>
> Subject: [PATCH 2/3] iio: ssp_sensors: replace usage of found with
> dedicated list iterator variable
>=20
> [External]
>=20
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
>=20
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
>=20
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
>=20
> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/CAHk-
> =3DwgRr_D8CB-D9Kg-
> c=3DEHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/__;!!A3Ni8CS0y
> 2Y!tqcYepOSYys02RcvKD7LiZk3mHwPmSLa_1S0QglWPRZSCoPnXk3ccjY
> _XzsDDA$  [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>


