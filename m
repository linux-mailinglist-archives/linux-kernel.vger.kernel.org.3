Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339CA52AD7B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiEQVXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiEQVXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:23:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217E43ED04
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652822613; x=1684358613;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3oOhseVlkXgjM3OkgTlLwljbahFOIP5hSF9BIqweUeA=;
  b=KyovHJtySsyZeSPLFN2kePwHai/E4BYUGmtrScz8Xd4VZaY6cSUdVnhd
   7HildK/BdWQlcyy4dDFB+0RnsCMrtXJWFQd4VhMjeunVYbnxNpggpsMHH
   j6Ku5J4JDwI+geFmxZAmzscvvzbJlL/rOq7FZ9ucnFqTAHj+rf0RkhYrM
   SwXfpD4i+5FftmsaJ9dQ4e31KzsyXDPZJLQnZhYeazxSFQRkqlWReYw2T
   dGeX1TSakoOHEHv23YdidI49fdrq15izQ2Uxs0J2/maWmORpo0a6IkhgW
   ungGXGVsQvYiv0D1WZ5i1x5YtEpBpoK2LpH8GPkGO+23vWemePYPMDunu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251852470"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251852470"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 14:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="569101610"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2022 14:23:32 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 14:23:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 14:23:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 14:23:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 14:23:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/b7kfGkcH9tdcuq4mwq9lcn61SB76TzgYC2kSMMZpAfllQcSAsW0WA5nnmxoQI6LVQmC4m0JJZ24KeNA2uMBZVsz7hucrBb18oUHUKzt00p9ovLsEnQif7vBT0Sg/04nXc4eIBDWxfW3pZrk8o+G5MCYMcUuUfcdgDBT8hC2pCJte/SVV1X3fIS8ueRnPiSjmB7Wjv8eg8yN/864+6DnD+Ss6APHHSCU26utUCSj/p1J/bCgOv5gZVogopEUhhW7/ZPphJ5TT1Me1gyEL0GXprftm32lORwdzV/s9X7mBe4sQxguOEsPaXCWrG92o6/3urCE6aNN3RT+VJuRT2maw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjHBO0K652o7+LxjK3pxRmrWj0X3oV0hKbOGamw4RUU=;
 b=WoC6XToNZ38IYDzMrPBAJYnce/LcDf3G1B5zqRot1gstdBj6VpDf+TixfTwQ6deBEifGj4MgDUt0Vt3HReyUcRdnuOlhlepH1DhnfGegewjo0qwxxRcQAor/6DWNp3xz4FkE1tRQn+71lNLSVnjgESfgjprhqjZqmk0FMZicyVKJMdkODmD5s4Mb3xZe59f1NVSyFUkqRPMesmmllNcz2RKqJGQAh6xJWRFLCc4iAWp4fJYq/ozUcbeY5QcIAS4X2X7KjpyJvNKwL42BhLUq8aE4B657ChkE6uLY+Bb985pzpdDV5rhgqZHyz24fm2Scw2vBebVEcEcFgQIaChCSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM5PR1101MB2202.namprd11.prod.outlook.com (2603:10b6:4:50::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 21:23:28 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 21:23:28 +0000
Message-ID: <39264d40-265e-b41f-913f-c21325678735@intel.com>
Date:   Tue, 17 May 2022 14:23:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH v4 15/21] x86/resctrl: Abstract __rmid_read()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Xin Hao" <xhao@linux.alibaba.com>, <xingxin.hx@openanolis.org>,
        <baolin.wang@linux.alibaba.com>
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-16-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220412124419.30689-16-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48)
 To BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dc43603-a414-457e-0404-08da384b7c4f
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2202:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR1101MB220216C01B8578D55DA30EF1F8CE9@DM5PR1101MB2202.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEbB9WHtljXixywd+ok07yntFP8OKB3tYMwaVCA/hvA66w3Koe29M39ALoL9dIwYvu3jzFzjv/ZnEvEzxj99B+y+UnAQt7rlQtpk2znZnv3a9y5fBDkZHZVAs87gAvDu84bRRjGF5L/RGk0pyb+4392/XHi8rSPAjLg6bhlmCRxk9ebiVTqWjVu49l+UivsrgSdMlVOF3yCwJTz8YK0pTFZmgriMfMxcsc1k1/eX0XvJXd6L5gLz4RT95YuXsVJsL2Ix4jGQjGcu5JD0D9LJ2xkEIJmYKvvvxZM8jKxTm1f8pVZGynHb0zkT5te/KK/hO4JIKudscIHpgc1QhXMQto9koMfny0YYz0Zff2MAkJaFvbasI2lh8Kip8aZ+ObA4y1Uk9HJP1TXZVfzAqgP5tywixaJ03Dmb0OruNikzig7j3VwKGovIi9YxxBDUhlRsW1LBxZyihgUAJP4VcwIwST8h5xOl+PELGmRoO0DK6USNNidiG7xlBMNKOeTiD2/ZqvKoEkLQBeADiOtOL4CQrZBgOKPROQSO2VW6+Pyt3fJhHmNoshzmQO04FUnG7ClXDqU6T4uHrlEJ4SsRqV7jB9cMLJLBpQ2/bSxZthnY0Wa380N2d4D75Pkb84aESLqGSRNiFT4Q8DvW9pdVk7m6r0jVso+Eh05y1KnDcS9h4r73rG3eDDWlXnIurtTW0Qi2DT3ske5RWaBZVMFcFNDZEqaSvlL8sFMFkkzsPH1sDKBxX7nwI9v7Nka43rh+Nuou
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(31686004)(5660300002)(186003)(26005)(4744005)(6506007)(36756003)(53546011)(66946007)(44832011)(2616005)(7416002)(8936002)(316002)(66556008)(54906003)(66476007)(6486002)(2906002)(508600001)(8676002)(86362001)(82960400001)(31696002)(4326008)(6666004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2Niamh5UHd2VDk3bmZBRzIwVVZQN1A3emVYRjYrb3hJNXpsTFE2cjIzcjZO?=
 =?utf-8?B?b1lVeXBMVW91ejFad1hEMzJ2dUZLWDVuSUtJbkpSODNRa1c0dnhjRkpSK0kw?=
 =?utf-8?B?dEFzREVCa3pEcWVnemZ2WWNCRXhvTVczSGJseTFZZnE3ZEhYWHJPaElyWFlx?=
 =?utf-8?B?QitzSC9pUWE4ckdrK2ZRMnAwQjhXNGV3eGd2NjJvK2hzWW5POHdjSDhuckdS?=
 =?utf-8?B?cVBCTXRpUytwSVJ6Uk0zZ0hWSllkNHorNkliTnU3WGNkNURldld1WDEwSlZR?=
 =?utf-8?B?NzZzcUZoWUxEK3Q5NnAzR21MRGdlR3NMaFNiRUJxL1hWdkpSaDJDVmVxbzRF?=
 =?utf-8?B?KzUyZTdBSk9raU51Si9vbG5ENTllZ29jbEJ0cDAzWmtSSG1mT01oOFVKNWlF?=
 =?utf-8?B?OXFMNjQvUy9XY1hISy9Tck9kaGdyalRNNHlpd0RIMm80U2VKb0c3L1NMY1lU?=
 =?utf-8?B?OFl3N1ZyQzdiR0F2Mld4NVVNNlp3OWR1RkFLUzAxWUcyd3Yybks5ZDZnZHYx?=
 =?utf-8?B?a3hrcnA4YUZPc2dqcU9BRDRUcUlrQXBrdGpWeHdCdFZ5NXduTzJjWVp5aU40?=
 =?utf-8?B?TFhZaFJPMk5Ramx1Q09BeEVQRGtDamJTWnB5d0xyTWd2eWhqR1VtRkNLcVQr?=
 =?utf-8?B?ZWRYQ2V2NDJDYVFSMFNuVnFtb1lCMXNIZFBSaE13QVFOa0JnaXduVS9VeGlF?=
 =?utf-8?B?TDdCTFp3YlJWR21SZHhxdEtiZVZBUWlPdlZjMTk2cmFwSjQvaGRnRVcwNzdT?=
 =?utf-8?B?dGVjdTd6MnkrdmNJSmdmRHhiRzZ2QmhBNjZRd05nYW5LN0dyRVdlYlVZYmp6?=
 =?utf-8?B?dUMxRHlHVkl3SmdOdWNiTlBsQlAxV1dsZDhkSlNidU1OZmw4K3l5QUNlMmVs?=
 =?utf-8?B?VGtIOUprSGFranhkWEZxeTZ4VlJjUHgxc3VpMlhiRjZwYmxZdWdjdmtlVGlC?=
 =?utf-8?B?MjBGMXBubzZTNStmM25LSWRDa0djK2t4UElveVhHbnJYMlZmblZjUWdUNFJl?=
 =?utf-8?B?R3RNS0drYThzNm15NEtKSHJMZUhNOUpHeEc1aWtWSkdDR0lTL0w4a0N5bEpX?=
 =?utf-8?B?MklNa3hRM1MwbHVpZmhKbVlWUVcyczYzT3dNWVU5YUswbE5QeDdISk9TVGZk?=
 =?utf-8?B?aUhqOGxNVndvaXhDRUJRNVFTQU43Um1SWEdnUEttRmlEdkQvS1lQdnE0Zmdv?=
 =?utf-8?B?MTdHVm9CbDRwTldtQ2Y3NGZPNWZPVG5BeDZmZ1lrTWtzS1NwdUd3aU44SVFv?=
 =?utf-8?B?Q0VnOXdKSGpCbFl3My9GcTNTTDhSbzI3SUd2TG5sbGc3WDh4QmZpbkd0NXdB?=
 =?utf-8?B?YnQ4WXQyS2RqcmtVdWxNQVV4VVVyMll6dnN3MU9iUi8rMG5ldllsQWVTOGlZ?=
 =?utf-8?B?NXh3NFJqWGhmZGkzemtRbTRZNkQwQ0R2NXlPdTExaWtyK1JKRzhWMEJpcFlV?=
 =?utf-8?B?QSs4Qmd6dDZsc3BMNXdWc1JtN2JjRWlmNEZJcWdJM3hBQVM1d3lmbU93Y1Ux?=
 =?utf-8?B?VWxHRStSeDJnN1g0TlhRZVU4VUh3Y3VNbDc3dnpzOEFMNHV6bGxNK2RFOXQ2?=
 =?utf-8?B?OEtBRFFrbkZCSnp3MDJpTDEyMjVBZWF6YzJkVmhpN0FqNHdWM3pja1FscHNV?=
 =?utf-8?B?ZnRyY1QrVGFxVlp6a0NyanY5cFNwdWhhUUFwZTd3Q2FhUnlySllleWRTMVpZ?=
 =?utf-8?B?dWZTSGg0VHpDUWREbmVXalBSUklHNW10VFcxemRrV0VJSS9uazRRc2dRVFU3?=
 =?utf-8?B?ZURxTXRRQ2JDSWZ2WTBsNkk3bzR5YVI1ZWMzNGl0SmROdUFWY0NzR3VqRDVr?=
 =?utf-8?B?czFNUTE4eVhvc3Bqd0R1bDdLNEMxVWFNQ2NCMDJEb0M4SUVOMDNVakU1eG8x?=
 =?utf-8?B?clMyRVloYTdBQXptRnJmUkJjcERMak5HZFNoSTZNRHpTU3BpYVl5NGNXZDRO?=
 =?utf-8?B?K1Q3OUxsWWg0Q2xROVo2d0ZHU1VwWDlWbVduNGw0d0NkOGtMcmJDWW80aUlG?=
 =?utf-8?B?OFVUOU1taytyMzZoeFRCZktHazZTUWx4TGZDOHBodnhVSVA4akY5cTdGNWVr?=
 =?utf-8?B?VUp1MVY2THc0QmJWZW9YK0ZTWmdwNEEvZ2RManhUNS9sY3hITGFJS21tSkVM?=
 =?utf-8?B?QjBUN1VYRkxzSDcwRkxUb2Q1TytWSnkrdnVjaE5RNHRXMmh3MWpDRUVrWnkz?=
 =?utf-8?B?d1JqdTNOYm9IR3dFVTRhT0l2V0hPSnNWdW5mZ0Vzc2dvUHFLOWdDMEVjTi9L?=
 =?utf-8?B?UDFyMWI3bEYzWTc0UGUzWmpFRUIyV2MveGhFT0kvbUhSWGRCS20rTDdPNThG?=
 =?utf-8?B?QkFGRW1xL0JoWmNEVG5FOW5KNEt6UXJkUVltSDU1RS94bzdneFdqVnZURmIy?=
 =?utf-8?Q?HfUB2YqYP1Sp8XpA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc43603-a414-457e-0404-08da384b7c4f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 21:23:28.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSvquTTycxOpp3+a+SqxdOKt/Pmxu3zg/7ZGQKRSJjt3klK9R47Gz262A1B8It8deRkUdAEhoYVRu/VaW3vndUzvZ//Zh6VAcjdRQuSkq4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/12/2022 5:44 AM, James Morse wrote:

> @@ -180,14 +180,24 @@ static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
>  	 * are error bits.
>  	 */
>  	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> -	rdmsrl(MSR_IA32_QM_CTR, val);
> +	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>  
> -	return val;
> +	if (msr_val & RMID_VAL_ERROR)
> +		return -EIO;
> +	if (msr_val & RMID_VAL_UNAVAIL)
> +		return -EINVAL;
> +
> +	*val = msr_val;
> +
> +	return 0;
>  }
>  

In above EIO is used to represent RMID_VAL_ERROR ...

> @@ -343,7 +355,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>  		 * Code would never reach here because an invalid
>  		 * event id would fail the __rmid_read.
>  		 */
> -		return RMID_VAL_ERROR;
> +		return -EINVAL;
>  	}
>  
>  	if (rr->first) {

I understand it can be seen as a symbolic change but could
RMID_VAL_ERROR consistently be associated with the same error?

Reinette
