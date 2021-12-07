Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C606D46B67A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhLGI7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:59:32 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:49320 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231313AbhLGI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1638867359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fO92v7cBCyjLvqoZNpoH5+Nejdj0CKRsH2hxUiiS27s=;
        b=DVTgBN1A1p9bB9hQrCxShZNuPDeUzMoYEFyl3LksuX3NfXlDcnDk5RjWZNVxzsiP2wpwcU
        7z0fHpZ6qbq5qHR1FH7flmSM03qe8iHDvLR21iPiXuw3bVb0ZPcuAnMZVfSToTgMrXPrdm
        NUCPV5X2Kv3pquz4z/GpbKvRHvp5RKU=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-sysg74_WMRqTufOE3z0y0g-1; Tue, 07 Dec 2021 09:55:58 +0100
X-MC-Unique: sysg74_WMRqTufOE3z0y0g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dil2mJdB2SJu2qTl/xAfJeBBBbexokk2rpgGOUghiA3tkXfhOM5G3guF8paCkdsOlOzrRFVuRllTKjXoRgysY3qylTCaC2ve2DBypnCPAlgP8/4v8lmM+nbHbC1Sj+ZAg3+j9762xCegSWcX+ELlOMyeoLZ5WOQonmI4z+5Tp1sGqm8VMDdH34u5TEAiA0B+a2XONW8R19WLncOBcXw7w6G945m5Nlv6ZVy6f2YnYDZyZkQJtRVZLt5aQQ+Q+NPHTi/4fam03sooF4BnycqOtc04Pzzbh2CNpncDiby5R7QRl8ND/DZTAFoOmE1yhZWrpWQLLjjCGlPet85eXunE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGCsfpShxi5iPA8mgokCiJpUmg1CXlDeLYwHfS0umtg=;
 b=egxyy13pc+gyWhhnrxxFJpcAc5a5DtWAzKx1O6sqX4x4pcCKJnUW5wMqY/HPf1RhTMFmET6KVA+UYr6I1Yh0oaQLcv9yxyFYsphdkyxfhRF0WY+Z6hm7h6sv5KLEuGT/fpZtH4yBNzCUUrW83MwXL/bxplgPVWmvHdgMYKIlOi0fwJvH6pDXVuY/BMulntyke7H3MWvJGBMtLVedB+9TnDErjhSc9EhFRANiBpxd/mIqhVFe5KtohxHz6lRYXuVTFkF2Zjm+HxT1zQZM1pLgo9yVfgSjPIorP8cwRDDImO4RKNCa0JFrb+r7H7dZYfB2KFOz3GRkzxMLunH1qLYzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB3PR0402MB3882.eurprd04.prod.outlook.com (2603:10a6:8:10::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Tue, 7 Dec
 2021 08:55:57 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1%7]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 08:55:57 +0000
Subject: Re: [PATCH v3 1/5] Docs: usb: update usb_bulk_msg receiving example
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
CC:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
References: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
 <3b794ef1936eb410b60cb536e47a0a00e36611d4.1638771720.git.philipp.g.hortmann@gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <ec1a30b7-941c-331a-fbc1-02b907cb5788@suse.com>
