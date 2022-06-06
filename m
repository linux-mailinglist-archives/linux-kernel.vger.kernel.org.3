Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8828253E2D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiFFISF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiFFISD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:18:03 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79914D243;
        Mon,  6 Jun 2022 01:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl0L+dVOxvu+i9zElgIC6htzdlD8QShO0Ln/xz884lUrwFpOrYuI0b1jXTPxhiOnWCg7CRF5jYsA7/oUgXvplyWoHhgFoBqyckbRBasumGC4KHcxT5/VRQ+qOJC12ZSS5ScxHK9sJ3Tj39Dh+hvs8oc48ay6cUIbeWgLDzfmHNa8gdkJwQVlnWSFC5IhtbFd8my4ycHRV6dkQ8IGcx4Jl2nIFxDAi/zeIr1dXFAPOCbFLYAHLt+g7kx+zD1wNds2HluvrBJ+iAaEOvHF/AcrTFNxl0AwjB+h9Ckwv+tgDoCAvjGvlymXhpEK5zci0J5zsF71+VTkfN4V4gkLiMWShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGXKcMlsvkGPR7qh7EoU9l3P0Ro25S80vVxETCM9I6k=;
 b=i+PKHjdG5OQz+2vcHfRKAnkjwyocAPDFNIubDhI1+vtViJBmp3PHz2CpEXOIgDlQ6fR8N7qYYy0HicbV0aTXY4H9jDd135RehG68tMrtKqMoazjDd0shdyOoR9X37LswaSucSF68vCE7s/a/rEm603fYN2U696UNgZ/cZuEXGY8yGQfuhbKESrE9iZs9rGRFk+Pe915KoOZL3yXFiad5opZP07r9njzoMXS2mCQaF4Ix3DQjTbRVLhJV4IoLbFCsem/K1C47mu4KQQeqktwtxuh4pzC2wrCiPT/3OPJp+teAvjpB1pN3MVeMY9OtRt5v/RMOo2T9ysPi/r9ywGASrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGXKcMlsvkGPR7qh7EoU9l3P0Ro25S80vVxETCM9I6k=;
 b=lsy25EGnocmjPS0OToSWvcLTGHhyVCJSIlyzdfzzdqZOGhYRe+5/6CU1u5Ub0XIxO1jr4P9WDY59CwwpuGdzF7hAMMr4OG1JZJtENP7iS9XxCRUpAcgA/WskKNfyTCSwcwzN4jW8sxrT85UVhb6xEtSTCcLTf8ej0eKZltbVNSycEPdakvV4HyxnkuX5ic0JbhW8Qq5A05MRypgE1vJ/KrLmBp55zGbWnFlhNp+lNbhGdduvYSEjrmJ62VMyMJGDIRarayRb0aWg7wAz3XuBVwBmpbu+wo2UzA4oK/kK2yrf6j7cr38GAxrVnErM8XtFaMb753P24pKfQfkUuZm/eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 08:18:00 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::16b:eff7:847b:19e7]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::16b:eff7:847b:19e7%10]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 08:18:00 +0000
