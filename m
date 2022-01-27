Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B649D9DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 06:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbiA0FNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 00:13:38 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:52608 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235130AbiA0FNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 00:13:34 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20R0To1H006271;
        Wed, 26 Jan 2022 21:13:31 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3dugw3rnva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 21:13:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTVU6EViWIs5kRLngeCAzjCjbSeuGekJPjvLHoiGTN+SKgJq3Y7WGJVhNCouDP1bPxT2Izmt8Q45WsWRheaxqXouYRUIX5BN0NFsFbk+iKcZLX3VVa/qduOO5GSrMselBTTDIio9uHIypJkooZMPSHjcI5bhqb/a4MrsJDFWAoG7GecNM9cz75gTvt0OR7EhlDM3lgCCYFDurY8W5Bd5BHNYLAhd/YDs8YwURq/kjIU9aPgcSfgpa7isHT3kMwTqZFejZNYUDN62Eu6tlwnuHZEreWfsw2yYQKumi12t6UBTXlqoKuiLsqvQot22ylJmKbXvKKZJSUn1JOrWNffZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giApJze2VdvSCBNKS+UhiMrsU6TdVz/aFghEZwvlW38=;
 b=LvxATLmmYvPOgd3WYcJyz1REffaK8bZOSn0XueliJNqqO0DN2ORr5Fs9ilXGiqXJQBlE4LoX6RqYxAO9hL+6/MhZmroMxdwW/44VueOt82Tfh/1pk7G/Hd/Pe6yF2oBxD9j4uwtUNLhbziR8NxCYBW2eHVaGJ0jG5MzXuJIOipeFFJ8yz5xrxChcKkNg8wNj4NOKr8E1YM4okxWMtxBGKO108BcHS/ABpjt2NC8RqR///A4ekGAh1MjrKT9YouHoj/lV9nGiKUbWWqKAF8I36/BFbzph5hby4jhaGE3LMq00U6iDeF66S7I3JULALzFJfBWwB+HDZIv2msk9p4VyfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giApJze2VdvSCBNKS+UhiMrsU6TdVz/aFghEZwvlW38=;
 b=h4DXgReaqsJFL8fEe46UFgr9UpRy+3diDs8M8zoFnGxo7Nm7s1Df/qU8tSF/G+5usU6zKy6Ehpk430gvhuDytnyMU4Ytk6uqn6ngq9YbWKLwzy5ZwOiuKe71ZwC/v2K0gn84kFHeTYenJgzh1kiJK4LVTVh23pM7//NZ+MZ43v8=
