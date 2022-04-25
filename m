Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA850DEB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbiDYLXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241748AbiDYLXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:23:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501BC13E36;
        Mon, 25 Apr 2022 04:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPAl6LdxtTEKI3WFS++egJusBbkXaii8IkLnZEOV1jGUZ86qirgDVnAjj2W2AbDbpSJsYBqqzT+2/7qDRE739avUmLpxxCy4AOTdN+dyyJTumX79/0C/khsf1KgiLBx42xoWvxFqLPYzOQFrqUqd7QNEgNb0/QYgjlaD+a/dq+oJFLc2r5xAHlVuMAg1m1hhzaw7OzTEtQB+nKLFLouaq0S8vfDWN2orWDSI3G1CLyIHqcA3q0b90pIew23OgeVFN9hGxMiV8SOZPvGSiDEnqTuHylTrIu3YRE9Nc7Uz57GiXiYjBgsViMTSa/L8w95XN2kdMES+yttpdNWobir2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5Rp1v1IocZCPs29O+2faMQ6BGtqzTGVvxpLCE1pwOQ=;
 b=B7wR6Vz3EyNG5aWYa8PvoywIHT6nrriULAfqSe259sOMNGfIx4ddHuXx4qEaSEMRHaEDD9T64AumPti6VLCZWNFSRJbjbCBcDk5IxErtF7ENqa/mz6URnWSFNmP4tNNH2KBgdP+vmyNv5KvNaNbj7NUPdsXROY4re0KN9x3ojzOJ+yWoKu3y0LYv6Z2voeucx8x8nTz+zg47beF/1odMvKY0So19VE2HzuPHmbxS8IFbElgTIdi4RfaaxiVOAuB6RHWny8DG7oW4dfqJHcUSrHGzPu7KacL0xcZrHTH99yH68JZygNjY+3cCLGo4KwwhXb2ooUrmAYyYc00cipS5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5Rp1v1IocZCPs29O+2faMQ6BGtqzTGVvxpLCE1pwOQ=;
 b=EEZjBxA6GO415/vNh3elHNapNhcxGJTUao19ToN/Z1YHq3hVXXYJ7xZ/CdT2gDr7A928cxCPCQsOC2Slm3jMwqI2IKGnn5ChmRy6nEEHE9e1t9MICyTmc1pAGNPf+cNeymc/+LRsTGHl6rC5YhVjkPOeaYc9zS8I0t45zdJZF4jIZ1inx0sUcnuh1EjzHcroMoczVl85LV5AKiJSxp+1oaCGFxodRAkc2jPDnrQutztBWKumfwAeBIBNW5mczs7/gNDZ9Jq03z2uhhnpEfC5+miwaiJXtc7p/L0/M7pSJVTAX2eeZ6uyOuIWvlQv68hW2a50aVQ6t2h6on/CnyaCqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:20:12 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0%4]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 11:20:12 +0000
