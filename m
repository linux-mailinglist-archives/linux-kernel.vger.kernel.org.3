Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25142521095
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiEJJWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238627AbiEJJV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:21:56 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2079.outbound.protection.outlook.com [40.107.102.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788DF20D246
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6gAIiPqz1f0FWd8wk4Ujv/YattMjEj801ze7QeZrhkxd8UHsLjCDvkyAFqmdHydAiQ/M5px0nzJ2HIuRsqnrlqjF/lx7gxbGL5Y5NEHBN5mkLv2d8B/9NK34t1cmROhsbU00VWO7CM+1OM3KeM16D/oLhSuSuGirrAR9Kb0D7zmkhsTNVJg4w3hr2nvnf8bI1GwrtLhqrQVRr0XnyNvQpffFl3rZ+1Gb3PNG+jXvZpbnPSbAzUntvrgzzDnejv+FYLZaFINQvlaXaA+3LCVe1nvyQjXwSU0mXUkILAex3iGROOqVLm/ACM4ilRYyWQtDd+Xs/WgESAPZm8DimY4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPfK1yP5gce34nT8LELdyslHHU1NmlPA295HjMthpLw=;
 b=lukQ0vZRwMU+WrhqzEPjIg8czrqlLOVhuy0RoVO/Rfk5yyarFoFUgpEefiCe5feeAOk/lqBsP0QmfPXDH1QN8NJXBpjXXc8dNT3zBmifiebqhUwQx967k1IxS//LX5ANr25ToiMVKFpKOkJlonfBCsdIb18Fvr7/vXlr1l1nHYBZWtaTKdEK1fwaReNSnOmIZ2Jw3m5Ikw8St7NwRSCv3t7N224fdpt+5apKHzMzsCvXuW4lr7dUCk6WUxtkrR5VPjwu/auA7M2OnWMJ22bu4JWnrcm5huLj2VjPtuG1NPsXmD2prRvk3B2Kntr9XBDprLY0wa1JtEFPLItzYVyL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPfK1yP5gce34nT8LELdyslHHU1NmlPA295HjMthpLw=;
 b=LlYDKr6/3NiINZOL1Qs7IBYCJ2BpdDyV2mm8sxjYRPa036EoZS+2mAXATlZvYWVDFC8VYB/K/Zu5IR0PndxtuQUEzvYw1f/a1uIysXRBIp9igEqcfZ7wFzO+CHYAxbhAq1rkHNETL1hsCUAzM4EzH7maRC0mw1AGRnbDaIjeuh0=
Received: from SA1PR02MB8560.namprd02.prod.outlook.com (2603:10b6:806:1fb::24)
 by BN0PR02MB8222.namprd02.prod.outlook.com (2603:10b6:408:154::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 09:17:53 +0000
Received: from SA1PR02MB8560.namprd02.prod.outlook.com
 ([fe80::94f0:32be:367b:1798]) by SA1PR02MB8560.namprd02.prod.outlook.com
 ([fe80::94f0:32be:367b:1798%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 09:17:53 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Nicholas Graumann <nick.graumann@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Harini Katakam <harinik@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] dmaengine: xilinx_dma: Free descriptor lists in order
Thread-Topic: [PATCH v3] dmaengine: xilinx_dma: Free descriptor lists in order
Thread-Index: AQHYTa0RTWwUJ64q2kGA8hfT/ly+Ca0YASdw
Date:   Tue, 10 May 2022 09:17:53 +0000
Message-ID: <SA1PR02MB8560D82039C9EA89E2914D3EC7C99@SA1PR02MB8560.namprd02.prod.outlook.com>
References: <20220411140348.30252-1-nick.graumann@gmail.com>
In-Reply-To: <20220411140348.30252-1-nick.graumann@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 290912f4-48cb-4e06-6bc1-08da3265f66b
x-ms-traffictypediagnostic: BN0PR02MB8222:EE_
x-microsoft-antispam-prvs: <BN0PR02MB822288C46D2029378B1DEDB9C7C99@BN0PR02MB8222.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /JQH/71cJdutf5RAfWarij2C+Vw8C4VN5AsSFW4IyvkPWKosavcwXYt7TI9I3PLPGilXP1sXTZciQx2I1i+6eg81qTc+VVyrd5OZgSUE+5VXePgsPsY6WnKkU8v6fwtdxF/FSywPqrdUuCqYWgXGQq9PK8Z3yZc37vORs0uREXUiFGFkApspIy8+sm4q73C9ounQaWKi834yAkQBHEPDs7/AaKxw2TAn6Et6VvLYUqSXcRVHg2dI1CIcjqxibCG8asrYrM+YENbtrcHis922VyR7REoX8u/V6c181BRgxVJbSi602Ius7ExCMb5r3s9vy/VnYxwa6CDg/A41vx6Qwgn0d78Bh6BZtRbtC0NFJnPzN0CFHaf0HqDJ5GIdFX53iM5NwF14a4WmT4l3KBR1p2Kt1v8yPiGK5id4b1tKgfkwIy0HbxHfKRibVBKrmDjm/86sltHWBJmNmdY/oJOZEZUBaRR3tzSqYGHFWccqU2R7HW8K+RjoCgVxHK9DCHU8BBr6kRiIiYDjXUeXHnuLcTg6ChFeZ+gZbtKXnNRZPfe9lTKde3cr2AFcv19WXS4xA2fOGfMgoImF810C1UeA4KRPObnJQ72XmWIv8Kb+dfHWy3GgwE9hIExzpcLDS/XEprhkacXClzIV9dARgl1Sqr6BUMOswWBtYnnBhjRGIstKpVUpE101SEBE49lksczRMiKI/QLeRqzuJ9y8GtZZ0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8560.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(54906003)(66946007)(4326008)(38070700005)(86362001)(8676002)(52536014)(66446008)(8936002)(110136005)(6636002)(316002)(64756008)(6506007)(53546011)(9686003)(122000001)(7696005)(26005)(71200400001)(76116006)(2906002)(38100700002)(508600001)(83380400001)(33656002)(55016003)(186003)(5660300002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GsNi3SES1bK5LOOhX4Wc7reniN58OsQTPRpNEli+ncRL+N98x/HbxVXvN6Mo?=
 =?us-ascii?Q?ly88HrH54zxUcWXzKkZF6tjvwpuDfPfvl1kHYTncbsowLlA2tA8iiaUF+PIo?=
 =?us-ascii?Q?VVnlF/Z/j7pDVWbLc2PVwogMVaZAkigfzNIDiN5ghyB6R+FDlRePldzYARZy?=
 =?us-ascii?Q?nIsWeTDc02C+RRwC1NiON/1p3GXG1ZWQsjdTIo58VcO4ZpAIU2u42Llo7tuA?=
 =?us-ascii?Q?2YORPS8bz0GY6ajTO1DAHRr1z71K7zqKT0trzOa42CwarcnqHYtVDLKxwgth?=
 =?us-ascii?Q?y0ObjrmkPhSBvxdqrzWTSn/rjwHW+JW/36KbIDd/fcdVBch9AkulEHIa0TvG?=
 =?us-ascii?Q?wadiO3hHdZb8oqaWqc/0pmjBWI7dxM9sdYvT3E6TuUgPwTl2KzwH/NS143mv?=
 =?us-ascii?Q?EwouR7Em0p9172kzHyKIWp9R7Q4aNwJV0JykrZtBupKm7vntWw3+rCNIfp6E?=
 =?us-ascii?Q?+t/sHSpK4/+CTcIr5rCXc3Q7jgwJfGPCccZrvoFjfo/k3/zT6+GvRV8UbFjA?=
 =?us-ascii?Q?1V9ce5EeGQX//4Hw5iod1so1eKeYHVnAtrZReTFaGvYJaRvs5aI3ahj4/Kpb?=
 =?us-ascii?Q?RJyqTe2pp7YYVVuOI5n8zca4sKF/ZSo2VaDoHH0qtWzD+FejQ4B5y6rlrtGG?=
 =?us-ascii?Q?7xJ/r6Lh/Vjgw1f/U2oM8GNOgjSBtoQy8n2OjPFP3mYZDvxOL6ntURKhobmO?=
 =?us-ascii?Q?+kPdtCUhCqY1g9wLuMp+e1tcGoczu5hc8/WY7T/660MZBYOSKX3FAbeKp1Jb?=
 =?us-ascii?Q?hqo6al/Jm7eO286SGUytrQhDogm7+NBof60f9I1/vqprVP91Y6oPgGAItcy8?=
 =?us-ascii?Q?ltxTZ97V3v0GuFOJHKjB1rB1eqSIRizhqFaKAozVLw1lTAx+jjgw16FIT3Rz?=
 =?us-ascii?Q?YyPpj0wuUYktCjtiCwFQYV1D+yxGLr1DrGDQYk5I5zZRdZQ2GNk85EU8Dk/I?=
 =?us-ascii?Q?LGIdDxWyfA7Km8oXXCtbAymupHw4wfXZvJA+SnsGYm6/lWovCb+h/SZ29dsc?=
 =?us-ascii?Q?RKR+K7gfi+8FYoj8lQ6Y1bt0txNvhhTZIdfO3p1zHLwmZoDrPP18SB74NvEh?=
 =?us-ascii?Q?ck/hhjHWrr0nqyJBgdG5OiE3WkH2gemD4ceTQpLCoCFPt2dew7qhVsz9+fDb?=
 =?us-ascii?Q?z1kgxAaHNM7KYWbKCABJ5aaKtIDNimJK4+i2BNnRNhnA+NiATyIQw1Us9n4e?=
 =?us-ascii?Q?YG27tMiBcAw3bDCtajEhjmWD116VaFBn+dqFEh+TOpHG3GBuaKYVnKsG9W3I?=
 =?us-ascii?Q?hEu88jLM0/HLXP7W66AdFuQg/8APYemN8W6MXunPZ1DFMP/DjMADpcIVXMYE?=
 =?us-ascii?Q?luZRJoK+RwpC3S/zRPW9wk3empvj4MObNfbcTcjjMmit2Z0ERN9/M/ZnuHjA?=
 =?us-ascii?Q?TLSBeUnX1yXuF7KE4/KdE0NHHTeuNmPBWMytcsWGEBWvH3Rjxa4erIUsXwIm?=
 =?us-ascii?Q?5Gf7URkrTHTTXGWOcB4TBLn7w3NZTfnRp0LKd0UAjCw+M+jYud384aisGiPX?=
 =?us-ascii?Q?MKBXAKlaXGPa9GaU96jRU0Zhs+Vk6A9Hgrh7KTQQjYk6TH7ZHLOTEAIScYFV?=
 =?us-ascii?Q?DU03jHybzY7us8UVltziBOG6LQ/zHvht+RP9cjhrIVRMb3DPsKxYk9I0roXR?=
 =?us-ascii?Q?l0SpSZbazLeM4/oy+JAero502xV4oAm/WPqSf2CoO2NeNbIbk7i0Cpcb9hT1?=
 =?us-ascii?Q?XVJ/1XUKctQrilhCG72P+407n52ALP8NU/+fhDCDJB3SjS/RTNvT9x7WqiEE?=
 =?us-ascii?Q?d9ibJkNwug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8560.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290912f4-48cb-4e06-6bc1-08da3265f66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 09:17:53.3511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSR6I03k3RtyYsqF72Yeq1jAJWx4urcebBwAQ1fqxsZF6hzo75K2OsVuOUgCUYRmD8XZ2XLVEi7kWYzug4Bo4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8222
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Nicholas Graumann <nick.graumann@gmail.com>
> Sent: Monday, April 11, 2022 7:34 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>; Appana Durga Kedareswara
> Rao <appanad@xilinx.com>; Harini Katakam <harinik@xilinx.com>; Vinod
> Koul <vkoul@kernel.org>; Michal Simek <michals@xilinx.com>; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>
> Cc: Nicholas Graumann <nick.graumann@gmail.com>;
> dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v3] dmaengine: xilinx_dma: Free descriptor lists in order
>=20

Minor nit - It's first version. I think we need to spin a new version fixin=
g it?

> If xilinx_dma_terminate_all is called while the AXI DMA is active, the fo=
llowing
> error messages might be seen upon restarting the DMA:
>=20
> [   72.556254] xilinx_dma_irq_handler: Channel d053cb5b has errors 10, cd=
r
> 2c049f80 tdr 2c04a000
> [   72.557370] xilinx_dma_irq_handler: Channel d053cb5b has errors 100, c=
dr
> 2c049f80 tdr 2c049f80
>=20
> From then on the AXI DMA won't process any more descriptors until the DMA
> channel is released and requested again.
>=20
> The following sequence of events is what causes this to happen:
>=20
> 1. Some descriptors are prepared with xilinx_dma_tx_submit (so they get
>    added to pending_list).
> 2. The DMA is kicked off via call to xilinx_dma_tx_submit (the
>    descriptors are moved to active_list).
> 3. While the transfer is active, another descriptor is prepared with
>    xilinx_dma_tx_submit (so it goes onto the pending_list) 4. Before the
> transfers complete, xilinx_dma_terminate_all is called.
>    That function resets the channel then calls
>    xilinx_dma_free_descriptors to free the descriptors.
>=20
> At that point, pending_list contains a descriptor that is newer (and thus=
 farther
> down the chain of descriptors) than the descriptors prepared in (1). Howe=
ver,
> it gets placed onto the free_seg_list before the older descriptors. From =
then
> on, the next pointers are no longer valid because the order of the descri=
ptors
> in free_seg_list does not match the order in which the descriptors were
> allocated.
>=20
> To remedy this, the descriptor lists need to be freed in order from oldes=
t to
> newest, otherwise segments could be added to the free segment list in a
> different order than they were created. This is not an issue for VDMA nor
> CDMA because the driver does not maintain a list of descriptors to free.
>=20
> Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct
> Memory Access Engine")
> Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 3ff9fa3d8cd5..3b435449cd0c 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -884,9 +884,13 @@ static void xilinx_dma_free_descriptors(struct
> xilinx_dma_chan *chan)
>=20
>  	spin_lock_irqsave(&chan->lock, flags);
>=20
> -	xilinx_dma_free_desc_list(chan, &chan->pending_list);
> +	/*
> +	 * Descriptor lists must be freed from oldest to newest so that the
> +	 * order of free_seg_list is maintained.
> +	 */
>  	xilinx_dma_free_desc_list(chan, &chan->done_list);
>  	xilinx_dma_free_desc_list(chan, &chan->active_list);
> +	xilinx_dma_free_desc_list(chan, &chan->pending_list);
>=20
>  	spin_unlock_irqrestore(&chan->lock, flags);  }
> --
> 2.35.1

