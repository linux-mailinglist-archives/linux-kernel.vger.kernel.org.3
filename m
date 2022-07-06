Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949EF567BBC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 04:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiGFCBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 22:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGFCBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:01:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2418F19286;
        Tue,  5 Jul 2022 19:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657072875; x=1688608875;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nvRDbrKJpcoRHAnCt28RJ/wF+joZwZL3f0DxrsFsJyU=;
  b=Re+kaVCX7ty1WZshV+IJxCvsu8VNV19AB7k+SASJ0hAMffrIju4OHA6R
   a5GVXoCzIZmt6Zx7FI9H+mF5frWTSAVfmOkgVK03e//WyfBmENVB1PaZi
   3heQNdOyX6kjFz9NA6A8kTZP4Eac+bLS7i/PrbLYA2nhA9ZYesEUJOdFn
   If2cjs5lExUSddAhuJTh1//mjYGBExOKqOyA6IHrhngQjIxU50OOn58gZ
   a7m1HBHvkbG092Ncy2eBFPF7/kWG/KhpyTRX+H2PzRkpTXzkvR2446XJC
   XSZTzRixQ0rZ8wutEMbmAkcMVUVKt7HLgpLdd3IbRAOIKIPACP8JGX7UA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="369934820"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="369934820"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 19:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="769861615"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2022 19:00:54 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 19:00:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 19:00:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 19:00:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkthxXMk5PXgZOWAH8Yr5KJpPtFDskyN+px/PjAEbMZdzRlcxSxiEdBc7S1W/ycXu4KkCbZmoTfVWhI/qJzie1akqx8+HcbYUAeT2xiUdrJ/gH+AG098gZOTTum6f75j5ian9Lo19JqYMrww+FkjsPSEeOxhW2mLGzLl1RYl9uUIbRd3j6qxUcYtJgHRm3c9L4LFp3HvZxo8Xt6lxuvxa0UPiUVnhmFVOlnEvKXEpG1Ss99/J0CG4uN17/Qxnw9M39xtAKVBEYFp8GQEWPIDanp8Kylobci9yTHdLWDGPMSTANUflrPZrGy+otBJe2J3bgZmY+SVOxxzGOCLHLbWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDXEaFijw8vllluN/DKL3Rbxd8KTXebZsShuxHJ5RoI=;
 b=KneCJ255hKOm9Zs7KxEL7MPR9wHG9Pa8YTk3qMYwi2WPcut4wwTQ1J11NWEUWMynw8lTwavx+w8Fk2h0dGFNMF72hwQP0c93qeOXlsOxJn2CsWafyOPxMOnmwQmAWhlz3U8qTTK8Zu+0C+5IyHeKmv2ioMeCiJXZVJUA9db9wuCNanrAX5QuBXALWezoY6xttZN5k6++wS7AhUSS5YRrGDnkN3s9t3t1/Tfl2h6JAubZe82sOo4UJSn53vqUO4m0CxEshlivl2c7r4HbU4RioiKw1OnPxqyn5KGDQVzFSxNXKVBBxSTVpRSmvwU9PkJGqNZgsIUNR6nSaSKkzHBBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM5PR11MB1434.namprd11.prod.outlook.com (2603:10b6:4:9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Wed, 6 Jul 2022 02:00:51 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14%4]) with mapi id 15.20.5395.019; Wed, 6 Jul 2022
 02:00:51 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Make tiny RCU support leak callbacks for
 debug-object errors
Thread-Topic: [PATCH v2] rcu: Make tiny RCU support leak callbacks for
 debug-object errors
Thread-Index: AQHYjPSNkw8Leg1ATEaQzvaLUuKjoa1wEumAgACIyGA=
Date:   Wed, 6 Jul 2022 02:00:51 +0000
Message-ID: <PH0PR11MB5880370195C11E8E943069CBDA809@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220701024404.2228367-1-qiang1.zhang@intel.com>
 <20220705174109.GD1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220705174109.GD1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 3f870afd-9721-49c7-7c51-08da5ef35a8b
