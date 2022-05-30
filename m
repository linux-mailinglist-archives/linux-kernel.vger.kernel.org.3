Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE95378F4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiE3KLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbiE3KL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:11:28 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDCC7CB28;
        Mon, 30 May 2022 03:11:14 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U9Cb9Q018897;
        Mon, 30 May 2022 06:11:11 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3gbgc73a3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 06:11:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoqKXJyZVkn0/TfeLjxCxi5aZjmWFD0pHsD84wh/VrpwvlCv0jK1IrXVQVMe9DblXFfdht8tqQD3N9BPsJAsf69m6IsCJ04SWlzzmkZYdb431D+f7jrJjS4gPtOAmpwro5FENvDZ1C8CiBX+BkWficSWjIh9FnVVid+/0YFVdhB7cUqTATI+mlLt3TB8sXkz7vB3dsBLCrzQE6E1AEiEHgiF8QQO7Nh6RtCb84WQ+LsNnd0qanO7THxQnICkW3qnRwopirEvVknlk767gu4U1XYaleOm2ZSTtE5l5esyz1nPGdHbBlBA8d9KD4E6Ttgy48bwjxw08od6SSymUH/JTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcHIivbyxzyoP2jEKvmKQtRU7bBV5Emr1QlzLp3tZMY=;
 b=VJ6oPcl+WEaQTBEYGvIR+RyFuYT/Wsj9eKbXR27SLqU4ntp50r81h7MkKGmLjuLgiI09qjyW4EyVdk6rzEGzIEyP4v3A2/Jo2eyc9a0UAYH43h/tjdiX0ILCjjNvNsF2qiRJ9Pf5omK0CnOsigmGehlZ1Is6N6BZzn3+UgT4tzDgMWkdjEkfii8KIqaO2hHevXy5wA9q6QF1+JasI89D3vCmlwTDdZ4RXpm2ZZuLmpmuHvABjIQVuYe3MmN7RS9kEnOUFISKWnyBMsCarHrzZz2M1T5eVt+46Oy3cSb7apHkQGpsacKdJWMyA3fn098XIYrmmUPVSScXe814RWxQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcHIivbyxzyoP2jEKvmKQtRU7bBV5Emr1QlzLp3tZMY=;
 b=1a+Y8v76pxLcIRHe5+wqZyt1Um/9iJwESAz2bjoxihEteZ6SVjYku4XTkqL+39D0VBdwR3yD5WZRy1jupttFvKOtWvxDCKZ/fio/Cy4Mj0/pLCiaG0zvabU8DxJbHv4mjKnaRf2QUaYKjwL4+OW9OHvy2i7CaXTiYL1U3e7dhzE=
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com (2603:10b6:a03:3b8::19)
 by CY4PR03MB2920.namprd03.prod.outlook.com (2603:10b6:903:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Mon, 30 May
 2022 10:11:09 +0000
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::b188:7eab:15fc:aa39]) by SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::b188:7eab:15fc:aa39%5]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 10:11:09 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] Input: adp5588-keys - switch to using managed
 resources
Thread-Topic: [PATCH 3/4] Input: adp5588-keys - switch to using managed
 resources
Thread-Index: AQHYck9TY0Z3n8JQbUawF7Y5LRKwJK03NnoQ
Date:   Mon, 30 May 2022 10:11:09 +0000
Message-ID: <SJ0PR03MB625362C81843C51A26448A418EDD9@SJ0PR03MB6253.namprd03.prod.outlook.com>
References: <20220528045631.289821-1-dmitry.torokhov@gmail.com>
 <20220528045631.289821-3-dmitry.torokhov@gmail.com>
In-Reply-To: <20220528045631.289821-3-dmitry.torokhov@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcm?=
 =?iso-8859-1?Q?lcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1kMTdmZjg4My1lMDAwLTExZWMtOTJhMS?=
 =?iso-8859-1?Q?00ODg5ZTc3Y2RkZWZcYW1lLXRlc3RcZDE3ZmY4ODUtZTAwMC0xMWVjLTky?=
 =?iso-8859-1?Q?YTEtNDg4OWU3N2NkZGVmYm9keS50eHQiIHN6PSI3MDI3IiB0PSIxMzI5OD?=
 =?iso-8859-1?Q?M3OTA2NzEyODk4MzEiIGg9Im13WUxiWEo0ZG14T1RBWitLQUdTdmRsZkl1?=
 =?iso-8859-1?Q?Zz0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBRG4zZGlURFhUWUFiYlJpaHNENjdNdXR0R0tHd1Byc3k0?=
 =?iso-8859-1?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBSnJqSklRQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-1?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-1?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-1?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-1?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-1?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-1?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88cfb21c-69f7-40b2-3d60-08da4224b784
