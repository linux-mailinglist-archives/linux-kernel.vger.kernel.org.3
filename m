Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3554D7687
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiCMPsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbiCMPsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:48:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDEFEA771
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647186431; x=1678722431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kj5k8IeHNdcBjIJxIxbeP7yLci6qtzD79GLVI5/0tYM=;
  b=GM+aglAnWjRW2WEQqDAAc57XRnHeJcUnpqV+v2Xus7NjFQ/YDCsoazBR
   rch7/CaKQS+FNlR3+iClpZ8rtytQD5W6dstq8OzJp8fgD/MLgCaiqRTVW
   aqSeC99Jk7Gwh6IwRD8ojVlG/HJEUB/f3skQSHh8CRGfRmhJeMFlFPMv+
   c3J6ZmZba7vJthvwysrxH9jt+LEx7aoURVCbgcH6loybxwwKOHBVc8rGh
   l+ciMHeDXlPSGRYmcnMa9TSZbGBXMpYbOBzbJY/ZIpz81a+oUq7by6oXC
   dPVBxjq2hD3Rty8ltk2sQkTLQrXmkgtpXOARQVzeXhJPvy9ffoThGkyi1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="254709031"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="254709031"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 08:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="548963776"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 13 Mar 2022 08:47:11 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 13 Mar 2022 08:47:11 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 13 Mar 2022 08:47:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Sun, 13 Mar 2022 08:47:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Sun, 13 Mar 2022 08:47:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btLvUac+M3YpCM/G2bm4z4PodJMlwXeKCMKupIshfswrQ3CT1uqWQTO2EOxtmL9Ge75wMz3VcU1HPz/O5+V60C7J++A4IhvWJ69EmS7Zp+G64gyyzZD3xGZIpzI8nK7xDpfou+3PZgojlWn8F12YM8o0lW3Gi+3mY805GGgcUhJjbkLzg2dwCWXnFh4y+nushSnKiIAvgsRHVH1ZMHhYgDgFRmFjEGha9XjKzR/IIrLAFKzTEzDlsoj8g9dRSgd+RaMwMhM6ArAdkxPt7f+/uFv3Kl21YNFq2oWHfbUbJnD+IhEg9dtFAyCsG2PB3gRmvBvEG2KipiHYrBXUNvXRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSevf7loseinVALgcMH3548TVJYf9zE9ZSKPLN22Ffc=;
 b=MUi8hbOS7dbkc3PJ7UewtIbAJdDE43nnJQrJhGyg/0wbcI/QWnODC17MG3uKlczdXcLReJttMaKsojm0+9a+S6kzWtq/nDvh8kzkrU66FwSDJ+nPRhKbP/e8SVlfgm3U6AX8kYlgK4FSazYXzkYrv+N8L+/et1rJ6kCy7EirW11+jxz5heYTMEFZKgZzjRm/64IVPpn91GNEMi2Z3I/wDIjK/fmMX+3uJyJ9NXjRmL3nBOEdH6KNHPDsj/BkpUgSbOwYGybqwMWuam1n9lVcPi42GHSxc07DsH7B0XCL39otqqYMHsk36UlVybsg63Lrwc1lBGMwJioA+gkCER3szw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by BN6PR11MB1779.namprd11.prod.outlook.com (2603:10b6:404:100::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Sun, 13 Mar
 2022 15:47:07 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::b03c:fa42:ac18:7fc3]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::b03c:fa42:ac18:7fc3%7]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 15:47:07 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: RE: [Intel-gfx] [PATCH v10 4/5] mei: gsc: add runtime pm handlers
Thread-Topic: [Intel-gfx] [PATCH v10 4/5] mei: gsc: add runtime pm handlers
Thread-Index: AQHYMwr3UdyywzUma0WBp78cI0ucuqy4/QuAgAR7/SA=
Date:   Sun, 13 Mar 2022 15:47:07 +0000
Message-ID: <MW3PR11MB4651A98ECDEF06AECAB57F6EED0E9@MW3PR11MB4651.namprd11.prod.outlook.com>
References: <20220308163654.942820-1-alexander.usyskin@intel.com>
 <20220308163654.942820-5-alexander.usyskin@intel.com>
 <YipLkXkoZFFNuK3p@intel.com>
