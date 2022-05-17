Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD86D529ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbiEQH3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiEQH3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:29:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C078043EFB
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652772568; x=1684308568;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2HzvOofAp68mITwbgnuHFHpyACsvlXEizRLvzGXgAOE=;
  b=Vxve2s1AjTOvPdZo/x1ZqP6RjS6BOjTJo4FO6Y3SMrZ4V6XdgpdS3mW+
   EJrfexojE25Fmvask3cmFw96U22v5DH2E3eIi+d1f76h7PsP0Frw9nOqS
   VpO7FZQPaaO+6lf2k6lVGQ4ICJ4aZ9Cw92nyd2k78//mqGGf22h3ApNWg
   2iYJVk3+ZMBZ9QqYvtFsUMqagSB2X2OpX0ThSIp53hON7MPcTLhE8Hgl3
   EHSnpdxlafZZXorRSvPI0xe0D0/LtqgCLVdDNBLJGdIGgo1nWJKKtBoRO
   4q0fwdt9+rnN+VCb8ll2ur0z7r+if2ap7A207xT9hURqXsyk+PVygleh8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="258659226"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="258659226"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 00:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="672726074"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 17 May 2022 00:29:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 00:29:27 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 00:29:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 00:29:26 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 00:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DakQO6fdpFfZU3jUifusTthsoQzGL2rh84lIT3n65tT9baR3hF6JGV8NE7N3EIJPruN9/ufHxOpEVYffd10h1m8dPk9vHh2dLNVYGDKkE4CbNunNYljF2O0eEw1OFlDsRdgHEar6ZfLV+eiT2zlR2GXiiN8w0vjVYi9hd8H/oX+TvB0hNll9jksDBFboGVBSIOvC5dca89VMtRVgI1cqFGHC25mBGmMQ/n6UR2bGO7rx/TsuWhTYaop7q8PNRLfsGej5I6VsRdx7YOGmNKXc2LaMgjk6Gz+kPUe2ITb+zva3EtPs6G7biBpmDLty6VevNsyiu5I6nrVx4Bp7rCmdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4a/9bdgK1/yPpptihO1mxw4xHKGh0r+wh0DwMjs2R4=;
 b=nvNSvthIYT3RAkee5+/+YC0/JAQ//ZTBvqcdxCU7gdJDXlJnDgjySahxy6IdlmqqMCIl0JIs+W9x9cp3E3oE1ISKOCx4WP9IkjuyYigbAjYdHfSjOl2YhrE04jMj8wAohtQiBtzJidybqnlPxfzqTPv6DPCAuaNE8h6TGp+3tW4WalHNa58JaGoSH9MWniNQ1xV6zPBN9n+07Va9pSLUJh/rZMkTcpHTlJ3Q6qWIfduQc05s62vY4sUJ1/YqylPcnr9gJGNl3x1WyhgVlWBxeqVVTJH+7PzudTL0d/roDSJY+wGYjQlpoZgIqpeZCZLflYlZVXt2SrH9g9KeBXvfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by CO1PR11MB4819.namprd11.prod.outlook.com (2603:10b6:303:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 07:29:25 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:29:25 +0000
Message-ID: <2b7ec8f1-af8f-5bab-3201-bbd65d013d7b@intel.com>
Date:   Tue, 17 May 2022 15:28:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: kismet: WARNING: unmet direct dependencies detected for
 RESET_TI_SYSCON when selected by SCSI_UFS_MEDIATEK
