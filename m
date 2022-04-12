Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F15F4FCC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbiDLCI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiDLCI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:08:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78037338AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA71b2lvQkLUJp0UXbZCoRo0QfhRT+WNFOp5sYWlH9u94mX8v44GKT/Fn/4X+358N8fIZxLVOyBocK4D7gAkWPOvB9aQDi/uvwb6bNChphYexWRa4IelsgMBnYFxPYV198wXQwzC6s4PFq4HXLPK+fUSWL2aGEGCt0IzulGSScDyfJt/C2phr3ClXfMl495nymFu7DWBAVzC9K0Cc2qWsth4bMwAcc4+KLTa/JJF5/N5R/DwwGQUEjaPp6qIFEYFj+53vaeMBgjWmg4Sl4YSgUHgQ3fLwxWwa5HPuZTv5jP01Z5s8POTT9krC1mhpx0h5izZdK+GPcWZNjDQ8V+gCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBFQ03HAmGshleUbTJrSWB3oIBQD0jWF8s6PrjA177M=;
 b=lgxoPuLdvSW3Hzs/PZ+sRg5a2+WMjmt66QJNyURnPPQ3rzHodK0BdK7QZwiHiw0KVK4XujQUCoR20dZarjSDQiXZxpLNZnIUD5/+ha62kGvwTxC1z9/K4FoWYDdc7ZpJst7NgXfgHAU4+/MIkQwMxKa+YWxrozVTx9dh7FhLpFHN3hxFGrA4jBkfKfanwgFYnPG5wou942zuhT6jNPDshht5zAvdEjJqWh1kINEVnMgcHxy40EBlb8CHy/cEfsBeIno2cY4W9zdVyofZa26fZteDxfns39eQC2T1maBimmnvfLD2A5XKYB6g5Vh8w5RVENcQRWqqjpRsRWVk9iHyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBFQ03HAmGshleUbTJrSWB3oIBQD0jWF8s6PrjA177M=;
 b=oQTrgpVnHmkZQlMbZXCy86rz7TaKWZJQwxtv2OlqQ0bF1Im1m/nJzYd/Kc/pcXRiewFNvkgv3B9CVG8A5IqcEkXffIWuvDPeZtoZA/sfZZm1Ck6g1VTx0IiwaXHvkFEY0ksuv5fyBbJy3fcclonkDB9eHroIJLVcFu5I5g/YOcAxqiUKFP78fZ9/WN2CSBT4NApNlwA+8V3uPU/20sDE6HxlhUMH6HnonJRjwRBLKe3TYcdAzWJs1W7VAq75XrE857rv1AVCbcPVcWGWOK7mhej6LKgjqPrNs98jvg5kHm7xPJL4HZQ96VcJ35gJnkm4TObDBbfcxJRbOxSwZSrdig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 02:06:39 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 02:06:39 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v8 03/23] mm: Check against orig_pte for finish_fault()
Date:   Tue, 12 Apr 2022 12:05:41 +1000
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014836.14077-1-peterx@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <20220405014836.14077-1-peterx@redhat.com>
Message-ID: <878rsbawd2.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SY2PR01CA0017.ausprd01.prod.outlook.com
 (2603:10c6:1:14::29) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58c63fde-c894-4d3a-63f1-08da1c2914e1
