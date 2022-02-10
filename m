Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EBB4B165B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbiBJTca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:32:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiBJTc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:32:28 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C00D62;
        Thu, 10 Feb 2022 11:32:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHngA1sjQf48VUsVC2avcPg7sRSWZlqps87CuHAUZ0mEBqnxgiYaIOON+9HhLudQ0b1hF8iwFIyS4eq5ZZ0mf6yqyFWpjly76jr0iGNeYCBTVSzairzR23wPWeWOy/rMwnaqSFIxNW0q4AEavV73fvFMptc/OkTdMfclqPhNpP3rolx/J58XW8ePZH4825qjDjB4mo70syrHY5U3Dwhf/Xsh/jGdLxwrYoZAijwl4ibTOHOqtYtQj8BUcqxAZygn5JfGIPmKSSFX6TiJXfLKojJLj3hG7SSI7Q7h03wuUSWGZWDTUlU0dGtmagEo/is86UNFdRzGCv46wGz12veCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ogzzbKEmnAAV6XWMAe7UrTtEWYY+weug50upauoumQ=;
 b=HndkwGhgLskF4b+/iP/VTvOakMzgavnaVhhbjL4ubC2Ojnk1aHydduDb6vKPBaI2+jGc+1XO6Nip4M1moYNacd6qf7MhT/n+y3yjA6sLqY6hZKGhMRhovDqldxEz+lFhaosZLHtAPWFe4dKkpC1zDX7+7h7+PvG6oxC3V5ShRps2vNrgkpUUNdnbvPTDZcbGNQXsaVBwzp/aIrrjpEOuEQqHIsBBwdV7/QO20Xg0c4cnilQA6OXdvBfcMckLa6K946zuMJdrl5oEXiHrbKkqayml5Bwrjjvq6/1XN7vRntU9SJDVbLe3ciM6U15u/8i896C3mfBzBKxfcPb/kYYsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ogzzbKEmnAAV6XWMAe7UrTtEWYY+weug50upauoumQ=;
 b=s6S8mxkhdFwcwuVLicnkrRuA7V7i1anr9FIZdiPEYA2383PRvBstOLpJ6JWfL/QGiJhN+tvLXCiJHSyuNOCdurVI9lBjftGMexC8cwrVg9n6PGBd39TafrQJKJSQSzf2Ou+Tw3BjIK57yc+w4zhnnoKanLFTAQJBcHs+9ALysOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM0PR0402MB3763.eurprd04.prod.outlook.com (2603:10a6:208:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 19:32:24 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f%6]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 19:32:24 +0000
Date:   Thu, 10 Feb 2022 21:32:22 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: interconnect: imx8m-noc: Add
 fsl,icc-id property
Message-ID: <YgVoRols6AA5HAze@abelvesa>
References: <20220106164150.3474048-1-abel.vesa@nxp.com>
 <YeslLJqwhX668+oa@robh.at.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeslLJqwhX668+oa@robh.at.kernel.org>
