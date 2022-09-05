Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451235AD1C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbiIELrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbiIELrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:47:05 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432CF5C94D;
        Mon,  5 Sep 2022 04:47:04 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2859DLm4010128;
        Mon, 5 Sep 2022 07:47:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jc0s6mvnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 07:47:01 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 285BjwTt017057;
        Mon, 5 Sep 2022 07:47:01 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jc0s6mvnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 07:47:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af0K5/ZLJHFFv2c3V/prCEMGH6POdI6XSyL+MAT5W2Hukp81JW5PWNg8V+EVDigWPhZacLOZbZWk3M44pE80fU+gHO0tyEh2S4bsb5+rY1mvOaeoGAT7ygIndivG7ImIvHsWq9p/Hr6mvRXUYBCFv1ywwf3iKvDyy+U/r9uxyiMkRbWfj0T+u9yj6exwSu+8tXPVpQfpzYZDfXURQISdTosiKr/0BSeL3osMf9fjlAN7aovzQXL4tf2D/KP0z/mr8qmxXVCKLbi7pKsRno1/5Z1oeR4z/jzedNt6+vSkfuK0BY2tzYB1wfsFMaaWRzGgaQv6hu5TuAmbWxqKD9jN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL7R0farkSmBNTvWudLNLYncewEQGgZXTgV1nQnVpAk=;
 b=cNIYsMDeCDfYD9cPyPZkqARR29VvD3GKNndYA940VBO8hhwyU2cUrcHus9x79B4KjLCECW++t0bG4KyIY7T14gn0Z+1RZ62EYt0fVxoUKd6k6HdNsRmnBZEHMsKwY/5qL4YGwlnuQDtwDyWNemXLvcKyZc+ouP59GLSmG8hU97aBJqIprNYgGQ26XKu0n819F9ZkXlHUOwj0RhZf8pzZfRmhoyjzVhkOSo4hUuTJFZbOp7EnY2IKahW2/g3KAT6Pit0CbwFjVZ2pFM2korkoZ+KaeWOiQg+4tEpw6ZW5y4HihjkVwcGW5Iw7MUPSQWPURo9aVgPs1kG0KdkDnQccrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL7R0farkSmBNTvWudLNLYncewEQGgZXTgV1nQnVpAk=;
 b=5ueMbsnalIpqGCQJ3kqU6nprbpa7BfeqWFv9JnS+A4PunQsvk0k7biAYOmR8SBTv8u+ztm5ruEODagx5006FWB9CjINBXp8Btp0IKsHuLRRsoyizER+SfdOn/BGR3ThWf0DO9fchLrwQ2fL3uvCyUc/buVL4yqIZCxLpfPGcYc0=
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com (2603:10b6:a03:3b8::19)
 by MW4PR03MB6946.namprd03.prod.outlook.com (2603:10b6:303:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Mon, 5 Sep
 2022 11:46:59 +0000
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::6175:a08d:5a98:10ed]) by SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::6175:a08d:5a98:10ed%3]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 11:46:59 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Sebastian Reichel <sre@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next 1/2] power: supply: adp5061: fix out-of-bounds read
 in adp5061_get_chg_type()
Thread-Topic: [PATCH -next 1/2] power: supply: adp5061: fix out-of-bounds read
 in adp5061_get_chg_type()
Thread-Index: AQHYueSs6z5z1PPFf0K5TcOUPI4wCa3QxotQ
Date:   Mon, 5 Sep 2022 11:46:59 +0000
Message-ID: <SJ0PR03MB625357900B5B71F5A770874E8E7F9@SJ0PR03MB6253.namprd03.prod.outlook.com>
References: <20220827073224.713803-1-weiyongjun1@huawei.com>
 <20220827073224.713803-2-weiyongjun1@huawei.com>
In-Reply-To: <20220827073224.713803-2-weiyongjun1@huawei.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy03MWExMWVjMC0yZDEwLTExZWQtYjZiYi1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTlcYW1lLXRlc3RcNzFhMTFlYzItMmQxMC0xMWVkLWI2YmItYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE5Ym9keS50eHQiIHN6PSIxNzM3IiB0PSIxMzMwNjg1MjAxNzc2?=
 =?us-ascii?Q?NDY2NjkiIGg9IjRpMnNXS1kyNVlENC9JdmVrQ1ZGd1h2THg3RT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?Qk52UGt6SGNIWUFXcDR2OWVVeTdmQWFuaS8xNVRMdDhBREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBWDVsMkt3QUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1497f88b-1ace-497a-d1e2-08da8f34574f
