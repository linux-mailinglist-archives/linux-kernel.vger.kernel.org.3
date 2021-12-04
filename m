Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86C646834A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 09:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355086AbhLDIFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 03:05:13 -0500
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:14432
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343993AbhLDIFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 03:05:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hhl3+gWhDRjY9Xa/gg9/7PmvB8KLbNqNcQYy0jddYW1OSRAMo8H0HZ3qK0p9m0LyYPdxBiOvnwxqas6tbnDDqE08v35kotMm+n6CwZF+1BqmEcrutX0JPnS6wyB0jwWqqsMj+hDPiVe0XWlBz62cc8XJKRXktVcFJacp/FA21arG9R+Cy83M2M+eFDSjt215fpTwKc0NDB5NxbPEAs84XZju+lxHw5fdLoad1qrOlNLfdzXIER8PgXjrN8TwDYk4WoON3EMUwGpxOFk8okpRcT+LCN7HjM4zLGiXrw1YlrSPl3Z2gnAqBYp3vT7WkhR3D5Sb4fZkUHMjKf0Ki2ZxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eb6sYAeyHBOaddgPkMs/BHOz2XS+iAXQPVDAttBgkZU=;
 b=HC8qwindWd86aaL9nTrJOPtNJCbWzc6Y4+FOolI2e4m4EtMjXxux44IyU8qgJmTqN4jybnodzjo3EAQ6Sea0OYHqX26eGWWCcEkMTNnNOiX0hnpKUXExfpuJDjnNx29DDy0zRTjj4t7hYrMFYADAR9+ypbboeAqPj4ySVhSNQ0dJE08/EfWaUWOYRj2KLzDG4q/sGRrOLD8ygq+66HGRrbYcpmcWd6yDqOVSQU/6YHcyLx8mqfOxPoX5yl4neCsaKeRZF/gihWucUyGnGhTz8TpUKVAymNpCr01qKvNTOZXevpyRsOs8u6l3QspYjefRpBuuLrbe9ngT7m+JCDpuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eb6sYAeyHBOaddgPkMs/BHOz2XS+iAXQPVDAttBgkZU=;
 b=h1LPz7TsN1q+7pD0SKXpo50nhoKCv6UfUL87DqcWuWFTAFRaAj18UPLnbfe++mUjoJEfdVn+rcEAU286w3Uh+dbaw2wf9MbF0lVZn+ikHA2OC9ZADrUejTa/os+1eXkApIGSlrcOuhV5JoFtuYwcRyJ03XPw7N3B9EADA0wzYTXGwzOAOwrpTYUbfS9LbSov13+oLExzG/V3cPaVGoyMOGncgUjWQI5klaEfI8o2s6+6p2caJ1vlHuVMippQnO5Fu60EPGpR4/XpGFdC4HG9m2U+BHSR4Pr1cf13Cutobi4aheWsXQH747Qk6T0CWtchs3oKIRdrbQehG9l7xEoc2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.24; Sat, 4 Dec 2021 08:01:43 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0%4]) with mapi id 15.20.4734.028; Sat, 4 Dec 2021
 08:01:43 +0000
Subject: Re: [PATCH V1] firmware: tegra: fix error application of sizeof to
 pointer
To:     Thierry Reding <thierry.reding@gmail.com>, cgel.zte@gmail.com
Cc:     arnd@arndb.de, lv.ruyi@zte.com.cn, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
References: <20211009085900.509697-1-lv.ruyi@zte.com.cn>
 <YW1/X73f99H6g5sY@orome.fritz.box>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bc1b1099-3365-db6a-5864-0365235f28c3@nvidia.com>
