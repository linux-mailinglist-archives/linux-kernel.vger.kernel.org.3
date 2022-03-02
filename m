Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4BC4CB129
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245162AbiCBVVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbiCBVVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:21:17 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A1122B34;
        Wed,  2 Mar 2022 13:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646256033; x=1677792033;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sBj+RW9FLTsnhyBtF2JY1isXyjT4NtQKsAmxNN2t3lU=;
  b=Z7B+AdKd/DRedafej247v7G6eMhJWM6t4BwSIMdp6LkjO20jomCgos9h
   U0KA48ZavnNHdLcbGGm8WfUafKDvSMFbQKJR6hqVZ26x2hX9KBEg8hVc3
   GCtWB03zfw9cVVOL/FTzv5WvaPNIsnboKnXFfbA5biGIJeH0WPE4t1UA9
   lbOkAnwaFR6j3Dh+lZ+U4xOCfqUKH8eZZtQ8XCByTCHv7Pr0oP/QdwkZG
   Px7ucUAfqVFP95w8a37BOc2J4cZGNmcJcDAuMDO5yPY1LKv8VKDwQ52nU
   Kb1WGXagSy24xCBu2MI1RuwswFJ8fiKcGlqbBXlA5OFsSa0xfnK8akEC0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253237088"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253237088"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 13:20:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="630546934"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Mar 2022 13:20:32 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 13:20:31 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 2 Mar 2022 13:20:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 2 Mar 2022 13:20:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6sY8glryherA8x/fzVjVwhy2Oez6aaLXQ30H8I5LBYI6t0n6ia2OHt73TX3Q9Znwu2djbskCQ0EAL9UAdlcwiyjlkhQzA3v/xywpAYmx2IKYeViQTmc0TusbFoDzy3mjdc2KSyfmAl9WoUYNzJROqgokMvH+mDwzovwILjPaqugy1NTnCwYlxNc4fJy3X1JaMbIZmHkPhBjdxJffPmoFcoPvwgBqQNRiUtKMBXOFNznHX3rAk9wOiNcZlISaW3I4W5MkvZzmBjb9l/+RJmpALoM5npCSIFHZOC60WpufBi2B6eiKxX6rrxuXbskweXT5Zg7eHG3YnLl2JPxJQWFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALRAkZhCM1ni9EW8bnoeXPxx+itFhyYHFlfiesP9WBw=;
 b=RM+6hEhgtJtY66hpNhZqMvC5De2i0VU6Fy+Zog/VH7udtnDb2DNxS3ZutepJ5PiX/Sxg+x47jMchOb2Hpu4hGWNQt/372R7pcNMqvaa4h86zCy7Nqze/hZDa7d0dU0Iw2iRDnZQm3aVYqTybR33eb7AxGrzK1CFtAGSZcVZjTtW9LmL2E+gHAK8210WxfyHFJX6dxxOGI6feRmsnlEXM4pR9BCUu1ptLu7axFbHydugLmdUDiUBbokT+aoMhvxGcdz4dasVMMv33dwSVHUgyIVNDCkbTCkb3qgODrN4jkoCi0GE6QJEEsv8cmLzWON2NlnlG4W3juuTHltjfS7uf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 21:20:28 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 21:20:28 +0000
Message-ID: <b2733dba-278a-4574-f7ab-f035e97f762e@intel.com>
Date:   Wed, 2 Mar 2022 13:20:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH V2 00/32] x86/sgx and selftests/sgx: Support SGX2
Content-Language: en-US
To:     Nathaniel McCallum <nathaniel@profian.com>
CC:     <dave.hansen@linux.intel.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <CAHAy0tR-64vxtFo4KXiJP_va2=WF++Q6gDaPksNxiaSB5wWvhA@mail.gmail.com>
 <86495779-a9c5-45d5-0017-c491bf6354ab@intel.com>
 <CAHAy0tQYBD2b0jdim=6Zv+hwskyd1FhpycyGF+1FBHDih9TP3g@mail.gmail.com>
 <e746026c-33f3-fd15-5303-563b3eb761d3@intel.com>
 <CAHAy0tRXxDQSuBVoEW9jzpFaWns4DzWqmFASFNGgGb5vjnYuPw@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CAHAy0tRXxDQSuBVoEW9jzpFaWns4DzWqmFASFNGgGb5vjnYuPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::16) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f41c41dc-fdf9-422d-b475-08d9fc927927
