Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39FE5877B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbiHBHTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiHBHS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:18:57 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6863332DA3;
        Tue,  2 Aug 2022 00:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659424736; x=1690960736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UqYu2OxsaGpSJc4L1kePrAo4L9vdsmeRvWn7nJbRjdY=;
  b=DusYtf+qDTICWo/rfgLbNSh2jCMYEfiO8yRTloPXN+UMzpy+uX6NxakL
   XnKQhvIZcyuSpBTul1XR0xKAID0mt/08N8SqJIla8NNsMIc7t/dDALHP9
   4QtP2oJNtjwXUl+VD+X++SVZT6FcBDYkp1Z+cfxE8FHbzpot5ZS92T8m/
   pp86/heIjBdhWSK2bhTD48JRP3Ak+YZZ/A542kwLFywQYhhGCO4uqmFjO
   0ooE30/01GtotktvEAf+hnm/YWmsSFLkv/RkfG0Hur4h2FXR4Ixqm69yL
   CpEMxGmrX0Tdw3FevsCt9huOnKxos6LuqaGLhKJrWgdM7+3ArJY8FDRnk
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654531200"; 
   d="scan'208";a="208140374"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2022 15:18:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkDhOEu8pTvquHP3R5cLeGBiqhChxazPZk0PPrwKZHc+gQsMKPCoekHISJJta2v51xWqR2YLxVrO/bLIgTT2U5syCYqHFb7q7mDh2P8iNoij5WThaNdGy7ReRmCcnUCYhs2WqZDfAQclOCwL50CPgRgYBjp2B9y/ExPLOTxGbiDit/uwIUztbdJUhdAzOhHcNcKlMLtNyQX/DiL3MEP2LkxSR97htdTCQ6A4rqSrfeJzPoF5wOqEpxXfW4pJNs9192KaeSBQlW7uZDni0Jrwe2efyRmUz+SEy57Uwe7G1xB10qkGMEIiF5SQdgFLgImOdbzKEKP30edETt8a/Zf94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSZ6Pcz3HiVxE/f06NBd5uJyK2gWWRXa8125W3kKSMU=;
 b=fwSwPmXuykGwS4EClpdu1K5Gush4/Otg+t+b6CBiKt72NXKoBKYrwEE1+Ol34aSLtA5LYxi9gqZ8Bo9OdSLTmwB708XVg/65Q/1lgWaLNrkVuXIA9loZxOHRAdZQb0fUDmnYPeDix3ttBXWSg0Jo6l0pc17iXs4jdOQGNgyGliRuacL624Q6mUh4lKTEINr+BFHrlBwu3DFNk6DkTWEEk3Geq/tbfHyOHrYhgQT5LdWR28CHJhiSako7jZ/DU47rftdzTosLsdFpQAZTzXFBfRVyJn/0T3juu7u38InffGcI1cfDuolSiOnFFDoXDQ1N2adHKISn/U2Mi6kfwM93Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSZ6Pcz3HiVxE/f06NBd5uJyK2gWWRXa8125W3kKSMU=;
 b=LOFyE/C88YkuBgqaRhUyHsbIH0Hxc1KBzwaaauiZZDG9pWf7HZW6dMNlC8xff32U5jlB4Mh9H2+cL0yO+p3+Fa8HhtwIhqJM3tJqC5un60OyqppZiA/ZJr7u7qAmMMbxmy9oF7Ff647lfj1oHeESPslc13q41PKV6t5brQmOTnI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SN6PR04MB4110.namprd04.prod.outlook.com (2603:10b6:805:46::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.15; Tue, 2 Aug 2022 07:18:51 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 07:18:51 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Chu <chu.stanley@gmail.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH v3] ufs: core: ufshcd: use local_clock() for debugging
 timestamps
Thread-Topic: [PATCH v3] ufs: core: ufshcd: use local_clock() for debugging
 timestamps
