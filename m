Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B74350EACF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245653AbiDYUtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbiDYUtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:49:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70113.outbound.protection.outlook.com [40.107.7.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D378432995;
        Mon, 25 Apr 2022 13:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b04ctutoYAnqkN8Z3DGGrIUGKvDRxQ4PZmyychM0GOor6Sz6MVhOh9SejYlk3nJhcfP8hImB/AmUpTV46FIxvNOOCeIpvvtfyjw0rctquPaC/5Ttm9Bi9InhYfqNLHVkaO2gTXR0E4C6J+UBqRAo2yhRvTB/Q4uiId2aVZIxJ4hScTYJIiwIo+H5gXdEwXLY8QyhgKqJUBmbeE/I6LTPi9Gtstj9erLzwzXdvom1GPgewM12n0eHRCFIqpAuYefo3tOOULkfvqkSmQNTmENGWZLHc4YKTHmTb6dPU2ukCD5SzMYO4sF+PeEvLhKLm98Jbqq2LVFmtnZIW3xl0dITNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LqRYTA+o7XYMUnZOXqcZPUQbGEKrKmLzNcO/2hv7do=;
 b=knZZX2CepjQGZZbv5M9Dxo/9AUJ4jhE6gNw2RVCovCAwWyv4s/bAJDLrJI7rS6ItyXyDI8eKGkdJ8KEseLiAcy5O5nrjcS0Va2gMQ9uJFpuYjed3SKW70U0DLglfirSFw0Kr4qVxBf5eYYs5hnEsrtT3Asiha80xYH6QY2WkmenvhAn0ziQytnOY8SK1Fa+pv+jRe1g4ZAIQ5EoSVxHngVtDqmiGeJTR17pR08amk77juOic/0ZjQBsi0gQRwBJi5P5MbpQLmLPKNFrTN54If176k+apJhNI/m/epqmvSv2O7U4PMiFU2v6RtukB4RCvNrqebcSzEilB0Kc1uDalUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LqRYTA+o7XYMUnZOXqcZPUQbGEKrKmLzNcO/2hv7do=;
 b=JjvHgxJL6tIimTk8GBIendN+OCHLX9dwC9n/PY2V2HTGmhpOe/+oitbnIoz26I21CwQdJRGqbcYiXQARnJly/+rNYGDzP9n7zMKCFE089pyAAUgTuMdMF+pQQlOfGrP3kDAzragsoHsv6CpXkchduQubm683pptUn9Uc3Trm+gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PR1PR02MB4937.eurprd02.prod.outlook.com (2603:10a6:102:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 20:46:31 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 20:46:31 +0000
Message-ID: <42db911c-5eba-0511-3e8c-8011a2a5b44a@axentia.se>
Date:   Mon, 25 Apr 2022 22:46:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: sv
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 0/2] Add support for texas dac121c081 to the dac5571 driver
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0084.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::17) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c944a0cc-fd25-42ca-c111-08da26fcade0
X-MS-TrafficTypeDiagnostic: PR1PR02MB4937:EE_
X-Microsoft-Antispam-PRVS: <PR1PR02MB4937E31852D1E439732332EBBCF89@PR1PR02MB4937.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnoJoRkVU0dym00GFxivFLscp/Vkd+6bho3AC5ck9Efo1zXt1NHAhmBRB2NO1QdawELFXu1QsIuszX1Xmu7rR2ggXEfZwDITC2ElzrlAEGC/PDoxzvEBdzPn75XG+g72eDtjYQUFDDy1TF+BdlW/GceDpaJ07Kqt0TiLyr+9hWRNM7VCJ7bUut0m8SGNlPAaTM9cQZVOkMfT4SxhLt/wTNVeu4aTWCo+QRDVu/++RPr7PC4hbC7mJ5Vx+RizOEiyGVNftF5Yuiw+i93GUOTkQFX+SzN6hE4w4wi54KN5A1DY/4n9OUtLJOufOzOarWsst8a28p9kYbDl4fIXAZNWYs1wNiAMdDUo7wC7sztomMyXSWocqL2r4uye9UXqA7/Zp/MDXrrO70pOlf8Y5Lgb/kQW9A2bKFQ1UCOvTl0r/1/T/eHHsWs67WPbzUb5Wgl6XpX2xjv5oaYiq2zzgwMbSgBSUdo91OkXjHD8s5ARPQRecfdhi0ZbB9FbwwBE1ZZOOvLXSuh8J6BtX+r1yeaCmqVJ1oBlOG1+zn8ZU8gQcy5mUucYbKBw7ng6lcq/G1wt/3PsLgzJYwTR8m6lrbRN71RYDA1ZIsm3WfmA+0H45F+vUZ+y+rvTBB4Jmm8Sc3Bkhhhh7aEIJGzg9/bIpFmIgB8F5RxCOspCZ0vempX1Q7Ci1QlQI9gsYTvvqj37+IKSfwIY+W/KEknGRubWy5XBPpiZnGnya2eaFMupLHqS4EV6GaM55/5VArZj64MA0iwS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(346002)(136003)(376002)(396003)(39840400004)(83380400001)(5660300002)(38100700002)(6512007)(6506007)(316002)(86362001)(26005)(54906003)(508600001)(6486002)(186003)(6916009)(2906002)(8936002)(4744005)(2616005)(31696002)(4326008)(8676002)(66946007)(66556008)(66476007)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWlhUFhaT0dyazJHOExEd3F5UHkrT0FQUS9XRGYwY2hMZjZGRkg4c3NpZ2VK?=
 =?utf-8?B?bGl2WThqV29nYkcvQmZEZnRpTlpGbmV1SUc0V0ZoMStBRE1HY2VWMlYzbHZ1?=
 =?utf-8?B?Rk4rNCtjR2Y0ZnFDZEo2T05qbG1NcnFOTy9ZbmVKL3VQNmJqMmltR293a0xK?=
 =?utf-8?B?SmlDYkhWejZndFozWnErV0RHazFvaWhUUDE4eGp1aElVRmMyVFhFMXU0d0tv?=
 =?utf-8?B?NmJCNE1YQjNJVGduK245M1ZCWEpZOEw3NnArZVBoOTFNSk9iK3hxVGp6dXRU?=
 =?utf-8?B?dXFITnFNK2lycXFtaUUySjJrOUNnMVRMaDdnNkorUlZmOVEyZlIwVll4bEph?=
 =?utf-8?B?LzNrRjlzUDlNUjBEaTg5M3hWYVludVhSb2lrZlZyUUQ1cTZXWWsyTWtxTFEr?=
 =?utf-8?B?aHAzOWo5bld0RXVuYkhyZkNqSXhEdXA1ZnBZdzFOazJwTTlLNzlIc3YrUHg3?=
 =?utf-8?B?S2lwQVJ0WVpxZFMxeW5oYXdYR01EZmc3a3Vvd1N1ZHBxREwzT0JUbE5INFpq?=
 =?utf-8?B?dU00Zzd5RXo2ejJjc1c2T2d5Y0xGckh2bmYrd3B4RFpnYzk5bFBNUWZ6YUpC?=
 =?utf-8?B?L2VYcWYrdmJVYXBYVWpncFhQTXlVWU1ybjhHRnlJc0hhWjdKYTRjVFNHQmFJ?=
 =?utf-8?B?bklaZ3dQTUpkV1c1WTc5MjVMZkFvVFRHUTJESnNtM2FBRXg2NlU2Wnh3QVZV?=
 =?utf-8?B?VHZBbDdKSW5nY09yWU45bkRmRXhBdkN4WFNKaFlpUUJ1M2locWFrVlZWOWdF?=
 =?utf-8?B?bEhmSHpBQlp4NExQYnNRR2FNWTZFUXNoY2ZlYXhVcWYxUGtNbjJjRnJZSC9r?=
 =?utf-8?B?dWJ5MDFwcXMyczFabzU2WGhvc2xkMDlQK2UyODNHVTFmTENKaEJON21FajJC?=
 =?utf-8?B?T1ltQ0J1Ym5xa1JaWS94YktuNW5KaTBWbGhySEIrUU9BeTdRMzl0ckxwSllJ?=
 =?utf-8?B?QWFUaHJpcmYrVlliVEp2TGY1cDhuRXdYb3BkcDhpNXhveWlnaHpDbEluaURD?=
 =?utf-8?B?NEI3TVlkWWhJZWllbXlZZGZkVmhpZWtyV1BPV1BWc0JGVDZTVU9WSnhCa2tY?=
 =?utf-8?B?L0JMd3VUazRGUHdZZ3R1TndvRDhKQUlWNk9reGkyeE1WenhzcjYrS0owd1ho?=
 =?utf-8?B?UTFFL0VaN29HR0dNRk85b1o1ZzNnLzc3SXBsa29OclhlanRyVlNZSWQ5M0Fp?=
 =?utf-8?B?ZDlaVEUxZXFZWmVzM3ZVRUgyYVBBNkFLdktTSGV0bzRqWk9GRjN2UmluT2pj?=
 =?utf-8?B?aitxQ2lwTG1ib2V3dFpGekF5d1VCS3lPRmpIMTlER2o5b0x6MDN1NmRWYkVt?=
 =?utf-8?B?Q2xHNEdmNnBGbHYraVJXNVcwbnp3V3JBaXJ4Z1JSbWxjU3MybVBvbnpaaEVz?=
 =?utf-8?B?aGJtYWpmSDd1cjJ5YU03K3BUWFdTZkxVdzcyOENvVEtRYUtqQ0Z6TkVkSVhk?=
 =?utf-8?B?cW1GQTRMOHZ1TmN2KzlndERGNmNha0lidVAyZ0h5eVUvWmpxbW55cmpGMXpI?=
 =?utf-8?B?MGFWaFFnUCs0K0F4dExmQ0xPS0xDb0tOaE85MnprVGVsRFR6dzhLbGdBcXc1?=
 =?utf-8?B?Wmc0L0c1ZWp5NlZLbU9JUFNCSjhRSFQ4ZTh3VDRvT1BxY0FuQXVrVytwYUQv?=
 =?utf-8?B?bTBSMGYyNHVuUHdCM1FpU0UzNnpIeDBjVzVFb1JNMVd6WHluQ0FvU1llVk9l?=
 =?utf-8?B?aGxoOHo4NFhFMG1BSjV1NXFVRWFabXM0Zy9BWFdoK1FOcHVPc0MyUk1WOHY3?=
 =?utf-8?B?M29NWFJrQ1FZVVVzQXJQUUh1dDdnZnRhcnAwYjRDQlBOL3BVSE5WSEszeFBO?=
 =?utf-8?B?Z3RUT0drZmFhbnJMVUxyTmx5SW5GdFM2Wm5OL3B0dlJPa09nMTlaY1VTQkhR?=
 =?utf-8?B?bnhTYkVEdm1vM2NSZllabkMrSEtaYW4vNkhSYzFhL25UdENHbS82N3Qvd3M1?=
 =?utf-8?B?T1NrNGpOVDQxbFVJZDFsUVljL2lneGpRcGtxbTFyT25RT21HUkhTVWhOelZO?=
 =?utf-8?B?UGFjUjkrOXlLU0F3RGN1SVhieFkxQWpMMG1NdGtqeXY4V3YyQnNYcWRZWlB1?=
 =?utf-8?B?Y0s4ZXpIa3Q3OFVtdUpyOUNjV2Vad1NvVWovMTlKL3NhZFJPRG43ZFJ5WnZN?=
 =?utf-8?B?V1NuRXVrcUYvd0I1RFRqYWkzRFg4Q0RlRTNWcy9Ed1dNSEl3RkdhcDRrRFRH?=
 =?utf-8?B?Mk5WallPc3hWekhwZUhKTjRObCt3Y0ZHMXd2OFBMSFNUYlZBQk15SlJhRWtP?=
 =?utf-8?B?VW0yVXV2aTVXSUxLT0tCemYzemI3TTBhdnhwNGs3UGswdUxNejBXaks0QzVQ?=
 =?utf-8?B?QkFWeTFDS1Y4emNveHBkNkFTSDR3U240QTlTSEh0QlZzeXFMNXMzdz09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c944a0cc-fd25-42ca-c111-08da26fcade0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 20:46:31.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgMQkRsJgiXgfJEXEPW1DcS18yYZPiwO9Ssx3kEeDOUE5JNEQhcF1AigjLMLbdot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR02MB4937
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The new chip works much like the other chips supported by the driver, so
this is just adding another compatible to the list.

Chenages since v1:
- Guenter Roeck noticed elsewhere that my mail setup was botched and
  that my patches were clobbered. Hopefully fixed. *blush*
- added tags from Sean Nyekjaer and Rob Herring

Cheers,
Peter

Peter Rosin (2):
  dt-bindings: iio: ti-dac5571: Add ti,dac121c081
  iio: dac: ti-dac5571: add support for ti,dac121c081

 Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
 drivers/iio/dac/Kconfig                                   | 2 +-
 drivers/iio/dac/ti-dac5571.c                              | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.20.1

