Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D469C4F4F05
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588035AbiDFALJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443859AbiDEPkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60135.outbound.protection.outlook.com [40.107.6.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0523D10E564
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUIqr0wXFY1cFmZvVVvTAataaOzZoufOKqsgY4xWxfAch8eNbX+GF9/Nf2P5vw8EYqrAzuZOYJNpevRYUcC83SsgydiGgejVR9nfVL1Q8w414Ih7z7eW7Ir/nFcDIW1AfnvNkmPCbYF603PDTpYIa0LVKKU1N7dLno77GxU6Bb+M6cYRLcJVb9mK5+geoUc6yDv0kPqMu0NHm+4uAXyyQD2HVmojepjaPUW/6BXBicNBeCZ6SFPz60dT06mfHQwmBITFFBbPEJQJZS92uYsMFibelITDKGWsIaQ3NWWKOPHCbb0HQoBPapmKVZ+CiIccfu0U7vXlQ7+eCVtQo50srQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0E4STAZFcewHycGs8tUJgQn+MiZaqTy0L0i+omE7uY=;
 b=j45zRAih3HbpC3kRVljrHMCNOYbkB/hWBlgXVAPv7ZiY22Xw4GECGRNIUikX31MWEK3NrHwP5e8OVuDRUZT3u2VCH2fJNFcMIJY/vBQaKGuqGuyd1mxVmY/eOkZvYsGzuvZQvNsFDdUcdlQ+nTb+xS+rySEEjr/r7543lRIQGXFfaAvHTalzahqS4bxKDK37amgXY+tvt6ch+Ykvd16x7WBacNYAjw/ziOqJjpEUT8ypT8kgR8up3/VqVnIlhTSz/u26clEfz2uUj9igidcxTNPTrpw/N0IRjmPpm/fxkWve8OQfa+A8Xfl7JHsDj/SodGcLVT5p7KSppMlBnmGTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0E4STAZFcewHycGs8tUJgQn+MiZaqTy0L0i+omE7uY=;
 b=ki/XUvE3OSXypRL9RCj67hvHvVXjU28X6ONZ/bKexK1OUJKUJiGwlohNtP9LC+jAwcpnTKLSlsYpyLkLPHzHWkmrTReAj8pMB9IGLk75Din0+pQH3BII2MvMozAN1PPlYudhepV5V6TKSX70pj+nH3JwqAx6MtuPo+GONptWLlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by DB6PR0701MB2758.eurprd07.prod.outlook.com (2603:10a6:4:22::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.14; Tue, 5 Apr
 2022 14:00:57 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::2505:5d08:7490:d517]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::2505:5d08:7490:d517%7]) with mapi id 15.20.5144.016; Tue, 5 Apr 2022
 14:00:57 +0000
Message-ID: <404b3d6e-510e-c15f-a28b-7425bcc67cc2@nokia.com>
Date:   Tue, 5 Apr 2022 16:00:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: mm: swap: locking in release_pages()
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <89009285-c75d-0f09-5b08-d133c42a18f9@nokia.com>
 <YkwdRnuQBjoJ01YK@dhcp22.suse.cz>
 <dc5eb22d-5389-bacb-3756-253e774a8394@nokia.com>
 <Ykwr7OHllqM+Dpii@dhcp22.suse.cz>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <Ykwr7OHllqM+Dpii@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0170.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::30) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8fe74a1-d546-4863-ee1a-08da170cb551