X-MS-TrafficTypeDiagnostic: DM6PR11MB4724:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB4724CBF8D84D6D238E5F16BEF8039@DM6PR11MB4724.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wu2srqOLiiHx7cEu46cywyBF3jYopbBhfGk3mxysnlaH3czLVltlkTlxqLkISweoa2qwxSC/FWa2rRohzW1hm/iAaIG8uFT1rFLq5Vwr3cfiZ9VTNhMfKwnsdCyiqY2I+FoYswu9+X+XA7eSUkY6820ibUtGkI8rCSeD2tkmCQTwKJyGZwA9D43JCxz0WnEdfkVUOoJseYvkirnW5PiJCaklGbyqsCc7nD/EC4NPCPgCImbH8pNBq29dNFpLx4ZOdwg/ZhjZwvFJ6p1sB8zBVrlkopufj/Et/4EJfDvA9Kgyo1U8ozE0XFfiQdkH/6tC6ByPz1wGg52jU6jqZhPMiKc9YiIcaVLCYPe2CHswq4xLPPHm6dArM3CZu3zXM8N4meWH66CV9o/opDootrgyY0fBgU2d6K8L1cm3TUY/arwTEPgMZ/MPeU6FDM77pblnKWZvXiubQFUqLJG+vc5YJI7xr3rg0L42TIDp4zC8EM3gzgXOsTe7eXKPFBbYhr/f0n2sLGEGDoCi62E7Bci1fitRWBthC1lQuuyPC+l00zFkX2aMobMmbSow9GK4/TXCD8zavwHvaXoiImxAnwpXzTxXWgPdR74p1ciXjDAo+QuabjnnujuA8BzINRQF7TgZ5RRZVpUQifC2cjR8PLnRpg2ZWbYb5shGfysa1AbEdFBlngrsqEDUA7KN/6Ng+mxjm0xty7SZWg86SaRvEbQcjuzdrHiTT/mV1gAG0hvrK6zYLlobT0KYqVJg2Hn7FrG1RYPg800ajihbOegwaS8ZimFwQD+bQuAKpe49KHoMZy5K4x1WCF/nIbeFLCGphVbptBuTxhJVtBuFe+gXebmrVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66946007)(66556008)(66476007)(53546011)(2906002)(8676002)(36756003)(6486002)(508600001)(966005)(6512007)(6506007)(6666004)(186003)(26005)(86362001)(2616005)(316002)(31696002)(54906003)(44832011)(83380400001)(82960400001)(31686004)(8936002)(5660300002)(7416002)(6916009)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1Y1R2l5cFJlRnM3dHdrNE9adkVVWHpqSnpSWTIyczRJVk53ajNmQ1J1MGkv?=
 =?utf-8?B?dkdOYzFMVnphUXFTcFFJVFFTZGh5cWovQ3RzdlpZWG1GN1NGYUV1WHh4clpj?=
 =?utf-8?B?dlBsd0Z4TnB4d2FlSm1tQTRwLzh1WGR3cllpb1dXVDdQazl4Wk5KWjRGMHdP?=
 =?utf-8?B?OWYrdnZ6VTFxb3FwaHN4QnlQKzhwMkNCbS9zUnBmZkdaamY2ZEtoS2pTajFj?=
 =?utf-8?B?NzZBV21aakFWdm5ndzErZzZBV2wvYmsxMENhTXI4L0M5eXNSbEl0L1JzdjRl?=
 =?utf-8?B?UG15VU5kMDRrMG1SZWRWMndXTnU3eTVKTXIzK25pdmpuNkRLWVlIcE5QUzdL?=
 =?utf-8?B?bVEwNys0TE01bFBDZlRjUUcvSDI5eFBLVXM2YWExNUFSdXh3ZEhKeWlFMHNt?=
 =?utf-8?B?dnVHYUpxNDFvbDVHS29HdVJXczNNRmV6dWlvQk0zN0NXcy9KcXVaQ2c2OTdk?=
 =?utf-8?B?Zk54MjAyeVdnamFOT05md2tjT3hPM1lkOWtqUDNncVVGZ2oyMzRqZDZhMWJh?=
 =?utf-8?B?bTA0MW5NSVhDSitxRGV1ZnJ5eC9TNGdPOE02YURidE9MaVl6RTE4em1PODk2?=
 =?utf-8?B?RkdDQWdjakJ3M0xBVy9WSUhoTXpUV0VJaTNNaitqb1pBYlVlV1N0KytoS0lB?=
 =?utf-8?B?NVlkaDRqTWk2cG9ld0d3akFVcEszSlFhWVJtMTltWXJtdHNzbDVRZFZDaW5Q?=
 =?utf-8?B?N3JaNzJBK3lMYUxUZTdXa01yV1pCRzFFbFFEdDh3VlUvcmhWelR2eVUyWjBt?=
 =?utf-8?B?REhldytsSTRiNVI0WndVaU0vMWlIYXFEZGl0N2kwNW1tdG5ESnpxNm0wQ1pF?=
 =?utf-8?B?bGltUHR0WGg0TFRnVVdIWHh6aU9PTVpYbmRxOG1lcDZEbUVjVU12RmFsNFdE?=
 =?utf-8?B?WXl1Q01WRkNabG13WjJVTG80KzhsSXU5b0hIV1FvaGhaT1k3OXZTdThRNHBh?=
 =?utf-8?B?QXVBbVdoajVqL2kvRE5SOWU3eW9XdmpvdVZPdisyT1gwTlZ3eEQ2ZVdtL0dL?=
 =?utf-8?B?U3FiS296R1k0cEdqM294V3h0ME8wNVhEZ0tSOHAvSE9PQ1RpQmhEOUc0SVpa?=
 =?utf-8?B?T1FDWnhuL3RCQ2Jya1E2ZnFRNnBnQ0FteS9FV0hScVBjWlNSM2txbjIwcVVM?=
 =?utf-8?B?a0k4QjgrcmFXVjhPcWpNYUxRZHFsekJHZWhtd0czVGtLTnNDRDVwZ3RTcElW?=
 =?utf-8?B?SGtSUGNXUG0xVWNSd3Q3aTJUU3pnclBrVjVhL0NjbGVtQzlvRnRqUFAwOVov?=
 =?utf-8?B?RUZiSGZXUHVka0EwcHVzUE9YRFlvUHpLSXYySkhoVmk0RUJOZE9YZWZrSlpx?=
 =?utf-8?B?SjNPd3paa0pYN3NuRFY3VHM2SnJtWG02Zk9NWitjcFFqeDNnRjNaODRQUy94?=
 =?utf-8?B?aGFlUms1czRGbDV0TlFiV1YxNnlTQ0EzbTFDK01zaGlveUYxYmc2cjVCOE5Q?=
 =?utf-8?B?cWdIMlhYWldCNGFoSmN6TlJZYnpvRU5aVVRWbUFTQ0E4bzNQLzRLUGR3M3Z4?=
 =?utf-8?B?UkpSeDJka3RnYkhqTlZTZkNiQjcrRTBrR0dVaEhjemUxeGZ2SVRqejR6VzZG?=
 =?utf-8?B?ZE5tUjRiOG01TE9NL2s0dXVCSEFGVUUvc2I3NjljYnlwZnBBNGNlemNiRk9V?=
 =?utf-8?B?TnRYcXpLbUFoNldKKzJkMnpzdkl2KzdybTk1LzBDNzAyTjhONzdFYnUvMkg1?=
 =?utf-8?B?UGFDY0pYVklFWFlZN2NhamZUN1FUYWtjT2Y5czdhS3FpTFRrcjVodVZMemZ2?=
 =?utf-8?B?OUJ2bm83OXJRSTM3TysxWmRVdWNwTnBZcDBuOHVsRlRjbW1Yb1RTdzVYREtG?=
 =?utf-8?B?aDZ6eGkrc3d4dTBjd1ZTcEc1SWVRS0d5K2lTVFRNRlJVOHVKL1B3WUdCQ0Jz?=
 =?utf-8?B?RktJcFRTdkxpRFI1UmlMazBHbDlpcGVNYThDbE5xUk1oTVlMTFdmN2tHVE1F?=
 =?utf-8?B?Z1cwcmNZazc3eU5sQWNEdkdCYXA3V2tPODVLVVprT3BZRTFHckFBQ0pRd1NG?=
 =?utf-8?B?R2g3VlZvd0wrLzR3TkovSjNnYXNrQUZET3VaNWtwZGZ0MnNqTzZNcHNwOGg1?=
 =?utf-8?B?TE5zOHVsZTdDV2l3Q3cwejBySmFLdFNHOTZYa0d3dkNqVDRjMlN3UVZ2NHpr?=
 =?utf-8?B?M290S0hCbFBvL1dHUTRJSDdXT3hxWnZpeVRUcUpDUHRZUWVtWFRleVg0NTZz?=
 =?utf-8?B?SzBUQkxtUUQ0R1VhOE9aNjNMRUdRV3BMVVlpWVJkK3JzN2NrSUl4bEZ5ZVZ3?=
 =?utf-8?Q?tCeiIZQF9xBbrJTLW626ZQTAJNvg5T7pdE9TT2079M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f41c41dc-fdf9-422d-b475-08d9fc927927
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 21:20:28.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eW4WINMhM1194kqI0YdAS1SeyldPCgL+wRt0grAfUeeW3JvoLiSnjTurU4STe8jSOQrH2WNAsbZ7m41OiEdUzqcSKsrAhYnFCz5zXNLe9Jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathaniel,

