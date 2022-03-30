Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7554EB9D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbiC3FFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiC3FFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:05:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF6856C2E;
        Tue, 29 Mar 2022 22:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648616645; x=1680152645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rG+eVeojlMtCVeV28H/KcdxcNxpO6CTI7mP1qsqgZx0=;
  b=Ct/ktaZmFqSMMvhnNEJIhHbz7PxXuvLkTL9eaMrmg+x/xVA4LWWU9mcR
   +a/QFoS99e34Skw8ZHvB7thDh9kWxUS69s3iWfliva+7tfScSaH8+j9vK
   tIJ5p+THA28MZC1lg1Z83ffloHgI0XSiUERbzTZLDRGeR/8g+SllSUyRj
   DHBQsQpO37WkDICjpt66eqsAsUDWGk/GifaWY35DqzM7NTgGgkY/OLsmg
   9Gih7d6kMoOvpre5gfh6nsRJtug/mqO/xHGystYGXcFFSNTBEVCmKi9fD
   9NSnSWcIzgGwalZ7sUi7GIJGlDMIYdx3NjBCMk91RUU+dtJUi2R2TIXJ1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="241603573"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="241603573"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 22:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="521746192"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 29 Mar 2022 22:04:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 22:04:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 22:04:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 29 Mar 2022 22:04:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 29 Mar 2022 22:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfO6GF4T6skqgdARgeCQrOVlIiczhsVYPQKA5uvvhnL5hEBTxTKJbM/Z14hCEgPHyMvVCrJYGc/GUeBva2BLYfw9ifGVu/lPt5csLjT631dN/NLTOItXR2WVA8whW8hYyI5KXfBTMM6f3a7XeHYakrCKeHOaaWlaHA/4vgTc5Mwd3lZ69dGJYaB1ZpJWhA0tM7K9dlCUoKXWoCVgynMoq6t8S78uhmGRGIM6yBSOz73tcBUc/eba8QHtpJzBc/O5cxRkmOzkMbWdjeD6kx+GFk5l3TPW+TdqavguVFCswv2SmXQprWxGf57SneLtldb4RBpXiLj0QQ501pOL0QAWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EB9HTs9I5Ib9Imdm8IuhjQee+gXPRVnSq8Df3KLMV3k=;
 b=SLr8kYVZ5dGaqVkzeh1wqi85/3lJW6qOaxPBqzosQIMpwRnRGueh7k4870UVpqVtOMcbCjUc7DhWG6L27jAYCcy050EbxItyVkgN+gOUolFASHkF99+EITTz9RWPUw8eHbDJ/boaVLfSksIabV6WnItmrq/Tz/KjW2Oy1wgQCx2Z/8G+n/fFeKuogiPec9yEEfCNtE4kC3lEsYNIDpIFT/edAwPdFNFvAzm1CTlBdYV0MB45tL1gRo5JD46LE07q1Dmk4uHaHazYjf4NsYv2nwNAeNg3bup/tIrSw4cEtCgseiZ8Qd+bhizpM6tHICanTpiep5vMUd4ueKFNF7TWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19)
 by MW3PR11MB4764.namprd11.prod.outlook.com (2603:10b6:303:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 05:04:01 +0000
Received: from BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::8548:a26:d677:6e0e]) by BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::8548:a26:d677:6e0e%9]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 05:04:01 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v10 0/2] Add the driver for Intel Keem Bay SoC timer block
Thread-Topic: [PATCH v10 0/2] Add the driver for Intel Keem Bay SoC timer
 block
