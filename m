Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1DF4F7AE9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbiDGJD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243667AbiDGJC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:02:58 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6C66FA3B;
        Thu,  7 Apr 2022 02:00:56 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2378l6tl010319;
        Thu, 7 Apr 2022 05:00:40 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3f6gb7mru9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 05:00:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nrpp7/APPISiRdSXw0mnkX4/ArfbYA9XzO0sT3JrGpvq6Zmk47/ZLLVJ6fXai66r2pb8v9Tq5fhzM9OLrN86WOUvSNsm9H2Geisl+w9a/Gy0lu69u+LbWrlaSG65MniUJUAXw/9m8qC6PPnZLGlQ1taEYSDXuWxFZzKxJ9lb0MIDdyRNfE1V2BgN8bH7tD/WQ77Tga8aNFJI+xU9QGklpqM/ujNox6KFWzN11oVFsQrlZIMwpbCNbctQlXfWy5fkBBQz9q65eiBYAL3i+kAo+6ZX3m6gxU0PsyKd3Qwxj6/z96n2Z278QLTB/sRUu7k6WjJ3fOT67Ll1dLjiGu11CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWTd2m/On7T5UpeEUCa7gh3PGxHrTWxjDTo9h+JuqCY=;
 b=NtkVKNhq6yupYS9Y7gL02hPa+FsDsWvWgSuep9JSDBpft1bpFlh6QuBz8ogC3GIPI9D6LPg0xk8HscXhkP+xMKx75gG9EM1ufPnu5UUEhK4iBAf6Lbypp4VIBgtfID10neVnH46FZ8PvW7OVy5cA1CZMua1scYD2PosleQlwj6r9AHYM5D2aUoY0NlRH3yA4D3L5fi74ycr/GtviiByEKhk/MMg1/oy24Au8iBvLORkorMDO5uBF6z1nhYPILeL61L//vi6O0iC2dBlm89uExjSfIlubgj03vbQ3fqEkNhvI71yfwJdc3RPYkNHClG+spRw7opZyiPkA31ceVx7srA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWTd2m/On7T5UpeEUCa7gh3PGxHrTWxjDTo9h+JuqCY=;
 b=TsSLLgvw+fVD2BauMn6jgYMbValSDiSlpK6+o5rU3WxosB+FRtZ5vxy9jbbx9m36RmvghLXNpYgzfB5mvAIszJt92O9EX2Z2+DjgAPh5J2Ps4zbaDEYbgMEt46OI1ZIsR7PL/Rv9siLBxGVsdocIYMVhohA0v2qwWSsWLueZ4vA=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by MWHPR03MB2862.namprd03.prod.outlook.com (2603:10b6:300:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 09:00:38 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%9]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 09:00:37 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     =?iso-8859-1?Q?Ma=EDra_Canal?= <maira.canal@usp.br>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: ad7266: convert probe to full device-managed
Thread-Topic: [PATCH] iio: ad7266: convert probe to full device-managed
Thread-Index: AQHYSdqTSgFXrJmo3kmKULvUGA6oZqzkJ89A
Date:   Thu, 7 Apr 2022 09:00:37 +0000
Message-ID: <PH0PR03MB6786A74F55FCAD340E9F443F99E69@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <Yk2t5D2x2+YorkTd@fedora>
In-Reply-To: <Yk2t5D2x2+YorkTd@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMmQxNDVkNWUtYjY1MS0xMWVjLThiZDctZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDJkMTQ1ZDYwLWI2NTEtMTFlYy04YmQ3LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iNzU1IiB0PSIxMzI5Mzc5NTYzMT?=
 =?iso-8859-1?Q?cxNjE3NjIiIGg9ImY3cDJsckE1T0Noc01iOFJEQ0JJOHJmNE1JTT0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBQWlhWFB2WFVyWUFjS0ltNzlGZ3gwNndvaWJ2MFdESFRvREFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 8eddd931-3226-418e-ef25-08da18751592
