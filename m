Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BD94E8F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbiC1Hp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbiC1HpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:45:22 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C4352E4D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:43:41 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S4S1hq028564;
        Mon, 28 Mar 2022 03:42:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3f1yr5bhg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 03:42:45 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 22S6TeEO006596;
        Mon, 28 Mar 2022 03:42:44 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3f1yr5bhg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 03:42:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiOj1cPX6I0yN/9n6xgwGtGewe/Xqa3nDqXb5ENRBbmVPi6MMOS8K+Z1Rx142U1IQc1mQWg0Nm9QLt9S3AEtBQqPem3oIvzpsrjXXn8MChfY2bIQxHqnpq4gSgAwFVSjkdiuXyyn7Bb906oVeddISkHZ1xOBgpYUO1DvPlo8poWGAEigoaTCYUqZsDTsh1cTois52ouomW46WrsWEZn81VmlQMK3dhv6vA5UDF3pueSjRU+4vftMdnhqkZSGigG+BsyHKTYHDBlnzvXaFeca+2fWzXy55EAdapBeSHQM8EQjzOgFAeDyXKn4Hf6pziQNMygTQKss0xexgiBa1YhBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM1grNVPj5oF1BzJbHE+SSdoRY9DUvBPsUlHyGGsc+g=;
 b=PWSY14UkLTNxvNDe4cZWpOf3zFqKocbOF9UHsbG3hs0XRqpMjqpXEBdcJXptDQrMgV9QTxgzgAUPjemQS+NXkOAKVRm+m+sJtk7OUlDmfpeQZG/ZTWXRRjAlw00ikrAbRGGLEIQjmfAg2Lt8XfKkqQtnal5pfkkpIkS00wjjufLb8w5JACfoc/0Tn22cRxgY4RJ0nJVP8KtLLEKjYpbQD5RIZWr0igaq85qLjB+XTd0VJH00SxqYxDrjqXTiTAUtiwi3tfkED6TndlC3gKji0zJNairznqwr/lTd1KGeigKUhrf6B+njOtNs2PBJoNcXexHdk6+NdaLVEvGT07zk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM1grNVPj5oF1BzJbHE+SSdoRY9DUvBPsUlHyGGsc+g=;
 b=pihb2kTumUtfRGashYUK7O5Dhxl+cy5zgL6ruWtg5Vd08myjkVrT8NPIjMMNbGHN97gIkjEm1PFKSVGsqC5TP2JFTzIQlkrWLcXfRCytZ/O7zTVaIyrMoPXe26E+Jp7T09b9PL2i5gkt5Ijux+emN7fO6lPV7h+kGqRYZXB3vrU=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by SA0PR03MB5484.namprd03.prod.outlook.com (2603:10b6:806:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 07:42:43 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97%2]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 07:42:42 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Steve Lee <steve.lee.analog@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ryans.lee@maximintegrated.com" <ryans.lee@maximintegrated.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "krzk@kernel.org" <krzk@kernel.org>
