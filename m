Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C475994EC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbiHSFyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244851AbiHSFyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:54:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C579108E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660888464; x=1692424464;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WiV8bH5tAH6FcyfBqzUPpV4A/LoHofoGnC3wUQdsKbo=;
  b=ffks9lIfqZLXN6YL9U2JQYBG8+jLNRZOrTJjPU6ZDmupO6ky8i0eWTwQ
   rWkpCgW3tIXZmHu0KxhliJsIODF7jaF4z3vtqWKEnA/Ac5kYNw3+Xwbbd
   7Nq05sEjil8ODM5FpyegYmP7ufPLdCqit2tV69kvHDQE6vEG3J16ZM7b6
   cq8lJ4X5D6zFsr/EF2/yJpNFybwjuoB3/QOXzth4uDgiKVmcuLTIZYY/v
   f+52/ZOCGqOYkzohy353kCDpZtKxgAsR8EATjEmCmalVRAOC5jQHLtAzL
   pRYlF8jKc3MmaQH7gwKikSYZXzdPamK7GioioBLJ1vBYGGNAqYZ/EVcU0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="291698610"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="291698610"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 22:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="697451363"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Aug 2022 22:54:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 18 Aug 2022 22:54:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 18 Aug 2022 22:54:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 18 Aug 2022 22:54:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 22:54:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpQy0pxPRN5nozYTpvouUqiQmwHjyKaDCzNg/FVYvGpyPHCZUuqZtgJDzgY5mK67cm7hrnJJcYEgKwL8nknx2Z6rLR7mYCl+Q/KMKdhdJx/EVAuRGxgAJf1GGXqYhGp+mLTpB7jKtEvBE59PAk4QfnPZ3j60V1Bd6D2kOZ1qxQah7avFY/GZrDaMnQlD+bkjBcqwSqkwPfAyFrUxuI41aR9/873/bFmh5ThM5nk2+hVvjDlZiU4W+XU2lyq7M0FRjcokhwM8vF5eNCGxMYLN5oSJlQxoJNwVN0mTHmRfu3gMSGfpG1xF+VZTIzbDkCNh9XLCO0HZaA7VfJNfF+i9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwwpHt6qR4jy96o3B9j0OHRXvJPMeJJHaQx6C9rpfDY=;
 b=CUf6v6rY050o2rflkcwzdC3sPjLjMcjTxHVtGaziWnDkSGxXaFP4pNtL5k+rF1+C12s2Og1d8jcQ0/OAvOinBCWgLDdTia/ejAET1q0HsEN5/Zeh7iPN1FKPkLl8+3sBGFL1gzXdIyqkjD2XyKMATGLTsdNt7qhItTNs6UZKp85Xa2azo6j9/wd9L5KCLjQh9f/rqyI7ZIkgVzVeqsYw3fAyTPThitdX6B1NavUH3kB6ZShe2Vkls7XiVm2smkzBKb6eFo1dyGuhEOZlLu8zmj4GnG7UmrFYEcMnx/lLqXul4d1sNvctbctxs6gRhVAFPI8e5h2/UA32fd6lppUcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 19 Aug
 2022 05:54:17 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::503e:4a34:50bc:9f4]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::503e:4a34:50bc:9f4%6]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 05:54:17 +0000
