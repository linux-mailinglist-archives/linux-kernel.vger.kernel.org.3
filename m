Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD734E1E2B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 23:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbiCTWwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 18:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiCTWw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 18:52:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1356E49CA5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 15:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZA7JQVKYGGAJ0r298s3BKtP6arOKLCUSWugMsP1GST8Aa5Zetvf6LC1o1gcaDZh3j60nEdzT7qMs/RLtfbTByV8nWKqH35HgFMYWmbO7uVkp/fsmdQWqp/Du96jTtvntvCzbQaHoG43sxfJv9U94b7EEF/QL8qGsgCRq7uvjg5Vb+hl58aeBe24xLEIhy1RnvMoF2W/0t8Ow2zmpy7Px5hdbGanDTJdkmiZk9g8B0XBvnhhIR8uEhiDzJ8i5pfspbOZDSPFWNFE+1DtPPRnxXVc4oUsklRSne9HK0C8mXdU5rprUfNfLkVmtTWPpLeU7qvfdaPPJGjqsLOMT/JkPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DdarTynyysUTO96dCG/HtMTnIPH9KQ3ExgmVURIHNQ=;
 b=SvSiDKe7aMpe/+QtnMgqJz0iZk9fZL9rD0DJptwMBaPI4fYeIl6xupkgS+toCRSTbH1QKhVdLGFVFlBjGuXKbERlQWjioxmb3eJ8y9kNZDmqu6BBjR6NctOVtHyRF+Esuim7Zut1TSyXkMVftk2ltU7rX8IBLPYnib99lL4hPATM24a8gec0EmIXWXL2HoQvtZIApJYlRN8XRcYUwfvaXAHRgNpjjXn10XZajfzgQnflv9IGqco4xcncZhT1Px7qFAxEORHJQ2PXSxxNGSvtB+HcvK6CZuDhI07r1CCm9we7AzcpIeCIzajqufP5YNxhKLLyoLFoK0xEP8Jc7klZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DdarTynyysUTO96dCG/HtMTnIPH9KQ3ExgmVURIHNQ=;
 b=iH2inuq2Qgo7erXhPpOpGHCPktdXuds6elyl7n1aqA9Q63LQjbYZByqEXPSi2zNyB8U5RT37uGwe/q/ei30jiTOPsQojPL5ta/+nvZImk8puHBk/K4hHPDEYSAcI2r9OeuXZ0KNgT17+lnv5K34skfWDV1SKI0/EkO/FF2h1TYvEgNrPqNE88u/Z/KnabsEVnpd9+l7bDOBDQUWvwIXO5mR/JHPXqLNy7ovr1tLxLEtCClXtxCWlFsvnDTQlW+0Zl3XmlB4YecL83781dbKYD1xG6uao+hHPiXBC9jEuql3Ty7A5rlvYBgaH5yf1cP5aw042GKfLKzoHev1YE/Qe1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CO6PR12MB5409.namprd12.prod.outlook.com (2603:10b6:5:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Sun, 20 Mar
 2022 22:50:58 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::b4d2:1b8:7a7b:fdcb]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::b4d2:1b8:7a7b:fdcb%7]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 22:50:58 +0000
