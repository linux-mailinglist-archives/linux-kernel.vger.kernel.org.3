Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B49B4DACFB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354697AbiCPI50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354685AbiCPI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:57:24 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEC563BF9;
        Wed, 16 Mar 2022 01:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgegJnDQXbuEamqGfemS0bgaLccgwJkInvtGrlwdVTLHFn8WqpCllgzYHqvZUlL3Lo8K3weiXLsSYpVDTH30lFxHmK7MudGZs4kmHpmEQUqQKLezzKbKXeQyAnzzC3TPSclP6kvvtuDRd+vSUSf0LyjucIh8BrSMUBV+ZFEsW+AmzWWjFYc35ZWdb7KzVBSD4d04tZ1LqbxSy7DjP47ZV2XtA+Xo8HqbhaGhpfJrlaATBn6HxuC8BVT1dcGrNhxCvmA4ILFYSS0TiO1/1aKDHrKtCaNwO5ydz9mT3wOZDkcSnNPwoJcELG83aCicnKFO9ZhV9MQlVJlTcirTRpYMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+TjZOFaRL4Fx1+R67WVUAYA+62kyY6rs/TjdFRuRj8=;
 b=Ef4nZdXDsAZLXDyn2U5mb4oQk9VfQos+F5574Io3Oh86Hkx99W2+a3if6GAzfle2FrApcfBRq+kpT5GM5sW5ZUlKWculboFakkhTjDraVGD+aMq3ot6JTqk55qPx2QyPEDuenH2+WhvdeI+jCG2Ee91moTCOFDQtvJnRcURhGgwtzVxgfwrqPMd+9Q9zttYoZORfyZKx/fmkPPwoMEZ2+yDak30U+CnKfDU74s31X4+uOPg6GnoPV0aOJPg7p2i8C/3wGJU0kTiJhnfK7xMi1i1Hp7dlHGYYKzwNoXCvzRhLOvRUcVOG/4Hq57+RQpMYFEe4BUwu7+N/DvZHwZZ9xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+TjZOFaRL4Fx1+R67WVUAYA+62kyY6rs/TjdFRuRj8=;
 b=N6Y4il4Q+5q58apivv74OGiJu/VrDB2aZIi9pvPyuYJm0JXkHSrT0vNvQcU6uHotjBZoMWskW0N1Lxr3Ha4PUiycZVg6NA/HGKtQog+6BqDDYHkZ6vqrySsAKU/U60CaLSDI7gPdBaxXwfOylpsyfeBzWw94OkJLXt3mwEiFGsQ=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB6577.eurprd04.prod.outlook.com (2603:10a6:208:175::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.29; Wed, 16 Mar
 2022 08:56:07 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 08:56:07 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Eagle Zhou <eagle.zhou@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] media: amphion: Add missing of_node_put() in
 vpu_core_parse_dt()
Thread-Topic: [PATCH -next] media: amphion: Add missing of_node_put() in
 vpu_core_parse_dt()
