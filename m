Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBA04C20C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiBXAoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiBXAoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:44:06 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1ACE1B5F;
        Wed, 23 Feb 2022 16:43:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODeHETobtQg7USv0I851VsJpniItZJ2DyVyL/pHe+9NL4gobSQQEWauk1kDGIhp1WwASLVP2Auc+dAY55NNDvIMSFN4JMBhcqdQYKH6aclxqrSwi4GhroEYPU967xT5UIe3QNyweoeMEuTO0jx7KeiMGbW3Rq5eRjkj/gslAAT3YTD7U+rt+Pz1TwJOHu1JNh1prKGRrNiCu72+WBAeTukE+zaqhEwLBO+6Dws+nXvcsXMABmX6+1f+jbHn13kBC+2pQYy8/KpkG38tIZ6+Hk6Tw6uLwDkjb+FOe1WxkdWLqcYRHG8XvH2U3UudzWeaaOsZv+K5PtA4GMa0DnQxZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/PPLYlnZQQGON/2ypUF99wxlnyDee1XUjlYU71Azbc=;
 b=nPxOIUyJ78vxmirCr31ZVapfmN0JYDHR6Ts4Kzd1o3A2CqpGTv8sij7hLUGCH59N8fIQA43nDbJoDGvIXN000DH2dra6XYKDqyWBQCdwmRkHQRhQwwJQpOovsIrGggr32GJI64KaG384euz39IzE4fpG5uUubRmotN4g86JJfg8XfukLghDEUCDRYWQ1LuGnioExTiXSov4/oFHSLhBaE32N+sXIoURWury74qQow0mJaj6Sv921Ze15kb6WjOB8FE2VuP7ojkRJM8OuhCTI7bj2Lywy2hxSZYJl7oqI3w8KhvL4SO9xhR2r7gvbEld14zPw88xiqZTZYA2tAqgK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/PPLYlnZQQGON/2ypUF99wxlnyDee1XUjlYU71Azbc=;
 b=zqmjY79nM6s7AXz9CVCixbbSTHFGXn+sWv7MaKvAS73Bqj5atNJm9u6a9F7WtasvX0rVvT8oiHdXpfx/oyflKtBwF1nmgQRbP/TK7iSlc/Q2uN6G9oJMWuUNwK6VR1xqIoRc+c+XwTfg0dJd0x9sHwZf46H4QKxbo4q7LjxhUAE=
Received: from DM6PR05MB3962.namprd05.prod.outlook.com (2603:10b6:5:8a::15) by
 CO6PR05MB7506.namprd05.prod.outlook.com (2603:10b6:5:350::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.9; Thu, 24 Feb 2022 00:43:27 +0000
Received: from DM6PR05MB3962.namprd05.prod.outlook.com
 ([fe80::e816:84c7:6472:a142]) by DM6PR05MB3962.namprd05.prod.outlook.com
 ([fe80::e816:84c7:6472:a142%4]) with mapi id 15.20.5017.021; Thu, 24 Feb 2022
 00:43:26 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Jorgen Hansen <jhansen@vmware.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "acking@vmware.com" <acking@vmware.com>,
        "dtor@vmware.com" <dtor@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 3/3] VMCI: Fix some error handling paths in
 vmci_guest_probe_device()
Thread-Topic: [PATCH 3/3] VMCI: Fix some error handling paths in
 vmci_guest_probe_device()
Thread-Index: AQHYHs1qh1rsU2MYvUCsLtTWA1uvXqyh8XYA
Date:   Thu, 24 Feb 2022 00:43:26 +0000
Message-ID: <864E509D-C980-4726-A3EF-18BCAD6CBB6F@vmware.com>
References: <cover.1644531317.git.christophe.jaillet@wanadoo.fr>
 <c5c1a5f3547bea3c4a1cfb8474db683d83c0ca1d.1644531317.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <c5c1a5f3547bea3c4a1cfb8474db683d83c0ca1d.1644531317.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53b430ef-2e23-477f-850d-08d9f72eab98
