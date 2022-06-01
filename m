Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0A53AA94
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355899AbiFAP5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352622AbiFAP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:57:06 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2CB427FF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCd/bo/O2thutkklr/eyRo9v+OxzVqYQqe5j3KWL/VdgYfhoNvXNN9oSf5gr98Bt0neU95bE7HHyJ1EB7vbJTbeWxkc3P56mJXd6B+k2cmYZcNvtUqq0T6h1yWyBNHWF8M6pmNRx61z0TxWbjS08X6cuFf6a3KR/0FyxV6j9MG5Fq8iAIcO0Ri+kaQE6vZVngoAIr24C4sf+JUKwpMVx2ZtYoCF566U9KvzlD5FJzF/wUhds3nIU3jaUGC9uyBMcPsTPenW/WyjIrQKDcju7A4lA/0FZbMAI7HpFPFJGXBLyWtu0Y+SW/dW0ZYPyopGOJEkG7Ye3JDsN579AUpuh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMeMXSmAZoJ7ye4FYWfWncH58znQKjxZbkNSxrY8IXk=;
 b=KCBNNT8YoffThOxw/hNj0VAxhd5uyp2Lzjos6+VSU73J0V6girCug37m3muQ/SVCttyGhdgPtlnCNgHn+/WdfkLUZwPHqVUcQV0P9ihI9jLo974ClNVh7B3orEztSrXqU6JMKPiMHp4GxgSWPEUHfPQTH15bNgWusrJRr8C9pg3vRYFWzV8j8Q4kji+ROTNBlLsQkoJsHSNpyvYaQO578opzIaYwn4zzL+DZ0CnRdAdDd3gzTMUgE/Q5Y8MWMrf2/M7PUfjrdvJwShSlIr3DRlSXDoQxCPElywvq/7Ax8unWEWiXL9gYi2IneFale9MtC6C6E1TB5LNUKI/NWD6suA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMeMXSmAZoJ7ye4FYWfWncH58znQKjxZbkNSxrY8IXk=;
 b=QYs+FSHCWo6rRDlyncQHbuo3R7jWs37rrQrpyQHuT5UQUdi3ZdT93AP9hIcYI0WW3T47rgFoImorC8sndvXciNP51Xv4MLDn2i+NC1tVKFBGTUP3U9T2kmMzOB6pDwgbhtfpMe3v5aYFWYoJ9LycRyEjuzOXHGWX3pi8Lt5Q/4M=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by SJ0PR21MB2013.namprd21.prod.outlook.com (2603:10b6:a03:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.1; Wed, 1 Jun
 2022 15:56:59 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013%9]) with mapi id 15.20.5332.003; Wed, 1 Jun 2022
 15:56:59 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Caroline Subramoney <Caroline.Subramoney@microsoft.com>,
        Richard Wurdack <riwurd@microsoft.com>,
        Nathan Obr <Nathan.Obr@microsoft.com>
Subject: RE: [PATCH 2/2] nvme-pci: handle persistent internal error AER from
 NVMe controller
Thread-Topic: [PATCH 2/2] nvme-pci: handle persistent internal error AER from
 NVMe controller
Thread-Index: AQHYdW3cZHH+mxWkL0udYgrJBl+Wrq06KV2AgACFYKA=
Date:   Wed, 1 Jun 2022 15:56:59 +0000
Message-ID: <PH0PR21MB302599C693F0A48F3777008ED7DF9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1654056747-40143-1-git-send-email-mikelley@microsoft.com>
 <1654056747-40143-2-git-send-email-mikelley@microsoft.com>
 <20220601073505.GA24875@lst.de>
