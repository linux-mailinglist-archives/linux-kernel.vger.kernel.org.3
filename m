Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1C5AD32A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbiIEMkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiIEMkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:40:11 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A613E61D92
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662381246; x=1693917246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dRqtirA4erdOC+9c/xhS7buZqzOkV+Yk3P8EL3H006c=;
  b=YhNGkCCRHmGe4wZZJDi0GDzXUdo62y7xiY2EoJ+V5uOZAajrwLDrqzYZ
   2l1/JrC839lP7hX37LkFwkd2osyvqYjb01UCQpWjPQSBMDaqaR/71Ea+5
   4pg3tKjdcIjRjEoebMjCyK5m4KjTaTv5z1rR9tPXwMfZQ7Y6KkfMWW2+i
   EphE2OB6i4gN5o0MXPLXfd/b62cgAlHXFE7dk53D+UJFyEFrATJ4IqbLP
   hSXrlAFztq4csQBmX0Qv2yspJi+bIcjcrsxgb3mvDuL/29vie7xyCBwQX
   6sKs3JlGRY28FdFBtmEk3KB1mohcKX3i9Owwu4Nh1KPmIQ48VCEcInkHl
   A==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654531200"; 
   d="scan'208";a="215695093"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2022 20:33:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxmDA2CVPbeB7qjvwqACzpbrycdKRx+luQf6bBvfWSKf8lm+XQ354NawcmUQ3avBTW4QzxdEn11T9T8R/p9obCfo8L7MX2BPCmHKgsdXi3ViqewZ5LgA3jrdxxXyctI1jdIZ+7OONYLh3qoLAETziWP1ZSYUqvqLpZ/zHB4k+WAJ2i/wMIq/2lwrZsW4EWt+xZSulXbUPKJOrAoFEFBmR3HhIW9ls67PijjPrWQYzWtWkV2FBufw+q6Vlhfe5nJJWj/hKxCtvwAvWfTWjAoY0C7ek+il6EdrmjHv9ipl2NCvtYRqNv4Iirgt3br9GMUEhkpQyjideAoLsUvPfAulgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxItvLQcSBBE0d3TPpDiXwMF9PbXFuPIHtOpnDJrPLQ=;
 b=JmUd/dDU1wSNM6W9NVIrNTvNjrgZ0kmWEiU8BYxLPqTevsUVn+QyVGpemFjdJ6s7qBKW/MClgQE6RaEeCAzZntSXheIPCoxYBB8psmCE2nHrzhj7MTmMsFQkNrcdFxY7nyhVO5b2OuPoAhvasC0pAWWoUYwVTjfBd6AeE+HBF6A8MFpCfvx7NELU1xTtDUCAED8tAgSzW+oR1NZc1s39sQXa4StdGXgkynd7iNR0VG5N7nxnNDbQUpP8jUP6wE52Uf877vd9WLicsFHf7UAEBKQXX0T3fLYuxS93ogCB7p4jXHO0Pqpv5j5Y5uF5cWTBCE+6+zYVG7e2HarXYAf82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxItvLQcSBBE0d3TPpDiXwMF9PbXFuPIHtOpnDJrPLQ=;
 b=LgMbXq5H13fCXQsDineonA18x8jFAYQGuCxwAAdGblromTrEYm/VhC6jWf3F1ibTgK1tHKcD3QBSszuL7qYoXwJwLVhIKQrGYvNC/LWhReIJzW5BBvcCmqVs/rWaSx2GEosuQ5ZMg+r5lKnTBeCPVFzkiv0vcR6MCEz6Ap7A9X8=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by SN6PR04MB4813.namprd04.prod.outlook.com (2603:10b6:805:a9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Mon, 5 Sep
 2022 12:33:38 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c839:6239:54ad:fc30]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c839:6239:54ad:fc30%5]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 12:33:38 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet: fix mar and mor off-by-one errors