References: <202205170529.51HvFNLo-lkp@intel.com>
Content-Language: en-US
To:     Peter Wang <peter.wang@mediatek.com>
CC:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202205170529.51HvFNLo-lkp@intel.com>
X-Forwarded-Message-Id: <202205170529.51HvFNLo-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 481d1c29-7448-4021-c191-08da37d6f847
X-MS-TrafficTypeDiagnostic: CO1PR11MB4819:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CO1PR11MB4819D330B7E743074E6CAE58FBCE9@CO1PR11MB4819.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azZU14H36CNQpziSxryxKwUGzH3O/qn1t6aW41Krty1LwKNZUVGBqy1WwXgBQE73CIG0o41DMu+X4o7WqM68Vy9xiUlMTskMzpPsSWHC6GPQ2KTjTDHgbez7ZXNwIIRn0bfKUFDQApwsfEXmdSgBm0dAIos7KrgVH9yyebaTzEdAM9qOX1E/FkuP81g4N3NJuIfiWPZfrt6/W4xTEH0xtz0b2jCRljwBOmCq9ddaUnN67AMuw0iz/QXlJlVzSnCMjJo0dxDLfBGQx3eE5yvdS9AZluqetpGmhAxDscMcm887eyGX9ulnLR/kWQThAgOd+M/u1a6dXr/dv3yyjVDkHbIwiMmdjRi9D2n7onmHA6Zoj3leStpvyE5FTWJfxwzOBlbLgTmufSl9aqZo2R5weAWk1QAwh9ShdUwpTw9xStKRoZf99aJrWaWOT+I60ZpaD9tEgCiRvRhQmDxPRJMwk7JvsfpurXfFUTMTjZwsnl4iLom/8jNjUnmTifL5N1FJJZsup89YeKp7zuH66bOmdUti0azTHKzxD6dOXWHzuqp/DN77CG24p/pUOCzEoYZcLLjk2LPj2w1vJ9ObJyBRKUOVdUzPbPP8h/Q+hN52sQXRAka/mGS5RtDVzLrs4zfBTYNZADs+EgE7pnU7Q3JgVbaJn+5FbLsMrNbdjz8wYUd5xNZ94bcvyoaodqtmATtw7da8rHUhD33vNgLvj7fgGkv3dxv0p4XTfkx2ixiloQbkcO/OivRr97SuJ7F2Ra5Ek2eZm/0y1sPm52gaOtaagvqIDiyd8FZagE2cs/pYPQGAy5RZ/EbKu2bjLGCgT0Q+OlSX8vjpYVYnyC1vPg9gfNgpI2a86imY82DF6PHaD3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6506007)(26005)(6512007)(6486002)(54906003)(8936002)(31696002)(508600001)(66556008)(966005)(66476007)(4326008)(6666004)(66946007)(5660300002)(8676002)(38100700002)(83380400001)(186003)(2616005)(31686004)(82960400001)(36756003)(86362001)(316002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkFoc09GelpIWHRlWWoyZHdCSC84cDBJMm5ydmc0eWpRUlVjRGVDM2xVSVlh?=
 =?utf-8?B?TitVZDJpWmdnN3k3c3A5VVBSQ3FHcU1xU1lRQXFqa0VIU0lYV29uQlU4Vytr?=
 =?utf-8?B?dm0zL0cwZE13TGMvQldjZWxBUTJQNWlpZVQ1RUFqYnc4MTBvTVJsYVQxcksv?=
 =?utf-8?B?K2lFcnUxVjJSbmIyUkFTNEFkTGp6RE9YdGE4QmN4aFJ0aTRQb3dqU3NnTFE3?=
 =?utf-8?B?bnN5YU1rMjVqOW1nUmZ4OW82L3VZam16MjlpcEx6Qy9LSFNsbHRGM09MRWtv?=
 =?utf-8?B?UjVmaFIra1pEVDJ0NldFZWxpenRMTjFTZzRpNXVuU3NIOTN4bHlQQkdpbW1G?=
 =?utf-8?B?U3lXbUNESjE1REt0Z3l3eTNrT0ZXYjl5Tm0rS0NSb1Q1V01vZkx3VHFBS3pC?=
 =?utf-8?B?VnR6WHYvcW52ZHJlQkg0ak0wN2VRd3MyUnU1cktPVUR1WlVJb1JJUG5DWE1x?=
 =?utf-8?B?NGExUEVDNlZDUEZvMXVkelAzbmhOWG1ndm9vNTNtQ3RDVU1TL2pnR09zSzJW?=
 =?utf-8?B?UHhsR2tFaGg0TG5OdTc5enZvbFpmQkNURGVCNzhqVW1vVmhlTVFaUG1wME9s?=
 =?utf-8?B?RDkwb1hLSXlseXJVRVNZRHFsWmU4emtXcE1RbFc0dkVZU0YrZzBRNW9Ja1hJ?=
 =?utf-8?B?QUc1bk12Ym4vMEVkb2o0WldoSmE3MHBEVG0xb0w1NkdCVDJRNHhad2tscWxx?=
 =?utf-8?B?ZnFyaFdVUUUvSHE2dCtQNDdJN3dLUzFHU2RVL0NlQlQ5RHhPc3duSmFpVkpW?=
 =?utf-8?B?YXBEZFkyQmxQODU5Q01SWkE0bkJIOWxNay9XaXBiUDB0ZHVSeDJsMk5aL2tW?=
 =?utf-8?B?VVFHR1k0bHNJaWlzQ3RnY1JGR2JYZHdRRkZJSnpHMlh5MkhNOG4wYk42YVpS?=
 =?utf-8?B?TVlUaDRvdUl5UUNMQ3lubDBpU0RBTTZQOGQwamdqTVlIanNUTDFaS0Y3RTZT?=
 =?utf-8?B?YjYwS05rTWlZNElwV2lqNTdiS2tRVUZSai9iWTFxcXVrNEtXZ1RuZ21nRGRs?=
 =?utf-8?B?c3Z6VTJhaFBtSU15WU1hZTZQUy9rbCttMHVDNkhQODRvY282Lyt1R3pOSG5i?=
 =?utf-8?B?TGxLYjZTcXJhUHRLcFBqQzFtcUdWZVp0UHJRendtbGlDUzl5eWJOYkYvRm10?=
 =?utf-8?B?V3ZLQmJqK0dOenVxTDBPdHJMQng3dXA2cmFuaVlXaFMzOHNZZUxKM3l4RlNN?=
 =?utf-8?B?NWduZGJ5YVRDREhlOW4xdldQVmV5VEE0andEQVNXeWUyZ3B3L0pYZUhxanhW?=
 =?utf-8?B?Mi9VNHV5eU14Yk9hVFdEWmluZ09aY3JqVVczMFlGeFVwaCtLeUFoOXhMTjB4?=
 =?utf-8?B?aDBIcUVzVlRWeHpKQUtCY3pqVDFlTjdvQUw1ejl6cGUyMUhLVU1hOWtGTWFD?=
 =?utf-8?B?MDkxWUpBeUIyMGRRSStCNGg4MnZhZWJ5ZENWeHQyOGJ4eHY1MHdrRzZoWWJm?=
 =?utf-8?B?NWh5M25TcS9nRWZ1VkJQMXJXTENNaHZObXlEUUxWSGpXM0dpT0czQ2p1NzZB?=
 =?utf-8?B?eWk5My9Hei9adVlKRThVTFB6b0VrVGhJN2h4WlEwNHlPaFRRbE1FanpqMkVZ?=
 =?utf-8?B?WUVtQWNvNmdUaWh6ajJIZm9HeDJOU3FjUjdlZTFHMTNudEZvd2RQVXRkeDFj?=
 =?utf-8?B?bjVmRmdIMkpjOGI4SkppWlZza2orUlNURTA2VEQzUEowTFZuZVJZRmVVYTlE?=
 =?utf-8?B?clJ0U2VFWVk0TjN3SlJZR3pjMm1EYWRCUVg0TWJNOWN4dkhwSGxjeTNsVFVu?=
 =?utf-8?B?TE90SU4rczBqbTRjN0NxR2VYRUdtWjUzWXlQSXBvMGRkY1ZFU3F0Q0Y0aW9R?=
 =?utf-8?B?bWN2MDYvcHF2UFhqeXFlYVdjUGRReXZsdHEyVncrRzdUOHV6a1VmU3Y3WlBC?=
 =?utf-8?B?MWN6dmpWcC81RnBURDArU2ZKK0VLay9WeFRoY3pJTjNGbVFnNWFZSVZqMFJC?=
 =?utf-8?B?UUd6Qm9FUWNpcUxZVHRFU2FOaVcvSXFwaEJKZGFhTmIzdFV3L1FmajRMUFgy?=
 =?utf-8?B?UjJPN1NsNW5mOTU5c1pwYUZZd2N6ZnQ3TUIwcTFWanV6QnMwQ2pDWE1Mb1lQ?=
 =?utf-8?B?OU5KZzZJZnk4TXFvSStpcnU4aFo5VTc0Qm04OEZDbS80SGNpa2hzUTdTdGRm?=
 =?utf-8?B?U0pHemd3R0lxazRrZUNSWk5JRGtVek5neUliUERwV0RyZWh5N1hJZFdvclg0?=
 =?utf-8?B?QVhWWXc1QThGY1NHZDFLNm1pYUE1S0NJZkk3WGtmenpxYVpzcm03cWIyKzdz?=
 =?utf-8?B?NS9tbTkrdzNTM1NScFNwQ2o5Um9VcGM0SGo0c0piWnNYbHQzcGNIU3ZXSGh3?=
 =?utf-8?B?Rkh6NWlRN2xJVzBuaEgxSGJCZkpvRVNXM1VoZjIrdWVNaUZRTzhnVHZHTjZQ?=
 =?utf-8?Q?EGuSboJFiUrWSp+Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 481d1c29-7448-4021-c191-08da37d6f847
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:29:25.6983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoS0v9N1/h6zbuloiXnixYHqyU1tmeD4945f9yUnEzGytjY2S74uYbry7KGRlaV3HCQXkQpDoDRG+HldgMcPcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4819
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42226c989789d8da4af1de0c31070c96726d990c
commit: de48898d0cb6a3750558f35e14af799eafc3e6db scsi: ufs-mediatek: Create reset control device_link
date:   11 months ago
config: (https://download.01.org/0day-ci/archive/20220517/202205170529.51HvFNLo-lkp@intel.com/config)
reproduce:
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de48898d0cb6a3750558f35e14af799eafc3e6db
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout de48898d0cb6a3750558f35e14af799eafc3e6db
         # 1. reproduce by kismet
            # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
            kismet --linux-ksrc=linux --selectees CONFIG_RESET_TI_SYSCON --selectors CONFIG_SCSI_UFS_MEDIATEK -a=arm64
         # 2. reproduce by make
            # save the config file to linux source tree
            cd linux
            make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


kismet warnings: (new ones prefixed by >>)
 >> kismet: WARNING: unmet direct dependencies detected for RESET_TI_SYSCON when selected by SCSI_UFS_MEDIATEK

    WARNING: unmet direct dependencies detected for RESET_TI_SYSCON
      Depends on [n]: RESET_CONTROLLER [=n] && HAS_IOMEM [=y]
      Selected by [y]:
      - SCSI_UFS_MEDIATEK [=y] && SCSI_LOWLEVEL [=y] && SCSI [=y] && SCSI_UFSHCD_PLATFORM [=y] && ARCH_MEDIATEK [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
