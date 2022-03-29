Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0466C4EB622
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiC2WkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiC2WkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:40:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155CB54F96;
        Tue, 29 Mar 2022 15:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Acc3sfffs4i67Qx9Y2T7XGDwSb8n3zrl8iwDl/ZNf66vCDNfoJa8cat7JKEOSMWGXkul1rhD34xArK3NQXRxRAJxDoNpn0l4V8nhAzidI7ClS0yEsnfiLfqbmA/8iYR7w9iccej6WRgRAHRg9KMk8efnK3BVSzsMTqKIh8wgqPjppHHITQZr3GP24jX4AjnAbX7ZQYpH9oP53rlsp9mwtvsrdzezwLPgiQwmzww+fE2gpGPUJh7tqwmMJUoEtdxranR1LbcQt92LryCdoJZN35MD+xGduGmmFU/kLIgH1uydA258FGtyWiJNb7N8Z7UxTDTJQv2WU8QST8bDOX/cRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r436ABFRBmYx5H2l0NL/+uTqFpn5mY4gpIkMnvulqec=;
 b=eX2BIj6jqkqiY1iVOLqF0NRmP2vWTiO/MRL4l69jveX2LxQiID7Q2z+dRiqemgnR12FTZRRXpgGQcGKN95hB8cPSM2DXG+ilWwHswR1K52eAWDBkGIUhdgmT/D31yq9voAD2126qikVl0u7MWCxuLBDzCXMKUAvRhiTZcjKJhXQSXtSI82xDQkbRnT8oDGs0rO2Bc581wtBnz2m3CzXh2D2z8N1bzy8/2xFAPNo7UQyu5xQ/H4Pe8K8yAEswd4DmaYsoeoDbdtHxu2MD1XuXBO5+LtfeKypIVKAkLJopiZhm3gu1rUzmMIee7ay7tBEMJLhomtU65YPL3CvBWiQu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r436ABFRBmYx5H2l0NL/+uTqFpn5mY4gpIkMnvulqec=;
 b=qLhAp/w4SV1bwYWiMW3uBh+tYUaLkt3gdfJUSbIK/vdskwZMp0NP37MSpbhLcpYh0NTwYeW/JNNhX1isfq0XKrblz96CXSs9g/f22RZvpo+WODSZ4xPosipYIbQOCAWqXeFhqOb7EGyYmqgq4XIouBiQtOzN3cuccZjqVhVPI65ruMhNisNgMQCD8CziIM4gzA6/cyek9DYr8yAHTPDNw2/FOfVxk+0MiOppJT6iAjdAgIF5fDOOVaEJY7AYbxJUKeUrQVjDZG50Lp0P5TSF/AuNpYcLmXBT53bAt+u/Y0dx+PmfkTIlSSuccW9hhtZ/pM9vs47zu56u9ZCThpOpSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DM5PR1201MB0169.namprd12.prod.outlook.com (2603:10b6:4:55::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 22:38:24 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::8940:4e31:b98a:c02b]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::8940:4e31:b98a:c02b%6]) with mapi id 15.20.5123.019; Tue, 29 Mar 2022
 22:38:24 +0000
