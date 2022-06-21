Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D0A552B66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346449AbiFUHAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiFUHAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:00:33 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130114.outbound.protection.outlook.com [40.107.13.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771721EAD8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2moQ1g3ha1LyRic9tACabCGQMFRY6Wk8fv4oH/xH+Tc1E4kVeKlORuJu4j+TKmXlf+u5vLkcbJO65bs6PPVOWeu+JK/71/w0LO5fvzLIvvzjVABEh4NsJPlAs5FSZK8bFA6a9gKChsdV4xTnPAASnlolXOuR1zxoWifGHk1KEF/h5yseL0XHgJaWtuglM9syWthEp9//m0HxBu9UoaE5bWkyl0V59IRT4LyFCEuPtGGvU8yW383PK56f1OaeUaKAVoAVVE+Dx8XY1ONfsFsXLt+BAKHyTGQ+HCp9MI3DMOiEM0PAL9F1rR7KGjxlUag+k1RijawqGmmFA8uRCSDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xy/nWPJBxfhj/lM6jrb0rK7AkCjjDKPE9f5rhmdQatY=;
 b=d3bBsgUyWskSudWZ4WU2aqgja+R7dq7ClD4uoc/mxj2SNU8eZRqqOBcRKWcA90NugVhk2DtJWoEwxtOERq+kJVQJNPWeUb0j9xG/urV+ISi0P95q200NKKz7Igd4/j1xJ0AwtaDkjJfckLSJe8yELAhXxIUqpTFUYuhr8jrpbADZASeBXQs3MNom7y19BbEZkXlpMAuBWK+MkprVtxasVWXRT077wV51sM7kmZRIKCJPW7iJ1fRB+dqGJxn1lZIFCOlGQBZVxbIqO/0Bcqi5i6ATFT2D7nYdQalf+ywbGYKVo1tjko2/8f0WaF+giGuYhoU7NV/L4SPbpWuFlZ0c1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy/nWPJBxfhj/lM6jrb0rK7AkCjjDKPE9f5rhmdQatY=;
 b=eurEI6y0S57U9URns+SE+bdWa/iRgQdY8nVvuHhjpknWfYGuzvAp/7LZuEJob4BpbOG/ZhSmmaYqZq6DqXV1NnKtzVbEAxB/zmCi9cFSlRp59NBQLkXvFUJBXPm5uXBt5DId1NbKPdhYuYWkv8VTOt+piC1XGlZgKD4FBMD6qqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM6PR02MB4536.eurprd02.prod.outlook.com (2603:10a6:20b:3f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 07:00:28 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::6c12:cd95:b34:7dde]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::6c12:cd95:b34:7dde%4]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 07:00:28 +0000
Message-ID: <784d0cf4-1a9b-3421-c437-f5edc8ce62b5@axentia.se>
Date:   Tue, 21 Jun 2022 09:00:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: sv
To:     Tudor.Ambarus@microchip.com, regressions@leemhuis.info,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     du@axentia.se, Patrice.Vilchez@microchip.com,
        Cristian.Birsan@microchip.com, Ludovic.Desroches@microchip.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, saravanak@google.com
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <9e24034e-f586-a721-9031-179601a69abb@axentia.se>
 <7214ea3d-1445-c0fb-2620-cdc3d6167bcc@axentia.se>
 <b5c57978-212f-55c4-2f0b-b38a8f157ca3@microchip.com>
 <a024180a-493c-af20-0910-da30dd5fe364@axentia.se>
 <6d9561a4-39e4-3dbe-5fe2-c6f88ee2a4c6@axentia.se>
 <ed24a281-1790-8e24-5f5a-25b66527044b@microchip.com>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
 <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
 <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
 <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
 <c5928610-4902-27f3-7312-e8c85eefad39@axentia.se>
 <bfb4cb27-e2e1-e709-1c27-d938e4d30eab@leemhuis.info>
 <6b1bae01-d8fb-1676-3dee-9d5d376e37f1@microchip.com>
 <0d8b2d9c-af85-7148-ff13-aa968a7f51ad@microchip.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <0d8b2d9c-af85-7148-ff13-aa968a7f51ad@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0017.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::15) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf5f528-52e9-49ad-7652-08da5353b968
