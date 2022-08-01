Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6EF586712
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiHAJr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiHAJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:47:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ACF3C15B;
        Mon,  1 Aug 2022 02:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAGRnagukm8X7YHTqCIM52BxXh9l+C/axc+K+QWx7hsgLeM+G+LpwY+Y2YytRKGXaompix2kQxwO6Abp7u0nbyBLH7TSrGfeOdeXHitt91yUsNhHdP0IXnI1GRnoGyfuwKaS39wTfSTdoT2sjt7zzDaw51v+V26KIvbQCcM08S/KFN/FMHslq4mPkWIcPSXfwgAGgbdummQo7byVK6KeZAGsGylE7FkBKNWHrD5dwnWbrMQqHbRL1uCXIBryM39jBbNH34IrTJy1iFBDLTFuX/9e0hg6GRwyBl26z+ahKcOpo4HbdPWFUFmgUj1uxVx0PSe1Vy6faBgvQ0fWx6b2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uIDGKa/pbS/jGbd7sabN8g0ZqVBxREletBa2RXfcLE=;
 b=WIL0WdsOIRWDLAntvkDJEqY9h0L5amdFfx+GboP9iVgqpFEiXHXKuQtADX2L3Q2z1jD0VYTI0ImsSvOR5ZpFe7o0OI1QWFv+PY5H2kOhFnyGfO2iczaIESa6gRtAaZHQLMiNl2B0XFWSJNCvKKxA1d4DWjqOAcDCgJg8IUs75231H7G5LmUOXMNRf0Mwjb4fVl5rGNBIVwePjrjafIzp6lKvcKaw+ab8drwppk8XicADExu8MYwz9Rcz0MMeFls93nSqLrDfhtAQY/vyQfTH21GkCpFNj6z3ui4YkJbC/QshRFTG4HvqxhRjKiz4yv/4Y+LpoNwTRL7O7Q/Xvhl7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uIDGKa/pbS/jGbd7sabN8g0ZqVBxREletBa2RXfcLE=;
 b=gDsfIK9DNCgOkyJvXtQa9BuAH0kV43qjm1pENlNZhyRPIGxOgcU6J3v0tx+uIUtkS25UCRUF2zTubQBL0xa97dROPRR4Vr5/my0Bcy0uPPN5wx10Q6E8gdY+SBS/3xC6GQ8glhUguyTPB0C+3ml+WfETkbp2Vkz7lJXu9mH9Xooew2YFClNFyH1ZCulvOcVjiGpnwiUDLyx/9tMV9usdpBwoHhYb3ErSWUCYfdbdhwEI2koa2OxnOhgL13PCF7xvPASFGxqbTc41C3y9jCEzKnV/zw7aet1WCeEUytLTEHg3Wb6DPVnPV0D3I/zg0fuPK64yPI2GDa6JZIb14SpngA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by VI1PR04MB5808.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 09:47:18 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::9cc6:7688:607e:a3b6]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::9cc6:7688:607e:a3b6%8]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 09:47:17 +0000
Message-ID: <ca54c865-bc5c-ce8e-4ec1-9a3ac4130fa9@suse.com>
Date:   Mon, 1 Aug 2022 11:47:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog
 device
Content-Language: en-US
To:     Alexey Klimov <klimov.linux@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        Guenter Roeck <linux@roeck-us.net>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        atishp@rivosinc.com, atishp@atishpatra.org,
        Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Aaron Tomlin <atomlin@redhat.com>
References: <20220725030605.1808710-1-klimov.linux@gmail.com>
 <Yt5Zn9cXDe9/F9RJ@kroah.com>
 <CALW4P+Kd_XdvzGfA=Cmtu0c=kEHfhp2pph2Wh0Sa8Fm8GxDRTA@mail.gmail.com>
 <7770401d-fe3d-bda4-a2e2-55cd004a2d07@suse.com>
 <CALW4P++5ahRdK6WvghPgpPcTuoJyezU_=s6MG2nn4OBRWZYGXQ@mail.gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CALW4P++5ahRdK6WvghPgpPcTuoJyezU_=s6MG2nn4OBRWZYGXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0740.eurprd06.prod.outlook.com
 (2603:10a6:20b:487::18) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29ef242a-68ca-4b8c-9527-08da73a2d23e
