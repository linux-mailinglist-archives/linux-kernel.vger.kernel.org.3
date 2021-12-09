Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0020A46E309
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhLIHT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:19:26 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63313 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhLIHTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639034153; x=1670570153;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ii4BS2skveN8G6fYGPJjDiB/NDC2oljZKy1d6gPfrcY=;
  b=BOLRp22elQHp6QCDuGdhsfNy04DNDar6UQyxxWAt4kmrLRKOEcHbsal6
   xGklXEV0mIdsh27HJsBmlijN1VTKcFwcPiBbV+dGM1YRzAPVtxpaGYYEE
   5DqYjvn4X6sP3U9FB2qnT4ttolVKWiBHhslS24RiWn8aWDbya/YweW0l1
   fXAEuDJO7vtUO25ZoBXB/TNnoYD5In6vJ4PazUwTBGuNRqg549Dk4SqGj
   gvj0Qog8Octxrl1MR3ujUXe1Y0hgYZ5heU5KpBVEooRJIy/OZSF+sBW/a
   qjb73gU8a9Nv5I4bVM1UL5a6FbnjGmDB08G1fF9m8yaZtEtrb7JCOEAoS
   w==;
X-IronPort-AV: E=Sophos;i="5.88,191,1635177600"; 
   d="scan'208";a="299662018"
Received: from mail-bn8nam08lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 15:15:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpeWwxF1lot/lg7WKZTUx01EHNT8sP1undad2glu/Oedvx2ubsFj/5ohCcfGFsshj3y2DcC83NfaDbr/tQRzq1wN9uMmneBo1WrIPtM4HtuT9uDLt/JU8nc6uPEE3bGHkcw7EipHNLzBLqZA2g1jwIRY6AKsE5TEUDQey+yQ7jvUdt2utv+suC3Svw3J1Rihpsyovl/rFZPGnnr3n0O/xW3Z2P3+/yS6ilPkKBmPK4q3vPdzZZ3VwDIl26R8UB4iGO/rji1leWtcT1YfoK9fcvE+XhVhVxUiuduGLey/eGVsgGMY4tWauLU1y0F5OPBiD+FxJAnIee2ooqlosjtgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2x+dcYdeiHP9zmJcWrmthXcD/rEBQoIdMTciHjIG4g=;
 b=jGAn8I23aIFpxImF+QStL7NR48fzAdmLOfbKF/Vni/iQtBGaqnwznfzsPoGRr9GViLkdgSMzd01Cm+FiS20f/6ibf5cLYD6hTIMrnjTbw7Yzd/kaM26HK9SnOWutJ1FQ3FzuZPyOlOQZwepMGdNbpbl75IlN9CtB1twX7Uy/qloHRpNNE/TYG6T5El8WHnFJIg+nYeUAFiwZL9RxcJmOLkFI/MDPeB/6hfWzMMiDFHaiUEDTbjfacoUhZ0nokcnbrOm9yx30CnPKj+bR0za/6XAjqk+N47iga1FPz3ij3lY6cq/JH5mitA+3cAmbvKDFVXrksuFkKRNPU9SNIbKvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2x+dcYdeiHP9zmJcWrmthXcD/rEBQoIdMTciHjIG4g=;
 b=MXmFtL28vj21uYrhKZsfDF1Nsnyqd6X4mn+oh4M+FYAhh6/a9BJivU9O4cgIP+FPYcol3AVjTLMCb00ZQDl4rcpm7IJS7M7o+Q4EMb/u8gHjCpqOMi54lElVhp5PSoFRR6ujKepWW2aPEFgg+xVUT2YFdVLJa1dLLx6jw7eKvM0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4843.namprd04.prod.outlook.com (2603:10b6:5:2a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Thu, 9 Dec 2021 07:15:50 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::970:e4c6:a13d:7e24]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::970:e4c6:a13d:7e24%4]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 07:15:49 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ricky WU <ricky_wu@realtek.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: rtsx: improve performance for multi block rw