x-ms-traffictypediagnostic: MW4PR03MB6946:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4k9tOSfg4dKIKi+kFyHMjRjB4TVt4Yo2VWocOY26aYhnB06m+WIOheUxpS/p4RkQq5BpMhsBrIp9L1ojEJb+EhUpajKxFxZicjC6QibE4KahimlEmiYPgTn26mfUoRGkdvtY3Q8z9w4hZwgTTWOMRq2jTYf4EEfhOhLB5s+VXYpH4NDj9Shcj0FKS9qVxbPJ/0YvgEK0Gn0lD/WsoEhufEGnlYlBkIDJQb0GCVBSaboNUwCCgi5b8HuxFhFK/Lt9UfAAcEpN0bibSkXOFOHGw3QLbWDp5hoqIbZJ1x1YrMrx0MUgDdMPr7m6Vwuko/oDxo0blqAceypBNRhhenJKu5vutA5DlsZoK9RH1UEGH8NloqSJcANknNnwbv8bmiWQUmhMr8rocTx+jH/80rD6ttZhV/xNrwIeyo5MAGn91br1gLNtNICkyH/HwNszXD9zkeDOHSO7RBDs4MgNK4akJr1w5fRaBCwRskz+wHgUz+wXLTVM2vOmJe3tC07pHVy8a11zig9ujTQnn/KJSAmKgwdiRKSv8puY7mrzTsvBzZI5oFK9P1Xbax0zi0wj23NbTG9DKsFiQe+5wxNwlJTIeLwyjXFMH4wPlebJdXuIuur28znhAryeJV7BTEaCyFVkf40UkBJ6eGozkU6olR810t5RqfquetM8wENMKVFRjUe2FtBCs+R33EwzqhPw+Z8sKmVuLXfH3RU+bFTEeqKanfP7sqWzoQg4EkmZeQI7mWmw+snuDDOLiAaHqVnRgFikwfV02ZwpGVYy/oTFv5SWkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6253.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(316002)(54906003)(4326008)(71200400001)(66476007)(9686003)(66446008)(38100700002)(66946007)(7696005)(5660300002)(64756008)(26005)(8676002)(66556008)(6506007)(76116006)(122000001)(53546011)(55016003)(110136005)(2906002)(38070700005)(33656002)(478600001)(41300700001)(186003)(86362001)(8936002)(52536014)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GvXzrczh6ThSEKKYHJT0bMMVsrGJ65JzfAZlsbtCEo/wQ3cHZc/u3NkoycHT?=
 =?us-ascii?Q?I9l4coQZ17OUJcmIBF1YrWfyKpDtOtmEuVeavmSi7qmMe24oJtPnTQrja4kd?=
 =?us-ascii?Q?7V1L0Fu5IzORbKAqPEMXDbhNY+jYZNEosXNnOXNHgQzcSxicaInzSa+PTehr?=
 =?us-ascii?Q?GqKe+WMel1SGr2LtmyV4Vjkd0Hx9b2EjkPLtlOlFCVtHQfPkP9IpTt+8plPn?=
 =?us-ascii?Q?yLo8rfGQ4/T/6XJ51L0LWXk4So0a5ShFMxQSgL47yWpuxDPVM6gU/B0q48xS?=
 =?us-ascii?Q?d2Rt+LdL8XpcT4JMf/jU1aGu1WwhsEjS4ZMivvpWn/AJhC/MLVEqfC1ZUyJx?=
 =?us-ascii?Q?9oozIEjnnpt44Us7TMqqO/ExlPeMgzaPskDEvqx7fu8iikHEnhIK4XTpHept?=
 =?us-ascii?Q?QbCnxKae5C9PRHDwUlgDKih+Wy0QVFcIvhmE1pnbxnikEBzhJ+WM4XWA9hX6?=
 =?us-ascii?Q?rfw9h4SySoLvK8/+FNN52Dr+NCqjLJ514I9QwVuo/bawsSKM2gdMJzjaR7x/?=
 =?us-ascii?Q?bhLTWpt8mkStyL8VSO93qPW74Eq2RyNKRdfhE3wosaNVtHGHhBzr51DtImjw?=
 =?us-ascii?Q?Q3PMKTjvWUkfHilakisKQ3zXm7Dvl0bhKpTc5e1Y8a/99T+30qR6CQ8hwDv/?=
 =?us-ascii?Q?tYb91YjuE78bNSz9gL1c/SkMNa+iIBR+W/P3OnMPC42xpgDwX0W651FReNgn?=
 =?us-ascii?Q?n7aY49bKZ87UP8nR2p0w6eevigLEPP3/CEt5sbxqFqppmFmCrFK0T2LeNo9X?=
 =?us-ascii?Q?OmcDUH/a9Tqv0cnKbLIWptARFSkCPH3KtZZkdnED1k/8HqXBJtmQD2iQgIfR?=
 =?us-ascii?Q?HiM1SPhKX1qfHgVN6Y1of38EywBto1es5E0r8CtTGEhT0KTYIqPe0/j/IPKf?=
 =?us-ascii?Q?UECs9bi9J49lbRXI27/j4aB3cyD+gYqft1kX//s+39W3GGEqqt4Rpu4wXaSq?=
 =?us-ascii?Q?Q0aIxMZbFEmW7uXS3a4bM2PCFAEWJEcrMfTYbMKBDvTgrfoUdCf5Dl2NCRLx?=
 =?us-ascii?Q?JD5aWozKXrG+eTPZUHOmd9swB0Vc06IwKwg475SH0YHNG76mBfj3Agt6RMWZ?=
 =?us-ascii?Q?5vcGH2Oue9Yn9w2AOGPnoXy9QCkRhAD76zNZoUuydumhLGpMU9W8Egj+tWYJ?=
 =?us-ascii?Q?09tiLUdIWSbzWO2EB8AjLp9Zy7EmYsrg9rKpk0xxTmyxPHTri+MEj5aBhnUA?=
 =?us-ascii?Q?9ObTcwQNkwM5I7tb8a11VDHyxjt/eg3UfxHNDfQiKYYq7mcbYISBphD2eT2O?=
 =?us-ascii?Q?ttzo+E0k4fqypyeQDS4xR+xTmcIG9YqTORK09/sfWIbweOxyg+Vs18vHd8va?=
 =?us-ascii?Q?wxoTXqgArcs94NJuf34FJ1SxgK4i9pXFP4HFgxxssvPQxtWm2RK+NznCL9ft?=
 =?us-ascii?Q?J0XjtDz+/Nfp8s2JRvk35FXmulYy7V3GxwumWk4Sf3bjl/rOyzHZRjrnAi7X?=
 =?us-ascii?Q?gteGjeahNbiRwwY3iTXIj8ZzftRryVd9b1ywVTSlD14AR7Jdua2zjciG9Sz7?=
 =?us-ascii?Q?lCbO1htsTZB2jwV1o4yvq9cBvUmGcS/E1OqgdsS+oaJS7cnrU8iUfrNsprqC?=
 =?us-ascii?Q?02SGJ4VwhztF5V3NdZ3YRYLNtT2kW91HZAGJzZCVReeWbow2hh7hwY7QrN1G?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6253.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1497f88b-1ace-497a-d1e2-08da8f34574f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 11:46:59.2110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kb7OA+oJw1UXM1fkmMtJy4x/nz30SjlWdaZI/eZCT/3zX6aD1cMtzEb1F5HN+GsutwK8P4JrXnSJ8QBFXjHJ9UKMhEoqJNUQAsKDlYIEpOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6946
