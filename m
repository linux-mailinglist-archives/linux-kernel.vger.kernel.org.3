Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEDD4D3C92
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiCIWGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiCIWGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:06:04 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20075.outbound.protection.outlook.com [40.107.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E960101F06;
        Wed,  9 Mar 2022 14:05:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhLFuWzydzFWWMd/f6c0Eer+HjkJdzj0K74Cr36i1Evj98KuKKzNj7hIBib5Hwe13CSFzuODAAWozVRvENsvLex2+bzLaFJFzIMewNSMnlTRfNmF0rBIMCR7RfG47jm66vYS3OxoxLv4oKFhh1KgRKnWVxXDnd6WktSiNG0Jgithd6qMXrK0VfF/WPXFWCy86aODZHlTnNvs6A1EL44Pv/ar8OykX22exp75BpNFaBHH1H/p/CuR/bb/0GY20idkYfNugUej5n8b6SZq7hWR8TqbcZDweyUwuNYxzysKorWY0ZM5cGdQcdMXfJ0pY2Fo68Gz40m3xNYznQX6yQDgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdtUkZBakFFIWKIh3ukb7MTZG2Fpo0rS1mOke8VP+Xg=;
 b=f17O8gY/cbAJH/36PQv4TpAdJaZDspMoDWGXj2sRhYsvt4++1tXO+EodVMA2fIunsU6sIHTf+7dDgFkknK8vJq0dab/KWANX0wFYjSwJzKL9mgsT/eM+vO8x/cf8bNCXmJpMyxE7JqaCpwSR+jsj5yvn40zYh+xeIouWjSmVixHnRYMSV+9lbECNdBlcDK5DuSF4WjgDFIqcaXXBaMMkvDgJmpUAwjjB0jtBUpeBXNeufkmQMvNSfXL3hhGkkjdamqJOEMvQXlH3MnyB+rx93+vd4tmh4zW146PipDJxv/IC79PKMa0/cl2OX6ip3TOva9r2vvP5zbrcr5bo1nnKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdtUkZBakFFIWKIh3ukb7MTZG2Fpo0rS1mOke8VP+Xg=;
 b=QpqkDale5FslrwGQrv+2pG42rDl7CLeBd62AVHY/v+bX1b5zUkTHBw4bgLcb1LhEj5mnkIlX+tcEgOWbRR5HhmbKjnfN7gR01ybAMYCkDYmIjhQpP1t9o+m7mraNUu4IdE4Y53HautiwDIVpfzyL+MiggihpM8u7OSCZvAryrDA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6063.eurprd04.prod.outlook.com (2603:10a6:803:fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 22:05:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 22:05:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/2] remoteproc: support attach recovery after rproc
 crash
Thread-Topic: [PATCH V2 2/2] remoteproc: support attach recovery after rproc
 crash
Thread-Index: AQHYMrLihGYki8t5pUaIEFqC+w9Eway3ZJOAgAA4x/A=
Date:   Wed, 9 Mar 2022 22:05:01 +0000
Message-ID: <DU0PR04MB94170220090D96A5D961F9B4880A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220308064821.2154-1-peng.fan@oss.nxp.com>
 <20220308064821.2154-2-peng.fan@oss.nxp.com>
 <CANLsYkw2zuquHEb1SiMR6TTy-w329GCXw4mE=Jr_tecKdzvL4A@mail.gmail.com>
In-Reply-To: <CANLsYkw2zuquHEb1SiMR6TTy-w329GCXw4mE=Jr_tecKdzvL4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8059cf2-49ae-4468-564b-08da0218dbd1
x-ms-traffictypediagnostic: VI1PR04MB6063:EE_
x-microsoft-antispam-prvs: <VI1PR04MB6063F5DD460B74539EFD9991880A9@VI1PR04MB6063.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mJ6R3/k/KluMP+RNFppa7w0M8hSE+YRTs2j8ser2GBeXnpUdQiadWkYy5GsFwihcmAzkG0kZ4gLc+zowMY2VdXLvr1+X5SBadEPc2H1cpVMXCS/hF5ts+dUXGWnrNnc8fORGa6SvqammwBVLmyA3Mk+EyoBrI/BcNQWRx3D+OKzQDpiWfZoEhYxEQtY0K/dxljAmVWtWWevh8ylhBL/7qDWtf6f/toZsYeFfeYkjPgpN9wpLmMrb1xCCgi3yu8H8yi+PNu7axQ5B+5905NDxTfumx+E0H25IDLSWSmDco8UBLlBOeWpm4oePINvTLQScP9W5A9YpFosd0QaU+F7v77xI9A4WBgXEEaUVrdJhWSsiBBPfECeuKhnjJ+6FD9OfF0LZJlYzW2L5x2aL14cvgQf177auXP0qY0Vxplsdjemw0hzVYnPH3Me8ztlVeXUlpQw4McSbmc+zDSkpq/WOwin5zIf/R81+MmQpkI2DDXPplxBAdaSCWegcQIi6CAj7Vdtd8LCjlTh7MXaDsfr+7HNSEK9WDLsNId8y3p1pCMVgFAwJRVKU4DYYQV6RMA4gOO3AfcPkixThHIGG+KIaXOTqbV8tNkBWjKzjhr6BxTwFplWnOIzzgYRUf7tQJbyE9t8wBor7J89x098uqVy5wE6gCf856DSRT9W689pUbhFEHq6sO/pYSTJGQq9C/G62cT7wewDYIRWdBOAtf8ryJkW780AVnOcuhxAudsGq6AOSKNrXhfbbVA6wTsa8Ge3vHn0ekJbKI1hpZaFknpuOeMAQq2Z/eQE7z+zshbQxWCY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(186003)(5660300002)(966005)(52536014)(2906002)(76116006)(66556008)(26005)(66446008)(66476007)(9686003)(8676002)(55016003)(44832011)(64756008)(4326008)(83380400001)(8936002)(38070700005)(38100700002)(122000001)(71200400001)(498600001)(7696005)(33656002)(86362001)(45080400002)(110136005)(54906003)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FtFsgiI8WuegEawJd2iI1hYxKAoznqzUfPlMHja0oCNY5P7TzS5Fc0G9Tkw9?=
 =?us-ascii?Q?960dqlxMx3JY+RoEVcCBI3PWadvW/28sJlwwbq7JGAl9graXYwgh3KZ1QJA/?=
 =?us-ascii?Q?Xjxug1C1SKsLFcx4K8a4xp8D8g22lA38Iu0STvvAHLnYtLhfTkpWdeHKkyEa?=
 =?us-ascii?Q?1jXpMTAswmXNdyW+SGS/GLJF2LLxAzgPIoNH4+epqoWgIgFafXwFxOc/KCuj?=
 =?us-ascii?Q?WKSy9vQpjcj8R8GvF/wasRhBdcIpHO0Zw9y5y0HG3l6DXMgCaS8/7SvVivpH?=
 =?us-ascii?Q?rzSownH8Uib+KLOeHhHTTPHJcH/uX20jCDXY6KBmLSKi146t8Yvy8lbB+03w?=
 =?us-ascii?Q?wOphgkwV9ayU6nX9IN5gK6Ynb6WnRnNPLOFc3cre0EstrpADuD+3ibIYhtxd?=
 =?us-ascii?Q?7kjg/fT/mjkX2LgY/3/JypsO0TkD1E+wNiWvcO+LEj7zvW2YaYFYrTPlTJ9+?=
 =?us-ascii?Q?662JgJjXSMcXfElo22tzdPLe6YyGHUw0m364sjQq5s0llgZLmU+XPS1I2rlu?=
 =?us-ascii?Q?9oMet740rfoQpKoU0DlA4uTAprI8RyhVV2CCzQSjkuad7VSO8Ma5zSGqkV+5?=
 =?us-ascii?Q?y6ABtBZd2wf0sdOaHreEtZ+f2u06LoIdXQLepYrmhwOaN7fvtS3LXrEjnCKq?=
 =?us-ascii?Q?+tdDQgcBWeNfxD3qsAIU7+50vE22BJhsJiuQMwPPlhjjPreIokJfIfPL4W+m?=
 =?us-ascii?Q?3f96QB85SNDbj2q/ryciSUanp8ktGlYy1H4uE821xh+HRuzb73+cZiaRadl0?=
 =?us-ascii?Q?kuxMWYwqb1kSXkZyObTUtQAhr7hndD1nGjjJ6Ym0wgJBAvfsaZPhqSB2ELEj?=
 =?us-ascii?Q?dweAbBNx1yD5pG0jggfxcAQCPMI8aYRxzzdjYnSk47lx6YDeTGte2zn/HT6J?=
 =?us-ascii?Q?tcVzLSaAhx4yW6X2fPCKuAwAwF0MARVvjgwJiOyfAQ7Cdttpf2QTV7xNVWFH?=
 =?us-ascii?Q?4vNLDIRunWGB/CWI4g8jqEs56FdvCbvdJ+z4cKf1v0ILgQ/MJQlDSgKzYYwa?=
 =?us-ascii?Q?+aR/Sw0SRv73oBBz5NxeQBYHVzx2SNyZo/2RgoznswYc+hH0cLgerj1fbug0?=
 =?us-ascii?Q?cVwbnqnFDiH6oz/+MfeAkMPjrsuwIaX0cvxD4Y8H4lPy8srDZkR8yGelWxfo?=
 =?us-ascii?Q?PGrRrZMRM0Eo3gjeatC4LG3fjS6R3uCBYiKhW9N0kt8b5dHJsBmW+X68Ibps?=
 =?us-ascii?Q?34h6lHsGONAobXLcgW5UwHp+k267FV8mVBDwXOdKGtMLq+VSjWay4JaZ8qZ8?=
 =?us-ascii?Q?VB1zfXuR3IMj4vf+Tqa82RqPnitiY5Ze/rc2X6Wz1KVbgqqkPN3s9tYStaM8?=
 =?us-ascii?Q?zypofWIyFEjDQGT0GtF7tEriqeUaaUSmf69Erj6fwwz+dReUGanwY5cz2l/Q?=
 =?us-ascii?Q?k6foJv5/07OTqEqMAs3PgRvMQ7Z2V1OYoNoY/NwAx2GarGiROxBZAWr6Kge0?=
 =?us-ascii?Q?+VXKCKhEsnPVxSVf8uLPIzjwhqOa0AzBL/oGelXbfsY7TrnNDywlxZa/U1wF?=
 =?us-ascii?Q?umnmRUPA9i3x2GZpN/Gjjvifui/R7SdRsPIJpAIXr5ejLkc/wDUshkDX5M48?=
 =?us-ascii?Q?DL4AYiFODGjFE8pczYJ0umiKVsM6//pa6v/p7UtMr4mbKvA8Pj5NXaCqDgJ5?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8059cf2-49ae-4468-564b-08da0218dbd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 22:05:01.5964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L373Djf4/5VAt/iTA86Sjd29XsATFxKWpFmmHH2p3ZVUKIlQHj2wxMI9HZrR06QvyYGsvcipoAAXmixNgKZgAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 2/2] remoteproc: support attach recovery after rpr=
oc
> crash
>=20
> On Mon, 7 Mar 2022 at 23:08, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Current logic only support main processor to stop/start the remote
> > processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> > remote processor could do attach recovery after crash and trigger
> > watchdog reboot. It does not need main processor to load image, or
> > stop/start M4 core.
> >
> > Introduce two functions: rproc_attach_recovery,
> > rproc_firmware_recovery for the two cases. Firmware recovery is as
> > before, let main processor to help recovery, while attach recovery is r=
ecover
> itself withou help.
> > To attach recovery, we only do detach and attach.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  use rproc_has_feature in patch 1/2
> >
> >  drivers/remoteproc/remoteproc_core.c | 67
> > ++++++++++++++++++++--------
> >  1 file changed, 48 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> > b/drivers/remoteproc/remoteproc_core.c
> > index 69f51acf235e..366fad475898 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1887,6 +1887,50 @@ static int __rproc_detach(struct rproc *rproc)
> >         return 0;
> >  }
> >
> > +static int rproc_attach_recovery(struct rproc *rproc) {
> > +       int ret;
> > +
> > +       mutex_unlock(&rproc->lock);
> > +       ret =3D rproc_detach(rproc);
> > +       mutex_lock(&rproc->lock);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (atomic_inc_return(&rproc->power) > 1)
> > +               return 0;
> > +
> > +       return rproc_attach(rproc);
> > +}
> > +
> > +static int rproc_firmware_recovery(struct rproc *rproc) {
> > +       const struct firmware *firmware_p;
> > +       struct device *dev =3D &rproc->dev;
> > +       int ret;
> > +
> > +       ret =3D rproc_stop(rproc, true);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* generate coredump */
> > +       rproc->ops->coredump(rproc);
> > +
> > +       /* load firmware */
> > +       ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > +       if (ret < 0) {
> > +               dev_err(dev, "request_firmware failed: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       /* boot the remote processor up again */
> > +       ret =3D rproc_start(rproc, firmware_p);
> > +
> > +       release_firmware(firmware_p);
> > +
> > +       return ret;
> > +}
> > +
> >  /**
> >   * rproc_trigger_recovery() - recover a remoteproc
> >   * @rproc: the remote processor
> > @@ -1901,7 +1945,6 @@ static int __rproc_detach(struct rproc *rproc)
> >   */
> >  int rproc_trigger_recovery(struct rproc *rproc)  {
> > -       const struct firmware *firmware_p;
> >         struct device *dev =3D &rproc->dev;
> >         int ret;
> >
> > @@ -1915,24 +1958,10 @@ int rproc_trigger_recovery(struct rproc
> > *rproc)
> >
> >         dev_err(dev, "recovering %s\n", rproc->name);
> >
> > -       ret =3D rproc_stop(rproc, true);
> > -       if (ret)
> > -               goto unlock_mutex;
> > -
> > -       /* generate coredump */
> > -       rproc->ops->coredump(rproc);
> > -
> > -       /* load firmware */
> > -       ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > -       if (ret < 0) {
> > -               dev_err(dev, "request_firmware failed: %d\n", ret);
> > -               goto unlock_mutex;
> > -       }
> > -
> > -       /* boot the remote processor up again */
> > -       ret =3D rproc_start(rproc, firmware_p);
> > -
> > -       release_firmware(firmware_p);
> > +       if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_RECOVERY))
> > +               ret =3D rproc_attach_recovery(rproc);
> > +       else
> > +               ret =3D rproc_firmware_recovery(rproc);
>=20
> Should I assume this set, which is labeled V2, replaces this other patch =
[1]
> that is also labeled V2, sent out on January 26th?  If so, why are they b=
oth
> labeled with the same tag and why isn't there a cover letter to clearly s=
tate
> your intent?  More importantly, why am I having this conversation with an
> experienced kernel developer that should know better?
>=20
> Any reason I should not move this work to the very bottom of my patch que=
ue
> or better yet, simply drop it?

My bad. This patchset should labeled V3. I'll resend the patchset with a co=
ver-letter
and label V3. Thanks for your patience.

Thanks,
Peng.

>=20
> [1].
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Flkml%2F20220207173456.GA3355405%40p14s%2Ft%2F&amp;da
> ta=3D04%7C01%7Cpeng.fan%40nxp.com%7Ccb80ecb9fb3348d1222a08da01fc2
> 6cf%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637824479736
> 071420%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DFIdhBvAUP
> NZDPxzEW6wW%2B0GPzoQ7MUm8IbXc7yq%2BP6w%3D&amp;reserved=3D0
>=20
> >
> >  unlock_mutex:
> >         mutex_unlock(&rproc->lock);
> > --
> > 2.30.0
> >