Message-ID: <b70e024b-4f80-16b9-4bbe-ed8a24a384df@nvidia.com>
Date:   Mon, 6 Jun 2022 13:47:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/6] ASoC: tegra: Add binding doc for OPE module
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        perex@perex.cz, tiwai@suse.com, jonathanh@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
 <1654238172-16293-2-git-send-email-spujar@nvidia.com>
 <20220603203003.GA852734-robh@kernel.org>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <20220603203003.GA852734-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::13) To CY4PR12MB1576.namprd12.prod.outlook.com
 (2603:10b6:910:10::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86460810-abd1-4fbd-63a1-08da47951198
X-MS-TrafficTypeDiagnostic: MN0PR12MB6127:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6127694EF436C789F8E0B56EA7A29@MN0PR12MB6127.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lw5a1Xxe23rRr8NRFrhOCxxmluRvwOSxBcNybbRYcTQgXcFcc/bLo6AXJGg3Jv06QSkLSuA1V0dX+Ws7JDehz3Vx+Tt+XarYEoQDurdyZRRxKwvs375pUN601mY4j/l27QYtD55/UVxnmatn3HTxWc4whtEMMg/b9rsSS0LT6WrA6Y/ltMfGa8HkQgbN4/TGbqQWosPkDCoG0tykBpn0TR5fFWSFMrcw/ZpKKV/FSJ0qEBJBd6g0EI09KXqGtM8ujIRhaPXaeJ9Jr5r8y9jwO+QSU257pJ0UQgt3XfzOgGTpXy0JJ4rl5twRfuUrCCu/inYkO6XuZT2X3K9su7hj0Nrjr3VlESiA+ApzRZEKsYfuOxxSkZ17WvjJ6OyseY5IdJJz+utoHxpGJXOjlP3ZClAIzv9BcPVNrfv5dYR2O5ttbvfA6EpA/tm6jTZofR6ADIdGXyQ3jbkiG4VcmTM11xR0J/S9Yq32ETn7Po/BiIsVuRDmgfdKIVTRWKDLz1ky58xvKdwDDxM3VXVPVwSeXXZEYfGSUIhnEwLR0JjK5a7wfbAsmWScgUn/Mf6lGeGEA4dbQr+WE354QaYAzU5UQZYd38RRZ9aqXA/0Cexw1L2Vj0jgKaUQ+EDIAstQGA012EVQSo5p9J0Q4ZD8WcPU0NjhUtZr3pFB98UFuVHjimffXqfK2rwp1A0+2GDveNmSzhTU0hNeEdQCgKJr3hl76BaPCMKd6U+fAiFGoVq5lbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(31696002)(66476007)(86362001)(6486002)(186003)(66556008)(66946007)(6506007)(6666004)(8676002)(4326008)(53546011)(38100700002)(6916009)(8936002)(36756003)(31686004)(508600001)(83380400001)(6512007)(7416002)(2616005)(2906002)(26005)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWV4eENPNTZiZ3p0dEIxVHVQSVVXaDZhbkppd1FiQSthN3ozV01WRThBUTg3?=
 =?utf-8?B?RnR3cjV3VHJ5ZFBzOStEb0FubWkyTlRZQ2ZFUVVqRnRDRjM0MFZBcnlOUUNX?=
 =?utf-8?B?K3hzOTJwekl0dDF2VGJOc1hUNmlmVVA3SFJ6OGJlSUhDdFNDVThNSUFORVdj?=
 =?utf-8?B?SW9xS01VR0QyVEdTUTcrL1NzaDRGYktFOU02dGJ1Z2l3K0Vjb1VlQmZ3WlVh?=
 =?utf-8?B?RTZyNUI3OEszRVZ1TFBJYjBxZmFocFBrSVl5SUdoWmhIZ2E1UTRzdVBOQVBS?=
 =?utf-8?B?ZjB5UmZ0dE9wQjZUbDZ5UktGS08zamZHY291S0w0TGNPWlFkQkw4Z3RWUnNT?=
 =?utf-8?B?eU5LT0xzR01FQUtQRktndlpFVkhBcjdXYVlLSnpiWXdMYVVOaXNlRkFGMmFk?=
 =?utf-8?B?RCtzTG0wMnFvekZnbEVCY3ZMWkhKTXc1NDJ6ZHBwM2lPK2pyT2ppVXJ2ci9J?=
 =?utf-8?B?U01CdWZmTW02OEJpL2prb3IvdFprdXRYRXhZalBybUx2UUZlek12aXp1ZHFB?=
 =?utf-8?B?QVM2VVkvaGNPSllVb3BpUGxmeXdJZ1FER28xQi9SYTJNV2hYYU1TVTRoUXhH?=
 =?utf-8?B?RzNnZVdndFNDQU9zWDJsSk9PVk9ndGticngxQmNXYmdaV3R0Sm4yK0VXK3Mz?=
 =?utf-8?B?WmNuNFRRYjdaOEV1VEpIMHdMRG9rQ2lQSHVBM1ZtUDllN3duUTRuTzNEc3hO?=
 =?utf-8?B?TDFDenozZ3NsZ201cEJwVFZ4eDJSSkU1YVdSS2pMOXhKQUZTZ1NPMDBiNnN2?=
 =?utf-8?B?YjBrS1JBSTVTVlJmUmtGRUhwK3doTFkxcUFsenhvd2JCZWEvRC9aeVhlOE8y?=
 =?utf-8?B?TlJTdGswRTdsaTVHTnB6TmpQT0RoVmZ6bzNUTWlkaFdxL2pIMjR6MGh5Y2t2?=
 =?utf-8?B?ZWpoV1ZpV3FKT0dMd0M0ZzhsQ2tQbDd1YkJUTEVkbmdOSVR3Qjh2UFJHVlJ0?=
 =?utf-8?B?byswSC9JMzVkQmJDVGlhNVZSNkhhY3ZUaWtUUHVLSXdGYVRYcHB5WEpxTkFa?=
 =?utf-8?B?N05XWjllN1dnYjB2ZlNFMnk5ZjVYRkhZZ0c3SUs3TE1mM2FSRHpaZUR4R2JC?=
 =?utf-8?B?eDRvVUo2aWVlbmhWZkxuZGV1WWRGbEpaTUtwdlhKeU1ha2N0Ukh0WStGRkhl?=
 =?utf-8?B?MjFZdlBQV0tpNVJtUWpxRHhTWU9BbnN4dGk5dWxkNnlaSTJHUkkxT2xDQ3l3?=
 =?utf-8?B?WmlENExnbXdweTZiNHk2ZmFJaEZmTjhCVitjMU5XaHd1Rk1tUHpYdUJramVu?=
 =?utf-8?B?UFlEaGRkWkN5Ryt2VnpYY3dTNVZweERtNUFNVytRa2hKbDVkaEJMRURpcU9w?=
 =?utf-8?B?dFRMdFhQUmZXUmlmNGRxbmQxOGJpQStydmErZXFDNDRmRUFXN1ZpU0NIRHBo?=
 =?utf-8?B?bmdxb1JJMUkvNzlxQkMxai9DQUZpWk5TczZ6ZXdvOUU5d3ZjSHQxdlBhMkY3?=
 =?utf-8?B?ZGZLL1lIMHJoc01lVGxLQzdWbWVNekc1K2VZY2lUc0lVaVFzN0tPWFRXaUF4?=
 =?utf-8?B?N3I5TEM5c00rdWF1dnZZNHJ4Z29NemNybG83Y0trSkFqY05iZ2VKSGIyZ3V5?=
 =?utf-8?B?aXVZNHRTckxCVzE5aTB3ejF4cW5nN3BtaXdCdk41cW1sSkRKWFVlTC83azR3?=
 =?utf-8?B?T2Y3Rzk5RXVNMlZrMitMS0hkbkwxNThEaDBhNHRMeTNhekNWTDNnR0gzb3BI?=
 =?utf-8?B?Q2Npc1BZbmtaSE1RTUxvM0dKWXhDV1pTQldDN1NDUzZZeHNEdGViK3pvSm9M?=
 =?utf-8?B?dlhVMjRSYS9nd1ZLTGtsaUU3OEx0UEF3ZXpWZEFrQ2ovWXlUUFFnSlErRWd2?=
 =?utf-8?B?eCtSZ005UEN0Mm5YQTFnb3IxV2hEMThkNDBBZDMvOFFMSUErSGcwZWdOak9O?=
 =?utf-8?B?K0crbHB2NHRHVFU0NXJNRFVnaUsyMUFxVzkzWitqWXAzSUFEekl3c2x0cnZm?=
 =?utf-8?B?ejhWb3VORkdaRVJmZk9XZkxkNTFEUUtYRDg2dnl4V3ByNk1QeDNPY2lUY240?=
 =?utf-8?B?U1NrV3Y2aWh6ZS9pNW05NVUyaHRGYjNjSERzS1V2NTQwSEFWTkJxbldQWUM4?=
 =?utf-8?B?RzVMaThXTGpDOEJ3UzErU2VqTE90RFdZSjlMMXJxMzFtdkE4dnFpUnd2V0tR?=
 =?utf-8?B?U0VJaGZ0OVNleVAvUk5tVWZHc1RxZlhFQkhURnY1WDRsa3pqNFVoYlkrL1pC?=
 =?utf-8?B?NzJwY29tZDJwSnVhcUhxTjV3RGtCVG5GV1pPNTErQk1KNWJ2dmlFOUJGTUFq?=
 =?utf-8?B?aVFnMkJwS2FMa3FlcFBvNWpkZjE2dHZqK2RNTTZybitRaUJmMTBJTE4vZkM2?=
 =?utf-8?B?K3dHN1pQOVFRd2VhVmx4cm83dW9kdDlqMHJXTHJDcnNSbUgvUjFBdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86460810-abd1-4fbd-63a1-08da47951198
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 08:18:00.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhUUErsIshzJt5fVT3uFgeKTx4dJbRy29wh4t/RaqnOLKVONscm6lZeXAWUhWXJtdU3IztO0KlY/mH7I/AukMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04-06-2022 02:00, Rob Herring wrote:
> Doesn't apply for me. I guess there is some undocumented dependency
> here? Resend after the merge window if that solves it.

These were getting applied fine on linux-next.

Merge window seems to have closed now and v5.19-rc1 release is out. I 
can apply these cleanly on v5.19-rc1. Please let me know if re-send is 
needed now or I need to wait for some more time? Thanks.

