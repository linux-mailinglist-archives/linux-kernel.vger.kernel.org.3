Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FB5524555
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350108AbiELGCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbiELGCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:02:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF2E6CA95
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoH9qHxEZUFLv82t8jgCTvV2J9nnXerPQTCseDrD8i1xmPfAyTwG3m5Ztg7MlAo2XPPqE83RFW/6aQ9Tlb3ZveDUX/UFAKMzgp2pc7VXSeH8nBr7BEnIO4PMEvW3G3JMxu1Pe5qCI6OQbSYIimtBFLRGjLUD39AAmD8Z5sm2OlRKNe0k/liKMFNirtWl94gNcspvxB5tqTS1QhsHvnqSlzh28ma8GjXCoWOZ4m4iJqlFbsmSNDdmJjiSe3L9Ddp0xhkbmKWNZiyjICYyAV4yta5NxBL8myxHwzWsk7mWQWViPQDfj//Afw2ddYMHuFn/QedJBFgaA/Jp/Y0wXecB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XucDPuxviraXIdag+qT0KMNBNN6KNMozYhbgrFeY0V4=;
 b=k7JnkL4szW+r+BkTmJf9JpxMsmWfV2QPXElX+JAfi9FsMXkTmEGdZyhFaaSPMA/uXE5puJ0Hb7PFMrNwO2MfDhxNJnShvkhubgbB0MgQQrAiI72NhFKeJzJx2lhqGcMthtSym+mdq5p9Ecm4+deC7snEzeUjM0AP/6zDqiSjywHvSBrAeeq3h0GxNrqswiKwix4NBicyEUkQUeSmbcj+2TgbNIVNyPtDfayAlbt6SVYlTldYuwKOjNe5J9ujYnKghqjUbZ2o7jCfw4yzC4IWSDJf+8zJSH8iz+go08Iqb2OoAJXDnyCCIZPD3NprVamoVfPyTPDQHxsN3uPxIFGUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XucDPuxviraXIdag+qT0KMNBNN6KNMozYhbgrFeY0V4=;
 b=gjcMMpyOkvK28XGxt4hq3qDstSjUSDpgQawY5Eiv58kKxdt336LLQ6U9Lz1e0Wm+LgEWZAbVD7MpaNqH/fFS4hE/EX2vq9ZRpOq06WQvrDRbUZ9Z949TzG5UwyibJflMmAMvoUnhcdheLSqSxGaiYPwXo0vLsEuewT9djz51Us4MU7cRaiDFTHSYzTlizRn1EnIcW3fs2zyQ4Yy0RDu8Tns4G3F2Ndu8l6E/SHOiHTNVrGnj6SQyo/R2w4bIu6PE11vX7oXQ+HOKKFIhznKenX3+WxsrDt+bD7wQVR3TNFm+0NAnenXe23sKojrVUQPTfX3ddgJDrCCf1IauFxhwqw==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Thu, 12 May 2022 06:02:43 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5%9]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 06:02:42 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
Subject: RE: [PATCH v1] vdpa: Warn if MTU configured is too low
Thread-Topic: [PATCH v1] vdpa: Warn if MTU configured is too low
Thread-Index: AQHYZSXQkvDSxjYK1kSGW4GgpWe2qq0av/0AgAABD2A=
Date:   Thu, 12 May 2022 06:02:42 +0000
Message-ID: <DM8PR12MB5400970537EFD6A0B4C5C8FEABCB9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220511105642.124806-1-elic@nvidia.com>
 <20220512014128-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220512014128-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65660551-decb-4463-67a0-08da33dd0747