X-MS-TrafficTypeDiagnostic: DB6PR0701MB2758:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0701MB2758F702D9766CBF3A7A3B9588E49@DB6PR0701MB2758.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkjxreIe6mkefX2HFj6HTXL6L8+wtIPP/MNVun3DttzD+i3ivSQwSySLzeEixh4LiLz7MMTpYhTN5y+LbvzEfHBcv7UImevQt5h+hcobyTyfBnxwmJuM1VlcSlRu6uuRSBf5YriHihzXuVZqlDrZA33dM0XFR7XKrl6OQHk4IaBqNaGXrk8A3jI2Ad9c6f7m21jwVUj9ZILBB5KceWBq0AfyLhMMFhlVnFmtJnpJqVzr3nJaied7LzCSSaAB5qV3wlsd9w6kEMpI3Isdo0L+XSYAI/uu+dNZi3Cay450LG7mltlguvVQK8NkNnJfWzcpTWwAoABXz7BL95YPjF3cOlQRCH101P0B5bT3F0tZ1fi3X38JPS9SeI5eu13pn6//TNtgN1iJE/gXWvvBArHO++qq3BwdlRHvfM8yh7YdjK0F/LxH+fxfmp0OjrzFQu1o5d8/fAhV5Vv28L8Wy8JCYUwoLoMLha/8ltThphuhAlWqG9AUae5L1LJd92b2mDImckaObZTr3tsNKMLdtny3AXc5o/SNvtVb8Xn55NbdloeTxTDlH0PhRPGsDIuShrBN6J0Izqcxm4dysmawJWNWgZPgWjxrn/skjH2w6m+PyQgZ2l0+yqJPQ9ZTzBB98NIh5sqxeikRjIewtFG8STSj79KAUiJz3rsuyOWHTNwm/SH+13ewpFI7npzVIvesiJBOmBaanabVTJsdzjiGKlKH4Mb0O1Y3K1UPZ59xpkrgIYEydi7/VnuwrFJCt/Kxya8YJEqegUNGud3CXxl7ZL/ZuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(44832011)(508600001)(5660300002)(6486002)(8936002)(186003)(2616005)(52116002)(86362001)(26005)(53546011)(6512007)(7416002)(4744005)(31686004)(82960400001)(6506007)(6666004)(38350700002)(83380400001)(2906002)(8676002)(66946007)(66556008)(4326008)(38100700002)(66476007)(36756003)(54906003)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b044dlcva2VXeXI1Zm1SNGEyUVJTMk1td0hET20zMkxyRVk1eGpnSUd2UVRY?=
 =?utf-8?B?MnB5OW80a0w2UEllK01FRXVHYVVHQ2Y5UFNTUFZqOXJxK2VrdjhqK2VnbkJu?=
 =?utf-8?B?ZVdsMXVxZkZ5a0lrQmh6Z0QxWmd4YkI2aThSQzFhRkxjNVN5Wkt0NFp4NTYr?=
 =?utf-8?B?OWJyNEU1NXdQUUdqNEhuSVpUdEV4ZFN1Q1JveGsyUmx5WVhvQndKT1ZOSEFj?=
 =?utf-8?B?UHg0UURwNEhOaGtpQUdNVDZWazBUc2VoNUtGN2F5LzU0cENDTEVaVml2SnJ3?=
 =?utf-8?B?SmMvMllBaFpQT2VGOEVMK0NWRjEwYjVhU0VnZ2xlZjJ3SUlGWDYweUZvOXJs?=
 =?utf-8?B?K1ZmejRCSDJxZ2N1MG9XKy84bk5xY2pDcWIxRWpLcWdVeGZCcE1kOU1BNzFX?=
 =?utf-8?B?ZW1oYXoreEJpOFBaMllmblRCUTJKbWpYQWFMeCthYUJkeEFHbGNLOElZZlB4?=
 =?utf-8?B?aGM0ZXFTN2NoK1BwaG1nSFA1L3p0djU0ZDI5RjhDNFFmaFEyeWMxWXBRQXRn?=
 =?utf-8?B?Q1NvVEhEQjEvTGxzTFMrRE9OeWVZeXV1L21IZFg2dU5pNVBkSjhjOXFPczdR?=
 =?utf-8?B?OEVuUEhSQTdhd1pEb0RXWisweGE1VzJFeWNYbXZIZU43K1UxMmtHQUpXdEda?=
 =?utf-8?B?cUtvTE84MjlYdGdESG44K3p4cE1HTkNEM09LbWUvd1RuVWFGUTlVNWNMTjkr?=
 =?utf-8?B?MEN5ZzZOeWhiaTRkd01zZGZuSHF3OUw5cEVxc1dJajhobUVES01ORk1ZUkNs?=
 =?utf-8?B?REpEN2xyWDdHVGF5VmhhaVlXeDhHZ1JNaTdPdDR5dlI5RUhOeFJIa3lJMlAy?=
 =?utf-8?B?amJ5bzRoVThOcU1tWnY2NmJEL2NaeUhCaXJDNHFJdGVwaDk0ZkVISm16N2Zw?=
 =?utf-8?B?OWNDZVFZMDR5RlZzY3JSZG81Tm51V0c1bzI5cGNqOWhhdFF5clhYdEk4OW9S?=
 =?utf-8?B?cGkveVBRT1lOS09qTGNtczdqMkZxZEsxUGRoNCtKMVBlcWIyVXVteWlUQ0ln?=
 =?utf-8?B?S0pIdFlwdUxEQ3drdGUyZ0RVSjFKeHkyZUVEanN5TzBlY0VUMFYweDNEckx5?=
 =?utf-8?B?Qk9KUnFUWVJYNEdMbmthOWJwYjNwYXNldGhmS1dGTEc4THJ4MlMxYk53bkZq?=
 =?utf-8?B?V2NybjFtTzhaaGlCZGV6Q3dicy9ZOFFaOEpNWHlpK2svT0J4VzBQcW1wMVlG?=
 =?utf-8?B?RE5qcHBUTlgwTU5wK3ZLR0pyZ29tTS82TWxPL1ZYUkdoM2JoL3U1SUJhVU5y?=
 =?utf-8?B?UDdJeGZQOXJqdjZCa0lXd3NnSTZpUlBXTjdLeDY1VjRLcW9JejN0RCt3MFZ3?=
 =?utf-8?B?ZGdJbmhoWjBQMHBlRElDeHVBS1dYMEpJY3VOQklxQ1FYWUdiMThuK3JBSnpQ?=
 =?utf-8?B?V3J4RVZwUE5mSkJpU0w3b1hCSVEvU1p3bEE1a1FBWS9hZTA4QWU2Nmk3QnJi?=
 =?utf-8?B?UytDV1pOOE94TnhldVVvYmpmSUQzMFYrekl0VTE2QUc1YWJKWDU0RXdkbHQz?=
 =?utf-8?B?T21qaTNzOWhJSXBGRGtwUFZWUVEySUxwWmxqYWhiSVV6S2RqZG9Mb28wQjl6?=
 =?utf-8?B?THZqWFc1VDBYdmdXdjQrZkRxVzc4UTYrMVBCYmZnMnFEOGRaMk9DMXd5Y1VI?=
 =?utf-8?B?czgxdTFOU1UzUWR3TWdZUGdhVHNnMWxIbFRmcFZWVGhxd2trNitoUGxmMFRY?=
 =?utf-8?B?bERwSzNsNEduNWJ0b0MyN2pSVTJnSndTM2ZtTUxkUENnb1FnL25aL1EzZ2F0?=
 =?utf-8?B?VktDNmIrd0M5bitmZHYxM3FpTDVJbWdXd1JLZGd6NFJheXhkRXFQbVg2cW4y?=
 =?utf-8?B?YXNzOEl5ekRUbS9jUkFQcXBlRld6Tll3OFpOdjI3eHRUdDBmbDB3UCtiQUhh?=
 =?utf-8?B?cjV4U2xpMnFsL0d6T095WjNvS25lVHdwa1o2ZmpaMnVQUTNxV0ZDZkkrOTJZ?=
 =?utf-8?B?TmlpRGVqYUZPNTM2QzdzK0N0UExiY1JScjJRVFFXaUs5dE9oYjUzeVFmWjFK?=
 =?utf-8?B?alJsL2swZWNsb0pPdElEWDNsQmZ1N0NJbndTMlh4M3I2OFJwcURUNHhkUVBK?=
 =?utf-8?B?cWNtWGRUUEpRZVdZRFRJblNidlAyODJYNWlFb01mN1NuRklSV082MS9NUmk1?=
 =?utf-8?B?RXFoR3NoeS9FNGZHT3BZeFpRa0Y1ak44WHd4b0VBdTZ5UlA2aVZINTk0eG9L?=
 =?utf-8?B?Y0s2cjVjNWRPVmRyN2hhWWF6cGtaSFUvSStEdTBtQmhiU1NJZ3l2cGwrNjVs?=
 =?utf-8?B?amVTbGJEdlNHekRaZld4K1EvYnhHY0FQbWY0eVFvNXcwUDZ0bFdUZHFBN3Mr?=
 =?utf-8?B?eWRJVkgyM1FaOEhnNW9jSmUySkJUTHVWMFBLSVRWZUg0RmxKa3JqNi95WmFz?=
 =?utf-8?Q?KKuhv+TJ6o7QSrFvv8XMPjBSCyASZrOdGNNkP?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fe74a1-d546-4863-ee1a-08da170cb551
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 14:00:57.7781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubIoee1YG2NdMqjjnxcW2paBWInq8DQqPP6gq/3WUFVhOXSl7tRI+QJKS9zTyKsXJedW08DsiPqPChOcVAsCT/c0mFC/t0DNGP0G8nZEh2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB2758
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal!

On 05/04/2022 13:45, Michal Hocko wrote:
>>>> 1. Crash of v5.4.170 on an ARM32 machine:
>>>>
>>>> Unable to handle kernel NULL pointer dereference at virtual address 00000104
>>>> pgd = e138149d
>>>> [00000104] *pgd=84d2fd003, *pmd=8ffd6f003
>>>> Internal error: Oops: a07 [#1] PREEMPT SMP ARM
>>>> ...
>>>> CPU: 1 PID: 6172 Comm: AaSysInfoRColle Tainted: G    B      O      5.4.170-... #1
>>>> Hardware name: Keystone
>>>> PC is at release_pages+0x194/0x358
>>>> LR is at release_pages+0x10c/0x358
>>> Which LOC does this correspond to? (faddr2line should give you a nice
>>> output).
>> Sorry, I forgot this info in the initial report:
>>
>> this is indeed the del_page_from_lru_list() in this crash.
> Could you be more specific please? Is the problem in list_del or
> update_lru_size?

static inline void __list_del(struct list_head * prev, struct list_head * next)
{
        next->prev = prev;    <--

-- 
Best regards,
Alexander Sverdlin.
