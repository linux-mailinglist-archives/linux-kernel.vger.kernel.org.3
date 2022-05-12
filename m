Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572ED5241CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbiELBBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245021AbiELBBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:01:38 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2069.outbound.protection.outlook.com [40.107.102.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5276FD04
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsftNedSmVTwG1A+7axPJgD/11ZcVY88PuCcuY3yUfXNEwIXD5/hc5h/mFO9hHMTNX/hTxL6o6YbQLp2qYhJUjXC8uOyVto8oIzQkJ6EGAVvDUTGVieDvvXWOmwh3IXhrruE5z+91w0nDig3NUwF0o2YZnuaei+f3q5yOQbQYAA2NaWrwHtLl+/UB9xuvptTZgqa0rMWKxKb2ptUNA2VN2GgoYhKWacHnQgEHBdH5BVomJ/CNr8dXSoNW8LduX7VEBNip/pRJDmal+YJMconA0fR0qbOx8vzk8eK7urcjBAmxlr1EVxKdwgQ1kis/w0W1OBptTEwscA19aeXme7Zuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeiVZDrMAG6FIw3+mJvWfMKZyBVmsjrRlEVwVPoudGI=;
 b=KkweMajCtd9gd3+obvDoQq6ZRwLZtgre+tzKsws7kNDm0B/fyAVIvpOKks+vaLtyuLmVeQ3u12qpk9p7r6yFtEJpBcGfGHB89cBKLP7clVi7PhZQQe8lFanBv9va2vQGYi+1N8n2l/TDaZSCK6i3jsmUgsRr5OgwDinjlEiIqamAkVZPHrz8feDtG0Zm3UPnqGiPUN17DCbQOmn8y8mC5JWOlAdedwGv9c/x3JyppYIRFXWBFdBgdmSvEc0TwqZ7f9QJti0RXAybfmwSYF5g00t/a7Gn8AR9CiyDLra2lUI5HPU/GCplIoeo9EoAgwnVtJpTG1hKTK2C0HcAfbIKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeiVZDrMAG6FIw3+mJvWfMKZyBVmsjrRlEVwVPoudGI=;
 b=byZMvJg/xrJ2B8etMea3VuSF6G04fqC0DB1MnABbnYK1UchpzVIcNAdNlvB1MzfPFgaiy0YsJkAn9QHdJio09We5FxOykl+F1oeRky0i0OePqJ2774ZwgEeQcTj7DZTQH9tFlzlwsk9k33zdSGIE0Y7j9PPUM54kxuUMzWq4ioYG3bRKGqgDSfQfe1TQZlXTjrL4+bi6DLkDgZX6/oLkpYjB+ywJzBuwMrkp0h2ZxkvY3jOLj7ML/L6T3KMDS9KkG5CfZS/Ndzb9jp3796RgOvnotnyAmdeyOAZTvo6K8DjlgEjjIYTxopEYUTc5jELYyOS5VEHvx58V9aQVIbGaTw==
Received: from BN8PR15CA0037.namprd15.prod.outlook.com (2603:10b6:408:80::14)
 by BN8PR12MB3588.namprd12.prod.outlook.com (2603:10b6:408:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 01:01:35 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::35) by BN8PR15CA0037.outlook.office365.com
 (2603:10b6:408:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Thu, 12 May 2022 01:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 01:01:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 12 May
 2022 01:01:34 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 18:01:33 -0700
Message-ID: <2542a1be-f7dc-de2f-51cd-28a1ed5c3bda@nvidia.com>
Date:   Wed, 11 May 2022 18:02:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     <paulmck@kernel.org>
CC:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        "David Hildenbrand" <david@redhat.com>
References: <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e966772-c9d1-4b09-0617-08da33b2f67d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3588:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3588BD369E9B12ED4FBC3C59A8CB9@BN8PR12MB3588.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HrUKyjUebjePvv82T269kUk+dlf7pNZQpFlzFjZvX2SjOZMah+Dz/G3nTwL533jA2PAHbSWx8fRpLSZl6ciUS6mbM3OWYDVvzXqU03DmLqmgbT9ZL+nrifLlHLvfLJqYxBEyk8eImgkr/iZtUM1EcuR+AD+sk6QCnyYcS3gkofWIu5RhEL4AE2UsA55vQ0ZoSmEHEZulrjYurLdhvkhA5bwb9zbCx4QD7bMDdb27Vz/IaJF3mIz0nRlEsIQXXOjqtlXvxVj/cPKooA9IKrFmWA+slvLAvkQhABqdNazELK/r+Fqfvy12aplujF3uvCa37REtl6uZ0ZuUjTRr5Hze0XerN8oejNH/RrvS5p49summoDcwevv9KbUgAE9bwccn8qw0hvzxg3Zdh3EDN1Ijv/Dg79PyC9Qv6gdVXIy7Fk/lE5KDt8VHufw5iqZVxrZ9jggd5qOtUMZGNDateuvqs6c9fWNzxy6tkmuxAukYLKuq/X6eGHZ+Yp/x+lz62sdPwi+yFm4ph85h2S+ZTugkUpZX03RAKEfDQxcRosQcJoCINIoVWLZWlo05dtWruTxXlNCtw0vSAnz3cInc8UbLSL5ZvuLBAYdh13kTmNm/SfLfV+X0HooLWl3GTeduZHu5sWVZLomHVKMdgACEMIaDIIAYvyWfORpnizKTeSsMmFILXzXQD9cGCFd6JosIPec7UlWi7xSRreo4gKQ5kNBGTdCvBAjIHlw3gw5vkwQoVrDYNQCaP/L/Ops3iPt1RHuk
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(36860700001)(8936002)(31686004)(81166007)(508600001)(40460700003)(8676002)(70586007)(70206006)(2906002)(356005)(6666004)(83380400001)(6916009)(4326008)(2616005)(26005)(53546011)(186003)(16576012)(16526019)(5660300002)(86362001)(316002)(31696002)(82310400005)(47076005)(54906003)(336012)(426003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 01:01:35.7211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e966772-c9d1-4b09-0617-08da33b2f67d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3588
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 17:49, Paul E. McKenney wrote:
>> Thanks Paul for explaining the state of things.
>>
>> Minchan, how about something like very close to your original draft,
>> then, but with a little note, and the "&" as well:
>>
>> int __mt = get_pageblock_migratetype(page);
>>
>> /*
>>   * Defend against future compiler LTO features, or code refactoring
>>   * that inlines the above function, by forcing a single read. Because, this
>>   * routine races with set_pageblock_migratetype(), and we want to avoid
>>   * reading zero, when actually one or the other flags was set.
>>   */
>> int mt = __READ_ONCE(__mt);
>>
>> if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
>>      return false;
>>
>>
>> ...which should make everyone comfortable and protected from the
>> future sins of the compiler and linker teams? :)
> 
> This would work, but it would force a store to the stack and an immediate
> reload.  Which might be OK on this code path.
> 
> But using READ_ONCE() in (I think?) __get_pfnblock_flags_mask()
> would likely generate the same code that is produced today.
> 
> 	word = READ_ONCE(bitmap[word_bitidx]);

Ah right, I like that much, much better. The READ_ONCE is placed where
it actually clearly matters, rather than several layers removed.

> 
> But I could easily have missed a turn in that cascade of functions.  ;-)
> 
> Or there might be some code path that really hates a READ_ONCE() in
> that place.

I certainly hope not. I see free_one_page(), among other things, calls
this. But having the correct READ_ONCE() in a central place seems worth
it, unless we know that this will cause a measurable slowdown somewhere.


thanks,
-- 
John Hubbard
NVIDIA

> 
> 							Thanx, Paul