x-ms-traffictypediagnostic: MN2PR12MB3039:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3039822A0D4FDD1A57BD967FABCB9@MN2PR12MB3039.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: beUxQtXh90hPnZuBwqdwQf5GZIJ78nnyhgBQx5g5Xtn9jbz2i3eSNoFnHSKz+CMPaF1Z6jYy9mIIyqpu5lYDlDmGriUdwdvPOFPhQEr38W3t7byDpPR+ZJDxbxH02hte2U8MQw3z7jfr01Da5gS3lR+wh9X/GyPpSkm7VJoIpvEi5Rj8J03Q2wKRc9FrHzjmJ8+wkclFx7g8LtUMZ+LxC4BoqISRaK4lBQ4rAumRcQUMoanSfwjx9FU9SYgr4tnOuIJ6CnOb8ChRwxQRURbq/F1DKOKOrSK/ruh46njj+SuD/3CZbuaGzL5pEeeWmR6dWzAxuvt8ohwyfAqxGBCcdb3WmJSPWTMcoslU5iMoPS9TjKBJvw2gRBeJBpKYd8deAQ0kXbx1QDIY39cflyxYOg+Y/rY3ymI7hn8jOeMfZTeU6w90Fulfr6ht8ELGJI4LiuzFdIl6ikPwXN1gHmDCb9CFpQN5EXr35BfSmdHHsV4sv6UCOWPl/eplMhsMAwhlfhsoSO7I/AM18aiSBB1EPIe6g2/ANHX3TzcT+XkPUHUWO1tzNM+jZ7dsD/ozNYI69EjHyg8GQsjbxm86vAt2JB4pLOCAIyJpw/YUArgEFqO+DH4e2+XUhK1j3SEoaheOHxn1ERXvlWF6rFafrpUs+aiz2EdcjtrXFQnSjwvc1d2g6+QTqiEtchmLFYRVCm/ZeOQ8F1eog4qXQADyO3FrXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(38070700005)(38100700002)(83380400001)(2906002)(5660300002)(186003)(55016003)(86362001)(8936002)(52536014)(316002)(8676002)(54906003)(66446008)(66946007)(6916009)(66476007)(66556008)(4326008)(76116006)(64756008)(26005)(6506007)(7696005)(508600001)(71200400001)(122000001)(9686003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hq3NBdQDAOei2avuDzr+wpotkDnUSKOL8w0txyWOIYkLUYtzCmYOgnsQFwwr?=
 =?us-ascii?Q?2Ap5dysqDfOINUb1jpC2wYCOda7MEV5DZtvvAedyUioiT/Ggz8zUudU/XKoe?=
 =?us-ascii?Q?UwFtmeFLeXupXhdJfy0IPHSiy8Pn+V7FTkrfDVh9aS9jIPZ0NaLTGd4+AfDI?=
 =?us-ascii?Q?0C5tNaJvoByMg1FE9E03TGCdtFc8Iw/xf0owx+vtgT5cBghGqx5yzOMmHxWv?=
 =?us-ascii?Q?FwHN3dHSxLBni8DPGGWCHWuayg7vmCdXQ4E35DUPkmYyV6ckpjYZkxktKt3M?=
 =?us-ascii?Q?UtudOwWdKSMPM3jEhjlpxubDXhHiPxjOEpX9v2aSzEc3iYbnynUlupa+OTnq?=
 =?us-ascii?Q?E9I+Yb8oCaSeRc2TIOHT71Na4kTyVMcA9B7qrdb8x+G4ef7Qf8Ze8pk6TQ/x?=
 =?us-ascii?Q?RMo4Iig0RNsMLX+jeT3vtlyHa8AMKZVnTN6iT2oI2AZpQ1i8gQVeXY9zDg66?=
 =?us-ascii?Q?cPJ0hG23i7Cu3jRbu8e2V0Vu9EGcZoEynqVDE2hjwxCV7d9iaInzrc50hNwp?=
 =?us-ascii?Q?hP/UyjMEEdSuSBFZzLhv4eNc1cTT33bTziD/j4w4TTfpaS9s0LB8HV2+AAU6?=
 =?us-ascii?Q?w9t3gpoXzLyhQA+P85PUGRaCPcaLhSZ5BwL67AchIEzzqOL+jmeeQwKU73nk?=
 =?us-ascii?Q?y3hiCRU82pCjespH19uhSirgCxGu/fcvjOFBZ9dA+f5ErKPkapX+Jo25iK8b?=
 =?us-ascii?Q?3miO7OcqiWhvXRNvPp1LccbpVXMFV36aVaaJPJgRJgKBX87D9F9O8dA8rsl/?=
 =?us-ascii?Q?YJU9gyIM5xFd1q1419b46Co79McpJGgkxkVygbp3Z4c1us0ziqE3MJwB/yRZ?=
 =?us-ascii?Q?LbRc3l7asxVcMpGx9m9Ce34Zac6cWIeHXZ8f/NLWbEY28Sl5Ai0fclrjDUBC?=
 =?us-ascii?Q?2qCgQtLyTxwRkhvd9JVOwljWdQ+RdKD/J88WDNi2j1HxRZ+RXzzQQL8YghUp?=
 =?us-ascii?Q?tyAF36CFpLsQke4qRU8wYa2eie/xG6iV2es4QAtszmlSR6gRTTHSoSlVGW/x?=
 =?us-ascii?Q?z8rMXnqCp2JfIfsLX5Vq7OYLUS6tFV4BilLmziOeNZw3J+Rk2iXzPAYZJ3Sm?=
 =?us-ascii?Q?AibmgCMJLeZyDLJtq1Zv52JsTXBTnWS2XObLBVQOP/c/ViAuaNhdy3dmyz9a?=
 =?us-ascii?Q?WAjklf6a1BpnEmGQ2CtKXbiFwR05qTvQIdpLZwZ5q8eMYqBiFsygfuLQluRJ?=
 =?us-ascii?Q?yP0mCvteEnAHFlA54HjOISrhoeoiecRpdcIymh/xNkH0zFaPMaqmmM7KjBLD?=
 =?us-ascii?Q?aNr/z3Jaxi69sBWmY4z+PYUvKyp4AjLWMNf0dJalzqnJph9ZM7ZLEaUSnPS8?=
 =?us-ascii?Q?Vcy3ofORLmic2PW4nGnZEAzUD2unRIKH1Kyqk7rFP8zu6/3sd1niNAyjgBr7?=
 =?us-ascii?Q?BVFUB3oLdaFE/M1KJ6Tb9gEoGoE2tOx5eyOjs4avES4yvcWSzxIoSMoyWKme?=
 =?us-ascii?Q?8oamNDzlgCQXHEy/6Szt8V9gnCkxyd/lVG7W9dkvftvCBzIpI7a6Gepl5O4Z?=
 =?us-ascii?Q?fhcG2wj5lvVrvAddP6OGvhVf9d6UehhiQY9A1FAmE+Q1l3wJx65Xcg29ioKG?=
 =?us-ascii?Q?LRVqMuNBXOyfG5xSReclZarTBvhDCRch6kk55gE8YOKnfBoKUgBRZ0zzbwEi?=
 =?us-ascii?Q?1h2utlxMI3U1hoWu+LnUGToz9z2hKilSYqnTUp0YIpIYAB9jjPcAMpJSmYcq?=
 =?us-ascii?Q?VyD4tWp6L9X6zcvKpfvvBMwd+LT2jyhe5iynjP65KBXzoW+w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65660551-decb-4463-67a0-08da33dd0747
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 06:02:42.8943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsqbCKmwkwIkhJSP6WP15X7tpcnn39xcbjyFyYazuuXrRQrHQ+s9bR6pCca2Y4D6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3039
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, May 12, 2022 8:57 AM
> To: Eli Cohen <elic@nvidia.com>
> Cc: jasowang@redhat.com; virtualization@lists.linux-foundation.org; linux=
-kernel@vger.kernel.org; si-wei.liu@oracle.com
> Subject: Re: [PATCH v1] vdpa: Warn if MTU configured is too low
>=20
> On Wed, May 11, 2022 at 01:56:42PM +0300, Eli Cohen wrote:
> > Following the recommendation in virio spec 1.1, a device offering
> > VIRTIO_NET_F_MTU should set the mtu to at least 1280 bytes.
> >
> > Print a warning if this recommendation is not met.
> >
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> > v0 -> v1:
> >   chage pr_warn to netlink warning to userspace
> >
> >  drivers/vdpa/vdpa.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 91f4c13c7c7c..0fb4a615f267 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -583,6 +583,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg,=
 struct netlink_callback *cb)
