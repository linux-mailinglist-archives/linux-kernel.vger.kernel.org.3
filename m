Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361985AEDF9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbiIFOpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiIFOov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:44:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8D7DE98
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662473075; x=1694009075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=psUf+ThGOXymqI1/AsEMN8AgIksVidwn0U3Nks4tEJc=;
  b=J3LnfR/m4VutsS5NGz23yO55JqnAoHb4DN0Vc297sE77AqJdjK8kMVrT
   6VdEpOLUZSjE6/9Kv7DLlZkcQiv34GIA25bU3/1awLrUC3PpVDQhcuNnA
   Sl4HIpI7MFFHINrAOHyy7a7BIIu70mQNXc2DRQ4YhFYLzP2liwBe3j4iq
   NYnSkBxXGDpIum4shK8CCd7XxPEmOCDmk4nU1nu4beLOLehgGkB2OnJD3
   aD4QjYNono1kQAwZhbp6pfPOqpKTCTZNbD35pHI2O4yOkZzOj3aural7E
   9P8QkMEOAPF4dTaYhcW7KgGoZzzsx/uBGombvLWI6IQJkg+0b4ohlUqwr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296600309"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296600309"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="647238386"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 06 Sep 2022 07:02:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 07:02:30 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 07:02:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 07:02:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 07:02:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJPWRTSvdj4NkSJZyqsONPoG2N3i4j+mN701An3PceOt0VcgNM/NDfRJ4Snp+XcQBVD/MKp+v9ixNg9thU3v4O42m/cHNS9PSb4AEEiUbiNKEklrZjBVHlwetLKDIb1DYGImSzSshyb0zO6KLUj1TVkFbD/lkhl34ENbS38+Rj38LTJ4BrykzO6JfbsUEe/eRcCDtG/dxLh4KSAwseril1pRaItsvvCiAoPjAn5opbCrbktL4o13HMtp4Df+Y6ZmBLOjSEwlikIyane5SCKYrGFLOJyP1SVjR0f+xNjWTSDaYlQADp2pXzfTB3/iMK08+JfrS65ePq1mmRtzkYZaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeLDTqdI5/oFSGwFAeyojvyf/Ks/ONn12bXtmr825A0=;
 b=PwMn9beGmzicW7FW6RnlqYULCqYD/uADIvxF40uRF1sbMUJjVp1alGIPf6SdfFYFpYc4uEmcyOFzcFj+aSFwVAG22RDSsnLckMge5JhA0cH0kIsoWW4ZyvF0ChvJteckjBm7Z3U/cemTUs2+ZjocmL7EO/62FUzXNuUVnv9io3YKmLCAabtLf9cmOzniiU5DsO3xWx7jcm0TPdu3iRT/mdLScFJ2b+ti8G+vuHk3CNLDF2eWMlmEOGEuwcQW08/zO6AR5botNaHyk1O3/ohTUwh6LGwXLLMN3u9y9RwkdKHBMIayRrPbNEbI+cYEMwBsbqax2UGjhAji51KXB0dMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 BN7PR11MB2804.namprd11.prod.outlook.com (2603:10b6:406:ac::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Tue, 6 Sep 2022 14:01:57 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::b04c:807c:4ea0:c62e]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::b04c:807c:4ea0:c62e%9]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 14:01:57 +0000
