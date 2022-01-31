Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8E04A5026
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379014AbiAaUb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:31:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63370 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229851AbiAaUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:31:15 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VJxW5E023752
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:31:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=NCrXZfS4J6Fzs9jwXciaxH1AN1ZJItWOm3JtIotwETQ=;
 b=Nz0T4KG/1ddYSCTJDQq8Hk5W7+CYv6lek9fmwa7/e4s7ItB8gq8vJqrb0RozapmPNWKq
 iawDWDpxplz0zdRfYBlLTj4Rr48M01APS3OO+V1j6t2HHoJfRkwv+02No8EPZtG220CT
 JS4jKUNIul0PZRPWep/lUQ624N0fUySRsiM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dw49wuc4s-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:31:13 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 12:31:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1lTGo8hZJvnDJwYhFXWqVgO6NW9U/mag0XLQO9KRV3/ONNPV9Gmh859x7IWv7TL/YPzp261ZTpCmLgL/9p40MPbX5pZRGvZT2vtcDFPgq84et6IK5GYwCd6DvDsynqZodIRGyZHjSdOyvDE4F9asLU3XR45ARxXEp+uTEMHCIdnNsHdnMzvitSErmHSxsYauMyj3YF+uGR1gea0Kicsl99S46mbSLGzwOTGHTF2CM+8dsN10vTUVOnRHjQw4sF00qLeyZCWwWRouxRU206xxxXZA5F4gnaVE5o6s+ka508pSoSVn1BQjuY7CMt9NKwLhJEfyQHUwG+knzWUUearZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCrXZfS4J6Fzs9jwXciaxH1AN1ZJItWOm3JtIotwETQ=;
 b=Tbc0Gbi9x2ETvk5QiDahjCG0st1UGtriO0bRoeGGpgHFnKx56TJFuiZK5pWR6d7LkJlXpWQvpLjiB8sBNOPqCwk/5k5NJuA9A9DCXD7yEroYSw18zvn1Nvgb/M6l1WBawLdaSTyTyRMWB6+ApfHGsz0kajtbMwzWd+qASyjgWHNZZ0tCVwNZ4tptx2ywK1mqH3FQvJ7QE5nLzJju1Anz671jWTM3LWBbZmoWAZL4BQ2ADK2IKTX89nBtKiFlmRd0FC2IHlKtG30mbfm3HUkYT2rQGyL7NJu5YJz0Iq1gCbYEtdxPeU/TrA7nMv0sxUurpMo15+gDSn0anWtX3JGLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BN6PR15MB1268.namprd15.prod.outlook.com (2603:10b6:404:e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Mon, 31 Jan
 2022 20:31:11 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::d1db:c0b7:3515:9551]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::d1db:c0b7:3515:9551%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 20:31:11 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Feng Tang <feng.tang@intel.com>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Possible bug for ZSTD kernel decompressing
