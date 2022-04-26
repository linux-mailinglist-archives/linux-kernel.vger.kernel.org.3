Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE5350F87D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbiDZJlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348894AbiDZJ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:26:07 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B291B820E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8gYzMuKqQPK5lgjSnwS+otDPo+upWG1jL2OkRTv3JrcbThUTdbz0+tqXDnFMQQKxB1lKVZ3ScDG26a5UeDYTJjo54SPOu/yonruD6+pGz4sg0F9vEYQL51alEPAyNYK+IwItEfCyeKsgH2nP1CauhGuqjjUCjtgtV0Lzw0gA3KltGpvwPvraHooCPPczUcGXvDqpJFbQxS+sQp0jpKdNNRlawQEwZuG0xuOG2TNPvYqhJyW/9wVh0IEHC1IvnX9tR5c/ZoY2xcq0eqtPDTu90xRzZEUAcjZEuC/GfuvtOAo6oZwiIhpGE2SAkn77zV5Ds1Phm08qhevh8ap6ao4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDawsdf0iQeWTy7AIDNzXjZnEWl2CxaI1MO5W9KEdxA=;
 b=ev25+E1UB9P4P8J5F3lEamgM57zilJgeKMoDQ7yM+QtRtwxnFJ1K4ngosF24cNZVO0winTt/JK4n+o/D+jkmCzxT9TcRG1rUL7Be+5AIqt4AfE7qdANdnKpOr73UiBhk5H5bk075ujPW/fBlcWM1UiBKkJCcLuqghM7hvJHCEOa//HVzn3ekz8J0N8sCc87rvy3eNC2Vgf2aMxZ+VQWOAPOsl8zghFCruM1DcnO3Na39sRcAQXo1hE8FVlbXak7lIUA9Eo75Nn1Zv6f7INWHMa2jKnO/yQ0jiq020DfCDNPC4kEhQZrO6bx4PZwsUBahY6U/VNmr8fAx2NXNlnjV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDawsdf0iQeWTy7AIDNzXjZnEWl2CxaI1MO5W9KEdxA=;
 b=LNwQtQY/3k7ZMu7MyU+rFv8A8ImhUXtr9ytIjC8znnWAG/BFL3tmEukIMColN/W8nsdDr8z24ofw9JQ/zeDcd9Ai4WUvcnTk1YBsSbPAbjMUrWsZu9sFWxIUxzglFvKcSdpxwm9unvL5NWreJiCH5VukDdggAseHZ/zV1eYKE6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by BL0PR11MB3043.namprd11.prod.outlook.com (2603:10b6:208:33::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 26 Apr
 2022 08:56:54 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::89b8:2d6e:d075:527]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::89b8:2d6e:d075:527%5]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 08:56:54 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] dt-bindings: net: silabs, wfx: add prt, prtt1c-wfm200 antenna variant
