Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809054C216A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiBXB5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiBXB5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:57:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21056F70C1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645667829; x=1677203829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MXDk1j4XujFYox6+wfkxg9MsHpjHBsXN3MsdBYu4+AE=;
  b=P0kdpdvLuv7roe90kQVM58KNZAw1B36BCoK3yA7WfbzGci9US0VvCaRf
   AMIw82xOu6i8PihNP/wxRrUv6X7UVjGEO0hXZrUpzxcphPojavMAg38w4
   z/ETIJpGwzU+5JzPAI0cDQc7HFvQq07dib5844JurwaPm5M7wNW/rd1RO
   QVrwJYq+5B5tfOCFN6iQ47xb0rFhDmjpZn7jd79luU4rMMttZwGJx/p2p
   gZHTQiBSa6tsSyGWeIlQmErnI523XZOxV5o05mqxy8/F6hNhm73cxUCcb
   a/ZffidHfblm4XkHPNrErvQ017+4axXczlGLtO1msRhyJcyQmNwOx1aJz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232748129"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="232748129"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:44:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="508678073"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 23 Feb 2022 17:44:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 17:44:13 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 23 Feb 2022 17:44:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 23 Feb 2022 17:44:13 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 23 Feb 2022 17:44:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHkFyWoyy+dzuudHHB/DttVIH8V0fbcaljsCFrFPhxnYk1b7UifC1QQ4Ksh3fvESQcLfSPcgYoDucW1p5QUwfv0SAVRYDLBoFoGAr6nrW4g1mXl7w8LXVVDwQ7Z+nq6vFf3tA3No1rCIHIXN0nhBw47yB6OvafqfnB2T/2bqKEnoCrOXQ4MoxaQrgOignN7CO7OFHEBkQsrgM4AislbbWZ3HNFcn8I1GGtTrNkqlbHmhv1V71NxUhY3s0O6n1U7qU+FvN05DLsPbd//e3sYqwhESvse71U8cg0rgfIJBPEX8OlIAbkCFVo/3ZVPpRotqp4fCzBqe4ByqaqiBQfqLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzXGZKXpAtBAfbBEn4R4P8Ubbxl3YQxNtVVs2TcmVD8=;
 b=MVvL8TmsEHfRsMFp9nLwZnrX+s6a9u7Ckkw5AuTM8/8r/e+KaxEDZ1tlq+dSQKLXGtChsu3S/rXrlkbWqmg6KhMiBVVCuUnmCzcsFJ5Jr6G3W0EEMMh9cH6AL0sIQ0/QKI2Dc8et5voP2lPo4W2d40Uh/g0H8pSKLXwoHl7EwRi+Pu4D86FMSEm2/ULqeUcDDNiM0eZgqbtYhN+KKMQl3ZLW9+fjeWCG7Id0+/ETvj9keacjXpnv/2dRODGH8jXFCf6yIvSn6hbz00BkKGaEBzE5v+IOaZxKXMGPPubfbGUAHYQsxzw4fwtOx8QPWMgK4unpITiMCjWaW3TpoTPlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BYAPR11MB2566.namprd11.prod.outlook.com (2603:10b6:a02:be::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Thu, 24 Feb
 2022 01:44:11 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c%5]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 01:44:11 +0000
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
Thread-Index: AQHYJn4xBH205WNMF0CseYQWl0QGTKyg/zWggAAE7YCAADTiAIAAFuAAgAAJtACAAJZv8A==
Date:   Thu, 24 Feb 2022 01:44:11 +0000
Message-ID: <PH0PR11MB5880D7544442B4D60810F0D2DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <0000000000005a991a05a86970bb@google.com>
 <00000000000033314805d8765175@google.com>
 <PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <YhYafwiwUV2Sbn5t@kroah.com> <YhZG3GJb8G7oL7l7@rowland.harvard.edu>
 <YhZaDGeIIvpILdCk@kroah.com> <YhZiMHHjrBw8am5g@rowland.harvard.edu>
