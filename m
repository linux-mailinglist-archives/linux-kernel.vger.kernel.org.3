Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96337569710
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiGGAx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGGAx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:53:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D2F2CDD2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 17:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657155235; x=1688691235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cT+kO8u1nsy17EsTDrfucG0qQdcDUIMpKP6JjzuANXk=;
  b=mUK9zER0AMZQTIDYhjqAfVbsZrV6M2eHX1Om59mP52PLkYZSowhRe58k
   r/g7A/GzYhxuzr+IVo1a1Zd8edH5vUt4qeezsp/xzz6sctmfDSH2r107M
   UT9QQeyVNWQV/G2oZ2oOxVaJg5nDkmGVLO07B4iBdQ0YtCbNMCEyY/x/N
   lyH0oCWIsGLZCMohnyNx3QsUnPJQb2vszzq2EpAewuEv4UxjPkbS1u81t
   qrmQR7UaP4YlXW/+hhmoBozD5Wost6j3USRRorSheEpMqLJMf3Y2yH+QU
   K8+l/3n6zyebMtEPFhAK4w0+WamsUM4A///pRS67ysKeCamxPg4sDrUNS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="272692920"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="272692920"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 17:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="770236383"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2022 17:53:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 17:53:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 17:53:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 17:53:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+IAwMfAzm1MzYHxG9P3cIqPrSycePrvIAOwtodwoEyz/fKN2Lz3sw/CKobRU6q8AzpzgMnBE+McF37BBaBXL2WyCaQY9qR+wA2gCUjrcRITdTeB4nOE6WpwmoP/kdpNNTRSCUToVgCdjL8Jr+36TAJ3KYvHXOxUyXQIuh1bquskGaTjiwdKdqNm1T7eP1VSCro0BdnIuf32BEQKVhq3Sucw9YpGopUCLSWJ+7q0uP5Vva7mpbBKYHeHv1EIrFdUchMrHdFDzDpuufXdU05kBekLA+/VglshrCKjK3uUfhJfejOm4CsURXnmTGU+gjvoxb4cuR+MtyAdvcAN9aZSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cT+kO8u1nsy17EsTDrfucG0qQdcDUIMpKP6JjzuANXk=;
 b=G1Ai6PMHr/OXcXBtxjm2zI3Js7Wx0lUhJiOQ/Qa5JPWNAoCvx0Ee3I61jjad/EshUPg+2JdkIB1IG/JlnPTFRpaygyGcimuEC0UGk5fIdSu683a+mp51EiPe/+mpnR8nixgltO8Nh1J+/rmBEPydz7g+Zkoe5Lm0b8VM+h9go7AKq9+3uIWI6FaJ5R+q5tz2o2YxkVySvhyF0JPIxCH2Xwv/N+iOZ/u9j6i91bIs9JraA19JFzY4oPwQeW69ha+cby3cgbwa/rNd3/ex6nGH9AwffNDu1ipHTzkgYMtCDyMk84cB12tYUPCzCg8AMqQ/IB144G0YhUt1ccVPOLwo2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM8PR11MB5672.namprd11.prod.outlook.com (2603:10b6:8:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 00:53:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 00:53:24 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/6] iommu/vt-d: Use IDA interface to manage iommu
 sequence id
Thread-Topic: [PATCH v2 2/6] iommu/vt-d: Use IDA interface to manage iommu
 sequence id
Thread-Index: AQHYjbeOXjmNgujITECfoHlwIAha8q1yHF7Q
Date:   Thu, 7 Jul 2022 00:53:23 +0000
Message-ID: <BN9PR11MB5276C8780FDC02F53E20F51A8C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
 <20220702015610.2849494-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220702015610.2849494-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ce9354a-7ba5-4e7b-4417-08da5fb3186d
