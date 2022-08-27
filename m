Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472675A32F7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 02:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiH0ALm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 20:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiH0ALi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:11:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ECBE830A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kg5RRa8K/wBBpfOVu/UkNZVgaf26zYJ3woGEa68pkrPOL+tp7JcYTRJlOB9wlBtctPvbE+IXAGG3BtRBWtBZbGWQuowWTJTbUpZQgBP0OIVxIZC+whXLFto64jAXy5EPvZYqPhN1C/gYHDwPUMyU7tLObuwv4olVzb+qsBFx5r1TAMbZ2uApIrRyGmx9KGIk7okhLQC1bGKO+9EvPvY9XGZJn/UuRlgMgu4ZwFooqIjexf7oMdRACKIzgdLMq9pA4+ZKsckAHuNsgyjvURXQSqiFR+9+xwk8C1brgucRW9YNFiTTBXO59lyDDdBBSR9Deo9OhikBgBTPfGm/ALY5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6jqpc2UDnVq2nuCCupQ0i1Be/pFjTWSMC2g2UPqQww=;
 b=JO+zX85u0aIuHH44bwziBs1BrfFS6USNbVoa1x7oHouJLS0VTo8DCfOlA/TnntqjZmzN+U/JMJIwSdlNArh3/0Tm7k3OTpcPQD8oI5E/oma1Z9HcEWc6UKdmOM5eK5lfuAP1J5YnxtyWmXJNpEI48Uru3XsfY37kl3dIGiVqa0mp0YIdMfrEE83sCeWvhwK9hZdTdULntIDPu6fXonTOZSMbQnrd/ALPHiM7oWRsaQQ4kq96bnGUK3NUxqQVlG83S3si2onGjLdgi6LRpdbY5nSjQuaqVxYkdK6Ee5oMjGP4Cf1vk465/BJPx8fQEVlINBR+QPx0cThTDSLLWNZkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6jqpc2UDnVq2nuCCupQ0i1Be/pFjTWSMC2g2UPqQww=;
 b=UpzNMjbpBeo4BThTCdoFR5/ed+n7wekmHbLwORWsA6+T3M1f5/t4uyB1IslkKRw10/foEjR5VgRLqMg9kYc9ThmxscecAQDlXWxm168ZG15pjTlDj8bOS3X6M06g0OAGHdnqaos9fNqJXERT71UD03waHN0OSDFZh5C9l6/R2I2qJ1bhQb1Cl2IE7Z3kDxw5HYXWlk4k2Prw279Y9OiFgB9bjQILqDKIFTYiIQA723jR6dlNHxvgj1pxI3jtiP68CYJXWpfAy3Pi2chSpTkj+5O3IimJ49xZJHJ2miNPpLExiopZCiLaaMvQYJrK8k3FEcxZCNrYDZ2kH2MDE6elRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB4729.namprd12.prod.outlook.com (2603:10b6:5:7f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Sat, 27 Aug 2022 00:11:34 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7415:f39a:d46e:1594]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7415:f39a:d46e:1594%3]) with mapi id 15.20.5566.015; Sat, 27 Aug 2022
 00:11:34 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     alexlzhu@fb.com
Cc:     linux-mm@kvack.org, willy@infradead.org, hannes@cmpxchg.org,
        akpm@linux-foundation.org, riel@surriel.com, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/3] mm: add thp_utilization metrics to debugfs
Date:   Fri, 26 Aug 2022 20:11:31 -0400
X-Mailer: MailMate (1.14r5907)
Message-ID: <CE4E09B8-4CDC-471D-9625-2CED7C95997B@nvidia.com>
In-Reply-To: <b30dedf6393ed9b3ecd4118b97233cc4186b0e62.1661461643.git.alexlzhu@fb.com>
References: <cover.1661461643.git.alexlzhu@fb.com>
 <b30dedf6393ed9b3ecd4118b97233cc4186b0e62.1661461643.git.alexlzhu@fb.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5C4AD28B-6A4C-42C5-ABDD-6661C63E2E7A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0379.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::24) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a53ab31-cf35-474f-70d1-08da87c0b373
