Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE01B5887F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiHCH3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiHCH3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:29:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B841DA67;
        Wed,  3 Aug 2022 00:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659511784; x=1691047784;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=FxooDom5sh9XnXu+XNgCeHMXaCfoWGR2vlyvsAQyRsM=;
  b=VS5Nd2kL1TyjbKI/sxhAJfsshy5BgH0fDiuz/yZuJF8Hk7m0e0tQkjDv
   dt0AuiNPQaUFBeWC1jhozkvzO+kbkA02vdM9UzsDJX90hGlQ26A9fP8+D
   o7LqmNYetNYkLwOyDgMp8iuCMWUOUCDWzsQj1CciOPzjSrN4yH68eGB4E
   yUlnLoUe8sjOKm19gYAmvienvznacKy/0k1JdiB0AMVGfl9EExcCMtOVh
   ZidYeY5IdwHztOQ1KNs5P47CGu8UkoVXmST8uUmKjn3bhwQ7SfoTZcjTr
   lChLsWpOjN2P7mUuBUQdtrQLVWxAKRIysg//R5rkWvAPLi0puxPgLG/61
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290381831"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="290381831"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="729117640"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 03 Aug 2022 00:29:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 00:29:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 00:29:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 00:29:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYxE4+7DkCvQs9hgjVAT8d5ue9TKjq3J86/oeoGExnjp0CfIhpMvi6yj/QJKGJ7Kmmf2tcnJo8IpHbkM6H2XHmDpBWnH7mLaR59iVibRnJDCpEYjATkIbEs7yL0scDMUB4TJx9coieUY30qXQIJdBxbvaQY9PBHCAKTN6JL+qfsxv3AxOJrctavalbi6CfHkA4D/DnBXMEmqO4Fmb+RLncQo6hBwRhSi9E7yLVQopM49OhsJccpFLYVNxlCde7ifgjvdHDld6TfcoPD3sesHLuDI8Mk5ljA78iFBVdqvBBrQlcob15G02zLyr3Q3maCPZXiEGfz1lbNhfobt+YMMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxooDom5sh9XnXu+XNgCeHMXaCfoWGR2vlyvsAQyRsM=;
 b=HZXU56FTt1WGPYOYwPYZenw7DACILGo0KwTDanYNHN/uxQRX5/CiJwfluVvar5tPZ9HcP+u/BmIR8j9bDecADE8vMzlLLo+2aQPkZ0baYzYsjuDZniIlKWlHtrY26CDoqgxhiZ3B1IzG8pTRToBkX0AXFVz4zfFGUSzkL2UPzP8YR7TZIezxJ1htj9n2tPp7XG9Gxa6ZlXt2AZUnuz8D9DRjnb08kHnp6Cn2QWRi7nfl5I3mqSf4PTNXakpQNMrLzoaRnI7yixzdpAWzY2AjslNNih0kILMzPBJJLZ0bulfERggyvIZvBVazah6EsCko0CTtaAo1miPGv+lVI6X4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by MWHPR1101MB2366.namprd11.prod.outlook.com (2603:10b6:300:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Wed, 3 Aug
 2022 07:29:36 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d9d9:ed53:6b0a:e537]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d9d9:ed53:6b0a:e537%7]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 07:29:36 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Malani, Prashant" <pmalani@google.com>,
        "bleung@google.com" <bleung@google.com>
CC:     "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "Jamet, Michael" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: RE: [PATCH] thunderbolt: Supporting wake on DP hot events behind
 TBT/USB4 routers
Thread-Topic: [PATCH] thunderbolt: Supporting wake on DP hot events behind
 TBT/USB4 routers