x-ms-traffictypediagnostic: DM8PR11MB5672:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sI3eL9/fztlfjqWXUSw1FmJbOuzSMX6EIDx/RTA/td3fgWzgJuLEabxtDYmuQRGGREG2m7Ggas/bFz9P3HPxGVvmZYHLoFyEsGlZJ/CfdVRlQV6ENf8l7B+cLzWfCL6Rzj4phodTWgkPNR/PINbRkTBscBoVddU7i4W5Mcc8qiSjT5kTe6hhgwQMO4Lktw1+2W6a/wugkxpRR0br8/z348Q2L49eeA1KaTIDTEYuEwmMLI7N1d14t7cFiUbKtWMVERzOPs5zfA9OSqEYDhhXvNlS2t7Zs/5fgOpSWJhdBNMRdnSqHauKhss+xkeZvz8VK9pi50RrJN1fqqGzOiBqvT3hgOqFq/hX59WBJcZSgNg+afrbfTlZz8TGrC422QRxUEDiylErz79ws+MqJ8TwE5Bk50Cc9NLvE26Otsf7gncwsZK5U3rgMld+M0yDpVK/sbpSnU4zJ8Y1CbDa23y81Kn7KlqAloGUQIQKTQCUUyHvqkyMqMFU4sfNvRxdxy3ON7FNiw4Nr7go2ORgsmWt2A4mdCj25epo0niQf9NlWJuJ+zWNyJltd+pwlEJhS4HocjwbaNFxzFwBE0lDN1vbwrpcAH88kTl5RrRWriUTTYa1DH21oj5G7zCktEOMqrgELcZTVBT4vM7zM5NrHZIYZM1KqYzwn8zjJwhTVRn7zCBwq44WylxzochAuhh1bh14Qy7x/G67bXVxGVX5HtJ+C3utWNmgUUqDRNz2TlEc1rZ904fO+u3UxamgNyS4ZJBL+3jsYf39EYpjuHd4ZpUKu93yVCkMGXpZjDgCJp4Q1f3ERw/wg+LWP6L+PNzv70Kx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(396003)(366004)(39860400002)(38070700005)(478600001)(41300700001)(66476007)(66556008)(8936002)(9686003)(4326008)(66446008)(64756008)(6506007)(26005)(7696005)(66946007)(76116006)(186003)(8676002)(558084003)(122000001)(7416002)(5660300002)(86362001)(33656002)(110136005)(54906003)(316002)(82960400001)(52536014)(71200400001)(55016003)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HrgGEUTv3MgcFiL4satn/eT6S9X79qdrMIKHHAxBf1v+ZxJquD9PDWuL4Zc2?=
 =?us-ascii?Q?tCZ/fHmAe6h5/VzJOUmYiIEeVJ899RPDMRcMJ6sxLhIIhHRei16GPtHwc3hC?=
 =?us-ascii?Q?2ERa04/l8vhBVzpDWtQOE9f+9opl72C7wG2IklhDitZN+wWktqXb3PSgkrUz?=
 =?us-ascii?Q?6naN8wGlBmA8IVkOLD/nz2XqjeJ+oYhBRCw+HfFHFVe1bWJ8hKBZFhSVJ0do?=
 =?us-ascii?Q?UU11oJtf9HPYF+tHIGacbMhKA1FA1ouffZFfz0ofiZDxgV6RWaeoQrj4sAqS?=
 =?us-ascii?Q?gQ1Ml5ZSe0PtzW8y3DjaHrCxAiDxPmjHKhzlL3sI2v3r93LOY/6V1GYVtv60?=
 =?us-ascii?Q?nDGBBV12RJz6wdzdzVXE71J49VHTw4riFfK5PmwnHPDvW33cSyIYK3Mnwivl?=
 =?us-ascii?Q?W7LFSqv3a1bTegsCkBYH378edpjIj3yAb+doFNwo1RgsqwVAa1NhMvCTiy60?=
 =?us-ascii?Q?lQZ9PhDm4cIb/TaDjDmYacbRKWW0ekLf76mZhwSC6hlEyzdHLyjxNVdVIs/z?=
 =?us-ascii?Q?Ab3OMxhEBGSVn3yaAApZfKwr6A+li3XXkwKVhcyc4YNrFQ3Ix8VztkAE/pIO?=
 =?us-ascii?Q?teQlyy9arDZ796iPFRk0+psPxa/ZAiPHUhuOnAOuKhodB1PcPke0rQfvjDm1?=
 =?us-ascii?Q?O+10GtlXDGKeVmeh9JVH4sDc4+XKY0fDgI5km1MewBJIbgyeHas8EzPu6iub?=
 =?us-ascii?Q?ubbDy5ogpdkyExLiZ2eFGpY58yqq4izSysGQvFqyNjrZ6/n49NcUj2slbAfK?=
 =?us-ascii?Q?Tc9nAOEFvmZNEbkRHscOcBXmtQtyu84PgKSvOljTfU720feM0ilPUBPcRt9Y?=
 =?us-ascii?Q?F/8bhYZSTKQLRl6OckYxjmxT/6Ew1t1Oq118jNKaRL0+FmoLt1KntrqdvHBj?=
 =?us-ascii?Q?NarxmX5YfvEsVRb90iBY4fhvxA9Oi+EPzzg36flzgMDSjNglnWPaEgLXr079?=
 =?us-ascii?Q?oCjyxMMQQ3Jbxf+yRH68uoMCHH1gl8JF2+O3jtdyxe4CuEObN2+/1hKLDAKb?=
 =?us-ascii?Q?473GrO2u+GufrHBxb3t73DzftwELkRlR9MSUOMSmMkSUnHGw2hzOMgV9VuOZ?=
 =?us-ascii?Q?+7AQctXjcSQkF6OIzR5rRjWzkwKbCBBIwgU6TZXgFtnoZL0X4XB/RKvSZC+U?=
 =?us-ascii?Q?JRWju7Maf0ivtWk82V7wFoTgysFdnifQM9Dp1ZfrUPK6QWp/sqWarlgkc2JB?=
 =?us-ascii?Q?/SSnBjKIIDXclZ3qIxkjcEfC2fo5WrYjto8xglrhgQKv8Y7mnrxYQPjGlHVn?=
 =?us-ascii?Q?tvi2+OsZv+ra+zpTEGNjJ5QkK4581zK6kjxUhLslNoOTYvWMOo+/irH530bE?=
 =?us-ascii?Q?zYTVE7bxB2akdyptTumRj/AlhjH/H7uL2Kph/+ay4FikxyivNKPH3cramYac?=
 =?us-ascii?Q?BbZmdTVzF8gl+vVajlHO3m1Ftufqj//ezA+ck8qYN7Iw0NTRpDQ/itrTDbOr?=
 =?us-ascii?Q?/9hPPN2Nbzil0dLq+kf690AEDN05BwVY1ybhO7q01lsT5vVsth/omaT207kh?=
 =?us-ascii?Q?9Lsdj1I2cgMx9CSyrN8Q8+aZ3GNLps0cB6HcqGXjFobyQTELoTYudUqGDDmn?=
 =?us-ascii?Q?l2lMra0LKqPhKQbrASbQoK2Vu8JXvj9WSgxfsNcM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce9354a-7ba5-4e7b-4417-08da5fb3186d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 00:53:23.9476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDJv4polAOLInu26VT2zHgQZ7JvBZFbFjim1kpWxox7XsccROsx2MUd96nIYhSe/gip+Yi12FbA+yosCCs654A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5672
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Saturday, July 2, 2022 9:56 AM
>=20
> Switch dmar unit sequence id allocation and release from bitmap to IDA
> interface.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
