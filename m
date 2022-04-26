Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D898510714
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348551AbiDZSgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiDZSgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:36:53 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD1D44A21;
        Tue, 26 Apr 2022 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650998023; x=1682534023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=17sUipBWUfee0GbO6tPsNvE/Uyx+8SxUoWUtkgWGeaE=;
  b=B1JUInniXl5TNOfBc+9OdDjoogUyZo2xp8uq3voNzfIO/I9Vx1JLmxqZ
   plgJpoJ06K1DauqlfOJ8T/i/oQkmDJvyoeUyuxd3wIZfrqswE9bWmr6SS
   MEv1ZuilUunqhEPSJ7wc4lVZk3B96S1JJGsxkgobiih6SHLS19QX8HVyF
   w06O5dKxi9v5X4OV37nB8wTCG9cKz3/J8KdYXXHuwaQQBSwuF5pObTMon
   QxQvR+uZvps5wQSiY4o1Af9ZignL2HQ+9o5dAwrM+TQ1MBpDdRj6PwUzE
   3Z7lGrFDITpm3mGqgfeMcJYvwx5yJ7JjHKCm/OwgViDBz0KD5vO+9mfay
   A==;
X-IronPort-AV: E=Sophos;i="5.90,291,1643644800"; 
   d="scan'208";a="203749327"
Received: from mail-bn1nam07lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 02:33:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQM4nq8Yv64E7kwYwWS9oFk4JxX6sr5ka50OV/DGbF/oHE3G67fOMNvl19to11axZPdsqlVmuyBucs4e2tpJAkx4L+CITw4xGA48JbMFNelBsCjXyt/5BvrJEwPmCrghxaxGNisUmsuasc4TbfYjnzFNsYHWDJIKxnU8ZfSB+zv+AtSaaCD8sVwcIqzhU4PxybItRAcEreopvg6QMt4EmQRF7k0bF1hOmw8I9m+lHdhHH/icBDZ0EsYd6fYyVrbOEfvEOYX8cbaai9h8pL3IvrGp+dUVpp7fB0jlIgaLPevfXl191LOTyQ7EtSlDtPdaIdzhj1AkhYCyKG/rFtP92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMpK5/WcJO8yvQdmSZ9AUioLB2k2Bb26GyjEQXOshHY=;
 b=NnYPHojx7NZ4QjljoStP2/QSdADeb7RmGaqiuIh2KLdIOnJ5J0KFvG9YkNu9qPqy8aJN/kYhn37g9bh6n7eS6fQN5GC0pATT0ZGCH1GK8yYwMuNjPBZUukeGSVznYP/kdALydK/sPGE+Td4x6zJRIn/gkrCO+UyR5g0KrvhoZQh08by425K9S2CL009brYuDCcbzqj/4xphaLlJDiThNtR84HdVNu8GigRV6im5WDvZHZdfNbEBfe+9+6WRxK4zZnOdmhqoOmD02I22RiOYZsit8f7nqbrk1XCjGgEyga3EJ+KtvRQcS6B9TSPXTVa6c0vNtwABcQBQM8yj2EKaWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMpK5/WcJO8yvQdmSZ9AUioLB2k2Bb26GyjEQXOshHY=;
 b=xKJgPt7Ecj1Ty5pS/aeu4T4wTsI9GHz4K9KS/qoUy1j++PSQbZzrChcShVEIyWkIPk50p0JJGZ/DD4PZGqLbchjG4jZY+vswc+4tprW5ASzpW6i6X0V64ZOuzrJROrcAIPovdUrriNw6Z4HvZUdU7h4VR0VLw4ttbvvjeIEBDkc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MWHPR0401MB3546.namprd04.prod.outlook.com (2603:10b6:301:80::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 18:33:38 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3%3]) with mapi id 15.20.5206.012; Tue, 26 Apr 2022
 18:33:38 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Srinivasarao Pathipati <quic_spathi@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "merez@codeaurora.org" <merez@codeaurora.org>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "huijin.park@samsung.com" <huijin.park@samsung.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kamasali <quic_kamasali@quicinc.com>
