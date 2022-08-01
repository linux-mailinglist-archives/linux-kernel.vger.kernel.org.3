Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F450586861
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiHALo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiHALoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:44:24 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2101.outbound.protection.outlook.com [40.92.47.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD14033A1F;
        Mon,  1 Aug 2022 04:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfXuw7EWQuTzulzEIkf20enL0bshPyVdGL49wctVpOvMtg+qWsCfU5YlBP5b1jvQicGR8DpirLXc4sGdiTNdd5W9iZvj2i9oc3+oogu1qvQduvvGXyPVT+T8TCsrGYaHFAuxhl7yJsmqjhLmOXZQKoY6WomwZCcFWQbbfsV5pFR/iAP0H2cnld5rrpLudBAa3hxJ9NVwUe3HwYOzB1MrZkPoe5D1NK5Z/0cpVzViIt0ogEzfQsYivOUSV82WZclZ9wp45wBNzAYvL7/XD1L5241k9lIFSKglUBGxtJKNHModQECf1QNZ0zYeuCtrAQbQ27OSpZWnK3dRCRR6Yc/PHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEZEkloZ5V6gZ0doVqfKr24MSd3LUqFJS/g44jt+g/I=;
 b=FAsJlulIGjuVNHBV140kIXDOmEM6iRUTwmWBuXdmjGBoDIS+VfygYHr/rsKh+fIFqyL3ZWTLd4ywj28GCKYrUyWiYvFSRIgM9cAjvsNGKJCvI3+QmNyM1h4GLG8/W17+FzQMEBhI2oVBz26245mhtl9Gk7B5QDII56qHRAjU8oWmZQ+n2xS9KkMrs6QfW5uGOPRNd6l95upY0icLiSa1YThE1sAGTWItG7S4ekEABGW+H6ZOPkpZ45xHZWxlj3oVKlyvqK4xiKzPn2nQjjX/5OWdivzE8xubkHwYICW16ssNUMY0RyKoPhd7P/552k1mbsVAclcp1XsHo3wOGVYLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEZEkloZ5V6gZ0doVqfKr24MSd3LUqFJS/g44jt+g/I=;
 b=n9/2BJCpwDpqpzvmNXPLKORv7s+aS45TquDK6hR2PjP9obGaw5c3hdZhcBcd3OUvpjnaNfEopu+vGn8d69HLrstH7XQAaFpTLuAD6UXnvuuPa5C8xy5Pg7yTfYaYsz4yW63xNuXlBoHFTwy2wZCEIAUw8s6Qa7ulY6yyWRPg2/gJS5qdtpvrPaIB0mq5EoDSZJmI7NoijBbMC87Dq0gy3vgwT9yct13WnDHjSQgQnTg2pqMikV7GOMcX/aNRLLoPNPoJW/LnD2axnjZEtqfK2jiPuiXXdhm+6lVSRZAZJxV6zEfk/qbLN827V+s1hDCBQ6p4DsfaMecm7z4osCtQ6A==
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by CO6PR02MB7780.namprd02.prod.outlook.com (2603:10b6:303:ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 11:44:21 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%8]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 11:44:21 +0000
Message-ID: <BY5PR02MB700972E09CC9D8ED6EFBA59AEA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
Date:   Mon, 1 Aug 2022 17:13:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v2 0/3] Add support for Xiaomi Poco F1 EBBG variant
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <BY5PR02MB70099020AC1D181D15909F64EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Joel Selvaraj <joel.selvaraj@outlook.com>
In-Reply-To: <BY5PR02MB70099020AC1D181D15909F64EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [v+YWVYWr3hGM4zGoFirkwgZnAFVSd036m4ceqsB3hGzw0ZLjBvMWpn/cn2gtkWkE]
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <24e5226b-6838-2a07-0e11-595ecda2f984@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86c31e24-5789-49ec-f1a1-08da73b32c50
X-MS-TrafficTypeDiagnostic: CO6PR02MB7780:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+m6QNyaHzKiQFhWBXQ4FH4DzJNduCUBZuSEP1DsiKJ63iRsNNhUIIp0o7capg3xWLv4rWNNi+TJeyBkGNmGrhkdNSkPVYjO15CbenI87mr+iZGo0Ie27K5VhVpPubbe8EJqY919m8gdv0G7x+pbk3TRjcabJ4rv7Y6hRuYrrIV9TnHTq0wwrSUBEsoxcfDUow+AJYlrAzPtKTsTj0bd8Si4BFK74pZXB6pLSFlPl24mTNrFPgS4/FgNz7nV6ELOdR8P30H1yTIZCG96tYaC/7uUom61q1Qn5/jFrTLKCiyeiq/sWZj5iF7aE3mnLVqfd2n4bmyrn697yBF4f7MP0ob921SDQdf/pfJklW/EMkBv1Ny4KzjjLgI6NSyoSH+nHOjWYHwsUP9V+VQ37VUxm98RSbJVw5zdfvyFlRaYnyA+UFvT1FBHE1sSJY9XJAQqKkgaVQlDZAfHqjpAhkNc0yrLgW9ZiJBVNM6irtueNJokOJpSwksR4DZytuO7aefvDZRWJx+baXq4GlFA9PN30h7fbFRaXb00zTBpTwN95F0PaJrtmbbpMDzAxzzvZJwtOmqnpRVqbueIWd1hvGa8ZROkA1woo6QrG9uebB2ulzcPTdZCdKuc5C7DTsM4weNP7i976Gl9p7fsrTO7T+Mb5jR/C2snuD3EpiCpCZoLcFV5qEkG5bEf/vRzvbQGXKDb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNLMmNodFRSWm1lRG5BazJ6bHp4Q2RXVWx5YXNNVHNkZ3pXVm9YdkJNUVZk?=
 =?utf-8?B?SjB0OUxuUzZTNnBhRXJkSXUyeVdadTNQbWVKR2lsZ3ZaVjk3Y0NPY09VaUg0?=
 =?utf-8?B?cVdkMXpqWVl3WXYxVi9JbHM3aEZUdFdxNEVpMkxybDNZWjMzOU8yMmpaTWhn?=
 =?utf-8?B?NnJ3TnZPK1d5QTBSRUIyN2pGUi9MN3NabWpIemhBUTd5dGdCRE1XYkNOai9s?=
 =?utf-8?B?ajQxMzVHcXZwOVAyb0tkMVByMnREc0dFSDIwcHRvUDl2a2FIM3FwRFFBTDZ1?=
 =?utf-8?B?ak1SV2xBUlVybnEvQk12LzRNSzFRc09Bd0JMaCtNb1B0QVExeVVhM0xIUzFJ?=
 =?utf-8?B?c3BVaWFZcE1nbEVxcGhhTFBHTk9tTUQ1aHVoS2crUjY0Y0pudjB2WFpJdVI1?=
 =?utf-8?B?dmF6bFlOYlpOSWc4b0VOQlAwbDZndURrZkNJRjgrK01pdkdFa1lJK2hIdHNx?=
 =?utf-8?B?YVIvYSszeTQxczhPY0FDNm52cHJCYVVJRHJqMXQ0bGtGaHo4MHlkdEk2eGtG?=
 =?utf-8?B?Ky9ZLzVxT0RZbnNYU0d1MVVyck5NV201TnF0Y21KNEhVUGdwUU84aDlBQXhD?=
 =?utf-8?B?K1B3TzZwMHB0dTFhbDNsUlEvTlh0c2lrSnRwZGNpMlk5QnZrOVpOUXJPcmhn?=
 =?utf-8?B?ZFN6Qzg3R3NKVjBZM0Z6Tmtrc3RlbjZmMlQ0UGhPWXFmamQ4NXNNMmU0dm1L?=
 =?utf-8?B?RTcyRHhyakxTQTAwakgrOEQ3TDRMWms4Sm5JaXVleHg0aFN0ay9jYmdTcm5l?=
 =?utf-8?B?dm1Ia3pqZnFHQm9TaGp1YTl3NGt6eTBwVnBsSVZFZ09ROThMb2tyTkhJTVl4?=
 =?utf-8?B?d3NyaE80eWVkTllNdTJaWGFMNGtSRWFxK1IyN2xmM1FFOUJCN21tNGFQVWZi?=
 =?utf-8?B?bFErMnVDMWoxT1U0a3A0ZktlRW4vdUFOSm5taG9oR080T2FDY0F1Mjh1eWNs?=
 =?utf-8?B?a2RwU2pSZlNmZjBsZTEyZ2RCdEJ6MC9xSFBlekdrNVZxT2prNVNmRDAvK24w?=
 =?utf-8?B?Y0NsT25vZ2Y1WFNrVVZzek5FWjNHcDlwNWRKaERIbmd5L2w2QytlN1VaTG9h?=
 =?utf-8?B?bEhBSVRqYWJzVkNwdXYvZlczSnhpaGFRbXlEbGN6ZEU5SU5kTXpja00xdERZ?=
 =?utf-8?B?RzF5bTkzdDVtamtHMm5tTnNnb01rdHdQc2R5a2JqVE5ZWUdUMGw1YzkrSEtq?=
 =?utf-8?B?ZUlwM2kwTytmSHA4c1FkSlp6ZHU1OHhpWHVFMWtNNlZ5S05UWDdzUDlKVXJT?=
 =?utf-8?B?dXl3UU5VTGxRN0M5Tjl4QU13MCtvMEcvclhrS2Q2VWNNS1NlcW95cXp1bzJF?=
 =?utf-8?B?dlhUQW95ZHVIL1k5cTRsSjNOTlNZR295bFBBaXFYMjYxQzF3QVVjREtjSkdT?=
 =?utf-8?B?a2NCZkxpTFdaaGNmVHFPakg2K1JpT1BKemFiYWRrOFlwd2RpcXhZZHJnRVZK?=
 =?utf-8?B?R1JJTGgvMmNUeW1lUS9jcjJNa0hqd3R6MEpnbXNmYnVHTWh4dmE1QkFYMU8x?=
 =?utf-8?B?MlNnUHJ3a1ArKzZPczJ6NFJTQjNnWkZ4Y09yZldoZ0tPeDAySDVoNXFpTG9y?=
 =?utf-8?B?V2R2ZVFVeHJXNkttcDgwcmQzcTRYdVMxRVQzdm5NT3ExVlBtalJIc2dWb2Fm?=
 =?utf-8?B?QjMvVXVkNk1hcGVLMUgrTHE2WFZMaDk1cUpheXc2RUV6ZGZkMW1oWlpTVUQx?=
 =?utf-8?B?V3grNWtVTUYrTUErRnh4TUVaZy9RK3hlZFQ0NEJtdUJqd2Zaa1J4Wjc3MjRE?=
 =?utf-8?B?aWF0dWxaMTE1TkFaMUZWOTc0WDQ2Uk1KNkhYU3MzZ1E3djNBZWRXd3JMWkx6?=
 =?utf-8?B?ZVNRZDRiVnc5VmUvTjVqQT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c31e24-5789-49ec-f1a1-08da73b32c50
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 11:44:21.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7780
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be honest, I have no idea why my patch series doesn't get linked
properly. I think there is some issue in my OS. I use git format-patch
and git send-mail to send patches. It used to work fine. But it doesn't
want to work anymore :/ Is there a mailing list for sending test mails?
or how do I debug this? Kindly let me know if anyone has any
suggestions. Also, Do I need to resend this patch series?

Regards,
Joel Selvaraj
