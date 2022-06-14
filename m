Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88F954A34E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 02:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiFNAwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 20:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiFNAwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 20:52:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5177958E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655167949; x=1686703949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jejakw4Wmp7aHPTfKJAEYGLXfi61fB16k4MqwlOIclE=;
  b=EnWSppX0qWQTSx78Y8Lj7TzQkdAMoCzJfnGJ8U+T7Av26low8QO4A3XB
   Y8ulxrNHuYF5Za706jwa5w4/T0E+9D7b/cgXxgWmt+BTOCTAiWGwO0Gxj
   EsW/q7Im571ERFwNuB4QJIYLcM/ckjGOWswHt/dO4xz3GiGSaEUasAAsn
   dOyi1v97n8M3il6GO8bv1aPjy9gDEyDQCIp6V86Q6RtCzkSLE00U+JM4Q
   662bytD3dCAA5irHw6yiVAUmRpYs8lygeSQ6cQTabNu9v360P7XTTBNLJ
   Zr+P/40ZyT4EKii9BzTJKyH8dXfcoI7j6ARfB8qPYIGHZX1hFOcr4hzXu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="340126449"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="340126449"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 17:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="651715905"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2022 17:52:26 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 17:52:26 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 17:52:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 17:52:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 17:52:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h54bWLAxBrcJ1gPb/3rj5x1nHnrYaEKa83zSYgJI0zRKwLL6xq5RsKCaBJ8mWWDpKRO0CyjPj6w3C/r+vSJLkIKiSalv5tOkxjYCDOYA0RPV6a5VOL7Ta0dzAYlQvTyepyclCMJe1aZpmhckAuDcwqSf6g+pF3+rVVvYPDF/8+TYj9X/+ugRrelvH+Bv5v3XfrdMgGveOwVE6t+UEg+W41gMYea+gW0N+nW9QJxqXtFjbJ21h9Lu33QoIJzTP1vVQ9P8b+hQRDgL0I4WDRfz7rbiaB5PmIaRYDow9z3KkDwNc6uKrC6W63jiCcvqUcUy/tYu9i3BkzlLAS7qyOrVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cduNTM2kg+M4/hnmBw4hpq+1FQTQyl7NHSE8l3ChV2c=;
 b=dKxfatQbAChDkko0Uow/D4//+6ro9agnSKlIc+xrQLRmBoyGqSsoqSG7NqnORB+3VenQ/EKHNRQcdvYo55M+Jc3vsQS4TNrFrgwh+dx0rDmcmbUDRfb7N1C+qAA5KViZhQswFxETSSPH3xIPXRPe/wu1FHxZYaZlEHwQQeyEdwkL3VK35zUNcBsiVGxWY1IsquTxpw8YYyIOXBaqxTTPVQUDcnrpLhHqOECLgRBfUO/i9f5ExICuYcc5960c9C7Z0HxJNapCcgwLTpD1hU9QB1Uz01quUuAKBzCqY5JRmdvZl5uE0CTNN62WNjptMSUqxeMmM2KqwMdLexTDdk02eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CY4PR11MB1863.namprd11.prod.outlook.com (2603:10b6:903:121::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 00:52:23 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 00:52:23 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] WARNING in exit_tasks_rcu_finish
Thread-Topic: [syzbot] WARNING in exit_tasks_rcu_finish
Thread-Index: AQHYfnKnPcEG5KPSqUKTUzyVmEvcrK1MN1mLgADFmMCAAHlEgIAAboyggAAbjYCAAAEvgIAABfiAgAAHecA=
Date:   Tue, 14 Jun 2022 00:52:23 +0000
Message-ID: <PH0PR11MB5880C6814BA88CD660610344DAAA9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220613233753.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <202206131639.DBA0A8D@keescook>
 <20220614000329.GO1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220614000329.GO1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 63986618-5724-4601-b1f3-08da4da0250b
