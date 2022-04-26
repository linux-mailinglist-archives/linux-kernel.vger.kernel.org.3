Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917C2510157
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351887AbiDZPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348230AbiDZPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094F91301A1;
        Tue, 26 Apr 2022 08:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2C0iTcIwy66/tYOuetKTe9FXqzSmn2357ogb//CWgF2BEb6h0qRqRxcU7qz+wurH8Bz87f8dGQSA33KWzD9pNU7lcrshbZXJ2vNC0scawWvGwpkOzk41wWnw1eDdsYVoXbSa1qvDhh1RrtEL7azHMhJvb1sFhN2S19GlR22G4DC0gkLfIcvMh05op25MNPoZZ/kiiCeA/LvOv5j77Aqwl4G1EVPkm0qKMy0vUBDUUqQVlUVfZKt40dcF+iwjRowNW1zh2wZBg3igzajgAuxmsJEcE3ZJlDV9CXs0GyTsrxfgjswl46V50HWD8x7WSL7OWJxVKFDq7pRgXtcx/nisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lV2Yltfl+qFDSwXHPrDvEUR9O/wgSYRCpqL5t3Qyxw=;
 b=RfIZP0yQY8J/G1Q81yqIgDHWATuOiNiJfTO3195w8fFATkvRjy26DExviGhiobPTMcXaprmHW0abDxgKN6uWs8LEyL3fQDsfAPikQAqVR5g3hJHodoOMfeXAnVQiV0ZelCxbMy0LgXEvr4x5+e6IBvKFhTCl9m4UNKFC6vf16TFbgkjPBFlCKX4XrDTiTLXS4cN61ZFl1f0I29521BOZzbVi2GSjHViCjO55iYSjQZyWedEZF6cLY6m5xU4yxyloNjc5JLzJuFuw3+7rb5FmBk3F9UwNt2bnqJ3OnwDi/DO9iThwEQz9p/S1FFKs7/l4SH/Q/2+IKJ2aMcqP2/SdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lV2Yltfl+qFDSwXHPrDvEUR9O/wgSYRCpqL5t3Qyxw=;
 b=fDfkIIQlQb5hT52KmjORj0JXocMmT8KOdVcdzpdhH+tpgpMLQRUfZ5f8pXvxk9VNqhWHaMKXZkcoAEj/qumA2pRb2+TNx1lNdC2gUvfO0SD4gSaXBLguk0xKTRvluDAkcBiXFzv51Pt89hC/clDKgWXUy6VH8KPjAsaIzSaoTsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB4804.apcprd06.prod.outlook.com (2603:1096:4:16b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Tue, 26 Apr 2022 15:06:24 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:24 +0000
Date:   Tue, 26 Apr 2022 23:06:19 +0800
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] mmc: atmel-mci: simplify if-if to if-else
Message-ID: <YmgKa4xQ+pOd2xfh@myhostname>
References: <20220424090422.97070-1-wanjiabing@vivo.com>
 <CAPDyKFreW44ou8O4R53XUf7iZTGBBMM+1jmrOeh9cyEOTU-r1Q@mail.gmail.com>
Content-Type: multipart/mixed; boundary="10FwTIgmx2zT3VD7"
Content-Disposition: inline
In-Reply-To: <CAPDyKFreW44ou8O4R53XUf7iZTGBBMM+1jmrOeh9cyEOTU-r1Q@mail.gmail.com>
X-ClientProxiedBy: HK2PR02CA0155.apcprd02.prod.outlook.com
 (2603:1096:201:1f::15) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17605721-8aef-4c4a-e581-08da2796542d