Received: from DM6PR18MB3034.namprd18.prod.outlook.com (2603:10b6:5:18c::32)
 by CO1PR18MB4762.namprd18.prod.outlook.com (2603:10b6:303:e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 05:13:29 +0000
Received: from DM6PR18MB3034.namprd18.prod.outlook.com
 ([fe80::bdc7:54c4:7093:290c]) by DM6PR18MB3034.namprd18.prod.outlook.com
 ([fe80::bdc7:54c4:7093:290c%5]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 05:13:29 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     John Meneghini <jmeneghi@redhat.com>
CC:     Nilesh Javali <njavali@marvell.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "mlombard@redhat.com" <mlombard@redhat.com>,
        "guazhang@redhat.com" <guazhang@redhat.com>
Subject: RE: [EXT] [PATCH] scsi: bnx2fc: make bnx2fc_recv_frame mp safe
Thread-Topic: [EXT] [PATCH] scsi: bnx2fc: make bnx2fc_recv_frame mp safe
Thread-Index: AQHYETHkX+VvWQpirk+ddWzmPw4vqax2Vqzg
Date:   Thu, 27 Jan 2022 05:13:29 +0000
Message-ID: <DM6PR18MB3034D4C12A94CF3121F8B565D2219@DM6PR18MB3034.namprd18.prod.outlook.com>
References: <20220124145110.442335-1-jmeneghi@redhat.com>
In-Reply-To: <20220124145110.442335-1-jmeneghi@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46e3e6da-fe34-4237-81dd-08d9e153c164
x-ms-traffictypediagnostic: CO1PR18MB4762:EE_
x-microsoft-antispam-prvs: <CO1PR18MB4762EF22835B6FAB8F684D3CD2219@CO1PR18MB4762.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uKU6QHtoWnha4ZVUBbiff73tlYA4nJHgVQ0Pv48XijmtBRKH4FLWQyySIF0zM8GWieivWF8nwezPdutQe/ULr52yIlWsIKYuSSgwkqjRwD79zaDPUWw7pbHHe9jq+buYJAE3sOR9qpMZbOnpmyRXEEVD+SOD/VmC8aI4Ppz0zjYcc4gmjot3MQE2+C0bKfHA07l17jOnPmKrJ0or3rXpWZWKKnUDRH6S30Ej+SzuKv9Olm0JTTqdac+22r4ZdMwOOD5eM2pOTL0eg8g2vYCRY70EBUfDUR9KOhk2v1un6BgwGq616skH07KVQL6kqoTrUGnt7kaeqv3QJT7R3AsIyNYtXfg1Wl0DOp6c9Lh6Qtwk3TJHB/h02dQm7mF3Ho5TwNzGlBtq1x/qPxCA1f+WqmA2Z2RgXxJPrhC6L1goKf+3ALRE9pL3Qe2e0P3j3YEWvxCqFFPNqhxYUyi8KrI+4qkNwNzP1isHTpxwHxaHdUiPczPk3BF7vA57CYg20XvLtE7tDRhqxOfEChdKFWgLLfFPYcY89+4nippdlNkVmc5hme1arWIfIjTaoCs2YA7oVcsoJWRUcw71FMUeolt8egNe12ABq4jMOwRzwxFJZSBxijIc+RKmKrfP3Dax0Wmjf4D4Kf3+yk08poN5AusNeyVy6O9T7WB7SLbc8/WnE/soc9UEv8LTGhAIAq0fm3i2IoRGcjI2dtt7JEEZXfMCjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB3034.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(122000001)(6506007)(38070700005)(53546011)(5660300002)(86362001)(8936002)(55016003)(2906002)(4326008)(8676002)(38100700002)(52536014)(7696005)(66446008)(66556008)(64756008)(66476007)(6916009)(83380400001)(54906003)(508600001)(76116006)(66946007)(71200400001)(186003)(316002)(33656002)(26005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pGJjf5/4YhCg0gRSDrGzWNzxcpsNaxolnHkNbKr/IVqobq/2ZaEOKCMdhPh2?=
 =?us-ascii?Q?vS1QpW6aWC9qFU/s68b7DvGQUogbeNvmAT4+lU2nFpp4qwH1g88GvHHaeFwG?=
 =?us-ascii?Q?pB4maq9CmzoDrY3mtbUMrTQp2+OsAchlf4u/AIOz2UawPs+jH0SifV/rd9iZ?=
 =?us-ascii?Q?OIu+q8s1r2vhP8eovkaQMwoomG77WsU1pN9k6ONkICZKy/8YnxD2tu9uSsl5?=
 =?us-ascii?Q?IUS5jpcGL4tuoPOFWL3+6JgIL0dp+l6II0o0Lj/VlReWMPYUiJ51cAcbYP98?=
 =?us-ascii?Q?nGdpqYOG5GfZ7Tgz636Sb31TIu1xF4eT3C+ZSbF1bP4dwjfE06dYi57c0VAg?=
 =?us-ascii?Q?P6ppPIkOoiZn91+XDPV2fe2/9j9CDM4nUIZyPMylijSc/to+kfEVpRejpwXp?=
 =?us-ascii?Q?scbnjyis7XTTe3QBdT+bppFAAblja7PBLbdSkLM+P1+G5f0O+Yl1lIzoo39Z?=
 =?us-ascii?Q?IDZQ0CJtmTpBpB2roallnl+9kD5PPG0ho7eJWwZXXJ0Fdmho0pWcfycB3Sx9?=
 =?us-ascii?Q?sCB+IjEc3BcBitL2I6OzRGjd8L/j8ezd93iG+SuQJm7rRJjuc7BxwVEzI31Q?=
 =?us-ascii?Q?IMcsU9KVrNc7HEaItHxm3zA+8WdDDtf5Ff1ku0MP/yPJQHEjqvRB+76Fx0OV?=
 =?us-ascii?Q?sxYsES725cBjxg9yR0p/P6nbAp6TPG3vSGDzf/nGNOG+nLdMUqpAmDhLN8GW?=
 =?us-ascii?Q?z5goYxjE8afEddz1WO08iL9LSHnkcynjGEb+8vdcB22ACQzgAyC7xWu1Ub8S?=
 =?us-ascii?Q?Q4beNnrtBJ04HA+e9RhSxaUdxodltMc+8fWPfHHZS4KZbdbuidFEdIt2daYx?=
 =?us-ascii?Q?1mug90SdHLQu8veBeKs2F4S4NflIewkXHqU/SmNwWbekx9B7uEzjWHm9X4g1?=
 =?us-ascii?Q?n3+RZhfoUFyiqduMQzfwfqkUeovG0/UNxYnQbcmgjyQALgHlOuiVG3aSmL6o?=
 =?us-ascii?Q?fGArJY6sBrv3JqNrioWe0tDcI4kxNQt/PD8wTjnW3c0aG91egKiundjbIdqk?=
 =?us-ascii?Q?0aWPq83fdM5+W9HV2Ikd+Kmt8OuIYqSYx63HzU/j3bSj/p1ukIFnJxqaNtJm?=
 =?us-ascii?Q?LWye0n/wHBj0Fw1bYRa7OX7sHAvICokklXJ3qtJSDWg7//mZ1jwqazKT6dQr?=
 =?us-ascii?Q?o3gQu8/v5hYXpS6yhG/NM+frlnejKB5zNwdoEFqlzwjkTDR6peGNRSQND2Ma?=
 =?us-ascii?Q?IMIJgLPMoTJSwyr6AL4PpBtrVbvYv55fzUSd9/Kq3ji6YTb5A/7gWl6ufrVT?=
 =?us-ascii?Q?5htRkKN16nrflfOlQ5Un2u4+l7Su5P82v+vXsh8ziWgdcSsH3hlivug10IdP?=
 =?us-ascii?Q?FE7U+tb5fe4iW0cd7kO8hRG8dRdN0eZaIG9JpASJEV5J7HXZC/0IdHB6TAcU?=
 =?us-ascii?Q?62mcFwOvX6eWRWLFuQv4s4n00+PxIBHQyowcC9+O8azccoJ7sVMIeCtcoTXw?=
 =?us-ascii?Q?zni1JGNs/RuxAaKTIxwz7Y5Sgfn1oLVRXNeFE0KbSrzq2P2Psa0eeL0r+a6y?=
 =?us-ascii?Q?Bl1qvcv4yz3jVF/gK+jBoaeGYo9nq4RM4L9FWudSmnK2wHLoqte4s1W89HyR?=
 =?us-ascii?Q?Zk3NbZucUJ29Q4muc2++xdTH2UIaX1NlUbpu2hPHtWNB608HtTR/i9nVYQPu?=
 =?us-ascii?Q?oef3Ven1enNmJ8WlsPZ+4IE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB3034.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e3e6da-fe34-4237-81dd-08d9e153c164
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 05:13:29.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UROgSYsqnhCw2dDAe5y9p6jKNuHg9hz1g4N8om9ZW601zQRqYKayeEYZtA5x1g15k4zHlsatOsKC4VJ/2i92HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4762
X-Proofpoint-GUID: OMzcWkXlyihKFMguB6WibpQHhQG9UKvG
X-Proofpoint-ORIG-GUID: OMzcWkXlyihKFMguB6WibpQHhQG9UKvG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_01,2022-01-26_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

> -----Original Message-----
> From: John Meneghini <jmeneghi@redhat.com>
> Sent: Monday, January 24, 2022 8:21 PM
> To: Saurav Kashyap <skashyap@marvell.com>
> Cc: Nilesh Javali <njavali@marvell.com>; linux-scsi@vger.kernel.org; linu=
x-
> kernel@vger.kernel.org; GR-QLogic-Storage-Upstream <GR-QLogic-Storage-
> Upstream@marvell.com>; mlombard@redhat.com; guazhang@redhat.com
> Subject: [EXT] [PATCH] scsi: bnx2fc: make bnx2fc_recv_frame mp safe
>=20
> External Email
>=20
> ----------------------------------------------------------------------
>     Running tests with a debug kernel shows that bnx2fc_recv_frame is
>     modifying the per_cpu lport stats counters in a non-mpsafe way.
>     Just boot a debug kernel and run the bnx2fc driver with the hardware
>     enabled.
>=20
>     [ 1391.699147] BUG: using smp_processor_id() in preemptible [00000000=
]
> code: bnx2fc_
>     [ 1391.699160] caller is bnx2fc_recv_frame+0xbf9/0x1760 [bnx2fc]
>     [ 1391.699174] CPU: 2 PID: 4355 Comm: bnx2fc_l2_threa Kdump: loaded
> Tainted: G    B
>     [ 1391.699180] Hardware name: HP ProLiant DL120 G7, BIOS J01
> 07/01/2013
>     [ 1391.699183] Call Trace:
>     [ 1391.699188]  dump_stack_lvl+0x57/0x7d
>     [ 1391.699198]  check_preemption_disabled+0xc8/0xd0
>     [ 1391.699205]  bnx2fc_recv_frame+0xbf9/0x1760 [bnx2fc]
>     [ 1391.699215]  ? do_raw_spin_trylock+0xb5/0x180
>     [ 1391.699221]  ? bnx2fc_npiv_create_vports.isra.0+0x4e0/0x4e0 [bnx2f=
c]
>     [ 1391.699229]  ? bnx2fc_l2_rcv_thread+0xb7/0x3a0 [bnx2fc]
>     [ 1391.699240]  bnx2fc_l2_rcv_thread+0x1af/0x3a0 [bnx2fc]
>     [ 1391.699250]  ? bnx2fc_ulp_init+0xc0/0xc0 [bnx2fc]
>     [ 1391.699258]  kthread+0x364/0x420
>     [ 1391.699263]  ? _raw_spin_unlock_irq+0x24/0x50
>     [ 1391.699268]  ? set_kthread_struct+0x100/0x100
>     [ 1391.699273]  ret_from_fork+0x22/0x30
>=20
>     To fix the problem: restore the old get_cpu/put_cpu code with some
>     modifications to reduce the size of the critical section.
>=20
> Fixes: d576a5e80cd0 ("bnx2fc: Improve stats update mechanism")
> Tested-by: Guangwu Zhang <guazhang@redhat.com>
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>  drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> index 71fa62bd3083..e41a94dc2d1f 100644
> --- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> +++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> @@ -508,7 +508,8 @@ static int bnx2fc_l2_rcv_thread(void *arg)
>=20
>  static void bnx2fc_recv_frame(struct sk_buff *skb)
>  {
> -	u32 fr_len;
> +	u64 crc_err;
> +	u32 fr_len, fr_crc;
>  	struct fc_lport *lport;
>  	struct fcoe_rcv_info *fr;
>  	struct fc_stats *stats;
> @@ -542,6 +543,11 @@ static void bnx2fc_recv_frame(struct sk_buff *skb)
>  	skb_pull(skb, sizeof(struct fcoe_hdr));
>  	fr_len =3D skb->len - sizeof(struct fcoe_crc_eof);
>=20
> +	stats =3D per_cpu_ptr(lport->stats, get_cpu());
> +	stats->RxFrames++;
> +	stats->RxWords +=3D fr_len / FCOE_WORD_TO_BYTE;
> +	put_cpu();
> +
>  	fp =3D (struct fc_frame *)skb;
>  	fc_frame_init(fp);
>  	fr_dev(fp) =3D lport;
> @@ -624,16 +630,15 @@ static void bnx2fc_recv_frame(struct sk_buff *skb)
>  		return;
>  	}
>=20
> -	stats =3D per_cpu_ptr(lport->stats, smp_processor_id());
> -	stats->RxFrames++;
> -	stats->RxWords +=3D fr_len / FCOE_WORD_TO_BYTE;
> +	fr_crc =3D le32_to_cpu(fr_crc(fp));
>=20
> -	if (le32_to_cpu(fr_crc(fp)) !=3D
> -			~crc32(~0, skb->data, fr_len)) {
> -		if (stats->InvalidCRCCount < 5)
> +	if (unlikely(fr_crc !=3D ~crc32(~0, skb->data, fr_len))) {
> +		stats =3D per_cpu_ptr(lport->stats, get_cpu());
> +		crc_err =3D (stats->InvalidCRCCount++);
> +		put_cpu();
> +		if (crc_err < 5)
>  			printk(KERN_WARNING PFX "dropping frame with "
>  			       "CRC error\n");
> -		stats->InvalidCRCCount++;
>  		kfree_skb(skb);
>  		return;
>  	}
> --

Thanks for the patch.

Acked-by: Saurav Kashyap <skashyap@marvell.com>

> 2.27.0