Message-ID: <82bcda66-cf26-c9f5-fe2e-e41f739ec1ff@nvidia.com>
Date:   Sun, 20 Mar 2022 15:50:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rapidio: remove unnecessary use of list iterator
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Matt Porter <mporter@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220319203344.2547702-1-jakobkoschel@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220319203344.2547702-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::31) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d022bf82-c6e8-4c53-e6b5-08da0ac41930
X-MS-TrafficTypeDiagnostic: CO6PR12MB5409:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54094835B1096542D640DE9AA8159@CO6PR12MB5409.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGHH1jitd9CR9gXoXD1bWl69XL0079RTPVYnGN80gMmXHgJAUBXn4gEWkKhl9F4MPWQQvV+I3+pV1bcJRLgtQj/MOClePwIgdBNYKWwPHPFIXRHkRvlcv+NjToe7uv8gZis5AbxPPyeVtwjh6UFOhhss5NSXmzLmGCmluutG7iGvdIQ5U0PeaGO7ailimMOFrjWL7sMSJOhpBBStjsGn86Mx00QqC29cFtGB10BiZXQK9OEglWnvPmSEOimXIFZSGdRHJ9W5SIHzRPt9JTp/BOlgBzQtyShebIwved/E5VHaf1b482VrvHa/2uWI1fhD/RK+FwS+PTByhG8ntf9ZgmDGBkkpLnBujCwQbK8AUwIqugldLOZaCfoWf0J2Bg9YXR7+ZKd+J6mqnyYiF+zmKoPDVIYoZwDonWnQyhxJH4orxCppmCtPg2AbTsstChxc6gIqlvYw0mTNib1VOUxaX1h0xP1b/a4sfUz/8nhKa76RUfHXqAouZgYKhfVhLC19AZDPjARigkPWyl4m1tf8e96ZuVFLRacLhs11Vx4f/Lhw7s6QNfgvtotUDgsWEShzfVMpUZa5/P8JBjhCduYH1pk0prWV3k7Nk9Iy7gzj+43N5iK52/BDwwkO+kWAT/Lc4nTfgWUtkGdtk5CuVpdYHhqOrwhU+d00FsYCr6OlNV1oHyXxVIzSwXVy/CEfelPQggrIq43YjdLtymV0rYXZfMhP9C18s7AE1uEggH+zQCIs6GQmKJfGbzjk+rCJ7u+PgLdEhnIArc8ODYDrFa6Tw7DU+5Dd675Rwr5SJW8Ejkoat39hIi/rNIy/QiEDtB6zcIqaxyJbi2phiQyEiUJexA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(4326008)(66476007)(36756003)(31686004)(66556008)(83380400001)(2906002)(8936002)(53546011)(66946007)(2616005)(6666004)(8676002)(6506007)(38100700002)(7416002)(110136005)(508600001)(86362001)(54906003)(966005)(6486002)(316002)(186003)(31696002)(26005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWhXN0d6QjV4WGVxMlNOVHphUEoxS2pucXpRcjRydVJyT1UxY1JVNk5sdDAz?=
 =?utf-8?B?cDVsbTRPQWZrc2ZGeDRyRHVuNzk0aGViblQzZlNoWWlNZ3FzVTdacnY5dy9v?=
 =?utf-8?B?QURENkRBNEpBSHNpdGhTaThNdzBSSldtVk14TXgyVHRudTVPU1J5ZXkrNTlK?=
 =?utf-8?B?ZVBJRm1OUE1IVTRUK1BJUzh3NUNBbFdoSUVDSTUxdmdqWW1oSDZMZ1VsdVJW?=
 =?utf-8?B?bkJaKytoc1Z1bzMzaUhuYnVUNTltQ2dqQmFjSldmNTM0WUVrb3BDSFBJeWMz?=
 =?utf-8?B?QjlGeUZNV2Ruc0wyL1F0elVNcGttbk5VWXpPRGJlam9FL0JzWnNJUGF4dm1v?=
 =?utf-8?B?d1hWUGYrZGoxajZzeDBkWTZoZ1h2SkRtekFnR1EzVm9odDRYS0FyRVgreTN2?=
 =?utf-8?B?L3l0b1N0dVUzWEthK0xQSmlJYkk2WjIrank0QlhGeEhwWWxJT2RVRmxZZ0hi?=
 =?utf-8?B?Yi80bHE0Sy9sdVhQSHJDWHJUNGdzZ243L0ZxcXBtakMxUGJEZ25ETWR6bkJm?=
 =?utf-8?B?dzVpUXNHL1FaU2hxamVHbTFLM3pFV3dFaWpwUm4xUHpnUjk4cnBuMnVSb0RD?=
 =?utf-8?B?ZzhqVGhBT0kvSC9WNmt1UEMybjBpRlM3UlJNQTFINWQrYTVPY3pCQTl5cWY5?=
 =?utf-8?B?VXBoSm5aM2l4NzNjK09UbmhXOWdWNTlsZ2NoV3pnbUd3RlZtdElMazhZdzlG?=
 =?utf-8?B?bFVZbDJWMEtlM1cvYzV5NFFyV015RXlob0t1Tk1kNCtpYzRxM0FHWGU3eGxY?=
 =?utf-8?B?WFFRd1B6cXRncVlKM0V4eis4U2hRUEliTUZ3OFBtS3ZtMWpwOEZmbm5xZHdW?=
 =?utf-8?B?YklaNXp2TEptczBDNVEwVEZUc1ZDbkJQL3U3YlJ0WXdlazczQkMwc3Bwekt2?=
 =?utf-8?B?NlA2NjhXSldrRzZHMnNYUXpEVUNBR3M2MXJ6MUEvSDhNa3REMVQ4dzBYa3JC?=
 =?utf-8?B?b2VuZWg3YnJ2UU5yT0M5eitzUnBVSHdvaGhnRVZtbXJDUElaazZqVzZIS3Iw?=
 =?utf-8?B?UDFxaTZYa3ZlUVp0bzg0d0RMcGxDQWJINjBENHpRZXMrTlJ4ekI5eXlnc0Rl?=
 =?utf-8?B?RFpsLzV6OUErQ1VPK2o4OVltckxNanp6TWcwai84ZXlwS2I3cm1yS0lZRnM1?=
 =?utf-8?B?NGRKKzl3Q0hRNUlJaDJtNkNobm9VU1hwa2NuRzYxbzExRzczN2FjTzcxYmIy?=
 =?utf-8?B?QVpyczlUa0t3ZXFwbkpEbHFoUnhicU0wVzVTRUNQcTlCL2x3MzhmdVBSaUp1?=
 =?utf-8?B?K1drL2dVMHNac3VkbDlIQ01lc0ZlUmVTR0NRdWJCTGxTL09CeGgzck1DTXQ1?=
 =?utf-8?B?K21aTTBSaUVoRDhxSkFVOThBQ2VqRVltQlJzeCs0aW5NVXZobmlOMHN6NVFt?=
 =?utf-8?B?Y2grNkxWdVdhbFNsMlRXdE5aRVcyRStnbDJDZkFmdmhtV1FwbkNRQWQvMldo?=
 =?utf-8?B?dENoaVdnTzJSNlk1RnJHdTBZU3pIYVQyOS9UODlQYjI3YnhjNjBSdGMrSTNE?=
 =?utf-8?B?SUZHM1NoUlk2cUhGQkRIY3g5eFBLdVRTaldlVFFoNnhtQmJBNTlLT2Z0VWQ4?=
 =?utf-8?B?UmZqNTRqdGhzSFNVTlFtQkRtdFJFeXpUZVBLK05ZTkRzOTdMK2FrTnkrdGQ2?=
 =?utf-8?B?MForU1VXVUs0eWNxaVo4c3dOb3JSMnp6VGRqZlplWnltSitxbE5YK2ZIT3Ay?=
 =?utf-8?B?VXJuSi9GRnkxTXBMOTRHNXlROXVmN2F6Qzg1OUdQcm1QWU1JSWo0WGd5aFNy?=
 =?utf-8?B?TCtiT0NjN1p4UlM0cmNaUWVmc2RJcWhkeVg4TmliSzAzR2pGbVVFVGdLWXRn?=
 =?utf-8?B?WURUVkExT04xcmhlaXg4ZzZqTksyZmZWQmFHV0hTS2wxc0kwYnltd3dmWGlZ?=
 =?utf-8?B?MmVIUGExVHpjcXh3T29OZnloZDZoTFhHN1BzQnFlNUlpT3JoUktkN3p2WnFa?=
 =?utf-8?B?UHl6YnhTUWNmZThuT3kwZUNGNEJyMlNRaDZ6bXhBNXAzUkIzMU5zd2lCSDNz?=
 =?utf-8?B?cVdkWG1oODFBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d022bf82-c6e8-4c53-e6b5-08da0ac41930
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 22:50:58.4473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lA69hn5peMBThSOCMwmMddyxQ5DaXMuvNVTZgUI+qm/50pTYCIQlxhmbEWy+cAKgMwZEvvB+g9Pdo8bXJZjRMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5409
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/22 13:33, Jakob Koschel wrote:
> req->map is set in the valid case and always equals 'map' if the break
> was hit. It therefore is unnecessary to use the list iterator variable
> and the use of 'map' can be replaced with req->map.
> 
> This is done in preparation to limit the scope of a list iterator to
> the list traversal loop [1].
> 
> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>   drivers/rapidio/devices/rio_mport_cdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index 7df466e22282..2cdc054e53a5 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -915,7 +915,7 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
>   			goto err_req;
>   		}
> 
> -		if (xfer->length + xfer->offset > map->size) {
> +		if (xfer->length + xfer->offset > req->map->size) {
>   			ret = -EINVAL;
>   			goto err_req;
>   		}
> @@ -927,7 +927,7 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
>   		}
> 
>   		sg_set_buf(req->sgt.sgl,
> -			   map->virt_addr + (baddr - map->phys_addr) +
> +			   req->map->virt_addr + (baddr - req->map->phys_addr) +
>   				xfer->offset, xfer->length);
>   	}

I'm not a RapidIO expert, but this change is small and clearly correct,
so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
> 
> 
> base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
> --
> 2.25.1
> 

