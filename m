Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CD44F1E12
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380052AbiDDVr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379405AbiDDRHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:07:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4D340A22
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpXPmZ52+lRbRLjBgTHN+SA6l20m/1YBH9rxJHHrM9q4wqkkmkKCKH4kcetCChq8WTH/wyl3nB25eRBKf1k5nLPU5Y0TuGBd4uJztN+P6Z+Jw7Rzv1y19zHRPZq+ks5NNPJlFJjrNBlwqYowKp/cfY4VOcmmuTGU0coiAybZ46D0yccXIOFnmEcT+PrYlCwy+x3ku0GqwJ8BT47jpGoAvATWVndXLLdUKcrDxdkjuxrmptzh2FLPtHmwnt12wNsDlD3IYlpLvMXB94rZneYnMFF4gSsBMzNUwUvqEt55AIAphl98w6DWcv8mcMMFfejvC/AHbbXIkrBZJ4O7pZbhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McJHxPRl+hV1ObQKwUEe7tb6XK1sO6IKjw8qy89dJv4=;
 b=DqonjpXcWLj9nuYoPJAi5Y5sTvFdd0TyEs0kR2Eu++HiC7RJfQNjeQJA9+tZNaZECAotmm3KVnhtSL3s77iD1jSwy7/CTPwEFqDBmXEOJthskmeUfral0p4j2uLleinOjKkebiZCqbkoi3sXsYKOmovpbCTbIVQwTClcZmKK2wk3XDuFEEVtPUoqx3B9tzaEkPlIRDzNaf5KiNpM8Xt4Qem9n6n1wxQHEN6Ykt3i0k/m8hX1nwDHlEP/17LmW1+Q4hySwHz1wRxQ0Te0XeaIxUU7lQbxTCQlairNW1Cof/+Oxc71H+lYzV9/bgI+rIOWhmpNvj6PwVKDoMVrfzJcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McJHxPRl+hV1ObQKwUEe7tb6XK1sO6IKjw8qy89dJv4=;
 b=lnfv2stIG4QyWOWSDbgkWPOTkb70asgsW8PB3VwQ/ilY4o+ingtGFKIS//AsHQgkfVqlLutgxjejWVpggn+ERZe5bgXfHd6mvKzVAIHdhkC7m90V1UoqyV+prSNLmEHOHd2Czb98jkYzD2quA5ZadzI13UwzwOwizuMVgTPk8mo=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 17:05:01 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 17:05:01 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] Fix issues with untrusted devices and AMD IOMMU
Thread-Topic: [PATCH 0/2] Fix issues with untrusted devices and AMD IOMMU
Thread-Index: AQHYSEOt7+/LxPSUwkmrLofc9S+M1Kzf+M6AgAABfwA=
Date:   Mon, 4 Apr 2022 17:05:00 +0000
Message-ID: <BL1PR12MB51573B811E1F7321E25EF785E2E59@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220404164707.1128-1-mario.limonciello@amd.com>
 <YksizUJzRgEEdHLJ@infradead.org>