Thread-Index: AQHYOQypw3RVUrmgVkmJzLgcRwYa3azBtK8Q
Date:   Wed, 16 Mar 2022 08:56:07 +0000
Message-ID: <AM6PR04MB63419CD129367B8F2C811DF3E7119@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220316081938.80819-1-wangxiongfeng2@huawei.com>
In-Reply-To: <20220316081938.80819-1-wangxiongfeng2@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ccff1d5-c0d6-45ce-044f-08da072acf86
x-ms-traffictypediagnostic: AM0PR04MB6577:EE_
x-microsoft-antispam-prvs: <AM0PR04MB65774D664A57C71BB778867BE7119@AM0PR04MB6577.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aN6rImbLX78grZau8QuEO5sNpuvoASSwJTLXApjt3Tg5w3wjgHM+2AHwQi8KBL+gcJPVkBUCVn3XO36FIqt4xXiGddApFWwM7KgZvPkbardBfxfgKX7QIOxshoCMb2mtPAlsZZoVkjmDSSq7Ieu/0CIuGOWfVOEjVt9exMz9H6BksPURetpBxrs7RND/bX49v9CgAg0iEzxQ8ujejopTIvTxu3YmgSRm60vFFBCjHODjGti/71xnUGXtl4je0I7JqEcO3ycSkbu3sWt4tcAiRS9+6DYUdX0o1mqoMFUbVVGy13xx+4s3cTtFTnrzPuSe+QlY5Tdn0aCcDgDIVMHorj6Z/QeKo7Xoe81BJGxE45SgDMkU42Rfz827iSHfQStfD1KVD7Q7Xo4nvrzEdC2XkoW3PMHCiQ8Q6jQdqddxYCY+d92CuooevTcb8xKQh7Z8Ll9rEdnvZ8LQxLul8wVG8n4LK1F3L9QhXrp7dNPZsMNMWWV4yrSbKAHzt/4ztGSiLuEH+i6Tztk9eCTdhcMGUjjgFpRS+sc/XYiv3kaHzQNL6kwBh5AzeTNmDBublDag3Y/gsniPsCUTMWr+BbPNHsQwByHpO+mamI20wGPqI9Nw+BwltmejGFmxjPDPhwRAoej7ePNrTxcccuP2XUS/CiPZTo69CkRPtuwJXcz6YWhrNui3KZOzO9JIzVNybG3TkpSiWqyfiPVXfiFuxaA27hcx0yZ33Tr+i7ETnqkFRq5wCRKiVf0H2aG3ycQR2enyUwvwLlJL/btvoY1SJKTs6+Ra/qUVm/NXusGENfqa3Oc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(66556008)(76116006)(8676002)(64756008)(66446008)(86362001)(54906003)(4326008)(71200400001)(2906002)(110136005)(33656002)(316002)(53546011)(7696005)(6506007)(9686003)(44832011)(186003)(26005)(122000001)(55016003)(38070700005)(38100700002)(966005)(508600001)(52536014)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4FKY1nC8ymvaK2cAFQtltJFItH3sUE91KJeOWEGN0YXwrB+ZOTYrfm2X48v+?=
 =?us-ascii?Q?zDf9t2wi8J0hHIkq8ZneLCSmkDNYuxmO3AkU4xgHf/zfpBcWOR1O9wJsumGy?=
 =?us-ascii?Q?QtbTkSeLZwC8X11Nl7bYrvyI+n392TV/iYJleTJFFzUdTnYY0YaUH6SGsZB3?=
 =?us-ascii?Q?9uOAhhe4FCT4CfFEux92uG9jUOIh7x4IS3oX4ey04XoQTorT+hSDUBc5fs5F?=
 =?us-ascii?Q?YsBdnud7dS8nVPrq2yHmQiwHa/d6jP9UgPpuyizI+6MpNsb21JWsECRw1vM3?=
 =?us-ascii?Q?EuSTtkFLMmnIO+H3vtAa9D2UrpQRZpytsYlsdjUoVySxtWtztK9D7zT5Nu5N?=
 =?us-ascii?Q?HGr0BQsdya303Hj4iM+n0tvk0Wp7op71T3/45Qt3v4QKKKHx7inXy68Jl8Cb?=
 =?us-ascii?Q?7MyEqnBTF8PwsvRQScD4qP+vA4WsBQ1Sj6OaZFjTalhxVELV2hYVpBi7mvV0?=
 =?us-ascii?Q?WpBxA9JKltPR19l6eptcZ9nHiyDXl7BoqOZGmUWuK4tIq+NlKLHor17Umt7L?=
 =?us-ascii?Q?5GwnlGYjeg2EgzgV9hiSD4DAU2Qjm6sR2KhksSITtnsfWly1UqnstTgDI1W6?=
 =?us-ascii?Q?VuKz4fPHfc2HSxMsZ6hqhEBLA6DR4xeRrTv6D0maBCQyNkMinZaYz3C8+O4c?=
 =?us-ascii?Q?4cymZqvE5fzJhvzVdCbbZ9Jbur6WCBOpMqBpHf0GdA8aLVDdwmoIuoqUl/O7?=
 =?us-ascii?Q?OinyR6RY7PQ/3o8NJPD6pHnr15iX/98ylSuRTYFNI6aYhXmfeCJ2XMXqOHXt?=
 =?us-ascii?Q?T1OvoCPfwjHZkmN1VLRVOnNxrVlZL1UxfT4qFBDfR4Ngcf7HQt+nFN7A9AEr?=
 =?us-ascii?Q?nDkWVmqp5bq8ReSoO5+KAwPrNzGWPcDueUgZ3cMRFvPItqVhRCq/gYOHQsRj?=
 =?us-ascii?Q?d1YrxPOeNiv7hUKWTgNydgld7EAdoefBXBZVD1hD8PAQ4mzbrcnjCMv+Cab+?=
 =?us-ascii?Q?47ZK3TDfKnW/Y8JlKJKD9L0BVcSrsNBkujRD49fT/1pqmLJeN5mGWSM1NBkR?=
 =?us-ascii?Q?ciExtoOu218gh2z0tvjuzd6IXG5jAalnPvsTi37MSvsNbJWlBDKBHEKlYSdV?=
 =?us-ascii?Q?3FyOKSSxR+PBirkwrXKowPWD+5xEPib0YwSmKgdvhUZvbDkhJ8N/h1I8zf51?=
 =?us-ascii?Q?2Dhi6xh4gG+VxIoNLQTEESf9DwTE81N9NFQLJuMpHA/Zhgd6l2Kr2Rb46936?=
 =?us-ascii?Q?PgrO5txpEeE15Zy7KVkpO1Fk2HxX9BAbFCAjT+DyjUdo/EpDilW1acog0diL?=
 =?us-ascii?Q?K3fMvdN1vdGQxqZtvQeE7xlMrVJL/yR27jA+ON8P+wMYYDiSEyomWgaSKs2J?=
 =?us-ascii?Q?Oz8SOQSlgkbBhIZMfBueQ6CPIdLJUU8GubqjLEC0R0opDgwIA5NctlEKIQg5?=
 =?us-ascii?Q?xXA3nsTrFibnL6t9TIWFqvUSQz6eeCFvER9NtnyEXggw36fnx/z1Bma0rl7D?=
 =?us-ascii?Q?vwYxmD6H0Zw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccff1d5-c0d6-45ce-044f-08da072acf86
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 08:56:07.7565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDdoGjV2yAHgrHx/5SC1ojxUbgcSOuBxQiAIZEVYaT7y0yMOqapVIzl5H71TDNpfW/9GR5oF2XgVcceDzWESjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6577
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiongfeng,

    Lijun Fang has sent a patch to fix this issue.
