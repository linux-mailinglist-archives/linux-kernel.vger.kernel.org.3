Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E89C4C56C3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 17:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiBZQH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 11:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiBZQH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 11:07:27 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396C61D6CAA;
        Sat, 26 Feb 2022 08:06:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4LAXO5uFc/gy9sAvH5MXFGKAN0WGiwCDCg8ruxQyceXz/QE4+daojEW4NDoz3rL8zbq0Ctdm0l03r3p1V7dgM7GxDS8BVzyvchTk5so4o9GGTEDl/i+GWKLUZdKGokg0dMZI6EXxpYcOia0ujFHKaPib5HzGC1RdDT9kIPjPEH2Hdmo/hoAz9w//0lGtYRnlcFCoSKDwJ7hV/AfilgA8jWmJprBp6XMowIdVFDdUa/ycQScCNFHu/xVkR/6jf9zl7Ku7LTy/muk7J6g8AZbpbVPLhgLVIrzMaufv9EEUp9zqc3vyehZ3m2bCB4LhmbFwD8EhZoe2h3GhW4vJSdKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsOstLKHrzBv68OlTjjypwtpFGQLGLrqKRv0cR8g8cY=;
 b=hPV3OprfLV/9Wl08x8WHyUTpTuWRA1Nc79QjtIqf8q1SYbuVm7tyNlg2969ZPnnQXUFpVjKcx7SQO9LUfFX/riZmF6VjJ03gvhryGzKWOCpwY3kC0b4a2KQRbFxLL68X7eoEbVqnEiWkjYX8BTGJggAyznzMRXnBut0S3PJBdfMNsPPIx0cjZF6D7LprrqKXRpXcEXEM8AYTDdDtxzsbXYHd/IrjchK2g/U4iaZ3sOFx12fYm666q/UkWFF0rirM/sTz3l3C2lJfbLUX6dFd54h0qtWeI6WC4J+cas33ozITdesSumtetS99+ONAKSU2IhvQ8q66k4wmYOTUXHYfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsOstLKHrzBv68OlTjjypwtpFGQLGLrqKRv0cR8g8cY=;
 b=FHmeyxLNvO0N6QFKisNuoBwW4nVaf9uSwht4bFW4NTPbsrCuucgCDmK2mBFriiaV0kynGZw9Tb7ea9efXRfSOwZRaaKxxdQQ0sgUyq2Y9TZgctMMVhg2kdfKjfPfbObH2XH+irE/XyB9fNEJg3jIyOvV7yF1bjPK1btqLi/Yk4wzh1U+9E+bJs3rRhn6AmmSMxYmoO2ef6yoIc9vGWAIHPfgwuuGjh0Ux4p15se3cuEFrwbej+6w1y9PsOcIM+lzuDd5WR7jbLy9Wag3OuQhJm5CfnK0FXGMusXhmEB3Hu9kj5C+12BfvSTHO/iQM63OB7H+d3Tk7V+Q2ruV83wlrw==
Received: from CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8)
 by DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Sat, 26 Feb
 2022 16:06:51 +0000
Received: from CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::2158:bc32:112a:2860]) by CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::2158:bc32:112a:2860%2]) with mapi id 15.20.5017.026; Sat, 26 Feb 2022
 16:06:51 +0000
From:   Henry Lin <henryl@nvidia.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume
Thread-Topic: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume
Thread-Index: AQHYKhd7AopZ8pn1EUiip/DzNcJli6yj/JuAgAH/8D8=
Date:   Sat, 26 Feb 2022 16:06:51 +0000
Message-ID: <CH0PR12MB50897BE5D8841C27DD769580AC3F9@CH0PR12MB5089.namprd12.prod.outlook.com>
References: <20220225055311.92447-1-henryl@nvidia.com>
 <20220225071506.22012-1-henryl@nvidia.com> <Yhied+G/K8MndRfk@kroah.com>
