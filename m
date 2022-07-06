Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F8256882F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiGFMRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiGFMRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:17:44 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B272AC8;
        Wed,  6 Jul 2022 05:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2y/ERUCjl6ZMtg428cpj1HyWzZPqAT4livCwLjuQ8NDhSCA8lF9a8Yji6owMUBGb28l3MYCBKN0mynAUzQR63OpsDKrIGjP5U51jbZ4B5TRpv3R11nnwxdiLFvpVo4UI1fzv7X8JuyB0/5/Q5lL0REYFnoArNmZZRtdD/7XVmqQx/gadpdxDa8tJ63VX0eg9P7SRxsFVytcQyS++00KGTKozHRsMQmMfxHTE/RaKA63fWf9DWZvU1egqAex4QdlKzPNN6pVyJIXgbLfLzd9QEls447o+k98kUqzbeqRz+xOKje8rrlDsh1BO8aGC2ugSJKw/USym/9hAGE2ald3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnnOe670n3aTOsLl4tAIbekZv1ma69KQWTkbYZp0LK8=;
 b=lc5Dl9vJp0PD2ri8smvQO/5bvEYYmmZqlMuYiJr7jCaYlaEkRLdqYFPtgC6e2gkOMiJCOI9FiEDsnqBXpArSyFLGpDpMzx1PrbSK1f1YOR1Px5YaU/PcIpwPpsgqMWeuIeLwGFc3uAchIAknkBhLSo+ecHL2Wz/UMA7JcdVvVogGxvxRrVMZCf9dQyUgkk18y3NBb9F2QlxU92GM2pEluTy1dCWj/9ZqrpUP7vtvlEWp69OYJXm3IrlGtHqnQ+mc/kVDsvfOPQOsqN153oynDcszF8CB1Epi6Angv43YzfX6zKhc1xtr4fZZtOKLkFUPrgD+eXwgDZx4WoL7gFe/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnnOe670n3aTOsLl4tAIbekZv1ma69KQWTkbYZp0LK8=;
 b=jG66nT0hCUiu98L4Qm6MzlYGQ8MXrUACUiuA0fxI+Kd/VhxfKZusUvStpfedu+MhBF4hAtB7ljb7pCZWqRI+Qfox5C6Jx41/qigZ8pYeiIQK9QiZy24OM1uE6nwzBjQzxzIP7MV+ALA7u1iVKDKWQM0+jy2r41kDJIMB7icHcloe1q3FIe5Q3E73QL7wW//nuQyoxcS3AWyM4FOwT2yAqrU6ajtXNmeEapM+OXFiW58vgb1eP4Y8fkyQmn6qotnQ9KBwo7c7LsgKtbrKwE4qDbpy0n2Pa1Qn89em/IoL39UxzOVbRPBoxOEhmfJcJMiE8V+/cNJwrvkdKC6c3PSA5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by DB7PR04MB5995.eurprd04.prod.outlook.com
 (2603:10a6:10:8e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 12:17:41 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 12:17:40 +0000
Message-ID: <9e45b464-c680-7d22-c81d-9640059ef913@suse.com>
Date:   Wed, 6 Jul 2022 14:17:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arjan van de Ven <arjan@linux.intel.com>
References: <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
 <YsL5pUuydMWJ9dSQ@kroah.com>
 <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
 <5665ccb2-b92b-9e1f-8bb5-a950986450ec@I-love.SAKURA.ne.jp>
 <YsRHwy6+5gask+KT@kroah.com>
 <064bbe2a-c18e-203e-9e01-b32fe9baa390@I-love.SAKURA.ne.jp>
 <7ddb25ff-60e5-75be-8080-2a7465cca68c@I-love.SAKURA.ne.jp>
 <YsUtBERm94k/iZTy@kroah.com>
 <a6d98824-56c8-6d92-bb1b-eb065b57cb81@I-love.SAKURA.ne.jp>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <a6d98824-56c8-6d92-bb1b-eb065b57cb81@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::15) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 008d3f6c-802b-447b-1682-08da5f4985b4
