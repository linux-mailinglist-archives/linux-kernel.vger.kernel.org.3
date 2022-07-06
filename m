Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEFD567D1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiGFEYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGFEYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:24:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8541B7A3;
        Tue,  5 Jul 2022 21:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657081448; x=1688617448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1EJEFpZ40FdN+OZ2Gk/VuPzRK9GyM56GqwlsK/kNBT8=;
  b=alwDZgUZbvwRremANt5W9Vci8SrO/nvCzuy77BQoOd1Qek7OT/YJ85Hk
   TA5pK8+Jjr+ycPwQ4UxmjL4YQZrFwCPqBEf15fyh5MOffffV7efZxHML6
   84JaOJXk0BaFt5ea9zqLT4WTkN2l0Aa2tsK2lwmztl0OCo9kx3ryVVui1
   HdDAmAmF0/ZpurQ369aA8zUOn2Wuo8DkP9QGAdQrWfv376sCHQ2cOJZ5p
   TheskSwrhKT2L8sbEy2JFCQMQahUMuQ4i5kXQQpJDktdtCrRURCVE/tYL
   O3v9E2fkVnDTIYSZ9XJEirRDWs4jJwOvq/dG+O+fz4gLlSn5Jx4qHC6Hv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="369956932"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="369956932"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 21:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="567899502"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 21:24:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 21:24:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 21:24:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 21:24:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 21:24:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEB4RDO4u2ke0/OG5CdewSt6+RZuI0gj1WVX/uBV3lD8SPJqpAiune+jtF4Cu8ttcMaH8tYLZSQBiAmFvaYW36NCyIMORCTdLN5lrqQXHjoWuxiQvlIZBe9m/woeO0uwWeFhquFANu9xcwEgns6+BW3yTq/b1T3Wdjn+9nzTFl1VM9F8E4J0fdverS725/UcGDIbpqS28yK5IJBMUHal6m453XZkNNgpvFqw4lhoL+ER4NGLzo7sb/WUODskogv7fQTDFQTh3YeqsKgzwBUegBmUD2AT7/SQTJQmw/XeoflN6APo9HzkVqHR+QxQzYO/4irOKOxruu19lUgcSd3jKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqbHJcbGjbaAmbGb7jTttU4M6SRoRHP5M2kv9fadCk0=;
 b=c9pgIBc+ZcdxaGUwOsyT9nHE9v2oFLPgojxk1mupRJtiZdKcU7xuYkir38UMYI+ZIbPwdPOHMxmVZ33c+71FU4OMv6eRUEoqmehipAFUTWW1dJdwafLccAmJUhHShZ3JOm6WhxEnmTypsHWxSu3ZldVdTm+gGLi6igUGGpvvxeK3VZL5N9Fs096K1cyqBWLh9D4yuKFIvaa1fOJaJGZgYi4Tb7+mqN445LTJTM55hn4482EzLL0b87Aek110qCS7WGqYhkRkRE2yV6FFwKT+DppEQWxYBYBjr5umpqrfpKTMFbiNH1Pp5lPhb6SCO9N77YYb3qdoEAnRBwD2gz0h/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN7PR11MB2866.namprd11.prod.outlook.com (2603:10b6:406:b5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 04:24:03 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14%4]) with mapi id 15.20.5395.019; Wed, 6 Jul 2022
 04:24:03 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Make tiny RCU support leak callbacks for
 debug-object errors
Thread-Topic: [PATCH v2] rcu: Make tiny RCU support leak callbacks for
 debug-object errors
Thread-Index: AQHYjPSNkw8Leg1ATEaQzvaLUuKjoa1wEumAgACIyGCAACGEAIAAA9hQgAACRJA=
Date:   Wed, 6 Jul 2022 04:24:03 +0000
Message-ID: <PH0PR11MB5880176B380D4177EC6E8C61DA809@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220701024404.2228367-1-qiang1.zhang@intel.com>
 <20220705174109.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880370195C11E8E943069CBDA809@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220706035040.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880E86FD8C97088EC65B0A1DA809@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880E86FD8C97088EC65B0A1DA809@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26c89444-2be6-48f8-3f3a-08da5f075bef
