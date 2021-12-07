Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D5946B5F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhLGIcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:32:16 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2352 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhLGIcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638865724; x=1670401724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EeOzc36EkHQiRP2HM65dBku9/vlUuu/GuAPxUsuwj3E=;
  b=WktBi4YDSt90UurzrVy86lmfvyt4TeT69pQjVQAFDpBwMY6DJ+ZK5QNo
   JF7kit08BuZsdSjR6TJPrd8ZkTQNEf7bHg/+u5aRzjuuyqT0pxxXV3hEb
   npTOEOkMQlsGzUfP/7CcQ4cTOpGeAgaNAGVaPpaPaIIEsKF/TPZQyc6pk
   CG02MDeo9TLT9lShwtG2CHjrHROvMgyIkM7mTorzwp6U9KZL/LT0jaAgY
   mpWLQZIQ51Fs6/kMWUs4cArJYyG1HdkPg7Aohg7SeuTYVCcF5d6aNa4Nv
   6YqCBbDwLMPeGBuDJGk8wXckUjolSQyMV9rn1KeeXG96/vyAjHvZ6+woc
   w==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631548800"; 
   d="scan'208";a="192415249"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2021 16:28:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuOIW1beS4I/2aeYXrP3QtgK/NV6mcqsCzT5q1EsZ/dIl1KQzWk/2w0Ew37G8Rj96/4rh8CkutRxJXLITWOh/lYgVvJDyaqjoc7dWTMAfE/j2tskjcWQOExnmN1Ia0s8vJJmfFDuuuInfqgMMLVzOeOnOQ1ixvCI694KPY89v/VjtkaLKTz4jsH63PMF0f11Gr191QLTCRWqWPbnwTgm8BXThjFO6nePGKUE9pUpx+evbaqAAIVssOE8sEiwIUxwQUmDEHDDKxxeD6jkl39+Td/7rjDWVbN0YhySvftMog2bDLQ6RtZUj/9O/zw2WRADx7ZIsaerhgmoi9lJXKrupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8kmCYrZuBoVuK78K5fbbzY9QDS4sfCgRXW12yIqvRo=;
 b=XlNpz82p1+r2ueM64s6AadbIqr6u1bNtWwTAYXe3w6gVKwtv8FKm0InALEZNgBz0ruGlWptk2B09VtopTkTdOaea7BJXj7wnuDmsscUp1vfxSA91WQFVeyw3HVIajI/+29M2vBE+weYRah8o6Dga1nrCgUeK6+sqDunamTU+YryfDeIjzsLn54l9yjAKZLPC0lh3uayvn+k468yJ/i2YIDgdC8+i+bjxqLbHlEa1pUFtIR6Tgia+FKuIhW9OAgO6cAJFKZJekInZd3rf/fz0g0tyz6WB+BHDrI/1xjb08mUJVkEjkU/2ZYq1YRPTJhPT522EmPuNSZOQXO/JTfEDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8kmCYrZuBoVuK78K5fbbzY9QDS4sfCgRXW12yIqvRo=;
 b=HrN5vqKz2g1fAxiZT1LQ7GaTlcEZfpYsN4OPlIPfvZfK63xCfgq1b/GErCMGuRKPyzLocgpNx/oIJEbG09Vm8DrKikUpCIFVINvPq36AOVwwR/1h09fnSan/x69Fe25zNRNn8LXA+Hf4axWDeco06Q0u8G8JtDuGzyaankXXEyM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM5PR04MB0732.namprd04.prod.outlook.com (2603:10b6:3:100::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16; Tue, 7 Dec 2021 08:28:42 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::970:e4c6:a13d:7e24]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::970:e4c6:a13d:7e24%4]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 08:28:42 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Huijin Park <huijin.park@samsung.com>,
        Yue Hu <huyue2@yulong.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Add support for the eMMC RTC feature in
 mmc_ops
Thread-Topic: [PATCH] mmc: core: Add support for the eMMC RTC feature in
 mmc_ops