Date:   Tue, 26 Apr 2022 10:56:47 +0200
Message-ID: <13694640.RDIVbhacDa@pc-42>
Organization: Silicon Labs
In-Reply-To: <20220426083305.GA17577@pengutronix.de>
References: <20220425132844.866743-1-o.rempel@pengutronix.de> <4686508.cEBGB3zze1@pc-42> <20220426083305.GA17577@pengutronix.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR0P264CA0176.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::20) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bedf67c2-8edd-41ff-67aa-08da2762b612
X-MS-TrafficTypeDiagnostic: BL0PR11MB3043:EE_
X-Microsoft-Antispam-PRVS: <BL0PR11MB3043930EB5E3D7B1BF564F4193FB9@BL0PR11MB3043.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g26fh74SLEqXaJLBs9niznSQrnwrVst7QRndlOlUczDPiBPZIiQF3v4dKO7xeeFcWpjlp67HAzAPmTYnOhWQXe/7MjJMdiueEPSH1rYlNyyZTqI3WpwDXln7D1GdeM5RUlCqaTHtl4x68ivvZStenqnfXG/XqViqSqG+ppwoquzX6bCOngSsLYKs6CmoU/pLIRYBCxxmhiDPIA6nl5hfKlIuwAyan9MyklqOqhOQSUAfDpV2+/6f+04E6Ii46fHJ5bkR1IDR8+LCaDgGbWMsMSRhd8YzlgbSHjcDFIETVp4eHTk1A5umQau4gMoe5lH3P0YkJ9BQMOo8KPfZZFDPzy8Hz5etjtwawYf08BhH1thoKNISdpQU/E+5V1e84lr9uijqP9mbdrnnfEtSfJrhcjBxMI2IAmUAMoSbOYp0xNZQqjjYICty7gz81otyFh/fr/ZqX5gwgMWzaSCT/FW4RSZQDRgU1vDv9S8QIKbWxSxZ2hgvngHBfwj6XKE5XUnJ/EaWs8DaRvc7eMVGt02U34iARYJ5Fufiy+JJ8y3ahcQzo/FHT4Xz38KKdkLXif2M83/mTKfdVNLaezKs5l7FTzPLTqfI6zWxeN7TCf1zCeNs2RGZJ+VQ2i1nToWOvPGqTzk5u2Hwp8TDwSbaWzp2dEzTOPGIIFHSUSuF8jzHgmRWLBJd9JaUtmCqIuA+L515djm4Y0WZ/SztcPduHAwcY/EDXAf3PkwaPcAEwlxtZE0lSnKd3qTURay+VTXL4g31s/q92el+ym+yOWJTA5hbalH9EHEssCTdB+qhupyPyYLpyF41HtCteUWpZTQiShbu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(66556008)(66476007)(8676002)(86362001)(66946007)(54906003)(36916002)(38100700002)(2906002)(38350700002)(6916009)(186003)(316002)(66574015)(52116002)(6666004)(8936002)(4326008)(6506007)(33716001)(508600001)(6486002)(966005)(26005)(6512007)(9686003)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HHUA5kT9/x4ayNI72IuVQofKyDZXirO/Gki3ehAxtk3TJq4Utyz7MczYVL?=
 =?iso-8859-1?Q?3wfuEYFHpUy+RmGkXezIUudGaxYY4Arvr9MXz2e+TVP/OkKQZFaErgudZs?=
 =?iso-8859-1?Q?s3o4iV81wzjOtEg94XcehPZIWjqWWTVtARhI5Ykc3gPgZc5+5edTp6XeUl?=
 =?iso-8859-1?Q?JwiU8dPcRhtg9d1ggGotwmgnNyAFcpHFkeJryroh0Eg13oHax+hGvRDN8C?=
 =?iso-8859-1?Q?ElYS4g8jeIy5bMV7dWTihalUAzCSFqFiI9jFEK98omF0c6xFD2+hN7Sj9i?=
 =?iso-8859-1?Q?Tllv06a6mD4L2hp4QAkvGZJCwH4ihYe8tWlYcC4NPemWGMr4ihdqlgKNIj?=
 =?iso-8859-1?Q?6Cbu3i0qhA+8WFAZ31sdcQo9SIVu1lD51bI0bF6DBqsKc7rA3PvZ3SeJ6k?=
 =?iso-8859-1?Q?1hrS+mAUmFBurBDyEUia4xIvv617U4lQzcQ2+x9ZqBWENQna/3WYfmnhoM?=
 =?iso-8859-1?Q?G68e9boYP8h/2VHQzBdV6iSChcZqy9f9BCosjux/gnImhxTHvwnloVfzQU?=
 =?iso-8859-1?Q?eHockuw46Gfi3XIjjmXTrYVem+iJO5KL5VVCISq76e4LlxMBVC/eouHFWZ?=
 =?iso-8859-1?Q?okRMeM6MNGwwj3/DWmkOJuGo4udnFflRzyp/OXeisHjFJnCPsdqwYS8GAe?=
 =?iso-8859-1?Q?lgTjFe7h0qM9cmuTs+hMQ56YJ5HsO+f6VQK6PtBR7ZNbUotnoRXOadiZFY?=
 =?iso-8859-1?Q?RrXyfY9dV7O/U0efcKu883x6qJxGO9BmRZspEjHBculCk+k+a92NtnBdvH?=
 =?iso-8859-1?Q?qvSfMVaAtvdATAO3tDUCC7JoOV8SRbd7yBT7dT6t6RjqdIbSN753Q8VUuB?=
 =?iso-8859-1?Q?LlbgDU6JWaq1AuPR6kG5R37/xPrY6itFJWMEN356Nh/LT0POuUq0QlZglY?=
 =?iso-8859-1?Q?ah96/4TaOSOCSmJEzgszlZZHmMourMgj0kAq6llvI250NFjRJCtZ3TYOuY?=
 =?iso-8859-1?Q?dVrvxs59rJkZYnkIzpaXbHaFODAA4TnnKCnXMQhEiZT5JkiegvYu/kUYIw?=
 =?iso-8859-1?Q?G3H4j2COwLMEclNJbCd1jzAlYprdJzQOMRIUVpnNnJPUgm7hor6CeLhBJ2?=
 =?iso-8859-1?Q?qgoyqol73JqT5dQFm5LbvfIauBscMPs4OAwq6hCX/khXQf+jmbARsUt6K1?=
 =?iso-8859-1?Q?UevQzj/hWm7XGWrc3UVVAiy0O+vfIgl+FVtMY4TIPA2A6x7Kn6b8US/Ix4?=
 =?iso-8859-1?Q?1D29GUqCnyDa9cviYx4at4jCVW7tmU3q8npSUXSppiB/9qFiB3YCHWxOt1?=
 =?iso-8859-1?Q?H6710TvAo48EvXfgvvCVnsatiudTiglHY/9jZWCvPOrSs7IcNoQ7oe6zC1?=
 =?iso-8859-1?Q?lTTCHeJ6Bf9F1wavDAo26ZW/TcTqcvA5vG0WIv6qqvR04Nhy1CSt6NZaqf?=
 =?iso-8859-1?Q?UF4qhw7NkuAli+npURNJ1Jy6aOu1kceN45QTvX6YRcwTVys/l9ReeTj1us?=
 =?iso-8859-1?Q?28gDgYc4HmQeJsCowQqXrhi/9eW+p6xFpwBS7tk4uMq/fMg4uBer+7khdN?=
 =?iso-8859-1?Q?xZoi2UBn1dA4dgW3B+6N25DjTjL4WYnpFdBWk8c+8M9cTgTiTn6U3AjG4c?=
 =?iso-8859-1?Q?znWAtjiURGGbBHG1j1JZIoh10tF5npA+0EsHmCjqTYdDEKnLxgf+TtcRTh?=
 =?iso-8859-1?Q?gsagGFmV3BvuYAjNCH9fizw5RYGCCptEVtvig3DE16BD3jDapte2zGerKR?=
 =?iso-8859-1?Q?QMsRkYTv0aVi7x/zQ6zdZFtd05WacQ0hHpgLxVgeeJvRiQAi0W8o+1cPCg?=
 =?iso-8859-1?Q?XM4Z3w5ZI+NWvBp67u25kXAHy3kpRWWOpk70KAVYZQTiQ//fN4cCJpNIai?=
 =?iso-8859-1?Q?5pZ+P0AGHA=3D=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedf67c2-8edd-41ff-67aa-08da2762b612
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 08:56:54.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0F0oubzvvepptJ8XLcGKyzB9WPZ53YbGUflbZueT+JbUz4APf90wKt8CZadPcC9JZtdzWB2ap6nHxHhqlD4wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3043
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 April 2022 10:33:05 CEST Oleksij Rempel wrote:
> On Tue, Apr 26, 2022 at 10:19:29AM +0200, J=E9r=F4me Pouiller wrote:
> > On Tuesday 26 April 2022 09:21:13 CEST Oleksij Rempel wrote:
> > > On Mon, Apr 25, 2022 at 05:38:20PM +0200, J=E9r=F4me Pouiller wrote:
> > > > On Monday 25 April 2022 15:28:42 CEST Oleksij Rempel wrote:
> > > > > Add compatible for wfm200 antenna configuration variant for Proto=
nic PRTT1C
> > > > > board.
> > > > >
> > > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > > ---
> > > > >  .../devicetree/bindings/staging/net/wireless/silabs,wfx.yaml    =
 | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/staging/net/wirele=
