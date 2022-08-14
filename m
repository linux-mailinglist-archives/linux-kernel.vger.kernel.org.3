Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6FA592036
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbiHNOls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiHNOlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:41:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD9013D0D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660488103; x=1692024103;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5Ny0FCAMeRZjgop4vh0jVceTVMsrt8tUl8nztH2Rwd8=;
  b=cmNFVBzNomDyvEL9iKDjo7dg5WHjI3GDrKKwhjCVcCnoKdLdnMbXL6iw
   ONlxMb3ndEQasok2VJPqnFt2bWj2fAW/CN/x9oezXjF9flPd+58EUtkXt
   KFFS/VqS5mz4NybeuUEVlH4xwov1jPDNCy7/SlcNy+T0HhO6n/s7Sksbq
   GaPhKJCDHF5S6+/BOBokKqYLaALxSdM45wew25a+6I9WhBOKV85RMgxT0
   5oLzylKA851xL+fkhbTVsPHHzUXMgMqiRhp7L0+DG+XpAUrv1mwKnq6qh
   BmT7UpLN23FmMvjYG+JQHR7GKrx2DTJkj3CXewGKlcfBrXFYsSVfjilQY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="317808748"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="317808748"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 07:41:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="635197448"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2022 07:41:41 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 07:41:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 07:41:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 07:41:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 07:41:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKOZsVubUB56HuAvTnMtob+MglmjTcxgcT5MinH3X7W3FiejopDOChI0XynxYE+AyZ60yvVoODuaKAhyA9dvYfa8bgy3R2qobkFe8ddU+xdelSmYjQzow+IPNN0w63QMcTlJ8xqCDiO3iYHfBDcWVSp3CEJJlrdwpXwO0+2/MyVzwsD8VErmc3PzIRw0xjfvS+/GisK4wrYS264kBJW3e3BK0PFMWHesKo+v6o33MWjrbSEry2tahFnvs6S8ORpct2e/DqYnSWG8gIuxbEC4/ljtyZwghSf5a/lWrNSG8lSthhJbCFLc+dLmeXTKGwpo0O04Y0O6iSG/cQlgpks1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZio0R4GUjlbFLpCWI1YzU1JwlInSjUn6jYvUmGx9xs=;
 b=CttfkEAuSY0whreloXuVy3d2iG5ttXXUezUqFHFRaveLMjmRGwodPrMHxMZDC5hW89IhHAm0Bw8pAFGnyy0Gy/9PE8hFscAj+ssRfeDybfyvHZMka/DVl/lG8tF//Qa8pW7u59yTb9TFThN/NAUIY3dVVusmByLaBLQrXWwP+KywVQ/4YT8GO9C6yVvA7JKE6TcazIsm/jIVXPhWbiIRFBm9Ze4apYBE8W74QQ+4rXVcvvxcezzJJhFADwKrACoRBm7vMRY1FNu24Tr7CnmAz0L1nwwySTH+WGJFT2wAAbWBkQHln4pohydLmhEXsm3Dz+g5P3zSP7KGIivjQxnf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MN2PR11MB4301.namprd11.prod.outlook.com (2603:10b6:208:188::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Sun, 14 Aug
 2022 14:41:36 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%5]) with mapi id 15.20.5525.010; Sun, 14 Aug 2022
 14:41:36 +0000