Thread-Index: AQHYPezSIO7t9zFH8Ui3vYd0dO8YIqzXazWw
Date:   Wed, 30 Mar 2022 05:04:01 +0000
Message-ID: <BN9PR11MB55459A4EA8D0599DCB753173F11F9@BN9PR11MB5545.namprd11.prod.outlook.com>
References: <20220322130005.16045-1-shruthi.sanil@intel.com>
In-Reply-To: <20220322130005.16045-1-shruthi.sanil@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21b54c8f-ffdd-4d03-5b20-08da120ab472
x-ms-traffictypediagnostic: MW3PR11MB4764:EE_
x-microsoft-antispam-prvs: <MW3PR11MB4764DE1BDC99AC3CD2A2ADBCF11F9@MW3PR11MB4764.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrBCbb3dgQkhLz3EObPRbXMC4RSB10mlNQdZXw2UQB56b86O2P1HctNi/Ry/nZ8YcPtzEQjsC6dwhkZ5/l1vC4sQskxUexTuR4kaZcgO0FygzWq2LPCPaChYmzM3eEvxpTGWDENO6VKNarUSBFxoZ6qN+8OBqUqlBkoRSO4FzafBhhRPbb85eN0C2a/vcT34aU/VlFwhk7Qf7iMUjtNRrPMru14blSzuzj5yXD2tLzm3ukJwcazh6wnciujCxo5FyDvs2747KJ7mlBDp4eb7QnNOY5JaWyWPpSujby5h9jLsqTxu8eK1Fd/Cm1pgGjY2e3tKrO4ip9SuTMg+wB077hZtD4bVt0nEEVY+1QU689Ezsb4godnn1NJCLMhj0ZmR8h00G5f3Dd8oYfyDlvXaUrqp7VFxQ4VsKH++bjQyhlQ5CN9d/6CZFC3UyYKn6w22Q8e0Qw1eWjHxG5/ynjdyaB30dTzqTFYunQNkXPHfX5e6M/YymjR11KcesoUeTWA3eHgJI09Pp2+UEqECBsHKVGm3/hbVLe3V5gDEKSme2BWCLhf800nnvRb3IxeVGFqEYUFL/ojjeZi0hsE0x24hL77fjtuw2p/diasma7NIDhi6/kCfMomkJToXbIbVimLEDSwSK+eY3YqBAFadDQtolvGqkgbwbyD6lvgag7MekKuLQlw8y9jXRb2WqMnpYvRYTalZQz/Dp7nekZ7nLENz+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(316002)(38100700002)(55016003)(76116006)(110136005)(52536014)(8936002)(4326008)(6506007)(71200400001)(53546011)(7696005)(33656002)(5660300002)(54906003)(8676002)(66946007)(66476007)(186003)(83380400001)(66556008)(66446008)(38070700005)(2906002)(64756008)(26005)(9686003)(82960400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r6hfTERgshd9F/Y/oKBxHq6wLQ4W4zK5s+qjd80CEYR8pnvM7SRTlue+jk6O?=
 =?us-ascii?Q?g9kljG2JJCkPYOz7N+pN9aTzl0DlcS1zw+kc03NoDeQ/CIN4rDMr/NAObKSc?=
 =?us-ascii?Q?YTasjIa+lHh9d74hhFns0XeILX1nCryFUj8RXTwejkSjqPZyXrPl9EJg1wUS?=
 =?us-ascii?Q?gSjsyAnCC1Hn6e8thXY9hh1a9lCPZMN/+0+Gh3X40oJ7MlWM0YiUmsteW64r?=
 =?us-ascii?Q?4E7WNbEkJ96RBHbNMr/KOjWaQP2fG8LOKESk2xeXdYeGMSU5QmmDIOtNGSPf?=
 =?us-ascii?Q?DVOMebO3UgDKNECdFaccvt7bFf++Qn/2Ej+VUW+GGO8X9Y2oQ3qmSFPZ/NS5?=
 =?us-ascii?Q?/d/4BHG472a4fJ1hncChefTCKId30AW9NiecaPjSRNnTknJihHQIqpuwndj+?=
 =?us-ascii?Q?AxT0b7jrrtPhuwuOQ2i6ePp5+1rwBvKW6nsennxkLAYGX4H5EdA7BHeFWZDC?=
 =?us-ascii?Q?J8i1gvPt62VLNBox/BeO59fcA2xRZgozvrivwWvtbWLB6II2d7RkumVK4QHm?=
 =?us-ascii?Q?BHgUyuJJ1xDP99Yz2JXGhwKLw6n5EFlZltQV2Wdx8rSCtSQVerxeGAJl8z/k?=
 =?us-ascii?Q?rR3z1Oh9YH0xzvB0UqtsIr3YXfFPSw32oLSsoPIduaEZ5hg3m52K8bS2LOW5?=
 =?us-ascii?Q?91ZCYbgQzYm/TnvVNnv8+mrotzsgxNJr2HQq6qmv1eS0IqB0asujHzkwzP1z?=
 =?us-ascii?Q?LMAd3XOBFqI7h9qdQr1OTHh/1JfAZnRemR475wAc0lgeeFDDcqhrNJpMJ3p/?=
 =?us-ascii?Q?THhe81bcyv2YB12q4ZkTPdEv20Q+D0Zbqv33c/2J0ZiVogAuzxfEdVRNn6KZ?=
 =?us-ascii?Q?MmfB/l1jgxLu8opkG74BIMGToRtIvMTnIi0fF0SnCMEr95pyB1BsE3SHXHGV?=
 =?us-ascii?Q?tts5ss9LPeCxsUODYIi+1qMv8jVA9JeTCEvA7wzftWX80DMPxFYcA8O47fh8?=
 =?us-ascii?Q?u+HOKMuLRy6A7YEpLkc3/82uzG7WNjjNnOmfl7XmQaL0gDLmjd+e/NpUirZp?=
 =?us-ascii?Q?DL2vC6tYIVA/1SijGcdVUEtUZ80puv1PfplKFixnZTCLj4fKXmTE+NQyr3lq?=
 =?us-ascii?Q?SjrSuk7pz+r5m6oMj3VbbloWR2VKNWDceSwFzjJ/q+AnXk+5l9hdKH9TUjFi?=
 =?us-ascii?Q?Sy2daYdr4CuHJSCYNySklGsrvLSyHfuOeh2aRAiUdqNOVrhXYMT5g31f9HRL?=
 =?us-ascii?Q?nPH3epr8flctZoQXNNScoYGBT5oupYJjcrj3zW5FAn3DuMl91ElXEwlIOuVn?=
 =?us-ascii?Q?lQiJ5rXCd6QWe+XVae9Mb+YzZDZvbnExeuxe5PB2ZfOc5UAjYPqh+9ouMQx5?=
 =?us-ascii?Q?RGdjky55tneIkLjEvNEP7j9OkzLtm3lSfI7euGEwMzMnTKgw9miSMz1FEm43?=
 =?us-ascii?Q?l+vfdPkuJk/Ty/Ct+OCZBZReQFxf8aokUEd6fVAkv8IxKcMwvvqGoxwjjiQ6?=
 =?us-ascii?Q?CPuuX7UZT2Q24AlElD3jmquMnRRjHK7UjMi4zWhS6k9P3lqm2FCARVA0rOlR?=
 =?us-ascii?Q?WuI7ExqYmEWL+1qMHuYBKe05/poQjop0vag2DIbmDLhiWgwOJeylUNJHV/iJ?=
 =?us-ascii?Q?qFh/8AphAKyteICTa27L4Ds8zxHJSvq4DteqsXX+lFYAsWnY2zlwcYqv55mQ?=
 =?us-ascii?Q?f43gF2o7JDB5RjQ7G/X33Hxed3g7OLsJBcVMy5ocjNGk3J0rOy4wrwI8sVyx?=
 =?us-ascii?Q?PP5kxkr2KXjRYjK2My2Cvdhqk+aMlQNfHbcQ7mgF4PmW+P/i1hO353j6p4eN?=
 =?us-ascii?Q?yGT5v+L4fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b54c8f-ffdd-4d03-5b20-08da120ab472
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 05:04:01.1931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgh+Y7QGKYaZ3RNPDW4WNfeJtsefABDwPWEdzHPGbcGT1uaJveL7AgGupu9Ul1ezcUJX9YjDYxrO9/w783OgMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4764
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Reminder!

Regards,
Shruthi

> -----Original Message-----
> From: Sanil, Shruthi <shruthi.sanil@intel.com>
> Sent: Tuesday, March 22, 2022 6:30 PM
> To: daniel.lezcano@linaro.org; tglx@linutronix.de; robh+dt@kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Cc: andriy.shevchenko@linux.intel.com; mgross@linux.intel.com; Thokala,
> Srikanth <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Sanil, Shruthi
> <shruthi.sanil@intel.com>
> Subject: [PATCH v10 0/2] Add the driver for Intel Keem Bay SoC timer bloc=
k
>=20
> From: Shruthi Sanil <shruthi.sanil@intel.com>
>=20
> The timer block supports 1 64-bit free running counter and 8 32-bit gener=
al
> purpose timers.
>=20
> Patch 1 holds the device tree binding documentation.
> Patch 2 holds the device driver.
>=20
> This driver is tested on the Keem Bay evaluation module board.
>=20
> Changes since v9:
> - Updated the error message with the macro FW_BUG wherever applicable.
>=20
> Changes since v8:
> - The clockevent stucture has been declared as a global static variable,
>   rather than allocating memory using kzalloc during probing.
> - Updated the print statement indicating the configuration missing as the=
 FW
> Bug.
> - Updated the comments in the function keembay_timer_isr().
> - Updated the dt-binding to remove 'oneOf' as there is only 1 entry.
> - Updated the dt-binding description clearly indicating that
>   the descrption is about the undelying HW.
>=20
> Changes since v7:
> - Added back the compatible string "intel,keembay-gpt-creg"
>   as an enum to the mfd device node in the device tree bindings.
> - As the timer is used as a broadcast timer during CPU idle,
>   only one timer is needed. Hence updated the driver accordingly
>   incorporating the review comments.
>=20
> Changes since v6:
> - Removed the unused compatible string from the mfd device node
>   to fix the error thrown by the make dt-binding command.
>=20
> Changes since v5:
> - Created a MFD device for the common configuration register
>   in the device tree bindings.
> - Updated the timer driver with the MFD framework to access the
>   common configuration register.
>=20
> Changes since v4:
> - Updated the description in the device tree bindings.
> - Updated the unit address of all the timers and counter
>   in the device tree binding.
>=20
> Changes since v3:
> - Update in KConfig file to support COMPILE_TEST for Keem Bay timer.
> - Update in device tree bindings to remove status field.
> - Update in device tree bindings to remove 64-bit address space for
>   the child nodes by using non-empty ranges.
>=20
> Changes since v2:
> - Add multi timer support.
> - Update in the device tree binding to support multi timers.
> - Code optimization.
>=20
> Changes since v1:
> - Add support for KEEMBAY_TIMER to get selected through
> Kconfig.platforms.
> - Add CLOCK_EVT_FEAT_DYNIRQ as part of clockevent feature.
> - Avoid overlapping reg regions across 2 device nodes.
> - Simplify 2 device nodes as 1 because both are from same IP block.
> - Adapt the driver code according to the new simplified devicetree.
>=20
> Shruthi Sanil (2):
>   dt-bindings: timer: Add bindings for Intel Keem Bay SoC Timer
>   clocksource: Add Intel Keem Bay timer support
>=20
>  .../bindings/timer/intel,keembay-timer.yaml   | 125 ++++++++++
>  MAINTAINERS                                   |   6 +
>  drivers/clocksource/Kconfig                   |  11 +
>  drivers/clocksource/Makefile                  |   1 +
>  drivers/clocksource/timer-keembay.c           | 226 ++++++++++++++++++
>  5 files changed, 369 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
>  create mode 100644 drivers/clocksource/timer-keembay.c
>=20
>=20
> base-commit: ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2
> --
> 2.17.1

