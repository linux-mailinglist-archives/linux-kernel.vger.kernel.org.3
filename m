Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC445580E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbiGZHse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiGZHsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:48:30 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B1329C9C;
        Tue, 26 Jul 2022 00:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcmEdKnn5moZ8TVRMBdaUFm5lSdXLq04YkeDMhaEjrHkF9nDRz8u1PrEABoHfG+o/GXxqYWo3SSUJEagy/5AeOerLi0LHPzqVLEGwF32bzlWJ153nkGn9qxIvSkqIK9HST7VYzGg3mnuZvQDS7WQlHWyQhtqE0fKzEPZeTOqC3c7cU8SCDZPRzoopSx/RP9jHpHLacXeUH5hYGuBuwtr60DNliZI3/2cGU+QBF3npAjJdDEHNhwFV4GWPkR3jKS0Ooe9/wHLBsX6IvsEvxnchmgAfwKjWvxGVKb96ZGJc2Y23lJx8s+F23tZZMsv2CRAgNxK10yd5qjbO7+Ol1o/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMzMzaA9/WQOoJ5oEFmo82j9mlzhMnMe2NhORhghQMw=;
 b=a2ZOvjK3lzZYYaXy932Hzk6Z+a7Q9LOQMeYZPAlIsqr5WW16UzLbi+KCvunOrmiuRTcQebNxALiRxfWORVkRVG8XR3v61z3wsFAo8+wyfR08QTbWCHnNa7NFvSXQTWRB/30U5K1LSyLrYk6DEb4DjUbqEyb5cCgmDc1k7ZyIaPZoythaQ5fHoKLH87fMe888OirJafHqiHXCV/kFYp6ljTZYiYozBHuAw3iBfeiHVlydXt1cjVF/JmZoM4OueQNbxZMvzV2RjHHv5HY77OYyeLYsuA7GtFAHbOI1RrRDkhiLZh4BB09vtxLjqSwLTpjgGsqIqPC3rSwv/lCU6jjy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMzMzaA9/WQOoJ5oEFmo82j9mlzhMnMe2NhORhghQMw=;
 b=YfW5l8eSWLHKrIln0n65p8UbZ0Pqpvj3p137qZ38d5tU+olk+P2fb/4r2USd/ScCP5DQw57cpNjO+17Ms7JZQgBSvceZewbQCclvG0OuAS2DMKmMh3acPzehMlefjEo5IlvBt2MP2LgerLjMm8lY7ZslbaY6MB/ykQ9IkLsnvuKnYoLBtbnfzybgi5uV807wQScCnZlv9k9/I6bdJ2BYAeuhsu3bPxs7HRrYXRhNuTqcZ1qwcZAwnTiHbzXeDub6tt3pr4Wu/QT7m6SJ/Qtkf3k/UfTY5MWAPt3XCnNvpQEMUtNYWQyDN9tNHAFGuVRMlBxql7DvgNd1jBSLmO+Hxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by AM9PR04MB8636.eurprd04.prod.outlook.com
 (2603:10a6:20b:43f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Tue, 26 Jul
 2022 07:48:25 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5458.025; Tue, 26 Jul
 2022 07:48:24 +0000
Message-ID: <7770401d-fe3d-bda4-a2e2-55cd004a2d07@suse.com>
Date:   Tue, 26 Jul 2022 09:48:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog
 device
Content-Language: en-US
To:     Alexey Klimov <klimov.linux@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        Guenter Roeck <linux@roeck-us.net>,
        Oliver Neukum <oneukum@suse.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        atishp@rivosinc.com, atishp@atishpatra.org,
        Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Aaron Tomlin <atomlin@redhat.com>
References: <20220725030605.1808710-1-klimov.linux@gmail.com>
 <Yt5Zn9cXDe9/F9RJ@kroah.com>
 <CALW4P+Kd_XdvzGfA=Cmtu0c=kEHfhp2pph2Wh0Sa8Fm8GxDRTA@mail.gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CALW4P+Kd_XdvzGfA=Cmtu0c=kEHfhp2pph2Wh0Sa8Fm8GxDRTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::15) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d368b459-029b-419e-e36d-08da6edb3804
