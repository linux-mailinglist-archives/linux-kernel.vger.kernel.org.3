Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6025591DA6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 04:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiHNCyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 22:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiHNCyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 22:54:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D775A2B265
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 19:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660445689; x=1691981689;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vtD1roe7Ot0LG295J51gAqMY4UuR2nQloIZXIPVJ2fg=;
  b=DtvGZ+rsGviHeBxSs6Ys3DSHuE9aCfgYCSQNO6z68UOpR2cAK8TZ+bM/
   vF8Za3SCxx7zeVGmfpH8+f+dRJUb6gSpqB8UbrEzJj6Sx3xnRBgUfqeZv
   eMDl8PdL4wJB4MrndTiXHTijG/CnDd4P0nSVP/AH8VY5gneiBa9M+9zwb
   BmosAuZOC6JIi73tm1CbVKmWHGshWYKnbGnldaamDY28iLU7dDwN2OEAq
   9cPGugi+BJBpbIkqP0cboPpmuixdmwIHAAqaxgG5tSy0u+xJxElVdmTGU
   fFZsq+P8Mjb3RorlzsZFmWx+6trOr3PAu4+9RIfZBSF1pnMKjXrBdHoZv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291791270"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="291791270"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 19:54:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="695631512"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Aug 2022 19:54:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 13 Aug 2022 19:54:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sat, 13 Aug 2022 19:54:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sat, 13 Aug 2022 19:54:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fk098k+j8jTqiKeCtOCI6Q3OnCXr0NdDKUWbjtmamggnGFjX2eIcpC69OM48Flsw9DRPm6pqNt9zwn/KGDILA1absmhGtwO/AJXbZebDxZiRItUGK/B6wlbZehYNVFDRxpi92QY4S+oHwfk2+0/R+6MtqZKZ/7MhvWSPqkZvwMa/KsMgwtq54y2kXz6cf+C9z57HrFXA/KlzIWKlhhP/Wss03q46apczFVzwfiOHhsEx6lCA7LTFMHdg6kxR5+lUP/flrHokox/lZZgm3fq9jwPTZUIAyw1kMUbtoSU6qPlMcGw4QsxH1tExceVPMsaQoZuRPy/l73mHCo/QxFnaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJBw845jNaTfnRDS+EhrEL2vvVNxG6XNmluuK3SqIrU=;
 b=lOHiISmPow2mBXmXyZJpWsQVcJvvlf38T5p85nk6Ur17lt9X5WypBbE5aP3RknlAVjisivNDgPTurp3BDVbIPC2dYrGgv/gHmx9aQQWIkqxn9tgJWv55J1WGSpI1Tz4H//GRHSaK5C5gFN802Z4VCgVRbqx9X3EG27ZS9UJmL4v30ad1XkETxpeOYXPtG4nimryk60kxxc8q5soFg+A0SAEjRatPiIFh/r3et0ag8ndLfFYVL3m7Ng5K+LZnqNJyUBy+EXDxEXIDLdMmfNbeQaBAY7P1i2Hp+83l3MWBkbNdFwjtC7NmNnzNpVG0qM3FVyUDaEP72hiNrHxs1en7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MW4PR11MB6713.namprd11.prod.outlook.com (2603:10b6:303:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sun, 14 Aug
 2022 02:54:47 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%5]) with mapi id 15.20.5525.010; Sun, 14 Aug 2022
 02:54:46 +0000
Date:   Sun, 14 Aug 2022 02:54:29 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tony Luck" <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Ashok Raj" <ashok.raj@intel.com>
Subject: Re: [PATCH 5/5] x86/microcode: Handle NMI's during microcode update.
Message-ID: <Yvhj5YaLdJnF60uR@araj-dh-work>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
 <20220813223825.3164861-6-ashok.raj@intel.com>
 <0d6afdb6-e546-4ef0-80c2-84827c11f2ce@www.fastmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0d6afdb6-e546-4ef0-80c2-84827c11f2ce@www.fastmail.com>
