Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16055AEDE6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiIFOpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiIFOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:44:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BAE55B2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662473069; x=1694009069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XPnExotcUv23Qjv9TfC7epqAhRejORbaVej69uQ1Tlk=;
  b=UbFPoo5zPr8NKk2T3fd9MOBzaUFvOuoZ8drqFsUH7pMK4V5S16wmoSEs
   P6mjr68fHW4d8MlgxSffR34uUkR64rUn0j7saH2LOxKYC2P7RWtbF45Ao
   j3vFwMJy3uOuGoZJ2of9jaC6Uq+8+ErLO2ZLQ/wwVSeVf54CTtGfEdpDW
   GzhZ6uVYAO8uQKmcXR+VJ9FyiWnqM8xEfsUTIiq9w2rtFlAIWdOByKS6K
   yEL73SIqChT046zezKpZD7JB4JwD2/Birr8d6dWmdw2DyX5cVKqwH14nD
   chLelX7c0dAftO+3lmMz+822OL9TW3uoU3iVFbruqS1SyzReifagcTjjA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296600143"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296600143"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="565102150"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 06 Sep 2022 07:02:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 07:02:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 07:01:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 07:01:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 07:01:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVRDZEe0jgg3XqOBHo6RJEItlmVBgOrra0m+KJ9cUKrODD1KpdzpDHk+dGtfKCoZKZI7Bg6oKlW1ooX0ctMnIBnicsx4Gyjq3xvuCwvq+DT6g8IxQGcKDq9O5h7B9fVJwSn0TPCdFNdrvWAVSCAs3wwClsaTBN3G6OgT+eqepaUoQp4IWOZoUjlOr/mgOxbPGjJvCCMb9WkET4tsWcPMnya81xNbGZdELZLaLrkH0dkf8UlpXmR5bKhcKBaeM3c1fw7GXgz5csB6TyW/PxcgKRfiOtDwSKpbxyXizM1hr7Ywglp4tM6e9Sw0jjmqUYdmmBO+tTqT0JNHuY2vHxDKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pMg5E5jFzj3KtV8JUOOv7nChVtQDlBkI0eK1JX+5tY=;
 b=NAEhvsHZ4+Dw2n8J6dX+kjCRo2ZSMMME+KtdoISt99MyyyaP0+lxrI1gMhhuqYtMcHEpH1Ny/MHXCVOGySTLWrgb+m2yIXp9srJoDbSsfzDu7x7Hy3Cx9RzPJNcQLeT3pexy/pHIG322h471iPuQ4pqHc86pj5pwg1XKxnfRjyufoiDmBiigHvLjl2BN+XsqwEBJoCcmh97z4D5s8rv1LR67f44RjHEbwuzkIWPE1NGPsAoleTCJHHAk/VxCsfTgEp4HLGu+gClmF6zuhLkEaigJINqu158c0+FhMjcmzpnHmx+Pw0RHQNjhXnpsJ2qpoTDZfWuJLrSa/yQQ4pGZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 BN7PR11MB2804.namprd11.prod.outlook.com (2603:10b6:406:ac::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Tue, 6 Sep 2022 14:01:52 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::b04c:807c:4ea0:c62e]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::b04c:807c:4ea0:c62e%9]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 14:01:52 +0000