Thread-Topic: [PATCH v2] mmc: rtsx: improve performance for multi block rw
Thread-Index: AQHX7MdClx/1qrLL0EW2L7d2/OA9P6wpvXWA
Date:   Thu, 9 Dec 2021 07:15:49 +0000
Message-ID: <DM6PR04MB6575ACDAAC828B9174FBB1B6FC709@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1d97432a46a4467bb8e0a4fa5a7bdf6e@realtek.com>
In-Reply-To: <1d97432a46a4467bb8e0a4fa5a7bdf6e@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 974438aa-6b35-4d0f-0531-08d9bae3ba8e
x-ms-traffictypediagnostic: DM6PR04MB4843:EE_
x-microsoft-antispam-prvs: <DM6PR04MB484315C293E0EEE8CCB73F5BFC709@DM6PR04MB4843.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pFdsY6EUdWarRGtaGfzcfHcMJnMJai3LDXmnsjzl4bJK7LAo2J0K+z9D1BK9T+WwYDABcCRrM+SVUF9000fy6wyJnG5fSuqbndU6U/+uwx1JcnJKOHZJ6Gg4Nb2IxaPc94fVebdcHelBSkOJfJkxtrhKUoT7tWoC2316AdEN+y1B5zZO+7Lr65tvEs2/YE1fEjEQXi1Y+3S9VG3fzfEQ57WZDJ23uEdzD5eV5T1txjdhOpLVRd8SWLirr4QY+c1cnYq7fXlMwOTX+OhMpEJZziZ9pUbtvnsA5CHF/neIucH/cBi2SZ94oQs/7FW91j4ocmjPHykiB2xAgKqDH1XmSzEOZ8zQx8d46EkF5O/W2Qz5j2N6GLoBZk4+xbIB5fKDGPZaaTrAnuOr9AKTaV9pky6gFQ7C0mt1fCTWaoE34CIN9nCPpM9Dy1FOXw4HT69cCIgP5rKRGE9jEkIhZBqEwdyk8FXP/mufJ9Fo/Jt1aruuv7r8oAWTkgt0fMFkYxl2OXIZSXxv7b2oeWj1YO0ulLLop7SF3cvksSNJwNzmC3h48Y+GiEa5e7DIhNXCRny2r2vy62OtB8qVTfuYArkP5oUGXBHys6gnPELbcF6dP75nVIi5laXFZLq4rLw0zh8+wmovDKIRXTr62z7Z4799vgom+Gp4PL+1MgiT/kABJooS1pPxcouyjhikNi/IZU6qJHhpZMHw5s5rxpv1fmP2xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(82960400001)(38070700005)(316002)(52536014)(71200400001)(38100700002)(122000001)(110136005)(2906002)(9686003)(55016003)(26005)(186003)(5660300002)(86362001)(508600001)(6506007)(7696005)(83380400001)(8676002)(8936002)(33656002)(66556008)(64756008)(66446008)(66476007)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pwIU9Ql3LhVRhArlkgc4LtaR3+/6Fj3DIkub5RwY1M58wVe9Z802uIh3WC+5?=
 =?us-ascii?Q?tKnVfPsI6lfXtExnVfY/fBC0uOn0udR9vdfTUW43JX1dPSPuz6InOciGyQls?=
 =?us-ascii?Q?o6EH9vBA7kqK+KBWTYNcBbgSVMbYbjYrkTAO0HlPBNycl/KpGOSFp5ulaMsS?=
 =?us-ascii?Q?LAyDC0hjc6a7zfqw/RcUonjSD6jn4X4H80fIp+sgWH8ijAjwQmoGiS+b98ck?=
 =?us-ascii?Q?Xcz76TK93BtoyHQVl1XHMJF1feI2gEI0wF+pYalO/neSBKed/dGHV6hmwnQN?=
 =?us-ascii?Q?oivIewREVjOI5y89sC8YyvZytZJ3ua0+idMDiXhmk3MQ2IAMMP4OeKpZApwE?=
 =?us-ascii?Q?ROV6pYzkAxX7DFLNxCd1nUUFKybmP+9Pp+7z9xd9tpwgvCB0iXulbrUsDGmX?=
 =?us-ascii?Q?U0Rba0LsbqDH8G4O1EZkKE1eoT43G2xnNDDTwXfzfzAeMzb7Q3Psb0I6MYE/?=
 =?us-ascii?Q?IB41XT4zNjD6Z6jYvjjOhfdQB5yf0tV/fft+IWz/1o/jGupfC4SDwSJz73+9?=
 =?us-ascii?Q?HJ3m/gg1JBNCV2j2d423sbiACN6SqtKrPcNwt+cyrN8kNHpzRQDgwriy6ifJ?=
 =?us-ascii?Q?ta+ECiSg6bJPI0ktLuUu5rP6Id+xQLBfVY5rqyRluj3h8o89amvjO3mnxj52?=
 =?us-ascii?Q?A/eIbN3DXyAsCNm6fN0e/h5MytxiHwWLaKeGnOa1i9WVzqn+x22nS5Yn7Hef?=
 =?us-ascii?Q?tk/a027NJB6tBzf8BLCQ/YaZ/ZZKEuvvPrjYBYTU5FoL/fN6e+BtZ0PJ6qQK?=
 =?us-ascii?Q?faVZf3fZt899zyN19TullDtzD9xvz3wT7+gPKzSfRbnjV/5yIwNj+1Hj0Su4?=
 =?us-ascii?Q?c7nlLlKhD2jG+eJbOA9Pz6CBrJF6jqDYp+pqw2EzONP3A6AIe2AiW5KikCPV?=
 =?us-ascii?Q?MJpu2LQ+gRCqmwxGQb/cG1eIGreSpos1JDReADt6yn1HmMzVgDAyW41V3Z4g?=
 =?us-ascii?Q?FO4zxwKDxPCKE/VwpUsycER8+yrsbeuJMYomui1WRxAvJN60YP5jJiKnmnig?=
 =?us-ascii?Q?WW5u3SwFdb+L3XmupF881uexEapCWmiiqi410xOIw/I7zWPmj7PblABjNzQ4?=
 =?us-ascii?Q?ESoyJSHbDLLhAx6zXbLlmxP8OM/8M9lOoplyvs2skC2p7zdduv4JHCswBXZS?=
 =?us-ascii?Q?m+an6JBZGWfmqmnd1o3teSJsGrN7yvn1jzRkK9hZT/kf5H647B8pSOxJTVsR?=
 =?us-ascii?Q?2rNXnLKgHrbVV9GI0N0XRwd7dW+k71ur8MwV8omqkoHNTj4W2Eut9AYEraSA?=
 =?us-ascii?Q?7MLfjEkYAcqRjE81xRDTbZqZifKiX57GSfl5yNXaJyRY0Jt7EOfGB76u7TaO?=
 =?us-ascii?Q?TNdvcSKUL5NSKCeSsGJIPRTFKDZVai76Q4TagWFc00NXQbFqXWaAlml6/evv?=
 =?us-ascii?Q?T/JqUBfATBUEpaOJdOChbXY1+gZ+qqH/bI0Th20zixaL8q5sQhhJwuNNCUq+?=
 =?us-ascii?Q?4DsaZb91hzxGRlcXfOzXnRlvN4Fnhw5IQO2Rgo9/m75AjUyNI+kiF5cSAzbD?=
 =?us-ascii?Q?j/eicxAaz4Iyh8iGAGh8hTXVV3VZR0c5PaNcBOAiQLQMPzs5fR+Gmtc705ys?=
 =?us-ascii?Q?e4jQQGoJ4mu3ovdrREZAmXHAQfcdpo1iZicA4KkcnPVPt5SE4R+TKGsK9wvc?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974438aa-6b35-4d0f-0531-08d9bae3ba8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 07:15:49.8598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fEYyhQIjBTo4KMkwxWP7W4lVE8YGxWt/Vf4TlVN+vC6A8xL4vSvWHnC8H59WHGUtWkb18Z0fzhz8MjJhrHtVjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4843
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20
> Improving performance for the CMD is multi-block read/write
> and the data is sequential.
> sd_check_multi_seq() to distinguish multi-block RW (CMD 18/25)
> or normal RW (CMD 17/24) if the CMD is multi-block and the data is
Normal =3D=3D single ?

