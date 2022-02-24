Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35AC4C2244
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiBXDPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBXDPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:15:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720E725292A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645672501; x=1677208501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pPpZkagf+huPHE1Oiyh3rNkRgBOi8hqlYm2tLRqWPEs=;
  b=WlDhvzPMuehfc2eegai38U5+BfwvhWVyL51z5qg+GYrwUYFzQSk0Qt77
   BTK5wOT2uUjycRx1wEp+YEyulOiWRLsLbTDoH2oDITIFOzDmW6t+OJwfq
   Q5zsoxYXsK/Q8B2FsU/CEtw13wojXthTuDuc0xaUFqw9ty0d82HwhC3Jh
   6ybwHtOTEvq7nkcTGSAgFkC8n0bKFIxa1sNuPOY6NYNRmLE1dSnrxnD/k
   fT0o8b2MSV7WyIw3HMTpWpgPIcLri98N08QHs+nPIXIV5ftjDR0PO3WIZ
   +fxJkausO3OmV4TA6hVK5glh4kpGR5Ijmy/PcxqmQ5m4UT2tpvmQi6tek
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239534399"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="239534399"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:14:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="784532755"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2022 19:14:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 19:14:58 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 23 Feb 2022 19:14:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Feb 2022 19:14:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 23 Feb 2022 19:14:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq3i8Efr1YzuVfXBROxPCQ0TRasQJjAjso/ri31PuubTj+suvxwKywQuQ+VLYkjpNHmjlPnsvY2IQzY1j2gvONl5dXSSrHCyutzjSZRv+oWB+ojQ0xm1wgh2Jml/LR5CJgOkzlp07WML5vwhD5Mcft1B2FbsYeoBJaMyErHKOQSpOYo9O0vt1mDxZo1o31Rcad92xE9OW6XzUEbnY1UlcVgRU8ks82VqoOb0Ubk5Pjh7fO46jkr5CjHJRMn4otsMb8FO6YCBISx7m4hfBo7axteURaOv2H5QKiObUyHR9VVqYf0N6rO24VhoGWq/uEUkSlpnTN398HxA00nc0UgmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uolq74/cBNS21Byo0k7XchbI1Cn/TH9/PVFXME6jhQ=;
 b=PhzbDD3TO4ouNUD6yHNhp7LCj1ZiOznQ6iHvzs55v8OMaZCBCzkOX8cG09QCkqvFdpBTfpaKZwJmFypfNeHoa8TfO4/7c/Shf6UvtvgOn4vY5ZR+RHBnj7w+NDCT9HA8o2Z1CiuRYkYI7tKgR6m2mNHbvAtp12MuybbS3kn/XhX4ptgPSSstGN+GNrlyi8u1tc49ZX0dbXWSIz6qRSN/IgAZM39+oyLxo9C5LFMuKMYJ6cwUJnIJkreWvZGnCXZvZ6+jUVmhoqj4CrNfuxB7Vmc98UkcD/g8WR+rhUJARPDt7zylj/ieKai1VlWV3Fxrhf3+GwsZEse0rhyK9esnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM5PR11MB0060.namprd11.prod.outlook.com (2603:10b6:4:63::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 03:14:55 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c%5]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 03:14:54 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: RE: [syzbot] KASAN: use-after-free Read in dev_uevent
Thread-Topic: [syzbot] KASAN: use-after-free Read in dev_uevent
Thread-Index: AQHYJn4xBH205WNMF0CseYQWl0QGTKyg/zWggAAE7YCAADTiAIAAFuAAgAAJtACAAJZv8IAAG7Gw
Date:   Thu, 24 Feb 2022 03:14:54 +0000
Message-ID: <PH0PR11MB588091026B817203C772B264DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <0000000000005a991a05a86970bb@google.com>
 <00000000000033314805d8765175@google.com>
 <PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <YhYafwiwUV2Sbn5t@kroah.com> <YhZG3GJb8G7oL7l7@rowland.harvard.edu>
 <YhZaDGeIIvpILdCk@kroah.com> <YhZiMHHjrBw8am5g@rowland.harvard.edu>
 <PH0PR11MB5880D7544442B4D60810F0D2DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880D7544442B4D60810F0D2DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0bf1500-12f0-4cfa-0ca2-08d9f743d484