Thread-Index: AQHX6gvX/BT/iVXcEEKk0MhaGQh9w6wms6wQ
Date:   Tue, 7 Dec 2021 08:28:42 +0000
Message-ID: <DM6PR04MB657527FCF325EA9760032DA5FC6E9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20211205191009.32454-1-nishadkamdar@gmail.com>
In-Reply-To: <20211205191009.32454-1-nishadkamdar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82fb5448-b0f7-4c61-e24f-08d9b95b93e3
x-ms-traffictypediagnostic: DM5PR04MB0732:EE_
x-microsoft-antispam-prvs: <DM5PR04MB0732A70BBF99AEBD48BCAC2FFC6E9@DM5PR04MB0732.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +CoH2liAxfvcmE3m10VP+U98uMIOoUFWBS8zcMUHYvVkOXgzqBbwTz1J4W8NDq3r1B3ghDXNkTM4TWCIazLoYE1HBp0ukD3C/TRynKpqTf5Cp44MRlkDe5QNh4DPWWIIUsIpygRcCmypg5d74DzzXvxQBK7/IRVyplbdwK44NTiwlk43rlnPYMRK7wtSqR7zCQXb9o1GA/tXsayu6g/6Kpn+VAblnFuJ4/zGwxVX1lceSIf6N296I1zG18gJVMfEe5Vim02DaWnFPOt4lEmasrqWbDRfCW77YLnkKp3DeggZtcypFZ6yC4NuT1ZcmIpHpexaS6S5gw1XFpu15La7j1593ONV17aWskFu/TIiEnPpUDm2NkgH+HAa63S0gfkvNr4y0ltrf2gitYtXP41UsYALStSEaiCoQysJIen5O8giozMxiuWexQy3PLlFHCn3LokQ01HZcPEB90RSOIwz45V8BhiTyl98FrO3jYkuzViIcMxTMg/jbwcGtyFCDgeJMWYLhgD/r/LYZdqozQtq1SxohjmCDonoKslTuQxgQ4yPRm82xzxgWBuIHo8ZSGcmygPl7it4wDi8eYrpDlHmHDFq3nTj4RxZHBwwCSqrEicyENhAro0h8dlg+N2/ijzozz+HnqoeDwVrD8w5sLB7h7DS41If7fuF082IjGAJFTsuJ+TmrhaG6aTyaCb1u3qSg8jmtXaOEiS1wHfdwugcf1mkgCpVXNLzrhi+6Dj068k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(7416002)(7696005)(26005)(921005)(8676002)(316002)(9686003)(5660300002)(82960400001)(54906003)(8936002)(6506007)(508600001)(2906002)(64756008)(110136005)(38100700002)(66556008)(33656002)(4326008)(66476007)(38070700005)(66946007)(55016003)(66446008)(76116006)(83380400001)(122000001)(86362001)(71200400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YIDJXyFMNsGSHaPPkMPg1WxkQ0G3Dqmk3alra97ooRqa8bhzOSYI+b/KxSb/?=
 =?us-ascii?Q?0wp2sROSL+KiJIhb1CRIKNFhmdYpunJ3lr0DSt38wb0tm9Ofu+rE5I+FNN+0?=
 =?us-ascii?Q?quTyW74ked0OhO9NRq3AfEhxAJCQlgv9EQUm3m4I6PfUY0v0Nu9L6qZmXRKK?=
 =?us-ascii?Q?2KgnZV1eQen9o1e+QMn51N4K6kNghI48o2me+LDId/97BGnTNIysxvgV8VPY?=
 =?us-ascii?Q?qZcv6rX1mmAMJbIyg0F1tZwmFHJZmHYXFyfXWXoan3I1YAXW1txnT4B78tXI?=
 =?us-ascii?Q?aD8UCWXMnQSHHnYrW8p3ZGw8awQTffT2lIhREJcBttiwas6NiwCdPsxGonko?=
 =?us-ascii?Q?cdr6yxvcaCRnyOkxhaYXlJz4XEC/XBZVjDqH7it4V7zIzXac84eNWyHXz3pf?=
 =?us-ascii?Q?0ngqJ/gkigdbheQQhB6kUWw+yCryQnxukba7/lmgDGY7Ow5wP1V8J4AHH+Wi?=
 =?us-ascii?Q?2wzwMbdCWPtUd6XAfQjYPdl4WpaMBrGZxZpoxccTmF4T9RxmBOCihliC429A?=
 =?us-ascii?Q?FRt3eh8IMdrNfIRs2KCvhzb+zTeiEm9/JNkStL2GPlZVCtqKle0hrXvYwrdG?=
 =?us-ascii?Q?oS4V78Me7zvO+a+ID8dgXyDYzft2B4YsGk4Eh4SWB94suu7b/Os26YvpGmbZ?=
 =?us-ascii?Q?NrOGQsSwSbERtnpysyHf+NrcSR7FFnns5Y0r4fMPr0yY9Fzju/UaiT0s0ukT?=
 =?us-ascii?Q?MfM1JqmNLcYU9D1U8bSrsmuETj2Fmhk6Oc/D/PnAtCSPRfjfJyiTgyL6W/kj?=
 =?us-ascii?Q?ghW3CXRtBlLzLK2UNN7Laf7Wq6BMUu6DkXcil9P1XAIijzi1fElMh9uSyfNN?=
 =?us-ascii?Q?r7yMOBEA7P2frY3kYUtr5RcAHCS3ZuTKcdNiaEC7VEatiyg9eb0J/xdDccC0?=
 =?us-ascii?Q?mHPZa4lEcBTFCCBYhGQd0CTHzz91RFA1KbKXHpUcjXrMPAXGRiIr4ef93PNN?=
 =?us-ascii?Q?CRvxZo01J/zTlpNgxsoHX/7zZdEyeVoTbps1tPRaqwysUtS8MEp3hQOI0fKI?=
 =?us-ascii?Q?QhTzV7fTSN6M1dNHbjL1RefI72nAEIZ1O9UF3GFUvXReVf4ZUxR3WxXIjdIy?=
 =?us-ascii?Q?rsQ8+8FLadMDHcCMEpzCe+2SZ0VaB/OSwxdZEEOirfKODRHdxES08lLIeQL6?=
 =?us-ascii?Q?rJ9TsQB+cTvF+EOMuBqvsI9U/uXmrUrWYhOunNEj6sAcGlymudIn0L9tMIVo?=
 =?us-ascii?Q?G7etbsMbA3LPaiq0o6EBmwep1GU9P74Pwr7sLbLyDKyCvzNhu5G6jbFRK3Rz?=
 =?us-ascii?Q?plbPiqoKtCAWxunGjr8f9BRCC9zJnkGEmvwfRaxSK3RdIc1YyuB/Nc71ENLb?=
 =?us-ascii?Q?gabsx81wBbvvbzLW6MiLa6TKq4RTwLr/aNOq0rhj9OIXU1XCyyeo9SD2XL0C?=
 =?us-ascii?Q?z2cXHVUJMUvhMrp6+gNMZay9WLjkYSTxNaXzPUkwM6wDMZRyyYrsR6monKA0?=
 =?us-ascii?Q?gHMBFS7vDMD9vNQXoq3Br4oau7dg4ZM1CIzpZ0nefjP0YYxApBvsGVvuNGfd?=
 =?us-ascii?Q?BhTfHi6/KX3XAm4rF5heBEUcx9xcOAPXdmFK01FOic+pCIpOb1f9i6X6AyWh?=
 =?us-ascii?Q?kgs2/qkOkKgyNr39PLDgUoEf8gsGp/NQZ/yIccyOfg0kLvqvvx9XpSvCCJVX?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fb5448-b0f7-4c61-e24f-08d9b95b93e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 08:28:42.2577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLo1rbIIUgUfdB0MWnFYnJt503GfYHH9wiwybEQpI63Ok9UOx04PBWUVdrZpP+54RroEFJFseE9R8TJyYzq3SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0732
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> This patch adds support to set the RTC information in
> the eMMC device. This is based on the JEDEC specification.
>=20
> There is no way however, to read the RTC time from the
> device. Hence we rely on the response of the CMD49 to
> confirm the completion of the operation.
>=20
> This patch has been tested successfully with the ioctl
> interface. This patch has also been tested suceessfully
> with all the three RTC_INFO_TYPEs.
If this is triggered from user-space via ioctl anyway,
Why do we need this command to be implemented in the kernel?
Why not just add this to mmc-utils?

Thanks,
Avri

>=20
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/mmc/core/mmc_ops.c | 59
> ++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/mmc_ops.h |  2 ++
>  include/linux/mmc/mmc.h    |  1 +
>  3 files changed, 62 insertions(+)
>=20
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index d63d1c735335..490372341b3b 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -1063,3 +1063,62 @@ int mmc_sanitize(struct mmc_card *card,
> unsigned int timeout_ms)
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(mmc_sanitize);
> +
> +int mmc_set_time(struct mmc_card *card, struct mmc_host *host,
> +                u8 rtc_info_type, u64 seconds)
> +{
> +       struct mmc_request mrq =3D {};
> +       struct mmc_command cmd =3D {};
> +       struct mmc_data data =3D {};
> +       struct scatterlist sg;
> +       int err =3D 0;
> +       u8 *data_buf;
> +
> +       data_buf =3D kzalloc(512, GFP_KERNEL);
> +       if (!data_buf)
> +               return -ENOMEM;
> +
> +       if (rtc_info_type =3D=3D 0x01 || rtc_info_type =3D=3D 0x02 ||
> +           rtc_info_type =3D=3D 0x03) {
> +               data_buf[0] =3D 0x01;
> +               data_buf[1] =3D rtc_info_type;
> +               memcpy(&data_buf[2], &seconds, sizeof(u64));
> +       } else {
> +               pr_err("%s: invalid rtc_info_type %d\n",
> +                      mmc_hostname(host), rtc_info_type);
> +               kfree(data_buf);
> +               return -EINVAL;
> +       }
> +
> +       mrq.cmd =3D &cmd;
> +       mrq.data =3D &data;
> +
> +       cmd.opcode =3D MMC_SET_TIME;
> +       cmd.arg =3D 0;
> +       cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> +
> +       data.blksz =3D 512;
> +       data.blocks =3D 1;
> +       data.flags =3D MMC_DATA_WRITE;
> +       data.sg =3D &sg;
> +       data.sg_len =3D 1;
> +       sg_init_one(&sg, data_buf, 512);
> +
> +       mmc_set_data_timeout(&data, card);
> +
> +       mmc_wait_for_req(host, &mrq);
> +
> +       if (cmd.error) {
> +               err =3D cmd.error;
> +               goto out;
> +       }
> +
> +       if (data.error) {
> +               err =3D data.error;
> +               goto out;
> +       }
> +out:
> +       kfree(data_buf);
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(mmc_set_time);
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 9c813b851d0b..0c8695d1b363 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -55,6 +55,8 @@ void mmc_run_bkops(struct mmc_card *card);
>  int mmc_cmdq_enable(struct mmc_card *card);
>  int mmc_cmdq_disable(struct mmc_card *card);
>  int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms);
> +int mmc_set_time(struct mmc_card *card, struct mmc_host *host,
> +                u8 rtc_info_type, u64 seconds);
>=20
>  #endif
>=20
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index d9a65c6a8816..52a3bf873d50 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -64,6 +64,7 @@
>  #define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
>  #define MMC_PROGRAM_CID          26   /* adtc                    R1  */
>  #define MMC_PROGRAM_CSD          27   /* adtc                    R1  */
> +#define MMC_SET_TIME            49   /* adtc                    R1  */
>=20
>    /* class 6 */
>  #define MMC_SET_WRITE_PROT       28   /* ac   [31:0] data addr   R1b */
> --
> 2.17.1