Date:   Sun, 14 Aug 2022 14:41:18 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
CC:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 5/5] x86/microcode: Handle NMI's during microcode update.
Message-ID: <YvkJjsdlDIcerqLg@araj-dh-work>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
 <20220813223825.3164861-6-ashok.raj@intel.com>
 <0d6afdb6-e546-4ef0-80c2-84827c11f2ce@www.fastmail.com>
 <Yvhj5YaLdJnF60uR@araj-dh-work>
 <328bf268-51b3-f9b2-1315-bac0e883d135@citrix.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <328bf268-51b3-f9b2-1315-bac0e883d135@citrix.com>
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0841676f-f7cd-4ca6-40e9-08da7e031716
X-MS-TrafficTypeDiagnostic: MN2PR11MB4301:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3Q2Si2Y4Xtrc/WE7L+ngFCqAGYyPHOGPLbUwtztNxzcp5ZFufbsYUfnPOQGifmrsgaZZ40t7LZWhI6RqntVyfPZWZ1JtvvUssnptRuVeEC6GaYFtHeCGpzvgVwM5tu6OHwJPI9hzpP8hUvT/hSo3zv4Rc/2lyRg7Tokv88aICFxUHf62TRVAO/pNqdaXtKoNTJrCpPFBR8ihoQkeCtN7k+c/euIdLbW8gJ0wGYKkACvzVBXaboMUDPOs9hrI1syoCuqXyU4Hw//t/T6LEB06tixgAiPii9WI9+KGcu1imoIxEO+wQMmNLze6GoRya4N0M1RWiR6+/k4rSC0CoQP+/jmMex6s7eupcTJ9J3gEbVk2rEAcZgi1EzKmyRZMDj3g1e8elv1P81OSSz4+iQtfXRiFzLN2RJcLBnmHYo2zeUADYP+BNS0d6OgrqEMVvQI6T2xVV/bvKyppSR56kZ6KzQ+jlM+ZVzxYvUPpDONaxI8j5eI4ITYae3XSxLjZ3ZRVS3lHJZQRuwBVcyEYv/w+hsM89nS3WuBE29T0zCOMNHYXYLBPe2GfIQndZg5CLvV32eUF2yW3jYD0ErMJuJFIwkgtInCysb+3+IcXgjf0UlJo2Zdbql0MrHN6ZmnbhSxzQ0gfwsmC2R9c8dAdO3tTrxZWv08kcMDlS7PgsnJwmKqSb0RsMBt+jTQUiDAgzDHJ78I0nwfyhj3575AODksGgBD8aCoTVm6IUVtnZbg36HI6weZZ8oDyJIMGWYBQRq5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(366004)(376002)(346002)(396003)(2906002)(15650500001)(33716001)(5660300002)(44832011)(6666004)(38100700002)(41300700001)(83380400001)(6506007)(6512007)(26005)(9686003)(6916009)(107886003)(54906003)(316002)(86362001)(8676002)(186003)(82960400001)(6486002)(66556008)(8936002)(4326008)(66476007)(66946007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EiTygCLo2aOchxYJ6Y5IY7K+r/8T2VUShh3Nymd3gioXfhxicsC2HxiP4K?=
 =?iso-8859-1?Q?BqtEi2FQ/MnHvfwkP9fJrasvzI148XhF0zhRkmCCz95Gvzb9sSJP5qVlHr?=
 =?iso-8859-1?Q?tPmVStaNvNEZSEMyDXqi1TWDf6E7Xrvev9RpaFAfwnjKROER+ZzpbfXv60?=
 =?iso-8859-1?Q?jVgrizLKWUqHBljHMSPVo9unbzjs1eTUbyTRRGfi8kg+5MGaKn6+edP6FN?=
 =?iso-8859-1?Q?CRuSVYKXORpxrP1trIQV+Wp8g+X50uDpUGZBQ0CXlvj3muXSeaUdwKXkXn?=
 =?iso-8859-1?Q?xzE4jICswrLH9Ls8Bwj0gVq8s5loIPQHWstu4QQS+W1SgwmsI6YIhPj/aE?=
 =?iso-8859-1?Q?FoTUAvwm59O8RxfztY/8V3KIQLfnOleyXl4TSeh2SmNJOCOwkZuSS5nUz2?=
 =?iso-8859-1?Q?TpuVVw8f5PFPVkJ78LMUAaXnnvnv4qsTovTAwiy4zU+RSjbxvBanm4DXIB?=
 =?iso-8859-1?Q?ptt/lhK83+h7WEGbEkXjlMi6CoFCxhpU/A4V4FbLxBooMuk2aZmG94gkID?=
 =?iso-8859-1?Q?g+I6yGOELsNhOEXBWsxPZGff6SMH3s6/DTJnXgmEwAUj1KN0xgdTLQ7uf9?=
 =?iso-8859-1?Q?VO2Itz5eJHm5lE21gjIzuWeb3lGXaU00Op/c1R/OAQ7yx5iYbKLgHoqbu0?=
 =?iso-8859-1?Q?TAX/ivlLvpVGz4Tfxm+HyfuwDMTCFAtiIEEbv1QdYvAwH/CYGvv8VFCpH6?=
 =?iso-8859-1?Q?pNx0YWv1FXrkWiaurpjIh1RGmFU9LZse3g9T5MVvHyvsviXISOppQSlEK5?=
 =?iso-8859-1?Q?LlBCKnfm1TVjP3OJXFo+iSgxE74DDCrXpGY1sEgZ8sO3wKxOUHS9KmAh/d?=
 =?iso-8859-1?Q?lDhQsuJVhe3XGaW0Yf2+Rx3xTOddKKnqcb/AYbEHaZWaFA1hr9Io6AKf9L?=
 =?iso-8859-1?Q?Bmj1Yj8Qhf9t15t7RJNpIkOVfESoqPua6KCjuhxxFx3qE0FWuBjAEqoaJp?=
 =?iso-8859-1?Q?Lv+bNjUXYDGUqtDlMgq/JmP5YNftXTE0ibVeo2P2KsQmzLxpK2XEVrq6Xn?=
 =?iso-8859-1?Q?D1Ub4k/0q3NZuKYx6+pkWG33KMEvphxoGV8qbF3hdcV6/EGhKqgfK8cIan?=
 =?iso-8859-1?Q?xqgHtoyZheg+LENqX6xUEXmm+60X/4j3wEgByiqn4esN8L8Dv4cmvih5hw?=
 =?iso-8859-1?Q?KS8Sj2rpJ3gvvScGRvwlkMYAmtOQGgBRXZDW5jhBOlEWupdzfRJfzJiZdH?=
 =?iso-8859-1?Q?0bo5EPBkG3h5EpLpH9hz7+LqG/19gF7p4TB4LDI0Tke5vRXIcnJeaTtFtX?=
 =?iso-8859-1?Q?A0rdMQAg2pv7uYaNFIGrGFEKzRm8OH39laHc0qhGjukseWqwFx+H7nogzr?=
 =?iso-8859-1?Q?Vi/PNqKCY/8MxDzLe48WpDb1dKXHran6QQXIj4pnZjZD4caGtKia2yG8nM?=
 =?iso-8859-1?Q?+TQdr6IvaVpazPclAsOLQEsggOwTdteLfoyCa0xNWeKcAybGmIIZ0Ji8QI?=
 =?iso-8859-1?Q?3ycdwwoXn6Tz6XHDJkCK7L4hhMcbe8+qJGVyhGvrJtel+Qt9z9Pnai1WQZ?=
 =?iso-8859-1?Q?OBDsw50RUi7VHUCy3qGavapztP3sxR5qiv+awhmdwdm5edIbVMQOvB2LSo?=
 =?iso-8859-1?Q?JpgQr3TMWE1M/G2y90LsuYICh8faU9Pv+AZHxzZaO9DvM8en9WnfUldZkJ?=
 =?iso-8859-1?Q?XZoiOzHz19izypKHq6+W0frP0R9fkeh9okPhkyHEN8syClGkxILD79Lw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0841676f-f7cd-4ca6-40e9-08da7e031716
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 14:41:36.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mRjn0DGANPyZ/yL/x77u8jC/kCLX5F5ln8F+ojq/hUghl7iuBoBBq5fbrZ+TZj/hgP9wYRWVtuT+gSoCUSLMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4301
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sun, Aug 14, 2022 at 11:58:17AM +0000, Andrew Cooper wrote:
> >> If I were implementing this, I would rendezvous via stop_machine as usual.  Then I would set a flag or install a handler indicating that we are doing a microcode update, send NMI-to-self, and rendezvous in the NMI handler and do the update.
> > Well, that is exactly what I did for the first attempt. The code looked so
> > beautiful in the eyes of the creator :-) but somehow I couldn't get it to
> > not lock up.
> 
> So the way we do this in Xen is to rendezvous in stop machine, then have
> only the siblings self-NMI.  The primary threads don't need to be in NMI
> context, because the WRMSR to trigger the update *is* atomic with NMIs.
> 
> However, you do need to make sure that the NMI wait loop knows not to
> wait for primary threads, otherwise you can deadlock when taking an NMI
> on a primary thread between setting up the NMI handler and actually
> issuing the update.
> 

I'm almost sure that was the deadlock I ran into. You are correct, the
primary thread doesn't need to be in NMI, since once the wrmsr starts,  it
can't be interrupted.

But the primary needs to wait until its own siblings have dropped into NMI.
Before proceeding to perform wrmsr.

in stop_machine() handler, primary thread waits for its thread siblings to
enter NMI and report itself. Siblings will simply self IPI and then proceed
to wait for exit_sync

then primary does the wrmsr flow
clears the wait_cpus mask so that secondary inside NMI hander can release
itself

resync at exit rendezvous.

I have this coded, will test and repost.

Cheers,
Ashok
