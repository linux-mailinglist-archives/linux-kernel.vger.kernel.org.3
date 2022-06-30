Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C8E562624
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiF3Wdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiF3Wdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:33:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BCA57232;
        Thu, 30 Jun 2022 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656628409; x=1688164409;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pNPHgluDGYxnMMOavd0I9OlL6Y2f7+L0QgP8RoRBh30=;
  b=fQTCCM5qrUg0szVIUM+4ZtCs/Fet8CDeBQfnapQetfiIfRDXvNRuK3/e
   h9eG4iyRVP3iig8ncJ9B5XdIbmnlD6jNj25yaC16tFf8Bg50fAecad8qy
   CYmcqlRyC8r8UAn3EXVcF2jG+uKBt8F73BeKT/lEenfVuYHbFP4PdkfhU
   Z2tll5gBVCbp4jwUiVAFH12Laznyt3PS0BeX2sjIs85mPcvnRTYj5mJih
   2OIDWYKFACzwn1U+mpirHPe04vJRtNNc0Ix8idIEV+Sp+B+f8bnomy4sr
   RYvrI3DsrUkdGyGqPyTFJad1j0dxRB5jY0S+V/cqKCUUDo6AeAgqkIULd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="344170940"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="344170940"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 15:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="541502945"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 30 Jun 2022 15:33:27 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 15:33:27 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 15:33:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 15:33:26 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 15:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iju3SBgH0stkj+DrWB+X5nJsAmpF6AhM8JLm6tRW/jQH/nXtF0usjFW15AmOIiPVAFIjWZFCBWH6Pj6AC+LVPpipS32gNPsAY/YPWCXZAGfGx/PQ03rF/r52v5YMPn93JhPH1sHi3u466bGjtrbVDZd/jjYpdP8jLh0zawR/WfsQFrD5fNHPefHLHva/Vgee4eEAjB0TSYx9APrYqesHasxPzQJf4F5ZtiHk45ye0PNTFoFl7Lo0Kgjx81jumcgwceg7/VrOWfPqv3Wt7AuA3xnBDJQmWdCDQYuMvrUwjuvD4MXl8IhQwbox5zgi5VH0ndNWFvYVAqf2+fDcLboDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXSOJOTRjqEquX1xHCZrYCxrJztrwttzuKPcTQ64AR4=;
 b=T3HNYv2zpvXOusYPWup9S2uXou8o15/4NqIkIwZKzIV9jSEgGE/Cj8SfXIxsZ9GIfZS6TSq0CBzVzcsP7JRTmOyBBaUE/DGEpk/f1bZGNf0Z/18td16V+/7CARGGvDtgrXHww0zQD42XyO4vUpeNK3+BUlmakmLrLGyJO9mTTBtsZ8U4gOqEmHf5pIBDSoLvjywoXhZTzLI2qWaQPYYJlogOyEVXoL27jI7w0IrcyuxPO/t2025DgnbcXRnYJh8RW2tqCr5QDlGPweqONF47arqrcULpkUY2PGOjsjzD5U/FzFLO8nJFXgwYu4Habvr+GWipwTR9nO9baIHmf/5llw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by BL1PR11MB5270.namprd11.prod.outlook.com (2603:10b6:208:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 22:33:25 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513%7]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 22:33:25 +0000
Date:   Thu, 30 Jun 2022 15:33:23 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     linux-modules <linux-modules@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] kmod 30
Message-ID: <20220630223323.2hko2imx62embtsj@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220630153621.3fggpqrbyvunhwfu@ldmartin-desk2>
 <Yr4fHBR08VAVbs2E@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <Yr4fHBR08VAVbs2E@bombadil.infradead.org>
