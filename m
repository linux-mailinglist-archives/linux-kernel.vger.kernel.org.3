Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83B7597F48
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbiHRHeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbiHRHem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:34:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2F5A260D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660808081; x=1692344081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rg0refetZpuEYy5TOsz28C5ea7QEIEqne6hpteSpya4=;
  b=izLnGCim6yxsFMI2ivrfNODzPw7sMqzsu1FgJqY7rvsn4ZqD+Qgf3LDG
   A7jEO8Nmq6jA+cD7O3/xe1m+JxzENRt1+f0RX3zIxcicffH1f4tRAhcQG
   QrWgOOraymt5vSyyAczEBKuTkzX5fRQ8i9DCqAwV4tlBtNY1+kzoFGZvF
   MTMmGeFhZJluVetZZVMRi+uhytsIfZruBI9qK54NAYWwaEro2PH0Mw+ws
   gNlp48el5AEnjEoIckjmbm+C6tDwMtAOncoyc4DDKjjgWrS0vWUPYeC6p
   tDbFJzgef3mfkN5gMWjS8soDSoxzNP1s1mURFW6xeNkB1/WoGMtRshH/o
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="275737971"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="275737971"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 00:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="640756854"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2022 00:34:40 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 00:34:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 00:34:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 00:34:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmwGFepcZHK1MpbCWZAP8T72MnTRBQQcQ3uGgb/nb6VhCJ5NAAceDQPdin7+nkA+2ZNObkFqgyPZafenCiXEPomeSb2MVvaQpAWrkcgla+jff9ynXuBHhAxy91WHxD7kHZCtbA/xNME3EGRrv5aBmR4uCYS+paSQdhio3L70cWdhhD2dhzRddsbBWzwlzh7hg1uWn1iJCCo4IufjF3gRm1RFX9GDkNdRlrW0YfA3MFXr8Z7699QallozAyXiLzMHNRIKkFrviWuBCGEZskyZxcYxI/6B8YWHLlYa3enBQ5PolUYA4ioOzDlHOeuy22Vj3woGS19K7DR5lxx0uMeB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg0refetZpuEYy5TOsz28C5ea7QEIEqne6hpteSpya4=;
 b=PZNkHBJ7UemUdIjshaoppI4sFSuLvO6BJmzNK15+729h8fbFXVuGr8ZnJeHqHEe1VdSTlqHtp0RwlWO0WfBijqkA60eH4l+oPyg8QYZD2rOiKTQ7kBMr0beS64UtN8/Zj2tFX+6jkId0rhlsvWiOyn/ZDSYdZcbiG+cWo2LJRstlbLmX8IPHxI+GJXHxUJquGrVCNijwsqofj+l+SdxUszIyc5JoYR8mN2K+pAU3gQCbGgNBm7J4hzW5983g8S0+Y4VEDXjH2/DfWGUSZcsj77cilDxiL/6NKZndDX8QSn/Y+6U9PqDesPe4bla+pJisG96Nto/Aayo6J76qcwgHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB3053.namprd11.prod.outlook.com (2603:10b6:805:d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 18 Aug
 2022 07:34:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::301a:151:bce8:29ac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::301a:151:bce8:29ac%3]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 07:34:38 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 04/16] iommu: Always register bus notifiers
Thread-Topic: [PATCH v4 04/16] iommu: Always register bus notifiers
Thread-Index: AQHYsML6vJVYGLCyFk+JRbQaB6SUFa20SDQQ
Date:   Thu, 18 Aug 2022 07:34:38 +0000
Message-ID: <BN9PR11MB527614514208CC25D5809FEA8C6D9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1660572783.git.robin.murphy@arm.com>
 <7462347bf938bd6eedb629a3a318434f6516e712.1660572783.git.robin.murphy@arm.com>
