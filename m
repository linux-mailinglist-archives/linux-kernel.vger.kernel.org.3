Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B58B5AD69C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiIEPa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbiIEP3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:29:45 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80117.outbound.protection.outlook.com [40.107.8.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E3A6410
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fqi51JWAbWqf0veDsR7qz/PPhHv++LqujMU26OTwApFWyRJv3k9aP3uEzvXZJ6quZHyo46GDy7gnRs+EQ1zJf0IlH5yS4YUS0ApSC4WkBfPHe5MllyTIXN11xUI4W0qTZIKsIghZaJ+fMhj9lkENHaqef7XfzIdffegdpl9E7Qs/6oQqNSoGf1n651Uc7vsLcJr4xu6xaHr3o/8VnfC3GiZ1791s11NnvtEwd+bsWx2v19goBnoG02MP1hakEISyZ7njE3ZhnIENRd9tIrLYbrZz2VbJdCZUU8CPBqBf3C8rpCIBACoIDdOm5XVll3StL+YO5dUMhffh6axS9Sx5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqqFoZBeOWjlgGBY8whrOB0QCiuQvuJPZI1cf/8bcig=;
 b=fbQc5pQp7xj7fGhaTPRSJShh6ZtE2bohEe8ch56gj2NxekXz9TkUDPmdMeqTX0T8FBqJfJPoyNN3C6IQ/L0BjgeeeMrhv4DOvtCrydW9HLHebZYdPjpjwjE6mMFu8l0j64rwPsttti/BOqLTisU2aFJVgq+5+Wi6jW3VYcF1j4KQq2KmeYsULVHwE9IC+tGGtHtr2zjHb5skGQ2PDlnL+e7h9tEhhEBubJk+TII29x9Ln0c2UUuv0nV6y4pkQuPXw132YMuPTjFn7tr3k5BxbXP4tXXU0y7ehwG7wumh4B+EfYG/RFrH5MnsehDxf77u6/9XKl0m+z6fqEw9wusOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqqFoZBeOWjlgGBY8whrOB0QCiuQvuJPZI1cf/8bcig=;
 b=w5NR5yYAEb2ESMF7qoo68Uyt4P7xWJH+eSKssWxVoSYDUJ0qjAjH96VG383xBxVcXZJ5dKlxZ54NcDHn/CiF7Isw40GWLoAGSB+w/+G1rtKUgu7kgkXye4l/mPflrxkWpqvhg/vQeKUMJbnSqPxCiKA2A/ZAPYCY4z1YJ8zVYus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com (2603:10a6:20b:4cd::12)
 by DU0PR07MB9161.eurprd07.prod.outlook.com (2603:10a6:10:407::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Mon, 5 Sep
 2022 15:28:39 +0000
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::b333:1f3b:1b01:50d9]) by AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::b333:1f3b:1b01:50d9%3]) with mapi id 15.20.5612.009; Mon, 5 Sep 2022
 15:28:39 +0000
