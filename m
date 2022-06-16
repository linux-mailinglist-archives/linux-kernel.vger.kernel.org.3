Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3A54E8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiFPRuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347806AbiFPRtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:49:47 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150042.outbound.protection.outlook.com [40.107.15.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861552B0F;
        Thu, 16 Jun 2022 10:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/HZi8oe5VFdlQ/VbhSr1c9CORCwBC3CfoihhRg6P3MujHrRmQo9gINAEyo5y5qf66eGcE2AOIHQkAqu+piL4R8SeVHEFqlIScOAucVFvrVuVoagPStzTaYq+LGyl5DVxCWEfYL+HC+zSzeiPB17Bn9xYkXA0x/EviHugE7Yy0NUWt1imxbZGa/Z2VD+yNooGwOBz1jBD9ed5HlUTqH7ZfzVkbjaANe15ywA0zAzqiCxmxNhPSJ/9/1BJQmnPuE1zXvPYjgwpeTcSFKLJXuDBxEI7zTgjh0rRLF2hCBHKkt10wRvyANn1SpEl8ovUTol0jo35z5y7ODr+mqQ/UYtDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fERMSwrbi9bGEQi+/RubVV3FG/BjXneZkctkj0tlYfI=;
 b=nL+hYWXdY2kPQnccni/o0mFCgOo1WcgAuqEnkFli8oInYZaQjPuAFioFKT/tgjqvByrC6tLAikY4iGuU2ACC8QXABRYmcABERsDN4rL4Bghx6IBjZOKPHL8oLZ+W+UFVtBTJ25JZEkxBbe6XiIsoAkJXxdZobui8NYnOpw7dAHynB9zzbuiwr8c+j+tMugmtada/6HEBFTJQ7Uw5mYIgw0NYBSONa+lNea7popxho32fd65av1pRCZWBfNAknhD60NBEbWPhyNL+45Fpip0AdyQ+MPPr4hZnbZUA3odiXqDXor4bgiwAFHhGNIi7AVNRpoNhb5nikin4xw03fr/oOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fERMSwrbi9bGEQi+/RubVV3FG/BjXneZkctkj0tlYfI=;
 b=Gg1yQC+RONCo0gVocVp4GnuG6Lhsyex+Ri0BTlzKrWrrZ7JIo6c2nd3DsscVikBQGioWj5Agu7+JXaNIKClxvCi1F5kyi3kDDYiOUi1U2IV63GM2seUJbeSZonhgru2QPK3QdZGRuiSFHBL0/8XFRzKPli5obRyVc1PgCNAqho8=
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by AM0PR04MB5555.eurprd04.prod.outlook.com (2603:10a6:208:112::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Thu, 16 Jun
 2022 17:49:30 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::b8b7:9344:ad35:d35d]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::b8b7:9344:ad35:d35d%9]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 17:49:30 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/3] dt-bindings: crypto: fsl: add entropy delay
 property
Thread-Topic: [EXT] Re: [PATCH 1/3] dt-bindings: crypto: fsl: add entropy
 delay property
Thread-Index: AQHYdFB1/6ZPLK3UVkiqfeFtvvLa6a1BW74AgBELlRA=
Date:   Thu, 16 Jun 2022 17:49:30 +0000
Message-ID: <AS1PR04MB9358BCBEBDC7EBAC6E5DD6A9F3AC9@AS1PR04MB9358.eurprd04.prod.outlook.com>
References: <20220530180924.1792399-1-vabhav.sharma@nxp.com>
 <20220530180924.1792399-2-vabhav.sharma@nxp.com>
 <20220605212114.GA3528129-robh@kernel.org>
