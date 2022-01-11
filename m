Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAFD48A810
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348349AbiAKHBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:01:18 -0500
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com ([40.107.237.56]:63687
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233850AbiAKHBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:01:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDvaC7CdvsoMxYV0v8c8lwsTrjMbC+L8E5GZQK1mnmZtRVAk2vtTtGwFm3VVDuMzhW9DMx/doSAWG5KC2vh4vYoDjRdKqD6VRTT0XfXER1Km5+XqF8aVvSPx1w5QuvArs8JLF0kGJOuTdxYXrQWcG3benRQGd59rTrBqkpSxsKcPI4s8ee3Ls4YqnStZTIJiLNwJbmTTgusiMiEVeAXK/oNACdSS6k+Q712rriwG9AsU7QiJD1kMT37C8MtQR8ebZK+/DwYiVyB8kJUitaDR06UHC1n9ZVpwqP1DCuotyk2H7QQChNbXI8c3vfcDDxKuy8SWbIPHQfBukZoR8weftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oluXN+jSguiHhDQ3Ymijgd8HN9mC3oUtuPySqoHch54=;
 b=MHU8k/MBG3s06Q7TeCui+HGeYhpd7QfPRuYGcykSG2duw4JbI5ANsRPvQzNMoGAEnkONNA1X5r9QfzS8drFp5xrvDwQuNhLp6sPJWIfsYsUf85azZkp4/+nC9HOS6hrZ7diGd1M7pUOkSwYh1teeiEcjGr2s1V4pDYoGj/4rfIHhvbvGHocjvKV7LjIJrq3Bnw+uvP4OpxFFGxX9D4VcRsk8wpU/pfusUg3pUap5Ncc2JmsPc2EsjnWrsENwKNdiDGXsf689HguuNAIDQGy8DZWQReGQNsV8n67CbCM1vcXO5/YkqMp9pd9c46yQh12SxNUXAWUXl65owd2lcYZ78w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oluXN+jSguiHhDQ3Ymijgd8HN9mC3oUtuPySqoHch54=;
 b=m19UGGMHwtU4wps4fQ+0TIj0e9k+/0tIXMYsxPt5BGfI9vtS+93A/Z3rjC1y/8ejzry0xh2PoiXGT4XdLDav0y722LuBbqghkdIS0/EvNJVq/+uee7RtFsd+cCse4at4Vg3fLNSCnxDd8WEwxE1LioXQjarS00ZM3E72fx0Ox2OSwaVZFpqZ5lgEGhJSRG5/0TFGe6AeqeN88tJ2vh+Rlt+D5r6kn0DW5dakXaLCQ0ShXBZb+ugp4uV4RnRjjpHv3Jea3kWCgo8dmIBQxDOYksYBRWRNISEzIVlZR/YGxy77qAGYBWM4Wlws7IvtBR1akVm+djGeOqvvbhOvp+htWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:01:15 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:01:15 +0000
Message-ID: <9f5369d2-a2e4-f759-7b03-562ee215f17a@nvidia.com>
Date:   Mon, 10 Jan 2022 23:01:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 19/28] gup: Convert try_grab_page() to call
 try_grab_folio()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-20-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-20-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:a03:60::15) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8bfa36e-ca19-4f4a-b01a-08d9d4d0287d
