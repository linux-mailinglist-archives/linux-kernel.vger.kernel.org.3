Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0583755FF16
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiF2Lyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiF2Lyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:54:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E61B387B1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8K8RAy7yyZEp+wPkgvDbiPJ1HuHDt27pep0DSJmu/SGUxiVgucaczX+482zi6it/qSdfMP4aiv3UuOr5v4LxnO+ov5K7Qc8IqBy+jEeom08P0USeOTxD9EysWIUrz+KTzfyr3LTAe6mdG0ASlAicjV1D2T+HoSgVVWQ4w83SDGUJSoBvq8tJjWZz5b3BNH8GtSA3ohAFEzgEvzHZjmv/WpXMoTqP1vTpz8kqBjbjB0gZMtrweqiDHrlZ9JKK/CRaHwba/P904H8IOESHjUA3memhp8P62JxAMzJKfKriqQN041Mnb+XrYmx3t9O8AqBV7svIru3ZQI3B2a9dGEaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V5VFGP+nUGdXlM3EpyXG8G+ZHa+lExg7VpqCYnDasc=;
 b=DgTPMS3X76daD6RdqxRxou9RtGD1dCg8gMq0GEZhmcHVlddLIJ4qyoZxjfxqyDo5MVRSTsQQ5MOxb/kqZvWHP1VHLJxkKO9lb52DQb2uxxmwMVi4qCqaPM4OEZkL2DZgoPH7U2w0QH4n0GFaPcOEh8e5eY/YVxB8VnnXnUssPC63HQ8QXEWllzPoEDswHsWgO6pHkiA5Z+uEvfbygPxn+/yywmI8DwQpR2nPDTB/K0sV4dst5KLTxvrO84Cgw/dlpWTicpCL4IWs/Ly7qsBiqYMhpl9MTI+Qtw3PibOKIrNzUhzzDYx/vf6MQ7PzjqjSnWUlh6mBG33MIDooi/m4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V5VFGP+nUGdXlM3EpyXG8G+ZHa+lExg7VpqCYnDasc=;
 b=B5RogteyAe3a30Da3nHSzHP0bcqSW3Q82Z+fdc/0fE0fDU2VDI3TYgP0bL47Mtoky/YD7MmWsmfmKRrG94QR8PasA4BHGbBKKjq6TEgHwpinM1PUC4Wfs02H1K0W//RpIq9UXiP487/eaCqz2aAj3iyhPSqX/GLJtMGdx8ZS018=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Wed, 29 Jun 2022 11:54:42 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594%9]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 11:54:42 +0000
Message-ID: <f21aeb41-1648-24b8-01a5-143b6c99960d@amd.com>
Date:   Wed, 29 Jun 2022 18:54:34 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 7/7] iommu/amd: Do not support IOMMUv2 APIs when SNP is
 enabled
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, ashish.kalra@amd.com, vasant.hegde@amd.com,
        thomas.lendacky@amd.com
References: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
 <20220622171131.11870-8-suravee.suthikulpanit@amd.com>
 <YrQjHYsEIGN0mtO2@8bytes.org>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <YrQjHYsEIGN0mtO2@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:3:18::24) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8256c88-d2b7-4880-ec9f-08da59c626f3
