Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929CC5A9927
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiIANj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiIANi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:38:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE3510566;
        Thu,  1 Sep 2022 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662039442; x=1693575442;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=QbKgOqONOs31kIwm2z1V2vDM6fGmIlyn1NQgRVDcd8c=;
  b=ZqRst2M51JHecqD8Bekus26mcZ3Qbl0YWxeN3q1lLdynC2eDr+eYh+At
   GxAQN/oIpaY+/VnxbGHil8JdmeCgYvkY9XQyu6AVFtRvefKNUky+V61xy
   AIIIDMoWKO9eZIvPTuRv4K5i4C9TXC2q48an2O/3qiCljOZM68hmxsgX4
   46ZIhqsI4E84w8qJ8eFEJtQSu6uKMNe9X4JwLWj1laaK3WSheQq0CunIh
   ALIOWbOgXSDTaixqJ6hFsrm0Z27VJXnso01Z6SemZJMDGoxkQ915Iet2c
   uiIiluA/+VVuMMDyLduU/mxDCkHyVv9OqhlM8N3T4DhbwNSdmLZLEoFQ0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="282694280"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="282694280"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="645655762"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 01 Sep 2022 06:37:21 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 06:37:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 06:37:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 06:37:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4HVnBlNL1RjhszoNxND6i/DGA1xpM254/2LgUk01xffzCYYXjxadnzZxNBPLRn2pE6OhAdUkvzuxgS7pWPrrGAzYI2oExpDGWv+SZBIp3k9TIWjiG6wRdc8Ilt+ptmzlsElQBupvTyCpiuAFV9pzhjsTLIikhtIGyyGuAE3Yf0WcM0giP5PwSlWzo8cR1ey1zLJQFJCOkRED7/twcSehhH3uRo8wm7jooJPEFhaFptIp+q/G1s5UNxUW3merDmc8xL5jJD3BPrWWSurHW5hIY3zbppm4OGlVTfOPrMdEwgPmuJXwe3K1f+MpXe0U5EP/77saT8Q9liKwIa9Gn3EMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmNuE9o9FyblXfqbdb5e3nIOPWul0lvi6dgKR6Qd2Fc=;
 b=bF5koSiGm80t84oLw9Ap65Gd4FPfIA0RbJJwSFD4RbPyq5FpircKFARIqX1uDOpiNMBXkbTC9468ZWWuX/qfg2w5Flclh3a8xUeBdN6heN9e+HcUOkifsCXOjLGTQzndSR8DNWOuc9cKQm20JHm+fyVWIl+rm7FlagmnU4uhBsY0JqbRN0S08h5fIPXpdpf9NZhD4gZ6EZuM1FGD25Buj4Rc6FSfSi04ByXwMPXMoQvXqfVjGIpD7Wzgt6CQpeZbTBUgkZGZntTuXL7umhkZGUWK0csCC7a0cSJ1omPjgbGHz6JJ09Qnkgga54sbDBe0dfgd26DGY634pQhk+oX0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 BN6PR11MB1682.namprd11.prod.outlook.com (2603:10b6:404:3e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 13:37:19 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::b04c:807c:4ea0:c62e]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::b04c:807c:4ea0:c62e%9]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 13:37:19 +0000
From:   =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Maxime Ripard" <mripard@kernel.org>,
        David Gow <davidgow@google.com>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH] drm: Simplify testing on UML with kunit.py
