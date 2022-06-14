Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15FA54A307
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 02:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiFNACG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 20:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiFNACD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 20:02:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720E330F5B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655164922; x=1686700922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pFDaIdjulbgxbtIQiS1hKtUEbNaTJkHXkqDzFGPTru4=;
  b=cMgdosmCc2gUgL+hwWuAICI/LBj5lbm36Jq/m9ztrbI2LVikQw6f+YgD
   ST/e5gMFK6MEsejiVWVdLWAeVBlPiW6/IPIPDA2giGr90I3Vgfwy3RjIv
   2MgG4i7zLZS+sxFaXyre9c7DP3lnBEgDs3kNKfLxIb6XCsymSEx5B0XYd
   8PNoG3NYYnXiNVyVao4KMKSg+R/TpPPpsUQO1vA+vhoHuXq+344onloie
   wQrG4SIDXYVSAbsl94/YiS6ngv3cVzwnCLh4CpUzluWxBeE3haCodwD+R
   uQZrBiaESZnjv9pr4v5sFwJnmKgW0RCrCUgCYagrF2YR6PqEI9hMgt1+i
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="267140526"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="267140526"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 17:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="686339498"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2022 17:02:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 17:02:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 17:02:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 17:02:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 17:01:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOcWcLKcBNdq4h+XtwDA6ET1WzxQFlVvTIGmdIyaXP2dpKJXix2qMDYS1y2V1X7mlaTDSRPDNrUOEikJTBeZVgLmmBbUgEbvzIo3BilRcHQf2ZiqJyvq04sBa/wLrIgEJpKd2/qBva+S3c4dUzdLOre78s7A9ckfftLNfLzr01IP54n2xxSOyJbnv/CobUWFxRp47rmwlAoUVtZiXE6ywCc85ZDN/sIqU+mRti7J4/O57mkCsZMdWVuMW2sqm113SYGQt3L3csFrLLFRsBOJAGIaIFUvBoiLgPSIdQc0PnP3JdqLEI8E05JTWH46bF9oE9dr+Xg1QxaHRC39yff5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIOiQs7MeVvxAeghfJ/Gjj92dXtAOIeR0GGJkmRm4NU=;
 b=iO1h7HEZn5AG4oZG9qFbeKwpSeSI4/0Hn7SpKh1vN+qxJPRKlbpWgiDqCnr1cJNSoynLbC404pb+Bzh+AL8B78HKHD5RXUNaZoLyFavZ6qaNIKn22C4i9ZjSxFJx+IplA4Kf3KtEa+NyVLufCLENW1Ym8H8Qq4xN65KrBdZ/iILFJfO1pqAbqaAaRpJkX+jaNX73pPxLtVB63VjlO+J32T8WHrboJlcnucFqpVv9hHgkbETR4uu6iZ4hDlD0QlVBrUsSkKITs8xk+f3PyB3FuE47rEtH6Q+5MGutKCCJ6OwbSlF/T1CZ3ZtWxSnFERPM7rRgW0B6vrYDjDZs3o08XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM6PR11MB3418.namprd11.prod.outlook.com (2603:10b6:5:6e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Tue, 14 Jun
 2022 00:01:58 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 00:01:57 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] WARNING in exit_tasks_rcu_finish
Thread-Topic: [syzbot] WARNING in exit_tasks_rcu_finish
Thread-Index: AQHYfnKnPcEG5KPSqUKTUzyVmEvcrK1MN1mLgADFmMCAAHlEgIAAboyggAAbjYCAAALO4IAAAnpA
Date:   Tue, 14 Jun 2022 00:01:57 +0000
Message-ID: <PH0PR11MB588079E5ECB298E2C42C08D3DAAA9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <000000000000e2fc3f05e141f930@google.com>
 <87bkux1yn4.fsf@email.froward.int.ebiederm.org>
 <20220612202204.GX1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588027C1A486FCED7885C500DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220613152337.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880EB4D4F2B7D91C88BC852DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220613233753.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58806FA43338A28D72540CB9DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58806FA43338A28D72540CB9DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 50daa0d9-b694-46ce-f1a6-08da4d991979