X-MS-TrafficTypeDiagnostic: CY5PR12MB6156:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWqtYPinHvQ/J5hk7pAIxbAEXqIAi+OHVpoA2CDeGb8mZ/PiT5XJc1FhE0Trs/1GBPNYjE0z5PYp5bbBwGjAyjzXyOTBh8yIqh5ptyngvJHgHz5LFivlXUR9jRg3DEiIdRikgUHc7nbKn/7AR6jBdV9gl7pyNJhTHpaO/v0jMA6rcJqgAqRmZ1WX4FsEu46pOPENKqWKEQy2+8PRq+0no16BjBsf69+GycC17SNVQrXbJOu7WHtj5jMzMXEPjejFQBpC1U2aLad9GTxMoKk4tGfOPiAP2ip5C58nlbiKPNrVJh7C8cH8pVnqixidVELvkpvyuHhjZGsW1oRaa2O1qIM5UWJb1fYnusc7ZShGOC6lszYoUx7xFDE/3eLuvRW0x6n5+f/B2PxPeN+jDqTHCZ+Pc+pwZoQ63LDX7N9BRMW7JTy7LOKkOWFXaP9wibpaLx8h6fNOwuRpoLtVJ0e3/ViIko7OSzdrw9pV+vMMnbq444m6403tbhMpHecVAnfmK1KQ2Yyv2caqi/3GEL7PS3b1xcRrS785wKvwEb60KMXXOFLC415gp71vlM9UfPMAOdP1qEyvUAdymeUv90wJCGEEBSQx4H/yu8llXLW5yYkCurv1Vl/8Nv/vvdAHWOfAHjA8Jo3WS3/4EU1NhdKRNio9B7fF46wrS6JyscBlASH1ls47IohW4qcNiUsG3o14CA5TU+eqN3+wO1hOKn+SAzXS3TiTzeMw15JQj82fP3Ca+o24PVSqP9lqTaDxwMS5qJEcNzc0sBpeJLPv7oyArL3fQnoCqphInavmJr+evzUuvT1XtfdUZfcawY7Dr3L/zN6JRDKcMXPU1oNdFg+wwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(186003)(6666004)(36756003)(86362001)(6916009)(6506007)(2616005)(31686004)(6512007)(38100700002)(66556008)(6486002)(8676002)(2906002)(316002)(41300700001)(5660300002)(66476007)(66946007)(26005)(4326008)(31696002)(53546011)(478600001)(8936002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNlNUQ1ckJiSDZWT0tGdEpDZVlMclN6N1NjOWNtY2hPcGE5enFoUTF5UFpL?=
 =?utf-8?B?YkFEazlqWHNEZE5aaWhjTUttVDg4Y3RCWmp1UlF0QURwV2ZUTjJFZEt0bTRC?=
 =?utf-8?B?MzQyRG9JVlVaUDd3K3NTWVNab05ON1FFcVBZT2dEaE5nNVI4VTZCekhjQzJC?=
 =?utf-8?B?RjFhS01KZzFkUmo5bWRPNjJJb2dFZFEvVk1qaHA3TXYwQzZDRDNBVlIyUjJm?=
 =?utf-8?B?Y2VwU3VENnQ4UjQvMWRPM1VLTjRrNGhRSUVpVTN2bXExblZZUTVEUnY1TGlE?=
 =?utf-8?B?eHc4ajh6TUo2amM3ajV3eU5qeXNtYTcwSGZYVWRxSU1EVzlqSURQMEk3Z1BD?=
 =?utf-8?B?WXBKczA4WU82dzZ6aXFRZ0c1ZXY3MU5BNCs1ekhTeUpXRUh6c0U3QlZjZTU1?=
 =?utf-8?B?Ujg3YWlmRm5RZlRUbnNHMGU1TjMxQlphMG5QTG1VNXJpekRXS1diamQybU0r?=
 =?utf-8?B?R3J1WTEzdk5iTC85QUMrTm50U0hRV25lMEd3MXBwVEVOZ3BTNVVYNUYzODFG?=
 =?utf-8?B?RC9sZGFxT1FveEZFNmpwakIxcHl6aThUL1RRbjhGZkRtNFFaOE9yNUVndVNQ?=
 =?utf-8?B?YU82YkRlNnJLckdQdXkxQzdLV2xPMnZ4ZzYzVjByc3Z6VE90eE9vUWovUGxy?=
 =?utf-8?B?SVFYa0orSjc5Yzk2c0pZSDlnWjV2YTk2cWRWMDM1MkJxam9jTFVDOGVDcmNo?=
 =?utf-8?B?RFZBelRrUnkrZ2FGU0krSFpEcnEvNzZSWC9ESDBaaGlyOFNuNjNFUFhHOFU5?=
 =?utf-8?B?STQ4aHBKcGk2SmV3RHZkcXB6cytXaGZibmdvUWZ5R1U2clc2VUZQcmw3QVgw?=
 =?utf-8?B?Q1NhSmgvazg5SDF0UUd5c0RCWWFwSXVQWGtlMDFPeHErS1ZldTY5UnpFOGRp?=
 =?utf-8?B?dHBLc1lCV3dOUG9FZ1RXUVVSK2dlLzNtOGgrT0RzKzNmUE4rZmhhU3g0MVBN?=
 =?utf-8?B?TnFZTlZJZVBlODNKbC9qeXNVdUVVTytnL3FNQi93ODlURjFiY1N3QkpiREVv?=
 =?utf-8?B?UkU3akYrQ1hoTXhNa0JIY1hydWlhMldJVkRubjRRcGpEMC95QUR6TlUyNkxs?=
 =?utf-8?B?blRBVnU5OFBydjJnQ2FsM0V0cmxUTWl4NW95TUtXb2QyL0QwU1ZvT1Bpa2lk?=
 =?utf-8?B?eWpjaTNvNkZCb2Y1a2tJYlRVREN4c0hBZGhCR01NMU1zdTJURklSbDZCQnBS?=
 =?utf-8?B?Y3FzdXE2YjlEU0tGZWx4eWRqZDhJdXQxdTd4Q01GWFU3Rm9ieXU3ZnVNNUYr?=
 =?utf-8?B?UEdyWndaZVloblN5ekxVTVJ1aU4wQUFlZEw2NC9UdmRmY1o1SnAvbkJnRnhn?=
 =?utf-8?B?Nm4zWWlXczExQVoxTnBZZndNV0k2NzBtZytBQUF2ZEE4WjI2NEZmNGlyVDE2?=
 =?utf-8?B?UDdPcEFvUzNuOUtBWWFSZC9zT2xPeWNEY01UT0JlM3NRYmZXTkRkbTdtWmdW?=
 =?utf-8?B?S0d5aWhXaEcvUXVHZ1ExdjR5S3JCOEIwclNzb09sdU9xTUhBY2IxS3NWNWth?=
 =?utf-8?B?ZzBKNFA4d1hDcmpSWm1yTFhXRjBvTktQR2ZjTGlPK2NyRWpNMkcwZlB2UzUv?=
 =?utf-8?B?cFIxeGlBNmt6YTFFTmV2a0F0c0h3VHRNbDducEs2SEhGcURPcWp1MzRsTjFw?=
 =?utf-8?B?cnRRZ1d6dXRMazZGTWdTb1F4TXlDcHl3UVBZK0czWVRhRGNBUHBtcHM0RUJH?=
 =?utf-8?B?NmQ0czF0T2Y2TjdyOStuVFFJRHUwaXUzVFY1MjNXTTV0ZlR5SHA0V1FCSGFG?=
 =?utf-8?B?TXVpam9wNC9yeFpuS003b0lzTHdpa1JOUW5YVHZkYk9sT0RidzBuaWVvblBG?=
 =?utf-8?B?RUZNdVpTYmthTUExRmJPRDU2Z3ZYQ3EvNmxJV01uODBpWks2TTlCREkvQ2pI?=
 =?utf-8?B?V0x0Wkl2Sm0rR00wdWZxT1l3Ui81NmFEOFFqNmpuQTkzSEVnVWFPQkVJUTJN?=
 =?utf-8?B?VG9YYlhCNklBemduREUrWllZNWtxV2RqWHZ0WHdjZDlIWkNpZGNrV2lPaUZ3?=
 =?utf-8?B?R0tnV1F6bzNVS2NYb0tqaFl3WS9JbGRyRlJTNWs3M2JFM3hNbDJMZWpkaEdr?=
 =?utf-8?B?cUFBellnV0k0SzJ1QlZqaGcxK3RRUFc0NnkwS2o1Rnhqbkc3WDBtMTJPR3BV?=
 =?utf-8?Q?CrXlv++t4jN76JnRAEy5qyycH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8256c88-d2b7-4880-ec9f-08da59c626f3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 11:54:42.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZW7wa432bn4p5nBOhI9ze4rQZsBMh/XCcln1yPnsGGng6DyRG0bbVZCCU8hI/mkpSzggFdwxVdt19SiLPRgJyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/2022 3:23 PM, Joerg Roedel wrote:
> On Wed, Jun 22, 2022 at 12:11:31PM -0500, Suravee Suthikulpanit wrote:
>>   bool amd_iommu_v2_supported(void)
>>   {
>> -	return amd_iommu_v2_present;
>> +	/*
>> +	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system
>> +	 * (i.e. EFR[SNPSup]=1), IOMMUv2 page table cannot be used without
>> +	 * setting up IOMMUv1 page table.
>> +	 */
>> +	return amd_iommu_v2_present && !amd_iommu_snp_en;
> 
> IOMMU_v2 APIs could actually be supported with GIOV and IOMMUv2
> page-tables in-use, no?
> 
We can support IOMMUv2 iff the v1 table is also setup (i.e. DTE[Mode] != 0).
Currently w/ IOMMU_v2 APIs, the IOMMU sets the mode to zero. Therefore, we
cannot support this use case.

Best Regards,
Suravee

