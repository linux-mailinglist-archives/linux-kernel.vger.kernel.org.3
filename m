Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D73505F97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiDRWFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiDRWFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:05:09 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2058.outbound.protection.outlook.com [40.107.100.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11662127F;
        Mon, 18 Apr 2022 15:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYrCFOPFyxHqQCZhjk54G0sx+bCqsgGEFX+Ni2nfbEQVBTozEmnts1Do55t1YzVKDRUfqAE7s0YJRmwLPqcge+xFj8EDBS9Lc5QEPmwFa2JL6saJQD1m6EU9iDrMPgSPOkqE3nlvgcDlPvK4gKceX88B7r5jop1qvh6BojIx7fnVn0/p5Fnu3vih+xczc0jrmJLH/Y2SGiFqOVdZfGXB8M5VlwLsgq1c+AUTRqWTBMDV5BiUgm0XKRtSx8LGbPNoGTnjKOivElCil5ZkYcAbCl2pdnHbeGHbKdJtTTReKsQ9CabmV626cLIZuKX03d0z6lFBMFQswHocxXygNo2hNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr2LOTJiujcBwHErCQNVDjYgyHtbqgsT6YfcVP1RV/Q=;
 b=NSi+t+yG03y5GFQzjrALBNDN2par949TruPYa4STrq/5l9TRRtYB6r7YkuBiG+TGxGJryZlbfZswr+8zUcc2busgqrU1lSMklG4Tyq9bP11lTjEJI8dtqU7ZLyv8vX+OTkTP6Rib/CQCx82KT9vZ3EAMUuU1k5G3qB6Fkq1NNeFgiCvk0EdeaHJqvGiI3OMMyp8/pwnNctC9xVnOhn8gqhvVUXFSilPfATf51KFy0ATryzZLpGMENgxliEuEWyAPY8qIPzcVprly6LQWWSJ0rb8/2xmVUqk4K7bgJTa5u443FToXEXSDY/Hnj3To58oaaN0OLZaaNuSllGPnbD7MNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rr2LOTJiujcBwHErCQNVDjYgyHtbqgsT6YfcVP1RV/Q=;
 b=uBxTc07Y5ZSGPisanAphy7dkpXCKg3hT4s3iEWwgfLY4cFZe3cwDNF+MmH/hYPXt08+zRlbLAFJhIFqoL7yKfe3/MQxE2i/D0jL1h6/MAg+n4wpwq/XiKvQv3UqcQEaYc4VtdjWnXpJAAPQnjVpl432lRHd56XsyOr/xk20KLN0=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB3162.namprd12.prod.outlook.com (2603:10b6:5:15c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Mon, 18 Apr
 2022 22:02:26 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::3157:3164:59df:b603]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::3157:3164:59df:b603%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 22:02:26 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] platform/x86: amd-pmc: Shuffle location of
 amd_pmc_get_smu_version()
Thread-Topic: [PATCH] platform/x86: amd-pmc: Shuffle location of
 amd_pmc_get_smu_version()