x-ms-traffictypediagnostic: DM6PR11MB3418:EE_
x-microsoft-antispam-prvs: <DM6PR11MB34184982209AD8D8126E3C9CDAAA9@DM6PR11MB3418.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTGF01RUgIriFh0aysx2pT3arfyIFeo+41JDPfd1XdantcLgmT2RVVmcSr7Xyd/uLplXdSaJU49N7iuiTHg0NpJDWVBqFRA7CXI0DOy9xBGS5TsxceeZPX2epNgCZgGrEhS9MTEy2nmq31w/WdkYrWZ2qmOWW52uBxnXbtR6e814yrfTc0j61qrlMW4Nr7g0pjkEtDZSKl9mI67PR9ijMt3/ngsj248U8Dm1Okk435QAlC7wKsT0/WBekwDtfiuVO0O06SPaSyVe7GDiBjARA6BQtc4uEY6NgNhd8rbL4KWy29jPLL5D1TDUgNhbC9SNEyFbK/Y5kfRQ9rtSXWzS12yJwR3gSEernA+IYU11pjDon7zSxh6Mb540s2wkcPWhvoIgSNNYe/FHrztitMGFQlmcb3RCdIthibvab5NhTC+PDqObZlPappJTEa0ReroDJB14BnMFfDp+aU111Y06O5qb3Jr5bA/OniaKc61HzEm1rJWUJsLeL8n4LLGZydx2VCGZmr3eqzLrMU7JwKmTfYIFB+OavqhwuA/iz6WEC9PUdjCyNJa6JNWz185S7GNchxjbqm889oeYYMy748zj3vKaLNAJfp8NyruX8/vNcn8kC15gZgcz9lECEzykNhGTD/BXCckbMUTLin2h5+SotWwMvIemaT5TkVhLxgkhE1NijmymNF3U1zBvU3xIFISG9ChevCsgOI70oZeIO6gPgC3w7xIFUR5FsKG2I75/JM7gsqgfNWGDDGOBsih7QwY6REAZL8JJa2EqnDm5iiaQbUT3luQTpvDoHpVoYMviglPE4+sEVJW6DkSArjx32hIz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(5660300002)(66946007)(38070700005)(4326008)(8676002)(66446008)(86362001)(64756008)(8936002)(966005)(33656002)(52536014)(76116006)(66476007)(110136005)(66556008)(55016003)(508600001)(316002)(2906002)(71200400001)(9686003)(54906003)(7696005)(186003)(82960400001)(6506007)(83380400001)(38100700002)(122000001)(26005)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LUbD/GeIUjXTPOW4hVl5aTC0CzHxwJ7UUxEMJWNy6NnL1Pohp1jt1wZTXuas?=
 =?us-ascii?Q?/LCK4ikXP6h0DtKXabghU1YSIWJ+Boc8mhWQICs5IrYXcw2+8jiHGoYxgFoG?=
 =?us-ascii?Q?tAfJeBlPzpq8YjMswdbG01+cPu7kvZrygIG8bE390jzwoiufder8HB5l2fYf?=
 =?us-ascii?Q?/6jM4zzn/vOOiBIhWqZ2EDgreVHBVN2U6us7H/gCzgc3m6QQgMFTrduzEJmZ?=
 =?us-ascii?Q?EyYcjia3usYRncCn7Z3a9zjnXuoezW/tEvv6XczE96UDRVq4uMIkeXt5I4cp?=
 =?us-ascii?Q?JzrUjtM5jaY6lql9xRwDs6uAJ6QMZZcLKIOS4oIesRBK5GTjf7Crg3uFnNwb?=
 =?us-ascii?Q?UlzwHMsNWTV3/brsE3EBVDPyhoVITVFME1IfVnvchVXGGSj+n4Tp5AAHkRxU?=
 =?us-ascii?Q?FKLlBsBahQJiUa21g1tfEiGzpCQYSzXMsYhBD3g2APgMYN6ogBCz4M2HKVkl?=
 =?us-ascii?Q?XjOW6tEQvN+3mHkevNdulTysOAG/Cf8KSUVq+8088x5LEogUPyKH7q2wKQ7m?=
 =?us-ascii?Q?WMxmYuBq+HtMYdgob1//7nj5Gv9DvVpGci+64DuyCQeSYDwU94YHqaAPOD/I?=
 =?us-ascii?Q?jH7iIl/l5qaAmiHOneJRgMoVbe+IYLw3NRNiHYQdo/w5zBseWpDrV6za+Uj8?=
 =?us-ascii?Q?YpnNDo3+wtVUegEKlGDaWxSZNnk3Mx8mPO+dJzR7Dwy68vYyDvOoovrPFVdX?=
 =?us-ascii?Q?TE2xeJxSQVWynYVjhUgrPcCxK+KZj+b13GSJ7znGpf+jhSw+RkDx1US09OYc?=
 =?us-ascii?Q?kAadlyIaS+oCjmo8YMvTmRKKL3+NOfNiLLWRsDa0HUdWXw+RH7HW2O/rHfYs?=
 =?us-ascii?Q?opegJouhmq1k41D0cQC+lXLlPvG9Y2/pryp6mnDxtFUcOVUAxisgvp8NzKy6?=
 =?us-ascii?Q?3iHlpc2SgoGzoEAPWrusCeobGPdMXWSVFOsoLGsopTOO2EM+v6fqTVrSl1MP?=
 =?us-ascii?Q?QI6LS6ItBAfY82xOtmr/OwgeSLtK+T8MUvt85IrYib9D/hy2tsmUzDT8G0qc?=
 =?us-ascii?Q?i4zavfp/5b/vpbks1LqdLsqYYCt5Wlfqa5agM8mxUXaB/lQmzCGB1fe3gR14?=
 =?us-ascii?Q?/GiDi+FEtwFVgn35sNyX97WkiI5a/zt1gHfP5tpsdJqdRQF9xp6aSjuGxb+X?=
 =?us-ascii?Q?3q7HHpEegjfKlBi8B9pFHaz2Odnb07bgyFlSVuQb6EzsOLtBAeARsHtfJ/sy?=
 =?us-ascii?Q?yj9bpJ4x3ja78lhx29h8jzV0I/qGTrR4b4o3+VhubHdVzeoHPGomXZ/hI968?=
 =?us-ascii?Q?no3nwyCaBDPzQrNuFKxmqYh5YT8dAxrp8A7UfAOEQ6fmCd01nOfgcAuteNai?=
 =?us-ascii?Q?zfDkayQ26YGbvx9X9v9vdLdrAkW3B8BYupVFXfy18xxSdqLoTJJZ4T89DkR/?=
 =?us-ascii?Q?AcsOGmanja9troyc5hXsatl47hYHvfp2InjbtilyoCVvsvAg9RQiFnb76Lju?=
 =?us-ascii?Q?mXIfi25DUUKcnOo40jYeKsRwYQFIWQ0JWtPDqqJFGyk6UtlC12oQnJAMFGo3?=
 =?us-ascii?Q?lLTm9cTEn185aAlnqocN8y9Fp0pANJHWQHRSeo763W6Xn2Hjl+8XCAYTsJXK?=
 =?us-ascii?Q?uNhG1dmt6HPe3dnOn9LSXwydTrrmuE+EC3DjjPXQLiV00MYRC6MmcMNFBlpD?=
 =?us-ascii?Q?hOo40WH2iHlEPFeMjhpaNP7dH2UA56VMn9iaUQ20yy6kD8Ykgmsu3CKxQZQS?=
 =?us-ascii?Q?Js2MqCkHz4ojUUK1FXJxZmZKwfJulgEDY7SSof+KjRjUI5MucFndkqBxGbyU?=
 =?us-ascii?Q?8Vcca0SY6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50daa0d9-b694-46ce-f1a6-08da4d991979
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 00:01:57.8947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeOR8982/STbKMvPyKNvDGDg2aKivYtJum55O9vnalHHGJPbEzxyXnMiOHDcRfYZLlXDLpXUL6KTP/uO3U8wXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3418
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jun 13, 2022 at 10:26:47PM +0000, Zhang, Qiang1 wrote:
> On Mon, Jun 13, 2022 at 01:55:31PM +0000, Zhang, Qiang1 wrote:
> > > syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com> writes=
:
> > >=20
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    6d0c80680317 Add linux-next specific files for 2022=
0610
> > > > git tree:       linux-next
> > > > console output:=20
> > > > https://syzkaller.appspot.com/x/log.txt?x=3D13b52c2ff00000
> > > > kernel config: =20
> > > > https://syzkaller.appspot.com/x/.config?x=3Da30d6e3e814e5931
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9bb26e7c5=
e8e4fa7e641
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU =
Binutils for Debian) 2.35.2
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > >=20
> > > I don't understand what is going on in linux-next=20
> > > kernel/rcu/tasks.h looks different than in Linus's tree.  Paul=20
> > > does that mean you have some staged rcu changes?
> >=20
> > >Less than 100 RCU-related patches in -rcu, so not all that bad. =20
> > >;-)
> > >
> > >But yes, this could possibly be an issue in one of those patches.
> >=20
> > > Eric
> > >=20
> > >=20
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by:=20
> > > > syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664=20
> > > > exit_tasks_rcu_finish_trace kernel/rcu/tasks.h:1664 [inline]
> > > > WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664
> > > > exit_tasks_rcu_finish+0x122/0x1b0 kernel/rcu/tasks.h:1006
> >=20
> > >The usual way for this warning to trigger is for these a task to exit =
while in an RCU Tasks Trace read-side critical section:
> > >
> > >	rcu_read_lock_trace();
> > >	do_something_that_causes_task_exit();
> > >
> >=20
> > Hi Paul, wether the following scenarios be considered
> >=20
> > rcu_read_unlock_trace_special
> >    ->if (trs.b.blocked)
> >        ->raw_spin_lock_irqsave_rcu_node
> >        ->list_del_init(&t->trc_blkd_node)
> >        ->WRITE_ONCE(t->trc_reader_special.b.blocked, false)
> >        ->raw_spin_unlock_irqrestore_rcu_node
> >                      ->Inerrrupt
> >                             ->schedule
> >                                 ->rcu_note_context_switch
> >                                     ->rcu_tasks_trace_qs
> >                                          If (___rttq_nesting && !READ_O=
NCE((t)->trc_reader_special.b.blocked)=20
> >                                                         /*___rttq_nesti=
ng  =3D=3D1    &&  (t)->trc_reader_special.b.blocked =3Dfalse*/
> > 				rcu_tasks_trace_qs_blkd(t)    =20
> >    ->WRITE_ONCE(t->trc_reader_nesting, 0)
> >     .......
> >    -> exit_tasks_rcu_finish
> >=20
> > Whether the following patch can fix it, or what am I missing?
> > Any thoughts?
> >=20
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index
> > f1209ce621c5..c607e4c914d3 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1247,6 +1247,7 @@ void rcu_read_unlock_trace_special(struct task_st=
ruct *t)
> >         struct rcu_tasks_percpu *rtpcp;
> >         union rcu_special trs;
> >=20
> > +       WRITE_ONCE(t->trc_reader_nesting, 0);
> >         // Open-coded full-word version of rcu_ld_need_qs().
> >         smp_mb(); // Enforce full grace-period ordering.
> >         trs =3D smp_load_acquire(&t->trc_reader_special);
> > @@ -1267,7 +1268,6 @@ void rcu_read_unlock_trace_special(struct task_st=
ruct *t)
> >                 WRITE_ONCE(t->trc_reader_special.b.blocked, false);
> >                 raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> >         }
> > -       WRITE_ONCE(t->trc_reader_nesting, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
>=20
> >Thank you for looking into this!
> >
> >You do have what I believe to be the correct failure scenario, but the a=
bove fix would break nested RCU Tasks Trace read-side critical sections.
>=20
> Hi Paul
>=20
> Break nested RCU Tasks Trace read-side critical sections? =20
> Does it mean the following?
>=20
> rcu_read_unlock_trace
>     -> WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
>          /* t->trc_reader_special.s  =3D=3D 0*/
>     -> if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting)
>           -> Interrupt
>               -> schedule
>                  -> rcu_note_context_switch
>                      -> rcu_tasks_trace_qs
>                               /*___rttq_nesting  =3D=3D INT_MIN    &&  (t=
)->trc_reader_special.b.blocked =3D=3D false*/
>                           ->rcu_tasks_trace_qs_blkd(t)    =20
>              /*nesting =3D=3D 0*/
>          -> WRITE_ONCE(t->trc_reader_nesting, nesting);
>          -> return;

 Directly return.

