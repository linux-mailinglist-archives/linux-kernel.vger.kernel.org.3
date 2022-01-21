Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC39495DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379991AbiAUKYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:24:48 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:50436 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233456AbiAUKYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:24:30 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20L71bgq016803;
        Fri, 21 Jan 2022 05:24:21 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3dqhy5j13u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 05:24:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3uZIcqhULA2JWo7Wt5nqLCr1gZvMwQITLtCtwU3hU49iKWzTVXcOm50kyg3NA0XWGHaW/490wsO5C0dotIQ+p2STZs7ho7J/vikFAYmECdUR8u5aJqkgh71o86dauZ4Nu+hTpjwGJP9/ve9Y+dSc8RKN4drDF1+l1oKbAwzQbXiavm6hQzZ8aAqzSZRvFwazhdiUPWvSlVo1T6qCUzGN1hJOlgZRXqDuBayPYRH/73MdCn2A4KmqYrFGNoDLjb4U0oLowMC3nQ1c4yTWA+NUD2hWmqkgTfYlZIlOS/NxG559kapm6mH3fpuZiVwQzawVovSsDHA5zhurP9XT9v6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK7OaxRYoWUpzulXMr/kJTwkZMme48oDGkAofAb4DbU=;
 b=anP1Mv1coQsP/R6yKRYfwTbNidDYeUl1ZOsZggU6Abrkc8OPX4gD4808y7JFFvaIu6WVOGJTk0ZaIiem9XgD/83ACMvNfkTmjs/Rb83igfIJUPRID/vIYmdDNDPjKM65UBLBkKGbswR+jzsPy/groP94Da0rgZ1eQbwd4XLJLl/3gVqdCdU5qY/bRE/i/VN5VUZ6HLaxK++XEl/rQgD/qz7M2CE8OB16Tkf79Lka9tXWDUko8IVU+lGsEvGvnFL/ze3qEnolqb5OacJhOq6PHY72aLex/za/dLkdsBnTkxqdnl5FlI0WYoyBBpdg9apZ0HEfxmN/bQF74u1TctJBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK7OaxRYoWUpzulXMr/kJTwkZMme48oDGkAofAb4DbU=;
 b=gK6ac/g7XleWAYiJLeEvu46tI0Kfq6Y1Uz/F7pTo3MVTo05mzGNfty9cNDOcQki/GokXCqkqkKW1Oaxbv3ANHeCASKPqp9W/C+cvMf3pnk/PYNyflPKA+aywN1bB1OQTNRGvt0ehER0syAPv21fGACrwrCtsS8hBEXSRv/1O+9M=
Received: from DM6PR03MB3866.namprd03.prod.outlook.com (2603:10b6:5:44::10) by
 CO6PR03MB6244.namprd03.prod.outlook.com (2603:10b6:303:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 10:24:18 +0000
Received: from DM6PR03MB3866.namprd03.prod.outlook.com
 ([fe80::95e6:b7a7:70f:26ac]) by DM6PR03MB3866.namprd03.prod.outlook.com
 ([fe80::95e6:b7a7:70f:26ac%5]) with mapi id 15.20.4888.014; Fri, 21 Jan 2022
 10:24:18 +0000
From:   "Pop, Cristian" <Cristian.Pop@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v2 2/2] one-bit-adc-dac: Add initial version of one bit
 ADC-DAC
Thread-Topic: [PATCH v2 2/2] one-bit-adc-dac: Add initial version of one bit
 ADC-DAC
Thread-Index: AQHYBuECg5VLWXXOF0mJVfnl1l0ataxlkU8AgAe8uvA=
Date:   Fri, 21 Jan 2022 10:24:18 +0000
Message-ID: <DM6PR03MB38660D97C97334644D755FD7E75B9@DM6PR03MB3866.namprd03.prod.outlook.com>
References: <20220111115919.14645-1-cristian.pop@analog.com>
        <20220111115919.14645-2-cristian.pop@analog.com>
 <20220116115228.1f7b4728@jic23-huawei>
