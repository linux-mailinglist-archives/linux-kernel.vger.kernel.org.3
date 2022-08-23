Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E018C59CCDE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbiHWAIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiHWAIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:08:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DCEDEB9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661213315; x=1692749315;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wIqZQnS5KCAuehClliWx8d2gRf65G5L2fMBKv2Vqgz4=;
  b=bAI8Xv8/yXGVngLkWS7DYcnJpEnyluAOBXcsIGZCzmLKnVZMrY23Wch/
   wkTqr6/OHH5jEpZq2RjlnkUaylDS/nkf0J/0uVkm1jui6luTCvNDpA99P
   qJq/9O5mc0zFoAFe+w8kuty4EcOqtGg7idZklg6678n0EXjZ8fvH51/CA
   HWmDMquDHdbqF00Su6+oecDAui8FCS6F70GJkpNPLBZ9B9C/drxDuBLBF
   hITNGV1UpAmeIpIBOViI9DhKpVtVmoNfHaoY2sWks0xBW60X9gcspz/xl
   lTBLrEb8iI8m0EvcGESGBn5Hje3Qpl7eU4zOG9bfdADl56M6XrbHSIe0m
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280523817"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="280523817"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 17:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="698477406"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 17:08:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 17:08:33 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 17:08:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 22 Aug 2022 17:08:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 22 Aug 2022 17:08:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK83S+QUriedf72Kka1kdldKeH5Q3j36nP+ZQDnYiuqdkxuHFWjXWJLHpux421mhhvD4o5e2IsHNAmcvucd5Zn/WdredOyYxO/Zb8YISWUgwjnUOhOj1lzqD+d7H1vB/Tn7bd1iCwBBB4oTr0IxVFDWUY7ybETXJ3tvXRcomI4OYomSj2SqKfMsNfO43nRobVRnXIoiphzjjJLnwHYhBL+ywOLctbL67JI1K6C8Xxc1ypaCy/lNxIBIBg/FyDpP3V7erZ4CC2OI5DDk2w/X0FNyE/n3QgK4mR7CKZ+TSpVtzyHN67eUF9dwRRYM6iGF4U4ej4sV/vZwZmUMGRXatog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrG3US3YROO1TLAhYfPAdNKgyNV0+4ku8Q9Kjlp3NpQ=;
 b=aCpuMJOEUib0x6ncSdlfIwhU3IVUl/Ciz4VyLL0XtXUWGRVnO9s3Iji5hYd8l8HR7vIeYWPnaV8RxWMVAP6Rrhsg52PPVHJchDxAb0jM3uHyOLnM7qcjI/WicvpczvxgfjqWFW4NpD5FmfFlGV70kHZstm/vx7CkWaFjZ7COgtS7uxX5IYS/pqjmX6/761f45t1lvY1pIWawxbmVnZChFW5Rkv0LElAue64zLHTca09XuBxB55tKW8M5yBPEioqRtyyzIIGNgtOeWftEjZwAgmNxo1rlUXFDAqXsI4UxytGWmfsb6bronWiPZ61j1+rUvC6d6QDW9uuBZmH6DUk1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM6PR11MB3785.namprd11.prod.outlook.com (2603:10b6:5:13f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 00:08:30 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%5]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 00:08:30 +0000
Date:   Tue, 23 Aug 2022 00:08:27 +0000
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
Subject: Re: [PATCH v3 2/5] x86/microcode/intel: Allow a late-load only if a
 min rev is specified
Message-ID: <YwQae9yhJyjAQ5Xy@araj-dh-work>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-3-ashok.raj@intel.com>
 <Yv9vy/GTh/QInBPM@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yv9vy/GTh/QInBPM@zn.tnic>
