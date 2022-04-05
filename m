Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D034F5018
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1840484AbiDFBKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572945AbiDERXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:23:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8139F14012;
        Tue,  5 Apr 2022 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649179298; x=1680715298;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=awf7+vdRU9Odvss0X1HqpeUtO2+BsLWZDSgkc4lMPv4=;
  b=W1KpJ/23m3gI+FUA4A5gZiQ8h4JFO3fLKTOVGiQOKDiEuF22Jya+82qF
   m2z+u/c9aUCBXctG9EFPKd2UKPAc+h/uINAMWl1xxXryITgzIjAE8kx6x
   b9IgMxdC+COTkVxuGYL3e36/N4W88uuk2PBNrdD9aH6vciawX84//fp6o
   QarvniEa0Zvp900CcYeHNz4kInIccBxjgpEcN7GVHrPCOTqZVTLXqtTNi
   y550965qqqS6FBEsPKecgJSFiIUxWwGXB6oe31hT5H8hg5hA6pM+vxCNE
   RnxeJY6OL8P4jjtZKHIBjaKjW2TdLf7UBmlzEl+cyfphnBV3YkOy0Kkfd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="248328641"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="248328641"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 10:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="523543859"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2022 10:21:29 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 10:21:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 10:21:28 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 10:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZLopGKVR27Su6iblhGounZeQYs74E83GG4ofdRtI7CJjaVX+jQp0nIENYSriWiokXfEdJybLQ32NKhH0OtaPqAJCuKBaeaWOJxVq8t346/5fmbMSKx31BCDaKNDGFbqKNuG16+RKJvk3ik8EmqUPlBiHJLCKTxjF67bqdX2B+K1sacAaILw+naRNpDFjpORiFz0TewoqH3CtHA6wCThTRXJG1ED8B77pOY8KsAwsPWznvuU5HnfCOppZad7K46NTbo4HyTBDsGiwBsQAaVm5fee67gytMDoNis8UL30rfAb1+G7tXgOtsH5UvUFGIdlOz95DGLy407MpMRqJd56wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxRxGod0d+AkoLc9YuVex+ueBLDiZC7Qw4EPGgLvwZQ=;
 b=TLUE1TDQvkxH6Hccl2oQM00tHbOZoW4yCYOW+Dqw5taubuBNjchNN66Mlk742u+zIAOL2NvNrzgg1CIN7tUQwbop1gew4tOmwjhufFIqYHiI8W3jCS1VZg2yY9tsqU+f31KtC6RNy9lfMadeOEHdtqYFwvwWAvts7gWj+mP8p0e1h9S1z+wCsXR7pv3Z8LKyVD567eH42sjFK0Ix6JDBKOYwryhKSK2ZjLuouMzmj4TLDOvriHdL5ovVySV2YXI8GRTzilo2Vsk1cqtl22DsUdVeWSqTJ2Zzkbggi0G0GrI5k2y7qAgaXPhg1Iy8tzIlqmb4HciUw32+8rNKoko07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM5PR11MB1706.namprd11.prod.outlook.com (2603:10b6:3:b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Tue, 5 Apr 2022 17:21:27 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 17:21:27 +0000
Message-ID: <76c6e673-71fb-1068-0114-c3eea93a2fd4@intel.com>
Date:   Tue, 5 Apr 2022 10:21:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH RFC] x86/sgx: Simplify struct
 sgx_enclave_restrict_permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.rog>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220405151642.96096-1-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220405151642.96096-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:303:b8::11) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 749e4ec5-36d6-44ea-c204-08da1728b7a4