X-MS-TrafficTypeDiagnostic: DM6PR12MB4729:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqXEk1q+ktQslX8n+nE1UEJNM3dVWvtzmmD8sbZHn4871U8/yo8D48U6jXCP5zHlqoCXOmlImjC0SNdyC8mcPyLNAZ98dQuCjCvL/6J08Sfki9RgH7EtPV1AAdDkiJlgKDWrLjly7nJcRp1O8h2fadeQS1e2GPYO+oY5Y/uN9pVqadmEUtwRI9dp9+alSVwvFj7T3uGdw0fjlsQyZykY54JTfvU+258kZO7aWsPG6VN9X6rTDoxo1++AsOj5g/lIcmr9OrPowLs48IfyiApZkMNHJsB+7ZIb/71samdmiNnXGKLLGnQgwHgd0uP73F2ZbAKTLuDyQja2jDD6VLrsreFc6EAZbkNGC7RRbzA7KtmidfD1RdJQChF7SMltdl9tXyXCaNbL2eD1ENWRPEy2me9Sy0xb22Y1DONano4LQXpK/qIesEs630Z13XsEB6ixSjtp+vKyyCt8CEno8JVUyySOxiQixQn9JONMGkuBJGElUjsa/nny94Zmq2PGyCK9Y23+Bz8L4In2cBuurUxcAkSMj5JJ3zxNwST449l2Y3RSBPTSPlbdK3zhAQRDa2a/Kk8EGv16mm1JXeGBxwzHAHakmp1HnPeaTD0XwquXsaAeAUWOw5YGp2aWWOWRa0ltAtcTOm42ZjPV6E2v1gaGzG+pMNbKv+I6TrFr7n7ja4xXtkoN/iZy/rAYywf3XEQmtQTgsVar4a14kvDkArm7WfDMh2C1SeokgsNiI7PMPQWibo0Yqs1B6appBaETy2TOxlLUYLwWcped3y9IT+9Xt1nTvCssV7LZO50YnvgCbNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(66476007)(86362001)(6666004)(6506007)(26005)(33964004)(6512007)(66556008)(53546011)(8676002)(478600001)(66946007)(33656002)(38100700002)(2906002)(4326008)(235185007)(5660300002)(186003)(8936002)(30864003)(41300700001)(2616005)(6486002)(83380400001)(6916009)(36756003)(316002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFdmS3FGWVJJSmZ6SXd6bDM3ZzVqZWc3bHB5Tkdac291TlVGUkVFa1Z3R25w?=
 =?utf-8?B?a0RwQ0h1ZlF2SmJJMVoydUg0dWJNMXU1NUdWb3d6UnhINXEwV2tuTW9uUElM?=
 =?utf-8?B?a0o5dmJwZVByQTNwQmVoMDdDZGdNbTRlOVE5WEc4akFsZHJsUTU3VHd3QUVu?=
 =?utf-8?B?YzVRbWZYMnl3bmR0eHdzTjAzYU5IMGZ5dFN6aTh5Wkh6K0IwZjF5NGhFZ25B?=
 =?utf-8?B?Y0hBYWFUUTdvWUp5dmQrRmdYWmdPbFJrdmd2Y1ZEeHZHVGtmUVhUQVJoMmMw?=
 =?utf-8?B?d2RYN1JGZEY3YjJkSjAreU5tZ2tUVGd6NDBYc0JzQmpjTXF2MmZCeEZrSFBt?=
 =?utf-8?B?Zjg3MTlJK3c1TTRRV01rQTlHbnJmaHRMYVcrWFRrMHIyVW5IV1lSS0Vvb3NU?=
 =?utf-8?B?Z1IrMHJnOTBmSjFPc2Y5bGJDQWJzaGNzSFBrbG15ZVlyMEhGTXUwdktiQnpI?=
 =?utf-8?B?OGV1T3lBME9SNGhNK3lCRnNCUlFmTHBnZ2Frb0FGSnlISHdrVkJ6bFo2bW5E?=
 =?utf-8?B?dnB4dlhaSWZPdnJCUEVPT0E4T0p2QktDMFFTMTlSUTU5WjZaQzgwZmZxVzdP?=
 =?utf-8?B?RG9SNmVyaUgzMXJnL0VmVlY2cmI4NGtOMzJxZmJiOWc3dkJxUGU4TVFQeDhw?=
 =?utf-8?B?eUFIU1lHZGJoVlZJbXlndE1La3VoSm8rVlhLdXBLNHJYRlFMR09aWHpjT2tw?=
 =?utf-8?B?clg1RkZvUitybVRCTmdWa0I4bHVmb2p2WXViTGk3WW9yL0Y1NmJ6QnN3bHlO?=
 =?utf-8?B?UmowejAwUXpSbVl2RlNLUW9HL1B3aGkxR2RGWDlsa1VST0xSWkpJZ3prcThn?=
 =?utf-8?B?enl2cmh3VXNBKzBodjJNUzBpcWFKVnk3WkZBa3c2S2FlckhFVnZjeHByN3Bz?=
 =?utf-8?B?cDBoOGNDVEwxTDIzR055MXRLZXNNMERJSUhjNUVVNzNSYUlNNk9iTXNwTm1C?=
 =?utf-8?B?VUdXblZscGIyNXpJVFlZZlJPNG4vOThETGZNVmNzcFl2bEk0YjMzYTZtSTdv?=
 =?utf-8?B?STZWcDByd3JRR25qWlE2VEJQM0lOejVNRW14QTZDU1Z5TGlZN3Q3TmwxMmJM?=
 =?utf-8?B?UnhtNnlVRFA4clJ5cUEvNjQ5RnBnYUVseEJkUXRXRDlyVGFWUzJxc09vM3pp?=
 =?utf-8?B?cFpiZG9KUU9MdWd6MDZkNjNSZklqUjZTM0ZFT25VbjJFVVVrSm9QM2poUXh0?=
 =?utf-8?B?UGtFYnVKejR3WDZEaTkvMWRDU0FRbGJxbUp6RVVvcEtSaHNURnQvWENKVGpW?=
 =?utf-8?B?RFhWeXZrYzF3V2x0UTF2bzZVVEkydUpCWnAwMlpBRVRZZVpUcU9xRUZQSTdM?=
 =?utf-8?B?RzZYU2tTWTZCM1hVRkpLL0loUnE1aVB0bXZ1c2V6VVhaY2pLRHJvT3J2WHg4?=
 =?utf-8?B?TFlUN3Bla1JpSWdSRHQ4Z2pvL1AxekpqQWhaelk5cTZNdFRlRjBnR0xjMlF3?=
 =?utf-8?B?bTk5QXR6K0h6VXQvZzdxeGY0S3lGUUdldzlOdjY4N1kwQTRKclBiYWdTOG90?=
 =?utf-8?B?UEI0YWc0elJoZm16VU9HSXZzVkkxcEoxeGVNK0t3M1ArWDNGeWRYdUZoSzd4?=
 =?utf-8?B?YXRxQzYzVk9lV1VxSTY3UjZNSllqVW4rMnQ3WEZCSGtiUXhTZ1RXUjh4NVcv?=
 =?utf-8?B?cXRPb2orTlp4WEk0bmdpVU9ZSFEvU0xZZFRTeFYrb1JUVHkwWUhSRDFRYWd0?=
 =?utf-8?B?OFlVZFJRcGdhRUx1WHhpUnQ1VThHQmJXNzgrMDhBWE8vVnM4cHZPa1ROanpt?=
 =?utf-8?B?dUhrSGJFek96VW11aW96MDhzS1lzOWZRN2lNN0J1WHFEbGZ6STA3YkYyd1lw?=
 =?utf-8?B?R1Yxc0xsSFhFc296NDN3bFhHV3dnOVVGU0o4WmNxQlhSR1pMLzU2VmJQWGls?=
 =?utf-8?B?bDc2MUpObVA1V3NheHF2NzdoSXRFNy9kbCtEV0pieFI5RjZleC9WVGRwRGtT?=
 =?utf-8?B?OExRem40OWV4d0NGL2JnOG9sOHVzMDBVblNndEJWMC9qRUdTM2Y2T3c5QzZx?=
 =?utf-8?B?cU9XRlJFaUlNSnVxeWtzYmNNeGZnRVUzMnpPS2loZWNXYmNYQ3RqUTAwZGpI?=
 =?utf-8?B?SVIxSHpkWFlRRWJRSXEyK05BM0dHeFV3cVZSTnVzeVBOMUFQWC9ONkk3R1Rp?=
 =?utf-8?Q?cc103GSB33cbxkgDKzsjYeDzJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a53ab31-cf35-474f-70d1-08da87c0b373
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 00:11:34.3004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXE9Bnzl2sa6j7HKNNgjT1+WjaEYfuGsZRCA6s8Lb+B7jHX/7KZpHIF0tDwrN/BF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4729
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5C4AD28B-6A4C-42C5-ABDD-6661C63E2E7A_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25 Aug 2022, at 17:30, alexlzhu@fb.com wrote:

> From: Alexander Zhu <alexlzhu@fb.com>
>
> This change introduces a tool that scans through all of physical
> memory for anonymous THPs and groups them into buckets based
> on utilization. It also includes an interface under
> /sys/kernel/debug/thp_utilization.
>
> Sample Output:
>
> Utilized[0-50]: 1331 680884
> Utilized[51-101]: 9 3983
> Utilized[102-152]: 3 1187
> Utilized[153-203]: 0 0
> Utilized[204-255]: 2 539
> Utilized[256-306]: 5 1135
> Utilized[307-357]: 1 192
> Utilized[358-408]: 0 0
> Utilized[409-459]: 1 57
> Utilized[460-512]: 400 13
> Last Scan Time: 223.98
> Last Scan Duration: 70.65

How large is the memory? Just wonder the scanning speed.
Also, it might be better to explicitly add the time unit, second,
in the output.

>
> This indicates that there are 1331 THPs that have between 0 and 50
> utilized (non zero) pages. In total there are 680884 zero pages in
> this utilization bucket. THPs in the [0-50] bucket compose 76% of total=

> THPs, and are responsible for 99% of total zero pages across all
> THPs. In other words, the least utilized THPs are responsible for almos=
t
> all of the memory waste when THP is always enabled. Similar results
> have been observed across production workloads.
>
> The last two lines indicate the timestamp and duration of the most rece=
nt
> scan through all of physical memory. Here we see that the last scan
> occurred 223.98 seconds after boot time and took 70.65 seconds.
>
> Utilization of a THP is defined as the percentage of nonzero
> pages in the THP. The worker thread will scan through all
> of physical memory and obtain utilization of all anonymous
> THPs. It will gather this information by periodically scanning
> through all of physical memory for anonymous THPs, group them
> into buckets based on utilization, and report utilization
> information through debugfs under /sys/kernel/debug/thp_utilization.
>
> Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst |   9 +
>  include/linux/huge_mm.h                    |   2 +
>  mm/huge_memory.c                           | 198 +++++++++++++++++++++=

>  3 files changed, 209 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> index c9c37f16eef8..d883ff9fddc7 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -297,6 +297,15 @@ To identify what applications are mapping file tra=
nsparent huge pages, it
>  is necessary to read ``/proc/PID/smaps`` and count the FileHugeMapped =
fields
>  for each mapping.
>
> +The utilization of transparent hugepages can be viewed by reading
> +``/sys/kernel/debug/thp_utilization``. The utilization of a THP is def=
ined
> +as the ratio of non zero filled 4kb pages to the total number of pages=
 in a
> +THP. The buckets are labelled by the range of total utilized 4kb pages=
 with
> +one line per utilization bucket. Each line contains the total number o=
f
> +THPs in that bucket and the total number of zero filled 4kb pages summ=
ed
> +over all THPs in that bucket. The last two lines show the timestamp an=
d
> +duration respectively of the most recent scan over all of physical mem=
ory.
> +
>  Note that reading the smaps file is expensive and reading it
>  frequently will incur overhead.
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 768e5261fdae..c9086239deb7 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -179,6 +179,8 @@ bool hugepage_vma_check(struct vm_area_struct *vma,=

>  unsigned long thp_get_unmapped_area(struct file *filp, unsigned long a=
ddr,
>  		unsigned long len, unsigned long pgoff, unsigned long flags);
>
> +int thp_number_utilized_pages(struct page *page);
> +
>  void prep_transhuge_page(struct page *page);
>  void free_transhuge_page(struct page *page);
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8a7c1b344abe..8be1e320e70c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -45,6 +45,21 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/thp.h>
>
> +/*
> + * The number of utilization buckets THPs will be grouped in
> + * under /sys/kernel/debug/thp_utilization.
> + */
> +#define THP_UTIL_BUCKET_NR 10
> +/*
> + * The maximum number of hugepages to scan through on each periodic
> + * run of the scanner that generates /sys/kernel/debug/thp_utilization=
=2E
> + * We scan through physical memory in chunks of size PMD_SIZE and
> + * record the timestamp and duration of each scan. In practice we have=

> + * found that scanning THP_UTIL_SCAN_SIZE hugepages per second is suff=
icient
> + * for obtaining useful utilization metrics and does not have a notice=
able
> + * impact on CPU.
> + */
> +#define THP_UTIL_SCAN_SIZE 256
>  /*
>   * By default, transparent hugepage support is disabled in order to av=
oid
>   * risking an increased memory footprint for applications that are not=

> @@ -70,6 +85,25 @@ static atomic_t huge_zero_refcount;
>  struct page *huge_zero_page __read_mostly;
>  unsigned long huge_zero_pfn __read_mostly =3D ~0UL;
>
> +static void thp_utilization_workfn(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(thp_utilization_work, thp_utilization_work=
fn);
> +
> +struct thp_scan_info_bucket {
> +	int nr_thps;
> +	int nr_zero_pages;
> +};
> +
> +struct thp_scan_info {
> +	struct thp_scan_info_bucket buckets[THP_UTIL_BUCKET_NR];
> +	struct zone *scan_zone;
> +	struct timespec64 last_scan_duration;
> +	struct timespec64 last_scan_time;
> +	unsigned long pfn;
> +};
> +
> +static struct thp_scan_info thp_scan_debugfs;
> +static struct thp_scan_info thp_scan;
> +
>  bool hugepage_vma_check(struct vm_area_struct *vma,
>  			unsigned long vm_flags,
>  			bool smaps, bool in_pf)
> @@ -486,6 +520,7 @@ static int __init hugepage_init(void)
>  	if (err)
>  		goto err_slab;
>
> +	schedule_delayed_work(&thp_utilization_work, HZ);
>  	err =3D register_shrinker(&huge_zero_page_shrinker, "thp-zero");
>  	if (err)
>  		goto err_hzp_shrinker;
> @@ -600,6 +635,11 @@ static inline bool is_transparent_hugepage(struct =
page *page)
>  	       page[1].compound_dtor =3D=3D TRANSHUGE_PAGE_DTOR;
>  }
>
> +static inline bool is_anon_transparent_hugepage(struct page *page)
> +{
> +	return PageAnon(page) && is_transparent_hugepage(page);
> +}
> +
>  static unsigned long __thp_get_unmapped_area(struct file *filp,
>  		unsigned long addr, unsigned long len,
>  		loff_t off, unsigned long flags, unsigned long size)
> @@ -650,6 +690,38 @@ unsigned long thp_get_unmapped_area(struct file *f=
ilp, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>
> +int thp_number_utilized_pages(struct page *page)
> +{
> +	struct folio *folio;
> +	unsigned long page_offset, value;
> +	int thp_nr_utilized_pages =3D HPAGE_PMD_NR;
> +	int step_size =3D sizeof(unsigned long);
> +	bool is_all_zeroes;
> +	void *kaddr;
> +	int i;
> +
> +	if (!page || !is_anon_transparent_hugepage(page))
> +		return -1;
> +
> +	folio =3D page_folio(page);
> +	for (i =3D 0; i < folio_nr_pages(folio); i++) {
> +		kaddr =3D kmap_local_folio(folio, i);
> +		is_all_zeroes =3D true;
> +		for (page_offset =3D 0; page_offset < PAGE_SIZE; page_offset +=3D st=
ep_size) {
> +			value =3D *(unsigned long *)(kaddr + page_offset);

Is it possible to use cache-bypassing read to avoid cache
pollution? You are scanning for 256*2M at a time. Wouldn=E2=80=99t that
wipe out all the useful data in the cache?

> +			if (value !=3D 0) {
> +				is_all_zeroes =3D false;
> +				break;
> +			}
> +		}
> +		if (is_all_zeroes)
> +			thp_nr_utilized_pages--;
> +
> +		kunmap_local(kaddr);
> +	}
> +	return thp_nr_utilized_pages;
> +}
> +
>  static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>  			struct page *page, gfp_t gfp)
>  {
> @@ -3135,6 +3207,42 @@ static int __init split_huge_pages_debugfs(void)=

>  	return 0;
>  }
>  late_initcall(split_huge_pages_debugfs);
> +
> +static int thp_utilization_show(struct seq_file *seqf, void *pos)
> +{
> +	int i;
> +	int start;
> +	int end;
> +
> +	for (i =3D 0; i < THP_UTIL_BUCKET_NR; i++) {
> +		start =3D i * HPAGE_PMD_NR / THP_UTIL_BUCKET_NR;
> +		end =3D (i + 1 =3D=3D THP_UTIL_BUCKET_NR)
> +			   ? HPAGE_PMD_NR
> +			   : ((i + 1) * HPAGE_PMD_NR / THP_UTIL_BUCKET_NR - 1);
> +		/* The last bucket will need to contain 100 */
> +		seq_printf(seqf, "Utilized[%d-%d]: %d %d\n", start, end,
> +			   thp_scan_debugfs.buckets[i].nr_thps,
> +			   thp_scan_debugfs.buckets[i].nr_zero_pages);
> +	}
> +	seq_printf(seqf, "Last Scan Time: %lu.%02lu\n",
> +		   (unsigned long)thp_scan_debugfs.last_scan_time.tv_sec,
> +		   (thp_scan_debugfs.last_scan_time.tv_nsec / (NSEC_PER_SEC / 100)))=
;
> +
> +	seq_printf(seqf, "Last Scan Duration: %lu.%02lu\n",
> +		   (unsigned long)thp_scan_debugfs.last_scan_duration.tv_sec,
> +		   (thp_scan_debugfs.last_scan_duration.tv_nsec / (NSEC_PER_SEC / 10=
0)));
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(thp_utilization);
> +
> +static int __init thp_utilization_debugfs(void)
> +{
> +	debugfs_create_file("thp_utilization", 0200, NULL, NULL,
> +			    &thp_utilization_fops);
> +	return 0;
> +}
> +late_initcall(thp_utilization_debugfs);
>  #endif
>
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> @@ -3220,3 +3328,93 @@ void remove_migration_pmd(struct page_vma_mapped=
_walk *pvmw, struct page *new)
>  	trace_remove_migration_pmd(address, pmd_val(pmde));
>  }
>  #endif
> +
> +static void thp_scan_next_zone(void)
> +{
> +	struct timespec64 current_time;
> +	int i;
> +	bool update_debugfs;
> +	/*
> +	 * THP utilization worker thread has reached the end
> +	 * of the memory zone. Proceed to the next zone.
> +	 */
> +	thp_scan.scan_zone =3D next_zone(thp_scan.scan_zone);
> +	update_debugfs =3D !thp_scan.scan_zone;
> +	thp_scan.scan_zone =3D update_debugfs ? (first_online_pgdat())->node_=
zones
> +			: thp_scan.scan_zone;
> +	thp_scan.pfn =3D (thp_scan.scan_zone->zone_start_pfn + HPAGE_PMD_NR -=
 1)
> +			& ~(HPAGE_PMD_SIZE - 1);
> +	if (!update_debugfs)
> +		return;
> +	/*
> +	 * If the worker has scanned through all of physical
> +	 * memory. Then update information displayed in /sys/kernel/debug/thp=
_utilization
> +	 */
> +	ktime_get_ts64(&current_time);
> +	thp_scan_debugfs.last_scan_duration =3D timespec64_sub(current_time,
> +							     thp_scan_debugfs.last_scan_time);
> +	thp_scan_debugfs.last_scan_time =3D current_time;
> +
> +	for (i =3D 0; i < THP_UTIL_BUCKET_NR; i++) {
> +		thp_scan_debugfs.buckets[i].nr_thps =3D thp_scan.buckets[i].nr_thps;=

> +		thp_scan_debugfs.buckets[i].nr_zero_pages =3D thp_scan.buckets[i].nr=
_zero_pages;
> +		thp_scan.buckets[i].nr_thps =3D 0;
> +		thp_scan.buckets[i].nr_zero_pages =3D 0;
> +	}
> +}
> +
> +static void thp_util_scan(unsigned long pfn_end)
> +{
> +	struct page *page =3D NULL;
> +	int bucket, num_utilized_pages, current_pfn;
> +	int i;
> +	/*
> +	 * Scan through each memory zone in chunks of up to THP_UTIL_SCAN_SIZ=
E
> +	 * hugepages every second looking for anonymous THPs.
> +	 */
> +	for (i =3D 0; i < THP_UTIL_SCAN_SIZE; i++) {
> +		current_pfn =3D thp_scan.pfn;
> +		thp_scan.pfn +=3D HPAGE_PMD_NR;
> +		if (current_pfn >=3D pfn_end)
> +			return;
> +
> +		if (!pfn_valid(current_pfn))
> +			continue;
> +
> +		page =3D pfn_to_page(current_pfn);
> +		num_utilized_pages =3D thp_number_utilized_pages(page);
> +		 /* Not a THP; skip it. */
> +		if (num_utilized_pages < 0)
> +			continue;
> +		/* Group THPs into utilization buckets */
> +		bucket =3D num_utilized_pages * THP_UTIL_BUCKET_NR / HPAGE_PMD_NR;
> +		bucket =3D min(bucket, THP_UTIL_BUCKET_NR - 1);
> +		thp_scan.buckets[bucket].nr_thps++;
> +		thp_scan.buckets[bucket].nr_zero_pages +=3D (HPAGE_PMD_NR - num_util=
ized_pages);
> +	}
> +}
> +
> +static void thp_utilization_workfn(struct work_struct *work)
> +{
> +	unsigned long pfn_end;
> +
> +	if (!thp_scan.scan_zone)
> +		thp_scan.scan_zone =3D (first_online_pgdat())->node_zones;
> +	/*
> +	 * Worker function that scans through all of physical memory
> +	 * for anonymous THPs.
> +	 */
> +	pfn_end =3D (thp_scan.scan_zone->zone_start_pfn +
> +			thp_scan.scan_zone->spanned_pages + HPAGE_PMD_NR - 1)
> +			& ~(HPAGE_PMD_SIZE - 1);
> +	/* If we have reached the end of the zone or end of physical memory
> +	 * move on to the next zone. Otherwise, scan the next PFNs in the
> +	 * current zone.
> +	 */
> +	if (!populated_zone(thp_scan.scan_zone) || thp_scan.pfn >=3D pfn_end)=

> +		thp_scan_next_zone();
> +	else
> +		thp_util_scan(pfn_end);
> +
> +	schedule_delayed_work(&thp_utilization_work, HZ);
> +}
> -- =

