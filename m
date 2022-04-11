Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FDD4FC475
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349249AbiDKTAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbiDKTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:00:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE141FA74;
        Mon, 11 Apr 2022 11:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXH6clXYbdM8ohAJDrLo+oeL8v8RfWTzxQBsAZ756MjRJYXvKR44GuYWD2/TRKAUDGUOSOu7DiL515h6a5qzt4a3/7Ca3vd2wcK/UCbTJaiEJc+w+a0dl0U6SWSLpxjAREoCgzfvrArI9D9vxKWW6D7/lrlX1gJnmNsWap2KH8231rm4wX+Z2pr0qzoWiIJ4YJ5+LH8K/+atopkK2m0OweTA6xIGsjmSQyvKESAemiF1RPsYvEPQVRr6SUk0MgzNhzTNKb5/A5Tv981HQLdhf0elTSW2Js0bQdUVePvkdtwnRJm/GFwaZIbzubEznuPP0oC94AqwG2g5ljXftpauaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNr+aXkFl2Uv/0LnxRNPGDl+EjFvEMEPisVUt5oROSo=;
 b=DrPy6/wefoERmnd/OR56j7wxriySRT8hOhpXlrA0R3sjPjwKLKa+hu6t2ypRtFkYRs9QwEk8Vzz4IOrq0j7BZfkTtlWPiblXC2QI/fY3JyEUGoHDpm/kLh6wV7zfD4qQrsV6LTm49GrSrggIJZ0gww7tkTOHiIKnsVKbOqgnFuftwTIDrGHDmQFJaiNCMMymlqFx5+2Ayxjptikxe6/wImVp4ijz2Zx0R01f8r2QAy6jiMOmi2FVeMfFqITosqTEcWMcMPIYZ/k14bvdeKIrGRELx28UDp9QaPbi4QjscM+OshB+dCYMf9v3ZIt2jt8KG9oH0opJIVCJZzPrnLmh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNr+aXkFl2Uv/0LnxRNPGDl+EjFvEMEPisVUt5oROSo=;
 b=dGDRzgzdIZrl+X7xyS9b0DsmLEqvZzLzp8+AvnBRX+2h0mGL98G5SL/7dpt2vn7eky9MBkmokktu6eF/UNXUAJ9w6LcFJ+jYopR60yT556NpvPQ6LVQ8QxJGdsXJUakV/HuMWLxSbJY3ALatbg9VBs5drlEm08kWNfnetCIWSlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 18:58:03 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1092:2d0b:9aa4:30]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1092:2d0b:9aa4:30%5]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 18:58:03 +0000
