Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148724FB372
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiDKGIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiDKGIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:08:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1909C13DFD;
        Sun, 10 Apr 2022 23:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4SKBAT9f9xrtWql39sdO5UeESu9y5d8e/szC8Llomd572wdW8HlE6v08YbnFZy3x4+HVenckV1URlWUROMVDkRDrs+iMbacZRCkSyM1goE3gmjOuKoKoHDm/JaS64q6lxIJWh7aHAqsCg2XVe4o01mP3m930SGxphdLKN0M9ij1vBCGKw9vmptwICNISSE7O3Cmuj9SAugaDkrdoH/dsKes5fYvbBNrC2gESslde6MjOJqotyKUmsv8483cfhHV5gVQxcKXb79LJzjCTtRuJVzvOKRDxFpUILvQUncUNhpYQ6lI3vHuBAk96ksYtCqSwBJ76jsH/lVPe/D2ofRFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQRqjw6Rk3EwhDySR80ELGscjrUe7GXLDk702NsBp6w=;
 b=cuQXTD821DRRSLfChmIRP3fjL/LACSAEL+uxYRvGAyCqNwFVs5prlMtSTg5kY8zMBORaBnPmA6n8LXtRZiRB/Rq1g7xknvNw0qfEBQOjMzvH5QvCuPDSixrmRy+O3Vfrv6k9dt4tix71CB8NNMAOnfyWcw4ipa2JGp708YDkNJnXmdn60I6Qb/kMpujZ+Ax2eJDUnW10z6jtNLWtJP81/cOSCtTR1cfIVPYOVIFb7APYMI/1pAA53Sw21at21DrfLgY3+vs/lbLouzu2AovghvEAV5GUzPsggXFm5zuFSGRQ4tFbd++NEEZAzRh3BGU+ZekLF/n4q1ke/pHBViYF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQRqjw6Rk3EwhDySR80ELGscjrUe7GXLDk702NsBp6w=;
 b=nlaS0PAgXYwGIeAS4pTpSV0VNfH5fBTPYmUgMNJ3yBkne8O7homsROBYeiAt1kpCvdC2nA/JxfQJc8zauikPxFU+mh1ecvrVNVh8zoumec/nmCx5/F6oj9k3rnfR/jieBKAIKUlNvd/iUirW2zdja+QfXxmV5nSghTATG9qCF0UwMyDW6VSTr7aaHvV7u4f+bjA1sfdnARpjRsdg08obZzOnX/2YkaEclKWr20zM0aKdhNChbJIEgXgvd8qX52mIwDBNJJWn+hwqjTFVNJFrf0fG+NiYYvEFgOsWl0oq+bNB9VvW+8RWaMmYWwoy76xZW2hY0NYD57+3cCSvrOx7sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 06:05:45 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 06:05:45 +0000
