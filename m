Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721DA4F6A82
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiDFTyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbiDFTxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:53:06 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E84BFD3;
        Wed,  6 Apr 2022 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649267451; x=1680803451;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QYdjH+bOBQUt6Yegvt5vRCpDONlCTMj2qCESVekkfk4=;
  b=WVy4rxXrd9ViB1LmgPh1ULUQWNXrH/pLPGF+vR2IQ9z34Lqy4I32AKXK
   n0XxXtt7MuKzlVsj8QDU2svd6KKJME65c7sKiV8oeS0K50O2xFJHy5M1J
   jk7zT7N+tfnVGdDVS+JtKaGRFa1Al++dmP4ym/0vbcowE5SpwyeE6b1uO
   gBjtOANkm/AIMOMX6b0j4M92vGeoOL4asB41uripU0AFagDxNAG8MM2rX
   9nUaXqrlTm+nc6QY3zHkt53a5cWx1+YRg/J/NSn/+vOB6bspHGlF1lcXA
   VvR2V8L11RgHaYVi2YHfs+T/v2pdwO5FXINQ9h9bRw3K2TGJGoFhHEmZx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="321811732"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="321811732"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 10:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="790977649"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 06 Apr 2022 10:50:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 10:50:50 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 10:50:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Apr 2022 10:50:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Apr 2022 10:50:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB3r3gjAsDMPnFqPNQtvdkinlpeMfvMbG5TxlZvjApB1+94jZw0Ps0TxEokRvhfcWtFO6cruqXMTx/QMibXzKzwM3nH5XKrTTwEYZoOS8yWd/M4q+YBneN5CPqKgd1JyXtvksmRiOu2FBHBFPh9NFOJnu2MphxAPgwOO1+Ju9W555Ep0LQk9IENZrS0lF8FjHUEPQCxeDmwJent4CbDogQ6zkGShaJ4ySJgTOVgGa0/9Ev8FEp15LSnLze8+GtdafgcMAp266VIl1G7OtvCuqkNMtTGI20YAYAw5DufXl1DLtlkXIzqdoA5f4kVNOAe+A9WwfFcfC9bu7SEf9ihfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfyvRjbOFCTtg+MbyY3zY+yFPWSYwoe5dolFYEzvVgE=;
 b=HlD1E2E49zfMF7qiLXYSaUxxeSHKzkkkqn1TnMNcptfxDVyHXY78hiZQq0oP//LqE0NcP02FJIwL7S7qb5ddp45u8yhqTuy7eseynwPfWqvUf8wd47ILZ8jlFYWo0uzSj7en3gQRJZA7/FSuyApD2ySDsqoJyBOstbdYgVgfBvRoGXWV1AwMBFjQvc93ZglUlqrhoDSLg65hy2MWKYX40fTlfaRc9JYo7l5IrRpl+motyfdim8MmGi2T1oxwNC6tV16lP5eHKD+2PsI+AdASxfEnRwgek5Ch/VhujVG28QfSHuNaqmW2ycq2voPiEzopaZN9ei/RQfHcmx4iHWhWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB4348.namprd11.prod.outlook.com (2603:10b6:5:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 17:50:46 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 17:50:46 +0000
Message-ID: <02010d9b-b452-3577-dd1d-7013027a09ce@intel.com>
Date:   Wed, 6 Apr 2022 10:50:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V3 17/30] x86/sgx: Support modifying SGX page type
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <bac6e77fe04100d6bfebd4e13aa9b916f82bfea6.1648847675.git.reinette.chatre@intel.com>
 <Ykvqf3Ws6jlN5g+p@kernel.org>
 <b41d81ebcb6934765d7f37d4ce95baa16ec9b5d2.camel@kernel.org>
 <d8cc2142-c50d-fbd9-425f-01e279c9a0f1@intel.com>
 <94f62e19a630792f78e3c48895dfb792ecb02c6c.camel@kernel.org>
 <70962fc4-1624-2fd8-4d8d-f1a31001e165@intel.com>
 <55cd5349e58c44113ae976e04ea4c6dc0cfba66d.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <55cd5349e58c44113ae976e04ea4c6dc0cfba66d.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:303:2b::19) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e157cef-3559-42bd-bccb-08da17f5fa71