> 2.30.2

--
Best Regards,
Yan, Zi

--=_MailMate_5C4AD28B-6A4C-42C5-ABDD-6661C63E2E7A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmMJYTMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK8IUQALKIGZfxMWnaf7/ewUSJZxV5K/AK/esv23++
wmERWOoAFGFOA7DRVNTIc3r2YmLrOIug0TWX2h34jjfO5VTsa4zwQBIZZX0OYKBE
VPXU3/79TnE80NmzFPK0aGapl3EX46h0O6hvjAoopg5UET3Y/ySgYfDBtVDJ3sFM
QIi8Flhds/LpqZXbAJ91Ijz7I3wJ3lRsTfErRH5ULnrIuczAAmNNmSHEJ4vsBxl0
V6zD12GshdwVjZCDWSlLRBzz7vG42BTeGZX3BtHDKARd6sMeD9j1AvlR/EaoLDXu
zeZA+ZQo/s576Le0u3sW4LN9vMb/OmtWkI+JjT+icOxgfrPwU1k3folc2Mzp82r1
svGmxME/FI2QkkNa6BGwByXV3fs2bGghnB2eiRysoAiE/QSc0DZ8yn97vbVm4RXJ
GVY9HYJrb8W44qgnj4IJleHy0woJKkOv4LPTKAbW0fx7ivczQHGSrnIhw2kkepUa
dTIKVM2jVchooaae2ZKQ/HAqWc1DiWJAzp5gitY3Yn763YaDoOsr/zFNkJIGlbWw
qugmbTloZ0roGoCzwT3qXu5BdUJwPVQiLrCjlfKYtzzCHp/bVDkPl4/3Ik9khOW/
CqzygUfmyn5kZ9SkxOzkEaJFeBt2kJ3EDX6/CSLdTeTz31LCIZN/p8cnwtv8wYdD
w+f/03Zt
=ezU5
-----END PGP SIGNATURE-----

--=_MailMate_5C4AD28B-6A4C-42C5-ABDD-6661C63E2E7A_=--
