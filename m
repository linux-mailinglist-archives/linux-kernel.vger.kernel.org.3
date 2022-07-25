Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1631457FC42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiGYJUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiGYJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:20:46 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20083.outbound.protection.outlook.com [40.107.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F150BE0F;
        Mon, 25 Jul 2022 02:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDRPmqeVgUVmUmVkRWgaq69LXItMCAGCxF9EYmECLDX2Xuy8Sp0neR9bT9R6IhPXvB7CXaAJBuRjXjllRN7NZzqd4Eehv/4OkTd/+B0o+TQjm+aQQUF44zvEvSk6dxunnVtqRUHGI6aU5WcfimvNnJ8mVXohO5ShO/VIsIckD/Q0mO96EyGGIs3WJodvUysC6K0r0p3ywPkHeG1kQWvu6BgpdzOsOCOMwOC5EZkrkXb3u1WshvXHopHMP6Wgv4+8UPb4xSzayhIsqzcCwp9149ELGdU8VvQ1W2tm1joiY3VcakC0bRCHZSxqc77gSR9wYcvKAScPYg7NGUisQ3IZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJbHHLLJ8vhMP3HBNbYFIu2mu/qbj9oTh9rU4cvhFEY=;
 b=go+9LIxtavrI0tZww+Y5wUdKl3cu+ImmOMxGAFSQ+9nQ+xz+yPKJT7ON5Bm7PnJThqahQdnJsT2dBJO/asWZVLUQStvXt2IGBsf/7a2Cg6SrI2PCSQTKZuEnX3qkto07HGKca4XtWP2tmENy1+KmlW8HGGSTdaTAc5TPk6To/1yQxWFuHeGnTEhCsBVvUgJvM+3cJmSwrNrF7znoUip1QlNa8cL9EL0wE3ntkZ+6ZJwHF+MDSlajO9xc82elNkUxRtIdFdgSsXB7SO+mlazTsXNUrV/OPZQgVHrGfoUVwcttSjsDJQtet3EQA2Ez2jdgJTaIOyEzeJTiV7ptwI4cpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJbHHLLJ8vhMP3HBNbYFIu2mu/qbj9oTh9rU4cvhFEY=;
 b=dws/8gUX9E+J5kz3h2ynfo0gOqHYZkY5gUhxbUJREnnADusHTT4rjCh58rasU8wcPt6yTIdbUGHh8j6hkz/kYvAr4pYWGUsJEzIURiDWW9hgwKaokfykmXzQZdFcyG2D7PJEnz+FMZJMdDTZuvwNcB/TttP8PnCvDHn3jQ3tEbTrEot/OhZ1uDrthro+ASW288tPWp7AQlwY71AOikArr+/0sSRtbUigLVpMOBUiMVeA+cjd8/2YZl15IRqkuprb9wkWgxvG8C3RcpRFqEzum8ev8VbmI43zoKxwzdqtZG0fgb4/kQ0G265tBPXNs1Mz7vC1uWF1UfTRXrn+z/MiTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by AM6PR0402MB3830.eurprd04.prod.outlook.com
 (2603:10a6:209:1d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 09:20:42 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5458.024; Mon, 25 Jul
 2022 09:20:42 +0000
Message-ID: <9138fc95-983c-1225-394a-dc6da9ddfb2c@suse.com>
Date:   Mon, 25 Jul 2022 11:20:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/7] USB: cdc-acm: use CDC serial-state defines
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220725075841.1187-1-johan@kernel.org>
 <20220725075841.1187-5-johan@kernel.org>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220725075841.1187-5-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd7ebe82-8a26-4d37-77b9-08da6e1ef239
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3830:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrkGvFihgMvjFMj/f5h00y+Z0PStKd4bkfLrz6BZ4nglV/cmwNk7t7zwa5UtIwL0tGxORkedjv66O3dxL1avDR4xvUzjKyiQ8jGD+Qq6RicAlnrU5dwtMIKn5BwO2y9nIVxEtl7/rSVLFfKso/1ccDUb+4dBWSk9M5UEcA1BIroiAl7kQ50T1f9pwpedk4JckTiuZLZizN5zeFzsR7WhgMxOjI96Lj903bkgQwvllNcLy/q4/cudx9ZQeyUD8h8wohEmDzPs1zwKeeEP1wH1R6qCw0fvJC5+WVWCmY9Pkg/W1lnM5PipKrtskTzgMp9UYX6QDSUijqTYQxgy+KD2kiLwsMVKgS0F0hyB/7fvdlH/uXBnRx0vjBG+0CkEFdkXzaDqRuKR2Zay+q4hbSODFCZ1k0wxFd3EtIEB6/MgaYc1a6wlbJdtKjc9VXcwf3keVUlCf+uz/iEZKVY3KvoVzlpPWrrvZbo+AxzZirXft+bL5nBmThrz9wjmr29WMhN5AgicrW+eqcK10qmP3ZtgtaMnGzHrpCJsJ9U3tVE8luGxBY8M1BJ13cnEiYMcd/xXsXWwfiqDwnaKJ/UIdTQcginlJrGuoSl98UB6nQ3SYe7dAgB8wF0Z/mgsLSNBHEUOt7b7N0sa873pkYyIrtDhHiHiI+eAYfAwQlzlImNhn0+Njjmw6tpOrG3xq9G3OmNh8AvX2oPQFriB1vCU3LLbFW6Dz9CR/6Yc6azAzZCjIzGnTGNWGiSOvGlV8RODsC9NqJ9LZLwzHQNGtDueYlkMOLXGwodZoY983OB0WQOy4p00e+/estq6PfeuF4jAb6E1k13z05uF3Zn4Dgc6GR80dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(346002)(39860400002)(136003)(186003)(6506007)(38100700002)(41300700001)(6512007)(8676002)(31696002)(2616005)(2906002)(316002)(53546011)(66946007)(8936002)(558084003)(86362001)(5660300002)(6666004)(110136005)(6486002)(31686004)(66476007)(66556008)(478600001)(36756003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnJQV3JLZzFVN1hGMXdyem5rMm9nbkxBYk5Yb3F1TXdJU0FGWHh3aUhIaXpi?=
 =?utf-8?B?NVpsRXNXZWxZbkpXdEpOeG9DckI3RmdaeCs5QUVmTlpLNlZramJxNXRXK3R0?=
 =?utf-8?B?YkZ1ZDRHdDM3OHhhalZQYjI3WnNoVDdDM0txWnB3OUNGeWFnOFVyYWNkTGo3?=
 =?utf-8?B?ZHlUTlFDcEEyNmRLSzh2aHhXUVFMa1FSTlMrVFhzNXJaanR0b1NGTmxjL2dY?=
 =?utf-8?B?amJqTjAzMExRQjYzdmlhRjNadHNHWklPT1JITU00Zy9aV1AxR3hHdkhxd3Nw?=
 =?utf-8?B?RWdORVY2OEpEK3VoS0dGWDMzczZ1TUExd0duM09sQkh0OHRjN0t3bFh3ZXc3?=
 =?utf-8?B?b084NjNJbndPUUwyNWZRTXpLamR6bW1hc3RESjZJcXdBYy96UE5QVXJYSW9P?=
 =?utf-8?B?azVEU1RWZU9tUmVrVWdaREVvdVNLNDF3MTllZlNucTlRRUs3aXlnMXZZQmRZ?=
 =?utf-8?B?RG0yd09sUE9lQzZ2UHJCY0lBeEl6cDRQczIyWE5QMXV4OEtDZTN2OTZlRFho?=
 =?utf-8?B?aTkzZDJuOW1QNzFrR2lDSndzY2MrOUpxM296a0Q3eEY3czVxdjdCSkQwYnRX?=
 =?utf-8?B?NFFpY3V5THlBMnlUeE1veXJmNENZV2N1czN0enZtVkhkeFNKcUtWYkpvVkZR?=
 =?utf-8?B?YWhuNVE4VE5BSzZ4WittT2xnVEFRMlZyRG5Da0ttMndSWG5TNzl5UEZEUVM3?=
 =?utf-8?B?bG5BdGhMbTg1VnNtWDMzK0ZIbUVYUDYrN0QwTE9oSk9rQWUzQ2ROYTc0ak5N?=
 =?utf-8?B?c0YrY3NoL0tQV3Vuc0VXVmJXNjhwLzNSSkFCTXZFS3ZteUdJTDl1R2lhY2Nq?=
 =?utf-8?B?cHRHQ3d5L1oxQ0JkMHZjYkwrbENlTndvNUd6cFd1K0JhbzdEUTNNbnNOaEZP?=
 =?utf-8?B?MkZneXlpekcvNERDUDliZXhxK3JGa25rbUk5WmRNTVNaUVdUVXpCZjY1ZmlE?=
 =?utf-8?B?ZEl0NDVZQzBLQUN5M05HMTV1aGwybGtnUEZKRjhtaEdqdVpoNGlpYlpocHp3?=
 =?utf-8?B?eXVmeE1nbDJOdVE1aDhvSzQ0V3JmeFpscitLV0lEMkNjcmlJR1hSWklYc1ly?=
 =?utf-8?B?T2Z1aElTMWdFa0V0d2FxNmd4UTVHYTlsd1JCWnpVMjVUcmY5bit4dWxxeVcy?=
 =?utf-8?B?dlJIN2dLdzdnRHlpWDc4cFVLZHJobWxxU1VwZjVOM0RpTWJ0MG5ZbTBtTXlI?=
 =?utf-8?B?WDdIZncrZ2lkUHpzWDJrRGNVQ2FFR2FjZ0FpeC9GQjRBYWpwMitRU2w3OFFp?=
 =?utf-8?B?QUhsZUxWWEpNWGpsREJVVldLTzYxUjIwYXEyeU9hQlBVWWQvNjA3MUFvWHAv?=
 =?utf-8?B?VktiMGtESHg4UzZ0ejNXczVRSnVHTWhtRzd2dGlaRDBHUXhucEVKWXcyT3BT?=
 =?utf-8?B?M0hmUUwzaTVXSUdWMTJuemRjdEVvb0FSOHU0aVFRdHpIL2tGd1o0Y25VTkVr?=
 =?utf-8?B?NXg4T1ZVWkxTYnYxTUNDWFBZNVZZNmtSQVM1cjA0aURLYUxFWG9pRkZUdlFN?=
 =?utf-8?B?Z3plVVhPVGlGMUEwQk5pNEpJWklEZGJOYUNOREUxbkdJTy9FelppY2liZFBk?=
 =?utf-8?B?bXJUVWZBK2V6NnQzRWJQT2I0T1JLQnJFRTFLbUdwWHRsemRCaHJOTVFiY3RH?=
 =?utf-8?B?NzRSalVxV0c4ejl3USt6ZmcxeFhpYmIybVl0RGtTbjRoWHE2YWY3bFpJcDZv?=
 =?utf-8?B?aXdMTGtzaDVDNlkrN1NhdDVCbUZGd2xkdUE3VXJxWlBOMVVWemdNdzNyMlhx?=
 =?utf-8?B?cC9nNG81NlhJNVR2NUhZRjNHRGV6VkFkNTFxWXJNMThlWWdYTWlTMmk2bVpU?=
 =?utf-8?B?NW5iemZiL0xnbmZjNGNFRFhDem96bVdENzJnMVNBb3lUdEZkRDNMQjREZ3lq?=
 =?utf-8?B?YjJNSG9PcFhFaE03WkJsemRnWTQ3REtHS1ZSOHlKNDJHSUhpakVnY3dIV0c1?=
 =?utf-8?B?ZWxCYTZTUVpKeEE1RGZWVFphSGxVZU0xdWFTdko1WEVESFV4clBtaGFyTHcx?=
 =?utf-8?B?VC8zNklsbU9KVlQ4OHh5Sy9IMDNSVmx6L1JJS2paMSthcFp6ZmJFUVRNV3hY?=
 =?utf-8?B?TUtBNXIvK2M1Z0RZdGZKSWpGSGptV1lWWkxhaFJMd3ZpSjd2dEVJaU5DMWc1?=
 =?utf-8?B?SXVrZE14aUY2QTJtR1RDVXEzVnFmaW5VVUF2UUtPbVJVT1JQY0lQbEVpekZ3?=
 =?utf-8?Q?I4CloyF3q9VTz0ImnN8BNzEZVSHkv5FlU958YTmdJPHi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7ebe82-8a26-4d37-77b9-08da6e1ef239
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 09:20:42.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vk51tnOv/g6VXbcJ+FNF+Vls7uB+YR6ES8Q2DIUCgojeBDTVrRnhWsLHErmwus9M8IEP7fxmXUsxwtHuK855ug==
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
> Use the new CDC serial-state defines.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>
