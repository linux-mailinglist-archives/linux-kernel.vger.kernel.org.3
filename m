Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F30E58C45F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiHHHq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiHHHq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:46:27 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544F1E0E2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 00:46:26 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27871Qm1027800;
        Mon, 8 Aug 2022 03:46:23 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3hsmx82e92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 03:46:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEI4ev+9l6Hm9b3TmnT7kqrZLui/jMdWgFv/b5ogW4UdDcdPIMwgsF2JV0VKzHoPmWycK6LHpD018n+odDat/Mf595J3k71TR5s4XIXsNhwm/5pWOkDOo9No0XoBN0eVsAVYLesP91is8a9VatpfeXCcZcdKCBSLjyCozgDe/YhLdpV63l+ctA/9dcIocpo3nSNPOWBNGoZleCeqLv/M0EJIy3xSpBoeTZ/D+WX6yhrulV+iuxvySVzjvu9+8W60dybQvUtyNzPnEqtLbOKEamDdK5A3VFtnxUVMhZcEc6h299hEJtcuWmHXaEF4KxbySNU7UFyKqtTTndRHZ2zLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QHQjHzSVyQx8zFTIV+4fUpHrWuwAEeuVS5oUjj7Dxg=;
 b=PRzGSWTwystYd1h2W1YR4Hx2fB/F8TfaRFyvTcK8Z4PhGZfA1kHxMLtWVUsv36oOJthSWnYEaNFdANe739AsXzpKiEykvA1dR/KsCOGwI2RMVToK07/aKUFAwmmFFFNd2cn3ejUq9OQMQfI/UXx/aIerutC50/QBaFZOcT41UYYA+daoF0E/HYupInnEgXdChau3318QlDatUiOrPZo5I4mH2JRbupC3G//8JHuAQNY6EcJDKVdNHjjdL5LeHRUqltu5liYZJiIluyoXdUnF/DtBnYhkMO9FB5dABLuMp7slbQ0hr9m+hxC1GU3KnZvWgnks/ipLn9S9VxhbaIfvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QHQjHzSVyQx8zFTIV+4fUpHrWuwAEeuVS5oUjj7Dxg=;
 b=mbhnfggC2Nyaluyvl8YaPK54yonlA0ddFV+4m0lc5eQ5Po1cl2/1CwmDXoQHaUppMqlkVcwTEjZPN7HuDfNloa72YaGshU3CIJIv44iG6eHqtM6iYlJf/Hp8PPUAzWzkQ2ETXFLsfgVeg9pXH4/ImM13yrUiSrfF+aBvasHWaWw=
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com (2603:10b6:a03:3b8::19)
 by SA2PR03MB5724.namprd03.prod.outlook.com (2603:10b6:806:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Mon, 8 Aug
 2022 07:46:20 +0000
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::6175:a08d:5a98:10ed]) by SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::6175:a08d:5a98:10ed%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 07:46:20 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/28] mfd: adp5520: Remove #ifdef guards for PM related
 functions
Thread-Topic: [PATCH 03/28] mfd: adp5520: Remove #ifdef guards for PM related
 functions
Thread-Index: AQHYqm1rqu9lghc4kUaaAW4yKT0hIK2koPGQ
Date:   Mon, 8 Aug 2022 07:46:20 +0000
Message-ID: <SJ0PR03MB625392B802F508EADC2819808E639@SJ0PR03MB6253.namprd03.prod.outlook.com>
References: <20220807145247.46107-1-paul@crapouillou.net>
 <20220807145247.46107-4-paul@crapouillou.net>
In-Reply-To: <20220807145247.46107-4-paul@crapouillou.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0yZjMzODA4Yi0xNmVlLTExZWQtYjZiMC1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTlcYW1lLXRlc3RcMmYzMzgwOGQtMTZlZS0xMWVkLWI2YjAtYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE5Ym9keS50eHQiIHN6PSIyMzk2IiB0PSIxMzMwNDQxODM3Nzg0?=
 =?us-ascii?Q?NTk4MzUiIGg9Imx1MlZUc3RuNTdMamtETkhhTzdKbWw1STlNVT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QzdBSXp4K3FyWUFlSTZGSG9tQU1RRjRqb1VlaVlBeEFVREFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 663ca060-5382-4afc-c05a-08da79121567