X-MS-TrafficTypeDiagnostic: DB7PR04MB5995:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyb3hsBXzLUgSEA5ROwM5uGanjq5/PM8Cd2nJcLwQBu7STOVRuN1VzVReUAVHztzH7jppZjJWzbxpl3V0hxOaRegpZRSt51UAi2e+WTvMdz7iHs72qAcbemfDcaKKKHxS5kyK4cTTyfLIjItHbJgwclCmI4buidBq0V/8A5nKlpaQW549UhDZLvUQsPJrI54KaLC1SwZZ0oLxag+8Tf7AIu0dQWO6l8W7Q+VhB8+++Z479heXOJ2SVdr2UBmaZzoPzslspdU0Zk+IEGWpDQvgDCPP+1QKB68aBvHryjpm3/taRnlV3xNZbGBHmczjm/tOueXsrYpZoia0Kmtz8pAXC0SQq5tnXFwAe7Sis+jCEUthmDcABmtTVzYFumZ3MXxL5w39gf8vJAVE2sTLapBXxhURQTc8PbbWZ3euLSZSeU78hKrCVuEMSBv+MlB2OoKktenRud0pDYC8cntycEtfkN8FzxwOphthksWLcXGs2uI0o7q4Ci80kTQB1pWQxbxGxKua0y3VsYswxG9R5eV/xwD7ZIx+4KnMFICKETs6lm/pqc+wPbLlxMj703S71o4IH4X4pgG89rpqjv8GLOrmOT6vIKOAD1D3hEoQ5uLyXRatfdbFEejrZ59pOzYocQbT533UuEh+AOm/5Na7gsX2yLLAxwyYpf03Pn5dpWlyg3rnzWpTDBhssM6h93UkD2G2G9/wMLqz4UCNAvBUOwEI9Hx/FHmfLUGmXzNijJFQXXpN8T30JEIQNQX/xJ68KulM6qT7VPsA/btbiKosJg4WL4Md6CdogBTglwK03L87MUnpemCvsSPW8Jwo897RwrZTnbnjj+FKd10uINpLukycA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(366004)(396003)(136003)(6512007)(2616005)(66946007)(66556008)(66476007)(8936002)(7416002)(4326008)(8676002)(5660300002)(31696002)(36756003)(41300700001)(86362001)(31686004)(6506007)(2906002)(6486002)(186003)(53546011)(478600001)(83380400001)(316002)(54906003)(110136005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHFHdlEwMjhzVnpKUFllS1VkUDdFVEpoY09DTDdTczg5RHExaUZIWWs0RklB?=
 =?utf-8?B?aHRoZ2poT2tjZTNjNTc2OE9VTGZISUpIMnRiczVQdzN6NE5jZzdSdDBBckZ5?=
 =?utf-8?B?V0RkNXh5bXg3QXVZRW5VR3JtVWVlUEJQczBWYVNmNGNVY2ZTVWJQQVVGSlFX?=
 =?utf-8?B?Tzk1bHovR29EWDVPdE5vai9jVGtLR2xVVkUzdHpPdVpSRkk1VkxLZ1hJc01t?=
 =?utf-8?B?NWl2RTFUNkNhMDh3OGllSTBiOU9FRzVNQXVSMFExWjlNMWEyVjhtbFdqSWlS?=
 =?utf-8?B?TTd5cTA1RjVqR0F5eDNFRnE1eEVJbGRNN21WZmdpL0ZZQXllamF1WFNYUFNr?=
 =?utf-8?B?emlweTJXNzBTSEg3YmhRM0s4OTJiZVY0R3N4RW9GNlgyZGkwR0l1dWFBV0NX?=
 =?utf-8?B?OFVKZHZ1aXEwanF2SDlCYUdGL2QvQ2JRZHB3cHpuQ0tVb2s5SFBRUGFkSnZn?=
 =?utf-8?B?T2ZNY0Yycnc0ckpQWTlzL2ZvQXdLcmRDMWZZZkM2cUY0QUFhcE02MWljdWlM?=
 =?utf-8?B?QXM1RytQUEgxQklVM1lTc0ZoRGhmQUhRTVFVWEtDNmRiNUdtUGJ6ZUQ0RW1m?=
 =?utf-8?B?RWg3SWkwTkhRaENOVWM0TlFDMUdDUTJYb0h1eE81Z0V2R1hRWXI0VDNEMTRV?=
 =?utf-8?B?S2xWTENTbFYvSG9jMEtyZXZGc2IvSElYczI0Z05UR1pocXpoWXcvcHRwQ1BJ?=
 =?utf-8?B?VmhKY001d1NBc1MrZks4RllwdUpGQ0xqeWE1NGRHMGVOdnpFN1Zicm90Slkv?=
 =?utf-8?B?VkR4dHFKL0FnbjA3czd1bVNEeHRiZFBOYlczT2JxUWIzZml1YkFub2FQMFly?=
 =?utf-8?B?ZWZ0Tkp4ZnlybklrcU5WdGczbEpvREdIeGRQWHlReXZSVUVHQTM4bGs4NWVs?=
 =?utf-8?B?STlhc2VsT0JhVFBTUkF4L3N1ZjAvRlEvUzNxR2JRbnVCcGRwbVBtT2FyQTdW?=
 =?utf-8?B?WittVmFjY04zTWJ0bytvcGFaNGdQc1hsN2dHQ3ZHRDJLNWYrMWk3cW9wakp2?=
 =?utf-8?B?ejZuU1NtdHpmZVAyK29RbXNpK3hKRTgwZE9PSHpNL1ViZE1Ca014TUlJYTA4?=
 =?utf-8?B?RFE2Qi80ZWVNNnVxRE0wWVM5TUNQOUNMcHdsL0lNb0NaYXh6ZFhIRWhWeERD?=
 =?utf-8?B?Q3ViUWVwakZTL25pTjVtUGxibjRLOEh0NGZlcS95WFpJb3JRZ21PeWxtK20z?=
 =?utf-8?B?ZEN0ZU1ySFB3ZS9wNWJUYkJpbncybWlrQlZtQ0diVnluTzcxQXJnUTYzYk1F?=
 =?utf-8?B?OE13RW9OakFOZWpQcGNpbEtsTVdCSGszZ3R0WnhDcHN4elBUcFdVcFFYemRN?=
 =?utf-8?B?dzVuSllzMjhOVThNdjBaUFdZc3d2MzdDdGRHWXNacU5oaTZQNWpwZXpQQTBl?=
 =?utf-8?B?WlMwbk45VFBUS0dKbjZFWHNFZDZkZUI1Y2w4aUIxc1liQlJiRERLaXora3hl?=
 =?utf-8?B?Unh5L3BsRkNDVFlUblRTZENuZzkwT2s0eGlTTDR2dGdTT2l1UFh1UGNKdmh1?=
 =?utf-8?B?am9hVWt6Rjl6S3VtOTh1MHNxZSs4cUJpSldLcXd2SSt0YkxucWk4ME5ZM0ZN?=
 =?utf-8?B?dHhBTUQzZlFubURvb2VuZEhBYjJuOUh6bExTWHlXUkFkMG93VlpEelpKMGFH?=
 =?utf-8?B?VFhOYXRUM29PY1FXZGJXVEVqSG5BUUhLd3ZnOWRHVzJJR004TTBkUlczVXB4?=
 =?utf-8?B?ZFY3aXIzZWorOU8xQUhkNTdrWlVYUE8rNkhVR1F6cG5PNW1ySDNkeEk0NGNv?=
 =?utf-8?B?U3JDNFAwa21vSlVGRmp6UkZyL3RrWG9JRG96b2RpendRaHBnbTI4eUNiMVNq?=
 =?utf-8?B?R3FCVVBad1Z4QlhreXQ4bDBHSEU3QzFEbjhrZTByOWp2RDhEL3F6Q1JINTh5?=
 =?utf-8?B?RHZNSGZaK2N4eWI0N1h4UzFMMlBMcXZHeXVNZU9INGZiRUdpcDNjajVTYjl6?=
 =?utf-8?B?RHh5TVczQnlRd1BsVFFVa0JsYkxVN25QeUM1OVc2dG8yZmRvL3M3WXVtWUc4?=
 =?utf-8?B?VUtOUVREcU10dXRIN3Ard2tXK29KaHp5dFNvZFFYVG04Z0g1NnYzTXkyTDhT?=
 =?utf-8?B?QU44b3U2cHdkREl2Q0t6dU1zYk1aSlZvaVE4Q3lERldVQmtWTXJkYVJKS0ZM?=
 =?utf-8?B?TWxlTlhueFdHM3ZJNkU1ZW5GWFhqUVhnSVM3WXlFbHdUeUxUNldUK1prRitX?=
 =?utf-8?Q?JAklbRoF7fmxBhlt+pRjiRQE3F5srlLGs1yrAzFlR7Be?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008d3f6c-802b-447b-1682-08da5f4985b4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 12:17:40.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8YzNe/Gd8B1ves2vxal/osDaRfv+yVnwfixeU+zccxD7Jfv8GwDUgLu2eO/HwkUY2wxpRdKB/Etrh9+D5zpCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.07.22 12:26, Tetsuo Handa wrote:

> wait_for_device_probe() in snapshot_open() was added by commit c751085943362143
> ("PM/Hibernate: Wait for SCSI devices scan to complete during resume"), and
> that commit did not take into account possibility of unresponsive hardware.
> 
>    "In addition, if the resume from hibernation is userland-driven, it's
>     better to wait for all device probes in the kernel to complete before
>     attempting to open the resume device."
> 
> 

Testsuo-san,

I am afraid my first reply was too court to be useful. Sorry for that.
First let me congratulate you for finding and analyzing an important
issue.
Yet, I am afraid while your analysis is good, your attempt at a fix
suffers from being too close to the analysis, instead of taking a step
back and looking at root causes.
Frankly I was afraid you'd look at UAS next and try to fix it in the
same way. And that is the core of the issue. IF the SCSI layer can be
made to hang a host controller by an unresponsive device, the issue
is in the SCSI layer. If you were to insist on your current approach
you'd have to go through every host controller driver. You are just
seeing this only with storage because you are fuzzing USB, not SCSI.
But the bug you found is more fundamental than a single bus system.

The SCSI layer is just designed in such a way that timeouts are handled
by the core. That is a fundamental design decision you cannot easily
deviate from. Hence I would like to ask you to take a closer look
at the scanning code in the SCSI layer, not a host controller driver.

	Regards
		Oliver
