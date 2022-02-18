Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDFD4BB9E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiBRNNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:13:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiBRNNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:13:33 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF12ADFD7;
        Fri, 18 Feb 2022 05:13:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcOCbXXBfSMjzjOjLvY+N3Tbh/PqV656VuHOLrCpJEhWB+KfA7avMqNFitR5vCXpXC8XwFucBnBkqEGbutERphO8DxcUMRIkAG7O6vgbEH0hO/Y40nvs8nS8TiCIEoP2EYBOUbNWI1KVoOsnJVRFbgodfVIGF9p9R1o73dzOvjmJ3LF/tHWExF4QQsT54rtJTs8CYOIQJMwnH8OzgUVQWJnv0CKRLjFZif/rRsiL7W3upaCtVZjk+X/rnl57xW/emJcNSxQbB+gc8dzv6QFN19bGqmFuZgnxjrV9oHhhwNro3WiRPKev5UNCeAaNUCWCmwC3rPOYiGbnwefIW+Mqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXXi1ZLDfNi06EUk4PQKjQZmqKQD3bm3r9HBJW9ur9A=;
 b=cPc3uf0XHOJQJEeU3VAY6iBVB4YdlrIU6pC/lJB/4+kUF2s7zXuw5liEYy8Do3zGWyJtnu2PKpqvNTiAfXApedNW/jz+6IG24B/vUGIZmTcm0KO/F8y7pegPNVZ1uL3/CMQJWH3y1T9lgB28OownSQHOMrVvCqM2FfySPcGKx5N8Ef94s+TyNKU4n9cbDBvIIJpEdj6S0xSxdkRZn7YDydZE8fjBnwwKfHB5u6Gw5P9/E1DWpRngya+mcCmsks9j53WXNwR0ygqepWoj+tY9RtGpJmH1nFCenbinZakwllm70WzxNTJmKrKOeI6xHd6+HDyeDNfSZeK8tbzN/I9Ufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXXi1ZLDfNi06EUk4PQKjQZmqKQD3bm3r9HBJW9ur9A=;
 b=ZrS7EBvKFqtk5E+TS3rshPMX/0CTslkM+IyyUCYFTeTtvz4hG6mTWOZgyewf+c1QvnSGsIDoBH+K04/dUYRLCNXwj7oTb43diJQh1xaGTCF/Nrc4AInInSPmrQkVI1w5/V4Jm5i1XtAaes9TUp/LZ61dQctLUmzWKqVvyHdwgYY=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by PR3PR10MB4160.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 18 Feb
 2022 13:13:11 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acd3:e31b:a13e:b0db]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acd3:e31b:a13e:b0db%6]) with mapi id 15.20.4995.017; Fri, 18 Feb 2022
 13:13:11 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Sebastian Reichel <sre@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] power: supply: da9150-fg: Use
 devm_delayed_work_autocancel()
Thread-Topic: [PATCH] power: supply: da9150-fg: Use
 devm_delayed_work_autocancel()