Thread-Index: AdinCrp/wAKoliRWSz2ixLRb9JQnKw==
Date:   Wed, 3 Aug 2022 07:29:36 +0000
Message-ID: <CO1PR11MB48353AD9FD931B1D4AD5646F969C9@CO1PR11MB4835.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: pmalani@google.com,bleung@google.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 700aae25-a68e-4fc6-36ac-08da7521eb10
x-ms-traffictypediagnostic: MWHPR1101MB2366:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FaLJkZfi8Gfawml9P/E7+7cK3PE9ZOpKDGBtD0cmzNgLFq/UQDWuBo9sGWyQMZ34ys3mvD0w2WrqhCtO12Fkd/j5/iC58zTTp8gZpAgrKTRj5ewUQ10tzXBQ5gn5V7j2Zj08B7P/X5oBNjSerb7Kb40Z7rgdk7+SPn5Rk/qg0i4lDubMCUJ9GbYzxAirhpz4MqtxLzOSDqKOfj/7V48181YuoSLqOVKGkUXTjvfaV/dTuFoYHlsBopUbKe7l2AfjiUzFhESDRdpDD2iERwx1h/3GOiacJGjeMVEvS0OglPULvIk6BRBCejv7ij4mZlNAkAi7OVQycIJtS1MQnEmuihefyr03d+1do0FItelOqwZz55ZPvtte4uFfbLAZ0TbEGn3Ov2k6ZkajzNIGErg/Jpbku6JyyvSQ6RcB/S3E2/Ihq+q2+NcZEfi2Q2Nb+43QGq9eVuo36IRzryei1YcnZhD03H8BO6Rfcq+gEivCMdzfIvMEKugigeopHAjhJl2XVm7PQP5+5zJSnmwvAPuRzDCmvZBZMBsCXDO2x+vHQPyoXBTh/RGJJwjkuGGU6oWw06sKY7gLWuODw3njmWg1v+ihatdnXo7eSyXmw8+TxIHDnNhD+J5I/OR6jrISFLsfxRWTqOMm+0tDbvZLftu09W6lSWHyXiDkgFdSl1sJ3VCglN/HDEixLYcf2HIzU7ZON/fhQ4kKXyInIageUiYMqnrIZ5N1XvVmNyw7bfsNkSMcrf20TjFoTrr1Yo9uUGBJSE0cAuZHB6eJIOszjtJ/Hjgb1nAOMoScf6JdxTiH0JjAelJTcRIZAPjEggo7r4su
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(396003)(39860400002)(376002)(64756008)(8676002)(66476007)(66446008)(66556008)(4326008)(83380400001)(66946007)(186003)(8936002)(52536014)(5660300002)(33656002)(76116006)(2906002)(55016003)(478600001)(71200400001)(53546011)(7696005)(41300700001)(54906003)(26005)(9686003)(86362001)(110136005)(6506007)(82960400001)(38100700002)(122000001)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0hC74bW31jCGNUhV/F47kcmRNu5kQGHRxHLwpe/Pji9MUxgYehSZVOp9spZ9?=
 =?us-ascii?Q?Wrz/KrUNiE06bePz+wW9E+K4z8eIDejsKS2HG0I3TxTFM34x6YLh1mlilzZz?=
 =?us-ascii?Q?Pz1zmQWVchqeiBGhPj58OJH6wJnpr75O3i9YeZYHAY69a+4AkvYC64IkgsHD?=
 =?us-ascii?Q?i5vx/mRGJEHBBf28p3cblwnZRu7RyxrRCBbeNEK98E2n2ls7aHpMyjjvDrKS?=
 =?us-ascii?Q?8Eh7LkG6kMJYiPqNKxE5mNgT942HXC1o5YI/iNbgeljaU9Wdk/xXo/s7QD/b?=
 =?us-ascii?Q?o8qX9k7ZD5bKd5VVb/8/AsLbl3QZl2INEwPaP1TQ0X3lbH1NC9qrl+o84Hn0?=
 =?us-ascii?Q?MzZPKpCdh2r7sAFrwJd9Ry4r0dUbZEsYPJ5GmAdhXhPbkxmLrQZbhubY0ntV?=
 =?us-ascii?Q?H3PcMkA2+adb3tvMU2nsk4B+ZLmoRUWfpXf37eMl6btdTAHzplr3olvmjENY?=
 =?us-ascii?Q?JoUaUCnP9I0ObgIsElu6W2kyVqWpymoPm10cDRXyyIAiRJq4Cw0pmK+vZERU?=
 =?us-ascii?Q?Mu42YLLGiTc/ckDNHpEhPn/JSlwKHEsyNpNUkX2Ir/XNw4CwLXgfCH/2Gv//?=
 =?us-ascii?Q?RkW2MdFjoKz+KloOTxfCywLr0bSb1Cl76UgVWWaq1Hc4dcqnfPTxMHnJ4Hw9?=
 =?us-ascii?Q?pm7K0ycCi1jgoIBeD+kXraEUM2F89Hd9BurwAiKmN6efZ90RaZ3LH8eKsI++?=
 =?us-ascii?Q?qxrptRjWk+Bb62tmR/bkOwl6C+rGweiRr9BnSRxUFnbDEnZ8apgcZ5rkQP46?=
 =?us-ascii?Q?pgx/irtunYcftkjHCjferf5EfCve6+a7NOClm8aKyPcKwsMAx0ICkU7ftkc9?=
 =?us-ascii?Q?wEX1aySmTG5lYxgRymF4twwSPTx+TZvhQg3E8KsGN18ZVRP8yohzrfGYKK45?=
 =?us-ascii?Q?TOvyC7ZbuHmjM0Br31KzlIiH2HXMiP1yRE8D/eTPa+SCbxiFW4fCHVqfGb3f?=
 =?us-ascii?Q?m1E6+CQxg8Q7ezc0tyDJU18H8hor7fx1ZMvFEKQTXbVvVkPmuWfyZBAmUSz5?=
 =?us-ascii?Q?rj1YrIpHhKfJacZcTgCZAgbWYbNUK9N+Xnuhi5oY4qYCgtBa8xvw3xgrurDJ?=
 =?us-ascii?Q?Rq+htuH+v4BfDQpU6kAuekT5jd3+4oBWSFNq7LX0e3x82hbP7Kd3ul6Y0Lq1?=
 =?us-ascii?Q?dUEll39VD+zqqzsIlXDzfTsq4C85WKVSFoK4UZ+TMvgYVU33/B5OAJAoJ9Nd?=
 =?us-ascii?Q?76BjD7TjWSuegWab16Jz1QTXgYupvtWUbuVJNSKrrGxtZMuOGE8DjqDyY6J7?=
 =?us-ascii?Q?OkzvGku0PP4BARTDbFve6HFobJ52ne4V5dCTN+r4dlEb6sK4EbfCN/yYehUu?=
 =?us-ascii?Q?Mo/c6d1ySfTF57P4baSYL3rZKqpWbundXX6/80vpflOFIP7EpnDRdhvDMIhR?=
 =?us-ascii?Q?3C5uM73YcahgkazKy83JVVBynlQ1xPsVgA1SZ8jErZsIOMLHK9lprN1C73B5?=
 =?us-ascii?Q?B30Rwu8Xiu5nhLZ2OkxSEa5ErL//pI6WxP5XymBxsUz/iiWDMvhyzM7OI50x?=
 =?us-ascii?Q?Yd3LNK82ImX0IHj5QAgX2j0qfw75esnTwmZKvNEsy+eKqku6r3McISmZjCE7?=
 =?us-ascii?Q?RCwUMpq61isoRQ6oGTQdKzmsOKibysEjAgRMwGT3Wn9xOsNAvkQr17IBvOhX?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700aae25-a68e-4fc6-36ac-08da7521eb10
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 07:29:36.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLJeWedVaWjYOq/GVZqkEcXCd8nLXJZoQeL/ohs0xYeXBvhd52VJVeBrhNK5LN50jnfDaAUXRn4Ch8hwfaG1zz4llBCwKY+7c35bdh1FoOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2366
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Abhijeet
@Benson Leung @Malani, Prashant Please provide your comments.=20

