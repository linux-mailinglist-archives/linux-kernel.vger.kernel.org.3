Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95C3508D72
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380652AbiDTQhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380647AbiDTQhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:37:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5715445506;
        Wed, 20 Apr 2022 09:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahEmDqX4mD9mN6TmikrwT6ZVbpbBbnb7vR4uzI2QEikosZxIhtad+7ha1fsLRNs3WRwM620Qq4SQebdkBB/5f9aEFYrmJawIgzfLre1qraZ4b3KaSNV0K8rZVuog4Y18d1GNGhhjogm/xFFq1+iWtsrV1f+F1H37EjuwBtXuGQDMXRJW2EyJVsG4TNVoNPNP31oH5vLAO1DRLKLvpJFy3hvx5R3zqXe6o6G6m165ZAPBy3qPxY8djq8VQMO/tcQwp5cvXQoFXpRkDrWJt8huEmGYL3qOYpBSA+mcLfE9V4v70GMQIFp2mJMCXDDF4IICMX2TnHFVPGdsSSccizPNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlR66Yp1oRcjf+ji4xi5CG5/c0cDg0AfuaE7T3nVU4E=;
 b=CMMYPPMCrwcBJwi0bBAUWZw0yqpCAVLeDu6vKlZY42t/8cZXsGOuTZTEtWBOj81qB51rD3qiNRHHyrKW8DzzR64wTR/uoqLQz+0m5J7Id/0g1F4voM2ADBWwfA4xRGcOuI6V3n3edm5867my9IBkc76rc1jDmYA6e2spP9sK+E7emc5ZaOYmL4ZVfYqMGAY4FqlwyDgCFoF09VljhfRyh0TC9lDEcV/h1qkGtDWfJHck+uS+cmmS2CtAQGUxPeWGRPjRu+iTxuUBkqGCsThYNTUkQCdELIjfBOlcWFZXAIWil4j3/Q0+qKxBWalGZMHyyziV4poHtpAUHmy9Vexqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlR66Yp1oRcjf+ji4xi5CG5/c0cDg0AfuaE7T3nVU4E=;
 b=v00LDXGYKmSoqMPF1h59Q2Fs3iYJKhP26uaO6W2bye6+NIhkF67jIxy7tIji3lDWKSSwFdrKSCOuhs99y2vNUiBSS3QgqMLeks1/M3wRgZKyeobrxePNH+5iScmMNVHJO9KjyG9ZaL1RhpocTh0xzGLZfnxTEUdvQ+O8kMojUWg=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM5PR12MB1225.namprd12.prod.outlook.com (2603:10b6:3:7a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 16:34:30 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::3157:3164:59df:b603]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::3157:3164:59df:b603%8]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 16:34:30 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "David E. Box" <david.e.box@linux.intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] platform/x86/intel/sdsi: Poll on ready bit for writes
Thread-Topic: [PATCH 2/3] platform/x86/intel/sdsi: Poll on ready bit for
 writes
Thread-Index: AQHYVNOgtzw4T/fCYEOX/WTS19QP1Kz4/udg
Date:   Wed, 20 Apr 2022 16:34:30 +0000
Message-ID: <BL1PR12MB5157EBB51DA629A40BE514EDE2F59@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220420155622.1763633-1-david.e.box@linux.intel.com>
 <20220420155622.1763633-3-david.e.box@linux.intel.com>