In-Reply-To: <Yhied+G/K8MndRfk@kroah.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: e899dda9-4043-98c0-6a10-05d4910b937d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7e78e18-5736-4032-1c4f-08d9f942003b
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_
x-microsoft-antispam-prvs: <DM6PR12MB5021EE247E8708812721863AAC3F9@DM6PR12MB5021.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JhhTi9SZl4IMY26itPWxcU2oDNAj5fZjdf2wha7QbAIsmsRoDZPSpsrnwo23DEVKW7NW9MXd6xk0Hddwkp9u4FV05yT6O1IKh3xVm2jL+DScBESEIBxUTyynN63fVYdCi9PUNXVRBhFwUaob8vyTlan8xBZDCdNIACUkrdWjb5EZuW9CLs3kQ6X9kTLTc39VBm0JeeMwIRpKc53aXWW6V2TUgRkmOyU/+NvdfKdxwrub3k3uiuFVjrBuGQ15Pfore8LTV3aEsviieGRgthlinBzPmVe7Y+AR+hJrtm+1c9XwPNuBnEn86y/xSyFM7+kKvHO76/gz/N96s43Kg9mlcRGEw9ZjADdRayLHFeklO/YY0mbI5PNXVcHq+tlpdt5foJT1/DrCmYq7KJHDHeG8BSMz6g4r9dCDHU6fKVWO9CdWSn/akXmUVNE0U6QK2bnQLb3cZO1Z8kk6Jvn1HBNuUPyiNz/yvaSC3rcvgHravCzueXziTKXtUtQrRqhYq5HT5OE6uQ9wzZ7IZ/iVnMyY7Yq2wAJgPaNyPI/uO7d5HCsI+oiow9GC2bAxec5t6TjAzBcKY25hmtpBkAhx0hMB3vt+xDfOlFeWng9ebW33XUMFWDD1B334Z1LaT94Q+giu1KrpNG9xEUxL5zSQk6XGvJC/ot5p7VBcq1UgLAqninAvwepymTnxm6Oev+9XLbnMoEYPpXG22vdzkZYarM+8Ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5089.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(8936002)(2906002)(52536014)(5660300002)(4744005)(54906003)(33656002)(6916009)(4326008)(38070700005)(66446008)(7696005)(38100700002)(86362001)(316002)(76116006)(66946007)(91956017)(8676002)(71200400001)(66556008)(64756008)(66476007)(55016003)(83380400001)(26005)(186003)(6506007)(9686003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CV68f34k6WW4hZv20sNbd/MjALXK2wR5CHP2gEhvXfAtI9/N2qKqyw56zN?=
 =?iso-8859-1?Q?+4Wj50bgCYBeB47NQ+Wd9/RtgJ6hceLz2/NXCjjUTKNU16MbwI2EPBmfuc?=
 =?iso-8859-1?Q?bGojPWgxE/5p5PHsttGneldX3+a3ClNiQDv/OEuN4R1JnZ/5alfgIdyrrt?=
 =?iso-8859-1?Q?lyZvujYbkOenoKsvZMPupfGg0Zfy588lvAgBTlTrO+uWwVcngCGx9TpUc3?=
 =?iso-8859-1?Q?70bSrCwLRzuoV6NrFg+6UvGAse8geL8Sp+gp4jsH6myqT7KJclnD0A1pIo?=
 =?iso-8859-1?Q?XuR6I0sCZe5uYKGOjWUyxNlgpjo4UYL6qcsxwMWMdhgmQu9ShYTU/cHTuS?=
 =?iso-8859-1?Q?eK08neM7a5yvj1q3PKtHiSioBv2hYi7MHVnx2RbaF53nVANiCVUUDXvARb?=
 =?iso-8859-1?Q?48f+FwdZpyw8iPNma5hmmpH1Bh5yvanfxUcTTIx8nh1iqA8bBWKZXy6o00?=
 =?iso-8859-1?Q?Ia/zZdBbDodpvlOZta2nKKrK3d6BUCU7pvxRgkASGlcndKLvEC+zcZMqeW?=
 =?iso-8859-1?Q?UxnoGOsbqDP57OpO9G2Q6pTYJPCiSYGtbEzPslkK4zCvuvYJKjOnWud5/p?=
 =?iso-8859-1?Q?TjqnmdEBfUaYa6qXJNAAl4ggHkskYfctCoYAT8h97J3Ete/mpH6ps1Xnpp?=
 =?iso-8859-1?Q?UJw18kDtlGMemV533ah5WOTk/1EwDcvMEmoDCYkPKAgy69h1+2m0FLorSK?=
 =?iso-8859-1?Q?Z+1YtL8UkscOAK6Qf3rtTYdzF8aiqh+0AC62o+uTq5dHWDmr0WIv9XA5b7?=
 =?iso-8859-1?Q?MoeGAN2Owyha+rXwXgbtJgxbXH0oLQ+PcmnP61AEkbnqkLX5NwojUlvnze?=
 =?iso-8859-1?Q?wGHwulQEcM/2Xskv1YMOOdXdFKOSIPzrveSzSCqBMEfzdnkCq5RmgIJe9P?=
 =?iso-8859-1?Q?iQ8qLdFFsGWyFycE+dvzS32K9THgkyMzYPc9erzt7RD0SULo8BWNIcDQnF?=
 =?iso-8859-1?Q?exHYZQ0X9gUWBcZ9uvoDI84SGpQcCj1yOzUgnUqDYvD1TNwt0TDNR39GWr?=
 =?iso-8859-1?Q?UdBG0tF5ljsNb/xN+/rg4B6xk2Uog0GGsqFn604pnBSqduLGmuHZq5YBAi?=
 =?iso-8859-1?Q?3HnmqGGgE6Y/0rpdkiWoEXAhuR2t5KmFAr6XoGnbnpqMsWhSWuqJpZn+fW?=
 =?iso-8859-1?Q?Wji8a1lpHnH4V0BhKrTWrLHDTiUkRregrzEh+SRMt+YA3aAUlE9RgwDjqQ?=
 =?iso-8859-1?Q?2qcUmPYTb0oB7w5CXm2fAqzvqLLPRPLAiNkosZrS9BS+XK1NHEkkp43VSp?=
 =?iso-8859-1?Q?qVExrbp8Q8YRDq9x4wPob+yFizdauHkjO889z28C6KUekhjdu5RAnabGLG?=
 =?iso-8859-1?Q?2bRVITNuwY4v+bkDGZ5r8J8viCQYQOEYpU/n0HJEPullXkZBYHHCgwUBIp?=
 =?iso-8859-1?Q?m2RP79aCj3XbG/Mc2r7WcXU0U8GX8Y6MMbe2KMBRj0Kc5VnN3wCooZLQtM?=
 =?iso-8859-1?Q?YNkzkyeVO5tD1smULC8eb/fYTdoHUgTU8NqNJjyOBARxXdC5fpHAg90nUb?=
 =?iso-8859-1?Q?GLB4RrnsdHmWRY9KNxG8VVR6oNfiHFx4qttjvVePLsa22UNhrQhRAl39hk?=
 =?iso-8859-1?Q?0au8oV4kWVpBknRkjjqjaI7fCQteprMqpaDcBZCtj1nN3ww4MWUj/tmTcd?=
 =?iso-8859-1?Q?GE6QptXbJkBjg2Io/ITgjHNQyUB32jtI9R48oa2dvf4kZYBca1cArH8A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5089.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e78e18-5736-4032-1c4f-08d9f942003b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2022 16:06:51.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODyuc55UI3YLjUyKzfMkIBQpnwcxAhL/H4mTzoSQrlA8dgkWiyU+budPh0Tp6iQmt2rdy2bP3qfLQqbqojBMwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5021
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB2 resume starts with usb_hcd_start_port_resume() in port status=0A=
change handling for RESUME link state. usb_hcd_end_port_resume() call is=0A=
needed to keep runtime PM balance.=0A=
=0A=
Fixes: a231ec41e6f6 ("xhci: refactor U0 link state handling in get_port_sta=
tus")=0A=
Signed-off-by: Henry Lin <henryl@nvidia.com>=0A=
---=0A=
V1 -> V2: Added Fixes tag in changelog=0A=
=0A=
 drivers/usb/host/xhci-hub.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c=0A=
index df3522dab31b..4a8b07b8ee01 100644=0A=
--- a/drivers/usb/host/xhci-hub.c=0A=
+++ b/drivers/usb/host/xhci-hub.c=0A=
@@ -1090,6 +1090,8 @@ static void xhci_get_usb2_port_status(struct xhci_por=
t *port, u32 *status,=0A=
                 if (link_state =3D=3D XDEV_U0) {=0A=
                         bus_state->resume_done[portnum] =3D 0;=0A=
                         clear_bit(portnum, &bus_state->resuming_ports);=0A=
+                       usb_hcd_end_port_resume(&port->rhub->hcd->self,=0A=
+                                               portnum);=0A=
                         if (bus_state->suspended_ports & (1 << portnum)) {=
=0A=
                                 bus_state->suspended_ports &=3D ~(1 << por=
tnum);=0A=
                                 bus_state->port_c_suspend |=3D 1 << portnu=
m;=0A=
--=0A=
2.17.1=