Thread-Index: AQHYU2yuMeYidUswH0W6CvuzN7NHS6z2OP5w
Date:   Mon, 18 Apr 2022 22:02:26 +0000
Message-ID: <BL1PR12MB51578B2A60309327CA8CC397E2F39@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220418213800.21257-1-nathan@kernel.org>
In-Reply-To: <20220418213800.21257-1-nathan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-18T22:02:00Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e642ed21-af8e-44ea-b113-9ded5a5867b2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-18T22:02:25Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: cd42888b-2898-4574-b6ca-789ffc875c09
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46c8ca44-770b-420c-2cf9-08da21872003
x-ms-traffictypediagnostic: DM6PR12MB3162:EE_
x-microsoft-antispam-prvs: <DM6PR12MB31627862627B067D7595B8A4E2F39@DM6PR12MB3162.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7vBZf4iDXSSlQa94nxZJ0xOAu7haCRhUBYel2Ii9GUDouR8+7c9xY5G5Qj4rRyLa0A3I0tClreWES7yVJpKqFVTtDK9GIej70uhB31sxnQLytF+U/fE5GZiMNP6yrYVja1uaVDa821Ib/ZirxXpx600a6Yid2Dv3ROWcU7H7QUUdiH2Xpi4sWVHyle/or96HPvzj9S7arCBMLLBIjR+gUHVVApcgnOW80UiqLxJTv46D/0xFGy1Eu4Cv1HLkWOiKgzDIMncKSMRW9Dr7CeFoXrl7zraN14W5PxBG5VywH2AB2T1Ez7PGuV/YsdSczttf8v78Wnf6GFH0k2mLvCiOBrnUMppkl4tZDIH8N7yWBKeg6Fx6Od54CUV3GL0JX1JSgH3rwPRdnrRVaMzykDwMZqO4N7asiFL87znFDR1sCccVkTKffprQsc+OFKWIQ9i/u9ilVerSDN9UlcDDPljES1w5bYfQjOjzEq1bV+oCY4i5A8T8X5G6HNVhL5AFRJQw5NknfTQw3HoRt9yLG2ChJc4pDC1R228m2tEzt6zzUHU3KL63Ep3PFotee81k0Nq7fY2gRlkhm3yzCTUGPp76bkayIaM7/B/sW2Lx+WVgJr4GiJPCVRm1SG0IF1+RguSs0VsmJb5d/UlUFJMkDw0E/Nel40APbU32rHTGAhghHQ+a/kcI0ZGhujji3PvRCI0LIL5dH8HD1/n/GTbfMBiDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(122000001)(66476007)(76116006)(33656002)(110136005)(54906003)(64756008)(8676002)(5660300002)(316002)(66446008)(38100700002)(38070700005)(8936002)(4326008)(186003)(53546011)(55016003)(86362001)(71200400001)(2906002)(52536014)(26005)(508600001)(83380400001)(7696005)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uetiYVO2i76FmI3x3VrOnCJTZVrLGrpTK9xYj8AZBoUIBWKYsspjKggwiORR?=
 =?us-ascii?Q?d2zVBVOLjgrMDzCFRF1uHxcSRfHS2M2YFdE6asBhfWz1YIxXwQUedHmaN8nI?=
 =?us-ascii?Q?9+7oUVkic+wOPVFM4datJmZ0f5Djr0J7XWE719Mo147KuXEGpMPLv84mbJGj?=
 =?us-ascii?Q?oSWpiqjuV2wVM9hng+wyv+oCIVgfTFHmg7i5Uhdy1DgWfyhUsPNMHy5IRbfw?=
 =?us-ascii?Q?hbDE6g/66pIS8c8TlQWpKciqfCQHwL4XRDAFJ2OCgU87OcqfbP+k6MeRjiPZ?=
 =?us-ascii?Q?8tYMFDdAZxh8i00f+EPUIiMtEKmF7W4LMK997y0PtO3c7LAs2wuk3cnkrxsC?=
 =?us-ascii?Q?/LqJZ0gSV3Dqk0elbFO9660pzoaNOzJXQbot9MVfY9BaTWxUozwPXpjlTznd?=
 =?us-ascii?Q?EbV+GMXj2J9e03QC1cuhC9GcYBXzQ1QdloXYkTkXRmA6f3WK2CqJ7H++HoCR?=
 =?us-ascii?Q?kMRTIF6436oURp3IhC1uex42XseXTEDk7d0sna7hA0Ss3R8o7EO82rcLwl0q?=
 =?us-ascii?Q?yp2fPe4u5lmFRg+cltzk3HQvlZ0ED2TEG1G4DnZBL5DghoVoKNWCY2ZgSZm0?=
 =?us-ascii?Q?k6OUhZVmbRgqqBkN9Qwg1/joVljHrbXerhpS3+cffW6yy8UQdwRIVsoerhry?=
 =?us-ascii?Q?qrXem0CGyUOQGkoCEhECfcsdv4m6f4/OfEgkFvwfZoerGf/oP8wqdcp3nzOo?=
 =?us-ascii?Q?YiybKqshzcM9jJvoH8qAY1kowfDWBfQxsJhd+jgZzwUolsYBe926aNAMuoDI?=
 =?us-ascii?Q?EhKJNfNJJ7ELcWOKYHjEZ9UQc93HSEqVTIBllKym+bwYPIzhl5brY6QqrxS1?=
 =?us-ascii?Q?Vyi9/VTeVBqTSMwPO5v3BcvF3MhTIPiRPo+j8ZT0j6c7NWQ67Z14cBb6c1Wr?=
 =?us-ascii?Q?DMx3R3+iNJOMkQgKoS00nVbOrlkzLV+jc/8t5bFLgDkzXWr1vNDt3JZEBvj+?=
 =?us-ascii?Q?jwJX4eW10FakT9pzO/8QDAcUYI62pluHAvii/9yiTOdp8RWWoY/LJzJci5U4?=
 =?us-ascii?Q?gYD1vU38QkuDTkJJ83q1JTrjrI+1ZIPfO55HgVhA28UWWOyugAILQHVdJ478?=
 =?us-ascii?Q?hdXePXopsd0Q5k3rqEXksA6jbnnePioe4ht9ipBK4B5IXPaiwFyCLBDn9BIL?=
 =?us-ascii?Q?KEIXzcidTp4ITMmlKNJS3aed8tKOeuDHGvAF/3GVce9RVuRVjqVs3oFFRsLC?=
 =?us-ascii?Q?e7Of8lvGfecAgp41xyzUFtMUCfeV8/Wn0VgQ0eyTBP/NMSdfY1N4LIEGhqcX?=
 =?us-ascii?Q?JYW1HGHcW8Lr/TpfY8Id2YY5uJfn1fGMwGRcKo2W3u4J15dHIgv1E2kuaXml?=
 =?us-ascii?Q?diIb1Jd1Nv3pVrH/kTlD2xsbz2yqGbcxZR6VDxIXvxWAbRBPPZnUDYdS+hP9?=
 =?us-ascii?Q?V2Ut0324Oaxv3jz13GNHNV5UHccckCcVMQFHV3FxM7HZhzATCNnT5p1WjbPD?=
 =?us-ascii?Q?9tC8OIxI6ayyMiFq3EwEqdZGv12IZRu3WNl/Bm+GuP4n0SXhOpthKJp3/wvX?=
 =?us-ascii?Q?urusGRbW8xNqFVU8CTmb+z/HjCPThT4ZKwooiMOzlNRTVRIISRwk0rry1GFI?=
 =?us-ascii?Q?+ef84IwQzsIxTG8zOqnOkanLIgGXnux8Cy0EaxYUUOY6UA3g0PnlEU9AOdm1?=
 =?us-ascii?Q?rQgYApgrFZs0LhNnf5Nftdt8LgSRBameqSUfatX1hdOU+Frn4YPegD0r38WE?=
 =?us-ascii?Q?WeF1MCgVLbGmaXpTsj0/ifbUfmlyj9qw8dNkQIbvl0OrFtAEDGQiZ9Vl652/?=
 =?us-ascii?Q?Io3IHUer/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c8ca44-770b-420c-2cf9-08da21872003
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 22:02:26.6777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXsLnpg0qpxRRRjuzgdMaiClEy1NBeBJ2w1otvLHA3fgCD4AKx4AA3V4v3Wr4uljNmMLsFTTtI1ZWqcFHg/FFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
> Sent: Monday, April 18, 2022 16:38
> To: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Hans de Goede <hdegoede@redhat.com>;
> Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> patches@lists.linux.dev; Nathan Chancellor <nathan@kernel.org>
> Subject: [PATCH] platform/x86: amd-pmc: Shuffle location of
> amd_pmc_get_smu_version()
>=20
> When CONFIG_DEBUG_FS is disabled, amd_pmc_get_smu_version() is unused:
>=20
>   drivers/platform/x86/amd-pmc.c:196:12: warning: unused function
> 'amd_pmc_get_smu_version' [-Wunused-function]
>   static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
>              ^
>   1 warning generated.
>=20
> Eliminate the warning by moving amd_pmc_get_smu_version() to the
> CONFIG_DEBUG_FS block where it is used.
>=20
> Fixes: b0c07116c894 ("platform/x86: amd-pmc: Avoid reading SMU version at
> probe time")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>  drivers/platform/x86/amd-pmc.c | 40 +++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pm=
c.c
> index 668a1d6c11ee..e266492d3ef7 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -193,26 +193,6 @@ struct smu_metrics {
>  	u64 timecondition_notmet_totaltime[SOC_SUBSYSTEM_IP_MAX];
>  } __packed;
>=20
> -static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
> -{
> -	int rc;
> -	u32 val;
> -
> -	rc =3D amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION,
> 1);
> -	if (rc)
> -		return rc;
> -
> -	dev->smu_program =3D (val >> 24) & GENMASK(7, 0);
> -	dev->major =3D (val >> 16) & GENMASK(7, 0);
> -	dev->minor =3D (val >> 8) & GENMASK(7, 0);
> -	dev->rev =3D (val >> 0) & GENMASK(7, 0);
> -
> -	dev_dbg(dev->dev, "SMU program %u version is %u.%u.%u\n",
> -		dev->smu_program, dev->major, dev->minor, dev->rev);
> -
> -	return 0;
> -}
> -
>  static int amd_pmc_stb_debugfs_open(struct inode *inode, struct file *fi=
lp)
>  {
>  	struct amd_pmc_dev *dev =3D filp->f_inode->i_private;
> @@ -417,6 +397,26 @@ static int s0ix_stats_show(struct seq_file *s, void
> *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(s0ix_stats);
>=20
> +static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
> +{
> +	int rc;
> +	u32 val;
> +
> +	rc =3D amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION,
> 1);
> +	if (rc)
> +		return rc;
> +
> +	dev->smu_program =3D (val >> 24) & GENMASK(7, 0);
> +	dev->major =3D (val >> 16) & GENMASK(7, 0);
> +	dev->minor =3D (val >> 8) & GENMASK(7, 0);
> +	dev->rev =3D (val >> 0) & GENMASK(7, 0);
> +
> +	dev_dbg(dev->dev, "SMU program %u version is %u.%u.%u\n",
> +		dev->smu_program, dev->major, dev->minor, dev->rev);
> +
> +	return 0;
> +}
> +
>  static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
>  {
>  	struct amd_pmc_dev *dev =3D s->private;
>=20
> base-commit: b0c07116c894325d40a218f558047f925e4b3bdb
> --
> 2.36.0
