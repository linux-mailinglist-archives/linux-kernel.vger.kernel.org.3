Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27624C3B36
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbiBYBqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiBYBqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:46:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9E322B972
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645753551; x=1677289551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9+kroKFjnqUMAdbQzOY7/fdDbdsmlwGGwPuMaT8/04k=;
  b=OgW3Qp0jPtEKhYKtcVtn5V+IyIKB+Xh6kuvrSSBTirVU0NFsOkbaP1aW
   ffK9IEJAqiCDhUXE9X79O+ToeoFiEI7rBm+O/cZJH2rFa2SwLNzmlHMcg
   HGatNm3OcGsuPwtyitRgylictnoateD1K1wOBmsIJodZprnXg/b4t+Ymx
   RCxeuFqp0uyEzoqcvIm38n4/FOEKiRKZJrQ4XqLpuK8dNeFBVGpa/ceS1
   uQJpBQ99TX+nBViSRLr4g7wXEtkfULiofLQplOIB7oUAlWU00ZrQktUbM
   R/iOyWrEbkzpdEv9klMb7TznRm3/9V0FyWDt7F5DLixgC3xo23izL+bXp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="249977078"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="249977078"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 17:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="491821475"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 24 Feb 2022 17:45:50 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 17:45:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 24 Feb 2022 17:45:50 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 24 Feb 2022 17:45:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtQDquKhqo0TikqLFAn3Ii1/xadi8KUxB5mrkDvdDMS1WPidl0nAbKE7hmT/LlwLYIvcXpgsK8AMZ+bBLLj802nkJHJeh0AhMufU7MHweQi6PNGklGu17NxkxAAlzMPSaEPzZkNgCcmwWp7q+KayWaA+uDoVSo1F/wJtyyh7+8Q8oOk6bq9WxM+y2cudWeh/4KPCXkGTRrC8urd1QRYmTXkEOB5HYCh8uM5JRCneGdRrzXX9ytxLEMC0dLoJE+kEI/RmFiT94BWG+QlkCorvf/wpWCOzJ5YrgaR3Xp0QDNqhD1bgABqnhkDeJDI169x9ANgCfY85Llr8ycaKjBKYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m81up7HHaPEYa4B2F1FwhpC/jTVud5DLohpLQlcT1k=;
 b=liIilPUwTT/Me9JA8fvZRm2YytTp0FtC7Ycmtn5nANZjH3IpZISC5tsItoMo0qrFvpQ1JQg49EEm3ly2722Ojni/2DmV2mNJ/npyG7xQazafz7HApoZjhvjULStClfh41DJfkmickk+j2raD6cHCSGmFoFifgxzKgUuzeTxZopFgGT1UqDqntSBj21MN7dSu8Ho7TaLqBM66mOmknlJ2pOJELdPKUjF9oIaQMjGuerEw5USDuLNjCmiEprXrtIkMxdCCgmjIkPwzZdt+Llue8/1Vnu7OOKeRZ9RfHNOiq0V+u7oFmldwG2WIql/y1dYn9v737C2FKV8gmy5MHvpiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM6PR11MB2539.namprd11.prod.outlook.com (2603:10b6:5:bf::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 25 Feb
 2022 01:45:47 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c%8]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 01:45:47 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        Tejun Heo <tj@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: RE: [syzbot] KASAN: use-after-free Read in dev_uevent
Thread-Topic: [syzbot] KASAN: use-after-free Read in dev_uevent
Thread-Index: AQHYJn4xBH205WNMF0CseYQWl0QGTKyg/zWggAAE7YCAADTiAIAAFuAAgAAJtACAAJZv8IAAG7GwgAEw0ACAAEUQUA==
Date:   Fri, 25 Feb 2022 01:45:47 +0000
Message-ID: <PH0PR11MB588041571694CDC54D12F336DA3E9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <0000000000005a991a05a86970bb@google.com>
 <00000000000033314805d8765175@google.com>
 <PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <YhYafwiwUV2Sbn5t@kroah.com> <YhZG3GJb8G7oL7l7@rowland.harvard.edu>
 <YhZaDGeIIvpILdCk@kroah.com> <YhZiMHHjrBw8am5g@rowland.harvard.edu>
 <PH0PR11MB5880D7544442B4D60810F0D2DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588091026B817203C772B264DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Yhf3ThBfjWVcYszC@rowland.harvard.edu>
