Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC634FCF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiDLG0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiDLG0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:26:21 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC26BA8;
        Mon, 11 Apr 2022 23:24:03 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23C20AIk014200;
        Tue, 12 Apr 2022 02:23:49 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3fb7w81n4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 02:23:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4jkfKy4crwdNgrYkvKLKU4VZjb+Wk5HiCETVuIpTTica8Hzomt+JC99Q5gO7o18dymhlddqEbew9gYQUFwsgHiaGbeCQZxHFHu9ljige93UVCegA0GqAC5ovVkz7QOC/KDX6Qde+1D7s3I7a7RO7nw7ldDhZlfrjIzsYKa57lSiRmAT0ycyF8+2x9ALCe4yuZYSHkC8XVhf7vdYt7nVrcwfk+mZRH/Xrb2Oe06+sVufqiKFDsm2nFaCvWoYwtoHH4W18cXRkgIYgUkhoy0KhXCYHdlAoNJFUyrrbGXm1KuenAYb6lPXC9CmNh4cydTi+wj2TdJbsHOuQLm/ClqHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PL2nLVQhS2hJExOALIsSvC1sdbXjNiI2aAM5UhhGNNs=;
 b=HXd5YAsBtpvXZpSy1HZ8bTuVlqRMtxBBKp9CBj/5uMnkZ98yZkRtnjEdgSvq8iUcfLPkbWGFME0YQaAT//nroSdyEBQ0/pXwIZMfLkumvO6PwB8/KkXapD70xYSApvZqAO3HW32GIE2DF22K67GzgDEMyfk8mM1SlqvdL+ZN3TbflgZ+eGxJZ6P06DedBYbAnP9eOIIcN5G6x32HLb4Vr5G8dqBEbaxFKQS1IFfP2NB+diP+ZuBDPYeFdwt8n5G0GXDkqTQqNJtF09ihcC3vVEqu+FCR3QiQkd/fS8nYzyz8I8xdzzMYQ+ZvkXUMnB1qXIglHv8/0QBfTDbWsGL+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL2nLVQhS2hJExOALIsSvC1sdbXjNiI2aAM5UhhGNNs=;
 b=H4LR7+5b/5ZhOHI+zHbRrZyxPj0Km1hM2NQLjVGc9aRMDSnVR4Tq8Boodf4+6rGdoCIHmCektbZqTNnpIltdqJrHPLNLzMRvqB8Mk3Pc1vrPhbt1FM0vihl9ilMZEtA2HpQTgQfb9V+g6BGySZ2MWg46CrD6ue/MBRO7vQDsPhM=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DM6PR03MB4668.namprd03.prod.outlook.com (2603:10b6:5:18c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 06:23:46 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%9]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 06:23:46 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ivan Drobyshevskyi <drobyshevskyi@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: proximity: Fix return value check of
 wait_for_completion_timeout
Thread-Topic: [PATCH] iio: proximity: Fix return value check of
 wait_for_completion_timeout
