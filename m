Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEC04873BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbiAGHoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:44:44 -0500
Received: from mail-vi1eur05on2126.outbound.protection.outlook.com ([40.107.21.126]:28640
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235891AbiAGHom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:44:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBWeKsOyZIDjphMA5t1i23bs3iCc6Wc9Asq6noa6yQrPeJ1kAqbMMtEAfA7gkaxeYx7JwPWUYleV89+t48wwlvhb/wUam+yKLZS1jEJHsqE/gL4u+5l1DGYsGmCecOTMMnpQ8Qzj7nRYW/XR1ZEIBhynEGrOW0Z6iIgVVAAtHyEUHyBmBo08Y+WdqUB2vAbhHLvReqe09tMIVn5CQokM8FezkgXZj89rbOprK6eskxs1V2xOKjTEh7GevXJSepVXhvijNRwCZ9uRvUP7DeUQo/VItsByqD9KC8nB5t9axROyAJU085p35i1Ood1f5AfDO64fxNCAC6fwg4pnZtUDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp0ue/Lyb5EMxnq6ks4kzQjhrgazWu7owBnheuOmJUk=;
 b=kigd4VCIducmn+Mjhwd5m9gSqa58GmXZCjEWy5GEzIHcCApIEimgtDvH9v7Vl296APkTuqraniqkC5x+0mpYeYVFk3xaGgpZrIeiSOzCB31iDy4yVDl2yw9zZYPxV271a7oPZl9m3EKQfadztGwEk7x+trclgd7YyTbuogl532rAb8g7jQBnP4JDLHzZDAgVAO7YeCrDfgVwVX8KNlLfKi8lAvYO0WBjzQbKIOFYECHGG0GLH3Sb8+KmojE97hN4wmuqwscK5pbnEMh3BBmopJmwF0X639jfJOyxVYrBo80NLTnaVDMoz7X9QR+oz/yybpm596FjjvVF07dAxptiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp0ue/Lyb5EMxnq6ks4kzQjhrgazWu7owBnheuOmJUk=;
 b=DuBuBRvvunUi79kzVayJUoudU/Uivd26MuRom6kAaJYKgjgqI3S8BqyIdgTQJiQV/X2ykWiABLK85gQzxF4bfSu3btdcYkREUUIT5IQ1IYC1cVH03U7oyqVJMnHLiv3VTwpNHhvlWr91ETu3PI9Gd4wgiQHK1kSX7m7p5fcHIF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2792.eurprd02.prod.outlook.com (2603:10a6:4:b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 07:44:41 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 07:44:41 +0000
Message-ID: <75067db8-0264-c49c-daa8-d7a877932711@axentia.se>
Date:   Fri, 7 Jan 2022 08:44:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 3/4] mux: fix grammar, missing "is".
Organization: Axentia Technologies AB
In-Reply-To: <bd26e410-b2c4-888c-9bef-efc26146e366@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0364.eurprd05.prod.outlook.com
 (2603:10a6:7:94::23) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d074492a-5221-4d3b-f4c8-08d9d1b19039
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2792:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB279290C5DB19A18178BC9073BC4D9@DB6PR0202MB2792.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fc7BRmjeYHD+Bz+e25xYiqqMSv0yf/YfnhnjbR5QaOOMGnvM+deOtb9ykD7ZwXf/xXCL5lPYFam962neCaNPkQy4Hqd7LYspk/n5jiVWniPB0vfeG/qDuu2zGQd34A0nEf7OXRqI/38dgdLUrbxSSOmYpaYvhR3zoUp7F8X5rnbe2FzSaf0a5/zv/WE5TUpl98qEf2lf2JPc3Ytw9J2uswFKK/3q2uJib2mWQCBJwGRESpVN12AJAZAZwJ/mUcnYuH3lHSvz3WOjyLPVZDPptKeH70kFb/7ix5dbwO4uT3i7VDrFCGJR6/MSDWrCye2XiUSi57IWiRAxOtKeiTl71jHdnqv9FjQ/AOnuR7EOWaCExenE8SkBPihesylKzrzRWRlLMcNE1ckckvPnTcE5zW3cA5pF5fZ9M5Y1QyjnLkPLrsWajtcwlG20V3nZAbQdR72U8JSxb6rkwa4MkIJisJz6LEaU+njULEy8Ik+3mQJ1tKrYYLjf9zFemq76teHe0swdmmSYQmDHjy7TZOX/RxtVFTjg5TBZjy3u15qEE9AkC+P1LVUAQ47KmKgUvWr3B60OjmOPTUgYTV4VBu7WiAoHZjFBkuwUWTHkrWsl0VgnfgDFsHrXi/NQ9IaDRsSvBBGgJYExkAwCb2WsLaHrm6OX+uAwUnbjR7SREIi3XHWhzEU5hbXK6hBwGEpxHYZOEhCFipMDgjX0reOr1aQ0WrDTuc9EwVVWvH4BV5DDeBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(346002)(376002)(396003)(8676002)(8936002)(54906003)(6666004)(36756003)(31686004)(6486002)(86362001)(2906002)(5660300002)(83380400001)(6916009)(36916002)(38100700002)(186003)(31696002)(6506007)(4744005)(26005)(4326008)(6512007)(2616005)(508600001)(316002)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFBUZDUvbHdKNCtMeHY1TGpSdmg2VzlUZjNkK204RFNmbEtMTW1iMjEyMzVD?=
 =?utf-8?B?NXlqMitHdUdaNFZqK0RMUFRGbTFUUFIxZFBob25PWTF0bWw3OThDK3Bvanlq?=
 =?utf-8?B?Wkg5elc2TVU0Z1Z0dHRLbCtiOHVsek5KVTRNdDl6eHZDRGs4Q2JzS3NIcW5a?=
 =?utf-8?B?NUxUNms2SE93UW5qOTZWck1GdjhKby9Yb1krcjUxcHpORVlta21wL0s2RWZR?=
 =?utf-8?B?M1pEMWc1dEVpZVYxMDFRWFE2aWYwVzRQaDJ1LzByblVxS29WOGRUSDJoYkJk?=
 =?utf-8?B?b0FMdzdpclFYcTJIQjErR3d1V1RyZndCelZHeVp4SUU3a0YrdTBZRmxaQnYy?=
 =?utf-8?B?Y2pmd0p2STc3WGMxY3NRdlkvYmpJTEhRRWpuMmRwd2JVWHdGMEJ0Y1RuQVZz?=
 =?utf-8?B?dVh1cnNPN2tWVHlPdUlCODlxU2wxaG9VMzZCSUt2eDUxNHZjZkxRUktpSVZn?=
 =?utf-8?B?ZUI2eWpqUVo3QVRsWDdscjNpQlpDcnoyUC82TXhIaTB0Z3J5K3NFZVNPN1JZ?=
 =?utf-8?B?Wk9WcTV4RGxybUJiekVjUXZ6RWdObFZvWEU4cGFVVWUyQVFCUXBnOC81eE5S?=
 =?utf-8?B?UEMrMkpRT0t5S0pEbVRKa2MvZGltcE8yZVlGSjZ5K21xVlJQTEN6dUt0eVhG?=
 =?utf-8?B?b21oTDYwUjE2UFVKNUVqcXdnVUdkNXFMU1lLaWNmMVRYd1plajJDa2FkeEZy?=
 =?utf-8?B?a1NESENVd2U0eVErQzNnc1g3S1EyT3BIYWxVVDMyd3gzY1VIMndva1I2Z1hE?=
 =?utf-8?B?S1RJV0lPREkwL3BEbGVuMzBGTWxIVTZDbXk4clNNcHRCT215dSsrYXNLdHZ2?=
 =?utf-8?B?N0piLzJEYUdPdy9sY3dTd29GOHNsam5tSWozZVI4WGlzZVIraTVJK3hvem51?=
 =?utf-8?B?b20wRFQ0QkZVQWs3eGhLZkhUWHRHV0Y4Wk1uNng5OE81NGt1a0xNN0dGck11?=
 =?utf-8?B?ZXIzTTZnQXRmV3Rvc0JVUU5EbnJLeEQyOXp4VTgza1FNYUk0YlRMK2dYbytj?=
 =?utf-8?B?OFVjcXhSSytMbkFXc09xdmZOcGN5RHlnc0xtUXFpZkRDN2pCVWFKMEV6SFJD?=
 =?utf-8?B?VFJsZXlPZENSSlRZY0NrbzJZbUhYMkU0YnRDUjNTTFQyUjFFY0tqdGk0SzlC?=
 =?utf-8?B?M2Q5L2FDSDgzUVBMWGt4eFNqdU9LUDlKcTdGZDB0QlZ2akVkWFNzTEpEVFMy?=
 =?utf-8?B?RmJ3VFo2djYrVVRRb0JXVnQ5b1hlUTVCc3VIUTgzeGppSHNyTEttRzlETjN5?=
 =?utf-8?B?UVNXc3Byc2k1TThkTTlxT1V2a0lGdVVzL0hBNVVwM2VKd050TWxIZTNWUFV6?=
 =?utf-8?B?UUFHc0R0Wm5QcGtZdmZ6NENEWUZLMVpBblJzUXJNZDFBN3ZMdUtwQUltK21K?=
 =?utf-8?B?QUs5UkpkSjFuaWJkRWNGUURkdEo0dGFLYWNDanpOOS95cGlyaEQ2VjluUVJF?=
 =?utf-8?B?TTBLLzhuQ0tXR2prK2YxZmxqRmF0V0VOQlkzWmhVbU5sZHlUbXRhbFZsWUpR?=
 =?utf-8?B?b2MvK2ZsN0d5Z2NnYTVuU05YV28vZHd3VEZSMmVrVVUxVTJxYzh5a3J6QXFH?=
 =?utf-8?B?bHR2ZnJXdVo0eXF1YXVNeGtzQWhHd2M5OExQd21meU5YVURmWWQ4WGhDZkR4?=
 =?utf-8?B?Y0M5T1FYY0JTN1VZQnhHeStpYzhvWUNKaHduVUNrU0RDZ1pKRUtlMHNqZ3Z5?=
 =?utf-8?B?Q3o4L0V0dmtSb3lyK2FMNzR5Mkh2LzVCRHlmNExTZmZJTHg0eXJXM3EydGVr?=
 =?utf-8?B?cG1WbzNheVBqS0VsK3plSHZ3UXhpdXlKTVk4RElsSHlKSnZFazJoQXp2bjVC?=
 =?utf-8?B?K0dkdTl5ckhUZ05GVHlmd1hMNnl1MjRUZUY1N1BuVGhUUXU2WTFjMGsxRmxJ?=
 =?utf-8?B?VXJZR2lhT0p6TlU0MGZzUnVkUHZHNEpMVHptNGdQQ2dEMzhadXdWTXZEai9i?=
 =?utf-8?B?RWI5MWhmR0cwNjAzZEt2c0JRQlVJaCs4djR4U0VNUVZTUSs3MDlDeXR4bUdk?=
 =?utf-8?B?ZXlPZmhkRWxPL3MzUzhQSTlQM2FMSFQ4NXk2aldHSmlkeFcvdkJENGVWOUNU?=
 =?utf-8?B?RlJXMnQ4ZDFQU044elhvRTJjbDVqc3dWU3UwR1pVQ3QvTE1mTnhHZ0NlYW56?=
 =?utf-8?Q?l0CQ=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d074492a-5221-4d3b-f4c8-08d9d1b19039
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 07:44:41.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2h/BPtt8dtxFomaBKSm2WEEMUFWOIdx8zHceql2sFzi6xfIjsAKiBCcZQcEEugAu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it easier to parse.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 5cf2124fa55b..1a76a536d4b1 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -416,7 +416,7 @@ EXPORT_SYMBOL_GPL(mux_state_select_delay);
  * @delay_us: The time to delay (in microseconds) if the mux state is changed.
  *
  * On successfully selecting the mux-control state, it will be locked until
- * mux_control_deselect() called.
+ * mux_control_deselect() is called.
  *
  * Therefore, make sure to call mux_control_deselect() when the operation is
  * complete and the mux-control is free for others to use, but do not call
-- 
2.20.1