In-Reply-To: <20220605212114.GA3528129-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 320a93e8-5cbe-4fe4-7226-08da4fc090a5
x-ms-traffictypediagnostic: AM0PR04MB5555:EE_
x-microsoft-antispam-prvs: <AM0PR04MB5555F3F0390D0F7404910CABF3AC9@AM0PR04MB5555.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Og3JnrVqwsMclB7EB4b5RgZqnO//h2lj+acV2Ehx72OEk9Zg9fBOWANiW2xtkbA2IMcoYIGpj5I/STqkw9yKTOLn/bVAkNtt394mLevhVzp7CkDT2qe/nprS2WzH9Z7KuwT3PsaC6E99o0/amO1satM1yoDDzQLnwUyc49POSsNliUAnaW0LsuEHx7z7ii53jsSB9kVCyvDT7s/xm0v9GzVvqlLKO6sAeQkNIA9U2rT7W18/B+uTAU4f7eOL3jrhssc1GeJ2ksHDd7kBpgwGU9NdDznuFSaxpOH62kMLK7jNkByW9Xy25ii8+rCC23lbU1fLgYOzUISnCpDFDA6HOV7Gdl4U+/ke/rbKJZVRfvTKuawj/tLzIts7HeimRyT3JHTPAKiwxHHyZeYZW9dI3Dkxo32P+rAHA1szQsd3C6mb7IWnVuJP8on52kAFVKa2ukENbTZEhtB94teDuWdckvC3zsLS/8JJxPfBScSfk/hLEjsodRTRuyQ5Zlau8cxA6BAbu4SIqTcnM5Y6Lr3iDIvWmxwiFAvUQrSlABwLaQHSJIFyQ8XfRARYku8IuVsLL58jVfsKJYTOpgsTCBEadUeM5vgDZYEtl2lQUtpPCJxOHIglZFIzLWT3xuYzAKaAkgAkVaIYuPJmUjVjyVtvjRleVkXCKZZ+08sIOxoNtFq9X4In+556N9JxAw741O2L/fVBKosfXzeHxlxGQ5MEQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6916009)(55236004)(55016003)(122000001)(316002)(53546011)(8936002)(86362001)(6506007)(33656002)(38070700005)(38100700002)(2906002)(508600001)(54906003)(66556008)(9686003)(71200400001)(83380400001)(7696005)(186003)(8676002)(4326008)(66946007)(64756008)(26005)(66476007)(44832011)(66446008)(52536014)(76116006)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dJyUcYFpaHJt9OkVaD0AkluSZJ3WummH9xQdiM8n3H+as8NS/C5GzfFDJPTF?=
 =?us-ascii?Q?UiZywzlCbnpbTW3dKkDngGTj8yzTMrCElcNrM8GmSU9YLlNh/XJwuPP4V8A0?=
 =?us-ascii?Q?ZbCzhfILenhw5O9SqiXEkdrjhdYnMNaj4hc6Hb6SZPp1JS1Pzt329klz3fdG?=
 =?us-ascii?Q?K9qUzegSoAuZ3EimOq5GPzc+bBJPuXSSuanwbvlvk+hOiBOOI7LVdLqnyYUz?=
 =?us-ascii?Q?wnYukHTbY6Tno129cn3AExEB59hDTbHnebRA2fZYbyd4sv/Cz942CQMRmxkh?=
 =?us-ascii?Q?7YitCc0pat9ewk6/ZjCXvCFR3QtfVrIpVWdPy1X/FB+sH8YKZNhPfhD4/rqR?=
 =?us-ascii?Q?/qNnyShZOGikT6iqkUnHQ5l1Wrls+1GvhbBR5X9ZbZgEnc6TC6t19hT0oRJe?=
 =?us-ascii?Q?BNvO22nLh2Ob0jFw0xSQ0q3o6eK1qaQmMDnr/zM1yYIOSxNZXRawl9LouKk+?=
 =?us-ascii?Q?8j2D6owebfs9IbvJBjT3oqm7KoXf/TZ/S35tKndwnYLtxSbXFXamA28XV/Z7?=
 =?us-ascii?Q?9tr+hQ3nYhzJOe2lDK6kkIQ48kBlKlrDku2CewRzE4SJLU8FkcKtV8OOtBXw?=
 =?us-ascii?Q?Cp0fgqvg06wtb/Ya1K2R9rZ+MDYca4mTEphFVZ4zzzKxCfE1E6vi4VMzOVAq?=
 =?us-ascii?Q?5LZnQE0S38CDX0GgRjLb5RUH7YNM830F1b/EKiwQMrhca/UvjpgFgyqVMhUo?=
 =?us-ascii?Q?wHU0bfF0YiK2fByvoAmZgEAZHPilcf61VbUIAWFSuJ8m8fGYKJvbeDWd1zq4?=
 =?us-ascii?Q?w1A8ARLkEAru+Ql7HgbVBZytDdqpdewyNwciNCXtp1zxCo576xTIRceZ/slw?=
 =?us-ascii?Q?YoMRPyCKmpTcPcXtvCKPBQ/K/wrCQ+TBnNfIscxX1K8ZckrFitGAf/BQHvGU?=
 =?us-ascii?Q?4EJ/Y54DEZ7hhNrvU5+5LULlR8p1uG2nL9k+VysmHR+ix6OEjILywnn08Iro?=
 =?us-ascii?Q?4OBB4T3m5+lyzC8GB5VrBEQysYIwGw5ZlN8Ej27msMkPO6jmZhcWYAodu429?=
 =?us-ascii?Q?RpP4R4RCUIaVd1cVrey2v+am+3RSmHnUKk308xBO2nlf7al6IRJIFd/czlr4?=
 =?us-ascii?Q?wdlYJBBP4uqUXrrB/yq9hOghBDjBTb0aMHrmVrFQ/Zcbo4mCc4K+gtDj594R?=
 =?us-ascii?Q?CstAEXcLcfWW9Wg0THi+VGyJuMfzXmHSUYFy/TEg3cEgr/E7hZcSiWpvpJT4?=
 =?us-ascii?Q?QDGKmPJgpGmWOJJ59HGIUTkkWQ3m589/gieujsml22t69dXe7YB/2lTyz1Vt?=
 =?us-ascii?Q?DXhAqnspvm5ajJ+oTFD9DfP5s+NiudXY19km555I0Et1zufM+OseqseRPcRJ?=
 =?us-ascii?Q?bBKixKiBjTZ2TtJXGmz+Px28WlTb27LjksDf8lYVTdQzkbk/qBzGdsHPKAam?=
 =?us-ascii?Q?jZYnts1QscDByG9nJFKh7SdOxR4ZAhHx1dM8gi3Xl3So4OcTDSD51cokAl+w?=
 =?us-ascii?Q?TdOjXY5NSkU5KsDiukXA4MU8eXnY00zCAp18YjXlWMIShZejdfWWmj5hyJDa?=
 =?us-ascii?Q?YH65mvjY+uAAqwC90iTGJgiuyI/CyKJjNysfIKBxTmm8uTqvxbVU/WoQZTXv?=
 =?us-ascii?Q?AaghMfIsKWmu62YxNsNM2nHvwE5y1QJjMYDrEylbmnlNK7L2QCNO6p6bw97H?=
 =?us-ascii?Q?BJ6Y3rp//z2pmRrMAdmWABTK+Ye0kVJKEzrJKKVyoMEJpw3+viochpzMRz5Q?=
 =?us-ascii?Q?cD0F++9vRBs9d1Qc13WcFcXAw5YelkDYqmVzMomlxpjJR8BYrrhNhcI1tu+9?=
 =?us-ascii?Q?esVcnSu3yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320a93e8-5cbe-4fe4-7226-08da4fc090a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 17:49:30.4954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OFfGoHS/CfeQiqr8QZjFVvQkxNgbj/xKWk2dI2eAclvS05As4UHUWHd6/K5ZmPzcehrDV4/NJFFOF7esJxQWSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5555
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, June 6, 2022 2:51 AM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>
> Cc: Horia Geanta <horia.geanta@nxp.com>; Gaurav Jain
> <gaurav.jain@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net;
> shawnguo@kernel.org; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Silvano=
 Di