X-MS-TrafficTypeDiagnostic: AM6PR02MB4536:EE_
X-Microsoft-Antispam-PRVS: <AM6PR02MB45364C2A550E4D5282DF8342BCB39@AM6PR02MB4536.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sh9VtGaga6zzyS/ePaWPoMcaNndIJUnueh9VqsD5hVKSMtbzCcoDUV9dM5qJPlCPxCsVZixXp8XSOB+QNGjjwSChQbQtQ48v6V5qd4df/n6JwottftnDDK+1Xb6PW2ByvSkWb+XCZxfcYKWJCWoVLypf1P4r0LuOdJVTPtf5+QkV1xigPlkxri6Oc/S4f3XYTd+Qz6aHTUENJYScnFDMOKEKxdKl9i9Wg+582uh67nXRYR9V6Uv+E3QazddO3TCipN790rjZzHozfDGavYN8mZWkU3x+L+iTtET6F5T6aK786Vcd95rvXugQbuOtkUGpVGgdNNOfoArYNF7ga0UDnGtuINeDYC2akxRXM5y2sUYXl9kum5pKRJL3PhDTT+D+58a9a0Pj5+auSF2fjnae5hrfPRn6NTlfqGpObjCkWmhY9WxvdG+DQUYQFL09kHTqyn+9BdYE7IHQxxdbgVfbWFU6LLE1HO/dPbbec4SlOSf2C1AK83XP9TCgU6l2L2Eh0UxvfoL1zYD0fztMyp6KJDKCsttqdLoFI7319AZo1VLDXrONfJtmFoVHJXPxGOdJsDsQyjvKvwbr8dyjFgg/DkAUMuqxSTuD1z1zHTwH9irr8aU6XAvAIJFqcZ0z7PT+NPCMUoCHO0eWQ4ADjSQzWJL7WX8KYsZgjR6wJdO7ISeP/fibs8QBy8k9H/XTDSJ02PbRJWpXJ4aawHmB4SdGvvaMVCAk6TUPRuNSkrSo2wA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(346002)(39840400004)(366004)(396003)(36756003)(6506007)(31696002)(6666004)(26005)(6512007)(2906002)(31686004)(38100700002)(7416002)(66556008)(66476007)(5660300002)(41300700001)(2616005)(478600001)(86362001)(316002)(186003)(8676002)(4326008)(6486002)(4744005)(8936002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzN2QzZMUDF2S3l6dURHeUs1aGpFampTM1FvUFZXUEtCaTZ4K21oZktBWU9u?=
 =?utf-8?B?OGJnY3o4V1h3b2drblRGcnppb0NzdFFXUS95cnM2ekZuWExRa2J6R1E0RElt?=
 =?utf-8?B?Nis5SkVuWGozWEw0dDRoVHkrUDZRWHl6NERTVnZKMFVPYTVsQUk1bnZ1Ump2?=
 =?utf-8?B?bTdTNzFyMTd3THdTSXBwT0VMYjdrTVVVQmJLR09IZXQzWHU1TlQ2VGpmKzJM?=
 =?utf-8?B?WGMvamp3Mkt6K0FtTjQ4ekJOUTlSL1lUWVl6b3NMWENOOUMrSkZzNklGV1M3?=
 =?utf-8?B?QXYwd1hCam5EM29yUVVuemU2ZGhuQkduRmxKU0xNZld0Um0zZGV2NExIWmFv?=
 =?utf-8?B?d1IwVVhDV0VvaTkvaHJ4UnRNUmNDSlBzZE5XYVJqalBZZ05VTlptREV4T004?=
 =?utf-8?B?V3FBQ0sxeUwzMWZSb3o0WXlhK3hqWVNVV21ONlRLY25Gd1F4SENTbXYzaVJS?=
 =?utf-8?B?dHNDRDloZFlsS3lnYThnYlcwOXErRzAzaWxNU3RwTlZtbytSbTRVYkNsRVp6?=
 =?utf-8?B?ektlRHBpb1NQalRtNFVyNlVOK0llelZGajdnVkdoWlVrNnRMRGZFRHF2b1A1?=
 =?utf-8?B?Rnc3QUdyYk1NWGpUbnRIK3c4dFJOZlI3VnhPRUlEaVZ1UUJvWVpTRUcwa2lF?=
 =?utf-8?B?WVZYSmY0WDRKajlxZWlxbnVwbGVBMUo1NjJIakRBb1BqSklkS05JRFFrTnZ2?=
 =?utf-8?B?cnYvZ0V5a01sNlRQSjhtck43VHFxL1czUFpmZDUzTmFNdkhVY3BHQWFBTmJH?=
 =?utf-8?B?NlFxZlBid0k5eWZ3eVlQNFloYzROSmFKeUhFL2V2akQrL2QwRU94VEpuQlVP?=
 =?utf-8?B?RHowQTdEMm52dXd1S0pqaVl3WUNJSWhsa0xqNWQ0bXNVUEpodUhiSXZSNzR6?=
 =?utf-8?B?cGhPdjVSU2Q4OFk2dkd2RkpweGFNNk45VE85UTgyK3RoODEvOWQrSDRSbU5U?=
 =?utf-8?B?SnFlSGJaMElXVmVRTTNGdk9ka1h1VnptbjdQVEFQamdkUnN6WVFMK1NNUDA4?=
 =?utf-8?B?QmhIVGVuZXE0WnRsODJlZnh1QUNkTGdhOGN0MnhTVmJtNGRldGxibkFiKzVZ?=
 =?utf-8?B?L3RYUGFSMjVDdkE2aUdPMUhIZ3lGajVmNElUTVphYTEwcGFBZ3laYjRKVHJF?=
 =?utf-8?B?WFJSWlNrRG9rY0dXTU1EN0FtNFB5OE8rVEQvMTdHTUtOcFpWNmlFMHRKNnQ5?=
 =?utf-8?B?UzNFaVY3Rjhxa09hMFB4MGpTaTc3RjU4UC9mS3Z1VGN5UFkra2k3ZSttQUpT?=
 =?utf-8?B?R2VndGx0dVUzaEpKZnFEdjR3Y0YxOU14cFlsM1F3dCtCdllTbk9VbGlFUWpz?=
 =?utf-8?B?bmhrTnJ0M3FTbHZqSk16am40Lzl0b05aQzVKYSs0b3lUL1Rwd3lYS01kazQ4?=
 =?utf-8?B?dUxncU5TbUVsdGJvS21mYVlyNCt0T25PalhIeDZId0FRYmhrd2daTGg2T2FB?=
 =?utf-8?B?eE1qcFJCcFIzbU4yMFpTWUFZZDhUZlBpb1F2a01sZkhxY1R5NjZyK1piS1M3?=
 =?utf-8?B?MlM1aDhub3c3OWc3ZVkzNEs3YTBwM3J3ZkxiVTd1T25oYjluaEZ2L2ZIRGg0?=
 =?utf-8?B?a04wVTkxaXJoakNkN2xPVVpPRGZrcUpyM0hIUWMvZ3lqVmYvZDZER04vUXdD?=
 =?utf-8?B?Z094NG44Vjd3OU1HNHBsaUtScDNyMEpuYStwc3BCRndKUjU4eVFUNW1nVzNS?=
 =?utf-8?B?L2k0Nk1EN0xUclZrcjVXRVJDd3Q2bFhncHVNN0NCUDJzTWtFbHRrcjFmOEVO?=
 =?utf-8?B?cGtXNkViR2lBTklWMFpCb012dkJxMTE1R1QwSTNpZHJaTzYrTlpZbUJIcmRO?=
 =?utf-8?B?a29JL21LVm1KRml0Y0U1aEUrdkMvcXVBZUM4RTVlemkrZW4yRDM3Wk05M3hm?=
 =?utf-8?B?ZHpqdzZOL1l1OVBuUkpZNXVVWTdjOTZsSjFlUzJQaFhwOXNaa1FLS3M0VzRC?=
 =?utf-8?B?bDBOSHJxd3ZkMmNjYmowTW9kbHFQYm5USUV2R2tXcXhYUVgxcEs3UkFxaGUr?=
 =?utf-8?B?RzRzcC9OSm9BSzNkS29DUVJEeGZ2ZElKbEN4ZWZ4U29uY2dSSzNmZDc5Zmxq?=
 =?utf-8?B?dnRqYjhibmNJTG9odldZekpxWmFhS00wck81WWNUWUJSVzJJeURmb2hrU2dX?=
 =?utf-8?B?QXlVeTY5ZDd5UURNVm5oVU81UVFEOUNOMEYxcm1sMTBmV2RpUGlSdTFQVXFl?=
 =?utf-8?B?VkZIMlBHbloxT3VVWW5TSDZHaDBzZW5kQ29zaUJMQitPbGxKZi9aRXZ3N3Vh?=
 =?utf-8?B?WUovMzdka05neHBHbXltRmw0NnBOdlh4Y1pRd3JJUmU2bEl4NW1HeXZ3MUxq?=
 =?utf-8?B?TWtRTU1CdDVwTXJzR010MFdManJacUM2RmpMWmZJdjF3M1pLR0xMdz09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf5f528-52e9-49ad-7652-08da5353b968
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 07:00:28.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrlQPgjN5QngFag9F4CKKqhHMiO0HN+/JAqlW7LOQ/+LuE7abYpkT/PHOFHxp4MP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4536
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-06-20 at 16:22, Tudor.Ambarus@microchip.com wrote:
> 
>>
>> git@github.com:ambarus/linux-0day.git, branch dma-regression-hdmac-v5.18-rc7-4th-attempt
>>
> 
> Hi, Peter,
> 
> I've just forced pushed on this branch, I had a typo somewhere and with that fixed I could
> no longer reproduce the bug. Tested for ~20 minutes. Would you please test last 3 patches
> and tell me if you can still reproduce the bug?
> 
> Thanks,
> ta

Hi!

Great news! I will test today.

Cheers,
Peter
