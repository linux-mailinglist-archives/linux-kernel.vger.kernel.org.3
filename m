Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137E9559B41
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiFXOOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiFXOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:14:23 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92106522DA;
        Fri, 24 Jun 2022 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656080061; x=1687616061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XfbONC9ky9T30AeKnOIVgoNijkX50lcvwHLUiXvturQ=;
  b=CNo5KpbmmJYbysvQATywb2ioghxecLOIXB+38LCDzEI+1xzVE6R3meuL
   eXGVcWWl3x60nt8W/LcRxbWcvTSzAO2PBDARpyb6Luv1ktqMoQ5zQLHpM
   wksuFNjVq9JtR/700PJv6De25e4kgpxVCn/pJFwVRg/jg9CM+InPMztOb
   zA80iiYI/K2DR49fpk4ePgw43k2QX1w99b/duWhuGk2R0eDjCYeXK2y+7
   oliiZt65d0BlFWHFX6AYMWmiQ78IT46sG0eO1486wocmsZrxWUyRQk4vy
   G0mWJbEkLY5PNlc/baJAfvUdFlAyXfifnHXyrLR699Hf6p0rtVkWrzTU1
   w==;
X-IronPort-AV: E=Sophos;i="5.92,218,1650902400"; 
   d="scan'208";a="202704455"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 22:14:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKLB0Jv4ZOJyBWJZ+ONS1d66Y6hWl1Dpj8wl1BrMCbCOnyIbQgtz1FigVEinlCen7OEadQc2bydsW8d17B93Yw3ki3rdN+tRlSMyO8SbMxmu/VyLgHgtYzoW5PVQGf2WTAnixFUk/C1VzeAr7gCVbq+0+Dussjfr1K2H5Hp9HC+eLTEpDPcBmaCdrldthw4EzOi1b7t0If8ktpvIplg+kzj6Tr4uRU/w/5sJj7J4FDulZY3N4pRoAXCLWUwIYKv6hnrO3JY4Vmq6iHJmIos0KSXklyQK/Df2RHa/Td5COs/cZyP2SqB26mN35oHN29a2ud3OJi5cVXTo27GZut+A1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Heg2e2L61SBkArNhKZabNFk1VHyKqJ/EbyqcrWDTlRs=;
 b=PPiaETakpSvywWJ/JCxXsl7tCpRdP23cmNdQ/NnpV3AnS6Ma6hbmusepPGoaK0j9XHGDZC3uAgA6CKF3Ay0e0G7zHoqXTSbpEmwodBDM0c5XmgOTFHl0mQPX0L4RLkmIJEANYVT7HZcbMJIm7V41DZT5gFDMyRtfHyFGDSP8iDzNMmiKVZtlhEXpErkR0ddrFhJ87WGGOUxmKaedlUcvF7P1NGI15RMkDNJCDC/rq2h7ftz8vinRTmD26Tkw2zs7JZ6MsOIjiU42WwfCYl8rx8Xs1C43+tgaL7EXDSYV2Yax0YuUEn76iYbwfk6qtoFFQwyLDPSUP9fyXEy6aPjDQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Heg2e2L61SBkArNhKZabNFk1VHyKqJ/EbyqcrWDTlRs=;
 b=aRdL7ibOEsCczxRm+o+ZTD+rcqot3kS6xT5CjHhGv+8uaQN+h0N+rm/0t5JGbJ+UzSIHVV6U+dil8bDDGNWvvk5yrIPmyYwW237+47/Xig3SIgoI7x21LVSuq4dCQKUoc6eQr9NH6aQh9UQm+WOZ6eDZMyyGjCyHtma3/ytJlwg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5292.namprd04.prod.outlook.com (2603:10b6:5:107::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.18; Fri, 24 Jun 2022 14:14:17 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%7]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 14:14:17 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: RE: [PATCH] mmc: block: Add single read for 4k sector cards
