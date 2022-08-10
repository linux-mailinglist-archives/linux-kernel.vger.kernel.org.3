Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8F558E797
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiHJHHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiHJHHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:07:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCA74CFA;
        Wed, 10 Aug 2022 00:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcqa9X0Ka6PfU26V+dskoz4ZlMDvyJncMAPr0c4fbsERLrnvPKS9BVxGYlPBYjRcZUnMsPny9BXU96uTBJ2GWhNaMoqwo5ODi3SnmKVvbLgI15/2LwnN+Al9YMcfCjwY6pS6NBfUu7/9ul4alzRnFSdl+wcNuLUXCJ+h1CbpGAOwbCMSXX+C/HAOG/2kokBVG745U6m/qiwIoRc/6pj1/OKln7+B1pHlA3Xh1SSb5dbAEsZ1yoxW1my5ua81Ymd7NERqyQ8TQ9BPjAeR31B55XOcrWUFhGroOYhgdn0eaqOmS15p4DkQK/DKOOmR9cRvrtEVunekmyKpUF9k2rZloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve5nfEAtRdkA5f1HmqWO/FpqvoiXF0HJasJGkFJiBlc=;
 b=XUPAZ4k0Jn/kIpFe8D+Q6PIgdTTD5FRkC54Yql1X6UNvlHG7CK1WBQLi66oybSuwHLjeGoFsvZTa6guTEqpMdaOYBaqSINQnI64eFI+RLU1A+BuciuRgl45ZnnGKD9SZSwS6lJuBhd+aDIIOgA0nFoBDQ5HBpfqbqqzFF2Zj0BNEGpjtZs7myMXJ7SBOBAM1H/kKrCOvb4WYSgzw8Bu782fQV9Y9cjpHhl5PQhImFSsjYtcQ0CSs3UtfyvdpQR3qpcobaEKPI+ktChmrt+B7INWo4A+waDh91PUdCPqlQ1tbjKpY60C7xhMWPHODNii/GYXBzbyAB13MjHFOhlEk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve5nfEAtRdkA5f1HmqWO/FpqvoiXF0HJasJGkFJiBlc=;
 b=m+dq/k1dVInov9VzokQCFOaqPP1bHGutPuS9GQ+5hegdCd94p2TJrNE9ax7frtXrWnwNnq294ul16cTIFEwtkMR6JtPxuruBilYy6Q8stW8APi27/H32cyfFy+aa5I/5sZJZeElgFwWUXpD/x1eCRRwcgfcMHjJcchQwDmR2vOBr6tUlxbrqJyE9xEI4GdB7wBR9ZWWIXKqTBmf2AVpEq6OHswbmNYG6ae2TaUhueSwdWohwPYXSxTqCkETIsRblIUG5OeeFGaSQzWhAyM8ajhiLwG1UcWKpMzoGxN3QED4Ea4JSOgBNRjljQeZJjiTYhIkvYfHEgk1aIm86U+N13A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AS8PR04MB8836.eurprd04.prod.outlook.com (2603:10a6:20b:42f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 10 Aug
 2022 07:07:09 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2d5d:bae0:430f:70ad]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2d5d:bae0:430f:70ad%4]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 07:07:09 +0000
Message-ID: <d8930edf-d138-6ef2-81c3-ff4d9003066b@suse.com>
Date:   Wed, 10 Aug 2022 09:07:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/4] xen: x86: set the config XEN_512GB after config
 change
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
References: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
 <20220810050712.9539-2-lukas.bulwahn@gmail.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20220810050712.9539-2-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::15) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66127261-71c5-4e61-b687-08da7a9ef0cc