In-Reply-To: <20220116115228.1f7b4728@jic23-huawei>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3BvcDJcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy1lOGQ4NGNkNC03YWEzLTExZWMtOWE3Ni00MTU2NDUw?=
 =?us-ascii?Q?MDAwMzBcYW1lLXRlc3RcZThkODRjZDYtN2FhMy0xMWVjLTlhNzYtNDE1NjQ1?=
 =?us-ascii?Q?MDAwMDMwYm9keS50eHQiIHN6PSIxMjAxMSIgdD0iMTMyODcyMzQwOTU2NDI0?=
 =?us-ascii?Q?MDYxIiBoPSJmQ290VWdqWnRRT3hWeTRTckczSVNuS3BRQWM9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NBQUI5?=
 =?us-ascii?Q?cHk2cnNBN1lBYUJkZWpXMVJGVVRvRjE2TmJWRVZSTURBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFC?=
 =?us-ascii?Q?ZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhB?=
 =?us-ascii?Q?WmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5?=
 =?us-ascii?Q?QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZB?=
 =?us-ascii?Q?R29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRh?=
 =?us-ascii?Q?Pg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b7a49c6-6d61-4e0c-66fc-08d9dcc82e92
x-ms-traffictypediagnostic: CO6PR03MB6244:EE_
x-microsoft-antispam-prvs: <CO6PR03MB6244A3283C75A5A19FC74F40E75B9@CO6PR03MB6244.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zlp5F54IGlP9XEt6CamxX8SFBXyOQcbkbN6TdChLkVFNNVPXiPCeMhlrw7wcruZGnWj9zfzATk3QvhZ01MHOWjqu2g3xU1Yi/xcWPDrSdAqd5lf8cD+iXeqJtLh9HpP7U9DlSTJFlMwfO2MG5AwudAEX5CifRk3Y2addjENUSCYCOHlNniT7tW4A7IoiBLwHPjXVlr7xnh47voZe6xDyBx5L9i2gnTi7+L3FehFIzkqP3VWhrcX/DuYnkx2T647UHCHO25qTDwxDEhg8c2mNSBkX8XLBWrNzyWj1ECxbTI3DLXM9Fhez0wZCpua+BfY3AZvaBQAsI2qPe51rHy6JH4kTDnu8NAO92Iv/zSshzzKW5YGu3eQVIfzken0UDgDqgobQg+Jt5Vik5zmpqwovR7ONBJAG/hs68JnMvsWSHvzX7zELEZjJozVOb6rHTV6qojaeiJDhR8XxAU4aec9loJruCDHZEU/B0i/7L0VpFbAiqQ1cLxY0ymH+sgg+o+fsV5fRdA7VnTSfriLSXegMEW9i6IUbNLeDiA/3la2Kn90ru6Er980T6vPtYbQ4If1fnJ+fJoZQfo6ynbl9vYkwIopHgHOQIe4ndVwOZ9Pwl7aGQGZf1vnOGJY6BbEwGJyRFk1+72g+uPsUorNhcyWohd3TH+j9aD9ObMqybzbETHnUcuxGjyQVsdsvEypZvAF9/HkuiWy3ujuJAyX/gUWP+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB3866.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(6916009)(4326008)(508600001)(55016003)(7696005)(66556008)(66476007)(64756008)(66946007)(53546011)(26005)(122000001)(66446008)(316002)(186003)(76116006)(38100700002)(6506007)(54906003)(9686003)(2906002)(5660300002)(83380400001)(71200400001)(8936002)(86362001)(33656002)(30864003)(8676002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0D5WqdR5nYV4j5pY30bfHIGCyDL4bhJwUF8fCplKECYl0oF1659ma+ZPKua8?=
 =?us-ascii?Q?D0FbpTBAEeKMiZ9fEqoI+gX797Kbyk8b3D4THqXNaAyBqzNrh5wUZGQ5sCSc?=
 =?us-ascii?Q?4UW8+V6/Rf6/u82//IaGm0tlKZdVm4GuFaNWn6IUnVe59fb1XF8UNqbZum/V?=
 =?us-ascii?Q?8CfixTho/S/93nTdMpWJGdgthy8vbC5kNyWy6BXs65iS6zCynE33mjaC438q?=
 =?us-ascii?Q?7M2ZxMSQd8XBtm0lWtuk4esPtRYgZUAJKR2lOmHpmDWzrjJi+e2GVmyCPo6n?=
 =?us-ascii?Q?6gINYvrOVhFK9DZdlgG2zD1l0uLiFGMri6UrHOSRRiwppBFQSxirjEkp9/6Y?=
 =?us-ascii?Q?9401wG+bTcwMIcJnLUQGkeufOxm9dR5uP0KwINNKpDfV0a2gHhB3x+piFFTH?=
 =?us-ascii?Q?JO9XM8YSEGDE3cQtrE2WNUdjiwymycrU5RJvXYiZTyOKctWnthV0q65Nm9Gd?=
 =?us-ascii?Q?NeuPL64Aa6YrOdUO1Et2D66GwGXqhKJf8mhssCbLpMWK3XAxulh+dTXs6R4H?=
 =?us-ascii?Q?vmpgSiCMrlwofpMwFus4bAcKFs0Gm8Q4aiqWCDojwrPd75Z5zMQStM3irdm6?=
 =?us-ascii?Q?LMFlz6sleSpCND6l0CEWZC38JDr5h64VY7mu/touqFB5WcW5weGgosFwI7Ah?=
 =?us-ascii?Q?LOa3ZmqmejnQxZrTs1AZWR7D453FA7Q1vEEuws2ySe/Alpo7CvNCImYaK6Ri?=
 =?us-ascii?Q?69ApddgDEq/E0cfKQIe5I1359sjoKqLesc1fhKF1Q++hVIerzRJqs3ggA9OJ?=
 =?us-ascii?Q?aRlCKgGMr8rf4GH574xcApGNyjU4pc9d4E9xc00BcFljomRzjYJfe5pBYLGo?=
 =?us-ascii?Q?ZXehuopgNWLnkSkJUwKBj3KDNQE5mD4imzSosnoY1WBx/mjcC7QjMgV89K08?=
 =?us-ascii?Q?SvM0mR9TzLIjUmPvxNCoZzrFpX7SfI3MZM2Ndx46YcD3bZUrErBhPLQm5ry7?=
 =?us-ascii?Q?qviu8xuufA0ImMzgIgxFRtCsrNAga0EsHC89+Rj79dP8s3+Ut9dqy6WCAEHQ?=
 =?us-ascii?Q?EXY/5sNXwJ2d8RKAVgeTVIBtZxOUYzQHwOmVRaeMPh89fQcg+OXWiwx/7LKb?=
 =?us-ascii?Q?p973NWGt9XQ1jaGVaMG9lG0dIDaO/cMIWrAisdYc768zD1CR35DWwNB7Dbtq?=
 =?us-ascii?Q?t0t8kSBqo54Hr/oN+Ax+ReAoHf3CqVVXhW216qbj11TU+LmQgv3ANkVrTqAe?=
 =?us-ascii?Q?pr+IiC15U8pAlw9MoKXF2TfRmAWjp3efIgIQH6cm0siQr/UEDRmE/+nrI57b?=
 =?us-ascii?Q?2xeDpnhLq5XU1RZIBL9Q/8XJmGrBs0tJohxzNH+/8cGhsr1QxYaQSRZK4jzo?=
 =?us-ascii?Q?KbLpRilgQRAAkfFMPVWViVhUkNQMcXN3QyDUTt/NMIWI+XOMylPeNTc35m+L?=
 =?us-ascii?Q?wNKivchZaWmFPL7Nl6HcI8pNXgjOE9tQszLlIvgC5QsvdEv9NRz7ZFpPlfcY?=
 =?us-ascii?Q?GDvK/H39G6KXSQWP8E4JtakKAQsqahCeMrd2D6by3nTfqKNq2MJpOm+v6ljx?=
 =?us-ascii?Q?HJgX+3f4j2Tgveuxfeue4xzhFNEFpzG9ZhvfyxBfNtLzNRfe33+7+kcREyNw?=
 =?us-ascii?Q?6gnuD9ccHELEMysQPvRi2QKQ4SRTi+2I1OaKULmKxdRt+fWumqSNBd42/xAf?=
 =?us-ascii?Q?OA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB3866.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7a49c6-6d61-4e0c-66fc-08d9dcc82e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 10:24:18.1614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbE/0gOz7P5I82WFbj2JCt1NwSQMucGYhQbZ+sjRNvZtKrh6qZdUK4q4DFySh9R3hTTs3frX58eZyJyg9yaafw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR03MB6244
X-Proofpoint-GUID: hO9UG703DdFcveu_F794FgQn-xn5gbnd
X-Proofpoint-ORIG-GUID: hO9UG703DdFcveu_F794FgQn-xn5gbnd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

The additional functionality it is a little bit unclear to me.

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, January 16, 2022 1:52 PM
> To: Pop, Cristian <Cristian.Pop@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-gpio@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; robh+dt@kernel.org
> Subject: Re: [PATCH v2 2/2] one-bit-adc-dac: Add initial version of one b=
it
> ADC-DAC
>=20
> [External]
>=20
> On Tue, 11 Jan 2022 13:59:19 +0200
> Cristian Pop <cristian.pop@analog.com> wrote:
>=20
> > This allows remote reading and writing of the GPIOs. This is useful in
> > application that run on another PC, at system level, where multiple
> > iio devices and GPIO devices are integrated together.
> Hi Cristian,
>=20
> So I fully understand why this can be useful, but it is a software only
> construction so I'm not convinced that it makes sense to necessarily
> configure it via device tree.   A better fit may well be configfs.
> (note I always meant to add configfs controls for iio_hwmon but haven't
> found the time to do it yet...)
>=20
> As it currently stands, doing only polled / sysfs reads this driver doesn=
't do
> enough to justify its existence. You could just do all this in userspace =
using
> the existing gpio interfaces.  So to be useful I'd expect it to at least =
do
> triggered buffer capture.

What do you mean by triggered buffer capture? Should I save previous GPIO
states into a buffer? What should I do with them?

A useful use case that I see:
- Is to register a function callback (in kernel space, maybe user space tha=
t
  should be used by a different driver), and called in the interrupt handle=
r
  when the state of an input GPIO changes.
- Output to a GPIO from a buffer using a clock, obtaining a PWM like signal=
.

>=20
> When we have talked about handling digital signals int he past we discuss=
ed
> whether the IIO channel description would also benefit from tighter packi=
ng
> than the current minimum of a byte per channel.  Perhaps we don't
> technically 'need' it here but if we do add it in future it will be hard =
to retrofit
> into this driver without big userspace ABI changes (i.e. breaking all exi=
sting
> users).
>=20
> I've not repeated stuff Andy got it in his review (assuming I remembered =
it
> was something Andy raised).
>=20
> Conclusion:
> 1) Creation interface needs a rethink or strong argument why it belongs i=
n
> DT.
> 2) Driver needs to do more to justify it's existence.
>=20
> Jonathan
>=20
> >
> > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > ---
> >  drivers/iio/addac/Kconfig           |   8 +
> >  drivers/iio/addac/Makefile          |   1 +
> >  drivers/iio/addac/one-bit-adc-dac.c | 229
> > ++++++++++++++++++++++++++++
> >  3 files changed, 238 insertions(+)
> >  create mode 100644 drivers/iio/addac/one-bit-adc-dac.c
> >
> > diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
> > index 138492362f20..5f311f4a747e 100644
> > --- a/drivers/iio/addac/Kconfig
> > +++ b/drivers/iio/addac/Kconfig
> > @@ -17,4 +17,12 @@ config AD74413R
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called ad74413r.
> >
> > +config ONE_BIT_ADC_DAC
> > +	tristate "ONE_BIT_ADC_DAC driver"
> > +	help
> > +	  Say yes here to build support for ONE_BIT_ADC_DAC driver.
>=20
> Needs a lot more detail here.  Though naming it to be explicitly about GP=
IO to
> IIO binding would help.
>=20
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called one-bit-adc-dac.
> > +
> >  endmenu
> > diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
> > index cfd4bbe64ad3..0a33f0706b55 100644
> > --- a/drivers/iio/addac/Makefile
> > +++ b/drivers/iio/addac/Makefile
> > @@ -5,3 +5,4 @@
> >
> >  # When adding new entries keep the list in alphabetical order
> >  obj-$(CONFIG_AD74413R) +=3D ad74413r.o
> > +obj-$(CONFIG_ONE_BIT_ADC_DAC) +=3D one-bit-adc-dac.o
> > diff --git a/drivers/iio/addac/one-bit-adc-dac.c
> > b/drivers/iio/addac/one-bit-adc-dac.c
> > new file mode 100644
> > index 000000000000..5680de594429
> > --- /dev/null
> > +++ b/drivers/iio/addac/one-bit-adc-dac.c
> > @@ -0,0 +1,229 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > +/*
> > + * one-bit-adc-dac
>=20
> Improve description here as well.  It's really just a wrapper for a gpio =
in an IIO
> channel, so just say that.  Fine to say the representation is 1 bit ADC o=
r DAC
> channels as well, but I think the GPIO part will be more obvious to the c=
asual
> reader.
>=20
> > + *
> > + * Copyright 2022 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/gpio/consumer.h>
> > +
> > +enum ch_direction {
> > +	CH_IN,
> > +	CH_OUT,
> > +};
> > +
> > +struct one_bit_adc_dac_state {
> > +	int			in_num_ch;
> > +	int			out_num_ch;
> > +	struct platform_device  *pdev;
>=20
> Not used after probe so don't keep it around.
>=20
> > +	struct gpio_descs       *in_gpio_descs;
> > +	struct gpio_descs       *out_gpio_descs;
> > +	const char		**labels;
> > +};
> > +
> > +static int one_bit_adc_dac_read_raw(struct iio_dev *indio_dev,
> > +	const struct iio_chan_spec *chan, int *val, int *val2, long info) {
> > +	struct one_bit_adc_dac_state *st =3D iio_priv(indio_dev);
> > +	struct gpio_descs *descs;
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (chan->output)
> > +			descs =3D st->out_gpio_descs;
> > +		else
> > +			descs =3D st->in_gpio_descs;
> > +		*val =3D gpiod_get_value_cansleep(descs->desc[chan-
> >channel]);
> > +
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int one_bit_adc_dac_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int val,
> > +			    int val2,
> > +			    long info)
> > +{
> > +	struct one_bit_adc_dac_state *st =3D iio_priv(indio_dev);
> > +	int channel =3D chan->channel;
> > +
> > +	if (!chan->output)
> > +		return 0;
>=20
> -EINVAL;  It's an error that should be reported to userspace..
>=20
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		gpiod_set_value_cansleep(st->out_gpio_descs-
> >desc[channel], val);
> > +
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int one_bit_adc_dac_read_label(struct iio_dev *indio_dev,
> > +	const struct iio_chan_spec *chan, char *label) {
> > +	struct one_bit_adc_dac_state *st =3D iio_priv(indio_dev);
> > +	int ch;
> > +
> > +	if (chan->output)
> > +		ch =3D chan->channel + st->in_num_ch;
> > +	else
> > +		ch =3D chan->channel;
> > +
> > +	return sprintf(label, "%s\n", st->labels[ch]); }
> > +
> > +static const struct iio_info one_bit_adc_dac_info =3D {
> > +	.read_raw =3D &one_bit_adc_dac_read_raw,
> > +	.write_raw =3D &one_bit_adc_dac_write_raw,
> > +	.read_label =3D &one_bit_adc_dac_read_label, };
> > +
> > +static int one_bit_adc_dac_set_ch(struct iio_chan_spec *channels,
> > +					int num_ch,
> > +					enum ch_direction direction)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < num_ch; i++) {
> > +		channels[i].type =3D IIO_VOLTAGE;
> > +		channels[i].indexed =3D 1;
> > +		channels[i].channel =3D i;
> > +		channels[i].info_mask_separate =3D
> BIT(IIO_CHAN_INFO_RAW);
> > +		channels[i].output =3D direction;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int one_bit_adc_dac_set_channel_label(struct iio_dev *indio_dev=
,
> > +						struct iio_chan_spec
> *channels,
> > +						int num_channels)
> > +{
> > +	struct device *device =3D indio_dev->dev.parent;
> > +	struct one_bit_adc_dac_state *st =3D iio_priv(indio_dev);
> > +	struct fwnode_handle *fwnode;
> > +	struct fwnode_handle *child;
> > +	struct iio_chan_spec *chan;
> > +	const char *label;
> > +	int crt_ch =3D 0, child_num, i =3D 0;
> > +
> > +	fwnode =3D dev_fwnode(device);
> > +	child_num =3D device_get_child_node_count(device);
> > +
> > +	st->labels =3D devm_kzalloc(device, sizeof(*st->labels) * child_num,
> GFP_KERNEL);
> > +	if (!st->labels)
> > +		return -ENOMEM;
> > +
> > +	i =3D child_num;
> > +	fwnode_for_each_child_node(fwnode, child) {
> > +		if (fwnode_property_read_u32(child, "reg", &crt_ch))
> > +			continue;
> > +
> > +		if (crt_ch >=3D num_channels)
> > +			continue;
> > +
> > +		if (fwnode_property_read_string(child, "label", &label))
> > +			continue;
> > +
> > +		chan =3D &channels[crt_ch];
> ? Not used.
>=20
> > +		st->labels[--i] =3D label;
>=20
> I've no idea how this works...  Should be looking for the chan->channel v=
alue
> as that's what your read uses to index.
>=20
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int one_bit_adc_dac_parse_dt(struct iio_dev *indio_dev) {
> > +	struct one_bit_adc_dac_state *st =3D iio_priv(indio_dev);
> > +	struct iio_chan_spec *channels;
> > +	int ret, in_num_ch =3D 0, out_num_ch =3D 0;
> > +
> > +	st->in_gpio_descs =3D devm_gpiod_get_array_optional(&st->pdev-
> >dev, "in", GPIOD_IN);
> > +	if (IS_ERR(st->in_gpio_descs))
> > +		return PTR_ERR(st->in_gpio_descs);
> > +
> > +	if (st->in_gpio_descs)
> > +		in_num_ch =3D st->in_gpio_descs->ndescs;
> > +
> > +	st->out_gpio_descs =3D devm_gpiod_get_array_optional(&st->pdev-
> >dev, "out", GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->out_gpio_descs))
> > +		return PTR_ERR(st->out_gpio_descs);
> > +
> > +	if (st->out_gpio_descs)
> > +		out_num_ch =3D st->out_gpio_descs->ndescs;
> > +	st->in_num_ch =3D in_num_ch;
> > +	st->out_num_ch =3D out_num_ch;
> > +
> > +	channels =3D devm_kcalloc(indio_dev->dev.parent, in_num_ch +
> out_num_ch,
> > +				sizeof(*channels), GFP_KERNEL);
> > +	if (!channels)
> > +		return -ENOMEM;
> > +
> > +	ret =3D one_bit_adc_dac_set_ch(&channels[0], in_num_ch, CH_IN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D one_bit_adc_dac_set_ch(&channels[in_num_ch],
> out_num_ch, CH_OUT);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D one_bit_adc_dac_set_channel_label(indio_dev, channels,
> in_num_ch + out_num_ch);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->channels =3D channels;
> > +	indio_dev->num_channels =3D in_num_ch + out_num_ch;
> > +
> > +	return 0;
> > +}
> > +
> > +static int one_bit_adc_dac_probe(struct platform_device *pdev) {
> > +	struct iio_dev *indio_dev;
> > +	struct one_bit_adc_dac_state *st;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st =3D iio_priv(indio_dev);
> > +	st->pdev =3D pdev;
> > +	indio_dev->name =3D "one-bit-adc-dac";
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->info =3D &one_bit_adc_dac_info;
> > +
> > +	ret =3D one_bit_adc_dac_parse_dt(indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(indio_dev->dev.parent,
> indio_dev); }
> > +
> > +static const struct of_device_id one_bit_adc_dac_dt_match[] =3D {
> > +	{ .compatible =3D "one-bit-adc-dac" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, one_bit_adc_dac_dt_match);
> > +
> > +static struct platform_driver one_bit_adc_dac_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "one-bit-adc-dac",
> > +		.of_match_table =3D one_bit_adc_dac_dt_match,
> > +	},
> > +	.probe =3D one_bit_adc_dac_probe,
> > +};
> > +module_platform_driver(one_bit_adc_dac_driver);
> > +
> > +MODULE_AUTHOR("Cristian Pop <cristian.pop@analog.com>");
> > +MODULE_DESCRIPTION("One bit ADC DAC converter");
> MODULE_LICENSE("Dual
> > +BSD/GPL");
> > \ No newline at end of file
>=20
> Make sure to eyeball your patches before sending as this sort of thing sh=
ould
> be caught at that stage...
>=20