Thread-Topic: [PATCH] mmc: block: Add single read for 4k sector cards
Thread-Index: AdiHGlstOTiMmBAQQCyuCs385lDFywAuIFHg
Date:   Fri, 24 Jun 2022 14:14:17 +0000
Message-ID: <DM6PR04MB6575B79A8822A9C9E5FBD849FCB49@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <0fee7b89d21a472f97aa5b079abd1ce1@hyperstone.com>
In-Reply-To: <0fee7b89d21a472f97aa5b079abd1ce1@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 393255ad-ff2e-49b7-6660-08da55ebd35a
x-ms-traffictypediagnostic: DM6PR04MB5292:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNhz3EpVCazNZR5qr7o3bgkatjvM3GMBzINRhV4sromyXZd+KQ1LRyOBlyNlgu24lA7IdCKmyZWACENeI9XT9/VJHhPP9iU0yWkLIpD3SeejAjsH+mJs9X8OOZtJ07BKHhk9qzSqqJTvtOW01aa4dCP0ujYffkbDJ5mG/zWGTPNlVdbBgq+bwd9V1zxSPaPLG9synKwpKlXxeb4sxp7fcErsuAJhODKuW8EcTgXkIocyANju2IJYkXvrN853hUJ27JXfkQMUoccz0R9Tw0scgz6+YKDExpsDJq2Xh5HEaMzLijLmh/7QqSMuBfUe5MpYxqGv90OJpNAcGuMJqqQ7wu2xw6BSO9Osyf+6ZIVhbZS1lSNK3BWS4v6sayxhDGU+JyK9/k5VqK7XoeLS6gW8TwbC8W1gKOV/EkML/yi4Tt7z1wgUszoVA6kzNuYOQorJQFUgb8eKT+QnJKF2S7X5apoxJwwUX1+PxROn9h8xcn0kxhplXN9W54QFByBTD8C6UnP4H34mgSSPVsK3WCruQSEscqZLa2wjeYLL1DKZ0jAvCeZdzaMXcEp9fWciA2U9eMX8XVSkc6SmmMZIQVLI6Kfj4IFIaWi2AgUUk+RO5Ix617wKo184ov3tmxiWJJeSgpGK5zpqf2IEezT8txFOzoGI10NnEhioqX9sJNXc9fdDdaLkMtK0OfCN2FmtjaaUg0+iQHArnOFaeBaNzrKOQcorvnOLK3JCbytFIVmmO9CU1GQDxHr4bn80ruSpu7NG5dfZWxvnGMGU3mcAJewWnnKDR0hqaolEGhGUKzOd+iY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(122000001)(38070700005)(71200400001)(6506007)(83380400001)(7696005)(8676002)(26005)(9686003)(186003)(86362001)(478600001)(2906002)(41300700001)(55016003)(5660300002)(52536014)(33656002)(316002)(76116006)(110136005)(8936002)(66946007)(4326008)(66556008)(66446008)(66476007)(64756008)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?x/C9h4+Lqz7ntHdWeraJnwypYfJtxNfIWBYkueVRQEJ8sBwBGRUjqMPM5k?=
 =?iso-8859-1?Q?AuQ27c5hgyTHQZQvE0ngYbaQJ0xyFzpFqlIpJNjcuC7SExcUwnrLrvMHBd?=
 =?iso-8859-1?Q?HXUyegw4Nb4QLfT0MJlRoqWsPLRkfgnlQR5ChV28LJEqGEVvBpGExAQH6k?=
 =?iso-8859-1?Q?1maiwcSQwfF+4UvReUndPQ20YjVMW4iVWRIuA0RbO1q7jMlPaedo84YlGz?=
 =?iso-8859-1?Q?GU6QtUXx4QtjljgWAldwihX4AS7Al4UVZ8ItrXVeeFiBhOPYiWHvx8o5vt?=
 =?iso-8859-1?Q?JihtiMVPNEi7JiwdG4qNrlV3gwDzcYkx3F3IJQpphu8aqsoH5+skdROaEN?=
 =?iso-8859-1?Q?m+4gljfBCbf9hKo6fUzqDeikdUyqV/L54u7iWyBSXk05gneP+Luvh3t51g?=
 =?iso-8859-1?Q?rIlenDzKjRbHm7BAJ5MbZTO7GMbsXEJln8nV2VzPdI1xtyhTNrY3dlv4SS?=
 =?iso-8859-1?Q?GVsvIzIQzpC8lwoaoL7CQ2M3YvviBHznpO4w4OBmovoKpBEvVsEKwxUchT?=
 =?iso-8859-1?Q?YGJ3ZbRi6l8tEkqjwy2z9NjnAI8dQL/0oSjcJNXcdR2VQdZwjaIAESNF3q?=
 =?iso-8859-1?Q?gB4y2p2fJyAcfkU2bv1kx1SSwpzDm4Y85yUEAQGPszglNktiskTtNCW7gT?=
 =?iso-8859-1?Q?7lS+eCusJpDNylHMEr0BetXb6ikLzf+FL6bKEUL9yy261sANhNkdjl/TQP?=
 =?iso-8859-1?Q?YsTAWDYQQ5eLFM8z8TTb2ewjO13BHUtKa+UmCSGv4uS9wgrP/Nj+QAmx5F?=
 =?iso-8859-1?Q?xuNoYaPDGew/7FidkWnD96C8C2H4uyXKrLC/dLanoUKUC6qi4GxKq/dUF8?=
 =?iso-8859-1?Q?gfyWxWOrcDRC4C7Jn+ltT9+4qdRqDw6qEqVVnV+XVn0lvcRNrblNvLWbH5?=
 =?iso-8859-1?Q?9+teEHl1Trck1ImVvCYxy2jBDOwrkYkOEG4UwEh5LZaDzvaqquaGIg/sg2?=
 =?iso-8859-1?Q?NuEemCHQrP+fg91SGlc6mpCqahu4Iyw1Fp6D+NWSRQ7nJLSesW9gr61wO8?=
 =?iso-8859-1?Q?y9qgOiCRv7zwNMchAI2RePXhPwCsFNoBxyGponnWaoJAEMge/k9pNCfLVd?=
 =?iso-8859-1?Q?GzrDnbgETajOeDNlL+G12h1sjRoI4zu530PeVifs+F6UpcAxbSaoU8tl8e?=
 =?iso-8859-1?Q?KAIiajNMopeC2S85QYuBTYN25dciSjLnD9z3s7c/5W55SPnWKcH10oxs49?=
 =?iso-8859-1?Q?VITYd8o8qD44Fa614Kk6Y72zvCgTXRjNaJfBrQvQy3gQ0kytaJ+ml8cY4U?=
 =?iso-8859-1?Q?6YQPmR1guqco7JuPJIURYe4ds1F828/2/jDVdgWEi/WPqT25bHeVgb/36T?=
 =?iso-8859-1?Q?6Zm5xHXNGwe1KSfSnsRaxXvTJJV9y3sZYl0hOjTDp5oC38lgI5HncIdLSi?=
 =?iso-8859-1?Q?YTNLhqGNWXoVmTZDFE9zby+/Izip6nd+34INq5AXRrTMcWAk9txcomicTx?=
 =?iso-8859-1?Q?oesC3Uba1dWZn0CjlI2oQ2+OhsY92Mz/m07zIvKTqvtEaEj7hb/e8WpFuO?=
 =?iso-8859-1?Q?rqQ6/evloOmNAc//VxpO2rsVET5RtA16mXKaJ9qydd18llcpCoOXALRGbT?=
 =?iso-8859-1?Q?mmMXAtrY1b9yEqakM7w2wUEyWwBN8VtIur00mTwHG0WoCxgO9p4W21tqBy?=
 =?iso-8859-1?Q?MmR8XPWtLsoVhgHc/XYq9WFiqDrtMJEDUN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393255ad-ff2e-49b7-6660-08da55ebd35a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 14:14:17.7782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNkg2DnA1m8mKasz8IlP/xkxW0ijF7qH58bYxmdO/wpbp5f0d/LmtzrEbbRc88GtVpyym9aPV3375qJPVwJIMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5292
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Cards with 4k native sector size may only be read 4k-aligned,
> accommodate for this in the single read recovery and use it.

