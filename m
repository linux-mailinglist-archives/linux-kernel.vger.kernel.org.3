Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DA349F453
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346775AbiA1H2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:28:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:41758 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232543AbiA1H2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643354928; x=1674890928;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jV/xmiOv/97xSDXg797BftZXL9hSBnuOgpkqOTwjI4Y=;
  b=OYsnHsdkAO3RpVDuaZz2vmN+4BFLywnTN+A2ZhiQv5nbryU4PNB/rTXk
   eOuPQJfr053cd5ntTFx2zPxuCXCr4O+zI6fGK+pp0sc55eQ3tosm8f1fA
   jkWtFKwgoBSF2jpdVt30DGh8wtmVW11QH+/9sgfnYnq9npimblXtzx5pW
   C1+wuPasaMGbSjPpTWdIM6n57gHiPlJkyzdwxn8n4nBZfY1ciQ4w4CHhp
   4c3icu01RXsAxiPpZ2KVppNdor+1YeRNrgJh/JP4/IwPysFFJhzKjNNu0
   uYW4Mjlg1lGZ1Jhr/oDvo1yobhEWOfE6xkyzP+YI66IXnX4X/jjOpLvsr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227045501"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="227045501"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="480644845"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2022 23:28:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 27 Jan 2022 23:28:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 27 Jan 2022 23:28:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 27 Jan 2022 23:28:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jX8q0tq8WHTQdhJ9UpDNBi8WLnR4UDHh2JurZf5VIIn4SXpS3BbKeJtw9oi8C/qXFwVjHZS4caNhvuIr32StEr/y4WZpz82+cPE0PfiuOQr8u+hB5nL/Ps5r5Qv0v/c6V3zYgPePikL1DJNqgGs3UPjQO9YGrseJCpuh+BgrWoFlROQyESrdOkzOgcyEBAwh6/NcMSbHKgrgqrolqmvk9MuAeEI1ixAIKbGiDW9yp1w0yDJgv1mIiAIXTV3B4M58ILBhUMMTXLoqTGsCQbHhoCLA5YgkqhIs1z964Jw12oiXldASpVbiz3L3tOPLK/4s5HQNx0qFEUwmwlgxZM9LoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkqB+XQuvLLZgo0JyBecQ+7ASesxR9CkSAmse0NYOb0=;
 b=YU/wzcMCe5faGoWr472+29ZCrpXM5LyZXacn571yFSiX/1WbnsdwnjzFQztAwlF1pe4KFB3rCm64Xp64fG2wKmoz1aL8ZqG86CXhYDn7+Yz2aWEprF3sg7qO839EnLkeb9vPwUo/Id103BSewjvyEO64CXZ9HPRd0VAbtoN2GsgROrvAi/pwkuUUjQzHmMczPfa777UY+6JaLL1+oQY6Qz2KcEybGtOnJ/4kL/T+HOMwOIN0EB8mDxmogr3el95ol4W8Z/AQ0a05JgR297Uu+o8K1oFK6w/mXPAFc5WfiZ2Z8VtINSPzX6djDNG+rbj7hFFv22NWsR4zQa1K5daKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by DM5PR1101MB2139.namprd11.prod.outlook.com (2603:10b6:4:56::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 28 Jan
 2022 07:28:34 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%6]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 07:28:34 +0000
Message-ID: <f4d8a648-11c6-aec5-41db-e10c4282f2c0@intel.com>
Date:   Fri, 28 Jan 2022 15:28:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:775:30: warning: Same value in
 both branches of ternary operator. [duplicateValueTernary]
References: <202201281431.O4oatgJN-lkp@intel.com>
Content-Language: en-US
To:     Zack Rusin <zackr@vmware.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Roland Scheidegger <sroland@vmware.com>,
        Martin Krastev <krastevm@vmware.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202201281431.O4oatgJN-lkp@intel.com>
