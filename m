Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3635A543A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiH2Sxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2Sxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:53:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BBC15A3D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661799214; x=1693335214;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c0ppNAzY3AHBm57WgYUeyGnvb4Vc1caXapa0V5HOXVo=;
  b=lPTBGemvnyTa1qV1hg9nkYUB5Eu9NdAkisJndW267oWa/RUWXp/bIpZ6
   R+yigFydAbc1Q5dWyOrKHwzO+UkTSM8KfTNSxJf3l5BbWF8ssIojeL1Ty
   qPi4N5HgWZQVj0ModC2oaYWXP5rZ9a2QuzpSVE+ECDg9GSge4BDat0KbC
   qdFuKfCju7//y/SxWaqrnmMnLXZdm2R/TOfVAbQ7mH2/vmtBC7OrE342R
   r0ECq8XsyWmPWU1pLBWjZdUPBWpW9qxGbJHFQqL2aq/hU7vQN6+1vSRBJ
   4yGKouIc2+YMqUICAwGFL6jS6oJOVBuPgn2upzme09G4t57LkRbeYyJDv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="321095855"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="321095855"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 11:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="562337715"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2022 11:53:23 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 11:53:22 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 11:53:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 29 Aug 2022 11:53:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 29 Aug 2022 11:53:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKpjVJjMspc9tvsOJIS2l7GBm8I54kAnvn9oE3d4W/M+yR8crFDhOz9gwjfEPqKf4/ozeoFqJhjPR1Slejp3C3AmezaF6KGtYTaF6RoXIZCfdzaVhsLPix5M4vMqNCgAYRNRqk4oS3bnCRLHIe9B9L8vsQZjy5Pj2GIUIkeVg5pj3eE2CVCCS00kVbl/jq01av9vhTF2nCtJmFlFwSQ24zAvW8kVTkyR8ns9sm5cLPV+FofQ5hnGUX8K9Av5mI0trUZ1yiURGrQdo06+8wCkEWR2VF/apfUvq09fhIFKZ+3SOkCNDUKX6M7uGpk5FXN0PNQ/Cky1UAZE4IUKukw7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd8EKGsF4cE1pTm/R1oxPLZa8iyftMDBCpaR0GLErIc=;
 b=A98SK94t5B+GGIXCU3TXng7AV6j0CwiusW0l9Tp82s2eqWsyBHyzi6NwrURZ8sz6g3TJ+tkFSgvuZoxPFf57dH29kOathM3hQLLzwR+bwDQFpHASB3//QqT57hpS403JIVDwMmSAbDh1X231JB/cwxmLJDnV0R6aXrViMLMu/sfEAYVFK3l3d31Wj0xYqzOIR3MZRQPyrNOOv9Zd5kjsqCPREia9qXFbWECcSyjy9YXeGt3ryhAtGTtruYd+P0emsEGIFqcmlmTMDeMzKz4wZAdAlUu4BqtQL/Vn7yDQe2o3B15q6rrLDMIfTitHkWLMorrSBrbC5g+3K6YNsKNObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MN2PR11MB4758.namprd11.prod.outlook.com (2603:10b6:208:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 18:53:15 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::f80a:da3d:ca42:b0a]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::f80a:da3d:ca42:b0a%3]) with mapi id 15.20.5566.016; Mon, 29 Aug 2022
 18:53:15 +0000
Date:   Mon, 29 Aug 2022 18:52:49 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode/intel: Allow late loading only if a min
 rev is specified
