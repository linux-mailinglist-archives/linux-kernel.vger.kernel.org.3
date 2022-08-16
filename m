Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9790B595828
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiHPK1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbiHPK1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:27:03 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F9920BEF
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMbjT8bcgjSSUOuQNal2OQ6+BVlJYv/h5G1MS90eJqgK6/j53XkdCOksDXEmvKWxQw3xyA4I3BGja2xqW/JpOBJ2RWdnscgw6FqxwSPbkI8vRUwbO2aisv2J0hW78wUWU10/NUBvH7WU3DJffAypEU9y+5jtKdvO6SA4t/Lsdl/W+yOElpNp9CXomXvkEmSVuGg5Goi+xqG/QtY2mFlF6QbhBS+UAB+X6GINvL+vWIAo7XNlXQYjfNd3Phywms7jXF5zNByYt+ZB/5XOfVRmIvutlKMKZCCgmTWZi+qK3Wu688r9jlumK2FaZlJkb7pnfomq9veGzRf8oIm9csVe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF+6d6MfOSIAkE5R6AdVTdVC/mczVEuIJ8B+91gNGW0=;
 b=JtwCGoAZFongzGGYu9L9G3WX+6Ee2qdA4GT2BLs/9bGrRVnNnmFWthmlFCzQauED0gE4nifwQcVJJA8ZYOYGCp/juSDAFD1D7dgwl6zyF537IMRQdEsnJOTxr0BJIICU8Cv9w7Y1B01QG7mkRVL/EXqKvrLCsfAhn85xYwqn+fUjhaeXshhMZJgMPm/cgNgpOLIRRfly6JrZHT9v4JngBqay1twNBXBzUWg6gfe58JaQWfGrsngOU7xSbwQSXfqoUETRZiDj1xwUYH75wl0wDmAdZ44YLZPI1+jeTOeznnDHX6EueuOBVFRP2nDHT6GJNKhBIcTOp3xaS0vEXkeDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF+6d6MfOSIAkE5R6AdVTdVC/mczVEuIJ8B+91gNGW0=;
 b=O3VXF+pIT0pfnnyIOg2A1xzyxQPJhRA4HceIqk12ZWpxS67BK8wu+9ipYG4fjZfeokAd8pXqhrDlCw+cBHUDjzF33cXa6IME4b/CKqtK5YkGqFb0XDCEp3hGOPGWT3rSeEzKXwDm/X339+g4uOUmKGZyBSxar7hXt2qcfncGamo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by AM9PR08MB7014.eurprd08.prod.outlook.com
 (2603:10a6:20b:41b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 16 Aug
 2022 09:20:21 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b%9]) with mapi id 15.20.5525.010; Tue, 16 Aug 2022
 09:20:21 +0000
Message-ID: <ec3d2515-b2a2-8441-2e9a-a7fe664e048a@wolfvision.net>
Date:   Tue, 16 Aug 2022 11:20:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [BUG BISECT] phy: rockchip-inno-usb2: Sync initial otg state
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>,
        Markus Reichl <m.reichl@fivetechno.de>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220622003140.30365-1-pgwipeout@gmail.com>
 <88f2de00-32e3-ed74-082f-c0972a81f0f8@fivetechno.de>
 <CAMdYzYoTLjRW1FgwfizUu-+k0R4tCO78qYa7MEpgfz99aj3SvQ@mail.gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <CAMdYzYoTLjRW1FgwfizUu-+k0R4tCO78qYa7MEpgfz99aj3SvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0501CA0033.eurprd05.prod.outlook.com
 (2603:10a6:800:60::19) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88597ab9-7212-443d-9057-08da7f688b24
