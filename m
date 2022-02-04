Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B44A9A82
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359184AbiBDN7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:59:43 -0500
Received: from mail-zr0che01on2111.outbound.protection.outlook.com ([40.107.24.111]:30686
        "EHLO CHE01-ZR0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233765AbiBDN7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:59:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUl5pP0nzU6NGDI48zk1G5tvK1ItLeXUhxQBljIL18pc+cM29Vsu2hvu3+CGcgHA3OrjaxH9J0WJOkWm9c9ai+T7aG5rk+g0BuuuX9BjlcZ2ST1S1CYXJIx2h0oU0a5GMbvmk723UMNpl913Iftfh9BLJCXolDkwAIKdO9cJaysaWPYE/2m51EpxAu2LLGgCxjlUXcM8HJ2PXBGjdWzDXil/cB2JmH2mBWwrV0EgNRmhEwujQs4eutZgJR/GwQVGwWwvuCmls69sWbM7p3qUF++MV1W83bQn2mhtxfDc6/E67mL4IWMGv9ur0+yNGRh3ArCEBtm6Iqa9kka2VKtOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZxhmHoQbFh9FKHEK8RwmJBSLi+nBr6O4S74NvQu5Eg=;
 b=ZVmlyiRXeCJciRKHNYGhHcxVDmLHfDNLXvWUKFzHfQVDebUG6QvQG0xd73zTPhB3e7JHGcwX8ljKOQ12pISTi0q2MiwB+DtkdjXMiViD3JigQ8s3BuciWkkunmKG9SsJSLltr/FszVIqwAjtDC+Wo5ht/D5kF3wyueaSJHIdaZ4Ua4blxUNtxRe8pExWH0pN1BbUiLjAgaFCfDnz0PDHP4A2/rMCUo7coJQE/eNRxoWtttotuzAR/Qh0HQA3YstihKiEZEOqC0cgf6GUZFy4AbFXfgijC/4847TVzuVTL0UaaOslw+Vy5eQGsH9lNFreQfs1aPfs9cw7g04PyyE1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZxhmHoQbFh9FKHEK8RwmJBSLi+nBr6O4S74NvQu5Eg=;
 b=FYyPZlE2VhyBN2JadEOCqmdtxBVWUvekaFsy4JlL1JvS889bcE9YoSW+ir/quSjRU5sQuEU1OZuXlT658gyiT6UY4uXb4rKWodNV6wBGN/nJ+3Xi+UInyuFE8BeNqQTuR/1sYpaQ9+5ITGmLLTsCOxCcAGFJpf26Cq8dJBCLyMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by ZR0P278MB0556.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 13:59:38 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb%4]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 13:59:38 +0000
Date:   Fri, 4 Feb 2022 14:59:37 +0100
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 2/2] extcon: add optional input-debounce attribute
Message-ID: <20220204135937.GA1166088@francesco-nb.int.toradex.com>
References: <1508406773-887-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <CGME20171019095315epcas1p1da40aef7397c561c5fe970309a97b762@epcas1p1.samsung.com>
 <1508406773-887-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <59E87BDB.2090104@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59E87BDB.2090104@samsung.com>