X-MS-TrafficTypeDiagnostic: VI1PR04MB5808:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6J3GXLgv0HhfLbu0pJMMeIojnII8Ph2N+rvadtOouFKjNJqzBjNZzQfTTckRs5l4N2T7QVJ9O45YXxb5aVd+43e5Dm1xjuoZ5CP+zDCxAi0mVF7sI3Y6ojpHAPgEq1tlbB0Qxu5T5vCaFSctVDsEUDMVegjUDhSltazsnYffRIf+MxzNwuc6bQzAF7w2v9pGhs4NEy1b15MXLQU8RzsvjobUQqRFzULRGmNSTDk0ai2tnDD4jHhsrEawLdiwG1NsHEFIcov2RmTJESI2fp9EY9J/02llxhXBGGj+IQku/sGZiLOFIslGUWUay0NhQ5ZBlB3ePNJQ/Kaa56AvLaEQM35yObndTd/RHJAvDaCo7DYNTWm3vyKuD5SYZT47Lm4xTFf8vKfwrpX9NXcNuatC5e79CfLv31OnxdEWH6UWcy8UcyvVQWWBqKC94Dz0hz4JAgprxaUA5N1zCxc43TgRu7hP1s6xakbZvZxbPNaavMAIcN1ebX284ldibl9MWpHyhsvFcSkq5DUsBb/29nTTNByNxMFfJBqs0QWxZjJNPT+XSoxQzn/qEhfmaY0VIW74ssLHwmlGUu9RLfQGRZN1gkcSPmGehBKvdApILwzMhXri8wPcO80vajaLPtPYmEZF05GmDnp316sD4A0uTTxQAGLvZIDOHwwmLX01YTHXxtKfCvYe5fLJP7t5/PvfU/HO4vS6KLrtIMs5yHIvILCNNQAqQT7yoe8X6iaJ6+wbJA/04YsCdrbmYQOBfc5XOxYyGXF6/iqanqjtwgODveBA7bhNqAQJAuzNL5vXnWHLcDOgxsXEoi7LmpBZoHFckeFD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(39850400004)(346002)(376002)(36756003)(110136005)(54906003)(31686004)(316002)(38100700002)(8676002)(4326008)(66556008)(41300700001)(6666004)(66946007)(6512007)(6486002)(83380400001)(66476007)(478600001)(2616005)(186003)(8936002)(7416002)(5660300002)(4744005)(6506007)(86362001)(53546011)(31696002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2ZIVituZUEzM0F2Smh4ZkpwSFBvOU1Qdm1KclREajFwNzdIeUxwL1MyMkhh?=
 =?utf-8?B?V2xza3R6RDhOTWdUcEJ6WEU3ZWZENW1jcWhMajdiSXZqeFRMSWNRUzVWZVlu?=
 =?utf-8?B?d1EvZGF2MmRmWDVIcXA1bzVtRzRYTEZoRDZGY3BYMmMwVUNOZUJJNm5LUXhZ?=
 =?utf-8?B?K1NFSTB0czVOaG9pYXh5QjBPRlpXREtIdUErRzRzQkVPVnIzbks1UHFZcVJU?=
 =?utf-8?B?UDlBNUhlaHl4TGJCRHNwanBJc0Q1MGFGTks1dExWc0s2OUlpOERMNlY1eGYv?=
 =?utf-8?B?WVhXcmNPbmhta1B2MUloMXJyZFlvS3RSZmVJT2hWNWplaitDZnF1V3VMc0Nx?=
 =?utf-8?B?cit0d2pqS1JrR3lua3ZCYWFJa2JUUXVEL2k4NWRHdG8ySENkSUQ4cldPdHBp?=
 =?utf-8?B?SlhEbjBhUllwTFF1anRJVTlDUzBsQlNGTlVJS1M3VE5BbGhsamJnemE5eXl6?=
 =?utf-8?B?TFpuK0FHZExXN0NNM2hLcEdZR2JjaXRmaVhick53ZUNCdVd4TC8rK1E0WWM0?=
 =?utf-8?B?L2FkZytZL1NHU215Um0yQUEzeHJQd1UyL2IzeGJkVTFvc3oxZXZuWXZ0V2Fu?=
 =?utf-8?B?NFZoKy8zUElxelFTSUpORUUybTNaNDhtNjdlMWRsUElTTVRCYiszUHVnNW1j?=
 =?utf-8?B?czdlS05OaGxkNzJsTlp6eEF0c3I4LzRlTStseDBpVDFQa1YreFljUXIwdzlE?=
 =?utf-8?B?TDNsTTZGVnVlcVN1cWs2Nng5Q1RzTkg5bUxuWnhyMnVkcUkyK2dvcjJFM1BS?=
 =?utf-8?B?RW02OGN0aVRiUEtTQjJNall6ajJ1Mm5lVzUxMk5qZE9aNUtQblpaeXJta0pL?=
 =?utf-8?B?VjMwNXRuV3d1cmZ5dGkwTktnYXJ1TWlLeVhaSEFMdEFLYmFSekRJRXRmbkov?=
 =?utf-8?B?Y1ZTNlRGTjdtQ0t1UjY4Mm10RXZmTnhGMlJSUE1icFZOMklLUEM4dkxaU3hC?=
 =?utf-8?B?Yi9FMGhpY0FCWjlFNmNFbjR5TllhS1BRVFhkb09rdkxoTTVUZ3hPZFdkSXBH?=
 =?utf-8?B?N05xOE1rK0xCRGZTTm1vTzBxVVBXTHU1dStoaDlza3VsMHkwdXJUNjVBbiti?=
 =?utf-8?B?TUxCZkN3TGpTL1NEa3BXNVFHbm43SDFjUWRzTlIwSlZaL1lYa0k5MDd1KytN?=
 =?utf-8?B?bHhCKzFJT2dtMWt5RW5KaVFMck4vckVzMWNkWUdRYXRQUE1kMkpqRDhKZmtG?=
 =?utf-8?B?cVh4WDNOWHl1aUw1anU0cU80WFhDV21oQWgxRVhHVXhYYlNJZW5RMWtmZG5G?=
 =?utf-8?B?YThoNFpHZ3Iza0lnTFF6N2I0ekwzdjF4aWdaNitmd0JoQVpwRk9KMDR5eE00?=
 =?utf-8?B?dVlZNmk0d2xVb2xOWUEzd2sxYW16TTQ5bTArUHZhcEFhcE0yNURyMWRybGJa?=
 =?utf-8?B?Zm5EWXkrbFhtc3NSQit6L3IwbThCYzc1VVJsdXJiWlpOTWVKQnBwNjk1aGJN?=
 =?utf-8?B?WGFqUTlvV1F3VENmanIwS0Y3QW9TenZwSmNXeThVbHRlQXVDNURVTVdYUFZa?=
 =?utf-8?B?MmR6NnN5WGdHTEJTS2RGUXZGVlMwTTF2V0ZHb1VYOWxLeVBnM1FzRFkxazA2?=
 =?utf-8?B?M1c2MlNOREU3RC8zME05RlVra1Q1Q0VGdkZZQjNlVk40S1VEbGg5aitFb1Vz?=
 =?utf-8?B?ci9XSzlRVk01L0YweHI5REFzVkxWek5VbXN2aEkyazZESnozM1ZJUkdpTExY?=
 =?utf-8?B?eHRpUlRLOVpDbWtxclpPdXduM3VQVmpFdytwRHFvK3NPalBkWEx1akV4d1la?=
 =?utf-8?B?a3dMQWdpUDFJYlgxTDF3Y0FVVUljRHoxWWZEZ0VKOUtEUVlLMFNmY0F1Q1lj?=
 =?utf-8?B?YVp5dnlwOEV6WHBnZEoza3NjY0g1aEQvYU5qSTBna0taQ3BMdmJOTWcwUUF0?=
 =?utf-8?B?anBTK2VWOENEa0h6bFdRZkptMFZGSU1hT0hHTEExNjY5Q05JTVIxZlJVM1hL?=
 =?utf-8?B?emh0dUFEZWhWaFJRN01IUlduYzZuVlBsSDZmUHYvNEpPZjNiMENBdHQxSk1a?=
 =?utf-8?B?SEJiZ3FkdDRwUS9Wd0RReGtqQ1h4Sm5GL3VyNFNnSHdlWDNNWnE5MndXdkhh?=
 =?utf-8?B?TWVIeDhqeWI5YjFRamc5cytyTFVqaGpVakduaFlKM21kZXlIUEVQT0hNNGY5?=
 =?utf-8?B?QU0vRTJKM2ZPVjVGYjUrRXRTRHFsYlhuc0pFdEtRVVBXM3ZvVm03dUx1YmlF?=
 =?utf-8?Q?4uWttxv4WGaoP9Rr0uf4Iw2lh7os8BA+39Pgx5aIxe1m?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ef242a-68ca-4b8c-9527-08da73a2d23e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 09:47:17.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ST7n3qFW9C6T1dUgbqZb2kDxQOJxncqk7XG4I0Xk2Tg3IUFcOIxnuk9V00AdYLRvafOcdYF3+QnrXOJ8dvzN1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5808
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.07.22 04:34, Alexey Klimov wrote:
> On Tue, Jul 26, 2022 at 8:48 AM Oliver Neukum <oneukum@suse.com> wrote:

> You're right. Upon reset the watchdog is disabled even if it was active before.
> Adding empty ->pre_reset() and ->post_reset() helps to avoid that, but
> looking at Documentation and other drivers it seems that I need to do:
> in pre_reset():
> mutex_lock() to block any other I/O to the usb device;
> __usb_streamlabs_wdt_cmd(STOP) to stop the watchdog;
> and do not unlock the mutex;
> 
> in post_reset():
> if (watchdog_active())
>         __usb_streamlabs_wdt_cmd(START);
> mutex_unlock() to allow other's I/O to the usb deivce.
> 
> Seems right?

Hi,

I suppose if you make reenabling the watchdog conditional,
you may just as well do the same for disabling it.

	Regards
		Oliver