x-ms-traffictypediagnostic: MWHPR03MB2862:EE_
x-microsoft-antispam-prvs: <MWHPR03MB28629A1B16DEFC1A3FBFC38499E69@MWHPR03MB2862.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o/r4VteyOW26Ff9E8i922iBRwDrjhpWD5xyX1GdI9vdzFMyXANaiKF5AsbFqnIuSsCYfIz/OD+41JQC2Cza+NQ0m8Kxl7Z+TAFAPXs1XjSWvf6H/WUsJs0RAGpoXrZhqnRpqy1JREHmMGwZYxrANZCLi6NFP95eLyKjHFBHu9ALAYEbGX207g1RIZEX8HSsW/yTT2BPtHi+UMzb0p9odn3lCmnobkkIdy7TRsCBQhk/MUDwiXrX8pFV1LOYZ9nCG7h/OKQxTaaon2rX1d8txsLi4IoCYs+gqlaRT4rW0iGnaPQrRe9pwdISNgoMIXKLZtJPPa1aTLQ3nYSAzgfJGBMlnfiBGZkW3PvJn9vySP49TS0Pb50eAGoSgx1qJ04mtZv/pG8JE6anl/oaGBqpyLdtEql1UzlOCOYiZ0Wzmg1oVAwcZakVIqPIkNGOr1wRa0s6p8pMXPGOlQl7ZF1nvEyZqp74RK4UBYbEKwdLIX4ANl4AXvhbfWP+d3Pk6O8/WEJclaMC/mzg1YDC3eVaWPWdhvf9VR2fFqXzYdXmvBjTKHN/WP1Tpxrxmx1ppu1RdtfABqj5e6eg/NnbpcSOM++6hLc9j1EPM0eKPvdPekV7k5gbJ6QarDcGmKKzTEesUZUhdY20RrytKjHy+UHzL2mfWyZoTZ52Qo3/LYf4HOYHaYo234rAogScvuY0i/qvuj85RcrUGReLdO3NDi87NNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(86362001)(508600001)(6506007)(53546011)(66476007)(66556008)(66446008)(8676002)(66946007)(4326008)(76116006)(71200400001)(9686003)(316002)(7696005)(54906003)(110136005)(38070700005)(186003)(26005)(55016003)(122000001)(83380400001)(38100700002)(8936002)(4744005)(33656002)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z5N9tAGdgqcO6+h6joxr4xL+9ALN4LcaHzCMhLf7PkfWpvNLLZ0pQwmaQ6?=
 =?iso-8859-1?Q?TbgI3j6KeqbzTHMpPNivReUXtCmHPa1Zasd5oZyjJq9GUSso/uZJFqB8qS?=
 =?iso-8859-1?Q?KMGIkizImyt7UxovBPjWqpS0K0mm1FPb4DyK2JrBy9Yr7U2NOnCGQ/EP3Z?=
 =?iso-8859-1?Q?g8nbCgxSuyw8LTdXPyQhTQwgHg4gQccdUMiCONOEjAANNurLOuICCSEHGo?=
 =?iso-8859-1?Q?NTOBOdZ5wkUDr9fxK56HDEpwyfa6zlxx64q3LStcaZsj/0tmXEtI8t/YTD?=
 =?iso-8859-1?Q?6l2jw2QYpqaqh950Uyg5FwpqFf8OPjRlSJlwf0rb7zseRon6UWGNeKlqVD?=
 =?iso-8859-1?Q?rjIftn5EmG4ta4MIR2lq/TmQRVeGjxlRARkzNjhzQDhVhrBIJ+V9TkOvZJ?=
 =?iso-8859-1?Q?qd0MxtV8dVDr4QgHEpo2PyOUf1Briu7D6f5tVEwdwFaGXWtb5dA5qjefwv?=
 =?iso-8859-1?Q?6Bug3TkPgMiRvRvzGvp8N8QrL0OewgO6W4rwozia6huMWlEycclLoDv5fw?=
 =?iso-8859-1?Q?Jt/Dgp9UWLZaCmhFCKBuef0ZmBd6MGnpLqrYgujGLEB0S4SC/miQMeDZ8y?=
 =?iso-8859-1?Q?B+hs3Cq+0TXv/+C+cCRSPVrkxT65YNil7T3AJWZSZS3SoRV7rwDmqjFPcf?=
 =?iso-8859-1?Q?qbNYeHWUiHNuk+LNYylWKuRHuXL1scV4n5rBNvysLKlh6Mhk5+eCRXDJ8L?=
 =?iso-8859-1?Q?z6bYVrqJ4gTF30eFr6046gGF+C10wXXnsnt2Y6GC5MumehvFH2zEkeicOO?=
 =?iso-8859-1?Q?/FtHCsTdDuXN/aWBQrtk5Y/C/pQsL+N8eKs6jMalmyqP9P79JBgWwMmyff?=
 =?iso-8859-1?Q?rZXWcIg8dVUgb/5oK5nHd7LdY5A2QMMXTsKXAF2xy3UobFFTOcGpa9bJXe?=
 =?iso-8859-1?Q?sgWD60D7rbnf9QqAbtSpDQL3gz1UkNNNKvpF4J5HC0gcE1MXYubwYxtj0B?=
 =?iso-8859-1?Q?OTwORbolPCqbPw587qRoZdbxE+g1mI57aOutA+x3vQffHUKw6ghKGk/MEb?=
 =?iso-8859-1?Q?woYYonbi+KV8y+hSbIGFgtnQVal0E96OKU3d2L2uXiHB8Lf34XsCB01cLP?=
 =?iso-8859-1?Q?TzJSSOFLTrzy7SJ9MxyAXQXhHGdu8WL8J6+kXYqdkGcfVI5Dtvigqx6+63?=
 =?iso-8859-1?Q?QD5NnB8sYQhOuyX8RTQdv/OFkdvIEZxSgtfCf0aGm/9L/rodzA3RnoJFX3?=
 =?iso-8859-1?Q?LG9cJ0iuPfgUgrBfWqJTXA0HwETrbmebkneN1UPlp2/55xsdpyYAOreKdi?=
 =?iso-8859-1?Q?qFXBcVWNoQLe5UV0+4oQAfzTP+AlqMsu6QRXzCmUrSmdghhpA0lq4NK3UA?=
 =?iso-8859-1?Q?HcwaEGxqKlWDFUztWT6Lyyp1dKYm+ECYwAYwX/YLsDjyxrXafZ0xtz5h7d?=
 =?iso-8859-1?Q?H3jnBmslsV1PBOwltBZp2x+qdWmoBnHKHjF3VGbNRU6kAy4ERFLcF+O8LK?=
 =?iso-8859-1?Q?dcEkTSZ/Z7kXFK1Y6IXpi5PnCXudegEupMiTLqh51ZfvWz94i1pVoHM7d8?=
 =?iso-8859-1?Q?cmOZr4MTpbTUBg4p5m7VBg8vEJ1j8RV0Ckib6iqTBf+zqw8plA7XJw9h15?=
 =?iso-8859-1?Q?voEKp8OzliiaNI10x+Sd39A0y4hq6r415BfKk0nVBdEMSi62oN87ZKbsF1?=
 =?iso-8859-1?Q?42KsGt7BnGzolM8W6f/Xp4MG296MAex0wJ/00HVNAvXPN+SYSgv+tuvqDV?=
 =?iso-8859-1?Q?9+OUpF7tP2VmOHigsDz1qnrWogaqqxDpHmL3184jxaw2cDVsaLK7lqEekv?=
 =?iso-8859-1?Q?WOWylYg1KXYhxHc2a38pyGYYQeEcylkc7+7iO4l/v1FzpDYr0vtrCaElzP?=
 =?iso-8859-1?Q?PVwoAnMkDA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eddd931-3226-418e-ef25-08da18751592
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 09:00:37.8069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qh2AMZ9gaBaxMds0YZBTV+jnoUZCK/r5AR4BR6QcFrfxnubycHmZe/fKjxDdbHVrX/MsNr5BnpsLHify65XMIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2862
X-Proofpoint-GUID: W6Z3FZbAb-B7LGJaAbkcqGBXXtxzymst
X-Proofpoint-ORIG-GUID: W6Z3FZbAb-B7LGJaAbkcqGBXXtxzymst
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_13,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=949
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070046
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ma=EDra Canal <maira.canal@usp.br>
> Sent: Wednesday, April 6, 2022 5:13 PM
> To: Hennerich, Michael <Michael.Hennerich@analog.com>;
> lars@metafoo.de; jic23@kernel.org
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] iio: ad7266: convert probe to full device-managed
>=20
> [External]
>=20
> Convert probe functions to device-managed variants, with exception
> of
> the regulator, which required a devm_add_action_or_reset() hook
> registration.
>=20
> Signed-off-by: Ma=EDra Canal <maira.canal@usp.br>
> ---

With what Marcelo said,

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

