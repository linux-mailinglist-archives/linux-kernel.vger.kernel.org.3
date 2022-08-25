Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EAD5A07AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 05:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiHYD3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 23:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiHYD2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 23:28:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D88C9E2CB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 20:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661398111; x=1692934111;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dQdvNPz4VkqpIg71fWJNMzgtzJi9vyTVHv7m8vwampI=;
  b=Q04e8daXAvhJxsrL9hVhY1Vmc7utFQ/+OMWT9nHZYaH/FlgeHTjmE59i
   Q9OLUHRGghI5AjTTT/EI3Ez1cTZC6mME/S+qxW5exT4h3ZOtYU/KSi4gr
   XpSeq2JLj7D6g3+Xc66a/WYRnOArYws4k31+qGSE4PQ4UWUEpjSsQjlVk
   QcMBWIdKJ6ann9rh57H7p7AgmMNxxb1loqIjImcLOzfwKr7gxwvQdJc2r
   CBGe7M9xKsDhxzEKh5STVKl4a0G46pmvibLl0obKkO5eqfwdlOXBO6m2l
   nvX1wTsHyY0/10EDTrhWgZuAxcnr5d2j1t4ABAY2pFzts/UxAHuzVARMW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="294136270"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="294136270"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 20:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="938162469"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2022 20:28:30 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 20:28:30 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 20:28:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 20:28:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 20:28:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3hbQmLM1FITcaclm6LkaRfOHSfKuNoW0KTXqOA9jQeqkmAXOZjD0Tnl+4AB44NRNok17dq1NFn4Q46KvRiIpsTQqITVtl8lNuGcm/mpdoEeMP760yyEK6EZzeEZPFA0VTmTLt2N8YnSPna6pzchP+QNR6LXenlxVUAVSI+J7tnKbR110XyHqXBAmCaXygfeRrN5/qO4jy4i5b9K+tbSrzfOQt4kqMsDzWqQ/VQ9mGpB4/CGdfznFetRKMFEYO0RGWsneiYNcPZBpQyzo10xGwaAlzOrvXJoCnBnRdEBGw+U0RVibNZt4W81dqiPebNo8CC/zDDR1n7PsB76HRchFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oR2HiJQGncZlPYcUPgS6eFrw01XyTORDym8fzJQk6/Y=;
 b=ltUq4MajF7tOFWji8eQigjUfEwC5pBp6LOKOhZByQbHdBk1NDsWi1XdEiYO9Fr3m15tG6jJQMdFPvCPsD6lypUf3OHkDYJ+Fl2ZAkHOC7uB0otBuAKCicqJF+rnfI/ZnwWy88NZt0/C6te5N3PHwgpzJWSV/d41G1WZuugzyPx3R6z5Q85iEDibGeqTcIAZYT357U8TIXoQ1Me8Ua0bui2M0xM4F6UBGLOFbTdAMd/mrMIDVLtysN9rQO9617geds0Bx5vJ1almAR2mVR23qqnDzvWoaGtlFXjUgTqmaFPJH6YDoC86di3g8wsouoNPNSSU5PfQ12jdGxz27saOSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM5PR1101MB2105.namprd11.prod.outlook.com (2603:10b6:4:51::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Thu, 25 Aug
 2022 03:28:22 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 03:28:22 +0000
Date:   Thu, 25 Aug 2022 03:27:57 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 1/5] x86/microcode/intel: Check against CPU signature
 before saving microcode
Message-ID: <YwbsPVteXuWVho10@araj-dh-work>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-2-ashok.raj@intel.com>
 <Yv9k6fqRANu4ojK6@zn.tnic>
 <YwS2SXBN2J5FQflG@araj-dh-work>
 <YwZ7u0ljd+AW1P9d@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YwZ7u0ljd+AW1P9d@zn.tnic>