X-MS-TrafficTypeDiagnostic: DM4PR12MB5342:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53420C623CDC22D00836F2C9DFED9@DM4PR12MB5342.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7JaukOrHOM5jgMMrGGrbW9oVgaDaoQatz/K3WJxYSv5boP1ttzmB0aZhywVxSVpjMl/XkhNBQckpQISES2SrSTAc9J3XsDz5X4LR4xQEFZTcHCUxduOUxp3epoaoDewjBXhkcG8ABQ11ubIIcPp9r17qFR1F2/YKRF0gn8uVcWWmtJbTDjbT2JAGOK1EWG8hgrnBiUNOKS3pR3zgHkW2tDCx6vKjiQXHzS6U8eT0UzsJ5vuEhvBqQRL0Y7N2vhUE14E65VswCP2ew6IMQI1e1tQOkvUApLh0+sdipZdKmjMrri4lCtB8H9YmIs8ndmfy2dlB19ZMn0h1Py06R8KaFZscl4bA3fYa+pGI/1/nfahq2aS2CPCBweu0nTZFfi4SYvgk6p8SkpPBXLpepkc9dZPPvBYmyPq+S9teuXHcKgUphDiAJdOUNobvioGCVpL1mqzci9UpA15sNEE7U3bgHcPvh5w/Dld9DZnjj+d4F12VIq7g8CafPPUjCHFENBWexFTHhcps8bFd/4BFi824UF6XnfAgNbWVrBFGq8bt+29bSYs7nDMdaMnXGjinKCGHFkXsmjUNI7qXqqjJ4+ME6M1Cye656FH96gmyzk/qw34OkOe21bAUDtLOtMmdFbSIeg75fSkff1e/7E2PMgNcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(4326008)(66946007)(54906003)(6916009)(6486002)(66476007)(8676002)(6512007)(6666004)(86362001)(316002)(66556008)(38100700002)(83380400001)(6506007)(44144004)(9686003)(2906002)(7416002)(5660300002)(26005)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v/AbCkfmkx+tX1Lb3y+NWuvTX4d8dUa2lIuCwcDNycVvmKG1+8PBJEY6Z48+?=
 =?us-ascii?Q?Yjr9bxASLWBuT1sEBoYFhxg1JlYlPFHqY84y3Li9wxrIote8RcDrBvgiPaCd?=
 =?us-ascii?Q?uh4Pd39fBCR6Jtv6eJKJsIV8r58SNT31taD8uZqCk1KyroPZ1f3it6LlVY6B?=
 =?us-ascii?Q?80nAQWvL/1ftMx5R14jN8XxytQ8QJjr4tu5QK/hsROHc2/H8bWQiHkZGm6WP?=
 =?us-ascii?Q?oMoysFJW9wffXtDwxmB5NB38+bQhHg5tMdWTmHcHNkiRazQutvrH5OD2HgDB?=
 =?us-ascii?Q?NER+1TPy737GNnRkcv2HB23KCXEQeAKoZMSINyzWs+XD8VzuMvL+TPoe2YYs?=
 =?us-ascii?Q?8GUc2PX2YN7aJXaYbBQB5+GmUeJ71CCnfpr/AcsAC0HUDcp345EF0kupRdbg?=
 =?us-ascii?Q?z6oEnUKyWKQcIsxObdRtoAVUHxUfZIuRo/oEP6Ym2zL5THperEfJFXgMcYiw?=
 =?us-ascii?Q?pAGbjnv8M+fWHEZ1miObjEJEH6cfC5derqOC2iDcmZfFFHLiQ5QaFAz+6vdk?=
 =?us-ascii?Q?tSV6iLnzfxQY/St+0H/YxGS7WPsLDx5v9tOsgHoJIz4MBglRzVqh9p0NJecd?=
 =?us-ascii?Q?PFJlKY5WZFDUmJVCvBp/7CQ4F38yy4jnWSnIqVn4cLoJqvfvX72lnvLEuDju?=
 =?us-ascii?Q?8E0vou5h5W5oCcy2oKQUVdGEq2BONfKKc7GMm/r4WiEMuZaSXKufym3tocco?=
 =?us-ascii?Q?MQ0trjRX0ePDflg3uIadH/zq4oGFjfj2vGJxwSAugwWII52FgBXgOoaCmKCQ?=
 =?us-ascii?Q?sGWyAx02GUBuh0w6GNqmVT+VIX9ECBJmWh9a2Mdap1+cNFJMn+igTaA94nKs?=
 =?us-ascii?Q?9pxHKpDmzXFwW31iSiaTA6MhqWl/euXCrCkc9x7n1vYz/2B8wAAMG4Mjsc51?=
 =?us-ascii?Q?SOf+4KVgDjzBvvqqzFO5ocJK5L/PImMKN1m7FUcr5cAfZCOzmy7ecu42MLnE?=
 =?us-ascii?Q?R/T09sfxRWoSMJU1YkF/ck7HTNHf+V1A45hGNLnFB3fhnmE0Hy1w0GKkmuwz?=
 =?us-ascii?Q?jvIFJ/qO2AvyR6oMnCYUt//pUHX1z6LFGXk32f9fSCGBALML1EXj8OsC5l0U?=
 =?us-ascii?Q?PCEccQIHU2pfPQ/z4QYeFK5S1ng4NmqJJgoq9s70dUUqcBQg+ogt7lhLMZUS?=
 =?us-ascii?Q?wUpdZZhGXp8/Hvzly0bcR2eYZOOGAQJ27mYjqArcI8n1FIcwbgbWYndnr4QN?=
 =?us-ascii?Q?ZZYdzFiYi8TQBoj3grmL9s9ETy+p+/+sEjnq4rLmHtnUOEr0WQZ61ZWYX8F4?=
 =?us-ascii?Q?xq6IAddJnsOXkx4u92wQ6AXI3gSNR0ZpK3vMa/glUKIfzP2pONvZl1HyY2xk?=
 =?us-ascii?Q?G4LL69XbR6CQqCsx0sPprOVvlMcylNmACAkZp285Wu+ZVmYXi2tTDCr/5Vzt?=
 =?us-ascii?Q?q4A0+yxmTxDz1TsaoT5QpFHu5hbr1U3Zm5sWgCcAXIJ2nytSVCI68wu2pt/i?=
 =?us-ascii?Q?cSzMlqJnlX7cHeHSVnwqtzswt57hAFJYdkiG//yTtu6ivcl/BTE12OfqTRub?=
 =?us-ascii?Q?7kDT4AuEMt/5G2Njd6C8l9zHGXKU2k0kaXigSZeC0LfTgOqVGU+BEiSms+wO?=
 =?us-ascii?Q?AHUyutbeAP2EjHg894fplP71JzQPjpP5oF/Go6ezr24MCd9eaAG8PPFSwwjc?=
 =?us-ascii?Q?nRtyWM9Gr+Mt89o8EhEp1OFp7Q6DxHxyECzjpZnRMbl7mGopCA7PST/s+q5K?=
 =?us-ascii?Q?e65AU8ToLhsztfBQ93l/GXHfKH64Bg47dli23x6uk2RKqjBS5/rnH+t0sQv8?=
 =?us-ascii?Q?1UhSf9z2Og=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c63fde-c894-4d3a-63f1-08da1c2914e1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 02:06:39.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cs1mCKFRrYw4HuBqThguMt0KxoVA+xhy5nZ46BZD0SCjLjLyEY8MY+eWFMWP4fBOVnxrcChX4bTyh3hOOgJG4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5342
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