Thread-Topic: [PATCH] nvmet: fix mar and mor off-by-one errors
Thread-Index: AQHYwSJaL0sgHpgYm06eo7YO4ydfha3QxSsA
Date:   Mon, 5 Sep 2022 12:33:38 +0000
Message-ID: <YxXsoAk+RMUs25L8@x1-carbon>
References: <20220905122116.2678206-1-Dennis.Maisenbacher@wdc.com>
In-Reply-To: <20220905122116.2678206-1-Dennis.Maisenbacher@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e234198e-200c-49f5-9ddb-08da8f3adb8e
x-ms-traffictypediagnostic: SN6PR04MB4813:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yGFrEaMQLwu5GZkufpBq3JFOg6H+cHbbCGAEbfM9ZUcmVFHojSVuw+/5gY8xK3vYFWyMgGdEDPLcV1w2HcXWHIEWT/Vj0ZRbceKSr9/oPgwA3QzD4u6+0/8zFVoUzhwdVgitxOSfxNb8L5BQd/oqkk5DH68hDgabJz/PJoIZGzuSm2d/ZB2zlEHE7EjrihSktaYtu6kLHNxjspSGO7HwQNk5AIf0EJ1ciyBu0wWS/c9yomuatLiOESq8UZFYzr6Tan2uHgvvRz/F2ry0cIZp79TEGNyp7kZKEO2HyOp1VJp46uXm4bKlRvJv25/NKGbiE8pHyuBkYo66Ypubuy/RmBw5iMNYMZZtbUj9bsb6pcCv7wZP7GIVF0pde2nTexKjrSDf4WPHF4KWiR6fdjEnGhFTBuYrwNic86x2zH0HxYKbJsTHratFORTATQX2tBEdITSTGyeITyB1YkLCIGaNupIhXtdyXmLIJmnvv6uZHrfFBZvxZ0vOjLdTsle9ZV6zLfROA6RobsyQwk50rnOGUVhCrXDFT6zn/AJEXNeF5kMqCn/WrbcOuUG2SpY2Csw2ZlODZOefevWqIZ1V2elkzxqhazPAdQ7BmxiHiYYDnXgYh6S58e97rjTzTenwjBJzDj8eXN53TL35cyGD5T4hcFrkfsaCNQfjB1FhUN5hpGT/FbeEmSCVE+PF2Au6An/N5rN/+BW6LtIWXDIomR+BNVCNiltlV4FP0YKTnEOvRw3NUb5e99KY3wnxWZbCenjlBtitmcVVw9zPZOgWptito+5P3JTAaNsdD1qYNvk3Vt4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(6862004)(26005)(6512007)(83380400001)(9686003)(8936002)(5660300002)(2906002)(71200400001)(86362001)(186003)(6506007)(478600001)(6486002)(316002)(38070700005)(82960400001)(122000001)(41300700001)(33716001)(6636002)(66556008)(38100700002)(54906003)(64756008)(8676002)(4326008)(66946007)(91956017)(66476007)(66446008)(76116006)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GWlArK+wibxpi7x4J3OflDTia1cfq9uyblRRt0Kv0JoqIrLlsLkgqcsDBv06?=
 =?us-ascii?Q?F0rDHFKYyJ/hsPoFzyQeM4/vU8zUwFKNYRbctsX4430JyV//g00vUCOXfeHC?=
 =?us-ascii?Q?Fduc7VK5bttKtoJ/qnHxCR/6lnpvgc4yI+X2Nfe38z7ioAueaYkA9moZPZxT?=
 =?us-ascii?Q?E7k813Iy1n0CidwhPniUoncHpxknhy6rB7N9EzTVGRnio8TwjYpU+d5yigBd?=
 =?us-ascii?Q?TeF71nOpT5sXUQ+vv+vVS8RPHmMHyCRzzXjTu+7l21WZakdyGj91QSb2+K9I?=
 =?us-ascii?Q?46UiXwss92LrSaF5k6AVyAtbmAUzZo3/o/iO54cviHLsvMyTH3LUFLuQQ/2a?=
 =?us-ascii?Q?Fw/L/UWMHaMmb2cH/esN5PMiKip76F5wwS6Ol3XbYp8HdmawhLTbpYUSzEld?=
 =?us-ascii?Q?QTHAVryUMPLO6NQ0UtUilNgcSKeV+StNjQ5S/71tpZObAC9qbSL0IpF596k3?=
 =?us-ascii?Q?b/EMe8Qy/RSS8+c2S6qyRbAZ7MsOxUGeGKYWxRRDpJAjv6ihZszGDMRMk+hO?=
 =?us-ascii?Q?KQjltHE2hKKoRQLBjmvzZIQov8eauvCiK02trYFgDwpzug4mdyj5Oe9GV/D+?=
 =?us-ascii?Q?hZPqkH7HgBow+TbAmra23/35KMfCuRUM4BSbXQw+MylBvRA0YAY4E0x85Fl2?=
 =?us-ascii?Q?x/S15oydG7VxqonrIQWKeXOfmP9tADHki2+Kr0c5bTJj8+1vnmfVof1dA2Z/?=
 =?us-ascii?Q?fTN8EL8afHTvN6of4fZRRNoyk5lkUz6xeNjmuHZcrEz6jZnHBmlOspkrKnq7?=
 =?us-ascii?Q?sSae1SIP1mgv2VLD2RXpiJdwfnc3ihrTAaStmHuxIFJ6yirVF9WNzUx17Ydk?=
 =?us-ascii?Q?d+70NKbWK03/GCecgmqrutQlCkr5pWZogY2BCc7jCuFZbp6UmoIn6LAqB2Zv?=
 =?us-ascii?Q?/85xE6FMhlzSROxAya7WaUcXmHL9PjzfNZmeGKVmvKUOl6IEiKepKZK9h3FI?=
 =?us-ascii?Q?rXi9rKbT8FlvYsRL27fqt4VZUjb8QCSi7w8QtRZ0na5Roz/COI0iLWuDQmHB?=
 =?us-ascii?Q?Q76QZpkKHffbgWERR6O6hDjbeqjh6ijK3g7o/fg8SD2BuzAJVV3bGHDCaN1X?=
 =?us-ascii?Q?Yeebu0NtmaLDchNtEO+RAmUboE/21Y6n1Y+q7W6xJEJqvtgfhk4sKpvWXiAg?=
 =?us-ascii?Q?rJWjNoVkDKqRSdmR68AREqHAk94U0DADB6N/i3xmOsh2yRyNMlUKW2Ra4cna?=
 =?us-ascii?Q?xN1gFLU4APhrncmFhnDn4AZVRi29hFU7SwqIdb2nLZ7IKm0SsZPis2oqU5gc?=
 =?us-ascii?Q?lcGhwFnAFkoJqdQcpdTqUNJ89uZ3xRH52HI3WDlV8oHAb/zg/WjcWTW3GlDi?=
 =?us-ascii?Q?z5ZDJxkNFmQdZMMZvgy2AslkXoboOBBpRE6FtlBwWfyvsA1BDnZmkF8x/x8Z?=
 =?us-ascii?Q?8gUVL/8Wxdlivh/rgHKzG47X2VV4ROXMohhAJy1J3PIBZF5wqRzUzFtgOMNo?=
 =?us-ascii?Q?sgC/8BqPZOdtxrEj/SzQU7F/vQhEhYWk2vecvM7BAKNdRw+sdvR8r066sEr0?=
 =?us-ascii?Q?M/sSTPF8uwEkp1GW+6sWeIyf7cxke4Q7q7sxlC3I3L14WicMmRqsZmbwl14L?=
 =?us-ascii?Q?OktQNpkhtZjCYI+rGIu3Z/kiPIXtuMWv9Oj4IKXJr0s9f8omQZLNR6z0Zp2t?=
 =?us-ascii?Q?9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4ABF074E98D5844AB2E78BEC724F9DBC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e234198e-200c-49f5-9ddb-08da8f3adb8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 12:33:38.0466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrnZET5e/hhnOtLUR0u0hCx+u+R/aL5O8FQaDK2U2z4WCbnpjGqwJ/K02yklAXXp8W8PUrK2vLQM+SE8K+PD9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4813
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 02:21:16PM +0200, Dennis Maisenbacher wrote:
> From: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
>=20
> Maximum Active Resources (MAR) and Maximum Open Resources (MOR) are 0's
> based vales where a value of 0xffffffff indicates that there is no limit.
>=20
> Cast the unsigned int values that are returned by bdev_max_open_zones and
> bdev_max_active_zones into u32 vales which need to be decremented as the
> returned values of the block layer helpers are not 0's based.
> The cast to u32 is necessary because the size of unsigned int is
> architecture dependent and a 0 reported by the block layer helpers
> indicates no limit, thus it needs to be converted to 0xffffffff which
> happens by underflowing the u32.
>=20
> Suggested-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
> ---
>  drivers/nvme/target/zns.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index c7ef69f29fe4..606f21ee21bf 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -100,6 +100,7 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_re=
q *req)
>  	struct nvme_id_ns_zns *id_zns;
>  	u64 zsze;
>  	u16 status;
> +	u32 mar, mor;
> =20
>  	if (le32_to_cpu(req->cmd->identify.nsid) =3D=3D NVME_NSID_ALL) {
>  		req->error_loc =3D offsetof(struct nvme_identify, nsid);
> @@ -130,8 +131,10 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_r=
eq *req)
>  	zsze =3D (bdev_zone_sectors(req->ns->bdev) << 9) >>
>  					req->ns->blksize_shift;
>  	id_zns->lbafe[0].zsze =3D cpu_to_le64(zsze);
> -	id_zns->mor =3D cpu_to_le32(bdev_max_open_zones(req->ns->bdev));
> -	id_zns->mar =3D cpu_to_le32(bdev_max_active_zones(req->ns->bdev));
> +	mor =3D bdev_max_open_zones(req->ns->bdev);
> +	id_zns->mor =3D cpu_to_le32(--mor);
> +	mar =3D bdev_max_active_zones(req->ns->bdev);
> +	id_zns->mar =3D cpu_to_le32(--mar);
> =20
>  done:
>  	status =3D nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
> --=20
> 2.25.1
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