ss/silabs,wfx.yaml b/Documentation/devicetree/bindings/staging/net/wireless=
/silabs,wfx.yaml
> > > > > index 105725a127ab..ce107fe45d7c 100644
> > > > > --- a/Documentation/devicetree/bindings/staging/net/wireless/sila=
bs,wfx.yaml
> > > > > +++ b/Documentation/devicetree/bindings/staging/net/wireless/sila=
bs,wfx.yaml
> > > > > @@ -39,6 +39,7 @@ properties:
> > > > >    compatible:
> > > > >      items:
> > > > >        - enum:
> > > > > +          - prt,prtt1c-wfm200 # Protonic PRTT1C Board
> > > > >            - silabs,brd4001a # WGM160P Evaluation Board
> > > > >            - silabs,brd8022a # WF200 Evaluation Board
> > > > >            - silabs,brd8023a # WFM200 Evaluation Board
> > > >
> > > > I think you also have to declare this new entry in wfx_sdio_of_matc=
h,
> > > > and/or wfx_spi_of_match and wfx_spi_id.
> > > >
> > > > On the WFM200 variant, the antenna is built in the chip. So I think=
 you
> > > > can point on the same configuration than the brd8023a.
> > >
> > > I assume driver update can be made in a separate patch. As soon as we
> > > reserved compatible for this boards there should be no conflicts. Thi=
s patches
> > > series is targeting only devicetree and needed DT schema changes.
> >
> > hmmm... I am not DT specialist, but it seems a bit weird to have a new
> > entry in the dt schema, but no new code in any of_match table.
>=20
> Here is one example:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/spi/fsl-imx-cspi.yaml?h=3Dv5.18-rc4
> properties:
>   compatible:
>     oneOf:
>       - const: fsl,imx1-cspi
>       - const: fsl,imx21-cspi
>       - const: fsl,imx27-cspi
>       - const: fsl,imx31-cspi
>       - const: fsl,imx35-cspi
>       - const: fsl,imx51-ecspi
>       - const: fsl,imx53-ecspi
>       - items:
>           - enum:
>               - fsl,imx50-ecspi
>               - fsl,imx6q-ecspi
>               - fsl,imx6sx-ecspi
>               - fsl,imx6sl-ecspi
>               - fsl,imx6sll-ecspi
>               - fsl,imx6ul-ecspi
>               - fsl,imx7d-ecspi
>               - fsl,imx8mq-ecspi
>               - fsl,imx8mm-ecspi
>               - fsl,imx8mn-ecspi
>               - fsl,imx8mp-ecspi
>           - const: fsl,imx51-ecspi
>=20
> httpt://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/spi/spi-imx.c?h=3Dv5.18-rc4#n1063
> static const struct of_device_id spi_imx_dt_ids[] =3D {
>         { .compatible =3D "fsl,imx1-cspi", .data =3D &imx1_cspi_devtype_d=
ata, },
>         { .compatible =3D "fsl,imx21-cspi", .data =3D &imx21_cspi_devtype=
_data, },
>         { .compatible =3D "fsl,imx27-cspi", .data =3D &imx27_cspi_devtype=
_data, },
>         { .compatible =3D "fsl,imx31-cspi", .data =3D &imx31_cspi_devtype=
_data, },
>         { .compatible =3D "fsl,imx35-cspi", .data =3D &imx35_cspi_devtype=
_data, },
>         { .compatible =3D "fsl,imx51-ecspi", .data =3D &imx51_ecspi_devty=
pe_data, },
>         { .compatible =3D "fsl,imx53-ecspi", .data =3D &imx53_ecspi_devty=
pe_data, },
>         { .compatible =3D "fsl,imx6ul-ecspi", .data =3D &imx6ul_ecspi_dev=
type_data, },
>         { /* sentinel */ }
> };

Right.


--=20
J=E9r=F4me Pouiller