Thread-Index: AQHYpgduebgdyd5qmU6KPdLYUuexca2bMTpA
Date:   Tue, 2 Aug 2022 07:18:51 +0000
Message-ID: <DM6PR04MB65757B61628255C6E4F5941FFC9D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220802103230.v3.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
In-Reply-To: <20220802103230.v3.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 171cd42f-fdb6-43c8-5ac9-08da74574031
x-ms-traffictypediagnostic: SN6PR04MB4110:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mGHxbOuB6KfAyXhm9UeUmRx7Ytozyg3zATZ2tf8F+dam7Dly0DnOiV9IWKL76ASOyD+MaTs4WzEkXMc7hIRTqHNv1bRYN7m1rwnvSK62nuxOv9G6q2cHbZspaXF8TFlO8I921pu0DpYx5bfRa7VZa0kP146JVN4QXXKqi/PqJhgULWMmvSAr69O9iTAqlYHmS9zhdOsfxSil5+CqIaqBLHl5hPMCAZp1E5mrbDVspJAHPjdSArooph0Ee19ubJn1kblahVfO+X6BN1c2hWnVb3nE3zJfxXfdttzekGi2QJC/8Y9cnZKQRjg4J9w9ri77i+0d33r6VRm9kmZ4ZSveFrkFHV1p7W3wKglKvOnFLZghqwfsYhx9aW4T6EvYSnYJadQ27A4xNXyjQTUONlKj7FU4eC1RWqGrcVR2+A0EAIqvHmdVGgB3eSe5kEIP7C1g2IYEXJLkIRkyCK4lQV868IIiZQ8g7hvRSuHY/i00Oavljae5puMUvLWuek6L75qcUZNXI0EExaW1b4Cw5s5CkWkGKk2pZUydrWpoMIydfvCQBf2ksH5/4D1UGk10AD5a2PWJYhDoL9djurqFn2cakZgud7p+N9eYem0BZUszj3Rqfcjco4HmAnxV+KjUZ43iq9yBFMPjAC3CqBFWvwRpGWWVOGDJ1kWAmKuBHEGsj1+ZXmc9acnIJ3bu6yglVP79FRPqWEq4ujm+7qQYJ7l0AKt78JHgHX78gGg5souk2df080mVOs8s/nHY+aOT3vCbGm6Xc1vbkHfR8TpPFxX6333ebnOyPXj06O2t8saU+6k1U1YsM/82Wb9mTYQ7zouQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(7416002)(38100700002)(122000001)(82960400001)(54906003)(26005)(9686003)(110136005)(6506007)(7696005)(186003)(316002)(2906002)(83380400001)(33656002)(38070700005)(66446008)(64756008)(5660300002)(478600001)(8676002)(4326008)(71200400001)(86362001)(8936002)(41300700001)(55016003)(52536014)(76116006)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cmKa+Y9P2FTP9EKis+830rnK4ivAQ0NsPkive5vFCj2PWH3tjWBm7aLB6/V/?=
 =?us-ascii?Q?SfyyuBSRfnjkhUkAL6068Zll7LIrV11Rkew2dPJypO/Epv6M7N5MaclqYB1Z?=
 =?us-ascii?Q?GkZEV+J8YnppG7gpX1cw0FVkF27TuWNW/n9w+ExiRIF24JXybdF1PtoPK2J6?=
 =?us-ascii?Q?al0yQ94lCoeFQWW063zxDCgTmOUhXLaHQI7NNYMhOpgdJRmiXd3XBXoNO0Fw?=
 =?us-ascii?Q?CH1mD38dRk7L1geK6P5yNo70uuLZtewn24X1DR7+bvKYbpd+223hcvSskkWR?=
 =?us-ascii?Q?DJRPAn8xIXWtyWUVgPt73tm+h5WiWUILuJygNCfSVfCk3sDA9vwQw3a9Ku3c?=
 =?us-ascii?Q?gZ6+bfBdeLzWdwesCs+hKkiDF5EI/LupcgmJOAdCAdGfs8+v4MJ3PK2Hs27K?=
 =?us-ascii?Q?UeSZepa7rRpvN0U6k9koO71KPhAerv0MLJTdP74XyHlmpECUhI7mzKJ2pKJM?=
 =?us-ascii?Q?7uFbpeE9SghWxLf5aiMBXg8Xx6zAuqcy8e+m3/zMWQY12kHaJD24IgWrhwXs?=
 =?us-ascii?Q?4AcoPJiStr9XIXpRDk2evK44Cl6azGKy44p+0xYfmNLdQIqWnNZXEudwvZPY?=
 =?us-ascii?Q?+nvVvoNk+chvSFl7mobv4rPqcN7E4x9mQEYKPiWBZSRTQGpxWC8bjHupxjyv?=
 =?us-ascii?Q?bSIwT+sK+mZjOWUmuPftcSI6dfd4CO0YhmyIQlAxVkeHEwBx7dU6eHWUMcOg?=
 =?us-ascii?Q?Aeq3//TGVLTRF6flyrANe0jEpeVYyBBEsQNUmHY/lW+0G8O1tAzyOyEVsamN?=
 =?us-ascii?Q?Rlo4d3M+qpbDxlOZDgsiV0M85WbEm9yM/aqk23Elvk2kt3kme7wG/MBxMgIv?=
 =?us-ascii?Q?lerk1o6zE01N/bI2eAeoHNQgThHJ5EXDqCYeOsV7P7a8Orv3B56r1bvZAJBz?=
 =?us-ascii?Q?qNqnnUh0sT7pdTrbkNiO4LK7k99hXv64i6ReeA+EiXkD1RIK3dCu7K1Xny1T?=
 =?us-ascii?Q?3TgBJNhVWjWVghX4iJ/9FP1cQF3anMbunMft4/aBL8d7uq0WrwHXTR6GmJVI?=
 =?us-ascii?Q?nhr7zTaowEeFTv5galJsgaaGKEFqdrClcCAmYfb72AGsZOXxFJsUthGvHqFL?=
 =?us-ascii?Q?wfGblBHH6l8U/t3sEMjvxYcifhuFLogXCDwgIjdAmFLMaMtpt72wy1xt3duF?=
 =?us-ascii?Q?lRWNA9UDGDRMo0jOO30zS4Jja5+Klrzomb0gLlhwjX91p0HyvVNMenIaP9kF?=
 =?us-ascii?Q?uWWv/aDNeC02ZmqPOdKdGJqin6mhUWZCdJRbdMl2dpMVgpYHTAI0bEN2TBsE?=
 =?us-ascii?Q?Vx3p9nLqfr8eEuXnK1aR0OfJWNcqjwooC9gU653EYjULZwLrtgu2KTMaJgPw?=
 =?us-ascii?Q?94Ggk10xiJvBEV43JyQp1FVfYXlqUcMuLNf+FgvjHSa7Eo2tz1b0+1acJg9x?=
 =?us-ascii?Q?oMhAkVTOpu/bTdSCpdqUY99Z4yVkAKO/SqFSZL2caSQfVt2UNHWRW90Z0phs?=
 =?us-ascii?Q?pHDQ3gdOI5GtpZrgxVjRFaNuVGYjdy2yNZXfqVaqpEkQXr82Onue4VIKcZzl?=
 =?us-ascii?Q?YBE4rvjl3ztQnQzUzIxxojn38TflI4MSdkklZPs8tf4HHu9cV9WWeFUCHMiH?=
 =?us-ascii?Q?9n1da0KjitVLeDQU0qrHX+MNrRaLhvijdeQjKxnB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171cd42f-fdb6-43c8-5ac9-08da74574031
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 07:18:51.3987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4CiTezqWt1CPpheoFcJXC30OmFXqEYYYERwcGKLxMyCHkYd8qaatZNrqXtKp8M8CdGuyHSyBzuoMWATGFiU9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4110
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> CLOCK_MONOTONIC is not advanced when the system is in suspend. This
> becomes problematic when debugging issues related to suspend-resume:
> the timestamps printed by ufshcd_print_trs can not be correlated with dme=
sg
> entries, which are timestamped with local_clock().
>=20
> This CL changes the used clock to local_clock() for the informational tim=
estamp
> variables and adds mirroring *_local_clock instances for variables used i=
n
> subsequent derevations (to not change the semantics of those derevations)=
.
I agree with this approach because the words of cautious while using sched_=
clock()
Happens to be true for various ufs platforms, specifically of a required st=
abilization period.