Date:   Thu, 1 Sep 2022 15:36:21 +0200
Message-ID: <20220901133621.353270-1-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::17) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ea75e2b-e369-41e1-8fd4-08da8c1f174d
X-MS-TrafficTypeDiagnostic: BN6PR11MB1682:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pqw33bElAbHi94xVY/FfcEvqTPigb0UbVkR79f5o2ymlMJUQJw7J/FvTz8AuUP2RELJHKXhUukJ+zctR7GaJtSNiGfY9+2ohFXe/urFA4gRw6P2ik/4kkW1mx1jl+XgiRBdKLSdBCcuZ63jqWp+le63ZMfD2bG3Fh9uivdFLH3UX2DwmfxhfG+3V7klW/jeCZSIPIpLoVI8gdP+tDQJl4YgpbpSwChYi65IDFiKyBDqtMsOkhY3+JpQY0bgyCLlVUsCbM/V6l0HUdKZ5wBKu7dsVXpm0BMK7Gvk14CtlYQ7tDetMXg0Yaslw1l++bD+on80vBTvyGdQ/AwmLFvOvtdbLQHEsVJXUxargU04E2bEmjCciUTAszfLoe2sKhWr9W/llQr43covVVOV/nyYaCImOkcNC0osXC/t+0Im0GrbDnTB2L8T+jgUAO0FGKjpkBeD8Kb/EMz+Y4TECLN2HfP/SIpSGyY0X0Fr1+/A/miPzN+lT/MriKOAmvD2XTxk3jsopYJ++NSWbWF3JwfAmr7oDwg+uHnHe3rU1+PoqgbJbKFFJbZLstT5D/75hjg2ZPN/8ckRXCEsfTednOVFWGvpHit3A6EdFaYHa0JLDPjsEVkXoOtQuzTxp7TgJJAFFJFLE5n719YuN1appx/6baW0gM3KbZ3rRyrTn50A6cjINeLji5NMnp0z6aERLxVS0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(376002)(366004)(83380400001)(6666004)(86362001)(41300700001)(6506007)(186003)(2616005)(1076003)(26005)(6512007)(82960400001)(38100700002)(8936002)(54906003)(7416002)(316002)(5660300002)(36756003)(4326008)(8676002)(66476007)(66556008)(66946007)(478600001)(6486002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTBvaFRKQkJwMDVQczJIdFUzOXhTMGh0a2hFWUo1L05ReWxPdEVBdSt2aHBh?=
 =?utf-8?B?cG1uUXJZUEdybGxqcXV6elRoQmVkZGRQVVN5L0ZVZUR1TjJrZWo1RHVwcTV1?=
 =?utf-8?B?Y0x1bVk5YTZNcWtsVkFpQ2JNTVVBRElZVVRFd1NjeE9kYmpxVm9EcFozYjFN?=
 =?utf-8?B?NjB4cFR3RTdoUFhSaFp2WVRSTFVYbG90VVdzalJadkdtUlhoVmN4Q0R6ZWlj?=
 =?utf-8?B?Kzc1bzlnN3ByZVFLK2dZNEhhMzNKWFFnN0NuczB3aWVhcFBPaDlaVVhoa0Zo?=
 =?utf-8?B?OE5kYUp5SDRIaXN2SFFxcU1VaFkwbzhtMWZJSUhnT2RTQTgvYlB4a0dZUnNS?=
 =?utf-8?B?NU04Wmw0MWFrR0ZuTE5wUnpXMnh1dVA0MWR2d2xqM1FwTlRhVmEyMFFpcmxJ?=
 =?utf-8?B?WDNvMWp4eHdZRWVxUktuSERqcDRFaFZTSEhhM2VkZjRGNUJCMUpsN1Ftb05q?=
 =?utf-8?B?Ukc2K0VsYWhtcWVDQWpkTTUwRFg1YUdCZGZOZklEUGFmK0xCR0hnaXVTYVha?=
 =?utf-8?B?N3grWHk0SERmelVFU3VLcEhXVWtxckZaVFFPOEVTdUUwQ01WYkMvZ2gxSHNP?=
 =?utf-8?B?WUVqbmthSHdDQm9UMUdUQUprRm9kUi8wQjZQVEFPejMvRCtmcXYyb0pYWFpa?=
 =?utf-8?B?WUdxcnR6TnFXTlN2d1NDcjVvZ1ZLWmpRK3Vib201aXV5cEM1WFRZVEsxclY2?=
 =?utf-8?B?UE5EeE9nbVdsMDgrWXc3Wm0wL29hazZPMWZydlJ3amJadWM3M08zSUlaMzFP?=
 =?utf-8?B?Y3ptTkgyS0oyZGNtMGExUGw5QlRJNE9QME51U29FMmY1bkhtS1hsbUs0MExU?=
 =?utf-8?B?M0xFWkZCZDBHU2VwdHptdnVLZld4RUt0eUZibkt0L0hnMHdMMk5USllJNDlM?=
 =?utf-8?B?d2YzVFlEVEppbkZad3YrVG1TZEtBeWhhWXNVbFcwL2hKZ1dtY2VGems3M1NL?=
 =?utf-8?B?cStFWmR6a1RiWnBKMnJ1eW5WSFBBd1NNT0hjbFZ5a3ZYMDdJejBFenQ3b2lm?=
 =?utf-8?B?Q3VxWEZTcklHWXhMS0l2UXJHZ3RrUER1Y2FzeEJQbU5raVdiN3AxT2Vpekho?=
 =?utf-8?B?MmNrYnA3WGhIUk44cDNzdTJaNDJNY0Nxa0ZTc2Z5Y2I1bHZ1NXZkUlBCcnVD?=
 =?utf-8?B?TFVUV05aR2F1TlJtNDNuSGRCM1FYWU9henVxY2pZVWduSlpIVTgzbU8xMjNo?=
 =?utf-8?B?dTNYNnhmZHZIcGZzb0NEN2NjdjcxUTJjd2hnSjlKWkptT015K0lEdnpuekgv?=
 =?utf-8?B?UWgvZ3BuRUVDL2RrYWE3eUh5Y3J5V0NxaDlpZ3BUTXByUG9tTzhDOFJQRzlv?=
 =?utf-8?B?YlJyTjRiK1VWNlEwYVZSM1prL1JjTGY3bVExbFJ1V2hqaXdZL1hFV3BiV09k?=
 =?utf-8?B?Q3FSY0dISWNHWHJEZzF0THZwZXd2TFlsWEdxNTg2bzQxZGUxVmp1T2o4MzF4?=
 =?utf-8?B?dFBtaHk0L24ycEN2SDBCbUJPbVUveEFidFNqR2FFMzB2NWxuSWtuc2JTSXpw?=
 =?utf-8?B?MmFERDY2TXpxZ3pUK0ZFd2JqZGNUb0JPc1o2ejRUVk8zc1cvQ201R2V5NWV2?=
 =?utf-8?B?VUN1dWk2cnB2TXpzbWdUY2FYc01zd0t6R05rZUZIMTBKWGw2Z3c4UytKMWI0?=
 =?utf-8?B?V20xK1JOTzVTNXd2elpKcnp3Qnkyb2RaS2cxNmxRUmVDd2tkMFBTOGxGM2M1?=
 =?utf-8?B?Q2JWTFp3OUdweE8wY1ltd3ZLdnV3bDZwMGVMNE41KzRSbGVDSjhpWE5lLzZC?=
 =?utf-8?B?a1k0c095Z3JWQnV5eTEzOXpGYVpIdmFFSnlRMWliWlhBYkVncUc2a2ZVK3l2?=
 =?utf-8?B?aGErWVFTUnZxN3RWcDRsZlp1MTQ2N1hMbnF1bFZLMHJ6b2RnZXhmZVZCcUVG?=
 =?utf-8?B?KytNVXNVWHNveEcveTdSeTI3bUNBZnI5Y01pbGVvUlJnK3FaSEFkSGd6T1p3?=
 =?utf-8?B?SkZyd3hlTWVpU1NpYTAzZTNpMDIySG14UWtKQUVYSklINW1JQTl3RGgxRVR2?=
 =?utf-8?B?Tm1MdGY5SlJ1ZmxTY1BRVGNjSDE5c24wR2E0Snc2dXlrZmJRWCtIWDQ4SEh5?=
 =?utf-8?B?UmxiRW1tVE16b2F3dWRSbWFtbUhBU1Y0S0Z0TzZYYVJ2ZFh4SmJWaE56SFA3?=
 =?utf-8?B?VFQ1ZDltTHdnWnJFNEhTZ2NUak12Q2k3WjEyR2xSQmFwNEV3ZUhZMDhaMHVX?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea75e2b-e369-41e1-8fd4-08da8c1f174d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 13:37:19.2773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVNuagLHSXiokL0ByUV64wQNjRCY+zjK4/A9UQ9ajZV49YUbq1PRnN83F5v6hSqanTGcWdvKKLPXErEYkzBv/GLCFsek2/a/nlyPoQ1gLRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1682
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

DRM depends on IOMEM and DMA, introduce an additional Kconfig to pull in
IOMEM and DMA emulation on UML.
Since --kconfig_add usage is no longer needed, remove it from
documentation.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 Documentation/gpu/drm-internals.rst | 7 +------
 drivers/video/Kconfig               | 4 ++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/gpu/drm-internals.rst b/Documentation/gpu/drm-internals.rst
index 5fd20a306718..c264a9587d21 100644
--- a/Documentation/gpu/drm-internals.rst
+++ b/Documentation/gpu/drm-internals.rst
@@ -228,16 +228,11 @@ follows:
 
 .. code-block:: bash
 
-	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests \
-		--kconfig_add CONFIG_VIRTIO_UML=y \
-		--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
+	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests
 
 .. note::
 	The configuration included in ``.kunitconfig`` should be as generic as
 	possible.
-	``CONFIG_VIRTIO_UML`` and ``CONFIG_UML_PCI_OVER_VIRTIO`` are not
-	included in it because they are only required for User Mode Linux.
-
 
 Legacy Support Code
 ===================
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0587e21abad9..f3266c9fa8a6 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -52,5 +52,9 @@ if FB || SGI_NEWPORT_CONSOLE
 
 endif
 
+config DRM_UML_IO_EMULATION
+	def_bool y if UML && KUNIT
+	select UML_DMA_EMULATION
+	select UML_IOMEM_EMULATION
 
 endmenu
-- 
2.37.3