X-ClientProxiedBy: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e51a53f2-e300-4ecd-cd24-08da849b9c0a
X-MS-TrafficTypeDiagnostic: DM6PR11MB3785:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0da2X8xJGqU2MQBpoj+B2qQ5ShBMcsXutd3SzUgYv2ZYVlaioMK2dztG4DwOL5srKzbCIcQwZICx0TjtHNZyiJAcWl6Lvq0061YB0tm7bgJQH0crC3nasM3hDL4B1GDjziJXpJJF6Ij2q91R4gGzL3LthJ/XOi3tKNgvg55/jmbC2tLlvjlSl85dagQ63Rh+On6NeHoSKa/fmkYHglnd5wJ1cgsu67xw2/70UMZzlGgiH2bnxW7V7sU7E3teWraiCPcskZrRN23ueOQX7DVaAr6U+rkPyc7JZ2dCFEElCOBA8zch5WoBSfPV/LLBqKiL5okqIPx0WWJ2SXjk1CLYfucS7oTorYkaUQAh8SqpCCMOmGdT8kw6DndTIzpow4juseR9/l4/BlwYdN7clpHkY3+tJN9KzX3+ePzf8SNew1cYOnxkX/e573hOGi1BUSpDO/BVTYVpISicAiNJBAy/G7ZPalS1O04VJcTMZUcGdPixuKqVblGONaxAvb6+2DxtxzQlqpqDnh6ih6VdP3NcaWO8Q2AZsbK0X5JPPf1RJgMz2uNOC1JBp5980/mI/OBLpUYCbpz+DhECEakQelfPTNw9oLelN1RN8aw5UA6IaVq9G5wtmdBzea77pgLX1AavB1PcSD86Eq7l8w/nRKk/0OoXj4zje99wEo/Hd9zu501J0keyFVQNyQrIMSw2GWaMULhiwNqdFXyviq1bprilnrG/yaJd4v0bmRHXIlHXPcigN9vHGlx2i2pkkX1apbRq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(39860400002)(346002)(376002)(136003)(41300700001)(6486002)(8676002)(478600001)(4326008)(316002)(6916009)(38100700002)(54906003)(66946007)(66476007)(66556008)(4744005)(8936002)(2906002)(44832011)(186003)(6512007)(107886003)(82960400001)(86362001)(9686003)(6506007)(26005)(6666004)(33716001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R3m5pC8ysGP483pgTApz1Y2WM64Hxe1aNE3EctvmwIBaoFboCYBX2+wUhqaS?=
 =?us-ascii?Q?lTWqMAdoh1UDu7XTkbBV4RM9+pQzFp7qC831lDnTXE6nJrljQpCR0SUwB5FW?=
 =?us-ascii?Q?AC+4l/JURiHGVds4FKINkPgG3Q1SMgxmcJ9FhjhnAgaL1/b7oadGs5QW6jRQ?=
 =?us-ascii?Q?eHmRKSEdXfF3s5pXUnN0K9dPCub+sXNiJhlfLXxDMqqE9QhEIgMOe2qgneNc?=
 =?us-ascii?Q?bWJUtDF4qAbb+2MOWHqIE9QhY5ABg4EeOk0t8PVnskcOWXPKl0zk1xEh112X?=
 =?us-ascii?Q?vwqNa/G/Qbrf5F6qAN1SOINrdTGeqjRpG4HvRZwVM0J5a40AyYx+RE4TtiaV?=
 =?us-ascii?Q?f6AeCwscGEIppejaVJISDx6p11sH0An7wbGoAHsiZOSvI1s4C95Fhbl+v1An?=
 =?us-ascii?Q?lsF6JsTQRPqcCkGLp7/jioOSil9MMFifPcY4+zM4P5/bKBrqaYCiFSHO+e0R?=
 =?us-ascii?Q?6xQBEPyg5gQSFjtoser4H++ihXcfWjFh8g0Tv7p9JZQ+rxb6SbTMzoq4RVYz?=
 =?us-ascii?Q?nwTr8phDOEuSIY5n1/N80P5wUmrTGROjlmhxROkTFEDvaq3OLTWE6NHerdPf?=
 =?us-ascii?Q?zj5Zo57i3DLoyR5Cn3m5hLZX2//Om0KmMJK9b/IahZuWtzH6QcZ1Nji4HdFd?=
 =?us-ascii?Q?3dTBgBM9D+ae0QgQgyaROpB+E074JhmXw9HNqG9PIHIfr3nEDtP/fmNF0f3e?=
 =?us-ascii?Q?q9DF7UW2D3MYPuknyEILwbql/SqdNDNwcXJ0YAvzsg9eyewR7Yf4ys6xVOX8?=
 =?us-ascii?Q?2icEI0SnORA3rJoY6V4IQt0h8/pcGPgEvXl12++7IUnWfNy4pZakMekgKX3P?=
 =?us-ascii?Q?dOgZihY7XaI+Ov/KuH7k9IiK+t2MH80FLYxGJgLODFZblk7E7aTQ4xVACoXp?=
 =?us-ascii?Q?ndqyuU3S3b41JukC1idfhMs9I/USpvUYfJ6wXvoUoNZOjhITePkiEfKirg5I?=
 =?us-ascii?Q?+JeJXAAkMKtq3SSAWWGqLDz0GiI6HjhqJY9cc6rlAL9dm9ncVji8eSQ5DKEy?=
 =?us-ascii?Q?b25k+GUizHMQ8vJfjq2/W4pEt1c2bJ+9IN2c6utkfMrt1UMo5x3FZCGJvn6z?=
 =?us-ascii?Q?+Ps8baayGEGuTLToWSw+xil9aFJ38uDYtEBwAbhc0/N1iD9KyzUAIOsWRXL6?=
 =?us-ascii?Q?maaUF5V0ROLnIW/PILLTWndiIDSVo9vCcumQx7QvA3r323Rta/6iQo1cdXHQ?=
 =?us-ascii?Q?WHaogAi3/AaW8uN3wLGN3X4h2cMqoijVlq5qi00IjCWXH/EGeOvogvExbRLL?=
 =?us-ascii?Q?uIDd+dEDui6RkPZKNoFr74XgU/qQrbe48g5nuVFsjmluSv+sesi/bgMuOv7U?=
 =?us-ascii?Q?iMqIY7BmAxy97ab/1K3lidyrnXwqGbGPkA9b25f1OuJ6LDicysW6EXYDUtfK?=
 =?us-ascii?Q?f2X3a4sTnS/i5aJmdIFm5RGGcy91eJQstBxIwxt0jzvnBstuPUrqlJW3T/WP?=
 =?us-ascii?Q?SWIpnGFm4q9nW+4ZajlR84+aYSEULtj1AtmUYZz5AeQDyqqdVXQKpR4JZ6kE?=
 =?us-ascii?Q?9S+M2hpXgGPLwA/rp7cB7WFoPP2JCjpSt+Egr0jke6Bo2J1JbJr9mQ+/tizO?=
 =?us-ascii?Q?yiBLfN+HDeLPZUXX8lWFzUFAoLjAnliPmZVfVkBsjJODgg2KeKML0c5y+9kW?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e51a53f2-e300-4ecd-cd24-08da849b9c0a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 00:08:30.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZeJR1JEAfsBNtjJBI5jDMCP2OSRSU2ETj3O46EtUZMOrc6E8WfCBEFYaXN3i5AViS4I1TcVrzEDMhcPWy2TMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3785
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

> >  struct microcode_intel {
> > diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> > index c4b11e2fbe33..1eb202ec2302 100644
> > --- a/arch/x86/kernel/cpu/microcode/intel.c
> > +++ b/arch/x86/kernel/cpu/microcode/intel.c
> > @@ -178,6 +178,7 @@ static int microcode_sanity_check(void *mc, int print_err)
> 
> You can't do this in this function:
> 
> load_ucode_intel_bsp -> __load_ucode_intel -> scan_microcode -> microcode_sanity_check
> 
> which is the early path.

Correct, but print_err parameter is 0 when called from scan_microcode() and 1
when called from generic_load_microcode().

We do min_rev enforcement only when print_err is set.

Should I change the parameter to "late_loading" instead so the
meaning is clear. Let me know if I that's preferred.

Cheers,
Ashok