Message-ID: <Yw0LAbFITDDFGek3@araj-dh-work>
References: <20220829180436.716672-1-ashok.raj@intel.com>
 <e46c20a5-9f43-6ec4-6c2e-ea6891a8ce0d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e46c20a5-9f43-6ec4-6c2e-ea6891a8ce0d@intel.com>
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99e7f645-9658-479d-805b-08da89efbaab
X-MS-TrafficTypeDiagnostic: MN2PR11MB4758:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPVP53lL64CeOH9pNdnod4gwmegxwDXDca3yj7GLNWTWQpgJO13g3JfpdZTyC9Kt/xzDBGhci3bfTGUtRGznKTvrVuS7cowzkP+kdfvgNWjNwtEGsn9/ko+VM2397PA6dgHwBEp4VP/5HTsnPl2++kU6PgrBcuh9iTIjwhktmNcSx+oPepVQEFvI9sdbKOBHwx7ngWnQTqgEF0vabQRnt11CLO694m1wpisI8+Z0rBJghBih+6nrC208nxpqvOJ6JUOreAhfuYkq4Y9QzrFPmzzSTdfciLK/RI5XUWSEi46B5FZMmBgxTEwQJ/wYoooy/KF2zonVTPuMGpQqwIBnxOBtY8avqnqYrwmfamfr+Rz2M7NpvrCnmsCoamMJBwoV+r2KYN3pNZivTsGSkOzqjPAEiJlV65gi5VL50uNVtyD37dIgRLOX2hjBJlgs30bQPoztvdLKYzxuFfdNiZ4IMmzjK+A2q7zwKOO2s9sNvYDkoEwDpsf/L61J+WMv6vF8opok4BLItV21zL0GILO4uhrTN0m1Mm9AmMurtsTNwZcyTLI38lCk9JmSRhJo1PuvSe9rAt1520VLkZbrBMQAU9u6LRyJ/r68Kqk05cYG3LolovhcqqURDuWA8YvXgGtoy4FbOob7cTSaJTuJMbePVnq3sxTBamsdIFEyAWBfSbwYAAzmcwJFZiBo2txtkkar3AnbY15sqfPi8a9SMSwPow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(39860400002)(136003)(376002)(346002)(6512007)(9686003)(82960400001)(26005)(54906003)(6636002)(316002)(38100700002)(8936002)(6506007)(8676002)(6486002)(41300700001)(6862004)(44832011)(53546011)(2906002)(66556008)(66946007)(186003)(83380400001)(107886003)(33716001)(478600001)(4326008)(6666004)(66476007)(5660300002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2mct4z1R+K/K48uULqFikEynzldmy8pT9qLeBAirXgcjsGLFItf2Kxv3JC03?=
 =?us-ascii?Q?XsUIbsjLIWK8anBXOu43Gl5YnQ/m1viM+FXTXYhWu/+gnv/gaJE97F858fIZ?=
 =?us-ascii?Q?Jz/ozpGkkU4ocqMRXW5JFnFSx53dSDpG6K2awpFg+UQozzedXimOysRPljLY?=
 =?us-ascii?Q?PKB5t6dn1FU7dH2uQF79OzvJfFJ0U/w96/ZXl0EyO1EUE8XuKeQohDkFffpt?=
 =?us-ascii?Q?q4Lo6trKMaOTi3fFLLKawoovUZ75P0Mjn/7zv/a3PG63UoSZhh71gr063P8+?=
 =?us-ascii?Q?41jKas5j81ZBHtkeOxmCmZlfgviuyj8Tfh4fganNnIm05t4+Yejm35DMPbi7?=
 =?us-ascii?Q?wwhUu0ui6duZ9Zc3NYK9b4TKdcpMRrEuXr43Zue7/FuUduDLTJUOd9XRpm2W?=
 =?us-ascii?Q?VADh4nMvhsUoF+6fS1+Q1awr7J9WsR60x4Ct2IZSjXPFhtxpBTEUdbQYFnUU?=
 =?us-ascii?Q?LyOMPTngYCRj51uuqwYIS1txp6XZuchfAqKZ1GmJFyuVeA40rx/Oz9XDhIIv?=
 =?us-ascii?Q?ukO0BB29dtyXNYj18pLz2Li02/oMKibRqIa5f+TpkpvQutc8Xf0RiGmEnapu?=
 =?us-ascii?Q?UKZoxCjGmuEyLaphU1Q7G9auaZeluOrVyU8ePtOLGETpDTL26mPnM40+e5wV?=
 =?us-ascii?Q?XTGOIOs+4WUKSC5HPQo1jJKe6Czs7FguGIzyLGGlF+HMobdnmHhw1r7ZOH3L?=
 =?us-ascii?Q?xeWLifJ9q+XgomQvZs8tpUZWbPXH2XqslD6hCv+bOiSdUBv747nP9nPCDCww?=
 =?us-ascii?Q?sEdj5+yLup2sayYcHtUGe2t9abDBU+WaS4LlpuWr0NWkEGgStKFC42nj2E0R?=
 =?us-ascii?Q?rLyTfpqu5dAX38zMYxPNF/PRmysEj7k31cqQJJTEangOSZb4ixmPLFcTEgkX?=
 =?us-ascii?Q?U24RGAYhng5Ek3gKKZY2t1voQZl9qThPYT/MSTXENovcwHsjuIlzcmlvIRkT?=
 =?us-ascii?Q?tvuAD4nMyzsflhTMEV08SnEyISvAQOJ6rgN/vyBQi8yzPh4xLgnBO1B9F12K?=
 =?us-ascii?Q?BMtkP2qMelgsn4MIn0HwLVpTyzs9Pccb7PAY2GNi/2TzDBLvalT2weYUMuZr?=
 =?us-ascii?Q?6KOedFMMgGtjolCDfw31eItEbzgh1f7KHRZ/NE1oB59OT3OcaV/JhmZ7izGP?=
 =?us-ascii?Q?30m7nDji9tkKapmKzgegr9uxAosIJh0tr21BzoQW1Gr3vWjlm/imHPwUldxs?=
 =?us-ascii?Q?6Lj19cpxFVg/jk9iy29yySwFzpoFXkGKQciZ+sRhGZqekcWJBMtyxRdQRYId?=
 =?us-ascii?Q?mWNHmtjcDzSoeyWiWrrnYy9AnLUafAoz/ydxUJ8UPkAkxN6fY3qstoFU9VLb?=
 =?us-ascii?Q?BQ4lXrF0S0Vu17NI4GTmH2q8x01afqlK98HQcWOw206O776QZL/lbvw9+R84?=
 =?us-ascii?Q?UamvI+s9FcoBfri1ThJStoK4tl+r/S/2F8N2I6IukAUMJI4Ku8QzeMUvvEcQ?=
 =?us-ascii?Q?GsKzJeD+WeLQBj7775KTpTau/nGtSnfn++CyvQ/1INHLASwIS47Alws+bpBb?=
 =?us-ascii?Q?PT2XKc+ICo7C0yUL7ikB6izVDlp+DLPQqTMGm7DZKViB5jSk4lWEJqGnHIpD?=
 =?us-ascii?Q?gGyFC1T1jiMoSjpMLDUcNtRdmQ6dOtPV+jG7Mva4ryMnS8OThy/0I6dGiKdv?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e7f645-9658-479d-805b-08da89efbaab
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 18:53:15.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vdy0Pbk+SIwHrbHCeSNW7e18yWxijtUv5EDg6rDacYoAS531E2L/i3YwpXsDRU5ct9lr5Un2uHjs5TDHuFcxwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4758
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:36:12AM -0700, Dave Hansen wrote:
> On 8/29/22 11:04, Ashok Raj wrote:
> > Any microcode that modifies the interface to an OS-visible feature
> > will set the min_version to itself. This will enforce this microcode is
> > not suitable for late loading unless the currently loaded revision is greater
> > or equal to the new microcode affecting the change.
> 
> I know this hasn't quite made it into the normal Intel documentation
> channels.  But, it would be nice to make sure that we have a _really_
> solid description here of the architecture of min_rev which is *very*
> close to what the Intel folks building microcode images agreed to.
> 
> This whole thing is useless if the architecture contract isn't ironclad
> and agreed to by both sides.
> 
> One other thing on that note...  The CPU itself authenticates the
> microcode.  The OS trusts that the CPU will verify the integrity of the
> image.
> 
> But, this min_rev is not part of the image that the CPU verifies, right?
>  If you get your microcode images out of the back of a van in the shady
> part of town, nobody can promise that min_rev in the header follows the
> rules.
> 
> I don't think we need to defend against that.  I'm not sure we really
> even *can* defend against it.  It's probably good to note, though.

If someone also recomputes checksums in the main-header and also for
extended signature tables when one is present.. just a binary edit will be
caught by the microcode_sanity_check() today.

The commit log already has the following text. It doesn't say this is not
in the encrypted header, but just says HW doesn't check for min-rev. 

If you think we should change the description below, I can update it.

------
The enforcement is not in hardware and limited to kernel loader enforcing
the requirement. It is not required for early loading of microcode to
enforce this requirement, since the new features are only
evaluated after early loading in the boot process.
