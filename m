Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EF7526F2C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiENCzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiENCzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:55:10 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2084.outbound.protection.outlook.com [40.107.101.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D0B381314
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiLGXwqEprSre6+aRdij5+S4eG+UtThDHgcx46TGt7TIsDde/0XVFi3EzYsM5Wuu2+/+7oY6TYdmYopQXAJSZmSJSsnOVuqYXoRT4GjSRUWXt/SF//GD8d988b79ESJXZEeEVWPj4aAduyVyk7kxqrWBd/wjQ/5EVST1C9NX/Y+eUWnAfeyPr0VHkXVwN7m+lXSZyN7ks+dJK7sZDRL2/swIZBqEzL8fzGR2A9ZhggXcn52Qr3WNsWs0JPG5LiWKZ2+YOB2Hb879YDx0B3YuoHxWjUFV9UjhO3GuMQBf0ndBSxQ3mOSDSbEr36rjl6hz2QkENO83VSA8pn5M/G7gLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKNhYaITQXlGsXPpemM8JYG+kVtYTvvRwSk+5YSl8Yc=;
 b=gRcFRy4uDVkAOeRm8UdEuoaIrVN5kcSEoKclK/jhX10zn/Hgck7XGdyp1KZUsScUfZOrXBKLt/zGXbdNR0D/RM3cGUem/wYW8mHVC3ac+K7ceDMkDcmtQFNac5hy8WAiKh47joMjZjxMNSDVnjY0dH6nzMw1zpbKvXCd511yEqnwLUdsIGXVklDQmEAEA+9zZOhBdkyExp6GYAPqCTlrc1PpvCIOC5VNeCh4ZmkmTQ3VekFWInY9kMOE1bLwfw9BEACtNw5HWgWpCzxcgUQJYF/pJxxS2qaeTHIQ0FaFWmZhley23DU6rdpJOZa206TBoA1qjH5lcTptnoWv8+Lt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKNhYaITQXlGsXPpemM8JYG+kVtYTvvRwSk+5YSl8Yc=;
 b=s988/GBvbNh/DxEzjeEf1L5QS9X5z1s7vNK994IOKVOjNbQXjHfjGHm0qaVpqC3pYP6Yta8NjM4UPbBobIkxIw+HxehSXeWzoXuTpraTX027pN75hSabE4XLXnZUm3zFXYnDKbNL4w1RUsC/IUnr1l+sYUtIkyTN6SXxyWnLaQyLyRI0nY9TEUf1FErVUcix3AWVHk/1J6ttbsC/uXjSCZaV0qHum4hmtpQ2dK8MEBYAKNAi2epbSXsgYSyY7WcDbJlApJXRv3Pco/uSYOvzBH7QfEtRni89R0NGqOwDzi7Aclrp1cVLxr9EG8JJqqk9IrOb4zzSG9AGXRGPH1U78A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Sat, 14 May
 2022 01:16:48 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5250.017; Sat, 14 May 2022
 01:16:48 +0000
Message-ID: <1c6405b0-271e-22b8-961e-629a2a8bbcf0@nvidia.com>
Date:   Fri, 13 May 2022 18:16:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>
References: <000000000000ef451a05dee0f2b1@google.com>
 <00000000000077377c05dee75f63@google.com>
 <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
 <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
 <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
 <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
 <Yn7vnpXwX50J3K+7@google.com>
 <4809b134-a37a-50b8-4c25-44548bc1048f@nvidia.com>
 <Yn73Hz7LkSUv7ycw@google.com>
 <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
In-Reply-To: <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::42) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 759e57e0-94e8-4b02-fb58-08da35476b16
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2717C8C8A8A4E8CBDDBFEEE1A8CD9@SN6PR12MB2717.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: In5f1jTxODfLcXamYcgIRW+Dwd8KFMAj3RH93kHL7mXU8cJ3CmbQzKmZEMsmctFKKZhY4YfZYcThs/+ukLWesdJ/dl+USA8JN440lggeJcDIHr238JG2vlRg71lTzusQF6IxjxzIga60r8F2jCmQhpIZiTpY//K9jJ4MIaimoAHfaAQDO8od0ULQhjWo/C4ml+NL9uIHL5KpQahP2rCBNniqwiUIqJmpQ+9hh61d9JUNqjFQKHpiTna1Cku1DIzCaiTz1jFUK0SYvGr4Mnirr0zzu+blNmajhP1dueBqsYQvFsNgo2aVGKHMmuPiGSK+x6yJLXpNG+xlFOEsYJljKP2fs3/sXSTD8cDieKfD0MC69I9n2QUpKi9QQNkGycIX914AzKepWPV6mr4wc+MM1IHmw/jxflsmBxbyZwARaOlN+cOw66N2Hqwr7WI069vUuYshZhWDEA9DQVKd0YLZ7m/EVO5d5TDjuXN1QWr5578S9qHDI4eD2fXOhovoOKVSmu8iDgyUJllzpNow2uXhL8AlxaNslzWbu/EqgEYa8xAAtMHZcseT8YJq90gx9zQhlAGgFWrd/gLjO2Xt0ldY3SiHKKy5+Us6U3kNBlGAhpcTUknWCVnmKT/JkjDtpRnIIF6WFGzCHrONWsKhjll+oybreJcR//KqqnRAkdc8ezGovhzG7LWg6Irrc4B0a3MW3PzlA8ntWK/RpL9cBJ+6mXLnMCUFZ3pfkvCsa7lCn8nlphN2jfCowO28DMbc/KbZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(83380400001)(31686004)(2616005)(6512007)(26005)(2906002)(36756003)(5660300002)(8936002)(508600001)(38100700002)(6486002)(86362001)(7416002)(31696002)(66476007)(54906003)(6506007)(6916009)(66946007)(316002)(53546011)(8676002)(4326008)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M21jeVE5dytCRXhVT04zczAxN1ZodC9DVVg1UmxKWEoxUzhtM0Mwd05Oa0Ru?=
 =?utf-8?B?VU1qM0R0eCsweUxMYmxzQk50KzE2SVBYNWNZR0dsUmhrcHR4WTNUVHNpeUFC?=
 =?utf-8?B?Mjl2VDNiSTVDTUpMN3Q2UnNEeHZycjdKdkoxcmtveDBIT1E1MzdFRmlIYTB4?=
 =?utf-8?B?ckd5em8xL2NXcnMvbXhkem51TkVVeHRTbXBCZnlsZmc2OHQ5WjIzZ0RURjFo?=
 =?utf-8?B?SndSam1wdHo5cUpWbk9RajNoMi9KQkhWWmZZZWZ5L2ttK1crR294MjAxNDlT?=
 =?utf-8?B?Tk5jZlBGeHpQRlc3ejNGbml1WURrcVhlZzdMSTByOWJTUEZTQys2N2oxcXdU?=
 =?utf-8?B?cWRjeGhUMXhuZWwzakpOMXZxUmdxWEVzMlNMUHlJNVdzR2VOK0pHbnJXb09D?=
 =?utf-8?B?a0FKQXk1QnJtd2dTamlqRi85bmFMbTVIemFNNVFTN0R4RDhRT1pJTkdERXQ2?=
 =?utf-8?B?TitqTmlUK3l1ZE5ZWVFNRlgxcW8yRlVPYTdIRXdTOTA0cnJmek1OTU9lME91?=
 =?utf-8?B?bWVCZ1RDUmcrS0RmeGdmZlZOLzYxaFp2UTUySTFVakRMcm4xQWR4WmNzaE9S?=
 =?utf-8?B?Sm1FS2I5ZkxFWS9HbUVDSW9ZSnFIZkwvd1RRd2JneWZYZ1p6ZFhPbFppUEpj?=
 =?utf-8?B?a3c3WFVpclJuZUx2WC82VE5Zc2lVanZydXJtOXRKbThobldVbU1ndmgvQldT?=
 =?utf-8?B?QzRjQTZNbGNZYmJUVUoyaDZkNkV5a3hTOG96U3NWZ3R0UGRtUnR1QkxTS3A0?=
 =?utf-8?B?WGMyY2ZGem16eFZKZUVRQTdmTVM4dndUWVFlRm04RDJsUW5SK3V1aXlQanF1?=
 =?utf-8?B?VkpuaWdXR2x4TDhPcUU1WGVFcTU5Z252UzkvUUpQOE9MZTdDOEVzY0l6cXds?=
 =?utf-8?B?MnlZMHpTTkdHekl5akhHYzRSQktFd0JsSHMyWFZlRTlKSDNwZVY3RkpVL2Yr?=
 =?utf-8?B?aVpQVTVzNE54YVJoZHc1cXZyd1VoYmluLzJnMGY5MTdmTGRleGJqYTVxcXRN?=
 =?utf-8?B?YnpEUWxaN0tyR0NFWURvV245T1B3aTB1RFFDdGJHRG9iVHp6SXpCdkJ2bS9q?=
 =?utf-8?B?ZWN1VkY3Zkh0MkkrYmp2NVV5SnNENTFpN3VaN1Z4K2s5T0NwSlF0Q0l0V3U4?=
 =?utf-8?B?bkF1THY2bkd1Y2VOUWloTjF3S28yOGRZVXFxUHc3dHJweTJCRGtna25pQ2pI?=
 =?utf-8?B?dXZvYThmekVaem13OVViMC96Szd4VXBzR2VKVE13ZkM5TmlpNFdZL29pdE8z?=
 =?utf-8?B?MXNzQjZ4NTBSOW8zTGdrTThMeDRKZ0N4N241KzFKWUJQNHVkUjk0SEFxVFUy?=
 =?utf-8?B?UnB0RDNDTTFxbkRCeFdyQ2RwSHZVYzJkNEFJbWlWTS9ZVUFnWmh2T3JBYjVB?=
 =?utf-8?B?Nm8yb1pnNU1GK2syTFR4OEhsQmVKQnpsL0JDdnFCcDF1RzVTd09ZMkUzdGMx?=
 =?utf-8?B?eXJQdm41YUUrU1psa3BhUWFCZ0poeWtJelZJZEJJSFJ6czBoUmU1aDB1ek9u?=
 =?utf-8?B?SjU1MlMyZng5MDRFTGFVMXdzNHAweU13dnplMG8zRVNocGtpZytxd3FRcFVw?=
 =?utf-8?B?WStsbngvRGNXNG00ejVlNGZvbEU3MWM5REtQQjd6Z3YzWTM1NmE3Yk5ISHYr?=
 =?utf-8?B?VzF0MHh6VFcyTG1zRTdJM3JVZWFNcmlubXlGYjU4by9ZYUpSTDhuS253d3Vx?=
 =?utf-8?B?Y0pTYlJnUlF3RTVpdkVLMkVETklGVzhhNWlQQkJtRGNwV2JpL2J0eE5vRXds?=
 =?utf-8?B?S1N6S0Q2d2N1cmZGVVUzR09KSG5nOWRpZHNTaEV4cGg5eTZvbXo3djd3aVNE?=
 =?utf-8?B?TmUyWnNldFI5ZWR4NFArdWFBL1c1REF0SzlORjVIeFlYVEdxZWQ1T05YZC84?=
 =?utf-8?B?MlhTMjk4dWpaSnJ0Q0VsbGpxd2lKWG1GcUZRT0dhWk5pNFFETE01aXY3aHpQ?=
 =?utf-8?B?ZHVoNkhtTmdram1qd213SDBOWFdVOEdjc2NpMCtGU2ZVWEZYei9yWC9ZUmU5?=
 =?utf-8?B?dzBYS3ZqTEtyaFVHczVLV291MGQ5S3JmcUthbGRYMzdPY2t3d1lLM0hGaGpz?=
 =?utf-8?B?b1ZvRHhqWXhWQmdrVUNCQ014TnBuV3ozWDZFanBmWUFGTkJsWHlvZ0NyRDZk?=
 =?utf-8?B?a1NmRG1wclBIcGJHS0xPbUhOcnFtb01pN2pEUnhnK1lKd3U4eTZyUDgwYk9m?=
 =?utf-8?B?K0pPMjhMQjZTdG02MXpHb3BZcndZaSsyd1F3SDhVWXBNREs0aEFQNXBDNHVJ?=
 =?utf-8?B?RXZMOTJTZ1N5WitwOVZqMGlENUxmd0pTYjd2VlhvY0FsZjNySWtIYlhJczI2?=
 =?utf-8?B?TEw2OXNlb01ndFpjS0cvaWdSOFBuaHI5Q2V4Zzg4QjRNS3BRdCt4QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759e57e0-94e8-4b02-fb58-08da35476b16
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2022 01:16:48.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uPi5f4nMKQRT8rQEi1d6QvYBPfiwRwL8w4vd7FA2CaDO4p3WBFQ/2uiWiwBajDlV9if2EikHa8f5XgI0bf6EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 17:56, John Hubbard wrote:
> On 5/13/22 17:26, Minchan Kim wrote:
>> Anything else further can we get insight from the warning?
>>
>> For example, pin_user_pages going on against a hugetlb page
>> which are concurrently running alloc_contig_range(it's
>> exported function so anyone can call randomly) so
>> alloc_contig_range changes pageblock type as MIGRATE_ISOLATE
>> under us so the hit at the warning?
> 
> Well, yes. First of all, the comments above the warning that fired have
> gone a little bit stale: they claim that we can only hit the warning if
> the page refcount overflows. However, we almost certainly got here via:
> 
> try_grab_folio()
>      /*
>       * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
>       * right zone, so fail and let the caller fall back to the slow
>       * path.
>       */
>      if (unlikely((flags & FOLL_LONGTERM) &&
>               !is_pinnable_page(page))) /* which we just changed */

Specifically, the recent patch effectively acted as an error injection
test, by forcing is_pinnable_page() to always return true (if CONFIG_CMA
is defined). Because: MIGRATE_CMA|MIGRATE_ISOLATE == 7, which will match
any of the MIGRATE_* enums when checked with bitwise AND.

I suspect this particular error path has not been exercised much, or if
it has, not reported here anyway. Until now.


thanks,
-- 
John Hubbard
NVIDIA
