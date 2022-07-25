Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3114257FC33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiGYJS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiGYJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:18:54 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20054.outbound.protection.outlook.com [40.107.2.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37EBE002;
        Mon, 25 Jul 2022 02:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi0ZQ4T4T8RKHAlNTueO8iBWjkEJUEdal7ADiLG7xsVIWfzCeJsCtpsPsFZTBiWB1Q0iJy3150L0xqB1JrsVhavkcwSzIHSBimC1ITD7VKFuHIqzqETA0Td28NlzmgG19Ki5WVFPCPXh5jD6F2qJ/zcW0LHrwxHngvMT7bOsgSSoBGgyJyrDKtoEdjq+naQYWcm/BDwpNlRVdGzgBmpUCI/Ei47zgpDLjU8e9142OJNeoyjpmMPRxIqAhUGI4cDmM0YbdhhGfJ3eypKvHrT3lLvqyIyPSplWRxWlRY+kPemxw4s6cMl9QhwgtabDiSJtfORjBKWJAPLNdOaHE5OgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CksbUOqC0EZjFvntr55eiViD+ZeEbB3XxfMcpXgkOMM=;
 b=ap3R/52dHbfIT/VH1QTB3C7XXknxhEB/WR5FVyX32DTm7nCLqnvFnZBIKKm5aR9RTHLGPKcR+cQmGO/kQ7B27qkkK2qYKI4RP6Be1rPLFIh0AUTwebVR3NbS+ntggh7z6dR/yI5/RJdJTe07O+EIR8b4anH3/4bYbGAAAuzD+8q6AWy1MFUs56u210pEsVzfreJCUClueO7Q1VjCuwUgK7Qi7BFBSmLQzXagNc8i0IXdwBHlttCHrYZQi8VTZfw7bkSGQZnY/pM7HggvlrmOOWbJZXRLpCrrBCI0fAQ7xautv6GjfMZ7qzzTLUV8wRicjaCM9U1OrQ9FIchZ93Hvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CksbUOqC0EZjFvntr55eiViD+ZeEbB3XxfMcpXgkOMM=;
 b=zdZOJ7k6TzCR+7PktyN1IXivrKtcirhvx0E9+4pj+JQ4rgBsGQ85U9HhGtBa+hjpLUhs2QaXzVG73+gUztfbWi2Sd0usiSqNU3gQ7mac6WAHwuG5doI8XQgXAShDGt1ajfke9Lf6qzBhE9KhUsubg2/Un/se80eIGCTG24OIoFx8iuHKZkM/DrlVeMK3OOTyG9xpNfe0q15S/NTsxR9Txo/DnANZGATg8CK9s95LigLw4ZbwnIa8LtABrjgNVPs/JBFewzHnCM3PAb/QxDF5EaQW/BzzL3hCcBZA5cL0wosNaUwKuKTHcnKEpmP7YctRXIKUO4kNAop4wHnsXK4LaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by AM6PR0402MB3830.eurprd04.prod.outlook.com
 (2603:10a6:209:1d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 09:18:49 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5458.024; Mon, 25 Jul
 2022 09:18:49 +0000
Message-ID: <ce8ce188-7a5e-faee-e7f2-dbf6877e6424@suse.com>
Date:   Mon, 25 Jul 2022 11:18:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/7] USB: cdc-acm: use CDC control-line defines
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220725075841.1187-1-johan@kernel.org>
 <20220725075841.1187-4-johan@kernel.org>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220725075841.1187-4-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::17) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be1fb144-7d85-4b96-62e3-08da6e1eaeee
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3830:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47b2oRP//hKFDnyaVz7QwxXSh1dtDCgrB01aOrpdX8uxSNgD1Dep1yIW3vURAi30pk+cLdFg8daPlVtEsO/sFr2HPRZTiR8I0s01Eq6xHv+d8TiYiuRYpM3lz2xXZiF9lrrM/y3MNaAeIWWQxOz2ObZhjQxJ8IB4eOyBXgAEnj2E4ceZqFQT1jM+CPce90fafAOWAhokldajibpOBLN+Kn7EI3xFTe6ZGyhFHiL81JX5jchQ1OFQfIhLwap6vXDbbvL0DXenJ55IMRRZH+xolD3b2fFC2rvMHH41zdgw99cp6a1inX9UoiWMKBCMAbYD0LkelXkxgV3uejyeajVsor52bFtzIU9JckalRsGK4CJBFfqnePgyCTIQp+IBECmNDYewYvkRs6ZsVWCv7l5V0sa8+0Ssgb0bVvj+QkBbXBvM8xeOQlIlmppEc7H9u0l0PDg4b1sXCXWyffwbrpwx2wEm960v6X++gAVhR8INBf+sD8s/j6X01Z0szqnx3U5MlV7DKzNgJ/vy1BmQfIe8KyIaL7/lc8wwp4EqcOBtWBKoC2/qi9rMNTIrW2vPkicTd6orI+CZCWXw1kk6izKfKwOw8lk1hDhPZtPP/gcZEkdWzw9/6kEnDX5Z1EM0eP1RT2GiuuQbzLwKDa0AZBy6ho/uk5ZIYJ34YjJKM8B2feak9qZ2a0PQAZz2iLwszHlatGG+91HTQC/snRVF7lqE0+UMtFsVCf4vUfGVW8vMYz34DM56M1q22HYPMKqXI+aeZGXWNG95iSco8f1cCtEXuFDoZku2QZHEZWL7VDSO4VrKPFIuJzkUEeJ1C7VnBN8f9fSmwEhVspeuiminCii/pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(366004)(396003)(376002)(558084003)(8936002)(66946007)(66556008)(478600001)(66476007)(4326008)(36756003)(5660300002)(86362001)(6486002)(31686004)(6666004)(110136005)(6512007)(31696002)(8676002)(6506007)(186003)(41300700001)(38100700002)(53546011)(2616005)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFZWTkRwaE16Um90QnpUeGk1QVlWaldXVm1mclcwbVpZenNVZUtldTk0ZTZm?=
 =?utf-8?B?VkpvaXF3ZjgwNU5sMTAyUVhsbGtIY3grdWZ5NW0xdjJUVm5UVDF6Ym90MUdk?=
 =?utf-8?B?dHZ0clpBSFRPR1RJeEtDOVlFNU92WEZxRnJRVXN6NUwvSUdlRHp6TjRYREl3?=
 =?utf-8?B?Rm9HQjdCeHZmUHdybW1mRWN1MXA2bjZXejkzckdGTjR3UFA3QkpjQTJKN1M4?=
 =?utf-8?B?MmZmb2FEU1NvNDBjZkZTOGRtRjBpWTNQSEppdDNQb3Rsa0hJRHBJajVJSXcz?=
 =?utf-8?B?N1VxVGxPeHVpMTJrVjA2RzZPV0MwNHJYcjJidE1GZVhuT0RiSmNpSnVxUUxG?=
 =?utf-8?B?RDZCVUo4a2VvSjZpYlBqcXB4R2RJOHcxbHNWd2VmTm9ZNDN1VnJML1poZXZm?=
 =?utf-8?B?bmRERzkyR1Y3VExNK2d5SlNRaEpEZy8xbTdNbkFqNC9ubEJvTzhwUFlXZkMw?=
 =?utf-8?B?ek9qK2t3eW5vZDlnYmpzOC8vNmgvUzdVeU9MaHRFbWs5emNPV0lPSjRsSEd1?=
 =?utf-8?B?WEdjeHpEbCtGYUNINEpYT09PY1FlSy80bnZlTGIwZkFrbDBYYkhVZFpUM0d6?=
 =?utf-8?B?TjJtTW5QQVc3Ykkrc3MybDlNZXhaQ05rckhqeFkzcEkyVlR0OTNmRG8zbWZK?=
 =?utf-8?B?ZVZHWlBhN2tSanZSTFVRV2h6S0FQWi9BWWR0aGJyTUJyNW9YZWpsWUVlMXlP?=
 =?utf-8?B?N3AvOTZ5VDd6OWs3bFdUbVh2cHFvMzhXWHEzUDg4WkoreC9DQU9xd3RMVllk?=
 =?utf-8?B?OGZDNWdtTGs1RzhzN216UDhNTkVQaEtBY2NuOXJ5S3kxV3RNdEdOQTEvL2lP?=
 =?utf-8?B?RkNCQVZiTUJXbDZNM2FMMDFyYk1kQnZMR2RSY295RU9KYnVrc09CM1N5WG9s?=
 =?utf-8?B?MkwvWmtIREU1eGNpc2tIQmJBVEFaRDJsZENqN2pJVXo4a1dnc1oyTkVkUlhW?=
 =?utf-8?B?SWNIWVBzaXVHTlVPaGtTczZsYS84Rmc4OGJTTHg1amxiS1JicmNoaDg5Y2Z5?=
 =?utf-8?B?MURNUEpGUXdQOW5TTXN6R1A2U1MxY2N2eTkxaG1jZ0hIaHhTQXVXRVU2b3JC?=
 =?utf-8?B?UVFXbTE3WUw4cU5ZTTNaSUpFWGJYVHhoZW93RUswNHBIZGtlTERMVEtyV3NI?=
 =?utf-8?B?ZlRjQU5nVGRvRnB6Y3lod2NnSERGdzZqbnQvY3IvYjYvM2duVEN4VEtGSmQx?=
 =?utf-8?B?SVJwUTdTNmJ3eVA3UWJXbjk3M1RtQk5KU3lyWUh3Tk1paW91eFptanlPcWpx?=
 =?utf-8?B?NjFUd0pObERmREZVT3BTRkQrQ3BVcWJBcEdSMXNvWjJISUE5b200Q201OWpC?=
 =?utf-8?B?TXNsVUhCSlBQOEVTOWNWZHVlWXkwa1dMMlE5N2dkU1JWd0hhc1U3V1FqTDdD?=
 =?utf-8?B?ZDZBOXJ4VEFaOW8vMlJWNHZ6SStLdjU1dVJ2cWJpVTJCSnNmQzJ3UFZTOGVw?=
 =?utf-8?B?TGI0cmxRaWZrbDc1UG1aSW5nZ3RaUTJCQ3l5NGluMmV3RFd0SGlEbnNoNlcw?=
 =?utf-8?B?a25ESmh2TlBjcUptR2pZTW1peEtGUVJtUzVjU0xKM0dJUnlNaXVGakFxd1Qx?=
 =?utf-8?B?T29LcGJxamhIbHF1aWllUEFiZzBlcnR3c3hNZmN1QnVURHVrSWhZcVRPQ2gx?=
 =?utf-8?B?SHFxOFZkUTZUazhBZFdSVmJhU2pJYy9VZlZPUWo4RFpjWDBncEZtODZlYjhj?=
 =?utf-8?B?NityOHpyS3k1bzNpZXJKMTlLOVlXRjdnN0dIcnBQNEd1WVFKSXVuaGR2dmky?=
 =?utf-8?B?bGkvT1NnZVh1bHE1dU5vdmI1dTVqeXhKTGgrWnhDSTFKbCtZaHl2UkI4ZGdO?=
 =?utf-8?B?YWdhZEJBNEdla1psM3RLUGVQQ081bEpXc0NxTDIrMW5UbTRwTjg0QkdabU84?=
 =?utf-8?B?Rm9aV1llcnNKeGh5RjBITXJtZVhadStTNWQydFZ2TFJTL2NnSzhvbFJIRDNa?=
 =?utf-8?B?U0lzd0x4ODQxVE43aThudHFZeUhBM2NyOGlyZmJjZzNrWkltd1B3eWd6aE11?=
 =?utf-8?B?QU1KUmdZVnZkYzhyVjg2blhKaktaRHp6SE5JTm04TStqOVE2QllJU1ZsMXJt?=
 =?utf-8?B?TTc1dmhDWWtGOXp6a3B5Z203UnR2RXZpTFpDbDNaVFFCTHJEazE0ZlllRWJH?=
 =?utf-8?B?SmliNWVzY3c1K0wrTC9WZzFGLzltSUptNUZtRzZKYk1HaFM4Y1lwMG9wcXhG?=
 =?utf-8?Q?qnRVWdtA9opaxBWJuhKgN2A2AdRPv7qzhWp6ICXSjGA5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1fb144-7d85-4b96-62e3-08da6e1eaeee
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 09:18:49.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfWWvvRgDoWxHZ3+ab5k4TYQv5QXfzUUM7D7YgQ0OBebLsMHP3/9bKclBj88X3cKzezcQmJRI5ZARx06Ywf/yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3830
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.07.22 09:58, Johan Hovold wrote:
> Use the new CDC control-line defines.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>
