Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A5A5AD243
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbiIEMRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiIEMRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:17:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A005E664
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662380257; x=1693916257;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JlK6QAL6uIhD/bklFKtSzHrlBXVFmzJ7vAA0RZX4KIs=;
  b=EawaWIqJ8i8SG2Z+udUFhuzzN+h7BwHgAo92Hkr4jraZHdOHVwjFKzai
   xhDwyqZpfbrZzTYzmstIJri82r8pb55MmLrergNYxeB+Kobq7P8SrYTJe
   ApoK7AuwLFNeu1p/SawqSAFRYBAdRi4IEnvuS1pEES3zuMDWN6/UzYYvA
   4pNROGzAjq4CFVFmTSZEMDAKyOL+RT+JkuWVCUgl7DSMmuWFBZvHZACWV
   SUs94NGtvrBdv7bUUl1zyrPqZsjTBPdhJm9tvhpRe6J5dm50eufa9HboE
   9yIduhse9J9u9VhA5ubiTiPwLaTVhDLpqOiqe2alHZgwClT9PLQ35Fsar
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="112206543"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 05:17:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 05:17:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 5 Sep 2022 05:17:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mT3+dbD73E6EnUkTfpLM5J9Iu3YTsmpDY+LT4XgvJkqoe8hKt3QTM7h9ISXrF1nnSnw4O+/Ss5PnX+K5wzTg/WgqFbppT5INyEzlG5oFYOLDj0GKDwp9kqGsb2h9etIMxWODltGmxmthok8bqWLMppQGCvBt7hfOo4sP3CkAmD/59bi5Wr9HNros7tubD2e64IRUN5Kx0y4o0CDqe+L4Wzu9rNB/RT789qmcsJ/RY8fb4aq5KORcpZQWmjZGpS8IXBSR2D9yMTiVsY4wrT1vVhpZECWaibgP0hjFCtcVBIvgAAVmeCji4W4aAkHGbbG3QvCQPaX9sp/AhQ7m/W+d4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqpRh54Ul7Xrm/klmDSkkdmHuJKPPP0DthhY9me8wKE=;
 b=Zw4yOnvtx2sWj6fqIAw+/St+/wcVzOYZbfWwBl0lcOElP14siK5FSosj/oevwCx2xr5oAfsn10IYRZUZzMEH5/Mch56h5hzxC5QwKQ/hgjUGmh2FHx1l4fKrDRYvM9EkesTVpA9Wxsh/VsY8/f1aFlhfjucrqXqHrtP91JSehZwox84fDqWkvR/HhnvVtFA/J5KVFipTjBjihg6fe7HXE1BSjG0O9I9ZEyIqZOSV5+X01UQE89eTOoam0Uk+9LX2VfGwOXQ8QoYXiLUKJ87EhpKydybj7txee4ZHSyKkxQWfVkpbnuz/x8AhrryRBW3qz0+0lFQ7oKPb5R321PO7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqpRh54Ul7Xrm/klmDSkkdmHuJKPPP0DthhY9me8wKE=;
 b=P6qY8MlhPaYndWBgj9lWiryxF8WaUURadET/LRywBFOA6GBP4MGH20sGn/bQU/DNhkqdG0GPYX7E4MVgeuVwjJzWpj5WL3AOL2Oev5f6MFdcMiO+V5CaQ01mIK3TZtmaOdYphBu34bm2r8aIav4pYJDNn1byNHtjqplzDMJIWUQ=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by BYAPR11MB2983.namprd11.prod.outlook.com (2603:10b6:a03:88::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Mon, 5 Sep
 2022 12:17:20 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5588.014; Mon, 5 Sep 2022
 12:17:20 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: RE: [char-misc:char-misc-next 21/24] ERROR: modpost:
 "auxiliary_driver_unregister"
 [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!
Thread-Topic: [char-misc:char-misc-next 21/24] ERROR: modpost:
 "auxiliary_driver_unregister"
 [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!
Thread-Index: AQHYwRIhxcDXJSnD/kOc6fe+JSyy8K3Qv5Cw
Date:   Mon, 5 Sep 2022 12:17:20 +0000
Message-ID: <BN8PR11MB36683901F40D621C0BB25918E97F9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <202209051843.L37B3c76-lkp@intel.com>
In-Reply-To: <202209051843.L37B3c76-lkp@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e774c6c-ba90-4228-1180-08da8f3894b7
x-ms-traffictypediagnostic: BYAPR11MB2983:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2dLkt3hU10x2G6+zFKoYoTNxKfj/1Kmq0VQJIXXvuz4DiiBAMuGAEQS/y5lOkGAD0IgNIV0YqcikhMDUjHqJ3ohE5xOdEQz6COiAmrpQ3jrlcx10Jf0wejJDXB+dTOIweByXCKHaU1ZjzIDapRwwNSVHet+rAtBKCHzmuZzis1PM+FLquHKz+StTQA8l0S6/T4eIL/bLm0/gnKOQzW9euujLofi+KesMiKJDYzD5swckArLcnmgunUdsTSY7Ak46iKjydsV4XaBxFLqKJQoF4lM7GTKVM9qDJmiMVnvkgiNSJuZUOdZWvoIXrmShJlyUe2O5kLDwDTiFo4AlQzqGRd16GmQa99fbKZPDQ4T9CES0dfIhMBp90fm2vUMv4dJ1PMZka1ueTzpwmmQwBSLnoks3f7URDCeqZ3VwiqQb99Phk4DhqAUzym0fn7EmpvV/S7QVK7oqYbegaM7HwBRpb4Y7rKFMcvH0EqLIw2s6CrTs9Xq7zfhgQ6JQ5k1Op/3jscAr71gAoAlRjvDVmcXOWD519RIMIMuqkP3u393QPfo9bM8Kg5LFGMY0J4L4WSV8X64ypmFqeHIo6EwFBfYGnOaWy/Ve6I5E3KAPHm68brnK3pLKLOxcBDnny+RJeR7UGNN549fGNA8WyBwNgLyvcWcroyte/QSoWzWMw4ZICKvOck4BRSdXU4QIxl7b5bjQMRpZZyJF5IOmiKAyS7x9cjGdvR1Ww3rg4SfcBSSpS1rJ+IozYwHxjVgw0mdyAk5tHGwxn5lbqaJ8XcuOx8IiRTO2km16/uUnePfRzO6aWM7WCVdcTV3u9gsNYZvWGnH/6wVprKNxdtAOfShNMJCDP4urdDuE2yybOpFcZd+9l5Q1ucWB+8LO0D0dZ6y1QK4xpU8uavzptJIpazDywVlipA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(396003)(39860400002)(9686003)(8936002)(26005)(52536014)(53546011)(55016003)(5660300002)(41300700001)(186003)(84970400001)(86362001)(33656002)(478600001)(71200400001)(966005)(6506007)(7696005)(38070700005)(316002)(66946007)(83380400001)(6916009)(54906003)(2906002)(76116006)(122000001)(38100700002)(66446008)(64756008)(4326008)(8676002)(66556008)(66476007)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cDPcqGdHO21wWscNDz/4AoGejfMfD2XtXzuUmR1clK/gJVvvaPX4AlGOaoyK?=
 =?us-ascii?Q?brbbZVOR81s27RhkktrUph28Vb6eI4DWtUmhOJJau0utnrN/9G6bRzFjWkTU?=
 =?us-ascii?Q?abegc7nTFWlMNmDUewKLwqSr2SZlZKkYzgNmjYjzT6hRVdYFmMUBhRih/C3Z?=
 =?us-ascii?Q?INfAD38jreRv3ezYkKr9eRZXfNXCBL+z3XjilfPNWQ66N2xG1GDH0g2sDVOs?=
 =?us-ascii?Q?1q6AIIhgY5QXVKLZ+sFbd0WVlxD1g2w/VkbHZE9SKLE4fU+qKD8KygrN5w5L?=
 =?us-ascii?Q?trYk4WQW9cgAAfjugJamUo4MExC9qzlbrZ6gCDxKtiD6dmBMQON54/W7p7mu?=
 =?us-ascii?Q?ktK59hqYTwKzrIZsjCDIvJKE94CglCwrpF3QK1SohTaxonPUxC5iUGMwKCBz?=
 =?us-ascii?Q?gu6ixC4Keg9g9hUMYIqNu9hxXlWnC5T8Hg40lUjGR+gByjHY6x4ZYVNJqECg?=
 =?us-ascii?Q?U0ZqL+ntekbx3lSUW2UJApryHzhImdcPFbn4MuuTyTJ3A15eRQ5WiHIe710G?=
 =?us-ascii?Q?cCsnJTyTjvqtbW8HfgsHp/u5By4t6S+M4jUFPBopNjppd4v9YExtlLzgzNXE?=
 =?us-ascii?Q?ZdRo7j+zeH/pwFmhAV1ZX7fK96EoJRXAi9MQIhiYxBVdkt7S6jNzPul0D57b?=
 =?us-ascii?Q?ZDVlWst/VGK6nyyIUeuyjbCVUpr4VtOiJoXN5r8jBNB5UQ59eIyVP9mu0Wob?=
 =?us-ascii?Q?iJJsb8YSs8rp3iqwSoR0b6bXf+XPvAm+SYOFK3Y9AMtXvolOPbTWt8skiZmi?=
 =?us-ascii?Q?y0Mf+qNbrHLIhznle2/DIhcsvUE3Q46XA72iOCRs0+Jn8OHTGKqYJ2kxihNU?=
 =?us-ascii?Q?EpyF3slNp64MVK+ybDahNRu4eu4pu3nVTvtgsZCiTaYYZnFZfac79jP+iKUv?=
 =?us-ascii?Q?Tf9cjaRAiLPM0VNWVXGBsZji1APSGbDOXXEeSML9F4PFuTycdaarXdmy4BEr?=
 =?us-ascii?Q?Sw/x9dWi0bIFbrIdIJpigXdJe26XFAzTYJy3PEx9cX49fJfUWH08J1IoXwzu?=
 =?us-ascii?Q?SvIbLmbScLCQC2is8DCUf+3EijBeVj9oBPWidIiB6U4muFiOSzv8UUNQYIuU?=
 =?us-ascii?Q?y+UEg/2NZsiaXMhxlosKG3DvdMmn6/T5tR7g5bx+BTNqJ1pUtWj9mfijc1g8?=
 =?us-ascii?Q?tnMFjDp/LZ7pygUTIBNEAYU9B8080+IAK/aex3C+C1QTGHb53ePxnwJxfjLt?=
 =?us-ascii?Q?DZgk7gFONlvjfI27szenLUTplcXAhywK2NVoWQsX/satOMLKYSduuhYAk6qq?=
 =?us-ascii?Q?NKqTH0TxBamSfh4uaovvdFNXv1DJ6iiuxoSH3tdI+J9kf3eYS5s/oqNf83qU?=
 =?us-ascii?Q?9wDb+tFyge2GwX+vxDATBaHsIfLlVEM9iUUZf+ZGFseKYiPsSas7YmwKfwon?=
 =?us-ascii?Q?k5cOIIzQZh+K1EG6aXmEGU0iklqXlbBjOhsK70h5IxnJh/lEPj46r+du2bBc?=
 =?us-ascii?Q?rMmvkqJVY8DHZLcjwSAv17owMZ3+E1lRR0m5f15T0iU+j3QjfJtcn2AX7KFn?=
 =?us-ascii?Q?ZmL+kZWy5HvENaKshqjGbsc+HUemuW/5nWeOliwubGAIgLg/lICEaxn2o273?=
 =?us-ascii?Q?Dl/NgSXH6kbS/L0Bpyv9mFtMK27YPhfJF3qBf3J+QzTM1jGOwnQEK65xcM+l?=
 =?us-ascii?Q?Q94fGGaazV1huw9zZUTMako=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e774c6c-ba90-4228-1180-08da8f3894b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 12:17:20.2000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGnCoZROFXAW/A6/DCg8nRJxhF6wJQffy6oqnEbNIsayZFXktMtG+Bj0N4Z6+vqs1YDi16s4RLVKVQPFhPemBAy7NAnFTHU4X8J2NZr3WJhHisBvQHBkBfcNugBUOnsq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2983
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Monday, September 5, 2022 3:57 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Cc: kbuild-all@lists.01.org; linux-kernel@vger.kernel.org; Greg Kroah-
> Hartman <gregkh@linuxfoundation.org>
> Subject: [char-misc:char-misc-next 21/24] ERROR: modpost:
> "auxiliary_driver_unregister"
> [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.=
git
> char-misc-next
> head:   50e177c5bfd9abc3828cb57e14e6169170f6764a
> commit: 7d3e4d807df2a216b9aa2944372f2b3f6ef3f205 [21/24] misc:
> microchip: pci1xxxx: load gpio driver for the gpio controller auxiliary d=
evice
> enumerated by the auxiliary bus driver.
> config: x86_64-randconfig-c042-20220905 (https://download.01.org/0day-
> ci/archive/20220905/202209051843.L37B3c76-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0 reproduce (this is a W=3D1 buil=
d):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> misc.git/commit/?id=3D7d3e4d807df2a216b9aa2944372f2b3f6ef3f205
>         git remote add char-misc
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
>         git fetch --no-tags char-misc char-misc-next
>         git checkout 7d3e4d807df2a216b9aa2944372f2b3f6ef3f205
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> ERROR: modpost: "auxiliary_device_init"
> [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko] undefined!
> ERROR: modpost: "__auxiliary_device_add"
> [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko] undefined!
> >> ERROR: modpost: "auxiliary_driver_unregister"
> [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!
> >> ERROR: modpost: "__auxiliary_driver_register"
> [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!

Greg, I think I must select the AUXILIARY_BUS like below.

config GP_PCI1XXXX
       tristate "Microchip PCI1XXXX PCIe to GPIO Expander + OTP/EEPROM mana=
ger"
       depends on PCI
       depends on GPIOLIB
       select GPIOLIB_IRQCHIP
       select AUXILIARY_BUS
       help
         PCI1XXXX is a PCIe GEN 3 switch with one of the endpoints having
         multiple functions and one of the functions is a GPIO controller
         which also has registers to interface with the OTP and EEPROM.
         Select yes, no or module here to include or exclude the driver
         for the GPIO function.

I will test my changes and send an add-on patch.

Thank You.

Regards,
Kumar
