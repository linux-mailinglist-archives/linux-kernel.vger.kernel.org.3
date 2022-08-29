Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431335A53DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiH2SRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiH2SR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:17:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B489C534
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661797047; x=1693333047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Ual6T4f/VB6EPcoL1kvt07eseGMI8ryXQYC4vZBzDg=;
  b=AjtWitDvMjb9SRBSp7ES1Z60ctuW3epcZ/04Zdb+ttetyrVORSNHGZG3
   8l1KoQNza9i1eL4dslKmrfYr8tv9/YPyYdVuYoxmXnIlC2jVzpVVPp7Jj
   sTsa9QGW5U1okEf6Wi2925j2nEiZAVX4A1jcyA4mXTPX+CyUcZRwZuw/W
   1Qf266NCHj6QWKA+k5Cds81U1ADTpjuaq7W7iWgQAtERG05WPq/vH8uf/
   CqhfeluJAZmmLCUGEt7346F2p/lvdMXG/4G8UdeUkA9VUpb9st7sfqVEI
   joGJjf+xYrWcpsE9mSULcNdyXjiX0RqpzQCTi/Pi/mgtf8704HAluha7x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295745175"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="295745175"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 11:17:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="641032300"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2022 11:17:27 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 11:17:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 29 Aug 2022 11:17:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 29 Aug 2022 11:17:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGtxaWVbz7+0kRX/6k+UVnW+wwd79RuTUAszcMqE8/20A/U2RU+s20xGiu20YkMxX7ieHKK9pdFJK+kS6/x4slUt/jnoHnz0jg30l5vib1MvkH5PFBGWJKWOqsBWyUBWuOIyODosj8am0Zh720aNIsmevgZQY4qYJQWJDiBIbqyalSCsoaY0G0FbIuvakK5q5hZPQ248hP5ir3/sDrFZEpKuk6lIepOGGrOXrt1OLTOnje0jDOT427kUUOsUAFZo1hRv82JjIOwurnP8ydoIsAoF121j6ZVptQve/cr5Ov6Wce0PxYHtmqDSfYQJu/8FoXbo1alQlN2s9dHhk6OEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ual6T4f/VB6EPcoL1kvt07eseGMI8ryXQYC4vZBzDg=;
 b=CWyUZkuVCrM3BPh98vQ9Ne7FkYH6S+teLw05oxYO6zOjb4EZLKlgHm2j65LHJj2Qb1gv8WiVZOC7E3QLJWuIie+If790V1Wr/BB3mJEhKeDjASqiWyu3wwbwtxsG6S1p90hG/U4QEU8wuN8den6KGzcnpSIYmOo7z/kx+iFI+0JaNkTJVAG1WvvjsKJNEwYdxV14oMF69oN0GQo1HKpHQylBIqDL6ApaaMM+khAU33UYAW35hHAQLN7IChaanaPYvcmq4QDi+V+klfGvNaaPwbKUyMRDzWYDUS2PRhlD7aUCGHY0fKSy8YAfXPUahw7V3+ko1bFYRTzkYuhK8BlZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6438.namprd11.prod.outlook.com (2603:10b6:930:35::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 18:17:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8daf:550d:185b:6d5b]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8daf:550d:185b:6d5b%5]) with mapi id 15.20.5504.024; Mon, 29 Aug 2022
 18:17:19 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Lutomirski, Andy" <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: RE: [PATCH] x86/microcode: Print previous version of microcode after
 reload
Thread-Topic: [PATCH] x86/microcode: Print previous version of microcode after
 reload