X-ClientProxiedBy: GVAP278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::18) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b155fb49-9b27-469a-65fc-08d9e7e69562
X-MS-TrafficTypeDiagnostic: ZR0P278MB0556:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB05564CA4843F22BE535BF499E2299@ZR0P278MB0556.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tg4vDN5dlkmdbYhuIBRQCZAaZRuWFvA9IXzwAp3oLo6+va50ILUcXxwr8OOBAUP+QNHd5vmsnUOOGg3v69Qf33i3zNhcZquI7W2fePppsKZX4lHTKBa4r37eI71bpIuw/5N1T3ru/ZGzrWHbJnc4MR/4dhT3nCKR1g3n1pwAL7sjmC8qZxQG1fqveDB+itoW3c8LDcX3SE5mkZVUdB0et1BrqnTLXX/6ZaDvYrcLdYoo7A5TbPPzrV7IUz46IlIM1+wOfsS3G+2VrYeVbdI9OKqASRmcF3HClMuFjSR0iEmDbxgUZDwqFm/p4x9tsX0ogngAmiNaDvU5+vB1wQlMG93oZ2YG/K9FY5h1wAZdpkNadLjeS/Vc2rLld0jPAyEQWxZn/Fq0tu8OXiu+ikRwWpWo/gI6LJXOGMj6pl2d5lFfOtrXD1sKAkplwPCpE6Mf6e0o4G5TIXqopIxd02gAQGWbFM6DBR0zuenqaqkMMb1+QMdtoCJhNldqJXGmZVbdN14inOdf1G4nR5p3axEx5roYcf7f6giZX+ioPPrmF3phct7XW5rIfbpm2YKd4HOET1FGoVIOjiTOTRKNyvWsdTCInKU9a24w0p/LpOBOidcdLAuhNzVixZ1S4Mj+vWi3SJ7jkqdwsQwgT/nnSOAs3K9whJjireNgvQ3K49NahEr+HdD4ly7iyEHk9BHS9IdB1nzQiIq8YHh+tiEsYne3hn86qJZBql6X8ZNQdFwozEH6Nd2G447sldCsnOpgkoBXSeTxO1IEeLWKJkTI6AS+Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(39850400004)(136003)(366004)(376002)(346002)(508600001)(66556008)(6512007)(966005)(6486002)(1076003)(33656002)(86362001)(26005)(52116002)(186003)(8936002)(6506007)(2906002)(66476007)(8676002)(4326008)(5660300002)(38100700002)(83380400001)(110136005)(38350700002)(44832011)(4744005)(316002)(54906003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXE4N0JIOWtjTzRHTmJWRWN1aGRaVk5CMHJNVzRZWW9oQ2VYU2JjNTU3RmZD?=
 =?utf-8?B?TUlIS3hnR2FLUmVJRFRodHpUR0dMRSs4dXI0YnovcGFDRWc2MWJmcUkvUE8y?=
 =?utf-8?B?MHp3M0FGZVJMakhiRjZLUTRNZGthV3Z1YlZjOFJVWUZpQ21VcGZSV0dVQmtC?=
 =?utf-8?B?MXpZMUxDTEM4dGN0RllJcjVwSndoTktUMHVjRWRrVmxTa3FPQWtjVVJJSjc0?=
 =?utf-8?B?TS9PdlhQQ1c1QXFBWWhEcEZtbkhPYldmaXc3c0NYM2VlemlNSWY2QXVsUWpY?=
 =?utf-8?B?SWI1VmYzSzUvS0UveGcvS2JFMW1xczMvdG1WYXJCK1BrRHBXMWp2Wks1aHhx?=
 =?utf-8?B?RjFERGk1R1ZYdmxGZkc5TGtPMXZMWGErbHliL0U2RWp4YWdBTHpUTzRRRys5?=
 =?utf-8?B?ZHVVNlB1Q3ROajJKRGxyS2duZGhtNGRuT2V5MFFHNTRRTnk2NjIxSHc1Sndm?=
 =?utf-8?B?OU5QeHdLMDQza2hyQndxMnNtR1o5K3ZjMGRIVmdCMXl0UGVNTnJYNjF0UEEr?=
 =?utf-8?B?ZFpHQXhJVFpvOUk4bnFTWXIwdHEvdVJTdFQvQmRqUnl5YWtkYUdYLzBKeGor?=
 =?utf-8?B?MUM5VlVTOHN2N0NRekFlN1pReGF3T0I5amh3dkxBeTE5WE82enNpbndtNVpB?=
 =?utf-8?B?cy9rbEpoQS9BNVhmK2IzaDlaMjNlcFZrVDFLMG1Gb2hIVHY3WXlIczloY0Nn?=
 =?utf-8?B?MjR1NVNBWGFocE5laVh4alRxZCtNK2J5bE5qSDJMOVBSRk9JQTZSVUlmN05M?=
 =?utf-8?B?OHY0SEZLWVpoQW1FV0VGQVpKVTZTdzl4dldETDExUW1tcDhMeVl5OTdxK1R6?=
 =?utf-8?B?UDFrMXdqaHovODFXaDNvUXhkZ3VhWUM5VG1NZ0NXRzBIb0hvNjFBTmExLzdh?=
 =?utf-8?B?ZzUzVFFPblAxZ1gvTjBYeXFKTzZFN2pyTGovdWxITDk5RGVmSit6aFNKOGx4?=
 =?utf-8?B?bFRPTHRHcG9VSTRnQTY4VWJFSythSThhSWJmMnUzUlY2N3RrKzRRNkl3Ukk0?=
 =?utf-8?B?bXFCdUJUdUlERDJuN0U2K3k4L1pGc2dBcmo1aitPWm5Wamk2UWlldVR2WUU3?=
 =?utf-8?B?OUgzMTBRelh3UmMxRWduZzBGeENJcjJMRW9qdEVZcVl6ek1sOHhKdnUyc2hv?=
 =?utf-8?B?d2ZaSDkrNlRtZ0NHbjRxZWpvbkhWTmp1b3JGdVBOWHhJU2JkQ3VoeHpNVVJP?=
 =?utf-8?B?NzNyTWNuUllFY25Fdm9la3lYVk9PZWxJQVpZUHZPUFpMMHRHeUFxZWREeisv?=
 =?utf-8?B?Qy9UQS83a0QrM2k0TnNNYW9ueEIreDhKYTZtTWpKTXZkWk9KQW5ObW9lZXNw?=
 =?utf-8?B?QkVHOXdCdnlTK3EvclYxdDB0ekdGZytJV0xDQ1JYZHE5YzlYcFFtWTdYUHJk?=
 =?utf-8?B?SUZwZzY1akVJMWVtUzBjOVBoTUpqc1pSTkFGdThOeEExU3JYZ2lGZlFYL1Yv?=
 =?utf-8?B?bWNYRzBZOFhOTzdzbEQ4T0xiVkNNR2I3dHpSY2NtTDhGSnFqRmJWc2tHT0tT?=
 =?utf-8?B?aXlCNWFBOEwxVDdoamtMbUEyaVoyR3ZHYzR2anVxNGtQcndsRTE0SytEQ01P?=
 =?utf-8?B?R3pIZ0tIaDRYTXhLUkZIaWNZY2ZrZ0tGTzBDdjQrTmFXWmNuT3NpbnQvYkhT?=
 =?utf-8?B?a2h1b1JINDZnbk9OMWg0Qkx4em1TOU1RZXg4dWR3ZS9lTThORTlzcmxQSjRj?=
 =?utf-8?B?Z3dBY2xlcm9OdjN1S05RcjdFRVFVNjZ5VnNQeXNyKy9NcThoRFc4NkFCMFB5?=
 =?utf-8?B?a0xVZHFZc09zYjM1RXhOa0h3ODJHSGdBbnRTbGRZWGdPWHUzTzNtTEEybklL?=
 =?utf-8?B?eG1QbHZuUUFNQjhwQ3YzTmlXOVpPZWJJaUkyT1AzOHdXd2ZQaHJOdGV2VGNo?=
 =?utf-8?B?NVFpeHFEdVFJNWJFRmowUGFQYlBEMHdYMjNCdndiNnBOQjZVM1pYVTZkMzBz?=
 =?utf-8?B?d05URnFiN1JNemlQRUdIcFY4SU1BQkdRQzBjc2xkQ1JCWVNjYmh2dUw1b2pv?=
 =?utf-8?B?VHVqU2RsQnBNdzJ6RCswSVhORVNCa2xWdkR0ejJEMi9oc1VYNldpUm1NN0F1?=
 =?utf-8?B?d2lkMnpqR2hRMDBNbitKQ0M3SkxlWlZvREhKLzRVaXdVOHl0a0tzSE1IUmdx?=
 =?utf-8?B?cjE2cmZsTEZHell6ZDh2WGhObklWbG9NQnpzT2dNbnJpK1NlejRyVHJRdVJC?=
 =?utf-8?B?cFRIQi9BUEgxZkFEblZyaXZWOHNRUnVLWmdaTXFUZnl2RVZEM2laVTJzTTFN?=
 =?utf-8?B?UkxJT1ZldTJqc0lyV1NaS2dTeTBBPT0=?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b155fb49-9b27-469a-65fc-08d9e7e69562
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 13:59:38.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c8ggs5yMkwAwDH96j7w/SX+40OEiG8WOoss/+HKZLEeTh6xeTKawD95IlAjb+o0b6dwGLNvVMGkY+ld6J99qNqx4wqLva0lKntYqx+qrL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0556
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Raveendra, Chanwoo et all

On Thu, Oct 19, 2017 at 07:18:03PM +0900, Chanwoo Choi wrote:
> On 2017년 10월 19일 18:52, Raveendra Padasalagi wrote:
> > Add changes to capture optional dt attribute "input-debounce"
> > provided in extcon node and used the same value if provided otherwise
> > default value of 20000 usecs is used for id and vbus gpios debounce time.
> Looks good to me.
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> After completing the review of patch1 from DT maintainer,
> I'll merge these patch sets.

I noticed that this series [1] was never merged in the end, anything I
can do to help?
It is solving a real issue and I would be glad to understand what's the
reason this was not merged in 2017 to get it done now.

Francesco

[1] https://lore.kernel.org/all/1508406773-887-1-git-send-email-raveendra.padasalagi@broadcom.com/