X-ClientProxiedBy: BY5PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::40) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea3c9bdb-6c9c-4ab9-47c2-08da8649dce2
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2105:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYgssgqEDwXvM/si+Paem+Msk/OYxI+EwOErDa59ZOYGSiqJszMznKB2B8/NMg9UNsVc6DbzUeY5VD+fF4U/lptuEpO7fDIRx6M12OHnOg7ZCI2N/Ti5rkswiRYBKxOb5B8MTSdj8lRRBAgtKQVWpB9izHWu4tXSecMvpDDECY2MJBolCQrm/1o2asJAQ75qg5emaGLQ7tORoyB41uhtnbmC5e8ociiIQZdvCYPeRjWLqdP3g7cPX9cH4mQ/BDe5yisTIfb3AMSniBQJf9qEMCUqod4aHWNKMwdciSbBmoytdgz4FDKVSTnKWbHyVjzKUyXrIj80LrSaHMsBDpVzhAct5Twr3c2eaTmg9vjO5kjM+zRO2X5W0rVY5AxcLf+ldshEEiMQX0A56i1ZpVG3XL+koxvxvpHAJ/Xkt1wTw+Ky4BrIlWxZGcPxiN099u7l1S6ldW9uLL0tsZkcjCBaFQK+1Vr56Uts59NAd8p9q49KiQ1cVA49g8WeTJ97zCMGQ7oIQJHgIUOZ88RvDsSGO5kQnEftFW+w/s4XZzxO7ygrZOPHeV5o+nwfSc3ntGN8n5dbDOHqtlnLbxXFctMsja+KCjcfEiaYaHdCTJx99W48zumOvtzLtTLiSG0bSAuDXyHr4GqAJVeEuBng+qFa+13nomiwviO2dyoGn4g3TeN/AlvfmVji7cWXa9IH43mfTcBi3Ro2qHo4icYNI3xe7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(136003)(39860400002)(346002)(396003)(2906002)(6916009)(186003)(8936002)(8676002)(66556008)(66476007)(44832011)(66946007)(54906003)(316002)(4326008)(6486002)(478600001)(6512007)(86362001)(107886003)(41300700001)(6506007)(33716001)(9686003)(5660300002)(26005)(82960400001)(83380400001)(6666004)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xGAzyO/pVdp34Sne7yllCvZFqnY9e5GagKRwZAVBmhq+RskqAY766Ge7kylT?=
 =?us-ascii?Q?XJ8qMOEvJLEtTSLQiJHhitdgMAhktxmf1BSFqboDWrOqbBqP7zfqwngu9bLA?=
 =?us-ascii?Q?nei0BOJv6a1PaugttqPmgb2HXyMPoMeQbLKlgvi5GJ7omw7Mac2pKHQAlMwG?=
 =?us-ascii?Q?MYzFzO5RDsQfBR38ULA2uv/jsvZDkDjo5SIn3daBK9iP4ghQfUDCdaXIQ2Ev?=
 =?us-ascii?Q?B7RNZueqNKUTcdIODfYKE6tOo1WzbBGIYOQchRTaJPq630Jsiu28iH+s9lRu?=
 =?us-ascii?Q?hh7H3uKh5GUE37v/nEfXEFP3mJEiWmMFQM5mvqljVZ1DjYPsAhQBg6+gFxv3?=
 =?us-ascii?Q?xSmLkpv/OOfhUvzdzHpDaxL/jWYVnkMFvgr8pDogSGjRr9/jcYEpuBvDBAqh?=
 =?us-ascii?Q?rehtws8tniFIPS0pCAdIotcE2DJOtkQgXwkMILxWY/gm07Z053nulKA4aSc9?=
 =?us-ascii?Q?kra699OF8FgaXRg02ypH9qD8Ncgp3hDWA1tdaw1wFcnYULa6bHWdxkv/xOb2?=
 =?us-ascii?Q?55Zd8F2j5e7TPipp8S5GfTPQitvuBa7lhvjHj2Tl1lYSb+8CvTZgU37Mh7sn?=
 =?us-ascii?Q?SFLYbxuWdHRNuKx+IDCnu3oea89CWNz7U9xIwRN5lOWQJ/xzHJO58zRn2QiK?=
 =?us-ascii?Q?cZHcEdfZ3KN/MoMnsBbKJeH31qcMDu2M916DHCXlMksbdqliHVVfEVBinwKo?=
 =?us-ascii?Q?A0KAFMIZlpRqgRG+OC0aUjaUCjUhe8SXpSM0euLcwSW2tGkN+cgsEYLmdwSZ?=
 =?us-ascii?Q?C8mQ2Gly/pZuc9Q8p9fiBwGrfpWkHexDA+5nIy0MI/zQ2SwvFYgr1P1Sr3b8?=
 =?us-ascii?Q?3nLX+yZwb/fFsjl4ZG3eFWfxst/fY85tWb2lL5IVKpMB7CKfbB/OyMbns6L7?=
 =?us-ascii?Q?0+NQ+oY19a5Hc10HnKaY4k3xubDdHglLg88ugohnuCizbpfzUpKJjyvyIAK3?=
 =?us-ascii?Q?mgWl1ysOVuKdcyuDYQwW2YVoyw8d51AHvSCDiJJ7IohOEJosj0NPHFJOyVzW?=
 =?us-ascii?Q?0wTkkPSK/MV7RtdEcRlpFU2U04leAfonpltGWj/heXlzqowxJRxGS/fB9d1n?=
 =?us-ascii?Q?c4wRvoTYiORTaj4uNka9MgCWeCZwCwq1juaLiSjQDcsuFn4cdDeQHDYlru8M?=
 =?us-ascii?Q?V7EaannS1Pp1PY5Dk2e+fKwbvCRSlygT/QNB48aA5kvD9yKRvdcNIsbw/RKQ?=
 =?us-ascii?Q?dPq51yDLDKu7LvvzCbDsRStgNbQkAN+FCD3dMrI7EjUBHsomeKQ0A8bhZJXl?=
 =?us-ascii?Q?zZCiYNEvxylaIg4tW+Gno8zD6eVwL+Vha6baDiaDXlsQts/POFhNrCTCQt5s?=
 =?us-ascii?Q?hjoICZ8vOWZ4dOLWoIIF5TLr1HJsYexRhbVYzpCxxhh0nxqBfym2o/U0Z+g4?=
 =?us-ascii?Q?YpwhdmvsazxVsKSRF55BpxlcUxko0QeMuRLbSfT++eApKy2zCfZZvKGd9Z71?=
 =?us-ascii?Q?PEzOiykcXUVNoYkkdLg+S/1Veu8qHA4lWrFTzpv/pGXEvhByJ03zpjy15z8X?=
 =?us-ascii?Q?fD0XHHmzrWAoIC9PattvNnGOFlFcpv5yOQevu0aprgS5X2PaxVCJLfT62aNo?=
 =?us-ascii?Q?Gj6EV5sCIQNv82GtqVB8DJUkodGIqaguMKCEn5DvJttqmwQoGkn0LfPHpnaL?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3c9bdb-6c9c-4ab9-47c2-08da8649dce2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 03:28:22.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSxgM3hwC3O0RUtffZ/Dz8fcQ5/Mf5dbImpEezO2wVjgu8+6kZhNTml66MNZ8i0MQiPiwVWoQX0bB1vD1WP6Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2105
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 09:27:55PM +0200, Borislav Petkov wrote:
> On Tue, Aug 23, 2022 at 11:13:13AM +0000, Ashok Raj wrote:
> > > > patch1:
> > > > fms3 <--- header FMS
> > > > ...
> > > > ext_sig:
> > > > fms1
> > > > fms2
> > > > 
> > > > patch2: new
> > > > fms2 <--- header FMS
> > > > 
> > > > Current code takes only fms3 and checks with patch2 fms2.
> > > 
> > > So, find_matching_signature() does all the signatures matching and
> > > scanning already. If anything, that function should tell its callers
> > > whether the patch it is looking at - the fms2 one - should replace the
> > > current one or not.
> > > 
> > > I.e., all the logic to say how strong a patch match is, should be
> > > concentrated there. And then the caller will do the according action.
> > 
> > I updated the commit log accordingly. Basically find_matching_signature()
> > is only intended to find a CPU's sig/pf against a microcode image and not
> > intended to compare between two different images. 
> 
> Err, what?
> 
> find_matching_signature() looks at fmt3 - your example above - and then
> goes and looks at ext_sig. Also your example above.