x-ms-traffictypediagnostic: BN7PR11MB2866:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6yKTzOiHJs2FI7cPJwx9YsLKfzmrxQSAKj2LsBQxth3v2qEmsfqZWyTRM6QMlY04ZgmbXN9GGd27GGtxxpMJkmD+CFLNrBiP1uzgRqjAZDTRGutCazE737mygrZESrgjFtXM8vnaNyn6PXHBv9+JTKBupvxJmskGm+GTGvI1zHnnYrPi4+aPZmVFJrY+84QYFpD7meso9HvmpRFAYOjALR/W75jasXyCz+5sMf+zeYGmgRyOSddcpjaVsIk/v9nP4ddPDqErefoRI4z60FDg9uqr/svehk5yWy8RzxXieY7lNI3eMHPFJnUKDdDwLQ8219cedC6LdT6Bfdt/WULKYrjkiRmsG+ii7sJR/pVHXhohKbtCUYk0mGxITQXfpZhwzmEdQNZXZ2C7L9YrUL8XLO8OJRM7MakAc5otG3lB41DTsRWuwMkDVzXg1byYFebUkSe0Mix+3z39vcFoWCcPlSLSAwOP2Y8uwptGiN6mnNqur6KXNBSZiuavpOaanwT8kYdhrMd+AfR/RREI6JAdCA98eF/NzmfCzt17uEO+He0qpi4DSVXU4NdjdGIvgChFp5p209d2voPRwHp8yYXzTO23UCT5qFgC7YgjkMyaaPkIfDVWRn8386YhcQDBBmKPF4A6SbsxfFPE4qpi2q+fD5dXBhNJ5b3yt3or2noCnRbg10xbbNBX4q5rZiscOuIRWkP+LFAhIXa1nIdEryE/lp7IZdsDW23Zo8GEb64wGNvI6uOOFFMM/FSyq/PA3BGqVmW2xFD6HDnlBKZtTfnC+61eROawptjjposWOPRz3yGmd+eIeVcVFA2/gQCAqVFO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(346002)(396003)(366004)(316002)(76116006)(4326008)(64756008)(66556008)(66476007)(110136005)(66946007)(66446008)(478600001)(41300700001)(26005)(71200400001)(8676002)(6506007)(45080400002)(54906003)(8936002)(55016003)(5660300002)(7696005)(30864003)(2906002)(52536014)(122000001)(33656002)(38100700002)(86362001)(38070700005)(82960400001)(2940100002)(186003)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7TBX3bEIkI1rawnm7Sx4kDpog3veRd+VNCXaeRPmNCcL0a/JHgdX0yAOg61v?=
 =?us-ascii?Q?+sWtIqO5lND247cOSm3dbBBs4xxftSFL/22n3FTRR7ZZXTvg+vFbAYlzgOl/?=
 =?us-ascii?Q?Kmikwkgr2BKhbc7k5o9IbM/VcOYjORJIZV7/jX48IZHTg31bu9ElS3BuyYsI?=
 =?us-ascii?Q?2KK+L2nPufS+YxVQ4rKQB/d/8fEKnNP5ypbhHM06uryEqOQbeWHXznIKUBie?=
 =?us-ascii?Q?QjK1PRYIypNLdAFMjxXXKZyN/T3Wnw+oILY7H6IfA8pZIOxBvXU8nG75xLfs?=
 =?us-ascii?Q?6dtBLe/3aEpD3fdZwSCh0hq40RpGX7UiFqvNEqUiLEswFZBPTLj06870dxgq?=
 =?us-ascii?Q?2CJkhd+eIWAURYX0jTUnRz6albw6jenQYle2rTU6dzYi4/8xPQwBxPhkcNYl?=
 =?us-ascii?Q?E/KqtAZKteZsRo8gpxta8qk2P3ZQjRlwyKTQRrHWj1A2eZNzg2UZUdWMdn6T?=
 =?us-ascii?Q?0uAIX1J8MoU/KHHPgXxkDgK4H/yIFrw9lPBMUzxlBri/zij89sATt5GQnm0b?=
 =?us-ascii?Q?1oZX8c3TniHYt/M4KXEHrnq7dpBYVbISPvCBarnrZHeQwn2U78sz80FX/18F?=
 =?us-ascii?Q?e/6NzuHGHW8zznR4fpWDReilJtPXv9KXu/kdR8mALKAUXNX4CffMG/Wdj51V?=
 =?us-ascii?Q?Cl+ZjNAOPvseStdy9wipLm0OMdqOW+0Lk2Vxd0Jens9edGsoEtBog0IjsPPl?=
 =?us-ascii?Q?WUzKD2WeN8s3KuqqbYAeo0NpoDcQHTfvGtrZm6HrsFE7dMuvP6Q5gyHeADK8?=
 =?us-ascii?Q?U3uLAjQHjwoigJSL1wmi5/lzE3bq/pIkR5OmNwgOzOZmORO2OwKRy8E+tItJ?=
 =?us-ascii?Q?B067cMUOpWXTdg/RV9G8Lc2n8uQkxRPL/9AjJG2K21sds0cinXX8rGZiErkJ?=
 =?us-ascii?Q?vKvWjw3hLFJ6Lkh9726bzYZjiMrLKW/dEViJ+w/Bv31lJLNJk4z+0lOmBcT4?=
 =?us-ascii?Q?2vFUcCgHZIEybngY2cCMCNALKXz8bVHnQJU0nHVhLh9oSOgAmUDuLiynbNhc?=
 =?us-ascii?Q?VNH9U6Hu81/+2LQU91CQaR7AOcW0XbY99xNoz5eR+TWGK7uF105mU6cJI1qw?=
 =?us-ascii?Q?O/HTX1Eg1Z/0Fvgb+4FxmQRCoaEt8CCQpDrSFnLXeODUXPPt9Q+jGkQqYsoi?=
 =?us-ascii?Q?2KkKDXWOYOy15ZFumevFJAGBuDwyPplggR8NKHCnM2cEAp8b3vhyJETkPKSD?=
 =?us-ascii?Q?rY8wbq8FpcGLUR/etDGn/i16zU4xo7InRf2EO5K1gdDlG8e8BUt6nrs3pKGg?=
 =?us-ascii?Q?amhBBiisST8ZVGiWK+tm5KUpc64a59oPe/2btoCT0x4CV/q7xZP0zVm067GV?=
 =?us-ascii?Q?DUkvT3kI3WGGItjfWLmeRcCZhSEWiA8bJ7Wfbwwi3Fnvj25+HQmEOtwdNYLY?=
 =?us-ascii?Q?zo8QRkXiZHh2gcqisc3MA51OqCatiO410kzPNLok8B4emUifkeHwrR+UR0Wf?=
 =?us-ascii?Q?NVxygG8e8lF7t31YNsOJk+1YeFaMcd+OvSYjD5adrUk39TM2PeNRboXUYPrR?=
 =?us-ascii?Q?QL3a7lCCSjMhS/RPoQ8sT2aZDoe95leXMSpSHEnVqHtOLsOLPRCZSLRRAu1+?=
 =?us-ascii?Q?ittCTm5XeKr43UxPMRyrZ5D4cHL+4tPeHJxL2tp2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c89444-2be6-48f8-3f3a-08da5f075bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 04:24:03.7693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUa4SPlCvuIVCHuFKVj3Bl1nWhzf3uMGP9XF08qYNhULkxECM7msL6KrA/oJ8sJw7yc+fu4WUN+sRJfBDXzIFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2866
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jul 06, 2022 at 02:00:51AM +0000, Zhang, Qiang1 wrote:
> On Fri, Jul 01, 2022 at 10:44:04AM +0800, Zqiang wrote:
> > Currently, only tree RCU support leak callbacks setting when do
> > duplicate call_rcu(). this commit add leak callbacks setting when
> > fo duplicate call_rcu() for tiny RCU.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>=20
> >This does look plausible, thank you!
> >
> >What testing have you done?
> >
> >One important test for Tiny RCU is that the size of the kernel not
> >grow without a very good reason.  In this case, the added code should
> >be dead code in a production build (CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn),
> >but it is good to check.
> >
> >It is of course also good to check that the messages print as expected,
> >which is what rcutorture.object_debug is there to help with.
>=20
> In the condition that the CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn, the function=
 directly returns zero.