In-Reply-To: <YksizUJzRgEEdHLJ@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-04T17:04:59Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0f11fbff-551d-4fe5-8ce3-3b81779eb115;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-04T17:04:59Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d7d44dc8-83e0-4d5a-ad06-0640c7806498
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f3dd9fa-d9b3-4809-1637-08da165d4167
x-ms-traffictypediagnostic: DM6PR12MB2938:EE_
x-microsoft-antispam-prvs: <DM6PR12MB29383F5ABF81B960D78B5AB0E2E59@DM6PR12MB2938.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bX+QbpplrT4PeafEJMYIOwV9JSgr0GAcOEt2Ly5QWPSdj52JOpmkXjlpFuaBM0Z3YVuTfZ31dcQq6u1EG4uJeffxvwL3l7mC2pJryJgwRMucliIPE/C615AS8BcaT/YuL1y5iQkMZ/NhmJbI34IVvxg3kgZqepdRzKn1/ipjy98e9nvaK1qkUVcphf/1vPk8zPaCKnM+1xGgpXPkqMyfS2piQecCJCQNElyQUlU3b8byGjuKkcWFzJwAjYOvfYG9PslQIye5uq8EP9jvNwkWFpfZS9sK4fy4DsgkNStcAghLLWRSFAAkzgH98j25HZaq51clKC2TFtb++unx+BGzRmXjrX8oa89td+nYw0b9PPf2dz0b4FUz0mG1THpSOmQmc+IT6+n0OQeePIr2bAVuapPUDgHyra6fL4LM145ChDZZ1gPwTGQiLgYiNtNXb/sUj1FO21cNYiFNx70KP6a4SmzrsL+NP2C6bxeXvLPiOCOSogX0XDY1rOA6Xqvx1NfqCy9j31Svoz+MCWfsy/PQXfxvcdP9T0hFvipuUlN7hGV/Sl99mHFfgbsCwpLS8Yng9IswkdA4zSLAFilElVvVRM7Etv6x/TFR1nlC5xNN95IZAbSrBHrSgCK9pq7B7MwLykSZoavzfM9HSMVH2qn4IyX+vyzCAxM1ATqQleECxJli5lXAQ74OSeqQDtsgpqw5gMd/pHXY+1xFX7L+KeAkBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(122000001)(54906003)(6916009)(38100700002)(52536014)(55016003)(6506007)(5660300002)(9686003)(508600001)(7696005)(33656002)(83380400001)(38070700005)(8936002)(186003)(2906002)(8676002)(4326008)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CbEYVpHKpasxbVNALomnXcpaH3cfnmcuYEqjzK/w7zJhBA/bqM31P/2Bb5OM?=
 =?us-ascii?Q?VLhFialP372u+oxOZL8kvr0B5XLGjYHzA2d9ICaXKaYeY9EfS2AQeZgPcF8J?=
 =?us-ascii?Q?pzfb/3C6dwtePhGJeZhVt9qMl0fOid2DRcPdoyJp+XFxsnNHiNpbwUvqrOAm?=
 =?us-ascii?Q?Ed3kqgyrdRsRB2n73cPFXVczZNeC24jdNUDdFJ3yVYelbGwl2lE46dxPF9Nu?=
 =?us-ascii?Q?1ObBZLj/ijH/dveCYvl30Aaa0T5PQRG9OUD/YPKpX2FClGlBk+n1oBWhLRhE?=
 =?us-ascii?Q?j1j3d/wMDNvV/WsBs4qRJqnvRznZsdbnPOZ7qKcSFl+dkAglbFwQGJ8QHCBb?=
 =?us-ascii?Q?gzb+5eag6UsED7WOBpoK82XHop/6yQU8NNp+rIaoAf5tUomocJneoC1Hq0CW?=
 =?us-ascii?Q?RBizWKAtf+Jaxod85kKWeLQ9xceXZEF1n/B8qTVvIzOOIfnO+Ot2b/jb4GuT?=
 =?us-ascii?Q?rzHmCEHtdBUf+4OKN0cVazwz1rhWdP1rFJNos26Bi0FhtoZvpCcmQ1as0IQK?=
 =?us-ascii?Q?6x+fAkEEevxKTVwD0dCSbI9iUoQHlN6nnOK0BBWt4YLeFdfcH55fNrem60j5?=
 =?us-ascii?Q?HBXyrHg9hdIvm5/rBIS74kcPAszQNooAr0A2KU0vSZY2z/qWhDH6Ro4n2nMk?=
 =?us-ascii?Q?zl3GRQlgghaGPjYToOSepbE3NHZt4efFpoX3p1hsywwF0XyBTc/PYIFf14Gv?=
 =?us-ascii?Q?8B5dRSW8NZnBYEeeQnf4Ov8fq3Y8pYuqK+XBk3Y24Hz0DOCGJQE0yczdIgmO?=
 =?us-ascii?Q?W9+koI3LpUFa5hLVeF4OTA1Hxmxh9XEe+Z89c+gh1aykoZhhUlrPH+OYwWtp?=
 =?us-ascii?Q?AdsL/IHB+HMj6k+EfG327k9I15ezTIeCxmcPl1DgZ3GBR0fNMXrCxwWx31yI?=
 =?us-ascii?Q?wrzSVvWYmOeueoQE0BpqJjEnd74IMHj/25NW40GCiEDRySHLd+L/WwtMaPto?=
 =?us-ascii?Q?548ZDX04JrpWRQEy8iKu40gzGA3mUmVUuXox9fanFI/1b9BPBSaK0q6SOMpD?=
 =?us-ascii?Q?Ds22D25x+lLgzQs+XRA4GuTgQytrkZrlLVBW7PRIZLJg8kzWURzdZVFYuoa9?=
 =?us-ascii?Q?wtmXs69x0ASckqRr3pIjG6f25CoUPJBUpn7HiVxnQ0bwe050DjsCEqZS4Nst?=
 =?us-ascii?Q?oL01AM1Vwi4PG8/kmlWWACyCB4/sgNR4gEPTWxRLtNcQ/Lvmgd25G0WOH2IX?=
 =?us-ascii?Q?9AiItrppgJfFY/ZlH4HRKVz/fK/dAEsp+KKn/JelRBTW0nRdDEc+PA/ZpnCr?=
 =?us-ascii?Q?dxT4HI8UrUcmewK7iFTBoGdBtqCKRGcYm3Zq400jTsE9QA53MQe2hhGjzLap?=
 =?us-ascii?Q?UKDmRsmZTox+14YQ8eRN7fbsxIirxIlcVlc27KlrYgFtpSpIz1rSI8Ifv5/l?=
 =?us-ascii?Q?6erPwwrREyGja8Du2gEISrlW4nLccUD9iEoHPDIPuvduc8hJ80VqtmcLhPtp?=
 =?us-ascii?Q?+Jgm6OkLGBP7KJau+XzErimb+9euUpEXH3NfnDKhWndEbqrNXxTyTkCZsmc3?=
 =?us-ascii?Q?qsdEyZP7ixHoi2Pq1uSA2ea1M9IM/AJk16f2FNazby2f87W5X6R6pOj21qnZ?=
 =?us-ascii?Q?BdMrpt2k4EhmnKRU8KSqpo3EK0iaz8abX7NZR1Xe+dtUOQ+OLYNFo3mmQbNV?=
 =?us-ascii?Q?NQ1KaJNtv87/I2PW7rf3fnljBNB5qzYGbK8nr6HioayPWZ1EQ8PdtEbcRwcL?=
 =?us-ascii?Q?Au+ggHTcvb+2pyqhpPuKjE2qf7QX7xgLWL6MKEWJ8PLz0ih2PIWZdXmXcRxT?=
 =?us-ascii?Q?CC5VKtWvS86tim6hY8FFJHqtWKnnOq/iPFi983r3tCcbMg90lvzw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3dd9fa-d9b3-4809-1637-08da165d4167
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 17:05:00.9659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Rh8u/hM0j1lj7/cH356JrVINMWjPK+VKIMeoLnFWi54PeVs+OvxPksIBBWuh6oLAaVJBEqw535B3UfzQge9Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]