On 3/2/2022 8:57 AM, Nathaniel McCallum wrote:
> Perhaps it would be better for us to have a shared understanding on
> how the patches as posted are supposed to work in the most common
> cases? I'm thinking here of projects such as Enarx, Gramine and
> Occulum, which all have a similar process. Namely they execute an
> executable (called exec in the below chart) which has things like
> syscalls handled by a shim. These two components (shim and exec) are
> supported by a non-enclave userspace runtime. Given this common
> architectural pattern, this is how I understand adding pages via an
> exec call to mmap() to work.
> 
> https://mermaid.live/edit#pako:eNp1k81qwzAQhF9F6NRCAu1Vh0BIRemhoeSHBuIettYmFpElVZZLQ8i7144sJ8aOT2bmY3d2vT7R1AikjBb4U6JO8UXC3kGeaFI9FpyXqbSgPTmg06j6uiu1lzn2jSKTA2XwD9NEB31uPBLzi-6iMpLnYB8Wn4-kOBYpKBW52iXj8WQSmzEy5Zvt01ewG5HUQN2UEc7nK77YPjdALd64GWih8NpkALGwR_JtzOGAaKXexyTKGEt2pgoMaXahgj5Qgk9nM_6xGvDDJpsmOyiVv0LB62B8un4dBDrLiLPeWciCL9fvvKVQizhSG6stFz9Df7sxUpcYitR-SodFO2A_Vw-7l4nzzduqjX9bKJxOHDDeBB3RHF0OUlS3faq1hPoMqzulrHoVGPZOE32u0NIK8MiF9MZRtgNV4IhC6c3yqFPKvCsxQs3_0VDnfzf-CPg
> 
> This only covers adding RW pages. I haven't even tackled permission
> changes yet. Is that understanding correct? If not, please provide an
> alternative sequence diagram to explain how you expect this to be
> used.