In-Reply-To: <7462347bf938bd6eedb629a3a318434f6516e712.1660572783.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e343a82-fc8f-46c0-aeaa-08da80ec1b83
x-ms-traffictypediagnostic: SN6PR11MB3053:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: drZZ/GyiqtHVGERjtDB2+DHLG9YNRJ4nw9gR20vRIwmkVIS6RklPoCoJZJ004aZeRTJHdZ3sfmTZQ7nyfWBW/8/eeh8vS3k4kFL4ob0+to6q51/+BmStOnVRkEw6IF6SyGDndSsHvFgaZCuAeOX2Pjqeq/laOuB0KFPaaCsikG/qdr0cUMelCBfqq7/Jrb2d9wIVlhz2jYQasgHjOV8jzuplrvwU8BVcycOAF7Eh2zyFBD9qk+S1uQOKPMD7+Kkg4/tDBJ5LHwx6Mv6+0sVzKK4D9xsYuZhj3EN/uUgYkJt9Qwjx4ssUL4bW6eyKVUoqsAs8JkEPRHvpmXB8tnRdtD1SVLEO+FjlKWIXX2q5p9lQIVXza83Irmi41a7gbXZa4ixXJV4bNk0vgCayzxq45gtaiMibLn93LykeYAe/J5dtJXKNxbIAiyB0+IuQqtDE+wr5XC6nGsBcNObi8wf51AJIIjLEMulsvL4A6bx7gdlZg0IB4b8ui8wzK8ZNBcZVfiwYTJnc2fdc7G5O376tWZkMyLLsnRVyLGvz5VlBcPBMxrvckV2iDSxOrSUvLuYyckky6eMNvcWiN4q0MJT5MitbOzOJr0ZR7DhvQ22AhzbSgbKXkGyJGj9qyZd78BaTS3+VHXzTWpUDS6Qm6OlcDLUou2RFz9dsaVvXJlp/gsJWcaxhoHJlSK0Ub8eqcS6qUM7y9dFNpvvHkwb2Hl37CmwRB58qiAgKkldWhphGDNFnlQ02wUGKDXAkbf8yh95le6tFM3y1VFkzJByYR1iGBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(396003)(376002)(39860400002)(7416002)(82960400001)(122000001)(38070700005)(38100700002)(4326008)(8676002)(64756008)(66556008)(76116006)(66446008)(66476007)(66946007)(110136005)(54906003)(52536014)(316002)(2906002)(8936002)(4744005)(86362001)(5660300002)(71200400001)(26005)(9686003)(6506007)(7696005)(186003)(41300700001)(55016003)(478600001)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vx1Sba//f/YfgfC5K5hlcHQmVvVXvOTn88Gk/GF1p4kCxXQtJOvMllGy+XCZ?=
 =?us-ascii?Q?JjCbdeia5qejoUm0WgzJMk2vhGYfG62Ux1E6+AGLCMt5uNjlxOiQDniO0ji5?=
 =?us-ascii?Q?mZo0sGe4t8aDTfQxPbcaK2d7F5pnNsAby97JkEpzizfDSwrcL/2F6Tgpva8R?=
 =?us-ascii?Q?/728rTNYJ7qCWDp8ZDdXgSdyRcyD3bGsTb30ugFJ+dqUSRRKTc6khS9Bet4i?=
 =?us-ascii?Q?ljw9Vj7ReE/n2r/nbneOC6MhMAmFWsmFXpMTtf2wxgryNF05GAasyrUi+Kku?=
 =?us-ascii?Q?om1u1zG0smJsfiEQDM/heDMlV5FUpwo5IAznvjDg9TygTeNR4e8ZlSvgYylj?=
 =?us-ascii?Q?ABknUUZC53CLUd6pA4kZq+HfWkyQt4u+e8vWrwOd7fWbCpsOInLiy2zzd9ug?=
 =?us-ascii?Q?oSRdHA9K9yrrLLFE8Ap5OrwRSAH6u8MipVEu/V74lfKeOnD0ckaPpZEvBatI?=
 =?us-ascii?Q?jMIDJWZyrMqW8kH91i7kGKeBES8YcJHIltilJs10auwgnShgx3l0z/m15eEu?=
 =?us-ascii?Q?djd901urjVqt9997OtE/CyDVdhzM0uQhqJYNf4KpezLtpYlf3FDeMSPeUCl9?=
 =?us-ascii?Q?UTmWbo9ZjW5iMBasaMK//9eptrTdMu+GR8nDQkVzrOPHSePO7DnOW1+Gx4Q1?=
 =?us-ascii?Q?KLERkfsL1EGw/DuypYerVztkWfJ82EdTVrkKyHcw+pSGC6/wPdWDQCVCPbp5?=
 =?us-ascii?Q?nTjT9KSwrFNOCW7GEahOJRMW94Q/0cuNj9OL6hFvvsQgZjGUGU9Z1McjWTT0?=
 =?us-ascii?Q?OcX6G+YT8/hwdvroHAzLGmWsywoM+0QKA/h+KokrRLFer/YMM5+n1+ru1Z3k?=
 =?us-ascii?Q?Tmpo/47VnU7ulkKzevA3JHRcb5cQjNKJeuPLcB24l0IKcxuaBKPZtqNXSpp2?=
 =?us-ascii?Q?VLXZ+qccTOgKVK47m3VQ1ejxnIbDhmU3rddV1fsegt/x4UkspzGVBRZak9EW?=
 =?us-ascii?Q?Bt/jiNlRoGwNC63b+oasU3esoj7oMmMlflii3WDLQBXNwQohyUKiStxDq0+x?=
 =?us-ascii?Q?6Poosr8/7R77TZUCGst6mM+rNPpiwZcI+3UgmbUzHmrN/FhWreIZLXpvgWRO?=
 =?us-ascii?Q?/g7IG1XJ3hmSN/RUEctrnnsoEtSSYq7BfKdB4KG1hATQFLST2Z/wnvCQbwHN?=
 =?us-ascii?Q?ARKQ72WrzfBWWUWIJtVK2ZwzAsrQN666UuAyP4T0XjNQ0v8hlIPu+s2/hZnv?=
 =?us-ascii?Q?DdpY2FBC8yQy7XPN+2jWy84P7EpUIiPdj4kqaO1OkG+NTdEtfCw73rtvniN5?=
 =?us-ascii?Q?b1s3w6jGAF3o8eQq3N7S9y/AbReVavcGtXz8WpnsvGUJaZFlUN2a8bzPOir9?=
 =?us-ascii?Q?vknnn8XvtEfeYf8Jcz3M3LyGt6LxG8ZC1sUyl42DGKPJYMDXs1V3bf3lOmeI?=
 =?us-ascii?Q?BSf5dpyzc7iv1GyWQEkkTC+/DVxgefkefNHaEQifYVN4DCelXIkKqV5vffv9?=
 =?us-ascii?Q?hABBdaw+ByC1DsQFxvx2YmrLkOVaJBanUfbT6+wPfmitMtHiIsKcwe4wJx0k?=
 =?us-ascii?Q?RfC82O95pLU661lVGofo1va9QM4cwU85MA61G17qgicSZBhJcYzeR8MqyjOv?=
 =?us-ascii?Q?llFq5fRXh+RHq0HQ6ZEz6RnVYQBLD8uysOY+ucoR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e343a82-fc8f-46c0-aeaa-08da80ec1b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 07:34:38.8443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uxsD7sLkstMK6BC9eAvWVLEcDd+6W1ktPjMXS5iBKVu1ZcX8tgZb8yTpG+Tr6H63gQqSiGq44PIueIlOhLgLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Tuesday, August 16, 2022 12:20 AM
>=20
> The number of bus types that the IOMMU subsystem deals with is small and
> manageable, so pull that list into core code as a first step towards
> cleaning up all the boilerplate bus-awareness from drivers. Calling
> iommu_probe_device() before bus->iommu_ops is set will simply return
> -ENODEV and not break the notifier call chain, so there should be no
> harm in proactively registering all our bus notifiers at init time.
>=20
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com> # s390
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