X-MS-TrafficTypeDiagnostic: AM9PR04MB8636:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0EXqhEIA0Rvkk8XC8XBA7FS7Fv9O37ZL3WaMjpkP77I1YGTYVVFoGPabByqDBt1RgS9OUDDlKuOSgWSXeWjZHIdGsRBUcGzkTPbv+s8Yh9kEEyKZX/tz10IrXgR2Z8Qu/aTTPBn1dtTV2gPJEpfNg7iH1Ho2n6OnoeegEB0AAUhYkt48y+R1tI1cHiwLGlLMlZ4aNgWLkKHPy1H4Ea9sFw7LuQAI1MMM0Dj9IhrnTwMVoqjXsCk/boND8fzxzpFY7G7zkXh8UJkssiejKzhj5cUcv6Hwh0VZl67Hveo/vB1ybjuPLIFcuZfqFVE/VMFrhyKjPj4aOI5PSKpMdIdvQVAguFRDwuZxdvcnBRg9Je4wiimoI9IxFw6JR56LHwK/8EhQlz1sNmXR7Z2GcHVhzRmw/OunPkcdpEAuISuDYj4WKvYE5rMraUIhwYtfknIglnRiSfqREYq56YNaK101teb6wGh8YrO+4JNK4ESJFKSPWtvQA07SKBAjhMLyiVEc/8wj83QF4r4NUyCUzY3AegXGBOb26a3JDVBGkiO5I/Eutpr6shibfuPiGShzrquHMqoydDKXOF+1/YO+C+5bGAFST1rNDBGU9F3Mi3WnxKQEHKc1YYuZxVYZNjGdt4USzw2lTuRY6fmsC5uNhD7iAZO0SJV7vNgi4bjlSQpOFQWSjtY8k9aMPrz9oVNgZoeebrBhISFpA3drJLuw1+QWvvPptvMl6dFdrKhhHaqWwCFWau4vycli6gL2sWsD9/kSiKH20oNVNrh4ntRnRonpmUC6WV2aedV/GZ58JIC9XH6JsOKxMtblHqmyqGmYCAio/mpDXZvJCZFXT1XFI4komg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(136003)(396003)(39860400002)(7416002)(186003)(8936002)(83380400001)(5660300002)(2906002)(86362001)(38100700002)(31696002)(4744005)(66476007)(2616005)(31686004)(8676002)(4326008)(6486002)(478600001)(110136005)(36756003)(54906003)(316002)(6512007)(66946007)(6506007)(53546011)(6666004)(41300700001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1RnWndCQTl6KzNUWXJMdmh5bzBHM3dWS3ZHNWF2NGRRMVhkVFJRcjF3V1VI?=
 =?utf-8?B?bi9oQ2lkV2J2S1hlSHFGYWhTNitUMHdvakdHOHJTODlJMEJIMTE2Q1h6dlh5?=
 =?utf-8?B?TUE0RHBEaU1HSUxET2dyUHR5aCtoQ2ZLbTZuR00wajNWenUvdloxWklRZUt4?=
 =?utf-8?B?cFRjQUdPaURsaUFNU2cyTHdndlFNamFyOWRXTzhTclpmMFpiVkxCZ1NidTNG?=
 =?utf-8?B?M3h3a0ZkdS96RlRsNlE3MlhZR0grbEtVODNiUE43dEI1TlJRTHFueXlSdnh4?=
 =?utf-8?B?Z3dBdm9Mb0o1OVFVTlQwWkRWLy8vamhYVlVlbnY1TnE3ZGlWVUdnU2FlUVdv?=
 =?utf-8?B?VGh4blBRLzVQajdoUzZNRkNLL1Yxcm1CZnIxSU93eGFCekVTRy8wVmdJa1dE?=
 =?utf-8?B?WXdlYXhld1RCYlltVCtFa3kzb051L0pzNkh4MXdGc1RjaWFwVzRPKzVES01s?=
 =?utf-8?B?TWp0UWlndzFmcUVkNWVXL21TdUMwKzkrdU9tMFV5RjFRa29Rb1Y5V3pWaHlE?=
 =?utf-8?B?Y1IxcEpyZEJvUCtUVVYxWktsNWh0eEdhR3cyVGhGU093Q25wQ3p2aEs5ZTRV?=
 =?utf-8?B?cE5mOTZEZUpvZU1yamVCWmo3TVpUcFBnbGtOOXVFMXVJbVBxN2hzZGtKNnBs?=
 =?utf-8?B?eVNKUVVoMk14Y3BYakF0SWx2UHAzd0JwR3pMZzRJcDlvU0VmRVRKU3dDdW8w?=
 =?utf-8?B?NU1QTGc1L2ZITVUvTkYrMSs3YklnL3hWSS9Pdlprd2dGZEMzaEV2RnFjUGF0?=
 =?utf-8?B?NklqOVRMamRuSUR5ajlmanBFcTkrWWErWnB6UU5hd1RoMUpPRHpsVDN4UUJQ?=
 =?utf-8?B?Z2ZXdEo3UlFxUHhXTHhEZEN5TWtPSy84Q09JVVQyVWp1OUFDYTR5ZUF4TC9U?=
 =?utf-8?B?d29GRU05NEc5cGxiT0E5dEZVcFN5aFZTSmd0SUw3cWFUcXJrNUpWa2wwSk84?=
 =?utf-8?B?R0d3TlFiS3FUTFZZRElMR0VPNS84aWpwSjZpQnpiU1dKZm9rNGt0MmRtV2o0?=
 =?utf-8?B?cXhQZmRhMjhnbG1CTjBtTUNEb3dBbG9Ba3M1N2dOU2hQQlJZR0doS0RvV0xH?=
 =?utf-8?B?ZXBnS0RiK2xnMWJ2Y2l2bEh2ZUVoRlQwbFA2UHd6VitSMjlwb2grYWJSVWZ3?=
 =?utf-8?B?VFNtOXFQWkJDWEFTZlEyWXpTd3NZZStUMmI5dE0yYUlMakJVdURNTGd5RnRG?=
 =?utf-8?B?aWUwb2VHWUFOQTM2SVN4Ym5XNXVPcy9IbjVtRU1LTzN1dnNHK1NtOG5QTzd1?=
 =?utf-8?B?a05qS1ViRmxJTCt0OTZ5L2hQRFJUZW5wdFk2dldXd0ZabzBIU21MdEV6aDRN?=
 =?utf-8?B?MU9DTTNkTmN6MFlMSmJmMG5JMU9SK3Q4Z2RVbDJ3WmJ5UXRseitPWE5ZYXVZ?=
 =?utf-8?B?cCtSUmpiRW1tUzVlYkdtRHhPMVlKclNFUzQ1TDgwTHpUdzBzS2xRSy9zSHNC?=
 =?utf-8?B?R3M1dUlkZVZpYnNNMEtzNk0xOGpkYkFTQ3ZoVzZ4SkJHZWNhdmExMjJ3ZVVS?=
 =?utf-8?B?ZlpVYnI2RXE0enMvYzZKbHhoVHpTT0hiUFJnSTdtZERHSnA1TEhZWitOMHpo?=
 =?utf-8?B?azNKZUdIODhUSEdDYmZ2SGN2TldDb2ZpQUVBVXFZWTZtcFpzZnh1RWp0dFU5?=
 =?utf-8?B?SFJpUEs1UGdRUHVCUEtPNkpOK2JtM0REN1dNMlQvek1DQ09WdEhMbC9lUjNB?=
 =?utf-8?B?dVZrZEw1M1FjcWlaQ1FhQWVMNkRnbHZZWUJ3QUhyeHhnendRamZVa1hPK2xP?=
 =?utf-8?B?aWRMODBaNG5GNzhtODlsWEJyajdxVlpyOFZNSVNnSlJoTFJoREF2YkczWVpF?=
 =?utf-8?B?K1FiYkZaR1VMVmtQTThRcTV5UGgvQ2dkREpTZmZMTkw0SG8vUkY5bzdxMG5r?=
 =?utf-8?B?dGlQT2M3cmZMOUxKT3N1NXdMaTF6Zzl3Zzg3UklLZUg2bStvQ3pEL0pBQVVM?=
 =?utf-8?B?bkMzTGErOE9ablFnMk9EVUEvYVUyaUxpenU1eU9tVXVaZHFGS3ZDRk14K3Z0?=
 =?utf-8?B?QzZzOFhzV2lPMVpVZ05sTGdiYmN2TFMwWWtuVUZlYlVZbmZ1QXpIUFRURG9r?=
 =?utf-8?B?dGhRRmxTUGVIU0tDWWxCVkp1MVMyYko0OENGeEk0K3VmazlpY3hTdFJYdk9Z?=
 =?utf-8?B?Y1lMMkZzY3hiMnNzbGtMNTNXenZReGNocE5taGU0Q3hPcThwUDlQT2xsOGZk?=
 =?utf-8?Q?a47v1xK3Kv5CQQrKYMbKpp2OKwjJin4+k+4P5lCCBgAQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d368b459-029b-419e-e36d-08da6edb3804
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 07:48:24.6208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYShPd6b+mIvNjxsXoVRX39Un3RDGyDXp9BHl3HXulcWibbeQhEobhBfdCCatWkZSnvp1SgNFltxqPvZ/e3+Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8636
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.07.22 02:21, Alexey Klimov wrote:
> On Mon, Jul 25, 2022 at 9:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Mon, Jul 25, 2022 at 04:06:05AM +0100, Alexey Klimov wrote:
> 
> [..]
> 
>> Anyway, driver looks good to me, nice work!
>>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thanks, Greg. If you don't mind I'll use your tag in next version
> after making changes suggested by Guenter since there will be no
> significant functional changes. If code will change a lot, then the
> process (Documentation/process/submitting-patches.rst) will require me
> to drop the tag.

Hi,

while thinking about this a question arose. How does this
device react to a USB reset? A watchdog that can be disabled
by a simple reset does not like very reliable to me.
Do you need to implement pre/post_reset() ?

	Regards
		Oliver