> >  				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
> >  				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
> >
> > +/* Recommended virtio spec 1.1 section 5.1.4.1 */
>=20
> I'd add name of section here too.

Sure

>=20
> > +#define VIRTIO_MIN_PREFERRED_MTU 1280
> > +
>=20
> Preferred is kind of confusing here. I guess you are trying to
> say it's not mandatory but I don't think this conveys this information.
>=20
> Recommended (matching text below)?

Will modify

>=20
>=20
> >  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct ge=
nl_info *info)
> >  {
> >  	struct vdpa_dev_set_config config =3D {};
> > @@ -634,6 +637,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_=
buff *skb, struct genl_info *i
> >  		err =3D PTR_ERR(mdev);
> >  		goto err;
> >  	}
> > +	if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MTU)) &&
> > +	    (config.mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) &&
> > +	    config.net.mtu < VIRTIO_MIN_PREFERRED_MTU))
> > +		NL_SET_ERR_MSG_MOD(info->extack, "MTU is below recommended value\n")=
;
> >  	if ((config.mask & mdev->config_attr_mask) !=3D config.mask) {
> >  		NL_SET_ERR_MSG_MOD(info->extack,
> >  				   "All provided attributes are not supported");
>=20
>=20
> Pity we can't include the actual value here, but oh well. At least let's
> include the recommended value, we can do that:
> 	"MTU is below recommended value of " __stringify(VIRTIO_MIN_PREFERRED_MT=
U) "\n"
>=20
Will change
>=20
> > @@ -1135,7 +1142,7 @@ static const struct nla_policy vdpa_nl_policy[VDP=
A_ATTR_MAX + 1] =3D {
> >  	[VDPA_ATTR_DEV_NAME] =3D { .type =3D NLA_STRING },
> >  	[VDPA_ATTR_DEV_NET_CFG_MACADDR] =3D NLA_POLICY_ETH_ADDR,
> >  	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> > -	[VDPA_ATTR_DEV_NET_CFG_MTU] =3D NLA_POLICY_MIN(NLA_U16, 68),
> > +	[VDPA_ATTR_DEV_NET_CFG_MTU] =3D NLA_POLICY_MIN(NLA_U16, ETH_MIN_MTU),
> >  };
> >
> >  static const struct genl_ops vdpa_nl_ops[] =3D {
> > --
> > 2.35.1

