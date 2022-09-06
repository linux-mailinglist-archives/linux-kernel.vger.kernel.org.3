Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239B05AEDFF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbiIFOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238565AbiIFOpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:45:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE7C31DCF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662473091; x=1694009091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MX00ssXpjtJYQ+spFhg74wUjSQVQbcT6XTXrrHchVl8=;
  b=ST2hjEcisXZGK8WTF6krWe1zfL7nkDNDEz2XY3TYpmeiFHihXFogaqpb
   fIeW7mYXb/JdKgf9mn7nXGE/tjO8rUtD8xiubCPg48VaianXx4wYUVzmU
   lend6Y+VRqa0Xzb9VJTiuX9KXeziml02tLF/GJCyfF2mZRlDiqYqzaBSd
   MF+pGC5HbLgf6BVUNI7KRlTQ+2B36QVxNH5KIv0oX0z12J8u/v8VL8i+T
   1mhT1m5upAm96oROgThUensL9yiguW3VoaMtyaugx8GebJdKmYVimVOj7
   Xu8gXkJfygnSZQkg0+7CUqbf0YgPCqA58cQn0iawQ1mlYv26W5YogX+w8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360548184"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="360548184"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="565103127"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 06 Sep 2022 07:03:40 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 07:02:38 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 07:02:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 07:02:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 07:02:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZv0dR1SCKpojHf1hKIeZP+6roxfyRGFJjSI+IIEDtBgr22OpNZE/Y9EYNATe9lUlv06a5lnHwRlHWa5/tN305r23KXyJHkiHl2O8wz/4VW6yyEDdTMy0q5ywdWEjuDJOjoIScMp6Mfl2UDTPsT4EyI2/mOk4BLMBGblXE0DE5z33jNEjtcMXgyRhYNoltVBWADn5MVReJES+Z7FaySfbdMMP0z3Nuelzg1kwD3c1JoKfx5QGY3DgYXuUTHIyfkIiwbuOp/g3JLkbMKZv5ls+heVVPFNfV1ZmJXyqtzPeTxE8fljElEmoA92I5CIJAYjzvHgcMhDdFCNFZeNPM1nYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntgjhyZkcPlUOgVX+RHpm2ndX81emlXdtqwkMjmHFDc=;
 b=HcMIJ8cIU9nMrNfLIgVKREvFA/dIZbg7izF6aDRPpN3B+1rFNwsGA+/7ezbql+LWTW3veCs62Aefhj4fl5a0oyO+Qyi9nHvGIvolr78fpyL6u6KcUC5N8WKlQnwX3dMlDVxMiZkLbbRDGqXSgzjoVLCLK9xnbnL+snFk+F7XCW87VPI/AjjLHrDqP05BAwWOSoWBTd7NGWjyoddk/w8JpuUGO577zDjP+UBrCcjC20ySOjniJSivoAy/T8TDR2CSKZNJ0YhWRQlgPo6Gnz0SSMrpmkLx7l6dRiSPLDOaoR98zthWS92Drk/BVMUqbNjdPgCMDy87m5VASI6rjRalvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 BN7PR11MB2804.namprd11.prod.outlook.com (2603:10b6:406:ac::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Tue, 6 Sep 2022 14:02:06 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::b04c:807c:4ea0:c62e]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::b04c:807c:4ea0:c62e%9]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 14:02:06 +0000