Thread-Index: AQHYu9KnvdGmWAOcIkSIc0pXU/XlOq3GLuWQ
Date:   Mon, 29 Aug 2022 18:17:19 +0000
Message-ID: <SJ1PR11MB6083DD2543901900A37A716EFC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220829181030.722891-1-ashok.raj@intel.com>
In-Reply-To: <20220829181030.722891-1-ashok.raj@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1df69fbf-54f3-44f4-8cff-08da89eab5e6
x-ms-traffictypediagnostic: CY5PR11MB6438:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g085JBa9QTb3EOa66k6Hc1CY/jssxED6oXLA8YUN1SGPpwFUbwAx7ZWObVoGTGsm+1rkiMdcVAB4QjmQlJ2S3/STEu8BB4TKsvPg93wzbVCFPfMoNSilPLRMpFiaeBs/sXyWFPH3ifv7U9BVrI2F/ixh1NDn0919uxb4+wEYOnl8z63ikNpA8FdcxqAL+HBI8DcRpC4SHrQJlRijAAcyzFuMz33KWHBHOSXHmHmhG0HwrZSeM30+HZS9Z1C8BdmJ95EnqKEDo5WgZi3VT2OZlbBQ5r+eh4yOe5o7XJTZupk9YKdgDgjCrXdm3ULzjtT6gV5yM1XRkKj+S/ZqplhzNw2JnF1j6/fqZnjtDPTkFSKRXAV4kRrVqAVR/C5lGoT4hy1Ho+RNY2ZF4slimD8lptoJZ/dRZVOOisEaoQIhZbQuepBejFrYp9GkpQSBVyDW4zoArtWH1YwJItnFuhJxsf5ORNO7mDL0+fws5zx+DlvJ/UVBkoi6GktmpialVelHLkNNAzWENTbZVlMHNHiFXEDz4bWfCtequtBLOGJIbY4LPbv70Nn9fv33jASkswfxRV+GShY66Lmo91zxOyQGGFnzYRVi9NPKuYnKkWjkozvmw/ZnlKco1UDG0IfoJ6KcJFx1pTK5fSZgtrGkaZNR2HZA+hobSVw/dq0yOsnckmVLc4rs7qOqW0LaL0qfrRk3hLjwTr3PRb1TLQiWekn2LImLwisRpHCNMwXK57ZaYqt4ejzFgnPcEe5AadwnfrDr/aT6vZw24uGZBKAUnyz9hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(366004)(136003)(346002)(66946007)(478600001)(186003)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(5660300002)(558084003)(33656002)(71200400001)(55016003)(41300700001)(26005)(6506007)(7696005)(9686003)(82960400001)(38070700005)(86362001)(122000001)(316002)(54906003)(2906002)(8936002)(110136005)(76116006)(52536014)(83380400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HuRRzrHmRmutpJ09t0Wp+ASJ8U57ZrYFQQ9OjKHiQD7GhIgleJPTiGQnqEHr?=
 =?us-ascii?Q?Zvn6wyJqpQUik1EI68/umwJ76oeYoKVjfSU59nMOHiqnQRV+fn83HO8ljCn6?=
 =?us-ascii?Q?gVk5zE4BHyeTPsWIl2PQs85SpWUR0Zq8pjkesesbBp9d8a8hf2Qu4KMGXn8u?=
 =?us-ascii?Q?B/Nk1hgmRWVs4FN79hRwsqoTJXS9jtheAc7ue5ZjRlQ7UShtFzxsyUsmQwm3?=
 =?us-ascii?Q?I+QfXE7rANO2eW1iJLBMa0o5Fi4CadBGBpFYYP3L+Pi+VTW0rZP2z65lMaH3?=
 =?us-ascii?Q?FIOSxJ6dkjE7WowVmzUoL5MzBLl0T/XSXzW7pbp2ToAG3W+8fyeGiCoxDcAg?=
 =?us-ascii?Q?4e2AFO8aGmHC2QjNyJbs3agcoWrIAVOlTO5r/AvHUku0TE3hCAKZXUch7L05?=
 =?us-ascii?Q?FYjF+kKiTUt8WMUYj51+6ormQHvueDeIGYF1XHt7ssT6On17qprcK2H0BnNa?=
 =?us-ascii?Q?a7eF5W7FCk56B23KF1TcJnH94Qrk6+kfi6SXwS1pcew6hhWpk+rBqg0nmWFW?=
 =?us-ascii?Q?0zIw09MGnXRWQJrQf42RJzTKoSW4ZKDIXX8XUROmX98f8HmMsCEio9h6aCcE?=
 =?us-ascii?Q?YzxDEaEawdn6HCIlFpIEqXBxawNtF2r+uBO6U7m7oGREDamsGk4P2WKYd9ON?=
 =?us-ascii?Q?H2D2tDbKb+r/sA7M2jCUjt4Ky/u8GxuRy7I0WQDYkgLgvYb7ADfGA4mtj3/h?=
 =?us-ascii?Q?6NhySwrYwq0Nlvc7D1kL9QM8JUMGRFoamO9ebwi6w/hS3qLtsbdDAHrQmu9v?=
 =?us-ascii?Q?68yMT1yapkqfZd2XQRfGGh1j8+x8AdIF5AYYo1nlDE/sSrgLnYllovpHXG7F?=
 =?us-ascii?Q?Mzt860nIjyqe2xuCYeIAkh7d7RbcLXMSePNvjtH5Xa4rwQB9Uo8ks54Nh/6M?=
 =?us-ascii?Q?7Zo6Du5rXN7DF19HQ1GiJ4lgeqT1tq7We2mYltB6iLhkBgBthNsMiU9PqtmM?=
 =?us-ascii?Q?yQHfDLNiivERtFdIbavtiC4Zz3o24rJCAlMowd90tDuQ+4MVoMORsTxwyDC6?=
 =?us-ascii?Q?Z2t+InL8VWrMJ5zcQSBX3vovmaHtJ3x+EqmTAZyUzLVwqxxh/LdOICjiX5S/?=
 =?us-ascii?Q?w4JYo+9paS2QXV8J3XMOP8h52SEr85xClDID1nmD75t12a6GKdO+f9oxefEH?=
 =?us-ascii?Q?65QkbJuTme/q7Bd8W0vLlIVwrn27x5Wwh3uOvYt4P2VPwXUL7EfJbWjycxJ9?=
 =?us-ascii?Q?1nSc+qwqImpEyaoor/26UNjSDjRO60woj7D0gkkaYXvMOZ2YSfD9/FEb2VUq?=
 =?us-ascii?Q?BAWSsGTAIs9JKBIhf1Cyee+4CO0Foc6aTK0JYndfnZTwckxpJOiSr2AP154p?=
 =?us-ascii?Q?d4DeQxWbFLisn8uv1RcR1ZFxR4EhGy8pBL9wOGTg8YLbrPbavUaG5p6ddctH?=
 =?us-ascii?Q?f5DbupyOIr7tefMnQeS+UH50m4DtGi1zIICx0UKTbaub1LkGXT1HqgLgTe65?=
 =?us-ascii?Q?6XxdqrxbVWYw2MBWGqbkv5xnA6IByjIjo2u+4Q+ovG6jJOMzeEk4qMU+3dUn?=
 =?us-ascii?Q?6fNHiER4roVRwJc0Om0/pfsGKoP7gZOBSlsHKNxtFelm5wUeVD1A3erumIfh?=
 =?us-ascii?Q?oxKalYW1TkhsKhmxcf8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df69fbf-54f3-44f4-8cff-08da89eab5e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 18:17:19.3172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpV6Gd6GaIES9vz3DacATz0UZ3x4VI8KVNXpE1FVfhZBAl/81DeFmLCMnuQvYCPvQPURMvCdt+FUZLlGOFJJ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6438
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

> It will be useful to print both old and new versions of microcode after a
> reload is complete.

Yes, yes, yes! Many times I've had to dig deep to figure out what base micr=
ocode
was loaded by the BIOS because the early init update doesn't say what the o=
ld
version was.

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
