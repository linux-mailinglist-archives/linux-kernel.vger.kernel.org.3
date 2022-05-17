Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE229529E29
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244885AbiEQJho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244151AbiEQJhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:37:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DDD4475F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:37:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noQlBfbobHsRXolcwuvJDs5q95BqyHSq8j+uSS+Ejx1cpbq6GlRirzJWBz/cF0BhtQ/JSBLmaEWd7D0P6B2e4bb225DLTNuRATMBPFcEhtxgsJ9pANxUeo76BSuwKx42JtQNnjot3IooRUog6Rqj7XjdFoJub9fWBSInWVtU/002nWtpIwL3rhYcXi22vgzmHxGdGk8E3VdVMwNCVZvUFHFuPyNGAFOUky5Mi/PkBRhYKTfjZSgPeYV7KBMUOKDQwWTBvEt+MNJjWr33aWAAXTwWUDtJHaWjoV9QwS0oB1ok8AGTqXZ4/sHVFJi8Vdj9ydM8bs3/NOJOB9ujX5qR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2WwcJWzjGyxzsElDxTML2OjAT2zDekCudRWILFcs6c=;
 b=WtGyhnydmtveHZxcShWTchA46JNqQcvLkvg03pPU0ICqAZOAjf0gZY63y2rpfH/nrKvAGpDBqkPEMq7NP+A38HQAUX6hF6PxiqAVfQXkQvVeewLTshF62UvqGqdcopCMG8L9pttiNaJHZP2jrcY+qPiFemixrnvhV6JsdfBRFSWh260u0BfcUGH8hB1bi8FN7C/XSxW1OeVQw5+ersHmwPGSgRaWJIeqfjXoy6ocp5n40BD2R/kf6qqlgmL8LNqLQYaVWz+d+tmLNsA+bdX3SnA5ZczPHqxZddEyVk33gMI9CAXu4/hgn8fGqtXJYI/mh88GFNv22A/N6rbRlLyvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2WwcJWzjGyxzsElDxTML2OjAT2zDekCudRWILFcs6c=;
 b=eVzxERmKnLaplLUpCxfIRnXV/GYmf3Y6nyw1xOw3xUbBFFYMPNpsY65j4tlCVZFWmmiaCvDPKRYRnAboXLFJXeOQQE1Xg6bYqM4tlcsdizkBgalcRNPGBdQ/1KsNGRaujKZjfTfIKpMdHxuDZD95As0pQVHXvDlhQDJh5cjjEKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB3652.namprd12.prod.outlook.com (2603:10b6:a03:1a7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Tue, 17 May
 2022 09:37:33 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 09:37:33 +0000
Message-ID: <ca9866f0-622d-a55c-ded5-48b32340de51@amd.com>
Date:   Tue, 17 May 2022 11:37:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dma-buf: fix use of DMA_BUF_SET_NAME_{A,B} in userspace
Content-Language: en-US
To:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220517072708.245265-1-Jerome.Pouiller@silabs.com>
 <c1479285-7fd8-b73a-9672-6e0d7db4cbdf@amd.com> <3847797.kQq0lBPeGt@pc-42>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <3847797.kQq0lBPeGt@pc-42>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: AS9PR06CA0341.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051c5489-cc9a-4ca9-b4b5-08da37e8de91
X-MS-TrafficTypeDiagnostic: BY5PR12MB3652:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3652F45018BEDD0760A467E583CE9@BY5PR12MB3652.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tobRyqRVKmsmme9OoQnoO2iLlMsRkCOqJmUKUT69U9Z6VX/W+F5Rd5WkafdJb1qAk6qnB9nrrhwB9hZQ/+MIQJOkiRRoSMCc9o419JcT7YxjBJKVt58nhN5JHCrObZPZ5H4WOaaecX24h8q8LiEOryPjVzN8UmSbRs+sOtxGxJOgJ/l6qdsaJfGAYQak3Bi/RvN9JlV7Q2YzVxrBWqVoX4LW9XnmwmseQBvGRkUNYqc8p/ePbybV9uuqW2TwYVViJHveRbSqF4jA/SEwW7SnDCcJC2DT/aiIJW7NSM/q4EZOhbB3uRwBN75dSQ8DcTitcC5dAi0y7TkfTuuGL/4qIBUfLqDghlLrkWdnQXa6d1+sRly18NWl5RQNBYxmoj6CN7nygLlpM7Ef8RMQS9zq8UbWNBxTSaVtPGAS2Va7W8TZSRA4PPfvotrj48afhXo4swVYGsEFfSgxEQMmxS+4SA1gSsuug0c2GcyLQYj+MaoLffXpq5Fxc1trEkACKb3TWQy58fK3fC07ZH5brtKhPciEDatJYKVoZgSt1EVlLBBswap1XXOOWpFMa4NVKG8y2P6WaPcUUYif24vaiNJB8F1oI8bGl/Q4rcpvhhiBIJ/rrvWrTNwO06jWc1RepKvBw/B1Qst+qb9j4VCGbEJdsjA/kOWkQ0rMIoXXAU+sGlHmAko0z8+T5RLHZiqORQgPlgEv9pI+J2nrhvd1qGzm0Z2cb1ZaU9Kuod64gcVQ64Hi0MNVy/FXfkfvoVDS6dBbbbZE0BeLNGbp+JFft3dNhYjlO2WLYGw8pHwy3Jag9GRg1lcWgZW/SIYS0nDsnwmL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(316002)(66476007)(66556008)(966005)(66946007)(8676002)(31696002)(4326008)(26005)(6512007)(6666004)(186003)(36756003)(6506007)(38100700002)(45080400002)(2616005)(31686004)(5660300002)(2906002)(508600001)(86362001)(6486002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFR3N01VZlBEYm5DZ3dvTnZCYXdnZHVGK2ZKZ0NXbGlteDMzZEpnaGFFUU9w?=
 =?utf-8?B?TlIyalF1QjZuVjJnQmJITHdDUmVaYnM3dXV4Z296MGJuT0lSVFptYWNwQ0NK?=
 =?utf-8?B?UE5UdmMyRzhndmhRQzV6akhYeHFBUDZpc0w0OVFFbXpwTWFVQmRxc0pvdTgw?=
 =?utf-8?B?WFZrbHZKWlBOT0RDWE8walVGcUp2cGdSakhTM3ZxU1hIT0NUL09QYzBSbW5V?=
 =?utf-8?B?SFFPajdsdVhYS1YwQk9CSUVaMFFxbDVHd2V5cW5jTFpjNXZFbWlkNkJiUWJD?=
 =?utf-8?B?UlVqT1hOL3VVQWxTbmtxekQwd1lkQUY4T0taQmVhRE8zY0RLdFY3S3piREg1?=
 =?utf-8?B?ZFI2Mm1XREVvYjQwTzRGcXdRUmlSK29ET2F2d1hnZFZhZTFpRlpHWUsrVTF3?=
 =?utf-8?B?RnZTRXZKMWV1TWVFMGRzWXp5U1dBVjVubndXQnBKamcrRExOSHFWVmhRRTZT?=
 =?utf-8?B?Q05tWHcreDI0VXk4R3ZjeVY5SUhmWjR3SzVvMmNWcDVScVpaUUwyR2ZmKzBH?=
 =?utf-8?B?WDlKcE9JTjRJemJYNkd5ZzluTXZIZW9lNkY5czhwSnBqdnRuNTAwanFqaHN5?=
 =?utf-8?B?TENRdzY5VDZVWHJZZ0NnaU91VzUyUjVIS3Z6YjVTRVlBNEVReFJWelY4aDJF?=
 =?utf-8?B?a08zeTlYUmFpNTZBcGlxRGlDaUR5M1FQbEY2TlVwRDNNL3Q5aDM4VElIdUJ1?=
 =?utf-8?B?WjltZzh4UFJrRVAraXFZOEhaaE1rbzRzZ2pKYTExNE5uYzRid2laWFFRSFBx?=
 =?utf-8?B?TnYxdHltVndWenhkZzhPNkI3ekZJWS8zVXJ0SjczM1dhejhhN3paSnNMdVBk?=
 =?utf-8?B?NnRDVkVpQzd4R3h3WFg4eWFkMTY1eW9WWjhreCtwUjFMRzg1TFNiTEZVcFds?=
 =?utf-8?B?dnZGeThGbDRNYnFuekZ3T3FzMVpEZGNLdHpMZ2ZSWDdTNm54UDFxV3kza1Jr?=
 =?utf-8?B?Ym4yQlNsS2pEcXh2WmgwUXdxeDk4ditzdi9tZjNobkVpYmJjdEw4cnJVeTJN?=
 =?utf-8?B?M09va0ppb1ZTcDFxSC84aytVSktIYXVqMzJhNEd2aHAybWRtNm41eWhGVC9L?=
 =?utf-8?B?SnppYURyTURXK1V5ZmlzN3lEdFZyUGRvU3AxQ3JRQnRmeS9idkk0VVM2R2RH?=
 =?utf-8?B?aDhaZ3A1REsyVDhRUEhBWkg0UllHa1djNHorbnBrUmc2a1JYQ0pVbzdIYmRw?=
 =?utf-8?B?eFAzVnpEL3lhdjAxUjAwMWVyNmg1eURjSWZxaEZHc0JjbldJRldlUThEN1lv?=
 =?utf-8?B?KzN4MDdFY0tIQklUc0ZMQ1VJR0pKWHI0S3Z3ZGp5Z0JWNElsaHVZMHJuUWZU?=
 =?utf-8?B?cDZOZEtSZmV5dVllTkdqQ2VDUEk0Unh2R1dDRmtZaEtYREV1eTRveVhtMGV2?=
 =?utf-8?B?SEtsV3dYRTFYSU42N3NRYU5tWDlabG9vZkp0WnE3K3ZHSnhTVlJCOVFHMEVW?=
 =?utf-8?B?aFJhcEJ6dmtWR1dyZ0wyNHRKUnp6aFdSUk1FU1hnS3Y4MGxJR1VtNGljaWRn?=
 =?utf-8?B?UDYvaHRrRW9GWStWMUd0QWZISG9zTUZhR0Vtd3hKMy9LOVQ0bklhT1lDOUhW?=
 =?utf-8?B?a2lIbjVsUzdmUThZdHZmZGt1Qld4VHdOaGhMZkdhYnpzRWxhVmUxeTMyUk1T?=
 =?utf-8?B?eWhBZStRS2FPVzN6YTgwbzFzYkJNVkNMS3M2ZW5CaWNJWTd2Q3FWMnVQb0xa?=
 =?utf-8?B?MVhJVzNnZjhpcW1vQU0raXVQbmVJY3kxRHlKN0c5cHVLV2Q3OFlrLzRhRVVK?=
 =?utf-8?B?d2lkK0JmNW1jYzlLaENlVDJiMS91MlBCWmJWdjVzbDZvTTJJVTlnS0ljV2Nh?=
 =?utf-8?B?Qys0NjdhTGdWcmdzeXN3UGFIdm5QSGxHM3R1WVlyNjhhWXowUVRhd1pJNkRY?=
 =?utf-8?B?dU9UNmxmTGhtS2ZwRG82bkJLb21WSkdDY2JuOUZLVGUzdFFRbCsyMGc1Q3BD?=
 =?utf-8?B?RzcxYTg1Q3RuNjJhYTBjTHo3eFlLVzdpQ3RhY0tYZE5CbjMxZHBFWUVSNWRU?=
 =?utf-8?B?UldiNmtWR1h3WlJyWkpNV3JUOXRwdFZBVmFLOHo4OGxydjEvSktlOFNYNkRh?=
 =?utf-8?B?Y1VGcW9BbmJQUld4QjRDMFhTWEhodVl2U2xZRkZRb1l2SXlmajFIZkVtSkoz?=
 =?utf-8?B?VkczQUdRbld4NllmQlMxWGhONGcvYitBb2RFZmZJd3Q2TUQ3Rno0ZFpVcy9z?=
 =?utf-8?B?Y3pSSXE3T21sVnkyaXlGc04rWDBuZklCclZKamdmM0F6NkhacU0xVUhnYUVW?=
 =?utf-8?B?c0kwR1RuSWNXKzc4Y09rWTJMdnIzMUhtRG5EbGtlR2o2alZlVHVGMVp3WkQx?=
 =?utf-8?B?ZDNNZzRtM2hOaEZpOWFET3hmaTM1aTZ1ODdtZHJ2dDlUdHlhVWdQQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051c5489-cc9a-4ca9-b4b5-08da37e8de91
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 09:37:33.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5uKbQBUXFvcVjar03ECDUCsi5Y+mRUeWRvwNsxcFBCOLA5tvlpQOHkKvAPSf2dr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3652
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTcuMDUuMjIgdW0gMTA6MzIgc2NocmllYiBKw6lyw7RtZSBQb3VpbGxlcjoNCj4gW2FkZCBz
dGFibGVAdmdlci5rZXJuZWwub3JnIHRvIHRoZSByZWNpcGllbnRzXQ0KDQpXZWxsLCB0aGF0J3Mg
bm90IHdoYXQgSSBzdWdnZXN0ZWQgOikNCg0KVGhlIHF1ZXN0aW9uIHdhcyBpZiB3ZSBzaG91bGQg
YWRkIGEgQ0Mgc3RhYmxlIHRhZyB3aGlsZSBwdXNoaW5nIHRoaXMuDQoNCkdyZWcgbWlnaHQgYmUg
Y29tcGxhaW5pbmcgdGhhdCB5b3Ugc2hvdWxkbid0IENDIHRoZSBzdGFibGUgbGlzdCBtYW51YWxs
eS4NCg0KPiBPbiBUdWVzZGF5IDE3IE1heSAyMDIyIDA5OjMwOjI0IENFU1QgQ2hyaXN0aWFuIEvD
tm5pZyB3cm90ZToNCj4+IEFtIDE3LjA1LjIyIHVtIDA5OjI3IHNjaHJpZWIgSmVyb21lIFBvdWls
bGVyOg0KPj4+IEZyb206IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91aWxsZXJAc2lsYWJz
LmNvbT4NCj4+Pg0KPj4+IFRoZSB0eXBlZGVmcyB1MzIgYW5kIHU2NCBhcmUgbm90IGF2YWlsYWJs
ZSBpbiB1c2Vyc3BhY2UuIFRodXMgdXNlciBnZXQNCj4+PiBhbiBlcnJvciBoZSB0cnkgdG8gdXNl
IERNQV9CVUZfU0VUX05BTUVfQSBvciBETUFfQlVGX1NFVF9OQU1FX0I6DQo+Pj4NCj4+PiAgICAg
ICAkIGdjYyAtV2FsbCAgIC1jIC1NTUQgLWMgLW8gaW9jdGxzX2xpc3QubyBpb2N0bHNfbGlzdC5j
DQo+Pj4gICAgICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS94ODZfNjQtbGlu
dXgtZ251L2FzbS9pb2N0bC5oOjEsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICBmcm9tIC91
c3IvaW5jbHVkZS9saW51eC9pb2N0bC5oOjUsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICBm
cm9tIC91c3IvaW5jbHVkZS9hc20tZ2VuZXJpYy9pb2N0bHMuaDo1LA0KPj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgZnJvbSBpb2N0bHNfbGlzdC5jOjExOg0KPj4+ICAgICAgIGlvY3Rsc19saXN0
LmM6NDYzOjI5OiBlcnJvcjog4oCYdTMy4oCZIHVuZGVjbGFyZWQgaGVyZSAobm90IGluIGEgZnVu
Y3Rpb24pDQo+Pj4gICAgICAgICA0NjMgfCAgICAgeyAiRE1BX0JVRl9TRVRfTkFNRV9BIiwgRE1B
X0JVRl9TRVRfTkFNRV9BLCAtMSwgLTEgfSwgLy8gbGludXgvZG1hLWJ1Zi5oDQo+Pj4gICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+DQo+
Pj4gICAgICAgaW9jdGxzX2xpc3QuYzo0NjQ6Mjk6IGVycm9yOiDigJh1NjTigJkgdW5kZWNsYXJl
ZCBoZXJlIChub3QgaW4gYSBmdW5jdGlvbikNCj4+PiAgICAgICAgIDQ2NCB8ICAgICB7ICJETUFf
QlVGX1NFVF9OQU1FX0IiLCBETUFfQlVGX1NFVF9OQU1FX0IsIC0xLCAtMSB9LCAvLyBsaW51eC9k
bWEtYnVmLmgNCj4+PiAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+fn5+fn5+fn5+fn4NCj4+Pg0KPj4+IFRoZSBpc3N1ZSB3YXMgaW5pdGlhbGx5IHJlcG9y
dGVkIGhlcmVbMV0uDQo+Pj4NCj4+PiBbMV06IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnVybGRlZmVuc2UuY29tJTJGdjMl
MkZfX2h0dHBzJTNBJTJGJTJGbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20l
MkYlM0Z1cmwlM0RodHRwcyozQSoyRioyRmdpdGh1Yi5jb20qMkZqZXJvbWUtcG91aWxsZXIqMkZp
b2N0bCoyRnB1bGwqMkYxNCUyNmFtcCUzQmRhdGElM0QwNSo3QzAxKjdDY2hyaXN0aWFuLmtvZW5p
Zyo0MGFtZC5jb20qN0M0YjY2NWUzYzIyMjI0NjMwMTRlYzA4ZGEzN2Q2YjNmNCo3QzNkZDg5NjFm
ZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkKjdDMCo3QzAqN0M2Mzc4ODM2OTI1MzM1NDcyODMqN0NV
bmtub3duKjdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklp
TENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wKjNEKjdDMzAwMCo3Qyo3Qyo3QyUyNmFtcCUzQnNk
YXRhJTNEcHJqKjJCU091ZioyQjFJV0sxWEtHRDM4MUxoRHVMOXFPb2o3bFl5OHhNb1YqMkI2byoz
RCUyNmFtcCUzQnJlc2VydmVkJTNEMF9fJTNCSlNVbEpTVWxKU1VsSlNVbEpTVWxKU1VsSlNVbEpT
VWxKU1UhIU4zMENzN0pyIVZwLTZNNmt1QnE0dXFFSGFZVGJrSmJOM0JUa2Q4NURBZUdTN3hOWUxQ
Yk5NcDAwa0JsYkQwaVFQakpkUTVPVkNGZUNwX1hWcnNZSWh4dkxscExRRG1SaEs1UVhoUUElMjQm
YW1wO2RhdGE9MDUlN0MwMSU3Q2NocmlzdGlhbi5rb2VuaWclNDBhbWQuY29tJTdDZmI5ZTJjYTM3
ZTYyNGRlMGNhNjUwOGRhMzdkZmM0Y2YlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgz
ZCU3QzAlN0MwJTdDNjM3ODgzNzMxNDcxNDUzOTM1JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5
SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJ
Nk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPUsxSDNtVmhlaFY5RDFGOUhsZVIlMkZI
V2hONk5pUXBBaTVwWHlGNFJINEtidyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPj4+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0K
Pj4gR29vZCBjYXRjaCwgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4NCj4+DQo+PiBDQzogc3RhYmxlPw0KPiBEb25lDQo+DQo+PiBGaXhlczog
Pw0KPiBGaXhlczogYTViZmY5MmVhYWM0ICgiZG1hLWJ1ZjogRml4IFNFVF9OQU1FIGlvY3RsIHVh
cGkiKQ0KDQpHb2luZyB0byBwdXNoIHRoYXQgdG8gZHJtLW1pc2MtZml4ZXMgd2l0aCB0aGUgRml4
ZXM6IGFuZCBDQzogc3RhYmxlIHRhZyANCmFkZGVkLg0KDQpUaGFua3MsDQpDaHJpc3RpYW4uDQoN
Cg0K
