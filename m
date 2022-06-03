Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F953CA49
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244460AbiFCM6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiFCM6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:58:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D4F6265
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCRSS23dg/prnQ7Fb+P3UkhKhMav4v+9GpHk7ugvCDMLL0+zZEp9zqsg+3BqFyfbTCBeHy15H6QszilHiPJ6ICMRv9V4OZHt5UUlCYsoBTaXmLY9MO0Wj4lHgrWH359QMte8bGOpyLJSYBbqzYia+490Y49CSdRo8ivdhazeC1CVeZxLoORXlOxeVEVCDG3W8DdhRkQfvO2G4bsodn+JK2h7aB5XuTMWgJx1fLS12pjed9DnE9yyeb+rj1kSE2Xcre8QpbMtunDHwOIO3QWXx6JuwOH6+a5s/Ps7UnKuDnVEEb449O70LTfqRV9bcLhoTRqWhsW/RwPrWxnDuF2gbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMyQfc+ZV9jAng8liWiRO3/Vcu2D63OsS8YpKTasEJQ=;
 b=DkSZs1KWZ26VvlMCuQsLIgMfjWWPIC1F8Tc+aJdUuD5GBStS8JOL02W9nJwp2fgJaD/L22TA/rmz1QR2vXz10byuZrZfeGmTSZDFOgUrd0R42i+pRPyBhMm/vN/mD18Ohi+6BTnNW+YlW2NF1r6Db52WLF2YYqvWdOY+v8Ibh+jzetxZjmWlhrOoLimflpoAeni1yj7j6LzhSa8q8WJjzZPrYlOslepbZogvJXQCxyI/YNEh8ZyiBQVVyz/9hiYpGqpXFBIwsJsfTcD1fknQ2MuUjYeYlJUsgUDii6RCYjWEnLg+dBdkRuntQTpMKwj4Pl7mLACmdZYadUZmdblkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMyQfc+ZV9jAng8liWiRO3/Vcu2D63OsS8YpKTasEJQ=;
 b=iSTV3SL+cBcUmvJlLrPAUxekUvPChjxVtu0fUUB+btXBbcY3iTlaoyqyIeg8a41KCvmeVuqiRqCc0GzNA0+4jRim+NqRxGFZF64Vr7+wlpYRvH7CniU31gar95+vKRLvCL9VIcGpPOFRNQfx74LEXPOdkKB/WA9Pm/0q1D+XSBRkAnoUufvkp16X1EKkX/fLvYYnunpI8WsJpFKTawORFK4KR/w+A9VjJApOEd49NvbrOTu7CBYuJds8VQL/IBT4w9aUMaQW/T5nxDrSFFR1CrIez5Pni9XqsW2reg2NsLuMyao3JmMSb+e6w2NOpN28ZqJg8BE+wT8CxzfnfppWjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 3 Jun
 2022 12:58:49 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b%5]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 12:58:49 +0000
References: <20220603071233.2296100-1-apopple@nvidia.com>
 <YpoCPIdsDrBLdIsV@casper.infradead.org>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap.c: Update comments in filemap_fault()