> On Mon, Apr 04, 2022 at 11:47:05AM -0500, Mario Limonciello wrote:
> > The bounce buffers were originally set up, but torn down during
> > the boot process.
> > * This happens because as part of IOMMU initialization
> >   `amd_iommu_init_dma_ops` gets called and resets the global swiotlb to=
 0.
> > * When late_init gets called `pci_swiotlb_late_init` `swiotlb_exit` is
> >   called and the buffers are torn down.
>=20
> I think the proper thing is to do this:
>=20
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a1ada7bff44e6..079694f894b85 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1838,17 +1838,10 @@ void amd_iommu_domain_update(struct
> protection_domain *domain)
>  	amd_iommu_domain_flush_complete(domain);
>  }
>=20
> -static void __init amd_iommu_init_dma_ops(void)
> -{
> -	swiotlb =3D (iommu_default_passthrough() || sme_me_mask) ? 1 : 0;
> -}
> -
>  int __init amd_iommu_init_api(void)
>  {
>  	int err;
>=20
> -	amd_iommu_init_dma_ops();
> -
>  	err =3D bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
>  	if (err)
>  		return err;

I do expect that solves it as well.  The reason I submitted the way I did i=
s
that there seemed to be a strong affinity for having swiotlb disabled when =
IOMMU
is enabled on AMD IOMMU.  The original code that disabled SWIOTLB in AMD IO=
MMU
dates all the way back to 2.6.33 (commit 75f1cdf1dda92cae037ec848ae63690d91=
913eac)
and it has ping ponged around since then to add more criteria that it would=
 be or wouldn't
be disabled, but was never actually dropped until your suggestion.

If the consensus is that it should be dropped, I'll validate it does help a=
nd then send that out
as a v2.  I do think that my messaging patch (1/2) may still be useful for =
debugging in the
future if for another reason SWIOTLB is disabled.