Message-ID: <ba28886f-be5d-9ab2-41d0-942609934263@nvidia.com>
Date:   Mon, 11 Apr 2022 11:35:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v6 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-2-amhetre@nvidia.com>
 <3bbbffff-6aa3-7068-6f0c-4372d53daf94@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <3bbbffff-6aa3-7068-6f0c-4372d53daf94@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::26) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6827353d-b4f4-405f-9fe8-08da1b8150d9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4358:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43587316FA4ADB419D93CB0BCAEA9@MN2PR12MB4358.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWoFUp78Xf3jipx3CiWDUFTbut3+nP9998FIa2IpzoY4JeSnw6mNmP/z4TSO7tAatQH5yzlNTOEI9RrVLfWCtRBxq+zpoTjKv68R0qrr+9uyp+Fr2CgrIKvGKPwTxizoWsm9mstci5EUSj5Gn1yG6Zrq7dFwGBHyNpmzCRR0MNuR8XYld++i96tS0VcQZb9+s7VB8BrczqHaTp2GXCbB7pUj1CQRlDVgqGq6ojX1Njkl3X4xeBLNRn08cemIjCPXpb0hArP4xMWqrulce8UOXMRIW0uzkNlRKrUw48bW3vyQmWz/XiIVlGW/kbN1aeeAXe7UKHmclv+7/8Gn65brEnVc3ZMYAKjsqbHyxpTdnR1OtmzMBABBEvPl8FzSDCCqkCnaWJDLCUeWyrzb7CHPBOyIBvUZ3FLiAav64tSWXdlRGxlL2EojmjCU57Ub0wo4ptUu0CKl2oNXbB+fetgP17A4Fjl6h0zqG985Y3ncUKLctFT+SB2mJhHZDl2ALMbdWvC32OWOBuefhW1AVOHrkA0V1Q0GRkSOsUytZ+Am1yOIdmQHtv3ycOFNmqvSf1g0lSTAR5MZ2u+8upnRUYMya9qT9iO2KIMqpIAZuZ0/Qk47ov+EtDOE67ZSWGcw4EVunZV6KVBi4sDW2XTdh6Hqxy86kBXXATz5NA4ZtRw5UHBEjwM7dThGw1DO5CKeeYFqzAeXlelVW1icTzB/7NdITpOm4VCU+tkEXaJHSuY4oRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(107886003)(8676002)(2616005)(4326008)(66946007)(86362001)(66476007)(66556008)(316002)(38100700002)(6666004)(55236004)(6512007)(6506007)(53546011)(6486002)(8936002)(83380400001)(36756003)(2906002)(31686004)(186003)(26005)(5660300002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0VNS05vY1Y1SmNGZnN1Zjl2UStRN3VvT3NBRWxneVF2Y0xyK0VHa09OZXlr?=
 =?utf-8?B?VmpJT1NHTERhbHc1eDZ4RXEyUXVzdmVseTUrdXJ4UEZYcGM4cExwMlR6eUM5?=
 =?utf-8?B?cDdhZVlISGIzT2ZwNW9OcFQ1YTlFdGVNQXdzbmZ6QzFRbEdlM21LeFdsOWxY?=
 =?utf-8?B?ajdkNGJCVkNYeDllTWtGdzhROWJROVU5N3owaWJUTEYzZlU1Z3lPeENKOEQ5?=
 =?utf-8?B?MDYzNEo4SURTanRwQ0JGd0dVKytjQkNPbEJ1ckVBWGc1Z0RXeitsakZTbXFa?=
 =?utf-8?B?UDRSc1JRUlpOaVpSOVBtSThqSnFvTWp0REZMbGM3S3dqOVc4RlFFY3ZjN1Fu?=
 =?utf-8?B?U09WSEJMOVFsWVdjMytyS2YvdmN5eElBcG1nTERwaWI1NXh6ZGVPYUFyb00x?=
 =?utf-8?B?T0xmQWlvcWdWWFFYK29mYlkwdU9tVVB4U2h2QkZSV3pVZUlIdkE4QkUwdnUv?=
 =?utf-8?B?UmFYNDlrN2h2dlE3TGtjdzVtUU9NKzg4cVpPczRnYkY4NDdrVTVoY2tQWElQ?=
 =?utf-8?B?cldRblA0U3RYbXh5a2N4NUVic1RPTktVNGQrK1k1eDNZajM2N2ZzNTNlQnho?=
 =?utf-8?B?Q05IUWxac0ZIZWdqeFIxR0toczU0Zk5kNCt5MzJQTkFQOWVXK3psVXhGUUxW?=
 =?utf-8?B?SFlWOWpHNGpRcUw0MkhxMjRyVld0cFdPS2NIeTRYUUZZRytBbTZBTG9CbnRQ?=
 =?utf-8?B?b1hkeklnREtMbCtPYU5DUXZrdTFJT1JIdSswM3VnQUxneDNBM2NYL2J5VHlP?=
 =?utf-8?B?ZUdwNnBYaVAxSUZ6dHRqK3BCL2JCZ1BUUmhKWDk4NjcyUDRCYWlGSWR1blQr?=
 =?utf-8?B?N2tmdGRJblpCU21uTjRpZ05tUUNpS3VqZ1VlWFpBVGk5YzVOQUMzZUtHcnJr?=
 =?utf-8?B?OTM2MWdVamlGN0pYUzdiOHZLT1dXbGFjd25YdURSUkRseXFwQU42eC9rYlk1?=
 =?utf-8?B?ZkRQTXFZbnY1RlR2Yno1RGszV3IrZGdYaSsxd1gxZFlJbXJZdDF0aCtYYm1J?=
 =?utf-8?B?d1FNODFqWHpXZDJTTmdiNU9tVVlPN1BjbXdZYzhvNnJKRUFOZ0F5ZXhnK0kw?=
 =?utf-8?B?TitqT3h1Z0d5WFJGK21JSEVGVUdDMHA1L1g2ZUw1bEI2SW5WS1d0Y0xLaVds?=
 =?utf-8?B?UFBnZ2lMUnlleWVFN3NSay9WNmZpdDJaQmRnVXZ1MldVQ0E2R1A5V0dwV2tC?=
 =?utf-8?B?aXV3bXdZYyttSkRkL2xnek1mMldrNlVST2pkTHg5VEZvNmZldGNGR2FGRm1Z?=
 =?utf-8?B?ZHgxUWtSTENvVkVqclNXdjgrN05SWW5ybmt1SWZPVi9yY2VIZ0ozTWFHYzgz?=
 =?utf-8?B?L2hyR2wyc1ZMTmg4d3lHS1k5V2Jva1FieXdxQkpTcHlhcml2aEZmN0ZybW1O?=
 =?utf-8?B?a0VkQ09mZjRjek9tdFZzZnpOZTRSZm5QZ2hRRTBnZjZoSjdSWU5pMnJMaCs1?=
 =?utf-8?B?WVVmMEpCb1RPVkwxN3dnM1FybzRTMXdSdFJhdzkzemZHSUVKWkRWazJpcXFl?=
 =?utf-8?B?MDVuUEkvRUx2Sy9qeGd6cWI3amN3Y0lrV25BRXVrenJBeXpIOVIxRjAyalZz?=
 =?utf-8?B?SDRodVgxaXJWM2ZBZy9CWnBuZFRoM0s4RXZUeGtDanVsY2RPZVpNSnplN2xz?=
 =?utf-8?B?c2pmVDUyWWtId3pRbGJDazQ0azQyTnczeDFyUVJjS0h6ZVIwSE1mU1Z0RTIz?=
 =?utf-8?B?U0RzMlR0b043cEJBVFRLL2dQY1J6VVNwMWE1Y2YrL2h6TXRudGFZS3ZhVGdU?=
 =?utf-8?B?bEZlckFoN2cyeGpuK0FWTXd1ak9iY0Y0T2xwWjR0UVA1cG1yN2VQUkZFZmhx?=
 =?utf-8?B?bGpwNU5LSnArenNvVWxkVUtKa0x2eXJoMFBPa3BtclhXbUw4amFmNFZqQUlP?=
 =?utf-8?B?NTI5MnZvUmlENm51Szc0M3IzOEE5ZXJ6cTFhblQ0UzNMYXgzK2FFVU5IN1Qx?=
 =?utf-8?B?RVZ3QzJkMk9mUDlpdFU5SjhyNksvSklrNmNYbklBbjV0bmVtTTkvYjZJZ2l5?=
 =?utf-8?B?VlZ4RjNkdXhVZXppbWplcHZkUWk1cmhzQk9KaWgvVXdVM3hlOWU4Q0N3NEtU?=
 =?utf-8?B?SGRHYXZDRTcxZEREZUJTS2piWmpCMW9PZmFERHVKcVlKNHdsWmYrU01XS1Fm?=
 =?utf-8?B?dVd6NDdhN0tkS2hRVW1XZmsvSENYVVUwc3E4MFpGWjRoRitqaDhiSS81c1pM?=
 =?utf-8?B?bFBRWGdkS2Y3Y1BqbVorNzlkak1ZT0NEUGRpV2hhdEVpdXd5bFcrRWQ4TjRr?=
 =?utf-8?B?bERDZG4rWDNPaWpmbkErMm9VaDJGN28ySll6WU1EWTNIVHh0aUpIaFBhcUxt?=
 =?utf-8?B?Z2poaUNFd0l0eGZQb201dmh4blBvVGVGV3ZRbE5DV0pXSW02MTNPZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6827353d-b4f4-405f-9fe8-08da1b8150d9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 06:05:45.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wfyIIXh70Gh8U446f2AENCa4mXXShOVKPprSu+YvfN4T6nH+1y3/2atK/rjVujquWb8XtF/Vm/+TCKHxgOaBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2022 7:48 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 06.04.2022 08:24, Ashish Mhetre пишет:
>> +     num_dt_channels = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
>> +                                                       reg_cells * sizeof(u32));
>> +     /*
>> +      * On tegra186 onwards, memory controller support multiple channels.
>> +      * Apart from regular memory controller channels, there is one broadcast
>> +      * channel and one for stream-id registers.
>> +      */
>> +     if (num_dt_channels < mc->soc->num_channels + 2) {
>> +             dev_warn(&pdev->dev, "MC channels are missing, please update memory controller DT node with MC channels\n");
>> +             return 0;
>> +     }
>> +
>> +     mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "mc-broadcast");
>> +     if (IS_ERR(mc->bcast_ch_regs))
>> +             return PTR_ERR(mc->bcast_ch_regs);
> 
> Looks to me that you don't need to use of_property_count_elems_of_size()
> and could only check the "mc-broadcast" presence to decide whether this
> is an older DT.
> 
Now that we are using reg-names in new DT, yes it'd be fine to just
check mc-broadcast to decide it's a new or old DT.

> mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev,
> "broadcast");
> if (IS_ERR(mc->bcast_ch_regs)) {
>          dev_warn(&pdev->dev, "Broadcast channel is missing, please update your
> device-tree\n");
>          return PTR_ERR(mc->bcast_ch_regs);
> }

return 0;

to avoid DT ABI break, right?