Message-ID: <954bbab1-65c9-e909-d41a-e730433a73c4@nvidia.com>
Date:   Tue, 29 Mar 2022 15:38:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 01/11] Documentation: Add HTE subsystem guide
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, smangipudi@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, warthog618@gmail.com,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org
References: <20220329054521.14420-1-dipenp@nvidia.com>
 <20220329054521.14420-2-dipenp@nvidia.com>
 <db81d120-039d-f49f-9a48-c91e96777a61@gmail.com>
 <875ynw7p9x.fsf@meer.lwn.net>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <875ynw7p9x.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83f05799-f8b1-4600-da31-08da11d4d567
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0169:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0169290400F59B1E37B45626AE1E9@DM5PR1201MB0169.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAs2e6Hk7kUvrEjlkIwZr7WcOo1+bWvGZ1hKLeM+jDCeeEbWRzZESzhBCzLHP3b3/8PQVYQ96w/i7afdZ8zq/upi9sPQsKD2pB/9K62JxeoWyKths56lPbKqyJFjR29QSMzqjSibJaueqKbgguhCMcLaNDJ4drnnsGef+PSL6kwMkaTsjJbT4yB8SYBBVs8fpWL8aMzjhxUtaF9BGwo57zrr/Npy4fzWFGTQBSO6YgsB486HtBgCXUxgszySDZwstu89Dg9iTxWea4SmuFlyhnGYGJUAZjd2XrjqrTAVnf/DzQjSuUHUrEK3INlHHbdeAtYJnxfLDEe7rhXwB9cU0VqLFwtUcLxMZ5j+T/kY76Nka87+AHiOX6wCoGQI1VpQiBZ48So0oogrTSK2ss/3RZG3yBGEBCOE7lQQVxJ6a8nY9jtv/UTsGVbjUeC0wvfM0Xy09V0drMSCe6xd+t0+HoHgsRXKvPwTQ8eu4Sl13bgQ7cne9xmxPDXmqI9e91QAzcYrUYkcK9h3TQXpJoLEp7qRXa8BR7Nzgjocmc7OyKmwZj07JmF7nqqxlcUb/m4N93s4NlRmT0CWZCk7nPDN95+RdOVQMzIhNfJMCBoQ7/SN6KCrTQhAlxTD7uM4e1AGqRqtoiZJ9rOeA4vsUH7LArICjOHhevlRUhYbrZ6ENoaWpwjPij4aJChY+RV+IA0mYs6uvs445q9+Zd1iND2fCyTCxnjWbbuwJ57ci9GFpOvYXf7m9zeDwZQ37Wno8kq8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8676002)(508600001)(6506007)(36756003)(110136005)(86362001)(6486002)(316002)(66476007)(66556008)(31696002)(31686004)(53546011)(6512007)(66946007)(921005)(186003)(26005)(83380400001)(8936002)(5660300002)(7416002)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlVzVkxSNE5HSFZBQ2k5anpDejBEcW9nMjJZQkpsdGlmcEp4ZGRFUmxBb3hk?=
 =?utf-8?B?L3dTWjJSOVAxUXBvRS95RzIzUXBpTmI4L0Fhc2YxQ1VZYnhkeTRENjBaTUJN?=
 =?utf-8?B?NlpSZUNUUzNoNCtJVDA5RkJWL2R3UnZMRjdlWDJoRWtEVFVtM1ZBb1Z2QXR2?=
 =?utf-8?B?ZW1KajdoWTdLcXdxeVhSVEVpV1B2eWZPVUc5RmdieC9teWh3bnU5ZDBSZUQz?=
 =?utf-8?B?V2k1VHcxZmk0NGxtMDUyL2J6ZXZJNDRmSnJhUzlLcCtDeUpzUXdkUjZjODhD?=
 =?utf-8?B?Qm1ndUlpenNHeXBKMk8wejZJU2ZlUlE5cTM5NU84YlYvcTJaMUR4K2lDMzRK?=
 =?utf-8?B?M1FsamxuNlF1OVRkYzNiYUkxV3JENWRRYmJBKzN6MWUxUFVheDNnSUovWEFQ?=
 =?utf-8?B?Y3k3Z01UZ21GOU1hTHl3N0c1akV5eENTbi9ES3ZvbEs3Y2tXazhDeVBSTXdy?=
 =?utf-8?B?QUVlUy9UZE45TXg4N2k1RCtyK3lPMU9IbnZGOGtwcE5oM21SWFUyOTBwb0tT?=
 =?utf-8?B?c2RkZ2VVSTdTOGVENk1YSjBGcGNveGs4OEhiWjllbk11aUcwOEJ6c241Z2xC?=
 =?utf-8?B?R2JXamRoVXBiRXlkSFFMUmRPNVRCaFRBUFlTaVBZYkxzTTJCdHFQRmh1em93?=
 =?utf-8?B?bUhGVDBIbDdSMjNvNEdzTXdBTzdvUDZiZHZpazFRR3FyQVIvOUJSMDhSTWRV?=
 =?utf-8?B?Ky9BcmpIQWpZWEgwenZFKy9TbkVMUlh3a241eEl0Rk9IVXkzeWI3QkNjMWsy?=
 =?utf-8?B?R0FPWHQvcEcycStuYzllNUF1VkY3TllIWENhWkFGa09ZSXdkcURQRVM5dGcy?=
 =?utf-8?B?U2l1QTNpV214aktXWlMwQUdJZ0VIRTFnRE5mWGZsa1BNamFReHpTeVZPbzlx?=
 =?utf-8?B?VkdQNHVJdDNxRU1WdUx4eXFCbUlXUFdMQXJJbXA2K2MwZTBwY3V0L1Zhbzc1?=
 =?utf-8?B?NU9YOWx1cnNpUXRqVjVBRTQySHZKZWdLaVluRW5WWkJ2VVhnV3ROQUYyd1Q5?=
 =?utf-8?B?N1ppZk5qeS85U0J4bVFrNitVRktMaHdqWmJQZWFxWUpsR2FZbndYQUl1UUNx?=
 =?utf-8?B?S2thODJNNVpCK2ZQY28xTFNmN3VQU2ZZRUd6dHJaV1FsejVyM1VBME83c2hs?=
 =?utf-8?B?ODB4TE4zcVpFekpESStBVmRIWjVERVMzZElvblRjRnhNT01jTWhYZHVNcnlJ?=
 =?utf-8?B?NzNpQUtpQzMzanNYRGcySGo5Wm1BMzl1UDdEb2J3M3MrWGluQ2dkSEVvTDZW?=
 =?utf-8?B?SHNSSi9VZkR0dG15RlkzUHRSVjZvaTRxMThtZTNQMXhaeEo2NUNKMVRFQkZ5?=
 =?utf-8?B?N3J5MGdXcmt4cGw3dDRJZXU2MXRhS0JYM2ZPWHhUUGErR1lBWTFUSGdPcjBi?=
 =?utf-8?B?eWJHYmpxYUloZEJNajVwalBwS3ZaWm4xNHJ2ZWZ3ZmlZTDdwUVNWNTFtZ3hy?=
 =?utf-8?B?ZXFZa0liUlVCNk5WdzZ4R2VwVUtudSs4WGNJTk5IYnB2SzFJd1hFYjJTdVJo?=
 =?utf-8?B?MmNsM3BaZGlLcThqVlVOdjJFREpsMnIxcFpFU2gyZDc0YzZkK1lkUnFQL3dS?=
 =?utf-8?B?THpMTWY2N21CZ0FYZFViZTBndFBXQUNBUmxDa1c2ZDRVRkUrakNHeXExNUtW?=
 =?utf-8?B?bEYxSWRSUjRuVmNPS0EwekZGdHFvc2pjM1lod1pmS2M4LzNXTk9pY3czNytX?=
 =?utf-8?B?am5PMjczdmxRMnQxU3labmhnUThhRjBFVUhpMDF6Nkc3YkplWHZMaG9hS1lZ?=
 =?utf-8?B?d2UzMlEvN2Q1SnBFVlBmdUpQRnhOMjVTRm9rbytnRzJaa3BFbm5zVEVsU3lR?=
 =?utf-8?B?WkNxckRXeGs0NUFtNFRlYm5ZNUh3UUdwRGNqUHRadTl6TGJGWmpKTTljaXdT?=
 =?utf-8?B?bGc0eUI1TFdsL2p2dGJxL042RURSbWx3enpta05jNDJCZDNwL2FnNzZzaU1w?=
 =?utf-8?B?SFJic3hab1NZdVI5dVEzSVNlaE9Td2NOSGJHZE9WTjBxVGxwZG15MlkzZ0lx?=
 =?utf-8?B?ZWJFRzhUakZnMUg5Z0lFQkdhS2FmRnpLZGV3cHdBMndaaHZOZlliam4vODhG?=
 =?utf-8?B?Rys1THI0UG4xZVU5bTRlM3NpaGZGcGk4M1k5QzlTQkpJb2dtTmpUZjFIWlg4?=
 =?utf-8?B?QlA5OWh1NTVjSFp5c2gxa0pGSjJ1cmlFaWJLNlVYdkZtMHI4SEFRbE1yUFN1?=
 =?utf-8?B?dmp6Uk1qaE9Ca1hJaVFtVUVHVy9WaW5hQ3E5U3B2MlFTaGt4TmpvTEZCYVpO?=
 =?utf-8?B?V3o2RGcyVG1ocEdRaGNRK3Bub2lTQkhRMGNiTUxpeHY4bGVUNC9pdlNsZFZL?=
 =?utf-8?B?WTU5dHZ1ZFJPQXk2WThmMjhVV3daYkJFbHd2SUpYQmpMOXV6ZFJ2QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f05799-f8b1-4600-da31-08da11d4d567
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 22:38:23.9000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JV3nBkVPg+hD2HbvKv/wf6hyC2nwcD83hRW+SbboaIA/TOL6PwDSVACAP8fbYIcD3FN92OLtKRZ9F+Prv+gwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0169
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/29/22 8:27 AM, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>
>> On 29/03/22 12.45, Dipen Patel wrote:
>>> +============================================
>>> +The Linux Hardware Timestamping Engine (HTE)
>>> +============================================
>>> +
>>> +:Author: Dipen Patel
>>> +
>> Please learn how to convey semantics with rst format, see further comments
>> below.
> That is the Sphinx "field list" syntax; it's pretty heavily used
> throughout the kernel documentation and doesn't seem to merit that sort
> of response...?
>
> [...]
>
>>> +The struct hte_ts_data is used to pass timestamp details between the consumers
>>> +and the providers. It expresses timestamp data in nanoseconds in u64 data
>>> +type. For now all the HTE APIs using struct hte_ts_data require tsc to be in
>>> +nanoseconds. An example of the typical hte_ts_data data life cycle, for the
>>> +GPIO line is as follows::
>>> +
>> When we talk about name terms found in actual code (like keywords or variable
>> names), it is customary to enclose them inside inline code (for example,
>> ``struct what`` or ``u64 what``).
> It's also customary to minimize markup.  In the case of "struct
> whatever" the markup is actively harmful since it interferes with the
> automatic recognition and cross-referencing of the type.
I agree, I will keep only necessary reference in this section.
>
> jon