Please find my attempt linked below:

https://mermaid.live/edit#pako:eNqFUsFqAjEQ_ZWQUwsK7XUPgthQeqiUVang9jAkoxu6m2yzWVsR_72J2WTbKnSOb97MvPeSI-VaIM1oix8dKo4PEnYG6kIRVw0YK7lsQFlSghGfYPCy845GYXWJm05ZWV8ZaEt55QB-IS9UwOfaItF7NGc0I3UNzU3-ekvaQ8uhqiLPd8l4PJnEYxmZsvXm7i20e5B4QlA5rAqMgJJfG9Ixg21X2ctVXn9GGJsvWb65729FSZXWDdlqpxx46Qzu-gB8-cHzhhim2zKdzdjLcuAAt3IPzv6Qkq84EdxGM3492UJS-cdSpLHp6nEgCPz3RjI5NPvAlRisJjspOsbWT8sUyc_MwjuynC1Wzyw9EB3RGk0NUrgvePRYQW2J7tNQd5sKDN5ooU6O2jXCiWZCWm1otoWqxRGFzurFQXGaWdNhJPXfuGedvgFejOuH

The changes include:
* Move mmap() to occur before attempting EACCEPT on the addresses. This is
  required for EACCEPT (as well as any subsequent access from within the enclave)
  to be able to access the pages.
* Remove AEX[1] to the runtime within the loop. After EAUG returns execution
  will return to the instruction pointer that triggered the #PF, EACCEPT,
  this will cause the EACCEPT to be run again, this time succeeding.

This is based on the implementation within this series. When supporting
the new ioctl() requested by Jarkko there will be an additional ioctl()
required before the loop.

Reinette