Message-ID: <66a173c5-553e-8788-7e9a-153382f1f9a5@nokia.com>
Date:   Mon, 5 Sep 2022 17:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] ARM: kasan: Only map modules if CONFIG_KASAN_VMALLOC=n
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kasan-dev@googlegroups.com,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220905122754.32590-1-alexander.sverdlin@nokia.com>
 <CACRpkdbdKAWfvpG2n-eJPagV3Sx1faaxC9cEFs3PTyDaxETwyQ@mail.gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <CACRpkdbdKAWfvpG2n-eJPagV3Sx1faaxC9cEFs3PTyDaxETwyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To AS4PR07MB8658.eurprd07.prod.outlook.com
 (2603:10a6:20b:4cd::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR07MB8658:EE_|DU0PR07MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: f9485fa3-53b4-4f64-cbbe-08da8f534eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMVZ2011ygruPfpBmLQOH67/XLvgPkQQrn+pYmWvX1Q9Q0ZcPvsmIZNhxK4tZoab3UKEimkootpf+GeOglKCnU+Ru1BgaE2ff50f+2cSeSQWYyvZloKpSQACfvl8cD8PPtLZc258WYqtglPzakbgC6GOxOe7vG9LPrlZECrJOu4xBudp1JR8CRvteajQWHwyKNsK0mVI3MrwE21NWMlxWoFA+QSmPV/89rEt2IkpzHbnzdhI1qjoOnhaSUzLhf3r07V2BCUc8d0wI1E/QcVisgF4FNMuAcwRhGDcOkok2pme2pGNxQPuVKnteH19ZDS5fAwsUXumgoZ2sApOLKfQBYsR1YdLVHHid6GiQYfzmJ9Ue+nhXAAyO7k1eyiODZZ6CQOmKYYtDPWlgCUNhHmiCj59TpeDYB1T8SytNM4G1op+pIvv37Yun3jB4M90bA0VChf2a6oMEvWSQayODK6zmqZ72M7cJ6ZPXvIWH3xj9MoESZK/Laui4edrYQ6ULvMCbZ0YPhHwcZjwccicmdopKr1PB26UerwYbFLGmbyWXXm2kSNen3veyQ7ScGdFHjT/XNnJw+bFdqP+D0pBxrnJ9S5AnDJ2aScp2wouyDkKO/Ih0Co/wm0WnPx5bk/OKDJKA9N4b6a1Z2R6lKxSupHGXYPrkwF04JCWct+DEP8b6WrM2cdhjtPtEqgpBKROvtFE2aM9nms+97YDs/BdLRcgpoi8RLcrILs9d2hlyXE9pp+UT2nnDiCIkwkI1HHq4SFISLv6DJH+8ww7GgllZYiDeOS2svmQk5lxaEXQeanvR/mCG6mEEJ2VfIxo41+vbMxiB2HSmgo2sApcixOQsONbMv0xvKnxDlIXCi0cSXfHncM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8658.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(6512007)(26005)(38100700002)(8936002)(66946007)(66476007)(8676002)(4326008)(66556008)(478600001)(2906002)(6506007)(44832011)(31696002)(53546011)(86362001)(41300700001)(6666004)(4744005)(5660300002)(7416002)(82960400001)(2616005)(186003)(316002)(36756003)(966005)(6486002)(31686004)(16799955002)(54906003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WktYQWhneG5tTWpBY3E2U1RwVjVac1E0L2JubmhrV3lNV3BzdFBjU0hwQ0Z5?=
 =?utf-8?B?TGdZODllUnRReW1Ddk04TlpCNjJIRWc5SkcyYkJKV1RLbU9UemxPbHUzVHdI?=
 =?utf-8?B?T3QxN0VTRUhrQ3RHRDR1RVZWODdSZS9pK0JBMnl0MG95OGkrbGxDeUZpZ0pF?=
 =?utf-8?B?TnpoUjQ4MjJLUCt3VEc0MXVIMUczRENldm9oVHVNUkpHclR5MC9yQ2xDYVUv?=
 =?utf-8?B?blErNkljQzVpRGVKRWtJc3QrZnVvWWZBY0lsVXV1eUVhVE9VVDlrMzZnSHc5?=
 =?utf-8?B?UGRHOTFpcEZMbzhUT3ZNbEdDZ053c1pqSmNlSXd1dXpCWis0UDRrSUQ2V3Zl?=
 =?utf-8?B?cHdISkJRaERsdlBWR1JUOGU2RFNXY1MxZzJYR0U1TWFSVUhJWDFENWplci81?=
 =?utf-8?B?UmhYbXZ1T3Rpb0d3SVNpUUJteE9rUk9OeGtKcUt3ZnpjbUtSYm1KV1Z4TlNv?=
 =?utf-8?B?Z1puVHNrbjBEZXVBUHVicjFuTXNHbTRqclZZQldQQ215T2dZWjBjQ1BsUGZ0?=
 =?utf-8?B?OEpZYUcvamVtZWMydHNPT2ZJNTNaTVdhaDZLRTdkSGs2dXVtbDdPczJEMTVa?=
 =?utf-8?B?bnRxL0JFZUd2WG9IbDVtYmZmZU5XbDNJNWpoc2MxYkhiTXNhWXF0WmdGOWlP?=
 =?utf-8?B?QitxSlI2OWRtcmpVa0RvQVZCV0hMZldDaDZPWW8waURlWlZUSENmVVpja0hN?=
 =?utf-8?B?cFByK0wyZzBQc1p6eVJUMnduV0FzM2NEdVYyN1BwTkx3OFpFUEVLNnFGZ1J2?=
 =?utf-8?B?UzlrTEZWdDg4TDc5ZmpQNndMdXM3bmdSUmdycThobUdIT2F3ZXVpU0Y2T05O?=
 =?utf-8?B?ZWEzbTV2UXY2ckNGYWdJWWNvTnRjRGFjdWZBODJ1STdZbk8zWk9pZUR0TFFU?=
 =?utf-8?B?amFNVEpjRHozRCt0aTU5QW51a2RlbCtnV28zZURDYkt0MGRxZGZGRFRLVE5l?=
 =?utf-8?B?d1pLUC9Va1BCT2dhMW1JQjNOVDVpaFQrWUY3dUwyL0ZrMlZWZXRHbmttOStt?=
 =?utf-8?B?NDBIV1pTSE1iN0VnelRSaU5ENWlBYk5RTEh3MXg3YUtZZmN3TDlzVWx0cGRx?=
 =?utf-8?B?ejAyeEN1RVdZTXUvN01WWExJSUc4c2lCUW41V2Ric1dtTkh6NFNUR0gyRG50?=
 =?utf-8?B?Z01YTU1wcEFCMWx0SSs5T0dFRU8rYnBEb2JjREZYVWw3cjFxVTU5SlRjSEw5?=
 =?utf-8?B?OUZNWDdxK1hlWHF5R1h6MEtPcjFhRkN3bE1JQS9mZGNROU9VWHAwcGltTUtN?=
 =?utf-8?B?V2dORzRhTkpKYTFWOEVmQ3pDM0wrcXo0Q1NFRkJvRDZBRThYL1FodkpyRGdx?=
 =?utf-8?B?TWVQd2pzZmlWRXR5L3FDT01UOVluN0lLRFgwTFl1b3c2YVpHamd3NlFSMzVy?=
 =?utf-8?B?am1RTnpWTDhRdEN0ZDN6MWs1NnZRM0N4dFpXZFFiN0I4d0xubFBoWHNrT3hn?=
 =?utf-8?B?OGkzWjBiejJya1BJaTVIRzlvZ04xUUxOQ0Q5bkFPN0lwaFRHc0tjYkdNWGdn?=
 =?utf-8?B?Y000eEVCVVdnbkNhZ0ZqL0ZESjFjQ2lhQzNGclZVbW4wYVczeVl3dlBKSElS?=
 =?utf-8?B?clpqemsweE5VWTZyc2lwcXVIL0ZNZDFTdG5zK2c3NWwwVk1PZ0l1K3lnM2x6?=
 =?utf-8?B?c2lsVXpjdis4SEdkQmt1dTYwVnJIbEc1WmNVakwwUi9tR056MVFVbGJnQktT?=
 =?utf-8?B?WUNvRzVYbkxlaXB4TDNSb1ZpUEZpKytkY2RuQ2dKV1VRTm9oMlpHdklsTDU5?=
 =?utf-8?B?cEdUMEo3MDRpRHFHczlIUnQyVStySjEyVnNHWXFBN1JGc0FPWHNJSEx0RHMr?=
 =?utf-8?B?ZWJ1ZHQyemVyZkF3OVBNeG9xOFRxUFIrK2hoWEFLem1XanduQXFrdUVWcVFi?=
 =?utf-8?B?TTNBQUdpc3hyWmpiYlI2ZlJsSVNhc3UxeklNTTVlQUtCa3hvYlkwanFBZ3ds?=
 =?utf-8?B?clJrVDJjY0FnbUVBczh6UXpoQ21XdWdGY1llZFVBUWNPQjJyL1JkclkzTXZI?=
 =?utf-8?B?OEYzMVplay9EQjhwSE9lR1NOWFNNNDhCTThoNkJJUUxxMnRLVElpRXVob01t?=
 =?utf-8?B?OFJWb25Mb0psbFg5YlZnSEtZT2gzUHV4OGRVbUxEQnZKWUhpWW02WnBxUGNa?=
 =?utf-8?B?Q095Y2NVRHg2OVZ0RCswQW1iVlk2clJHNks2SWZrNm0vTzMzRWFtWVg2Q0lo?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9161
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On 05/09/2022 15:38, Linus Walleij wrote:
>> In case CONFIG_KASAN_VMALLOC=y kasan_populate_vmalloc() allocates the
>> shadow pages dynamically. But even worse is that kasan_release_vmalloc()
>> releases them, which is not compatible with create_mapping() of
>> MODULES_VADDR..MODULES_END range:
>>
>> BUG: Bad page state in process kworker/9:1  pfn:2068b

[...]

>>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Thanks Alexander, will you submit this to Russell's patch tracker please?

done!

https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9242/1

Thank you for the quick review!

-- 
Best regards,
Alexander Sverdlin.
