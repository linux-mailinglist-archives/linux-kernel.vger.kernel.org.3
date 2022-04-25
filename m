Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4774D50EAA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245567AbiDYUiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiDYUiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:38:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2091.outbound.protection.outlook.com [40.107.22.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6748F644A;
        Mon, 25 Apr 2022 13:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnPHWoXqeplal1ex+y/ZR/xvR6THHSBL5HU+SY4uxja2td9DiFXXoPBayOL/QG9KZiMf5ISgNvO/HV6eJzIG/pbXQheg8xqXzE0DNhHB6nbo6av7zDb1wTDKrJP8yOOXWz402d+ySMn179QjJlunOcEjcgqjzP0mxXKL3liH5qlOSAnwFPr+SFBaq+G+SkdqY56jT8VSgS4yrZUPFGovJqXM75RtMRKgEO8a2YToVyHDX6nyRGvWqrdS7c/sY6jNgpo7psMSoPuoGA+HoU05i+nmW779mda8CwgkeUO9E1YpDoEbfQIgT2zwbSFpDylsrWb9BH89DfPNSD31LtC7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoT+f4ajiOaiGBUpWTKG13vWpeTq/9h/ezi3yqwv8tk=;
 b=fJzD7n7PQyXnFr43zJycXhS79jqEdMk3MT1bNcLW84rjpimMXvkkk1c+dolJm7Iv6tgMeXuvJPAyDnpH7+P1scWUvunD1fXD0vRysIdpFvRWKEYLXdBmKa9F/890m8xoVzTIFgyauhrI9Q+cZLSlv8Dk4ope9hKB74zp0hWQfV7BQN5c0Na3VcHG24dB9pyeNg1z94xEB45HT6Q83Qib6wUv4qPJCDpAmPYQnJ8QFbiA49kdKSKuk7t7QqYe2ViVfJeDMQNeMcWXRWWSVbx9TMQ5C8F3Rc6VeAHKMXVxbbl5FMnRcNZQEWWVAr60KgH11wiFN9+cznAH8kBlco0BAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoT+f4ajiOaiGBUpWTKG13vWpeTq/9h/ezi3yqwv8tk=;
 b=En+xn7cITV50C4Ivrwe1bUBe/cDQkbYFrs8ok038elofwtZVFpvkuywyGGofFkg/yp7T88RfgogLvXlxvbATQB4VuhoWhvQj/HWFl5nKP7elY1DzDALRzk98iMi7EsA/0URoD6WHEjWAqBcEzHcEyjXy3QIg7ieLegrsieuGBnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM9PR02MB6929.eurprd02.prod.outlook.com (2603:10a6:20b:263::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 20:35:12 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 20:35:12 +0000
Message-ID: <ea4cd16b-4a04-8857-d08a-53be58b00d28@axentia.se>
Date:   Mon, 25 Apr 2022 22:35:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 0/2] Add support for Atmel AT30TS74
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0048.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::36) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1377441f-9192-4643-4285-08da26fb1904
X-MS-TrafficTypeDiagnostic: AM9PR02MB6929:EE_
X-Microsoft-Antispam-PRVS: <AM9PR02MB6929E016D5470DA4243BBE7DBCF89@AM9PR02MB6929.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PNAJCcyJjFnXgTMlTq+vIeL/1eoloVB8G3YA1VhQi2ICitkLHSWmQhZTite//mX6QbbaaMP+5IkrRT4hkb0gfwyqubS8v+ryJnt2dnM+iCl2GZppucfojO8wUyCDAeh2O1uAn3LLcqjr3Xs/GXytdNifEyNorFWypMijwidZfjtYGbV5JAOsbsI2gQ3Esd9Ij9qGSuMpYrmDuS52bFZOv3+Nv7wx8EY5xhwY0FXWfl7RKLsiIOZbwiv+qaoE0/38Op0y8XQhOw6gBmBAk9tV+A3H7bGykkIKt7paKlz7vIjyc6MfQ7anyLOjnLQXOE0Smr0G46R1B8NmhUEl9vBdJnYmPw7C12Bt2TG1st3Ko9bIga1/Fyfb1pWUtQSKSDtwA/mTGf7/Xcd3BWiaDbF+lUlK+73x+WXAz0FwjUfT3KeyIi5Ci6V5AQRbI2umfO+fx7HbFJOiQRVmVunvAWFfWio33jZ0iVln13dsvHGaX9h1a1h+5vDjCDA1d4wIsUTWY2y4fA+gvPFMkjACMaJosu4JrynZBpEFgdB9NcMrAnCOAWNMy4Iy93WBiuKIqEBNs5z/vh9PSFzLRW3aQFdXt77anOD2AHwNHX5pFxnVQVGaGj8QiT9SCDZM2LDx0epJWFxUexcEAc5Ldzoal56+nXcDgoBHCwBspwQjYyiQ3+Cot5TcJq2/JfofNiK9jmQMRNearfHSxvqvGbPyybFkDp5z8zReuihmPKmoUd+I7ZANRl2FcVdsZCTAERxEq3V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(396003)(376002)(136003)(346002)(39840400004)(26005)(6512007)(6486002)(66556008)(508600001)(6506007)(2906002)(4744005)(5660300002)(36756003)(8936002)(31686004)(38100700002)(2616005)(8676002)(4326008)(66946007)(83380400001)(66476007)(186003)(54906003)(6916009)(86362001)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnNsLzJSVG1oVTZTTWJoTmlFaHZPcmdrdnZNU0tMcDZKQ0tzVkhkSFR4WXd3?=
 =?utf-8?B?WHhIRkhSMEQ5bWtRMjhxR3hicnN0bzlwL0lXN2dsdWRWK2lPaTkveWZUbyta?=
 =?utf-8?B?cVF4aElQclJPZFNCZWFoRHB2NCtnWnNFTjR4bFh4TGwvNTRMME9ndkpSS05C?=
 =?utf-8?B?bzhKTHVmSGU1WGlQaTNpeWNJNWl2OHQwUTdWb1kyeVF5OWlJclZlTDh3Qm5u?=
 =?utf-8?B?V2xIVDVDL1hCQ2UvUmdrK2l5ekRsS2NaVTJYczZOUENnQkpqM2lHZ2J0ZUZa?=
 =?utf-8?B?UzdRZU5wVG5mQXBHY3ZxRlIvbk5KNDdjVmNDQkFRL2xxb1VpRUxwYjdIVUox?=
 =?utf-8?B?T25sWTkveUk2TjdTVy9JaFdIYXRYK3MwMUtnSHQzMDRxa242QThHV3cvU3Zy?=
 =?utf-8?B?bGV3Z3dUaTh4OGx5dW90TFlyNWlZZ2pubUpZU3picUJETy9Wb2NLNjU0eVBN?=
 =?utf-8?B?K1RJVnpIdUZWMkQ4cWJva2lmdk5MRGxVUEFNZytHeisydlAwUTV1bzE0Nkw2?=
 =?utf-8?B?Skp5ZjEyc2tvVUdQV2E0NVpvU0tTMTVwTllBT3NTSHJvdnFZcXRxZDN4bEJZ?=
 =?utf-8?B?WjVVUmxxcVFJUi82YW1FS1V2Qmk3VEk2R1VJRVBZQ2ExdFAwYk5ORXRsWW01?=
 =?utf-8?B?ZmRycTZkQmlxM2c2SHdiOTlLa3FlWXlZOHZNakwrRmp2dktTQmdTc0xDUGdO?=
 =?utf-8?B?dWpKbnZYblRUNHFQUGRZbDI1c3R6V3oxLzdkblR1dndwbTAvN0hIcVMvTnpJ?=
 =?utf-8?B?WVlGWkVVRWR6YnlOc3p2Qlc4RVpLemtCVy9GbHNBWkFFbkp4WW9TUjJpSU9u?=
 =?utf-8?B?WXk4QkVya2JzNHRoQ0N3RW9hT0s2S0ZsMVZXOVJZODgyS3J6OWhMTEN4aVg2?=
 =?utf-8?B?UzR1THBjWWxsUy9lbkkzWG9UNzhrblJRTFJ0dXNXa3FGaUxRSDJRRzJ4YWx2?=
 =?utf-8?B?M3lnbXVMT01kbkkxMXdQdTZ5aXY3MmZaUG9QU0U5TGtIVGN5NVk4Vm9nWmNw?=
 =?utf-8?B?cHE5K1NLZHBLZkJmZVp1dXNHUFZnamhBbnpuL2ZPcjgyRXZzaWFXMUx5K29J?=
 =?utf-8?B?Nk9xSGNoUkdDZUdNeUxWM2hDbUxzcE9kMkQ0bHcwUXNJS1B4dVFaS0NNQm5V?=
 =?utf-8?B?U2VlWUF5SXR4SElVeHloUVBxd1J1bmVrdWV2UUFleXBIRVYwWVNPR1duTmdn?=
 =?utf-8?B?YTV1cG9OWWlXNFlnZGNYbXltaElHQ3BneTFlNVhBSzJqUkY1dWcwUmxRWEpX?=
 =?utf-8?B?MWdjTm9HdVB0QXhVSEVsWGNSdWwvMEo3a2plQVFMNHZjajhDd1IzVjhlV1Ur?=
 =?utf-8?B?ODNMSWkrVjcwcTI2R1hkWlRhOGZ1ODZTTm9DbEZQcnk2K2dQM3RZWWczRkxP?=
 =?utf-8?B?NjRjNkFpcVFGVUI2MWpYSDdrNjNOS253Y2Rwb2JVOHRpNnpIZGRYVWVMVXJi?=
 =?utf-8?B?K1RCTllTWXU0ZVdnNm5FcHZwdTRPQzlZeHZ4Z0I3RE50ZExiR25pdG55UGJK?=
 =?utf-8?B?blhMYmhSREpSMnhmb2VSTkVLM2MrcE1aOXFoQWQrUmY0V3N6Q2xoWnVDRUQ1?=
 =?utf-8?B?MUtrckhuRGJCWVVnRit5U2I4TmcrOWRITXNjeGo3SjdZMUFFRFBGMUQ0UXhk?=
 =?utf-8?B?QkpPVjJSckp1dEhpMHJXaGVtUG1uQmhCUTZ1THV2Z2hYRU80ODZHcnVBOGMw?=
 =?utf-8?B?TzMzTi9kTEYrQUdDMVJMSzlpUnJIajNaVlZkZDBkVWp4dzJWSEt6bnMwQlhL?=
 =?utf-8?B?TGtBL1haM0JrR2lSc1hvak54U292K2Z6cTZsS3RwUW1SaUE3NVdnRldvUUpV?=
 =?utf-8?B?bEF4b3JxWE1GbEowYkpuQUZ5bUxGOXBNV2FZRGl0YUFZSzIzeDVGVWhvaUhr?=
 =?utf-8?B?ckRxQXlneko5b2swTThVbm5hVUFRTVRmcDVrdXc1L21Ub1BxT2FwS3RDK2tB?=
 =?utf-8?B?VzBTM2hOVkxkZkR4eDdob2dkZEV2cWcyUGN1eGsvb3FYSkNvTGtoOEEwQmFu?=
 =?utf-8?B?bEZrWmFrTms2SGhIUXp1bU1EQ1dNelB1NmMzb0dhUXVITFR5bU91dFdPKyt0?=
 =?utf-8?B?Ui9NUlFyeXo1NklhZFJ0RzVmQW5ITlBRUGU0dWd3Qm51Y0tIVzczakhLckFp?=
 =?utf-8?B?bTV3eXpTUWhJYmh2ZE0zaDBMMVEvZi9MVWo5bkc5V1k5T0NtS2pkQmVSU1lh?=
 =?utf-8?B?dVYwWmh4ZXVkOVhLNGxodHhBQi8wWWhWOTJjRXZ6UUIrR1paTmh5UG4wWDdN?=
 =?utf-8?B?bGxZeXNpOGZBWDFDcUJ1cXBzdUk3SllmVHAwa0ovelVDUG4rdk02d29xYlNv?=
 =?utf-8?B?QWtsYlNYUHpLMVpRTU1Jdmt6MExDZmZGMDNveExCK29FQjd3dDN6UT09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 1377441f-9192-4643-4285-08da26fb1904
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 20:35:12.5796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOW0uzxamrVtvq6UO32Bf7FTfRnsZROXPf95bTZnMPBwHrGOh5Jld944rEWEk6EO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6929
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

Yet another LM75 temperature sensor. Add it to the list of
supported chips.

Changes since v1:
- disable "flowed" text messages in thunderbird, and hopefully get
  clean patches this time (first patches sent since I got a new
  computer)     sorry about that      *blush*
- add tag from Rob Herring

Cheers,
Peter

Peter Rosin (2):
  dt-bindings: hwmon: Add Atmel AT30TS74
  hwmon: (lm75) Add Atmel AT30TS74 support

 Documentation/devicetree/bindings/hwmon/lm75.yaml |  1 +
 drivers/hwmon/Kconfig                             |  1 +
 drivers/hwmon/lm75.c                              | 14 ++++++++++++++
 3 files changed, 16 insertions(+)

-- 
2.20.1