Thread-Topic: Possible bug for ZSTD kernel decompressing
Thread-Index: AQHYFAMJn5it7R8zZ0OSLoTcXCVE9Kx9mvAA
Date:   Mon, 31 Jan 2022 20:31:10 +0000
Message-ID: <682F137E-25D6-43F7-88FC-D8C7ECE4517B@fb.com>
References: <20220128045330.GB87412@shbuild999.sh.intel.com>
In-Reply-To: <20220128045330.GB87412@shbuild999.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa29e302-15ce-4b7d-cc5d-08d9e4f89e66
x-ms-traffictypediagnostic: BN6PR15MB1268:EE_
x-microsoft-antispam-prvs: <BN6PR15MB1268F3B79EEF4252749C3250AB259@BN6PR15MB1268.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 29RTffcAjlMjyEzKkto7SECEX7GS85mqmZ5qfp+SPfUtkomYBVX061SNOtdc2UDJsp2zKDHE11ecxgPvhae6pKFPAr4JQ9a0mDXyOt5TKu4zXSmXdHgJiUm6PJiH3I+PQr0RT26u6eQvOLvr71ox1KrfUstJNAsQmEOSqCdg96dHlBt3E6s8eYdHH+1sKIdN0citJZ8lziPcuOeeKXoyxyCWKzJgOrU73tn1Uawg3KxGxw0FwgZ3TotQ1eIOqjhAqQkBUTBYXEYikEk2mSVmWSfeZ2BqBMHxUlLNbTlvIA1dE6wTIfvnbXIZfqmoSgnU6+zK0b6JkJEws+vEjnW1hyXDy0NKpb5BBrhiau2wDV/zPddHTFb5IeZUo8q83kkGA9SaWVNJ3LC+6uAvo63wYW4rUyd2Iz9ocN0AB/SuglIv7LddcHsjxGCyC42Ot5n6lOlrSpAb/vmZsYTHtRi5wDrjSwwZmoYB/6IXgWJQ3SBIe9S4mJXOf48+ZsoGLVjpi0dFVBLfhz8QlUVANhR68ewGRo6FVD6sSetHHkAHjCmZ+8hx4lmks9k6iX6VNE2piZbRM8nulhDeEBi+42U6lVCJ5BTa2l3xvQ299sVPr+7lJiZFl576CXvOJynz+6XuW/4ss6RKtFg/rm1sJWx+vy6X3YLvMhbHXFJdMjS9GX019WjB/JSZh1dWGJ8PijXr39PSC6NnBosxe6D4lbLsZcdedxvgA+rwNJd7RBJ3hDFkaH/vY8tFmRaOYlE68s95pJa42GFBVUXobxkFVqtBpk0aXXbWmNi0cb0iar3sY6B0Q4bdEPVzCAosCyUSiAL9H62K8OMLakLoizmUGeR0bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(36756003)(54906003)(508600001)(6512007)(6506007)(83380400001)(316002)(6916009)(26005)(66476007)(66946007)(2906002)(66556008)(76116006)(66446008)(64756008)(8676002)(8936002)(6486002)(966005)(53546011)(2616005)(186003)(4326008)(122000001)(33656002)(38070700005)(38100700002)(71200400001)(86362001)(45980500001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g0goTzPKWDwC3QQ+owFztEyDFHfY4jqdPTmnTXWliW+HXFNIgABQsUJfVQ53?=
 =?us-ascii?Q?qC66ZoGkA0CI3glNCO3vUEdIdNzEreL0crOKE0m8Vz+0pK3wOmXqNJyxByYr?=
 =?us-ascii?Q?3slQ3oRiatYkbLkPWguLLqk7PFbDBan4+LMm8daIvIwYvRi81otVR1DtpE5F?=
 =?us-ascii?Q?QLT1VM5Z6fbM5Jbw3E+lHOVsVfYonV6NMnLQTE4g72Q++whUGEQFvpwxU48L?=
 =?us-ascii?Q?zQFq36VY6QODzifp5jma8+bIaCNZjY+KQNqeL7iGTyjicdjyC3g6dWDTgX7N?=
 =?us-ascii?Q?4sI7fWJR2VX+Mwg2lXv/pXVB25hUdKxtE5yB7Q7DRDRT7cIGalWpDB5Phc9V?=
 =?us-ascii?Q?cJSfeTj3C6jeLAfAX6B9xXxLeqraePoRcjCBfvXMmWtHHtvDiRqobyFHZQ7D?=
 =?us-ascii?Q?AYdTcLPuwggVgJ4+V1KuiQapHEUwbEAm++mj6HjkkgvZ1feanyDFAgVyJIYJ?=
 =?us-ascii?Q?/tRycHDwZ9xEQtWbYXX9lh17585ySfGbr41644WN6PFPGkt36JmdVns2LqgH?=
 =?us-ascii?Q?S8d5GDyc3+HO9h9YBeRmmHxo76F7ByoVVFVRKK3fH/ec9OFYsUwOP7Vb9hzx?=
 =?us-ascii?Q?JDSk30yYDIrTMwxeq8xO2SJyGesR2TTgIt1xt+fSkemotlY3+kZYiLMG7QNC?=
 =?us-ascii?Q?qPwzV+cTbXMpohNbeyAIMlII4uvQDkAdPFRNJkS2WWv82Ry7/yXYJFDBuRBB?=
 =?us-ascii?Q?VC1+UBMhuPI6WCF2eEt+ocfhIIVoiyGIdoyje0Q9dmsh98lr2ujxPAix8fNh?=
 =?us-ascii?Q?ZQaJR078kK4vZ3LQTR0CjLpqfT5hXd/o/Sk7ZrQsy25ou4c3O3xSJVYM6eEE?=
 =?us-ascii?Q?PP1U0Q0sewaUggACxepo0XfnGjronUACgrZxgvedZinwQ0h12dQO+yzzDB2u?=
 =?us-ascii?Q?NESKTirKXW/s+rAaFPN3xKBD/7xS1vQO7fNDTIUcOBdG6VYw5D/hDG9Rb0uz?=
 =?us-ascii?Q?NDrfHOIyIEcw+pIrCvYDU+EhQd5Brav47Iqk3bUy9IFVEozdItUqZ6oP+zmy?=
 =?us-ascii?Q?fMJwNmJCjlgxYMb5Ur2tKhppmhVctSfjH0Y/v2fpVWxClHJOqXwtnmKMDlxG?=
 =?us-ascii?Q?thSDkkE3qVgS/WkAjIQ3AEb+tmypkJpxC4rA6rsau7vCMiqdrufrmUk8ZWPC?=
 =?us-ascii?Q?gnF6gfij58DEEe/aV7IA9+jGiBMbYS1LJ0YAhVDyh7jkw8RwyQiHYi7o/lak?=
 =?us-ascii?Q?tOVrs6/1HOaIQcp/Ez3sW0JMIiM8E92/KJ9ka8Agw4U3SVQ/WSgoRtXhWaK8?=
 =?us-ascii?Q?qgQYFsoRQQJC+z21u2JJu5wMXSthZm47lsLh4l7YWeCH5epCbH790VomOVFo?=
 =?us-ascii?Q?rjbLWN/mNqH1T8u1u8H/gcZwm846HCvWFIioR9TcpRoQNFAU388bAWuzW3EK?=
 =?us-ascii?Q?B63DOOw4DT7gtq5c7lvQL0xTSnb4+61kzqQGEVt+5YeZB2ZyOUyrKlqjnU+q?=
 =?us-ascii?Q?IsGcBoKn0DZLril+JisWhs4mtD2SRKkFoK2c9OxlSLnDdSV39vZ5a0ns8PQE?=
 =?us-ascii?Q?Ml2EqcIAuL3Ea7AKGq8eIriFrR3cRuwJJt5kQNIWDc5I9xjSFCpsLXuggyjm?=
 =?us-ascii?Q?NkfPrBNqxqby1q2l4hQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE563F1F664D7640951FBA8EA114D897@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa29e302-15ce-4b7d-cc5d-08d9e4f89e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 20:31:10.9414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GuJFeAf+HSv9ki3pzzbKLgA+iGSY9OL61jhHe+2i0NEwaeZVxxs5klk5M7CqEVNW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1268
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: TIC6gb6LJdwQXAr6faPPbXniz7stnEvP
X-Proofpoint-ORIG-GUID: TIC6gb6LJdwQXAr6faPPbXniz7stnEvP
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201310130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 27, 2022, at 8:53 PM, Feng Tang <feng.tang@intel.com> wrote:
> 
> Hi All,
> 
> Recently 0Day reported a 32bit i386 kernel decompression failure for my
> patch [1], which essentially increase the kernel data section's size
> from 19MB to 53MB, with error message:
> 
> 	early console in setup code
> 	early console in extract_kernel
> 	input_data: 0x05077079
> 	input_len: 0x00f8a633
> 	output: 0x01000000
> 	output_len: 0x045c4328
> 	kernel_total_size: 0x05040000
> 	needed_size: 0x05040000
> 
> 	Decompressing Linux... 
> 
> 	ZSTD-compressed data is corrupt
> 
> 	 -- System haltedBUG: kernel hang in boot stage
> 
> From debug, it is likely a problem of ZSTD decompression code, as when I
> reverted my patch and  hacked to increase the size of kernel data
> section by 32MB, the same error will happen.
> 
> Some other hints are:
> * same i386 config with lz4 and xz algo can boot
> * X86_64 + zstd also boots fine
> 
> This could be reproduced by qemu cmd:
> 
> qemu-system-i386 -machine pc -cpu host -enable-kvm -kernel bzImage -m 2048m -smp 4 -serial stdio  --append "earlyprintk=ttyS0,115200 console=ttyS0,115200"
> 
> i386 kernel config is attached, and the debug patch as below:
> ---
> diff --git a/init/main.c b/init/main.c
> index 767ee2672176..873f40ddf96e 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -162,6 +162,10 @@ static size_t initargs_offs;
> static char *execute_command;
> static char *ramdisk_execute_command = "/init";
> 
> +#define DT_SIZE		8192000
> +static unsigned long tbuf[DT_SIZE] = { 1, 2, 3, 4, };
> +
> /*
>  * Used to generate warnings if static_key manipulation functions are used
>  * before jump_label_init is called.
> @@ -690,6 +694,11 @@ noinline void __ref rest_init(void)
> 	struct task_struct *tsk;
> 	int pid;
> 
> +	unsigned long i, j;
> +	for (i = 0; i < DT_SIZE; i++)
> +		j += tbuf[i];
> +	printk("j = 0x%x\n", j);
> +
> 	rcu_scheduler_starting();
> 	/*
> 	 * We need to spawn init first so that it obtains pid 1, however
> 
> Please let me know if you need more info.
> 
> [1.] https://lore.kernel.org/lkml/1627456900-42743-1-git-send-email-feng.tang@intel.com/ 

I've been unable to reproduce this issue using the provided patch + config based on
Linux v5.17-rc2.

What version of Linux are you testing on? Zstd was updated in v5.16, so if you're not
testing on v5.16 or later, can you please re-test on v5.17-rc2?

Best,
Nick Terrell

> Thanks,
> Feng
> <i386_decompress_fail.config>