> Ninno <silvano.dininno@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> Subject: [EXT] Re: [PATCH 1/3] dt-bindings: crypto: fsl: add entropy dela=
y
> property
>=20
> Caution: EXT Email
>=20
> On Mon, May 30, 2022 at 11:39:22PM +0530, Vabhav Sharma wrote:
> > Add entropy delay property which defines the length (in system clocks)
> > of each Entropy sample taken for TRNG configuration.
> >
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
> > Reviewed-by: Varun Sethi <v.sethi@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > index 8f359f473ada..1477294eda38 100644
> > --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > @@ -62,6 +62,12 @@ PROPERTIES
> >        Definition: A standard property. Define the 'ERA' of the SEC
> >            device.
> >
> > +   - entropy-delay
> > +      Usage: optional
> > +      Value type: <u32>
> > +      Definition: A property which specifies the length (in system clo=
cks)
> > +          of each Entropy sample taken.
> > +
>=20
> Seems like this could be common, but should be a time value (with unit
> suffix) rather than clocks. If not common, then needs a vendor prefix.
> Is this time to read a value or time between values produced? Not really =
clear
> from the description.
CAAM TRNG Configuration includes 16-bit field entropy-delay. This field spe=
cifies how long the oscillator is given to freely oscillate and generate a =
single bit of entropy.
It is specified as number of system clock cycles and this u32 type field al=
ready exist in the caam driver code with default value of 3200. However, on=
 some platform this value can vary and support is added to read the value f=
rom device tree in order to override default value, Hope this helps to clar=
ify.
>=20
> Rob
