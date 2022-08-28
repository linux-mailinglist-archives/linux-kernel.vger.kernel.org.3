Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878735A3EC8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiH1RRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiH1RRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:17:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D82CDF2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 10:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNdt+Xjm/E6V+h91gEtnkulASnHMPAxAtvy1rVRti3/AgfPIgPor1MptXUitKKY1tRv/ryK5xI8ezhuRrg9mT8S7X3f2CIVenuFEJkW4Rj/F1IE3OhFA0ylwRQYg6Xib3nohqiqR4Q0oLqN458H0wNYqfNzZApwUJOci+NU4OJhnnyQqRo7B5ro3rHePzTaRSixHO6CYw8t1HhPnj8q9fxwjD/Jqdz7knDRe9HmhaCFk3EUq5n6fnOUm6kkbf7HpZ8ljqyWvnYucFGYcFiRfEuiNBjTZIfHcNSXSMQyr/tfnyepu+gAjYXObzauCmvhmR2uj0oFzZ69lxwXsiLl/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR0lfdXWiTHpUfZeqyoHHYtqcCfrr1QXdQ8g2GmWDnY=;
 b=N11ZldKliuGBVslsaKC9mmUe6GJF25HWIu7SgrQfDthejulG41tF8vpmuFMbbhaU7cViS38YUw6W/qQp8+zic7WVAjl6p4e1RM/GC3YL2uURKe9aWvszzxJTv2VxKvyBKq/2XSfUZqlptgqyD9lTBEJBO6HPQKI+6Y4eb1bV7WMcSIF5f8r5gPKKItYcHdox8JgJWaUpO6rUezKGLj+kVUkuGEfLipCtPvWSpJty+QLyQ+rLQP+Rn+p2/xbMwoNgLwvRyzuNwwpe8x+xVvuLpJ9TwdlP3UJ7hLibAeyLmn/mlvMgnjnEVB4VtvPeeIZPQjt9j4o8ssrsxyiXDvwE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR0lfdXWiTHpUfZeqyoHHYtqcCfrr1QXdQ8g2GmWDnY=;
 b=SyihOI14E1XiXfctMji5Ql117fEHqkzcF1Hawqp39ivi7j9YBYHy8RA9K9c8hi7B0R6c/wfgrRMWtPFFxvj443eDnH4v+TA8grRve8NBLSKgkS7uAKEZMHQJ19HHK9CyDlXrVVJCpj+b6oFHQ2vhSy3iDuEFY1nNlYhFTr9OeSPuBl1MGbbR6vx97roniT2+iHz8nmEeDLjydfB8gU66F7+D4xaAxZJjwkSWLHcnHl3tYIZw4R1zDo/XsS7h7ZXtbV8g4Kkr3KEoHGKM1gLdMW7LLWbxlR6xveDprAUzI4Mrf8gBo8oSPp86X1dNSKfpSe52WEb2EGAJA1zUwga8ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sun, 28 Aug
 2022 17:16:56 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.021; Sun, 28 Aug 2022
 17:16:56 +0000
