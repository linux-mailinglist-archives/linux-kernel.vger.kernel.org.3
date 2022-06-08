Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA68542BC8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiFHJpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiFHJok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:44:40 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60094.outbound.protection.outlook.com [40.107.6.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660E31C5D5C;
        Wed,  8 Jun 2022 02:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRgaYbQzDwTKhk7/QUuI8EIfXqw7TP8lG2ydmSFU7ZuSHpMCdykL4pJrHoKGDC8DwEoVoTAIu7JAHDx3fkvTeSuxCz6UIALNHt7uju3nllqe+H7pjEBLLv6NM9oOxmfFIRJz5Sju5hdX2fv3cVWN4PSmrloDaF87yvOc8uiq8oA563SwFZSywaKckX0dDisWqkBakfeVQUCw2p+/ONq6Uv5Vq69bOxLS36BItyrdzg6voUPBxgM8HCbg8PaxF5iaHEoYhZvOKXjRMu2g9ggasJ0cDsJUBBBiDaBwsvnnjYVXAw5K4ac9b2kywIgPCvcy7XMEnksmCWzJuHwnZsCfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrNm4dUTdYi4XPjccOkMYQkqNHOsbI6B6cGic3y7Voo=;
 b=hvKL50zp46WrkOgoekj+ecueWZ6Vi/aBL8sNltMScvrNm6safGK6pXrMusd85aJ+Cc7C1LhfnP3eVlbyRIZxmrJYhaDuaNE5SbP1SDJaT2n2dc0V6Vy5V9dKO95iihDN5S/ul6/gDiNFLfy927VZduGq965Rp2jyB8XMY+s7ubsB9PPcsB1m7sS5C0woZCemHJ8+nLfxRduqln1DxPyOLcl+7bicpOzLsA2X2FRlUv1iNAnNAfbuylZtL+I4BsvN1y/BM1ifJPo6tzn4CvEA1qjLIxaVznM6l5UAC5F40s7eqy6cy8x2pORAn2bfYAsV4DoQCGSQgGN1TesAqXiRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrNm4dUTdYi4XPjccOkMYQkqNHOsbI6B6cGic3y7Voo=;
 b=gREzaw5HH29gKfYf7+UF/QVpaF+PN03Dz9zrLM/M3DJVU+/jLucIUUR1ClVcsLXcg3pt985tRJdQBTKCVxnw1MoxbfpXFQtoBvn+I06KfdNiTgKPvz6bKmmEh1lVf9lwoR87w8lQtjH8JB1Vu2FpAQDicDfLGTuHlQ5MwsGl6oA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com (2603:10a6:20b:4cd::12)
 by AM6PR07MB5125.eurprd07.prod.outlook.com (2603:10a6:20b:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.11; Wed, 8 Jun
 2022 09:11:35 +0000
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::1d35:9369:bda:b3a0]) by AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::1d35:9369:bda:b3a0%7]) with mapi id 15.20.5332.011; Wed, 8 Jun 2022
 09:11:35 +0000
