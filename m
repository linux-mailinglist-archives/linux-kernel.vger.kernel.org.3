Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB905154A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380350AbiD2Thg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349536AbiD2The (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:37:34 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA04CFE7C;
        Fri, 29 Apr 2022 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651260856; x=1682796856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aJ4f9YFz8EJlufcK3UvFhXhEbqojV1irIgbDVHINZtk=;
  b=puSYy1AWkAHwBpOzypSKEeC3qOoS8Bc9ThE714miSmkyd1MavPpO8eRX
   io4Qg5pnhkuLtZ9btMAY/cUMv1vsiFidZXEAeLr0lGO4y3BVkgwM7kP7d
   3Txq0LGESabYhbMbATVcYXQMve7D61N3ApRMxyhFJggI/jJPFUbAH2NEn
   ngyzFZ3lLGZ3wan8qeOlS4X+Ze8dJSHpi4wPLRJ9Dovx4XXOfALEXcBZM
   WdGGAdBoDeNmUzOv6DeQkw40eQBOuzPKnQySXXhxs5je9htCsUqA49dyc
   ODpmQ4dtEQD0zD3IXhosu9D6iZfyl+YSTjSSWlb55tCTa2RX1XNhQJ+Wr
   g==;
X-IronPort-AV: E=Sophos;i="5.91,186,1647273600"; 
   d="scan'208";a="200077850"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2022 03:34:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8Kd6yrcpcuCp95nS0gHk0myy90X3nMJZFreNUs6hV7eLSGbHsNg4AqM3SwzLvVGt4VQEBvik4xIeUJWbtiO8JrMlvcpx2nGvbWODaGuoZ1GDfThQz+hqjnQgWaabwDAKrbbPVlUFE1pzoLGtDIt4A0ymr0UZTJRMVK9OMbDl4GPHHJxXpIF3VGXxK+fqgwNMX63px6ylowLQPmnq4gIuqFTXcELfkTD6ZtvXWWqGAzHpXQHF+FwAsMxYXtSvf9YQbYR9TY6Or2BbxpxeXkp9H2ifuxx46XKq7n08aWMy95rFzOYF3GvVvdFLvV+lU7wv2+EPHsHxAWUTn+NOMIm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeI3c+FblzQpzKWDuXvQlqEJbbk/G1nsESaaoAwsRnM=;
 b=ns0Ik76AGCu/FDAmDQn1D0nToEC0/+tFVZ2wZ/+3eUUFynhSqID8v4tjryPLX3RXQ+lcFMHVneFGo6gK4hYh8PPjciHzgpGgWcpYkKexwhwosrg1+6MX8ZGgyZVRI6ZgExZ2ZsFYsdLu/tZyiK9aV/79wqcztOloj7oYlRxpuxhQmaB3VISQCK8sROTWydtu6q+6pP6JTwsLBF2qWoiizn5Kz7MXexGVz5T01bjyl0/fWuGkmfpXunuh9nE1egcLPfkVA90FrPfu5hxMksJA0Rh0ohKw11+EdTexnd1cwLU0lF7eqyMxRYG6j6blSz01QfardhWFi8WHBbg0wY2mbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeI3c+FblzQpzKWDuXvQlqEJbbk/G1nsESaaoAwsRnM=;
 b=yhUND1REYxUB/1u3rOcnKNmoMLxpPsAr6o43vdNit2t1HTGIAylhhfrSoJ7fM9U91fcOvF2XP/P5Mybd4v3ZWRUyn+bkNRn5SKPp3nhdDLlcN2SloDPLdjSp9Y6J7ce1DmhBYvNeir0cdyviPeuXC4XVctl6mwgAWxYhf30DK9I=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MWHPR04MB0238.namprd04.prod.outlook.com (2603:10b6:300:9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 19:34:11 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3%3]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 19:34:10 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "kernel@axis.com" <kernel@axis.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: support zeroout using TRIM
Thread-Topic: [PATCH] mmc: core: support zeroout using TRIM
Thread-Index: AQHYW9zpo90Gc6qNZU+y8mD6XK0FLq0HR1bA
Date:   Fri, 29 Apr 2022 19:34:10 +0000
Message-ID: <DM6PR04MB657540F6BB9D02A5BA8A2AE6FCFC9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220429152118.3617303-1-vincent.whitchurch@axis.com>
In-Reply-To: <20220429152118.3617303-1-vincent.whitchurch@axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c802fc1-6c72-4941-bda7-08da2a173c1e
x-ms-traffictypediagnostic: MWHPR04MB0238:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0238C60B3F655E956392FBD8FCFC9@MWHPR04MB0238.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0lnZvhfss5UOIhTXbF9XVd5Wdos7v4ZbmAV+yAE30SOq2bsqZdup3jlHRTN0DUQit3ZaLg+Ryrc54PjZtwSv4QCE0BNfFbqF2nJQZ+S0lfaGl7VbxezD5ZLvCIn3swQh7ClnG7v0PK8UZjMZUDuYkgNAcMVJnnnrzsvA0akoGBmVVdIWXjf6D+z3ve0wkFJG0KXIRlC4r7zfiNWwR68c6k5pMBIUFfN4vLAsmepFo17qj2ulZf3zAlWqRz4RRGYCxEPzBvIR3A1my9sg5TTjVoUgHYNEuqc2JNOlNPBlacokMmG7cMF6teEBs36DiHmrw4Bvk4KMzbFO8Zf8B0QgzlGF47zmOR3UCp4t/WrC6ESc4m9eYzXqlfk3vTgx6MpVFRGtWXdnIxdspnBaTgYijsw6GPUbUBf2o7QD+IfP/VRlpJ1knzfoDIiuC02G5WvOuPzXXd2XVfWIuqDRxxF1US/xMHSXiMSDWwjKpUGlv8+WVzym13M2px/UK3LGypCew3crYN7AMLf+CCx1D0FusWy61n+OtM85L+QnkaKrA/TGBPLZp4US2pQJYkuagFwhaoYqoXiuIcDRWwHWnk8ak8E+4gzcOmh0XbhwsidyhvcdgdGYL7yKbWmIXnXOze8hIsC6xjj/Cb0U3/fmFvTbiE0mcO+XBUeprwJzfAAZi5oNG9V0aFcXWVQAPilTZ7IehGf/AJb6/KZMeIeAZbi0+KJa8FGDvd5qRW+teSCX/AOkHp4wUXe0XQaa2ns9SFSu51Sj/dx1YX4cW2sdRJ0T8SZhwaJ74+z0FMTNgFeg1Fpvyttke+Syf8FZlFG1FZVgVKAjL98Uflq90l8zJ7uPCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(82960400001)(26005)(7696005)(55016003)(54906003)(83380400001)(6506007)(84970400001)(2906002)(38100700002)(38070700005)(66556008)(66476007)(64756008)(66446008)(110136005)(8676002)(4326008)(66946007)(966005)(76116006)(122000001)(71200400001)(5660300002)(316002)(52536014)(86362001)(8936002)(508600001)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8+Sk0MYVF841ohxD/FoUGDUihEGHwt/coR0oGbJi/5HyfNha/QP1n16E0rH2?=
 =?us-ascii?Q?wnhO+RiabaubGIjo3uUmw6gT/6K3g4RwS3OyOCWjxtzFteuVNWYvmSi4oxpI?=
 =?us-ascii?Q?uw7m6TMlJaVd14twmA0zge/JK4UKnevQ2OPeu/AxE7v3mDxXI26iyHGhbteF?=
 =?us-ascii?Q?h3sDa1h2vz+QPuE0TSakDvIq1AW7IScHFjCQi8DVIQzMA8Xm7QUQmMAzthDz?=
 =?us-ascii?Q?tmJqKJ94b2slM8HRvEhCtg5TcsDUP22inUN24Dpz06p9fUtF1RSkSjfLM5IZ?=
 =?us-ascii?Q?NHT8sTjSPss0rOlFpPVss9l8zpvuw7+nsszAR/4tSoCKiGANCNwEC7rgqIZH?=
 =?us-ascii?Q?bVyVSgP+I/4Cxn7oVpN3SLuQSWaWJxGrcm3+3PxF9SGhO6INRCi/VpJgUGVR?=
 =?us-ascii?Q?WBNFblqv9gc8UQVQFOg7wO4J4q6XorhP4EA3+eXrFERA5ZcqtKzuvmbw2e66?=
 =?us-ascii?Q?MUMArENP8NYaIoQEWqE8VKH1tAINwBo6f7SO7kOGDNeO3WbpG8gDmyd4O/Lx?=
 =?us-ascii?Q?n7B9bkR8eK5pBWPXeMwfIlb8EhltqbqXGx3dXfDWI4UbURhFvKWL1+kQ98cz?=
 =?us-ascii?Q?//owiOTc2A3dl8oQODvEIbi8qCN29xwTGZJkhFLcwlAjPzFKnOH8dn4ZLb69?=
 =?us-ascii?Q?eKoTzJuckbI9ex6cp3PNvqp7PED/Jl0KHksUxTw5TDhU1MOQGHepPROQ3914?=
 =?us-ascii?Q?8WRdI1UvS/aW+u4SakY+iHdSzcHuzaXtcQGzMu2p7+zG25YUlkQWnRrdmevC?=
 =?us-ascii?Q?uKIU3jfcw+XDPml/xmun0uAHqspCEhzy42rzXYqkLKlbfJmmOHSccltMInBo?=
 =?us-ascii?Q?WAx58e8BrmXygshOh5OHXP4Rc4/BMutOUkFDod5VicMI3jwY9J1Jjpx3GeE+?=
 =?us-ascii?Q?S/iuftu+JmWzXs2TZanhVBDCic6BR2n4FzhTzT6ax8s2eekEIxcQan5HGAF1?=
 =?us-ascii?Q?C591aVP6xnJWAG4/LkYIx++4TpqGCezPDjjrxu8K9LcWki0H4/Ep+UdM9Ktp?=
 =?us-ascii?Q?f5pyH7/LT7NrG5bDhkVSD/uKzqJWuQzOSXEJcQklPZiHBR54tg/RClyuzfDJ?=
 =?us-ascii?Q?/pLm5uCXl80tznWErfmk9nNLh/DD2FynYtFoqRJ5Q4L9X9s6JYOnGWAyQVY3?=
 =?us-ascii?Q?uTYecsJLpMC9awU0oOE190bACcba736bK8pv5quTXOQrSG+pH++fVWbk1dqi?=
 =?us-ascii?Q?1RRve9qUo5jwFmIIUZKfaTXi4RXny41ht1EGLtIVNU8WEg/QogDzhP0cqZNB?=
 =?us-ascii?Q?P6VXAt1MBbcV8HOnai+0GNGsCWFTQbURV3CUlW5pMfto+mU1DBIA2faUObf5?=
 =?us-ascii?Q?2dRb1rWZFSeuz/OWa4uhQZwgxG2F/rp4csrUWniWkQyEj8T+93DC+pKpbdf3?=
 =?us-ascii?Q?uqIgfZ1k9nkG51FAKiwxYD8YkD3V0znittuvBJ/Fj/95sj8VyjvI9oH2gz4a?=
 =?us-ascii?Q?KCjUrLSA1/JkgpHQ0juGWu4FzF9iFZUdGG0wSb0OaFq21RQFWBvo4PxEjQRv?=
 =?us-ascii?Q?zILNUqwZ+FUUpCbY+ia9FQ8WmxybkSOdX4pvkHUJuVk1j02PwKLrvgJIAY7/?=
 =?us-ascii?Q?EJHJOee5edeCciHE57uTEuvRxdmwbX+l+yanCM9lgFiBQEZ6UzXB1cHK/Dub?=
 =?us-ascii?Q?+5GwOeF9QCsCNeXECqF0fcSTQOAEU19LQUav7C1VxPT3XeaMpHUnZGFPGpzs?=
 =?us-ascii?Q?uw+HpEcXsYQBzN4L47nZJhyF065Ys40jDMTzuicUR8YJ26S1b5zIKM5urhGt?=
 =?us-ascii?Q?Wu/eCnpuxw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c802fc1-6c72-4941-bda7-08da2a173c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 19:34:10.7452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: neHgGG8lO1tnNbYZ8JHpB4xJvqIb7eTN/5G1Hi+sSJHgS7Pzq3H90C4UwVATRWn8ZfkrE1BS8bC1uLDoj8JqGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0238
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If the device supports TRIM and indicates that it erases to zeros, we can=
 use
> it to support hardware offloading of REQ_OP_WRITE_ZEROES.
>=20
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
I agree that zero out is indeed a privet case of trim, as indicated by ERAS=
ED_MEM_CONT.

Looks good to me.

Thanks,
Avri

> ---
>=20
> Notes:
>     https://lore.kernel.org/lkml/20160303182146.GG9772@thunk.org/ seems
> to agree
>     that BLKZEROOUT can use TRIM on eMMC.
>=20
>     BLKDISCARD uses DISCARD when available so it can't be used to send
> TRIM.
>=20
>     If TRIM should not be used for BLKZEROOUT for some reason I guess the
> only way
>     is to use MMC_IOC_MULTI_CMD like in this commit in mmc-utils but
> that's a
>     rather low-level interface:
>=20
>      https://git.kernel.org/pub/scm/utils/mmc/mmc-
> utils.git/commit/?id=3D43282e80e174cc73b09b81a4d17cb3a7b4dc5cfc
>=20
>  drivers/mmc/core/block.c | 26 ++++++++++++++++++++++----
> drivers/mmc/core/queue.c |  2 ++
>  2 files changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> 506dc900f5c7..0398b205a285 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -126,6 +126,7 @@ struct mmc_blk_data {
>  #define MMC_BLK_DISCARD                BIT(2)
>  #define MMC_BLK_SECDISCARD     BIT(3)
>  #define MMC_BLK_CQE_RECOVERY   BIT(4)
> +#define MMC_BLK_TRIM           BIT(5)
>=20
>         /*
>          * Only set in main mmc_blk_data associated @@ -1090,12 +1091,13
> @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct
> request *req)
>         blk_mq_end_request(req, ret ? BLK_STS_IOERR : BLK_STS_OK);  }
>=20
> -static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct
> request *req)
> +static void mmc_blk_issue_erase_rq(struct mmc_queue *mq, struct
> request *req,
> +                                  int type, unsigned int erase_arg)
>  {
>         struct mmc_blk_data *md =3D mq->blkdata;
>         struct mmc_card *card =3D md->queue.card;
>         unsigned int from, nr;
> -       int err =3D 0, type =3D MMC_BLK_DISCARD;
> +       int err =3D 0;
>         blk_status_t status =3D BLK_STS_OK;
>=20
>         if (!mmc_can_erase(card)) {
> @@ -1111,13 +1113,13 @@ static void mmc_blk_issue_discard_rq(struct
> mmc_queue *mq, struct request *req)
>                 if (card->quirks & MMC_QUIRK_INAND_CMD38) {
>                         err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                          INAND_CMD38_ARG_EXT_CSD,
> -                                        card->erase_arg =3D=3D MMC_TRIM_=
ARG ?
> +                                        erase_arg =3D=3D MMC_TRIM_ARG ?
>                                          INAND_CMD38_ARG_TRIM :
>                                          INAND_CMD38_ARG_ERASE,
>                                          card->ext_csd.generic_cmd6_time)=
;
>                 }
>                 if (!err)
> -                       err =3D mmc_erase(card, from, nr, card->erase_arg=
);
> +                       err =3D mmc_erase(card, from, nr, erase_arg);
>         } while (err =3D=3D -EIO && !mmc_blk_reset(md, card->host, type))=
;
>         if (err)
>                 status =3D BLK_STS_IOERR;
> @@ -1127,6 +1129,19 @@ static void mmc_blk_issue_discard_rq(struct
> mmc_queue *mq, struct request *req)
>         blk_mq_end_request(req, status);  }
>=20
> +static void mmc_blk_issue_trim_rq(struct mmc_queue *mq, struct request
> +*req) {
> +       mmc_blk_issue_erase_rq(mq, req, MMC_BLK_TRIM, MMC_TRIM_ARG);
> }
> +
> +static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct
> +request *req) {
> +       struct mmc_blk_data *md =3D mq->blkdata;
> +       struct mmc_card *card =3D md->queue.card;
> +
> +       mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD,
> +card->erase_arg); }
> +
>  static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
>                                        struct request *req)  { @@ -2327,6=
 +2342,9 @@ enum
> mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request
> *req)
>                 case REQ_OP_SECURE_ERASE:
>                         mmc_blk_issue_secdiscard_rq(mq, req);
>                         break;
> +               case REQ_OP_WRITE_ZEROES:
> +                       mmc_blk_issue_trim_rq(mq, req);
> +                       break;
>                 case REQ_OP_FLUSH:
>                         mmc_blk_issue_flush(mq, req);
>                         break;
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c index
> c69b2d9df6f1..bbe2ea829ea7 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -191,6 +191,8 @@ static void mmc_queue_setup_discard(struct
> request_queue *q,
>                 q->limits.discard_granularity =3D SECTOR_SIZE;
>         if (mmc_can_secure_erase_trim(card))
>                 blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
> +       if (mmc_can_trim(card) && card->erased_byte =3D=3D 0)
> +               blk_queue_max_write_zeroes_sectors(q, max_discard);
>  }
>=20
>  static unsigned short mmc_get_max_segments(struct mmc_host *host)
> --
> 2.34.1

