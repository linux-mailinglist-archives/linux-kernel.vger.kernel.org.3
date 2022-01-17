Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8ECE4904F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiAQJfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:35:10 -0500
Received: from mail-bn8nam11on2076.outbound.protection.outlook.com ([40.107.236.76]:33249
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235646AbiAQJfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:35:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpBARiUh4qev3ls8Vr1yPpgmFnEYfEQooseq/DM4jTdmvXnXfFcuL7fkwRobisLZswux//Ib090weNr6++XC08vTrFIdvcitZmvlH8i+pmW2SR4qLRwYqphq5iaDYShlx4yuKd50gwdPq7UI8uDaC957ta5YG5nOtTOpxCQWBP/q5C9vNfgaaLS1wZAkV7KHCkwMTOcZQ52MtOmlxydehJiw5IYXsPIplrjBTnHQX7hk7IBW8ACXkRBVl7llEkg0JUcqkI78olHnMgtUf7gwnUKpXG4F/eBX7f0xZ40WynsMwXSEflPVocnQU8XdQkC0+NZAoKsBCi+8CdUH4x/MYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCb7S4KRRS0hS1L6kvupNKfAoFq/Wws/uhUCyzonz7w=;
 b=FFMvyFW3ZYbazlsP204pZf2ey43C7J8r9JF5X8Y58kCBU4Q8RhPW4nzhknGba1rYP98tXitpw3kxtBytavYMmyvr7xVTXzLlyg1MXHJvx0PS1N4y/OquiAX1P11l2ETl/9m/TbLs4nxIOj82NDzd7/g2ik8xE7mVzh+WKOXmuglzL87C6lAm1fwdb8WF7w62Flta5POU9FslMA4WEqDcEbnqaCHbHhslREFUvmVBzx+jQEhAurwyj8iZZIv7hVX4vFRXdzMOR/pwFePClIXJxtG1ih0U5MTpKVieN9XumNiTjuiQbo2U7EuT+6BaFkJ9zbzShabhlTb3vaqdFXiKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCb7S4KRRS0hS1L6kvupNKfAoFq/Wws/uhUCyzonz7w=;
 b=osS03EnFmR1cYlMEbaDWHDfPUEVbvvWKGMJ1ybGHOF+eiWUtf3NTdaKPcGtuJC5moVn/N7rBTebgPd9fmz4d3/yhaWWh7zvXjFLBuUNbRf5e1AT5s+e5s8KmFVmVlG1WYC79/c4n9USNBxKuXzdKrc1/4LzkUlReOWChnJnzndA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM5PR12MB1292.namprd12.prod.outlook.com (2603:10b6:3:73::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Mon, 17 Jan 2022 09:35:06 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%7]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 09:35:06 +0000
Message-ID: <de3ecdf3-005f-f8f7-80c3-280c9ff989cb@amd.com>
Date:   Mon, 17 Jan 2022 15:04:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] HID: amd_sfh: Remove useless DMA-32 fallback
 configuration
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
References: <a1ce59490a9a32f638a41fb80ff4b4598c33acec.1642260273.git.christophe.jaillet@wanadoo.fr>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <a1ce59490a9a32f638a41fb80ff4b4598c33acec.1642260273.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::31) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 812e4ffb-a365-423f-5733-08d9d99ca55f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1292:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB129273935A812DD801EDBEE1E6579@DM5PR12MB1292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbZPJPoHvbLTkTJvrWFUzhf/N66vBkwr3DzqYfIZ/CbvrIYxE66SH5Ntmt5WdeO9iO0Y7/TQhwdF4s2ZCInG77E+V7SW8v9dLYQAUzJdHFFJ1uQdaHmyUZd8NGwex7I0Bee74x4jCKJLzCiMOu5z7MvyECNMVM3bDGdFV/ZQGO4fbNn0P4CvXn5NUr7gi44x4+3UXViO3gK9mHIQiK3qRPUAciKz/flVyI5scu6BBQy+ZjQAf5XjCrdm2frLp+x+2+X6XeDGTjlO/KvXy0rVb5HQXg1f1ovjUo8bxqy7Hfwkx9fLe0Ui9GbDrWHOMno0ooDgkdOex9NbLJnzc982qESw317Rc7JO23hOAnYizjxUMKwE4j2WZmtS4K4Y+cdzk4v5eqteKJIA+uHTnDgYFBDyOvY9QIZt64TfDiUxUiM8jlkQYvoMzt5O/hM1bEvEYceJebqtqruRldEo6e5CKTmAr0o8bRV8c1afam/gtYGhxQQHUFO6M4H3quDP3Fn2hd9DrVxNyI/sU3lsF6wrbEfVXIqdjIptfMNRSnvet51KevnAyfex0bHXC0LA4X8Bd3MCFEI+EqvGMHb2a+PyCoySI7DDgEfc0o4w/CoPIF8CTT4ByEXcZvUWT4d1o3kDk1EkroSSjfXn349lGUCUxlGUxtpHeWwbTSk5yAd91SneaDsk2kGMkKQLeeanr2wr9d2gi/d58J3jefGMJRSbN2TYTxl6moIa5I9Na8f7zZTlWx/UJIu4/MGGr3J36o1Z/5rhZHDjkplH0QyShDYxiS9RDm+wpiMZyf44oGf6zcY/IoBFpxB+pvbR/No7Z8Cp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(31686004)(53546011)(6506007)(36756003)(38100700002)(966005)(5660300002)(6512007)(4326008)(2906002)(508600001)(6666004)(6486002)(186003)(66556008)(66946007)(66476007)(8676002)(8936002)(110136005)(26005)(316002)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWpwbzhHYThxWG1UTHEzL3lRaFNwOW5JQU90ZzZ6L3l2VjROdFk3bFM1Nmx5?=
 =?utf-8?B?R2VwYUJCLzFQcUdxYWJhTlN4aUR0aHNkLzJGWi80ajZiUkVjZzg1K1pOM3lB?=
 =?utf-8?B?VXdZbmQzRHJ0eWxDZXlLU3lnVG5ZRVdHVXNKK3ZXcnp4WEtPRWIwcUNIRmZ4?=
 =?utf-8?B?K0hzOWZlQy80NDJPZFZvS3FhdENDMzdJdkM4ckNSZnErdUFtRXEwTU01bkNa?=
 =?utf-8?B?dUE1QXhsNm1jZUZKbXdrQ3FPb3VLdEVZd1BjYUw3UFo5aTdma01kQ3UxK2Fo?=
 =?utf-8?B?ajVpWk02TTExZWkvNDEzOWRXMGx0VzFmSWgyblltbkFldmtXenU3ZUpFeCtV?=
 =?utf-8?B?ZlVQeW9FQ2xxNXh1UDQ4L1RBbkl4dCsyOTJUWUJNK3BYVlRINGtobWRFdmdX?=
 =?utf-8?B?OEsrNG5CbTZPblpLdXZOZkxqV3Q2SGdDZ0VVOUhkYjRYR0FSYkVIY3AzNkJn?=
 =?utf-8?B?TnlVYVF1RUl0RG5EQlcvdHY3bTUyWTBiZzZaV05pUnRra1FoVnVyam42dVds?=
 =?utf-8?B?dDF3aHBocWJsWHowM0xhUTEvR1lPM1REMFlEMVIvblFOMjJHa2ZuL1JLRnVw?=
 =?utf-8?B?TGFreGhnUDB0NElsTG9CN0x4SG9UaDJ5d2dpNHdDSGxhaFZuNDEzS0x1MVNO?=
 =?utf-8?B?UXRsZWFvUUI5K3UvcGJ2MUN6eW9EeE44YlhkUlBYUk1lSkk5YjArM2NhcUdu?=
 =?utf-8?B?YktIazAvb2F0d2RxVk1kLzAyVTVLd29JanhxQkhMV1Rta2dydk1SZzQ3RXFa?=
 =?utf-8?B?NWFmWGEvc3I5RUxKN1hSS0pBblk3MGxuZUZrNEN2NHRyOGxDYUhraVlUSU02?=
 =?utf-8?B?cWlFVllhUjUvRWc1dkI1elc4em4yRktIUklSbTB6K01JTWRjcWZCQjJOWFpt?=
 =?utf-8?B?Q1pKRHEvWTcxSU8zOGM5V2pYUWc2WGxBUjBQaml6SllUTTdCZVArV05YRkNH?=
 =?utf-8?B?dlk3bnNJOGtUWEQvS0xMNGdnL3pHd0lrQ0k4VG1WK25mbTNYMjhjZERNWTdn?=
 =?utf-8?B?cFJ2Y1BFUXNQZXEzMkVUU3UvMEw1c0U4ZC9kajdJUjdPZk1rS21hSE1pbjBO?=
 =?utf-8?B?TWxZOTdmamR2VTlTNzZDQldqa0k1ekxiNnVmc0ZMSUVBRnVsTkZPWVJTdG5M?=
 =?utf-8?B?MGhXNFp2aUZWOHpET0FlcWVoUHlOcGZXejF6M21EV0EzUlJDZndvK1NJZlFr?=
 =?utf-8?B?ODNRY0FESThlNGVVWU9ncFd0TEZDQ3ZLMGJtK01kV2J4d1VKUStyV0IzZm1M?=
 =?utf-8?B?RU5jYnZYMURESmkzNHUreUxTQTV1aHNMT0hHU3VVUm9kL0FQSittMDhobEZF?=
 =?utf-8?B?eG9kZGZSbnIrSmZpbXlTNXV6cE4zNGIyeWtXQzlIT3FNMlUwemR3UWdQcVJi?=
 =?utf-8?B?eUQwRE5JQ1ZrMmRkWGkwZk1Kcmd2T3c4YkY0Z2xjTXBrVGxEQm5yVEZVeHBH?=
 =?utf-8?B?dnlLQWxpamdwMUNOd1NuNUZyR0dnT1hLSjYvd2V2OWFyQmJzY2NEbjVwN3BG?=
 =?utf-8?B?eXlJdHBhVURnRWo5cG5yMWs5YUk0YWlyUVBJZFNhOFNmMWxRRytyWWl1OUph?=
 =?utf-8?B?UTFncWRiWDk4QTRFQlVoM3VhNG9TYjZkdnM3ZGZMQzBIRU1oK05kVlErSElo?=
 =?utf-8?B?OGY2eE1VdWdqellIeFNma1Znb2t5MERZdlcwSXBIYVp2RStDSVhnUGVycmN3?=
 =?utf-8?B?UG1RMDl1b0NpZ1dqMjZNeHA1anZ5TXBGa0Jzd3pvOXBmMC95a01HRjlaWkM4?=
 =?utf-8?B?b3JNTGZJaGZPWUlBU0hXK2UzNTg4blRBY1MzSHNIOFV2OG1uYUFwdmRQNkl0?=
 =?utf-8?B?RkR4a2MxVDRoSVVVandvK3pmd1JZYzMwclZrSytORTJqTm1rZFViNzNZMVRV?=
 =?utf-8?B?c2NXcjY2bDVMYVgrcDNsM2Yrekgwd09KbGRKTFE1Y1VFS0pDOUNEOFRIME1v?=
 =?utf-8?B?Wkt2N0VpbEZTeWRidmMwV21xSXBQYTVOdVFPa2lsUk9hK3BKQ0RUb3Fpb0pa?=
 =?utf-8?B?ampIbEE4aEYxQWpLZFNZVjJoZExCZURKYW1rVHFGTUduV0tmbFpHM0ppK0M3?=
 =?utf-8?B?RjlxcDNiSzVGNU9UVDFnK1lQNERkY0VNTmhaQnY0QVRYUDM3dnZYSngvUGdL?=
 =?utf-8?B?ZFFOcVk3d0JoK21zb1VzanVRSTJtd2hEYlpWaWhkb1F1b2RsbCtqbU1lSXFU?=
 =?utf-8?Q?VUCCRLTJN2oNgBk7bmAwtGE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812e4ffb-a365-423f-5733-08d9d99ca55f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 09:35:06.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9+dNvK8IcrPGtuW93IiLw1tOPu25dhLg8zQNC8ZZPSLQsOcJ9K+C+kJ1kVAhC1Zokq18t9OXDxVvnMt+GO5IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1292
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/15/2022 8:54 PM, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
>
> Simplify code and remove some dead code accordingly.
>
> [1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index 2503be0253d3..673536d1d9ba 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -248,11 +248,8 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
>  	pci_set_master(pdev);
>  	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (rc) {
> -		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> -		if (rc) {
> -			dev_err(&pdev->dev, "failed to set DMA mask\n");
> -			return rc;
> -		}
> +		dev_err(&pdev->dev, "failed to set DMA mask\n");
> +		return rc;
>  	}
>  
>  	privdata->cl_data = devm_kzalloc(&pdev->dev, sizeof(struct amdtp_cl_data), GFP_KERNEL);

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
Basavaraj