x-ms-traffictypediagnostic: DM5PR11MB1434:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k/SHac8MxnVnj32f4fCLIcjx7gMzBdKpY+ZuUdxZSBfRQi86TYMhXdLCPVTjrj4RjtnTg9jtSjz5wPOZFSK+hbYF/bKj0TxyW4YVoJLJ/D46iEUDbq1o0oC/tVuRlCVvUbf7Tz3zjqHx7gnH7vS/f9o0XJYapNtqYgBoH2NOyvMCTFOcLaNpHSfyDEGBkI6ZD+S99Ue0naDpZTmiAileSWI78I9zMNlRiPdn9d0NQ4SrlwnNnJByo8U1pdVhCtukiEi+USMafuEoP30voNr+DCo2xedeXWhCII3fukxinOwqXxDB3vfKPiKiFBuaRgK/5o+jnaxspM169pPAFpSCiHoOv53RxCO9ClqIHh9/yviVv6rKfC69YCvIdJo8QYJOsJNXBJzMsDKbTOLS0yU+6pZApnGGRF+AGjWQqgaTaTHAZElrU6IsfPubhAsvpWSQXG87HCXL9fwC7sk77kBe/OlG04ePITxal8xiPp+EP5oEuSR6wUOD0dCBNHo5/ZRCOUYYd86PYk4f7lM8l/N+TAyEoH6KIW3xuGkt2HPlcjT6jDOijFnjUaxrGJCSYbSZggZOnNfXePHB7tOnSs/S8cVR+JA565VlmBctw8Yj5FyNAtkxyCOCgXd9nBA/O3ItHGuEIz169r8SHvQZFzZuysT/oju8y61dfiNespf1NguuJqucnhXec6V7gKmdeCFjlmmRjGntdmhdxc7NDHhlYUj9C6yVLySMOCxmWAm2ilQJkhVYTpHTXQc86NGLS25/Aoc1v4ur0zLQgkHyfzXLqCjs+P/dtCSVib6IvdgcG1EYcjWSvyqcZYlCYfkApM/+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(39860400002)(346002)(8936002)(52536014)(38100700002)(86362001)(478600001)(33656002)(76116006)(122000001)(66946007)(4326008)(8676002)(9686003)(64756008)(66446008)(66476007)(66556008)(82960400001)(30864003)(5660300002)(71200400001)(26005)(55016003)(186003)(45080400002)(316002)(6916009)(7696005)(54906003)(2906002)(41300700001)(6506007)(83380400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FzPIbicLTlkOhO6C9+jjq15LgcG6nbYRNP+URBvyNcz4VWOmDXDIDuzBcSXN?=
 =?us-ascii?Q?9lNAc4LD9i81AGBUdRRggsNAnmRri5nOpD+Y5XrqGGf0kwlJR0zZKWCVNoh2?=
 =?us-ascii?Q?s3I0ohf0HG9KfOGjmvrZoZs5zHPRCattW6hJ63Z82dRTkMbsRM5C+Oa2tXZM?=
 =?us-ascii?Q?FWnHFb2l0QCYIbBVBWkswtrrJ/6j+o7UrN+zizMs2OnQ7208QF+f5yPigXYv?=
 =?us-ascii?Q?CvhJTEfLMyZrIGeAT4Rncqeo0JFUpYkoZDNLHQ3pYEIm1uamqF1Z9dBfD+uO?=
 =?us-ascii?Q?1/Xg5gi46jddN3hQx0+/dzGpUAnAQAwjN82QLsiiwkf9RSIOWyIYlGeOgXa/?=
 =?us-ascii?Q?BjKu3JnrTD0pwKec7bWMMCyFqVfPXofqtCQVM/TtpxzEViov4HhjvGA8ArIL?=
 =?us-ascii?Q?URCRRCJ0g88qJwsf2+VkyStJ7O1BO2Iff1Dkod0L+RLh66DgPPV638xi6DYA?=
 =?us-ascii?Q?HZ/3TmMfLAgkSM6SMElnqdHqsMieUc5mWCCJY6WlVZjeyOuXllv14kOLki9k?=
 =?us-ascii?Q?4ca+LqOZp6HZj96ziHZmPaFZ2YWfxOjT9H5py1eQq7w4Z6dNEvEeUOJ2ADuO?=
 =?us-ascii?Q?56Xp1rm5jTLNGYvNMLUVfwAkhGfrdKGe4MZksPmMxG8hzcQqZOSaZHYMnYv+?=
 =?us-ascii?Q?jYUK70bJZ4+rG0SvMoSdt5koYZNFrSnZpHGoPDLptW9bSvxsZzjzs6oOksQh?=
 =?us-ascii?Q?/49J25UBTd5eiyiJJKFyaKfz54/Bz3FR2Ev+H2Eixc0L8As91PGI6HNsDIUM?=
 =?us-ascii?Q?CJPJBcql/BFU9M3KLlIrVs6p1eeWJC3VKcMl5THmD1Z8H5XB1fFb2odctSPP?=
 =?us-ascii?Q?LZuh12Zm3BLIHhyaS4ompHA3e8tSM8iDw+WZr2bIdtZnaBTjjvPRM4E3lKG2?=
 =?us-ascii?Q?VpRXRNebQb/KdN921nogBI5osF/vT0UXRB8PtUKqzFSkMQ/S3BT0pHU2BFyd?=
 =?us-ascii?Q?2WvqTt8efNH8bO7wCC89lzstW7Pv15Zhi0x7tvUWGluYze9ziY68L6jnaXOJ?=
 =?us-ascii?Q?J45qG8ptTsStnQjGmfxQiyFUPC2RQj2KCthsgbkON4/nsG1/9B6jiz6vL5zw?=
 =?us-ascii?Q?j0ceyRayWBTDYa7wsa5lhyLKRX/Vjxctj/xuOk3db+wWRIAafLfP8y/U4tMX?=
 =?us-ascii?Q?0KKdCdMJiCv/176IsEi9QkYb6U85KVPLD3y7+spHypVUczOx+MIx3lhX6lOu?=
 =?us-ascii?Q?aq/NpErPTQcnU0T3D+wFi9Z9VPjMQdUmr6Q9VwReT+ST5OzxtJHQZARyrLn0?=
 =?us-ascii?Q?GiVj8rW9z2kiHmDFV25JKXFJzIsqmmyK3igirA0D/FIuQjcbEK+w6Lu5YI1o?=
 =?us-ascii?Q?xtFB2GeatwxrB+5TAQkU0aE0UqwVUzwo8FI35Znq5nWkjOHlMlSJUGUfj+Rv?=
 =?us-ascii?Q?t2k9MYHb3vbN+Y1g/N8zngJsLb1dv8KFKnQB8GxhDxw4UKUxEgqQ9zodYJcI?=
 =?us-ascii?Q?VLe05s1XRuwPXqn/V0Xxx18exKIU+PSs6RicT6ttC2y7IGXtmT3gOemLZRJb?=
 =?us-ascii?Q?4EANpJzGFb4HQHrNmgMO7wshMAfC1ntGk5uQgmXhf4CKjUL9dck0vGSIkaIL?=
 =?us-ascii?Q?IRpw1WYweASrOINkjlM/UV+tSOU+UP7LY12qg6gC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f870afd-9721-49c7-7c51-08da5ef35a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 02:00:51.4876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4wGZ0vOaUdtNPeVKWUqBqZtdsxWpDDG2ZLRrPtIviMo+i8UCv4v1WNIHqC3Vhor+y/jIA0637UX78woGYKAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1434
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

On Fri, Jul 01, 2022 at 10:44:04AM +0800, Zqiang wrote:
> Currently, only tree RCU support leak callbacks setting when do
> duplicate call_rcu(). this commit add leak callbacks setting when
> fo duplicate call_rcu() for tiny RCU.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

>This does look plausible, thank you!
>
>What testing have you done?
>
>One important test for Tiny RCU is that the size of the kernel not
>grow without a very good reason.  In this case, the added code should
>be dead code in a production build (CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn),
>but it is good to check.
>
>It is of course also good to check that the messages print as expected,
>which is what rcutorture.object_debug is there to help with.

In the condition that the CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn, the function d=
irectly returns zero.

#else   /* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
static inline int debug_rcu_head_queue(struct rcu_head *head)
{
        return 0;
}

My test results are as follows:

runqemu kvm slirp nographic qemuparams=3D"-m 2048 -smp 1" bootparams=3D"rcu=
torture.object_debug=3D1" -d

log:
root@qemux86-64:/# zcat /proc/config.gz | grep RCU
# RCU Subsystem
CONFIG_TINY_RCU=3Dy
CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy

[    1.015657] rcutorture: WARN: Duplicate call_rcu() test starting.
[    1.015659] ------------[ cut here ]------------
[    1.015659] ODEBUG: activate active (active state 1) object type: rcu_he=
ad hint: 0x0
[    1.015680] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_print=
_object+0xda/0x100
[    1.016329] Modules linked in:
[    1.016329] CPU: 0 PID: 1 Comm: swapper Not tainted 5.19.0-rc3-yoctodev-=
standard+ #214
[    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    1.016329] RIP: 0010:debug_print_object+0xda/0x100
[    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e1 =
48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <0f=
> e
[    1.016329] RSP: 0000:ffff888001337be0 EFLAGS: 00010086
[    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000000=
00000
[    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed10002=
66f6e
[    1.016329] RBP: ffff888001337c10 R08: ffffffff90a56ee6 R09: fffffbfff25=
df5c2
[    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 00000000000=
00001
[    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e8a0 R15: 00000000000=
00000
[    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlGS:=
0000000000000000
[    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 00000000001=
506f0
[    1.016329] Call Trace:
[    1.016329]  <TASK>
[    1.016329]  debug_object_activate+0x2b9/0x300
[    1.016329]  ? debug_object_assert_init+0x220/0x220
[    1.016329]  ? lockdep_hardirqs_on_prepare+0x13/0x210
[    1.016329]  ? call_rcu+0xde/0x150
[    1.016329]  ? trace_hardirqs_on+0x54/0x120
[    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
[    1.016329]  call_rcu+0x20/0x150
[    1.016329]  rcu_torture_init+0x1687/0x1759
[    1.016329]  ? srcu_init+0xaa/0xaa
[    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
[    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
[    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
[    1.016329]  ? irq_pm_init_ops+0x19/0x19
[    1.016329]  ? mutex_unlock+0x12/0x20
[    1.016329]  ? srcu_init+0xaa/0xaa
[    1.016329]  do_one_initcall+0xc1/0x310
[    1.016329]  ? initcall_blacklisted+0x140/0x140
[    1.016329]  ? parameq+0x20/0x90
[    1.016329]  ? __kmalloc+0x238/0x5d0
[    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
[    1.016329]  kernel_init_freeable+0x20a/0x268
[    1.016329]  ? rest_init+0x160/0x160
[    1.016329]  kernel_init+0x1e/0x140
[    1.016329]  ret_from_fork+0x22/0x30
[    1.016329]  </TASK>
[    1.016329] irq event stamp: 152
[    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw_s=
pin_unlock_irqrestore+0x4c/0x60
[    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw_s=
pin_lock_irqsave+0x71/0x90
[    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_pro=
cess+0xc8c/0x31b0
[    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    1.016329] ---[ end trace 0000000000000000 ]---
[    1.016329] ------------[ cut here ]------------
[    1.016329] ODEBUG: active_state active (active state 1) object type: rc=
u_head hint: 0x0
[    1.016329] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_print=
_object+0xda/0x100
[    1.016329] Modules linked in:
[    1.016329] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.19=
.0-rc3-yoctodev-standard+ #214
[    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    1.016329] RIP: 0010:debug_print_object+0xda/0x100
[    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e1 =
48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <0f=
> e
[    1.016329] RSP: 0000:ffff888001337bd0 EFLAGS: 00010082
[    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000000=
00000
[    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed10002=
66f6c
[    1.016329] RBP: ffff888001337c00 R08: ffffffff90a56ee6 R09: fffffbfff25=
df5c2
[    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 00000000000=
00001
[    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e640 R15: 00000000000=
00000
[    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlGS:=
0000000000000000
[    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 00000000001=
506f0
[    1.016329] Call Trace:
[    1.016329]  <TASK>
[    1.016329]  debug_object_active_state+0x1d7/0x210
[    1.016329]  ? debug_object_deactivate+0x210/0x210
[    1.016329]  ? lockdep_hardirqs_on_prepare+0x13/0x210
[    1.016329]  ? call_rcu+0xde/0x150
[    1.016329]  ? trace_hardirqs_on+0x54/0x120
[    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
[    1.016329]  call_rcu+0x39/0x150
[    1.016329]  rcu_torture_init+0x1687/0x1759
[    1.016329]  ? srcu_init+0xaa/0xaa
[    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
[    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
[    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
[    1.016329]  ? irq_pm_init_ops+0x19/0x19
[    1.016329]  ? mutex_unlock+0x12/0x20
[    1.016329]  ? srcu_init+0xaa/0xaa
[    1.016329]  do_one_initcall+0xc1/0x310
[    1.016329]  ? initcall_blacklisted+0x140/0x140
[    1.016329]  ? parameq+0x20/0x90
[    1.016329]  ? __kmalloc+0x238/0x5d0
[    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
[    1.016329]  kernel_init_freeable+0x20a/0x268
[    1.016329]  ? rest_init+0x160/0x160
[    1.016329]  kernel_init+0x1e/0x140
[    1.016329]  ret_from_fork+0x22/0x30
[    1.016329]  </TASK>
[    1.016329] irq event stamp: 152
[    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw_s=
pin_unlock_irqrestore+0x4c/0x60
[    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw_s=
pin_lock_irqsave+0x71/0x90
[    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_pro=
cess+0xc8c/0x31b0
[    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    1.016329] ---[ end trace 0000000000000000 ]---
[    1.016329] call_rcu(): Double-freed CB (____ptrval____)->rcu_torture_le=
ak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
[    1.016329] ------------[ cut here ]------------
[    1.016329] ODEBUG: activate active (active state 1) object type: rcu_he=
ad hint: 0x0
[    1.016329] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_print=
_object+0xda/0x100
[    1.016329] Modules linked in:
[    1.016329] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.19=
.0-rc3-yoctodev-standard+ #214
[    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    1.016329] RIP: 0010:debug_print_object+0xda/0x100
[    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e1 =
48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <0f=
> e
[    1.016329] RSP: 0000:ffff888001337be0 EFLAGS: 00010086
[    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000000=
00000
[    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed10002=
66f6e
[    1.016329] RBP: ffff888001337c10 R08: ffffffff90a56ee6 R09: fffffbfff25=
df5c2
[    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 00000000000=
00001
[    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e8a0 R15: 00000000000=
00000
[    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlGS:=
0000000000000000
[    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 00000000001=
506f0
[    1.016329] Call Trace:
[    1.016329]  <TASK>
[    1.016329]  debug_object_activate+0x2b9/0x300
[    1.016329]  ? debug_object_assert_init+0x220/0x220
[    1.016329]  ? _raw_spin_unlock+0x23/0x30
[    1.016329]  ? find_vmap_area+0x5c/0x90
[    1.016329]  ? do_raw_spin_unlock+0x85/0xe0
[    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
[    1.016329]  call_rcu+0x20/0x150
[    1.016329]  rcu_torture_init+0x16aa/0x1759
[    1.016329]  ? srcu_init+0xaa/0xaa
[    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
[    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
[    1.016329]  ? srcu_torture_completed+0x10/0x10
[    1.016329]  ? irq_pm_init_ops+0x19/0x19
[    1.016329]  ? mutex_unlock+0x12/0x20
[    1.016329]  ? srcu_init+0xaa/0xaa
[    1.016329]  do_one_initcall+0xc1/0x310
[    1.016329]  ? initcall_blacklisted+0x140/0x140
[    1.016329]  ? parameq+0x20/0x90
[    1.016329]  ? __kmalloc+0x238/0x5d0
[    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
[    1.016329]  kernel_init_freeable+0x20a/0x268
[    1.016329]  ? rest_init+0x160/0x160
[    1.016329]  kernel_init+0x1e/0x140
[    1.016329]  ret_from_fork+0x22/0x30
[    1.016329]  </TASK>
[    1.016329] irq event stamp: 152
[    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw_s=
pin_unlock_irqrestore+0x4c/0x60
[    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw_s=
pin_lock_irqsave+0x71/0x90
[    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_pro=
cess+0xc8c/0x31b0
[    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    1.016329] ---[ end trace 0000000000000000 ]---
[    1.016329] ------------[ cut here ]------------
[    1.016329] ODEBUG: active_state active (active state 1) object type: rc=
u_head hint: 0x0
[    1.016329] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_print=
_object+0xda/0x100
[    1.016329] Modules linked in:
[    1.016329] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.19=
.0-rc3-yoctodev-standard+ #214
[    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    1.016329] RIP: 0010:debug_print_object+0xda/0x100
[    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e1 =
48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <0f=
> e
[    1.016329] RSP: 0000:ffff888001337bd0 EFLAGS: 00010082
[    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000000=
00000
[    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed10002=
66f6c
[    1.016329] RBP: ffff888001337c00 R08: ffffffff90a56ee6 R09: fffffbfff25=
df5c2
[    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 00000000000=
00001
[    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e640 R15: 00000000000=
00000
[    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlGS:=
0000000000000000
[    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 00000000001=
506f0
[    1.016329] Call Trace:
[    1.016329]  <TASK>
[    1.016329]  debug_object_active_state+0x1d7/0x210
[    1.016329]  ? debug_object_deactivate+0x210/0x210
[    1.016329]  ? _raw_spin_unlock+0x23/0x30
[    1.016329]  ? find_vmap_area+0x5c/0x90
[    1.016329]  ? do_raw_spin_unlock+0x85/0xe0
[    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
[    1.016329]  call_rcu+0x39/0x150
[    1.016329]  rcu_torture_init+0x16aa/0x1759
[    1.016329]  ? srcu_init+0xaa/0xaa
[    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
[    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
[    1.016329]  ? srcu_torture_completed+0x10/0x10
[    1.016329]  ? irq_pm_init_ops+0x19/0x19
[    1.016329]  ? mutex_unlock+0x12/0x20
[    1.016329]  ? srcu_init+0xaa/0xaa
[    1.016329]  do_one_initcall+0xc1/0x310
[    1.016329]  ? initcall_blacklisted+0x140/0x140
[    1.016329]  ? parameq+0x20/0x90
[    1.016329]  ? __kmalloc+0x238/0x5d0
[    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
[    1.016329]  kernel_init_freeable+0x20a/0x268
[    1.016329]  ? rest_init+0x160/0x160
[    1.016329]  kernel_init+0x1e/0x140
[    1.016329]  ret_from_fork+0x22/0x30
[    1.016329]  </TASK>
[    1.016329] irq event stamp: 152
[    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw_s=
pin_unlock_irqrestore+0x4c/0x60
[    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw_s=
pin_lock_irqsave+0x71/0x90
[    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_pro=
cess+0xc8c/0x31b0
[    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    1.016329] ---[ end trace 0000000000000000 ]---
[    1.016329] call_rcu(): Double-freed CB (____ptrval____)->rcu_torture_le=
ak_cb+0x0/0x10()!!!   slab kmalloc-16 start ffff888003f49240 pointer offset=
 06
[    1.101401] rcu-torture: rcu_torture_read_exit: Start of test

Thanks
Zqiang


>
>							Thanx, Paul

> ---
>  v1->v2:
>  for do duplicate kvfree_call_rcu(), not set leak callbacks.=20
>=20
>  kernel/rcu/tiny.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index f0561ee16b9c..943d431b908f 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -158,6 +158,10 @@ void synchronize_rcu(void)
>  }
>  EXPORT_SYMBOL_GPL(synchronize_rcu);
> =20
> +static void tiny_rcu_leak_callback(struct rcu_head *rhp)
> +{
> +}
> +
>  /*
>   * Post an RCU callback to be invoked after the end of an RCU grace
>   * period.  But since we have but one CPU, that would be after any
> @@ -165,9 +169,20 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
>   */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> +	static atomic_t doublefrees;
>  	unsigned long flags;
> =20
> -	debug_rcu_head_queue(head);
> +	if (debug_rcu_head_queue(head)) {
> +		if (atomic_inc_return(&doublefrees) < 4) {
> +			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->=
func);
> +			mem_dump_obj(head);
> +		}
> +
> +		if (!__is_kvfree_rcu_offset((unsigned long)head->func))
> +			WRITE_ONCE(head->func, tiny_rcu_leak_callback);
> +		return;
> +	}
> +
>  	head->func =3D func;
>  	head->next =3D NULL;
> =20
> --=20
> 2.25.1
>=20
