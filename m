Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85BF513AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiD1RTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiD1RTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:19:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577F040E70
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sfn9f3uHCRgKRwhqyF/buDLeTWMNlga9Q2tugPDsCyYy/bO5DqnKkp4DHZZE5dAVDttOEUxH0xt7lUJrL9XvtYdMZZpGU3PZUKNpw7nhq15fjWLKNL4o96if6IJ0UnJD8IloagNFst8oiS41YLvUEOmFgJfjQ1g/5Xi+8mE2oqoVltNyDpoLK7svELzpg32uwZiXCZAj/c121DSnw9ywM3EPxn1yS+uqb5vkIzX8TQvkGHveoy3q4Qp8jKb2gUrxbRIQgWdzfcxeYqh8ElgVIPayW/A42AmcuvkFiwP75uDkOEz7ZF5qcWxFRHuk2dCJFxROINg41RTyEz+/+vfGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTEhagI//WdAiZPlt2Pb5DOwPTSp3btELFCt28ZukAQ=;
 b=MVTq4UYtHANTGog2ekfE+fIvspYxO13QMuf1HRNIkx7so/mp3GhdNnWHgXXnaWvDxfC6xcLLmFU+x27PhIrjCe0EhPoSVNU5lwyM4HAnL8dCEXipEc17uIpogN2QmLpFZ+rqzbSq1JIkbCiufz9A2L409rYjKAwm3sqaO88y0NySgutal/gPthiwqhZYbloedMLC+9zjIeOmml4ffNqKDozp0NYpw7Yd2izPOjIer8d4p8dG6uywBkgTFl/7U70snkt11lJbkQrkQMfDhYsC/+r1zWvCroZA0jLCd0ibOd0+LvQII1VlM6RDKPztLV1bvSaDPv/q+4SZE1ETtuyBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTEhagI//WdAiZPlt2Pb5DOwPTSp3btELFCt28ZukAQ=;
 b=y/h4GdYUnuHblY5qHgD4PQ0PaiHkeLfnI4295wvZYcKbZX0EbwtueY4SnUPjVWeiTZw0I9znW8+ElGqI3Jsri7S9jsn141/MDiPbDXoHkpYH1CrLZ6+LIk+KUXghJTSiFHQfWWdxAGnXwmR4dnV22N3V9LrhNXwcYLnbZ3NItKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MW2PR12MB2428.namprd12.prod.outlook.com (2603:10b6:907:6::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.17; Thu, 28 Apr 2022 17:16:33 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::9894:c8:c612:ba6b]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::9894:c8:c612:ba6b%4]) with mapi id 15.20.5206.014; Thu, 28 Apr 2022
 17:16:32 +0000