From:   =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Simon Ser <contact@emersion.fr>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH v3 2/4] drm: Introduce skip_legacy_minors modparam
Date:   Tue, 6 Sep 2022 16:01:15 +0200
Message-ID: <20220906140117.409852-3-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906140117.409852-1-michal.winiarski@intel.com>
References: <20220906140117.409852-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::9) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2084f58-b029-4d6c-7988-08da90105c96
X-MS-TrafficTypeDiagnostic: BN7PR11MB2804:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /WkEhu68+WocDBBdgjd5JeWm072A6Ax0IRlp3c4OtbQxY4/M4FUj47YhpzVXH4L30DwwDuecAGh7FKqH9TQ5WWf02HY/mIiX6EaL1sntXTeNZVHICPiQVIz+NTPDbh6OmrFEGhjwzlnrClcCUY8kob3lThouHVo+ijpL9dnUzIG6o3hr1PZwrWMn2wzH7ksiCQ7JynFJ9lNbMQ9HRLlsV67wkKrQdRPYOkpjuwAo+o1BJJVtPpVuhahvDDueBRxd+cjwkCorNV7QfK5maeppwrYXuquRSJf176Vkv93vLUj67EdBkAa8ie8qaEyKrPJUg+SFYSGIVZjkOdyDSGC9cZjM/jn2OYW02Seb9eeYfZ1qe8eWGj31Tum1v95PyVehFySiyI1XMB9JF2kGOZgQpaeBqO7RR5A3Xe65EM+blL1yBlVyiu4fCae4d9Ailtg/awRV24EyyfAiqrujC3P6c+xGTXfQgJV+H7aq7SIxhr3wAgH6K12QTods7pxEuyfcpIiXDCSQtwYEWHfEROmvv6lEEtV3Cp3ZN22ZYEpnoyK8TJKazBYIMjc1s5UTmr/l15roequhDeJNinyai1G0nsZoA+NPXWShV9FECdRnsa48ukoa8DQHelEAVqDHoCrVoQ1wbUhxMVj/2gcFxTUq3ZpxF1HY6gKyXTfSe11tXXOVVEzdVn9/puhrElrE/+WkCd7ffht2g+kYbnRUjNgejg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(346002)(366004)(136003)(8676002)(6486002)(66476007)(83380400001)(66946007)(66556008)(4326008)(478600001)(6506007)(6666004)(26005)(2906002)(6512007)(5660300002)(8936002)(186003)(1076003)(86362001)(2616005)(41300700001)(36756003)(316002)(82960400001)(38100700002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDBSVnBVTWVVSXVqMEdvV2ZRU3A1ZUJGUFFJKzNxdmN3SzZtcUZYaUV5cXZq?=
 =?utf-8?B?Uk9qaW9jbmMyZHZtRGJ3NmU5L0xLVW4wTVNVSjFLMk12VFRlL1FvaW5qbW52?=
 =?utf-8?B?TnU3dlVBQ1JqRFl5YVhNTmJWUkRWZWNEdlBKSXJDTGVVa1FIVmZ5T0NXLzNl?=
 =?utf-8?B?UEhRMlc0WXFYOER6dGRUbm9MYmI4NngvV2I4dUVzUWhTY295cFVRNFQ1VTB6?=
 =?utf-8?B?dnlvc1V1dE1DUjgyNzRFZFNoYllCRmppUCtXc2pJTjhIRGNqd1V2bTQ4aHBZ?=
 =?utf-8?B?SGw2clVtNXh3bTZFK2JoQVdNeExiS2YxVnFCSS9JOUtCdENZWTBTaUZxV1Bt?=
 =?utf-8?B?S1hHMDdZOVFRWGVYaHo3ZXhlSmMzR3VxcG1mbFkzd0xjOGxDY3duZVAvRHAv?=
 =?utf-8?B?NDJ4TWNJenVJNmFvaHJ3VHZKMWE5S2taZVJsYVlXNFl3WUVMUVBpM1oyMEFW?=
 =?utf-8?B?dlFCTk9mdEQ2V09YaUs4dlo0THJBcGJEWXVoZS9Wc3R0NVRveDBCNzNVVm9S?=
 =?utf-8?B?N0pNOXRpdEZtNXAyRWpzQ1lWb2lzVHdUQ1NVdHh1UE1oVGZUVWVac1ZvMXBT?=
 =?utf-8?B?SVN0eVZVVmQ3ME45ZmVWdUZvZFNVaktOT3FwYmlkcEg4eW0yYXRkYXZ5M09K?=
 =?utf-8?B?Q3NYOTNmNnNEcHAydXRlQmlNS2gzT0ZBUHc1a3ppV0MvWnlzZ1lFVmovODU5?=
 =?utf-8?B?RkxzVy82VkRXZDBTZWEwblEyUDhDUnBjTDVGZlFtSDRUWUtFQ2NKQzhjZHFU?=
 =?utf-8?B?MDAzMDgyNnNDR05mN1ZoanlFcVVJSlNYOTZxSkRTM0gyR2RXSUtWcUpEYVUv?=
 =?utf-8?B?WGtySTJtT0tIY0o3bHhkMVdiREowWmNua1hFcWVScStVbXR2S2d5Z1I5RVFn?=
 =?utf-8?B?ZGVLZVB0UElqS3pObHZTL0NLZmljak5NeVhFRUJyZGhjVVduKzhjbDUxNmp2?=
 =?utf-8?B?WnQ4NEZMZm81ZGJpT1FhOVk3djJEY2dQbDgvdXdwSE1ocWxwUGJVT3VYWGk1?=
 =?utf-8?B?WE5FaEVKVGZ2SmRtaHNyaWpoa2tZTE1VTlVETEVrR011WXZzRUkvdEV5b01r?=
 =?utf-8?B?VGkxRXNOYnVGUDRPQXQwOEJPUmcxYmd4cmtkaEdqVGUzVFZCUW85d1lPOVVE?=
 =?utf-8?B?WTk1OUExZkRlTFZtY3Q4NE84UlRlU0NsRjJiNDFYOWw2STRwQmFpQjd3Q1A2?=
 =?utf-8?B?YWhRbzZULytWenNOaDI0a2lXdVp4MUE5OFIvVGtac3NpTG1rRmNWN3ZQS0NV?=
 =?utf-8?B?UW9mTFVKYUx6TUlSVnhLNVlZTW1sckJ4dUNRN2tvMlpjSVJpV2hGWW5Pdy85?=
 =?utf-8?B?dFNZc0RBSlNiUDVSd2FoTHkrYnlnTnhQdGhJUXVkK3BicVNpZnJ4c3U4NDNv?=
 =?utf-8?B?M1RoMFVKQ2pobWowTDhqM3lIc2FzUlZNTklJN05MODlVNGlaZVIvUzYwSXp5?=
 =?utf-8?B?S3pmY2hGdWNBSC9BcjZsdHV3L1FuaDh0UXMvcVZCV0hYakRrRzcyUzVkNHk0?=
 =?utf-8?B?VXpweCs1SVBTUkxaYlQvSSt4ZXFhcEZ6Y1p4R3VScFVBTEhLU21VU2s0S1R1?=
 =?utf-8?B?L0c1RzlyR3Rtc05kLzNnN3FkK1JCODNTemk1eWtxU3ZDdVNJQnJ6YVJmcTND?=
 =?utf-8?B?dTc1eXpEcXB5d25JL0U3bVYrZ2tNcVVTZlBGY3k3SzJkcWhPWUxjVjZPOFZy?=
 =?utf-8?B?K2V3WnRlendMM2xJaTJ2TzZldm02TkJxRXVncUh4Ulp5MkJGb0t3ZzF5UXYw?=
 =?utf-8?B?VVdkQ3g4T2FjaW4yRFlYZ0I1d1RvOVF5czhVV2NJdHlZaXR6Z0ltd0UrMFdL?=
 =?utf-8?B?c1kvUm12aDRRVlFOejlKL0o0MmZ5UThic0FFTThVZW1LK1g0aGV4QkxaZnE2?=
 =?utf-8?B?MFpNb0tCbUY2b0pkZzRVb3V2eUZFeVJWQ01GUDhxRnkwaW1GNStnZ3NJQUdU?=
 =?utf-8?B?Q3RIQ1dnL25PMHZFMHNWdU5WcFJkZ1ZMekJiR3dLR281QjZZZmNoTGNQY1Jy?=
 =?utf-8?B?UW1XMndBdW9YMGxMNHlVT0x0RWdCRHVxVUZLQmdTV0YwalNyZG8ydnRZL3FN?=
 =?utf-8?B?bXJKRXgreTh1VVBrZXkxVTRtTlJLaDc1VVZnS0Q5MWxXMDhyQ2cxdTNSNzVl?=
 =?utf-8?B?N3VuVVNtOFNwQmV2cXhXdG5Od2VKWnQ3Wi8vMjhSZk1oVkhPNGNBUDNhZGM4?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2084f58-b029-4d6c-7988-08da90105c96
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 14:01:57.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rRQFCx0kJOb4EH1DTcRSoAURwpAtGrE2Ejmz9nPHBmtMa5MZ51d55+n/V3hF2QCE+U56oK89bL+x9iUn8B5bwClrM1J4Dsfwpu0UVACFw4=
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

While there is support for >64 DRM devices on kernel side, existing
userspace may still have some hardcoded assumptions and it's possible
that it will require changes to be able to use more than 64 devices.
Add a modparam to simplify testing and development of >64 devices
support on userspace side by allocating minors from the >=192 range
(without the need of having >64 physical devices connected).

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/gpu/drm/drm_drv.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 9432b1619602..0bdcca0db611 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -56,6 +56,11 @@ MODULE_LICENSE("GPL and additional rights");
 static DEFINE_SPINLOCK(drm_minor_lock);
 static struct idr drm_minors_idr;
 
+static bool skip_legacy_minors;
+module_param_unsafe(skip_legacy_minors, bool, 0400);
+MODULE_PARM_DESC(skip_legacy_minors,
+		 "Don't allocate minors in 0-192 range. This can be used for testing userspace support for >64 drm devices (default: false)");
+
 /*
  * If the drm core fails to init for whatever reason,
  * we should prevent any drivers from registering with it.
@@ -113,7 +118,7 @@ static int drm_minor_alloc(struct drm_device *dev, unsigned int type)
 {
 	struct drm_minor *minor;
 	unsigned long flags;
-	int r;
+	int r = -ENOSPC;
 
 	minor = drmm_kzalloc(dev, sizeof(*minor), GFP_KERNEL);
 	if (!minor)
@@ -130,11 +135,12 @@ static int drm_minor_alloc(struct drm_device *dev, unsigned int type)
 	 */
 	idr_preload(GFP_KERNEL);
 	spin_lock_irqsave(&drm_minor_lock, flags);
-	r = idr_alloc(&drm_minors_idr,
-		      NULL,
-		      64 * type,
-		      64 * (type + 1),
-		      GFP_NOWAIT);
+	if (!skip_legacy_minors)
+		r = idr_alloc(&drm_minors_idr,
+			      NULL,
+			      64 * type,
+			      64 * (type + 1),
+			      GFP_NOWAIT);
 	if (r == -ENOSPC)
 		r = idr_alloc(&drm_minors_idr, NULL, 192, 1 << MINORBITS, GFP_NOWAIT);
 	spin_unlock_irqrestore(&drm_minor_lock, flags);
-- 
2.37.3