X-MS-TrafficTypeDiagnostic: DM6PR11MB4348:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB43482013A8DEF4A57ABD84CCF8E79@DM6PR11MB4348.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vClVxNPp4/JUYM6iKo0XrANRsMIfzYMa87uiwBLLLIYm/ghrkDcuR4OlSBd/GFDOi+igb1Ba4IsoJu3h2pjSw0ndM0D/yXomJOyzMHax2Wgy6kx9CUm49LX0/4UxiXHwpzJesrj7nEiqbtcGd2TDiUAi2dR04FuKhe/uUENn/IS+NB33FXvxoTZRkl5EpFs3ehBdRAtYhizZgZW70WPOkVL9nWUo9s2AmbVaLJeVOWt76Q69ct4Yy5FCcrAb/2Qi4HMHx4SYt+bqv4/M+kcX1W1ToVhjokH0n6twTpf7AW5K+JrZ/0kTLPljMQ36I2qymq1lR5OX2vitIFahtpKnlfAyH4y+zr+cH9qZjPv96vmjZtz1wu6PoIP5NmcWTqgrAkaypLuwwh5nI8MaINq358Zpp/uNHt6oZg2JEv5Y0TNVvICkW4AuN5Fj54eqgV7IkmPd91XBfYe1WwNg+ioWo+HGAhOPNacGw71U81EolLlEn38eVqf8n+pXje7VdeGdqICR2/+FR2XS0ndN7n255cwo6zXaBvcPCUGg/6bvV7hLa863gEVxPc9v2IDDXAJP2xwtmndhBLEJv0P9bQYpRoqn/x4NSDxtDMIV3zkGxtgnTmEI+rNNWXOJmilcPFbQ+zo1JOsAw608etPEpUSlqGZB/eKX3aaojtNWbqLIVCiq0LVKcrntXeIp6MQNTwTtmwRjAFGcUTyGZFU7xhcHWN8ocK23u5UiZCvUYeka13I9Lq3h1ZdI1WvorviStc0p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(6916009)(508600001)(316002)(31686004)(36756003)(6506007)(53546011)(6486002)(26005)(2616005)(7416002)(82960400001)(2906002)(31696002)(4326008)(66476007)(8676002)(83380400001)(66946007)(86362001)(44832011)(8936002)(38100700002)(6666004)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNvK2dPRVhpTnErZ1B4VWt1K2FYQzB1MU9ZUWZaMFR6WHRIN25nYVBFQ1JE?=
 =?utf-8?B?V3lOeWRkTStsYk1MZ2VGVDZFbXYxdVRMb1BycUtjWVIrb0V4TFpPdDEwbmtQ?=
 =?utf-8?B?cC9uOVl5bGxTQk9TbDQxeHJKMzdPeGRDWEhDMXQ0MTJFeU1BTDNqV1hUaDFt?=
 =?utf-8?B?MTRYa1dUNjRJMmVWKzhjSGFJa1ViL2d5U2g1SlhRN1B0OWJwaG9uNDNXckVW?=
 =?utf-8?B?eG1ZMDJaTXVqdFhWZmI0enFpYlBFMm5hMm9CRkN3QkZFcFFUYmVpdEFCMG5p?=
 =?utf-8?B?elJGc28zUkJRbHdVYnBJTFRkSUNqdGJrdXFnUWVzVUpwRTV0VWFzVGg0WDVD?=
 =?utf-8?B?N3ppcWJSSncxWFU5QlJobmdVRE1DWFJnZFVUTXpremh1U2hDQUZ2YUJ5S3R1?=
 =?utf-8?B?SFc3Q3h5ek5sekhZM3E0WEhzWmpoaG0xUG0yQ01QZjhpWkNqUjZSQ1c4czBu?=
 =?utf-8?B?cDNHMEo2YTVFNk1zMDlVbU91SEFGZzNoU0lvMTE1QXdiLzRPdU1FMFh0aGk4?=
 =?utf-8?B?MjlHczJpVmxiaWdiaWhHL0VHV3VzZ2U0Q1NqYXFBZHFaYU1LZmxISXFOenRQ?=
 =?utf-8?B?a1JrLzkrSnBBUCtNdzdkMXB0M0d3MVZJcWFpWDI1VUpKa1hvQTh2dEY2dG9O?=
 =?utf-8?B?WHBlQmdQYWxYclRoZ3ZWRUIyVTZPbi9hNzJIbjJibXZYMzN2V3pWWFJpdHRu?=
 =?utf-8?B?S2FuYmkweXg5em91eTVyY3h5cmRXZnc0MVdtc1NmUzZwTThlRWg0bFlkVlFO?=
 =?utf-8?B?TkplT1drTjc5SklERldrcEliY2tDTmN6TDZLcmJvOW1sNlFYeGYwQlh5MWxO?=
 =?utf-8?B?ZkxXSk1QMWNtTnZzTm8zajAwRGVZUVdydDVoV0laTmR6anRoQmV6NGdwUTg0?=
 =?utf-8?B?aGpWS3A3NTZjOUFRZC9rV3N4cUlLZ0hYM1YrMk8zd2svRDFFTHdLNW45T1JK?=
 =?utf-8?B?aVNlSHB2UjNxQ2FkMTdJa01va1l3T092aXlOKzhldVZiajlJWnRxQys1Mllw?=
 =?utf-8?B?ZFgyYmpITWdhcmN3dDVmRGQ2VE84VW5kZXBvVUV0aG5hVFhZaEY1bXdtSWgw?=
 =?utf-8?B?WHMwZEJoc2xSR2JIam5CcEJ0enpJYWhXM3Fub1VWUEcvM1RkQXRVcHFQdFgz?=
 =?utf-8?B?cmhXU3J3d0RnWUV0Z3dYelVFUmxFVXNMUFVmWjZoNnIyUUdwSktmcUJZR05E?=
 =?utf-8?B?dVd6b2lrREJodUdLNEFXWlNDUGQ4SFRhaFBzeHB5anVOcFlJWG1WbXhUOXRn?=
 =?utf-8?B?NTE2SjVXeldSMzZGNWJKWjVKMnU5Zk1JRGZiajR3a2tCQ0J0RUF5ZGNOTEdh?=
 =?utf-8?B?OTZJMDEwZEJHVVAvcHE5T3NnVWRRTGRNYlU4SHBFUVVOaGR4MWZBcDJHandP?=
 =?utf-8?B?QVlRdHVZZlBCTzRMSU01M1lNdUcxMytvNzVuNzRpbUUySzM5Q0lvMzZNcnlN?=
 =?utf-8?B?cjVuUy8vdmV2V3NrMUJvdlU1YWVNelhwVDJ5V01VSnlTdUhaZTBuNHVTRWdR?=
 =?utf-8?B?Q25kdlZGbkloNWxzZjlEZFplRnpwekZJWG9GaTY0UXJJYzB1bDk4bkJjbG9k?=
 =?utf-8?B?L3QyMnRwRW9udE8yWHNMNUFVYVBzYjhiMzJra0lZRzdJS2hnR1pDMGN0UzMx?=
 =?utf-8?B?MW03RnBmaXB4NU1vd2Ric1RSc1FBQW53M2dUK1cyRW5BQzZsTFJLdllpSktx?=
 =?utf-8?B?ZGlJODRUbXBlWGJoMWJLaCtNdkJiblhqbWFhdDJETzNUYWpDYzI5SFVzL0I0?=
 =?utf-8?B?SzZ6OXIyV3RoKzNuQTJGUWNJbllPRDlHejFMV0VpUFFuWFoxaGhWemhqTm9W?=
 =?utf-8?B?N2lSNEhNbFNGL3Z6MGJIZUg1SGgzNExVNkRXRys5UllrblE2WUM5ZTduRHNy?=
 =?utf-8?B?TmhVQk5ocUVpdk9waUE4Qm1XRXlyOUpRZWVIbzFZQmFjb0xtTjV5dGxpVm1N?=
 =?utf-8?B?WmZWeG1WaDliOW1XSjRuQWZFRDVJRTB0SFJPeDVISXRyQWc1YXVPMzhkUzV6?=
 =?utf-8?B?WDdHZXBJZFpSTEVjblpkSFd2QUdLUWM4ekI0YkJpaEJzV20yL3Y5eXJnNmlU?=
 =?utf-8?B?OEtSVE9RQm9hZi9Bb1QxR1kvMWI1TVpZRTFMWmxLclF4TVJpM0hkSWV1YjQy?=
 =?utf-8?B?RWtnY2JKdiszWCsvQlNSWVhzdldKK3ptZGk2T0JiZjV0UzErTkhKN24wa2c2?=
 =?utf-8?B?WkJON2t4K2VQeDQxL3IyTVU2bEFNekJ0VXhDb1VkNnNNeUFNUDgwN1RrSUNp?=
 =?utf-8?B?Uzg2MGxFWnZZTU9rRy9KWEtoUk5JNjVTNm41U0cwclVwdHYxM2NlTHUrdm1F?=
 =?utf-8?B?clZMK1c3Y1lOZlA2Q1ZZOHdjUlRaQ1FPVnVFZmdBYnZWd1RtcWR1NTZpVmsv?=
 =?utf-8?Q?xCIAZ/N60bW9PvF4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e157cef-3559-42bd-bccb-08da17f5fa71
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 17:50:46.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PZRk6+opuJRjz3dWc0V8GyiIr2Te78v98Yion2PFaquhrOwe37dlAqEujz0SDFGyAi6PyIJ8deOyKD/xhJFluIRXbYbZhHnF3Kq7W2vld0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4348
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/6/2022 12:32 AM, Jarkko Sakkinen wrote:
> On Tue, 2022-04-05 at 11:59 -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 4/5/2022 11:41 AM, Jarkko Sakkinen wrote:
>>> On Tue, 2022-04-05 at 10:05 -0700, Reinette Chatre wrote:
>>>> Hi Jarkko,
>>>>
>>>> On 4/5/2022 8:34 AM, Jarkko Sakkinen wrote:
>>>>> On Tue, 2022-04-05 at 10:06 +0300, Jarkko Sakkinen wrote:
>>>>
>>>>>>>
>>>>>>
>>>>>> To be coherent with other names, this should be
>>>>>> SGX_IOC_ENCLAVE_MODIFY_TYPES.
>>>>
>>>> This is not such a clear change request to me:
>>>>
>>>> SGX_IOC_ENCLAVE_ADD_PAGES - add multiple pages
>>>> SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS - restrict multiple permissions
>>>> SGX_IOC_ENCLAVE_REMOVE_PAGES - remove multiple pages
>>>> SGX_IOC_ENCLAVE_MODIFY_TYPE - set a single type
>>>>
>>>> Perhaps it should rather be SGX_IOC_ENCLAVE_SET_TYPE to indicate that
>>>> there is a single target type as opposed to the possibility
>>>> of multiple source types (TCS and regular pages can be trimmed).
>>>>
>>>>>
>>
>> What is your opinion about what the ioctl() name should be? I prefer
>> to obtain a confirmation from you since you originally [1] requested
>> SGX_IOC_ENCLAVE_MODIFY_TYPE.
> 
> s/TYPE/TYPES/g i.e. SGX_IOC_ENCLAVE_MODIFY_TYPES is fine.

ok, thank you for confirming, will do.

>>
>>>>> This should take only page type given that flags are zeroed:
>>>>>
>>>>> EPCM(DS:RCX).R := 0;
>>>>> EPCM(DS:RCX).W := 0;
>>>>> EPCM(DS:RCX).X := 0; 
>>>>>
>>>>
>>>> ok, this was how it was done in V1 [1] and I can go back to that.
>>>
>>> I would name the fields as "flags" and "page_type" just to align
>>> names with SGX instead of trying to mimim "posix names". Otherwise, 
>>> I support that.
>>
>> I will move this ioctl() to use "page_type" instead of "secinfo"
>> within struct sgx_enclave_modify_type.
>>
>> Your guidance of "flags" is not clear to me. I assume that you
>> refer to the field for struct sgx_enclave_restrict_permissions
>> where I think "permissions" to only contain the new permissions
>> would be more appropriate. None of the other values in
>> secinfo.flags are relevant.
> 
> I'm fine with your permissions field to the restrict ioctl.

Will do, thank you.

Reinette