Thread-Index: AQHYIQLYZkJpMV3yBU+s35Z4V4Ora6yZT2CQ
Date:   Fri, 18 Feb 2022 13:13:10 +0000
Message-ID: <DB9PR10MB465210AEF84FD0F390B1616480379@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <c4cf74b56258c679f69bbc6350179b8b500f5800.1644774892.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <c4cf74b56258c679f69bbc6350179b8b500f5800.1644774892.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f3e83be-bccf-4355-8cf1-08d9f2e069d0
x-ms-traffictypediagnostic: PR3PR10MB4160:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <PR3PR10MB4160DC828EA98C709BFF9CC9A7379@PR3PR10MB4160.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVHn0zgxoVBkVCnRa10AQX7CugJkdQ/UdXSMFt51Xuj2r6H4VY2fIrWU4cgQnT2P6aCK5FdOFz9ppTyJWIPpKtzLza0dgB/yZnpqt+rKQqmCvW2HsZniXZbGJQUuSeawuEWKK5BOMyBDVxSgnntD1KlP0vNmQkC6aIXQUuilM2rEC1/l5TZpD/sxXfHWVT3cVCRrZIPTyREdXNC4hC9k17+zb2SZWuiy9XIXNGE3RH8/rtdW/qLmqmO3uJsHTKa1zBRgJM1ivfH5LYP2/TY3dv2YEsMuQxPLo2B/P1MPr+7CFnwUGOwb9E/KiwxQuvo334TJoSlzqiltSYNFjASkGBJHTDaQ4FdGl3xw74Xkbz9EZH23cH3pdAlGQPtd/mdVg6sZJMaA0J/AcpJXCAHo5TAectrwD0iu5Q7UmE1NDzph7X6b52bI80LrhocJawYN0R1gGwqVZHlDqfn+z3lZctUXC8M4W/kCw4D0Pvn2eXv7OGaiHxugwOxMokpdNJhhFtL46OibNA4pVyiLDe0XFYn/oojM1+sLqM3LQGxYqJKfeyXIkgzxROATcN5ud6OO0K0SmHvhW9MS9/M0TcbWiOAT9y0HfdMA7jl1FWuFhr5SEzbQEYxXdwDk3yX6XYzoARXcj64bXUK1/TxPSNqmfeXnt9JTJ56iNMi8q2HLDLqIXwEzMfkktmdv0ldNaI/mnSPk7hQCBPpKg3jGbLk9Ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(64756008)(76116006)(316002)(54906003)(66946007)(6506007)(8936002)(8676002)(66446008)(66476007)(508600001)(110136005)(33656002)(86362001)(4744005)(122000001)(38100700002)(38070700005)(7696005)(186003)(9686003)(71200400001)(26005)(55236004)(53546011)(55016003)(5660300002)(2906002)(52536014)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jgxR6rzUUdy0032sagFHCmF8Jqr92eUQ3x11G/jSXoCPiMq7sgUwftzT70Qx?=
 =?us-ascii?Q?YPTt7bDT6urYg8RDmBYwUUt/jYXmldCqI5nGkX4DfCh3raGZ7F8fgwMG/wfa?=
 =?us-ascii?Q?6aV0l8g7pFi5ZvYRYnI3R6NyAFZ9RhLyPsXS20Og6+Y2ngUze9jDZlTXMXvP?=
 =?us-ascii?Q?Mx9LLMLJ5ahAvQncczxjDvFo0PaDdmduQe9/p8pZ+pAbGy+MTy8BFIhUM628?=
 =?us-ascii?Q?oZjl1G8nSlmgaQwcbqs9rKAikdV7VQy/9t12Y9zmFVXFefl7BATE6gq+eXgj?=
 =?us-ascii?Q?rAIyvqnORUp9uYsK8/GiHm4j7V9MPJteY/IHEn3wKXDFAnA68oKUx7Iy3TZA?=
 =?us-ascii?Q?aB+0vzhoL6nUou6zoCgV1+TnR5mHJyIH2LWOHmo6RCT90fSt58pWjl+6ODfN?=
 =?us-ascii?Q?GL6CNlpd9WplMaQhhBboixbwdco2IpQ/D2G6ssTOZNWnebfopNYeDUOSfX+B?=
 =?us-ascii?Q?872moFyyIit8FwvhYTBh30n6Ha0dtMetFFngMvxuXbnnIYzum0Bqf1BsOh5k?=
 =?us-ascii?Q?3ACIlKq640zf00q6e5wAk3Ji8o53ybQBencZG4cNYZgHbO6HzDDs3hmKp9W1?=
 =?us-ascii?Q?dNk+ghOHETy9ku/tAtw7iWSS2MASTR2hJer/dCE9KWlZFcq9DqMU3P89dXyM?=
 =?us-ascii?Q?iIdtpkrvF+Q9pkAa+orlrryE/BlE7mwyzg/qPD5kipSO050oQXuqcTf+TEO+?=
 =?us-ascii?Q?qg+fhqf73H76xPsM882g67irjD3lRgSJFScwoB7bR68Tg22pGQIARmGmTrRY?=
 =?us-ascii?Q?1COwf4lTyKaU/GwSktbRQcRjCvQhti5WDyb3C7Zf7J+1+80eHRd1Qb4cc9+g?=
 =?us-ascii?Q?yl9mYPsd4JxQGbtrhre3xNRrpVXqh67UtbliSGJDPopqR7j2aQILbY+EXLli?=
 =?us-ascii?Q?KV3kztsCh3TtCPcjkGWbXEfgg4a39vQ+Ezev+ahKlddS9UdGSezrghMixEN0?=
 =?us-ascii?Q?85f1+1Ql1HdGLFxfVPSsRyaxAMEduptxZoHWNSwp3GagafjQMaWzH/iRbdMh?=
 =?us-ascii?Q?ctTiO1SQLLTToU4u4Ol8AClTy3RaqYaH0mTni33qFotyJIlOH9/1sqtFr5AU?=
 =?us-ascii?Q?ff/Yo0zoQm36vbyAAVZS8W9vARwfnlQFg7KnwBgQa+BE7qFxF4swogVqx6Zi?=
 =?us-ascii?Q?ffgevDtFAV+7F+KCCNpu4hAabkU1D6Xcml81S3R9uIoSpBGa6IQKz0x40XWa?=
 =?us-ascii?Q?wE/N/FR91JLXNSZIRF9idC3vUc+9q2WFzgUwFiY6TOb41523cbymjqb1ajts?=
 =?us-ascii?Q?NQkFandR71R9NjOWwfv4j+CNIoVgyCvQWRuVkTu9+BuWGEZSDNcHedGH4KBg?=
 =?us-ascii?Q?1660Zpob+TyTOh9SIXFJl2FZEC1KVVB0zXlyarOKPxsIiAf9tYR79htxBP6f?=
 =?us-ascii?Q?h2M9+ORc5hF8lP91g1wrXm02890rJ3lmpN5J+Vpv/G7oVktFG4JWyfXQtXUJ?=
 =?us-ascii?Q?KkgjlPKBUZkC8GmS71JOfKtFEHrUV31Ep6h1SFuEpFCVfThz0E3sidFRqhtG?=
 =?us-ascii?Q?UGSWYKs48qlYGQiMOkDYbosLTG8YU/LMpDPBHxm7ukSCPdk31bYoJw4MI/L/?=
 =?us-ascii?Q?DZMRvRWiXIZwf0cnHsW2bV9haXdgfho9XDhT6/OMnbPvaE50j6INdQB2Z82F?=
 =?us-ascii?Q?IJpkajurgRWAqjJ4nsuuPVV7ChEGCXR4erISGzJaHkUQylfVqRf0xWGrr2Ei?=
 =?us-ascii?Q?yGIPMA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3e83be-bccf-4355-8cf1-08d9f2e069d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 13:13:11.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxkOPVl31u0e3/s2+Zxm2BH/PP4EfFJNsVCxICzBDz35+It5gVQ1CgkFQZbybjtJf1XU9q+1d8ZeY9vjicWOWw+50/SK81v8n1JmRBfvw2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4160
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 February 2022 17:55, Christophe JAILLET wrote:

> This driver only uses managed resources, except for the delayed work, if
> it is used.
>=20
> Use devm_delayed_work_autocancel() to also manage the delayed work.
> The error handling path of the probe and the remove function can both be
> removed.
>=20
> This saves a few lines of code.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