Thread-Index: AQHYThl99NRYKGRf3UqRiCXMHbklwqzrzqNQgAAAY5A=
Date:   Tue, 12 Apr 2022 06:23:45 +0000
Message-ID: <PH0PR03MB6786F62DE142E3E2C66C937F99ED9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220412030022.20249-1-linmq006@gmail.com>
 <PH0PR03MB67863270EC86D06606F1E44E99ED9@PH0PR03MB6786.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB67863270EC86D06606F1E44E99ED9@PH0PR03MB6786.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMTlmNmZkZTMtYmEyOS0xMWVjLThiZGMtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDE5ZjZmZGU1LWJhMjktMTFlYy04YmRjLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTY1MiIgdD0iMTMyOTQyMTgyMj?=
 =?iso-8859-1?Q?QzNzcyNDI0IiBoPSJVM3lNcDcrRVh5c0xlb0c2L201MXdIVmFjTUk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUFJS0U3Y05VN1lBYXlVYnQ4K0ZSdCtySlJ1M3o0VkczNERBQUFB?=
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
x-ms-office365-filtering-correlation-id: 4e98d5c5-a58f-42e1-345b-08da1c4cffbd
x-ms-traffictypediagnostic: DM6PR03MB4668:EE_
x-microsoft-antispam-prvs: <DM6PR03MB46685438847C9E55F65E888599ED9@DM6PR03MB4668.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l3c18dqojRVC5f649kknbBIjz3tAyB9MTtJvpc5AhGQ4aaGGnKk0RBc5KfpihTFERHGXPeq4oDMjL8pmD9CleDMwtEMQ/eKN6PHGnWNxfmqL6oC/qDp4E5M7DG1CQsN9y2CIrURjhGe/CVC4sFyqQ5mdxoYj4qlY3AkowU4hyeZ62XoRjy7teVL4yDDutTkTsHd9ENf/fmvIkehbJHh63deexqFTbpHAg2wLQTjYckWFa2lQUUU86XR5yvhnOk+1zuJnGCtL0kbDT5x356KSmhKRnjIOGjrrZD8dPXlcFGGdsizAW/KSUHJksJxbhyqzbvmOiW4W32nrr87dotUJofYV3ZI4yyrviIVZIofHGbsNJ9zDsUSKXc2mtbwnK1VDNz0nYp7hGQ/7K94Hffh/deSKMltxkqyNSGv7iGIyHtwFR5+rQ6OieWLItRqWSYpN457RKohr6454oii2zMw2znHJebvciUeOO6ClxFhj9wfU3WcOu827yiEGbTfGRfFgNbAUmvsTOs6IePOU+Uo7X7UMrLA3lPMUXzblpr46EX4ikdcsrCbN7SH0kXIIAKUIlY9akRjX77+l/wAXbhg/KqosiLlSQ+mhjbznngCm7OsTSe2cQAzV+MdK07OYTnbuWfExO7Fa/tOKYLDSModWhGbLF1vqim9ldBkS7Iut53FZ6SYs7y33kDt9F6OWU2UppJB7ueyZ+VZRm5dQkV2yuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(316002)(83380400001)(2940100002)(110136005)(9686003)(38100700002)(33656002)(66556008)(86362001)(66946007)(38070700005)(64756008)(66446008)(186003)(8676002)(508600001)(76116006)(66476007)(53546011)(71200400001)(7696005)(6506007)(8936002)(2906002)(5660300002)(55016003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ujO2Y7s5w9RUu/+++txcxCFrzGe0GWI8Yjm3fcCH/GGDJDMOZhOPORfwuu?=
 =?iso-8859-1?Q?YWMrdn35e655d7qRtvN0X2XbYMqXwmGqea6/Elp7wNPB5299hAmyJGrhkS?=
 =?iso-8859-1?Q?QSkRSBkWxZEnQ7AsVysL0cWanOjWB/6tQujZcZseb08HAglHSBKfLSD4mo?=
 =?iso-8859-1?Q?mvVnkRIIGfwyK1s/VuUqfBzcbcvzYpTH3XZYFMAyLzOLUOx0jJHVCV15wr?=
 =?iso-8859-1?Q?vjja2hLMWOAHdlVIt1FeY3RT8o9Gu8inF/DpU3IjCb1Gilh0Jfio6cxoIU?=
 =?iso-8859-1?Q?9UcsOJhbZ8HfDH14bPqKz4G0TV77Dir09D4Q5Vr+31cqd5fiwxVpNH50to?=
 =?iso-8859-1?Q?haoYu4xKAyC7N2Tv4F0u8RgA7UwS4owDs/8EpgyhjjmH+5VETdsCk36dks?=
 =?iso-8859-1?Q?TKZYIUg1JDopf0cEz71xUUu5E+OqoXTjsvbBpwtJM1fsAzcoKE/y2SkZTI?=
 =?iso-8859-1?Q?P9JZ/GCOjdLYSlNE5WNZhM6eRjjpQ1DjrC55jBPKLEErG7iYcItxwuZ6O/?=
 =?iso-8859-1?Q?D79llwGMzxCzkUBSw/BMSRArsol4/BqnyEH4tYUszCwU6+yw37ADjsirmO?=
 =?iso-8859-1?Q?YswVIVg2vyanedDycaOeI7Gr8G91CicewYJg+a1pa8aOuIDQle2lvUcjz3?=
 =?iso-8859-1?Q?PntD/P1SPx58PKisy1htioZoSr1MB/wtfTotdMl95wVR4LYQV4YdCVgwwB?=
 =?iso-8859-1?Q?H2hFiKhz3g2ouImSFIpgUVxuENjau0IX7Kb8X4wP7eArG8v8JbMApGLK1Z?=
 =?iso-8859-1?Q?t4MzbQpfrF+EvawiGv6FJVXh2zbgFUgLbUR9DP1gk5sml+dM8IHLsCRks7?=
 =?iso-8859-1?Q?jPHWya6pJjcOIbxVFk93yz2QORWe3+ueet9Fi+GWXOHl0NOtlg8CbeBZ6g?=
 =?iso-8859-1?Q?iXw7xRkip49isolErRQUOcMMv0Y+4nnUetb++E1mmShya/jXN6ggYcJXBv?=
 =?iso-8859-1?Q?UvPMOouya/Y4ZjLM8tzffkpmataGMnOC+tNKVysHsOJh9kYXk6M1X0DfGV?=
 =?iso-8859-1?Q?j4VoRGZqqzAZ7Y4i3tsCGfpXc1qUMYrDzijzbV9HDQpj42n+I1qDZBT+fa?=
 =?iso-8859-1?Q?2LExWgT+rOMtrqKr0y4cjJ11EYwoaci6h1v3moHPL83fspGeq6xDAceuSK?=
 =?iso-8859-1?Q?W1JATg+OYdNZWTO6r3bgxc5sf4YBs0hg4N4cpc8DtLTTrzGBsKoO1hZGUY?=
 =?iso-8859-1?Q?6hDLUY5pINVKFrQWtXNLWN0r43tegFO8vHtNE7YzMx3YYSVugfnCsqlSJr?=
 =?iso-8859-1?Q?AtL43m9FfBJJZvkiqw87cGQnmhgXtvHEKwznw3JMZ+Jj+xr2sBZ2831X6Y?=
 =?iso-8859-1?Q?SjL7TqvvkBcVyANPnrfGSBxpixKP7XK+jLBHqEBaxuitsLl3ySCUIVch3y?=
 =?iso-8859-1?Q?jRZtFKVmFTGERLBYNu4B4Ip+mpxEewKjeKBjOssFnxNyr/Hw7K47fU1UWD?=
 =?iso-8859-1?Q?2CEY0YgBsLAbf/8Vk3rebRR2GZzxz7785lvvZIF0ObL6GxKcfjiAe8neuu?=
 =?iso-8859-1?Q?2ddcxYu+wjOlzG8qqmBDwCO1lHbKWfeQOQCufgYHrcB34lWBY4zf9d38Mr?=
 =?iso-8859-1?Q?Oct1jz7PtxGmC47hA+FEqlOTje38IPpxDBCWf8BzeAshW5DiIZ+3eyCBL5?=
 =?iso-8859-1?Q?BKJ5BRG9ps4icnWlhU0RDU1KFiJiry0LdTHWJ2x8GDoTYjY24/kWyPDisJ?=
 =?iso-8859-1?Q?5B5G5hvuoUKQ43UlnoJ/7jwY1yC4756p2LazkPn5L35DcD9U8Bt4BUe6X/?=
 =?iso-8859-1?Q?mVy7Z80S3uzjxo/JhldIGwAtjyk278SjsO+zNX6YQ/R+/lfGtTA1hcI64p?=
 =?iso-8859-1?Q?9q2fTf+mw7rJv5WEhwqHfW81SNzX6q242+DDSsLgJflEpx9d65AxJw78oY?=
 =?iso-8859-1?Q?In?=
x-ms-exchange-antispam-messagedata-1: wpVJwCV/lSyc6A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e98d5c5-a58f-42e1-345b-08da1c4cffbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 06:23:45.9247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AveX4dCCaxNGJsB1bztsn+DOTJ8KugS9n0eUPgyzHWifj/2SX93pnIQbxSgjQ8x2+tDIsh0o6eBxiLpqF+gIkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4668
X-Proofpoint-GUID: i9wThgiqQAeUGRok-iGLgu_7DukyGY4-
X-Proofpoint-ORIG-GUID: i9wThgiqQAeUGRok-iGLgu_7DukyGY4-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-12_02,2022-04-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 mlxlogscore=887 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120029
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Sa, Nuno
> Sent: Tuesday, April 12, 2022 8:21 AM
> To: Miaoqian Lin <linmq006@gmail.com>; Song Qiang
> <songqiang1304521@gmail.com>; Jonathan Cameron
> <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Ivan
> Drobyshevskyi <drobyshevskyi@gmail.com>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] iio: proximity: Fix return value check of
> wait_for_completion_timeout
>=20
>=20
>=20
> > -----Original Message-----
> > From: Miaoqian Lin <linmq006@gmail.com>
> > Sent: Tuesday, April 12, 2022 5:00 AM
> > To: Song Qiang <songqiang1304521@gmail.com>; Jonathan Cameron
> > <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Ivan
> > Drobyshevskyi <drobyshevskyi@gmail.com>; linux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: linmq006@gmail.com
> > Subject: [PATCH] iio: proximity: Fix return value check of
> > wait_for_completion_timeout
> >
> > [External]
> >
> > wait_for_completion_timeout() returns unsigned long not int.
> > It returns 0 if timed out, and positive if completed.
> > The check for <=3D 0 is ambiguous and should be =3D=3D 0 here
> > indicating timeout which is the only error case.
> >
> > Fixes: 3cef2e31b54b ("iio: proximity: vl53l0x: Add IRQ support")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
>=20
> Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

Hi Lin,

Just one note regarding the patch subject. You should indicate
to which driver this patch applies "iio: proximity: vl53l0x: ..."

- Nuno S=E1

