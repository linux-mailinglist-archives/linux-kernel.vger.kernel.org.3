Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F35D540130
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245374AbiFGOWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245348AbiFGOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:22:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C2BC9662;
        Tue,  7 Jun 2022 07:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbQ4kkGHkfo86PpuoJqqt8kDrCp7r1QVKYemU92ay9fbu57JMPV5kTYBjfUq4LmdeTxRpQblje2c/5+hCEaAfP6/+9ttZ0a03h1eJNX6uXT/OQwE8K9b6NR8gWcHc2KrrskJKcX7XNIWC4JUuqNMkfWDe0b52dyluYsrqO021Kw6gEGmrlPK605g7shGriuZpPw2DgwrxhLX1m+/KAGLFIT34d+k19WQJYF5s4Z+Jllav1LPEg9Q0hAHLNczOCAswst/e3WrMjS5wwFYCtZjtPclI2fVO8bgU7w9t0EM5DH+DAZ755j1TVLk2eo3JGAwuaxyqFQsuP7FqRvum3K1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7/ekMqh55fq/CNJ9DskeQfEpFgN9KGW5BppG2Vat9Q=;
 b=RJZaa6ntXzFd52FTFneIIk70HOoVoeE0FnMvVhy+nitAwQoIA7lAnjzjkX53yXQ5ryPGucn2JVDSPa4prgwIJrcs78ZXlSq1Qibu85w9uCAn5Ck12n178TunkYjqLmTKnM8wEKgSN1y5knX6jzlwWO9bq/AN0KZU9aQTWiSJKae9CryVFLOGQDcy4sIDisHLJOEykoMQLdSTcguZFtEV9+fgSfYRAh3XaYD8KOwtlt5bWHD7772IOy1ZJaNk9BojQMh7YPohQ0Whjob/us572dJ8rlaIzR6ljz5JvTnnQImIzq+yB+kdW+pl3FOgJusl6zhZIQXLuqJJiJH2c9upsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7/ekMqh55fq/CNJ9DskeQfEpFgN9KGW5BppG2Vat9Q=;
 b=jjcQsAfyQGp7vPO9YCHh/3MeIoHlurlenpyl3t8NznoAfimhR04D7kxKdia2HsbenAvAi9RUHwKUwYDdXI8HaEfiXWk2SFGqQZubaZpjafXDgZ1wBX0WT0zCfCJORFlTXT+G2jSsUm3yNfRXqd0LQw+FLHQ7WrsOo4CxZgmNQ/llGRd0yXHpaROVt2t68FKb2LYdkj9Qi3S1nRS0UTsPjp3n/z0Zb6rzWLXJczvul/3HIBQRVbOwpMMDZ3lQfiS/EYkDb1LhVJcf26EjF8gAoYuRixW8GeS+lv2sKeb+L56HRXzawA/zQgtfy2y5cHP5I89Eyo0b+Ne8QEE2NGHfNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH2PR12MB3893.namprd12.prod.outlook.com (2603:10b6:610:21::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.15; Tue, 7 Jun 2022 14:22:29 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f954:6840:ce82:c54f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f954:6840:ce82:c54f%4]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 14:22:28 +0000
