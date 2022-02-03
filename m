Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF74A8FB3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354603AbiBCVTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:19:40 -0500
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:38753
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231479AbiBCVTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:19:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW8lU96uxcw4csuR0n2OKV9Ufz5/Vhwj8wD6Yk2QiTSCrYhDwvqvwOGnpxK+JiEbYdSNHYBjd1JFYI8y4ioMXlXBvcMVemx2ZVuK7uwMGJN8U6vuQuigxy80p83x4pfdrwrs41tPRt5jc3Y0ATOwzs5fvXDNe7JXlxw7r1YewTwd0AHEpakaKr8Syv3rSVp8gmAIsewIm8P268insOvHev2EKQK9IF9aCEAHgjIWfrDlSP3wPSFVCKRDa6EQs8Zow06hLNfin4gWO6S1TD0SFyelRBNpqzrHAwD+q6n9PKBKZTIzszt0RsROtfWLiDN7IBDBvx0AsjrZCJg9op/9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KikAOoyWjiBKxKrhhzlE57pOmaMWmqcaiAbTjga/X98=;
 b=SLuW2gnd9S7edUUGVJDJWYygzQ2UskIU7A3nsBpLuHCpcwPI70oFDuutJ61uK4uigYSNrw6zKc6QTig9m0wQbwjoqiFkwkMgK52gWJJEcxs1MQ1mQWkrSU2ZAroHetVHY87KPfgXY+qYognqRl2cMMZqj7GsAMoNPcYQ1zSqg530DoW0ziqKEljKe7LkCLYVg/DdCjkf90/zSapVMHlxn09lhzG55HeupAaQc37uazzCTt1JdicAYGIqo96SFzjhBlM9uaRCNLmx3GqV7IEYD5aQ2ctZ/k9Y8HEAWPtGZp+VToBPMqaI+l6sL4OKT6H80pmi7UETvihHUINW/enFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KikAOoyWjiBKxKrhhzlE57pOmaMWmqcaiAbTjga/X98=;
 b=PQEFrfJTtoBVjiJyFAAYACXGwlA9KhFFHFkkJvvSeBFoyo6mrQCgWX6dXtvCvHgcmOJhUF4xHCywFHQdUZrioBvUHid0yB7fysvn2QG+L3apHe+QHKQII6/LOtStOtIVGHDHQWN4vyL/cnEoZVV55zhccsqIL79aX66Iz673sqjr8KhitB61EvFE7wYogf7zm2uOYOKxJLr5OjKZJh95tHgtLayL4mvfbvXDeIGp2GdUck5KWLR5ox8X+SLTCYXi9WeMPEq/4bRyNh14kRRXBUwWtYT3dBHLHYjYWJuM4sxho5pI/Y9++8uXFf1xUgGejBA7XOR27cPz4IwpTb2oaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Thu, 3 Feb
 2022 21:19:36 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 21:19:36 +0000
