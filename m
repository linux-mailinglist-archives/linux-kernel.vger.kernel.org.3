Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F6E53ECAA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiFFNjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbiFFNj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:39:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78607248505
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0KDgrOwBR+8Ty1GahEvAQP2IXxxqNZ4lhNMSE5zTdu5QmVMdTVe+FthNyj1CGS0Kn+7P28uaoQN0P3yATBjtTlV57AxHpKk26EEEU+MAxwq7qbOO9EsLmzr1V/5blSvjVbpDCNPjLTmL2Zo10bLjjbriMgX9RnjN54jnuE0IV3nnUWJcSc2tmxIh31AfYfmeHGs3NR+HubsMuynE5V6EPtt7CnnOQ8H/YB3HduGQaR/zwef/Z4Fn4bQlGfGCBPPSr5QVR6918NUq4Ha2H/x80+OMXtZ7q2wbMLM8vqJrfRE/iejUFj7HlyBWJTEDdqJ6UKWAhqzjF1RzRuN//z22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KORMxSlQAfDCxdTt5dGQ3CudAG1Qj65LvPBS7X4cmKM=;
 b=L6Z9QG0oOlNSXDejof+S8ytrbXI3AqkRIz/Eew6svc2DxPcFqwd2KEsI1Ahsd4B7Nl8glY7PbAP5ir68jSz8TmCeuHvRUaMtE+ONxncBJZmPWEOlJNYB7YXY995gZLZ7NsP/DC+C0sMe/gGbdhSTGvnPwwlSQ52mMmd4ohymRgWYFE6llbEmgF6+jvZ/5F8UypBNCJvq/lk3heVhCgnqlpiwq2vB/brvZdwAcSP26BXboZ8sm82VpzYQ6pdNX59fuhNYI7R9XK2vDopDC/PXx79yaW2fVDdrxRBscoKpAjjK9w6KtKI/faP7tToibxlkczSxu/dcpkL8IuHKauETcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KORMxSlQAfDCxdTt5dGQ3CudAG1Qj65LvPBS7X4cmKM=;
 b=iAhHndm74qwP0h83mEOtYqJtYJHESDET2xoThhZVb+gNI38beACtvWbe95c8fO1jhFC48RPezL1pc7AfAoD2Zy2Nwg+CrgYCTct2NFDC+kO5AWbrY2reBDqivLSGSTORqz1KxzRQYZZOCbJRGSqyabYTMvRmTscEpzrDe74S//o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DM5PR1201MB0249.namprd12.prod.outlook.com (2603:10b6:4:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Mon, 6 Jun
 2022 13:39:25 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::d978:617e:55a3:cfd]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::d978:617e:55a3:cfd%5]) with mapi id 15.20.5314.015; Mon, 6 Jun 2022
 13:39:24 +0000