X-Forwarded-Message-Id: <202201281431.O4oatgJN-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 245ea11b-90a0-4a9b-41b3-08d9e22fca7b
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2139:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1101MB213971D686A2FCA6A8BF27FEFB229@DM5PR1101MB2139.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:183;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAS3BxDwC8WoOGZ6rXkM70dogUSNFDiht5RFwNJ30Gm+9Nf+PcDfHluYJpretjROVdlxPXeQGABS4A8sElfwZCNygSqhr3zcMkzFdwcsBgIzopwIL4UiN0flERVTg5Zy3GRmnFaZzxzA2Ik8D0BV4r8IEmMIqC138jct6LFfr2nxj6gX0oCep57lcBMVryPcPWOTuFopOTGMw4WkChygGwdJgvRSW7OQcyRacLWN8fyekNbuYgSZq8I9j+yjQVPTPZddV3R4upYHgFTRDScgE+aBjn2KzbYsuWK+PoV1sJSYbMwCvengiR355MROA5DLAk4pqs/NN9+CiFZ0nNoC1iTuAkoNLcev+5/leD2SieIf/g4sqDiIA2TaKq2tQX7oeHQUYycsXAZI6mrOIY1zU8CXFkWA/L00twfzI69mIvtAHXpfHFzcF1eL+5Nni3P0MEL7kKBKJEEQLey+6Tk1qSh/fgP2V18/hUSGNpPaTY9SNxGcyFYiUz2kakb+CKieFhTO87tQoXJsQB4/q8/K/YG3EMLViprlC/DoXk153ln5bIkwEFf4hvrlm34DqbgVRWw1qBwKsCE/VHc4AF6WA2/hYPSJUXG5UiIWfnyzZltGMmTgh4x/0dxv185XyPPMHFdBgPVsdbJBUxiMltFC3v3rc+SYYuKjjIETRtfdHvp7svWLeYeBoMDN4SX8jY7uVIlkuQanrIJ+gJ4CTdSgmPM75f2HqB45FDc2c/+p+prBYOmyTWgF0Yx46z+dTco1rzq+y+t+RYW0R9J5bP4Bpvf5/R35a9KjMWZFnfWG8F6OXk8jGrHb1GM2w1qoHC6QDraDBGvxY0AUVknJNwe8aUw4EpDT5EcDdd0fGEwxvL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(36756003)(6666004)(6486002)(82960400001)(83380400001)(6506007)(54906003)(31686004)(316002)(966005)(508600001)(5660300002)(38100700002)(66946007)(8676002)(31696002)(66556008)(2616005)(6512007)(66476007)(4326008)(86362001)(8936002)(2906002)(6916009)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RXYmZRZGZheUVlVXJNZXRGT2hXWTZseHNyNU5GamxOYTJjTlVyR1lCR3k4?=
 =?utf-8?B?Q3JOSXFXM0xNaGtZSHFlck5nYmtiSHJHSE1vcFZCL3Zyb0p6UXpoQmMzYWdp?=
 =?utf-8?B?Z1ZOTkRXMFhtUDUzTXZiSzlBVFVUT2JaM0lvYlVJbDlsM0lWeHRmQ0w5Z0lG?=
 =?utf-8?B?d2xaTkgrUThSOHZ3VDBDMDJPZ2NvRFBIUWlrTGV2bFUydzg5dm1nUzBJcWlk?=
 =?utf-8?B?cTdIWVNwQ0lzZ3lXRERXV0xCaTJsMXBXY3RnRkRMMkdZMkRmSDFTZTZqUEE5?=
 =?utf-8?B?K21lSkRQVU9lNU9RWVdxL1FTa3lKL0dub093QXlacll3cmVhSGREVXlqdWJk?=
 =?utf-8?B?SEI3YkM0ZkNrMGR1V1VPK3kxNmF4cGthRXExalVCMGFKTml3bGR3ZDZWZmUr?=
 =?utf-8?B?S0tDSEJnejZuSEtMNzMxZGVsQ2xxVm83NHh4bWVSSDlpbDBmdHl5T3BsV2FD?=
 =?utf-8?B?alV0WENhMWlNYlcyZ1M4UEsxUTgxa1F1OXFFazJvVGU4RlV0bTlFT1FoWGlp?=
 =?utf-8?B?M1JtU0tFOUdCSUIvTXpDbkdvUmdrOXlORTVmaE9mbEY2aDJaMXRvRzBoRXF5?=
 =?utf-8?B?enhkcXNicHBPMExmOE5kbEhRNXYrK05oc0VWNisvOVAyRnNORWlOY3lIZ2lE?=
 =?utf-8?B?bkhyNktyVzFCNXU4ODc5SkJyZ3JQUXE3T0JNN0VGMGRPblBjUjk2M0t3aE9D?=
 =?utf-8?B?QW8zbkZ3dnhzcGtTaW0xZlJPekFUcUt3ZStiMGIxR244OVkxWGZyam1WdTJM?=
 =?utf-8?B?UUkvU1lKTGg1SDlYQ0xZTHNKbngrRkQ2YXJCaTZMYUxTR2pzL0FLbzRaQkJW?=
 =?utf-8?B?TUZkcitYV2xDTnJ0R3JnUW9HUDJNQjZhR25ORmRWeWQwYkZER2RLdzV0REZD?=
 =?utf-8?B?S0pjK0V0MEJtL0wyMEF5SDdXYlFMV2xabllDRk93MTRXenV2MVBjTlc1VllZ?=
 =?utf-8?B?MVBUS2xjRm8wQWNabm90cTBkUHpQbThVUHYzalE5MjBHRGN3cFNSVVd6YW5J?=
 =?utf-8?B?M3N1R2x3NjFidE9ZWTgyTjEzakZSK01xcGR4bm1kSXphN2NvaDdTRmhrTUdi?=
 =?utf-8?B?bzViT3VXanFGZUZCOEYyU0x3WVl6bFJtUHlvVVJEQlAyOCtpZmpxZmxpKzA5?=
 =?utf-8?B?YTlVZ1ZlZGxBWTVPUHZWdlcrdEVHMUFZR0V5elY5Qy92cjhCWHVNVXBrUldv?=
 =?utf-8?B?eVZkYURzcE5iQ0lMNjNFWG10ZXYrY2syQW1Lc3ZRUmRNc0x5NHNzSjgrYVVz?=
 =?utf-8?B?TUhSMVd5cXk4LzYrMTh5ZW9yaGRtT3M0aWNLSTBPdUFPY2pXUnlTaWl3WW1G?=
 =?utf-8?B?VjV2SHNEOWhQUXFBWllyclZmV3FtS3RXYjU4dGUyTW9QUVZjM0FlUjl1MEpC?=
 =?utf-8?B?Q0lDRldQTnNMTS84RmhubnlLNEU2OWI3YzJ3VnN4T1ZrU0cyOHZWZ3dXWU5G?=
 =?utf-8?B?aTJSUm1CVGF0blkzKy9KejUwcGZVUXJTMWQ4cndEZElsTlFTNzZ6OEVUL0Jt?=
 =?utf-8?B?blNHOFlRclZVVkw0dE1sMnVCSDFHc1pReG9IK2w1ak0rR3NDdFZtSzlLUS9P?=
 =?utf-8?B?U083czZtVkZoNEtpakVXdk9nMlVweTJaYys0NERHUzl0Szd1OEpVMWpjb1Fj?=
 =?utf-8?B?dFVIOXIwK1hzeVhnNDJ0Uml1bnU3WFZhYlUreEFMTjE0T2Y0VUxGdC9kWXhO?=
 =?utf-8?B?czJJN1F2UEN3M1lDQTIrcldBUEFHWFhjenh4NUJOSFJNYU9qRDBNTzlucDlt?=
 =?utf-8?B?aTU3cFRySUwxUGhuL1hKK2lOK2NlS1JhY21nRktTWGl6NEtTSXdUck1xbzhu?=
 =?utf-8?B?V1JudnBhS2thL2xNbXFXTktHTmRTMitMdUdrQ2hnSjMxZU10RFBObjlYaklK?=
 =?utf-8?B?VVl6N1NXNWd4d0g0aFZLcTRsdlpHQ2doN0IyclBXZlliTU9lZDljb3dVUHZK?=
 =?utf-8?B?TDYrRFVXVFhWc0wxd212OVNrU2JSL2ZMd3J6eVVEU05uSlByVnVuSGR0dC9w?=
 =?utf-8?B?bXBOV1N1RUV0Z21sQ0JmTWdLajBHUlhrcEdYMlNtZGJzKzNYdWtjN1Q3L0Fh?=
 =?utf-8?B?TzI5aHlJSDh5UjE5MW1RN2ZKSUg5MFJFY3VJaUNpMUZCWmpDa2NMV0NQUjE3?=
 =?utf-8?B?L0pnK1lYeXVlVFV5WmF5c3BGOWZEOEhlRUZHMTN4cW93R1hONTFmRENJZWdW?=
 =?utf-8?Q?hQ0d8ZI2Ryg3tl5bRmBmEPM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 245ea11b-90a0-4a9b-41b3-08d9e22fca7b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 07:28:34.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SKUwwDDqKAHSFrcSL2d9bt9YnhO0vajmGFh3RrTJb73Ynj2fQn99N/tiEEtCYdIBcN31/YwIUV3qIXuRxhm9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2139
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23a46422c56144939c091c76cf389aa863ce9c18
commit: 4fb9326b96cbf9f751086969161a6c1d75bcd8f9 drm/vmwgfx: support 64 UAVs
date:   7 weeks ago
compiler: aarch64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not be real problems)

 >> drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:775:30: warning: Same value in both branches of ternary operator. [duplicateValueTernary]
       SVGA3D_DX11_1_MAX_UAVIEWS : SVGA3D_MAX_UAVIEWS);
                                 ^

vim +775 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h

4fb9326b96cbf9 Zack Rusin 2021-12-06  770
4fb9326b96cbf9 Zack Rusin 2021-12-06  771
4fb9326b96cbf9 Zack Rusin 2021-12-06  772  static inline u32 vmw_max_num_uavs(struct vmw_private *dev_priv)
4fb9326b96cbf9 Zack Rusin 2021-12-06  773  {
4fb9326b96cbf9 Zack Rusin 2021-12-06  774  	return (has_gl43_context(dev_priv) ?
4fb9326b96cbf9 Zack Rusin 2021-12-06 @775  			SVGA3D_DX11_1_MAX_UAVIEWS : SVGA3D_MAX_UAVIEWS);
4fb9326b96cbf9 Zack Rusin 2021-12-06  776  }
4fb9326b96cbf9 Zack Rusin 2021-12-06  777

drivers/gpu/drm/vmwgfx/device_include/svga3d_limits.h:

#define SVGA3D_DX11_1_MAX_UAVIEWS 64
#define SVGA3D_MAX_UAVIEWS (SVGA3D_DX11_1_MAX_UAVIEWS)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
