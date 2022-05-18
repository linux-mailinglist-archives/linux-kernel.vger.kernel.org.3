Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AAC52B8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiERLjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiERLjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:39:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C707F1737FD;
        Wed, 18 May 2022 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652873945; x=1684409945;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sSe8pb37mHSuU0fQqAHuE8mkew7THVuuWQMf90GkFPQ=;
  b=DOtFZ1m/QnsIr/S4r/nIDpBqKOxw43I85LXoc55ifjkK7LEK3FBvb6n5
   /KGf/UhHOPQh4K5k1Rh06Dmj+YCT6B5vhyt95NTqzQbnwHk4Dvw/zomkf
   Fci8nRnsnhS8HB1BVRT+Mb01rC+tcejonuIAMe0aUnC5fVskD2G2cB5m4
   FJjA7F7fQNwXIO/FrWnKTAKFiawnF16uBzPRCh4SpzMm9ohGkXzWm5sBi
   SFsTblsk3LtG01eC/I6qpyvB7kBZmcokkrlBdRCPOr+87vi0+V7VJIZzL
   Hm5iKax6NY/rRtHr9VabDp+j33XJMbUOYSb/M9Vzo1yv20dZD6hQcueOF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="252146253"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="252146253"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 04:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="569427402"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2022 04:39:03 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 18 May 2022 04:39:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 18 May 2022 04:39:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 18 May 2022 04:39:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKt5ydyo9YfcEulW3rlrA3HFkYcDbbjQPs24qWCv/G5SSDaX+ilv02VmM7U+vSNqHsIRXWG/7KMDiXfFmwrKTe2WZZUNqr32Xj7XnhmCtm6pBmS7A8OKFvgv1SSgX5wg31NNDVkahCRqcXLZKhR4yxZW5fj0Z+vNkNZwmm/Wwk+vFeJSkN3ZjkEeMSMCmtfzhWi52K0KijFC/VYerd+4J66DZ7+QeEpysoRUeg294qTcVTgKFoe3ugJpeFs5AjLSvvXWD1iAc0JI/sxz6PR6mWuY+1adMCC/BXa3QJiLr9lcoeyeeZzbre1iawuyrUbZQ9CtUSCdChoRwmcGohE1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJn2W+lD1ZVm+0fbynr10iOn/DswqaXqhwiESL1lOaE=;
 b=kq90hdz5Dsbat3P8Pd73TjQQsXWLeSo3uZa99FmV9G0hJDbMQWXBXrNRrwEjSaJjKP5CtpzvOoosIFrtu8te0neNfMy8gMFgrbbZOfMpHSxsrHcEyG0bx1NaM321lBY9OP2zJ73WHKojSxFZMbkh5P9/ptAN0voJpjxL6bnsmUh4cu5POLqbjFyeKvN/5Gg4rE1kaHir6QMR7FyQRX1oWaL/BN5O18Pb/QevM2jYxqnKnblXP0r/0BWWt0TajTZU+r8I0K5MwEzNn9bBDjKDDTKlm9bN/WC/PCWxYqx3l+eKqswRo2770lMa5dC5tfsILFS0tiloIC+CnHso+y5u9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3180.namprd11.prod.outlook.com (2603:10b6:5:9::13) by
 SA2PR11MB5003.namprd11.prod.outlook.com (2603:10b6:806:11e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Wed, 18 May 2022 11:38:56 +0000
Received: from DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b1fa:393c:9fb6:6871]) by DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b1fa:393c:9fb6:6871%5]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 11:38:56 +0000
Message-ID: <aafc540b-fcc6-dbd5-e38a-00c102485b83@intel.com>
Date:   Wed, 18 May 2022 13:38:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH 05/20] media: s5p-mfc: Add initial support for MFCv12
Content-Language: en-US
To:     Smitha T Murthy <smitha.t@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <m.szyprowski@samsung.com>, <mchehab@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <ezequiel@vanguardiasur.com.ar>,
        <jernej.skrabec@gmail.com>, <benjamin.gaignard@collabora.com>,
        <stanimir.varbanov@linaro.org>, <dillon.minfei@gmail.com>,
        <david.plowman@raspberrypi.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <andi@etezian.org>,
        <alim.akhtar@samsung.com>, <aswani.reddy@samsung.com>,
        <pankaj.dubey@samsung.com>, <linux-fsd@tesla.com>
