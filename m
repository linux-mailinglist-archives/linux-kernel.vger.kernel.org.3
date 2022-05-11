Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A919F524092
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349048AbiEKXMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiEKXMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:12:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532AD1683E7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbXWNIrixe3ctH756Zsp3U/YsO605NP2blFAOTWuVJPkziC9xSUEGpfqOBDheJyZ9Q4nFffRRr7UmFnimpSTIxZ79ajW+xYTcd1Y3hH7xOmDn48IvZUajYykB6g71ZBgBcbh+JyaUOCHoqd9wK1S5tJ7Gzd/suMeRi9fJ22Ar2qH3mGmI19RlCKdsgzBVbp0eZX/FSjgz+4P2Mf2wpeOz1UmCFWtQg7RL/EDnYFukhjvWMsKLWI/BjE+o9YjnPOHj79a53xV+NgS+En8d9QXx8OQmuL3o/fpdOkyJ0NBibYM5N4XLu3Ct70UqlXztNd7oc05ReS9tKobxnuNlIgH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFtBqUfOCsFrHEqi1h+oUo+5wlBEelYgMwLMW0MI0og=;
 b=i3LrOOFcS3FsPnRrIrcSlZ0xKPlaZOGw41kFchN+rcGi+CayMDwZd7cj/HqIhTbQj06Q4ALlPnY/t/W/3E1StyPYNUEqn+DZBMT3jkweFsquGWQ/W3MKiUomuZRYa8xsw7eEimlAE88+VTHcE1k/Snzh8TzqlCwei3+H7G26QN+6hbrNGIxpqjy6jM3terNmM7+sarU9tXQR5xqJmog5PLuJ0b16NasQfjdCemiUSrDCXmlhntoPAz190Y8iAWEsrgoZWsTe0KXCn+40f+ftClBjGxhSEl/SpT2TdgH84jGOttHOmqcrGzXwdbEYzociLG8dFqqqVnS+mr+l1XMGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFtBqUfOCsFrHEqi1h+oUo+5wlBEelYgMwLMW0MI0og=;
 b=Fqdw7+2PpsRXX3WOe8rM2wUNwEiin+0Nugefaf7Ab3dbYeUZInNYW6JPiGnLr8xSGVOPqJXDnsooiIDM5Dxsrs7gs98S41PD3OZOOnpYlPpCzmUsGKgANVLAZYP/NCYCDekIg8D5wFZG/QbpmIM8VyZiRs+YVfiED4/mPrdH0+fLLNzFhLtDcWKEU6yIKp5ISNObignAD/cxY+PemkVkiH+g/EP5GdDozwZTdvolhr2/w1TY5mIycLyeNx+AF/EVsY/BDMNzmONGCVSsCWLURnbx1VvhwfCSpkqmZElgVqCl+cp6v+20u8NaeZ4KEv7m5AM2RIh1jEKjg6lKixelng==
Received: from DS7PR05CA0046.namprd05.prod.outlook.com (2603:10b6:8:2f::14) by
 DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.20; Wed, 11 May 2022 23:12:42 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::5d) by DS7PR05CA0046.outlook.office365.com
 (2603:10b6:8:2f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 23:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 23:12:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May
 2022 23:12:41 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 16:12:40 -0700
Message-ID: <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
Date:   Wed, 11 May 2022 16:13:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
References: <20220510211743.95831-1-minchan@kernel.org>
 <857d21da-5de2-fa3e-b1ce-41cc1cfb0191@nvidia.com>
 <Ynr10y6pkH6WwbQo@google.com>
 <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
 <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
 <YnwupNzDNv7IbjRQ@google.com>
 <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
 <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YnxCCPZUfgQNXSg6@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49c258e3-4957-4df8-6ff5-08da33a3c02e
X-MS-TrafficTypeDiagnostic: DM4PR12MB6064:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6064545A829C4C14CBBE83BBA8C89@DM4PR12MB6064.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1r9cIjtDUNF/Ude2UUcwkcqYt8GluaBog7obxybyrocYFFhVkwetrwOxS+nzZuEk8tz+zG8gXfxXqko1YdvMiWQ4TNw3VhvAlsB0QdXZhmyNyTyAADSTLHO4Mn3dXuai36IoawQ3iH3DVk86WeQGOwRR2EMUuUYWreL+DcOmfPZ8xzZGHkJZyjpX45l5X4F1+cLNrjEZv3ulWM2NOtIXywaI2J72zGb597GprUj4em0XULtjt3ULtUAhn/ByJkx9+4QoiTxNLfsksLUnJ5U4z3/TRD7q4ya9/Aik4k77PgUGAy6msvoD3TAWJXSku3ag+mVwcOrvWMsC8sc18BiFXwphSARty4ZVF4/UDWK9LnxoOmQyevY31h9CXlXS3YHGbCwA1OF8DyMAnB7bNlNvvvz3AGKAcuKN5JUJA1G7gSg2GwE8BDUhM9vKs6vImMpZoi+fQ3xS9fIz0cx2YP+FK2jlkhKOMQmR9lq21GffpzakyHl0u60OinqKMfwd1n3WISqwqHOnPErvB4aM/kvuuu2k1Ue7klrxuknto96C3kNCO2U8i0wa77dn/RxAOepsh9KGcjknWvqhXgANkJ9biUFMaOcZ5CIs5MAFSEv+/I9K5gQmqG5skW9HIjPtMRP1lrFaxKntgnyMhxVQhHi80IkrLk3eRTHStC1W8prq2izSWGBiJFazuZqG8ipRzMWdhW6MC6jE61T6aUbS9heZdGTJKx+Fl73MdGrWXUzpG/0=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(31696002)(8936002)(16576012)(508600001)(316002)(54906003)(81166007)(6916009)(36860700001)(356005)(70586007)(8676002)(86362001)(4326008)(70206006)(4744005)(16526019)(26005)(31686004)(6666004)(40460700003)(83380400001)(53546011)(2616005)(186003)(426003)(47076005)(336012)(82310400005)(2906002)(5660300002)(36756003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 23:12:42.2051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c258e3-4957-4df8-6ff5-08da33a3c02e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 16:08, Minchan Kim wrote:
>> OK, so the code checks the wrong item each time. But the code really
>> only needs to know "is either _CMA or _ISOLATE set?". And so you
> 
> Yes.
> 
>> can just sidestep the entire question by writing it like this:
>>
>> int mt = get_pageblock_migratetype(page);
>>
>> if (mt & (MIGRATE_ISOLATE | MIGRATE_CMA))
>> 	return false;
> 
> I am confused. Isn't it same question?
> 
>                                                      set_pageblock_migratetype(MIGRATE_ISOLATE)
> if (get_pageblock_migrate(page) & MIGRATE_CMA)
> 
>                                                      set_pageblock_migratetype(MIGRATE_CMA)
> 
> if (get_pageblock_migrate(page) & MIGRATE_ISOLATE)

Well no, because the "&" operation is a single operation on the CPU, and 
isn't going to get split up like that.


thanks,
-- 
John Hubbard
NVIDIA