Message-ID: <015d68dc-aa38-1823-68ab-f66d78124d13@amd.com>
Date:   Fri, 29 Apr 2022 00:16:24 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Set translation valid bit only when IO page
 tables are in used
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, vasant.hegde@amd.com, jon.grimm@amd.com
References: <20220420112920.18091-1-suravee.suthikulpanit@amd.com>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
In-Reply-To: <20220420112920.18091-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2P15301CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::13) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24835970-f60c-4939-873d-08da293ad72d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2428:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2428AD631E754D5893A48CEEF3FD9@MW2PR12MB2428.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STkpTiSYlMht2jmIgp/Ut5Wqju2RTYvsW1ZAmfnbwqz17B8MXdr5dQ0h9UK2qrqQWBGQGhOvhOeQ1F0pnaqGctkbL/p07uPXlB3jy6/mukM16dBqNFlKlfnU45H0B5X7WIMXeJvPyUGNUc3AVAmk+geF5xTcx4seCLvtk6bt77J1qJJbmyfaAQ48/3Hsd8KtQTnRKHuJs4EIrvk56NFEXupAsp8zHHHz20ZBHHnEp6uw19gBPtJRp34ynFS5QrIqGNU7hRJe+kYqJhcUXwwQ8ar2jfHEwrWnHh1MSObprQeao/VCjAkGbjqxa0onqIHaiHHke2UEPEGncfmzwT9qC+rvfwTnVhoVErD8AuHHfisE1nFeGwecVPK6bIKdm3TIep33GFXb1GYMw5a1W/+4j1GjQIBwtsrwYlqJcknUJN2q2ZUglwd0agf0+3FYAf2Rh+xbDVhLOH65PngEm+XLgO5Cj+BcRGWaW2o/5dWpr1F+87EqPQdju8lGkaly1yVZbwAgCXaKM/Uzdxw0x0ft1Y5y39HxeR2S56e1/cmvrGGGHQBCLFW/BKD4b6P4UhRQJGybzBGeN9pNaX4reaX523y9ClprA3L+GijwQBOwGnCk1XHNicLN8uHyCTsmB/5MHzgHOJ8HjIuht/Wv2ldc6bJRabn9HkcWfDyatRmq2YhZyc5SyiaxL/E0qr8B0dVdtl32bLCdJV1fXxTTt2fsxeVgUB7Q4/5l3D4n4NI6S34=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(2906002)(66476007)(66946007)(66556008)(8676002)(5660300002)(36756003)(44832011)(8936002)(4744005)(53546011)(316002)(186003)(2616005)(508600001)(6512007)(6506007)(6666004)(26005)(6486002)(83380400001)(31686004)(31696002)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDMzemNXK3BtNU5WRDZJSlVwdVdaMjN0eU9pR1B0bFRTd29TSnFUMURLWlNo?=
 =?utf-8?B?OWZWL09qdWlURnBsT3JVOUlYL3JEWGxJR3k5SnZ2aU9rbnBJVTg2VXlVQk9T?=
 =?utf-8?B?VVZhWklWT3JqUG54aTM0V3daNEJWRFhNVCsxTWxqV2ZVVitQQnFBSDNrb2dp?=
 =?utf-8?B?TkZyamdyMXEwUjdDUmZQdnpqVDNLMVhBTmp5UG5CR0M5VTZuSjhKNU9SQ0Zu?=
 =?utf-8?B?SXBCcjAyQU5LYkZxSjZzYzQyUUN1U1M1Z00xVVJaakgxNjI2d2RFSDlaUTc5?=
 =?utf-8?B?YWNEUm9laWVUaWdBUmZRZUFzcEtZdHBNV2F0NERXcnVianV1TFY4R2VzZ01K?=
 =?utf-8?B?UGR3M2wwUVVqR1JQYWlqSm1sV3ZXNVlYUjN4bTJZdTJCaldXRk40UGx4byt5?=
 =?utf-8?B?SU9IRnZXUmRuTnhEL0hVZmFjeUJkbDVScWlKS29PdWZMN1BBUnM4THJZdjU1?=
 =?utf-8?B?NEk2VUJtRnhvR1hFTXZlT05TWlZ2eGtBQzVRbTEyVG02cG82Q2FueG8wVmx4?=
 =?utf-8?B?ZFRYZEhyU2dTL0pYTWw3THg5Sm82SUl0RzE5eW1RT25CRGRuM3hSYVU1NmRl?=
 =?utf-8?B?ay9DbUdCZTdvMHA2U2ZISUpqY0FvTkUxRFMxZ284WEdFK1pNdGY2aVF6OXdt?=
 =?utf-8?B?ekRpWU1iNlM5UUp5UU1SS0VXeGpXY1JGdXpLNmtudFRzS3k4aUNaSTRkMDFj?=
 =?utf-8?B?RFVwbFRBc2JDRHFtN3h5Q3N6dUhQMVJQcWlTZFlsL0xpU2R0TDBmTmUvbndz?=
 =?utf-8?B?SnpJVGlPSmxZRWxablFvUnFnQlJnODNCRXh5TEh3alN5VGdDeFpuam1YQktl?=
 =?utf-8?B?Ymc4SGI2UlQwQ2xvSm1yd3FYZ2ZTS1RoRFU5RysxUjBDb29scDFHRmYwMk1u?=
 =?utf-8?B?ei9MSEtMSXAzeStNVUt1QUg2MCtvQ0l1SUxQRThpZ0VjMExWbjlkQlVaNEFG?=
 =?utf-8?B?d3AxRVZBSTVIZVR4SzhOZVhFY05COG9GOWt5bG9SY3RNanZ3RDh6T0tRZmNE?=
 =?utf-8?B?TkFOcVloc3NrS25QcldPSStoYTFrb0JDYUN5M0EwcjlsNWJKa0xPTmlnOFEr?=
 =?utf-8?B?V08vM09jNjkvZmNXZ1BNR2hHdm0zMm0rMGhtYnc5YzFDL3h5U3g2bVY5SVVx?=
 =?utf-8?B?Ung5b3VhQTZUNGsxSFpHMEtpaTRHL3NwT2ZoejdNL3dDdTlvdkZ5MEdScnBS?=
 =?utf-8?B?TUt1NU42dWJ6dm9oemZaZmY3aUdNZDFOR0pYVUhUekZ0dnJMV0pjWnVlRFZ6?=
 =?utf-8?B?aUxaK0xEOUN2R1BjSnRSQktEbE50YnVpTGNvZlIxRjBXUkJMK3lBTXVwZXFP?=
 =?utf-8?B?MmtqUGpMUUk0MUI1OUhyQ0hwcnJnM25PV3BXL2JyUmFlc3JwUXhRZ2JDRS9F?=
 =?utf-8?B?WTBySm82emNJWEJqUzZMN29sa1JqejJ5WnpBa1JmMzUvZDFTUGg2V0pnRkUv?=
 =?utf-8?B?S2w5TlVNQ25oU0VKZjVySGgxNUNSbE5jcVJseHMxWXpaL3lwaVhvRDQ1OHE3?=
 =?utf-8?B?KzIwN2Rja0t4anNFTWQ1U0RKQkRVWU5STXdIeEdIQkpSVVl6NWRoUU83bC9x?=
 =?utf-8?B?NzVPdW9tRmhnd0szMExlSE1vM3dURzE0R2RRWlRmaVkyRXAyZFZJeE1JSkZV?=
 =?utf-8?B?Zm1NWUNkc1pBeUZFYm0vOWJIVjkzTTJwY1ZRUU9HRlk1K3AvYjdOL1FyYnFJ?=
 =?utf-8?B?Vnh0OXpRRzFJQmlDbTBqc3FaL084cjU2SnFmQlJUZHQ2YzI1dHZsQTJVVVpD?=
 =?utf-8?B?TjdSZWRTRUR5VUdvTlRueVRoRFVJbUlzMk1OOXVzdGUrdmJzSmJIQWFTaU1S?=
 =?utf-8?B?VmdKSzhWdnVnWHVrVzhKTS91bUxsSlFvNzZwZjZNYUJndGoyZ1Q1RlFVblRL?=
 =?utf-8?B?aWtxUVZ0U2lxKzBOZGFGY2Rya21hYkFGdnloSE5OdFRuOURsdmhiNHBEWFNw?=
 =?utf-8?B?K1NRdmRLaVRUNkZiYmgxZVZYQ1cwTVVDOGZTSk5kL0NTNGdYV2tqeWgveE1T?=
 =?utf-8?B?ZCs1c3p1R25JNHVRVkZWV1o5bDBzd1YyVkhnbDBFbkF0Zi9wR1hWdGJreFR4?=
 =?utf-8?B?S3ZIQml1c1djRFdPaEt1VUtNRHlMMldFVzlMTHpWVnhNbHFWTEF6TmZTcTNF?=
 =?utf-8?B?VitNT211Z3ZHdFFVc0dRUEpQWDlRd2JxSmtzdUFoWUNVOTZnZjFpcFRCbWRp?=
 =?utf-8?B?SmdYV2J3emlBRGlGNmk3cjhwdHZDSkNzWk1wWkRFT0s5SjZnaFFiZEluTllQ?=
 =?utf-8?B?TkV1ZzhXa0g3OGxpMEVMNmhoU2VROGRvbzZ3RTIzQmRjWEtBMThtNVpvREtZ?=
 =?utf-8?B?MytDcE1qZUhXajYzc0htaGVpQmhuY1ZSdFZ3N09uNEhNaDhENVdpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24835970-f60c-4939-873d-08da293ad72d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 17:16:32.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YofZY0DEMAqq9e1h6f539NsgeXeJpeVMqOYIm6xQgv3mtPhuoLKZP3mltQvVsOd+xSGzI6vOqnSnc7f7oCyxdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/22 6:29 PM, Suravee Suthikulpanit wrote:
> On AMD system with SNP enabled, IOMMU hardware checks the host translation
> valid (TV) and guest translation valid (GV) bits in the device
> table entry (DTE) before accessing the corresponded page tables.
> 
> However, current IOMMU driver sets the TV bit for all devices
> regardless of whether the host page table is in used.
> This results in ILLEGAL_DEV_TABLE_ENTRY event for devices, which
> do not the host page table root pointer set up.
> 
> Thefore, only set TV bit when host or guest page tables are in used.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>

I found a bug in this patch. I will send out v2 with the fix.

Regards,
Suravee