-               sig          = mc_saved_hdr->sig;
-               pf           = mc_saved_hdr->pf;
 
-               if (find_matching_signature(data, sig, pf)) {

In the above example, 

Old patch header rev is fms3
New patch header is fms2
Your CPU sig is fms2. 

The code was taking mc_saved_hdr->sig (which is fms3) and looking in the
new patch (which only has fms2) now you will never find and end up in the
situation described, which is adding the new patch to the tail instead of
replacing patch1. 

Also look at all the existing usages of the function and we *always* use
the fms of the CPU.

Bottom line, you never need to have more than 1 patch for a given CPU. The
list only exists since it could technically support multi-stepping in the
system.

> 
> So you can teach that function to say with a *separate* return value
> "replace current patch with this new patch because this new patch is a
> better fit."

I didn't quite understand what needs to be taught. 

FWIW, I rewrote the commit  log with *lots* help from Dave. Hopefully the
full rewrite of the log can help jog memory about the purpose and why this
has survived all these years. Simply because the code still is capable of
picking the right microcode except in our internal testing it showed its
warts. 

The new commit log below: 

== Background ==

Microcode needs to be reapplied upon a resume from suspend flow. For this
purpose kernel saves a copy of the microcode after its loaded. Its possible
to build systems with two or more CPUs that have incompatible microcodes,
like if the CPUs have different stepping and each have separate microcode
files.

save_microcode_patch() is called when it comes time to load a new microcode
image into kernel. Its job is to either ADD this to the kernel cache list
if one didn't exist, or REPLACE if one was already saved in the list.
save_microcode_patch() is expected to search the saved list for the
specific CPU in the system, and replace it with the new incoming patch
being updated.

At any given time, there *must* be exactly one entry in the cache for a
given CPU in the system. If one isn't found, save_microcode_patch() just
adds this image to the list.

Lastly, microcode images have a CPU signature for compatible processors
that this image applies. The signature can be found in two places.

- The microcode header
- In the extended signature table in the image. This is located at the end
  of the image itself.

for e.g. The image would consist of

microcode header
    { rev, date, checksum, sigx }
image
    { microcode image }

extended_signature_table.
    sig1
    sig2
    sig3


When Intel releases microcode images, typically the most recent stepping is
listed in the main microcode header, and the additional (older) ones are
listed in the extended signature table.

== Problem ==
The kernel is supposed to match the CPUs signature (struct ucode_cpu_info)
with the existing patches in the microcode_cache list. But, instead it
tries to match the signature in the old microcode, against the one in the
saved patch list in microcode_cache.

This would seem to make perfect sense if both old and new had the same
signature listed in the microcode header. But if the current CPU is listed
in the extended signature (say like sig1, above), and the new patch had a
signature in the main header as sig2, and only sig2 in the new patch.
Current code would take sigx from the current image and compare with sig2.
this is a mismatch and yield no search results, and save_microcode_patch,
will keep both the old and new images. 

== Impact ==

When find_patch() is called since the code only checks for entries in the
cache > what's loaded in the CPU, it will skip the one at the head (which
is the older revision) and find the one at the tail, which is the newer
revision.

-- Problem 1--
So what exactly is the problem? find_patch() will always find the correct
patch to update on resume. But we end up storing an extra image that would
never be required. 

-- Problem 2 --
There was some internal version with support for microcode rollback, which
permits picking revisions that are older than currently loaded.
microcode_cache now has both the old and the new, in some situations it
selected the older patch instead of picking the newer revision at the end
of the list.

[Note, the code that surfaced the bug was purely for internal evaluation
purposes.]

Nevertheless this will just end up storing every patch that isn't required.
Kernel just needs to store the latest patch. Otherwise its a memory leak
that sits in kernel and never used. This is mostly harmless.

== Solution ==
Always search for an entry in the microcode_cache, with the interested CPU
signature instead of using the signature found in another microcode entry.

In fact every other usage of find_matching_microcode() is always called
with the CPU signature. This is the *only* instance that used the wrong
values to compare.