x-ms-traffictypediagnostic: DM5PR11MB0060:EE_
x-microsoft-antispam-prvs: <DM5PR11MB00603713A960F7C175705848DA3D9@DM5PR11MB0060.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OZWgA/5EaiteOwadrj9AFbY0/M6kLoZiF6kL7vPYFJBTpotCfQol9/53NXrvfrXYiMOJ9oel/oGvyS1M9PDNkVxrmJ6MK8zLg/qh0C8zYIm+kuenKlQufdeqhdbhrFRspozZUoYNkwcOsvlGPVUFvqVDczOXBkUPXq7xH7p9aO87TzxQGGC3kts68fpLfm10jDPshDPXCN28kbNTpntlMoSv5zWMoQiojKL0BwGDVUbG4GrR38eLNot2heCRB9NQydfu7/siZVnMbecRAOROWLPWOnnK3WDuO8INf4QPs/RC3oYPZ+6Ni03aygn/HKnMEk51obYQ8JYbb18tXJg+N92qOxxoq9vQPTmVLXcBl+qJJeIcZ5tvMncfAy8Ok9/jJzP4JLOyMD8NpA+ocGakq6Q+HKIsbqrkslCBiKJdtqqAiaX4e6AaU2n9r2uDxhZ2H+d9gkw2MqLcGpzNrg9Gzgzn8J5mGyeG28it79L1SpEQ9unkmbAMPvHMf/hWMnZCyS+GXay1omf2PEpVYSqiMUD8syH4x+3N886JmjXZKzBBUyOPBhfTp0Ok6+mScGUB8xWszt+EhKJs1feEIDEKJHbfhLBWgJZWEAVhFFRlHiYvqFZYzzLi8iCmwMKIO9K+TMHuI7Z6eVnd07eKQKQo+VLjQ3r68r/1pm5BAl45kXvlhQ85RoPoVIXovRGK4ysB7DOWK/7Z69zA4ZSNUjPJ/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66476007)(64756008)(66446008)(66556008)(7696005)(6506007)(2940100002)(38100700002)(508600001)(4326008)(8676002)(26005)(316002)(9686003)(2906002)(86362001)(110136005)(54906003)(122000001)(55016003)(66946007)(82960400001)(186003)(33656002)(5660300002)(76116006)(71200400001)(52536014)(83380400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eMarFR8xxI8kEMlr6peI4TNfK0uE1lh4uMnPNorz9tsntq1gfTlv15UQKMXN?=
 =?us-ascii?Q?nbtDGA9A4hS4nly02I2PN6MEdxABpBAarDJ7Q7bcwzNgW6CIWX1AU6qm0WXK?=
 =?us-ascii?Q?iX658N/8O67K5tSXhqv7to92JZGqJiIHyltl6ZJTrx+SDZ0FqtKUzGPJQiIF?=
 =?us-ascii?Q?3/BDs37S+EXCcRKiDJB4UnGaDytxJmfTVMUHAEACPSI/wuCuMFomH6Ud1W27?=
 =?us-ascii?Q?gMua6xSOCf75S3pwzMt4n+CN7mttkuxugOJyBIKFqqjyFLgZnOM9zSvl/Qvd?=
 =?us-ascii?Q?/CLtemvtBjrPNLLADBwrTsyn+JlxbsUjSIY2JDs6gjVZm+EaMn8pvjWfmHS4?=
 =?us-ascii?Q?ZdzJRt3ysi1a8DNj6vhmY7jsH/Y7RZ3gF39f9noF9O+l0DkBfSxERxww1Agx?=
 =?us-ascii?Q?2LKSRA1cn43M+SCFoJUxhRF1BSw9K/bkbjfQSnYe97c5jMHmUTVKfzzctQsv?=
 =?us-ascii?Q?1y7AZrP4gxo/UjXKBuhZlEqzM5kNjZAr89i1nbC9Uj0WaIwUaOribq+gGaAQ?=
 =?us-ascii?Q?xRh8PWRYqTH3NTzJXU/gJ0RcqDsOHkS83g/k3wltTxsdEU4WWYEc0N2nLOEf?=
 =?us-ascii?Q?/Oh1eKPq+bAqxAWQy7auCSYlIleSIFtFYhVZvYdROO6BQnfnd4iw+b2LQlYr?=
 =?us-ascii?Q?tn0acpSxtHsw+AvFiypGtEj8fuLjHHLc+gZPT0I+iKulWgASCNW3vz2l4fYX?=
 =?us-ascii?Q?qbSFriP+6FYRm+6QgJv87323fwGf2d4KvTwI+yeMCxWPvzNoOH5+8tTFHd68?=
 =?us-ascii?Q?dlkEYLTDMpW1jKQ9i9VPyC/6KQA/SwQMHWejj45VWE28V4BDiBD0he/v8ncD?=
 =?us-ascii?Q?nx01uV1ri5v9nLFWv8jS8zBdpDqq5JqFaZKjOQUbUmhyBgSA3g6lxVpwqcdK?=
 =?us-ascii?Q?OQvTYvzsB79AVrUareEOdcOXt6dLbv9ZS4p9RqA8h0yuYLfZdGPbwW3Zxw5I?=
 =?us-ascii?Q?uqBtQGzpF0rPGUltN7RcoRfAgVG5I5vUVNL6mOkas3kPHIEF2JXy6e6SoOdH?=
 =?us-ascii?Q?FM9oSXOc6culg7YWU2HqUiNnKmvJFf/36BTLy1G0svytpb9vFz/0dU6UAjfV?=
 =?us-ascii?Q?2G+E8AJwrjB5SIPTNvs33Jl4zi2Kv0nZP0WEfkahCljjcuw2efWGQdUsSMa2?=
 =?us-ascii?Q?88hRm1aYiGh0okNP4PAwf5flNXu5oF+/b+XDGEl2/gcGt07zdIDE1Jq1B+uO?=
 =?us-ascii?Q?q3P1A/IVW7fZujbqi1IQaPYDlgwGG7EflVOCDALdHXL+PmD1/1dnbsNi0EIW?=
 =?us-ascii?Q?tD3bL6wmetnyLm89a7zGzrHagEEHPjdPUcLq0r6Kg2cSs56h4P3H93Ihe6Q4?=
 =?us-ascii?Q?cSnz+J2z+FMQCk/+jZl6t8n4dMmieY3Z8d261Vvbg4ftEQJACsb+kuD3u1TK?=
 =?us-ascii?Q?RMgyxphuJxMg1g/FtaBJ7Ab0a2oPALeRSAJky+85en75ruebulkFEBLq2ULV?=
 =?us-ascii?Q?SmMMIuhFb1WhZSt4tPGookzXMF0XFVdMUgw+uPpZltwj6aRgFtUx5oF8R1GI?=
 =?us-ascii?Q?wuUJuO+7zzjYErE/1BoqoruzV32WhVZrRryn9gIo26pWfq8vrVGQMl3tcgL7?=
 =?us-ascii?Q?SLAbcxCSS3eCoskF8L61cHX6Bv5BLHJQWgpBFSWTgZLePxGxdlDMtbEU1HOK?=
 =?us-ascii?Q?j9DcKNRSwyuHzlNbxh2icCI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bf1500-12f0-4cfa-0ca2-08d9f743d484
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 03:14:54.8666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2s5X/4k/9RzCLjjHOfMkiC6YMJyzISneOm1nBo3/dO8EEGzlzliKJZ6na9QJHhSTPSsO3vEZllk5Gkv8l7Q6zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0060
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Feb 23, 2022 at 05:00:12PM +0100, gregkh@linuxfoundation.org wrote:
> On Wed, Feb 23, 2022 at 09:38:20AM -0500, stern@rowland.harvard.edu wrote=
:
> > Which bus locks are you referring to?  I'm not aware of any locks=20
> > that synchronize dev_uevent() with anything (in particular, with=20
> > driver unbinding).
>=20
> The locks in the driver core that handle the binding and unbinding of=20
> drivers to devices.
>=20
> > And as far as I know, usb_gadget_remove_driver() doesn't play any=20
> > odd tricks with pointers.
>=20
> Ah, I never noticed that this is doing a "fake" bus and does the=20
> bind/unbind itself outside of the driver core.  It should just be a=20
> normal bus type and have the core do the work for it, but oh well.
>=20
> And there is a lock that should serialize all of this already, so it's=20
> odd that this is able to be triggered at all.

>>I guess at a minimum the UDC core should hold the device lock when it reg=
isters, unregisters, binds, or unbinds UDC and gadget devices. =20
>>Would that be enough to fix the problem?  I really don't understand how s=
ysfs file access gets synchronized with device removal.

>>>
>>>Agree with you, in usb_gadget_remove_driver() function, the udc->dev.dri=
ver and udc->gadget->dev.driver be set to null without any protection, so w=
hen the udevd accessed the dev->driver, this address may be invalid at this=
 time.
>>>maybe the operation of dev->driver can be protected by device_lock().=20
>>>

Is it enough that we just need to protect "dev.driver" ?

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3d6430eb0c6a..9bd2624973d7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2316,8 +2316,10 @@ static int dev_uevent(struct kobject *kobj, struct k=
obj_uevent_env *env)
        if (dev->type && dev->type->name)
                add_uevent_var(env, "DEVTYPE=3D%s", dev->type->name);

+       device_lock(dev);
        if (dev->driver)
                add_uevent_var(env, "DRIVER=3D%s", dev->driver->name);
+       device_unlock(dev);

        /* Add common DT information about the device */
        of_device_uevent(dev, env);
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 568534a0d17c..7877142397d3 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1436,8 +1436,14 @@ static void usb_gadget_remove_driver(struct usb_udc =
*udc)
        usb_gadget_udc_stop(udc);

        udc->driver =3D NULL;
+
+       device_lock(&udc->dev);
        udc->dev.driver =3D NULL;
+       device_unlock(&udc->dev);
+
+       device_lock(&udc->gadget->dev);
        udc->gadget->dev.driver =3D NULL;
+       device_unlock(&udc->gadget->dev);
 }

 /**
@@ -1498,8 +1504,14 @@ static int udc_bind_to_driver(struct usb_udc *udc, s=
truct usb_gadget_driver *dri
                        driver->function);

        udc->driver =3D driver;
+
+       device_lock(&udc->dev);
        udc->dev.driver =3D &driver->driver;
+       device_unlock(&udc->dev);
+
+       device_lock(&udc->gadget->dev);
        udc->gadget->dev.driver =3D &driver->driver;
+       device_unlock(&udc->gadget->dev);

        usb_gadget_udc_set_speed(udc, driver->max_speed);

@@ -1521,8 +1533,14 @@ static int udc_bind_to_driver(struct usb_udc *udc, s=
truct usb_gadget_driver *dri
                dev_err(&udc->dev, "failed to start %s: %d\n",
                        udc->driver->function, ret);
        udc->driver =3D NULL;
+
+       device_lock(&udc->dev);
        udc->dev.driver =3D NULL;
+       device_unlock(&udc->dev);
+
+       device_lock(&udc->gadget->dev);
        udc->gadget->dev.driver =3D NULL;
+       device_unlock(&udc->gadget->dev);
        return ret;
 }

Thanks,
Zqiang


>>>Thanks,
>>>Zqiang


> Unless the device is being removed at the same time it was manually=20
> unbound from the driver?  If so, then this really should be fixed up=20
> to use the driver core logic instead...
>>
>>Device removal does of course trigger unbinding, but they always take pla=
ce in the same thread so it isn't an issue.
>>
>>Probably part of the reason people don't want to use the driver core here=
 is so that they can specify which UDC a gadget driver should bind to.  The=
 driver core would always bind each new gadget to the first registered gadg=
et driver.
>>
>>When Dave Brownell originally wrote the gadget subsystem, I believe he di=
dn't bother to integrate it with the driver core because it was a "bus" wit=
h only a single device and a single driver.  The ability to have multiple U=
DCs in the system was added later.
>>
>>Alan Stern