X-MS-TrafficTypeDiagnostic: AM9PR08MB7014:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3M6exVgb3+9PR4f3gh3EYbuFFiRyxfvKBa2KmaKKVAwIBgRvX0RZx0+rWTAq00WwJ7nXb7cznOatZ6uLjftSwkQ6UYU98BoGgbWVTY4IbjaNJxhNZgDuYtA4vGEix8vXA8uFHWCnbbm4tHEKEhCjSd/vOoaXypRI4ZPGhrwU/wL8FSa1RX3RViygS20j60tF7u2dKR64zRWMMzpsMg6eh7ABVCH4cO9Q66t6lqNgL3GpDNRgMaRIlczM8Rr8aSyqQlw5LEsj5MXwFtE4ugrPX6FrPz/s2ReIYeYzbst9hdmZQTPeziiGgMqy2kIkvzWI9kEgD5TamSzKFOwWyfSsMx2A8/FYinv91QHdITPqqCodripPO/rf6uWPeA/F0LszIuOlroK/a7wGfOV8J8DDVKzSGEVHJN3CpsSEvWFvKN8z/TAFvO2p8KP0Ss5HN0sQyvIq5LwnfrDUZsNc+A7X8aVBvZef0l4LtfifswrdVRAHmcHp/GtsbIwhwJlymbRbs/EbXZkku0pYZA+oMB6214mAdMIyA/jrRew5dKJIfxuBDABxkz2oeA05VPAEELQ9jtO3vynRz703c7mg+87iVIY/zWRa9XK5DONO/qRG1Qb4WZhj0h1Vwo6c0m41PsOnw57GopDVpUNXMzey3xB15PUP8DwR5wmMZRngHZHA+ugjTLLeMuYqm5v2O3blkHGyk6FyxhNH26B94Y2X/2R4crrUr8jJLpzeuBN5xZrkXH0xBrwG+AqDLHNsaUTZ8zb3RVDwOX/OxF+xrmutFzAuFLiQGioODEybd/f7orYeoVOh9z6JufQ+CMsQvRL5NqVdkCWnYsjiDB8xVXOcnrIrt3IGsJ37KaXlo1jLyVJ0NR2Sz6/92uzocV+91fobcvhF/ZOuIZ0dMmSYoFCM0YxZ/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(366004)(396003)(39850400004)(186003)(478600001)(6506007)(53546011)(52116002)(36916002)(36756003)(31696002)(86362001)(2616005)(26005)(6512007)(31686004)(45080400002)(41300700001)(966005)(6486002)(83380400001)(8676002)(5660300002)(66946007)(66556008)(66476007)(316002)(4326008)(110136005)(54906003)(38100700002)(38350700002)(7416002)(8936002)(44832011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDZtOG5HUUFpZXdQSXRyTFJOVzNlUHQ5Qk56R0NrYzVDUU94MWlLSzlnSGZh?=
 =?utf-8?B?RTZDdko1UGtBQm50THd5Y1JzeWE0VlpJK2JMNmZTSWpaSU9uY2pZTlhMdy9R?=
 =?utf-8?B?NXQyMEVHZnFJdkJ2amFwWDhQTDJ5VnVWQmgzNWZpSmg2RDJ2OG9wSGZSM3Rq?=
 =?utf-8?B?dVVzYlRpKzJ0VW1DM25sOWk3MWQ4Y2RNRjZJV0JaOTBVV2pOOXZVNzFXVXp2?=
 =?utf-8?B?SUpVYlNkSTc2Z3ZhQWRlbis1TUFwK3BYcXFCM2wwR1RhaEt4akovc0JxdkM0?=
 =?utf-8?B?WlRWSjFzZ0gwNUxpd0FpNDY2dW5RZitmMWQrWk5tMkc3YyszWDhnYjRRNUFK?=
 =?utf-8?B?WUpWMHhDTjZ0dmhZUm5CVU9rY0xvWklyUUVWYXdDRzRqaGlRQzVhMG04QTZG?=
 =?utf-8?B?QXJxUWVUalFHRnI2cGtjeElQRlBnMGV6SGVTR2gxczM1WnFmRy9ETXVzK3R5?=
 =?utf-8?B?a3UxU0ZNcFhZZ0xBQ2ZEQ3dKSHU1SDFOVzRpcXN0eEVEVnViL2RLd1JvK1JK?=
 =?utf-8?B?ZXJUZ3BFWUtFTVhqK1RjbGRCZVRTamVBeW4wS1V2VzhwcWI2YzE2cUFwZkp0?=
 =?utf-8?B?MGJoQ3hvMVl4WU5jMzJSUkxnTk1wYml5cTZ2UFBZM3d4N0tMSVMra090VE9M?=
 =?utf-8?B?SnZpNjd6ZDV0dmNYYW93UElrclQrMEROL013RkptZHNzZHZRWHJXL2g2ZHh4?=
 =?utf-8?B?SEI3UlJLNmVJeFFFQko5RXkzSjNTbHVwU1lYNEM3SitzQXRMVWZLcEpUMndi?=
 =?utf-8?B?VjgrV0kyZU9ZYjl6aVh0YUUveEc2NkdLZEhaRm5BQ2N6cllKdUYyaE45WnZY?=
 =?utf-8?B?bDBUamtzNDlYa0VDMFRqbDZpWEJSOTNZMXNmTzAyQ3Zvc04vVGJZeHNFc1FW?=
 =?utf-8?B?TWFNRDVnTXNGYlZVVTk3M2FpSE1NcW4xTUVOWnhuRkZVZlA5VjZiL2w5bUVV?=
 =?utf-8?B?endJR2ZyNk84U0ZvRmIrVXIxNEJGSzRMVUlJZWFYUEttblFRaEZEd2VDYUJV?=
 =?utf-8?B?K04rMjZjQThVeWdYOGpHSllNV3M3NEdxeHZIL25EWjY3ektGeGRKL25QR0d1?=
 =?utf-8?B?cWp1bW9DcmtFV25xTDZRNlliZjQ1cUVQaE0wNWt2QVlDT2ZSai95Q2pWNmV0?=
 =?utf-8?B?R1A4QmxLQi82NzlmblhkNmRXdURhaWdXVlFaY1NPb0VWSTE4QVBTMkl3aEFq?=
 =?utf-8?B?bzA1UkxNc1lTWnlXTFNRK2w4aFNtYmZFR2xMZE5kYlhhdkV4NzVBaHhIaWQy?=
 =?utf-8?B?aHpjeWJNRDF3Um5teVJMTzg1S3RtV0I5SWNiSU05WmdaMWhxMEpiVFhJaWow?=
 =?utf-8?B?U2dmdkc1bkFsdUhGZ3BEU2I5dCsxREppZktsVzJTRnJRb1UxUVMxd3lvTEhK?=
 =?utf-8?B?TUpwcUprRTRlOUN2RWtDcTVuSlVhRlBxcEl0Q1dPZU1KYmwyMTZ1OUF5aUlN?=
 =?utf-8?B?ZWUyR0JpZnlZNWxMcnF4cG9HQlBlUUNOS0FLNEs5cVhTS2hpdDUrU3BOU0Ry?=
 =?utf-8?B?aWdObnJSaytBUTBnMWpvdjVJN3pwN1VRbytOT2lHaEtIZXlaZ0hvOSszdzNX?=
 =?utf-8?B?QmNpWUdITzRRY0c2SG9MQlZKMWJYZkVCL1hRYUlJZmhJUFVZcGxkNlRSdVl1?=
 =?utf-8?B?dkhMYTRSVEhkZStmc1BiQzRyN0dOMUtrWE92YWR3RThLUzJidVpQVWJFT3Zn?=
 =?utf-8?B?eDRLc3pJb2ZZeklDcnIvb3BLUzB3b1FWUGpoaWIvSFR4U05LcFV3UjVBa1BT?=
 =?utf-8?B?TGJ0WEFySzNTbTJnalVHOU1TWXM3cG01QjhGL1JPNDRad1ZmSGpGZyt0UHFO?=
 =?utf-8?B?Q2RLQVAzbXR5VlI1RWpoSldYK2RqZVdHZWRkR1ZUSDBaR1RydSs1ZzJraTVy?=
 =?utf-8?B?cmk2Zm0rN1lSME9ldG1nYWcvdmJ3MmFzSy9uU0RZS0NSZWxLSll1M2lHRTdS?=
 =?utf-8?B?OXA2ZXhvbEpIS1krWTJ5T2NjR3VTRkwxQ1lpQWNnNjQrUzkwM050NmtFNHph?=
 =?utf-8?B?SnZkZzU4MENRbm5tZDhSZng3c3ovK3o3YWRNUHBmejE0eCtHM1dQemVhQ1hj?=
 =?utf-8?B?STZXUkpjWlJFOFV5b0kxS0VoancyUkMxSGtOSUU4aW9jd3U4SHQwQ2tjQ2Qv?=
 =?utf-8?B?emdHc2grZTNDNTArb0J5SUlZMHNYNnRmU1VsTlNDTmdKd1NjZXk2TnF4eE43?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 88597ab9-7212-443d-9057-08da7f688b24
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 09:20:21.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVpt2SnbR9id8d/xY/q6vbECswZWEujl/vDB/BveeQCw1g5fxndYDG2/zSFVIwZEtdEo5t+3oLf16ShzeLzHIrm82r4XTivMp88RL4iJkls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB7014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 8/4/22 11:49, Peter Geis wrote:
> On Tue, Aug 2, 2022 at 2:39 PM Markus Reichl <m.reichl@fivetechno.de> wrote:
>>
>> Hi,
>>
>> with linux-next-20220728 rk3399-roc-pc does not boot.
>> Bisecting pointed to this commit.
>> By reverting this commit the board boots again.
> 
> Thank you for reporting this, someone was kind enough to reproduce the
> problem on the rockpro64 and confirmed this is an issue. As I won't
> have access to my hardware until next month, we should probably revert
> this until the root cause can be identified.

Just experienced this issue on my ROCK3 Model A board (RK3568) and
reverting this commit solved it.

Having the revert in v6.0-rc2 would be great -- if there is anything I
can help to accelerate this please let me know.

Thanks and best regards,
Michael

> 
> Very Respectfully,
> Peter Geis
> 
>>
>> [    2.398700] Unable to handle kernel NULL pointer dereference at virtual address
>> 0000000000000008
>> [    2.399517] Mem abort info:
>> [    2.399772]   ESR = 0x0000000096000004
>> [    2.400114]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [    2.400594]   SET = 0, FnV = 0
>> [    2.400873]   EA = 0, S1PTW = 0
>> [    2.401161]   FSC = 0x04: level 0 translation fault
>> [    2.401602] Data abort info:
>> [    2.401864]   ISV = 0, ISS = 0x00000004
>> [    2.402212]   CM = 0, WnR = 0
>> [    2.402484] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000001376000
>> [    2.403071] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
>> [    2.403687] Internal error: Oops: 96000004 [#1] SMP
>> [    2.404130] Modules linked in: ip_tables x_tables ipv6 xhci_plat_hcd xhci_hcd
>> dwc3 rockchipdrm drm_cma_helper analogix_dp dw_hdmi realtek drm_display_helper
>> dwc3_of_simple dw_mipi_dsi ehci_platform ohci_platform ohci_hcd ehci_hcd
>> drm_kms_helper dwmac_rk syscopyarea sysfillrect stmmac_platform sysimgblt
>> fb_sys_fops usbcore stmmac pcs_xpcs drm phylink drm_panel_orientation_quirks
>> [    2.407155] CPU: 4 PID: 71 Comm: kworker/4:6 Not tainted
>> 5.19.0-rc8-next-20220728 #437
>> [    2.407868] Hardware name: Firefly ROC-RK3399-PC Mezzanine Board (DT)
>> [    2.408448] Workqueue: events rockchip_usb2phy_otg_sm_work
>> [    2.408958] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    2.411634] pc : rockchip_usb2phy_otg_sm_work+0x50/0x330
>> [    2.414332] lr : process_one_work+0x1d8/0x380
>> [    2.416948] sp : ffff800009373d60
>> [    2.419406] x29: ffff800009373d60 x28: 0000000000000000 x27: 0000000000000000
>> [    2.422199] x26: ffff0000f779fcb8 x25: ffff0000f77a3a05 x24: 000000000000000c
>> [    2.424978] x23: 0000000000000000 x22: ffff0000010c8258 x21: ffff80000888ec10
>> [    2.427768] x20: ffff0000010c82f0 x19: 000000000000000c x18: 0000000000000001
>> [    2.430604] x17: 000000040044ffff x16: 00400034b5503510 x15: 0000000000000000
>> [    2.433390] x14: ffff000000708000 x13: ffff8000eec96000 x12: 0000000034d4d91d
>> [    2.436185] x11: 0000000000000000 x10: 0000000000000a10 x9 : ffff000001aa7a74
>> [    2.438958] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffff000001aa7a74
>> [    2.441668] x5 : 000073746e657665 x4 : 000000000000002f x3 : ffff00000356c808
>> [    2.444407] x2 : ffff800009373da4 x1 : 000000000000e2ac x0 : ffff80000888eb34
>> [    2.447190] Call trace:
>> [    2.449557]  rockchip_usb2phy_otg_sm_work+0x50/0x330
>> [    2.452169]  process_one_work+0x1d8/0x380
>> [    2.454684]  worker_thread+0x170/0x4e0
>> [    2.457056]  kthread+0xd8/0xdc
>> [    2.459354]  ret_from_fork+0x10/0x20
>> [    2.461728] Code: 91037015 295be001 f9403c77 b940e413 (f94006e0)
>> [    2.464338] ---[ end trace 0000000000000000 ]---
>>
>> Am 22.06.22 um 02:31 schrieb Peter Geis:
>>> The initial otg state for the phy defaults to device mode. The actual
>>> state isn't detected until an ID IRQ fires. Fix this by syncing the ID
>>> state during initialization.
>>>
>>> Fixes: 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>>> ---
>>>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>> index 6711659f727c..6e44069617df 100644
>>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>> @@ -1162,6 +1162,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>>>                                       EXTCON_USB_HOST, &rport->event_nb);
>>>               if (ret)
>>>                       dev_err(rphy->dev, "register USB HOST notifier failed\n");
>>> +
>>> +             if (!of_property_read_bool(rphy->dev->of_node, "extcon")) {
>>> +                     /* do initial sync of usb state */
>>> +                     ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
>>> +                     extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
>>> +             }
>>>       }
>>>
>>>   out:
>>
>> Gruß,
>> --
>> Markus Reichl
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