See link https://patchwork.linuxtv.org/project/linux-media/patch/2022031406=
0952.66762-1-fanglijun3@huawei.com/

Ming

> From: Xiongfeng Wang [mailto:wangxiongfeng2@huawei.com]
> Sent: Wednesday, March 16, 2022 4:20 PM
> To: Ming Qian <ming.qian@nxp.com>; Shijie Qin <shijie.qin@nxp.com>; Eagle
> Zhou <eagle.zhou@nxp.com>; mchehab@kernel.org
> Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> wangxiongfeng2@huawei.com
> Subject: [PATCH -next] media: amphion: Add missing of_node_put() in
> vpu_core_parse_dt()
>=20
> of_parse_phandle() will increment the refcount of the returned device_nod=
e.
> Calling of_node_put() to avoid the refcount leak.
>=20
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/media/platform/amphion/vpu_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/media/platform/amphion/vpu_core.c
> b/drivers/media/platform/amphion/vpu_core.c
> index 016554387f3f..1da20335bc45 100644
> --- a/drivers/media/platform/amphion/vpu_core.c
> +++ b/drivers/media/platform/amphion/vpu_core.c
> @@ -529,11 +529,14 @@ static int vpu_core_parse_dt(struct vpu_core *core,
> struct device_node *np)
>  	}
>  	if (of_address_to_resource(node, 0, &res)) {
>  		dev_err(core->dev, "boot-region of_address_to_resource error\n");
> +		of_node_put(node);
>  		return -EINVAL;
>  	}
>  	core->fw.phys =3D res.start;
>  	core->fw.length =3D resource_size(&res);
>=20
> +	of_node_put(node);
> +
>  	node =3D of_parse_phandle(np, "memory-region", 1);
>  	if (!node) {
>  		dev_err(core->dev, "rpc-region of_parse_phandle error\n"); @@
> -541,6 +544,7 @@ static int vpu_core_parse_dt(struct vpu_core *core, stru=
ct
> device_node *np)
>  	}
>  	if (of_address_to_resource(node, 0, &res)) {
>  		dev_err(core->dev, "rpc-region of_address_to_resource error\n");
> +		of_node_put(node);
>  		return -EINVAL;
>  	}
>  	core->rpc.phys =3D res.start;
> @@ -549,6 +553,7 @@ static int vpu_core_parse_dt(struct vpu_core *core,
> struct device_node *np)
>  	if (core->rpc.length < core->res->rpc_size + core->res->fwlog_size) {
>  		dev_err(core->dev, "the rpc-region <%pad, 0x%x> is not enough\n",
>  			&core->rpc.phys, core->rpc.length);
> +		of_node_put(node);
>  		return -EINVAL;
>  	}
>=20
> @@ -560,6 +565,7 @@ static int vpu_core_parse_dt(struct vpu_core *core,
> struct device_node *np)
>  	if (ret !=3D VPU_CORE_MEMORY_UNCACHED) {
>  		dev_err(core->dev, "rpc region<%pad, 0x%x> isn't uncached\n",
>  			&core->rpc.phys, core->rpc.length);
> +		of_node_put(node);
>  		return -EINVAL;
>  	}
>=20
> @@ -571,6 +577,8 @@ static int vpu_core_parse_dt(struct vpu_core *core,
> struct device_node *np)
>  	core->act.length =3D core->rpc.length - core->res->rpc_size -
> core->log.length;
>  	core->rpc.length =3D core->res->rpc_size;
>=20
> +	of_node_put(node);
> +
>  	return 0;
>  }
>=20
> --
> 2.20.1

