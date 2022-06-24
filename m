Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E5755A1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiFXTdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiFXTdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:33:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098E0DF2E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656099180; x=1687635180;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eXjXmTOQ3M6lhmgEGzRoSuCUh5z3ONh1kao39FBS7Vs=;
  b=XwICrVwzp5RjBXlW7MhLykNN6+YPIdpQc9aqC2ybu+qdYce/qqdUgL38
   SI2iV+c/+HiMl8ResPiz/MW5tm4QCK/ruFh7t10w6TiB8kSSdpD19MIRc
   c3Yva2udDoVrh6V9ou11OZZX8AchqzAXz+cy+P+3WTewkrXIiWIigJb+7
   DdMF15kGNZfD0wLOSdqpAe8QP591l7+8Dn/I2G7+kxwfRFD98YOkgUJah
   hdj9mWVOWKqFumcipGoXBR9t/aHHiJe9PJnz32/Vk4+3lz4UiBOkJpTCz
   6NJDKTwxpkJMAgMN5mo+T4eS5pBd1lE0ApkhKfwtmJwadpISUglDX+PC3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="261496420"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="261496420"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 12:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="586681454"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga007.jf.intel.com with ESMTP; 24 Jun 2022 12:32:58 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 12:32:58 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 12:32:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 24 Jun 2022 12:32:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 24 Jun 2022 12:32:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsISuwzf6RsonAiN9QYgCk7uODxGPsMCarr8Ol6r6PYzJGrxj29fDIM/h5o/1m4AzfzyjX7j+HZ7bHTbdLRlOeolX9Gfbb6LLvdQV+msGu5ZsI+ndTw1LBLsNt3VY20aOBySihLxWA7CvYbJCT7+ff2T9Z0VrShO8qNXPwqO8q2uhrhcb5+9VOAtY0qE17IUqgyaAonst8cjvWXKMQFuvUPI3rotD7mFX4OCnFeVR0e+IB51NLcmXuf0qwMSvSR1LZQND2LuMX9FyKxOu73v6iVYpK/gpC/fkosLrGVkwfz4oHSRtNEJYPoAQc++LAb8CBieHTpNmgjesG5xp2C1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/C4ozT5Wfz27yq4Mchcv3qEVVMWG+3lP1y32vvaCHIM=;
 b=DRPkOAGlSB7oesCnUcMHG4I0VSOLPEGQpLAKf3x+jjKahGqlZO820tqJMVbLnoYXkctOfbAWOL67agcbsv2ILLPxdPlYzklx/FkLpNmh2CWZFMVF0+xiZvNLaW0AzzSsQlj7oEM2ucXuwZKGbsfHmSAU/P5uZhj61D4PZhMcFVxLkCb4KI5uxdwmNakhsOeDTqIpA3yZebSJ688cUA480b+p6akKvZg6Tb4U/0K0fbU1mqfcqRgw4hkE3HVLgKgS60BLzn0wAuFlrPLUoZxi2r7um1q8ed31cmAElUj3gFZkp4EAbQ9FGLZCEkRckyyRGnr7+V0vMl22Ev6mhUwelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN7PR11MB2724.namprd11.prod.outlook.com
 (2603:10b6:406:b3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 19:32:56 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.024; Fri, 24 Jun 2022
 19:32:56 +0000
Date:   Fri, 24 Jun 2022 12:32:53 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <pmladek@suse.com>
CC:     Kent Overstreet <kent.overstreet@gmail.com>, <rostedt@goodmis.org>,
        <enozhatsky@chromium.org>, <linux@rasmusvillemoes.dk>,
        <willy@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <nvdimm@lists.linux.dev>, <santosh@fossix.org>
Subject: RE: [PATCH v4 26/34] tools/testing/nvdimm: Convert to printbuf
Message-ID: <62b61165348f4_a7a2f294d0@dwillia2-xfh.notmuch>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-27-kent.overstreet@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220620004233.3805-27-kent.overstreet@gmail.com>
X-ClientProxiedBy: MW4PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:303:86::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8c71b0a-3770-4fd0-11f2-08da5618568e
X-MS-TrafficTypeDiagnostic: BN7PR11MB2724:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ds6Ghm3LZVsNnZU3AYUi12v7Um6MWznFILmw8XEBcaLj+hbp81Zaa0GlP3mvcgjsmQtedx/rcapGP7apk/H5AZA+SLxBxMWgNWJ6kzhR0JormOQZDxKtywZpfxfIOyWYfi6ck60v4+iNtaELrCZ7TsHorx4RR1xklg2FtVbPqpOrbPmIUi9hq+afQN/yiqVKQ8V0Tga9+YKSaGYNPXDVIlECk21bBAA3P3TtkZVpE4J+4plK91uIYYf/056kFt+C7Bh135f3F59QAN+SVx233HPgjnpaEMUz373Rw09vBYZdgrf09gertx0rJ7MQxHN0Dcgco3cKNantOeCbKCg8fnSiu13m9/DkWA8cDtrenMFpX9/jA8L91kQk0RIzrv0Dj8wa4Hp8hO8+GtCPob/M6Muxg2jsieg6K0hNeykS2ZYXoCevyP2+LFvo7qg9uDGPnoMGy+lyVmAfOJ/mxBbeaAd/g3GZwvyffX1yFSnoh0nYFOdCIG/M7e/ouSeTJjLtnjSV50g0Qc+0ks+CYVfsqqgxfQjUg/9fLrCVDFU3vPIVTNWaJHIR87tlzJFrU9UPRIUIqEmWLdiujwTY0ZXN4TgJz6VyzAJCQqP1oObWSHwMm3xi++bSnLMeVIbJvVwgak5Aw6hU5vOA7mrg+lwFo6CQpUxqHv1OY78MhWgOrLowktJtffmAPL02OcG0XsJUcvs9tXdkj84WZ7MQSkBYRJV0duhoulJ30YptqE47pp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(346002)(136003)(6506007)(6486002)(478600001)(26005)(82960400001)(8936002)(7416002)(41300700001)(6666004)(4744005)(2906002)(5660300002)(8676002)(4326008)(66946007)(316002)(54906003)(66476007)(66556008)(9686003)(6512007)(86362001)(186003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8gO1n/+SAwjlhV8n2HwSFzNkNOC3aptfvrr2KKsrCIYXxjyQeakuB3DxZom7?=
 =?us-ascii?Q?5crO0McMDy/K/837tYbqTfmyhmykJ1+cCaHBxgnbRSM+B7ruw+ys92KpDpTP?=
 =?us-ascii?Q?OgIIKyg/qP6tEaLOaxG8S30d0qSkromyfjQrMI05Q9oEJ68wr2EvqKOnXN0z?=
 =?us-ascii?Q?bJrhFT6KBSQhBtnpZwNvOHbAZsYKJbStc+6xt4rcgUYMgn/ENt1DzTPHkx8I?=
 =?us-ascii?Q?AYrrHKjxImMqGpHdd2kHrPbsjBt83AMnKp1LPbsVkewEB5O4iDWOx2/M4U82?=
 =?us-ascii?Q?5xcxyUFqsVKN5SG50hWfpU1wYnu8h+wghBWMEyxTzRIkdh6BpJBENTpn8N7L?=
 =?us-ascii?Q?Tczfpgeirtjk53bRcL/zwgKT8mcKnJed6QvGS4ZOf0N3DM8zkM2rK4rq/tBQ?=
 =?us-ascii?Q?7wBx1Mso12YHAa36sUVpytkEXe1UDmdH/SDcKvvdZlSXEztfN47gxS1US7/F?=
 =?us-ascii?Q?DUP5JX1ki4fuAIFncgp3AfJtChKGUSFNKI8i1GE3ELYwkW9LxmzREmbwls4R?=
 =?us-ascii?Q?MThTp39Iokc/ptyrM5ZbdESVRbFBpAJC6Lm0xtenguOYMdtl7zI/HTnLh8RN?=
 =?us-ascii?Q?LYnC0tvvzzEixP1QNoA9WPSxrfR7DlxJA59mNeCQLXBzbkDDmKnjcXD41GQT?=
 =?us-ascii?Q?POblxrTu4YlgTHu/Sjt2Y1M9MvpEZbv/o+xqO8zrKFvqbWBwhigItkRPM1fc?=
 =?us-ascii?Q?ab4pNT8AFMJdlYKisPDm8IHV4+/K7bCvtkSfzf+pZLwDhKAqf9Ma8odSrCR6?=
 =?us-ascii?Q?5rcc3MpUEDSIKUHR+GFvFdbWpNxhP7iGzK/vY82aGiJ3lyvmLhE3RqZJMtQq?=
 =?us-ascii?Q?Go+2XlcKj32rjZCi5QCxwMTSu+l94/nqzDcmcs8fvNbj1hdqjjcj1xRrlk5O?=
 =?us-ascii?Q?ri+3/ARdnYhjLm5ZnkkCBetx+hjpxpFKmvRH1N9BugyZuIolY6r6OejuTAB4?=
 =?us-ascii?Q?O4hh7PbVHMD9bXFmpFpsf901P4lWly/OgUp2R8LMoLmeQ1XUmLBR+nuRrIzD?=
 =?us-ascii?Q?aRHG1Kj1grOG8JRtBl6tBxobW7b9qCKQggwV39KdFQFNglYoeEZwwmMWGPI6?=
 =?us-ascii?Q?mI0W68jvKHN9J7y4iM4RGgCzHW175uWQWnB8osjJlfEsF9tBDJXcKPHhon0e?=
 =?us-ascii?Q?idWMG0UaNnIqFNkLB85DVz2cdGzFI3dyS5/gOxpi8yunmNozb+fo1IireKL8?=
 =?us-ascii?Q?UW0JsmO55xZyHVuSu2TDwWSugy76XPYXnuUiCFd+MptgFOkIo72LA1JBe7gi?=
 =?us-ascii?Q?F0aU4Ko1+Uf+Pbx8ewld2Jkj01Jmct0PXSjdo/Vme3WY4Aze2sgESwZ2tRm/?=
 =?us-ascii?Q?OvhB7pVirO6LV3d2JNNUUWiaRdUBGnxC+EHXgdMFKz+oRUa/5wcE/hZXY9MH?=
 =?us-ascii?Q?d6heYa+UHzeh0uWmPVyQw2mb2663aQkuadAhbkTp7ZjjOTqICasCy76a1MpJ?=
 =?us-ascii?Q?x2DZGBnx4EVoWb49mDpoTuiB3Ddldt5Vf706WYR9/EnYhZv/ZYnFHjG972nP?=
 =?us-ascii?Q?tTlVtvbSX4SebEYvymosjZLldRep0Cr2x6Cj+zsHpicRR9rBHQJXCv+buW8E?=
 =?us-ascii?Q?Rk0ai8DuTM7pOHsY6ldiLIqdX9Fit7q7u5SyHR1xydbWvY8ekPvukhLmk6fk?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c71b0a-3770-4fd0-11f2-08da5618568e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 19:32:55.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUoEdpZM7O82z7rssX/fu0qnZOqeoib42K0JC+x4/zyos+Mh9AjgSN0zWOK1MfibQkMu6iUqsJZ6xSetX9nTjVX9miJvOjH+T1bHbS6x2ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2724
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Santosh ]

Kent Overstreet wrote:
> This converts from seq_buf to printbuf. Here we're using printbuf with
> an external buffer, meaning it's a direct conversion.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: nvdimm@lists.linux.dev

Acked-by: Dan Williams <dan.j.williams@intel.com>

This probably also wants a Tested-by from Santosh, but it looks ok to me.