Subject: RE: [PATCH V1] mmc: core: Add partial initialization support
Thread-Topic: [PATCH V1] mmc: core: Add partial initialization support
Thread-Index: AQHYWUyoCuEqwcrJJUG+ipv40mEWZq0CDgxg
Date:   Tue, 26 Apr 2022 18:33:38 +0000
Message-ID: <DM6PR04MB6575541A6720A96997653A6CFCFB9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
In-Reply-To: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d41f3669-45af-491d-d794-08da27b347c4
x-ms-traffictypediagnostic: MWHPR0401MB3546:EE_
x-microsoft-antispam-prvs: <MWHPR0401MB3546E7F622C48F5DCBD1E33FFCFB9@MWHPR0401MB3546.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jlX34McLc6pMkO0r1AraTP23bLs6x0SXlpeSyG4WvjBuyZmTT1T3OHmH9dGtME2yUaUPDc1GFAo47I9ISsaOBnGGmiJ9OMptsIzHxz5Nhnj11cY9MREqEDzaMEdjsck90vb0himdS62V4rwBVpIAfSXxNdQ2XpV4wSQyOXWeVio8z7dc1z3IaCj9oZtnGOdQyGpIlVhOpV+DJoSMNPe6D/kk4RlsaJVseQlT/ho7A8+EinOKTqxeeQuwwnd0QZVuGpTyor+4HA7URVjGTWkWkEaf/urlVDYAEG98nCK52a60DoCD/7P8p16bZKONOsyxLzjk72KliZOCbIysZHk8Z2rJDX8G6jkBNgfg+5JpCnLyuNTUOgH3Yh3bHOpmfUfvu+6VxkAZ1+0eIkAqA+6tGwp00pObot76u+25HDLAzk5KzDe/g8CDWIT3ORsYc+h3Jtw9O/y94uxoUcdtucy3JHo/Fb1VabeOH/Sp7TThs+wlzbtUIsUP8HiP1ABiB/NZ1cVv7Ya/8FbCWRjslYtkFcqVz0kfexNoPr76jjLHybMygcgykQk30hBCnLujVWAWnEXs9bCTSlkWzHId3vgb3IwlPiwmmiJ1VQg3chsuys8GGWwyPa+akQOX7euLMX6CMNn4/d9KnW9bk5tLgJ99nD3d6l2gSj4ON43il5JvrOlRYeP3egaaR1LTgAr7mnIfSmo2CPN17V99oi8Ti6GyuFjB59vALUAXwiq/u2q6zJ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(26005)(6506007)(66946007)(66556008)(186003)(7416002)(38100700002)(316002)(2906002)(110136005)(7696005)(9686003)(66476007)(71200400001)(8936002)(86362001)(64756008)(76116006)(82960400001)(66446008)(33656002)(5660300002)(4326008)(8676002)(122000001)(83380400001)(52536014)(921005)(38070700005)(508600001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HO85NmIpqn4Gu5/SkInfHpPo8tppIbgME+COtSVOlcYGrALtQ6KWoKMDE/kf?=
 =?us-ascii?Q?KoF8P2d5speefWPKbw5/kI2W0txfA3eymBvXWd0l93m7eOGknm6sini0s88n?=
 =?us-ascii?Q?BzZoLN5Ktsv7na6EeMbzU0zWQHiK4XnxYYF65LeAkJJOQinzr7bzTopD7Pge?=
 =?us-ascii?Q?mqDkdLEMVi9OJcJM0vGHa9JyT5vqvSoE46KZrk2o0faymVGoKPFUfjjCxrfq?=
 =?us-ascii?Q?fhdtMZkBbMAjRzuGUBH/pqZr7qi/chkesO1zWQ7EOBUCMWC9f8D8cUHxUAyK?=
 =?us-ascii?Q?DV2htUQCR3NflTMjo3Z7CC29nbASUkr69aVpgR/2eYaypK7aklXSpHeWt7J8?=
 =?us-ascii?Q?HE1LPnVt6ThTrgz+srmbIWJRZOQD0QXOkaVlJxi87kfagGbx9x1qa7C6nM/B?=
 =?us-ascii?Q?zuEpUVPCviuO8FV4+J5UYiJvG+j4XlTYi3W8D72jVPoE+eUjT8Tzr/xsgx/b?=
 =?us-ascii?Q?6ja1suLp+6sz8H85IVcvv7k+2B+W/Q8CkqPUSKq/3seyjpOG0kM+K89htWjB?=
 =?us-ascii?Q?CbJPFNof581z36ZQtUUpWD5bWH+QulURZJ8obrpRQO62JfbqljWiZ4urCZfT?=
 =?us-ascii?Q?asPWMIX1CqcP717L5OXkHbCINkfrjF9bRUt3nyxskDy410hnjc72Y5qbIyP7?=
 =?us-ascii?Q?SC3b08dCdlm8h+Oa1fY4M9oDRqbevU8lT9OWtl3dc9MAcIWBxiVVtJ+dVBdZ?=
 =?us-ascii?Q?df+o+XyQjkFGTWj8Y2Nw44VCQ4ZwLwBXFUFIzIp+g9RALrDRbiEVCf3F/VZm?=
 =?us-ascii?Q?LP5wg2HQ9j38udbEOnMGRqp3ImY7iUr2AqgcK5rzjqfPIejQ3ty3f+fxzfQy?=
 =?us-ascii?Q?kKwwmZ6LSjPnwK+VKe+zIjg3fdO/QYGE1qvxdGm+ll7UmHfYQk6k3clN/dSZ?=
 =?us-ascii?Q?3C8jcLiECJSADjONn83vNx5IFNeyadiNVEtvsQ2nMC3Kq9kIGjbHf0kY/qEj?=
 =?us-ascii?Q?tbz+eb7+eo9wSULsZpH684BVG4jZ+QQGSO6SyP39q9GgnsDLkXd6ZpG0tMFM?=
 =?us-ascii?Q?G019WTvycF5JXSv5RhrBpEUlxU8AAfPW9HAFtmqIo6GniJMTLRYMu2caQqNa?=
 =?us-ascii?Q?7FoXOPZk3dpGGtFQSqTpAMasgpXAeCAKMqYSDZCZkej6wUYxGyoWbyrDSBJb?=
 =?us-ascii?Q?gl6NejN2V5V5X5VDLWuTLI6dnhq0ch0ud4kVy/VmNaNrpzBM3RL2dFhpPNM1?=
 =?us-ascii?Q?Ben7AqBEk+/UPCJSZgelN3qRy5chTj+xQo0ZfMTMd5ww+UCE3jJpDP7GUYr1?=
 =?us-ascii?Q?cq6wHiwcs1d+jDnx2NKFSK9gwBD2w02Fq1zS0Q0f+IgNwJhFQ/xeTkDjFZnp?=
 =?us-ascii?Q?7BsL+O8BcQWxkEb5HFg8g818ehAbLbWIFOrzF91d7EEY4bpHdiiWjZMUpd3X?=
 =?us-ascii?Q?cLwrasberFl7LAWY1dIVa3FAV0EkwTr5Ko3s+chlc//h1qsctV2Ve36WzovI?=
 =?us-ascii?Q?2mdyHY69Dn35igp9LRKt/rY/P0vuj57aAN3JIBectfFl/MBn5aiit4llWaRO?=
 =?us-ascii?Q?aJVV9FGrKTgBVYje6CX1PPzX4La+cujhNnawYwLVjxbKS88xFikZTII5Ykdo?=
 =?us-ascii?Q?GMGtayTiVLiDbTKs7+aa9VAp4zAKmN7VncY/o51HCNWF7ZwOSfXgoP2jhqok?=
 =?us-ascii?Q?0ZJuEOS7J31T90s1QArwzP7TfVt6e/DhSG7zq+dn/VM5RfyvJgi63lLNvf56?=
 =?us-ascii?Q?qOkTYmPoI9oOluplb52lbWx4y2fA6212tz0hj6gtbHdQRcmdDqHja8B39MoR?=
 =?us-ascii?Q?KKLR0wSzVw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41f3669-45af-491d-d794-08da27b347c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 18:33:38.2902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/EIWN2MckMbK0MEId/+/Q2F1C+3KPQS3BNBICOt2fSvsy/3wIfHoy1AryaO0/UvnFIfuVdKfDPZwznLRfyxuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3546
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Maya Erez <merez@codeaurora.org>
>=20
> This change adds the ability to partially initialize
> the MMC card by using card Sleep/Awake sequence (CMD5).
> Card will be sent to Sleep state during runtime/system suspend
> and will be woken up during runtime/system resume.
> By using this sequence the card doesn't need full initialization
> which gives time reduction in system/runtime resume path.
>=20
> Signed-off-by: Maya Erez <merez@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> Signed-off-by: kamasali <quic_kamasali@quicinc.com>
> Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
> ---
>  drivers/mmc/core/mmc.c   | 149
> ++++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/mmc/card.h |   4 ++
>  include/linux/mmc/host.h |   2 +
>  3 files changed, 146 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 9ab915b..8691c00 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1942,7 +1942,14 @@ static int mmc_sleep_busy_cb(void *cb_data, bool
> *busy)
>         return 0;
>  }
>=20
> -static int mmc_sleep(struct mmc_host *host)
> +static int mmc_can_sleepawake(struct mmc_host *host)
> +{
> +       return host && (host->caps2 & MMC_CAP2_SLEEP_AWAKE) && host-
> >card &&
> +               (host->card->ext_csd.rev >=3D 3);
Maybe just:
return mmc_can_sleep(host->card) && (host->caps2 & MMC_CAP2_SLEEP_AWAKE);

> +
> +}
> +
> +static int mmc_sleepawake(struct mmc_host *host, bool sleep)
>  {
>         struct mmc_command cmd =3D {};
>         struct mmc_card *card =3D host->card;
> @@ -1953,14 +1960,17 @@ static int mmc_sleep(struct mmc_host *host)
>         /* Re-tuning can't be done once the card is deselected */
>         mmc_retune_hold(host);
>=20
> -       err =3D mmc_deselect_cards(host);
> -       if (err)
> -               goto out_release;
> +       if (sleep) {
> +               err =3D mmc_deselect_cards(host);
> +               if (err)
> +                       goto out_release;
> +       }
>=20
>         cmd.opcode =3D MMC_SLEEP_AWAKE;
>         cmd.arg =3D card->rca << 16;
> -       cmd.arg |=3D 1 << 15;
>         use_r1b_resp =3D mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
> +       if (sleep)
> +               cmd.arg |=3D 1 << 15;
>=20
>         err =3D mmc_wait_for_cmd(host, &cmd, 0);
>         if (err)
> @@ -1982,6 +1992,9 @@ static int mmc_sleep(struct mmc_host *host)
>=20
>         err =3D __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_sleep_busy_=
cb,
> host);
>=20
> +       if (!sleep)
> +               err =3D mmc_select_card(card);
> +
>  out_release:
>         mmc_retune_release(host);
>         return err;
> @@ -2080,6 +2093,66 @@ static int _mmc_flush_cache(struct mmc_host
> *host)
>                         pr_err("%s: cache flush error %d\n",
>                                mmc_hostname(host), err);
>         }
> +       return err;
> +}
> +
> +static int mmc_cache_card_ext_csd(struct mmc_host *host)
> +{
> +       int err;
> +       u8 *ext_csd;
> +       struct mmc_card *card =3D host->card;
> +
> +       err =3D mmc_get_ext_csd(card, &ext_csd);
> +       if (err || !ext_csd) {
> +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
> +                       mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +       /* only cache read/write fields that the sw changes */
> +       card->ext_csd.raw_ext_csd_cmdq =3D ext_csd[EXT_CSD_CMDQ_MODE_EN];
> +       card->ext_csd.raw_ext_csd_cache_ctrl =3D ext_csd[EXT_CSD_CACHE_CT=
RL];
> +       card->ext_csd.raw_ext_csd_bus_width =3D ext_csd[EXT_CSD_BUS_WIDTH=
];
> +       card->ext_csd.raw_ext_csd_hs_timing =3D ext_csd[EXT_CSD_HS_TIMING=
];
> +
> +       kfree(ext_csd);
> +
> +       return 0;
> +}
> +
> +static int mmc_test_awake_ext_csd(struct mmc_host *host)
> +{
> +       int err;
> +       u8 *ext_csd;
> +       struct mmc_card *card =3D host->card;
> +
> +       err =3D mmc_get_ext_csd(card, &ext_csd);
> +       if (err) {
> +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
> +                       mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /* only compare read/write fields that the sw changes */
> +       pr_debug("%s: %s: type(cached:current) cmdq(%d:%d) cache_ctrl(%d:=
%d)
> bus_width (%d:%d) timing(%d:%d)\n",
> +               mmc_hostname(host), __func__,
> +               card->ext_csd.raw_ext_csd_cmdq,
> +               ext_csd[EXT_CSD_CMDQ_MODE_EN],
> +               card->ext_csd.raw_ext_csd_cache_ctrl,
> +               ext_csd[EXT_CSD_CACHE_CTRL],
> +               card->ext_csd.raw_ext_csd_bus_width,
> +               ext_csd[EXT_CSD_BUS_WIDTH],
> +               card->ext_csd.raw_ext_csd_hs_timing,
> +               ext_csd[EXT_CSD_HS_TIMING]);
> +       err =3D !((card->ext_csd.raw_ext_csd_cmdq =3D=3D
> +                       ext_csd[EXT_CSD_CMDQ_MODE_EN]) &&
> +               (card->ext_csd.raw_ext_csd_cache_ctrl =3D=3D
> +                       ext_csd[EXT_CSD_CACHE_CTRL]) &&
> +               (card->ext_csd.raw_ext_csd_bus_width =3D=3D
> +                       ext_csd[EXT_CSD_BUS_WIDTH]) &&
> +               (card->ext_csd.raw_ext_csd_hs_timing =3D=3D
> +                       ext_csd[EXT_CSD_HS_TIMING]));
> +
> +       kfree(ext_csd);
>=20
>         return err;
>  }
> @@ -2103,8 +2176,12 @@ static int _mmc_suspend(struct mmc_host *host,
> bool is_suspend)
>             ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
>              (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
>                 err =3D mmc_poweroff_notify(host->card, notify_type);
> -       else if (mmc_can_sleep(host->card))
> -               err =3D mmc_sleep(host);
> +       if (mmc_can_sleepawake(host)) {
> +               memcpy(&host->cached_ios, &host->ios, sizeof(host->cached=
_ios));
> +                mmc_cache_card_ext_csd(host);
> +       }
> +       if (mmc_can_sleep(host->card))
> +               err =3D mmc_sleepawake(host, true);
>         else if (!mmc_host_is_spi(host))
>                 err =3D mmc_deselect_cards(host);
>=20
> @@ -2117,6 +2194,48 @@ static int _mmc_suspend(struct mmc_host *host,
> bool is_suspend)
>         return err;
>  }
>=20
> +static int mmc_partial_init(struct mmc_host *host)
> +{
> +       int err =3D 0;
> +       struct mmc_card *card =3D host->card;
> +
> +       mmc_set_bus_width(host, host->cached_ios.bus_width);
> +       mmc_set_timing(host, host->cached_ios.timing);
> +       if (host->cached_ios.enhanced_strobe) {
> +               host->ios.enhanced_strobe =3D true;
> +               if (host->ops->hs400_enhanced_strobe)
> +                       host->ops->hs400_enhanced_strobe(host, &host->ios=
);
> +       }
> +       mmc_set_clock(host, host->cached_ios.clock);
> +       mmc_set_bus_mode(host, host->cached_ios.bus_mode);
> +
> +       if (!mmc_card_hs400es(card) &&
> +                       (mmc_card_hs200(card) || mmc_card_hs400(card))) {
> +               err =3D mmc_execute_tuning(card);
> +               if (err) {
> +                       pr_err("%s: %s: Tuning failed (%d)\n",
> +                               mmc_hostname(host), __func__, err);
> +                       goto out;
> +               }
> +       }
> +       /*
> +        * The ext_csd is read to make sure the card did not went through
> +        * Power-failure during sleep period.
> +        * A subset of the W/E_P, W/C_P register will be tested. In case
> +        * these registers values are different from the values that were
> +        * cached during suspend, we will conclude that a Power-failure o=
ccurred
> +        * and will do full initialization sequence.
> +        */
This seems like a strange enough hack.
Power-failure during sleep period? really?

> +       err =3D mmc_test_awake_ext_csd(host);
> +       if (err) {
> +               pr_debug("%s: %s: fail on ext_csd read (%d)\n",
> +                       mmc_hostname(host), __func__, err);
> +               goto out;
Redundant goto

> +       }
> +out:
> +       return err;
> +}

Thanks,
Avri

> +
>  /*
>   * Suspend callback
>   */
> @@ -2139,7 +2258,7 @@ static int mmc_suspend(struct mmc_host *host)
>   */
>  static int _mmc_resume(struct mmc_host *host)
>  {
> -       int err =3D 0;
> +       int err =3D -EINVAL;
>=20
>         mmc_claim_host(host);
>=20
> @@ -2147,7 +2266,19 @@ static int _mmc_resume(struct mmc_host *host)
>                 goto out;
>=20
>         mmc_power_up(host, host->card->ocr);
> -       err =3D mmc_init_card(host, host->card->ocr, host->card);
> +
> +       if (mmc_can_sleepawake(host)) {
> +               err =3D mmc_sleepawake(host, false);
> +               if (!err)
> +                       err =3D mmc_partial_init(host);
> +               else
> +                       pr_err("%s: %s: awake failed (%d), fallback to fu=
ll init\n",
> +                               mmc_hostname(host), __func__, err);
> +       }
> +
> +       if (err)
> +               err =3D mmc_init_card(host, host->card->ocr, host->card);
> +
>         mmc_card_clr_suspended(host->card);
>=20
>  out:
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 37f9758..ed7f6f7 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -86,6 +86,8 @@ struct mmc_ext_csd {
>         unsigned int            data_tag_unit_size;     /* DATA TAG UNIT =
size */
>         unsigned int            boot_ro_lock;           /* ro lock suppor=
t */
>         bool                    boot_ro_lockable;
> +       u8                      raw_ext_csd_cmdq;       /* 15 */
> +       u8                      raw_ext_csd_cache_ctrl; /* 33 */
>         bool                    ffu_capable;    /* Firmware upgrade suppo=
rt */
>         bool                    cmdq_en;        /* Command Queue enabled =
*/
>         bool                    cmdq_support;   /* Command Queue supporte=
d */
> @@ -96,7 +98,9 @@ struct mmc_ext_csd {
>         u8                      raw_partition_support;  /* 160 */
>         u8                      raw_rpmb_size_mult;     /* 168 */
>         u8                      raw_erased_mem_count;   /* 181 */
> +       u8                      raw_ext_csd_bus_width;  /* 183 */
>         u8                      strobe_support;         /* 184 */
> +       u8                      raw_ext_csd_hs_timing;  /* 185 */
>         u8                      raw_ext_csd_structure;  /* 194 */
>         u8                      raw_card_type;          /* 196 */
>         u8                      raw_driver_strength;    /* 197 */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c38072e..a9ddf7a 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -422,6 +422,7 @@ struct mmc_host {
>  #else
>  #define MMC_CAP2_CRYPTO                0
>  #endif
> +#define MMC_CAP2_SLEEP_AWAKE   (1 << 29)       /* Use Sleep/Awake
> (CMD5) */
>  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that
> has GPT entry at a non-standard location */
>=20
>         int                     fixed_drv_type; /* fixed driver type for =
non-removable
> media */
> @@ -441,6 +442,7 @@ struct mmc_host {
>         spinlock_t              lock;           /* lock for claim and bus=
 ops */
>=20
>         struct mmc_ios          ios;            /* current io bus setting=
s */
> +       struct mmc_ios          cached_ios;
>=20
>         /* group bitfields together to minimize padding */
>         unsigned int            use_spi_crc:1;
> --
> 2.7.4