Message-ID: <c5fad2c0-598d-a90c-5272-398ce48399fe@nvidia.com>
Date:   Mon, 25 Apr 2022 12:20:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH] arm64: dts: tegra: Fix boolean properties with
 values
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Yk3nShkFzNJaI3/Z@robh.at.kernel.org> <YlVAy95eF/9b1nmu@orome>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <YlVAy95eF/9b1nmu@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eda6e54-4dab-447b-37bc-08da26ad90a4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4190:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4190F8FFEED92954D5977AC0D9F89@MN2PR12MB4190.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZxZFUiceNj01zzQKzQLNaMu+QhNkhLsJxsdLcHIeL9uHwNDv/B66pi/sJzfF0zwojZbBTU3IgSkVTOL4hpOhW1824lJop7wwYs8GoSmjtRmpBa8oaxS+St+djHBuySpFFiIjwXinXBhvbYF6ABannXPznx+Nf3h3zZVCD7kLWI0BGiutBOxx1T/A9O8mgnOS2SLWC52kT2CjNc6JwkwUdFVqlxadudzWC0hTwEmLReTaIH8NAN/xqmJDhNP1AhcR9xbnrHKPfmgTh6arGqjgBFAaR7jMfWIio02W4iY7w+eVL2PEo1VHqKPezLLMTuAxTMGe6I5HL4eZgShE2EERisVCqau4JjbOAQnhfgIkV+oHruMpI4ec4jMzT0aLYOfSf/0FMzNnfyAEuk+oY9ZMZSWj24xDCOcRxHnCZPt7UDbf6pNEcxq4ebvtMNb1zVzlwXJdOhdESVWa1JHNoVoKZwln2fnfLQQJvNpPrrGNxaRpgP4x5Tumg/Hgu3KeJE2EtUpUNCNjd050Ig4pF55wl20He9wympGamIJfkzDEqtfh4b+xJZc6xnPB+m89bDtZg+kwc+d+0YLjaa0B6cIhQrxRdEpo59WKecp5ngmK2btpU7w9TreFbFwV2Gx6UTG9QDd7PncKkNLS6+kX1t4YLs+THeysrLivfdauq7rfXvKvZJ7jFYodih9vgUCos5wj3MOi8YoNMEtQ7h7SFBM0rkdSfHP8Y8VHlRhukrEL9AK50Yq+7fhT7Lbt9zGCVGx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(66946007)(86362001)(26005)(6666004)(8936002)(31696002)(66556008)(36756003)(6512007)(54906003)(110136005)(316002)(8676002)(5660300002)(7416002)(508600001)(4326008)(6486002)(66476007)(31686004)(2906002)(186003)(38100700002)(83380400001)(53546011)(55236004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekptYWZvZkR2ZU1xTDZKM3lHcTBNdTRvZEUvMlhSL2RJTXl0TFBUdTJiMFRv?=
 =?utf-8?B?TGhIVGJIT2pwYWtSU09RM0liR0VYSkp5bHNmQm9mMTRmWnh5UCtGV0xDVkZv?=
 =?utf-8?B?bWtLVTUrOVVXMi96UFNxSGhsUnRjY05lcmJlMlA4eGRNcCsyVUFSbnQ3MVdM?=
 =?utf-8?B?Z2R5Y0lKZzVLWnd4VXFFdnF3VE1NMHYyM2VQNGZ5TWdVNk1YcDMzZVBPS25X?=
 =?utf-8?B?alJRazVOZG9adTRNUysyd3krOUc5NUI5ZnVwTVlxd0hqN213UFJnUFpvSjhM?=
 =?utf-8?B?bWtwOGRxWFE1RU5aTDdDUG5tazU2Z1FiWFBpRnVva3dSSmFRYURtLzkvVUky?=
 =?utf-8?B?WWlNSGVIaGRJVzJQdTB0aDdPT1dmUko3YkNBem9DRlNNcm4yOXI1dVB4eDVr?=
 =?utf-8?B?Tm1yVUw3eHZGaU40bU4reHZVY2luQm1DcU8rUG1KVlZRV0E3LytIZ0JRZmZX?=
 =?utf-8?B?aHVCT3dTNk9lRld0a2RnNmJadk5NUzF6RGE4dzBiMEhVeVljcy9FdURxbCtS?=
 =?utf-8?B?UEVHSGxPZng0TFFmS0pIN0tpelpPUTdoT2VZQ2E2cEw1c25RRVJJUllQWHZD?=
 =?utf-8?B?VGJqWGhXdkRJNGZGQmR3Zy80N3NNZ2RiYXpvbXdtTzNaU0h3UlFZdHppQU9x?=
 =?utf-8?B?Ym9rcFZtdGIxclNNdTJZMGFFVEFDTTBJVVQwWTI1S2tTWU1zdURzMHpMNkhR?=
 =?utf-8?B?NjN1ZjFxU2k4TkRSbWtUaTlKWk5hN2QwQXVucnF3RUxKVjRkTGZPUUNxVU01?=
 =?utf-8?B?dTh4cWQzRm5lbEZKSGZ6MGpzTVR5S0NsNHdXUjJhc0FyQ05Fc2ZkWXhVM1FQ?=
 =?utf-8?B?NGFCdjBhU3l1aDJNb0VCSmJFcTR0MXhGSXppRzAyUVpkVkYvbGxJb25Ub3RE?=
 =?utf-8?B?dERxdHhFVENuRjd0OGkzR2t2VzdzZ2QvL3YrdlJSVkhNRGdPUEt5S2hmTWdu?=
 =?utf-8?B?Z0VPRmVDa0V4T1N6RWhFMlFaVS9sd2xqc3JleFB1TWgveTdGZDYrN01aUjlx?=
 =?utf-8?B?Y05jVlVWT0kvV0w3RVJydG5qc1Mya3hIODluWDZxRUhIaVhRK1Z5SnBJTVZG?=
 =?utf-8?B?UGRBTEczS1g4SzhuZXVyQTVtVjQxdmREOVBuS2M4S1RMN2Zka01pRGQxbmo4?=
 =?utf-8?B?S09oMFVacG1tVDYydE9tUS9vVVJ4bzdEVmZyS2tyY3lHUUdodU5HaVY3eEoy?=
 =?utf-8?B?M0p0L2lpWlUrMnhFUnJvbHRkM2JkSE53Y2twY0xyQ3dMVEJxUWdKcE04cDZk?=
 =?utf-8?B?TktCNnZnTW5lYW80NmgwVXRnMEluLzlQa0NyVkpGM3lhQllDSkx2NDVkUFdv?=
 =?utf-8?B?MFRnYjREcHpSN280K2JHZTUrNzVzWXczU2lTdXErVkdxK0F4ZFM0cWFJWGYv?=
 =?utf-8?B?eDN5WW9EZjF3ajlIazB4UWNFZVBQNGVsSFJzK2JRUTlKRFJBODNCYkFBYWs2?=
 =?utf-8?B?SG9KckQ0MFZmc3QrdTd1aFNYN1I5KzYvTHhJeWxvd21qL2VPUVJZc0tuN0dj?=
 =?utf-8?B?UWR2T1p6a2Y1UzFTSkhXMGNQNU8yZCtJVE5HNlFHZ2hRWGh2bVA1NnIranli?=
 =?utf-8?B?LzNsVW4vMFI0M2ZBOUJmNWE2Rit6cHBWT2FHSDRXR3NuKys1VmIyV2FhdW9O?=
 =?utf-8?B?UG53K29mRkJ5dWhEK3pyVVdrRXFIVjBoMzRJd2M5SGFDOFdMYTJWK1NrNXVB?=
 =?utf-8?B?aktvSmpxWUdQWGdTV29NRFliTGRFMXUzWkN3S1h6NW1yYnhBUk55SE5UMXQx?=
 =?utf-8?B?Um5jclVEYlhIOXVndlMwblBUdDUzMk52Q25OQ3JhUm1idFpGczRVZTlRT1Ew?=
 =?utf-8?B?bnZ3aWVJa0dTSVVWSng0Rk1yMVB2WXlEaTFGNUh1cTJaZU0rcUNlQ3Z5Rzlh?=
 =?utf-8?B?eFM4SzdLSlNJVlh3L1Z6ZkNGMzlCWElwVkNJZE5qLzRjNFhhQXRSU3dPWVR0?=
 =?utf-8?B?cVdaQ0dLRnZ5Sitac1VYSG5ESnphQXRZdlRHUDlMdGMxRGpOWUxhL0NMQmMx?=
 =?utf-8?B?THhUQUNId29MelIyMG1jaGRxdHpVMFRQNXJ0NGlHZ2JITXJZbUYvYjVLUmpS?=
 =?utf-8?B?V01qU3hJbTkvMWlGZTRkVDdGY3BnRjNCRXN4SUgwbmdVWGFRNWFrcmVZbHRk?=
 =?utf-8?B?alM4eTQyM0l6b0Nrcjc3N1ZhcGd5WEtGeTYwVUVpUDdCRThZaWhVYXRWbmVz?=
 =?utf-8?B?QnVGaEpIdCtyaHN2TElCRklWbDdYKzhLcCs2cDEraS90Wk01emRMVmg1dEI1?=
 =?utf-8?B?cS9LOFFublhheG4xb1cvcVpJN210WHdVcjBpalBuUmVuMFBuM1ZaRHp1NkJQ?=
 =?utf-8?B?cWlDNjg4TWk0dzB1aUF5SVZ2SUNhSEhrSFJqWWNYNjhjMUw2RVNsbFB3NFVV?=
 =?utf-8?Q?eqg6A1RdzvOJCHR4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eda6e54-4dab-447b-37bc-08da26ad90a4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:20:12.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86J9006EG+CRvyf8jR3H9afgl2LHfpd5+P/N/+3w/OdySgyoCwBjuLXD9KGaKhZxYEfrKtgJi+KFf2ZsbBkQtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/04/2022 10:05, Thierry Reding wrote:
> On Wed, Apr 06, 2022 at 02:17:30PM -0500, Rob Herring wrote:
>> Boolean properties in DT are present or not present and don't take a value.
>> A property such as 'foo = <0>;' evaluated to true. IOW, the value doesn't
>> matter.
>>
>> It may have been intended that 0 values are false, but there is no change
>> in behavior with this patch.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> Can someone apply this for 5.18.
>>
>>   arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi            | 8 ++++----
>>   .../boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts    | 8 ++++----
>>   arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi            | 6 +++---
>>   arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi            | 6 +++---
>>   arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi            | 6 +++---
>>   arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi            | 8 ++++----
>>   arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts        | 8 ++++----
>>   arch/arm64/boot/dts/nvidia/tegra210-smaug.dts             | 4 ++--
>>   8 files changed, 27 insertions(+), 27 deletions(-)
> 
> This causes multiple regressions on Tegra boards. The reason for this is
> that these properties are not in fact boolean, despite what the DT
> bindings say. If you look at the code that handles these, you'll notice
> that they are single-cell properties, typically with <0> and <1> values.
> What may have led to the conclusion that these are boolean is that there
> is also a special case where these can be left out, but the meaning of
> that is not the "false" (<0>) value. Instead, leaving these out means
> that the values should be left at whatever is currently in the register.
> 
> See pinconf_generic_parse_dt_config() and parse_dt_cfg() specifically in
> drivers/pinctrl/pinconf-generic.c.
> 
> Arnd, can you please revert this so that these boards can be unbroken?


Arnd, any feedback on this? A lot of Tegra boards are still not booting 
with v5.18-rc4.

Jon

-- 
nvpublic