Looks ok to me now and should work for all architectures.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

Peter Xu <peterx@redhat.com> writes:

> We used to check against none pte in finish_fault(), with the assumption
> that the orig_pte is always none pte.
>
> This change prepares us to be able to call do_fault() on !none ptes.  For
> example, we should allow that to happen for pte marker so that we can restore
> information out of the pte markers.
>
> Let's change the "pte_none" check into detecting changes since we fetched
> orig_pte.  One trivial thing to take care of here is, when pmd==NULL for
> the pgtable we may not initialize orig_pte at all in handle_pte_fault().
>
> By default orig_pte will be all zeros however the problem is not all
> architectures are using all-zeros for a none pte.  pte_clear() will be the
> right thing to use here so that we'll always have a valid orig_pte value
> for the whole handle_pte_fault() call.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 3f396241a7db..b1af996b09ca 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4241,7 +4241,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>  				      vmf->address, &vmf->ptl);
>  	ret = 0;
>  	/* Re-check under ptl */
> -	if (likely(pte_none(*vmf->pte)))
> +	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
>  		do_set_pte(vmf, page, vmf->address);
>  	else
>  		ret = VM_FAULT_NOPAGE;
> @@ -4709,6 +4709,13 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  		 * concurrent faults and from rmap lookups.
>  		 */
>  		vmf->pte = NULL;
> +		/*
> +		 * Always initialize orig_pte.  This matches with below
> +		 * code to have orig_pte to be the none pte if pte==NULL.
> +		 * This makes the rest code to be always safe to reference
> +		 * it, e.g. in finish_fault() we'll detect pte changes.
> +		 */
> +		pte_clear(vmf->vma->vm_mm, vmf->address, &vmf->orig_pte);
>  	} else {
>  		/*
>  		 * If a huge pmd materialized under us just retry later.  Use

--=-=-=--
