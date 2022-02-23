Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF314C1C19
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244362AbiBWTWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiBWTWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:22:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B4046144;
        Wed, 23 Feb 2022 11:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645644124; x=1677180124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=973Qa1Z0nELcufIUnRm5HrqTW0pGB/mGy0quNROGY70=;
  b=DTTFwDngPo0EFIEqErvIH/FdM4r2569fdNrmbDO+YkxMpBIPwRw6g5BJ
   b2pq6Fb8U7cjw0IJcCGZkKeXG5nrTKENSGmFjojicujY8zbuKMkvHxVnO
   p6bQQVKNRw+xNa7EVKWLOlao04hPY7TPyI9aIGftXzCs2YZfHqiOWrxh0
   7oZEfH//J1Gaor2A5bTqj7vFd54DqdR3/zXmb8FlTnAqdnY9NqrsWdSLx
   yb/bo7PnUR0dYE4kzXJWeCo+NJOYhrk2JSkzEt8G8NutTF84WrpnRm6Z3
   KG41Mk4ewz9WVqzm1jxdGC5W0A8oirLwDeGotVc8Rzedl0yYx8rDtp3FC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="252255576"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="252255576"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 11:22:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="508567232"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 23 Feb 2022 11:22:02 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 11:22:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 23 Feb 2022 11:22:02 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 23 Feb 2022 11:22:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW7UzPM0SGlI5FFY3k9aRQfA16dOObJw7uELGHJMfqAHboERHkRrAsh6k9dniW7w8iLNbyPCjfvt4gBKLabEd6+TtClrIXPM8BGuUe+nk8wIw64OhLPi/s4gX2LInwlD+sjxl8+OEUbDkghNMj7BLEyaYOpxLVzJEhlIc7L4u33KbD/UDq3qRzv43kyc7c5TfCiYNI3HQk640PGXpVDY69JcsQ3dzjWNwJj0Kp+DslMlQanvp92dN28hE6BNoGfR8+fNAmmAZr/zpoDz2qvEkBNmyhNsJMbYp6fzGSShkbpN//ZTtKtWLN6zjUNoiwAlIV/E50KkVzjeqfWY76M61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UECLKP0Bp9SGP77y8jp7q6VBSME2PGUhT499oSEtCoI=;
 b=A+FJ6xQHG0H6k8B95bOBGof2xX4qh/6e2c+G1oBnQZdqxtLez6jtnQOF45mSqxXJd1ljNFk6R3fOkYyxE3PYm5J72gi9dZdxTto59FoKKxd/pD/XmZZwduwUay3iKIL6m4wWH/NVfxr0aqY4GatFRzqwebhBI77kouMSlgytQSHjNjQvSa8BEYDm/i4CL4+eQqET4yxgxc5VU+Ut6/zZzJq86n5Lmluw/7LxuU4FcXAWfTfptngMj51nrn3x7sTyH1wHehRGyyprfovxZf3do+RQfAqmj7Pqr8W1o3SbEpndd4vl5Jw7wb+nHSaWleSYZ+OhXkN8MJ4t19rGkzd7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) by
 BN8PR11MB3634.namprd11.prod.outlook.com (2603:10b6:408:88::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.21; Wed, 23 Feb 2022 19:21:51 +0000
Received: from DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d22:453d:a721:125a]) by DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d22:453d:a721:125a%4]) with mapi id 15.20.5017.023; Wed, 23 Feb 2022
 19:21:50 +0000