Subject: RE: [V3 1/2] ASoC: max98390: Add reset gpio control
Thread-Topic: [V3 1/2] ASoC: max98390: Add reset gpio control
Thread-Index: AQHYQkk6ZcDoheE4OE68GiZS/SX6S6zUabcA
Date:   Mon, 28 Mar 2022 07:42:42 +0000
Message-ID: <PH0PR03MB678617C7A854827D0EC99010991D9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220328021139.8700-1-steve.lee.analog@gmail.com>
In-Reply-To: <20220328021139.8700-1-steve.lee.analog@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYTRjOWMzMTEtYWU2YS0xMWVjLThiZDMtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XGE0YzljMzEzLWFlNmEtMTFlYy04YmQzLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMTc1OSIgdD0iMTMyOTI5MjY5Nj?=
 =?iso-8859-1?Q?A2Mjk5NDk0IiBoPSJEMTVidVRRSG9FSEpZZ0NYTG1hVjFueXVYZVE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJtdHlKbmQwTFlBY2dSdWNidGNzNER5Qkc1eHUxeXpnTURBQUFB?=
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
x-ms-office365-filtering-correlation-id: e512ba97-79f2-4e7c-a19e-08da108e8af3
x-ms-traffictypediagnostic: SA0PR03MB5484:EE_
x-microsoft-antispam-prvs: <SA0PR03MB54845FB8046BA8A847DDD74C991D9@SA0PR03MB5484.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WgYao/PqNJ0sfDf6+Nqno6v2+KOYYF2zylR2S7tqeJfRa3p3McR4yejO/xW/B56iqOOm9P/z7EzZpoCzsKieiUKhDU57uCtWsPWEYPvwrlkFnl/vnp47GUywDZcF2x9559GriSeVZhyGN2+w7294wnWwE0Wu62KMU9A91JFHZgEzkVpwMFF8q7O7leUC0wRL3iq4KSDuL6KcTcFeAFo4hncE+O2L4+RUekFOwrVXc6hEJfSXwUy9gNKDdwLXUXX79+jJkYuYv3jtWaYPEx/IV4ufq70rshs1HpXPuBJHJ9hCtvYgj/A8fZ/05/HgP97xFcTEIFjwED3F0rQ/SN5t8vHBzjDgoh6YPROMy6fRGqpm2o4Fr1g9hmkDOfmp9UTrKTk4zOY6c0lA7D6EJkvZhvcbCxnX7QHwDhAV7nlwVcq9Yq18skdTsRrLayVCOEKE+JcaByNl+9TEY0Oh2nvzxLdafKvSRoxH/6C6BoLRXjQW2k5cwb4FHUlYBqcMiOMZOaitxa1f2XXZ4IptEVdHVuI0qSGHeYeo/RSWz5Zn5l14DTaHRr1hnHby4mrXCj7d2T0qA9i1cuK2uR6bkBSyfzD6819CcV3IP9ZbzrogLsGsF1+LikJgfsWLu98iqu95X3E1I8RTg4Bz8/HCDCFWQ/6P2XfJ59tPp2ECpyP9fkziUG7n4IMJnnjEfTkbnmivv7eltshDA4pI7N8PspqySg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(9686003)(55016003)(2906002)(38100700002)(316002)(110136005)(122000001)(66556008)(66446008)(66946007)(86362001)(76116006)(4326008)(64756008)(7696005)(26005)(5660300002)(508600001)(186003)(38070700005)(6506007)(8936002)(53546011)(33656002)(52536014)(66476007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Szz6a5PZ3sfDOsY/Xf3u4B+665w27WVSEFaZFr/l4tWWGFzfCI5Nh/jrt8?=
 =?iso-8859-1?Q?r1BASMqsNHq9Up9ZDLoLn54k0Gtg5g81SjWDuvIqWqskbFLEN5qsgBmwIF?=
 =?iso-8859-1?Q?XipA55suhBkZtzUQWB4ec2wnHvITJZO7RqqgwhQ4h5HoA/WWBPh0XFXQbk?=
 =?iso-8859-1?Q?Ad/ygQryTQRuUHIiiK5dHj/b21ZgB9GX+CdbLVFa2tF3YPWiECLQfrlJV5?=
 =?iso-8859-1?Q?tAIwWEwLqEKnrBwEH0AI08ydiN7nAmduQcmAAXXg9l5kmYU2069qcUNbBH?=
 =?iso-8859-1?Q?Tddltw9z1XIKEa6U2zpbMgUYnqk+Bx+QsCUYNu2Bm5gaZwtFTNvQk2X1FZ?=
 =?iso-8859-1?Q?oYx4GK/iMYlvqkemX2NTIT6NSzNpm1JKECfoPDeOQMUXeJkQEKXh6gEE4k?=
 =?iso-8859-1?Q?bS4T4PMHcPvJCDk7v5z3HI8ijQ5EFHzyZXlOGYrzdxny7+jkzEDbxEF8nV?=
 =?iso-8859-1?Q?/NW9Z7MpBWPo6Gj7W3YDDMqf81rSKRKgG/PBtiK8pH2K7OxfxeDFZB69N9?=
 =?iso-8859-1?Q?d0WXbJ9w3nc5gFGXZCxi4GVdVoAw9S37fBfiTh71X8pbQC6kA/niuF2Ncy?=
 =?iso-8859-1?Q?U0Nmn2lZq6tr8vSejDEcpaGxLLJ0n4Rc7dvEU+hP4tHJw/QS4ZvKXvZ9J3?=
 =?iso-8859-1?Q?qXIBMPyyNGjM2RqQRvr68pKYqOGoDQcUNuetL78KTiKX+3URiwiC8I9IF+?=
 =?iso-8859-1?Q?c+JilrIbskk55V0/KCQ1L3BCrKbBIPvfG+k87Xk/7hHJuHBfWieFeVnww+?=
 =?iso-8859-1?Q?cgRvSe3CCOfXKpJO6KUdVJMM9PwScKW7oceCh6S21WuXr1gOw3KdBRxqpk?=
 =?iso-8859-1?Q?5uvtKsBHcTsZ4MQBZJ0hq3bQeYpTGiKpUlL9b4bXQcYr0+KtHw3F46V+B5?=
 =?iso-8859-1?Q?Lzp5zHTP3vE+VkKI3AYMaem8FvPzBukkLn9oQuKgrvLOa4dSMIdC9YaTfP?=
 =?iso-8859-1?Q?pAxWiECwBZqv5f38lgAC3q4xcHMdGbF3xHxOKnCfleZHRgI5Y8Mx5prQfk?=
 =?iso-8859-1?Q?sPrCVcVz+RBu4NJsSMkfhWNMkZb53r6VcZezXtylkUexj0rIOE+xRij6i7?=
 =?iso-8859-1?Q?IYojRPzFxG565wKL2cDYB8eIeKiS/kNPk2nX4qBdZJSKD1B2NIo5xkAxfC?=
 =?iso-8859-1?Q?cRQKpQtbN0fPVDvBGC03o1dFMSbtRBxn173CmHYPPmXq5XLPSo5jOgDi9N?=
 =?iso-8859-1?Q?E+Oh2jDaLfXogBr+mDL+/MsU4rh5Vm/Dv/Gs21m1u3tI9xmawAxPPJvx7Z?=
 =?iso-8859-1?Q?QU7IdxSQoYW+VkpbVxRGFtDHT7oSd2XKf5SP5H5xYdYGeHilMrSaqB3Fec?=
 =?iso-8859-1?Q?rgPvPOKfdQ0Mb9ZOebE4Tv7SeMoeR2707OYADhBJrywhvvfzq2oTUCUzrB?=
 =?iso-8859-1?Q?jJonV0jjvL2uqbKGWevnpNzCu1hqTFBc4yBSz4osnIJw3VM6IQb4+LMUD2?=
 =?iso-8859-1?Q?9Ywf+ia2gx3GdVGqmFEeHmLoPj9INRzx/47wKEd9U3901s5aY53osvPopc?=
 =?iso-8859-1?Q?mdOFuS1qrb2y4iFf54a5ET5RcmYRg1t1sOaA41lOLxq9sFlbZaglzfgrQl?=
 =?iso-8859-1?Q?ecpGOwUZZGT1QrWUe25YpJj48UKATu5P3pfUtR9PIgS873WlfRKyxV0RON?=
 =?iso-8859-1?Q?9ojCs1pHqI0KRkprMnmGG9btGsYuYslpqBKzuQq+hovPKDeJ3gENbRq5th?=
 =?iso-8859-1?Q?orqL9EH2ccJsYf8BwUZLLTI1VnAdcqsj/GVAONxEuRUnpDWybFyqgS8iAD?=
 =?iso-8859-1?Q?klDDMVlLJ6Odb4FvRloxph4iK50bKWksiVyxUQYZGTLAN722olCj4yrFhT?=
 =?iso-8859-1?Q?kSN1X/2xhA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e512ba97-79f2-4e7c-a19e-08da108e8af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 07:42:42.7875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8p+SgO/8kT4p4AIJRj1J+ItQo9m7TnzjAfQ8KnRWxpAFCbf4MGGglUDlO/gNgd6p670EsnkkpAJsMapaPq/e5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5484
X-Proofpoint-ORIG-GUID: sqoYQRi-Uhlo8ffJGehZRKF35rUeXqXE
X-Proofpoint-GUID: pbUIhyoIWSXtQ1p5L7IQ8gElF68bblmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-28_02,2022-03-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203280043
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Steve Lee <steve.lee.analog@gmail.com>
> Sent: Monday, March 28, 2022 4:12 AM
> To: lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz;
> tiwai@suse.com; ryans.lee@maximintegrated.com; linux-
> kernel@vger.kernel.org; alsa-devel@alsa-project.org
> Cc: krzk@kernel.org; Sa, Nuno <Nuno.Sa@analog.com>; Steve Lee
> <steve.lee.analog@gmail.com>
> Subject: [V3 1/2] ASoC: max98390: Add reset gpio control
>=20
> [External]
>=20
>  Add reset gpio control to support RESET PIN connected to gpio.
>=20
> Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> ---
>  sound/soc/codecs/max98390.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/sound/soc/codecs/max98390.c
> b/sound/soc/codecs/max98390.c
> index 40fd6f363f35..05df9b85d9b0 100644
> --- a/sound/soc/codecs/max98390.c
> +++ b/sound/soc/codecs/max98390.c
> @@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct
> i2c_client *i2c,
>=20
>  	struct max98390_priv *max98390 =3D NULL;
>  	struct i2c_adapter *adapter =3D i2c->adapter;
> +	struct gpio_desc *reset_gpio;
>=20
>  	ret =3D i2c_check_functionality(adapter,
>  		I2C_FUNC_SMBUS_BYTE
> @@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct
> i2c_client *i2c,
>  		return ret;
>  	}
>=20
> +	reset_gpio =3D devm_gpiod_get_optional(&i2c->dev,
> +					     "reset", GPIOD_OUT_LOW);
> +
> +	/* Power on device */
> +	if (reset_gpio) {
> +		usleep_range(1000, 2000);
> +		/* bring out of reset */
> +		gpiod_set_value_cansleep(reset_gpio, 1);

Note this will set the gpio in the asserted state. Being it active low, thi=
s will
do the opposite thing that you are trying to accomplish...

- Nuno S=E1
