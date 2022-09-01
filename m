Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6F05AA115
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiIAUyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiIAUyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:54:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1358998D21
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662065676; x=1693601676;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BdB9uPfuxXOZbQQRSBdMcBYKK0x8NbUCLrUlk6Tbwb4=;
  b=boJxEXWwiuEuEzlbcQclJrD+GmunmYeOhjxVKV6e/t52K6XNmf3EQi5d
   mYezmlT7qxWsU9LzCDLZtH9KvTZjOyjiRUl/TtIQcR/EWxIZYYGlDeOrm
   E9tCRbX9qWfLacGUx0sRFdj5xA8Y3gSgLJB1uuAWNSI6iz3bmV59zWSIV
   lNgIL6e/YKfaOsYYoZA5GMs3eweJm/dqeDap35v8ZhiLy0Fx/CyVvB4rA
   qV+NNdf3IiicpNyDIyO7YqOiu9V2UDS6Er511kjKOMHUzHV6Rl8oUE6V6
   BRKkaJcrMKgY2KvDmKT+dUjcnW97165mxBuIf5ek3kP2eOVNojVh+K6A4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="297109514"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="297109514"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="608688012"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 01 Sep 2022 13:54:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 13:54:35 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 13:54:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 13:54:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 13:54:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klciX2GoodWcLJh0bdC5pPHzxIKgy87Kdv/DrfVFR/ME+c9Z+zf7gZQvx6aDAuXwasUWCC/ITFKun7KocYRu705EhZu73uYtBbgjY1razHAzTn0hS5WxX4PkGHeU/V129nE7mULQML/cqPi/jPjM0BvPG/itYtdTPN9e1yWazUWF2gb94Tri5fIU+bRYSgr1UUp5i+qQphFXcQbxYJIzj9p2uSx6AHoA/PZCyvpLy72MVGS/n2+KMRQtq6Rs7IDMhmfA275+fKOuSgygYAwLj64hVEeMw90gjSw5aKQvf2KqeqD7/0gyHsf4bzjF7LHC58l4SJeOncboL4KFYV09eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2JmRf/+Norsv9YX6q4UcTVJHv8RK6a9vLiNEL2QdFk=;
 b=MlJh6JjKOUVgEWN5lMpbos5ErKQsYcd77iRpZilZV2DS85s5Mltx/ILnP2QFBqgwuKtRoJ5gyCDAHDU6kzuXRg6uf93K0GrUd68oqHfZKg48AzPnnps/eTHM8iw4Sr1SGZpwkQVX5R37ZIaOW8qemS3lFwaRZp92lU76CFbn17HgX/nwa34UU58vWQTkoQg8wOlML6bdhJld0WFJTR6S7z4kGnRJNTbfociqp8suJXcMOYZ40gPr4gUbXphe1gKlWEIvxZ3Vp380FVtNuJQlPGl4Ui9TxlvZ/E9Jx1077w2SvRWnlHoyV+65MpYf6BUSlNLXhPN43jVDh1cLEV0dFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 CO1PR11MB4899.namprd11.prod.outlook.com (2603:10b6:303:6e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 20:54:33 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 20:54:33 +0000
Message-ID: <502899ee-07a7-cebb-b730-7c5888de2ce9@intel.com>
Date:   Thu, 1 Sep 2022 13:54:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v7 09/15] mei: bus: export common mkhi
 definitions into a separate header
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <20220806122636.43068-10-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220806122636.43068-10-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::33) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3910f5e4-33b6-47d7-70e1-08da8c5c2c39
X-MS-TrafficTypeDiagnostic: CO1PR11MB4899:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xt21LdadPsCOvCcNVCyIvNIbc6uCP5UoxrquxVrUtpE8OADk6gXWUXF98Bhekzf9/F0U9psrqXIUWb856jiKUhXVJ0uulcQwrmgdbIj1dddZERjqvhqcK1NJ4hW1rm2vj00ynDG84iFhiCXLhSy+T+6r9PkqsxUjYVo+VqmGQWxbIBr+I/QBU++vhEj7sXDA180kFe4hzO97rlwT77Cm+lebHJ6V6KpF9/JYzeeNIGKy3Xxf4F9uxjScruCcjVjgW7W2P/0EFsFeK1RCTDWcf5kz5QYsTG4Vz2vOcRapSGD3lGKVaox7h/QWSK+dQUOlUYKca5ixZCHnA0fJFkk8FyTKkqMoqdv7Q31/9MR2WgbuU+pCwzGHWiLJ/tSVFAoqfbHywLQHY+azumlaEeak7GnYBBhbj1zZCt4CtoAdEcmIrkaDivI6v/DUmhbTETaSR+vU1++Db6uJDLpxzZE1dhP90YOQj8DRKhJp9fwbHYt5xm7E2vpN5CNZ2HCvc3WY+mEbdYZFPDSHJ+A1fh5s5kh1qFLdT5QQQC6BAK/qvE5iQbfV1MK/cNCrJrBFjnFidNRsPBIXcxyuPRYOAlXaICsCiwntHdbJYtA0S/4IHooIs7v5ZzvFjRCIfCrVWwd0oZSl80RlXJaWoHM9mjmPH6GeXsCzgOK7BG3K2vMwvcmQ1x1uyofCzu2FicDe5igubXghxvhvku8cSo/S2uG+MIXXZkxVjw1EUz3R46ZX0yPVAOAkIMxgPD18p4OrluEaur0sfdvZcZeDouCvECdzN35kaXwZB/SfUm6C6p6MrYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(39860400002)(346002)(31686004)(83380400001)(186003)(110136005)(54906003)(6486002)(316002)(6506007)(36756003)(8936002)(107886003)(6512007)(2906002)(53546011)(26005)(86362001)(38100700002)(31696002)(2616005)(66556008)(41300700001)(66476007)(478600001)(8676002)(66946007)(4326008)(5660300002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2RKRThQSmV6NGtxVStYWmd0a2hURFZlRFlxUDV0Q2h5ZG04R21PazUxNlBW?=
 =?utf-8?B?YXovSUFzb0hYaXI0TnVud2Jpd3lXeE5sWDkyT1paYklHVE5tbkRYMHQxc3d0?=
 =?utf-8?B?cHFDOXhFTlVPVHZwUnd6VFZ2ejA4MzZSWVd4QnorOXZKTXI4UlZ6K2Qxa0Qr?=
 =?utf-8?B?VzRkaS9CbForb0ZYTFhsT09nSnpSdnF4QjRvYk0wWGcwYlNDZEo3Qis0RnVY?=
 =?utf-8?B?eG84Q01pL3BobHloK2hUK290SVh3RW8yaGYxekx5aC9LRXNXOXhuR1ZpUTlW?=
 =?utf-8?B?Z2hSdUs2bU1HUmRWa1RFaTgrbEpOOUxHUHBaZUo0YWl1SmxOUGxmdzk3eSt2?=
 =?utf-8?B?K1BQTmk0N2RnTU1Nb3BxTXlMZTA5Q0JqSlNMTmtVUzkrVVkzdzg2S0JqQXFP?=
 =?utf-8?B?cGdMVXh2b2szQVBaYVMrUmR5Rk44a3ZFMnRIK0EvQk9EbmJHZXVOK0svYUVv?=
 =?utf-8?B?UlhyTC9vUlBqcDZqT05XMjRpRVVMNjFscHFCS3lUL01RVnJhN2xNb29UajFt?=
 =?utf-8?B?cDdCLzVmSTNpZ1pNYm5LZVF3b3RZbXI2aVRLaUJGT3IzaXpwcGJRUGJPMUJn?=
 =?utf-8?B?VFIxNVNwN1ZFajB5M3ZVSTNENVYrTDl2RmNrTTJtaitXVFlDTnlYSzBqdlVm?=
 =?utf-8?B?MGRNdFZza09FR0RGQU1UYXVROXZoSHg1bTV3Zi9KV0UwRG9yQ2F5dXJ1ajdk?=
 =?utf-8?B?bkdlekg1QU4zSk5tamlSTnhmYm9VcnlTM2tMaHordFNjZi9RT2d0R1JyMGhy?=
 =?utf-8?B?OGsvVXhOWERkQ1FDZEpRekN1UHl2N3hXRzNQVVZWZ2FxYzYrTkxGU0lGZ3VJ?=
 =?utf-8?B?aGNodHc2NnpUQlh1MjdEL2Z6a2xuV3pCNllPT29qWUhKYURhcmpMOGYycVBD?=
 =?utf-8?B?Qy9vdzNENjRNY0pDTSs3cnRtRGtpSTc2eEpxM0RGY1VmYnJybitYZURrUmht?=
 =?utf-8?B?aVBkemhIbkxDQUE1eDlsODNsT0hOZ1ZZRG9ack9PWHZhZ0RIVklGUmxseFha?=
 =?utf-8?B?WDFYUm1wVGxqd29EM2U3VHBCbkZ0bGo2SWo2c0RiMTFXL1RMMll1S0k5OUUz?=
 =?utf-8?B?U2pGblF0b044eE9xd2FkQ083eWhvV3lxd1Z1d0dTeGFSQnhkdldpVWNOcVhJ?=
 =?utf-8?B?T1U1YkN6ajY4RUJCcWtnR1d4SUpQTWl6ZGVxMTFub05TM3JkZkd0RTN5WXRS?=
 =?utf-8?B?UlhZTW0xQkpMSzhIQS90NlZzNDZXMDVlWkZvRmsvNkJYbmxWR0V5QytqbEdt?=
 =?utf-8?B?YVZxMWxjcWRJTmcrZ0NCUDJ5bzlkVTMrR1dVKzR5L1NwSFVtdkxXa2xZeFBk?=
 =?utf-8?B?S3E0TmZUUy8zbFVrMW5SU1Y4aUFsZ2h6S3V0ZVBURFd4Skd4ZlpJVjdpYVh4?=
 =?utf-8?B?OUNUZ2ZKYVpjR2tvTkJIV1JhaWpiSWF2dWRYaUxzSmlkK1NaVDNuOE80bE90?=
 =?utf-8?B?N0tXdjduclRJRTEyeEZVOUJzSzdmZVRIejM1elVCS2JWMXR0bmxJRnN6ZUNE?=
 =?utf-8?B?Tk1XUXBTTGtLRCsvR28xdTZNK0wxYXY3NGdNWENYWmVKTnNWWkkvb3ZTR3VF?=
 =?utf-8?B?anFuYkY5SlJ3cVVUVUQ4cHZRUkRuc2FzbTB0ZHdMTEJob3hCNUFSRTlUN3Rp?=
 =?utf-8?B?anJPYnBSeUt2WUdCWmU1eHNwNzRBa1V5b3FDbDljc002UU5USlNmcWsrMlVW?=
 =?utf-8?B?VVdFc3hjYU9zOEd1azVyUkdldDNoaXhGRTNBSisyS3pBMVNLVlQ0WWJ3VkJK?=
 =?utf-8?B?eWJvOTNlTjRwTFdreldnUEhRMi9yb291SEI2SnZjOXg5eFNVbE1idE5hRVBI?=
 =?utf-8?B?S2xKdnhPMkwrTVI0WVo2TFBNeStxdDM3cTZsTUtZSXd3ai9kRDBCaWRHbHVV?=
 =?utf-8?B?emQrRXVUeGc4SGtRSndpU2pUK2lVRTJYZnltUkYyZDl4dndpWDl0aUIrYWdk?=
 =?utf-8?B?YVpUdGdkd3l4RzlvK1huVnN3MUxYWjd6RlJ1YkNZUGtBTzdkTFhhWkNlcDRn?=
 =?utf-8?B?aG5ycVg3a1pwaXliZ2pkM1ZsTkVpeHg1bWIxTU9BRmg0RUVBREE1SWZYSUtw?=
 =?utf-8?B?WjFSV25VWmJSUkZMRTdpaXEzaG5YSHVkV0tCdktDc2JJVEpnYlpQOHJCZjNz?=
 =?utf-8?B?VWUxclpiNVEyY2hsSGVIYXlBTHBKbW5EcStBVGoyV21id1VZeWo0SDZzc0p5?=
 =?utf-8?Q?1fpr6onvrOPuI+z2pVDC15Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3910f5e4-33b6-47d7-70e1-08da8c5c2c39
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 20:54:33.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4SshUvoMtFj9g1w+fZWLbs8f6giSUyY8wGEY0M/oRvfuF7afRXMW6A9bgECWPuyddV4cq1znu2iuR0/pgjo8BsVc36qF1lkM/jeR7O0CbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4899
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2022 5:26 AM, Tomas Winkler wrote:
> From: Vitaly Lubart <vitaly.lubart@intel.com>
>
> Exported common mkhi definitions from bus-fixup.c into a separate
> header file mkhi.h for other driver usage.
>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>   drivers/misc/mei/bus-fixup.c | 31 +------------------------
>   drivers/misc/mei/mkhi.h      | 45 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+), 30 deletions(-)
>   create mode 100644 drivers/misc/mei/mkhi.h
>
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
> index 24e91a9ea558..811c94ebf250 100644
> --- a/drivers/misc/mei/bus-fixup.c
> +++ b/drivers/misc/mei/bus-fixup.c
> @@ -15,6 +15,7 @@
>   
>   #include "mei_dev.h"
>   #include "client.h"
> +#include "mkhi.h"
>   
>   #define MEI_UUID_NFC_INFO UUID_LE(0xd2de1625, 0x382d, 0x417d, \
>   			0x48, 0xa4, 0xef, 0xab, 0xba, 0x8a, 0x12, 0x06)
> @@ -89,20 +90,6 @@ struct mei_os_ver {
>   	u8  reserved2;
>   } __packed;
>   
> -#define MKHI_FEATURE_PTT 0x10
> -
> -struct mkhi_rule_id {
> -	__le16 rule_type;
> -	u8 feature_id;
> -	u8 reserved;
> -} __packed;
> -
> -struct mkhi_fwcaps {
> -	struct mkhi_rule_id id;
> -	u8 len;
> -	u8 data[];
> -} __packed;
> -
>   struct mkhi_fw_ver_block {
>   	u16 minor;
>   	u8 major;
> @@ -115,22 +102,6 @@ struct mkhi_fw_ver {
>   	struct mkhi_fw_ver_block ver[MEI_MAX_FW_VER_BLOCKS];
>   } __packed;
>   
> -#define MKHI_FWCAPS_GROUP_ID 0x3
> -#define MKHI_FWCAPS_SET_OS_VER_APP_RULE_CMD 6
> -#define MKHI_GEN_GROUP_ID 0xFF
> -#define MKHI_GEN_GET_FW_VERSION_CMD 0x2
> -struct mkhi_msg_hdr {
> -	u8  group_id;
> -	u8  command;
> -	u8  reserved;
> -	u8  result;
> -} __packed;
> -
> -struct mkhi_msg {
> -	struct mkhi_msg_hdr hdr;
> -	u8 data[];
> -} __packed;
> -
>   #define MKHI_OSVER_BUF_LEN (sizeof(struct mkhi_msg_hdr) + \
>   			    sizeof(struct mkhi_fwcaps) + \
>   			    sizeof(struct mei_os_ver))
> diff --git a/drivers/misc/mei/mkhi.h b/drivers/misc/mei/mkhi.h
> new file mode 100644
> index 000000000000..27a9b476904e
> --- /dev/null
> +++ b/drivers/misc/mei/mkhi.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.