Message-ID: <b9634f95-bb88-d5a7-633b-b7082504549d@nokia.com>
Date:   Wed, 8 Jun 2022 11:11:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mips: vdso: Allow passing build path options
Content-Language: en-US
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <23e2afda-630a-f6fc-e211-a464b29496f4@nokia.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nemanja Rakovic <nemanja.rakovic@syrmia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <23e2afda-630a-f6fc-e211-a464b29496f4@nokia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0701CA0072.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::34) To AS4PR07MB8658.eurprd07.prod.outlook.com
 (2603:10a6:20b:4cd::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec5af0a4-6685-450a-1048-08da492ee2bb
X-MS-TrafficTypeDiagnostic: AM6PR07MB5125:EE_
X-Microsoft-Antispam-PRVS: <AM6PR07MB5125A11475B683E10A012FBB88A49@AM6PR07MB5125.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jugKourDV5CelkE2iQlNnNNpmC48r5N0zAlcC68VZHSxu3XFIEWjpSjUG8s8BPRW9tVBTYvigpToZRv9YAstt/doaKeE2qRO6VlFfCUg9NnRL93+haEXZvLDz7jqpzNzyS6IJL3RVotXACrDxNXJacyZC9dX7oKJGdncPuWlkiV1pfamUIytc8HEepmlcRPqaSqq61B2OuhEP+G4H2/TKAv+fpFl65g1+/I7SeR6tRfAx9UuGTUOavAaMbxVuE7YO579pCPFr1VSmMLMTRQATSLNsPTWzJ6MCrNmEVIgtdVTYsoA+8FgxXn5zPCdpNAHyXzrGLBfSMpOKTyU6E3wZi15VMkG1fHMuTHWzgWnj/1iXXpxmkTwCLEaXylMpB2k1kLNIlrNycHA7RZJluZ6QLklITrBsHL2QPB6q3/gRygvWp6Yo2oR1r57bnnx1kQ5b9brqBQhs0yRn70rNcI0896wIdy25cisxdDa+jHBwGo7NUd/XBcY1EEU8ZU/nSgaxJwp9/fAa+8qwen0w4KnhY8kDbudtFfIpOJo67TR0SorDLCeQ+5RMnY6Oq3Pn3fo8u7OP0BUeU8vIR6djWNg5dtYNUEwhl2RsHS256RsvtSYka/zEkhHmKao7JQJekAkFKiMKgPQzNC4OJ74YYSf1pT4rCmIgmolHCTUyZaoO0P5QM9DLiC6SD4PWUecN8LMXk793uBIWzYdpydahJdpfo2q+MORhE3tf++AKsPYMfymHxzSJhyoOLnpc6pH8mSoV/vcO37PUTR9D60KLVNjuRMLfb6Y1FIru0cJDdjEN4zNb6Upe0mt8MmeMHJrVvwk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8658.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(186003)(54906003)(110136005)(36756003)(83380400001)(6506007)(31696002)(66476007)(4326008)(82960400001)(31686004)(6666004)(316002)(66946007)(66556008)(8676002)(44832011)(26005)(38100700002)(86362001)(6512007)(38350700002)(53546011)(508600001)(52116002)(5660300002)(8936002)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzJqMUVaSWIvZXE0WkFTZkRieXd0VWNxUVhSS2V5UDFTSFdkdHVsZTdRQlBU?=
 =?utf-8?B?ZEYyQ1VkVzVhZ1RyZHJ6ektIME92cUxZYXJSWVkvYStjWkRkOXpsYnJJUElh?=
 =?utf-8?B?K1I2ak12QjVUdVBHR2MwZ1RnbnB1eVhPL2l4Wll0bHV6Szh1bGdTNFprWGJ5?=
 =?utf-8?B?TnNUZktPMFVMUFJSVWxreDNTYSt0UGNLKzVBdnE5SXFFUEZ0eWhyRWZPYlZD?=
 =?utf-8?B?SGNOaUpBa0hDRjMvaDJEYmwwSHNXQmZNTmpFSFNjcHA0UGlCbFh3VEh5V3NL?=
 =?utf-8?B?cXpuU3hEZTBqczBzVC9GM2RiNk15UDM5M1VQZmxyNU9TVSsvQlA2bEdqd2h5?=
 =?utf-8?B?akVIME1xcFRDenlRNmJxN0FVS0pFVTQvbXowV0xxRkl0dUd6VGU4M3R2KzN5?=
 =?utf-8?B?UUJxVXd6SVdjQnFvUTJoSkgwQ3JPWkxlOGp0UDhoczRtMS9oUXhjS01wczk1?=
 =?utf-8?B?V2xKOHVHTlRTWDF5dE8vT1NVUXJMWmV0ZVdHZEY3d1JUSTlaMWhyR25qd0Vw?=
 =?utf-8?B?RjIvR29vTGhSSFhjdDB0NVI3VHNiSjJwSklHOFhJbm1TODdkNjZuZUFnLzV1?=
 =?utf-8?B?WmZsMS9ITEgwUjhzcFcvNEV6bDdrVjVXTFZ2VlQwNTA0UGt0NnM1MkpyZ1h3?=
 =?utf-8?B?akFLN0QwV0xTeWdLWDREWjVrWjFjREhmTzRZRHFBOEJRWk1SK2RGOXhFSVVt?=
 =?utf-8?B?eUVHWHI2Z3Rta203eEhoNGpHVnhOOVJBNkJ6RWNxTGY1QWlLSUJPUzB2REcv?=
 =?utf-8?B?SVhtNXY1eEdET25zWmZDa2hsb3c3UDRnSml1Q2JiUWNkRjZLYjZUSmNVaHNW?=
 =?utf-8?B?WTVYOTUwdXQ4eEEvWVBtTHBwZ0R5M3N1bERDSzd4SVZrWGJmY2tkWlZzS3NL?=
 =?utf-8?B?a1VqdGNFM0tzaEtjVVJFb1BvQ3VKYXJ2WVd3eitDRXRnT3pSSEttR0I4d1pH?=
 =?utf-8?B?R1lhbW5qZEswbk9zSjFjQzJyOFBWU1UvNEdMeittYllaY2xpWmREdURSd1d1?=
 =?utf-8?B?Um14bVpTNW9oOHlvTU9sUzVhTUFCNHhIUWN1SVIzc0I5VUh6dzRkTUZFaUFH?=
 =?utf-8?B?bFR2b09xMkpKbkV4M2ppWmdMVGdJUVlOTXpwMkNUL1J6SDlsZ1lzQkRGWmZ6?=
 =?utf-8?B?QmcrMTZNWXJER3YvOEpONE5FdmNOUm5PQXBxV2lvMXdkS2ZacVdiSTYrak52?=
 =?utf-8?B?NndTb2c4a3ZtMXRkY0E0RndMUDB5K3ZrN25NcWR6R2cwRU1nQ3FGQWFCYVhV?=
 =?utf-8?B?SGU3TUc4Y1BpUlQzVVlycUFHYzMwd3h3akd0V3AvZk9wSlhuWHZMaHAwZGJp?=
 =?utf-8?B?ajNlbHp2OVc3YlZZUm13b29id2VSNzcrbXhqdEZ5WlZ2dUtKSjgxQVd0a0I0?=
 =?utf-8?B?OUVGODRWU0Nha0VIaGhDL29OcHM5Ny96SkttQWc1MVB6d21qdmhWTFUwektt?=
 =?utf-8?B?VUxJcVh0M1lxNkVPT1UxZHdWdHBWQlNhbCs2M2FoMmM3SnpZeXptYUQzQ3Ax?=
 =?utf-8?B?cGdxcGdIdnBJN3oxTXJBVmNVcU1SQlhNcE9zUE9ZMnFZSGpkRWhVL25tWjF0?=
 =?utf-8?B?U2crNGtxbWJRM1N1YzRXZkhRTHRzVXM1RlMyMEIyK0V3NFAwQ2xjUkdZSVlL?=
 =?utf-8?B?Si9jMTZoWWk4MWo4bi9Hajg0NklaOUxNOVdtcGhLclRyT1NyY0hVQ1FzNG9a?=
 =?utf-8?B?VDFrTDQwVGJ1MWJDNDN2TGVKTDIySnBWQlhyNnV6MHR5MEVDNEIxVW5HRWtu?=
 =?utf-8?B?cjZ6SHRZSnRPZ2VPRUpPWW9UclhMVTFjMHpJU2pXbUhOdW9HSzh6M1lrRnlR?=
 =?utf-8?B?RG5IY0x3QXd2b2FkSE9ybHZBS201QXlPV0JiMHFRWVhYS0tpTGJwKzFLQUp0?=
 =?utf-8?B?bGpwSHYrRmZqWlUxOGI4ZWV0K1ByMjhLTEg3RXVtaWFnVEFSN1A3cHdDTTFY?=
 =?utf-8?B?elIzc0hyWVdsUFlGRGxCeXlpREQxK3IydEFYcmJ4TzdZTy91L203UHA5NXJt?=
 =?utf-8?B?UHRQSHVsdmR3WnoxVHpvMHM4anBhcjZ0SEREZlFLb20rRFdKeU5SNFhlaUtm?=
 =?utf-8?B?R2Y5SkE3RWJraVkxY3N6VzMxY2dqYmtMekhVallzdVBzRmU1QU00Wkc2TTU5?=
 =?utf-8?B?Ync1aEYyUTRUQWRneUtpWkJGSnRqbEhhb0xzeHFVaUJOV1VqMWxObmJWcFNB?=
 =?utf-8?B?RXpuOWk0UmNnaklFdUltNEZ6Qm43ZUp3UEp4Y0ltVE1uc1ltMEIwcnJWQ0Nk?=
 =?utf-8?B?enhLYXdydHdVVWdBbDgxcnpKMmlmYVlXa1NNaXNrSnU4cHY0anJTY2JhKy9N?=
 =?utf-8?B?T2txSXJOSTFHc002dEZXcmlqT2hmR0FpaGV4RFNoRC9YaUwwYkxaS0ZqeFhk?=
 =?utf-8?Q?Y8c3F3M+weJY+GVOsQfBaafOCxRWZvTf2T/x4?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5af0a4-6685-450a-1048-08da492ee2bb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8658.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 09:11:34.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8uyctH7eCKvKwOYcQlicq6l9Py6eZxzbKz7DaMnSphBzRzwmIjKLCfE3ZR0nVX2o8z19aFLb6nPG2rKRYf7T84BGz7dp5boUwbN349IAYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB5125
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matija, Thomas,

On 04/04/2022 10:36, Matija Glavinic Pecotic wrote:
> vdso image is not reproducible in different build directories as build
> path defines vdso image contents via .notes, build ID. Build ID is
> hashed across all sections (prior stripping), debug sections included.
> With debug sections containing build paths, hash is impacted. Finally
> vmlinux is not reproducible as it will differ in vdso_data.
> 
> For users wanting reproducible builds, irrespective of build path, it
> is unwanted behavior. Issue is sorted out by passing related options
> via KAFLAGS, KCFLAGS, however due to mips' picking out specific/subset
> options, these are not getting passed through.
> 
> Allow related option to be taken if user specified them.
> 
> Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
>  arch/mips/vdso/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
> index f72658b3a53f..b8296ef2bfcf 100644
> --- a/arch/mips/vdso/Makefile
> +++ b/arch/mips/vdso/Makefile
> @@ -35,8 +35,12 @@ cflags-vdso := $(ccflags-vdso) \
>  	-O3 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
>  	-mrelax-pic-calls $(call cc-option, -mexplicit-relocs) \
>  	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
> -	$(call cc-option, -fno-asynchronous-unwind-tables)
> +	$(call cc-option, -fno-asynchronous-unwind-tables) \
> +	$(filter -ffile-prefix-map%,$(KBUILD_CFLAGS)) \
> +	$(filter -fmacro-prefix-map%,$(KBUILD_CFLAGS)) \
> +	$(filter -fdebug-prefix-map%,$(KBUILD_CFLAGS))
>  aflags-vdso := $(ccflags-vdso) \
> +	$(filter --debug-prefix-map%,$(KBUILD_AFLAGS)) \
>  	-D__ASSEMBLY__ -Wa,-gdwarf-2
>  
>  ifneq ($(c-gettimeofday-y),)

-- 
Best regards,
Alexander Sverdlin.