In-Reply-To: <20220601073505.GA24875@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2c682ad2-0a2d-48e6-bfe9-878564768048;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-01T15:32:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f190fa0-0839-4e0f-2f73-08da43e75c97
x-ms-traffictypediagnostic: SJ0PR21MB2013:EE_
x-microsoft-antispam-prvs: <SJ0PR21MB20133A5FACA8F61F881F0672D7DF9@SJ0PR21MB2013.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zm13Dla6OoNkSLdK8aeSjoiksLgby50g2BcKj+lnmQuv6oWDdj2LzBl/rMiax8TZBRxbUYxN0AMxaa1Hs3rnXT0bb2LQ+DvfCXTb1A3z1Ck7spvMcmsnbZ8FCSyGE5yEt3WKCXOURf1cngHSdltPl/GJrMJBjQCcARoy6L+cMd4QX555R9IU2rngUfLZYQPkc5meUNmIssps/iv40MLwMHHlGnXQGRJLejDewiE4XR4O3ouMt37q6EJ6fu3/HdrHRJmHS139+Iz6owZu9z65WIwUVsw7ndanYeLbmC0QpVZzK9TkGsjDYxd6RPdWKV4txhwZUKvkWNzAc0OKAgKPV5yYYlJjWlyeOVvKg8v2X3bG5F1lqbi7Ic82JEhnyVdfiyKJ614RfBNFkXXJnXetyxQLQi3YQVDNmb8WoyfTQFh+uKdnfmVPRQQnasIUR0N8Im3E/Eb0UG6Ev1YjiGwdQPpbSmj018WwTFNbE2uNfjpsIfRk7EA/F5E8sbuRlK2+G67Q8NpMnNRutbdbU4HBLe3raic2iagBhc33zDLR6N30/cJ4R4HkST7Y9LBFY8zHV4jn15aET0r4s8EMW/bbM7VFugClvFezSmzWyhZKjNRF7rtTXxnvWTnIZkD/lZG2dtcXdvF8ZwEQjZQ311D/+rCqQaijznA1cNWlO8GDNQDJfBSBCIiVIz2UV3EDRodBVeP+SVJ8KM7idt4XpodKY6WTHF2FEz/ZRlHHJcPM6d17UiyywoxE8EZmeKny9IDO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(38100700002)(64756008)(38070700005)(10290500003)(66946007)(76116006)(66476007)(8676002)(4326008)(66556008)(66446008)(316002)(82950400001)(82960400001)(6916009)(122000001)(54906003)(26005)(52536014)(86362001)(83380400001)(55016003)(71200400001)(8936002)(5660300002)(508600001)(107886003)(9686003)(2906002)(186003)(8990500004)(6506007)(7696005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c+V+NtBL4a2ApeB1/1pFelpElyNYK/QdPvAz2HVn2PjnuI9HeIEq0o1oRYad?=
 =?us-ascii?Q?F1XqmpdbnTkDEwuzCuaJ+pURwVuJU2ikhLLOnVgRxd9E3JBdavz4UD0OcWxY?=
 =?us-ascii?Q?swLJu8JQAFgXJcWVDXjwj9CWg1kHFYMtG8ep9AV+s0jv8H8dGMgPk88ia6Ty?=
 =?us-ascii?Q?7CyyfI4DobUh1JVdrxS6VDSaYYzQd5/ZCXDRJI+CtNf0p0B1XfmruO1JSY8x?=
 =?us-ascii?Q?X7q9oBZv+LZL1BxB8hhTpkQObpetfdrvJwpN8gUjp6M5/SH0PeJhCaRuNm1W?=
 =?us-ascii?Q?+5GasNDvjuXal5T3j6hZBoW97TYmsqtdUFUzdAuSsPiAq5iv8s7DdbRq2UlT?=
 =?us-ascii?Q?B15bHpugtpr/QoCL8Y1djguek4V7Ha6pI2S7DdaR1tBQWb7p3GGDNjaNwjkN?=
 =?us-ascii?Q?CfCX1JzX8ldBo0rOssMlBI560VrEC4ONhAki2MReY/s72FM24Rt6Dp4PhJbE?=
 =?us-ascii?Q?fOEzJJe4kRMLqQhMcXKqaprw/lISHyER787+96rhEE0pvryP6aZL6Hnzm6H+?=
 =?us-ascii?Q?ca6WxJPk6tsAsy0+j9PgkC3hSAZDpo4yV54DRj0qosspKRNmsp5yh46ej9mB?=
 =?us-ascii?Q?teu9SEknK62W/BWWdoXVuu9jiQgygJ0Jmz/cEjC5CIcdr02k+c4mWsgkAl8y?=
 =?us-ascii?Q?1ZSXgswZP7j7uKBkWRUAhRRiFBtXAd0qf9DlpmuDOP1644QZetoyyTpba/mJ?=
 =?us-ascii?Q?+lxsP2/tCWq+vBmAbJWfC7m2XSJB8Zg/U/B5l4ORsidst7RBVj+o+WZraQ72?=
 =?us-ascii?Q?o4qf1pAbLGmjvwPh9IN4p99yMT9flKDO6+PXFk67O/tuHTO5t4LhucYFBlWa?=
 =?us-ascii?Q?UL7I1QFQq2GYtwSY9P84BJo5r/1MlT03fxdf1ILMEvIjNQOsLRr2UPofsv86?=
 =?us-ascii?Q?8qTtAz8kECyeIlAt0GmS8XvGA0d243mqN6/o/vuk7IGE11yxQQ83pAYxQEH5?=
 =?us-ascii?Q?mWvXAazVyIr82Qv7rzupN0dYM/QIhr17UDu8bjqybMONmIdO2kPsojJOpYb1?=
 =?us-ascii?Q?ww4N5IT3P1tsYw5RkuWuqhFGFPoloej0Vl5vtqrotRrFx7tLjnAKSWsX/Anj?=
 =?us-ascii?Q?exthI0v/TfQg59qzEI8XQnh6m9CNpdveM7P2sJfybM8WRQ+DN46ljVMvG8R0?=
 =?us-ascii?Q?UVjX74QinmnewyGDOBppEDEJMuyQK4ofVnEVyHcZQCFCXpHuzQ4KUL0NSHxg?=
 =?us-ascii?Q?5sKn7uWQRsjvaVWROWIB2Rg/miyiXipdz65DD/efqWirZVe+5lRydElZqezo?=
 =?us-ascii?Q?2G2TnO6dfUdd0DQsZnqJud6SwG1t2sQIAVRwVpuwZI0wDHR0iQhyR8QwtSEj?=
 =?us-ascii?Q?bof5b+u/0jcOpJOPNaoMPNOwC3E6Ujt9Yu+8R7PeGSxiO+pUpVi+Gp/hXMkP?=
 =?us-ascii?Q?yfGQovEWhxk5+t7wRP0Fq+zxwpW1nGYzfA4NopOJlKACUcm8s6TbT0h4FdwI?=
 =?us-ascii?Q?hT+SWWIfx+PImPPshsNlu72P7aJeq/iym0rNqujXHmJLCJirT/2WYZbFpztG?=
 =?us-ascii?Q?uaMw8PGPuTURAHUAWOnENEHvLnnI476y2h79BG4A+joe2Juxnc9WM740+NQ7?=
 =?us-ascii?Q?z5AvgXgIkB+shdEmsq+onRvaiOeeb2fwVR9NBSmcqh97KriKh7Ix79PQrP2R?=
 =?us-ascii?Q?xmMHucS1qzZLjoO7jk2ZxKnz97gpWnMEuek9ToD8MfSqIs3pm7BoKyVjH4j2?=
 =?us-ascii?Q?sGmRyykPwPidbLJUfKlmKC2yuxFoLk/DpG6hp2t4tkm0CLFEN8eRndiK8W3B?=
 =?us-ascii?Q?MenS8CDZemQdesqsjGR8uoUsXKSq4Xc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f190fa0-0839-4e0f-2f73-08da43e75c97
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 15:56:59.5956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MDJJh1Xi2ZJGjBMCZXsnF1dJCoaqOOxn/ZbzqpP9pwINONh8vRGZKeEH9iOVpt4ckcprJBuWXafIARXGtLXMNCLV/QEw62jEIsqwXfcUJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2013
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
>=20
> This really belongs into common code.  See the untested patch below
> of how I'd do it.  The nvme_should_reset would be a separate prep
> patch again.

Indeed, that makes sense.  I had missed that execution gets from
the common code back to the PCI-specific code via the reset_work
function, so unnecessarily did everything in the pci.c.

If there is a persistent error that does a controller reset, it looks
like we should *not* queue async_event_work at the end of
nvme_complete_async_event().  The controller reset will
submit an AER on the admin queue, and so presumably
we don't want nvme_async_event_work() to also try to submit
another AER, which may or may not succeed depending on the
timing of when the controller state shows LIVE again.
Agreed?

Michael

>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 72f7c955c7078..b8b8e9ee04120 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -171,6 +171,24 @@ static inline void nvme_stop_failfast_work(struct nv=
me_ctrl
> *ctrl)
>  	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>  }
>=20
> +bool nvme_should_reset(struct nvme_ctrl *ctrl, u32 csts)
> +{
> +	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
> +	switch (ctrl->state) {
> +	case NVME_CTRL_RESETTING:
> +	case NVME_CTRL_CONNECTING:
> +		return false;
> +	default:
> +		break;
> +	}
> +
> +	/*
> +	 * We shouldn't reset unless the controller is on fatal error state or
> +	 * if we lost the communication with it.
> +	 */
> +	return (csts & NVME_CSTS_CFS) ||
> +		(ctrl->subsystem && (csts & NVME_CSTS_NSSRO));
> +}
>=20
>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>  {
> @@ -4537,24 +4555,41 @@ static void nvme_handle_aen_notice(struct nvme_ct=
rl
> *ctrl, u32 result)
>  	}
>  }
>=20
> +static void nvme_handle_aen_persistent_error(struct nvme_ctrl *ctrl)
> +{
> +	u32 csts;
> +
> +	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts) < 0 ||
> +	    nvme_should_reset(ctrl, csts)) {
> +		dev_warn(ctrl->device, "resetting due to AEN\n");
> +		nvme_reset_ctrl(ctrl);
> +	}
> +}
> +
>  void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  		volatile union nvme_result *res)
>  {
>  	u32 result =3D le32_to_cpu(res->u32);
> -	u32 aer_type =3D result & 0x07;
> +	u32 aen_type =3D result & 0x07;
> +	u32 aen_subtype =3D (result & 0xff00) >> 8;
>=20
>  	if (le16_to_cpu(status) >> 1 !=3D NVME_SC_SUCCESS)
>  		return;
>=20
> -	switch (aer_type) {
> +	switch (aen_type) {
>  	case NVME_AER_NOTICE:
>  		nvme_handle_aen_notice(ctrl, result);
>  		break;
>  	case NVME_AER_ERROR:
> +		if (aen_subtype =3D=3D NVME_AER_ERROR_PERSIST_INT_ERR) {
> +			nvme_handle_aen_persistent_error(ctrl);
> +			break;
> +		}
> +		fallthrough;
>  	case NVME_AER_SMART:
>  	case NVME_AER_CSS:
>  	case NVME_AER_VS:
> -		trace_nvme_async_event(ctrl, aer_type);
> +		trace_nvme_async_event(ctrl, aen_type);
>  		ctrl->aen_result =3D result;
>  		break;
>  	default:
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9b72b6ecf33c9..0d7e9ac52d25a 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -762,6 +762,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned=
 int fid,
>  		      u32 *result);
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
>  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
> +bool nvme_should_reset(struct nvme_ctrl *ctrl, u32 csts);
>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
>  int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
>  int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5a98a7de09642..c57023d98f8f3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1293,31 +1293,6 @@ static void abort_endio(struct request *req, blk_s=
tatus_t
> error)
>  	blk_mq_free_request(req);
>  }
>=20
> -static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
> -{
> -	/* If true, indicates loss of adapter communication, possibly by a
> -	 * NVMe Subsystem reset.
> -	 */
> -	bool nssro =3D dev->subsystem && (csts & NVME_CSTS_NSSRO);
> -
> -	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
> -	switch (dev->ctrl.state) {
> -	case NVME_CTRL_RESETTING:
> -	case NVME_CTRL_CONNECTING:
> -		return false;
> -	default:
> -		break;
> -	}
> -
> -	/* We shouldn't reset unless the controller is on fatal error state
> -	 * _or_ if we lost the communication with it.
> -	 */
> -	if (!(csts & NVME_CSTS_CFS) && !nssro)
> -		return false;
> -
> -	return true;
> -}
> -
>  static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
>  {
>  	/* Read a config register to help see what died. */
> @@ -1355,7 +1330,7 @@ static enum blk_eh_timer_return nvme_timeout(struct
> request *req, bool reserved)
>  	/*
>  	 * Reset immediately if the controller is failed
>  	 */
> -	if (nvme_should_reset(dev, csts)) {
> +	if (nvme_should_reset(&dev->ctrl, csts)) {
>  		nvme_warn_reset(dev, csts);
>  		nvme_dev_disable(dev, false);
>  		nvme_reset_ctrl(&dev->ctrl);
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 29ec3e3481ff6..8ced2439f1f34 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -711,6 +711,10 @@ enum {
>  	NVME_AER_VS			=3D 7,
>  };
>=20
> +enum {
> +	NVME_AER_ERROR_PERSIST_INT_ERR	=3D 0x03,
> +};
> +
>  enum {
>  	NVME_AER_NOTICE_NS_CHANGED	=3D 0x00,
>  	NVME_AER_NOTICE_FW_ACT_STARTING =3D 0x01,