>=20
> #else   /* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> static inline int debug_rcu_head_queue(struct rcu_head *head)
> {
>         return 0;
> }
>
>Yes, like I said, the added code -should- be dead code.  But there is
>often a gap between "should" and "is", for example, compilers don't
>always do what we would like them to.  So please use the "size vmlinux"
>command with and without your patch for a kernel built (both times)
>with CONFIG_TINY_RCU=3Dy and CONFIG_DEBUG_OBJECTS_RCU_HEAD=3D=3Dn.
>
>The rest of the test results look good, thank you!

Hi Paul

1. CONFIG_TINY_RCU=3Dy and CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy

Original:
text                      data                   bss                   dec =
                    hex       filename
26291319        20160143        15212544        61664006        3aceb06    =
vmlinux

Applay patch:
text                       data                  bss                     de=
c                 hex    filename
26291319        20160431        15212544        61664294        3acec26 vml=
inux

2. CONFIG_TINY_RCU=3Dy and CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn

Original:
text                    data                   bss                         =
 dec     hex filename
26290663        20159823        15212544        61663030        3ace736 vml=
inux

Applay patch:
text                     data                     bss                    de=
c     hex filename
26290663        20159823        15212544        61663030        3ace736 vml=
inux

Thanks
Zqiang

>
>							Thanx, Paul
>
> My test results are as follows:
>=20
> runqemu kvm slirp nographic qemuparams=3D"-m 2048 -smp 1" bootparams=3D"r=
cutorture.object_debug=3D1" -d
>=20
> log:
> root@qemux86-64:/# zcat /proc/config.gz | grep RCU
> # RCU Subsystem
> CONFIG_TINY_RCU=3Dy
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy
>=20
> [    1.015657] rcutorture: WARN: Duplicate call_rcu() test starting.
> [    1.015659] ------------[ cut here ]------------
> [    1.015659] ODEBUG: activate active (active state 1) object type: rcu_=
head hint: 0x0
> [    1.015680] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_pri=
nt_object+0xda/0x100
> [    1.016329] Modules linked in:
> [    1.016329] CPU: 0 PID: 1 Comm: swapper Not tainted 5.19.0-rc3-yoctode=
v-standard+ #214
> [    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    1.016329] RIP: 0010:debug_print_object+0xda/0x100
> [    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e=
1 48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <=
0f> e
> [    1.016329] RSP: 0000:ffff888001337be0 EFLAGS: 00010086
> [    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed100=
0266f6e
> [    1.016329] RBP: ffff888001337c10 R08: ffffffff90a56ee6 R09: fffffbfff=
25df5c2
> [    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 000000000=
0000001
> [    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e8a0 R15: 000000000=
0000000
> [    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlG=
S:0000000000000000
> [    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 000000000=
01506f0
> [    1.016329] Call Trace:
> [    1.016329]  <TASK>
> [    1.016329]  debug_object_activate+0x2b9/0x300
> [    1.016329]  ? debug_object_assert_init+0x220/0x220
> [    1.016329]  ? lockdep_hardirqs_on_prepare+0x13/0x210
> [    1.016329]  ? call_rcu+0xde/0x150
> [    1.016329]  ? trace_hardirqs_on+0x54/0x120
> [    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    1.016329]  call_rcu+0x20/0x150
> [    1.016329]  rcu_torture_init+0x1687/0x1759
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? irq_pm_init_ops+0x19/0x19
> [    1.016329]  ? mutex_unlock+0x12/0x20
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  do_one_initcall+0xc1/0x310
> [    1.016329]  ? initcall_blacklisted+0x140/0x140
> [    1.016329]  ? parameq+0x20/0x90
> [    1.016329]  ? __kmalloc+0x238/0x5d0
> [    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
> [    1.016329]  kernel_init_freeable+0x20a/0x268
> [    1.016329]  ? rest_init+0x160/0x160
> [    1.016329]  kernel_init+0x1e/0x140
> [    1.016329]  ret_from_fork+0x22/0x30
> [    1.016329]  </TASK>
> [    1.016329] irq event stamp: 152
> [    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw=
_spin_unlock_irqrestore+0x4c/0x60
> [    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw=
_spin_lock_irqsave+0x71/0x90
> [    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_p=
rocess+0xc8c/0x31b0
> [    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.016329] ---[ end trace 0000000000000000 ]---
> [    1.016329] ------------[ cut here ]------------
> [    1.016329] ODEBUG: active_state active (active state 1) object type: =
rcu_head hint: 0x0
> [    1.016329] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_pri=
nt_object+0xda/0x100
> [    1.016329] Modules linked in:
> [    1.016329] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.=
19.0-rc3-yoctodev-standard+ #214
> [    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    1.016329] RIP: 0010:debug_print_object+0xda/0x100
> [    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e=
1 48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <=
0f> e
> [    1.016329] RSP: 0000:ffff888001337bd0 EFLAGS: 00010082
> [    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed100=
0266f6c
> [    1.016329] RBP: ffff888001337c00 R08: ffffffff90a56ee6 R09: fffffbfff=
25df5c2
> [    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 000000000=
0000001
> [    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e640 R15: 000000000=
0000000
> [    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlG=
S:0000000000000000
> [    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 000000000=
01506f0
> [    1.016329] Call Trace:
> [    1.016329]  <TASK>
> [    1.016329]  debug_object_active_state+0x1d7/0x210
> [    1.016329]  ? debug_object_deactivate+0x210/0x210
> [    1.016329]  ? lockdep_hardirqs_on_prepare+0x13/0x210
> [    1.016329]  ? call_rcu+0xde/0x150
> [    1.016329]  ? trace_hardirqs_on+0x54/0x120
> [    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    1.016329]  call_rcu+0x39/0x150
> [    1.016329]  rcu_torture_init+0x1687/0x1759
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? irq_pm_init_ops+0x19/0x19
> [    1.016329]  ? mutex_unlock+0x12/0x20
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  do_one_initcall+0xc1/0x310
> [    1.016329]  ? initcall_blacklisted+0x140/0x140
> [    1.016329]  ? parameq+0x20/0x90
> [    1.016329]  ? __kmalloc+0x238/0x5d0
> [    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
> [    1.016329]  kernel_init_freeable+0x20a/0x268
> [    1.016329]  ? rest_init+0x160/0x160
> [    1.016329]  kernel_init+0x1e/0x140
> [    1.016329]  ret_from_fork+0x22/0x30
> [    1.016329]  </TASK>
> [    1.016329] irq event stamp: 152
> [    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw=
_spin_unlock_irqrestore+0x4c/0x60
> [    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw=
_spin_lock_irqsave+0x71/0x90
> [    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_p=
rocess+0xc8c/0x31b0
> [    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.016329] ---[ end trace 0000000000000000 ]---
> [    1.016329] call_rcu(): Double-freed CB (____ptrval____)->rcu_torture_=
leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
> [    1.016329] ------------[ cut here ]------------
> [    1.016329] ODEBUG: activate active (active state 1) object type: rcu_=
head hint: 0x0
> [    1.016329] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_pri=
nt_object+0xda/0x100
> [    1.016329] Modules linked in:
> [    1.016329] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.=
19.0-rc3-yoctodev-standard+ #214
> [    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    1.016329] RIP: 0010:debug_print_object+0xda/0x100
> [    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e=
1 48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <=
0f> e
> [    1.016329] RSP: 0000:ffff888001337be0 EFLAGS: 00010086
> [    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed100=
0266f6e
> [    1.016329] RBP: ffff888001337c10 R08: ffffffff90a56ee6 R09: fffffbfff=
25df5c2
> [    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 000000000=
0000001
> [    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e8a0 R15: 000000000=
0000000
> [    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlG=
S:0000000000000000
> [    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 000000000=
01506f0
> [    1.016329] Call Trace:
> [    1.016329]  <TASK>
> [    1.016329]  debug_object_activate+0x2b9/0x300
> [    1.016329]  ? debug_object_assert_init+0x220/0x220
> [    1.016329]  ? _raw_spin_unlock+0x23/0x30
> [    1.016329]  ? find_vmap_area+0x5c/0x90
> [    1.016329]  ? do_raw_spin_unlock+0x85/0xe0
> [    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    1.016329]  call_rcu+0x20/0x150
> [    1.016329]  rcu_torture_init+0x16aa/0x1759
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? srcu_torture_completed+0x10/0x10
> [    1.016329]  ? irq_pm_init_ops+0x19/0x19
> [    1.016329]  ? mutex_unlock+0x12/0x20
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  do_one_initcall+0xc1/0x310
> [    1.016329]  ? initcall_blacklisted+0x140/0x140
> [    1.016329]  ? parameq+0x20/0x90
> [    1.016329]  ? __kmalloc+0x238/0x5d0
> [    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
> [    1.016329]  kernel_init_freeable+0x20a/0x268
> [    1.016329]  ? rest_init+0x160/0x160
> [    1.016329]  kernel_init+0x1e/0x140
> [    1.016329]  ret_from_fork+0x22/0x30
> [    1.016329]  </TASK>
> [    1.016329] irq event stamp: 152
> [    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw=
_spin_unlock_irqrestore+0x4c/0x60
> [    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw=
_spin_lock_irqsave+0x71/0x90
> [    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_p=
rocess+0xc8c/0x31b0
> [    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.016329] ---[ end trace 0000000000000000 ]---
> [    1.016329] ------------[ cut here ]------------
> [    1.016329] ODEBUG: active_state active (active state 1) object type: =
rcu_head hint: 0x0
> [    1.016329] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_pri=
nt_object+0xda/0x100
> [    1.016329] Modules linked in:
> [    1.016329] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.=
19.0-rc3-yoctodev-standard+ #214
> [    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    1.016329] RIP: 0010:debug_print_object+0xda/0x100
> [    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e=
1 48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <=
0f> e
> [    1.016329] RSP: 0000:ffff888001337bd0 EFLAGS: 00010082
> [    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed100=
0266f6c
> [    1.016329] RBP: ffff888001337c00 R08: ffffffff90a56ee6 R09: fffffbfff=
25df5c2
> [    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 000000000=
0000001
> [    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e640 R15: 000000000=
0000000
> [    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlG=
S:0000000000000000
> [    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 000000000=
01506f0
> [    1.016329] Call Trace:
> [    1.016329]  <TASK>
> [    1.016329]  debug_object_active_state+0x1d7/0x210
> [    1.016329]  ? debug_object_deactivate+0x210/0x210
> [    1.016329]  ? _raw_spin_unlock+0x23/0x30
> [    1.016329]  ? find_vmap_area+0x5c/0x90
> [    1.016329]  ? do_raw_spin_unlock+0x85/0xe0
> [    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    1.016329]  call_rcu+0x39/0x150
> [    1.016329]  rcu_torture_init+0x16aa/0x1759
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? srcu_torture_completed+0x10/0x10
> [    1.016329]  ? irq_pm_init_ops+0x19/0x19
> [    1.016329]  ? mutex_unlock+0x12/0x20
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  do_one_initcall+0xc1/0x310
> [    1.016329]  ? initcall_blacklisted+0x140/0x140
> [    1.016329]  ? parameq+0x20/0x90
> [    1.016329]  ? __kmalloc+0x238/0x5d0
> [    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
> [    1.016329]  kernel_init_freeable+0x20a/0x268
> [    1.016329]  ? rest_init+0x160/0x160
> [    1.016329]  kernel_init+0x1e/0x140
> [    1.016329]  ret_from_fork+0x22/0x30
> [    1.016329]  </TASK>
> [    1.016329] irq event stamp: 152
> [    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw=
_spin_unlock_irqrestore+0x4c/0x60
> [    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw=
_spin_lock_irqsave+0x71/0x90
> [    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_p=
rocess+0xc8c/0x31b0
> [    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.016329] ---[ end trace 0000000000000000 ]---
> [    1.016329] call_rcu(): Double-freed CB (____ptrval____)->rcu_torture_=
leak_cb+0x0/0x10()!!!   slab kmalloc-16 start ffff888003f49240 pointer offs=
et 06
> [    1.101401] rcu-torture: rcu_torture_read_exit: Start of test
>=20
> Thanks
> Zqiang
>=20
>=20
> >
> >							Thanx, Paul
>=20
> > ---
> >  v1->v2:
> >  for do duplicate kvfree_call_rcu(), not set leak callbacks.=20
> >=20
> >  kernel/rcu/tiny.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > index f0561ee16b9c..943d431b908f 100644
> > --- a/kernel/rcu/tiny.c
> > +++ b/kernel/rcu/tiny.c
> > @@ -158,6 +158,10 @@ void synchronize_rcu(void)
> >  }
> >  EXPORT_SYMBOL_GPL(synchronize_rcu);
> > =20
> > +static void tiny_rcu_leak_callback(struct rcu_head *rhp)
> > +{
> > +}
> > +
> >  /*
> >   * Post an RCU callback to be invoked after the end of an RCU grace
> >   * period.  But since we have but one CPU, that would be after any
> > @@ -165,9 +169,20 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
> >   */
> >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  {
> > +	static atomic_t doublefrees;
> >  	unsigned long flags;
> > =20
> > -	debug_rcu_head_queue(head);
> > +	if (debug_rcu_head_queue(head)) {
> > +		if (atomic_inc_return(&doublefrees) < 4) {
> > +			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head=
->func);
> > +			mem_dump_obj(head);
> > +		}
> > +
> > +		if (!__is_kvfree_rcu_offset((unsigned long)head->func))
> > +			WRITE_ONCE(head->func, tiny_rcu_leak_callback);
> > +		return;
> > +	}
> > +
> >  	head->func =3D func;
> >  	head->next =3D NULL;
> > =20
> > --=20
> > 2.25.1
> >=20