x-ms-traffictypediagnostic: CY4PR11MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR11MB186365F249C8DFEAAD693E5FDAAA9@CY4PR11MB1863.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: exauaJ5w23LfvCzpRW8pd89w6AV4I7H4sglAhcrnpAdHYCCqRIp53hPKNwN+adB9T32iO+qNv6RSNiB1V16etORWrqQo4VGEbBs0TK2HQe3hKvhV+yocoRg4X4M7LXpY6HLB+9EyaLdyabSYYsdOc4jeYXR/nryJUtO5oaqmA0upfjb1DM/XdBch+1QjE1M8vLXSI9L8Fe59JLji+382wvSMF4djPobkhidTOqz9WA56S3xD1L+F/b0hUIHzwV5mQ+8G3i3BKXCGP5dTB3QjeZjH7/rnaTvtau2ZNqVHHQRqtrz1JfFmVVKvFlgcOgGsJYLE2K852IaqnJJZOK3ucTwIX5zyTkE5bM0+JCeQIx1TzeGkFd+6cMjW1KMg3SuCt1PrG1iC8bl+sriA9s1ia9DWkPHBtzV8w9iH1w6Yav/xjXUdEipCq0MkXflozp/RfKamC9a3esLmr1Htdplyys+JXQvdQzMW8YkUg1QuSZg/TBKD4pUjnZBfXJfRqal8TqRnzW1A+heQM1tXIwOx0Ihf1EObiDICio+fjef6da4Yh74jFkrC21Smo5pabQ2E37oLVqMpg5lDkvOiTvG7L6fQgHgnVpHwdKHPGckwaJg5LXUEfRq2uCAPP3+NVI9tUxSXeoK0fq5VmLi26ft2sA6QgZNOJTyjTnnjvV12mJuqhWRDawJTpGy2CNnbPZh+qsl1UJOVUGXD92jvLBfcjEEo3dqxKdQvgeuSn7o4irnHBwa3XQD3OkSVJmHx1AOSffx6ZaGt0d15O28Ws82EuaO3wo0PNtXZWJeu/qcyk1sirW4ibjnHb86DZnJ/Hf+j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(45080400002)(71200400001)(54906003)(7696005)(55016003)(6506007)(508600001)(966005)(186003)(316002)(38100700002)(33656002)(26005)(110136005)(83380400001)(66476007)(76116006)(66446008)(8936002)(64756008)(4326008)(8676002)(66556008)(66946007)(82960400001)(9686003)(122000001)(38070700005)(86362001)(2906002)(52536014)(5660300002)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pqQ9Ko04zIBmVwj0o/BSDphVcYMHw4rn+HexJwBjpOHM4E6TUxdDCsH+t9xT?=
 =?us-ascii?Q?kLmxLBGhkkMkM3bQZmhb0fWmVIna/p57CaKPi+mNrwwzi77AmaT/w9UU/Hgp?=
 =?us-ascii?Q?nAQ1jZLw4OH7luEhEyQjvnqyVwTTNesscWDs83Gye0aU6/6Zi9Kr42FE2/n0?=
 =?us-ascii?Q?wxpGY0LUDTkcW1T8YBijrPSawgEmU9CamFl0QZIRp6Npw1NpLBbx1r8z2TCU?=
 =?us-ascii?Q?zpSUNaHLKVjPnGW4XTM0NLYcJ6Vlr20cN3pEU+AJHg59Rl4A23CVfzpl0Y9I?=
 =?us-ascii?Q?hk1XTir2REQCzKMfIQwjzGE5FNINPE0ZLlJ2XNHnc6tBBFCjXXzBMXW4DnYV?=
 =?us-ascii?Q?vd8fnz0xQGxQYCXd4Z3n1ZqhtueLvDbeTOkhM+O8+dkxuoBEN35BohCmIpNl?=
 =?us-ascii?Q?9Jjch34OlZCL9sfHmvx2ryX/70JvxxvxZqXFUmQwQPpV9gke1+zPZUi1GLT6?=
 =?us-ascii?Q?EA/Ev3nPWKuar4KlX6SU3OabD8YhDxGKsI3EEJn4seOJgtn5o8Q7XdUbYTx2?=
 =?us-ascii?Q?xCqNFTqIyF2LmC7FvfepmO4Wf36AbIZ/UwsQiS00CfdRqojnm0gHjGfJ9s//?=
 =?us-ascii?Q?IOx+rsf8B39SY/SZT1ISvy0EkLG2PcB7O5KgkKVt3rsT2yhcLl2Lp+8jSC3A?=
 =?us-ascii?Q?Rw+dxHla7NbBXm1EWILpkIPYYwIF3Ma9EjtSnjbE3ARTiwt63OkI4ZY1x3/U?=
 =?us-ascii?Q?8wj0j+dkgUdOz2Thh9nKy4U9Sk423TFPyMkqrpbVOzlrBqDrxOmBQdE3Sa6h?=
 =?us-ascii?Q?VRBxrNkGiwcUiB3bvzaG85ijEczhO7vvRdrqrSjtih85RKhkzx2pUrJOf1xv?=
 =?us-ascii?Q?rR91pYARFiuWBZPqc/68CRzMvcDbFchtOh69zx4XPwdjk8UhDSQ8qsKOfl/u?=
 =?us-ascii?Q?H/JhCSZhF57aBKqR63ZUOhZo1N1qpxrEsQHVK01A/PVX390U9S17+Ivv3Xys?=
 =?us-ascii?Q?wpgNJ76mt5HeAKeuZDJgLfpqNH3NQAaAkvVRkVpxpU67iGNFqxD2J7mHikfi?=
 =?us-ascii?Q?x5hPb2eLEMNqHy9DQfaUw9WeFzYnqkORFHB+RdrNGqvCVHLrkFSa1UAn22+C?=
 =?us-ascii?Q?StsZdnLu8qLCG83v+tvxKuPILhio74MW8rsShhjK9OSIzwc6lcEQS3mtDq8h?=
 =?us-ascii?Q?cVFyPY2Gi2CoAb6chaGL9kf/CYz0axlzn+WZ2ONR8SbE0cfvfyF170o2xQFp?=
 =?us-ascii?Q?Ngd7yswAZvmE90Guzp7TT0+F/juiz+6dwR9aJmIInsGb3rliH5EpiXQnUUgB?=
 =?us-ascii?Q?RUtLhTnqteofFLjn1iojVw8MWajHBrmnr7Km6bDGodu5AgdchNJR19q8o5hR?=
 =?us-ascii?Q?LZVyD2vW5JzSF+T0R23JGlJ2XGjTvkqt100/QzGOCp16QNz7W2VHZzDD/EQS?=
 =?us-ascii?Q?jupe8RvJd1VY/R1GKpX/rlF/AAzqXrmGGEviHEdvFH7g3LUiUo2EJMDQEucV?=
 =?us-ascii?Q?NcJl278b/oZQWqV6pd3aLvn4VogKOAqrHaxuLLRLbWpy+qgoAkoOhg4Pqsx5?=
 =?us-ascii?Q?jISjbwQxnEjQ7umaWH/pcNGMmSta0JFuz1ePnl2yGfxdMxedE4UC+KSl9ALq?=
 =?us-ascii?Q?OjPxuaOvGm1x6hqLJHrUPZFE3H6ZjFfZjAPyvr7uDDLCDOtCg/bxb7TvFN2n?=
 =?us-ascii?Q?/UKAhURwEckqLXSHgpHn/711PwQFQ5c/Zbp57RwcoXBv2JSEcOsXdcKQVC6S?=
 =?us-ascii?Q?J0jRQoAklVpk5/yYvWc0KMS1tmyJrLaUYk7wZDW2WvZ+Q17as8FR7YJ6ioE7?=
 =?us-ascii?Q?BfHsU6hQwA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63986618-5724-4601-b1f3-08da4da0250b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 00:52:23.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1DWQmWb9obF6uCLhyekkfOXsue3+FAJTZZ85vj4DiOHV4WCq2MSb7N2Jqk02j+6REMaeAl+oC44kgcUHInr/wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1863
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jun 13, 2022 at 04:42:07PM -0700, Kees Cook wrote:
> On Mon, Jun 13, 2022 at 10:36:07AM -0700, syzbot wrote:
> > Hello,
> >=20
> > syzbot has tested the proposed patch and the reproducer did not trigger=
 any issue:
> >=20
> > Reported-and-tested-by:=20
> > syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
>=20
> Looks like the patch solved the reproducer. :)

>For one of the two possible ways to make the bug happen.  ;-)
>
>Still, good on Qiang for identifying one of the paths!  Not just anyone ca=
n do that.

Thanks Paul, yes this patch can solved the reproducer and I also test it.

I compiled "bpf_test" according to the c file in the following link

C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D148207bff00000

Not apply this patch, this calltrace reproduce

root@qemux86-64:/# ./bpf_test
^C
root@qemux86-64:/# dmesg
[  147.017232] ------------[ cut here ]------------
[  147.017234] WARNING: CPU: 3 PID: 21586 at kernel/rcu/tasks.h:1664 exit_t=
asks_rcu_finish+0xbf/0x100
[  147.017245] Modules linked in:
[  147.017249] CPU: 3 PID: 21586 Comm: bpf_test Not tainted 5.19.0-rc1-next=
-20220610-yoctodev-standard #204
[  147.017253] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  147.017256] RIP: 0010:exit_tasks_rcu_finish+0xbf/0x100
[  147.017261] Code: 03 00 00 85 c0 75 59 f0 83 44 24 fc 00 49 8d bc 24 41 =
03 00 00 e8 21 09 2b 00 41 0f b6 84 24 41 03 00 00 83 e0 01 08 d8 74 11 <0f=
> 8
[  147.017264] RSP: 0018:ffff88810ccd7af0 EFLAGS: 00010202
[  147.017268] RAX: 0000000000000001 RBX: 0000000000000201 RCX: ffffffff897=
ab52f
[  147.017271] RDX: 1ffff1102181d7c8 RSI: 0000000000000000 RDI: ffff88810c0=
ebe41
[  147.017274] RBP: ffff88810ccd7b08 R08: ffffffff897ab510 R09: 00000000000=
00000
[  147.017277] R10: ffffffff8c407bbf R11: 0000000000000000 R12: ffff88810c0=
ebb00
[  147.017279] R13: ffff88810c0ebe38 R14: ffff88810ccd7b78 R15: ffff88810cc=
d76b0
[  147.017282] FS:  0000000000000000(0000) GS:ffff88815a000000(0000) knlGS:=
0000000000000000
[  147.017287] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  147.017289] CR2: 0000000000000000 CR3: 000000011ac16000 CR4: 00000000001=
506e0
[  147.017292] Call Trace:
[  147.017294]  <TASK>
[  147.017297]  do_exit+0xe9a/0x13a0
[  147.017305]  ? mm_update_next_owner+0x450/0x450
[  147.017309]  ? lock_downgrade+0x410/0x410
[  147.017313]  ? lock_contended+0x790/0x790
[  147.017317]  ? rcu_read_lock_held_common+0x1e/0x60
[  147.017324]  do_group_exit+0x71/0x150
[  147.017329]  get_signal+0x1319/0x1340
[  147.017334]  ? futex_wait_setup+0x180/0x180
[  147.017341]  ? exit_signals+0x4c0/0x4c0
[  147.017345]  ? futex_wake+0x29e/0x2e0
[  147.017351]  arch_do_signal_or_restart+0x9c/0xc60
[  147.017357]  ? rcu_read_lock_sched_held+0x60/0xd0
[  147.017361]  ? rcu_read_lock_bh_held+0xb0/0xb0
[  147.017367]  ? get_sigframe_size+0x20/0x20
[  147.017371]  ? do_futex+0x1a2/0x240
[  147.017375]  ? __ia32_sys_get_robust_list+0x240/0x240
[  147.017378]  ? __context_tracking_exit+0x91/0xa0
[  147.017385]  ? lock_downgrade+0x410/0x410
[  147.017390]  ? __x64_sys_futex+0x125/0x2b0
[  147.017393]  ? rcu_read_lock_held_common+0x1e/0x60
[  147.017399]  ? lockdep_hardirqs_on_prepare+0x13/0x230
[  147.017403]  ? exit_to_user_mode_prepare+0x151/0x240
[  147.017409]  exit_to_user_mode_prepare+0x16c/0x240
[  147.017415]  syscall_exit_to_user_mode+0x1e/0x70
[  147.017419]  do_syscall_64+0x50/0x90
[  147.017423]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  147.017427] RIP: 0033:0x7f780e668fbd
[  147.017431] Code: Unable to access opcode bytes at RIP 0x7f780e668f93.
[  147.017433] RSP: 002b:00007f780e55bd48 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000ca
[  147.017437] RAX: fffffffffffffe00 RBX: 00007f780e55c640 RCX: 00007f780e6=
68fbd
[  147.017440] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000055ed9f3=
a8088
[  147.017442] RBP: 00007f780e55bd60 R08: 0000000100000001 R09: 00000001000=
00001
[  147.017445] R10: 0000000000000000 R11: 0000000000000246 R12: fffffffffff=
ffeb0
[  147.017447] R13: 0000000000000000 R14: 00007ffe5dcf20a0 R15: 00007f780e5=
3c000
[  147.017455]  </TASK>
[  147.017458] irq event stamp: 0
[  147.017460] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  147.017463] hardirqs last disabled at (0): [<ffffffff896b5990>] copy_pro=
cess+0xe30/0x35f0
[  147.017467] softirqs last  enabled at (0): [<ffffffff896b5990>] copy_pro=
cess+0xe30/0x35f0
[  147.017470] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  147.017473] ---[ end trace 0000000000000000 ]---

Apply this patch , this problem not reproduce.

Thanks
Zqiang

>
>							Thanx, Paul
>
> > Tested on:
> >=20
> > commit:         6d0c8068 Add linux-next specific files for 20220610
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linu=
x-next.git next-20220610
> > console output:=20
> > https://syzkaller.appspot.com/x/log.txt?x=3D12d068eff00000
> > kernel config: =20
> > https://syzkaller.appspot.com/x/.config?x=3Da30d6e3e814e5931
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9bb26e7c5e8e4=
fa7e641
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D147f47c8=
080000
> >=20
> > Note: testing is done by a robot and is best-effort only.
>=20
> You can see the dashboard link above for testing details...
>=20
> --
> Kees Cook