>  .........
>  exit_tasks_rcu_finish
>      trigger Warnings
>=20

My change ignores this, so I described the above scenario, the rcu_read_unl=
ock_trace_special() is not be called.

Thanks
Zqiang

> Or where am I misunderstanding?

>I suspect that you do in fact understand it.  Let's walk through the failu=
re scenario again and see.
>
>If that READ_ONCE(t->trc_reader_special.s) return zero as you suggest,=20
>and then the interrupt and schedule happen as you suggest, then
>rcu_tasks_trace_qs_blkd() will see a non-zero ->trc_reader_nesting and=20
>a zero .b.blocked.  It queues the task, but rcu_read_unlock_trace()=20
>won't check again.  It will set ->trc_reader_nesting to zero and=20
>continue.  As you noted, if the task exits in that state, then
>exit_tasks_rcu_finish_trace() will trigger its WARN_ON_ONCE().

I understand the problem you describe, Just like the call flow I described =
above,
rcu_read_unlock_trace_special() may not be called.

Thanks
Zqiang
=20
>
>Your change won't affect this because rcu_read_unlock_trace_special() neve=
r gets called.
>
>Hence the approach in the patch below.
>
>Do you see any failure modes given the below patch?

> Thanks
> Zqiang
>=20
> >
> >But would you be willing to try out the patch shown below?
>=20
> I will try to test it.