X-Proofpoint-GUID: YJOd0MfKyf_AJR-DqYLw0wA4cvEjFoKv
X-Proofpoint-ORIG-GUID: L799wMmdlbP3bsQ-I5UrE0LvzcpqOC3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_08,2022-09-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050057
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Wei Yongjun <weiyongjun1@huawei.com>
> Sent: Samstag, 27. August 2022 09:32
> To: Hennerich, Michael <Michael.Hennerich@analog.com>; Sebastian
> Reichel <sre@kernel.org>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>; linux-pm@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH -next 1/2] power: supply: adp5061: fix out-of-bounds read=
 in
> adp5061_get_chg_type()
>=20
>=20
> ADP5061_CHG_STATUS_1_CHG_STATUS is masked with 0x07, which means
> a length of 8, but adp5061_chg_type array size is 4, may end up reading 4
> elements beyond the end of the adp5061_chg_type[] array.
>=20
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/power/supply/adp5061.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/adp5061.c
> b/drivers/power/supply/adp5061.c index 003557043ab3..daee1161c305
> 100644
> --- a/drivers/power/supply/adp5061.c
> +++ b/drivers/power/supply/adp5061.c
> @@ -427,11 +427,11 @@ static int adp5061_get_chg_type(struct
> adp5061_state *st,
>  	if (ret < 0)
>  		return ret;
>=20
> -	chg_type =3D
> adp5061_chg_type[ADP5061_CHG_STATUS_1_CHG_STATUS(status1)];
> -	if (chg_type > ADP5061_CHG_FAST_CV)
> +	chg_type =3D ADP5061_CHG_STATUS_1_CHG_STATUS(status1);
> +	if (chg_type >=3D ARRAY_SIZE(adp5061_chg_type))
>  		val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
>  	else
> -		val->intval =3D chg_type;
> +		val->intval =3D adp5061_chg_type[chg_type];
>=20
>  	return ret;
>  }
> --
> 2.34.1

