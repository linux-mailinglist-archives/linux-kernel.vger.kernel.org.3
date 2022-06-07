Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6453FDDC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbiFGLtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiFGLtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:49:43 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150110.outbound.protection.outlook.com [40.107.15.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5909210F5;
        Tue,  7 Jun 2022 04:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/EYwp/mEMiIEoNJ2y7NgGSq9+2s9hIKRrBQkuEGgnyfKutCj5QGej6LdBJA23tO36XuwOZW98pLbMFHkG7LBybG4encL9mgg0J8c19rQatlFscVa7D+7Zr3Tzemhjd45lyfi1TwhfJwD++1z2cONk2q5i4Ei9EGNPYPPkgAd+5I4pAr6G/p7L+664y8RnZjG6n5nuIA6wKpBE5SCszbx7iaq4ud6kGpVdhC99nH8d581bko799C8+J53DiWWoCXd40HZA+kojMvJUz3Q9ifPjj4S0IIktykRA41oeAdwXBseo8oxTF7StRKpAiE/we2w/dBhBQ7oqQPn3oNJcMp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW7Mh4CRxsvBgLPR9vFD1zlf3DfNOYYfbaxmUuczGcU=;
 b=ZfEpOdQqnDDao2fO7pYhSjq7+bg9Ya7K1Pv4v9ahlR4mUCQavF2OjtULdyu+p5NYlBghlzmUcq4zxAesQNlSwUME2Bb+3TeGv5kL44KIH1xOGKFx+grfPb+rMtR8kCAadt/uheuta1ssJ/df9okpitN4Cl8EBWxvXPs+2wa4R4I1AIqnuUpwVd/xQOV4BhnnWUDTnYOm+aoA/TPLdnSBDxyP8YHW4BPGBaH39OGaoYlXprz7j1t7zHwgMpzzGaP3mO1szDfH1wogQKmtASJEeS9y2PQoZtcij1z5wy+f1HdNPc45Jv7VvIFeqP9gOpnhnoBKVulaZxXwGgn7ui9Kuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW7Mh4CRxsvBgLPR9vFD1zlf3DfNOYYfbaxmUuczGcU=;
 b=X/EH+BSkgLRuKJVUIEm3L5XT60od69Ktxw9k3tlCkL25CXPMQ5/U6RSvapfSpyFwP6BaKsknL+ikaePUEPZLyu+QpVTtBCmtQIoOjiFjZlMHNOOUzq6vjmgusPd8cZiUwVmG/C+PKdL19mvP2DXOOk50z3RGfTK/m7GY3dWhS/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DB9P190MB1434.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:25d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 11:49:40 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:49:39 +0000
Date:   Tue, 7 Jun 2022 14:49:36 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     robh+dt@kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        robert.marko@sartura.hr, vadym.kochan@plvision.eu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v8 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Message-ID: <20220607114936.GA18404@plvision.eu>
Reply-To: 20220515233047.531979-3-chris.packham@alliedtelesis.co.nz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220515233047.531979-3-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BE0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::19) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 209a117f-fe74-48a0-9df2-08da487bcda2
X-MS-TrafficTypeDiagnostic: DB9P190MB1434:EE_
X-Microsoft-Antispam-PRVS: <DB9P190MB1434C8EAF7B4272FE2E4BA5C95A59@DB9P190MB1434.EURP190.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jes/oU6vQ9fdXcQgD3It2swQibuYaS+P9vbgATU5G3BhQcXvOdctaxqwb8LavlsUval6MAMf09t6tqMMBGWI+/IqqWdSv0jGlHXN7Z2AitH3j+v4Iy+jD+8+HgrX5SYFyxEw7Hy1uUTigUD9fM+wSb2qPZDRTu4ThzpTyJu4OWG3RSa9wwAMxjxHLyNTfwDMLa6oz+LhJ+4JWiYfwhdWTbT8ljvNoMPNMzqLhDY+sGuRohSMoHERr805jK4J84utKtoTbgq0jd+1DNUSxv5dhom4pHb9BnLR0FeTKAPkYVyrfWkJg1N3weeRHVNlNa5LqaG/+oWkbDZRwkUq+kRwuyLJ9n54eIkRn1G55o+rj4yZfUx6el7dv4deqXfQ6aUYXYMiH4tIMT60GRmc7HqUHmN1cswNRBEOc7tKgZKo2t1h9tGxpDCzrKiX2H9aUber1Z4YlZ7GgQiHtPRnp9UFLVbvk8DBBOZSPhMHx6lBhzdWhgFZ6fiPskC5QBNmH+f4jQ/ZqbJLFHHUz1un75w4P2BTXZPSuGFmgoJVl30t3XBp0cVSM0x2so0+sSvQ7lm4vOGpARLM/A54VJ0qF3nGHoxwQRRn8hdwNNwy7N3FRTRgBOhFwBX2b0TQaSZhPNnsHANFM59YzDCJpm5PBZWyHyvBNOhAHsw6yPOm5ejhDzhBcjWFpEomkBjKung585qf9vyxUJpc8C0OSOC5v5s89kMOotUHuknHxGgxHM+8aZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(396003)(346002)(136003)(39830400003)(366004)(86362001)(38350700002)(38100700002)(44832011)(5660300002)(8676002)(4326008)(7416002)(66556008)(66946007)(66476007)(4744005)(921005)(6506007)(1076003)(6486002)(33656002)(26005)(6666004)(316002)(8936002)(52116002)(186003)(36756003)(2906002)(508600001)(2616005)(41300700001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JotPbIipWjseUXE8ygHN0NxpfAmwCk3+8Sj3eHWRpnfo7NctO5WFD06o06Vr?=
 =?us-ascii?Q?yjfGSmuGVidAm8a39VSnkW7BxNBWsipo2H1XSEu5wbGvMBXhqySNYr105/97?=
 =?us-ascii?Q?bq1EC3XteB1qxJ1y49gRrmYnJKZ+exlrCCj6+uv/l18v30pXpcqHX916odox?=
 =?us-ascii?Q?LxG0NkQjXNka+WRSiCN+WSwo48YvlbPo3k9YnY2NzHAFAFb1yrsxSTMAf1pH?=
 =?us-ascii?Q?Po013blaBjNhg1SavnsmnpTJktWk7OG1uzShe2n1kkgYxQF9XrScjEbAexmP?=
 =?us-ascii?Q?071j5MKyReMjjo07ovORHIv9GEX9O9uUDxvMRPYw+Ux57S5meoY0+QBsULo1?=
 =?us-ascii?Q?992I/6wOGGMQNOLY5BR42jgy7OhWKYRlxmzNkRBLpSHeL/DB9ilK3nJcJ5xK?=
 =?us-ascii?Q?sh387V0SCloDiVNOozg26houevgnaZnGutThslJVXG/bXr5naj3+SY9Bu5cU?=
 =?us-ascii?Q?iP0sibg0YebrMQYsmQ6tu+et7LPjsTfmgIA/RhL2makqrjPkcyaKB4C7YiZw?=
 =?us-ascii?Q?QrBRNvn76iwrRiFSrLikKQI4bUs8sc9SMLjdS2/gU4hl5G6npO3EJrgzn1oV?=
 =?us-ascii?Q?Z85cLC3Jo+slZR0CP1Qkykb67im0IRJ6rlE855mYDXRbvqErFWfceX2HeL4R?=
 =?us-ascii?Q?z4pgq/kKgupt1YWE3zeRin4PaI9zRLSpz7n0gURSBxIYIn+5N8Wh82oOToHg?=
 =?us-ascii?Q?Au+XsHxz5DR9uQivQGcstLzXFShVnpQkrIYj61TGZF0ylmC7QHYctwBD3EiP?=
 =?us-ascii?Q?jnK+f0Ui5SnwBzCVYW3sJx50V7yKwvdldfvctpcUZov9SGsXMtP3mMxhheEx?=
 =?us-ascii?Q?ed8KAMwNdz3G2ah74m1GlUy8Hw3bW+Joo7o4MnbhNSajbY31DTO0I/FVvbGm?=
 =?us-ascii?Q?ieDDPTjYc0E1iLzbGzN2wIHz565+hyNEtqsL/XgXB8AKtJL4xRXT8gYycVjj?=
 =?us-ascii?Q?3qHoFrDe6k5XJViQ4lo9NAJ+OvToFpCHhQ5dp2/eHdEyOPpj3J3phP8MDqse?=
 =?us-ascii?Q?HguZ2aa+ZHLiwzZD2OsveJUOOvyLd4Ox+O091BjD04Lc7vrLzh9uw/zY33q1?=
 =?us-ascii?Q?mslsKIwO1/KjsedG3u9N1VJkGFsycrZgukiOTr8F3t/dXh5GcNXo+ZMuJ4Y0?=
 =?us-ascii?Q?x16cCxxLUwOeG7W/RkdiWNuarpuCqSa/P+iyR2XQRi21TZM3mbFhdDPTMIWj?=
 =?us-ascii?Q?eRD1NM9f+FSNmFYsobQbHZA7rQm3flYhfWZhub7az5X6ehoKQOtUL/6uHb1o?=
 =?us-ascii?Q?1fFo/fRn3GNUTvB0MlMy7X69A20RISFJu7PJfHZjsndEDyICeAiAAFOHXGdN?=
 =?us-ascii?Q?8fLgWvQdKKTOAWqSOTz8otq9n9wcTaehexWTNPrdHGCMbzADnCA+LNf+otxz?=
 =?us-ascii?Q?6AVwBQ4WJ4i+Jc8OKidVAMPm5itX3H03cwWL/GnIbF4sUh6+CfC6WmU0EbAO?=
 =?us-ascii?Q?K7AYZKRLGlogsKFsJY1cCRR/omzGhYj9vOyVxdoKO3al8rpy4MgD14baLfYZ?=
 =?us-ascii?Q?spYT+98XofCMFEpmhdUngpwNzFpJRxK36PwjM0L8lI3+PxcBeFikC83fd7+9?=
 =?us-ascii?Q?iQvj1WYUNpBI7hyBQrA+BlUPKSE9vrsDeJuZnCwJMhCpeCty445EDlshV2gU?=
 =?us-ascii?Q?jTwPMns+MRdU2bSPqprPLsLRFv2Se4GHvafsK1a9xWteqrfYGnkAHj9XccBX?=
 =?us-ascii?Q?rC4PLfT2FapXBrZCDHFM6NBYXik0kLicYEijxbHmJNLqxaZdhDqP0XfBKxKx?=
 =?us-ascii?Q?D/SLtaKPJ+p4S126nVFSQfN7EKFvXFA=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 209a117f-fe74-48a0-9df2-08da487bcda2
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:49:39.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUc90uifjDKXOAKgvT4CtrjpYOlSJTt4/yyGRnqZvcKLwwFDO4mB/Ct9sNYaGzuX8gufb3yEoKGv0Zi1i5C3Ofy0V2PY483KPjW82aE+rg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1434
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> arch/arm64/boot/dts/marvell/Makefile          |   1 +
> .../boot/dts/marvell/armada-98dx25xx.dtsi     | 297 ++++++++++++++++++
> .../boot/dts/marvell/armada-98dx35xx-rd.dts   | 101 ++++++
> .../boot/dts/marvell/armada-98dx35xx.dtsi     |  13 +

There is a proposal from the Marvell to replace "armada-" prefix to "ac5-" in DTS naming as there
is no much common with Armada SoC's.

Regards,
Vadym Kochan