Message-ID: <b120cf98-85e0-75d5-30f9-44306b036cdd@nvidia.com>
Date:   Sun, 28 Aug 2022 10:16:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] mm: re-allow pinning of zero pfns (again)
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     akpm@linux-foundation.org, alex.sierra@amd.com,
        willy@infradead.org, hch@lst.de, Felix.Kuehling@amd.com,
        apopple@nvidia.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <166015037385.760108.16881097713975517242.stgit@omen>
 <033c2e8d-8ba9-3e0b-9dee-7d0973c708fa@nvidia.com>
 <20220828063759.60c85fd6.alex.williamson@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220828063759.60c85fd6.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaefed65-f2ed-45a6-eff5-08da89191bfb
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ws2ZyJ9evg6dliwZqZSWWaAA6DwqFloPWYYv1W3rvIv/lnAOXIIINaDyUlnHkvEQxjNy/0qMjyPbhb+p52hfpU9cCTZxZ78MvLKiPhNzxnx3No+r1RXnF6QcNF17+5kmYVFJxDpYQmPVOj2zCNY6+NQOnOThikG/m0TbA29RrRz8ZmTUkicXTGw1AJUIZQ3xAUJZ1qF7z1Zct5aonWucfpHrSs708ZFhb61ELGcTGv/IwAcRqmzpMl6kAuIWMTFpvW8R78z7J3FDwg9Bi+KF2djnNm6PJAAS1wF+16fsW28gL6EruD0mO042rt8CAEO6KKPDGaOHezGphfQmeXZdHDgcWmKHrOyv+7cuc2vQOaW21Mq8qeRZtJBgTCiQodNRiUGl2wa2JaqCLEztHrsTbsc6n/jTu3WOeaVsL8LcZSVTl6rb6FrSaEkayuZpKPZjgrfntx9ZuoANQ1GhVEAJu1Ea5cqhAS4ys9FLPrVe63PFwojwhg+KiHBfLQ0bXRC2h9LNo6RY5N9uyOKRp7ZsFY1eA1hAj/Ms4zgxVVDjytUVpNKdSF64UjTCBBopGiARgiY0LYsejINFsb3w2nJGOBB6Mwf5oWCIfKlESxRMbdTDmu2alMAIVHtN+T/vxumnBxxOWQ7E4BewBktoVzpPWtw/BudgtK5i2s9P7Q2QwqIGgq27sfDmJ1zA6D3w/IVwacO83i8fa8DbVa76KDYITZ9NcCsRHKkbfFEHfY5tpwR1bUqHW+14gZJ4ivVLx+l3LoEGOiRxrCfMUKPGhn+UsHz74GEeAelRDnhqBMMoU0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(186003)(2616005)(316002)(6916009)(36756003)(31686004)(26005)(6512007)(2906002)(6506007)(53546011)(83380400001)(4744005)(86362001)(31696002)(8936002)(5660300002)(478600001)(6486002)(41300700001)(38100700002)(4326008)(66556008)(66476007)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFdXR09DaDZadWRySTRkYVRVSy9EbUlXYjhCb2xyNmFPekJDRkM1eCsvV0xX?=
 =?utf-8?B?S3I5OHdhVFBQUWVxNkFJWE5UUnBjMmtrcmpKOG5ySTF2Y1NPd1FtU2R3QmJW?=
 =?utf-8?B?ZzErd01nK2owUzZnbEdjdzVlOEFHOVl6Y3VwSXZsaGFqcUQ5aUhmdm9mTWVw?=
 =?utf-8?B?OWVROWdMeTJDSGViT2l5N0hVV2Z6bWdyS0Ztai9PamswVkVicXVmM1ZuYXh5?=
 =?utf-8?B?NGNkNDRuNDBKeXhCcGlpY2RlQ0VPWHBzYm9QVnd0MmpCQ0JmWVhaN3dKN25t?=
 =?utf-8?B?UGV4b0lVdnpsVXE1ZGI0enVYQitaQ1dUTU1nRnh1dEdpaVQrWWMwUHlyaGJm?=
 =?utf-8?B?bkE4OVhQbGVoNHFva1M3NmlxTjh1RXluMGRWOUhQSVpYQjBuejR3ZXRZKzBr?=
 =?utf-8?B?TmtibFlsN0RKem00OG1KWmw1NUJrcVNvSWdFbmZJbFpDQ2JJRXV5SnJhUnhR?=
 =?utf-8?B?UFJLV3d4MTJXYkVLOEtDRnpvalBxOEcwSWRGZm9uVUVZT2J6MEgzNXJUMFR2?=
 =?utf-8?B?MnppR0xMNXZBblVsZHdBQW1NZDlteXdtcjljUlpMMW9qblZKUjVlcHlYSGkz?=
 =?utf-8?B?ZUNLbXRnMFpIcUNpYmdJYlhRMjJFcW9FeTIzSk9tZTVGSEtLZ09HQ3ErOHVJ?=
 =?utf-8?B?QnFDU0FuQ3VmeE93Z2Vqa1c1dmVsZDFFQmRrR0FBbHMwWmdNVGZjVzVYd3hV?=
 =?utf-8?B?Vjg2VHlEZTdmVFQ2STdmMHlUU29vMnlyY2VSZ256Wk80VDk5RDVSUGxUNjVv?=
 =?utf-8?B?czluSzhvRnhGZ1dNL0VIT3pHSjYxb09CcDdhb01sS2VubzgrNmpkTUd5RUNN?=
 =?utf-8?B?VytZVFcrQXVVTmhVd2lzdDJGSzhKLy9uUmJWU1lCR2xaQzFVbEIzQTFCVHox?=
 =?utf-8?B?b216L1FzaHlQTWw3TWFaZFhuRTRtbmczT2NvM3Rwc0lkYjRrczdVSkNJM1pO?=
 =?utf-8?B?cE5sVm4xSTdzRDlQNkU4TDNmLzd6ZDJYVEdxRjBxMTZVN204ZjZJNTlrS0k4?=
 =?utf-8?B?eVZXSzVLcE5INGk1MStrUVorOWlMWGxwa2g4ZC8veHI4QXZDN1JOZzBoaElF?=
 =?utf-8?B?R3JBSzczR0MvMExEQTM0dEU4Y2dsQ2RTK09xb0dHNVVLM1VEdmNvN2Q1RTNC?=
 =?utf-8?B?dnpOeEV1S1daSzlpVFZrbjRZeFkzQkZxd1phSUMva1dyZVh0RzBIUWcwYWx2?=
 =?utf-8?B?dHFRVDRJbUtPOWJheVhHSnRqdEppeUd6Kzk5VnhucmtLSGJOWFNFeEM2Y3NR?=
 =?utf-8?B?Ui9vK0wrMmt3TXVCRWM4RXJwNWRhVnljK3BSUUorVTVLMlJtaFZCRC8wbE5n?=
 =?utf-8?B?b1FjTXJKT2tWYmtGZG5mdmpUZ3A3Q3lsRWRWV3lTc2hBM0xxcmVydlY3RzRH?=
 =?utf-8?B?SDVVY21CbUlDTk9ZTmJGWUl4K0tLSlRCZG4wVmt6YmRYcHNDak5zMS9OZ2lx?=
 =?utf-8?B?S2pxb2NpVndUaUQ4VHNpZGZtaURIYTFoUkIwaUpJTWMyL2UvdytkRFFvd3FW?=
 =?utf-8?B?N012eTFoZmR3bU9OZ2YwbWhJU0kxNGpkNGIrcnp0NnoxM2kzcVhiRUhrdCtv?=
 =?utf-8?B?VW0wMFJUS0xSYlVCNjh6d1JzUmRKMll1TXFqQ0x5b0NjbTY2bkFNaXZmekhI?=
 =?utf-8?B?RzFzUTRvWmQ3cUM0REZyaVdLT01BRytFVHZKbEJDTnZnK21hSURaVmRuOHFU?=
 =?utf-8?B?K1N5NG8wcmpuMVV0M0EvRXZmRlpzdjJFSjk4aUdkaTU2Z1dOQStqVUtnL3V5?=
 =?utf-8?B?R29mcXdmSFpUYml2MzcvMHpPdC9ZdDQzdmdyelZsdzU4M3ZmUVdzV0RZRUpZ?=
 =?utf-8?B?VmJYMitjSzlWSVR6bXBKNCt5RWg4RzNmdGhlRnArT2loL2EwL2FERDFXcWZ4?=
 =?utf-8?B?M2ZGeUxjUkhNQ2lTVDYzV1E5K0pjcjR4ZzFSR09CME1zL1I2SWFtcWRheDA4?=
 =?utf-8?B?NXVicjI4ay9EZFJpaGtCdis3UWd1TzdwVmFpR2REUTB2TXMwNkpvaXE5TFpv?=
 =?utf-8?B?RnpLaDFIeEdteVQxZkR6MHBhQjdnS0l4NFRKYjIvcjlaQzU4RGlZS1c3c09v?=
 =?utf-8?B?OGJVbUdxZXZNSko0c1ZHajhtVnNjejZyUmZnZ0N4NVJYSDdFMHA3d25LZWl1?=
 =?utf-8?Q?AaHMosW9SyoMtEL18rVLGROEm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaefed65-f2ed-45a6-eff5-08da89191bfb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 17:16:56.4435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVjwkaxym6COJ58v93HGqfcUsDRNE28NhWWTKJm4TvaKJoV8yx8elg4sn12XLgAGhh6DFYScsjLit9BXhMHxzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/22 05:37, Alex Williamson wrote:
>> Those notes are all about (some of) the callers. But it's a simple
>> answer, really, so how about just this:
>>
>> 	/* The zero page is always allowed to be pinned. */
> 
> Sure.  Are we looking for a re-spin with this?  I see Andrew already
> added this incremental change to his hotfix-unstable branch separately.
> I'd hate for a comment re-spin to delay getting a fix for this problem,
> that blocks any VM use cases of VFIO, into mainline any longer.  Thanks,
> 

Definitely not. Andrews fixup should suffice.


thanks,

-- 
John Hubbard
NVIDIA