From:   "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Thread-Topic: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Thread-Index: AQHnSY0LvXD3+ZEFlRgON4KL/8w9CQKxAYDdAWBBDjasYq43gA==
Date:   Wed, 23 Feb 2022 19:21:50 +0000
Message-ID: <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
In-Reply-To: <YhLhoMFPyOFZ2fsX@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 628cbf39-408d-4ae4-24cb-08d9f701be55
x-ms-traffictypediagnostic: BN8PR11MB3634:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB36341F00D543262CEE249D9DF63C9@BN8PR11MB3634.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqlrL1jxH/JWv8WZGUkChGlfJkd/F5EllRImIW4WntTmFEnXRika3qS65JIwkdR6ZLmhvcUiWpSuA/g3nyWz3GQIkdY6uQH+YWKSRXNSJyf4gzmhwE96lqQPbHGA9jwlCvL8crYvRwDhKjMbOjltJ1XRnC4uyBR6VVeDm6goKIpYZqlckTcPl8Krr8yiWh8KqK2F/FYttItRA6VwDZ62gZk3Ya7bf1OnRCW5k8sSQx4y/MCl5FmMEFtpAgmbqEJQEG2lUOFQEzUxNllfmpOWj6PqjQFXKR8lSIVXc+/HgschtFjVrr2ezzUNlWhADWR+iaM8pQZgW59DvMfzRuOuitlNAx4kh1Pvhv4LGkOirfHu6rxB4+sUxWTLVSfVpHdQtp5GbS/8AGgYffGNwIuRmVIj1UHzxzhn6sOV67qtjDX0iJ+mb2CMrqtIqxmK8CS/96kXvDfZ9Rh3qdu862iyTQfuf8GhER8On+0S4tuDmWOqdAIieeP5RO7KXWGTfkU3IUh5c0fYmG3C5HHJw0gh7v+aiDEG8nZTwOIO+dFme2u0qJm9t7/1Q2mEwz5lBmucyS1FRDwvh1B9QDU5K4n7038iK2Ofz7rnPN7Xy797YZbWSvWd+DE+6kEk6yf1uoQdut/BJAnEMN1kzGH97jLt6vo1PA/Z8rb1u9IkgNfHpwpZNNkPe+G/mgZjHeQgnJ9Vs+i14QRHgQEWkMlA7miAFzplC5xI6ak2surMrEvxteT8c7uScP8j5PaGAscGtSVYl9S0mueCMLK8upf0UTg2sK5w4XecFgdJ6xgHC9Rd+ho=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5591.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(8936002)(7696005)(30864003)(86362001)(9686003)(53546011)(6506007)(55016003)(83380400001)(122000001)(966005)(508600001)(64756008)(316002)(71200400001)(2906002)(6636002)(54906003)(33656002)(66476007)(38100700002)(5660300002)(7416002)(8676002)(76116006)(4326008)(110136005)(82960400001)(186003)(38070700005)(26005)(66946007)(66556008)(66446008)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RdfS7r2ssVdz5PwVMER4fe7U6Z9rl9m9Wy41GOx3x8mtzDXeLAXjWWTJsh4x?=
 =?us-ascii?Q?7Rkn2y8+cKpWy/wp8ubjpMLaf34nCDoYaX/pp/Ky1zIhuDY9qOqJ1pzuU+vF?=
 =?us-ascii?Q?BJFw0HDGfb3MBqdkIhBLAV8fPgqia39mek0TsqHF7z05AvCqTyNmG9TRA8Nw?=
 =?us-ascii?Q?afn29jgQOl44kAmoqMauVQNwDvhW3RNwX7K8wgkLYoorPxn59kEYo4UKrw8s?=
 =?us-ascii?Q?lk3nNeg7CdbmrEuj7oVD+89sPWnfv2xvclP3auIvONI+tMSyB5SBattsRChO?=
 =?us-ascii?Q?L7MdczLaUN0J5OvLjFrhGGt072nW8NAf1unfuFYiudRhBLPfpDzJvtZu3Ues?=
 =?us-ascii?Q?4fbq9Ao0jWsqT6y3U1ErwIqPmscXwpbXcjDvQv8VLjxRZwYJW8zAE9w6mQSM?=
 =?us-ascii?Q?1V5Ky8WoJLtAr2PGIN1Ve9qrN2qrG7EaeOZskVnCDqH1l5xyEOeBrHj3V6Ka?=
 =?us-ascii?Q?0XS45ns8QeHwrZPrFDQTpsDsWNznxr3FJSeysURQ1uw8+o+TFMAn5ynuCyrX?=
 =?us-ascii?Q?zrpJge6FVZryRi95siOrhRH5rH1aqIqa5pZfLOn0L1kujoeNjwXO+203jDtk?=
 =?us-ascii?Q?VHcjsBzMvaGOwIhBFZTrXW6idO/5pdfbjLuKp4orXEiwrizQ2YCqqkF+sRZq?=
 =?us-ascii?Q?R5sMHnezQOFnVYsJFADDmu1nHtjYKRr+BygJuukNVV3FIzHLL5UtVdFL54Hd?=
 =?us-ascii?Q?eaGaVo1UiZ0+5Ox3T2V1th4wp6VwyA6zZPbxyS9dXyNPoTlPYqHusU5K7vEY?=
 =?us-ascii?Q?DdHMJq2BQBpK7PNUvEvrrMQkleT9P51yFZV1Ty/BwvNMt8yNTV8QxlgoOLEk?=
 =?us-ascii?Q?YcVdrib8fELDtdVRKr/rePMDIN0pBloRsH5WslE2BqExR42pEF3AUmjhbMTf?=
 =?us-ascii?Q?JEBt/NibczS+PEB7ziTbk597rPkwZTP5fue7vXjmSrDgstYE00lXacLEGc9/?=
 =?us-ascii?Q?E6iVDp7cj8bz1myZw7A39H90XKxuV7LI8UamPSJIFBZDfJyg5xivHmNnk7Mi?=
 =?us-ascii?Q?t1npBtMXhc/JrXJU3+yDAci5Z5hTGk3EFT2JfhrbUNT878nY2qwhty0kFbRj?=
 =?us-ascii?Q?qPd8zuEqmaswtyDsi2WGNc27AGUizPhjagk8Fs5joXphHraIykH8gKTpb+9y?=
 =?us-ascii?Q?T4TD6tOufNi0kpU99YTtaSX8Xb7Huu6S5+gZ5uH3zyvMDgour09370G3Bw5K?=
 =?us-ascii?Q?LZ36HDvQsVdKDehTrT5z+mCzbw3CbBVIdtTseLgUKT4vOJMR8j/kKb0FCuD4?=
 =?us-ascii?Q?En7hayElCaqdXzDn71M8FrpS33N61X8alZdOJgoVpHIUzRI7TqyC3JC74OzC?=
 =?us-ascii?Q?ICd+Yn8qtBvXwqcg3C1TpOeRZ61vP3Slp+CcRuJ0FcXX0WuKFGTwqy22q7g7?=
 =?us-ascii?Q?a/WrxqzW0QHrEqZ5tosAaAUyCpzn+CDGJBL+yzXM8Vp+fGer77eZsNMLGdiM?=
 =?us-ascii?Q?3YxSLmZVF0j4EFRPC2cgcM40NZo/q0+m2AAaP7Ss1UctxRLIN5a5ik/R7bLb?=
 =?us-ascii?Q?xhcv6rO6kfFxCMtxz+UhUPWB0ywX2tZzEYZP3mkfL9/DvbxhMk9Yq5KKf8Oz?=
 =?us-ascii?Q?TG+2fyySPbx54MzsKE7oBkfjhpmcVoblyxK0WIZJRva/BQOEPxAmG12ZFJ3p?=
 =?us-ascii?Q?7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5591.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628cbf39-408d-4ae4-24cb-08d9f701be55
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 19:21:50.8665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYfC7KL96YHDYnl8n+nFnipoHt9HnjUT7NofOuf1kBaFa1cXBo5DZpLThdv2rnL8MN993FqsZDm0r0zwU3BufQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3634
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Regarding the recent update of splitting the page permissions change reques=
t into two IOCTLS (RELAX and RESTRICT), can we combine them into one? That =
is, revert to how it was done in the v1 version?

