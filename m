Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D446522CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbiEKHCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242543AbiEKHCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:02:16 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2088.outbound.protection.outlook.com [40.107.113.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2133C84A2B;
        Wed, 11 May 2022 00:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWMIuT+kIXT8p9xrplewfXvFD4KiE8B1p4VNH5MvlSZgLww5Z7T6uth/JCur+pOGmHaobaKsImFn+VRA4qxeH6SAFMMBQHHxbvu/CL6SWccxG54fQ2dTCNCutCaxLf+SCAT6oIsxbUPhc5OXZF0fNlxeG8nzGvKrZydo+jpIPtsMKcfgaLoGra20V/gcnN5Jww3Of2VXYrrVOnHixXHklVhfDxSWKFwcV1kwgf5yb6SMVZxIMzPnVDoaDUXFAv3Sqf52ecIG4EbJomVAJD1jTUF3Uzu3dbumK5V4xS7jWhlprcZdRgW3QvDXFvf1xApBM69Sw+JTC/yXX9bsrvsktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QT7DxLFtxojdMiXNspmgOPUsYwGWj6GgkYVJsFaQ4o=;
 b=Z9U/jeWN+QT5crRUoYwFxZXZgh+fKSNb+S50ndApsGSgWORIfL4/4wq6NVNhaPTXBTDuQUFL6LICnw/VXWZ4Pmm3/lsZB1JlhjAmQrr18rV6ZKw7bnoIPjlUVxdc2TkaGeXEfDMsUDZ+2PNham2Wc/fb7OXP1U+6RgxySnckcBY5ZI9AyLNDpLZC+gt8ElQwgcLuNUsYhmyCh5cU2CBBs0lyqez7D/UKv22DYREZj57DQET+122Em09Dhoc6fUf7IzsLgccTqjDBDZC6rAiNg+qEuNHHyTbeqTOKYN2ZvM/3mOEEs2QP2cQ2OlE99LGCvsF5yggOpzfMLdqk0wOBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QT7DxLFtxojdMiXNspmgOPUsYwGWj6GgkYVJsFaQ4o=;
 b=DTzg2JiSjYxUK+6968D39JcWZpwkDhdNvE87hZ07L7ke8eTvTlfM/92FLA7WDKomJ+zUeztot2B2ZNOXxcpUJ8ueicm29iy/+eoi0/iC3GR0qfThgFYJeLMx+PR2lAs2//t4G5TzGxMj4ZYv3Ea/5VPZU/jYf08VxsuUKWzsKNg=
Received: from OSBPR01MB3288.jpnprd01.prod.outlook.com (2603:1096:604:21::19)
 by TYAPR01MB2400.jpnprd01.prod.outlook.com (2603:1096:404:8d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 07:01:56 +0000
Received: from OSBPR01MB3288.jpnprd01.prod.outlook.com
 ([fe80::f9b0:c51e:93d3:3fef]) by OSBPR01MB3288.jpnprd01.prod.outlook.com
 ([fe80::f9b0:c51e:93d3:3fef%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:01:56 +0000
From:   Ken Kurematsu <k.kurematsu@nskint.co.jp>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: [PATCH] dt-bindings: arm: fix typos in compatible
Thread-Topic: [PATCH] dt-bindings: arm: fix typos in compatible
Thread-Index: AdhlBGPA7N2O7RBuSEeLu1Z8l6bVHw==
Date:   Wed, 11 May 2022 07:01:56 +0000
Message-ID: <OSBPR01MB32880CB4C49E50DAB7C6B664DBC89@OSBPR01MB3288.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04d1b8de-5c8c-4121-fa59-08da331c22f7
x-ms-traffictypediagnostic: TYAPR01MB2400:EE_
x-microsoft-antispam-prvs: <TYAPR01MB240039BF62511199B04DCC77DBC89@TYAPR01MB2400.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +bYflFeDnIRW8Kf5rPl9rO5V63FrtSJiGr8DFUUOLwnD/UdA+JmsK8Nw6kUao2DXj5TNJho790XeA8mYCilRhlLgnhpkb8MM4kfmcyz/G/byGTOsBC4Dp9yWDQvRN+rqGfyWw9vDJNz83l7itqhTNCXBEFEK2tFnDdE7gOpd3Z4nxPfZgz9n6PQaiHCV7t1+OWwfWMskpCuokTAvZ82wg8SzNFo8jkTSAmm/E/amFPr98KsWPdgMp28rgPZEzbU0XmgbtqTDemK502cFxCoVbF4DAIHgWufKxwt7FIS3Jc7a8VIsJ17Atm8IhC6w/NgP3prpyJ3tNzajPzI6i0XtPZqC/mGl5cVo9NDaNNXsdwYO+NHzzV2t1qMmjNRT68HCmRjCQ1R/EdDrXXLm5vb92Fx1tByqfF7fr0FwFWsHDsRBLGKFXR+zMzC/aEfkZoFwiuDG5Pa3UnCr527kEIzv9aX7LzUU8nbZEZiCgD8HGbkpacGIpIbR0GBNt8k47YVmFUduRLFEjnWSNKRL1BNK+VlQQrUBg8uPHTm80Mfkj60V0Oesvp3s1kEkvJ/dk/TgjtwLpETGCyqPRFbl/ub70aQ+PAC9cC7ERjtUp/5tQTtTdfVyRfw4Cbrc2S5YUM4itxmM4mw4lfMCcMtUVGE4wTxhvMgFmGXYEVYV5TURPQzws556Av+oQiosMLjZtXHHAiUplGiqPLYAJG6dUCmgPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3288.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(396003)(346002)(39850400004)(366004)(136003)(38100700002)(6506007)(7696005)(26005)(54906003)(6916009)(9686003)(5660300002)(38070700005)(8936002)(107886003)(186003)(2906002)(4744005)(83380400001)(508600001)(55016003)(52536014)(33656002)(71200400001)(86362001)(4326008)(76116006)(316002)(66946007)(66446008)(122000001)(8676002)(66556008)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QB/pbUED1lAdj579rA8CWtfwC6JcHZ84umjYAtxEgRQOXaBClrexB6k6cyVj?=
 =?us-ascii?Q?Bhw7dOnieMBlIeklVlm1vDpuyDIqKCjVgoHUhte9v0s28B52sfoBVHaSizYu?=
 =?us-ascii?Q?sq/5hf3DEh/43ptrO8GfAppTkcVMM+4+lW2QXwkyGkipm9DxqOprGMNp7oDl?=
 =?us-ascii?Q?CVV7q7bGDXiS8VeO4guu74ByU0FufP/cirfSlT9ACuVUyfii1ErTnCjgoQzq?=
 =?us-ascii?Q?XiKQmGrveRxLcy1ijB+vMWUYRNUmk8/vY1bjXkjsTc50ANytMnsQisNPuKLN?=
 =?us-ascii?Q?mKWQSMIn6zmmvyYjqS6+es3k1Sx3VW1YXPFnJ9oh4g9S6E9SHppkT793EIma?=
 =?us-ascii?Q?AdfdxLPGK1kVBgdoyknKZ2AJxZdd3x2mFsg5Qxq+s8dbz6WE6swkfJPtY/VH?=
 =?us-ascii?Q?Xo5NNhLkNcCjHHSFZn673J8P3ZfzKKivlUfQ6tn897pk7mZCMA5Y46lDQlJG?=
 =?us-ascii?Q?sxPXKmJG5+8JoKB1yRzTc1m4sqy/ropql1GQd6bJl5yILGV4AVxlE1t/+PD+?=
 =?us-ascii?Q?vqCNRrDngHtoBd96S+MlZlFEjkZLbdrux6tkqfCj7+Y5ekgdAewYv0xi8C+b?=
 =?us-ascii?Q?QgofVnBIny105clzbDXqm9ubBHnxyU+Zuwxr3LQN5rzQYghJPvW2UprCVVsm?=
 =?us-ascii?Q?kv9iF7FWRo4/EsgeNcK+JvcbSh93dbzR51j7CUC4KFAx1J6nb0JB9xRgoqj7?=
 =?us-ascii?Q?Ai/RaiSV/jHdsW9FnyaKef/eq84ubnEvqAl7CeX9Xn/1XSFQPtQiTfwZ5TYb?=
 =?us-ascii?Q?qndGfaHmN/fmP3fKlWbKT/fifFL8156UuRpkQpnW7qz7DGxfcpg0SKoDqLFZ?=
 =?us-ascii?Q?keHv2P6Rds9/Dq/QDHCSKLzk1rAVvSiKkNpbq6s4QHRqCx/cFRGPeoNGTGle?=
 =?us-ascii?Q?HW+L99BYj47hPGnSyOkCmMVJXLaHM0wK6C3MvNZoPR0v2TPWXvJAYq2D1OqB?=
 =?us-ascii?Q?jR6df/pbfmY5Ju5LS3UhPxucP5gfmNaY7d4nemXogYGZ5rGgZQtVy7hXDQYO?=
 =?us-ascii?Q?uggnmr/1Y0FBKi88Z607wSBtd4syevZ7HGTYswfLNRkWuWRAC+XPD04/rQpl?=
 =?us-ascii?Q?7sOrsqY1eOwRNHzBm7QELZsTUYAu9eD2OvSK46xNo4nLFhBnLbV4KwGIdO3j?=
 =?us-ascii?Q?Izpp82OPxNEgw8xPzr17gTa0t4zcyJDs6rpDGiSJ7gA8b71oUkQ+eLsKQ/3j?=
 =?us-ascii?Q?0LrCMoh1exIGYrxJd+Nz47ttp68r/QOBxVDksw2PtEcAdGe8Exx+CJcKJzn0?=
 =?us-ascii?Q?RQxqwN9kjsdD0u0E/RXX1J1miws+mqEk+dUmOsD3uMJOSXEPhJL3ye3pOxUy?=
 =?us-ascii?Q?qjap3ab9emjIArlodkpWf7ZH+OHpt5G35zAjNbR5ppyIB6ilENAwwEegkDPo?=
 =?us-ascii?Q?QJeDg9U1/d/ftuBWwDjCoi9GYELVros4pBWZ++oZ5XEPg1SW7kdYiRvhizFs?=
 =?us-ascii?Q?fFAMkestC9WlD7vRX++qAOmaveEC7V4eG1X6YiCU/O1coYQi+0IOyQ7P/Xwb?=
 =?us-ascii?Q?BoADZA6rglPWU4rC/03+h87BFva323GwCbOaHtRQ/R6nqaylIpqmNus6AAHo?=
 =?us-ascii?Q?Zs8r7h+TZk/PjgOqfSvwBbXzQ/6/YXeXrQHA/A59pdyChPhp1mKK9n2TSxaY?=
 =?us-ascii?Q?++2dvODQEAW+FDxSDIijO9Az7pEh5q/f2eHTC+CjKx9Tl9Q4ifGcaOExD5Vz?=
 =?us-ascii?Q?wHMfLyaJRjCZaP2UgGdbt9t2BH1nzikTvqvQiprP06QN85vNHq7jwOUJn7fC?=
 =?us-ascii?Q?IkoNDh0WwaJ+0tlhBsGhXY55HuezR1s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB3288.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d1b8de-5c8c-4121-fa59-08da331c22f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 07:01:56.4499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7sPzd8m0ZIlIlM0ONpEqzDCZaUMJUKXkWCVyLMz5Bju50AfwvH6HKq60jFePCFJTWgDorhZ4XucLcVQKmj35TeL0aMynQcNn3eL90/2cSkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2400
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo "cortex"

Signed-off-by: Ken Kurematsu <k.kurematsu@nskint.co.jp>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt b/=
Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt
index 8c7a4908a849..a8866c6e9d46 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt
@@ -30,7 +30,7 @@ Example:
=20
 	cpus {
 		cpu@0 {
-			compatible =3D "arm,cotex-a9";
+			compatible =3D "arm,cortex-a9";
 			reg =3D <0>;
 			...
 			enable-method =3D "brcm,bcm63138";
--=20
2.36.0

