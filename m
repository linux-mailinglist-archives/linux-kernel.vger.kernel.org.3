Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5597250F374
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbiDZIOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344535AbiDZION (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:14:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D97C62A17
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIXdiYV0vzHp6AyI8WL2TKZlh9s44x8/qbnUtg50pCNWIBFUTPDhOPYeoEH1Xy9Hi5Uy16Y35xxq5Xx1fKnhookQLBvhIfEAbYCAy0vb5ewZdhsTomU93NLTYLF5vioh2IF55WB1QniBxNF+HbDNo2vYAxXXltiwQq2QkkiQxITsmVPHKXjM53JokPylrSmLbvQwEJOAbulb0dGOpy2WzMRLEEviHeHjTpSVoe06R7NvH6rFnKJsRjAlPOUkGDT9naDZohtibqvghpvNNFdqpNga9Lg8L7Yyur/H4b0s0VNA8f6PoUXhpDOJgMX9tN1sE0aM5xvwQzIevv52VBS7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dlrjm6i6kQ/UhUvZSbs9jRMw7ECeVy2Hsrj6pWpw0lc=;
 b=PXu1ObN5W3pQGHoJN1FfkVeGSGNG7z3lMmT35QjyWoTbH+O76O0pz0TIVvKokrhI1HPGVV1HFUs99RVlmVUq8n87yDLHJVmOejhc2vZPjXrSNsPNhoS2M9jB+eXy2Vdv85R+oZwQl7FKtTKWeUDmHhUS0pUMd6TkZbH39DxnMs6t0sXRJ/5jrQGkFzbd4MHHDx4I8DAlRfwdK5G3X87SB9nmx9trUn6x+U4GDIBA919RNaUiLqEpkIh8tohfKZEBUTeqrVYJ4Foh9srwzXz5drJjmiToimQu6Tf3RjRYOodH+rvBbDqVjHTDNFthEHgBGb+e7+bX4rkwSWZov3Y64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dlrjm6i6kQ/UhUvZSbs9jRMw7ECeVy2Hsrj6pWpw0lc=;
 b=iRJWKDUFnc/RQ9/15LXTTYOcs92YI+IQJR/ZrX6dfZU1KBv31eLOn2xLngNioXPHwTT7nSlKbRQIgqNOW2nA5KdrOwIwhXSKzXjN1XjXutAQhx8JT49+2c8s3FJL2TA80GkCkKCyS3AEsCRtAACfBKPcJpaEtVbLLLfec0NB4SE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by DM5PR11MB1676.namprd11.prod.outlook.com (2603:10b6:4:10::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Tue, 26 Apr 2022 08:10:59 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::89b8:2d6e:d075:527]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::89b8:2d6e:d075:527%5]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 08:10:59 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] dt-bindings: net: silabs,wfx: add prt,prtt1c-wfm200 antenna variant