From:   =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Simon Ser <contact@emersion.fr>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH v3 1/4] drm: Expand max DRM device number to full MINORBITS
Date:   Tue, 6 Sep 2022 16:01:14 +0200
Message-ID: <20220906140117.409852-2-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906140117.409852-1-michal.winiarski@intel.com>
References: <20220906140117.409852-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 422db91c-3acb-4ce1-f6aa-08da901059be
X-MS-TrafficTypeDiagnostic: BN7PR11MB2804:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ijp6rj9xduN8Q6wRj/ESes6t5Y+aFyZHTlamW0UpmFQmvw+Ez8W0h7IbQYICYdLHugDNRqJ+DfNEmB9bXVB1t3O8nnF/YApMnS8nJhP7Rbf5b8A3RjY/Iv6EaoVrVM1h2ta6IBCJkgHEJbz9tSeVqbHBFnmqzMk8ZAkcp9rDsoH6BUGlvBhuklGEURxDj7iKE7KMIu+8mOhO21kMl54c1MAcl4dqNJeQus7ucyhHO7pU9yi3ao6fsW1rIgF0a4nZwLhZGrKH3eubPHWXlpJtjhFlLQNc0JGinNZn3wH3oMiBIz2eJx09xH2K6GXb3q3AlJ5TngGNduY4qbMwSGCZEJOOHwMWk+OzxiJQyr6cmGZ1s+6Rxbpp0LOzWgN1rvQyMF5++CND4NzwJoY8nc2k2abM6rmgfFyrv7kMJL8eRyW4lTwPrxXXuYJn/FUCDJiwVQmysrt96SHU33teRf7wHAcQwQC2iAF3lYFzAMfoDN0950i40pIN1Np1lY9Q7Hk57KNx1df3DjHmOEfjrhiaEL9XZIvzNc4zMnYyr1MUqqHnKoLniOkFkqsyrGKDLtrG2W8zcf/EUJh/JHTUsBx7o9bFsxQ6zzW1bOwDIPVntAFRVgtEtoCwCUztgfHFVWzeJOO6URhc0jBzefjr1u8zAoSLd7a0mxdeY4ofiipfpawkDW7LaWY9oqPA44AT+82slIptEG6u5CmmJtTRLI0j4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(346002)(366004)(136003)(8676002)(6486002)(66476007)(83380400001)(66946007)(66556008)(4326008)(478600001)(6506007)(6666004)(26005)(2906002)(6512007)(5660300002)(8936002)(186003)(1076003)(86362001)(2616005)(41300700001)(36756003)(316002)(82960400001)(38100700002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzFTVDVSbFVqS2tBeGxDeWJsMjJuYTc2L3dQSTZSRFloMDRaYmxpNmNwdTc1?=
 =?utf-8?B?dnVqMUFpSm5VMDhMSTZ1Q2ZWM3d2V29XS0lmVThKNnRRN3MwbUJ3R1VWVlli?=
 =?utf-8?B?MUx2RytyVXNxMy9rWlYrWTZBOUlMTDN4UmQ2SmFEWEJKT0xLd1RDdFl1UEN4?=
 =?utf-8?B?MHRZVEppWnIzbWF3UjdMTTRyN0lSVmk0ZTRoUDEyb2tob0ZOL1BCekJOSFJV?=
 =?utf-8?B?NHhhU29hSzU1THR0RVR5OGNpeGlOZXJYZEl2SEVEVTRIK01RUzRwa0tIc3lI?=
 =?utf-8?B?TE9KaGRNeHpidWc1ZVM2WE9RcGFkdTJlc1hzeXVsZ3lMVi9hditrald5VCth?=
 =?utf-8?B?QzJsWFdzRHc2bzdBbEJ6RVVaZVRIb3ZwNUxTR1lVT3liNUFoQ0Z4YlBBNXFE?=
 =?utf-8?B?eXp2aGwrUUNQb2dXN0ZmU0k5R3pnZnhoTjBFOFRGcGxKT3pzUTNYZ2FVQm1h?=
 =?utf-8?B?OGhRNkkzcys2ZlAwTURYalFTK2E4U2MvYnU1QWhFSDliZ1crZHhwTG9yMkgz?=
 =?utf-8?B?dDZESTFoSTdZWUZiU2RObVQxcnhKdnJLeEpTZjdYeFBvUzU0aXF1U1VXWUNU?=
 =?utf-8?B?c0U5ckRFSXNtMnRaSFFLbTlwUEJVMkd3TUhxbFc1MDA4L0VHN3RzRkgrbmJr?=
 =?utf-8?B?VEQ4WXJURGJzQTVtQUZWbDR1TW93cmozU29MQWJEMXBmZ1FkVkxWNWE3ZzNm?=
 =?utf-8?B?czJ3cWlTY0NEeVdSaWc4WDdTc2dxL0hrWW5wdU9iYjhTQm1ZdnpJMWM4QUtm?=
 =?utf-8?B?d0dxMnN0Q0lGTGxxZytHZGIzc1MzYzcrUjhXbVo2VkprRVJ3ekY1RmZucWh0?=
 =?utf-8?B?aTdqdWU0YnhQQVNYZ2FlL0xRdnhPajhYaWhYbjlUNEFzRHVnblZrVFVYa2VS?=
 =?utf-8?B?M1JDNE1Kai94QVJlV1VQajZBQXNEd3lVVVR6eitaMWRKdW5VSWVNWDZpdnds?=
 =?utf-8?B?OUpCWkVQQ01XK3NlWENESjgzakgyZ3gxU3ZjRlZkN1lNWGs0bDV4TVpIK3Yw?=
 =?utf-8?B?RkVPMFI4QXAzSm1NNHNKWHZCRU91RUdOVFoxQ0YzYnNrRnFZbGkwcjM4NEto?=
 =?utf-8?B?S3ZlU0duRTBCNzVsUEJhR1M3TDl6YkM2U0pDd3htTXNxR3BEQXFRT3I1UkJR?=
 =?utf-8?B?OVNITDhFd3pVa0JmYWJVNnJGVTlQaXRJSGZ2dE9JdTFNMWJoVy80R2hleFAz?=
 =?utf-8?B?TTlGVktGQmNlY1poeDA0N0p2cWEwUzVJL01mWkZKbHBadlBaQlU4SXZVNzhs?=
 =?utf-8?B?cjZZTDVHblZ5UnNQaVBWRkRQNC9USHpVZnRMNlpRZ3J6by9vNkRvODRkb2xD?=
 =?utf-8?B?TUVrMW0zSytXYXN6Wkh4T2xqdGEvM3hzVUR3T3ZxaFE2ajFPeUJoMFJWakVj?=
 =?utf-8?B?VnhjMEZqMnlSeWZqVjZ0ZEVMTmJPUERVUHBQNGRlYjZLOC9OY1JGK0Zla2tT?=
 =?utf-8?B?TFB1RW5UeUh1NVVZai9ic2E0S2VwbUduN0orRWZoOHhsTzFRdzhXREorQjhu?=
 =?utf-8?B?aDlOcGx6b0dGSjFCZnljcFRjamZBYlFSZGh1NlFVT2ZRLzhSdEFtWjJDWTQv?=
 =?utf-8?B?S1lHbUtpRkszSERhWlhMb05hcFJUSTN0Vkk5ajQ2d01kUXplSnY2M0R0Smlh?=
 =?utf-8?B?ZE13bjhVdjB0anBHZ3RrQTVFbVdwcExUMnJNa3g2Sm0wREsxMGF5S1U5SlM5?=
 =?utf-8?B?RDQvMG1qV01ndVgwTFR2a1htbUlZUytvSVBOZFcvaUluTi9Uallob2lKOGZn?=
 =?utf-8?B?UDZSRTJlenQvNFl1Nmo1ZG9GRmtHSndjS21oejJvRjFNc0dhY1E0VEFuMllx?=
 =?utf-8?B?NU1tSUhCbGtSVE4xcXp5ZE5QZ1VHenV5Z1kzNlJiZlJaQldZdHJiSFZxSVQr?=
 =?utf-8?B?Zm9PeUdoMlZQM28rVURxbThZUzRxMU93VDZEMHIzZ1F1eE12Zkh0cVNaUGFN?=
 =?utf-8?B?Y1poS1RDSGZmalE1SkZEeUI4Y3RQK0YyVXY1a0NCZG5WVE16WTE1K0g1Vmov?=
 =?utf-8?B?RXBkeGUrbHUrUUtSZTZReFBKYUVSN1dCWVJDVG5pR3FqYWkvaVd5Sm1vVWZr?=
 =?utf-8?B?dUFCK25oM2IvNGsreWhPd3ZEbVUrQ3lTT0MyRFFENm1aRUVsS2M5cjJVQ1Vs?=
 =?utf-8?B?UnF0cVFaazN3NlIvOXE3eWpYU1grSXlKYlJNTzhKdE43VktLeCtHN3RZSHJB?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 422db91c-3acb-4ce1-f6aa-08da901059be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 14:01:52.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wl6KVK08Ph4uwT352Ob+KiaJs33PlK1GCFeqklP0oV03MWwPcZ6xlk946uPqY3NyYVtSixh7dEk3hKvncyJ/oFZ7gVczuu2VtcF8QuZQgCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2804
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a limit of 64 DRM devices is not good enough for modern world
where we have multi-GPU servers, SR-IOV virtual functions and virtual
devices used for testing.
Let's utilize full minor range for DRM devices.
To avoid regressing the existing userspace, we're still maintaining the
numbering scheme where 0-63 is used for primary, 64-127 is reserved
(formerly for control) and 128-191 is used for render.
For minors >= 192, we're allocating minors dynamically on a first-come,
first-served basis.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/gpu/drm/drm_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 8214a0b1ab7f..9432b1619602 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -122,6 +122,12 @@ static int drm_minor_alloc(struct drm_device *dev, unsigned int type)
 	minor->type = type;
 	minor->dev = dev;
 
+	/*
+	 * DRM used to support 64 devices, for backwards compatibility we need to maintain the
+	 * minor allocation scheme where minors 0-63 are primary nodes, 64-127 are control nodes,
+	 * and 128-191 are render nodes.
+	 * After reaching the limit, we're allocating minors dynamically - first-come, first-serve.
+	 */
 	idr_preload(GFP_KERNEL);
 	spin_lock_irqsave(&drm_minor_lock, flags);
 	r = idr_alloc(&drm_minors_idr,
@@ -129,6 +135,8 @@ static int drm_minor_alloc(struct drm_device *dev, unsigned int type)
 		      64 * type,
 		      64 * (type + 1),
 		      GFP_NOWAIT);
+	if (r == -ENOSPC)
+		r = idr_alloc(&drm_minors_idr, NULL, 192, 1 << MINORBITS, GFP_NOWAIT);
 	spin_unlock_irqrestore(&drm_minor_lock, flags);
 	idr_preload_end();
 
-- 
2.37.3