Acked-by: Avri Altman <avri.altman@wdc.com>=20

>=20
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
>=20
> ---
>=20
> Changes in v3:
> - Add missing header
>=20
> Changes in v2:
> - Use local clock to better align with dmesg
> - Correct commit message
>=20
>  drivers/ufs/core/ufshcd.c | 20 ++++++++++++--------
>  include/ufs/ufshcd.h      | 14 +++++++++-----
>  2 files changed, 21 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
> ce86d1b790c05..e61dafb93986f 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -21,6 +21,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/sched/clock.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <scsi/scsi_dbg.h>
>  #include <scsi/scsi_driver.h>
> @@ -460,7 +461,7 @@ static void ufshcd_print_evt(struct ufs_hba *hba, u32=
 id,
>                 if (e->tstamp[p] =3D=3D 0)
>                         continue;
>                 dev_err(hba->dev, "%s[%d] =3D 0x%x at %lld us\n", err_nam=
e, p,
> -                       e->val[p], ktime_to_us(e->tstamp[p]));
> +                       e->val[p], e->tstamp[p] / 1000);
>                 found =3D true;
>         }
>=20
> @@ -505,9 +506,9 @@ void ufshcd_print_trs(struct ufs_hba *hba, unsigned
> long bitmap, bool pr_prdt)
>                 lrbp =3D &hba->lrb[tag];
>=20
>                 dev_err(hba->dev, "UPIU[%d] - issue time %lld us\n",
> -                               tag, ktime_to_us(lrbp->issue_time_stamp))=
;
> +                               tag, lrbp->issue_time_stamp_local_clock
> + / 1000);
>                 dev_err(hba->dev, "UPIU[%d] - complete time %lld us\n",
> -                               tag, ktime_to_us(lrbp->compl_time_stamp))=
;
> +                               tag, lrbp->compl_time_stamp_local_clock
> + / 1000);
>                 dev_err(hba->dev,
>                         "UPIU[%d] - Transfer Request Descriptor phys@0x%l=
lx\n",
>                         tag, (u64)lrbp->utrd_dma_addr); @@ -569,10 +570,1=
0 @@ static
> void ufshcd_print_host_state(struct ufs_hba *hba)
>         dev_err(hba->dev, "Clk gate=3D%d\n", hba->clk_gating.state);
>         dev_err(hba->dev,
>                 "last_hibern8_exit_tstamp at %lld us, hibern8_exit_cnt=3D=
%d\n",
> -               ktime_to_us(hba->ufs_stats.last_hibern8_exit_tstamp),
> +               hba->ufs_stats.last_hibern8_exit_tstamp / 1000,
>                 hba->ufs_stats.hibern8_exit_cnt);
>         dev_err(hba->dev, "last intr at %lld us, last intr status=3D0x%x\=
n",
> -               ktime_to_us(hba->ufs_stats.last_intr_ts),
> +               hba->ufs_stats.last_intr_ts / 1000,
>                 hba->ufs_stats.last_intr_status);
>         dev_err(hba->dev, "error handling flags=3D0x%x, req. abort count=
=3D%d\n",
>                 hba->eh_flags, hba->req_abort_count); @@ -2142,7 +2143,9 =
@@ void
> ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>         unsigned long flags;
>=20
>         lrbp->issue_time_stamp =3D ktime_get();
> +       lrbp->issue_time_stamp_local_clock =3D local_clock();
>         lrbp->compl_time_stamp =3D ktime_set(0, 0);
> +       lrbp->compl_time_stamp_local_clock =3D 0;
>         ufshcd_add_command_trace(hba, task_tag, UFS_CMD_SEND);
>         ufshcd_clk_scaling_start_busy(hba);
>         if (unlikely(ufshcd_should_inform_monitor(hba, lrbp))) @@ -4199,7=
 +4202,7