Date:   Tue, 7 Dec 2021 09:55:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <3b794ef1936eb410b60cb536e47a0a00e36611d4.1638771720.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0410.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::28) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
Received: from linux.fritz.box (2001:a61:3b82:1901:9d6b:5ffd:1b6b:2163) by AS9PR06CA0410.eurprd06.prod.outlook.com (2603:10a6:20b:461::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Tue, 7 Dec 2021 08:55:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14172f4d-1524-4d91-6df8-08d9b95f6219
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3882:EE_
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3882A1FB7A122CFE21475656C76E9@DB3PR0402MB3882.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5h5t9GC/yUCKrrU4Wt3/SOSvchmqWXJaoYbJ/kJ7E4m/j74wq5/ZoduXn2BwJ3kpwH4efdG1/CRbpypJZZWDWDWcfjQI+PkJA9lLbygc/FQ731rW+Moq7CWKahq3PfbQAaXLWeHRp93mI9Gvw1p6mpFbvOvrcGHXE7P4z6esY18BOG/HoIHB10yLjfTRQLQdyMJjpQ1T934d4UjS5xCqwe+9GB7U0v2Gb+XM1o6MkaqDnmDGRzRyK/yYVHF9jncxSMdu3Ei6UHs0D+3RKc8EkPEQVqOpRKb0G249HmdThD9VJSKDg5znZPFb7M8/fo30tlLrKSOktMSSbr5gCusCekWUFruwS7jGaZXSeWyrbMaTUWW0D2I3Jd2ll/D6/b7Iqo9l/N+IiFrdPjRB08sg4LWNpN+9JSGnAIek89mUG71Ukt1cOfDk8MnmTl2+cK2rI1jZ+noo5GtguupPWKfwBF8pT1g63i9V3if3unY0OwvO/uhreOHq4jsh5DJ8/EZd08u4ag5ZpaRkrSOBNgGQ9npTEZjcZ+mwcnsBiETbKloaCRKqEg/m592R58/u48g3daSTSYQc6ulMIF4y0N3dVRtYOthL/LJ3tfWUvLUlAF+vDVEfQQGk34HM2jnQH/UiTjEqG+0T7zV7KrJ4Kqh925n7VoRBx3txhphsTiyHXwDFkqCbkIwwb3RoQW7n/kpK8eFEDs/0AoKn2TpqK640YXUXh9bqvDJ/zpIbhRPTvUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(2616005)(86362001)(4326008)(66946007)(6486002)(6512007)(508600001)(6506007)(66476007)(36756003)(31686004)(5660300002)(38100700002)(316002)(8676002)(53546011)(66556008)(2906002)(8936002)(186003)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wg73pipS89jfgStU6YPAkbVvkSzVc12ey8ZnQD1wZug2KpdgRpAS6KYS/rmI?=
 =?us-ascii?Q?rdwZcyjbw3Y2d95F3JAk4RHocQq6IP8YdtX7WdhiInOZc5BqNnpWpv1kUm8W?=
 =?us-ascii?Q?eHNIo6W8Kh09KE/Sc2MX2jdmW9vkrwdX6c2mKIC1CJxDINJQdtFmeW1j8W5I?=
 =?us-ascii?Q?oFBW2CrtLdR7szeKuM21xv/cd9edjVn9n23BlDlYj+JAGBxf/Q0OY6vdYeDv?=
 =?us-ascii?Q?jQVfiUUFmaeSn78k/ZHV7nMEKXNAHcCDa5BBs2OqHw9dTfZFMXdAUGH1vc+n?=
 =?us-ascii?Q?9065p67WfYxnC1eH3g3a3p3E44++nyb0Prx2Qyx1EC+ZTWAMJE3AOA46WDYh?=
 =?us-ascii?Q?aT/r0HmNY6oOwbVgysWW6YPiVnuj6XZlXf11xLMqCCAGBLePmu2j0jDBYJIU?=
 =?us-ascii?Q?qw1AxgaNzVduLmyyHmxclGo/xWnGgtTg0DYvR8lpYf1yJkCDjHMohpnZbVsu?=
 =?us-ascii?Q?cJpGhaWWgIkyjMo0LmTDoYQdb7kWXABf5gigK15P8wpUsWut9Cfun224jaGB?=
 =?us-ascii?Q?2yOxJpfvgBzOoUzENFZpiUsNTbXEFsktAVhsUqcDBj2TfF5Z2y3Y1s4P1G+o?=
 =?us-ascii?Q?HiHFDx/ltM3HN7VdQPjP67RIZ80oVbiZciBtyPLeoOkGxHHSzOUP8D9aoLWZ?=
 =?us-ascii?Q?V8SPSBhD4oV318jrTIBP3t1zTBZToHVg039IsDnq8oSYkexd8YIg81v1nk9+?=
 =?us-ascii?Q?TaB+afoHzfxwDXcDucvUr73vcSLoRiUziqSSWfiy/R7FaD9i+uPG7rtxtodM?=
 =?us-ascii?Q?A7bvG0MjwUJ2YCfIR3MhMBaqOcZZIdgP6h6/LhQJxSIP+dGChNA6lAfmBiGm?=
 =?us-ascii?Q?v4Bjf95orBYiYpOo0Np77U40uIxSpPsbvscG9FtTvhRUxqkko+eEr36KP0tu?=
 =?us-ascii?Q?BZzuvoiaY9LPWpTG9iwMLm/cZhLqDzsMz4Bmvd6ZkNnmbb/GD+VNq+OH2Vqn?=
 =?us-ascii?Q?ocGZhiru1rf5KvA5wH+BG//6Z6eVXjhX7anRf2vtjTyuugrP546YCa4omNFk?=
 =?us-ascii?Q?7xT7g6w/mYncwx45y5bUh1Tv5kp7Y88+vtRNCww2mJaNDRs07kUzKkv2NJjd?=
 =?us-ascii?Q?tJSTwgFlbPFtg7FWaePSJ/FU4QkGVBtsdlmZ33JpGw4kFsVs6O7bb1y2CmY2?=
 =?us-ascii?Q?3Pfcd7Ul3ti49qPWzqAudHmUkxXw7TVVGx+M3ufqyOsl23PW0NwHGA+FWUTm?=
 =?us-ascii?Q?EM/byKT+hy6QIaz4+7033xcIToS06YTQxZM3BBhRTGbJwjptCEY5QBCmg7tW?=
 =?us-ascii?Q?Aljrrn+deAbjtY4Dqkpkg1WTQ1pbg0wlPW7h3Lwk3p70DOlCDeJnOp5DqAhX?=
 =?us-ascii?Q?HGaraublOaX9TcdaYG+jzHjznW2bPAfVkXMOX3j9/+VCxMBUXr/Wm0GV7tuy?=
 =?us-ascii?Q?D7B1FZKsR9C5xu1a/VnZ0DvTNN6YR+yWop18ZXXm572b/37yA/WI2Ya/5eww?=
 =?us-ascii?Q?9EitgJ4muQTSlaaXKqWxPtQLsJ2L72KDIdkOf/7CpqbSS9UtTakoRBajCYt5?=
 =?us-ascii?Q?KM+6ism9+iMKMlZbBpjxcBmLG5euJHF3/ivYpK6MZUUGo4gJGlL71IN2il2R?=
 =?us-ascii?Q?UPYbufecFEeWM3RYe5Q8JGriGnp876P0svCQHgVn/XDg9nx7JqrGg0qP977s?=
 =?us-ascii?Q?08tn2p1ry88YSg06Cp2rQZpJTFCe5GhmuWloTsXzii7zH69zqhAxvnIfVAGg?=
 =?us-ascii?Q?eunoUpKpchputQYwd1XgXJy8J+Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14172f4d-1524-4d91-6df8-08d9b95f6219
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 08:55:57.0040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1CACzwSkKfPKqei1X4gs9YbQmtH4KXOUvboCUtaNSnr821c/Jk800k6bC/GJpDngo0apF2SYDDKpfrdxrQ3RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3882
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.12.21 21:57, Philipp Hortmann wrote:
>  The :c:func:`usb_bulk_msg` function can be very useful for doing single =
reads
>  or writes to a device; however, if you need to read or write constantly =
to
>  a device, it is recommended to set up your own urbs and submit them to
> -the USB subsystem.
> +the USB subsystem. The template uses urbs for read and write.

Hi,

now that I read this, shouldn't we tell the reader why exactly the use
of URBs is a good idea at that place?

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