Date:   Fri, 03 Jun 2022 22:55:52 +1000
In-reply-to: <YpoCPIdsDrBLdIsV@casper.infradead.org>
Message-ID: <875ylh9a49.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00cdae65-61d6-4edf-4439-08da4560cd68
X-MS-TrafficTypeDiagnostic: DM4PR12MB5770:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5770BFCCF530083A6BC88835DFA19@DM4PR12MB5770.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CeHDyCK9ixQd/LfZssar2vhCtS8M1H9TTXL0DrM1T8goe6LDc/qkCa/L3mekEGpZVON+3Smu6eRJN8zr5vHiCGKoEEWc2mfLSoSis2eEueP46dm/pqFeirNqKX1sVxKya6p6eZWT6qGr8FPu05dNAM8knWl81G2KlzNDDqJ9guK1uETVFvwTlHq+EfCP2/yvZmtgoRu3MqfUEPIBUJIdd3VI/N60WwpoJC22cT+WfMHteWW90kiCwyVCuGtuPxtnoI0qWbXZE41Sujfle9sDl3rEhT6n5+c+tejgTo+Jt5Jpc93R+SgLIKoD/zk7LRCptTrUfEN9Wqq0nOnrj4++vGPJEqzNjheyi+zrdMyBrhqGToSQGFaIRJyXBxEgYfX/XW43FjKG+OoKX2U9W+yhFieSA7xO6kvU9kvoQm7Z43rTNImaa2hMbSXckWEJ5SDcWU9cgTIdqikATQNxS8aL/IRUTwRz0W/EUv6CHoukH1/KBN9tQN9A8XG6Pdfo33iDxz2+EuGu4Q9HtG1xYc87+NZ4z9vWXgnG9qO0a86zrBh3nqeyHSki5AXFk0Dluncb5iHuPew04UXVS7VzjbebmSTjwxl8QoLgsBCwLKQeaseOjqimfVw+JPVB3q7DFwOv97429oetPUqKKstf+4cZYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(6506007)(2906002)(83380400001)(86362001)(8936002)(38100700002)(5660300002)(26005)(66556008)(66946007)(66476007)(6916009)(6666004)(316002)(186003)(6512007)(9686003)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v4/y8t5FSjcZtrVPRX5yDmIxVwW/UsKLt2EGAyaBUi7fdCfqC4fVMtkeVnQp?=
 =?us-ascii?Q?ms54Dkl/5vJ+NGnsI8zyNy8H3kiZy8aygBq6RxaUDnI/CNikNiNPKrtoJQu8?=
 =?us-ascii?Q?wty+GSYakLtuRmr/Y0EGi+QbyxNjxqwhRjio1jOimTJfzbdUrn14MtOUxgne?=
 =?us-ascii?Q?mxNSsMVtCP+05/tig6vkZ576gInY9yh0o9nmjvgSEYiaxJT2TZ3g/4Mwuyxo?=
 =?us-ascii?Q?M9ftE+t9NCyyEvpmwaSoBI+OBKzeZXCZWAwYIBRCdSi6vdtqy/s8ND/EJBmM?=
 =?us-ascii?Q?PJ0M4ri5qeKBfKUuDbxgeW9EXD0TzOhNLy6wdiJZZi5JBLW7AgB5owPYAXcf?=
 =?us-ascii?Q?pbqitU8fJaLYaXICSMCDbe5cNhDn8KX/TTKBKTs1kkazGs6A8c/MS+usWrdy?=
 =?us-ascii?Q?sBkXeDt4l/717EI+PY0RMDvdpeWTRulUejIXSZOyYxXDKViq6yQeXfhppWz7?=
 =?us-ascii?Q?0DzfCkBE6GoYq4xP7NVf78oPL9PJd/fj/Zhl8y4Yd4otx1MagpkQIzqhuaCq?=
 =?us-ascii?Q?hPEnYY/GgbIU56momdwTJJw8foVDZzfOyvN36Z9TWZsIYATiUMS2mGRPaLOu?=
 =?us-ascii?Q?QBbanwsTw6Rm1pb1SJg41MeV3+vGU/Ud71/2/cUQVXP2Gaunz1HYUyZY10tn?=
 =?us-ascii?Q?/8WRMhJql/2bOIBY1TaSaTLNiubGp/5UwoBzqr92PqoJfrr+l+fyVyYJn+8t?=
 =?us-ascii?Q?L0LIg8cosBxzUNA6zvI6GJ9Cp61/oXm9NL9a7M0LvzXbVvqZzC6r9Di8E/D4?=
 =?us-ascii?Q?5YboYaHOmM0nRff5/wcedsGqh9a22RH55nX3FwpNy5AjeK7GORVUUX/vXuzb?=
 =?us-ascii?Q?A0N80GYj+kAd5VyNcEB4wo5Upex7Zu+eAG+xne4cCRy1fgXroerffkRn0/68?=
 =?us-ascii?Q?IGOA8hLznDxX81K9XoW37BetI5xDfenQ7kfb6PHe8s3Ba0o7fJy1M5a8M31w?=
 =?us-ascii?Q?ho+iMaKxKKgGmUrMXNsRewmNACYVR2iOV5R90nGdu+Lqmv4YBAN0Ck+CGcjZ?=
 =?us-ascii?Q?/+2ccZZIWvD6eDv1YY818x6LrBU6O1e8zK5w4POzEXT48Lc6pP9eHZZQBWpX?=
 =?us-ascii?Q?jPuzpiVVQzRi6sz8ZAw5C+XghHJQb5tI3xomgtP3pyeH0F/IpYRMHszwvp4R?=
 =?us-ascii?Q?k/00qh/FDJT8aLQoor6lR8nw9XjmrAmCbM7wBSagaLEvWuHMJpFdoFJO2sAE?=
 =?us-ascii?Q?7Czm/wvc2TnE5MA8HVfu/gFZwN76y4SPLwF5Dj/L8MgCX5bMOK0tkmQkZzLD?=
 =?us-ascii?Q?4Oj4XdjnzOWxOp6jEvmJk+wVkQW8neW6cBsobGIp6eE/vmN44SFmMd+qTvJH?=
 =?us-ascii?Q?M5LLm3Vw6b3SenFfeRadPoH4954D48Xw+/oy02uV2dxSJBbxxg/Gr84Qo/Eu?=
 =?us-ascii?Q?LOAajDXQymXBBkJ4ilbmHobubDAOOPLQuW3/rKzY/aPYfC6n2BW/mlTIuixT?=
 =?us-ascii?Q?0elrLaKhWJ1zGph0gr+MG+CHjj1JcfziQzx+pYKjWscVjZufzVu+rEcGi5OH?=
 =?us-ascii?Q?9mWFGKPaQQlwOE92ErSBrJ7/a9wPnJWzGRhdyUWLtn4atzUQ2F6N2haPb2l5?=
 =?us-ascii?Q?0F/nWtw9VwRhZajwWes5lXEovtUbub73JOHWmxYwNdqDYNwRP+G1GSnD3iwf?=
 =?us-ascii?Q?bgHoNZNXDhGOuEl1/ck3J5B2G22XqBQqP16xevtTrMOZ5OoiQl7IAFYKyePm?=
 =?us-ascii?Q?zgcqwGmcByjHShHT7M2TFqoJMRkaY1tcZahgj8jpb7IPSMYZHmbJx+4u/6A9?=
 =?us-ascii?Q?ou+KaqXkeA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cdae65-61d6-4edf-4439-08da4560cd68
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 12:58:49.4966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fp+cn/PUpBPbahyw3czMLvnuLmp1SasivRi1JwASCHiOhKyg5Swp+MoiTyV7TNjbdpCfZ4wuXpsK1JaLYLR7Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Jun 03, 2022 at 05:12:33PM +1000, Alistair Popple wrote:
>> +++ b/mm/filemap.c
>> @@ -3168,8 +3168,9 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>  	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
>>
>>  	/*
>> -	 * We have a locked page in the page cache, now we need to check
>> -	 * that it's up-to-date. If not, it is going to be due to an error.
>> +	 * We have a locked page in the page cache. Check that it's up-to-date.
>> +	 * If not it is because there was no page in the page cache (only likely
>> +	 * in the case of MADV_RANDOM) or due to error.
>
> The comment is correct, but the code is buggy!

Ha!

> We should be calling page_cache_ra_order() in do_sync_mmap_readahead(),
> even if VM_RAND_READ is set (or !ra_pages, or mmap_miss is high).
> At least for one page.  That would allow us to drop the FGP_FOR_MMAP
> flag as page_cache_ra_order() will instantiate a folio for us.
>
> Do you want to write that patch or should I do it?

Thanks for the pointers, I can do it.

 - Alistair