Message-ID: <b68beb04-a248-e586-6af8-497cff6aaf02@nvidia.com>
Date:   Thu, 3 Feb 2022 13:19:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 2/4] mm/gup: clean up follow_pfn_pte() slightly
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20220203093232.572380-1-jhubbard@nvidia.com>
 <20220203093232.572380-3-jhubbard@nvidia.com>
 <20220203135352.55f35pztwmdx2rhk@quack3.lan> <20220203150123.GB8034@ziepe.ca>
 <YfvyYWfXuWgRlVaC@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YfvyYWfXuWgRlVaC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::8) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54c425b3-9824-487e-d714-08d9e75ae12c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB35952F9D9F53834AD71F9DFAA8289@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vj9b3ppwV1WDyFYSh7QN8gbkUFjSI7J88nPsg5hTHNiE5hqoYJeskdHe/bJMZKr8nP0YdxcZ7K4taDjcIYoKDFMapzmv/X5YkcTwMcHm7Vj2YnGZzElRBhCROd5ts9tC/IA+HA5WGCMcI0eYgw/zGmSCDMWqpMxl84WNDRwqr5ymfYumiqASLaYOVw8VvzH0mi4wXp7FxOLTBsQjnHhAKK0IRyYAsPQjs4f1yI6CyGEj7Lg01tc3x/8T4La16vg4s6U09Ny5YHoQ5MdEmji6+AxViKhpDv4PhHBqGGxwkkWsr7mZqa5V8QGxLREpGEVKt8hcnTgEIadx4QHAjyjuJRmokvG/Ly+b8KnXpQvvIUtJkUdDv4FeMdf33TWmPhuLV4E2dkFfoaVl1mgVQncHNBGBqsfESQPyDHEXpc1+Yh6gad3k//y5v8T3rJKI9NVP3/S6gqBz/r4HvZGlSZNYcVuSHhLmoz4CMzVlHnmnsY7gAnp4yXtxt0ruQvGjUS3EYUEKpBHJD2MfpOWbIafvJ2P4IufUvhnx+cPMBeX7oFuXP/so0+NvdQofGLU8zk052PPLeWgKwLpu/w85gbo2CyxckB5p5pdBPfAj35g1LcTNCfSOLrDOIcs9BuGrKV5lvV1bivVrHbdd9KinqmKAUFdatd+lQSGQzL+WHo1bufgG1ZL6pZzyknKuUDRWBvj3DWrf6TKBXix0MU0sDGQjki3YdIQvWYkZyVyylveeT+/2N3lvSUEgvOKqVLlNqQL0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(31686004)(26005)(4326008)(8676002)(31696002)(8936002)(86362001)(186003)(508600001)(53546011)(36756003)(83380400001)(6486002)(2616005)(6506007)(2906002)(7416002)(110136005)(54906003)(66556008)(6666004)(38100700002)(66946007)(66476007)(5660300002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0MrNjBXbGltUWVKM2Vtc3BuT20yOGhzOFJESXVULzc5Ym13YzFxcm0zL2VO?=
 =?utf-8?B?dW9FaGlWNTZ2RkVGVFh2ZmoyeHVsWDJoZjY2bHpJQXV0Njc2bVFXTlI0R25R?=
 =?utf-8?B?WG8yeGMrOFJBQlJOVkRmN1NFc0NwK3Nzbnl4VEZjalJiWVhFalRNTThrTUMr?=
 =?utf-8?B?Wks5cFM5N3crbXZ3K3VoWC9nTUNpN01IdE1wWitHVWZ2TlI2cm4vU3Q2bElR?=
 =?utf-8?B?ZmdCOG1wMGJrbThnMkE2Z2ZneEczSVF3VXNoTDk5Zk5hVjYvaTJnOElEbE9s?=
 =?utf-8?B?clM1bFRoYU0vNjk5eVIvNmdPZVpXQTlTS05vTXZvcU1PRlAyTnJXMjhhOVV0?=
 =?utf-8?B?VGorUmJtcmV4WjRJYVV5aUE5cGhTUUszNHlhM0ZsWms2Zm5BSEtwV1c3Y2w1?=
 =?utf-8?B?Z2hiMm9OZkRhSGVEQ0hKWS9SZzVQcituYVVCYmlMaDRIQ1Bwd3Q0UWQ2ZmZS?=
 =?utf-8?B?bThqRTlQK01MRWhvK2ZEUVA4ZE1GejI5dUlqcTZKTWpVeEpXdkROdXovN3FE?=
 =?utf-8?B?SXdXMjJBOUcyOEZPMlFjSzArbUpvbXJ0a1JZNDVZZThCR3ZpV3pTZ0luYlFs?=
 =?utf-8?B?azdEakdsb0E3WDBHZituU2xVMEJPVHdTc3MreHljWUsrSXNVeGtWalpJVVBl?=
 =?utf-8?B?TGZOS2l0L21ESDd4TklJNzlIOUpIM0xZVzNWYmRJM2MzNVFCMlJDT1FWenJJ?=
 =?utf-8?B?bkJpWm56eXNhWmJDblRvVjRCTzdMOW9xRWpUUlorNEtlZWkyRXlIaVZvc1RX?=
 =?utf-8?B?eTRqbkJEMFdsNDZMczZBYUJyU0QrVkZzMUVleFFLZldnVmJMbVVJR2NWdzlw?=
 =?utf-8?B?QjNtWDFBa1hHb1Z6bjBGcWN2SkR6TFdrdmxWVU9HdGRyb2wxOUszTGUwUTNu?=
 =?utf-8?B?V0xyMGpJM1B1aGJJNkozT2tibDhyZGtkNTk2ODQzUm0yMm1JaU9FOTExcmJI?=
 =?utf-8?B?NGZjTW4raUZZVEs4M25QQk56MXd4QWkwQTBnVjdxck5wTkJVaTlvSURrTXEv?=
 =?utf-8?B?aTdIYStGaWRoN05nYlVSNEtEYVJ2bk1hL2pWd2VVVTdjU2t5RjJ2R3JtcXNJ?=
 =?utf-8?B?TjN2SkQyRDdhdUZwTUhGSUlsaldPWUZIcEt1b25xQ2RtVm1rSzJzMXd6SzRO?=
 =?utf-8?B?V0o5RVJCSnVjaHhNRkRxVTlEY3J6ckpNaTJ3UTlueU9MRG5BQ1ZhMTJSNlRx?=
 =?utf-8?B?N2ROcVpuRWs1cTV0bU84WU9KNFhBaE5JNHBtVnZxcXJTV3VaWjBNRlgzWU0z?=
 =?utf-8?B?K2hmN2lsVCtrT1IwMGQrTjF0dHhrcTRvTEFQZ2R3dDY1ODFKYWJPWFBYN1JO?=
 =?utf-8?B?SS9Ud2FsYURmQWk3bmpzd0JWQ3N0WXpKN2RJb0dQT2RmblI0SUs4Mk12TDh1?=
 =?utf-8?B?OXhNbFNRSGtFeEllM0lNNWYvUzlKNlRNWTVJTUlJNWJERXQxc3piUjdpZ0xa?=
 =?utf-8?B?OExyRjRZT0JDUFU5TXpSV0RHNUVwZjVCYkVYMkJodTluc1FjZ1B5UzE5SFBN?=
 =?utf-8?B?RXMwUUIrcTFKMnIzZFRXL1FQSHh4TXVHTXhCUUcwYUVtK2FEQjB4YlZ0L3Vj?=
 =?utf-8?B?Q0Q2SlpIcWRuZGRtZ3dMZE9aeWJKSk1VNVR2cWQ4WWZsaWtLTUdoSUxtYXJi?=
 =?utf-8?B?ZHRYY0hHemE2RjlDbkNFYVpMTi9nTHdwVlN3R0FpSXh4K0V0eCt0ZDBzS2dL?=
 =?utf-8?B?NmJvc3FiRmNzMmFxdlNZZTJNeXhBQmkwNUlSd1R6TVFiOUFrV2kwVG1EUWc2?=
 =?utf-8?B?MHF6TnBLMVA0bWNmSXJLam5XU1hNNkVROTJya2oxdzdUN3VsaS9TalNpL0cw?=
 =?utf-8?B?cFEycllWSmNFVEhWeU1lTjcxa3Q4MWZuVTc5dm4rZHlPNnlnc2lmY2l6dS82?=
 =?utf-8?B?ck84RnF5ZEtvUUVXb3VQd3llUGJZdDRmdTRBQ3VET3NvZllyK3NxWkg2ckRz?=
 =?utf-8?B?VG5tR3hoYlBGeGgzMG55eXhzcFo2ZG9DS3dUQkI2eERUcWpsc0VNM0NYM09Q?=
 =?utf-8?B?MjlVeE1zVi9Vdk84M2ZoUmNXOTduOFpVRk8ycG80ZU1kb09tTjBob0Rhb0tr?=
 =?utf-8?B?dWJveWVnbS9UZGJwZUprUGhWejdUR0lZSG1xZHBjSmZJWlBvQ2lPUmxmMDFi?=
 =?utf-8?B?RG9tRTMwMVEwT092TGlMeDNxMlhJTWVRNlU4R2xnREc5WDRpTFl3WGRveDRL?=
 =?utf-8?Q?oIEi9uoVuNqzfIhJVXHUWtU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c425b3-9824-487e-d714-08d9e75ae12c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 21:19:36.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+SoWD6cmS+yljAZ9HgY3hLk8xM6PVS+N21lr7g7pPravj5jOErFJexzUrhSAt0Jlj32CB92FG2ClgaVvxzguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 07:18, Matthew Wilcox wrote:
...
>>> This will also modify the error code returned from follow_page().
>>
>> Er, but isn't that the whole point of this entire design? It is what
>> the commit that added it says:
>>
>> commit 1027e4436b6a5c413c95d95e50d0f26348a602ac
>> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Date:   Fri Sep 4 15:47:55 2015 -0700
>>
>>      mm: make GUP handle pfn mapping unless FOLL_GET is requested
>>      
>>      With DAX, pfn mapping becoming more common.  The patch adjusts GUP code to
>>      cover pfn mapping for cases when we don't need struct page to proceed.
>>      
>>      To make it possible, let's change follow_page() code to return -EEXIST
>>      error code if proper page table entry exists, but no corresponding struct
>>      page.  __get_user_page() would ignore the error code and move to the next
>>      page frame.
>>      
>>      The immediate effect of the change is working MAP_POPULATE and mlock() on
>>      DAX mappings.
>>
>>> A quick audit shows that at least the user in mm/migrate.c will
>>> propagate this error code to userspace and I'm not sure the change
>>> in error code will not break something... EEXIST is a bit strange
>>> error code to get from move_pages(2).
>>
>> That makes sense, maybe move_pages should squash the return codes to
>> EEXIST?
> 
> I think EFAULT is the closest:
>                This  is  a  zero  page  or the memory area is not mapped by the
>                process.
> 
> EBUSY implies it can be tried again later.
> 

