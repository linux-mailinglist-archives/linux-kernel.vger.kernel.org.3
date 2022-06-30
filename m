Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A939C561522
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiF3Iah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiF3Iab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:30:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E16FDF3F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656577830; x=1688113830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k/m0qlpQSA7EtJAhwv2gKuVa+Em2xdOWFK0bFfxE89I=;
  b=BLs31ULnq1FFSGAwr40bM/NQpnWm67gBbDUVOBywQ30t58fOZ3U2bUut
   bYU1eMA1YFziRQxtIZ0HYtHYeUg0ESQN6Bzq6mx7NfoZ6bgiJFkauqs4R
   y89l7r4eSP0fR/k7bk64I9fJzSDjoWLgEX+PM3+QJ9SgkeKk/FrL87IkX
   +zLDFh11wy+Jp47IvD8x2rmfFU+IVBcAQpdcUyAW+p3AhgU9yzZDWp4XS
   J7GiUseVGMAbq5kvqFLPT5aqScRezKjC/isMelkW2OvKPGUDQQ78czIwe
   OL3vl4LDlHp2HP/eFv/mK9pkvB/5IRu0X60JMTZJVtvMFQBAre0pRGhLu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="279830479"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="279830479"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 01:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="837513399"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2022 01:30:29 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 01:30:29 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 01:30:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 01:30:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 01:30:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu9gwlvb0V2K1FtT2ARTm+GNJNOLl3cLwpWCAxkNhuawLQK+WvPAo2j5FgWKb797BCavyBEN1ypBll5cUy6J4+Pvd9z4T/Qu+xC5D5sKNpRXrHGxgVCeeL61HrYYTR7jv2a+VMWi4fCgu5WHANkmztNxMwZvW0qMU+D1K7O16Y8sMa1LTLSdlZr0UtqIVxLiSUYBOrGb2PPuwk22IZsunJWSJEz31cWr47KbiDn40ccYooFRdgre+Y5UZ+EZoH423KS9a9tAzbAGz8OT2ibYClpacf6llFj4eHmX7lI9XqJrXgZxxjos0cldZA4xSVj1vHTkaVUZmivvqZZOcJHyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/m0qlpQSA7EtJAhwv2gKuVa+Em2xdOWFK0bFfxE89I=;
 b=RWVPfZGhMHCqGyTq1rXiz4W/Cyd/Z3albAIG3pYJ0hCxA1SaBoUJTVbdb46MFcS5UapdrpsmjKx2gE02iQNjdmpwqqz7Lekcwx4rTGpI99uHA3DvKNApbTM6KseP8xpve1xB9sJViBjGgVcRpeVjKXbv5NeueF6j3khy2HqzdtzgWFBoGJo1V2be5DED+McXNB4yvpAwO3zNbPTbtWRUnUhgODy0IPNmF5bjeApVcpo7MCy2xd9ReA+yB+tkaz+howo9JZq3z9a5u8jQBlY+hu5roGQ7aiRPIjOunYpX8+DnCJik7Zp3Q+XBb6Z7O3ygfgJX0sC/usM5s/JQN1vJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB3413.namprd11.prod.outlook.com (2603:10b6:a03:8c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 30 Jun
 2022 08:30:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.025; Thu, 30 Jun 2022
 08:30:26 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Steve Wahl" <steve.wahl@hpe.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 6/6] iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024
Thread-Topic: [PATCH v1 6/6] iommu/vt-d: Make DMAR_UNITS_SUPPORTED default
 1024
Thread-Index: AQHYiJMMNAQZnXWkx0u5S/VtwZpE0K1npfbA
Date:   Thu, 30 Jun 2022 08:30:26 +0000
Message-ID: <BN9PR11MB52764D2F4A1C7E09A437F64A8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
 <20220625125204.2199437-7-baolu.lu@linux.intel.com>
In-Reply-To: <20220625125204.2199437-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15535718-7605-47a3-1bd6-08da5a72c85c
x-ms-traffictypediagnostic: BYAPR11MB3413:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A7cf10rvbp8pejVsjh3WSzmPii2/SOdhdma+DBq/ScmQLwrbpTo/4/zc+AL/Je8yae1488COkahnOxQJMUQE3hRIzBmmA94lXym9EAbopsJ1NAjSoPwaCGMPTnpSzy0JWt/gsgfrz9a++cBteUpaHwVu+ORjPVoGEiLlW4EDwfWcgpg6yykOXXmYTPhjJMB7/kaLt00Jn3TCrQ+vC9ki4f8YsylA7SSgWHJ7pArKaChrdjsbjCiPyoaF2n9BIrUBpRAZGAsfAIM70Jx7jbjCe5u9TIbEkLGmTTkrZHrXiWnVIAS7QnYVppmUDFe9DyNntxw6x2cI5IAP1GMuNmZE4jMgUUtiHb6Gat6ak32+hZPbyjq7b7FAUITJ/nDoouoOH5mrbQhohJNsgNSEP78dWWaNXF6vXRZKVG+bEuR8lli062CArHSM8/fKoA0khc5wNUW+0Cgts9TSItwy7GhvD4fe7vAQ18Lr48PoRBf3usXnk/ZyJylWW/Vdjfgcc2iqSnv0KMLOYJTbGPJ6bdXBjZu+SCmkx4Oc034ZWUwxfAfqCWDRXgUoQ+fTXMsCMKBO2p5sOs72h6VFq9aTMjYHSfZnVV0s5W+fMht+qipIGYJ9wZrkzrpDogid4XPiUR6bLVq6C7VmmrKmY4wRFiXcqLPTkjSxJ2h5W8x8Z/QLwRRo/eE0/kehmBBMRN8+3/kfH9ehjoTEaU1gX5rhvOgYhaMxR7ugbO1WwkCC4M9VVpEFV4ShtZedNY+VIP7yEkVg6Fz61/4c/iBUvd8qTrEXAp2FgY5Ti1Lnuu2yqQruh8REIjpvehZLcE4Sz3huMPwY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(396003)(136003)(366004)(7696005)(33656002)(7416002)(2906002)(5660300002)(4744005)(55016003)(52536014)(54906003)(38070700005)(186003)(64756008)(122000001)(66446008)(8676002)(66946007)(8936002)(26005)(66476007)(38100700002)(9686003)(76116006)(41300700001)(316002)(83380400001)(6506007)(86362001)(110136005)(71200400001)(4326008)(82960400001)(66556008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kKbSEVBN15qckesdFt8SMiglgNxCOgPTtocWJO8HD7M1ENdTQjusE7M2e0vr?=
 =?us-ascii?Q?siw5Uq6+yAv9yb0mLxjGERuUXvC83yI0IEH2TIJaRRmkcJDPlZiydlLN6dq7?=
 =?us-ascii?Q?wAHSCvwYqhdbAtAyBxgSYm6M3Qmm71NcVWG4mUawy7DS2KeE/Cfet5XDunXv?=
 =?us-ascii?Q?Ml5R2+u6Mtvwvvmeq6uq+SOQdSvnp8RWmXMs+VfRJvvgidDDCRAREAouKA4e?=
 =?us-ascii?Q?RMKSiXPpyZUzcAgXLbdm1AkMBocvKRDobA7fggtLYNv5b7Xp8IDiXUEjuTLd?=
 =?us-ascii?Q?Ldsa8dzF5AURY3Da+iKhA37ICgIJNWjjhi2mKxnJTBFGLypDXIiAW8mVGbsd?=
 =?us-ascii?Q?Li1dsYFUrFw6n1BlazSf6URfDI72fFY7/1yIw2OYMGrTt/BBvKJz85KsfAg7?=
 =?us-ascii?Q?o+Nc3Vqrk427+WSoq7us6mFxv1DlKSMRWR7/mbz4SNfmQ9fQ0/zUfO2hk3x0?=
 =?us-ascii?Q?LJZsDf6nrt3Cf4nboRpLsyAeG8rdsF1TkuyCiASJJH/SpIq7pgAY/bQHwMy6?=
 =?us-ascii?Q?aPBAIXimpGlyAzLa/8/GQKiBPyuifZ+Z6ovvtD+O8laHSJYNZ5ngCEu7osDh?=
 =?us-ascii?Q?jdXbODiyYCJcECh973n1zXVCaGr8HLRUVbmahtmN3I66cwclZjDH0Un/g57b?=
 =?us-ascii?Q?ZFIRVwhY42AhCv+VjHwaohVakY89qOcHJ/lGXYbx2O8Z520bnleccnZsRPWu?=
 =?us-ascii?Q?Ru2Is5YqJQJISk9WAvXXzxlV1k/k7kcyu7qK0kANDwSEX+vlXgBWCtw8QM5g?=
 =?us-ascii?Q?2UHGe8vbPSxQfWcTdjoejoZd2cLgByp4s+7WC20CWPpWkhIHvmJidOybCx9D?=
 =?us-ascii?Q?XEMIbNBSj0Bu8NkvM1WibJR+/6NxPGV1qUhJ9N43E97uvE2+slQ9TqoRmEcu?=
 =?us-ascii?Q?2NRInDaK6L2Kk8RdI/BFwW/LzUbuT/eSsVJ1xThEmjpS42gNqgH+radwk13Y?=
 =?us-ascii?Q?32rbgEm3j9N3BzxKG6nXQMi+WtowM7URE5HMWA/yQYOWY2zLYXPOHhY1tsu1?=
 =?us-ascii?Q?3+bNkCtAoDRVFfS+/ig0RKB/BBDSVDFs9W0yV92KzRzH6v4zGXWfHD3G79eY?=
 =?us-ascii?Q?OVuyDRPzuoXV0kf3tiGFUharQUGUt3f4xSNJjDdm1GfSxI6mYbFflvnU4njf?=
 =?us-ascii?Q?nqcRKevM7Ed7Gw+LM0WZPX7mUpYsjFLnue/FY2W7YCBUq+vHl7QLsPIkKiBe?=
 =?us-ascii?Q?0xRYrjKBZQvH41ucQ6Ad8jTQ7Bn+B7q+fgIDUwCYJnpDZM+lkp+8/T+erhk3?=
 =?us-ascii?Q?J/rvVYN4LFXHyhw3gH13Myr3SnhOcGSWNDWUlCFypstD+PsTA8fySd/ESMgH?=
 =?us-ascii?Q?QWMOaLKs3eQ6ItuiWPe6FFgzajs2FdhGTzlYabDEFyy96hDGOB7Na+e7+LOW?=
 =?us-ascii?Q?RMjmL+rSb1HliIDnGTeGLIba8boaEqjJetUPPX6M9OG+stqKC4+P0d+Ai5s+?=
 =?us-ascii?Q?vvCIewEqYgFIJ9km8s01Yek4ORGk5HKlBhKzGOMr+A3ueDtas1QMBc416E1C?=
 =?us-ascii?Q?iFUb9ndChSI7CIiBxcwR0L8aFCn76k3fdk5jhiAzrLTF2N0q1zbOjzsrlZlZ?=
 =?us-ascii?Q?fAoBpLmaQg608NHTHE0v5bLMLj9AzptMZVCCvoUP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15535718-7605-47a3-1bd6-08da5a72c85c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 08:30:26.0441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WaRtCdOX05bMJ9uvUlo2w9TIYlgrBURcyiaDq+vxikFuBQqWNPIJ5+RLfCHJI3t/5jGCW48gtrS/F5XihC4Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Saturday, June 25, 2022 8:52 PM
>=20
> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> fails to boot properly.
>=20
> To support up to 64 sockets with 10 DMAR units each (640), make the
> value of DMAR_UNITS_SUPPORTED default 1024.
>=20
> Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