2022 (can fix when merging)

> + * Intel Management Engine Interface (Intel MEI) Linux driver
> + */
> +
> +#ifndef _MEI_MKHI_H_
> +#define _MEI_MKHI_H_
> +
> +#include "mei_dev.h"

Any reason you need the full mei_dev.h and not just linux/types.h ?

> +
> +#define MKHI_FEATURE_PTT 0x10
> +
> +#define MKHI_FWCAPS_GROUP_ID 0x3
> +#define MKHI_FWCAPS_SET_OS_VER_APP_RULE_CMD 6
> +#define MKHI_GEN_GROUP_ID 0xFF
> +#define MKHI_GEN_GET_FW_VERSION_CMD 0x2
> +
> +#define MCHI_GROUP_ID  0xA

This is new and doesn't seem to be used in follow-up patches. Any reason 
for adding it in?

Daniele

> +
> +struct mkhi_rule_id {
> +	__le16 rule_type;
> +	u8 feature_id;
> +	u8 reserved;
> +} __packed;
> +
> +struct mkhi_fwcaps {
> +	struct mkhi_rule_id id;
> +	u8 len;
> +	u8 data[];
> +} __packed;
> +
> +struct mkhi_msg_hdr {
> +	u8  group_id;
> +	u8  command;
> +	u8  reserved;
> +	u8  result;
> +} __packed;
> +
> +struct mkhi_msg {
> +	struct mkhi_msg_hdr hdr;
> +	u8 data[];
> +} __packed;
> +
> +#endif /* _MEI_MKHI_H_ */