Why? Currently in Gramine (a library OS for unmodified applications, https:=
//gramineproject.io/) with the new proposed change, one needs to store the =
page permission for each page or range of pages. And for every request of `=
mmap` or `mprotect`, Gramine would have to do a lookup of the page permissi=
ons for the request range and then call the respective IOCTL either RESTRIC=
T or RELAX. This seems a little overwhelming.

Request: Instead, can we do `MODPE`,  call `RESTRICT` IOCTL, and then do an=
 `EACCEPT` irrespective of RELAX or RESTRICT page permission request? With =
this approach, we can avoid storing  page permissions and simplify the impl=
ementation.

I understand RESTRICT IOCTL would do a `MODPR` and trigger `ETRACK` flows t=
o do TLB shootdowns which might not be needed for RELAX IOCTL but I am not =
sure what will be the performance impact. Is there any data point to see th=
e performance impact?

Thanks,
-Vijay

> -----Original Message-----
> From: Jarkko Sakkinen <jarkko@kernel.org>
> Sent: Sunday, February 20, 2022 4:50 PM
> To: Reinette Chatre <reinette.chatre@intel.com>
> Cc: dave.hansen@linux.intel.com; tglx@linutronix.de; bp@alien8.de;
> luto@kernel.org; mingo@redhat.com; linux-sgx@vger.kernel.org;
> x86@kernel.org; seanjc@google.com; kai.huang@intel.com;
> cathy.zhang@intel.com; cedric.xing@intel.com; haitao.huang@intel.com;
> mark.shanahan@intel.com; hpa@zytor.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave pag=
e
> permissions
>=20
> On Mon, Feb 07, 2022 at 04:45:38PM -0800, Reinette Chatre wrote:
> > In the initial (SGX1) version of SGX, pages in an enclave need to be
> > created with permissions that support all usages of the pages, from
> > the time the enclave is initialized until it is unloaded. For example,
> > pages used by a JIT compiler or when code needs to otherwise be
> > relocated need to always have RWX permissions.
> >
> > SGX2 includes a new function ENCLS[EMODPR] that is run from the kernel
> > and can be used to restrict the EPCM permissions of regular enclave
> > pages within an initialized enclave.
> >
> > Introduce ioctl() SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS to support
> > restricting EPCM permissions. With this ioctl() the user specifies a
> > page range and the permissions to be applied to all pages in the
> > provided range. After checking the new permissions (more detail
> > below) the page table entries are reset and any new page table entries
> > will contain the new, restricted, permissions.
> > ENCLS[EMODPR] is run to restrict the EPCM permissions followed by the
> > ENCLS[ETRACK] flow that will ensure no cached linear-to-physical
> > address mappings to the changed pages remain.
> >
> > It is possible for the permission change request to fail on any page
> > within the provided range, either with an error encountered by the
> > kernel or by the SGX hardware while running ENCLS[EMODPR]. To support
> > partial success the ioctl() returns an error code based on failures
> > encountered by the kernel as well as two result output parameters: one
> > for the number of pages that were successfully changed and one for the
> > SGX return code.
> >
> > Checking user provided new permissions
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Enclave page permission changes need to be approached with care and
> > for this reason permission changes are only allowed if the new
> > permissions are the same or more restrictive that the vetted
> > permissions. No additional checking is done to ensure that the
> > permissions are actually being restricted. This is because the enclave
> > may have relaxed the EPCM permissions from within the enclave without
> > letting the kernel know. An attempt to relax permissions using this
> > call will be ignored by the hardware.
> >
> > For example, together with the support for relaxing of EPCM
> > permissions, enclave pages added with the vetted permissions in
> > brackets below are allowed to have permissions as follows:
> > * (RWX) =3D> RW =3D> R =3D> RX =3D> RWX
> > * (RW) =3D> R =3D> RW
> > * (RX) =3D> R =3D> RX
> >
> > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> > ---
> > Changes since V1:
> > - Change terminology to use "relax" instead of "extend" to refer to
> >   the case when enclave page permissions are added (Dave).
> > - Use ioctl() in commit message (Dave).
> > - Add examples on what permissions would be allowed (Dave).
> > - Split enclave page permission changes into two ioctl()s, one for
> >   permission restricting (SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS)
> >   and one for permission relaxing
> (SGX_IOC_ENCLAVE_RELAX_PERMISSIONS)
> >   (Jarkko).
> > - In support of the ioctl() name change the following names have been
> >   changed:
> >   struct sgx_page_modp -> struct sgx_enclave_restrict_perm
> >   sgx_ioc_page_modp() -> sgx_ioc_enclave_restrict_perm()
> >   sgx_page_modp() -> sgx_enclave_restrict_perm()
> > - ioctl() takes entire secinfo as input instead of
> >   page permissions only (Jarkko).
> > - Fix kernel-doc to include () in function name.
> > - Create and use utility for the ETRACK flow.
> > - Fixups in comments
> > - Move kernel-doc to function that provides documentation for
> >   Documentation/x86/sgx.rst.
> > - Remove redundant comment.
> > - Make explicit which members of struct sgx_enclave_restrict_perm
> >   are for output (Dave).
> >
> >  arch/x86/include/uapi/asm/sgx.h |  21 +++
> >  arch/x86/kernel/cpu/sgx/encl.c  |   4 +-
> >  arch/x86/kernel/cpu/sgx/encl.h  |   3 +
> >  arch/x86/kernel/cpu/sgx/ioctl.c | 229
> > ++++++++++++++++++++++++++++++++
> >  4 files changed, 255 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/uapi/asm/sgx.h
> > b/arch/x86/include/uapi/asm/sgx.h index 5c678b27bb72..b0ffb80bc67f
> > 100644
> > --- a/arch/x86/include/uapi/asm/sgx.h
> > +++ b/arch/x86/include/uapi/asm/sgx.h
> > @@ -31,6 +31,8 @@ enum sgx_page_flags {
> >  	_IO(SGX_MAGIC, 0x04)
> >  #define SGX_IOC_ENCLAVE_RELAX_PERMISSIONS \
> >  	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_relax_perm)
> > +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
> > +	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_restrict_perm)
> >
> >  /**
> >   * struct sgx_enclave_create - parameter structure for the @@ -95,6
> > +97,25 @@ struct sgx_enclave_relax_perm {
> >  	__u64 count;
> >  };
> >
> > +/**
> > + * struct sgx_enclave_restrict_perm - parameters for ioctl
> > + *                                    %SGX_IOC_ENCLAVE_RESTRICT_PERMIS=
SIONS
> > + * @offset:	starting page offset (page aligned relative to enclave bas=
e
> > + *		address defined in SECS)
> > + * @length:	length of memory (multiple of the page size)
> > + * @secinfo:	address for the SECINFO data containing the new permissio=
n
> bits
> > + *		for pages in range described by @offset and @length
> > + * @result:	(output) SGX result code of ENCLS[EMODPR] function
> > + * @count:	(output) bytes successfully changed (multiple of page size)
> > + */
> > +struct sgx_enclave_restrict_perm {
> > +	__u64 offset;
> > +	__u64 length;
> > +	__u64 secinfo;
> > +	__u64 result;
> > +	__u64 count;
> > +};
> > +
> >  struct sgx_enclave_run;
> >
> >  /**
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c
> > b/arch/x86/kernel/cpu/sgx/encl.c index 8da813504249..a5d4a7efb986
> > 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -90,8 +90,8 @@ static struct sgx_epc_page *sgx_encl_eldu(struct
> sgx_encl_page *encl_page,
> >  	return epc_page;
> >  }
> >
> > -static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
> > -						unsigned long addr)
> > +struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
> > +					 unsigned long addr)
> >  {
> >  	struct sgx_epc_page *epc_page;
> >  	struct sgx_encl_page *entry;
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.h
> > b/arch/x86/kernel/cpu/sgx/encl.h index cb9f16d457ac..848a28d28d3d
> > 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.h
> > +++ b/arch/x86/kernel/cpu/sgx/encl.h
> > @@ -120,4 +120,7 @@ void sgx_free_va_slot(struct sgx_va_page
> *va_page,
> > unsigned int offset);  bool sgx_va_page_full(struct sgx_va_page
> > *va_page);  void sgx_encl_free_epc_page(struct sgx_epc_page *page);
> >
> > +struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
> > +					 unsigned long addr);
> > +
> >  #endif /* _X86_ENCL_H */
> > diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c
> > b/arch/x86/kernel/cpu/sgx/ioctl.c index 9cc6af404bf6..23bdf558b231
> > 100644
> > --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> > +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> > @@ -894,6 +894,232 @@ static long sgx_ioc_enclave_relax_perm(struct
> sgx_encl *encl, void __user *arg)
> >  	return ret;
> >  }
> >
> > +/*
> > + * Some SGX functions require that no cached linear-to-physical
> > +address
> > + * mappings are present before they can succeed. Collaborate with
> > + * hardware via ENCLS[ETRACK] to ensure that all cached
> > + * linear-to-physical address mappings belonging to all threads of
> > + * the enclave are cleared. See sgx_encl_cpumask() for details.
> > + */
> > +static int sgx_enclave_etrack(struct sgx_encl *encl) {
> > +	void *epc_virt;
> > +	int ret;
> > +
> > +	epc_virt =3D sgx_get_epc_virt_addr(encl->secs.epc_page);
> > +	ret =3D __etrack(epc_virt);
> > +	if (ret) {
> > +		/*
> > +		 * ETRACK only fails when there is an OS issue. For
> > +		 * example, two consecutive ETRACK was sent without
> > +		 * completed IPI between.
> > +		 */
> > +		pr_err_once("ETRACK returned %d (0x%x)", ret, ret);
> > +		/*
> > +		 * Send IPIs to kick CPUs out of the enclave and
> > +		 * try ETRACK again.
> > +		 */
> > +		on_each_cpu_mask(sgx_encl_cpumask(encl), sgx_ipi_cb,
> NULL, 1);
> > +		ret =3D __etrack(epc_virt);
> > +		if (ret) {
> > +			pr_err_once("ETRACK repeat returned %d (0x%x)",
> > +				    ret, ret);
> > +			return -EFAULT;
> > +		}
> > +	}
> > +	on_each_cpu_mask(sgx_encl_cpumask(encl), sgx_ipi_cb, NULL, 1);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * sgx_enclave_restrict_perm() - Restrict EPCM permissions and align O=
S
> view
> > + * @encl:	Enclave to which the pages belong.
> > + * @modp:	Checked parameters from user on which pages need
> modifying.
> > + * @secinfo_perm: New (validated) permission bits.
> > + *
> > + * Return:
> > + * - 0:		Success.
> > + * - -errno:	Otherwise.
> > + */
> > +static long sgx_enclave_restrict_perm(struct sgx_encl *encl,
> > +				      struct sgx_enclave_restrict_perm *modp,
> > +				      u64 secinfo_perm)
> > +{
> > +	unsigned long vm_prot, run_prot_restore;
> > +	struct sgx_encl_page *entry;
> > +	struct sgx_secinfo secinfo;
> > +	unsigned long addr;
> > +	unsigned long c;
> > +	void *epc_virt;
> > +	int ret;
> > +
> > +	memset(&secinfo, 0, sizeof(secinfo));
> > +	secinfo.flags =3D secinfo_perm;
> > +
> > +	vm_prot =3D vm_prot_from_secinfo(secinfo_perm);
> > +
> > +	for (c =3D 0 ; c < modp->length; c +=3D PAGE_SIZE) {
> > +		addr =3D encl->base + modp->offset + c;
> > +
> > +		mutex_lock(&encl->lock);
> > +
> > +		entry =3D sgx_encl_load_page(encl, addr);
> > +		if (IS_ERR(entry)) {
> > +			ret =3D PTR_ERR(entry) =3D=3D -EBUSY ? -EAGAIN : -
> EFAULT;
> > +			goto out_unlock;
> > +		}
> > +
> > +		/*
> > +		 * Changing EPCM permissions is only supported on regular
> > +		 * SGX pages. Attempting this change on other pages will
> > +		 * result in #PF.
> > +		 */
> > +		if (entry->type !=3D SGX_PAGE_TYPE_REG) {
> > +			ret =3D -EINVAL;
> > +			goto out_unlock;
> > +		}
> > +
> > +		/*
> > +		 * Do not verify if current runtime protection bits are what
> > +		 * is being requested. The enclave may have relaxed EPCM
> > +		 * permissions calls without letting the kernel know and
> > +		 * thus permission restriction may still be needed even if
> > +		 * from the kernel's perspective the permissions are
> unchanged.
> > +		 */
> > +
> > +		/* New permissions should never exceed vetted
> permissions. */
> > +		if ((entry->vm_max_prot_bits & vm_prot) !=3D vm_prot) {
> > +			ret =3D -EPERM;
> > +			goto out_unlock;
> > +		}
> > +
> > +		/* Make sure page stays around while releasing mutex. */
> > +		if (sgx_unmark_page_reclaimable(entry->epc_page)) {
> > +			ret =3D -EAGAIN;
> > +			goto out_unlock;
> > +		}
> > +
> > +		/*
> > +		 * Change runtime protection before zapping PTEs to ensure
> > +		 * any new #PF uses new permissions. EPCM permissions (if
> > +		 * needed) not changed yet.
> > +		 */
> > +		run_prot_restore =3D entry->vm_run_prot_bits;
> > +		entry->vm_run_prot_bits =3D vm_prot;
> > +
> > +		mutex_unlock(&encl->lock);
> > +		/*
> > +		 * Do not keep encl->lock because of dependency on
> > +		 * mmap_lock acquired in sgx_zap_enclave_ptes().
> > +		 */
> > +		sgx_zap_enclave_ptes(encl, addr);
> > +
> > +		mutex_lock(&encl->lock);
> > +
> > +		/* Change EPCM permissions. */
> > +		epc_virt =3D sgx_get_epc_virt_addr(entry->epc_page);
> > +		ret =3D __emodpr(&secinfo, epc_virt);
> > +		if (encls_faulted(ret)) {
> > +			/*
> > +			 * All possible faults should be avoidable:
> > +			 * parameters have been checked, will only change
> > +			 * permissions of a regular page, and no concurrent
> > +			 * SGX1/SGX2 ENCLS instructions since these
> > +			 * are protected with mutex.
> > +			 */
> > +			pr_err_once("EMODPR encountered exception
> %d\n",
> > +				    ENCLS_TRAPNR(ret));
> > +			ret =3D -EFAULT;
> > +			goto out_prot_restore;
> > +		}
> > +		if (encls_failed(ret)) {
> > +			modp->result =3D ret;
> > +			ret =3D -EFAULT;
> > +			goto out_prot_restore;
> > +		}
> > +
> > +		ret =3D sgx_enclave_etrack(encl);
> > +		if (ret) {
> > +			ret =3D -EFAULT;
> > +			goto out_reclaim;
> > +		}
> > +
> > +		sgx_mark_page_reclaimable(entry->epc_page);
> > +		mutex_unlock(&encl->lock);
> > +	}
> > +
> > +	ret =3D 0;
> > +	goto out;
> > +
> > +out_prot_restore:
> > +	entry->vm_run_prot_bits =3D run_prot_restore;
> > +out_reclaim:
> > +	sgx_mark_page_reclaimable(entry->epc_page);
> > +out_unlock:
> > +	mutex_unlock(&encl->lock);
> > +out:
> > +	modp->count =3D c;
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * sgx_ioc_enclave_restrict_perm() - handler for
> > + *                                   %SGX_IOC_ENCLAVE_RESTRICT_PERMISS=
IONS
> > + * @encl:	an enclave pointer
> > + * @arg:	userspace pointer to a &struct sgx_enclave_restrict_perm
> > + *		instance
> > + *
> > + * SGX2 distinguishes between relaxing and restricting the enclave
> > +page
> > + * permissions maintained by the hardware (EPCM permissions) of pages
> > + * belonging to an initialized enclave (after SGX_IOC_ENCLAVE_INIT).
> > + *
> > + * EPCM permissions cannot be restricted from within the enclave, the
> > +enclave
> > + * requires the kernel to run the privileged level 0 instructions
> > +ENCLS[EMODPR]
> > + * and ENCLS[ETRACK]. An attempt to relax EPCM permissions with this
> > +call
> > + * will be ignored by the hardware.
> > + *
> > + * Enclave page permissions are not allowed to exceed the maximum
> > +vetted
> > + * permissions maintained in &struct sgx_encl_page->vm_max_prot_bits.
> > + *
> > + * Return:
> > + * - 0:		Success
> > + * - -errno:	Otherwise
> > + */
> > +static long sgx_ioc_enclave_restrict_perm(struct sgx_encl *encl,
> > +					  void __user *arg)
> > +{
> > +	struct sgx_enclave_restrict_perm params;
> > +	u64 secinfo_perm;
> > +	long ret;
> > +
> > +	ret =3D sgx_ioc_sgx2_ready(encl);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (copy_from_user(&params, arg, sizeof(params)))
> > +		return -EFAULT;
> > +
> > +	if (sgx_validate_offset_length(encl, params.offset, params.length))
> > +		return -EINVAL;
> > +
> > +	ret =3D sgx_perm_from_user_secinfo((void __user *)params.secinfo,
> > +					 &secinfo_perm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (params.result || params.count)
> > +		return -EINVAL;
> > +
> > +	ret =3D sgx_enclave_restrict_perm(encl, &params, secinfo_perm);
> > +
> > +	if (copy_to_user(arg, &params, sizeof(params)))
> > +		return -EFAULT;
> > +
> > +	return ret;
> > +}
> > +
> >  long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long
> > arg)  {
> >  	struct sgx_encl *encl =3D filep->private_data; @@ -918,6 +1144,9 @@
> > long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> >  	case SGX_IOC_ENCLAVE_RELAX_PERMISSIONS:
> >  		ret =3D sgx_ioc_enclave_relax_perm(encl, (void __user *)arg);
> >  		break;
> > +	case SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS:
> > +		ret =3D sgx_ioc_enclave_restrict_perm(encl, (void __user
> *)arg);
> > +		break;
> >  	default:
> >  		ret =3D -ENOIOCTLCMD;
> >  		break;
> > --
> > 2.25.1
> >
>=20
> Just a suggestion but these might be a bit less cluttered explanations of
> the fields:
>=20
> /// SGX_IOC_ENCLAVE_RELAX_PERMISSIONS parameter structure
> #[repr(C)]
> pub struct RelaxPermissions {
>     /// In: starting page offset
>     offset: u64,
>     /// In: length of the address range (multiple of the page size)
>     length: u64,
>     /// In: SECINFO containing the relaxed permissions
>     secinfo: u64,
>     /// Out: length of the address range successfully changed
>     count: u64,
> };
>=20
> /// SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS parameter structure
> #[repr(C)]
> pub struct RestrictPermissions {
>     /// In: starting page offset
>     offset: u64,
>     /// In: length of the address range (multiple of the page size)
>     length: u64,
>     /// In: SECINFO containing the restricted permissions
>     secinfo: u64,
>     /// In: ENCLU[EMODPR] return value
>     result: u64,
>     /// Out: length of the address range successfully changed
>     count: u64,
> };
>=20
> I can live with the current ones too but I rewrote them so that I can
> quickly make sense of the fields later. It's Rust code but the point is
> the documentation...
>=20
> Also, it should not be too much trouble to use the struct in user space
> code even if the struct names are struct sgx_enclave_relax_permissions an=
d
> struct sgx_enclave_restrict_permissions, given that you most likely have
> exactly single call-site in the run-time.
>=20
> Other than that, looks quite good.
>=20
> BR, Jarkko