Date:   Fri, 19 Aug 2022 13:54:06 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1.1] x86/ibt, objtool: Add IBT_NOSEAL()
Message-ID: <Yv8lfpTQk8cqZNVU@xpf.sh.intel.com>
References: <cover.1660837839.git.jpoimboe@kernel.org>
 <5b86c2e3fff1f1e1f3fda126c315819205eb9d20.1660837839.git.jpoimboe@kernel.org>
 <20220818213927.e44fmxkoq4yj6ybn@treble>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220818213927.e44fmxkoq4yj6ybn@treble>
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2ed93ed-02be-4174-2a4d-08da81a7408f
X-MS-TrafficTypeDiagnostic: CY8PR11MB7107:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDDn67USJk61mzlOjnj5Gs8tsHoYNDnq1XqNpxGgyEyZK8Wz0GYercG15UHdUSeugug1aJ7srj24DXsE3j4Rlu6sEJzV0U7IRIhwytpOLlIJlDib4ELP6UA8DzkF2YAFL1mFgoBKjgYv/hBmg+kYFnCJ34ON8BD7/qnoydrV1Vqd6Z3ZISEvaLJdZ/on+uIp509etqA332xqzMM96vW60eGAxFc1dZh1TFBD/qNjQWohSKh4R5JaRvurxuaYnkvwpuSQNRRumXIlItos5FIMPAownRbO0qH1arhrPunf0jQOW5Lhdp2HIQf0N3WEHdIIwFTPc4zrsy4VduAfMhKzODgUfx1jpcqaqwBp9viJWGpY1MCUk6mUIkP94p/xhugIwNvW0d8JexmtiYEHCGZKzgSXB+X/W3DdA/MQeAgtjBL8Jg++YmTzMTpxpX4OBicxiN6PM/Cv5afp5aUtzr/0cK7hpC33SzKXtvK2F41/ZrOwUibmzJGf/Euwm78qX72C+2YAwMY/FywL2reQRFREc3odm6Qi7rJTJFuQyHtG8dCXJJ2YKE+MO4OsqYVRVDsEyjdZBbSXd4x96xsjw7Ouw3Eo9ENSen2rVMo7bKvuyyNqqo5U9XoEBHEzWeIboUvoUBakwYzl0+fxbarD0YMW/t7hGsjU+WUp03UzvZpfDHKw23pkzRCOEpKpSEeghYdcSKVKOs/h6Y50uPgfTD6wOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(346002)(396003)(39860400002)(86362001)(38100700002)(44832011)(66556008)(82960400001)(66476007)(8676002)(4326008)(66946007)(316002)(8936002)(6666004)(6486002)(478600001)(53546011)(6506007)(83380400001)(5660300002)(26005)(6916009)(41300700001)(186003)(2906002)(54906003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TP2+jPY6G+srFDamiKJpq2UslGKj/e0jSyyZMgxp7y1aUrnm02fdj54x48yc?=
 =?us-ascii?Q?EmMuZpOHbRh8uWjWEfmRo+mLDv+G/GD1d8yoipC2XslzcIMJtDWNbRuyc1cI?=
 =?us-ascii?Q?Y1kqRIu+ktJMXboMxyedzQrctjGLywkk7D942CdA1zFTdfMSMayLlWAukngo?=
 =?us-ascii?Q?hNBrcOpzcL1l6/HvBMNcSXyrADpFGKVyrqh/RjCRt/P3/58b4JQze/Rou0sI?=
 =?us-ascii?Q?a5EBXRRaSRjKaeQfilrJIYhztxMLryYWt740A1Kk0CQCOKPkn+L5L6s2wIvD?=
 =?us-ascii?Q?vw/MJfF3rRHZAlXYTMIdXGkjYpIz2FvUHc9ml4exzVZ+7xW9ajceAhE5KFya?=
 =?us-ascii?Q?o9jPLDq5t4VbJoEBjDiW5tgQeLfPWUAZ5OCZ10TwFrw2SDTeKCFMPtA+TM13?=
 =?us-ascii?Q?m6pJXMr2kf2Ga6wps0aWo2ZyQMDe2vEOlBl78KobowZKwWGqtpznGzNKuRxa?=
 =?us-ascii?Q?kBLX49XbQYK7H3tTiUWg1l13xWzfoZCBmmiQRtD3zZxUQDfQcs1+FjPxAnqC?=
 =?us-ascii?Q?nNWPcX3ihC+zVJDmN0VN1ZxKqqHb1c4AwSIfOf4xjNCDnNwc51VlPflAsm7p?=
 =?us-ascii?Q?RS88iOuzcC9c87yyVPure8nMqx+xV//SAUe3fsflCyfdoNq2E0aBfrfbwZgE?=
 =?us-ascii?Q?GyIS+ljPTyfyjZFvASc9KYOHdevChF+mtabTZErOZR/CciN3/5QD9io7Ut0v?=
 =?us-ascii?Q?2WOdQjOmq2cGCJhSDHaicl/eNeuuUmD1b3Ht1CjZe949wzEHTf/S7uSaDLFU?=
 =?us-ascii?Q?7KqcVmfovVnhDa0Zu4Qq6sPXnuWrmyV5qtQZY6PlLaMh47y1leXWPt13Cm7m?=
 =?us-ascii?Q?dwcJUqd/oZclsYX3AwDPazy5+8yzOZ84c1VZwpYFERhBcbZNoNR69P5wMpYB?=
 =?us-ascii?Q?9k/ppVKwu0jvLf26PsFZZLqGG+SPlH1aoFd8/tZQI+4r/ARq4TSU7sbxs0F7?=
 =?us-ascii?Q?4SYQnhEnnKUIozAgneSUzse5gSVXLrHDD3E94+Lr19dDmYdB+RFMdiImzDT3?=
 =?us-ascii?Q?8s3uypt53dJXWQ3eXU1j5ix2qf88jTCfNfjsEINKIoXH9uA7AeFmpP32bOvS?=
 =?us-ascii?Q?EvMkutwkeAvze0tCeFJffIphSeBGZQ9Wnd8TVZryDZ3FHbGhwSDpruIuABUH?=
 =?us-ascii?Q?0Z8gzHMu9nUgq429bMQtbg1L5HtR8cb8G43JCuxz+LGZf95frzHFQZfbH/sF?=
 =?us-ascii?Q?9QxXcVb94/wop4+FTb6l1Uxtv5LnITnBGBSPVARXhKxaNxjncmvxqQr5FwZk?=
 =?us-ascii?Q?Mlcbwb5RoLBWbvklNdxqgM+HLfm7i9wIl4l2e2Pv7y4dPFCeefKxp3qXdM0W?=
 =?us-ascii?Q?LDrAKeKfYF5b8+t/+J8ZQhsymGEfGQqAgdV8Ve0KKyu0Lj2iKvaLVYRmJ1yd?=
 =?us-ascii?Q?A+wh1fuhY1wlfTu12pav9J15AG7hOhLFaDIirmxHEzYNGRxcL3pdy9jI9JcN?=
 =?us-ascii?Q?rylidym4YivBVufzEB7sN4JjDQaNAUEGw3v8nC0m/qr/UU+pqDj8lQzWEA5b?=
 =?us-ascii?Q?qNdqrvpdR2tQrkLIDgv0xj52ulmLy36AV6AH+c4fKTZb6wHr88r9Ml1pgssQ?=
 =?us-ascii?Q?vX/zt7n3CHqIm4rZ8Ug23V/D9gfWQMzXOeEmrLUy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ed93ed-02be-4174-2a4d-08da81a7408f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 05:54:17.0398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhRVMcuhZGb27gsBvj6EPSdrI+ZnjSLpOjm6pD0IImCfHYCm62eGPB2rXWBNHEEsYMcilbDWGaQPOjG9ZwFpjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
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

Hi Poimboeuf,
  I installed your patches based on v5.19 kernel.

  And ran syzkaller test on TGL-H and ADL-P for more than
  4 hours with above kernel, this issue could not be reproduced.
  This issue should be fixed.

  Thanks!
  BR.

On 2022-08-18 at 14:39:27 -0700, Josh Poimboeuf wrote:
> Add a macro which prevents a function from getting sealed if there are
> no compile-time references to it.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
> v1.1:
> - add empty IBT_NOSEAL for CONFIG_X86_KERNEL_IBT=n
> 
>  arch/x86/include/asm/ibt.h | 11 +++++++++++
>  tools/objtool/check.c      |  3 ++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
> index 689880eca9ba..9b08082a5d9f 100644
> --- a/arch/x86/include/asm/ibt.h
> +++ b/arch/x86/include/asm/ibt.h
> @@ -31,6 +31,16 @@
>  
>  #define __noendbr	__attribute__((nocf_check))
>  
> +/*
> + * Create a dummy function pointer reference to prevent objtool from marking
> + * the function as needing to be "sealed" (i.e. ENDBR converted to NOP by
> + * apply_ibt_endbr()).
> + */
> +#define IBT_NOSEAL(fname)				\
> +	".pushsection .discard.ibt_endbr_noseal\n\t"	\
> +	_ASM_PTR fname "\n\t"				\
> +	".popsection\n\t"
> +
>  static inline __attribute_const__ u32 gen_endbr(void)
>  {
>  	u32 endbr;
> @@ -84,6 +94,7 @@ extern __noendbr void ibt_restore(u64 save);
>  #ifndef __ASSEMBLY__
>  
>  #define ASM_ENDBR
> +#define IBT_NOSEAL(name)
>  
>  #define __noendbr
>  
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 0cec74da7ffe..91678252a9b6 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4096,7 +4096,8 @@ static int validate_ibt(struct objtool_file *file)
>  		 * These sections can reference text addresses, but not with
>  		 * the intent to indirect branch to them.
>  		 */
> -		if (!strncmp(sec->name, ".discard", 8)			||
> +		if ((!strncmp(sec->name, ".discard", 8) &&
> +		     strcmp(sec->name, ".discard.ibt_endbr_noseal"))	||
>  		    !strncmp(sec->name, ".debug", 6)			||
>  		    !strcmp(sec->name, ".altinstructions")		||
>  		    !strcmp(sec->name, ".ibt_endbr_seal")		||
> -- 
> 2.37.2
> 