Message-ID: <e020f60d-218c-8e47-5863-23dcb55452f2@nvidia.com>
Date:   Tue, 7 Jun 2022 15:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 06/10] kbuild: check static EXPORT_SYMBOL* by script
 instead of modpost
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220513113930.10488-1-masahiroy@kernel.org>
 <20220513113930.10488-7-masahiroy@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220513113930.10488-7-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0147.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 161eef67-fc17-4f76-1045-08da4891267f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3893:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB389379682091F3E2DFD82BA6D9A59@CH2PR12MB3893.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: llmAUeshiwyE2xiHDmi414MRE0amDLHFESPadmA66ODdLR6CUHDGejJyMMOjO8eBw0kSyn6KBPUiP7Wy8fpo47QAspwPPWiY/1Fh1oTaeflfalQ+6q3LW/A46uSEvbMMh6QZRBeM25oBzfOUPwiFKBFWmEZgvfq/AUlNN1rBxcJMd4pbF46fW6FgKFTwoHNQ5UyG+clnezAtt4eRLGgUbBRQ+aiVsdD+TbBD2xNcqz5dWjuD77SGBxXE7w+hk7U6fJ0kVTXeZ3Yyio09lmOocu2b2XPEjbpC6AJ55Z01gqYpgjBaE+T56FXQ1HUj3KXTPcI25hRKpy90sx4j0GRqe9HvpFQawZB1PQSjLKy8WG8hR0S1o8yZePfpE0pR/NV4A4rh7d17RYnGzacCDHww5e1WKnPnNaVx4cE7nsYed8IMT4fbaClNB28C+tVq0SaTeBx4V18reisP66KtTE//ZPD5NAu892RgnrfaQYCpqyYh7Sb98GxLJVYaJfrlJf+s18PN3TbjprfYbTRNPDCBMD7GX2LM303dEdou5X4RVI7TX6+z4BQkXy3B5v9r1GLKnzkSR63qGtzl63MonmqTG8mtSvKepUW9UEZRpvUGRoN9WtaMxTPKxokZApX/4Dy5g7i3RiJYyu0TSpL2p0CTDZ5zB8z9eTBLCj6vHKgvIRR0nGU3nXFGwCZUAOCGhifgi4or1hSJPeoipcFFQ/Bjr0VCIbLP4cEZmQCKWHTrgMiVeTeyJuI5QpOeQ07I328l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(186003)(36756003)(8676002)(6486002)(83380400001)(6512007)(66556008)(26005)(54906003)(66476007)(66946007)(8936002)(5660300002)(7416002)(508600001)(31686004)(2906002)(2616005)(6666004)(31696002)(55236004)(316002)(38100700002)(6506007)(4326008)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0RKRmg5MWF2a1EzbUVrYlp5UGxlWEJWWjE3MXVBWmlZUkRDVTVjdXJsNFZr?=
 =?utf-8?B?MnNCK2FLMUlUbVhPMFZRZ3JUNjkrQTRUQ0x4SUhHZFg0My9EbVVydUZkTUNR?=
 =?utf-8?B?ZFFxWEJEK1lSZW8waCtRWnVkNzZrZjdjU3lwdVNHUGZvRmdoMnFRUEVGMXhs?=
 =?utf-8?B?NVExcnVUSFlvRldMaHErWFcyZmtnUXZCVjlTWTNFaVNIVkZhZnNreXVERE5R?=
 =?utf-8?B?YWZlNnRtSHpHNkFHbDdYR0tuanNVb2U0VkpZbHJCeWlyRTc3WVorNUV5UWY5?=
 =?utf-8?B?QlQzN3hvNGdMVFdiaGJSMC9lTHFHRDgrMUxjZ0MzMEt4NENOLzAzazRRSW16?=
 =?utf-8?B?bDM1U2FGS0d2blpJbVE5dzJEZEVqUmVoQXBIUW9UZnZTUVRsRzdncEc0cGZa?=
 =?utf-8?B?V3JzdWV1TFU3b3dDdDJHU04xaDRpMHRtZ3lLWmlEdXZpYUgxN25vYXJRQlBX?=
 =?utf-8?B?QzRVRzBSUG9HSWF6dUp4NTNsVzZEOHVhdEpzOGlFUkR5aFYvaUJPd1lpSnF3?=
 =?utf-8?B?S2dWZ1VEUG53L3RuMkRoY1BNb3g4aGhUUkZvVlFEbGg1THczaXFxZU9BZmVH?=
 =?utf-8?B?UjAwVnJ4cFgvcUlyTzR2eTNoeUV1NXA0RDVOOTdacW1oQXM0MndMZDM4RWh6?=
 =?utf-8?B?blcySk0xRzF4eWx3WEFEQlNOVWl2OW8rS2htM3hFY2ZDTnhBemR0cjFCRDQx?=
 =?utf-8?B?OVpIQ0lVVTJFTWx5UVhFMUVJTDRsUnprS3NScWpkNk9hRFZ0TzlmanhpLzlh?=
 =?utf-8?B?Y21Rdzk1OUFJZDBrd1VyaC9XYkhYdE44Ry80a0JScW0xNzN3UlhKRWV3dXds?=
 =?utf-8?B?WEpvdWNOWTlueVMzRXZOYXpVOVFrOGtDcTU1dElaeExBaUdOWmJjMVp5dUtS?=
 =?utf-8?B?WVVQRmhDN284em1zNkM0V3VaczNyWXBMYWVVN3cxd0trVHBPd05vR0NCRnZy?=
 =?utf-8?B?NzZBNFVzcW5xMkpla2QvcVk3STVvUnd1NVc2SXVhUVhxcUltcklsbjdFM1Fy?=
 =?utf-8?B?Qis0V1Ezc0FHSFdLV2tnMEVCeXJXTWcySjVvL1hoUG9uY3FKTWgzMFExejc2?=
 =?utf-8?B?dkE5cWF0ZERHR0U4V0pUcE9sTFJEWEhQaXZwS3l6SEdVZHFXVjFHM1dvQVdI?=
 =?utf-8?B?RlVQM2UvN1p0VTcyZ1EybTVUb3lzYmhDL3o1Q1lQZGxvUHdSRDE5VjNJdkJK?=
 =?utf-8?B?ZzF1UlZyUnRCazhYemNjM3J5SHh1dXkyQUVIMFgyRDhFazg2VnJFMkxmNDdT?=
 =?utf-8?B?eExpeUtWNnFjMGcycm8wUTRieHVDZm9odzg1MzliUE1KRFVkVTc2UTRZOFZ6?=
 =?utf-8?B?MlZ4QVVFU0VjcWFJcTUrWEs2VWFOaC9YRmFPNkhhblJYMnhUd0w4VHFlNzc3?=
 =?utf-8?B?ZmZzYUZvT3VqZFlpS3dCRlJXSXgvL3JCYy96Z1M5ZG5nUlFwWlZwU20wNzRs?=
 =?utf-8?B?R3JqSmNzajhYYXh6Mm9kbVRROTJHU0Y1S0lpSUtUL25seC9QZzdSMk5hMWZ1?=
 =?utf-8?B?UkV3VG1tR1Z2VlZlTVkyenJBV1B6OHE5dEhzSHZBdEpFTyt0dkM4bXBOcE5I?=
 =?utf-8?B?N1dFS0huS25xTTBiMEdzdGc1UEkrOSszYUF1b2lRV1RXbHZGa1lmMTdVYjd4?=
 =?utf-8?B?NWthYThza0dIaGRpUVR2dWJ6Q08vejVoMjI5b1Q4WWJsNUxlaWlDWWs5dVdC?=
 =?utf-8?B?MWcvVktUWFBVWEwvT2IwcitLUnI4T3liLzhObXE1cFpGejZHdFBiM1I3emRh?=
 =?utf-8?B?YVRhSitWbFRJOVRQRVJtdm5wMmdud2FYZ3UrWmEwaHI0bThpZzRocWIxN0Ew?=
 =?utf-8?B?bSt0WU9YcFd0RFZpc1VGNDlKdXZCYXBQNHpCb3RqTHkxNW5hdTBiVlpXNVNl?=
 =?utf-8?B?WjJ6MVZtOEExdmkyS0czY2c0NitTWkpXRjNRdzBGLzJsVTB0SFpBZmthcXV6?=
 =?utf-8?B?UXpzcFF5QTFtZmlySXc1eGhxTnYwdVFINTdCTGtlZ0J3S3VNdU5ZbUYzcFIz?=
 =?utf-8?B?aTN0WHVleGEzaUp3anRFcUY2V0xubEN5OHpxdW1kM2hLYWNpNjB4Uy9pbGxT?=
 =?utf-8?B?U2twOUZrQTJmK0NqT3MxbmcxUE5kcktjdXBDSE14VW9SZHlySFB6bnY5UWwv?=
 =?utf-8?B?NUNTYnRaTEx5cVNPc256OFI0bXhRR3RRM1dXNWtmM2dYU3haQU1BYVY0ejBK?=
 =?utf-8?B?aWxvcldOTXdXYVpkNUV1MTl1elpQR0preUVOalZGdmF2YUZKRXFmekRJazlm?=
 =?utf-8?B?SnQ3bEY2Q3ZEQ05NTExRYzZnMEdKSFRjSWtRSG9yU3ZISWhYSjE0V29SMXlm?=
 =?utf-8?B?OCtWMm10MUt2NVR0YVJ4aThNa1pPVWNjUE5IVTNpbnBVNzJFNHJia3RxVTdJ?=
 =?utf-8?Q?b5crClZ33OO2QanY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161eef67-fc17-4f76-1045-08da4891267f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 14:22:28.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0wbqyMhqZNWWy7g8NJh4r9ONt32YNpyNeLIi5ZzdT/KoU2fQ0q0JEsTPxrECZASa2dvbByrMWnfbX/OQT2LuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3893
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/05/2022 12:39, Masahiro Yamada wrote:
> The 'static' specifier and EXPORT_SYMBOL() are an odd combination.
> 
> Commit 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL*
> functions") tried to detect it, but this check has false negatives.
> 
> Here is the sample code.
> 
>    Makefile:
> 
>      obj-y += foo1.o foo2.o
> 
>    foo1.c:
> 
>      #include <linux/export.h>
>      static void foo(void) {}
>      EXPORT_SYMBOL(foo);
> 
>    foo2.c:
> 
>      void foo(void) {}
> 
> foo1.c exports the static symbol 'foo', but modpost cannot catch it
> because it is fooled by foo2.c, which has a global symbol with the
> same name.
> 
> s->is_static is cleared if a global symbol with the same name is found
> somewhere, but EXPORT_SYMBOL() and the global symbol do not necessarily
> belong to the same compilation unit.
> 
> This check should be done per compilation unit, but I do not know how
> to do it in modpost. modpost runs against vmlinux.o or modules, which
> merges multiple objects, then forgets their origin.
> 
> It is true modpost gets access to the lists of all the member objects
> (.vmlinux.objs and *.mod), but modpost cannot parse individual objects
> because they may not be ELF but LLVM IR when CONFIG_LTO_CLANG=y.
> 
> Add a simple bash script to parse the output from ${NM}. This works for
> CONFIG_LTO_CLANG=y because llvm-nm can dump symbols of LLVM IR files.
> 
> Revert 15bfc2348d54.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>


One some older build machines this is causing some builds (ARM/ARM64)
to fail ...

/dvs/git/dirty/git-master_l4t-upstream/kernel/scripts/check-local-export: line 54: wait: pid 48433 is not a child of this shell
/dvs/git/dirty/git-master_l4t-upstream/kernel/scripts/Makefile.build:250: recipe for target 'scripts/mod/empty.o' failed
make[2]: *** [scripts/mod/empty.o] Error 127
make[2]: *** Deleting file 'scripts/mod/empty.o'
make[2]: *** Waiting for unfinished jobs....
/dvs/git/dirty/git-master_l4t-upstream/kernel/Makefile:1285: recipe for target 'prepare0' failed
make[1]: *** [prepare0] Error 2
make[1]: Leaving directory '/dvs/git/dirty/git-master_l4t-upstream/artifacts/linux/arm64-defconfig-jetson'
Makefile:228: recipe for target '__sub-make' failed
make: *** [__sub-make] Error 2

Any ideas?

Thanks
Jon

-- 
nvpublic