> @@ int ufshcd_uic_hibern8_exit(struct ufs_hba *hba)
>         } else {
>                 ufshcd_vops_hibern8_notify(hba, UIC_CMD_DME_HIBER_EXIT,
>                                                                 POST_CHAN=
GE);
> -               hba->ufs_stats.last_hibern8_exit_tstamp =3D ktime_get();
> +               hba->ufs_stats.last_hibern8_exit_tstamp =3D local_clock()=
;
>                 hba->ufs_stats.hibern8_exit_cnt++;
>         }
>=20
> @@ -4696,7 +4699,7 @@ void ufshcd_update_evt_hist(struct ufs_hba *hba,
> u32 id, u32 val)
>=20
>         e =3D &hba->ufs_stats.event[id];
>         e->val[e->pos] =3D val;
> -       e->tstamp[e->pos] =3D ktime_get();
> +       e->tstamp[e->pos] =3D local_clock();
>         e->cnt +=3D 1;
>         e->pos =3D (e->pos + 1) % UFS_EVENT_HIST_LENGTH;
>=20
> @@ -5329,6 +5332,7 @@ static void __ufshcd_transfer_req_compl(struct
> ufs_hba *hba,
>         for_each_set_bit(index, &completed_reqs, hba->nutrs) {
>                 lrbp =3D &hba->lrb[index];
>                 lrbp->compl_time_stamp =3D ktime_get();
> +               lrbp->compl_time_stamp_local_clock =3D local_clock();
>                 cmd =3D lrbp->cmd;
>                 if (cmd) {
>                         if (unlikely(ufshcd_should_inform_monitor(hba, lr=
bp))) @@ -6617,7
> +6621,7 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
>=20
>         intr_status =3D ufshcd_readl(hba, REG_INTERRUPT_STATUS);
>         hba->ufs_stats.last_intr_status =3D intr_status;
> -       hba->ufs_stats.last_intr_ts =3D ktime_get();
> +       hba->ufs_stats.last_intr_ts =3D local_clock();
>=20
>         /*
>          * There could be max of hba->nutrs reqs in flight and in worst c=
ase diff --git
> a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h index
> a92271421718e..2de73196bb779 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -160,8 +160,10 @@ struct ufs_pm_lvl_states {
>   * @task_tag: Task tag of the command
>   * @lun: LUN of the command
>   * @intr_cmd: Interrupt command (doesn't participate in interrupt aggreg=
ation)
> - * @issue_time_stamp: time stamp for debug purposes
> - * @compl_time_stamp: time stamp for statistics
> + * @issue_time_stamp: time stamp for debug purposes (CLOCK_MONOTONIC)
> + * @issue_time_stamp_local_clock: time stamp for debug purposes
> + (local_clock)
> + * @compl_time_stamp: time stamp for statistics (CLOCK_MONOTONIC)
> + * @compl_time_stamp_local_clock: time stamp for debug purposes
> + (local_clock)
>   * @crypto_key_slot: the key slot to use for inline crypto (-1 if none)
>   * @data_unit_num: the data unit number for the first block for inline c=
rypto
>   * @req_abort_skip: skip request abort task flag @@ -185,7 +187,9 @@ str=
uct
> ufshcd_lrb {
>         u8 lun; /* UPIU LUN id field is only 8-bit wide */
>         bool intr_cmd;
>         ktime_t issue_time_stamp;
> +       u64 issue_time_stamp_local_clock;
>         ktime_t compl_time_stamp;
> +       u64 compl_time_stamp_local_clock;
>  #ifdef CONFIG_SCSI_UFS_CRYPTO
>         int crypto_key_slot;
>         u64 data_unit_num;
> @@ -430,7 +434,7 @@ struct ufs_clk_scaling {  struct ufs_event_hist {
>         int pos;
>         u32 val[UFS_EVENT_HIST_LENGTH];
> -       ktime_t tstamp[UFS_EVENT_HIST_LENGTH];
> +       u64 tstamp[UFS_EVENT_HIST_LENGTH];
>         unsigned long long cnt;
>  };
>=20
> @@ -446,10 +450,10 @@ struct ufs_event_hist {
>   */
>  struct ufs_stats {
>         u32 last_intr_status;
> -       ktime_t last_intr_ts;
> +       u64 last_intr_ts;
>=20
>         u32 hibern8_exit_cnt;
> -       ktime_t last_hibern8_exit_tstamp;
> +       u64 last_hibern8_exit_tstamp;
>         struct ufs_event_hist event[UFS_EVT_CNT];  };
>=20
> --
> 2.31.0