In-Reply-To: <YhZiMHHjrBw8am5g@rowland.harvard.edu>
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
x-ms-office365-filtering-correlation-id: 8bcddf62-95d1-4f5e-c346-08d9f73727bc
x-ms-traffictypediagnostic: BYAPR11MB2566:EE_
x-microsoft-antispam-prvs: <BYAPR11MB2566C2A9FB84B4A41B028FB1DA3D9@BYAPR11MB2566.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7ARUlmcPYec4lcdv2QQJLXKmVamkVgfIsbHO5iybw4lGAc71OH1m/be/1I4Dj3onMXQy76M90v0wuRPqtrtHOyD6ryHjLue1PoCitKtZDwveGwAxA4FQEBmsazmwJVyyWSqxGwKfgU/ebCo/L1wXJL2YtWdF4lDhh6Ko5Hl3xyBstV9gHzZ+YV0lsxpJ3/A46bkwr2Q4fLAJx8BSc0YHhzqNUQu3nI312Z5kLUfcrWPPxeJJL1lDOnvjMUztFkCBHWaBTYmCysqMKs/ZEu3El6ImR1nwA6oudjLO+tgX/DE9VGU/L/P6aPSTCfF65nDiOU2Gqk7SSWbsMaeXw7faQZDdx3gnY+HqNEiN5dS/SN5hcz28KIrnJsloYdWOz6A1osDj+jHFhqTDgorwhaz4aDmwp0fSWrQKSXSZS/sfLPTJkl6K89ihpwglD5NYAbEyagYS7CTxvqYvmgoPrWj4RRxsVMlOTnJrpiW8Oz8duwyXClip9Aa+DKZN5STX6HDl3vTyC6wtZMyfdL6apIg/4qv7fzIbCo7tHk2yWljuVv7DCizXqw3H6cIfmWn0CRRckuD4/2c3KXsAcPMBvBcDkjD169slFowHKP82FD08YOyYob/YvgJikTA3Hzvqsk9FpkhnMPmHjxKzKZ9nj97drcnJIA55fAfXDlXFurfW8n11ScdZv9U+kgG+K9yj3KP2b7VI+5fpVKMXicuTJcQPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(76116006)(83380400001)(110136005)(33656002)(55016003)(38070700005)(316002)(9686003)(52536014)(71200400001)(122000001)(8676002)(86362001)(6506007)(66476007)(4326008)(2906002)(508600001)(64756008)(66946007)(7696005)(38100700002)(5660300002)(8936002)(66556008)(26005)(186003)(82960400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C26oOeVdit65q4erQzyaOVvS0S8lG3MR2ShczNBkF3szFcMZm5BCRkyUYvZr?=
 =?us-ascii?Q?Uhs6B9xIbDprYICmE/UUHMzKi45d8JDrL/g8DDqffW+b/+BaHgb7WIIh0Fn6?=
 =?us-ascii?Q?ZKyARNzACBBg/Q0ICzHhpGhthogl+Cn3Q+B7U7OMovzirrUFQjTd96YWdItL?=
 =?us-ascii?Q?I1z8hMbR5+1dy7HvEssSh+lwMkb2ya4zorSLpl8Idy2EOAum7lNDI47ppm5n?=
 =?us-ascii?Q?Sk9m76a0epQDvWWJI0JVwyGI20os0ciyDGoJtV/A8BesYt+Nkomvkb+rOHZH?=
 =?us-ascii?Q?v2A/3+Kahu6q3DZOrb+IbiN38vLx3kw2lTKH8wp4VWrxlo0/Sn+OpNo8gd36?=
 =?us-ascii?Q?P7Q0O037EiCgFeiEzjHlRU52kvKnW5TNe67TnOvayvyxxeIHql9P2c4W7ZQA?=
 =?us-ascii?Q?6y6nUy1KU3f7gi8SuB5QPgBpmyxpuj13SFeUECq5uWd39GlLXTE6IHY8T3xz?=
 =?us-ascii?Q?0+zDBah7fYdJC3zXmaEMkupmi20F0J+RXNiWhQEYTSvNEm7PRyt73HvGzS/W?=
 =?us-ascii?Q?buyw8rL9lQG2qRN8Bg3wQuZg4J/TJ5o46l8SMxFtF9y0CefUV/5/hQ0EJwGi?=
 =?us-ascii?Q?ZHzWtt43HjxuyIV6tft9cRMaXesJEFrK1JqLhzh8Fkz5PmSN8SSnOWjgje3H?=
 =?us-ascii?Q?w7RzZYwcWi7znzt9Cfpx9dQasJ2VZ78PLVi1mlhehJJFt12DQte65tj9N6VR?=
 =?us-ascii?Q?AjSHlery8P8w0LqrY7R06i5on/NwumQdWURkcoBqO8G3AqhhbM+UKxiB0hXe?=
 =?us-ascii?Q?NfghX0pTKtRz1GPxWCO7zuksGwna8pmAQf50VHrEdy18Aum8b1Qf1PWYdE6U?=
 =?us-ascii?Q?AH6Yu12BrVzIt0/QC1raihIBd/AP14NcZKpuaPG80ctwvpnWj7DvfNs3dtzn?=
 =?us-ascii?Q?NTZeX3A2tCm6TYbmHOUXHzvkKX9m0eI6hnQmh9SGX+nb3Xy8xqPEDKXV0wo8?=
 =?us-ascii?Q?tr5AZvudM8vOCybjvT+ejmiksZbCSealRGvMp4QVpmxRFPjc1XqnttyCeHv3?=
 =?us-ascii?Q?x/6O/4rRhiyQCNfj7BePHp4EaQUMEC76BLj6Mm+PHZ43rl+k1zmPyFBo5gkm?=
 =?us-ascii?Q?qSS/fMvmcW8XFSmGsFfxim9fW382JZ9BA8o7oym6LU3/lYeIekOqFgN72kAj?=
 =?us-ascii?Q?miLw7eJ+xth4SKAwsdez3V1+NH52yOa+mJaxq4U2Y2rLqVqmXw+F1OMpoZh3?=
 =?us-ascii?Q?OFHzFc85Bg7m8faYypaQ4OMy/clK9MEFnK8DsdDScHvQA4W7X7BDaEQWhRad?=
 =?us-ascii?Q?AfwndcgJSsUB8qKcmWXz7pHX+SBajM+cE34bHNVuhOPhtf1TFRsncDQX1U6g?=
 =?us-ascii?Q?Byst8ns5PN+X5Pe73YVuAjDlZmdWH0MmjW45KsuLc9civZT40RlHT/B8NNaJ?=
 =?us-ascii?Q?kzoaB7IKuQK2qDEtzkk1YttIvhWqL6ehSMwZHVH8PCfWwnrotjCEjbpGYuxf?=
 =?us-ascii?Q?jE6XYDfAiEtnw/h97adgD2/bRo1zsJ+MF8k4bB6kIy23lSkdmzqkHXuVG77N?=
 =?us-ascii?Q?Jf0pTa2+1eDNwVL1PXTVMMVFlc6MSHS4969qiCJ62UpG6ekSIuEoqhLOtqio?=
 =?us-ascii?Q?+ag8nFNzAS5tpfg/h5kTN0qH42GUl35FN03aTFdK+wABK2jhqS/57AHNzFnm?=
 =?us-ascii?Q?sIlDU3U6BPRgvw1PU7Hz/HM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcddf62-95d1-4f5e-c346-08d9f73727bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 01:44:11.0486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZvvIQe43NRjB+mFPepEaf4oHXd1Pa5WccSuLPQ6BcXMR0dhdvX8s+XitbPEfOJmVfwIMQA3Ru3yjAPS3uhSQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2566
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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


Agree with you, in usb_gadget_remove_driver() function, the udc->dev.driver=
 and udc->gadget->dev.driver be set to null
without any protection, so when the udevd accessed the dev->driver, this ad=
dress may be invalid at this time.
maybe the operation of dev->driver can be protected by device_lock().=20

Thanks,
Zqiang


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