X-MS-TrafficTypeDiagnostic: DM5PR11MB1706:EE_
X-Microsoft-Antispam-PRVS: <DM5PR11MB17063368EA53699053554F26F8E49@DM5PR11MB1706.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHkPPZ2mKUGw1N0IClJbWKuALYi/2DV5kTUTGAwmpzFIoLZ04so8+SjSVXaNAq7CIOg1qsPXAuv8A7/RBduQUxzB9B1aCByBPyaUZA4MPHY4ucEMpsx+HXUpK9YRP03vx4s1OgTSgM08c5G4ICd8zAdn+VgO1wUBLKqEgBZCt2CVzDiGk9i8p/F6n/06e4lBO7zMUlTIScsIn3zS7UsBdxqaWuLJm+PA7mQxchhPLwSauANB6t/meWs+8gBVQiIrhuh+VLigx5/geLoFRGx/DE4Egr0VymsHDufvC2EnYKIF4jSqy+Qg7FjHzoqI0lUGr1P5HyBDmJ9wwbgiO1rrI3+yWphLqMRnzi6X7T+F5Fc1s070nxrIiL2cbgL1cLh/+miKTgYAOBp6pKDIgudq3OfVIRxjKHB3O4bb+d1CU/GCGZ1jkuUyT/Yb/cw1krMBozbxdve6ME6Z8VF6Eqifcml7NmwAvjUlf6t8mo+UkqmyDb0Q7tiUeS/I7QiJdWlcYhkROGa75bC6b/awhA2XgqHRhkzzLq9r9UaWWATpiR5JZD47v4+FXdx4LOvnnQfAqaR9YfaCZ9l+6lbcEQhBKiQlZcliSr/4O724c5rPQqf8ZYCRkeCs7cm5k+JV6mGYUJOcg12yS+HGHr+4emnQGnMCr/MK8scEiVatjrlcxky95AwH+AozQV7eht49Tt/TvSuze4zfY34bGrfIHcR/64tNbD6ZkqYRj2FQIAC31QRPEvkT/uwop6u4Y109nTboBCDzOmCLKqQj21kqxxWq6/E9brT2AwAyzbNPcbQpyNYgLIaJTwcKY3ZG1OjP7Lp143Ppi+LRWC6XS84P1UxCdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(53546011)(966005)(86362001)(6486002)(508600001)(6666004)(5660300002)(2616005)(6512007)(44832011)(38100700002)(7416002)(6506007)(82960400001)(31696002)(2906002)(36756003)(26005)(186003)(83380400001)(316002)(31686004)(66556008)(8676002)(54906003)(4326008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTNudGJQQWhoRHlncEtib3VMSE84dHZBaWxBbjV5dXNRWkd4RVFqeHRqc0NG?=
 =?utf-8?B?eTliQXV2d3liZXpqNGVzWmNTOExySWRQcytGbDdzWkxmL2hhYXRsdUxHVFhz?=
 =?utf-8?B?ZkpGdkN2RUVhQVUxZGoyazBiQjU0YUtneXJnbDhyMHJYclk1Y3NXZXBVMGlD?=
 =?utf-8?B?bURzbjNPRm12dklHc1ZSYytpdzBldDcyYS9zZzBBNWZBWDMrUVVkL3hRVmh0?=
 =?utf-8?B?SS9NbWd4RDhRNVVZTDNEVW9zY2x2dWZ6eDFjRUZKanFaK2toaEdLVCtaYk5i?=
 =?utf-8?B?TGlDdWU3NkRpTCtxMGtKU2x3TWdFdDJ3TmdGakJNMFJ5TVVuZUMzWmtJdDF0?=
 =?utf-8?B?Q1laUnRKSUhTYUt2QXZXbWZUN0pHRlNJWVdaMkNUa0ErSmlYMHZ3SDAwTitF?=
 =?utf-8?B?OW9RSHlBM2VWWCtESXF0ZytnZDVkZjJSd0hucDl1alNoemRSZU5UcGZqdUwr?=
 =?utf-8?B?UXpGeTVmdGVwSkpvYXVHMWlwQitxeHp0N29nbENXV3FBMGRBSmtsWDdDUjBx?=
 =?utf-8?B?WitSSWhPSld2dmNNMWNQZE81UitFOUkvSGZtN09vVVJOSFJqLzI2c09kVDh4?=
 =?utf-8?B?d0crNjJDNVVSK1pUMWorTVNpSlQxOFoxRFExZkdsMS9aMDdPQzM0NW01VXBs?=
 =?utf-8?B?YmRiaHBINGdTWGdubVdyUXVzZVpBM0VjTnpCbTdlNUV3ZGVJcWhZMWt3RG9E?=
 =?utf-8?B?dkJBR2pCNkp0S2ZRWThudURoZG1TcHlxbUJhdkpPK1JHc25BSXNXNmxMOGd1?=
 =?utf-8?B?Rys5UThRNkI0MnA3WVRhUUFhUFByR2VpSStQRzBqeG9VMjNDTGtLN3VzMXM4?=
 =?utf-8?B?TUxtUGx0UXJzaTc5R29Ha3RwZE1Fd2tVOHZwcnRFMG9YOFdmVjhLZi9OdVRz?=
 =?utf-8?B?dnRFMnN1aUlkUkVtT0hzNWR4dHM0RGxHb01PdEZ2cGJZclg2VHZWMUVxdWNW?=
 =?utf-8?B?d29kMUVSb3drNjdGUjc2WlNYMkxrT1BCQXM3ckhYekNKT1huTkFNWUwvWmhR?=
 =?utf-8?B?NEluSDI4UE1XRDgyOHhHamxueE9XbC9XQWtFYmxNR1g5eG5MQVB1Z0hUTlRC?=
 =?utf-8?B?RjE1a3l4Y0htMnNTSWtOVWlDVUo3Q2cyTjdLZi90MkRMSUM2eVFUZU42ZzBp?=
 =?utf-8?B?ZlpOL1ZrRjVJMVN6c2grMzVuRXdXOFVTUFdCdkZ2OXBEMlVYTkVkVWJ1NVFz?=
 =?utf-8?B?UVJEWEtnNDZvd3ExaVZQREVLRkxxSXh4TWpwdmlOdEdUZkhzR3liaGlyNDh0?=
 =?utf-8?B?bVhWcmhpZHpKZytYaUJPWVBxam8rdENIQTM5RExUMW15RGc1U2JDYXF0UldU?=
 =?utf-8?B?OWsyeTNjNU15Q29aUEFnV0xrMGg2ZVlJQjJ5M1JPR2RES1ozRVV2Sm1neW53?=
 =?utf-8?B?WCtPbU93WU5oMDM2L0JXN1Ruam1UMXRLMW1XZ3JETHhaSTJ3MWxGYjhsbEtG?=
 =?utf-8?B?ZS9FSVBlZ0t2SzZ4L2ZoS25wNzVOaExNaU9PbWJnTzV6SHlINzFyZGFJT2c4?=
 =?utf-8?B?K0pCRk1BUWZQVm5TQjZGQVZEZWhSYnJIL241eldJOE0yb0lUZno3U2pZL0M3?=
 =?utf-8?B?K0NiMkdCcGNrU0U3ZC93TWcxN1ZSZTRQRyt5bzRuMGxKaFV3VVgxcDQ3RWZH?=
 =?utf-8?B?SXlZeDB0SGcvaldTMjlRdTlKRE4wRitkb2prT011M2dDVXMvWmxsMkZEYWxu?=
 =?utf-8?B?OU91dUVJV2lzeEVTUEd1ZjFEdS9peERqZnBrTmtQWU1iNEU2UnlvSUNXUEJq?=
 =?utf-8?B?Rjg2OHFza2JnY0JaWFNsd3ZRMm15N0lwbytXSGtHbWRZT2hRZHpwK1RLek9C?=
 =?utf-8?B?OEt2b2pwTy92K3RnaVQ5VjhjdEZvVGRRNitocEZNZTU0UU5uWDF0cEpyU3NQ?=
 =?utf-8?B?NkVXdWpoREV5bDFXSTVBclRqNWJLejZNOGFnQjJvTnVFNzhlWEVPZGUvbUtV?=
 =?utf-8?B?bWhCdTNoaG1zdUxaTGI2dEt0aTJWdUJ2QmEzWVE5Rkt3SnBVUHIzN1BXcFpG?=
 =?utf-8?B?ZndQK203SC9NaC9zS0JTdkRmNW15aGsyWHdlc1lqYk1ORnBGNCt0cXlGNm1p?=
 =?utf-8?B?cUZSY1J2RkZqVlJvU1NMdWVraEtnN21MYklUTG1NVFc0cFZlVFF0b2YxT1h6?=
 =?utf-8?B?RmYrbE9ySkRDZGVwbGVwNlI3UCtlMi9BMEVnSC9lVzhRVEs4ei9taHRhR0hW?=
 =?utf-8?B?VERwZStNMXkxSVF5ays5c2xmN29UcTBkc1dzbjM0TTdHZVR2bnhxVmxiQjU1?=
 =?utf-8?B?V3ZYRVovMVNFdXZWUUJNekFnU0owNUh0ZDlQMkM0QTZ0eEk2RzNWa00rVExj?=
 =?utf-8?B?WlpjUWFYUjR3cGdFVGxyY2NXOVRiNERpT0xOWFFSOXZNd1h6TXpqKzV3ckgy?=
 =?utf-8?Q?JcoEJShNIILCSlNg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 749e4ec5-36d6-44ea-c204-08da1728b7a4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 17:21:27.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKRBeoT3k9sultEJ+2GkaYotQ9CODgSiq0sYUCfhZVvceum00tleo7fxQX7+l4sybhrG2pItgSodYyq1GJTPgM0kakuBeLl2fGka25OcJm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1706
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/5/2022 8:16 AM, Jarkko Sakkinen wrote:
> The reasoning to change SECINFO to simply flags is stated in this inline
> comment:
> 
> /*
>  * Return valid permission fields from a secinfo structure provided by
>  * user space. The secinfo structure is required to only have bits in
>  * the permission fields set.
>  */
> 
> It is better to simply change the parameter type than require to use
> a malformed version of a data structure.

Could you please elaborate what is malformed?

> 
> Link: https://lore.kernel.org/linux-sgx/26ab773de8842d03b40caf8645ca86884b195901.camel@kernel.org/T/#u
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> Only compile-tested.
>  arch/x86/include/uapi/asm/sgx.h |  5 ++-
>  arch/x86/kernel/cpu/sgx/ioctl.c | 57 ++++++---------------------------
>  2 files changed, 12 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
> index feda7f85b2ce..627136798f2a 100644
> --- a/arch/x86/include/uapi/asm/sgx.h
> +++ b/arch/x86/include/uapi/asm/sgx.h
> @@ -88,15 +88,14 @@ struct sgx_enclave_provision {
>   * @offset:	starting page offset (page aligned relative to enclave base
>   *		address defined in SECS)
>   * @length:	length of memory (multiple of the page size)
> - * @secinfo:	address for the SECINFO data containing the new permission bits
> - *		for pages in range described by @offset and @length
> + * @flags:	flags field of the SECINFO data
>   * @result:	(output) SGX result code of ENCLS[EMODPR] function
>   * @count:	(output) bytes successfully changed (multiple of page size)
>   */
>  struct sgx_enclave_restrict_permissions {
>  	__u64 offset;
>  	__u64 length;
> -	__u64 secinfo;
> +	__u64 flags;
>  	__u64 result;
>  	__u64 count;
>  };

What is the motivation for using the flags field of the SECINFO data? If
the goal is to only provide necessary information, why not just provide the
permission bits since none of the other bits are used? If the goal is
to make room for future SECINFO changes/demands, why not include the
reserved field of SECINFO where future changes are most likely to reside? 

Reinette
