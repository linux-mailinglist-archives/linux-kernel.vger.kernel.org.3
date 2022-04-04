Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B014F1411
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiDDLxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDDLxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:53:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9783B3D4A2;
        Mon,  4 Apr 2022 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649073077; x=1680609077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PR9PlxMIrBGV9Vu2Rsq3lHfMRE8ido4rhFbHWJ6l9R4=;
  b=dstUD9T0gxitjy3RS/7daIW42a0yEAV9sqsGVso3mRBcMKfUKtP4wp/3
   pPEtJCd+fwRTtuJ3Vz34XIM3ah4OY2TbJ8Q+CZG+LjIvBfpNB6/DEla84
   tMgzQKCOTe4RVFNsIt4UOgxjrqLmstumNJZz/zK/8G/CNCtzU3KJ9Ms1L
   j/IhO8YUx7iA8cB7pV3gK7P7Zw+n2DpmwQUC5RlgIY7tHNSEyj3FVWhSt
   7kDJpPn9G/vQnjW8H++fQ/r1ct+e1KfSfUiB2dKB7I5Yh0uRcFjQN+EcG
   tet9iI89GjJRezUU/yiFF2ExPA5Y65qL4UMD9bcorE0hjprmoIri0XyeV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="260193538"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="260193538"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 04:51:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="608012797"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 04 Apr 2022 04:51:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 4 Apr 2022 04:51:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 4 Apr 2022 04:51:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 4 Apr 2022 04:51:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 4 Apr 2022 04:51:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJUhpCTgUw28OUBNDkmlBvBM3nJ8cjbEEoSvDUoi+ndj5ak+7Gz7p9wRLDTm6Yd1OK89e/9hKSJXmddj1G5xOdmFyyAx6YUJgmy/mW0EUnWBeMQ2iUBUFPDIIwfsAEd2Tac5VUJdM9KUcf13y5B9ptwvu9p6WP5PQc103xgJI9RlZQNM0NFzkP6ZSHmZtWpc8J0UMdhhppPd5ozz8TcxiRl5l/JoDO6faz2BH7zyLxpYFOpr9KeOTxbph2s04YzfIAOAf5YqV6GVgAG6qXccE6YZ0R/Tm2j54IjbfWaNTq6P3yqN/W8kO/oXr8dr3QDthtSMO0PBlz68r95rlLP7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/CCJGTl6I64tc0Uv8JZL8Vq7hUGyiW0xtCODp+DZ5M=;
 b=T3QsbZYLLSX3dtNH8yrXNI60Hy9/H0cGOzO0KAcuXZg/K6sCWqfJY4qu9f/HUAnO/ur9h0/Tep/ltmBD5iAJmUYHqtOZrwvuclA/cG1Hy3xj64DNjSPvyQTjpjkLQUaiiuWhIjU+hKjMT8Z9enp0ucoFljXBbpgcw5/TYqAW87Fe8cqgIwTq5deUgJi297UkqZIDEqEiNIEpsjxhMKAmU/LQyYsQhj2h/+z/gMu/dNM3ys2BDsHOrsb9FDAlKlyrFg2yJE+rF9wObYa96KE+G9NX+MykexvbdcPN2rZ0TUIwTN05cULxG5vOIWFb4JNGCakrBq8c9BVe6V1HbVJmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18)
 by DM6PR11MB3641.namprd11.prod.outlook.com (2603:10b6:5:13b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 11:51:14 +0000
Received: from SJ0PR11MB5816.namprd11.prod.outlook.com
 ([fe80::542c:818b:3e2f:8b35]) by SJ0PR11MB5816.namprd11.prod.outlook.com
 ([fe80::542c:818b:3e2f:8b35%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 11:51:14 +0000
From:   "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
To:     "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>
Subject: RE: [PATCH v4 0/3] Add support for Intel Thunder Bay SPI controller
Thread-Topic: [PATCH v4 0/3] Add support for Intel Thunder Bay SPI controller
Thread-Index: AQHYMtgfKqORkW6Nkk+udkiP1wjhzKzfzh1w
Date:   Mon, 4 Apr 2022 11:51:14 +0000
Message-ID: <SJ0PR11MB581686619A1E792217F2D76E85E59@SJ0PR11MB5816.namprd11.prod.outlook.com>
References: <20220308103331.4116-1-nandhini.srikandan@intel.com>
In-Reply-To: <20220308103331.4116-1-nandhini.srikandan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38c3cba3-085e-4c34-b457-08da16316bc9
x-ms-traffictypediagnostic: DM6PR11MB3641:EE_
x-microsoft-antispam-prvs: <DM6PR11MB3641EF0F8125037C513E498285E59@DM6PR11MB3641.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gULtRCcHRG3C4b9HNEX+HVgEalnsDu5yeTgtkC7Spt6P0T+ABBGKkWmSc4xNpijuKfYj8bOuUG16ClDOKcheTMe+c8Gx0OBWVoFJsNe/tLgrwjmK+RVhAMvr3wUUIQf7/bEqen+e8qaKXZyj4XgIpmwuW4M8TRD1mDFKeRCm76qsFn4mj3+YbreqvQA1INEc8LEysqxvpK8rhpqIKgq/K8bsC5i8+hnlHkMqpNUXTQUu8ND/DkXQnnfdGEvcJXE+hL5a5z014FBkDgJTTwoDjKIubc8Z1gjIrxPTEddwe++5CEkfsW/h9XH2x96YbJWzSqatBqIgcMQ3qF6zX38mD8aYh4AaWcN1sxGLN8Ju5zttwMaNMF2rJTNtgcWlvenjhv6eFFuJIJIy7s58IKUgJFgkp3FuAKZmkFWzHrZ3I6+62I2yDdyN/6wpvyhaizryNPJECyf45VoZoVin2ZuxIjq+xhn4nY/q+2CJ48tNV3ZgqtZPC3TYWauR8o4Onzp3wLq6pjaf5M8AjxhJiy0/m8pQEmr/cM/pq0WHSZDOVoFZfjq3GzNe6K04sLzYFGpNVWJF6oQfcDcxPT1t9URt9/Lserop3WrnGTdiYw+BFVTzueryOIZ3hskDiJ5iMT4pMtULCk9vDX5k0qEKQs59wrhYBNFI9fMdzodr84SIhjIOOk6ZwvVV9INIgrhYaic0VNrdg022Q2QBBSO504TuFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5816.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(66556008)(4326008)(76116006)(64756008)(66946007)(8676002)(66476007)(66446008)(83380400001)(38070700005)(82960400001)(5660300002)(122000001)(2906002)(38100700002)(8936002)(52536014)(316002)(6506007)(186003)(26005)(7696005)(9686003)(55236004)(53546011)(110136005)(54906003)(508600001)(71200400001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8qjIF/kqy57ul/8KhWllRW2gyFRNC/vX4IeWXJktBj1vMMhqVmHLGFhaVNv1?=
 =?us-ascii?Q?fvq6yMNi1NLsXLQBI4abCFVUyiNHNLDwD4bN7vlnUdcuslCN+hyglqH59eC1?=
 =?us-ascii?Q?3YOzxN1ZpSSSVLFrG1iqsIUa4LlAWKp96oNvbL/ugwBJ1g/YVbGHSOBx/i1M?=
 =?us-ascii?Q?QJb6gGz44Z69XzxmnmwDCusxJ3leg76a4XQCI+LxojyylFaFCHdIsBjov2vG?=
 =?us-ascii?Q?7McL+IlGPwhPlPPX2uK1pXqRo4GT1wv58TW3xrI9EYeOLTDGkrhfzO5Sx73N?=
 =?us-ascii?Q?liUSq2QFBDcQ1o4mZIG+5eliGoDK0LrDbTmuDkNN5OcPdHt3fqYesSvVCDeQ?=
 =?us-ascii?Q?pqWbHdAr8HwBI01pykYMD340K6iDG/1DTe1Zcx0z89cZ2C5JDSFinbHqgnc6?=
 =?us-ascii?Q?uhROVdII+5/xGuWEx7a4/S+KKdxp2EHFoeSixbTq9hggQnn3pP1XuEfFYCas?=
 =?us-ascii?Q?CNCnPSTY/FtY78+1eQRshfCZEmegYab5kss7vIJKpSa7FwMjVZQs6EJm9rKJ?=
 =?us-ascii?Q?z//YJOe7b3vmFKOTScy03ILPfegF/b/Vhju1gmbxtQok2BP9D+sJPLFs3J9t?=
 =?us-ascii?Q?B9Ixp8e6CtDoAFkktMgirIrLS+T4cpStDAeZ4Peggit9nfrTIvAf9KvSOZ+Q?=
 =?us-ascii?Q?abr3ezP/3AQRq5zrEFKevmDEQqcOwHZedkhTFyX7/0zKZ28GgJOEhw5Yw2Fy?=
 =?us-ascii?Q?aQBsK0xhSgWK71rYIEGNa4MCpqOWHb+QU+5Tg4raxY907CYiTkTFZmysgYwt?=
 =?us-ascii?Q?MW+xSyDSAXL+9OOp1AEXgL8WdiwSJUTFPxf4kYLPSfw5zZK+rLQwDo9ucB0v?=
 =?us-ascii?Q?KoER4/8WEmyEOZDy0xN8gJqt+jCZCTvnhot6D9AenAiJZ0g7NymZAYf0LFDs?=
 =?us-ascii?Q?ayMYIoSOR6HgiUmuK5WSnc4fhPC+0cYdyTdkwlalE18vDtx9Tvmp4Xq29AyS?=
 =?us-ascii?Q?dpu/VMZagYCEBbF2qhjkeigSHgBrZ4tgvftFLQebGP0SqZNNUw8/8mBUIElz?=
 =?us-ascii?Q?DISk3ygXaZQ4ai5RWrEAalTRE18+BXqWAA48hxQdQCAkV+7GAeJXQxEYp5YD?=
 =?us-ascii?Q?SEz5wi27W3eZbun/8rGev7EwX39p6G2pWE+u3Sk56m8/YrIqw+2kl2yIbYiu?=
 =?us-ascii?Q?gmNt0KHYmP0VSSQudR95KowU20D9Na/OZYJEQaJSyI/QRRZJwS99VUocJfCK?=
 =?us-ascii?Q?LTb9WmMmZb+AAm74FvlIb5XzRWB0VhsF2LRgtk5N8Oxgu5a2IK7XzqxaCNEJ?=
 =?us-ascii?Q?WJRBsvEnBGuwcj0csQlYck7EFn7Jw4rFOpKBk4PlJWherArezuZetP3mgEZW?=
 =?us-ascii?Q?RhKEVvINyvqBxdlnDIqSFYZO4ORojdNf1nNZXrkAZssmnNf2fnFJYLDOne3s?=
 =?us-ascii?Q?C0N4z4n2wcnoD7yQUrgRa9PpmLc/8Y5/3XHwChaZzOvR0PzEMDU3F7/bOZNt?=
 =?us-ascii?Q?+Kvb0Nu1nut81umRNska/QCBwEY9Aod/Zq9rY5iTBsvudG6WXYJWWsjZv8Xg?=
 =?us-ascii?Q?aoDr1s4juUu64mMU0j8dQZEcpI6dlmonBOXWfnDHhR/3YLyqroDMWrdmj+eR?=
 =?us-ascii?Q?GXYZ98/XlQ1mLAJycFRKX4kVqmJh8NUtzaiG3RUDr4prEoO2v/4V9lH+3sKq?=
 =?us-ascii?Q?1LDlRVyPa5cTp3lm6uTi/x8Jyga7jABhPLwDRFP9lygeQELTdoZ1VqlVvSJa?=
 =?us-ascii?Q?BSvPOZKyjbvuLZrolu4q5irZtmobUeETDXcfdZPFAf5Jp0ttSxnMxArAAX03?=
 =?us-ascii?Q?SPAmJpCovKKM28CId1XFAgPr/nYTUdY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5816.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c3cba3-085e-4c34-b457-08da16316bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 11:51:14.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTUCKr59yHo8t2vjCFxmsF0Zoya7I5FE1Bh4PYV5UfedmY23gpO7pinZKQGigij1gQRfopznqOyw8mCvUAlOpZBkvEtgoovRY3hgNIpidrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3641
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Kindly help to review the patch set "Add support for Intel Thunder Bay SPI =
controller".

Regards,
Nandhini=20

> -----Original Message-----
> From: Srikandan, Nandhini <nandhini.srikandan@intel.com>
> Sent: Tuesday, March 8, 2022 4:03 PM
> To: fancer.lancer@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
> linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org; mgross@linux.intel.com; Pan, Kris
> <kris.pan@intel.com>; Demakkanavar, Kenchappa
> <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> <mahesh.r.vaidya@intel.com>; Srikandan, Nandhini
> <nandhini.srikandan@intel.com>; A, Rashmi <rashmi.a@intel.com>
> Subject: [PATCH v4 0/3] Add support for Intel Thunder Bay SPI controller
>=20
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
>=20
> Hi,
>=20
> This patch enables support for DW SPI on Intel Thunder Bay (patch 1,2).
> This patch set also enables master mode for latest Designware SPI version=
s
> (patch 3).
>=20
> Patch 1: DW SPI DT bindings for Intel Thunder Bay SoC.
> Patch 2: Adds support for Designware SPI on Intel Thunderbay SoC.
> Patch 3: Adds master mode support for Designware SPI controller.
>=20
> The driver is tested on Keem Bay and Thunder Bay evaluation board
>=20
> Summary:
> Changes from v3:
> 1) Dropped SSTE support in this patch.
> 2) Rebased to the latest code.
>=20
> Changes from v2:
> 1) SSTE support made using dt and created seperate patches.
> 2) SPI controller master mode selection made common to all DW SPI
> controllers.
> 3) Using a common init function for both keem bay and thunder bay.
>=20
> Changes from v1:
> 1) Designware CR0 specific macros are named in a generic way.
> 2) SPI CAP macros are named in generic way rather than naming project
> specific.
> 3) SPI KEEM BAY specific macros are replaced by generic macros.
> 4) Resued the existing SPI deassert API instead of adding another reset
>=20
>=20
> Changes in patches:
> Patch 1:
> Changes from v3/v2/v1:
> 1) No change in this patch
>=20
> Patch 2:
> Changes from v3:
> 1) No changes.
>=20
> Changes from v2:
> 1) Init function is made common for Keem Bay and Thunder Bay.
>=20
> Patch 3:
> Changes from v3:
> 1) Corrected dw_spi_ip_is macro with the missing underscore.
> 2) Setting CTRLR0 BIT31 without any condition check as in older version o=
f
>    DW SPI controller this bit is reserved.
>=20
> Changes from v2/v1:
> 1)Newly introduced in v3 to make master mode selection as seperate patch
>=20
> Thanks & Regards,
> Nandhini
>=20
>=20
> Nandhini Srikandan (3):
>   dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
>   spi: dw: Add support for Intel Thunder Bay SPI controller
>   spi: dw: Add support for master mode selection for DWC SSI controller
>=20
>  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml          | 2 ++
>  drivers/spi/spi-dw-core.c                                 | 4 ++--
>  drivers/spi/spi-dw-mmio.c                                 | 8 ++++----
>  drivers/spi/spi-dw.h                                      | 7 +++----
>  4 files changed, 11 insertions(+), 10 deletions(-)
>=20
> --
> 2.17.1