In-Reply-To: <Yhf3ThBfjWVcYszC@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 295a94f8-58a6-491d-fd31-08d9f8008baa
x-ms-traffictypediagnostic: DM6PR11MB2539:EE_
x-microsoft-antispam-prvs: <DM6PR11MB2539A644CA256E516D7C911BDA3E9@DM6PR11MB2539.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ap4Xt4I/sxGtapilGEfMHb8loO/9RXexS9ZrQZu+UM9tJu/oT6MDeKxe/+n4TkHe2IBDWSLNfOT7RkgzQQ+VrGhNDO7NsfG7sS/MPRobzKJIuaF+aLOx+ilto61WAplQxUkysOy1yT9xEe7EfdzH0ce4zMZWmpIJ6nTqzAkY/UXBM6m9d0+13ndNj39PjJPEsA6A3QdJxB76rZTWKzxTLGfNQEv9FG5R9LuunEWjRzpJJreAThAOuf+b+vZb0oLddD3ZH9xC3/GN9xJpP+f+z6I7AMbDgLG+ov31v75bV9jZal2PHY3U/04IpGJwLZoECakAHWzHMzouw0dY12XZaBl7k43dXQsI42MRG9TtcMc9vrpUWxI+6QpwBZJAGjeV+gdLQAfly/LKA7q7fZXP/5kytBOSaRFg3mBPJP+SpKnJK+p5RkdGM5HXKoL2nIubvEj0oOg3FVWVJ5L9IA3l78il/6Vaw08Kxh3jKn9IiL9gEgGVlgInqbuojRehRe7z8iYGB/kr6xK2Jj9f5kWz6epEY4CUMRUv/UNnGYzanh4XuWkgB8lJeNIo/vBEH5z9h/Oal2t9iwLszoJgsmPSsrFuvByPbIstAf2WftECH2Gwy8CYJoECJp/3ldlu4/UvmJqhzljyAKp11AZtGEzVre7w9/GWS2kQRWKtW/HY4B1Py9Mn/j10wsnqF1CZU7tznfNR9diiZloYJpmVtj1ejQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(64756008)(4326008)(66946007)(66446008)(66476007)(8936002)(76116006)(66556008)(52536014)(316002)(9686003)(86362001)(54906003)(71200400001)(110136005)(2906002)(26005)(186003)(33656002)(38100700002)(55016003)(122000001)(82960400001)(38070700005)(508600001)(5660300002)(83380400001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b0FSCb8EFBXGiAifgSEsLyGkAareM9hacjqLPgRsH6o9UW7RVEdH6YSmAoK+?=
 =?us-ascii?Q?Dlb9+jOxwFKVpP1JcBQtcamoBOuKSrqRSuRiqjrCKVrUUtX9XrUl0vLT5LK2?=
 =?us-ascii?Q?JxMRvBevXTYgm9edPxD2XdYC+Fy/H3exRx+CtfKzfq+Hiv6fPPT5kuIcs98d?=
 =?us-ascii?Q?zdOeeYRiYQrpIdWi7pCvcgT/uB539TqPqYyXp2vaRSXIOOSTno3cCKTpULiN?=
 =?us-ascii?Q?sxliUDgC/g+yRAePfpupU2/s4m4KrxeXXW02cKuikSU8sIUjSfF9GMLaV2ba?=
 =?us-ascii?Q?QiJYpTXQHDpTQoAj+9+v/77mdGjH5zg3Okijah+h0S3bhBZUn+M5j60ppZ0e?=
 =?us-ascii?Q?Dzvghf1rKFWNEAriB5hr2MWsd5LHttwHSol4yt9ESflMKeVOblOkiP1qaAH/?=
 =?us-ascii?Q?BDf50UjNInkKegmL1Ja5xl9iJL4F7BImwPCoze2CJ50Ne51VZ7qeH8HVD+hZ?=
 =?us-ascii?Q?8QrCFudfrg8ZzRy5+Twu8dbqSa/oQhKHwHnMIqreEH0JGcuEhCzSS4BNCu9R?=
 =?us-ascii?Q?pe8QNliZfuAO0fJZrwv/cWn0tPA25juwgXsYQUgMw4nnhiisNY8FqntF/3Yw?=
 =?us-ascii?Q?7mEtriDFaOWSSD0UXf90r3Ka7O3DaYHTffqoDuXsQw81240D78nN8a3ZGZg3?=
 =?us-ascii?Q?crryH4Yyc6SdmHNe6zWWJ1wA8R+JEBpCW+Aldf6fwFzL97+rfZgltk+6FMwN?=
 =?us-ascii?Q?yHGzFd/BgnxbCwxk0kfTa4CcPJ/7U1JIy4dol3G7lmf1K+a+BLMBAWvBqoOf?=
 =?us-ascii?Q?v9ScdAyo3TYMYUXoJo4vQ5eyw/CnbMBLJIMB1NVod+BW29pbQ94HKGy8SdeT?=
 =?us-ascii?Q?VnrP46Jq91erQVsx7YUQqmqFYTCcs8UrGp9ST/ytdKkvqhHvp45GpWv3MrNe?=
 =?us-ascii?Q?euGS+G0RI0z8zCfFJRpEqVPaFGtJyqiBVwHnEKjfxNnokm1mnZuhnsV6vxrL?=
 =?us-ascii?Q?IYhJZH2io3X7g1wHFYvvtaTIhF4Q2SAlzXRrKJvbOhZhMejXrnph5MLE1ohK?=
 =?us-ascii?Q?08V4NiIp+aFATSxkNbaZGIViSopNdMihttyeA4YatKcBjfLLNy/MaJQaNABi?=
 =?us-ascii?Q?/2tJcNb3oFvynMB8xPb0jy/Ehc5APtp0XRzFAXTqZ0kj8q7zcRq29JeMSAPJ?=
 =?us-ascii?Q?mirbs0swyjl6lSniHftbliJiM3WjSEhRoA4CfUFsL2dQIR/q8wg/tlQxSIBc?=
 =?us-ascii?Q?G/TCuWB+RkTJe6XYmXVflvE2EdoTm3J4oATQYcZQcmAsVUjqp1c3JyIkqMUn?=
 =?us-ascii?Q?sB9fy4qxqjFLrIXLcSXyswy3nWnVslaL0Fls9nd10Q7gcRrp1Qm+CYqPbore?=
 =?us-ascii?Q?zfiWQMH9QfdYhndNOTtESE91RaqAUKSCjJcvGOeUZkspFWcpUtkVlyUoZksr?=
 =?us-ascii?Q?rh+Kr6VXYqcuaC5HkBdVel06VaM1YV4Rnk3Pdei/qaSCFOtx8umybpZe8AwN?=
 =?us-ascii?Q?8gG/eh2H9pK9POos7B3sPuTSMDVItLLEvr5WSoJGTWMJcAsT5AlU4MRaSEtB?=
 =?us-ascii?Q?7oSlHR7n7BCpJwKMIXxN4+YkoqO3LPHqWdIDflXK3lpbTLTwJVOSTXFKCwDv?=
 =?us-ascii?Q?q6wfGRaz8Lc3GQ4RgUFtPOsdlpoyBZeHyjUoeTNlbUa7lcaCt4+FIt9JvGMw?=
 =?us-ascii?Q?BAZchZ3XneAs0GyfHcSRYrM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295a94f8-58a6-491d-fd31-08d9f8008baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 01:45:47.4219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvgdXRbruM6u/X1kxPx2Fenv15ZCsowLMSQmuowwXYaZ/8UgMl1lhiu5Ke2Gj0c/q/FRVVkXpgPyGZ0BkILbeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2539
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:14:54AM +0000, Zhang, Qiang1 wrote:
>=20
> On Wed, Feb 23, 2022 at 05:00:12PM +0100, gregkh@linuxfoundation.org wrot=
e:
> > On Wed, Feb 23, 2022 at 09:38:20AM -0500, stern@rowland.harvard.edu wro=
te:
> > > Which bus locks are you referring to?  I'm not aware of any locks=20
> > > that synchronize dev_uevent() with anything (in particular, with=20
> > > driver unbinding).
> >=20
> > The locks in the driver core that handle the binding and unbinding=20
> > of drivers to devices.
> >=20
> > > And as far as I know, usb_gadget_remove_driver() doesn't play any=20
> > > odd tricks with pointers.
> >=20
> > Ah, I never noticed that this is doing a "fake" bus and does the=20
> > bind/unbind itself outside of the driver core.  It should just be a=20
> > normal bus type and have the core do the work for it, but oh well.
> >=20
> > And there is a lock that should serialize all of this already, so=20
> > it's odd that this is able to be triggered at all.
>=20
> >>I guess at a minimum the UDC core should hold the device lock when it r=
egisters, unregisters, binds, or unbinds UDC and gadget devices. =20
> >>Would that be enough to fix the problem?  I really don't understand how=
 sysfs file access gets synchronized with device removal.
>=20
> >>>
> >>>Agree with you, in usb_gadget_remove_driver() function, the udc->dev.d=
river and udc->gadget->dev.driver be set to null without any protection, so=
 when the udevd accessed the dev->driver, this address may be invalid at th=
is time.
> >>>maybe the operation of dev->driver can be protected by device_lock().=
=20
> >>>
>=20
> Is it enough that we just need to protect "dev.driver" ?

I don't know, although I doubt it.  The right way to fix it is to make sure=
 that the existing protections, which apply to drivers that are registered =
in the driver core, can also work properly with gadgets.  But I don't know =
what those protections are or how they work.

> diff --git a/drivers/base/core.c b/drivers/base/core.c index=20
> 3d6430eb0c6a..9bd2624973d7 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2316,8 +2316,10 @@ static int dev_uevent(struct kobject *kobj, struct=
 kobj_uevent_env *env)
>         if (dev->type && dev->type->name)
>                 add_uevent_var(env, "DEVTYPE=3D%s", dev->type->name);
>=20
> +       device_lock(dev);
>         if (dev->driver)
>                 add_uevent_var(env, "DRIVER=3D%s", dev->driver->name);
> +       device_unlock(dev);

>>You probably should not do this.  Unless there's a serious bug, the drive=
r core already takes all the locks it needs.  Doing this might cause a dead=
lock (because the caller may already hold the device lock).

Sorry, yes it causes recursive locks.

>=20
>         /* Add common DT information about the device */
>         of_device_uevent(dev, env);
> diff --git a/drivers/usb/gadget/udc/core.c=20
> b/drivers/usb/gadget/udc/core.c index 568534a0d17c..7877142397d3=20
> 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1436,8 +1436,14 @@ static void usb_gadget_remove_driver(struct usb_ud=
c *udc)
>         usb_gadget_udc_stop(udc);
>=20
>         udc->driver =3D NULL;
> +
> +       device_lock(&udc->dev);
>         udc->dev.driver =3D NULL;
> +       device_unlock(&udc->dev);
> +
> +       device_lock(&udc->gadget->dev);
>         udc->gadget->dev.driver =3D NULL;
> +       device_unlock(&udc->gadget->dev);
>  }

>>These are reasonable things to do, but I don't know if they will fix the =
problem.
>>
>>We really should ask advice from somebody who understands how this stuff =
is supposed to work.  I'm not sure who to ask, though.  Tejun Heo, perhaps =
(CC'ed).
>>
>>Tejun: The USB Gadget core binds and unbinds drivers without using the no=
rmal driver core facilities (see the code in
>>usb_gadget_remove_driver() above).  As a result, unbinding races with uev=
ent generation, which can lead to a NULL pointer dereference as found by sy=
zbot testing.  In particular, dev->driver can become NULL between the times=
 when dev_uevent() tests it and uses it (see above).

                CPU0 (task 4316)                                           =
                        CPU1 (udevd task 3689)
usb_gadget_remove_driver()                                                d=
ev_uevent()
   	...........		                                                          =
     if (dev->driver)
    udc->dev.driver =3D NULL;                                              =
                    add_uevent_var(env, "DRIVER=3D%s", dev->driver->name)
    udc->gadget->dev.driver =3D NULL;=20


Thanks,
Zqiang

>>
>>Can you tell us how this should be fixed?
>>
>>Alan Stern