In-Reply-To: <YipLkXkoZFFNuK3p@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c1e6c65-c006-4601-82d4-08da0508ba7e
x-ms-traffictypediagnostic: BN6PR11MB1779:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB17797678182DAFAC82B3F771ED0E9@BN6PR11MB1779.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uA91mdrLPRdUtZxhB89q6pXCGTtQPd9hLDVuClHKlq7L2eZePeey4rBLp1act4ooC1Ixtmy/3axk9LKFbnfkYtHcKILxmOakyYKhU/r8VYU9sqrRXVkT729YWslTFEEujlr/5OaC67T19Mb+7NTgC4t4BvNf5W+McHPuEZ3CmAdban1iSGslYUX9CFh6gbJUxIu94HO2zvPwSrROaHjnwzFN9ZhGXtnRQ+lOnCtyb3TpiJHginkAPHFcPkhdOhqqVMzO0MLG6BUpwusC2LDmxfblt2NiCEblgG+zhBIflc9lL2lfVLWhbeDfLSlCahUNcp3IfZrZiuTByhx3dATPPFxrWPVUGt2U56ZWU7mBbYnpV7ALEQbw/UHcs23eA8iISgQ9HMlXEI1mKGNyeMZ9apfSD4HYefXJN9JYTgcbotWyvSjKnfQjPLz3fk+0z23Z45eYVrGuCcLDMVaBxbFEK9yg66dBQ+duGlOcQtYxh42vX6DiYQVMV86so8aIMrx19cvDrM/tS5w3kC3/2N1Y+rftMKeh3Z59JN9aRzqlMwk+ERVJERfIHEXibuN2geL5zd5qEiP05iH1oKo0AZZ7cKoI0l8/jXFbFaa2YHJMlU8C4U85Yd/ozcmiVOIcftbUNiEM4ItXefqZj+wQH6yEP1ZzuKNOucykV1CQ/Z4qDMon4vam/r+2DYJGQE9dOsxku0AFUOYPcHISgH42+B73Kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(8936002)(83380400001)(186003)(26005)(5660300002)(6506007)(7696005)(53546011)(2906002)(66446008)(66556008)(66476007)(66946007)(4326008)(9686003)(86362001)(122000001)(33656002)(54906003)(64756008)(76116006)(38100700002)(8676002)(6862004)(316002)(82960400001)(6636002)(508600001)(55016003)(38070700005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Q+k4RzzUdvxclT7oKOze0zi36DILgRBIQH5S4lM4tGSxlYrk6bYX+fG5Qdo?=
 =?us-ascii?Q?Msh0LJGa/rshmXjVAVS24QVChMXmihVL+ntbVLoPSP8eiW1PSvtRKsNhhi04?=
 =?us-ascii?Q?KzF5/2pkZXuFrgcXQzrVFkRNOTEV+Lu4Q/LcL9pfrUlJXAL2PpygDcV+Xm5M?=
 =?us-ascii?Q?eJ6eZKieCtUCgFPY9cvZrAjlNdPi1jhAWN5Ul5IiYNOg79b3ChQHSGc2irf0?=
 =?us-ascii?Q?2BHwe7a6g9xUKQzUuoPdFlc4tGPK8OvBXLPZ6HcS15eik94ozobtCSGTqkpp?=
 =?us-ascii?Q?m3usRt/xJmiNKdkwZJgxE9Ve+NA9TYma+xckoVkuRxZySMvcIgvA7WVdCFjZ?=
 =?us-ascii?Q?c5t0G0Q1Ms9grTQ+Ouq0VIGY6DRVw3nP2pmmn6iIygiE+uWCYLt6OnoRp2ex?=
 =?us-ascii?Q?0sVWjUOe5qLBL91SYTemmZnbCJCLgN40m87JYC2zYyAubPmNoqcbB5VL19or?=
 =?us-ascii?Q?IwezWbNIT9d45OoqXJpYBIaKaHYheFomhaiYbwMe4jM/v8wYZP2JG4sB4FuX?=
 =?us-ascii?Q?raQs1CSjRbfuAEPcgNxNpzvIYMM9l2pv4jOGZ7nCANsYDWnxlXUUSu5ytUQT?=
 =?us-ascii?Q?gyOV5QCbz6F34LBx/f+A2EBlLUr8u439MFi8PcqeIgbV3T7LU0MKbZSvtp22?=
 =?us-ascii?Q?gBdnL8iKd+79T+iAcSbEBb8elelzv6vEnthAJA6qX9YPGpM28djqcFClUZJ6?=
 =?us-ascii?Q?9fV8FwqFxxmzvUavBU4qJGHEU3e041ebSl1HtsbTkmR8qWo4x12qQKbwFhCe?=
 =?us-ascii?Q?O/edVW25SR6bw9TENXywRT6ekAs9rOZBitXfz9aBMWEoXobnCgHR1ZqyjBuc?=
 =?us-ascii?Q?WzPqEYCbG6dmV06B0lDOXweWxPldqND0+i5exCSPbFpQeSnW4K4+HjGoR3iS?=
 =?us-ascii?Q?JLy/UISW/jZs0N6pATNNg5ynkTA0FFi1zF/jY4Rpz8VzcHeyhz7+TkjIvyIy?=
 =?us-ascii?Q?HdzEBgtuYS9NHIemBzfspk3F8xCz89wD5f1BHA6txt//6SePWiSOP76RG6K+?=
 =?us-ascii?Q?3cM/aNqzPs4Oy6+c9GdiYSXGLN1ZIthW52a67c0/UhTo26dBCoalJ/08JAPm?=
 =?us-ascii?Q?7+Vd9gPeTcrlV4i1H9AQPsXVIxI6sMnImnWs36OBXcyeAvAzJBJU3wImSrk8?=
 =?us-ascii?Q?5Ff0lER1Xsog+5Na0nQfAMVVwY8DiNX4fcWPmTKMLDqeiTSCZ4svsOD/P2fL?=
 =?us-ascii?Q?1qP8qIgplt7En9nPAarS5Yp9227iCOMU9x1+ogPgGO7t1gZD5x5VBYGPW/XJ?=
 =?us-ascii?Q?M5XfuPa3H1y/mfomvCMRS+c0saTYfx/tJLaKHsWVB3wxm/BVP8V0elMXrzHc?=
 =?us-ascii?Q?+nPWq8hUb/L/H1JVYWBQYsnRIDWX/dypKEbEszuRx6dqo8UNAdFXnf96twR/?=
 =?us-ascii?Q?BWha/zr5FrzTelao24O/oNngN3Ofn1787YVMTj1kCU02ZQO518K1qWUG0MFj?=
 =?us-ascii?Q?a4d75uuWJjlRltFt5RRQNU2WfBOLn+gtYDbZYiDTfcVTSLqZfLCsbA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1e6c65-c006-4601-82d4-08da0508ba7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2022 15:47:07.1358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgJdBIKSvHettsJhEVT64XjTDABJ5g3tS20VrvxadIvpvHoDJGzJb6F7lR4JxLE0j9jgJcqXM8clwDjpOq+SlV1XFOUGcUt2bnINSXKKFEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1779
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Vivi, Rodrigo <rodrigo.vivi@intel.com>
> Sent: Thursday, March 10, 2022 21:04
> To: Usyskin, Alexander <alexander.usyskin@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jani Nikula
> <jani.nikula@linux.intel.com>; Joonas Lahtinen
> <joonas.lahtinen@linux.intel.com>; David Airlie <airlied@linux.ie>; Danie=
l
> Vetter <daniel@ffwll.ch>; Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>=
;
> linux-kernel@vger.kernel.org; Winkler, Tomas <tomas.winkler@intel.com>;
> Lubart, Vitaly <vitaly.lubart@intel.com>; intel-gfx@lists.freedesktop.org
> Subject: Re: [Intel-gfx] [PATCH v10 4/5] mei: gsc: add runtime pm handler=
s
>=20
> On Tue, Mar 08, 2022 at 06:36:53PM +0200, Alexander Usyskin wrote:
> > From: Tomas Winkler <tomas.winkler@intel.com>
> >
> > Implement runtime handlers for mei-gsc, to track
> > idle state of the device properly.
> >
> > CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > ---
> >  drivers/misc/mei/gsc-me.c | 67
> ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 66 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> > index cf427f6fdec9..dac482ddab51 100644
> > --- a/drivers/misc/mei/gsc-me.c
> > +++ b/drivers/misc/mei/gsc-me.c
> > @@ -152,7 +152,72 @@ static int __maybe_unused
> mei_gsc_pm_resume(struct device *device)
> >  	return 0;
> >  }
> >
> > -static SIMPLE_DEV_PM_OPS(mei_gsc_pm_ops, mei_gsc_pm_suspend,
> mei_gsc_pm_resume);
> > +static int __maybe_unused mei_gsc_pm_runtime_idle(struct device
> *device)
> > +{
> > +	struct mei_device *dev =3D dev_get_drvdata(device);
> > +
> > +	if (!dev)
> > +		return -ENODEV;
> > +	if (mei_write_is_idle(dev))
> > +		pm_runtime_autosuspend(device);
>=20
> This is not needed. The _idle() callback is called right before the
> autosuspend.
> so you just need to return -EBUSY if not idle.
>=20

It is taken from blueprint in pci-me.c
IIRC here we ask the autosuspend to kick in after DELAY,
not simply rejecting it unconditionally.

> But also I'm missing the call to enable the autosuspend and set the delay=
.
>
These calls are in the second patch in the series, at the end of probe.
=20
> Is this flow really working and you are getting device suspended when not=
 in
> use?
> (Maybe it is just my ignorance on other flow types here)
>=20

GSC low-power is guided by DG card, here we only signaling to parent (i915,=
 I think)
that GSC is idle or that we need resume to perform the operations.

> > +
> > +	return -EBUSY;
> > +}
> > +
> > +static int  __maybe_unused mei_gsc_pm_runtime_suspend(struct device
> *device)
> > +{
> > +	struct mei_device *dev =3D dev_get_drvdata(device);
> > +	struct mei_me_hw *hw;
> > +	int ret;
> > +
> > +	if (!dev)
> > +		return -ENODEV;
> > +
> > +	mutex_lock(&dev->device_lock);
> > +
> > +	if (mei_write_is_idle(dev)) {
> > +		hw =3D to_me_hw(dev);
> > +		hw->pg_state =3D MEI_PG_ON;
> > +		ret =3D 0;
> > +	} else {
> > +		ret =3D -EAGAIN;
> > +	}
>=20
> probably not needed this here... but it would be good if you use
> the runtime_pm{get,put} to protect your write operations as well...
>=20

We reuse big portions of mei and mei-me drivers and there
all needed runtime_pm calls are implemented.

The runtime pm callbacks are different as GSC do not have
actual HW registers to handle the low power states as CSME has.

> > +
> > +	mutex_unlock(&dev->device_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int __maybe_unused mei_gsc_pm_runtime_resume(struct device
> *device)
> > +{
> > +	struct mei_device *dev =3D dev_get_drvdata(device);
> > +	struct mei_me_hw *hw;
> > +	irqreturn_t irq_ret;
> > +
> > +	if (!dev)
> > +		return -ENODEV;
> > +
> > +	mutex_lock(&dev->device_lock);
> > +
> > +	hw =3D to_me_hw(dev);
> > +	hw->pg_state =3D MEI_PG_OFF;
> > +
> > +	mutex_unlock(&dev->device_lock);
> > +
> > +	irq_ret =3D mei_me_irq_thread_handler(1, dev);
> > +	if (irq_ret !=3D IRQ_HANDLED)
> > +		dev_err(dev->dev, "thread handler fail %d\n", irq_ret);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops mei_gsc_pm_ops =3D {
> > +	SET_SYSTEM_SLEEP_PM_OPS(mei_gsc_pm_suspend,
> > +				mei_gsc_pm_resume)
> > +	SET_RUNTIME_PM_OPS(mei_gsc_pm_runtime_suspend,
> > +			   mei_gsc_pm_runtime_resume,
> > +			   mei_gsc_pm_runtime_idle)
> > +};
> >
> >  static const struct auxiliary_device_id mei_gsc_id_table[] =3D {
> >  	{
> > --
> > 2.32.0
> >

--=20
Thanks,
Sasha