X-MS-TrafficTypeDiagnostic: AS8PR04MB8836:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PW0Zid2LEhxL0yZdPSB2Oov54SWlSjbOtuxNxDSTFnWejAidBHu8R8D0KKGdlCG2SEX/VQIox1EMvuQr7rWDQ+RylH0jRYUIBL+SE6OM2XeHWdR1yiB6oCHtlyyTpmmetP4o5LOkEsCk9l+iW+Cmr6sPTGmYb7Wu0SNB3X41zyrvM1W97EVC+JJYwQ6yrHsU3q0XeYp+jOXAayF6uwNTjHicy1Opm5uHb2PU8QHoiN/IcN333QbdRKnZJymjY4IYCRuXIsFrUXRy81oBo3qtdK/c7ull6fxpjJ5j5UcocQ9Z/ijg7votyLUwbkplShj4Qjn0dKahkwynWMKkYxRlIaMqD9rPbaGztQqz3f4AyF320Va/sw6WqKfjltX5K0Y81XSNt4U6HTURD/XYrRm2q9saHNKbos1YC4uAhTzxuV/jIbmVEPSiWMa3/KnElCzGhaHZrAettsxGMq6gyYYpYaYYpsd7OUEXf7NNcj4LoqwOJP26qO/MIDeeF298abecIbyYzuukcLLcUeMH8Q6I1qlfUvkTDK9Of+9jdSCa6OMfXp5uogxMXg7/pn2Omjrm02/TASf/6jMEhylHXIf+CljoDTPImssZheClFccvbD/5+TYF9Hgowqc1QCtVY24mqNXnFWds2wzu0kU91dxZhln1nCZcQdZkn8wZoSDmk4DATJzSdZiDbaptrSavZKyhdVS5S3iBVtRnDNTAIt20UpHnqlZPoZim/fuYXho5OAbd73RVTXfAB+DQbXL5KP5fEH6zZ3lXLiYxlYlyHQKEeE9paOIhD0vT7zWsBSHZQFXiEKPx5n1b3GEyzJw2K37w58L6StdBf0BWy6u8Uh6pcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(39860400002)(366004)(136003)(31696002)(86362001)(6916009)(38100700002)(4744005)(7416002)(8936002)(5660300002)(54906003)(316002)(8676002)(4326008)(66476007)(66556008)(66946007)(6486002)(2616005)(6512007)(26005)(186003)(478600001)(2906002)(6506007)(53546011)(41300700001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TC85MFoxMlVsVWwwVFdMd05JZU0zQ2dGSGNXMTI4ZTBsditJaEtaOFJaRnJ3?=
 =?utf-8?B?Q2JWWnhqYUlvNkpLQlpBbEYybkxBOGI5eHZ2WjBubFlzT2twR0NsbkV0VEtj?=
 =?utf-8?B?YWR4Ykc4RjlkOUlmZlVoME1KLzc0bjJqeXRRTWpsZ3R3WW02cjR2V29Fa1dw?=
 =?utf-8?B?eTUySFY1TElHcW1Lc1AxdnlaM0JVa1RyUkVrRFBQVDZWNG9adUQ2VTRhUDlT?=
 =?utf-8?B?dTVqWUlpeXBGcnVFM1VaV3cwaWpBK1lZRlBJZkk2WWZuS1RwY0xIZmhxSUlC?=
 =?utf-8?B?UmVXYk13Zy9NNmJtaUZnL29BNThSSkdMZDJiTmdUTDFWRjVXZzVhZXpwVFA2?=
 =?utf-8?B?MkI4MEo3Wm4yZk92S3NJV2pIaDlpMFpuV1lFMEp5d3o0SjZvdUM2YTNnTGRV?=
 =?utf-8?B?M3FrQmlNZHdMMDNVS0tQYTRvN0M3UDA5WWlrTXp2VVV5RHlxZVNycUJFZ1dS?=
 =?utf-8?B?ajc3OVlXczNQc1NmQ285MVNaL3kxUFo3d0JIdVFlWXp3dVVqWllpZnNjdXpY?=
 =?utf-8?B?MHNzM1hsYXZHRURxaVM4akRLYjkrM0tYUjRtMzcrQTRFL3B2cjNaWTlhM0Jo?=
 =?utf-8?B?cHJQYzY3NEhJVXZSUWRoM1BTWVYzRGY5NWhYQ3FmRm1RUlFrWHhwV29kZFhN?=
 =?utf-8?B?bThKbmJRcVlqVTU0K3pQY3hiSkY0aHUzWmRocVJSM01DNU5oZ1RhOTFWTTdu?=
 =?utf-8?B?VkNXZkN6WGk3TGFySG9mbWszQWJiaEVnQzBpVU9IQlpGbW9IZEF6OWVkZ1Z0?=
 =?utf-8?B?bVdsdkQ1UHNvQ1gwcXhwMk1VY1RVcVF3bWlBL0REbTh2a2YrYzBIS0NYRDlz?=
 =?utf-8?B?UW9uUWZFYWUrTitoallwZ01QblZwNGU0d0QwaFpRQklSTURDQ2l3cFQzZUs0?=
 =?utf-8?B?TGhEZFJJVGorV1FPSkZwcjhkNTVHT2p2TjRaUXpYT210Tm5TdGVrY00yRzQ0?=
 =?utf-8?B?RkVUYnJzdlhlSGFacnlBYmNIWVlRS3cranlyL3c2ZkVrWHBha3pLWk8wNTJz?=
 =?utf-8?B?WVkvdVMrZlNTZDdsc3NBR3RnR3RhYm54RTc2VEsxWHNOdDV6cFRxV2p6T2tP?=
 =?utf-8?B?cEszVm5LMUhrSTh6b3NVaCt3cGY1ajlEWllWeEFXeDh3cDZ4QnJGcE8waWpp?=
 =?utf-8?B?elliKzFtMUdSZWJiMDh5VS85NllaL3RYR2xzUTA0VEF3QitJblR0N1dueHFq?=
 =?utf-8?B?QSsxWEhjTUR1QXlFVkorcTBXT2oyYkZKQThWUTNHL2dodUk3bVdrSW9peXVr?=
 =?utf-8?B?UDJZUDMvV2NvdGdBVHN2UTFxcVdwMnNGNXhWNjg2ZXhTUS9XTzFDT2pmU2tG?=
 =?utf-8?B?SVgwT3VDdDFwTWdQRmt1dUNVNCtoQWJ3WVJMTlBnVlJkNm9DTkY0eUg5Y1ZX?=
 =?utf-8?B?ZVc1T0kzdDYvd0c5cGwyS1AxditUcG4yUXBabnNoYWo4Z1J4TjZQVldrdU5o?=
 =?utf-8?B?NjAyem9rSmlieEpmNVdUdGtXM3FDcEtSUk1IVmJUd29jbUxzVXVJaUNpM2lB?=
 =?utf-8?B?aFh3YU1tT2RDWUNUY05NektuQ3lMQ04xTlVSNXlTU2szVFdxa2tTNFFPRmlN?=
 =?utf-8?B?ZjB6QzBiQVNmV2NFTlVMNXBmenV0NWVjM3RsSUJyREkrdnBrQlVGU2xOU3cy?=
 =?utf-8?B?cDJqY1RRcGFuRzd2WExuY2JlRE55eWVMRU1yZU9RdTJyVEtZdWNNcEg0MG1a?=
 =?utf-8?B?b29Zc2p4YWZaUnR2TnNtR05BaEFhYzg1cWZTZ1dBKzFFVXh4aitRM0NZOHA0?=
 =?utf-8?B?aFB1dVQyYi9XNUJON1RtZHQ0elp1RXY3SEdySmdBcTRzdGRiT1BnSlRUL1RT?=
 =?utf-8?B?cldrTXlaZVN4UTJhbnBoN3VWVTNja1BPUHhzaDZKc2FPZ2hBdDBWamhjTXF4?=
 =?utf-8?B?MDJ3MGlYYmpoVVN6eCtQWUxrUkRid2pESzVSaU1MZVRxMmh4b3JxTzVJZVMr?=
 =?utf-8?B?ZXU5ams5QnhUdHVOczV3MlJaRTRZSVJDeW5vQ2h1SUVyVTM3aWdSS3BrUmlD?=
 =?utf-8?B?V0g2MWRZT1FWNVBJSk5XZVRpUkNjcGNTalo5SkZvanF1SG1LTU1VRTJ1eEwz?=
 =?utf-8?B?bVdpL2lkd3VURmsyb2JHWFdiM2JMc2R2TG5sK0RyUEg1MnczUnlOSEVrVFpi?=
 =?utf-8?Q?1ZK/7IXXRDntO0jt+zNq84y2i?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66127261-71c5-4e61-b687-08da7a9ef0cc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 07:07:09.0965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6TPmTE9f5WmEcxpSSbi3a3SnNnuLUuqWa/HhnLQypaXEwES4IZrdUD+dFxUaZebzVX35TMcdjUwJEzFfmbglA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.2022 07:07, Lukas Bulwahn wrote:
> --- a/arch/x86/configs/xen.config
> +++ b/arch/x86/configs/xen.config
> @@ -14,7 +14,7 @@ CONFIG_CPU_FREQ=y
>  
>  # x86 xen specific config options
>  CONFIG_XEN_PVH=y
> -CONFIG_XEN_MAX_DOMAIN_MEMORY=500
> +CONFIG_XEN_512GB=y

Does this actually need setting here? The option's default is y, so
it ought to be turned on "automatically". Hence I think it's only
the stale line which wants deleting.

Jan