X-ClientProxiedBy: VI1PR08CA0168.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::22) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66ecdca6-d404-4f42-0d8f-08d9eccc106e
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3763:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0402MB37632254D28570C493D5E05BF62F9@AM0PR0402MB3763.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfaquEDdta5y5P9ayYf5ghVo71pNDTVr6jkQ2oMoJWRYCb17BWAO+WfzZ0KjO1XRfuyamINDHVOfp2LpcYJgpL5ObJyAE5TCUMNT0Gx1ef8rMXYCXogJQYSQbhcy61xSnY3fhIJIW1SN/PPGhZ5phynD+k+poeTE4s1riZy6PKsZK/s7VQ+cAF8alYOkLufODGjj3kg31b0P+lUfRJX46WYx80t2H9qg/t3FwSdcrw8jrb68PUhq0mq6e+clPzDfHFF7HmU2KhGRbJwtcYiu77AIrLlmfIlke9hjNX9Lo3MTKna23NpXZLHeJDj4SbQa2yC+DTGOn0bPXberY4OpN9WB5nPz3SjSwpfl12j18k9L91HPwHXy8Xxt6bDYZoppFNEbvtEC1hu9J0UChR6XBhGob9WK4Cx3ncGzXwTIpvFokSvRnMkrPooofV9+Y3VaLzhw4P4Ic5t6+nbdlHnjH56Pia1EiekdfA/giZg3/BO0V9JDL+ieODTWq9tu2V9n2dn+cvjL8/XkGiVFqPH2rJZYpyFwSs8GMrkkQaa9nPq0P7OEkgAH1zcYuIcTTjO4wEnP0CQoAxOzY4u3Bg1HAZsbdN8JL0iYLOqlhrzSJTHQPZN3llnuSl1JNgeFAB8caR8NP1BxcVvNCYxDl8Vc449N6JOWdWU5JoVfNPBuTdadXRUleAk+JugbdkfD0sFRMhSpxmQrdDc9MpJ0LeCNl5kmYLQ+tD2hXVDi38haFIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(9686003)(83380400001)(316002)(6512007)(2906002)(33716001)(44832011)(54906003)(8936002)(52116002)(38100700002)(66556008)(86362001)(66946007)(6506007)(38350700002)(7416002)(5660300002)(66476007)(8676002)(508600001)(6486002)(26005)(186003)(6916009)(4326008)(53546011)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tjlGChBVGclOhQrxkC8oLxbp2lUslL7XY2KtiledLbWFJ0javsuqDbNZHuZC?=
 =?us-ascii?Q?dyHQTQ/j7Kd5sBiaONxB4Afc2NRIl2/0dsg8RekRf+Hx/cJVJ6lqg5Do/agU?=
 =?us-ascii?Q?jAENE1Mj127+H3bHrY+8iNAEh/Nmn/eidLs2nizaJ///BVQF+QcF0xjrYRXr?=
 =?us-ascii?Q?Qh863n9nF+ZN/c4zZzKufdrlRn/VkwljnCSyw1x77ll2dmGDTKbZIMskEIdn?=
 =?us-ascii?Q?ROyaepbVdfajC8iyvO8YE3a6SumdDXIkvFN6VCZ5AloV8BkI/AfFEAxqXDWc?=
 =?us-ascii?Q?AyfxmeRCWz2ytI5kmvhrftBO15kjDQvYhyi0AkLgVeQKAsBtRDuf8FMzrxaK?=
 =?us-ascii?Q?gdm0DWbQS9Pfse66AslMsnJCYXjWM9ehHTxGBbUXjFqC4nQDdvU4tLYthq8H?=
 =?us-ascii?Q?Jg6rVxd9RAd0VpLh+gyOalI5SqG7pIR36GEiLgrn4AXsmD9y9OraLbfd5fTi?=
 =?us-ascii?Q?Q0mCe1Ggcb/Bls470saA6zrBBJtYp6oWUSxPwfczbW5aLUNoeuAHDKUIDfgH?=
 =?us-ascii?Q?vWE6OyYqUs0HUZE2GsOvvWIIjzjEGmmRXxwm/8WNN9HW8g0Ka72xbT6qOkii?=
 =?us-ascii?Q?X3x6/a9qyA5kfYiJ55avJhPI+UHl3FZLG3E9FE5Z6vY9Rbe/7rhaZ/aATOdq?=
 =?us-ascii?Q?G7JR7LymVVUrXMzphjHdO0tbU8KKuQDcWdDBc/SjelKqymOLK1Y/dVy8oadw?=
 =?us-ascii?Q?PAf/CcaFZ3w+niLS0sAAaDnb3Bkvmu2dOyfSiUokkWkrWWzd+O4Tsrd4pu0d?=
 =?us-ascii?Q?4/YvHSApdqmb4OFzvD8Zh7z0deEm0ps33F6whD0mZitoObESpT/+sbt100fA?=
 =?us-ascii?Q?B8onKOEjubGLLToIMJjxmL98t9La1NSGi/c8/RyKDN9H68ml/RRymIIhmHVQ?=
 =?us-ascii?Q?iDlWS/Su3ccJ4UgziCAdF1tCviGdy7ygec5qjTQm8nz60sJRLBHpWM0/pUtY?=
 =?us-ascii?Q?Jiu7N2cKPRQ5kDUkwP0+8hgnALzcJtDYoneGJZaIil8pXizu40raFl+W0xN9?=
 =?us-ascii?Q?FuIBJzYXU+7CNKdZuYYIKRUcHbmGkz/bsbKyH7tYRejRoqJXmKpPr+mf1siX?=
 =?us-ascii?Q?5edj1EXB7llb5Ph8vpN6e3qsbNa2Fq2kXOtKiD/18Zbs/D8vbaTVBK/x+NlN?=
 =?us-ascii?Q?Q1uXg7MFm3F5bBR5Ey3qPkIT5PCCc8ors1TR0rLVbfHvzLI8bQ38JolfzaEY?=
 =?us-ascii?Q?k5xQeorml0lrmnlT7tGTVad3hZDLDYD7/Q7nPtvQKZb/6DvcI3F5Cs03rRFX?=
 =?us-ascii?Q?WxkYBv3TxE9WEAeaZ3uGLEIycwMFzDYRZ5cD7m8GBZlfvH+nq0pA5snDrYkT?=
 =?us-ascii?Q?QoHE8CYmsv7KAYuuzc27lBHFXWnWEp0cp+dbeFHiVGCEmyhb3WfjCXRcqSyy?=
 =?us-ascii?Q?TOimUaddyrNogZWyyrmA/si8Jg0W2/LU/xUXgkExOGvOXyV0Af+/eLX+eZRX?=
 =?us-ascii?Q?cq8Yro5P1AMtowIp5qZLdxBa2xuWlPp/3XSbrXpRPiFpS2/V5jgQwx0UPC/M?=
 =?us-ascii?Q?FxdymtSiMQBR5l/OnUHkTJ5MCu5bETH4AlilkEAjQTtnp3QBBcPG/tSIo7KI?=
 =?us-ascii?Q?ndnqWZ23sycTHYq8E9HrJmwkrLbFm9jnGRZCsHv/95XCqOFEct7lNEcya7Xd?=
 =?us-ascii?Q?0+VlZP0RZOvcuueurPr7mIo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ecdca6-d404-4f42-0d8f-08d9eccc106e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 19:32:24.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FLWkNcurk1LhYxUKq3oFptihKoHerfRbs5gUd5KHvZ6c/W4SJSgIXYdkHwNNKqiv633JN+zlKGHNw5Cg05bgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-21 15:27:08, Rob Herring wrote:
> On Thu, Jan 06, 2022 at 06:41:48PM +0200, Abel Vesa wrote:
> > Add documentation for fsl,icc-id property.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> > 
> > Changes since v3:
> >  * fixed typo in property description
> > 
> >  .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml      | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> > index b8204ed22dd5..dc7f6b6f508a 100644
> > --- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> > +++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> > @@ -47,6 +47,11 @@ properties:
> >    operating-points-v2: true
> >    opp-table: true
> >  
> > +  fsl,icc-id:
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    description:
> > +      unique ID used for linking i.MX bus or ddrc node to interconnect
> 
> Where does this unique ID come from and how is it used? Why aren't cells 
> in 'interconnects' sufficient for this?

Sorry for the late reply.

Well, the 'inteconnects' property is documented as a pair of
interconnect nodes, specifically source and destination (endpoints).

The fsl,icc-id is used here to allow the the imx-bus and imx8m-ddrc
nodes to specify which icc node it belongs to.

Basically, the 'interconnects' property is used by an icc consumer
to specify a path towards the target, while the fsl,icc-id is used
here to specify which icc node (in this case, not an endpoint)
belongs to which imx-bus or imx8m-ddrc device.

> 
> > +
> >    fsl,ddrc:
> >      $ref: "/schemas/types.yaml#/definitions/phandle"
> >      description:
> > -- 
> > 2.31.1
> > 
> >