x-ms-traffictypediagnostic: CY4PR03MB2920:EE_
x-microsoft-antispam-prvs: <CY4PR03MB2920A99375DB2B99A558CAE98EDD9@CY4PR03MB2920.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9NrJRXh2/Bm7rzkjMNOf79723l9eXCXFt6zStMCJA09uFPDWmPe/TAuJ+RXx7adPYAR0ZNRgw6zpBOtoHe3Nla+bm5+OWaMpkgZC+yzEp2TTI0TKyNhMyS+MX5Z1X03z+nR3I8GhPao23glOYW89nHflLH+xcRTM8rv0a3yaHlltQrdXmbDXxc7J0pTGDyLwnbP+4RKuT7P5xccHNTofucjBCunPwR9eHxKBXWpgUYeaWJNp6HQ/fLbkCrwwDYGBBTMT7L4PX4odKRXGrRNQQExkaJQMBbYXE/35g7Go8lNf/AsH7HTnuxTuYAXdZCbO6qO64zqR50qSFG7heRGLaN2kADcXP47/oUB15mEHUwMNvsRU2oTqnCOdLFmZacD34s6o/v7LZ7tlbvEdGp/jDWiNekxNO5HNlxS+tTe6yfarWdVEruWyx5VPlPRxFaGe/9cb7Q/PZbeuYTR+YbOTuw/1fQh7ALN/jC0a/2uKAWxQF9SOi1M60F1jFf9sWv3ElqaqV3qIlCVfBJr+UXjy/KSk8WQpNpEWEjZ5t8+09XsDrcNdfpxcRj0TIKJbAjLnyrfFX0jl7ceZl18nIZIJVsWXMkgWwBU6DevPpKysKifHe7jit4gknyUJsoqSpdpeacmee/AJ5pEW62I+zjkzp7FYfMcWAp+ujDEehGt3I2GJd9UbWHh75Y9LxAIBlc5MdjtWj915R+wMGztOSPnwmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6253.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(2906002)(71200400001)(64756008)(66476007)(66446008)(66556008)(4326008)(8676002)(316002)(76116006)(83380400001)(33656002)(5660300002)(53546011)(508600001)(38070700005)(122000001)(6506007)(55016003)(186003)(26005)(7696005)(86362001)(9686003)(8936002)(52536014)(54906003)(66574015)(6916009)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OzwkWCcoZM93fHasg18El9654ZKF8zf0hJJPZPYPAtoAhDj6/ZtdqrLa1b?=
 =?iso-8859-1?Q?PZSH4jgJToeZqWqoOGmv8+z/qMTv0k/GNDOlyoYTuP5VzerzV6u6E9swDF?=
 =?iso-8859-1?Q?lRQ8e+Pn5/KtkTLGK72LaTnWJ26RcNQ9ohnxPqZp0tDxlE9dzD6lmjQvwe?=
 =?iso-8859-1?Q?+A65JkM3mSWhuNh9Pw+j5CxEGqn+182T3Hat5/Q7uNZGf983hE9zusW8k+?=
 =?iso-8859-1?Q?LyVbOVHb7kixpoUgXTTrosrwQ/cO03Va2TCVdcbS4CWUKW7txgSbGpS8e4?=
 =?iso-8859-1?Q?NwMadBiJw3IXXgyv4WcAPCxU8mx96vOVyLF5EhSDEBK3Vyw3AzN0KxfQzA?=
 =?iso-8859-1?Q?tRbO1gIbAl9udWfcGE09HYJ6ZL4xdvsHJrqvmMsWVomEZzFdZvCZkgs7OP?=
 =?iso-8859-1?Q?rlrsxLRJ6tctPktYuPY9i5npPxIh1hwtOuS2lcszxSx6GUd4mLexgAh7jZ?=
 =?iso-8859-1?Q?bJmWy5jRA0zfdWYXFHT4+H8QmlJ/qoAZUFBhAOKlWsk4PkcamKh6R3M8FX?=
 =?iso-8859-1?Q?8vc8+pb2dYbEUtn6tu3c0AMReRGdAEn8wFgr1n2QeokZxgpVg3vb1u+Y+Q?=
 =?iso-8859-1?Q?eWS39GvrHjjm72YvCtfJJc6X3k6FRhf/qvNvJanKP1ei7btdLLVaShBhWX?=
 =?iso-8859-1?Q?/uKk53T0nnXqx0vtjCrXcdAnYo3Jd4WfKp5HD5q55/7MUxGIslwZWeazT0?=
 =?iso-8859-1?Q?rNLz0L57A4X/wAoAzPi+o8sW934SYFlmKqECJwKFyLOv3BqOC2EdyAARq0?=
 =?iso-8859-1?Q?yC1/6lGVAtN26totB/3n7GfKZy2msRbrWbaPnctjFNgm43fZFyNd0uggEm?=
 =?iso-8859-1?Q?hrLIJG9UBaXyavPAfuqeUOSPbhLG5nF9tENkUf7VLLBM2sphorpeXS7c2b?=
 =?iso-8859-1?Q?zfvGXTAIvW9ofqFhRRGxGVU3kfaOxATTVxjZlkp3qnAGpHrlyxSA858yV+?=
 =?iso-8859-1?Q?nyPKk6eCJHFibPiGFA35QGYkMG1l8sUscJuXgUPSZ+CREsLtdEWwxaU9qg?=
 =?iso-8859-1?Q?kLcXF77vfNCS7KqVZqt1xDLALnqoxTP9nsOafL5wCPnpAyy4YLflzKkmeE?=
 =?iso-8859-1?Q?+y4QFTe2unb3LN9NFZvQatL2JwtNwkGr9fs3z0iMm9kjlpPBPgp16OboxY?=
 =?iso-8859-1?Q?gi+AeF6TFtyN8g5UTa7ICbVwc7CBiE3Q30wgktO9tqNf0avUwOk5tcgSsx?=
 =?iso-8859-1?Q?pZcva8Ly5iaZ7EfM5iJw3D/oIVBGOk9thvyp+BrLn57EcMMFCcj7ymZCEQ?=
 =?iso-8859-1?Q?l+F2H6RvryNdiqkJgFRyYAGNVmizxXAA0QG02nksZiJECP9nJVjEm/SE5C?=
 =?iso-8859-1?Q?7z7QeTQnW5BIiAwaCg8lMqTRRQ331Wr3JRx+V60Nx7gK/SMK4WEWyMlbZ3?=
 =?iso-8859-1?Q?NdL5j2yiwtI0qah6zaTsLMyTMjmN5D28aWWqJRio2siqZsVhTjQ5jAQdeR?=
 =?iso-8859-1?Q?STCRuOEgF96VQpsqcPbkYUw/pnB49Uw14wWHUBa5dsIb1QT8No1Snd8Wv1?=
 =?iso-8859-1?Q?Ixes5PfE3NO42VX3+44EJhjAo6HLr6rpeC2VtnM3gonCBccCJBFlF1jBdA?=
 =?iso-8859-1?Q?OveEyhnEKN5JN9/rdGO5Jnw6FPvzL+sRYP6Zqt5f7fnACfbL8t8lMOjWOI?=
 =?iso-8859-1?Q?gFzNA9/k8rr31sbqH21Ip9vgDWS9Nnfx3gsfBUkbz2oTtU2kXAyGHMzgp0?=
 =?iso-8859-1?Q?NCBILWeUlY0VD+UvN/kH8vHwFqs0bFpje62NkQ1qfdTQgt3Qk1MEb2qaIA?=
 =?iso-8859-1?Q?3Kwcb5UsYmSdcX99bCOyr6x+74MjPsP+nen1LGwvH2wE8BIfXH5kYhPUa2?=
 =?iso-8859-1?Q?0XbPA6AhMQRfjjJIygcLIF8sGubUHtY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6253.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cfb21c-69f7-40b2-3d60-08da4224b784
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 10:11:09.1343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 646WnuXzq83T6YF0TPl7gygZwVCGNdUJegtsqQuSP6TBKYqMBAmO0cB89zGA5WgA8C355Km8FoJmVxKOgjk1z9QLuJBnqOSth2ZSJGWObPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2920
X-Proofpoint-GUID: Mb51nyjF5WJbZkfueguToaksmF84zPn1
X-Proofpoint-ORIG-GUID: Mb51nyjF5WJbZkfueguToaksmF84zPn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-30_03,2022-05-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300054
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Samstag, 28. Mai 2022 06:57
> To: Hennerich, Michael <Michael.Hennerich@analog.com>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 3/4] Input: adp5588-keys - switch to using managed resour=
ces
>=20
>=20
> This simplifies error handling in probe() and reduces amount of explicit =
code in
> remove().
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/keyboard/adp5588-keys.c | 111 +++++++++++---------------
>  1 file changed, 45 insertions(+), 66 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/adp5588-keys.c
> b/drivers/input/keyboard/adp5588-keys.c
> index ac21873ba1d7..df84a2998ed2 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -182,6 +182,21 @@ static int adp5588_build_gpiomap(struct
> adp5588_kpad *kpad,
>  	return n_unused;
>  }
>=20
> +static void adp5588_gpio_do_teardown(void *_kpad) {
> +	struct adp5588_kpad *kpad =3D _kpad;
> +	struct device *dev =3D &kpad->client->dev;
> +	const struct adp5588_kpad_platform_data *pdata =3D
> dev_get_platdata(dev);
> +	const struct adp5588_gpio_platform_data *gpio_data =3D pdata-
> >gpio_data;
> +	int error;
> +
> +	error =3D gpio_data->teardown(kpad->client,
> +				    kpad->gc.base, kpad->gc.ngpio,
> +				    gpio_data->context);
> +	if (error)
> +		dev_warn(&kpad->client->dev, "teardown failed %d\n", error);
> }
> +
>  static int adp5588_gpio_add(struct adp5588_kpad *kpad)  {
>  	struct device *dev =3D &kpad->client->dev; @@ -198,8 +213,6 @@ static
> int adp5588_gpio_add(struct adp5588_kpad *kpad)
>  		return 0;
>  	}
>=20
> -	kpad->export_gpio =3D true;
> -
>  	kpad->gc.direction_input =3D adp5588_gpio_direction_input;
>  	kpad->gc.direction_output =3D adp5588_gpio_direction_output;
>  	kpad->gc.get =3D adp5588_gpio_get_value; @@ -213,9 +226,9 @@ static
> int adp5588_gpio_add(struct adp5588_kpad *kpad)
>=20
>  	mutex_init(&kpad->gpio_lock);
>=20
> -	error =3D gpiochip_add_data(&kpad->gc, kpad);
> +	error =3D devm_gpiochip_add_data(dev, &kpad->gc, kpad);
>  	if (error) {
> -		dev_err(dev, "gpiochip_add failed, err: %d\n", error);
> +		dev_err(dev, "gpiochip_add failed: %d\n", error);
>  		return error;
>  	}
>=20
> @@ -230,41 +243,24 @@ static int adp5588_gpio_add(struct adp5588_kpad
> *kpad)
>  					 kpad->gc.base, kpad->gc.ngpio,
>  					 gpio_data->context);
>  		if (error)
> -			dev_warn(dev, "setup failed, %d\n", error);
> +			dev_warn(dev, "setup failed: %d\n", error);
>  	}
>=20
> -	return 0;
> -}
> -
> -static void adp5588_gpio_remove(struct adp5588_kpad *kpad) -{
> -	struct device *dev =3D &kpad->client->dev;
> -	const struct adp5588_kpad_platform_data *pdata =3D
> dev_get_platdata(dev);
> -	const struct adp5588_gpio_platform_data *gpio_data =3D pdata-
> >gpio_data;
> -	int error;
> -
> -	if (!kpad->export_gpio)
> -		return;
> -
>  	if (gpio_data->teardown) {
> -		error =3D gpio_data->teardown(kpad->client,
> -					    kpad->gc.base, kpad->gc.ngpio,
> -					    gpio_data->context);
> +		error =3D devm_add_action(dev, adp5588_gpio_do_teardown,
> kpad);
>  		if (error)
> -			dev_warn(dev, "teardown failed %d\n", error);
> +			dev_warn(dev, "failed to schedule teardown: %d\n",
> +				 error);
>  	}
>=20
> -	gpiochip_remove(&kpad->gc);
> +	return 0;
>  }
> +
>  #else
>  static inline int adp5588_gpio_add(struct adp5588_kpad *kpad)  {
>  	return 0;
>  }
> -
> -static inline void adp5588_gpio_remove(struct adp5588_kpad *kpad) -{ -}
> #endif
>=20
>  static void adp5588_report_events(struct adp5588_kpad *kpad, int ev_cnt)
> @@ -510,21 +506,20 @@ static int adp5588_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>=20
> -	kpad =3D kzalloc(sizeof(*kpad), GFP_KERNEL);
> -	input =3D input_allocate_device();
> -	if (!kpad || !input) {
> -		error =3D -ENOMEM;
> -		goto err_free_mem;
> -	}
> +	kpad =3D devm_kzalloc(&client->dev, sizeof(*kpad), GFP_KERNEL);
> +	if (!kpad)
> +		return -ENOMEM;
> +
> +	input =3D devm_input_allocate_device(&client->dev);
> +	if (!input)
> +		return -ENOMEM;
>=20
>  	kpad->client =3D client;
>  	kpad->input =3D input;
>=20
>  	ret =3D adp5588_read(client, DEV_ID);
> -	if (ret < 0) {
> -		error =3D ret;
> -		goto err_free_mem;
> -	}
> +	if (ret < 0)
> +		return ret;
>=20
>  	revid =3D (u8) ret & ADP5588_DEVICE_ID_MASK;
>  	if (WA_DELAYED_READOUT_REVID(revid))
> @@ -532,7 +527,6 @@ static int adp5588_probe(struct i2c_client *client,
>=20
>  	input->name =3D client->name;
>  	input->phys =3D "adp5588-keys/input0";
> -	input->dev.parent =3D &client->dev;
>=20
>  	input_set_drvdata(input, kpad);
>=20
> @@ -569,58 +563,43 @@ static int adp5588_probe(struct i2c_client *client,
>=20
>  	error =3D input_register_device(input);
>  	if (error) {
> -		dev_err(&client->dev, "unable to register input device\n");
> -		goto err_free_mem;
> +		dev_err(&client->dev, "unable to register input device: %d\n",
> +			error);
> +		return error;
>  	}
>=20
> -	error =3D request_threaded_irq(client->irq,
> -				     adp5588_hard_irq, adp5588_thread_irq,
> -				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				     client->dev.driver->name, kpad);
> +	error =3D devm_request_threaded_irq(&client->dev, client->irq,
> +					  adp5588_hard_irq,
> adp5588_thread_irq,
> +					  IRQF_TRIGGER_FALLING |
> IRQF_ONESHOT,
> +					  client->dev.driver->name, kpad);
>  	if (error) {
> -		dev_err(&client->dev, "irq %d busy?\n", client->irq);
> -		goto err_unreg_dev;
> +		dev_err(&client->dev, "failed to request irq %d: %d\n",
> +			client->irq, error);
> +		return error;
>  	}
>=20
>  	error =3D adp5588_setup(client);
>  	if (error)
> -		goto err_free_irq;
> +		return error;
>=20
>  	if (kpad->gpimapsize)
>  		adp5588_report_switch_state(kpad);
>=20
>  	error =3D adp5588_gpio_add(kpad);
>  	if (error)
> -		goto err_free_irq;
> +		return error;
>=20
>  	device_init_wakeup(&client->dev, 1);
> -	i2c_set_clientdata(client, kpad);
>=20
>  	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
>  	return 0;
> -
> - err_free_irq:
> -	free_irq(client->irq, kpad);
> - err_unreg_dev:
> -	input_unregister_device(input);
> -	input =3D NULL;
> - err_free_mem:
> -	input_free_device(input);
> -	kfree(kpad);
> -
> -	return error;
>  }
>=20
>  static int adp5588_remove(struct i2c_client *client)  {
> -	struct adp5588_kpad *kpad =3D i2c_get_clientdata(client);
> -
>  	adp5588_write(client, CFG, 0);
> -	free_irq(client->irq, kpad);
> -	input_unregister_device(kpad->input);
> -	adp5588_gpio_remove(kpad);
> -	kfree(kpad);
>=20
> +	/* all resources will be freed by devm */
>  	return 0;
>  }
>=20
> --
> 2.36.1.124.g0e6072fb45-goog

