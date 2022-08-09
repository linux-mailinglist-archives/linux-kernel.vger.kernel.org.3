Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AE558D96B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbiHINeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243625AbiHINdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:33:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2105.outbound.protection.outlook.com [40.107.21.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B5F1900D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrvHQPlPQTc4K/l/9CLI1q2q2os+COrpovVfOizGpRZo4oOflohuGK5ddMRVUQjH9/E2NcwQoFJ58xJqAQ8wp/DE/86iBVymWK3HyEDXqIGVR/7tv70/heZakP16h7CE3idOXBDzrzKIb3upZgCwLp6w1olYE15x5pUOKbJrlOA7gIaJnY+gdqa5fyKVVxSilK7cQbCHZ57mAJ6qe8CGxNC6DzSp+xQ4mzuYEpcJgz36jz1Twb5U7GELYpddkiwIi9cMC5jmh5cCojSs91TGMWhx6Ct9D4GE2mjz8iZ7oqg1JFQGpJMlGSrvHQJOl5M0KmUA2ROstbaAJpz16WuU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g488I6/5WeSVlXEW1o6a6Qn42LsMrO93T/uq8U4NIlQ=;
 b=n852Y+4l9bUqoDImuqvQl6YkOblnviKWyUmCgjiib2+8DxGUUkyBSs2q3MIgkrifuQcB++u8pIryUrQk0KIEkoJxNDAQHKvvS7AiF8hdd0gJj4Wv4EWeHmD03hMk02UdFg/4J0sSlvBvLkMRKheT0IyrYIqX+/+VxrSs3tuPFwT1rhBBqigS49OkMGLdo9FZz2KWNv8B6XysOO4438eVlyZWtvDBaTOQBl1Ec0bLAcGgVXiSWca/krcZHXpEWkAjYyr8Y/28HOCjim4pd4WT+KV0wB3xDVc/n7xnFmcuiZMqYUEIVIw4dJfrvHeT+Tr6CVke7CF7fupJf00N/cGoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g488I6/5WeSVlXEW1o6a6Qn42LsMrO93T/uq8U4NIlQ=;
 b=HBQkR94NP806oINF4RonQp4HeqPD43JErmfLkCvqZJTLTVRYDagAqXSGuNvy9zc6bouAtP8HShGiVgsvmLXPCga1RxV7PzjYqsJjyKGaOVMf94wvP2DmG2b7Rv36gg32wY6vctyss9SZ5EEdeN/yAXgZovOj9No+S0fQcSzj20shs9ERrw4cy8IuVaJLjzYPG9cjO+eqIueBa/cFKsrsYfFp+5PO5ncf3ROjYVg+5SNwfh6JBffSPJdDuQbvZ0E1x10emgXiThGz5d2QqZRHIDtizqtdeH2q0bS/BZO0K7i2vr528kPiInUhtmm3TBH1CrVil7ahCsb9UxGse6rQig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by PAXPR08MB6861.eurprd08.prod.outlook.com (2603:10a6:102:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:33:48 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:33:48 +0000
Message-ID: <20a3b1e1-32ab-58ba-489b-08a621060877@virtuozzo.com>
Date:   Tue, 9 Aug 2022 16:33:45 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.1
Subject: Re: [PATCH v4 1/1] Create debugfs file with virtio balloon usage
 information
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel@openvz.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
 <20220705045912-mutt-send-email-mst@kernel.org>
 <f6b46a29-0f65-9081-5228-a1028fea2bef@virtuozzo.com>
 <20220809063414-mutt-send-email-mst@kernel.org>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <20220809063414-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0401CA0003.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::13) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04bbcfd2-d48d-4744-a504-08da7a0bca10
X-MS-TrafficTypeDiagnostic: PAXPR08MB6861:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8yVzwWkB3Y3mP3NwdGvllWO/twuwB0SCPcDW/Uh0V4EYjmpgwgbZoii53OdfiyXYKlYn9Cea/uYoSRQiWeAUD2NSGibv+h9Kbcfd2Avs93paQJc9YgIobv5uwM0e/GNGoVye4j1U7swQ+YS/1Sm2U2SSx3cT8XTqqgYfUzf6qVIDrwGcP3zdPAEjLLpIfoQUuvbsOBpU2P2D2Zx//V/k0IpQBrqG4dumYnTPyd+cLcpdH3Y3Th6tD2Z618drdm0bf19wcSC5IUzuGcZtoaQJZQDocdDaj3ra+8dQ0U8/u8NosUUtARyK+VCp43V2fntJOgrcgrUilRm+azVLHLEDwoJNmMPo5aPGuCXIWrhauk5aFW8BhwMVl+qrOK9aR+P0xKNhqwoxtR2uPuxhcU8vDmSMueWqJ4FCxvvVzdnTXBoDJ2Ix0NMAg7F4p2UYPXKO2TzkuL2DvIdQ35yz9T/r0nL4odANh2cuQ8yhRsPiR2J72ZoL65pdAutz4n+v1STmzU9JzWlsnk7FdSDpi58g7+6iVHfRH7JJrHpiGTrhSqb1rJG0FMuaBfHJmVDjkIqxZHdTJI2dyPy9b8XdrPV3b0waFOiYlWU7ZIgpfR+EShpB+w2yR6rQPlQvevCQvbZz8ViaFnQlqDeZ50MFpb7U9LyLiehL5We16W8BJPZapmvSHCVNgp5Afdw84BGqV2mSLMva0ScnlWuK7eyxv2mCS1a9BI4PT1WF7kcE6yhqWrS5bMnJKLA35i2ij38NepBiLTv/8iAoco5hhNs+jMlH1kv23AnC+g4ZvTINKsIDhOtEHwVUoh28cfjCWcCp0JBS+Qu3KDrHSTc9RsWmCbltzLhw+FwAOC4h74sEDbd8m4W8XvBDeyKPq8+A4cAlZdJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39850400004)(136003)(376002)(396003)(8676002)(66476007)(66556008)(4326008)(8936002)(36756003)(186003)(478600001)(966005)(66946007)(54906003)(316002)(5660300002)(31696002)(6486002)(86362001)(6916009)(31686004)(4744005)(52116002)(26005)(53546011)(6512007)(6506007)(44832011)(6666004)(2906002)(41300700001)(2616005)(38100700002)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVpBSTd6SWZLOXZHYUo4QnE3Ulh0bGVDeWFaWGFNUUJ5S04vYWxzOTRsUjFC?=
 =?utf-8?B?TXAzc3B5czhrZm1GZnE1dWNoUmZjMm11V2E2SldRcU5tNGpHNmJFSWwzdUw1?=
 =?utf-8?B?UnF5OWZYVnQ4MWxuaGZUcEVkbm84UGJuN1dNVUZwaVZZYVJld3VpZ2tXYTVq?=
 =?utf-8?B?Y281ZUxyQWMvNVlnM2M4VzFadVlGbU1CODlYWFBYdkdYZkh6OFhwVGFBUTdQ?=
 =?utf-8?B?WklvZWxzaE12a3lqV1JXQjd6YXJPK1dZM1d5U0pYemMwZjgrR0VpL2dObWNq?=
 =?utf-8?B?c3pKb2cxKytua0hocFY2UjF6QU5oa1VJRkw5eTJyM3hjSUlLaUlHN0ZoTXJh?=
 =?utf-8?B?ZGNIdUhRbHQzaWN0cERFQmkzTFBmdlI5eDBLdkcva0Q3UGcreWUwWkxmVER2?=
 =?utf-8?B?L3p4MFNFclBkWkpHSTZSZUYxbzF3VXM0ZytydG5DTFNndldJVTJTbDZSally?=
 =?utf-8?B?T2RJYnRwQlp6WWNPZ0dLUmZ2ekc5WEF1VVpZcUJQSW9RenNaUU9ZWXBwTlpR?=
 =?utf-8?B?NWFZbWI1TmNWY0JKVGRRNThiTXZlRTNIamxMczFwUHo0L1NFU3huYjVwTk9M?=
 =?utf-8?B?T0Q1ODBLUStSbXUyZlhieHF3eUJxS2ROaGp3QlZrclFzSkRzSEJCcXZsUndx?=
 =?utf-8?B?V3JMV2tkS0dvMy90QW1QSVI4WU11ZTJtVm1HWmhicjRpTHVMZXBBK2RtWGNP?=
 =?utf-8?B?REJ6Sk9pbmVnKysxczNVQWl6bFJiRGtXanNZcjA4eUdzd3JDTTZUZ29iNEp4?=
 =?utf-8?B?anZrajlSaHZIcjZ1OXQ0UmhhRGxWMzFiblZJRWUyRXV0Mk4yYmZQS0lxQzhT?=
 =?utf-8?B?c0dTQjVkTWhKWVhxbkdsUjd1K3k0ZmVnVHl3K1ExSGFtUzZMNUgyWWZoYzh0?=
 =?utf-8?B?RHFIYUlSbUtEUUgzMUxjTzhBUU0zWjVBdFVOaExQYldmbDZjdEw1Ykk5bjdm?=
 =?utf-8?B?RzNrUlQ2OVcvajh2MElsYzAzK0tMcVYzVlVmdTJnRTFXVHdXZ2E0ZUYzT0FU?=
 =?utf-8?B?dG10VDdTbUUyVHlsbFEwN2NieHNlMmpqS2d5S2EwRjdaRkk0eTZGNkVIclU4?=
 =?utf-8?B?dTVvQ2gyUnlaTFZ2Znh0ZG0zNThBTEZRQmRVZHNKcTIyTzlBTkVqUG4rTUpn?=
 =?utf-8?B?TnRlcGZ6TWhYb05zZjZYVjNXc1ArREkyd1RraEFBdTBCcEhUUmNKQTh5S0xC?=
 =?utf-8?B?bTNPU3lIY1VoVGZlQ0RKUDNoMlBwOEg3RG1tNW5WYXJJdWdpazJVMUM0Q0RU?=
 =?utf-8?B?MGxxRThFc01oWCszUkp6clYrTUZpMHA0aEQwWWQ1MGc2bERVK1h0eVdwdDBx?=
 =?utf-8?B?emloSkVTMmdwYW91TGRDQ1oyTFNGTk5raEVSZ3AyaGlnRDhsUTVoMGl2U0U4?=
 =?utf-8?B?ektHeTEwQUJOaU42VW01WHd0QjJkVXFEUFFycCtCTXhxbGhqU3hWZFk5N2Zl?=
 =?utf-8?B?cVJwcHMxNExnaXVBdlBqOVZ0ZkdzTWJUUGRoSmJQcjVNVzVmVHc0dGZPSGh1?=
 =?utf-8?B?L0pacDU1R3dvelVJTVd1UG9uRHkvVU0yZUZiTC9DeTZEUFZFS0tzaEZaVXl5?=
 =?utf-8?B?eVpXVmRTYTFvUWFPcjU3NzR3T1BVczI0bmo5OEFiaWNKaG10L2xMcGMyM3BQ?=
 =?utf-8?B?TFI0QjBxWkV3OGMrSHM2WGFsQTNLQnROcnNaVmJxbndmTUFOT25FUmUwMEVS?=
 =?utf-8?B?Z3dMcFovS3dxYWNrSEtrTWkzTlZBUTR5MnZuc3VHYkRPRVFRdGdnV0ZJZHQr?=
 =?utf-8?B?VmhWQzRsd2ppRE5RUVo5S0poWU9IYTlnQzZKNnJTdmo5UFF1c3IzZUR4L1oz?=
 =?utf-8?B?NUF4UVhJM2dwYTZrZzdRaFBMMXJ3bHgrU25EZENKRkM2RWlpWlByYTNBcDlV?=
 =?utf-8?B?aDNJalIxazB0N3JlRGZtMVMzTXNLUnRlNjhsY2FRanhpTzgvMTMzOXB4aFpv?=
 =?utf-8?B?TGFCbDhFN1dSRjhGVlFqSThEVjhGcE1vcFZIMEF4MXJtRFZiY3hOMEpubGs1?=
 =?utf-8?B?RDBWaWFYREhPYXZ3Q00zNThXVXRvU2JwQkRLOE5ERDVlSXZOZkphb2tGWDRH?=
 =?utf-8?B?ZEpyNHdBUE5wUlFyU3RVLzFMRExQN0hNZ29pZFF3Z1k4cFExVm1rdktKZVZX?=
 =?utf-8?B?ZjdBK2VxUnpGL2RkaGZyNnFoOFVreVpvYXZyOXdEeTJNSjlqQU1CZGtScnF4?=
 =?utf-8?Q?s35RkXuKaVAQ91Ebenz9858=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bbcfd2-d48d-4744-a504-08da7a0bca10
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:33:48.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTC9rjbUxDfJSUXR2L6ufj8sDvA9AkpSuSDJKHJxGeTjdex5BqZoFvDQeVem98aHE41IZzR8FgLHCofGdz3KI0dFIQxCNC2nkWazuWq1y473H0U6oeYf/IiiIb0SZ0o/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 9.08.22 13:35, Michael S. Tsirkin wrote:

> Weird. There should be spaces around << I think.
> 

Yes, i understood, bad habits,  David pointed it out to me. I will avoid 
same thread email in the future. Please, check the hardening thread too.
https://lore.kernel.org/lkml/20220801093940.2343377-1-alexander.atanasov@virtuozzo.com/

I will get back to your other comments too, i need to think a bit.

-- 
Regards,
Alexander Atanasov