Message-ID: <4278ae8b-eb87-06ac-43af-41a1c741f9a9@amd.com>
Date:   Mon, 11 Apr 2022 13:58:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] crypto: ccp - Fix the INIT_EX data file open failure
Content-Language: en-US
To:     Jacky Li <jackyli@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220411180006.4187548-1-jackyli@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220411180006.4187548-1-jackyli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:208:a8::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43672e3a-692f-4848-9f92-08da1bed347a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2488:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2488971368F9423D875EF687ECEA9@DM5PR12MB2488.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cmy1HJpjFXy76HkGCE3kUGcvDnIpLdYBnbh4tDfL8ZDwl8TVsQSN7UOtEwizAiXpFSIGQGIFWegXjs60bjufVoTAFNg8NylyumJAyojNSzUm7dWrenZvXmf6uDrtiw0vEoSkqgsNs5qQ61TA3xbY6OkJ03LiF+gzlp3NnDxI9F12fugFV3lvk96/D6mloBkQYbW592TuKYCwmnPMYIQEZ3UBaSpV9AOuILV6oYgNwILgX8SQoqsLEFT1m8ds5qVDokHPnu6DEKryf7H5KQWD1jXn3KDp4JIq/DyE53+VUHDhEYtNrz9zS7hS5n4mrENsWjwAB5yE2/jFSicGYaHawvBr9nRF0n9tw4H0zGGUK+f6WfS9wmNgQVdlYKikz4CLvBzxAP2h50apR7FfU47x/DccY7haE0ibHuPUpVRoJVmNIUjvpA5R8FNl5lSIPLhS6qiLLpmbGeHh/9Z3BkBfrxioiEgcIoWzUyTxDCk7ZJp/M3htWof8oR13mzxUtpj0n++h8ll/TfmU6YtUukDYXlM1Fr51omcxC1NxzvoBYxNOP62uWGVZ3YbaoXX0HBs+ddFvyQM36LKt6NQlqozlPQ8Vo6+ZSTMwjeTktvA5Od4mJrqu4nZ6CPip1DymzcWVH1OX0VWKuWnLCp9HXXBbokmeSg/mtVPWTD0n4j1xXh6At//vBHCOXQYVsDGm3hZuhc5xjbvFmsNGp61Us8E6KPeAJIeqCHToHi7GQfIcB1zFuHWZwhVxOobnyKcDsR3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(38100700002)(6486002)(508600001)(31696002)(110136005)(86362001)(8936002)(5660300002)(8676002)(4326008)(316002)(54906003)(66946007)(66476007)(186003)(26005)(6506007)(6636002)(83380400001)(2616005)(6512007)(53546011)(36756003)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkdoNS9sOWlNcnU1MHF6OTcraWFjemRMaDNXT1lkVXp4K0oybDliUjc0TVcv?=
 =?utf-8?B?QW8wVlA3ZFRsQVZmc0hxL3FOb0dzc2l6R1ZvaitrZkVnOGxtY2t1WmpqWDBJ?=
 =?utf-8?B?di9LcDFSVGQxbXFuK0FiNldkMk94aWpHSDlWSzBDWjM5TU9OWU43bXdqUmpr?=
 =?utf-8?B?YmR5SEFGNEJ0YnJNcElOWVhjdUJTTm5DcmFiQklNQkZpUXhRQVZwNVNTU2V1?=
 =?utf-8?B?RzB2UDB0MFgvbFJ5UHRMRGFTOHRmRGJJZ1hVejVrSnN2U21rZzJ3MXlqa0Mr?=
 =?utf-8?B?K3ZLQU54bXNTc2hWQitjbnBXa1piRmNrSytHUUhGUTZaL05jV0J6NWl5eVVp?=
 =?utf-8?B?YjVHTDRDOC8rRXFRSFd6dVlFZzdOaEM0M2gyWC9WT0xxUXdPS2dVVDBZSE5V?=
 =?utf-8?B?T0JxTXNMYWozRTZvSUtyUzFwWXVsWC9LK2JoaGxUV1VCbnJrYlVqbkIzbzRO?=
 =?utf-8?B?RGMwYTAyK3B2NE5CdlhEQTFFM3dEa0ZGckRxaWlmTFdIRm5UN0U0WmJQSWta?=
 =?utf-8?B?eWlRS21QQlZ1VENpaUtmQ3lNSnFUb01XTEJDdm42b24vU0QzMmVLL3ZmRnla?=
 =?utf-8?B?c2k1WllrSi9veTF1dFpDemlMT1l2bzE4dUg5N2IrcjBNbndLVG5rc1NHM21C?=
 =?utf-8?B?UTJSZSs3NVRhYStxNlVnL2xkMmkxdzBwTFRiOTYxRG1ETW9lOWhyOTZFS0FJ?=
 =?utf-8?B?L0NqV3VQTU96RUpFS2FuYTJabmhRMXRZRGVMQ0dMTVp0R0JGQkgybnNqM21u?=
 =?utf-8?B?eE51NVYrQXVXRjE5OUFJeWw1RG44L0FpRTJJdjZsNG5PY0tNUzBQcDhOMDRL?=
 =?utf-8?B?SG1oZEY3aVRWN2ZrSEJnWnVyVDBEUm1XbkFYS2tiMzFLWWlUTUZaczVjRm0r?=
 =?utf-8?B?eGppdmNvS01DNDYwdFZFV09WaGlNaTVSNFBOdzkwZHFSRjhsd29sWndxWndm?=
 =?utf-8?B?ekk3M2FnZnJ3Vmx5bmJhRHYySXErMFBuVGJOZWl3QzFLU0Ixc1NqSzh6Szhh?=
 =?utf-8?B?MUpaRzlnc3RkYnJHOXNQTWpudFlYQ0RQeTV0Y1ZRaVFzTzBpOXMzSnJQdVVn?=
 =?utf-8?B?aHI0YUJ2MVMzUXpoRkw4bkxPZmJDUVpULzdtTm03ZVdBK095WXgrR0RZWHJp?=
 =?utf-8?B?MHZxMTA4ZDN5NFA3K05qQjBpYnhaZmUzQXYzZk4wWHZGQ2pBajN0U2xzS3F6?=
 =?utf-8?B?NitrVStwdDBFNVV6djNmK1pPYXdiT1lXSndsY2VzUEJZS05SOGZBVTlKVzF4?=
 =?utf-8?B?amgyc1NQbER2d1Q4MVdSQWlLQ2lEVDNrWlhCd2ROVUd4aE5PWk1oaVdzczNN?=
 =?utf-8?B?TTFGanpENWhMallnV1FhSWpudE9NTURaRjBJZ0lYVTFhVHVSdm10L25BRkFW?=
 =?utf-8?B?bW16dkI1SnF2bHZ0Rno2TFZzUDNHdGxHU3hvRFhLa294N2hvdlJxZW5mczlr?=
 =?utf-8?B?SHlKemt3c2R6NUo0MVBVUTg2cFE4aFE3aUlYUFkrblpOb3F4dEwzNlFZOVp1?=
 =?utf-8?B?dkdEd2xONHhiaU9LMDJjYkxJNXhDTWE2S2tqanVQWjJOR0w1eHR6MERaVk9n?=
 =?utf-8?B?UmhzaFpodFBUZ0dzMDNmeTAyVDBQWWpabGJXT3RLdnJiYjhjY2dQSGZTUFpI?=
 =?utf-8?B?YUhyYSthY1QwTVpiYzlsS2NEKzlweEF4Ry9mbHdYM1BNRU9PajBaNU5obVhY?=
 =?utf-8?B?RGo2UnJlcU5XQXVYRzB3bklKRDNuOHhmU3RXV05PS2xmQ3Y1Wmp2SDd5dUdn?=
 =?utf-8?B?STZrTlZhOTdpRTcxN3NPcVhrdm1IQWxDSElaNUpGdlEzMmZ3VHNhb1JRUnBS?=
 =?utf-8?B?a3dZMDFxa0lsMXRnZjNPZEdsM25FWnZDSkdJK056QWl5SHoycjhXcTNvZXJs?=
 =?utf-8?B?Zitwc0w0Z1JXUUlHbURMbzc0cXErRk53YmdwcHkyc3FoSU1zaWJDMy9oUzZS?=
 =?utf-8?B?UWRUckl3V2hEYUxmWjQ4blIzazR5cS9xOTFMQWljUGlHNGNIR29lUlp3SzFl?=
 =?utf-8?B?MlMrZU1DOTZYWG5rcldQa2NVYm53M1EwOHhOTm82UXhxSkFUaS9pSFdkalhK?=
 =?utf-8?B?K2RNVW9ZazdjZGxLcEdSWFFUNTJzelcxc2tyMWpzS3kxdk04NVR5aVdKbHdY?=
 =?utf-8?B?SlFWaDhXV090Nk5DZXFiWFh3b09XZmxHTWRlbHo5WHhSKytpb3UxRDNCS3BZ?=
 =?utf-8?B?a2RNazVQampNUjkxbDJLMCtoQVV2TnhCY1FRYUxIMTEzNEhhZVl0RmdRblli?=
 =?utf-8?B?cFZ2QWEyQ05rak9UbUxxTlBKVVFGSjhreFU0QVIzd0Z6ZjZuVVBYYkdMb05L?=
 =?utf-8?B?cnRhQWRxKzBCbk43ZVJsb3VBUjdhSWdYWUpmOGhjcENoK3I1Vk9JZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43672e3a-692f-4848-9f92-08da1bed347a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 18:58:02.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaXIE0Aiw29Aeyk99cxi7d4CHrbwCKONayfXb3o4oiqnCLrKkQwctgSp3FXz4Dv415/PU25a+jGjnlieYUCsVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 13:00, Jacky Li wrote:
> There are 2 common cases when INIT_EX data file might not be
> opened successfully and fail the sev initialization:
> 
> 1. In user namespaces, normal user tasks (e.g. VMM) can change their
>     current->fs->root to point to arbitrary directories. While
>     init_ex_path is provided as a module param related to root file
>     system. Solution: use the root directory of init_task to avoid
>     accessing the wrong file.
> 
> 2. Normal user tasks (e.g. VMM) don't have the privilege to access
>     the INIT_EX data file. Solution: open the file as root and
>     restore permissions immediately.
> 
> Signed-off-by: Jacky Li <jackyli@google.com>

Should this have a Fixes: tag?

Thanks,
Tom

> ---
>   drivers/crypto/ccp/sev-dev.c | 30 ++++++++++++++++++++++++++++--
>   1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 6ab93dfd478a..3aefb177715e 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -23,6 +23,7 @@
>   #include <linux/gfp.h>
>   #include <linux/cpufeature.h>
>   #include <linux/fs.h>
> +#include <linux/fs_struct.h>
>   
>   #include <asm/smp.h>
>   
> @@ -170,6 +171,31 @@ static void *sev_fw_alloc(unsigned long len)
>   	return page_address(page);
>   }
>   
> +static struct file *open_file_as_root(const char *filename, int flags, umode_t mode)
> +{
> +	struct file *fp;
> +	struct path root;
> +	struct cred *cred;
> +	const struct cred *old_cred;
> +
> +	task_lock(&init_task);
> +	get_fs_root(init_task.fs, &root);
> +	task_unlock(&init_task);
> +
> +	cred = prepare_creds();
> +	if (!cred)
> +		return ERR_PTR(-ENOMEM);
> +	cred->fsuid = GLOBAL_ROOT_UID;
> +	old_cred = override_creds(cred);
> +
> +	fp = file_open_root(&root, filename, flags, mode);
> +	path_put(&root);
> +
> +	revert_creds(old_cred);
> +
> +	return fp;
> +}
> +
>   static int sev_read_init_ex_file(void)
>   {
>   	struct sev_device *sev = psp_master->sev_data;
> @@ -181,7 +207,7 @@ static int sev_read_init_ex_file(void)
>   	if (!sev_init_ex_buffer)
>   		return -EOPNOTSUPP;
>   
> -	fp = filp_open(init_ex_path, O_RDONLY, 0);
> +	fp = open_file_as_root(init_ex_path, O_RDONLY, 0);
>   	if (IS_ERR(fp)) {
>   		int ret = PTR_ERR(fp);
>   
> @@ -217,7 +243,7 @@ static void sev_write_init_ex_file(void)
>   	if (!sev_init_ex_buffer)
>   		return;
>   
> -	fp = filp_open(init_ex_path, O_CREAT | O_WRONLY, 0600);
> +	fp = open_file_as_root(init_ex_path, O_CREAT | O_WRONLY, 0600);
>   	if (IS_ERR(fp)) {
>   		dev_err(sev->dev,
>   			"SEV: could not open file for write, error %ld\n",