-----Original Message-----
From: Mika Westerberg <mika.westerberg@linux.intel.com>=20
Sent: Wednesday, August 3, 2022 11:07 AM
To: Khandelwal, Rajat <rajat.khandelwal@intel.com>
Cc: andreas.noever@gmail.com; Jamet, Michael <michael.jamet@intel.com>; Yeh=
ezkelShB@gmail.com; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org=
; Malani, Prashant <pmalani@google.com>; bleung@google.com
Subject: Re: [PATCH] thunderbolt: Supporting wake on DP hot events behind T=
BT/USB4 routers

Hi,

On Wed, Aug 03, 2022 at 06:31:39AM +0530, Rajat Khandelwal wrote:
> Current implementation doesn't allow user to go into system suspend
> and simultaneously project the screen on an external display connected
> to a TBT/USB4 device. This patch enables this feature.
>=20
> Let me know what you think about this.

Please prefix patches to follow the sybsystem style. For Thunderbolt it
should be "thunderbolt: ....".

This will cause any monitor plug to wake up the system and I'm not sure
we want that, at least to be default behaviour. If you have a regular
Type-C (non-USB4/TBT) dock and you plug in a monitor to that, does it
wake up?

IIRC I already suggested you to do this for the USB4 ports themselves
(struct usb4_port) so that userspace can make them wake up the system on
any event by writing "enabled > .../wakeup" which is the normal way.