X-ClientProxiedBy: MWHPR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:301:2::34) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea47546b-14ca-4d06-5949-08da5ae88bb3
X-MS-TrafficTypeDiagnostic: BL1PR11MB5270:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 252LqAb9GQHK1ffGxKpkc/St0yZoS/7rnHi6K+/E019F1mpEFOmWKLtM5E509K9HMpORu3qe/CHQTZb96VcR/ZuzCogIKauK/kz2oihVPhi9NKmrXkIZxIImMfBETc73zIlu0K1+7NEUN1gn4XbuIAj8+DJIxUtBe0lOVy9q/KZP6lbg140rv8R9WqfWx1vnnvyJRVNXqVnRnnVuwQx25purQsmEG4AqcAGYh6uuXMFNaJIKgKy81Ny3S6BhOIGeLVdCM+2/lXNaLfPqMQkzedk7x9r9542bH56+mEG2HV2FhLKdxRIY5Pdy2yaiPBineLAMwemtr/k9wIz70tQSNFugGUQQvasRXy4JJL+JeU8ZcQ1aEyp0O/ucuZPSOErQ/FqeB8sOEzxmw3T9Pl41K4bDI2JuT1PEG1dFVFyFlcL0szTdqdA7iaQ3uHC66lcFvaXYrBveOspZwt1+GKhsqKzcVhWox2UshSE9y20Hy42jVDOtVNkfb6E5maX6pRGqmdMC40U7rOhYtL3n2DibObr7JUYkRvTkGE+TVuhTx2Gss/NXQbsQOAbo6EaN6AYltmiI3Y25L8+g3hl4bsWqc7hVAfp5q7d1uU036Ule+14fUFHXYIP8TIHyGUydBrtOnW80NtkMy/3hBsXcg/5PHzlI1+pW5N6a2N0bwanUNVU/pqTut+X8+snpjpQRxn/NpVZL7Xlbq6wMKmVMmm5ofCZT/P0Tj9nqtMyrbRYkbLEHjiosmMlcN4j0hsomIGOH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(136003)(346002)(366004)(39860400002)(26005)(6512007)(9686003)(86362001)(5660300002)(1076003)(2906002)(41300700001)(6506007)(66556008)(38100700002)(54906003)(8676002)(66476007)(4326008)(316002)(66946007)(6916009)(33716001)(6486002)(83380400001)(8936002)(186003)(478600001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zasfGHyEZ/W+HIliN1JQHRtCOyna3ShXrmbDK3QVbL/SIY7PqbCwXSYwi/jC?=
 =?us-ascii?Q?XzcIg89g/D3yoxNhiBBTkDmhfeZLRylDnraP8Y7TZZMIFa5mLqa5XXIWus8g?=
 =?us-ascii?Q?NjJVbkGp9IrD/zTZUHOiN/L4sFr7P6THXXoqjexlwJW5issuo4lrTHypZ3bu?=
 =?us-ascii?Q?boJdnC5PlDMQ/LuNigqG+vXJ3vxljfntuWSdwnC5bJ7WIRkSzVCkm1V7MGf2?=
 =?us-ascii?Q?ros1rIEp3nIw59KJU/MJQP5T9VQqf4BgTlc7s2qM40hEM5ErSjRSuuPvfX1E?=
 =?us-ascii?Q?6n60hxik8y0sRHHz3NdWKcu2PHkREnojQ6hhOTV+32L8vA1YruLzRyIWFHDJ?=
 =?us-ascii?Q?2xzEBUZ0jbxhA+N1XeewhZwbMwWgowa1nzrG0IiCHuG0seIK6vQAhkhEymwB?=
 =?us-ascii?Q?QscSV0FBuAp3lMQq1hdDPxW6th5X2lcvWCDsphj/aRbzpTQqFSGzyQaN5age?=
 =?us-ascii?Q?+J0Fkma2VN3op12Upr9iaeT4us7caBbnecv3AmkeQIv/MJVBEKuSqXw5xnxo?=
 =?us-ascii?Q?6ZXQQu/BJX0SKHFS5cXH9MvnK96CKFYo92tgX8/xLbt0Qt9nKR4nqwiEcOF2?=
 =?us-ascii?Q?EhL7a8621KXuXMakOyTJNOuRRX/7CVnD+9bzHLW9DG7YElxqCDQPPqkrH9Kx?=
 =?us-ascii?Q?gfiH2UsHKSDNW4jBLzwd3YlJbFpqEPkEN6OUx+FFGPxErYo2PUUQqJ0/+Nni?=
 =?us-ascii?Q?ug1As23Ok1tp7gwNpQTucPkr1BeIZ7dq9u2JtadmTQBD/frYf8LBb8l9HPG2?=
 =?us-ascii?Q?59SdU29gpT2BLAWBTGtfwoOa3wPm3bdQ8q+qrzVsrhilG3utF9cb+9meaBvv?=
 =?us-ascii?Q?RZex9QkJZMthii/zdgdusuo72IYqPNKwx2p9jnrhzE4m4rZFQLmcdpokZJMD?=
 =?us-ascii?Q?+G0XbPaOlOdBIKlhgdF2wrmiaAdApn6XK1Z/D0yljxXhCENDU73djK5XhttH?=
 =?us-ascii?Q?5hrJVaWLcHcXK+kRp7H/Y3qvJ1XdNhNRwL4VT57XP3/u0pMNXPiwWSmecfB/?=
 =?us-ascii?Q?EMJIX7kY9xorcwq+annyo0OMc5QAwGDUpIe5nEESiIZcwCGdFMlWZLmqiuVG?=
 =?us-ascii?Q?ZdfQBQTj7SdI+GDUoIkIBKwHac+OraVw6ymu0L7dfUmouPLIgkNMJ6L32yPZ?=
 =?us-ascii?Q?ew51Jamw/hYm7WRlh5RE1XCT2DP0Y5d6wh1Lb/swYO0q7udp5B/pUNhbIKUg?=
 =?us-ascii?Q?WBMY/YY97PKCmMHfECTy7qFs9iyefXeDq/WNCSqFn0vMvaZpQX7gpdMVy8Eq?=
 =?us-ascii?Q?wecfAVnUrlgskV/bzMa6LVzKeP+LksTCHqNUBkdj8hJjrpSIBM06gGammJiA?=
 =?us-ascii?Q?tBMoeS34CP1WCdYTmXnw18v2Ao7/oOfFNu/pe2WWQF9xFBipGlyAzPesC8Cy?=
 =?us-ascii?Q?IoReRmyT+yuA4YZ+us09gATafW7SjnNkNiks6X2b8wEr0MVcl3mwVU0vfRti?=
 =?us-ascii?Q?LceH0HsoAnbTFrrtgXGIIUH0S46X0OvGvlSv8+h6oPZY5BCRn3NUfzM35/yj?=
 =?us-ascii?Q?C50AukrPMwbZzAMOeTDTWGQPIC75r7II5PhRV7Sie7hsPWpVfRpXxJOWOGDt?=
 =?us-ascii?Q?OUGDtpxsDtP1TpfIJzpSVeWyA6m/jba7nrTNFfHxz6QvBYmJA1NAaJETLCeQ?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea47546b-14ca-4d06-5949-08da5ae88bb3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 22:33:25.0295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcW2heKFfxV3VFAXLsdVpytmF+cELq+c9/yPb+SgZgsKevxISboZxb9gR+jY8dYZqKoCgppcLN896KlQwOVVFXBponzs4SITCaW5HYzhoIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5270
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 03:09:32PM -0700, Luis Chamberlain wrote:
>On Thu, Jun 30, 2022 at 08:36:21AM -0700, Lucas De Marchi wrote:
>>         - modprobe learned a --wait <MSEC> option to be used together with -r
>>           when removing a module. This allows modprobe to keep trying the
>>           removal if it fails because the module is still in use. An exponential backoff
>>           time is used for further retries.
>>
>>           The wait behavior provided by the kernel when not passing O_NONBLOCK
>>           to delete_module() was removed in v3.13 due to not be used and the
>>           consequences of having to support it in the kernel. However there may
>>           be some users, particularly on testsuites for individual susbsystems, that
>>           would want that. So provide a userspace implementation inside modprobe for
>>           such users. "rmmod" doesn't have a --wait as it remains a bare minimal over
>>           the API provided by the kernel. In future the --wait behavior can be added
>>           to libkmod for testsuites not exec'ing modprobe for module removal.
>
>Sorry for the super late review, I was swamped. OK so the only issue
>I can think of is that rmmod *used* to support the kernel wait support
>with $(rmmod --wait) so wouldn't this be odd?

any reason not to use modprobe -r? Argument for rmmod supporting it in
the past is that the wait was implemented on the kernel side and rmmod
is the minimum wrapper around what the kernel provides.

On the other side, user shouldn't need to know where that is
implemented.

Over time libkmod grew much more to support loading/querying modules
rather than removing. I think for next version I will move some of the
module-removal support to libkmod rather than modprobe/rmmod. Then we
can think again on supporting that flag there.

>
>It is why I had gone with:
>
> -p | --remove-patiently   patiently removes the module
> -t | --timeout            timeout in ms to remove the module
>
>You would know better though.
>
>Also just curious, is it really terrible to just support waiting
>forever?

is there a use case for that? If we are trying to cover some races, I
imagine a small timeout would be sufficient. Also notice that if the
timeout is too big, so will be the interval between the retries.  On
your v2 I had suggested polling the refcnt so we would get notificed
on changes, but as you also noticed, that didn't work very well.  So I
went back to a time-based retry solution.

if there is a use-case, should we cap the interval between retries?

thanks
Lucas De Marchi

>
>  Luis