X-MS-TrafficTypeDiagnostic: SG2PR06MB4804:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB4804A0B86E95007990EA1052ABFB9@SG2PR06MB4804.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9niag2qehUAyzbJPXMQn4RjA4c7hD0L1oMVv2uCMWHsqEHLg8uLV8uCu+i/0Xog6vofy10VGnzl2NFr+/ytYPyYPFxjHuEK0qU22hVDr7tVHQbMgeQor9q12fxd4eDIuXNsuzO8EIfaOaA1iD8BbIXvU6ANR2opzovEHMvBQzMXadz+5oQlmy3BOTNj0kQQe85ZbZxnoiPK9W9LOknBQ06evRRDvfl0Nq5CEpGBt5GkgGKAY4jlm7kSW7ypAZf41faAuWPpdcKOLVx01khzgbc4Eje8IY0ctMccY5HHo8Z0bj0z+NDitzDjxcCySfcRCETNT5gy0lyAGnxPdepux9gFBUi+WVniUKHdF/9v9oSSDSrEBuzbHQy+Dlnn/lrPhfB8slrJiUfRl3gwFH6pDS8yCelFMdGOXJteLNBnGLkXalREi32YHLRiiw/bVusN1q7n5nHLlbVGVDUDXncTCYR+vuFHG+ibEyh55rCSl3lbVsPMu2qReVtFjBZeV4XS75y0MOSXAgma1blxM9ICr4tokdScfD6O3qx2JLYH68ZbURI4vc0/eomUYEaPWLAVGPLmIc8JrYwVcA1Ok8bdukjK9nQBnih1SNE8EhtI66wmL0ND+UEqjpTfepJLLRlioIBr76bdBHxTOwTEgSZo+Axfdi8R8d93O/gjDOXkWnpU00DunE/zI2l8KhLeofUwnXj7uVOIcMGJPnNKQSW8zsKSUlxwHXVsLSVG0Ns+0v90MsjYhgfhSCbh7kO8DBAYP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(54906003)(2906002)(5660300002)(235185007)(316002)(33716001)(6916009)(38350700002)(6666004)(52116002)(4326008)(8676002)(66946007)(66476007)(66556008)(186003)(26005)(86362001)(44144004)(83380400001)(8936002)(9686003)(508600001)(6486002)(6512007)(6506007)(38100700002)(67856001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92OXtxQ88rJ5hZsZqDP/FnGuj8Tv4SrG5k4hA26IlHs6HEWtXy9u+STbTheH?=
 =?us-ascii?Q?9fuGZEtDeyK27ahYbZHCKdh50/ZVIEfA9zYhit+LqVN8fnHZGxARaW5fVNcw?=
 =?us-ascii?Q?T/yBH6OwrRaFpuncVoALz06JxG005HL8Lne0XRCVYX2cUgf9eiCEGAZiPEvO?=
 =?us-ascii?Q?fgBa4vjOvoNir7sDmTIr1FKLjTdREijTrZkFDbt83nIqQdcf8G8sJUrvRpqC?=
 =?us-ascii?Q?btzS2VZ6LuezCfzfrDikfdf6z1i046MPI3CMhG1KGQzZB4RYtTEDRROKzT/H?=
 =?us-ascii?Q?7FsEt5gXGIUaXBiywIXeSlgulBTCXVXpuf4oWB8A71Ki07TfLrNhc0JZgQu8?=
 =?us-ascii?Q?hiBcmofqzk9lRXqDM27Xw16MwDwSpRlqmZ9wtDLlLFdnNDRz+LYtTRTluIbd?=
 =?us-ascii?Q?jz1zIY4j1SiF+uLRh1GL5jwOwmVc6kfWNxpcNe01gfvj4RprDAxu5CvfDttV?=
 =?us-ascii?Q?zX3DozwZbGPOiLXv1D0TXbxxtifbrOToiLMT8PSljYHBH7EehHOwAZnaJwtw?=
 =?us-ascii?Q?Tf0CP7bSqu59g+ip5akEaip7LeMjBdYXXfcwjiwCnDkUdmEfTNDeY9vg5NbY?=
 =?us-ascii?Q?A4I3SGsOJETTzuDj2sKKhniR4gOW2SdhZAij2ZvpJ8mWFfcWLT33ffxGebbh?=
 =?us-ascii?Q?iPy9QhSdJCjIwwXnUXBVTveBXn8SqxDOUNfHfyPnDOmiCsVvhuwnhHbJpmaP?=
 =?us-ascii?Q?WUa8xycorqBP6ICwKW63iq2/HCnHwcwhZORiCfvBmBOuYVjieez7KLBqAFJI?=
 =?us-ascii?Q?lS6vrCtEVqUnQtoec8BybnalowEiGVF28l+2hZcKj+ihDB5qdtZS2NsW8WRN?=
 =?us-ascii?Q?AQw1ksAkuUvxJg99eLxGiQX9LkTFPfJCFrpDXEHxhBRMtYA6y7h0JAtFQbpC?=
 =?us-ascii?Q?u6/qeOjbhTKL63v0ewwbBtFe7zXtX9rFMHSwqvT064A79JjCCKuBD+e7jMIz?=
 =?us-ascii?Q?WIywK18Q7MTLdWul0seQCS7L4mn84OyI2f7Nq2uO2+oKalsXKyS4bczCZv9/?=
 =?us-ascii?Q?q0ANxHeVfepkUyfUPJUtuaEQ3lRDVlIkOKe2qtqpU0SPujyuKpoa5kuFZE3M?=
 =?us-ascii?Q?jBfebGTOXXvfdsvmQbyRH1ZPYd+XvHYwUuLvKJWZPAy5m+h2ul1dDyJUygkk?=
 =?us-ascii?Q?7CSApt+W98WoNrn40vcbci0zDwcW6kvEnXmd4oDY2GYLGisDF+IDSeVSkaB2?=
 =?us-ascii?Q?6QlKKrquR3cAifEku6mGcpHhktcK+iBRPEnevVA/c8vEYHTwhlqsR7m4NIur?=
 =?us-ascii?Q?6LO/vKgj/FJAM6VZZ0+Xdv3ePXgLijYDYogQQUPoJWJOPg096owf3tfC1byd?=
 =?us-ascii?Q?HirAnHEx90keZYgzWuMbY+TmcthIOJd6sASuAboQdAgdWV5PBtjH9kKg3rWl?=
 =?us-ascii?Q?l9aQOyJ4ez0vRH4ocEWeGjQmHtSXDIEuOJBu0WDYjV+pVHwNkjj0GwXKvahB?=
 =?us-ascii?Q?2whWTBQAO4SNhjIy9o0T+aczLt+kjCtfdpkQs8HIOJ+o8vAr3vC8qACAmrCX?=
 =?us-ascii?Q?aS4M4nYIb8pAoBIMovBwdPNYW54QmRSdyNVqzW0VkarowVR97uFgJT239bAg?=
 =?us-ascii?Q?gIUwxhY3PZLaRxYB2rPK0sze634v22sMOL8x6g7tlHBfdOBSzFftdwCThav0?=
 =?us-ascii?Q?j6DJryfuoP5rEb77LSDWSDivumKcOXeY8JpwrXNmhc/HVtEHQR4kI9bEoLu/?=
 =?us-ascii?Q?Sf6OqA1HsNZyQnxrC8vB6uV96ENfr+oP5qyIlEkIf6u/CKYQUjuvBm+bNo4Y?=
 =?us-ascii?Q?ZMi2lcj8SA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17605721-8aef-4c4a-e581-08da2796542d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 15:06:24.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPlDhYbe0MDOlvTxtEGBwwqIyhOO2JUoWAIBkKuRaIifS2k0+kWT+YgNxsLoQbFu6RM0rN4UD1DNrY3F2xjSUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB4804
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--10FwTIgmx2zT3VD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 26, 2022 at 03:53:09PM +0200, Ulf Hansson wrote:
> On Sun, 24 Apr 2022 at 11:04, Wan Jiabing <wanjiabing@vivo.com> wrote:
> >
> > Use if and else instead of if(A) and if (!A).
> >
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> > ---
> >  drivers/mmc/host/atmel-mci.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> > index 807177c953f3..98893ccad4bd 100644
> > --- a/drivers/mmc/host/atmel-mci.c
> > +++ b/drivers/mmc/host/atmel-mci.c
> > @@ -1125,8 +1125,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
> >         chan = host->dma.chan;
> >         if (chan)
> >                 host->data_chan = chan;
> > -
> > -       if (!chan)
> > +       else
> >                 return -ENODEV;
> 
> To make a slightly better improvement of the code, I suggest we add an
> early bail out point in the atmci_prepare_data_dma() function. Like
> below:
> 
> if (!host->dma.chan)
>      return -ENODEV;
> 
> [...]
> 
> Kind regards
> Uffe

OK

How about this new patch?

Thanks,
Wan Jiabing


--10FwTIgmx2zT3VD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-mmc-atmel-mci-Simplify-if-chan-and-if-chan.patch"

From ce6f779033c9a8aa2489f59c860bb2a49a67c278 Mon Sep 17 00:00:00 2001
From: Wan Jiabing <wanjiabing@vivo.com>
Date: Tue, 26 Apr 2022 23:01:18 +0800
Subject: [PATCH] mmc: atmel-mci: Simplify if(chan) and if(!chan)

Use if(!host->dma.chan) instead of if(chan) and if(!chan) to make
code better.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/mmc/host/atmel-mci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 807177c953f3..91d52ba7a39f 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1122,13 +1122,12 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 	}
 
 	/* If we don't have a channel, we can't do DMA */
-	chan = host->dma.chan;
-	if (chan)
-		host->data_chan = chan;
-
-	if (!chan)
+	if (!host->dma.chan)
 		return -ENODEV;
 
+	chan = host->dma.chan;
+	host->data_chan = chan;
+
 	if (data->flags & MMC_DATA_READ) {
 		host->dma_conf.direction = slave_dirn = DMA_DEV_TO_MEM;
 		maxburst = atmci_convert_chksize(host,
-- 
2.35.3


--10FwTIgmx2zT3VD7--
