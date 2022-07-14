Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41676574922
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiGNJgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiGNJgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:36:05 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2119.outbound.protection.outlook.com [40.107.114.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864283334A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8RT4rTGnxBDesRbTgqwxUlcOu9zt7hbt0efWrdeIkN2jVJL3S7jUsMxlHv0j3NoCwnUMLoU7nb1OKNJscy8JBJ7+dLT1wF3hPTji2rpJ0vdig8YippLiHXgVnukUjQioNI/+xoHCudbPJ2FShFHMeZl4kkKnLTpTGpp81XFhcULfyJbgexZgwDEJOb74vyxyfJGlKeU7gdyD/W2qAad8bplWWXB7sBKKDZMvuEx7wgcoW1muL0yt8AfUZYu4XJEFAJ2XevVjbysZZqib3tJYR9jnR7RZtXMA31nSmrbCtow8TYzy5nOCqAMNQDD86MHW1sAjL/pKlwssW/z2jEmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QOhAJsNOO1WR+xKHn3RIBYIfcbw/0XYVIj45hkIrTA=;
 b=gBCDOhey3WO5QoH6bvsebe6R7DmqDZTiTfI0n9LcCNL/sa0dCjgsY7hxqQx+hfads7yK39MJjftAbq058rqlid21Nm/CVZM/yzAr+xX4cQmN7mxYJmZkaxMrgnqmgI47/T3KbRpzdYy4GSlV7pAg17FDZ1XBtszKjEudx9JYRivAELZUNkUfJXrp+PvWjjvIsKNe4PKwK0Q6kr7Ll7Q/nfu058RECfBjc0rQJOLYBm55cDCv6q2jIi+jH5+sA24W59ur8mKj1PJIsivG602kHoA/W4hoh5fikKwIPSRfaf/ASyDRjCCew9CA+/Uvnb/+HSCiMBy7Ds5H5fuN0Lt6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QOhAJsNOO1WR+xKHn3RIBYIfcbw/0XYVIj45hkIrTA=;
 b=l/xhHFqTUsDWV0RrdjHl+9cObgt8rsHsYje9PrmszECGXkRwT1A2M7NeMLZvm269w1/lvKeu5RsW8arVP5ZxYiCimAEUbqNYYFG5ffH+GWHk2h+WRSW+QoAPS0mB+46d5fHZTmKdwTgIxX3dCI1So7vZTScl9E9Fim64ku61kLk=
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com (2603:1096:604:6e::17)
 by TYAPR01MB3136.jpnprd01.prod.outlook.com (2603:1096:404:86::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17; Thu, 14 Jul
 2022 09:36:01 +0000
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::d083:eb12:1d4a:6d05]) by OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::d083:eb12:1d4a:6d05%7]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 09:36:01 +0000
From:   DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
To:     Benjamin Bara <bbara93@gmail.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: RE: [PATCH] regulator: da9063: disable unused voltage monitors
Thread-Topic: [PATCH] regulator: da9063: disable unused voltage monitors
Thread-Index: AQHYlrdCq5lz15FMVUKTHjEqq/kPea19nLfQ
Date:   Thu, 14 Jul 2022 09:36:01 +0000
Message-ID: <OSAPR01MB50602133D5009DFE59C93458B0889@OSAPR01MB5060.jpnprd01.prod.outlook.com>
References: <20220713124958.3094505-1-bbara93@gmail.com>
In-Reply-To: <20220713124958.3094505-1-bbara93@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72cd65e1-6eaa-4adf-9415-08da657c43c5
x-ms-traffictypediagnostic: TYAPR01MB3136:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o2DCV1eYU3cBkEBn++QrVgGugCwDzTcw6NZpdUHBZh5wOuD3zE2+tIF2OmfTcSCDh4rJBwu46+R4gthK7l6brnTLFuSL1/o+VW3sSlSQT67eVoi6BL3ZBGOgn8Fq/b3aSyQiHZOdAPJD1UOusE5v9QPJUuAeATj7xbI1W+nvH42bVLmnK1H3DM3waARnSsjKke8n8wniRevBRhdDNXB4ucDsEZ/sR7+Ku2/iltSa2sf4G+HwA9VtN85VwUEGquIptzqi3LJG0XsqMkJiZJQ+Qe+yir9EamJMi31OYW+BRvaQblpx9YjkwcuO1hlv0fDNzpnkvEwNzba5kWUo5Ot4sCeERIr+YOxa5udE8S3VOXj7qvBJF3jO7gATnQ/jheLCEFkzqoIJVg7CHvieXpSTKCBeJ48Gj9HwO7jdb00GuvP4KGDkouZulghdS/g9HUqUNonrjV+zW71UhW1/Y8sdFIkG6JgBd9ryCahAXU/GZu1TZ51lY9quMGui3fhpES/fRiOQdFV/rGrg7u7YwRxj7ri+1dpgUAt5U32Ii89I7l4YLjI+Iw1ZU9jWxEvkZIaO3PHdUJRmoh/3Yr4BI6BIKqZ+tYHz3kXz+L1R83+o9o0FtVrXDA8IHOFs0QbkyClJta7qC/PbFepI4iUhfYrBo4QN8L6BFkQraUCI48PnAFE5Z5iCbZoql0FQwbgsrBnz5WwvzVsu8tY++IQ9I5Y7ardDn8d1mNr7vE/xWU/wW+FgH1fnpIm0ghjGFBFyswNlb65gs/sPGLJU8wB4DOwttAw6H7VD8Ir0TPfqYTR5Kd0pzT02WzttrXP/RwnYd9at
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB5060.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(66446008)(5660300002)(38100700002)(86362001)(122000001)(8936002)(53546011)(83380400001)(4744005)(316002)(52536014)(66556008)(71200400001)(2906002)(55016003)(186003)(478600001)(41300700001)(66476007)(6506007)(54906003)(9686003)(26005)(4326008)(38070700005)(8676002)(76116006)(110136005)(64756008)(33656002)(7696005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X30wKA0s8zkh2Z25leq5GYbgvkFJb+FzWA/aj/TKZrW/p+isLhnpwClEC6yd?=
 =?us-ascii?Q?4TMOR829HRvEGtCE4pr0nA3t4WK7cRGyycIIILpwygalgbrUb7tkO5zIGGN6?=
 =?us-ascii?Q?lc+46/ltgrc5yxqvcRkf4wW1KF7HyNfKuLLyvnTOBjO6OLb4tX2Ti6R7YN8W?=
 =?us-ascii?Q?hg7TtCyk7kmUOxnun3rQREwDSLz6stsoM7rGd2/P5DRTP0/Q5UI7YQwa8OP0?=
 =?us-ascii?Q?nTJArV2QMK5cW1DE5gFwcAJKNf/l5SPdM8p6cNmNcB7/kgyA3tyuH/wQX572?=
 =?us-ascii?Q?PIKRmVpVHLh+tB4Bj2XS/C6x0kXhDQkRVQzGWT8Q/T6iZIQEDgkXDTGPaCTg?=
 =?us-ascii?Q?rAbxIWOKoesDKLYaJ0zAEX/uQ4dpLViDnGDEusu7Se9j7v/gP/Hl7/BjkNRY?=
 =?us-ascii?Q?G0h0gScUXU/C1XANGP1YOCkrJM+A4X9XQrBG0G01Hsm8z0Cro9OrdzEy42BK?=
 =?us-ascii?Q?lx36kyi1fa04g75h2B437cL570ZhT+apx3w5qHEHQMexVjQ5TaX/BxtpRAHh?=
 =?us-ascii?Q?+VEQOyT4b8Pyue2u0R5OcoyA7TXcxQ4RV1Ln3Bh2Q1Cv6Ff09xeHVhe0jZmW?=
 =?us-ascii?Q?G7ui7b5WyqW9NDhibsoZysALk3U6RWZtPfU+o4wmKq7Jn787aZcPb7BqClaC?=
 =?us-ascii?Q?xWU/ixmWQ9zDXBCkr6rcVH0KYk28N4/pTzaQrYjrQXhhScNTmzLs391GOXXn?=
 =?us-ascii?Q?ycyq1saKJBjW93U5LYuq37k4I4Pe70es4NjLH6YuHPZh1me4cyJDE3d8VMAZ?=
 =?us-ascii?Q?0nxmMYFvdIT0uU336KrZynCX0Ls+wkvQUYsHFeHDXQ4j+s3yJEskStkpjEot?=
 =?us-ascii?Q?VkUQHkYOHQWK004ixJ5REpGI1M0VRs5xljaH7keDCtEyhR9EtJYIvaZQAx10?=
 =?us-ascii?Q?SUF28xUuiLkwDL3g5O9VvbXZhuyd14Dk/U5vCQW5+kNya1Ow4Q2ZTRLCqApc?=
 =?us-ascii?Q?SBoZVzvdYDUs+qi4nwkoyddBsc+qTKOhGWBVL8YL9Ozj6+1g59QKvoUV7Zqq?=
 =?us-ascii?Q?SA19ZmwHossN8xlqaFOIc49nXwdyR4MW1A7Q4l+OVpryH8M0AhiB+MwmD6zb?=
 =?us-ascii?Q?6UZalyxLeR+NSfPnC4JP+aB47MXqLHfFeqKNYtHv2sfx2ORZGnq/iyggdzfY?=
 =?us-ascii?Q?a3rJSB1uVqQSVaq0+nPwG/C6JI23O4ZCbbIzeruzWt+JMy+F3zeuPBQ9Dgiy?=
 =?us-ascii?Q?PAtaysCg/rmcTgDegch1pBHzCNbjBtj5t3izsLdP2W723WX9YQ2s7rT8H9Ir?=
 =?us-ascii?Q?LfEgBA37oQt2gWCiHvKI9UavH4G+yuDVyBu5vPFlp+bM+fvV4JthobuRldMJ?=
 =?us-ascii?Q?lzU4rQ76tKO/orKB+oj12bv9Zc0Tk36JQeuV1Rhy5C+yIyUA4n7S32CYflAT?=
 =?us-ascii?Q?l/do5vyJLDR4qcGCQoVBBulpsm1ZYQX69r2gO8rXu1DmjLjxd0S1t3iujhfa?=
 =?us-ascii?Q?UajqAzkm40O4SjddugHvGTucfUdteQ5CabDJIGY+Jg9t0/1InSy+fqDL9t87?=
 =?us-ascii?Q?7XOPK8wqj7B02QmpdLTgX8V2J8Rg0ptXbd6RX46lPMaStrCC1rjf0yiTD9KN?=
 =?us-ascii?Q?BxscZt/lwj6Oh2KPmLEo6HkIsB7DJf8xyQjB1pxrsKOBPjsjfTRcXHN+yiOJ?=
 =?us-ascii?Q?aA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB5060.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cd65e1-6eaa-4adf-9415-08da657c43c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 09:36:01.3249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8izolvXlvfh2ifPkKzCWbfcs2owRCgBYIf+ANlBTA2ORemS+4Qz6ygPVq6Nc/+Vwb5s65MhRX4w74YmyWQaLZiiBlmPsnHM0NC6dVW6wt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3136
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SCC_THREE_WORD_MONTY,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 July 2022 13:50, Benjamin Bara wrote:

> From: Benjamin Bara <benjamin.bara@skidata.com>
>=20
> This enables the kernel to disable the voltage monitor of unused regs.
>=20
> Some boards might use the PWR_OK functionality, which asserts GP_FB2
> if each measured voltage is in-range.
> However, if a regulator (which is enabled and monitored) is disabled,
> also its voltage monitor must be disabled to keep a valid PWR_OK state.

This proposal seemingly doesn't work. If you disable monitoring of a regula=
tor,
and no other regulators are being monitored at that point, then GP_FB2 will=
 no
longer be asserted and you have the same issue. What's more this patch impa=
cts
all users and there's no means to re-enable monitoring. Certainly in the cu=
rrent
state this isn't a valid change.

What exactly is the problem you're attempting to resolve through this patch=
?
