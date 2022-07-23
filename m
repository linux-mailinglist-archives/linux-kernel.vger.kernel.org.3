Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9E57F1BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 23:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbiGWVYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 17:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiGWVYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 17:24:03 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515BD18E0A;
        Sat, 23 Jul 2022 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658611440; x=1690147440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oU/WGoKuVsBztbFsznSzVZebY8DFtDlpnB8ZUhy8VV0=;
  b=Z/aHzOJUdDwLvPV/HI4LKbBye2vgLIIAruuLbPEHF6u5eQXarz9wPaLU
   e4YLyFXnOYeeTPhBQEVZsO7lLA0Wsl5vea8UYSpragNoYJUEnzetMUten
   A+rG+VNTMkzfRQM7WvIQwPz9+J6ZZzu9b6TrAd/0ztS81+NyybTEMn53k
   xtH0wWjxSZhHpM5JAixLXNF71qAFnj8+czanjM0jYQ/qjflFIki6R+Ds3
   40bU6CZRnKluk+XvG/vujy4NFdI6SfOpALR8hJotAH1JOPKndqLZfuaLF
   gdJtyUNAz/DAiuq6tHAAy5BzVkSmuUTWk6uwOS7LjLk/OqO53sXx8JnkK
   w==;
X-IronPort-AV: E=Sophos;i="5.93,189,1654531200"; 
   d="scan'208";a="211676306"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2022 05:23:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQfAMwotwbPKzKB93+KatdCmdOJx8W2Wy+W51fxOddRasKOrhUxC0YYVjTnqWHhHEJIczHFA8un7E0iZbOwAfObPGfjk91Ps2W1PqygmCdFzANnTtM0ShiSoU+iiD6V5k85q6yziwdFLtKRW/jMpRkPtRxpPl9gfVgHaSOzuWvMHOv9YUJRCmg1gxgUuJv1P+ARKmPAbfE+6XtLy+mjjYceTFFhH5zgJVSfftPnBR9VlWeQqMN+TUjnorYRR7MnY2tUxz81h9Ig1ci4syKLPPadfgGWFQ3sYZgDGwoLsEUCm84x+BoROkmS6+r5Z7koySZqKpXAgN9yPAuu1u0t54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg1YkyVYrCeh/OGgBkibcmqMdjgjzVP5ALdyeTjFmpU=;
 b=fIkzRdaz+QYnz2cKGv+6Dj+mC2krtyVmArvVSCV8eLzkCGgOPdAfqdlCx1R2slvrizTZ/CAoq/RX1DI3HY6Xm4DhCgpJx6tfsPCTrQTxfNOqMOEfMAwsGZFHt3wzS5O/88LEt+GZNOL5MydD0NRkIUsCh71TnD4gWAK75t7oIcCuJZohNm2GOnI50xwO3lU9QturYLitR/D0xqF+l7LW5xzPuMdMaHrZ/dfXA13KXrz50eA5WCQj0mm9kJ2BO+sLr0zIIhzX/11aOsU7BYarFMnD3GX+GfceW16dTFifWZAi4ARkt0apQZKd59wBnXJS1okaC4dZ80vWFJEnR+6wlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg1YkyVYrCeh/OGgBkibcmqMdjgjzVP5ALdyeTjFmpU=;
 b=JiAvo1GMK3ybQ3pd7h2qdsaRZh9W/OFbaYeFxFCGRn/N4/cdvUK9yVaRxlBVyMTJ+LUPACYjNOlUj23RqGyAOOzx/EMqLu3R+uxn0Lz8f/XJ1LCd5s60bKpErr44Fd3xGshXr1uSa5dJQDneQWW8DtTWNIKW6I39Bvl4FRjbchw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB5709.namprd04.prod.outlook.com (2603:10b6:208:a0::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.20; Sat, 23 Jul 2022 21:23:58 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 21:23:58 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Can Guo <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Topic: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2MfEMA
Date:   Sat, 23 Jul 2022 21:23:57 +0000
Message-ID: <DM6PR04MB65756C5A6C5F674B19091F7DFC939@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
In-Reply-To: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11b9ea92-546d-40cf-98a9-08da6cf1a786
x-ms-traffictypediagnostic: MN2PR04MB5709:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7VV6gIFIJX2z9zOsEO9WsnMRBvXMMDv+rc+rjf31lZIOvrL7phH80JsJyTa2ueftk43oCCyblWtxwrqmqMHbga5MSQXBbOj51zR6kKFNx1W4u/h9fQdeGn5PlWokmJx4VAe0l38tatoDaj8JBsg7eQbytUexQn/bMg1RNtN0Cd1p5lgBiW1LybiJsUkw9qu7KRKWb4h5BCebZc9FCsJ3F75gkJuyC9AXImgRzqa1eG4uRm/oz+cMXyJacxGWVTfaMivzGCCk0z9FfNOYwT6VZb8ZGoNnAZaJ9k2MQbfBwjCgbl4FpQMile+LmMTh6E9Ml2i7vUka5jynCRb9KUNBzOk63se3fv/b/9vRK5pOSmU6oWXVaEeOuM/EgOBS1Ay0RIv5FBBI9VpEB7ACgsT8hlDNCPS9qf5zt+Ni8e7JG1HzybYkHGQ6NGbKH9lq8TZFBuqEENve+bSzxLNQodfzXa74kWacg8xVjPlezZSmX2knPPN5TQITV562QQZM3H3h17GlYWDKEIR4RlrJVDxns7FB6xlFsweyNtyc5GOg4QwCpbB0mqGNliEZWiiedL9WCLEv45DhVrKwZAPQTiW6YR8KYVt6wjLRKvBzoGgVRv8Va1RGJ0hwlayatKctSdepLJ2tT8MQhru8K+gwJBbPPjFPFS9BntDApSbhgfyFcw0WePnMyt+zk/DTh7Tp4ppPc+KMvJH5Ijc0fE83mU5+4tkygtL21QGj7XdJjeTH17jAdSmzhajFFlxZMaFxQpwL4HN+y1TXBBAjBsxrtV4IYgvbLRQtd9e0udDZTpUXjBPPOUEjjlFNzEaf3h1tufuUmVRmb5mzMWpJv1/RxCj+4BPMYCDXiWOWUoE/guHY/+0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(921005)(82960400001)(8936002)(7416002)(5660300002)(38070700005)(38100700002)(52536014)(55016003)(41300700001)(122000001)(64756008)(76116006)(66446008)(8676002)(66556008)(66476007)(4326008)(66946007)(2906002)(316002)(7696005)(26005)(9686003)(86362001)(6506007)(71200400001)(33656002)(54906003)(83380400001)(110136005)(478600001)(186003)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CPlZ1XaZO39QSjJ84YiH0N3cCKip8vKecsgyWws351a9sgOY4MBxNyevvWUz?=
 =?us-ascii?Q?s5ITKNB4pnnBcBV0VF/6vBSAEQM7U9NeV4wZcT4F3x/xe8JvOrhDFA5cZ8nj?=
 =?us-ascii?Q?6YmD5rj3rRhBvqw4PB/3ucbPlChDnUwkngID4d6EZScE0tu6IFlg2KGTmrLb?=
 =?us-ascii?Q?04+mQuLYmDVDAxL05/NQ43Q24kR2jAsvktNBTGNT/92TSC0ysZAVYTPy2JWx?=
 =?us-ascii?Q?M+sWFk3MGFnyVejCMtGVssTC5DsWjV/7hpNw/wzfzlh+E5tm82jaBjcp8R7H?=
 =?us-ascii?Q?mTBwXc5i7D6bG4tixVrmvtUjDx0g+mhvLOyOQPGhQ83M1DqJi8Z7NKW+LvmZ?=
 =?us-ascii?Q?k4jQSGYk0cWYH8KyUpdPiY/m19BkV5V0PZKyOb86Hrp6IK78DhQLw25AH4ST?=
 =?us-ascii?Q?fHh9QJ0YJOo+RaDWRMCw9QHvKVz1+yxpcMcSrD9dbPwCk/W106wNY//UDgUq?=
 =?us-ascii?Q?MHrU2tUUJBEHVDDDIPIApTC8MiSgJGh2GpFYPdvpJlDTnpZbg6LleoGCeh73?=
 =?us-ascii?Q?C1K12Er76HkPpJY0Q4BrhdMOxrLGkWGipCgDEl2Itrml9FR6rxvwfPQOI9uo?=
 =?us-ascii?Q?AWxrLeTiV7QW6SZLlKoYnwL/p+464gGqTm5LYxcZ9UHu/i1eElekr8P43Kg/?=
 =?us-ascii?Q?5nLUfEyoRKjP4Om4M9LCHth/j4AUpi+c93ydWhq2Q55lppDNDw2UunesdVZn?=
 =?us-ascii?Q?9htiI8SZ3PHJyg5ZLX9vDCTOLxZxo4qCcR/WZjvIc0B0gjaodP0ifBP9pLKg?=
 =?us-ascii?Q?ymWJCedG5W4hoF/r+Riij/XmMAxW/+eDvVe5ml8U6OXhM45WM+9jzwGGwhof?=
 =?us-ascii?Q?wYf818R+zOx4tc0+RiIA7DmMUKOq5VsXbSuIRNaIj1a5p1R1I+zSYZLBg8LA?=
 =?us-ascii?Q?NoybkN7+AtR6JrbY/UDEocr49bb0YDmGEAGlSnLQzLkM5RaFKmFdZrJ8rhB2?=
 =?us-ascii?Q?00AC28XT/Zrc/Pu7o35YOfZp5OKAZ1v9k0cgGhS7ysXzYw44TNqaOCy91hf+?=
 =?us-ascii?Q?lYuvxAdYS1ZyQ92oMdF4W9StkwzFYvKnXLp0SuLBsjLVnDJMb0tw58VXYrrf?=
 =?us-ascii?Q?CQNcUsz7c3z5ZyRvY2MNl3Xp5e0ZseY1fow1WXfvUXDjJHNoPC6G3++dgUHW?=
 =?us-ascii?Q?R44IaPjYJWL+i1SvFk3uZokWm2y7C856liw9TmDii/kU/Q3ev+veQa9mTcBR?=
 =?us-ascii?Q?UfGsoaABfnlYgKpJf84KHyZGpsWwMW78A8HlSwp1Vk7FgGHYcpNRmwrNOWR6?=
 =?us-ascii?Q?JYrsVq0fRnpzbLwB22qDfviihZTnXTtNfBX8MoinZRbczvIt8Qk8OEFTqtxv?=
 =?us-ascii?Q?nZos7UdmTRYKkhk6Xfcs3Hl2RHJnLEJRunlOyvyf+jGuvI36KQhl/pHH4/48?=
 =?us-ascii?Q?gdPBfihREMlpkTKnQkhXDw9S9wXwk+yvv6Ave76DMcr11PIhp1Xy5hyjbEQ0?=
 =?us-ascii?Q?944Hksk7FG0WVUFqFEWG0kWo8NZUJhoG5Vf8ytpPU1cbqtuY0IGuBTqI002v?=
 =?us-ascii?Q?b6v8k9TjmiYo7EZUR+JD0pZJGPKFeUBcpiidNX9s2hpiPSVtAnJZrJ9VMWVv?=
 =?us-ascii?Q?TZ51vxuMnP3sRRY8ZFbl/uZ2lQBvHNZCkhsiFeDg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b9ea92-546d-40cf-98a9-08da6cf1a786
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2022 21:23:57.9412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZ3bFoELgF8RkbmrZe8d4ClbGxsQerwu5cfe14Ejb7vnvK82wiYRqidAyU4aTFiLPyPoFBHDv1rfG82MgwqsQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5709
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static inline
> -void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
> +void ufshcd_send_command(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
> +                        struct ufs_hw_queue *hwq)
>  {
> -       struct ufshcd_lrb *lrbp =3D &hba->lrb[task_tag];
>         unsigned long flags;
>=20
>         lrbp->issue_time_stamp =3D ktime_get();
>         lrbp->compl_time_stamp =3D ktime_set(0, 0);
> -       ufshcd_add_command_trace(hba, task_tag, UFS_CMD_SEND);
> +       ufshcd_add_command_trace(hba, lrbp, UFS_CMD_SEND);
>         ufshcd_clk_scaling_start_busy(hba);
>         if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
>                 ufshcd_start_monitor(hba, lrbp);
>=20
> -       spin_lock_irqsave(&hba->outstanding_lock, flags);
> -       if (hba->vops && hba->vops->setup_xfer_req)
> -               hba->vops->setup_xfer_req(hba, task_tag, !!lrbp->cmd);
> -       __set_bit(task_tag, &hba->outstanding_reqs);
> -       ufshcd_writel(hba, 1 << task_tag,
> REG_UTP_TRANSFER_REQ_DOOR_BELL);
> -       spin_unlock_irqrestore(&hba->outstanding_lock, flags);
> +       if (is_mcq_enabled(hba)) {
> +               int utrd_size =3D sizeof(struct utp_transfer_req_desc);
Maybe we can map some designated ops, so all those if (is_mcq) can be avoid=
ed in the data-path.
Also maybe we can constify sizeof(struct utp_transfer_req_desc) which is us=
ed now few times.

Thanks,
Avri