>Thank you very much!
>
>						Thanx, Paul

> >---------------------------------------------------------------------
> >---
>=20
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h index=20
> 08059d8d4f5a7..937a58b3266bf 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -184,7 +184,7 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
>  		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
>  		    likely(!___rttq_nesting)) {					\
>  			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
> -		} else if (___rttq_nesting &&					\
> +		} else if (___rttq_nesting && ___rttq_nesting !=3D INT_MIN &&	\
>  			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
>  			rcu_tasks_trace_qs_blkd(t);				\
>  		}								\
> diff --git a/include/linux/rcupdate_trace.h=20
> b/include/linux/rcupdate_trace.h index 6f9c358173989..9bc8cbb33340b
> 100644
> --- a/include/linux/rcupdate_trace.h
> +++ b/include/linux/rcupdate_trace.h
> @@ -75,7 +75,7 @@ static inline void rcu_read_unlock_trace(void)
>  	nesting =3D READ_ONCE(t->trc_reader_nesting) - 1;
>  	barrier(); // Critical section before disabling.
>  	// Disable IPI-based setting of .need_qs.
> -	WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
> +	WRITE_ONCE(t->trc_reader_nesting, INT_MIN + nesting);
>  	if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
>  		WRITE_ONCE(t->trc_reader_nesting, nesting);
>  		return;  // We assume shallow reader nesting.
