Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA4B4873B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiAGHnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:43:49 -0500
Received: from mail-vi1eur05on2139.outbound.protection.outlook.com ([40.107.21.139]:26978
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232910AbiAGHns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:43:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlGEeSaoOMrWlP0wxRljpAHB5R+1RSsm7x0MSjaajKN1KEu4NzxtOz0EYPzJZe9fh3FyGDRaH9AQiEP+s7mPSmwkS05WG+qrPxuc08n6eTBa9h98nr93PR6hACqf25vc024bcjf1gEy5iHw43RDbyjalqjDBCcAWIcmatrNmyM4msgbK+KjaHNZCow6dAXTOBALsmBSvCpeqwfIJPdcWPzAdVNaQKVRWoeNNzDJFXBdOebvcaw0DD1FYcZNdNx9bBW5JU+q15GlKZPcDyftl0Z1+sLzi65J8+KVHoaZslWrO/wPLgGM7iIO4lEDnLq8rbEFxmxlSNPmqUl3mVtXSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJHQD18+1Ka3XfelLaxWAjgqpbtkRy1tfcoLFWn7CYU=;
 b=eTYTmUPfC1nGUC81JDBvhisGXS8e1EJkb/hW1ftqeXYyVsKvOa+DYFuDpLjSV8Vj7lFgAM/1aZndbJ+3/YUxLsxXybiEqCyRC4zn9rnwlPaygjyubF3UIYWdZQrcMsRyclb0KfHDwL9bwhsCx3tf9uyRBYdtqOZuK3HMVzF/bsmbvcRvJ6EM1SMTDSW2fWh95+qHubMxrxhy4YoAaAZmPFyUTcpS7jXOs1ZBETJUnwPE1bIY/aFI73ydkZwVXnbEGAW3JhFqt3qZhcj0alTVJvGNSf1ExUycdqy1BaHKq+wIbAVENJggqHjjGgwJ3OcvlWnBqcFp6vvr/IJeInX9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJHQD18+1Ka3XfelLaxWAjgqpbtkRy1tfcoLFWn7CYU=;
 b=l3I7qQKT+CvlCbkA9aoE2Am3t4OMhJMAFEvgSJGgm5Xplo+lo2ew+HpZL6Tp0gfCzeYwPBbjzD7ZdSJApcGV6dgppPD2epk5thOk8uAKXBPaD17g2aVm4hmkGpWQAuMywvrbuXrVImZHgkKjzZSX0GFtUF+hG86A8k1ltAPJX2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2792.eurprd02.prod.outlook.com (2603:10a6:4:b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 07:43:46 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 07:43:46 +0000
Message-ID: <bd26e410-b2c4-888c-9bef-efc26146e366@axentia.se>
Date:   Fri, 7 Jan 2022 08:43:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 0/4] mux-for-5.17-rc1
Organization: Axentia Technologies AB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0101CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::26) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 074507a0-efb1-4ef1-0510-08d9d1b16f77
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2792:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27928739162DDEEDD6A900C0BC4D9@DB6PR0202MB2792.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3U0Q9wwFdO2o9CmriU86oyA0K4UI1+LMLih03MQ2XsI491nbpg6Y+LmGeFPNxOvhmzui5BraUmvsYmTuX7WP8rDsiqYXxXoGrndk4BBRjxnJn+zqKXji4ExeZUUobRBITosmyHQeYwYlmLYQDIvBo7dUsfrI+nI8y+33ZDAbdlaoW7mkw6sogAFxJJ6maVdozAegJur6rXho0PNbpTnhEljxK9vmKGckWeMWIxQbNCUMBEe1PE75S9pXQ1KC8jDnoXc7NdiEMN7rkogV3G1LoK4d8AcXf6VrzwiJvAA8klgZ8QuEtplcAts5T+nyhtw0g+6eiu3Kl9moTJINjkp83mO0iFYlhwVW2ChE130l1ZyTPn6dK7U4BUJjev92UN62AP5ltiNgdSQXRxhCv6jmZSTg33woQZHaflLRO4H+T30SpqhiZacZtyPw8mFoKqh2hIVVyj8V/Mbvkf/qKuTs/geq7p3yTxU6GBPAwECtR6flQC/5BtFMqmzpd9l6l0B6etr4/sQHl9jomFNALJ5bSZRCZlWdGwohfFMX/e51fjhASWEo0AQb/SRCKymFxBRo/O6B7FQVs5HDXeBmjhLiV3l9Tc/n4PzNHK/AFGncdz07S93dWcqZQnNARGEgYcZvKZLw18RzuE69r1eMpU+/8sfQ27Ho5ZahayAx/QU1RqozPzivyLP/T12QrAIWQ5CsB6jFSjKu5StHmzzsT2pMaSIBn8QR34ssu0N085kbOEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(346002)(376002)(396003)(8676002)(8936002)(54906003)(6666004)(36756003)(31686004)(6486002)(86362001)(2906002)(5660300002)(83380400001)(6916009)(36916002)(38100700002)(186003)(31696002)(6506007)(4744005)(26005)(4326008)(6512007)(2616005)(508600001)(316002)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0xqenFPOFBuay8yNHlTUFZDN0NsZ1BhTDhMMFBRWkIwWXZsb2Y0UHFsQUJK?=
 =?utf-8?B?OWtuZ3oraXlaWldyVWlrbEF4NGZoVFprSnBxaklDbzdFeDZDVjk1cnhrNyt0?=
 =?utf-8?B?TzhqbEJuNUloSzNBNlhWMTl1SEhIelFUODBQeEUyZXR3Rm9Id1NjNnNHallF?=
 =?utf-8?B?UWZ5bytvNXNkcUZMLzEwU0ZPd3Y0QWtRK0h6dkVic1IvRWR2eTNZOHJOanZs?=
 =?utf-8?B?Qm92L2VCUy9nUkVXdHMrK1lrUlE2d0tuZ2liZ0FLbFRLNnd5a2JSWnR3ZWZ0?=
 =?utf-8?B?Z3BwZW1WdU1TRnBoek1FRWlsYXBxZG1yT202OHluVTdCU2tOZHFRMHZ5R3lN?=
 =?utf-8?B?VmloNFJIVnNVMlpXajVPT2UrYjZpZy9uSUNxeE1jNFpHb2N3enc4N3MzbThu?=
 =?utf-8?B?b2ZqSjBFTVZxY3k3K0hvMWFrTDk3MUdSdW1SdUxvNzk4NldwZHdIZ3E5eTlI?=
 =?utf-8?B?NXBNVHlrNndzZDlXTVVZRzl0blN3QmhYbFI2eGVuY21CQzc3QXpnZWsvOWNI?=
 =?utf-8?B?RjMwVTdjMXk3UXdLMW1ZaGtLMUtUYmtzT1hhTTJwV3BzZmpRN2YrQU5oN3JL?=
 =?utf-8?B?WkFpV2NabEZ5d3djNDlSRUoxNjJZZFNEc2NEVDNvWncrV2thRkhzWGJITG5P?=
 =?utf-8?B?M1FwTnRRTXJDZ0MrRzZDYlVaUTREY1pEMVpNeEludDZYNzErWGkvc0pvU3BW?=
 =?utf-8?B?dDJZd0J0djRsN3dxbE95alJCSWtwUU0xMENtVm5hMU1mTGtFenB4OGtBdlNi?=
 =?utf-8?B?UkpmZnNsdFpKd2tQbS9FVGMrK1lHb0NFQitJaUdhd25VS2x5MmNTcEE4MGl3?=
 =?utf-8?B?SEZJRG1aN2IvcVRrRlpqeCs3T2NLcVpZUFJGQzlPcm1UKzRiRTExR2RpRFVn?=
 =?utf-8?B?VTBiRHBjMlVFUFFuaHBmRFB1VVVwbnMxeWNOVmlZR3hzWTdDcUx5RVZ2WGJp?=
 =?utf-8?B?REhwYVlXZUFiYWtST3FrMDNPZHVsbDc3TUl1Vk5EN1hwMUh0dlFaRFV2TERZ?=
 =?utf-8?B?bVNVYkE3TFBTUHRwZ0k1b0VqNFpSSStGd1J6SHpCOVVNYlVuUytFZ0FxWm5i?=
 =?utf-8?B?dlgvblBqTVFtcG5qcWU5WkJQekRZYzJtek9RYUxZUFNvaWxJeHNQK1FUZ1Q4?=
 =?utf-8?B?RlR4T3NDaVVZYXNjcnZsYTR0TFdKYmxCQlNjcHVKYysxU2pYZ2VES09ZclV3?=
 =?utf-8?B?QjNDbWZKQ1FiM2phMi85dEZrdVpiclVrMy9nVUE1czNTcTNETWpzQzczcURy?=
 =?utf-8?B?dVRNcnNycG9DaXBYN0JFdDRoSmc3Wk1xT2IzeU1jd1dNQUY4d05LNVFPRFN6?=
 =?utf-8?B?b1hvdVVvb2ViWURKUWF6R3hSVUF4TEhQY2RrRERITnFLbVhtbWZBTHQrQVMx?=
 =?utf-8?B?dHVMQjJ1b0N6TTU4SkRRS2NqU0s2TDl3ZitvVlNBMFphRTBvbmcrb3ljcGxz?=
 =?utf-8?B?cUU5NmJLcGkrSGNmUHFadkxqcmljbXNScGQ4RllQZFU0MmorTHhERGVYL2hU?=
 =?utf-8?B?RVgzdFdtZzF5aWE0ZXV2d1V0c09GRjM5c3hTVUFBdmRIUEF6ekdDUnRXMHZ5?=
 =?utf-8?B?a3JZSytRS0phQTN4VlJlRy9pOEVrUFdHOW9jd1phL09CZkU5dGRiV0xsN0lx?=
 =?utf-8?B?STlmMVI4eUV2d3FuenFDaHdxT2N3OTROZkZyNWxlTGJaeHZnek9vNHJVYmFs?=
 =?utf-8?B?Vy92YzhRWFJQZkdXTGpZUSs0cFF2V2J3a1h1MzFIZVpEU0k2SVlLcS9ReEsw?=
 =?utf-8?B?WXdHb0w4UG0raWt4a1Q2RTVRZ3dDY2c3OUw3ditmeU5lZ1dvekNwL0cxT3Fi?=
 =?utf-8?B?WmdCTUNYZUxBWlFsd1I4MmVNZlNsaWpORGFPQTdRUUdiM1g1TTR2d0VELy82?=
 =?utf-8?B?eEp3cm15MXJLRFY0ckxJamR3TFpwU2lVVGZHRTBkV3o4Y25aMHJpd0k2SjU2?=
 =?utf-8?B?eEpCMDRUWGZza0lNV3MyRmRVUTB6ZDZSeFF2dGhhcTlNclhtR3lTa0pxcmZp?=
 =?utf-8?B?ZjFIKzVGT0VnSUNVakVqQVFYbE5XTHlvcVBkR3Q3SFJsZGcvWFllRlVpbU9X?=
 =?utf-8?B?SUxrYTZCRnU5M0YvMmlNc2FmK2dpazlMT0cwYUVFbVk5Mmt0emVLQkdiOWU5?=
 =?utf-8?Q?LRoo=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 074507a0-efb1-4ef1-0510-08d9d1b16f77
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 07:43:46.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KN4AmTNfP1xPyna+QKEsyqM2HDmvPsRYou4W5yY/bU/7nHOz8q43jJ5r8jlJ4Cjc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg!

Since last I improved a couple of commit messages. I.e. adding a body to
"mux: fix grammar, missing "is"."
and a Link tag to
"mux: Add support for reading mux state from consumer DT node"

Further, I removed the exports of the new functions mux_state_get()
and mux_state_put() as there are no users, not even in the wings as
is the case for devm_mux_state_get().

Cheers,
Peter

Aswath Govindraju (1):
  mux: Add support for reading mux state from consumer DT node

Peter Rosin (2):
  mux: add missing mux_state_get
  mux: fix grammar, missing "is".

Yang Li (1):
  mux: Fix struct mux_state kernel-doc comment

 .../driver-api/driver-model/devres.rst        |   1 +
 drivers/mux/core.c                            | 239 ++++++++++++++++--
 include/linux/mux/consumer.h                  |  18 ++
 3 files changed, 236 insertions(+), 22 deletions(-)