Date:   Tue, 26 Apr 2022 10:10:52 +0200
Message-ID: <2847775.BddDVKsqQX@pc-42>
Organization: Silicon Labs
In-Reply-To: <20220426050812.GA3419@pengutronix.de>
References: <20220425132844.866743-1-o.rempel@pengutronix.de> <14881918.tv2OnDr8pf@pc-42> <20220426050812.GA3419@pengutronix.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR3P192CA0006.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::11) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe769926-849c-49e3-c319-08da275c4bca
X-MS-TrafficTypeDiagnostic: DM5PR11MB1676:EE_
X-Microsoft-Antispam-PRVS: <DM5PR11MB16764C8008AA6448E067458993FB9@DM5PR11MB1676.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nwcPzqOxZRISp/2wguKWZ5Z+6QDTf38IeiJfztoj20KPsWWCw+wtz+hsYpT5iILngMDmSOas/nMhvLEYQHO50PjSY1NPuD31AkGOHz1wyeMhVjHf8X4P4JiSRWevg5p/vzB0iRjdfc1++ZgaWca+lvi9aXTzKuIh27qzgBhs5rFos5vFqhq9mnfpXXAd+eVQI1BsKP6z8uoDgkuzpBH/sVDL9SinKDrKqr9ybYs2wtL6Ee3VN6cGhnvxX7RyfO0vHFh0bzkp4M8IGfMBb9wgOq0FnWZvaiKvTV+1uS6lcWEnSmMsaeGcOZWtcWFfF2MkauLZG/b3d98AwoVEQ/L4yzSfqbudsXWhHRGlfb0tWxBSXk3k5RAHfCQ5vCs6vwAwuEyRxtIdG740JRoULcbHlTj3JlL0di8GKr3fYbUTHitvmfYG1cvc75ul4UMa9G4SOMaPjXP7M63tCTcyivBdjqZEXWAyxQP3OoVhAernVxHp1qfQVdRTVr5UcblawC6PV4CHhTSfcNesFFEzimXu4ADT9KLzUw3Zxh7XA6mg6Dkt8f1BKGBr0hdalvBIYvYp1pZ243iO55YhLz0dDHJp3CCDWK3KVKBj4O2OhHLmATXMn3F2fW5nle49OhzCs8urU+PszuHUtxrd1aPlgn4vy2VJrLByMI8s0isOCRB8kwERUp5BEmocIiQA5NpadsV87l3YnPuPbkG/1O0oFDmzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(66476007)(4326008)(9686003)(8676002)(6506007)(54906003)(6916009)(316002)(66556008)(26005)(8936002)(66946007)(6512007)(5660300002)(6666004)(52116002)(36916002)(508600001)(6486002)(2906002)(33716001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LFxcqfhX3wzsL5BdJdBY/5OtliEIN9C8EOhr2/Nf+rm7ksXzPgA0Ehv10Z?=
 =?iso-8859-1?Q?s6k8GKsRSfKCPaaQ0yt4m4KnK/xdNfRPB/Dhh0YK7MQinqZe7zMFVt/vJV?=
 =?iso-8859-1?Q?B2SqTYq2DF0HWa6AqknholNyfOVUzEvbySHHrBaJTlAjz0fEmXzvMTcyDc?=
 =?iso-8859-1?Q?cHQSDOl1R0YFcmcCstYaggU1UqaeVMeZk2Hv6IWVSXO7A6Js67uyw8YRUZ?=
 =?iso-8859-1?Q?7c802FIWGLsnbiIL2C+5zH32ZC452pAgeTBnk1mCSuy/VlPrlKoGCYOR9T?=
 =?iso-8859-1?Q?7Jhwlg4B4iBWhpMp3Qd5InKkf1cuRW5ClWgv7sck402v5SRw4K/BNoXMl/?=
 =?iso-8859-1?Q?70j6+j3NqFybD1oZmKzRcrkezBeK/iQspUWvQPD7Q57mc1t00ugM+7kpVf?=
 =?iso-8859-1?Q?0HBfYfzM97JsiOMqOHYou42pBtjiYZL4fjnVvlDQUBBeBhyfQUJ10UM+RH?=
 =?iso-8859-1?Q?DlgyvIp9SBl41dbw2IcSElHgoxpm7Wi+i2d4KonK6VdKH8vqh56HaFQiu0?=
 =?iso-8859-1?Q?UdwWcQi68ZVPqC5afhelOucg1YytwZBvtZZH4oR3VLCOeJOFSv26slPkf7?=
 =?iso-8859-1?Q?uwVNHbYaQMF2mj/6DI5ayghRH3ttw1u3HUfp8ySVWNt3dYmPXwk+7kKaBM?=
 =?iso-8859-1?Q?dASP4LvHIgoWJyHsa9yDW2JymaF18vx3q3G/uyjNQwCk6Zy0izcJVDKGbT?=
 =?iso-8859-1?Q?zWSOa1fXcn+vyoB7+wpuDvvCSYucelA9iChiqnayns7ealtlL+5mEB+etL?=
 =?iso-8859-1?Q?BE4upok2FL+mkwKR0u8OcGHTy22HWLifh1rfemkuvUfQpritamNwYP8W0q?=
 =?iso-8859-1?Q?zq7BzY2fURM5oTYYOu58dfwjC50JGrvODxT+uXhWB02VxmM9nMC/pALGXr?=
 =?iso-8859-1?Q?e7BgtybDPx0Zz6u/cRvHLu0n2YKjdzZU8wrR+v4QtpYmWcmwsYMOFVBcLz?=
 =?iso-8859-1?Q?qsBD/sY99jmTPaLosSu99cx4V6VzH4Hcxdvxup1a5QLq5sIW1mAL++VJuZ?=
 =?iso-8859-1?Q?6VNebvACfVXjA/+FLZOgljwGioaeEPRtxXTHU59TULJl+crrx1TeWy8/2K?=
 =?iso-8859-1?Q?A0PrmIA7KgJfLAuKjZduBVD7vs/XzIsR+OVLCWb4+woWu3FippRJUM/5VA?=
 =?iso-8859-1?Q?TBKFD+mzfjUU/E1wLNt07c34OPAeeSB6yGGJMktDNF93mdWB3Gn2Uobbc9?=
 =?iso-8859-1?Q?LwsEYMM2KWEHzIL69Qtq4DuoLrP6JRppdRmC2jto5Z+P798drbSnfZI/Z0?=
 =?iso-8859-1?Q?YEbhi31SkFSpeVqsriNdWc5/dTo0TvSSO9R+WKJA6B0Mi3536XUE4Of81m?=
 =?iso-8859-1?Q?hMhMSJDwd4eMO4ifHJgmvlnFR2Zr9Tkqe2b2a8ydmXJhTylgBUcZ8tphDZ?=
 =?iso-8859-1?Q?5Vx9F/EFbFX3LxWaZ+ElHaSe9jWZkowtlsffjjYNK0Loxvwj3hSc5l9L9y?=
 =?iso-8859-1?Q?KHSv39fnrEDnLoBFy8zu1pr90+BextJgPiFbIOwghiMlm+j18AbLfpLMbK?=
 =?iso-8859-1?Q?+gk3mZ8+uAn2rygiVEZDENpKz0mSYKl57kCD7YosEum3Jxxa6rOx8nG9Y5?=
 =?iso-8859-1?Q?6AqFCPbys1ddQCYi3H0DctHn/3nxeZ3D7637sjBIbGWS48x8X5MvLdSVqv?=
 =?iso-8859-1?Q?5CwBJDiB+0xK9jnrq3QZ6/Ikm4e/GIAYpfrMlKcE4EDlpFg1sKlzty9mEo?=
 =?iso-8859-1?Q?aHK3K9sLHkutK59Mljqo7b/joEmmnoD9w6ZJRuKWBV+5i92pyw1CUF8dlU?=
 =?iso-8859-1?Q?aTbxCqrfi+JkCsS/yacGlUKJX+ATaXz3XZpN5d5xoaOVO2JnjeG0Rf5fQ2?=
 =?iso-8859-1?Q?8SD4eyqAeQ=3D=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe769926-849c-49e3-c319-08da275c4bca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 08:10:59.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGcBNhJflG3pLL7Wjx8cPF5CiYcROGH+wlPuVGJ8eYFQYguIjzMFWF61aw9Me2gSn9Z+QP/G1PiBCkYreNOdwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1676
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 April 2022 07:08:12 CEST Oleksij Rempel wrote:
> On Mon, Apr 25, 2022 at 05:38:20PM +0200, J=E9r=F4me Pouiller wrote:
> > On Monday 25 April 2022 15:28:42 CEST Oleksij Rempel wrote:
> > > Add compatible for wfm200 antenna configuration variant for Protonic =
PRTT1C
> > > board.
> > >
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >  .../devicetree/bindings/staging/net/wireless/silabs,wfx.yaml     | 1=
 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/staging/net/wireless/s=
ilabs,wfx.yaml b/Documentation/devicetree/bindings/staging/net/wireless/sil=
abs,wfx.yaml
> > > index 105725a127ab..ce107fe45d7c 100644
> > > --- a/Documentation/devicetree/bindings/staging/net/wireless/silabs,w=
fx.yaml
> > > +++ b/Documentation/devicetree/bindings/staging/net/wireless/silabs,w=
fx.yaml
> > > @@ -39,6 +39,7 @@ properties:
> > >    compatible:
> > >      items:
> > >        - enum:
> > > +          - prt,prtt1c-wfm200 # Protonic PRTT1C Board
> > >            - silabs,brd4001a # WGM160P Evaluation Board
> > >            - silabs,brd8022a # WF200 Evaluation Board
> > >            - silabs,brd8023a # WFM200 Evaluation Board
> >
> > I think you also have to declare this new entry in wfx_sdio_of_match,
> > and/or wfx_spi_of_match and wfx_spi_id.
> >
> > On the WFM200 variant, the antenna is built in the chip. So I think you
> > can point on the same configuration than the brd8023a.
>=20
> We have attached Molex 47950 antenna on secondary RF output. Is it still
> compatible with brd8023a?

I think it is not. You will have to provide the configuration file for
this board.


--=20
J=E9r=F4me Pouiller