From:   =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Simon Ser <contact@emersion.fr>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH v3 4/4] idr: Add might_alloc() annotation
Date:   Tue, 6 Sep 2022 16:01:17 +0200
Message-ID: <20220906140117.409852-5-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906140117.409852-1-michal.winiarski@intel.com>
References: <20220906140117.409852-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25b75f90-7b2a-4e6a-b4af-08da9010620d
X-MS-TrafficTypeDiagnostic: BN7PR11MB2804:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwniUQfwOQ9yshVepnUR0FxkXN+BxV8FfoF/t1+3G9CZ1+Zcv9w+7a3tgy7RSFcgTSFA8XqMaRpv5BLAdzpao1bjHcwPZOAiOo8cwEGEjy0JaI0y1n30IdPd827YSM9az1yOWaOh1R+4oSVWXLkTpOgHL8xd55da9ujOvKy/jx07qQtYXxrIfcGQZ1Z8lT7g7Nuj6QtnPDASVXVkfMsA88Qa5KU4OIJKvVoacWAUBrUZdsJX84S57v9B4St1wwC6stIfPxnREKMR6Peyg88dSAymma2HWngdI2T3mxhkZ/n1WiJanszXcBR7QP5CJTlCqmrSJiLmK7squoXc9BR+b+iEYVCBLPdhfT9SAmMUNIUEoCGVsPW+q65Oox30t6rQY7sllFUEU4Wc/J2vrap7xZSY5BY9KGq6r6uIazKw83uuiITW1tCSqf/EwGiGV3sEqiwqcpUembs/cxN+Zso6FDg2FD94Uln+NemDHGHOYSiw/QDfc/otUppjvJbTUDRleCaFgjrIybhuwBk38QfbGUIs1ePTkkXZ5LBMYLvtlZvWDXjyzSLzBazgouH12jsyzul2JhXhYB0mPLQZu7kxK/3i5vPSd5M+INfEpVSfRhGfmardRWtgmKxoHCZKogm6reXL3GAQ/AAhUDgf5kyTpyaY+t7LSp+JwJrxlEColobluaC+sZTCUkzzMMpHy9HpxoRBrGbaRH6SKPy/TmKq8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(346002)(366004)(136003)(4744005)(8676002)(6486002)(66476007)(83380400001)(66946007)(66556008)(4326008)(478600001)(6506007)(6666004)(26005)(2906002)(6512007)(5660300002)(8936002)(186003)(1076003)(86362001)(2616005)(41300700001)(36756003)(316002)(82960400001)(38100700002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVJsY1M3TkNQUXRyejVzSHR5SjlCOVZlM2E2aTlYbTV3eDF0MTJ1K2VlR2xp?=
 =?utf-8?B?VGcvUm10Z2JoYlhMMzZHZXFNVGVFUFBWRkVLbm1QK0NnTnZjQkR6U3p1d2I1?=
 =?utf-8?B?a1Yyc3BSUjdpSTRVWllwc0hGRDUwNC9odnhvTVppUU1sMDdPUnJkdXlUMVNS?=
 =?utf-8?B?OWZPNTY1dWpKTzFUdkQxSzc1RXcySmVLZG94WWMwaUxUUUpOcXpJVnBrNHkr?=
 =?utf-8?B?VTE1RVlRRnZzSitpd1RnNHZLNFpMOFpGOVo0YitiUFJPWXhMeG1lbXlISnB2?=
 =?utf-8?B?ZFhaN0JTeDMwV3B5K09KZUxDY212VGRVUUNSV0lLNGZ2ck1UZ2pSaVNXWFJr?=
 =?utf-8?B?TExiTXcxMTlXaGNHNmIzMzBrejlrSjdMVE1DMlZSOXNEYVNBcklmK0doeUg3?=
 =?utf-8?B?aURQOE1WL2ExM0NGUkVzcWVVSHJqZk1MWFdrV1NGek5NRG16WWc4NmFmL2Fj?=
 =?utf-8?B?QU11R0JRWWZsZDhsTHJTdUFOdncwRExxUFRVVkNGNVRUMm9KN3A4Qkd6SzBz?=
 =?utf-8?B?aEZpZm9tVnZobEdEWnhqeDFmSVdKU2RobDlVY2tqRGxVelJuMFl5Q0RYQ3JO?=
 =?utf-8?B?ZWsrcVYvc0lXZkd3Tms2WnZ1cTlqc2JRK3ZxMkFuVVNWclpyM0daVHZmajlH?=
 =?utf-8?B?RGtmZEdEQ2dQZzQrNzZrbXlsWDZSUVpSbm1wWHJCUlpZZnJXUWFoNktJVlhQ?=
 =?utf-8?B?YVRKVlFja0l0enNlcEptbStRZitZYmlpVHpjajBxbUJIdUNaTUhHdlY3WUhh?=
 =?utf-8?B?cmw0V0w2VGpkekkzbFQ0aUxEa0dGMGJTUUNMNG0zOXRTbDRlSXc2VVI2OXQ5?=
 =?utf-8?B?V1pEa2hXUUdDRWp1SlVOY1E4dzRaMXM2bWJhMTBWdTBpdXJ0VlZ4bDBqNkVG?=
 =?utf-8?B?NklhVTFqL1M5OW9oRStqaHM1MzJxMXdvL0VZQVF2NzBEQVpjZGp2Q21MQ3JS?=
 =?utf-8?B?YVRJS0FZaEZvZHduc3JXRFl1WlBEdjZHSXYydkFoMCsxNU9MOS9Gell4UzdN?=
 =?utf-8?B?bmc3RlZLOFFLVlV5VEZEWENvUU1XOGdVY0xPLy9qMFRUc0xuS3FxOCtmaHdH?=
 =?utf-8?B?K1FhQmhHYnZUVXgyUEFsY21pV2RTNkQrV1E0VG5na3JrSzRPWGlkbVRJY1Ux?=
 =?utf-8?B?Uldqc3NGMVlZakV5SXJBTHFjV1k2N0IwcUR0di9rN1ZjRjJqNGs2em1LdjlD?=
 =?utf-8?B?OTE3dGRLZzhEMXRUUnFKQzg3UGs1MkNJeC9WeU9yTnZYRTRXaWxOUUxTb1M5?=
 =?utf-8?B?bmVSR244bkJqZWNLQjVhcmdRODk1Szlwd0lXOFlYcnZ2amxGTWFBWDNld2hU?=
 =?utf-8?B?TWhOZm5HNklCRkFsTTNFLzZKcEtCZko2eW1nblVEOUtiY2VscHg2ZnFxTjNH?=
 =?utf-8?B?K0RjSmdUbHEwNG9mS1NpK0xnZm05cEQ0Z0E0WTQwRnZ0b3hBN2t2OEJaeVEy?=
 =?utf-8?B?NCtOVHBWMnV6TFFNazhLb0duYkxVZ2IyNEMrQlFvaHpyZVY0NEVXcmpZUmJY?=
 =?utf-8?B?ZERZSnBQRVFLWGJYdHoyNmRTVUJoWFdSaFdVZUx1UGhjTWg3ZkpiMThnK0l6?=
 =?utf-8?B?QVU2SnZHeFVwazVjaGFyem1JblFjM0dsdFdVYUVVcmt3MEgyVlNQWXIvZWxJ?=
 =?utf-8?B?ZVc1UHh4bUEyZFpuZ0ZwcHhEU09aYWpkaHo1TGhMWll6SHF2ZnRXdk9CYW52?=
 =?utf-8?B?UkdKNGlONVJQRFZ6aW5LSlQvZDBKeURvSUJ2RjZQWk53WnpRSnpYVWEwQ1Zl?=
 =?utf-8?B?ajVFRlpsTVNqRWkvR1FHNVYxanQwajJkR2VSd2xKb3pHNUJQbWE0NHVDTHo3?=
 =?utf-8?B?dXFPMkFJeTJqUDVDL1UvcVFrbnZqdFJvOVhEU3BubXBSejQvNWdJVWhhQWwr?=
 =?utf-8?B?SDk5eFNzc1dWdE5zMWNOQ2RXTXMzL1NEeTQzNmhNMFU0eHVwQVI5MUUxVnN5?=
 =?utf-8?B?dkQvTzgvTHptK2ZRaWJIVUxVWHZWVCtqS2JUSGVYUmM2UzQ1SWthMmxjWEJW?=
 =?utf-8?B?QnBXQmpKUEk2ZENEb01KVUxxTUdZY3cvQk1rL3U5YWg5MHkrRFYweUxRVk9q?=
 =?utf-8?B?bkpSQVhVMFg5cFpQMDN4QjJVS0s1T0pXR01xQndTSVlhSk9TU29oR3ZzcHpE?=
 =?utf-8?B?YjdSRUJheTlwZ3RvWm9MRytteGtEM093aEplUzk0QUJNY3JCakp2aTJUYXJh?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b75f90-7b2a-4e6a-b4af-08da9010620d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 14:02:06.6839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99ESf6xA4T4oAKjTb1Daz9R0taG5cSe0oUYiqfwremDf8IF+U29x00pTiOrvYBOQ0BW9Ec/3+ikrWJbDupwAB2ZDxwPcfFeI+6jkNmEF3Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2804
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using might_alloc() lets us catch problems in a deterministic manner,
even if we end up not allocating anything.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 lib/radix-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 3c78e1e8b2ad..787ab01001de 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -23,6 +23,7 @@
 #include <linux/preempt.h>		/* in_interrupt() */
 #include <linux/radix-tree.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/xarray.h>
@@ -1481,6 +1482,8 @@ void __rcu **idr_get_free(struct radix_tree_root *root,
 	unsigned long maxindex, start = iter->next_index;
 	unsigned int shift, offset = 0;
 
+	might_alloc(gfp);
+
  grow:
 	shift = radix_tree_load_root(root, &child, &maxindex);
 	if (!radix_tree_tagged(root, IDR_FREE))
-- 
2.37.3