X-MS-TrafficTypeDiagnostic: BY5PR12MB3778:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3778C57D595140E9CC322BD5A8519@BY5PR12MB3778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERB/HxWWK6cctFHBYT6k5BhImVOM0ZeKPnGAgwI0HO0qhBxOxUCxXJd2NGuXRB+5OkOP2Ovu26zTL/Su0N2NsIYxZOLHaE8nmQz4Qpr4r25hNzi0V7fE8otspV1QIGfVSBOzDou+511077KoInLj/67m8JxbqZr7JLtX3ijlRJo7fLsB3hgwr0d640qDGSBsp4ba3iECjgzrosg0CYRtazkgae9b6sxsTL97VP2AdGO4Rb9aBGItJZh/6liqzK/3YZ3DJsB9zkerWftFfHUvzm8SljR5JuAm4FNaEOzvojaYY2o+7WbH7fKHc3IQ945OKNTMJQu76D1staGVSy+HQJeo/EyMfsSbo+d80BhpFKOyIEd5xmMqZZUJEjd1vaE9/vFzgBcYyAsRfJvRGsNTNWTb9bTX3bREKtUKTmZ7oLKe81avNVdu81T5YjvDc34vfgBTFhWL1AydUZH08IyoN2bSv7GWckzo01DhBSGYluoP6+q9aCNxR2F+x8AmzSV5dXH8/ONUxy8yhDN3pkoOD/l4XGOHe1AbujUUMHz+uhB94+QyMa4cW8+rk3WPs6/FRxe85RNqIRHpF5fWBF19bbPHbIxcD9xV5DdMbF15nvmsLHEPgAKZDBJkdJUd1PviVjfcU7H6gs5eJQbRqaTly9Xg9u2dmI/dahMYea5yHh0+vOkjlZ72w+AViUsbQ9XBXH4d0/7KGhLkxfpNr/IBNRNyVgvjc0ZoG87MdiqAL5ohPS+4W1+yrnmNMOBhekg3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(316002)(38100700002)(8936002)(8676002)(5660300002)(31696002)(186003)(4744005)(66556008)(66946007)(66476007)(2616005)(53546011)(6506007)(26005)(54906003)(6486002)(6512007)(2906002)(86362001)(31686004)(36756003)(508600001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3kxNktXdEQ4Y1hOTThCSDNVaVdvZnpWb0V5eGZuTzY0R3NSUExtdHNBRHNH?=
 =?utf-8?B?VXB5czlzVVZSMTFQZ1FWNjNaaTJVRVlZaFIvdk9oNEdIRHhDTEk3M2Rkb05p?=
 =?utf-8?B?MUszY2J5WWZTUjdHTU95UGNSYlR3eDBLQ0pDTzZ4Wk5iZlp4MjhiZVo3YmxX?=
 =?utf-8?B?UTNRa1NhdUlDQmtjdC9OUkNMSFlpc0owakNKY2l1ZmVRSXU5QjJudm83eUN5?=
 =?utf-8?B?UVY3TW9PMm1pZHk1TCsrOVloVDYxMEdRaU85Vi9rei8vWGFDZ3BlODFLQ1Rk?=
 =?utf-8?B?N3AxQTJpR0tQM2toTytMZ3lUTzZnaloxTEJ2Vy9VQUFjOVM3YU45aktid0lW?=
 =?utf-8?B?WWg3Z3hNRWxRNjNGL2hFZ1krYWZPeHpybXdpL09pYnpsYW5wT3k0WEwvOUVB?=
 =?utf-8?B?aXpuNjV4K3kxTFU2L3F0b2JaemdtU2NhL1RqSWxtWUZDOVUwc1ZaQU42Mith?=
 =?utf-8?B?dHZPRURsb3lKYVFXVS9ZcVFIV1RYMFovWEVZN2FiNVZOQjNFOHVzSXZyUTFX?=
 =?utf-8?B?SEtEU0xEeWU1QmZadXJ6aXc1eFEwTjFZRjlENys2dzhvM1dhcWVjc283ZGJG?=
 =?utf-8?B?Ly92L2ZQMTJ2RkY1di9BRWRleHZBNUorTjRsK1FKWGJOd0ZyQWNKUHlCUllV?=
 =?utf-8?B?aWc0WDlmbCtPSWdoS3VDYVREejltMlFaUWJjMCt6TU5Wd2NudkhSVWhNQlVU?=
 =?utf-8?B?dFZBZzc3RDhBejFwZkx4ZWRLSlZaVDhES1BqOXUwNjcreEhsSVBmSk94V0tq?=
 =?utf-8?B?emRMN1ppUjdZdWZQUGpLUlVZU0RoK2JZZHk3aXlYZHA4bnZ4TWJ3a3A0WVVz?=
 =?utf-8?B?TzR3Rk40ZGZBbDZEaXo0UVpZVkErd0hwWEQwOU1wOUE0UERlYVhqUVArdkpa?=
 =?utf-8?B?UWk2UlZ6QVNlekltNDNEZXdXamJHK3ZjdkpUbzJwZTJnSTdaeGtZMm4wVEY0?=
 =?utf-8?B?RkluMENLV3pMakFMWTZoZkVqWWtKK1FGbHBhZmVZeVZSdGN3OFdvWXU0dnZz?=
 =?utf-8?B?RGQzdURjMVVJWm41N2d1aHVFdDlEN2I4aDUvYjZ1SDNESlBTRDdHdEhzV09J?=
 =?utf-8?B?YllmUGVZK1hJZjhYazRKdWg1NXlRMnBZeWlpRHQxQ2FteGdGTjFtU09Yd3Yr?=
 =?utf-8?B?QkMvb2xvM1NXWkMrM2hMcUFJMHpUSG8wUjRSTzlIT2lXREg3SDFDelVNUnEx?=
 =?utf-8?B?KzMyRk84b3JIRTJBc3ZZNEZNRVZ5U3lmQ2U2bFZwcFZkKzg2Si9OcGNKVXlS?=
 =?utf-8?B?SUNmUU5tTGd4RndRcmZIRXllMkNTVjJZcGxQc1dHemEvMHRLbWpkdWJnaEh3?=
 =?utf-8?B?Q0RDRXRRNkxWNjdoZFJieG1TK2Y3WG90N0xqa3g0RFBYQlZiUmtaZWl4Wit4?=
 =?utf-8?B?aWNQUFhTVklRcGxVd2taZ3FlQUJvZ09RbUJ6K2lrWDNOWmtBNDh6bmxGV0pp?=
 =?utf-8?B?MXdlc0E0ZDFBVXJ4K2w0T1FGeW9PeWNsVXBHZnduUExWQktnREJwQWI5S1hn?=
 =?utf-8?B?aXUyTndUQnNCV2hqMVJGZlFMbW5zalRjV3lmeE9PU1RqNERIRGc5MG12bU10?=
 =?utf-8?B?MytZVkRjS0FMOHBRZ3V1SXhPYWdJMUt1VDJTMXlwNVlmOEw0K2ZpcDdnQWhl?=
 =?utf-8?B?Qmszd2xlUmlpWkc1SjJxNnYyREhnbnRLc3lZWG13K2JCOEtqdXB3VlIwVGY5?=
 =?utf-8?B?M05ZSVMxTGJZMlllNklLN3hVTGkzTk9KdHgwWmN4L1U1SEVBKzhmTFM0Y1hC?=
 =?utf-8?B?ZnFRZlAwR3ZMVEJ6bFFKVFVvcG4xTDZ1S2d1anIwRGhoS3BNd2taVWpmNXVq?=
 =?utf-8?B?UUg4VUNCQWprcGY2UkhKQkR4dW1RcFZ0Z3haVDNjOXdpdTBWWHZpeTl0TnFK?=
 =?utf-8?B?WFZ3UGgxVTFvWjBFTTlhRi9JdnQxUXZhdmZ5Q3dPUW9CRkxoUTR5MURNOTlD?=
 =?utf-8?B?R21PeCtKend2SlRzb2FRc0JFL1lvTVV4a1VYQXV2dmlFQ2VQT2kwZlZlMDFD?=
 =?utf-8?B?UEFkSTBjMTFaYlN6c1dZUVRURkhQWUw4SEkzOUR1RG5qOG9DbmIvUFovTE5v?=
 =?utf-8?B?eXVpZmRWZTIwd0kyRmpRcENvc3JIU3VwMEZWUTBSd0ZWeTIzVU9OdUt0a1RD?=
 =?utf-8?B?SjVFTE1iejUveHhibjBUenJUTkZrNU40bG9IUWcwaVhmaVk5Mm9UQjJzN3V6?=
 =?utf-8?Q?bJsjnnFRN7z22a5l3DvsiFA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bfa36e-ca19-4f4a-b01a-08d9d4d0287d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:01:14.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jfc82pi7FDZY52b6it7mSlyX+NIrmLe3P2IWG29j/6fdhCpyk1LaBXhI+xirmQ1KfxYo1PmxT3aMqrAlZYyBGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3778
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> try_grab_page() only cares about success or failure, not about the
> type returned.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 20703de2f107..c3e514172eaf 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -192,7 +192,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
>   	if (!(flags & (FOLL_GET | FOLL_PIN)))
>   		return true;
>   
> -	return try_grab_compound_head(page, 1, flags);
> +	return try_grab_folio(page, 1, flags);
>   }
>   
>   /**