In-Reply-To: <20220420155622.1763633-3-david.e.box@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-20T16:34:28Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=186afc40-4e5d-443d-833d-7f0eb297ca6b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-20T16:34:28Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 7b8c15c0-3267-40f3-bfea-7638c98237a9
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f757bfe6-740d-4a61-58d8-08da22eba4c3
x-ms-traffictypediagnostic: DM5PR12MB1225:EE_
x-microsoft-antispam-prvs: <DM5PR12MB122588DC3D4EE1047A4DB441E2F59@DM5PR12MB1225.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xly/49xNlfn3maC0bqHx/HCGXqkBTfuUtCYWxdEAqGQKanakGmkumy27EhtekRRUqzNUj3GjzC7WB+XxVGiAUgRsb59PShDek29CqwTTEppjv2a6k6qFHL8PO/uzgDjdqOwGkTQT89eUV0btJgFWBanI0ejl6eGJKmw5z6A1b6N2C/aO+nWm/8IyrNMAoyj48Wo0KJENCD6mz0LTFzVZo6bQNLlKkrjOlx8N3+u/XpPKy8JlaC0Rs+jy4rHOLaifKa/aCEpsw7NaWLBVfYypyb7VEEBGF/ZICTDeF3B+MKZrbJyyaMlfBmWZH+aXOERB+a0I5X8TGSEDXeYvwaforRcoWtgz2ET1o9AQcYuPOEM4LmEuq/j1XKHOhBw0jiefUHq2aYJ1xLUyyaL9Ggk0Bvg39UX1PunZLjyCRS0XwAiyXjE+XgHq2bzsrT5axUZYjSHuWYl94/AUNF0W+zmkcUZbctOjrpTRXZBasICfEfkEHe/Bm/J07SBEBLn+NnZk0vkB15a19xVz/xcpiz7CD7xSTauxzA2ceP0x/IZl1nmveXeK7/bg8vx0AE775/0XOTKCGuSvdc8VpT9fm2zcF7FWcbnaSsbULQ2Dff98daDan+Ca9ka8f3cC3GI6WNcp0lZq5t43p1SYonD5SV4xmvqAauQZe9Kt76uwM10+BcLh8K0CDrh04zjdV7NE49u6S4Q/7cifuKT6G+iwYFAlpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(53546011)(6506007)(52536014)(5660300002)(38070700005)(2906002)(38100700002)(508600001)(26005)(122000001)(33656002)(8936002)(7696005)(55016003)(71200400001)(186003)(66556008)(66446008)(64756008)(66946007)(66476007)(8676002)(9686003)(83380400001)(86362001)(316002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KMj2twwrNYuHH1FYG8jzqADnKYIJM2Pr6jkZmIwoD4j6KG4NaKM6wrS8X0Io?=
 =?us-ascii?Q?OZZ8Cbf1UcLDfjP75Cw3BxFgyQz7d3JQ74huWeYmmHGkZqpHxGZcTSM0KO3X?=
 =?us-ascii?Q?uCa15cgWr8A61ozUX+oBec2jZEgRNiBed73eeBzmY86q3ZzyrwmewPIzF+ON?=
 =?us-ascii?Q?65ZmgO9CgF+GfdiO9r5C0I1Fq9VqhhZwQfZLgp1oCvEB+go2uhqUq5WMRq8N?=
 =?us-ascii?Q?VO0Ma6Z/qSoifa+HpkhcKNQoXA9hsiTvz2wzdBAxINfjapyN2KCcnsonEzRt?=
 =?us-ascii?Q?N1J7HwmCxyF5cKzNpEectVE0ErDFjFcj51AX9vYM0HVgnQ3DIFGX/KqF/7M/?=
 =?us-ascii?Q?1VfiPtQ4rlXBWuhHjsWKOIT+SBmMYhEMQ6Hr4GjLCfH1xGTZU1Vl1aWoAQyv?=
 =?us-ascii?Q?RO3zDP2kYAVdr8svh3cBkHpPNNG6003xv1nnS0gXcrsHZB0r+E6V12BlKMQh?=
 =?us-ascii?Q?ylvynst0YdPz/NZwJHH4c/wG8rF2dRcBzGPSAfpMLqY/KlDGK+Lc391WVT2S?=
 =?us-ascii?Q?QuSIoeEU3kOyyYbJA804K+7I2+Jip+bcAV+IJr+pR2MI8tWhBsKjp0P2Yn2J?=
 =?us-ascii?Q?4LFJf6LGPMwqwIBU3qmRmi3qpCuD1oAbtQZ56scR25vvs9FDFZkS90xJS015?=
 =?us-ascii?Q?XxYVY5J8DvdCqQzGIcmiY/MsWY+Br3z1gVvkBE19ExnVQuVP8rkr68hkIYZi?=
 =?us-ascii?Q?bPXL4ZwTOzq0Lbm+BZqNZXBn8mA61gL0Xe/9MPj0/2KjOpYbL48josVz05K3?=
 =?us-ascii?Q?QrZtmeQnJaLpQR5uJWS4oi792OseZl70rUCx6pY2sQEWPZsFbQprsXy5d4xs?=
 =?us-ascii?Q?nCwQFuS3NvA73g4kq0CKsWp/RC7haWcVD8OaoUSYGcO1NaT3P9d/MTd2VJoX?=
 =?us-ascii?Q?a9PECywHvT5Fx2mBw0/X4i384S94y8zwKenKSwQNassOrBkjiSi96XzgJdQ8?=
 =?us-ascii?Q?fIzeuRwIT8VU//N74bPDfqUHHlLFUPonm1xrY56cFrFh+FU3GagBzmEldDqR?=
 =?us-ascii?Q?IgSrP8ANxY5A4smU8TEorUOMEsRs8X1iWGy8KIpuo7+o39lCJ19RBzZH+LpR?=
 =?us-ascii?Q?vjdPoeCKivPhSnEOshlW5oiKU/KhNgv04A15EYXaTSvJHsXVxdMO7BElS8Ol?=
 =?us-ascii?Q?pL0AI0hLcudiHo9gP0rjDBQfvX6AwC6p50Zs+Pu4rcesVuIK+PMFIF0+om0u?=
 =?us-ascii?Q?Ej7NmP7Nlir3NT8ws9554z/g/lBAZPTL6tkkPDzFChho5fpNHPxYl7wSG+Rs?=
 =?us-ascii?Q?ceCyvIulRBw16aUR1zyWmp18dqlHhwH48Cc2t64aIbMX7SHIbpWalkkbitnn?=
 =?us-ascii?Q?hJJCwzUvf+NWWjuEKnIVgZHUitH3MnT8J6SNXdVyrtq3PFHCZEparuFp3U1a?=
 =?us-ascii?Q?1qtv+jw8WBgxNz66ZXsNw+mLhFNm+wH9GagIpoaaG4yB69R/lUknQ8o7TLHn?=
 =?us-ascii?Q?WXEKHItZ32MH393coxjvxOujse8aRB7j5NYmP0DoQsLs8sNn/BF1niQ/dO0e?=
 =?us-ascii?Q?wLeUKwzvUWgk5T1vQMH+J9paBLR4u0n3LUAjIh13IgYWMowBFIV6QZaZ5TP1?=
 =?us-ascii?Q?cGuZaXohaVACjqz9+7CZPeZdq7u2E1FQEnsuDHp/zIb0YbCTyNcRWnYzmv+3?=
 =?us-ascii?Q?4tK03hd3i4FinsHMmMEeiJ7C6oHavDpAxJmzKQZsXS4zPUpW0RpsQ28VUHR9?=
 =?us-ascii?Q?V7usizO5vVrsYWuIXNF7jXAbEVaJ1SymjMAbiBrTCsCzt5IN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f757bfe6-740d-4a61-58d8-08da22eba4c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 16:34:30.2958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63RnNJStCWfBJykr8iBUkhI1LsN6X1yAS8PUJViUwaR5iPS55AM/ezVDJkgxTwkKgvBHGNbDLLjvGSvR5ozlxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1225
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: David E. Box <david.e.box@linux.intel.com>
> Sent: Wednesday, April 20, 2022 10:56
> To: hdegoede@redhat.com; david.e.box@linux.intel.com;
> markgross@kernel.org; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 2/3] platform/x86/intel/sdsi: Poll on ready bit for write=
s
>=20
> Due to change in firmware flow, update mailbox writes to poll on ready bi=
t
> instead of run_busy bit. This change makes the polling method consistent
> for both writes and reads, which also uses the ready bit.

Does this need some sort of guard on the behavior based on the firmware
version you are running on or are these all pre-production still?

>=20
> Fixes: 2546c6000430 ("platform/x86: Add Intel Software Defined Silicon dr=
iver")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/sdsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/int=
el/sdsi.c
> index 11f211402479..89729fed030c 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -245,8 +245,8 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv=
,
> struct sdsi_mbox_info *in
>  		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
>  	writeq(control, priv->control_addr);
>=20
> -	/* Poll on run_busy bit */
> -	ret =3D readq_poll_timeout(priv->control_addr, control, !(control &
> CTRL_RUN_BUSY),
> +	/* Poll on ready bit */
> +	ret =3D readq_poll_timeout(priv->control_addr, control, control &
> CTRL_READY,
>  				 MBOX_POLLING_PERIOD_US,
> MBOX_TIMEOUT_US);
>=20
>  	if (ret)
> --
> 2.25.1