OK. I definitely need to rework the commit description now, but the diffs are
looking like this:

diff --git a/mm/gup.c b/mm/gup.c
index 65575ae3602f..cad3f28492e3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -439,10 +439,6 @@ static struct page *no_page_table(struct vm_area_struct *vma,
  static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
  		pte_t *pte, unsigned int flags)
  {
-	/* No page to get reference */
-	if (flags & (FOLL_GET | FOLL_PIN))
-		return -EFAULT;
-
  	if (flags & FOLL_TOUCH) {
  		pte_t entry = *pte;

@@ -1180,8 +1176,13 @@ static long __get_user_pages(struct mm_struct *mm,
  		} else if (PTR_ERR(page) == -EEXIST) {
  			/*
  			 * Proper page table entry exists, but no corresponding
-			 * struct page.
+			 * struct page. If the caller expects **pages to be
+			 * filled in, bail out now, because that can't be done
+			 * for this page.
  			 */
+			if (pages)
+				goto out;
+
  			goto next_page;
  		} else if (IS_ERR(page)) {
  			ret = PTR_ERR(page);
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..be0d5ae36dc1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1761,6 +1761,13 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
  			continue;
  		}

+		/*
+		 * The move_pages() man page does not have an -EEXIST choice, so
+		 * use -EFAULT instead.
+		 */
+		if (err == -EEXIST)
+			err = -EFAULT;
+
  		/*
  		 * If the page is already on the target node (!err), store the
  		 * node, otherwise, store the err.

thanks,
-- 
John Hubbard
NVIDIA