Fixes: 2bf22b39823c (mmc: core: add workaround for controllers with broken =
multiblock reads)
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f4a1281658db..6f0b24cb0747 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -176,7 +176,7 @@ static inline int mmc_blk_part_switch(struct
> mmc_card *card,
>                                       unsigned int part_type);
>  static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                                struct mmc_card *card,
> -                              int disable_multi,
> +                              int recovery_mode,
>                                struct mmc_queue *mq);
>  static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
>=20
> @@ -1302,7 +1302,7 @@ static void mmc_blk_eval_resp_error(struct
> mmc_blk_request *brq)
>  }
>=20
>  static void mmc_blk_data_prep(struct mmc_queue *mq, struct
> mmc_queue_req *mqrq,
> -                             int disable_multi, bool *do_rel_wr_p,
> +                             int recovery_mode, bool *do_rel_wr_p,
>                               bool *do_data_tag_p)
>  {
>         struct mmc_blk_data *md =3D mq->blkdata;
> @@ -1372,8 +1372,11 @@ static void mmc_blk_data_prep(struct
> mmc_queue *mq, struct mmc_queue_req *mqrq,
>                  * at a time in order to accurately determine which
>                  * sectors can be read successfully.
>                  */
> -               if (disable_multi)
> +               if (recovery_mode) {
>                         brq->data.blocks =3D 1;
> +                       if (mmc_large_sector(card))
> +                               brq->data.blocks =3D 8;
Maybe a ternary operator here?
=20
> +               }
>=20
>                 /*
>                  * Some controllers have HW issues while operating
> @@ -1590,7 +1593,7 @@ static int mmc_blk_cqe_issue_rw_rq(struct
> mmc_queue *mq, struct request *req)
>=20
>  static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                                struct mmc_card *card,
> -                              int disable_multi,
> +                              int recovery_mode,
>                                struct mmc_queue *mq)
>  {
>         u32 readcmd, writecmd;
> @@ -1599,7 +1602,7 @@ static void mmc_blk_rw_rq_prep(struct
> mmc_queue_req *mqrq,
>         struct mmc_blk_data *md =3D mq->blkdata;
>         bool do_rel_wr, do_data_tag;
>=20
> -       mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr,
> &do_data_tag);
> +       mmc_blk_data_prep(mq, mqrq, recovery_mode, &do_rel_wr,
> &do_data_tag);
>=20
>         brq->mrq.cmd =3D &brq->cmd;
>=20
> @@ -1690,7 +1693,7 @@ static int mmc_blk_fix_state(struct mmc_card
> *card, struct request *req)
>=20
>  #define MMC_READ_SINGLE_RETRIES        2
>=20
> -/* Single sector read during recovery */
> +/* Single (native) sector read during recovery */
>  static void mmc_blk_read_single(struct mmc_queue *mq, struct request
> *req)
>  {
>         struct mmc_queue_req *mqrq =3D req_to_mmc_queue_req(req);
> @@ -1698,6 +1701,7 @@ static void mmc_blk_read_single(struct
> mmc_queue *mq, struct request *req)
>         struct mmc_card *card =3D mq->card;
>         struct mmc_host *host =3D card->host;
>         blk_status_t error =3D BLK_STS_OK;
> +       size_t bytes_per_read =3D mmc_large_sector(card) ? 4069 : 512;
Typo: 4069 -> 4096

Thanks,
Avri
>=20
>         do {
>                 u32 status;
> @@ -1732,13 +1736,13 @@ static void mmc_blk_read_single(struct
> mmc_queue *mq, struct request *req)
>                 else
>                         error =3D BLK_STS_OK;
>=20
> -       } while (blk_update_request(req, error, 512));
> +       } while (blk_update_request(req, error, bytes_per_read));
>=20
>         return;
>=20
>  error_exit:
>         mrq->data->bytes_xfered =3D 0;
> -       blk_update_request(req, BLK_STS_IOERR, 512);
> +       blk_update_request(req, BLK_STS_IOERR, bytes_per_read);
>         /* Let it try the remaining request again */
>         if (mqrq->retries > MMC_MAX_RETRIES - 1)
>                 mqrq->retries =3D MMC_MAX_RETRIES - 1;
> @@ -1879,10 +1883,8 @@ static void mmc_blk_mq_rw_recovery(struct
> mmc_queue *mq, struct request *req)
>                 return;
>         }
>=20
> -       /* FIXME: Missing single sector read for large sector size */
> -       if (!mmc_large_sector(card) && rq_data_dir(req) =3D=3D READ &&
> -           brq->data.blocks > 1) {
> -               /* Read one sector at a time */
> +       if (rq_data_dir(req) =3D=3D READ && brq->data.blocks > 1) {
> +               /* Read one (native) sector at a time */
>                 mmc_blk_read_single(mq, req);
>                 return;
>         }
> --
> 2.36.1
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