Message-ID: <ff70d135-a280-1dc2-9f9f-f4b35e499abc@amd.com>
Date:   Mon, 6 Jun 2022 19:09:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 3/9] mm/demotion: Move memory demotion related code
Content-Language: en-US
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-4-aneesh.kumar@linux.ibm.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220603134237.131362-4-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81b16024-997a-4ed0-5bdc-08da47c1f821
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0249:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB024929487936B75561A5BF76B0A29@DM5PR1201MB0249.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbOKepzTwYWhQPL7z5KNNiLKfoy+9ox43T+Tejw3NdpeRGIMbzz5dNw8Iyjt0f5LwH34LCUS+g2/ofkn8OG3mm/kHVrjnQh1Fg0jFEVb1OzBUz6AsrPUv8TERpDWOiTr8ufxNFRqM8g0F0G3BCW1lTkiwvPNPfu9CrXAYY35OFsAkR4LtTQzGg72T+Z5z3QvMEG5c5GU2zp8VmKG3oIKO57VhQ6GCSjy31IfQXen9zCgYAz5gcvORpm0HTDYYofOpqM78PeBPGYK2MEeOfb3kp6y+xJlNj0bXQAaKiCQjFX94aQI1LtuJrB6j3g+SQ20Sbc64bCQfxSLPYzxrzTuc9MjME1WTwGFt60PPXjNVSnODRX85DzWNkBeZZr3HP2fI64+xly2HhVklipnj35lEO00oKprw1YTifRFqU+je4ChCM65b3rp+Xi+14xvW+ZbtK/Vsb6zDuLnGzlE1Pad0pPfeYyJC6vg+WxmAm6QSBVQq/HOeFR3uOynvwo2WAnjA7ix5uOkGP8gipShQZrORLkczKoMRkENg3izZxZN7SA3bZfr1MGBqu/J4v5OYRVbm5xShuzA40MDHD2cOHhYsy4za/KQYutugIxM/FON9qXMxGfz9XHoaQVYmukf0vkV+oln2EmTJlVoEJgl81MJn4IU7666gNszUa3O/jpJgyjrox/RBuFHl0e590o3bGWSYH1YTCnHItsd/kb0pYtk5CVBBE8zSHDSxEJ6NKQrkDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(26005)(2906002)(6666004)(38100700002)(53546011)(6512007)(54906003)(558084003)(36756003)(316002)(86362001)(31696002)(66476007)(4326008)(2616005)(7416002)(8676002)(31686004)(66946007)(6486002)(66556008)(5660300002)(186003)(508600001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFVKNGhEaTdEWUoyaHRBcUYzL0cyN29HU1RMLzRsdXRDVUJnbjhPMlcvRlJ3?=
 =?utf-8?B?L01XQm9lRzdGR3BCZGFJZUdEZ20xN3pQWE5OYThOQ0lvenIvVVR5dzIybERT?=
 =?utf-8?B?SzZnb29rdUVhWFIvU3hIQ0orL2FoaWtyM1pPNXFkVkc1c1QvVkQzSkdnVFM2?=
 =?utf-8?B?Si9oL2lQQWhXTDU4UTNoUU84Wm90MHp3UFlsOEY2d3dZeHRyQUZVRHdFNmx2?=
 =?utf-8?B?b1hOUHRBaXhHaytib1lpYkFRVER5WHRidXlnaWIvYUN3elV5d0NCWDBETi8v?=
 =?utf-8?B?TDBjQUEwVlM4RHNpVHgrNzVkUzEvRkJrYUZCQ3NwWHZ2MnRkR0J3TDVBZmR3?=
 =?utf-8?B?bW1GRiszNWg0UkU5aGFCcjJJS1hPZDErdHo5dTNVUHZCSFY0cUtjRUJ5WXVU?=
 =?utf-8?B?cFVXc2NlVk0rbVNTSlRJWGg4dEljS3p2Zk1SZzlFZERWQlo5bjU1eldDcnlM?=
 =?utf-8?B?RDIvN2FQeHhNK0kvd3ltTkZ2OCs0UXhveXplWnNoRHJ0SjRBVmVuVW14dVZr?=
 =?utf-8?B?RVFLRnhUekpRR1Z2M1RKOWY1Tnl3aE9oRlVvUjE4UW8yL2JETERBekZDa0po?=
 =?utf-8?B?M1JXZXova3FKWWJNMDRpU3RHSlZ0aFRmRWJRUnU0U2ZuUGtXdWd1QlNXV0hm?=
 =?utf-8?B?YmxFZW4vY1FaVE52cUFTODRSV2M4ekFBMTdmVEt5OVlLYXVzSFdxMDNESVlR?=
 =?utf-8?B?bmM4ZStidzkvUlpYOFZhbm1PQTVpaTBjVmNmUG9PdEhBN0EvcHNUUUZROWlS?=
 =?utf-8?B?dWltMDZGcDN5eXZKZm95UnhaUHBOaExuaUtjaTZQbzBFb0oraHJVaXNiNTFN?=
 =?utf-8?B?UGlwU0RCU3dWR1M0aGtYSG9yN2lwaEJFcld3d3J4cnFwSFhjUTNFSUt2bi9D?=
 =?utf-8?B?WnNTUFJpSnR2L2dBdllBRGlRSlVNSkdkVkF3YWNUaFd2Ti8renJSSUxPdGtB?=
 =?utf-8?B?MVlxUFdFcy9BTkpoclhpblJCVkthdHc1RzYxdStIN21TZ1pvRTBGZlhKV1VD?=
 =?utf-8?B?V255a3Nla2RQaHVENkJSVGgwWEpacFByUmIwc29DeVp3bjhXelpzU3dIWHlO?=
 =?utf-8?B?K0h5YS9xVmVKODdreWNHVzk4elhKZlFicWp0TXJVK0dVYTliNE8wNlUwejBN?=
 =?utf-8?B?RFN1SU9jWkdWTEFlQ2dnYkNvK2NYSVRzTTFBMnlLMmhCL0dUaGxkVnAwWnc2?=
 =?utf-8?B?MlZGSXJza0U2OWxRRy9BSGh6RnhUK2I1L29ERmsxeTVCcExnMHBsWjhPMjRn?=
 =?utf-8?B?YTFRVDluTlBYU2pDTWg2YTA1OVNOeTdhNWxwcEsvOHVJT3NzM3VaSUtyV3h1?=
 =?utf-8?B?WHljejJ5WHJmcC82SitUODV5YVQyZHhOcmMxUUxRMGxsaElueEdPYkkwSlhq?=
 =?utf-8?B?aVlReHRGd0dYTzhIS1QxY2VINGNDbHp3TDlmLzlNUFZyeFJaWnNvcTZ0UXBo?=
 =?utf-8?B?eUtzaFc1eGxmZ21VMzRkZGplL3hZdjVKRnNTT2xIclBLM1NkRHc3RThpVHJ4?=
 =?utf-8?B?ay9ZdnVSblZCQXNJRUZnbEZManl2L3dVaUM0UUpKWDdzZHVveFRXNWZPWjRK?=
 =?utf-8?B?MnI2S1dHOEQ3SWVNdjh4UEZ3RUQ2cFAzUldXWXBXQ1RaQ2gyU0ZuK1dsWTU5?=
 =?utf-8?B?SkJRak1EWFJzbDkzTSt3STBmclZhSWgyZnBYMmxSRk9jd0g0UldkeXFGYUdx?=
 =?utf-8?B?V2xHU0Q5Q0ViVWtlUzNMdmFGdUFJUUtZaUp0TXYwMGtTejM3eEFiemJmNXE1?=
 =?utf-8?B?YWxrS21zWk1PODBtL0tJSmRKY2NpenZZSVAzTDRuaGUyaitXYUduOXNqdFMr?=
 =?utf-8?B?RlY4M3c1SVdjYVVHUG81dmVuMEl1clRCYUdnVElHdEtrREUwQWQ2b0dPMjZV?=
 =?utf-8?B?dC94VFQ3WWRybFJZTVhXUVFWSGVIcDJ6a3UrdXpVTTAySXhORlU2eXRsQ1hU?=
 =?utf-8?B?Rld5aWpPa0czdVQrK2NyWGZUS0xJcHJOWk9IRFB5ZjdMdUh4ZVJMWEhIekth?=
 =?utf-8?B?Z2hrOWtya3MxMFZ2S0Q1aXZvTU5kQWR2VVcybk9NRHRLWjNNTVZreTRlSk5X?=
 =?utf-8?B?Nkx6L0JQbUlLc1AzclU3N1Zza3d5aVpXOHkzYVVuMHZVSlJtTStHdVlIeXBN?=
 =?utf-8?B?aUt0cFVVZ1lSa2I5cC9pdktuYnpGRkFwQU5Ka3N3NzVHZjJLS1EybWhIaEZ1?=
 =?utf-8?B?NGM4N3N1SDdNbW1IejZ0MWhFbXg5MXdZMXUzQWdIOXJaeXdQSXE1ZVErV1dm?=
 =?utf-8?B?YjJkOFlTQnlxUVN5ZmtxakUwNEtyL0pwenU5dnM2THcxSXdTRk12cUQ2bWdo?=
 =?utf-8?B?MlVxUU9KZ053RU9Na1cwcCtOTnNqbG1yUld1LzNOcmlwTHlBRFNIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b16024-997a-4ed0-5bdc-08da47c1f821
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 13:39:24.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LINZ4t8uSsSzna2knWAqSg7qsUov50L0MCcAT3YmjxhD//bPEdy9aAkDi6NONGC4eskF6LKQSEKAuoJ0rkZ6gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0249
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/2022 7:12 PM, Aneesh Kumar K.V wrote:
> This move memory demotion related code to mm/demotion.c.

*mm/memory-tiers.c

> No functional change in this patch.

Regards,
Bharata.