Date:   Sat, 4 Dec 2021 08:01:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YW1/X73f99H6g5sY@orome.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0483.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::8) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
Received: from [IPv6:2a00:23c7:b086:2f00:a6a:195e:fabb:8e5a] (2a00:23c7:b086:2f00:a6a:195e:fabb:8e5a) by LO2P265CA0483.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Sat, 4 Dec 2021 08:01:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bea2f6c5-014f-4da9-16c3-08d9b6fc4fa5
X-MS-TrafficTypeDiagnostic: CO6PR12MB5460:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5460325B77165D661721FD75D96B9@CO6PR12MB5460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ToCwUufuZMeBz+AAHMc4dS9QvGa47xhaSsU3QMPSPPqyo+d+CZEfxG233kQ4kD3YMx0tCdMlps83OkzNMr/d9ppxkC0VtV9DpUxsNeb5wgYC8YJg4GyR2uKwivmKlVKU6O0dO29hlmhYRa7QUp4QpcraGy7UCQUEh5CK6ZawDmNQ3Uw5Txm62nbsk1iSMhq+DA0CIwKdhOvCam/icYeTGT6PlwWVZnUbmLY/vvKQDwwGCYAYSPX8wJ1XGGsMcJ2/rCL/kXzAa8QYTrXbr7QTqN6h2Qg14xY0Nd3jtZEFaJETB0NMDwbRlo2+j8QlAMZb7s7cfVlktZmEGw4uHp89+j4kY+lbXFdW24DzKa4AJQvhuD7TgzBt00MD/KF62+o43VDlhbnMBtHSwq+mzJmgd0/ExKDQ48m0UB8X3a9ssfJPgL/ol9GwOwzboYQhvy0dCNmZw7JgM2sFpoxCokGlqxSvstmLMZK36m2pK9qfasaKR8//Kmqq9HLGzdGaZDDXndsdyRcaUS30D5gSBI0PuewA3Jg7pynLzFs6EUU2zI9omiDwMqH5Kfw3Lz6eBKeKBYxjPaPt7s3X8EP9d/+KjVwkWwI+HxTqgP7qTJcwtN0Le16BLE6Wh0eFmaJc872IqoJCMc3lrRaXtprxv12kMWBj427Ql1lvDcwP7hp5hNjvTLLsvHHAh4oeLkxbdO/tSU28zTuRHlYG/285q5zKrIKbNfTm2RAyuz2SgsLtvWdI9a7DznTN8gBav9mjrgAV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(5660300002)(4326008)(66946007)(4744005)(66476007)(508600001)(186003)(53546011)(6666004)(2616005)(66556008)(8676002)(86362001)(83380400001)(2906002)(31686004)(6486002)(8936002)(36756003)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?gkrlsEp7lk8avoEfLwWX5JQsHWwLBCjf+klDj+9vwLXQnapp5Rkxkq3Z?=
 =?Windows-1252?Q?FAFsm+UsuGUxnML8Bhsx5c/1qVdNTCPWFGZoj3EQ8sM/6wiIX7iavTak?=
 =?Windows-1252?Q?6RbN0ecFfxlqwtaPNg/tsrWEUS7WtdQR9MlfqD0wv/y9INWiVS5Gi89f?=
 =?Windows-1252?Q?KbgbDJrmutQSkdOSIuqX8SIUHqZCV/CQ0IupAhtH9uCcQ7Ltq6fVW/vo?=
 =?Windows-1252?Q?BmVVxpdxfXpn/bTB+ripJZ3qk7ZvfSsNFgSVKSCGanUy8ZUSzkiI/Ecw?=
 =?Windows-1252?Q?yofOQWL3CL07URSBB+MQGlAECDKg5ijjGExatPNXnfsIyA++tx+g9me2?=
 =?Windows-1252?Q?0Kv/Wz7z/BwHrISeeqjWV30ghkHYBHAXz6viR+4BdK3SFa3A7TehybCT?=
 =?Windows-1252?Q?4OCoYlkMbU9OQQ6QHl8xJzDrUAARS/f/Gcaqb5CEqGNnBLOi2ibyrq21?=
 =?Windows-1252?Q?bCoY3HiXfZBh71kg15pVRgGBJ7EEbGiQ1YuvnF3i2Um2iuU9Gh+8OU9j?=
 =?Windows-1252?Q?zeJ3IglTiAMdFiu4QScsKaj26AzG+aUCc0CFh1IYAtJpVStTuBcGnf26?=
 =?Windows-1252?Q?do2L6Q57iOTDdKqrm5/Wzt+8t5IhUWB63j5d7o2MrGU/OV4zQfhHQxo0?=
 =?Windows-1252?Q?Aa0SSByg5Spj42oB00RQov1LkvNPyJDdTlHWiOwZKjpk+2tO0Pw5UuOA?=
 =?Windows-1252?Q?WwfwktE74zb1Hc69DHw7XTbZgiIaVBrbzCyXgsg6Er21iwrTt5wB3c8x?=
 =?Windows-1252?Q?h5bljh7IAUHbGA26EefDLJwctXHsZqnVSN5rUnk+dioO0UhI7/xoENL6?=
 =?Windows-1252?Q?8cM02QbNxkWHMZJpVPtnXMKyTuiu3J1Yw+xTnX7TKl+DYPdurjaBZ7r5?=
 =?Windows-1252?Q?lhGGmQfqxJAf6dJqEyaTYPj7tNNbKkMHfDuQ2MPDOaEHJ4gAEbsBya/f?=
 =?Windows-1252?Q?brhqP8aACsHJPZLWPiULiEOD0AlCgotLNHJv+b0S/FbvuGWnwerngXgw?=
 =?Windows-1252?Q?EtK5YcCzNbpcYcSTBdkCj9xq2OcrQNLSLyvZQiYZsCc8WZhmCRyN+Q2i?=
 =?Windows-1252?Q?J14ZkHpMve/VUEvGsiMVzQMQQwifj/nS+QT9j3l9G6xYarUXae0/sHKp?=
 =?Windows-1252?Q?0xjru1hXJsflyz9EKrtHWlNkTaO5puLDXT4IY/s3lKjyX4o6mfLIUblf?=
 =?Windows-1252?Q?sjfE03fC6tq/LhsivWUakGla6/SJKkigsiuZWcUPivzK7L9TGTjXgTl/?=
 =?Windows-1252?Q?rt9NXIYDh/Hn1IU967WzQPhXCcwuAlxl9G1nl6TqDv5aX8pL01isKWqG?=
 =?Windows-1252?Q?7uR5WtD3XC/4RVxcF0KxnfVvEGTMHuPJRn+gurJsY2aHYmiksBkWINPr?=
 =?Windows-1252?Q?/mT7ieacH75VYSY7TQjj6qiu4uNSDsJTJhLuVtbg1SAC9EaOe++KN+7a?=
 =?Windows-1252?Q?3JXosA/TNALfyANeQU0Ho4Va5ldsiJFWIiY6gczk+jr41zV4MsqcCJo7?=
 =?Windows-1252?Q?hmZYePR8+tEt4n+9tORpn1bXQ7tyZPeogkEZ0rqPIoul/bN1BQA8EUgR?=
 =?Windows-1252?Q?xviKcOxZvuFLnWxLTEV88EYZoS9OTDX/wPpF0UhR/U6bTHCqlIFEYvdi?=
 =?Windows-1252?Q?ihVVVco/WEx6HtY0ba0+Zr3ibfVyanRRz9jorq8X/DCtr5pwl5QRSqWj?=
 =?Windows-1252?Q?GRl1hf1mK2KNU5nTfcabIOMuQH79vKsD8KAfv7uR84LP0krXY2uBtTRs?=
 =?Windows-1252?Q?tI5MlS24OHD3yhT1nu15QAFgcoFbtPMnMgzsd+meerg3xG4xOMkneRVW?=
 =?Windows-1252?Q?B/6U1NAsGCuNzt5RB61TNy0FOg0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea2f6c5-014f-4da9-16c3-08d9b6fc4fa5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 08:01:43.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAEcNtUrS4ZJpCpKAiVQBwR8xGbggA21jG25Dgbnfb7j8ORdxSC4uh9YNy1qNFchKzSx3hX2QbtI5g65P0GQXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On 18/10/2021 15:06, Thierry Reding wrote:
> On Sat, Oct 09, 2021 at 08:59:00AM +0000, cgel.zte@gmail.com wrote:
>> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>>
>> Application of sizeof to pointer yields the number of bytes of the pointer,
>> but it should use the length of buffer in the code.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
>> ---
>>   drivers/firmware/tegra/bpmp-debugfs.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Applied, thanks.


We need to apply this as a fix for v5.16. I am still seeing a failure 
for reading the BPMP debugfs on v5.16-rc3.

Jon

-- 
nvpublic
