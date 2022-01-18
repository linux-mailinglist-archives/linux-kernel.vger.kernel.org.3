Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ACF4921C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiARJCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:02:47 -0500
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com ([40.107.243.52]:64993
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232026AbiARJCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:02:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuQF4K6tiT64zo6xC2hmuOsZKhe5+TzUrUVztdizO/P7UdD/dQklY9Lr07nqOCoy0SGZ6C6tD/It/150CxXQn0s59It3dkfpWDsmFe+eZLRusNR51K/mUNktAhs0bhluYYVVH0J9rMzkwmxRZkrBlyQQvTx1n4Me4Xj0oEVuLh40oeSSavUw95CsHKpAlaYlxFKHk8jU5oXtmHuGZ51OWWUhHaVIL+1w2e5a41RVtumM3CZw/W7X2GzlTtkDyROt8m02A9FVS/Y1rIIQzOmMcr4wGUK6ygS3w9PSxga+7Zoqs/4VCkceZ+0HwXI/p7Kv9awYssu6S6PSmeO8iDx2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heXjkXTg7XaensTqUf9Oh9w/bX0oRUwQJwG88P4hnRw=;
 b=XpszoJhd38efNdlscHalT/jrrakMPTQkZYrjf4ca5SZXgdRRuxTnbelqBPKq+u985G/UYrmDsbqTnS3MVvi+6G9iEjAg8pSpgSDua1G5g8P0redFT3n8jB102wpPs8o/0KE+O9kHgEI/8pZ5ER0wEk+VSj9+dZqgXvoeNVUs6E03r5YISm/Nkg5ANiG5LueyOcfIw0LYZ1GWhbh2dKFhE11gCN9GNMIKqgFazTB2+jE0DfsthbgN1t7HzUgjMK6NYhWnwbFQbX4u4eySG03rcxQg6cGTpUZkqnGP22rJctnUNsLcCI4BMdEZODdpKj40bXrr4pvvU9sHYbDnXRoMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heXjkXTg7XaensTqUf9Oh9w/bX0oRUwQJwG88P4hnRw=;
 b=EBqecEOg0fYfy4c4yLwqqcGFuS/IUESgN7TAe3U55b1/HXvS3MnuttzVr6a/K3Kl3iXuZ1fJlL6EidGk8631jYMwBZ6DPWhVyYJlDo+PB62Z0IRIQ0DJAhedZc0GTlzaUWsqTyJnBIbVFKAa14v8RvLPL89+dBU3znvPzeMyhuYXlsLm6JhG1nMgJ7zB3q2ZUocTlwCmZKrZkhkotpcM2Wqlcc3Dmvzj7toMWaz2BDAiewyyWyPMaGRKKZ/7kZP3nalt+CVonFOPpbGrf0zhDfcHt68bgNodX4NRD2aA99cqxom3XYFnLsHcb6X97fBU2BaF09D40UNu2/x3p0YGIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL0PR12MB4850.namprd12.prod.outlook.com (2603:10b6:208:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 09:02:44 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e%8]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 09:02:43 +0000
Subject: Re: [PATCH V2] usb: common: ulpi: Fix crash in ulpi_match()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20220117150039.44058-1-jonathanh@nvidia.com>
 <YeWN1Hb0tpjDzn+C@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ae60ab9f-2fd7-b706-3584-ef8ab6bc39de@nvidia.com>
Date:   Tue, 18 Jan 2022 09:02:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YeWN1Hb0tpjDzn+C@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::15) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e88bedba-8325-4ff3-1e77-08d9da6149e4
X-MS-TrafficTypeDiagnostic: BL0PR12MB4850:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4850509365DF9CA6133CB8ADD9589@BL0PR12MB4850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vg0j8dHyPRJ7J2ArGgQGQSU99zOV49CpvqFri74Iy+qhCqufcIrNgIrNjYsEa1aEoLDKdEbUgrgD46MKY8qGJYIe0r39LThnzo77msasJC0HcE86tytX/leM8vwT0M5Q0IeQWsGB/srvg2pCVkNfTEvlREJtmKbCvPTgl6QneRONkByxnm/UXhG3pu54dHTA6dlq7CClzQQJRyhahPbiRl7FtZEC2n2KS4KB5u/cTXqTR7Dyc6W769FN36nTUwDcII6LmbfDgfHew8XLhU9DZ/DxD8B87kIHcJioRAz5yeqXw9O5AohgckHY7VyErSPzCN1Duz7erwW9INU3Pj+kI1z56Z+Znv9sDTJJZKqChkYDmW4TcLbH9HI/fEUnsJmkFIhKTPlmpu5sVtmtQM23kIYAbNDKA1csIYHxViSP/qXECckcxjjgsi8P97eafABKfOcVacaFp3zNKlNYA9wnVVbsSV9NOibLIS88L4RBh9gJ6hb/xztr343zudBHM04c+f7f98VWmTHX2c4cZWXxzNP5XdC5FAJN070BEHcBQhIAtBoq1ySFaZCxzhKSHXt7UiY+1dbvqF4LIT8ksTYN0z/GuAoQLpOg7zAAKtYyhUPbi7it/KOwT5lB7HG8OvuGzeNKM/WwL84PQAbajBpoZtosdLcPXmD4u7oTijanc4g0+neD0s4uHWKX5WcYOCs5p4XROICQVADXOW+c5wDxUg1HNno0pE2C6nPb3oPzkBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(26005)(508600001)(316002)(186003)(54906003)(6916009)(55236004)(86362001)(53546011)(6506007)(31696002)(6512007)(2616005)(2906002)(6486002)(5660300002)(8936002)(38100700002)(36756003)(66556008)(66476007)(6666004)(31686004)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEdsYi90czRTVEtHcTB4Zkd0MmN4QWE3UGgyT3pLMldWQXVOUUNXK3JnMmFF?=
 =?utf-8?B?UEc4UDEzOXVrME1JdDgyZWp3dFBKZVdHNkJuTWtPZ2tqNUJ0cTgwZlBNTi9m?=
 =?utf-8?B?WGNhR1grYkwxbm1qQUNtV1ZzOHlyYnlQQlFIWXVhR0gzVDV3ckYvNUVBQUpM?=
 =?utf-8?B?QmE2NU9oV0E0S1haRlJ0NWo2VTN5QmxJbzZFY1Zoc3kycXJFdzMveGxMUGRL?=
 =?utf-8?B?dDdXOTA2eE45UjNzQzFSVXl6R2Q5YlpiVytUd3VOWmtXTExyNlJ4aWFvbFFB?=
 =?utf-8?B?Qnl4T3A2QjJmNWNadEd0ZXZxSHZjdzZjMXo5U053K01DMkF5UHU2bVNwaEph?=
 =?utf-8?B?N1BydWtwMHM2UUprTnZhRDMvNHBSZWhpbWgzbkQzeDRQeGZ3RCtLRXVBdzIz?=
 =?utf-8?B?ZzYxK2JyMlFPaU03emU3WEdwaUpOR2wyNW1PSG4zSkpES2ZvSTMrNXliNTEx?=
 =?utf-8?B?THF2cDVuZW1UV1NZMVFwUjU1TFhhV1B0NXduZk44WkNaUEVRNmszYkZrT053?=
 =?utf-8?B?RlZFbDk5QitQTEtXUDZEMFlNSDVFaU8rc1JCSVNOOU1rSjFSNzFWOWlPL1o1?=
 =?utf-8?B?blZSMVNGN3hzNk5sQnlyV2ZkbGhHU1lPS3BwZmFzSWI1OWhPUkRRMXV5RVlv?=
 =?utf-8?B?T1ZaeUVESDJpa201eExlcXVLNGZhOHV0dWgwRW9iajBUNTJFWENwWmVRaUFL?=
 =?utf-8?B?eVd2VkI3RFREbmxuWXVrUHN1elBjZnBrY0tmeGNUV1BrellmMUsxbTRwVG5U?=
 =?utf-8?B?R1I0MXdjUEpReGtuQ3R6allDcGE0V2FEcjZFd1Y0YlFPcTVkNHNtenBjL3JK?=
 =?utf-8?B?bWJaa1RFbFgrdi9TWWJtQmplejVibmdLckl3S29Sb2ptTXpCb0FWcy8xTzlW?=
 =?utf-8?B?SXNQNEtpb3AxYjFLS1o3WkI2NGZlVzJadXVicTkzSXN3aUhsTjZTNWRyVjYw?=
 =?utf-8?B?SWxDZThjcGJ5QkszTDRmZnJtYnh4ZGltMTRySC9nYStzSy9OM2NhTUh5a1h1?=
 =?utf-8?B?N0xhdTZtVWdyQ2JqM1ZXSWMxczFrR3A2bTl3UDVZUmZQUUh6cGw3U0JJTG5O?=
 =?utf-8?B?YkV5U1hNR0daazNUT04rbjhBSzNqK2tFOFh3USt3cDJEUWplUlNKQUtlVUps?=
 =?utf-8?B?N2NTT0VMbGI0OFFtOHFKWGFmSG9zMWRqVFpaUGNZNUNFNFNVS25POGNtaXdJ?=
 =?utf-8?B?WnZJd1YrM2ZwTmlKYXlobFViT2RCNk1Ld0wxVG9sdVBwUFUyV3RSQkFEUlFU?=
 =?utf-8?B?ejhURU52N2xWQjYrQlV2Rk1pQ0RrSmNhQUNJNFowbGFOMTVFZEVQSmx2YjZy?=
 =?utf-8?B?dXNiaGJuSDdhaktOMnEzQUgySThRUzlISVc0WjBYRmZaK0xKRFlMNEI2YVVJ?=
 =?utf-8?B?Yjl3VlNPYXdnSFhYTG5kQTlNZVhlbWJyVHBra1JLaDNVc0pGSXVHVTZDUUZy?=
 =?utf-8?B?WnJaZjVicll1UGtScWdPN3pIWWJTY3c5b3Ntc2lPdFJhMVVDYyt3QkVnR2tj?=
 =?utf-8?B?d05FS1EwUzFHRVZObExWcUxTODFTNGNGQlN0UVZBbEVVeEZDOEw3WjFxVFV3?=
 =?utf-8?B?SFFrKzQ2V1I2RmJrS1Y0ODZyWHdoeituZFY4YkxXcC9JNEFBQzNGd0Q4YkRD?=
 =?utf-8?B?R1VmSllxYUJ5VWlxQVdtMTVFcExSRVl0Z0x3WG41NHpISXNYZmJuVElxQlFN?=
 =?utf-8?B?dWFUays1cHEwMGI2TytJdXFsaDc2czFtNi8xU2h3ZzFMTHZROHJpZUxNUXBB?=
 =?utf-8?B?cTVWYmVSZC9wSHA2anVqQTdocWdoZFpjMkV2TjJmZlJ5RGhFMGZ5WlJydVNn?=
 =?utf-8?B?aDQ3eVVUV0dubktWcXJWUUkvTlJrRmoweWtRZ2ZmS1NsWS9kZTVZYTZMYnRo?=
 =?utf-8?B?SzQ0TGltaW1lUkJxRlF5THVwdk9Nam1VRXkxaFRBTXlLSmZjMDdBWjBHY0ha?=
 =?utf-8?B?SWdlb0hGZ2lEMDBGSVA1c3RGM3JYclhkR0crd3F2VDBQbzJENzFYb25uU28r?=
 =?utf-8?B?bTZISWxNbVM4OHRyemZlZTZJU1VuZFFlSG5rdG8ydkpHTk9hOVloU01pU1h3?=
 =?utf-8?B?OGVQSlZpdUpGR0ZZbHNHSjhlQ0tEMG5kamNVYUNHd2ZWOWNVZjRXVEZla3dE?=
 =?utf-8?B?SndqTExSeWtubEJTSEFMbkNyRzBmcEVLUkZ5em5LRkV5anVXdm05V0NzS0E5?=
 =?utf-8?Q?NN4VRGx/jQjjeXOrXM2zUlo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88bedba-8325-4ff3-1e77-08d9da6149e4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 09:02:43.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YOnyVi8MnX8WahiF2b2R9F3fO9lqRSABIiBUtGhhr4ei7v1TOJmYp1uwS9Xs3fuitt8bc6FQvaFMy27hJTG2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4850
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/01/2022 15:40, Greg KH wrote:
> On Mon, Jan 17, 2022 at 03:00:39PM +0000, Jon Hunter wrote:
>> Commit 7495af930835 ("ARM: multi_v7_defconfig: Enable drivers for
>> DragonBoard 410c") enables the CONFIG_PHY_QCOM_USB_HS for the ARM
>> multi_v7_defconfig. Enabling this Kconfig is causing the kernel to crash
>> on the Tegra20 Ventana platform in the ulpi_match() function.
>>
>> The Qualcomm USB HS PHY driver that is enabled by CONFIG_PHY_QCOM_USB_HS,
>> registers a ulpi_driver but this driver does not provide an 'id_table',
>> so when ulpi_match() is called on the Tegra20 Ventana platform, it
>> crashes when attempting to deference the id_table pointer which is not
>> valid. The Qualcomm USB HS PHY driver uses device-tree for matching the
>> ULPI driver with the device and so fix this crash by using device-tree
>> for matching if the id_table is not valid.
>>
>> Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> No cc: of stable since this is a bug going back to 4.11?


Yes good point.

Heikki, let me know if you want me to resend or if you can add the 
stable tag?

Cheers
Jon

-- 
nvpublic