X-ClientProxiedBy: BYAPR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::39) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 528a3c84-1746-442c-7b2c-08da7da058e6
X-MS-TrafficTypeDiagnostic: MW4PR11MB6713:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCdN5tAVKETOPDT4nJFersYjvaQENQvHdh3CdsgpkQIc92ez+tucP4CNsZOeZaU1ivqeWRhMj5XTCDrEiM+Hn2cgJ2z4mKSteml4P9wv+ipeEpAUdv3K0lxAAJqtkf9B00tfEhYzKLWc3tUjGE8UdKismJ6vqXntEdQbKBV2HvJRgezAwpM+JovD802DpI6o/vSucxxAuTzFCRlKJr+aIlTXWfFffPjfOTW1CVMctzDN8g8wVq42zgM7rxeBjQjEFZYZZewBl+5GwmVY0hb0DQ3IpaO3yc7hHSd9iR4t9whkdnqibxFFvLGyrWuo/GGlXXyCotRu97Q4rCldsVhnaPVWNSdRuMnqJs8glZ9dg9r9MFhfdXBcj7CsTdsH99OuXOX2WagZxMCQHsKHkHLeLzmXpHLRn6c05oX/wvkVFoIzKNqdqAdH/HwcnmhHRt0L0xKdhPyMyjapWwEcRTrVueOLRBYe932rSImjBl7sFJQ80vKWrzYim88n9FXXQo9lNR5zVNpHr4JPxT3eKC1koMSP1RS2JIGDmYvUljklWCDq5c1LTtEyk/tYFj1fpUWUWumpnryE5WOy7uljWFhneDoJvZdkjue35NoKZsQD+qXmpu0iTxY8Wi0+pcTGp/maDTcDg0dVgZTn7Ir/dGlSsto8owm2JoYujaqWgwQnKVLrSsokkMhsqHlM49joxSlpnPv833dmD7VFWcBir56/Xs5SkPGfiKhasVbdvYjIHUUvOm5E2njoblh7alYBqGVL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(376002)(136003)(366004)(346002)(33716001)(316002)(41300700001)(82960400001)(6512007)(9686003)(2906002)(66476007)(66556008)(66946007)(15650500001)(8676002)(6666004)(26005)(38100700002)(44832011)(4326008)(186003)(5660300002)(83380400001)(478600001)(6916009)(54906003)(8936002)(86362001)(6486002)(107886003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LWsgmgQZLMiu8zxj84YIGmtaqr7sSaeHCKQIgcLcWnR4+NDT5RAH+1XXX83m?=
 =?us-ascii?Q?KFq2Az42AvTMy4+4nQGt/bRpXV6NrOoOxKaRi1Rs68Lg21Zb9vlOaLgB5NGU?=
 =?us-ascii?Q?KZRc65FmhcO9B5NIultU3r2OoVOf7deA+xo12nvHRG/ZLdvv44+/XjOmzzFp?=
 =?us-ascii?Q?umHvO9JCNFTX0g4MaGrTkUXhcVitacICe4RiOBQvla3eODJ090Yi43fl2bnY?=
 =?us-ascii?Q?b4jgdHUrQ0UEIVFWKEN4LVASafYGViXYlL23eXZR92WgY1xLfmvG028RNCy+?=
 =?us-ascii?Q?quKedTJt85kD3GJIYezCMU0mfhp5G1DiIYAHv5TxWIV9qLJY/NHyOEwMWMtq?=
 =?us-ascii?Q?BdmPOnoQp0VZS23TZ6B5CoTwZM0+nxxfcE4WifF/doAaJc5f4pdo/UFwQ62e?=
 =?us-ascii?Q?nsLJgjpO06seUEHci1qpyxUQmyBo9dOC6i7GsouD2cAvkMFd3zVgGVIttq6V?=
 =?us-ascii?Q?/DhDvymK/gxqnZauREPur6O8EEVSKOdmgFw84A6++/KfF2T6XWFOePwoVQVG?=
 =?us-ascii?Q?bpHq2IL+eoYrdxy2RRZVMidS1PUsMv9FDzMYAa69i47Jz6yQLLXkJP+oBElx?=
 =?us-ascii?Q?7xlg96+ifygNAd0RjNHhN/vsT74n1rpYn2Kw+5zFP9k84WGcRZTGRIPoTuS0?=
 =?us-ascii?Q?/MzPBWO5+0WnRxqTZEsPoBOiwbypLpDKCNJCI4d3+MiBQORcNgQRgENMo+tS?=
 =?us-ascii?Q?fLrQTPcWfPhgyvxqevPQkd74dm7pCHtICqacX48TgOpqNLivZAKD2+O8RmZp?=
 =?us-ascii?Q?3IVO/GNOjic8/i7eM/j1GAACqjrAsyycYu8dDHnko5LWlv4mtYMupsEqHBA0?=
 =?us-ascii?Q?M4BR0tnlkdQje604ppQn1hujcmDbFrU2+iFRiGwkQ866jqnGVGMJySULIOCL?=
 =?us-ascii?Q?CxD3iPyECFCfsXCudZjMuh9+bsi91AKiq4innaFgTAv3fJG5huRVz1CQRCAZ?=
 =?us-ascii?Q?NwjYS8qs3rtpsktkEh036EV9hAYVchtcloJnxO6pL9cQeDuLSVy0jlqsFRME?=
 =?us-ascii?Q?Rt2bUv0JyRhTBRIW0WwM2XTzA/1srLUf2cdMKhbpSvDEJRxvxoOfl1Q/VQMj?=
 =?us-ascii?Q?E7D86u6si3zydmWJLiLTReo/7RyV9DLL2pNeAZUQI13d8pvdZrz4qCNAfMVY?=
 =?us-ascii?Q?r09D+UKfajKp904ejNW0wpYKdw0iTONIFC4DT8BJGNm5Tfy299dTis/a0SDH?=
 =?us-ascii?Q?WujiVlyKX4/m9l4Kb2MMU+pVV/8UVJjEG9cBJ4DNyatYqAHpQU3WPZ3KX3zT?=
 =?us-ascii?Q?S+UAtcp7UbBRzEzloL5hCT4Sycx6x1Fp/Uf92pI+0wYpzlEoC/W6/Id65rA/?=
 =?us-ascii?Q?aP1SyX2/ddG8MqKghfC/GLSBOoaEErdUa0bdhQXCk2XMfCKjbSA+cbqtn9gD?=
 =?us-ascii?Q?byqfusQWmzVWrEer4fF+OUHSlgSl/rx9pwL7xaygMzi4f99wrexmjeG/QtAw?=
 =?us-ascii?Q?m2d6HEgungfjfMiZ34eI9q+owqspLst2rALUOzca2G8BIM0b/XUAdDuEw/2x?=
 =?us-ascii?Q?zcasFkLJ61j94+91UMxrF/YB3Qhkr0u6dloAMPqXe+3+f1bECcl9T6gjo6Ky?=
 =?us-ascii?Q?DrI2G9Hl0/WxjULXf3Jwz6zYZft5lfJWpjxhiQ4FrLv8GxRaPP1xTJGFmEqx?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 528a3c84-1746-442c-7b2c-08da7da058e6
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 02:54:46.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8l72py8CwS/J9qNmrX0jHMCi3iSVN3xDHLuqBbnmbkwS7PJS5rlnPWmGVTBzz2eTguKXd0k4Yic9pzR4/OHguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6713
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 05:13:13PM -0700, Andy Lutomirski wrote:
> 
> 
> On Sat, Aug 13, 2022, at 3:38 PM, Ashok Raj wrote:
> > Microcode updates need a guarantee that the thread sibling that is waiting
> > for the update to finish on the primary core will not execute any
> > instructions until the update is complete. This is required to guarantee
> > any MSR or instruction that's being patched will be executed before the
> > update is complete.
> >
> > After the stop_machine() rendezvous, an NMI handler is registered. If an
> > NMI were to happen while the microcode update is not complete, the
> > secondary thread will spin until the ucode update state is cleared.
> >
> > Couple of choices discussed are:
> >
> > 1. Rendezvous inside the NMI handler, and also perform the update from
> >    within the handler. This seemed too risky and might cause instability
> >    with the races that we would need to solve. This would be a difficult
> >    choice.
> 
> I prefer choice 1.  As I understand it, Xen has done this for a while to good effect.
> 
> If I were implementing this, I would rendezvous via stop_machine as usual.  Then I would set a flag or install a handler indicating that we are doing a microcode update, send NMI-to-self, and rendezvous in the NMI handler and do the update.

Well, that is exactly what I did for the first attempt. The code looked so
beautiful in the eyes of the creator :-) but somehow I couldn't get it to
not lock up. But the new implementation seemed to be more efficient. We do
nothing until the secondary drops in the NMI handler, and then hold them
hostage right there.

I thought this was slightly improved, in the sense we don't take extra hit
for sending and receiving interrupts. 

In my first attempt I didn't only rendezvous between threads of the core.
Everything looked great but just didn't work for me in time.

Cheers,
Ashok