> sequential then call to sd_rw_multi_seq()
>=20
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
You are not sharing the performance improvement of this patch.
I would hardly expect any, because as you probably know,
SD/mmc devices are very good in detecting sequential read,
fetching the next data block beforehand.=20

> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 185 +++++++++++++++++++++++++++++-
>  1 file changed, 180 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 58cfaffa3c2d..ee2b0eec6422 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -22,6 +22,8 @@
>  #include <asm/unaligned.h>
>  #include <linux/pm_runtime.h>
>=20
> +enum RW_MODE   {NORMAL_RW, SEQ_RW};
> +
>  struct realtek_pci_sdmmc {
>         struct platform_device  *pdev;
>         struct rtsx_pcr         *pcr;
> @@ -31,6 +33,7 @@ struct realtek_pci_sdmmc {
>=20
>         struct work_struct      work;
>         struct mutex            host_mutex;
> +       struct delayed_work             rw_idle_work;
>=20
>         u8                      ssc_depth;
>         unsigned int            clock;
> @@ -46,6 +49,12 @@ struct realtek_pci_sdmmc {
>         s32                     cookie;
>         int                     cookie_sg_count;
>         bool                    using_cookie;
> +
> +       enum RW_MODE            rw_mode;
> +       u8              prev_dir;
> +       u8              cur_dir;
> +       u64             prev_sec_addr;
> +       u32             prev_sec_cnt;
>  };
>=20
>  static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *i=
os);
> @@ -226,6 +235,14 @@ static void sd_send_cmd_get_rsp(struct
> realtek_pci_sdmmc *host,
>         dev_dbg(sdmmc_dev(host), "%s: SD/MMC CMD %d, arg =3D 0x%08x\n",
>                         __func__, cmd_idx, arg);
>=20
> +       if (cmd_idx =3D=3D MMC_SEND_STATUS && host->rw_mode =3D=3D SEQ_RW=
) {
> +               cmd->resp[0] =3D R1_READY_FOR_DATA | (R1_STATE_TRAN << 9)=
;
> +               goto out;
> +       }
> +
> +       if (!mmc_op_multi(cmd->opcode))
> +               host->rw_mode =3D NORMAL_RW;
> +
>         rsp_type =3D sd_response_type(cmd);
>         if (rsp_type < 0)
>                 goto out;
> @@ -542,6 +559,93 @@ static int sd_write_long_data(struct
> realtek_pci_sdmmc *host,
>         return 0;
>  }
>=20
> +static int sd_rw_multi_seq(struct realtek_pci_sdmmc *host, struct
> mmc_request *mrq)
> +{
> +       struct rtsx_pcr *pcr =3D host->pcr;
> +       struct mmc_host *mmc =3D host->mmc;
> +       struct mmc_card *card =3D mmc->card;
> +       struct mmc_data *data =3D mrq->data;
> +       int uhs =3D mmc_card_uhs(card);
> +       u8 cfg2;
> +       int err;
> +       size_t data_len =3D data->blksz * data->blocks;
> +
> +       cfg2 =3D SD_NO_CALCULATE_CRC7 | SD_CHECK_CRC16 |
> +               SD_NO_WAIT_BUSY_END | SD_NO_CHECK_CRC7 | SD_RSP_LEN_0;
> +
> +       if (!uhs)
> +               cfg2 |=3D SD_NO_CHECK_WAIT_CRC_TO;
> +
> +       rtsx_pci_init_cmd(pcr);
> +       sd_cmd_set_data_len(pcr, data->blocks, data->blksz);
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, IRQSTAT0,
> +                       DMA_DONE_INT, DMA_DONE_INT);
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMATC3,
> +               0xFF, (u8)(data_len >> 24));
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMATC2,
> +               0xFF, (u8)(data_len >> 16));
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMATC1,
> +               0xFF, (u8)(data_len >> 8));
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMATC0, 0xFF, (u8)data_len);
> +
> +       if (host->cur_dir =3D=3D DMA_DIR_FROM_CARD)
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMACTL,
> +                       0x03 | DMA_PACK_SIZE_MASK,
> +                       DMA_DIR_FROM_CARD | DMA_EN | DMA_512);
> +       else
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMACTL,
> +                       0x03 | DMA_PACK_SIZE_MASK,
> +                       DMA_DIR_TO_CARD | DMA_EN | DMA_512);
> +
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_DATA_SOURCE,
> +                       0x01, RING_BUFFER);
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_CFG2, 0xFF, cfg2);
> +
> +       if (host->cur_dir =3D=3D DMA_DIR_FROM_CARD)
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
> +                               SD_TRANSFER_START | SD_TM_AUTO_READ_3);
> +       else
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
> +                               SD_TRANSFER_START | SD_TM_AUTO_WRITE_3);
> +
> +       rtsx_pci_add_cmd(pcr, CHECK_REG_CMD, SD_TRANSFER,
> +                       SD_TRANSFER_END, SD_TRANSFER_END);
> +       rtsx_pci_send_cmd_no_wait(pcr);
> +
> +       if (host->cur_dir =3D=3D DMA_DIR_FROM_CARD)
> +               err =3D rtsx_pci_dma_transfer(pcr, data->sg, host->sg_cou=
nt, 1, 10000);
> +       else
> +               err =3D rtsx_pci_dma_transfer(pcr, data->sg, host->sg_cou=
nt, 0, 10000);
> +
> +       if (err < 0) {
> +               sd_clear_error(host);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sd_stop_rw_multi_seq(struct realtek_pci_sdmmc *host, struct
> mmc_request *mrq)
> +{
> +       struct rtsx_pcr *pcr =3D host->pcr;
> +       struct mmc_command *cmd;
> +
> +       cmd =3D kzalloc(sizeof(*cmd), GFP_KERNEL);
> +
> +       cmd->opcode =3D MMC_STOP_TRANSMISSION;
> +       cmd->arg =3D 0;
> +       cmd->busy_timeout =3D 0;
> +       if (host->cur_dir =3D=3D DMA_DIR_FROM_CARD)
> +               cmd->flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +       else
> +               cmd->flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC=
;
> +       sd_send_cmd_get_rsp(host, cmd);
> +       udelay(50);
> +       rtsx_pci_write_register(pcr, RBCTL, RB_FLUSH, RB_FLUSH);
> +       kfree(cmd);
> +       return 0;
> +}
> +
>  static inline void sd_enable_initial_mode(struct realtek_pci_sdmmc *host=
)
>  {
>         rtsx_pci_write_register(host->pcr, SD_CFG1,
> @@ -796,6 +900,45 @@ static inline int sd_rw_cmd(struct mmc_command
> *cmd)
>                 (cmd->opcode =3D=3D MMC_WRITE_BLOCK);
>  }
>=20
> +static void sd_rw_idle_work(struct work_struct *work)
> +{
> +       struct delayed_work *dwork =3D to_delayed_work(work);
> +       struct realtek_pci_sdmmc *host =3D container_of(dwork,
> +                       struct realtek_pci_sdmmc, rw_idle_work);
> +       struct mmc_command *cmd;
> +
> +       cmd =3D kzalloc(sizeof(*cmd), GFP_KERNEL);
> +
> +       cmd->opcode =3D MMC_STOP_TRANSMISSION;
> +       cmd->arg =3D 0;
> +       cmd->busy_timeout =3D 0;
> +       if (host->cur_dir =3D=3D DMA_DIR_FROM_CARD)
> +               cmd->flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +       else
> +               cmd->flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC=
;
> +
> +       sd_send_cmd_get_rsp(host, cmd);
> +       host->rw_mode =3D NORMAL_RW;
> +       kfree(cmd);
> +}
> +
> +static int sd_check_multi_seq(struct realtek_pci_sdmmc *host, struct
> mmc_request *mrq)
Looks like you meant this to return a Boolean?

Thanks,
Avri

> +{
> +       struct mmc_command *cmd =3D mrq->cmd;
> +       struct mmc_data *data =3D mrq->data;
> +
> +       if (!mmc_op_multi(cmd->opcode))
> +               return 0;
> +
> +       if (host->prev_dir !=3D host->cur_dir)
> +               return 0;
> +
> +       if ((host->prev_sec_addr + host->prev_sec_cnt) !=3D data->blk_add=
r)
> +               return 0;
> +
> +       return 1;
> +}
> +
>  static void sd_request(struct work_struct *work)
>  {
>         struct realtek_pci_sdmmc *host =3D container_of(work,
> @@ -841,12 +984,36 @@ static void sd_request(struct work_struct *work)
>         if (!data_size) {
>                 sd_send_cmd_get_rsp(host, cmd);
>         } else if (sd_rw_cmd(cmd) || sdio_extblock_cmd(cmd, data)) {
> -               cmd->error =3D sd_rw_multi(host, mrq);
> -               if (!host->using_cookie)
> -                       sdmmc_post_req(host->mmc, host->mrq, 0);
> +               /* Check multi-block and seq function*/
> +               if (data->flags & MMC_DATA_READ)
> +                       host->cur_dir =3D DMA_DIR_FROM_CARD;
> +               else
> +                       host->cur_dir =3D DMA_DIR_TO_CARD;
> +
> +               if (host->rw_mode =3D=3D SEQ_RW) {
> +                       cancel_delayed_work(&host->rw_idle_work);
> +                       if (!sd_check_multi_seq(host, mrq)) {
> +                               sd_stop_rw_multi_seq(host, mrq);
> +                               host->rw_mode =3D NORMAL_RW;
> +                       }
> +               }
> +
> +               if (host->rw_mode =3D=3D SEQ_RW)
> +                       cmd->error =3D sd_rw_multi_seq(host, mrq);
> +               else {
> +                       if (mmc_op_multi(cmd->opcode))
> +                               host->rw_mode =3D SEQ_RW;
> +                       cmd->error =3D sd_rw_multi(host, mrq);
> +                       if (!host->using_cookie)
> +                               sdmmc_post_req(host->mmc, host->mrq, 0);
> +               }
> +
> +               if (cmd->error)
> +                       host->rw_mode =3D NORMAL_RW;
> +
> +               if (mmc_op_multi(cmd->opcode) && host->rw_mode =3D=3D SEQ=
_RW)
> +                       mod_delayed_work(system_wq, &host->rw_idle_work,
> msecs_to_jiffies(150));
>=20
> -               if (mmc_op_multi(cmd->opcode) && mrq->stop)
> -                       sd_send_cmd_get_rsp(host, mrq->stop);
>         } else {
>                 sd_normal_rw(host, mrq);
>         }
> @@ -867,6 +1034,11 @@ static void sd_request(struct work_struct *work)
>         }
>=20
>         mutex_lock(&host->host_mutex);
> +       if (sd_rw_cmd(cmd) || sdio_extblock_cmd(cmd, data)) {
> +               host->prev_dir =3D host->cur_dir;
> +               host->prev_sec_addr =3D data->blk_addr;
> +               host->prev_sec_cnt =3D data->blocks;
> +       }
>         host->mrq =3D NULL;
>         mutex_unlock(&host->host_mutex);
>=20
> @@ -1457,6 +1629,7 @@ static void rtsx_pci_sdmmc_card_event(struct
> platform_device *pdev)
>         struct realtek_pci_sdmmc *host =3D platform_get_drvdata(pdev);
>=20
>         host->cookie =3D -1;
> +       host->rw_mode =3D NORMAL_RW;
>         mmc_detect_change(host->mmc, 0);
>  }
>=20
> @@ -1487,6 +1660,7 @@ static int rtsx_pci_sdmmc_drv_probe(struct
> platform_device *pdev)
>         host->cookie =3D -1;
>         host->power_state =3D SDMMC_POWER_OFF;
>         INIT_WORK(&host->work, sd_request);
> +       INIT_DELAYED_WORK(&host->rw_idle_work, sd_rw_idle_work);
>         platform_set_drvdata(pdev, host);
>         pcr->slots[RTSX_SD_CARD].p_dev =3D pdev;
>         pcr->slots[RTSX_SD_CARD].card_event =3D rtsx_pci_sdmmc_card_event=
;
> @@ -1526,6 +1700,7 @@ static int rtsx_pci_sdmmc_drv_remove(struct
> platform_device *pdev)
>                 pm_runtime_disable(&pdev->dev);
>         }
>=20
> +       cancel_delayed_work_sync(&host->rw_idle_work);
>         cancel_work_sync(&host->work);
>=20
>         mutex_lock(&host->host_mutex);
> --
> 2.25.1
