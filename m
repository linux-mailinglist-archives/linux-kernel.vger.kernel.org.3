Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA53D4A0038
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350585AbiA1ShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:37:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24230 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236970AbiA1ShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:37:11 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20SB4qHs025214
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:37:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=nTudaPiiSQu6JHjuAd+tjnIKJOK0mSHxRaToxs5Fiz8=;
 b=f9arnsb/sKxBQccXyUtuxoh+Yf4tiOavaqf1Rq9u57l7FyiE2cXUI52wdBani0dmUAr0
 tKG9XaUT3oXCfJtGcBndHQwnNQ/kUq+AeCpgQQWZugsAhUcn9BuNYUEybQCxL5rQZLs6
 aKHjSizmhe2ryOjyTJ/fRDVnyRce/RlBQc4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dv8um4fuu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:37:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 10:37:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0CFK5uJqsmpM4E3p9H6aAVVLiqCXJ+UOcx9xXRv2dwtWeK7Z2U/39WjT1UTPTTYu6JzcOW2BXzw96D7Z02EmLrSOd272Ro98+skPD5hW03i9J9dZjOouDSgWRKuBUlpYof550wJ84KCDV7+W/m824NvCFIc8c1EIVp+2wWy8xCkDsBFDSzNHrsvff4Hcu5wBD5GzX7pRmsqK96KZhc7IeV5JaoJLGRTLrU3DKPJXkJIGFF6C/5NI1hFtPNvtMWlCxo4HzNNr7d/U0fsUlNI4Alq2awPEsg74NSx67cNkv7RWIz8W1PgiQSoA2+o9SBw1ckPYcm/mXmZUyKHcEhyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTudaPiiSQu6JHjuAd+tjnIKJOK0mSHxRaToxs5Fiz8=;
 b=A93+NWMpBcFUYZaZLPZyOqeMAJxe37wf6/yiGXRDbunxBrgrfDJshsWsifyV56xTlTyqVICv8pTax4qcWCjj7bIrqFXBxfgYtB+emroKs10ccxNr7YxQ/u1EZ5iddfa1Y2hEh2/cWMKMgtfV4RqZKtFyAUpFbBwLp7L8l7EnzWde3sS5zRTjPqVpSLvHoysQtj9JIKjBAP/mpsy1V+HjWW+CoqHNjmHmK6KJMbPXATyQgvj2RIlk7N/45i259jYQlFhNZ/uUyIEKCncuKFWxE52eivgLYbTNZ8J7DgEnfE6O9WFS+Sq/q1CVZhmwkXKNo2bQybtGKEvTG3HI3Wo4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SA0PR15MB3982.namprd15.prod.outlook.com (2603:10b6:806:88::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 18:37:03 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::d1db:c0b7:3515:9551]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::d1db:c0b7:3515:9551%3]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 18:37:03 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Feng Tang <feng.tang@intel.com>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Possible bug for ZSTD kernel decompressing