x-ms-traffictypediagnostic: SA2PR03MB5724:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vokP7iCCV+UvS/KAyqx2Aj/lDcdBSOR2p5NtdCCf885jZcFzqNemCEKsYlxJH0YSlc001qR6aecUwWicKqom74FsoYSrdJX942EhJBhWWNoFJQVROBqYvwBPuuuBIM+2mr7YzLEkm5tQd8R4vNDaE6iDDRfDYh/yWlGjzBkq3B3LDsuWB0kXb+7rHlT9X67PSjv38o7xmBfwR1jDN5g17SoFFhJbBJD0pTGTnJnQuuasvkQ4oj4JlzVzd/+z6KcV4TaXzk+X+ffEN/tLP6MnDXuLJ3+VSrzrfTxbO+fh5vEyiRE0JetaaqbDQBtGCmMJiGSteBbmnwQc7wbekCIxzzHLz9yccGMACtAXzAlSzr/viOmF/ZyX9E+xF60iCKfxiu+0OP92ADwacDcBDS1Ew4RAvxZrHRjurmlVofheNT+rxvzYhHCg/cV5XKRMz2mXqBFac9UFYA7Pi0vAu2P5Gz7Icli5oRf0CQPn+pcz2ZxEGuTYVlkDoUgHiF3iMIek22vIhJF0EmgRHz4XPmjzWD5BwnJXpd0udsSAb975eLO7HggnHJlU56hdK6irg8WAwe+8c/B+/8oKF+UQGIBicTF469nh9eBoXF5hN5yppX0T9yvnWZXsT9dE9qhxjwsixcGFWAU3vvARPllV7oW2lA8F4xoVtr+KP4cMRGgvussr5cytRihxx7m5vUxqtCRyzWsDZ8hlsuT06Zpto961mR7xhKEkDyMjUVQCAUazZ5FbNwQVYCpo5Y5u2uCkeGGxcM/d8hGoFfkjKI7YNzYvHuSIWCQiGCNhHQ0N9mgzNFMNdd0L+UBgP9uGBwHvkEso
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6253.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(4326008)(76116006)(66946007)(8936002)(122000001)(66556008)(8676002)(186003)(5660300002)(66476007)(66446008)(64756008)(316002)(110136005)(52536014)(71200400001)(478600001)(2906002)(9686003)(26005)(33656002)(41300700001)(6506007)(53546011)(7696005)(55016003)(38070700005)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QTwj/sAp/7Apuuu8c1vnWu8g4O0LQwSFg+FYjD5jXYjRxl70x8NK/dqU7wFm?=
 =?us-ascii?Q?/N/DWipzBefcsXo+lr9a0TuiHJQQ9Z9yFLugacqoR7TVcl8cMtfTc/NjqSty?=
 =?us-ascii?Q?HgVLteDxvxxya7dcOeq918kgvhKkct1HiOKIw1nSBvNPC+H8jjA/pJ3R55E0?=
 =?us-ascii?Q?j1ns/WGPvr/GSlQf+YznEJ4ttr0UugRSLrCZm3UWV3ILHr41AQtEAlleFur3?=
 =?us-ascii?Q?zVGXQYyPr1A/tdGw12mT8oFIMQsclUakudQsXvSmyKsInzUxCjTsgBtbD28q?=
 =?us-ascii?Q?I4toXU6ZAuH7zalIy7U66VT7wFQ7qrL/0ghmktqG3fkh/SddyHaRqloNZ8CJ?=
 =?us-ascii?Q?P34cAmeTw6TvA9o8u0GEetc+ahCe2AT2QsJSBN0bjxRvauprPf3nvD4DzDFc?=
 =?us-ascii?Q?g0hP/7UyKKVL7Ht0Q0dzmszwXzIvM35m/0AbS8tBSw6Fx7BLqmtsD818Hswf?=
 =?us-ascii?Q?MgEbHV9ZvTiKHPQOfz+B+TcJmvvnt2Dxbxc7715TZ5eB4CmV0mypxe8QJUmD?=
 =?us-ascii?Q?FmXENfdGA1GZTLwAm+33CY3DVdLz4klMbAAVZN38x5LMAbZDa1UM6KRbNjQo?=
 =?us-ascii?Q?99daJVTBXFjNRxJWdD1But0HKO6ZpznG8n9AxryVqsAdPkRH0iaaX7+PKHuN?=
 =?us-ascii?Q?69yUdE8Vv8VLeCS5122eXV43ysPmN91qHYfMrdLf8W4R5LIT50PInoJuJ1BE?=
 =?us-ascii?Q?eQ8j5d39BKKjXoNHgg3f+pU/LP94hGQm/t2pn5VOkFpm3WcY4DUA8xB5CUKm?=
 =?us-ascii?Q?Ig56wHGtMaZUiJiv0nwouJ2yD5Okb93X3K0k/O9zbbvlXM0R1R6jCuYqmlpo?=
 =?us-ascii?Q?/RBzHhHJ3ANrnojYo4KH/MQBkXFpnf19tPxLmESQ2pdQeCZkknFGOrk2se6D?=
 =?us-ascii?Q?q40MTtwsL0W+PvoODQgzk+KOv7rkReeIToDSIS9kDnEagj0v+B6jo4v7Ntd+?=
 =?us-ascii?Q?yHacEwU+f0C/Zz1sY285ovqFsAW1IN1zUgEPewul1Icp0wIxzqOAlAwI/u8o?=
 =?us-ascii?Q?pEtxOVwCTyPnaB7/PUUvoXEK6ced1lKiBUqxXpravR1fA9izRDM1bmJdIOu9?=
 =?us-ascii?Q?YahxsAbnRMMiicGqXGd9da/1h2s/UQpsFlwyzaF6rai4R5eppcpaqivfp1YA?=
 =?us-ascii?Q?9fnNwqoN9ztGVsTHPQrsviz04v8kboJJFPokwnml+6mLH1qw5O9XhajhyQhR?=
 =?us-ascii?Q?yVZoQiWJUS/nR0LiNIAhLbq0YudmN7KU/1J9l1AtX7i56SDGmViRcGEBvnP0?=
 =?us-ascii?Q?ToJPZCbOptROb3Mosup4AMXpoTkl9ZA9iyervHtpIi3wRYbTtSpkd3ocHkTF?=
 =?us-ascii?Q?3/U8Y6rBet9z78O3+f3BWUnrTwUfNMZelBU6X+1Hqj/vUDzn87/Qg6utdNZF?=
 =?us-ascii?Q?/eqt4zdJsqNXe/eRVA5pVf2J+kx3bl5r8O2BK4wwyEfI2IHJbQVpuV5nYXh6?=
 =?us-ascii?Q?JyAl/78e5kWFkfwdCwLLOacpBXcaYIWGBO90GYZm0AlFnfkQjgyf22I4T2pV?=
 =?us-ascii?Q?he1xaETFAhbr/nW0XIT1SJjA3i+Ar8U8zsNOm4D39YiX5rSksAUYeGfn0AcS?=
 =?us-ascii?Q?/sCw7sMxQMcVNVeoTr2llOc3k9PxfkmPLi8TUHHHs+UFHV9ZwBmPdILg4oO6?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6253.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663ca060-5382-4afc-c05a-08da79121567
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 07:46:20.1202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCjFJHK7ScjIgISlHDw0m7/7fxTo73gy4Fzd2qFUZcPDdg5HD+x8g+YdvFjjDOVAsXX8Z2Zvz8A6jrXaEbbxTiPIL/pB6iVpTIZNWo4Ybus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5724
X-Proofpoint-GUID: NPS3mR3Lg7V3vf3y9O_hnsiwO01Dh7L2
X-Proofpoint-ORIG-GUID: NPS3mR3Lg7V3vf3y9O_hnsiwO01Dh7L2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_05,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Paul Cercueil <paul@crapouillou.net>
> Sent: Sonntag, 7. August 2022 16:52
> To: Lee Jones <lee.jones@linaro.org>
> Cc: linux-kernel@vger.kernel.org; Paul Cercueil <paul@crapouillou.net>;
> Hennerich, Michael <Michael.Hennerich@analog.com>
> Subject: [PATCH 03/28] mfd: adp5520: Remove #ifdef guards for PM related
> functions
>=20
>=20
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
> to handle the .suspend/.resume callbacks.
>=20
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without
> having to use #ifdef guards.
>=20
> The advantage is then that these functions are now always compiled
> independently of any Kconfig option, and thanks to that bugs and
> regressions are easier to catch.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Michael Hennerich <michael.hennerich@analog.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/mfd/adp5520.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c index
> 8db15f5a7179..882eddc32f8e 100644
> --- a/drivers/mfd/adp5520.c
> +++ b/drivers/mfd/adp5520.c
> @@ -305,7 +305,6 @@ static int adp5520_probe(struct i2c_client *client,
>  	return ret;
>  }
>=20
> -#ifdef CONFIG_PM_SLEEP
>  static int adp5520_suspend(struct device *dev)  {
>  	struct i2c_client *client =3D to_i2c_client(dev); @@ -326,9 +325,8 @@
> static int adp5520_resume(struct device *dev)
>  	adp5520_write(chip->dev, ADP5520_MODE_STATUS, chip->mode);
>  	return 0;
>  }
> -#endif
>=20
> -static SIMPLE_DEV_PM_OPS(adp5520_pm, adp5520_suspend,
> adp5520_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(adp5520_pm, adp5520_suspend,
> +adp5520_resume);
>=20
>  static const struct i2c_device_id adp5520_id[] =3D {
>  	{ "pmic-adp5520", ID_ADP5520 },
> @@ -339,7 +337,7 @@ static const struct i2c_device_id adp5520_id[] =3D {
> static struct i2c_driver adp5520_driver =3D {
>  	.driver =3D {
>  		.name			=3D "adp5520",
> -		.pm			=3D &adp5520_pm,
> +		.pm			=3D pm_sleep_ptr(&adp5520_pm),
>  		.suppress_bind_attrs	=3D true,
>  	},
>  	.probe		=3D adp5520_probe,
> --
> 2.35.1