References: <20220517125548.14746-1-smitha.t@samsung.com>
 <CGME20220517125605epcas5p44cbb77e6bc15ceb32a934e326fc777ef@epcas5p4.samsung.com>
 <20220517125548.14746-6-smitha.t@samsung.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220517125548.14746-6-smitha.t@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0043.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::13) To DM6PR11MB3180.namprd11.prod.outlook.com
 (2603:10b6:5:9::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1cfea47-df9a-4c4e-f94e-08da38c2fd8c
X-MS-TrafficTypeDiagnostic: SA2PR11MB5003:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB500328FAD48F78AD14A9C38FEBD19@SA2PR11MB5003.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MqZlSNBYeuXzNNzK+N99bsWtQyxyHRX2Rarxoi3UU6zo2Q1fG9tZed0KuVeTAs6IKCv/lpBMwKpUKLqbvJx0/eMjBk2RpdzXY3bFFgYSkYRQZ2uw14M4Ph85K0o2W56/kOG/esYJpjS/FRNwMz9jGAnt9uqU/aiDUcXEyI+q2qU0jg2dGRooRod8Et0iLf2iENiIzg5NdMpMQCdroN/X6QrR8YX/bVPmOg+OVTU/+K11yvjcrGo65s5TxqZBGrYeu14e7AfTORU+XHssa7NDs69TXfTaSzHFkD+NC3FGdrHbPAvxko5MoWxo4a8Wd0d0JEZlKSt1YgcQIgwqD5w3KvDdNtwxjYXV4ucG52fzt8Ny/qAxYcjBxoJQtvHOU366JnLesNygwBn1sC9wDPm0Vuxxbl1WaLZzw0m/jmRu8IylD6xs6IA4ofWZF1uuPGWshS4JRH2FKIDEEvI1kwwyHwChVOpPgEVFwzzT5IAJl9N0L4EanNZNDGK5W00pMcESoAIbu0HyKgUXtqGsWFAddg+7Oq4mQW9PD+CV7upmaDDgAoWGC6RXSxupkmNqIe4M964TYyQQll5HmE4gc5Yv8dEwyyYJqNCOd9pmfFnt16lohld3vrdC/FNEjvrBEnbrYDIFhSoZ8U6mbVHlhUr2JdPHCJZoTMcet36BGki24ofyZW2kfEoYXXsnfSBYXZH0lDWTXrbNZfJAttwqKyc2xnv26V9IpNdNUJPbkuE2RFxyZJzGpqBHxf7Q/wbn9GMkp6c6/xKCqHAzTglZiG8VuIxRC/LvDBA4hGgkHrG2hT31qNFWLPyPLbwkrfK7aWw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(31686004)(5660300002)(186003)(44832011)(6506007)(83380400001)(36756003)(36916002)(53546011)(8936002)(7416002)(2616005)(30864003)(82960400001)(508600001)(316002)(2906002)(6486002)(966005)(38100700002)(86362001)(8676002)(31696002)(4326008)(66476007)(66946007)(6666004)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWRzWW4vV3JDZ0lWUGlsb0lCL281eUxrOXZxQ2J6RWE3MytGRG1EUXlxSGNC?=
 =?utf-8?B?Y1dNUVhFeisxaTl4K25RdDNZVElkYTJON1ZDVXlmYVpqVERwSlNveUZCVHZu?=
 =?utf-8?B?K0NXb2h4SVpFWjVUR0R2NWhBNDZya1d5V3FvVzAweFdzTVFtalErTUt4N0Ra?=
 =?utf-8?B?eVNSQ1JxM3RnNW42bjFnUTZCaG5YUVFCLzJreEpiWExXWkEzSXEwNUh3NXAx?=
 =?utf-8?B?SlNsa1hBT1JaQVhxUTlrM0d1SStPdTZQWHAyYzBpK1lPTmdRS2F0dDd6OEJY?=
 =?utf-8?B?ZVRVMm5SaGhmdU5wRmdzQnJuSE8vd3pwaTQ3QnNtSWxBOG1Wd1lva29obkhT?=
 =?utf-8?B?WXRycTRCeG9rdlFlYm8vOXlsY2FCUlN5alBoY1ZzY096QXpuSldJYjJBSWg3?=
 =?utf-8?B?ei9XcEJvbFh6cjZna1JvVFgydnlXU0ZUbGNiQ0kwa002UzJ3QVNQTHFiek9T?=
 =?utf-8?B?V2FzVWhORlpicVh4cHJmbSszR3FxN0FiMkZ0ZDFPam1rTjlJV21seWpqdFpP?=
 =?utf-8?B?MEVmWWtkOE5RQjgxYXZPVDhmUjkrek0wdHFjamhkQlcweTFuTEdEeG9ZNDVM?=
 =?utf-8?B?NjRjSkdySmVlenVzZjQ4TVpoNzY5RGtDS2h4NlNidWhqUTQrN3FJVnY0N05y?=
 =?utf-8?B?UEhCbmY2SGlmT1BDMVhrYXovblIrUGhKYjJUUmlBdmF5eEVaa3RWSk5JNndI?=
 =?utf-8?B?cG5FZ29uYzdnMHVkdDV1YTNtU040U3NpdUxJMkcvZHJSNDhVZjZkSTloZWNO?=
 =?utf-8?B?dmo5VHpuNWErcXpMVExxWjVRV24rb3VIOXZUTytHa3RoRnk0Wk82ZjA5TmFT?=
 =?utf-8?B?c1NQeGdUaEFHUDY5cXdmVGdVd1BtVXRQR1lhU1hvSElRclFCV0cra0JOdEhw?=
 =?utf-8?B?dEhKb3lhcENIUU1Bc3A1dXZUOXBGZmVEdDg1bXU3Z0xWMXhMU1plcG5TZkEy?=
 =?utf-8?B?Ti94aDN5M3NCZHFGNnhxdS9NNU4xNnY0QTVZTm5HVk9MVmNsejVtYmdmOE1t?=
 =?utf-8?B?eXY4RS9FMDFodXFsT1hRcXFHbzBXYWNqWWo3YzlhUmZ1VFZpaWRML0x3Tkwy?=
 =?utf-8?B?Mm5mUm9PRW5ZZTd5ZDNXcytjYldsVVFmZmdpeWZ6bkxWMnNpWDVHSXJmT21a?=
 =?utf-8?B?cmxqU2wySDlWcEZWcDNqVHRDdG4yNHQvcUNvNjRjeEVDc1NrcnlNNXFOd3hh?=
 =?utf-8?B?VXJOMC84ZTI4VVpsdWsxWUlQNlU3cnlWclhYc2RxSjJHZ1ZqYlcvZWZHaWk0?=
 =?utf-8?B?NkZVRDFYYjFyVEpVTFBGNTd2RWI1QUJnT2p3c3FNdzFoRk5MN2VuVmpUTEhq?=
 =?utf-8?B?emdFS0dWODBPem9jTGJsM01qUVRjbDkrRHN6YTF5SXVOSmNUdTEvTDdwTFVR?=
 =?utf-8?B?bU51ZjN4Sm5oa0V5ZGRwa3grb1d4ZW1CcWd5WTBWM3pWajI4bm1XSzRudFFE?=
 =?utf-8?B?ZEt3aWxxNCtMdHFkUHQ4eVVPSFEvdk1Jd2ZkZ3g0UGp3cWpRSUhtT2lSYmcr?=
 =?utf-8?B?NURqZGF6MG81S0xLcGxoZ3RyOWdxNXllSEVFa2g4M2luYkhUc2w4TWNRTm1i?=
 =?utf-8?B?ekZNWW5Bb0UzT1NJRTErWWdsTXh2ZURsckxDZ0NEUjFPR0NHYzJXYWZWOHdj?=
 =?utf-8?B?c1UxSmlYdmRBVnpNaEk5enZsZE5iOVBkVDVpR0FTSFFVZkMyRE9EcXloKzJz?=
 =?utf-8?B?eE4rdHhxS0ZFWDRIblZSYzJYZG1uc25Zdm5vblpVNlVSOUVmNVJBc2UvNWMv?=
 =?utf-8?B?U3lXbVY4NkVueUJ1d2NsNG1BK2haMHJaYkVnTmpoMzF5eCtvNkt5dlRPUWJl?=
 =?utf-8?B?S1lWLzZMcE81bHF6dnBxRnBPd2JMM1loVFhRMU1CbnRMdVoyLzVUQWd0THJP?=
 =?utf-8?B?ZTBlTllOK29RQmtFZllSekU2bFI3L0RTbjMrQXZuVzRoaDNrK1o0TWg1cDI0?=
 =?utf-8?B?UEIwMHNKUmJsUGlrYVNDZEZiNG4wdnZ0cnF1Y083TlZnMndzRUVQMHVybzdD?=
 =?utf-8?B?b0dGb2YrTGJSQlBybkJtcTE0eDV0TXVwSnRhRzBsQldCU0pNdDJucUEyQmpZ?=
 =?utf-8?B?N05kQkdxSWcydmxYMHQ4OERnK3IyYnE1K3ZZcVB2VE0wdWZoNjNQc2JudFVO?=
 =?utf-8?B?bEN3T2pjV3ltc3ExUldMV2EzOHJDZ25iaDhtRi9sTUhyeXpBQUE5SlkzQnZv?=
 =?utf-8?B?cU5ZZHkzM2FxR0hVdzZVNmtKaWp1MVpwZkxtZ0RUck01OElwVERrWVdHWXcw?=
 =?utf-8?B?NStXYmJFYXQzQk9xZENpa202Yi9ROG85V21IQ0NzV2h0dGluQ2ZERG5zTWNN?=
 =?utf-8?B?REZZQmFqNU9EMk96UU9yRzdpc2hYZkljVmZZaE50U2ZxbEJSN1hKRUQ5SWRo?=
 =?utf-8?Q?JvitObW2vcZhA08U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cfea47-df9a-4c4e-f94e-08da38c2fd8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 11:38:55.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohVb7wqVVoZgq3SUn13pMYzdFKlm8YJEdCyftdQOvWJCiOpPCW/J+qBvPOud2Gmiyvgf4wLtCfTqCe/m+SZrfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5003
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.2022 14:55, Smitha T Murthy wrote:
> Add support for MFCv12, with a new register file and
> necessary hw control, decoder, encoder and structural changes.
> Add luma dbp, chroma dpb and mv sizes for each codec as per the
> UM for MFCv12, along with appropriate alignment.
>
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>   .../platform/samsung/s5p-mfc/regs-mfc-v12.h   | 49 +++++++++++
>   .../media/platform/samsung/s5p-mfc/s5p_mfc.c  | 30 +++++++
>   .../platform/samsung/s5p-mfc/s5p_mfc_common.h | 13 ++-
>   .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
>   .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  6 +-
>   .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    |  5 +-
>   .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  8 +-
>   .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 84 +++++++++++++++++--
>   .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |  2 +
>   9 files changed, 178 insertions(+), 21 deletions(-)
>   create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
>
> diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> new file mode 100644
> index 000000000000..efb77c2bf913
> --- /dev/null
> +++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Register definition file for Samsung MFC V12.x Interface (FIMV) driver
> + *
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + *     http://www.samsung.com/
> + */
> +
> +#ifndef _REGS_MFC_V12_H
> +#define _REGS_MFC_V12_H
> +
> +#include <linux/sizes.h>
> +#include "regs-mfc-v10.h"
> +
> +/* MFCv12 Context buffer sizes */
> +#define MFC_CTX_BUF_SIZE_V12		(30 * SZ_1K)
> +#define MFC_H264_DEC_CTX_BUF_SIZE_V12   (2 * SZ_1M)
> +#define MFC_OTHER_DEC_CTX_BUF_SIZE_V12  (30 * SZ_1K)
> +#define MFC_H264_ENC_CTX_BUF_SIZE_V12   (100 * SZ_1K)
> +#define MFC_HEVC_ENC_CTX_BUF_SIZE_V12	(40 * SZ_1K)
> +#define MFC_OTHER_ENC_CTX_BUF_SIZE_V12  (25 * SZ_1K)
> +
> +/* MFCv12 variant defines */
> +#define MAX_FW_SIZE_V12			(SZ_1M)
> +#define MAX_CPB_SIZE_V12		(7 * SZ_1M)
> +#define MFC_VERSION_V12			0xC0
> +#define MFC_NUM_PORTS_V12		1
> +
> +/* Encoder buffer size for MFCv12 */
> +#define ENC_V120_BASE_SIZE(x, y) \
> +	(((x + 3) * (y + 3) * 8) \
> +	+ (((y * 64) + 2304) * (x + 7) / 8))
> +
> +#define ENC_V120_H264_ME_SIZE(x, y) \
> +	(ENC_V120_BASE_SIZE(x, y) \
> +	+ (DIV_ROUND_UP(x * y, 64) * 32))
> +
> +#define ENC_V120_MPEG4_ME_SIZE(x, y) \
> +	(ENC_V120_BASE_SIZE(x, y) \
> +	+ (DIV_ROUND_UP(x * y, 128) * 16))
> +
> +#define ENC_V120_VP8_ME_SIZE(x, y) \
> +	ENC_V120_BASE_SIZE(x, y)
> +
> +#define ENC_V120_HEVC_ME_SIZE(x, y)     \
> +	(((x + 3) * (y + 3) * 32)       \
> +	+ (((y * 128) + 2304) * (x + 3) / 4))
> +
> +#endif /*_REGS_MFC_V12_H*/
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> index 761341934925..a4e3df24b4ae 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> @@ -775,6 +775,8 @@ static int s5p_mfc_open(struct file *file)
>   	INIT_LIST_HEAD(&ctx->dst_queue);
>   	ctx->src_queue_cnt = 0;
>   	ctx->dst_queue_cnt = 0;
> +	ctx->is_422 = 0;
> +	ctx->is_10bit = 0;
>   	/* Get context number */
>   	ctx->num = 0;
>   	while (dev->ctx[ctx->num]) {
> @@ -1638,6 +1640,31 @@ static struct s5p_mfc_variant mfc_drvdata_v10 = {
>   	.fw_name[0]     = "s5p-mfc-v10.fw",
>   };
>   
> +static struct s5p_mfc_buf_size_v6 mfc_buf_size_v12 = {
> +	.dev_ctx        = MFC_CTX_BUF_SIZE_V12,
> +	.h264_dec_ctx   = MFC_H264_DEC_CTX_BUF_SIZE_V12,
> +	.other_dec_ctx  = MFC_OTHER_DEC_CTX_BUF_SIZE_V12,
> +	.h264_enc_ctx   = MFC_H264_ENC_CTX_BUF_SIZE_V12,
> +	.hevc_enc_ctx   = MFC_HEVC_ENC_CTX_BUF_SIZE_V12,
> +	.other_enc_ctx  = MFC_OTHER_ENC_CTX_BUF_SIZE_V12,
> +};
> +
> +static struct s5p_mfc_buf_size buf_size_v12 = {
> +	.fw     = MAX_FW_SIZE_V12,
> +	.cpb    = MAX_CPB_SIZE_V12,
> +	.priv   = &mfc_buf_size_v12,
> +};
> +
> +static struct s5p_mfc_variant mfc_drvdata_v12 = {
> +	.version        = MFC_VERSION_V12,
> +	.version_bit    = MFC_V12_BIT,
> +	.port_num       = MFC_NUM_PORTS_V12,
> +	.buf_size       = &buf_size_v12,
> +	.fw_name[0]     = "s5p-mfc-v12.fw",
> +	.clk_names	= {"mfc"},
> +	.num_clocks	= 1,
> +};
> +
>   static const struct of_device_id exynos_mfc_match[] = {
>   	{
>   		.compatible = "samsung,mfc-v5",
> @@ -1657,6 +1684,9 @@ static const struct of_device_id exynos_mfc_match[] = {
>   	}, {
>   		.compatible = "samsung,mfc-v10",
>   		.data = &mfc_drvdata_v10,
> +	}, {
> +		.compatible = "samsung,mfc-v12",
> +		.data = &mfc_drvdata_v12,
>   	},
>   	{},
>   };
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> index ae266d8518d1..eed4d8f71a3a 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> @@ -19,7 +19,7 @@
>   #include <media/v4l2-ioctl.h>
>   #include <media/videobuf2-v4l2.h>
>   #include "regs-mfc.h"
> -#include "regs-mfc-v10.h"
> +#include "regs-mfc-v12.h"
>   
>   #define S5P_MFC_NAME		"s5p-mfc"
>   
> @@ -720,6 +720,8 @@ struct s5p_mfc_ctx {
>   	struct v4l2_ctrl *ctrls[MFC_MAX_CTRLS];
>   	struct v4l2_ctrl_handler ctrl_handler;
>   	size_t scratch_buf_size;
> +	int is_10bit;
> +	int is_422;
>   };
>   
>   /*
> @@ -775,6 +777,7 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
>   #define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70 ? 1 : 0)
>   #define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80 ? 1 : 0)
>   #define IS_MFCV10_PLUS(dev)	(dev->variant->version >= 0xA0 ? 1 : 0)
> +#define IS_MFCV12(dev)		(dev->variant->version >= 0xC0 ? 1 : 0)
>   #define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
>   
>   #define MFC_V5_BIT	BIT(0)
> @@ -782,11 +785,13 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
>   #define MFC_V7_BIT	BIT(2)
>   #define MFC_V8_BIT	BIT(3)
>   #define MFC_V10_BIT	BIT(5)
> +#define MFC_V12_BIT	BIT(7)
>   
>   #define MFC_V5PLUS_BITS		(MFC_V5_BIT | MFC_V6_BIT | MFC_V7_BIT | \
> -					MFC_V8_BIT | MFC_V10_BIT)
> +					MFC_V8_BIT | MFC_V10_BIT | MFC_V12_BIT)
>   #define MFC_V6PLUS_BITS		(MFC_V6_BIT | MFC_V7_BIT | MFC_V8_BIT | \
> -					MFC_V10_BIT)
> -#define MFC_V7PLUS_BITS		(MFC_V7_BIT | MFC_V8_BIT | MFC_V10_BIT)
> +					MFC_V10_BIT | MFC_V12_BIT)
> +#define MFC_V7PLUS_BITS		(MFC_V7_BIT | MFC_V8_BIT | MFC_V10_BIT | \
> +					MFC_V12_BIT)
>   
>   #endif /* S5P_MFC_COMMON_H_ */
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> index ffe9f7e79eca..877e5bceb75b 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> @@ -130,7 +130,7 @@ int s5p_mfc_reset(struct s5p_mfc_dev *dev)
>   			mfc_write(dev, 0, S5P_FIMV_REG_CLEAR_BEGIN_V6 + (i*4));
>   
>   		/* check bus reset control before reset */
> -		if (dev->risc_on)
> +		if (dev->risc_on && !IS_MFCV12(dev))
>   			if (s5p_mfc_bus_reset(dev))
>   				return -EIO;
>   		/* Reset
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> index 4b89df8bfd18..37f6c8a80871 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> @@ -146,7 +146,7 @@ static struct s5p_mfc_fmt formats[] = {
>   		.codec_mode	= S5P_FIMV_CODEC_HEVC_DEC,
>   		.type		= MFC_FMT_DEC,
>   		.num_planes	= 1,
> -		.versions	= MFC_V10_BIT,
> +		.versions	= MFC_V10_BIT | MFC_V12_BIT,
>   		.flags		= V4L2_FMT_FLAG_DYN_RESOLUTION |
>   				  V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM,
>   	},
> @@ -155,7 +155,7 @@ static struct s5p_mfc_fmt formats[] = {
>   		.codec_mode	= S5P_FIMV_CODEC_VP9_DEC,
>   		.type		= MFC_FMT_DEC,
>   		.num_planes	= 1,
> -		.versions	= MFC_V10_BIT,
> +		.versions	= MFC_V10_BIT | MFC_V12_BIT,
>   		.flags		= V4L2_FMT_FLAG_DYN_RESOLUTION,
>   	},
>   };
> @@ -357,7 +357,7 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
>   		pix_mp->width = ctx->buf_width;
>   		pix_mp->height = ctx->buf_height;
>   		pix_mp->field = V4L2_FIELD_NONE;
> -		pix_mp->num_planes = 2;
> +		pix_mp->num_planes = ctx->dst_fmt->num_planes;
>   		/* Set pixelformat to the format in which MFC
>   		   outputs the decoded frame */
>   		pix_mp->pixelformat = ctx->dst_fmt->fourcc;
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> index a8877d805b29..ae2c0977b24e 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> @@ -92,7 +92,7 @@ static struct s5p_mfc_fmt formats[] = {
>   		.codec_mode	= S5P_FIMV_CODEC_HEVC_ENC,
>   		.type		= MFC_FMT_ENC,
>   		.num_planes	= 1,
> -		.versions	= MFC_V10_BIT,
> +		.versions	= MFC_V10_BIT | MFC_V12_BIT,
>   	},
>   };
>   
> @@ -1179,7 +1179,8 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
>   		if (FW_HAS_E_MIN_SCRATCH_BUF(dev)) {
>   			ctx->scratch_buf_size = s5p_mfc_hw_call(dev->mfc_ops,
>   					get_e_min_scratch_buf_size, dev);
> -			ctx->bank1.size += ctx->scratch_buf_size;
> +			if (!IS_MFCV12(dev))
> +				ctx->bank1.size += ctx->scratch_buf_size;
>   		}
>   		ctx->state = MFCINST_HEAD_PRODUCED;
>   	}
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> index b9831275f3ab..87ac56756a16 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
> @@ -166,9 +166,9 @@ struct s5p_mfc_regs {
>   	void __iomem *d_decoded_third_addr;/* only v7 */
>   	void __iomem *d_used_dpb_flag_upper;/* v7 and v8 */
>   	void __iomem *d_used_dpb_flag_lower;/* v7 and v8 */
> -	void __iomem *d_min_scratch_buffer_size; /* v10 */
> -	void __iomem *d_static_buffer_addr; /* v10 */
> -	void __iomem *d_static_buffer_size; /* v10 */
> +	void __iomem *d_min_scratch_buffer_size; /* v10 and v12 */
> +	void __iomem *d_static_buffer_addr; /* v10 and v12 */
> +	void __iomem *d_static_buffer_size; /* v10 and v12 */
>   
>   	/* encoder registers */
>   	void __iomem *e_frame_width;
> @@ -268,7 +268,7 @@ struct s5p_mfc_regs {
>   	void __iomem *e_vp8_hierarchical_qp_layer0;/* v7 and v8 */
>   	void __iomem *e_vp8_hierarchical_qp_layer1;/* v7 and v8 */
>   	void __iomem *e_vp8_hierarchical_qp_layer2;/* v7 and v8 */
> -	void __iomem *e_min_scratch_buffer_size; /* v10 */
> +	void __iomem *e_min_scratch_buffer_size; /* v10 and v12 */
>   	void __iomem *e_num_t_layer; /* v10 */
>   	void __iomem *e_hier_qp_layer0; /* v10 */
>   	void __iomem *e_hier_bit_rate_layer0; /* v10 */
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> index 728d255e65fc..98c524688b45 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -82,7 +82,53 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
>   			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
>   			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
> -		if (IS_MFCV10_PLUS(dev)) {
> +		if (IS_MFCV12(dev)) {
> +			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
> +			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
> +			if (ctx->codec_mode == S5P_FIMV_CODEC_HEVC_ENC &&
> +								ctx->is_10bit) {
> +				ctx->luma_dpb_size =
> +					ALIGN(ctx->img_width, 64) *
> +					ALIGN(ctx->img_height, 32) +
> +					ALIGN(DIV_ROUND_UP(lcu_width * 32, 4),

DIV_ROUND_UP(lcu_width * 32, 4) == lcu_width * 8

Similar few lines below.
Anyway if you have lcu_width, lcu_height, please use it.

Or maybe better drop them and use:
width64 = ALIGN(ctx->img_width, 64);
height32 = ALIGN(ctx->img_height, 32);
which seems to fit better here, I suppose it could replace all ALIGN(ctx->img_...).
Anyway something to improve readability would be good.



> +					16) * ALIGN(ctx->img_height, 32) + 128;
> +				if (ctx->is_422) {
> +					ctx->chroma_dpb_size =
> +						ctx->luma_dpb_size;
> +				} else {
> +					ctx->chroma_dpb_size =
> +						ALIGN(ctx->img_width, 64) *
> +						ALIGN(ctx->img_height, 32) / 2 +
> +						ALIGN(DIV_ROUND_UP(lcu_width *
> +						32, 4), 16) *
> +						ALIGN(ctx->img_height, 32) / 2 +
> +						128;
> +				}
> +			} else if (ctx->codec_mode == S5P_FIMV_CODEC_VP9_ENC &&
> +					ctx->is_10bit) {
> +				ctx->luma_dpb_size =
> +					ALIGN(ctx->img_width * 2, 128) *
> +					ALIGN(ctx->img_height, 32) + 64;
> +				ctx->chroma_dpb_size =
> +					ALIGN(ctx->img_width * 2, 128) *
> +					(ALIGN(ctx->img_height, 32) / 2) + 64;
> +			} else {
> +				ctx->luma_dpb_size =
> +					ALIGN(ctx->img_width, 64) *
> +					ALIGN(ctx->img_height, 32) + 64;
> +				if (ctx->is_422) {
> +					ctx->chroma_dpb_size =
> +						ctx->luma_dpb_size;
> +				} else {
> +					ctx->chroma_dpb_size =
> +						ALIGN(ctx->img_width, 64) *
> +						(ALIGN(ctx->img_height, 32) / 2)
> +						+ 64;
> +				}
> +			}
> +			ctx->luma_dpb_size = ALIGN(ctx->luma_dpb_size + 256, SZ_2K);
> +			ctx->chroma_dpb_size = ALIGN(ctx->chroma_dpb_size + 256, SZ_2K);
> +		} else if (IS_MFCV10_PLUS(dev)) {
>   			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
>   			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
>   			if (ctx->codec_mode != S5P_FIMV_CODEC_HEVC_ENC) {
> @@ -230,7 +276,12 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   			DEC_VP9_STATIC_BUFFER_SIZE;
>   		break;
>   	case S5P_MFC_CODEC_H264_ENC:
> -		if (IS_MFCV10_PLUS(dev)) {
> +		if (IS_MFCV12(dev)) {
> +			mfc_debug(2, "Use min scratch buffer size\n");
> +			ctx->me_buffer_size =
> +				ALIGN(ENC_V120_H264_ME_SIZE(mb_width,
> +							mb_height), 256);

You can put ALIGN to definition of ENC_V120_H264_ME_SIZE.

> +		} else if (IS_MFCV10_PLUS(dev)) {
>   			mfc_debug(2, "Use min scratch buffer size\n");
>   			ctx->me_buffer_size =
>   			ALIGN(ENC_V100_H264_ME_SIZE(mb_width, mb_height), 16);
> @@ -254,7 +305,12 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   		break;
>   	case S5P_MFC_CODEC_MPEG4_ENC:
>   	case S5P_MFC_CODEC_H263_ENC:
> -		if (IS_MFCV10_PLUS(dev)) {
> +		if (IS_MFCV12(dev)) {
> +			mfc_debug(2, "Use min scratch buffer size\n");
> +			ctx->me_buffer_size =
> +				ALIGN(ENC_V120_MPEG4_ME_SIZE(mb_width,
> +							mb_height), 256);
> +		} else if (IS_MFCV10_PLUS(dev)) {
>   			mfc_debug(2, "Use min scratch buffer size\n");
>   			ctx->me_buffer_size =
>   				ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
> @@ -273,7 +329,12 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   		ctx->bank2.size = 0;
>   		break;
>   	case S5P_MFC_CODEC_VP8_ENC:
> -		if (IS_MFCV10_PLUS(dev)) {
> +		if (IS_MFCV12(dev)) {
> +			mfc_debug(2, "Use min scratch buffer size\n");
> +			ctx->me_buffer_size =
> +				ALIGN(ENC_V120_VP8_ME_SIZE(mb_width, mb_height),
> +						256);

ditto

> +		} else if (IS_MFCV10_PLUS(dev)) {
>   			mfc_debug(2, "Use min scratch buffer size\n");
>   			ctx->me_buffer_size =
>   				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width, mb_height),
> @@ -297,9 +358,15 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   		ctx->bank2.size = 0;
>   		break;
>   	case S5P_MFC_CODEC_HEVC_ENC:
> +		if (IS_MFCV12(dev))
> +			ctx->me_buffer_size =
> +				ALIGN(ENC_V120_HEVC_ME_SIZE(lcu_width,
> +							lcu_height), 256);
ditto
> +		else
> +			ctx->me_buffer_size =
> +				ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width,
> +							lcu_height), 16);

ditto

>   		mfc_debug(2, "Use min scratch buffer size\n");
> -		ctx->me_buffer_size =
> -			ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width, lcu_height), 16);
>   		ctx->scratch_buf_size = ALIGN(ctx->scratch_buf_size, 256);
>   		ctx->bank1.size =
>   			ctx->scratch_buf_size + ctx->tmv_buffer_size +
> @@ -452,7 +519,10 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
>   
>   	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
>   			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
> -		if (IS_MFCV10_PLUS(dev)) {
> +		if (IS_MFCV12(dev)) {
> +			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V12(ctx->img_width,
> +					ctx->img_height);
> +		} else if (IS_MFCV10_PLUS(dev)) {
>   			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx->img_width,
>   					ctx->img_height);
>   		} else {
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
> index e4dd03c5454c..ee2018ee95cc 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
> @@ -23,6 +23,8 @@
>   					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 128)
>   #define S5P_MFC_DEC_MV_SIZE_V10(x, y)	(MB_WIDTH(x) * \
>   					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 512)
> +#define S5P_MFC_DEC_MV_SIZE_V12(x, y)	(MB_WIDTH(x) * \
> +					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 1024)

(MB_HEIGHT(y)+1)/2)*2) == ALIGN(MB_HEIGHT(y), 2)

You could replace all S5P_MFC_DEC_MV_SIZE_V* with:
#define S5P_MFC_DEC_MV_SIZE(x, y, offset).

Regards
Andrzej

>   #define S5P_MFC_LCU_WIDTH(x_size)	DIV_ROUND_UP(x_size, 32)
>   #define S5P_MFC_LCU_HEIGHT(y_size)	DIV_ROUND_UP(y_size, 32)
>   

