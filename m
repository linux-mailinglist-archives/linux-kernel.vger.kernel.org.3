Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688645A3AA8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 02:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiH1AhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 20:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1AhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 20:37:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56531399DF
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 17:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAI+zbV9f0b0lkheKF6svsNhK4tafU2f124WXchO0tjgjzhXNv+YeXKyYPofSni4QyO5TCyaOda0pH6WwjA2D6455U8j+3JxrYpt8NAD5uNut5LgG87kKuyvd4+bFiUaabAnGttmLOcCBTCFXdiT4gow7F+MC4BImiJT+gUoAz8SaebwmRW+34jwXmpaLTyVwEpDbTwb5SepmIhTXGZlNVsjCxaPZB9ZpyijWnBiG34X3wiS/eTvA2/Sg5XBUqCf7QNSLCWtPGq86kLMS1nnacbx9Hhcu7Q44WhWkYWxFqp6hUiUoo8PcwqedU0Tt3uG3YwRX2SBzmXBw803AAQTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kmukNQ4N2cyfLHpzgBim/BnOVYlP44qWao5aNWPmO8=;
 b=Nx3//Ns1DXJCrNDNyJEWnCXQ0ui224F1S4DdPivGVc15L1LAhUrf0cASALqbiGxz2fzC0oFk2Y7/aCt4jBSE39NF5V7pQ8oDthaWGpSdBinncxsBmQ8qsVlvTS/MrZ8vUZElmNeFkbkivNix08KkBr96FXqbvc2qrzUUrGbYcyrg55ZnYylVjuyrTG929sWMojttPcWtidunb1FpTS1RwkhAB4yo2Eg9h4+yd6V2V2cKv72BnFjNcoYhv4t6Sfeqt5noVF5ByMSreGCKkWs5VhzLss06dSR/4gSsfCInO+zw6R7qWxc31WshVuoxVVhHMWRhUk1mky/VyjFgzACksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kmukNQ4N2cyfLHpzgBim/BnOVYlP44qWao5aNWPmO8=;
 b=EGHE1bnPl5afAn9+a0DrcwEXTyLi5L5pH1TYZd7Q+5u6hcoppG9dVa9qM+tf2OSWuEgo9tNHA5cNbXGWSe8z0A0vO6leqBAx2Jhz+K7aDtIbN6kCTFqyVKqwZAHzxiJoKgvVM2iWnYMzFk8Fa+iaAyHArP6wAwDpZuk8QlJ/HKGe7BD8uKH1qVfZ8fB4zlSaDTHxC8tKBwbdeMwMp4rsQsDSiZlPK4qcXcNY2H2+lzU1wojVl04TNZO9CJVT8D+oI5NxoWTyKkOy3w064fzfbSbe01QbuLfbMN4UD9fjZBR6rJQnUXYQqIGQ1ErUeh1KI/BL8gw9/h/RWc8czIwgfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH0PR12MB5449.namprd12.prod.outlook.com (2603:10b6:510:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sun, 28 Aug
 2022 00:36:56 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.021; Sun, 28 Aug 2022
 00:36:56 +0000
Message-ID: <babb4967-8f58-2bc8-45cc-c51ced0007c6@nvidia.com>
Date:   Sat, 27 Aug 2022 17:36:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm/gup.c: Fix uninitialized return value on
 __gup_longterm_locked()
Content-Language: en-US
To:     Shigeru Yoshida <syoshida@redhat.com>, akpm@linux-foundation.org
Cc:     apopple@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shigeru Yoshida <yshigeru@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220827230037.78876-1-syoshida@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220827230037.78876-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31fe301a-8850-431c-d26e-08da888d690e
X-MS-TrafficTypeDiagnostic: PH0PR12MB5449:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4Oec3egVDxYS2cykv9U7CJ8HbKXwPYB+JT/uJLivGPnUGPHIYC4yALi14X6NqS4taIhO3V7Mod/cADrDAe2jC1pJWhAcDTUW3H5+dATVL4IQ/BWtu+foBjMUlRYKguFL/BW0QbaHj98U/SvhiT0UZ3pr0X6jHw3CrmDx8DQphmoKVjW079N/aWabxgmduI5KD0gWyXwJTqq9WxtRzua6v39IuJw/0faie8DYPJ3+zWa+EOguPdPbKJgWU+gwavQtuEiX88daV6pHUMuNqcG5BFi6veKWRyubdkOj7khlIYZ8vSjgHKIlZ4dAXzrizLXCy2X+bx9RB+hxYARDSDJda/JV3ZFcxM49hbKEPtVebD97Z8D8IPxxVrZ0AJKmM8SOE/EU9FkgJLefyAW30xE0oFxCSCJ+xuE4gezR50tDnkbm1zRQBfzZTIjAFxzkBCxzI55l7GIP4yNx+wNBL/N8MWPUfC3PLYVDJOAsGofSzj9Fxu2S8hILQk2JC7PrBhjSwEo795P0gaJtQZ9avToo5N1bIFNOZ3aPd5Eaf3Jc+HQc+/Em2A02hEAFP2edOj2RCSkmsBIjLzLH9FpQQDVZPHGBlFit4J0JZyNpqXOoI5qVpL7C6odd9ZwRjC6P7PONM0Ss2IBOFQ3u487qWt8SRbv3rixHrqPTQ174PQLB21LNqec9PzIi6v1BcyzxsCvE5B6gdy7VlEF3Y6kmSIKEV27EBVu5+49UIe15adPHwP+r1Lri62o3R2Rs9dLJs90WAPXWuDCRnmgt6J8xOIEiG+c8CnKidEeHBFd9sWa/js=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(6512007)(2906002)(26005)(38100700002)(6666004)(53546011)(6506007)(2616005)(83380400001)(186003)(54906003)(8676002)(316002)(31686004)(4326008)(66476007)(66556008)(66946007)(6486002)(31696002)(36756003)(41300700001)(5660300002)(8936002)(86362001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG9NSDYxRFhDNk92S0RlZHVWS2lrZnZIRy9LWGxPSnp1VktSK1hLNnlxc3Uz?=
 =?utf-8?B?enBuZEJuTGNLb2VqcVRGL3k0Y1c0VHFlODFySVRqMGtNM2VLa21ERWxuTXgx?=
 =?utf-8?B?Mll0aTJLSW5tZVRoSEcyZmVHYnBRbE0wZmwvclE1WEdodURwdWxxdHQzM3No?=
 =?utf-8?B?UWwvNXpnaUxzaFExMEh6ME5vRFJVTUl1dnhvTWRXam1vaEVEdDYxWm0rY01w?=
 =?utf-8?B?dWx4OHphNURqVll4Nm5CenlRb3NvQ2h5amY1VDBwYnpGeHExQzRjenAyY2RS?=
 =?utf-8?B?andSQS93SVVuUlNCeWVqdHkzZEplNjMyaXZBdzdtUFpYRVByOU5vTW0vM3JG?=
 =?utf-8?B?SkVKOVdNT1dpcXJReGlwVVRBOGl5djFJQ3lQSVREV0REanB1K0tLRnUwNlV5?=
 =?utf-8?B?TTE3ZUxPanJxY3hKb285V3lUT0xld3hObElzcXBxcHRYY3RPd1I2UlV2Yk9E?=
 =?utf-8?B?Y1dyRXVlNkh4WnpDWERaVnkrL0l4YkgzMkx0YlU4NzVrc2ZhY2U2SEc5TjI2?=
 =?utf-8?B?VlF0V0dGdk9KaGJqejNPUW5MNFRKeEtMMVNkdkdJZmhaMnhhRjlGR2RPK2I3?=
 =?utf-8?B?OFloWTE4eU9MdU9Mc0ZWSnJldnl5MDgxUnVwNE5kMURjcGpJaXkyMk1jV2Nv?=
 =?utf-8?B?QWNQRk5qa0JVWGJCSGdFZE0zOXhRWmU4WkZqQUs0THdjSjJvd0hjbHlmVzcw?=
 =?utf-8?B?Njl6TVhaYnJTNUltVk8rbjRiQnRBRWNwa0pYN3BaWXVMNWpJL3J2MkZScWZB?=
 =?utf-8?B?eFlxU1k3dGl3bDdwMVlZNlRiR05rOVVsakFyU2tCU0E4MDg5WW1kUzlwNzJK?=
 =?utf-8?B?UVdpNkpRNWVsVC8zZndGU2lobzZKamN1WjdBejZNcGVObFBaemVqSGRkQkVn?=
 =?utf-8?B?Rk92MklPRDhtTU1RUjBzeHA0NWl6L0VZRjNjMDVpUE5GUlBQek1Hc3JaRDBV?=
 =?utf-8?B?akdzUnpoeXliS3lFczIwRml0MGt5Tmp2MkZNVFpIQ0FVaEt2SHRrKzFhM2x0?=
 =?utf-8?B?OGdTQmtXTXI0Yk05V0pId25UYkhkV3E1by9zVk5ic1NNSm15eFYxRWhYT3A4?=
 =?utf-8?B?TnhSZzc0Q09IOW9ta3RKR3lqaitrY1dXaXZKb1NUcG56bUVZdGJzOTBlWTJy?=
 =?utf-8?B?cWdvaTk0UGpMcmYwTXVXVkhHQjhvUEFIVmVIelJaOWJHWUR2WWdzOG5XckYz?=
 =?utf-8?B?TGRITG01b1g1WjQrWUwya1cyaTZWV2tnN2xkZ3N6cWY5ZWp0ZGRhRTRpcTZC?=
 =?utf-8?B?SVNFbnZxcXoyQm5uYzZRTStDVXJGdEdFOExTVVNnOUsxTEw2ZE1ESzdyNVMy?=
 =?utf-8?B?b1RYYXVRaG1tYjVLUllBS3hJUXhTdWZLV1Ziei9xTEFsYWx3QzZabmJrdm5D?=
 =?utf-8?B?MWxPUjlFZ29NMkVDZG00dHI2UEkwZ2ZwcmRyVjUrOXlXSUpQZVlZTmdVcXUw?=
 =?utf-8?B?dXNwN2hoYW4vS294SW1tQWh6QWFYZXJSa0FmYzZGVlBlZFZDcUk1cDR0ckkz?=
 =?utf-8?B?SFRHbmF1YktYaDlUTWtycG80aXA1bzJhQ29UZjJOdFE5VjF3SlJBTEpOK0k3?=
 =?utf-8?B?bEFZSTVTZnQzUzlZbGpvZkQ3N3RGWHNvOUxVSTcxUjBRazJ3OFNEZEowTjZB?=
 =?utf-8?B?eTVvVlFaa00zK0gxU0dsOEQydEh5R1c1bTlKcWEwRXdSZ3hsZ3hNSS9HZlNG?=
 =?utf-8?B?aFY2RXRqa1hqeTFacGc4VzRja0p3Q1diZGpOZjExUnV3UHB0eEM4Z3c0T2da?=
 =?utf-8?B?SzdheE45bmljbzBjTjNPZ1NITTdIdnhicG1vTTF0VGcvTUU5ZUR0U2VlWmhM?=
 =?utf-8?B?WE9rM0lCd1RQVENSaC9mVU5qVUx6VUY4ZGJueFpqZE1HdzJrc1haY1JvZDBh?=
 =?utf-8?B?UHFTcXhWQVZXSVkwRzhhSzh2M0dIZEdua2RiZzVmQnkreHFNVWVGaDQvcDd1?=
 =?utf-8?B?U0h5Z2Y1UnpNNWd0Rmk0RlpuR1M4Rkl1LzRaOHN1Tm1VVjVHdS9Na2g0eEc5?=
 =?utf-8?B?dHZoMlpSczg3Q21ReFVXbzM2TTB5akxhNG5BSEJadzllSDVGZTRIcGhiR0Fi?=
 =?utf-8?B?RkR3UVQ3VHRPenRCdTF2TEVKYWtlVXI1V0xvbTloVkpMRFBNSmJma2ZXaml1?=
 =?utf-8?Q?6oBXNr63L+fdk5HnGtxmqo4S6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fe301a-8850-431c-d26e-08da888d690e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 00:36:56.1942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rj/Ix0F3eFWmsCvajzGfrNsuI+z1rvWI2hRVEYN9ZmHax8uyuwoEhtNk9KqihRqsIW5SXxYBK9p0tG6G1Q6Pwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5449
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

On 8/27/22 16:00, Shigeru Yoshida wrote:
> From: Shigeru Yoshida <yshigeru@gmail.com>
> 
> In __gup_longterm_locked(), it returns uninitialized value if
> __get_user_pages_locked() fails on the first iteration of the loop
> since rc is not initialized.
> 
> This patch fixes this issue by properly returning error code if
> __get_user_pages_locked() fails.
> 
> Fixes: 11147539df44 (mm/gup.c: Fix return value for __gup_longterm_locked())
> Cc: Alistair Popple <apopple@nvidia.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shigeru Yoshida <yshigeru@gmail.com>
> ---
>  mm/gup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ad59c796d4d3..66d8619e02ad 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2110,8 +2110,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>  		nr_pinned_pages = __get_user_pages_locked(mm, start, nr_pages,
>  							  pages, vmas, NULL,
>  							  gup_flags);
> -		if (nr_pinned_pages <= 0)
> +		if (nr_pinned_pages <= 0) {
> +			rc = nr_pinned_pages;
>  			break;
> +		}
>  		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages);
>  	} while (rc == -EAGAIN);
>  	memalloc_pin_restore(flags);

Sorry I didn't catch the 0th loop iteration problem on the 
first review of this. Anyway,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,

-- 
John Hubbard
NVIDIA