Thread-Topic: Possible bug for ZSTD kernel decompressing
Thread-Index: AQHYFAMJn5it7R8zZ0OSLoTcXCVE9Kx4xA+A
Date:   Fri, 28 Jan 2022 18:37:03 +0000
Message-ID: <2E1AE4F4-98F8-4AB4-8812-25FEBB1A03EE@fb.com>
References: <20220128045330.GB87412@shbuild999.sh.intel.com>
In-Reply-To: <20220128045330.GB87412@shbuild999.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7940ed20-aa07-4044-31bd-08d9e28d2de0
x-ms-traffictypediagnostic: SA0PR15MB3982:EE_
x-microsoft-antispam-prvs: <SA0PR15MB3982C03CBC308735A309BCFEAB229@SA0PR15MB3982.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yffdHJsxBbg0NrAT3mKOXupHKrqB5vJP70nmtilrsCvbdMRazZltBDOUSYjVl2VY/XJaL8L0Lerd5PSVjAXRn0kI4TbdoeTd21oPPmIqJlMmODZ9Z/AXdS04UbGZTBhCRQfhc97Iaq8kzaa/RkIPmV8oVWTKlwAFTHpyEMFd11N8sqEjRJ1FmTJzrZWBNRQ0FgaKkStXoaUoU5sagspGwhH5uJJaWfps040CM1+zHeBRENSMAEidBJhKuqeU0yuDrC0AHDxyXtdYs5129mqJb+V9RylCPUJwu3AlafksI4d1DXgNE4/62n3RcntXOB0qAoa6oPNPWTYthMMYVspOMu1DwWGnaIKQ3LfEoPb2GfSHnkbxH44Anm/GhyBM6imP3V4cxxQR08AwgSP1TNnaPyJ+uCZ7Z9alj2uLTol9LjGtj52CRpkmxIq8l765FqvVGQK48g/2suX+tPlO4OQ3WsxBnm0d/8b3wwUOfTbMKQD0czzL9IaU7jVyNSecvsoJ9YrCUN9oLGUy0t1wl/9z2JlTmSQ4U6j79Fid+5X750PXgXzIERyS9vCYPxdx8QxZnReeJpZfUqrSw6Da1LXIy3HGwYbWxIy0+Fowxu+rDEptpQ5yNA9EDpDgySQAdYbNWUkQpsYmgMLo5uHgOeFLYOacGI+GOstecVXqtmjw436mXCBV2UbVhkWi4JS3dgbcXzdXMvhxm+xv1B9+VABiFV4ZmECQgtPh6wu3W21Xtgver0uMOruSE35BzTzJX3+wYe2F2o+EilDkDpfiy4SB2b3KEtVfpwjda81uDBhzTfqQ5KiojH/sHP1cNz8y2dxEl0oHZtXkfKATnAcxEot9bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2616005)(186003)(38070700005)(508600001)(71200400001)(26005)(5660300002)(53546011)(6512007)(33656002)(122000001)(6506007)(6486002)(966005)(38100700002)(83380400001)(8936002)(4326008)(66446008)(76116006)(316002)(66476007)(66556008)(66946007)(54906003)(64756008)(6916009)(8676002)(2906002)(36756003)(45980500001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pz+1dybPzAp1trSOW/Q8zaphbJMWH1jXKEMNa6q0ii0I1HK86qwzagPNh/ug?=
 =?us-ascii?Q?8U1utXYSKtPYsmLvP2T+f6Rv30IAnYaDB2qxsLQ/jxNe57DS/twXQ5wgGFw6?=
 =?us-ascii?Q?RV9nbfvoDPINW//ZHKKdpERgpgeAJ0/HYU6WcS7wVuM7mv7SAJ9dnXzkIQnV?=
 =?us-ascii?Q?SJmZwINFodyypIki6khJVNvKJT2iodkh6YeiA+A2hU4ClqmH1smBSrdkbMmN?=
 =?us-ascii?Q?u6o5LW/COAQWaob+kOXBF4eNOXD0w2Y/Wd+AyP6o/LyoCzoWvPlPlZFqSWOG?=
 =?us-ascii?Q?IHFjwmVkma+0UGJApdQaC5IXJKV/Y9QxDIm1R3dIYRmFvnFW5m/Pek5KhCZO?=
 =?us-ascii?Q?HeEi3LI44JFuUaqbGMK7EgjULnMKLIGhSHO4RFyyHcVGrK+FRUQp3c+8t55X?=
 =?us-ascii?Q?rmnFThGv/4xXSpnODsPiWsAfqhIubU/o5hfdsEvIQy2A4v9OLbcatdlFz3Gw?=
 =?us-ascii?Q?J6s65Y1U0JHJX4op3y5EMjaSoY2jUpiIHodg5LVwQTECHRq6n/NquXTMnBhL?=
 =?us-ascii?Q?FjQlqR0Kmp5Q9P23DYHDX2BmpKB/Bq3EjkUPKn3r3YCp3WpM46z0pyMqJJQ7?=
 =?us-ascii?Q?UIh8UHsiDcBfznVs2RnJ99CawLuiJKDXDkk9p7u2u351BSsnOD9To63jJ1WV?=
 =?us-ascii?Q?k4w5elqUUYWQk6gPglHLwDmlbM90Pjcn9/rLSzIp+jtzVSf1/6e0j7qLOLHE?=
 =?us-ascii?Q?G9aUwrk5UO1b7TPug2sJnThp1IG19nYkzDVycfPVSwTX6cT5I+ike8bDlbJh?=
 =?us-ascii?Q?fvbT33DZ2aaMXqw+NNQtdPcgjB892J5u+mOxaSdOWJZ6kzYgzLNcpY50grJI?=
 =?us-ascii?Q?7I696A4hO2hNUSA7IXCpiIjiT33+ovcPSRcfw+dzdPkLF2vUy/UjU7HWxRmt?=
 =?us-ascii?Q?6Q640Bk5+HIqdwoFY75FcR7IB2ohwEIpt8ehKQKlt5kZAyw7tFSHuSHtaR6D?=
 =?us-ascii?Q?cpRZbq5ZQD4aY2ml5p9yuqgZO/cn7q6uqNsmpOdhj4PvjvqRIhSRsNH8dqYV?=
 =?us-ascii?Q?L5nWhogOhd6eVY/Ohcu/nZKuOvvCpEufGEyl0j8rWy36T0cIEK/s2yewYmSb?=
 =?us-ascii?Q?iMDalRxXk3mhmHQl4LUqql/Oa8fDHi/amkLEmDWqrRQRYtcmtpTLdNkIE+kS?=
 =?us-ascii?Q?7riVDdhOasrUBKJlCdpD0nHORaaekM95ACQLpcRdCnGfeEkESjwqcXLZhdAB?=
 =?us-ascii?Q?ciAgbwUi/tRoGZS4dZD/boQNcc56FPwGefgtg/+4LJYLSUEhgBRJjkd8UB6C?=
 =?us-ascii?Q?85PIjnXjKCYL1jjTQyXpr6r84+X0OyszalCd8prKfkoi/2xeHdJCZuZi5ldZ?=
 =?us-ascii?Q?GhSUFOT2qBF+b1r0yW2AnZL2KycozioytCcWD9ilHNui1K/pJ/u9lZyDGm8z?=
 =?us-ascii?Q?P3eBshk1+7NcMVufzCblg2jUvHnsmR12OuRZcZX9d1RGoLbclF5ILLrAW5CA?=
 =?us-ascii?Q?PYqXqp07U5oOmsncGe1IDpU0ot9ls2c/9ILQheKnCuU5oLX/K4hKOOOFBPFD?=
 =?us-ascii?Q?l1zQtHs55aV6k+U+FnWoIGpJFKxq6joeGR/SQrKvcMaMZiIe2lQHr7M6eE0Z?=
 =?us-ascii?Q?anfZ6QBFswhIGpcOaVI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <741C0477EA35494DB9A4F8ACBD1AA337@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7940ed20-aa07-4044-31bd-08d9e28d2de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 18:37:03.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dkm/8WXEOyff83/VBEhkJzTJ4e+2Y/ek2TnOLeI7w85s5zNCcQywLdk9cLnI+WZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3982
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: llqmYWY5qTo4PM79gCjJZtXOMI_0K1KD
X-Proofpoint-GUID: llqmYWY5qTo4PM79gCjJZtXOMI_0K1KD
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_05,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0
 mlxlogscore=981 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280108
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

Thanks for the report! I will look into the report this weekend.

-Nick

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
> 
> Thanks,
> Feng
> <i386_decompress_fail.config>