x-ms-traffictypediagnostic: CO6PR05MB7506:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <CO6PR05MB7506C230FDF38A4DC22B043BCE3D9@CO6PR05MB7506.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 82enNMAxpv266wRSTpJfOynSIG5sYB2vHeKYZqhZq+0NZEoYUcdRMYWyNTeMHcy57Y7Aak0jxNm5MRc4UzehcMruJgwQ4R2XZLof4/ld19Ivrxfuu8vbNlQX7LumfA/hqHliLCqugVTR3wTU1WS0K8XfowHylRS97wlMCjlD1VrrG0esrGbeenmjkmkVPhhFoR2jH5ZJgEl0kaV/iGnpNgpoAVCQVGAjPECsDSLhi6FKEDt+eaetZ7fuI0W8syazbpazImILG4Qm/NYNa5U7DfKsOba1n+4XrvAnGn0/E8S67IMlOpWNM1BT2++WyL1n7zBOvs4fgaZIDpBRYlOd5lEw76oHyGEeOXKzZtIvgD8KJ2PFfnC3a1JcDQd2eJfS0P55HqZoCIBQj0dZhzj+5RG7qrIXmlJ8xA6n5Y1tJsJFeSZLL0lZjW28WhM4Qr+x2DnDbtbGYqoZR2/mxU91JQZEixEVIj1is+JiWTTDVq1gVY6FFqu7Ailxo8tn2zv6Jws/+qnVbo87+26VSkMMv8MtjVFdJxFxVPM4Hc5kZ04ZEDgvzFt/MGraDsi0Vo3Yqe/U3Aiav8drPnqIe9d8XraRVezn4WnSrQvXf8CwaNXQ7O4hkbpnDntJyOjWbV4vyd/dssz+q2Mdi3CsxU8mnW++PGNDPkTRPnKFXz69CD4qeLlWLsxFiyszvR4RkMIHTvubMGQPYWGESxbYCvPrlxRe61R7NSaDi9C4aVPWiOYyhM1qPHOe9aTnXY7PSvhk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB3962.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6506007)(186003)(6512007)(6486002)(86362001)(6916009)(508600001)(316002)(54906003)(2616005)(71200400001)(38100700002)(66556008)(33656002)(83380400001)(122000001)(4326008)(38070700005)(66946007)(8676002)(36756003)(76116006)(91956017)(64756008)(5660300002)(66476007)(66446008)(8936002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wcy77WjUYfKr4Z7VLNYyQ7VmJxV9FlQxVDMOGkwuSl/vpgfwnUpovjZDHiPa?=
 =?us-ascii?Q?rx5moEj2hzBAvZJFW0zgJOkjo58TBB5eACvxvttvO0XFk9/5NwvkdHx83C4S?=
 =?us-ascii?Q?YvE/8JjfvDXE+flFVXg/5XglyhDC5fTvTKpRQZn9wlvhRfbb9pgToNZaFa1Y?=
 =?us-ascii?Q?ESEKDnC2hLRZLp5Ei69O8HB61dJJVfJO58tcesZanKSJipa9zGpjBUZTJlsB?=
 =?us-ascii?Q?G/FaqAcmKIYhjbyxW5X4wfcYgkRw0aNS1VsLcGAnEEgh3SgVOfUIjFJr8qwY?=
 =?us-ascii?Q?0SWtKCsYptvVQBtCFHUstP9pB2hmNktyxnalFsIz96SMfaotSNFUPdxPS/3H?=
 =?us-ascii?Q?HVUUda4vbGhMtKzio17gLtM/31ewUXxAt1S5CnhWvXpt710xBBYlIP6BfKSo?=
 =?us-ascii?Q?YgN6+aOaqwfU2TM7H8V3kS0L/kN2BMkbRP3rZ5n0RzECKaiPY51O14dfe5UX?=
 =?us-ascii?Q?v67L+9I0crtFMjYxu5HGcqwTFOSa6MGMqLGeuOITALIwTkVhfeqRd6uHVzcv?=
 =?us-ascii?Q?a5BiGmtmjqM6lYx/ZfgshtqvpdV7Ab44NMMShgOIzsjTYPNJCnwqxMGz0rTd?=
 =?us-ascii?Q?7Ey4lMTHHryRBR8R0XIkvDEu6zQdfl3+Sd37CE0AwA2VBiEvrLJEyHk5RIxQ?=
 =?us-ascii?Q?QWJfD+GYWlCtoYOmX03C/5/HSSm5MlquAdrcu0YAGaUDnhJr5sHT2Fg+JwAN?=
 =?us-ascii?Q?pYesBWKL53dBY/72xvJzrqfY2R7cLAgo/oxkT+KoP8VkAO/aYzn9YM6uotau?=
 =?us-ascii?Q?LTn3cjoga5IAIZ2ul85arQJWRyB7tZnvHgYYOeuZRXCq9FTkv6yDdbm6eJx8?=
 =?us-ascii?Q?XpmKn7C9cx4m/VilfCC1m11IiKNPubQEP0X3h6G7AUW21NvUKbxAXWKqrSeH?=
 =?us-ascii?Q?RE9pGWk/jTm7PIaADE0eM0QceG5C5M2P1mTUPjsZaRWqw3JYQb9Y+DR9Lxr8?=
 =?us-ascii?Q?MO6mqOcn5zwQl0JYqBHX33AsM+NAD5Y0lGKld4jFrQ52T38SPCUnenWVxwOI?=
 =?us-ascii?Q?lrATZC5zuAFp0yL/YmYWH0b/fkrDyrPztjXVDgcHmQnEa41GlWvfRxqfF01Q?=
 =?us-ascii?Q?qBANwPeq5MmXOiKHRiNBvURB9mhsWDd2gl+IZ++nC73SO29BAo5oPWKnIeM4?=
 =?us-ascii?Q?RTuVqPV/A6w/ExipN4uPlPyRRPJYPHfE8kVw7s5JDLcnvC4j8estSdTnCcZs?=
 =?us-ascii?Q?Ib5ReSlxMSfIzq0Z2CM1xdi5lRXHZnyHknIDpnRCwuulnV1tWXDUWYBvin53?=
 =?us-ascii?Q?ZQWW/v7fnXVJyXZAMHnRV5PYBB4tfX9FIlK/pmYuBfkOCT8L0uX90ZD1y1Ha?=
 =?us-ascii?Q?n9HiGCkeQ4YiE6xHzOvz1yQkSGFNGdztcYacKVjIuPvB29idRSMpQmkRq2Sf?=
 =?us-ascii?Q?m/cGMqrMcSWiYL2Pm5+98kQPcYpCkryXt89R2T8NIjSNjNYfIWu1jkM8Vfxo?=
 =?us-ascii?Q?d+Ef9EqbCcGZAx26CJcod4JVe3rRDkTgCIsnOdGIW5dMw1ZF/bEgR6QxEOyQ?=
 =?us-ascii?Q?ekA+KmTOe6Qf/hH3b3pFXcup5kaJ0mCuBgnkHh1pDv2hlgirDXv8nK/bCWnD?=
 =?us-ascii?Q?f8Hqz7EJqe8pATfHtrQ0oKRWrChE4usFfvqvib41APNcbBvqRuP9ubvj0P1P?=
 =?us-ascii?Q?3tDdxUVCLCsmR7+a7pzWENhUHOnlssxliuMAyH+ZYi+iJMpZPpNedxGF1R1U?=
 =?us-ascii?Q?cZrInYnHud3w95Rx6TpF1i2BSJk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <892F96C4AE17DD45B7234AD3651A6D2E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB3962.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b430ef-2e23-477f-850d-08d9f72eab98
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 00:43:26.7685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uz7UbO4JiHmLQhh9Fz1P3TkyWxcHH409bfA4xW59CaHB2HAv2bxpaK8BpJfUDfF18maPPiez8+x2a3iKo8vSwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7506
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 10, 2022, at 2:27 PM, Christophe JAILLET <christophe.jaillet@wanad=
oo.fr> wrote:
>=20
> The 'err_remove_vmci_dev_g' error label is not at the right place.
> This could lead to un-released resource.
>=20
> There is also a missing label. If pci_alloc_irq_vectors() fails, the
> previous vmci_event_subscribe() call must be undone.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks for the patch!
Let's deal with the points which Dan brought up separately.

Acked-by: Vishnu Dasa <vdasa@vmware.com>

> ---
> Review with GREAT care.
>=20
> This patch is a recent rebase of an old patch that has never been
> submitted.
> This function is huge and modifying its error handling path is error
> prone (at least for me).
>=20
> The patch is compile-tested only.
> ---
> drivers/misc/vmw_vmci/vmci_guest.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/v=
mci_guest.c
> index 02d4722d8474..2e8ad36895ae 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -765,7 +765,7 @@ static int vmci_guest_probe_device(struct pci_dev *pd=
ev,
> 	/* Check host capabilities. */
> 	error =3D vmci_check_host_caps(pdev);
> 	if (error)
> -		goto err_remove_bitmap;
> +		goto err_remove_vmci_dev_g;
>=20
> 	/* Enable device. */
>=20
> @@ -795,7 +795,7 @@ static int vmci_guest_probe_device(struct pci_dev *pd=
ev,
> 		error =3D pci_alloc_irq_vectors(pdev, 1, 1,
> 				PCI_IRQ_MSIX | PCI_IRQ_MSI | PCI_IRQ_LEGACY);
> 		if (error < 0)
> -			goto err_remove_bitmap;
> +			goto err_unsubscrive_event;
> 	} else {
> 		vmci_dev->exclusive_vectors =3D true;
> 	}
> @@ -871,13 +871,19 @@ static int vmci_guest_probe_device(struct pci_dev *=
pdev,
> err_disable_msi:
> 	pci_free_irq_vectors(pdev);
>=20
> +err_unsubscrive_event:

Please rename this to err_unsubscribe_event

> 	vmci_err =3D vmci_event_unsubscribe(ctx_update_sub_id);
> 	if (vmci_err < VMCI_SUCCESS)
> 		dev_warn(&pdev->dev,
> 			 "Failed to unsubscribe from event (type=3D%d) with subscriber (ID=3D0=
x%x): %d\n",
> 			 VMCI_EVENT_CTX_ID_UPDATE, ctx_update_sub_id, vmci_err);
>=20
> -err_remove_bitmap:
> +err_remove_vmci_dev_g:
> +	spin_lock_irq(&vmci_dev_spinlock);
> +	vmci_pdev =3D NULL;
> +	vmci_dev_g =3D NULL;
> +	spin_unlock_irq(&vmci_dev_spinlock);
> +
> 	if (vmci_dev->notification_bitmap) {
> 		vmci_write_reg(vmci_dev, VMCI_CONTROL_RESET, VMCI_CONTROL_ADDR);
> 		dma_free_coherent(&pdev->dev, PAGE_SIZE,
> @@ -885,12 +891,6 @@ static int vmci_guest_probe_device(struct pci_dev *p=
dev,
> 				  vmci_dev->notification_base);
> 	}
>=20
> -err_remove_vmci_dev_g:
> -	spin_lock_irq(&vmci_dev_spinlock);
> -	vmci_pdev =3D NULL;
> -	vmci_dev_g =3D NULL;
> -	spin_unlock_irq(&vmci_dev_spinlock);
> -
> err_free_data_buffers:
> 	vmci_free_dg_buffers(vmci_dev);
>=20
> --=20
> 2.32.0
>=20

