Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6705148E11B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiAMXox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:44:53 -0500
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:3264
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229870AbiAMXow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:44:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVzq6oKXgW4GSBFadMq49DUxAs3wMU/2bRjt6Op0w5m1+hE4sZCfr6oxf9HM7Kt1Hl0YsKsEwu8ytyOhsmsP/G4HPgWEgZFoaewsVhId/iFvbrdgIY5LeU2/W5itQit8dRTidAScXgvHMroKHvhKswEnL2meSl2Ohwu16ZFOjQyipfcA9JNHzYe430mB2FtQPqzKBni6YcjZElRHcENJ3AiXJK76aVBBifNUvAt//PtQX7VW5Lsho6LtQwrCsZb+UT/AozhnjO7CtJMhP8fn1LYgF0urJjZ3no40gUzlt49YlIPf7OGkbJpJAwhVKtSRsqd5VjzYz3ZyPb3kP+H67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sQWJ1ZaLc8+JnvToca6PenaVOGX5ikRvtJIafvuAf4=;
 b=jNaCYUfSnPSk2oBQZ3wpKY43k1oM1HS4m4YvFTPeNxOsUJC51ktnMbwx1aazxhiCG5g8DedR1potyZvjiVBFOo21Ogg91Oip7ncRnyJ4S5kExsOooyr9Im0UoxhJ2q+IY1YARQeFuX3nFYt5S98Sz7SAxvYY9oNEhyav/m8FBOc1L/1D62uDgCaXWLPNDQG6f2JxkT3ipAHJxp4CfKxwYWP605fX0gTp6vyUuryykZM3AMV2LM0uFZtCBKyvPKrlNAfdMYGprlpNgq9//t3FUIBBJLKNARMDLBL2Q7YJwsf+UaDDt9zMkT54u7c2XO59gcsYHsm3NqKVjgNKDZJn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sQWJ1ZaLc8+JnvToca6PenaVOGX5ikRvtJIafvuAf4=;
 b=ihp9d+T6xaUAxwJLJogzmJ0BfFYzuwJieysDn9L0C828r6zwk8OiBH2TlSaheyZTX8pWQuscDGLaAY9EhLRNyXI8TcocB1XQvJWsnOWYQSn+oqFW4/3ZHH/TC1rjFGWLj3ECRDJNL3chM5hgBAOHJ3ZA2RTyQu5MDlHS57d9xyvpAL0ZK+mjj9xUbeQuXOtfVPqYEp/RQHY+DNA9AJLCxdJ1JmHHpYXpGLG0tHsicE2VNg83hI6s2YWJxC/oMOzIlPQVv3iqJnZ9V5aW0SGKiumIRrdOtct/6zkc4UNkkv8js2lXG9UyuNsC95O0/LeqZocJvQsPBa85LrNE7ynr3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MWHPR1201MB0206.namprd12.prod.outlook.com (2603:10b6:301:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 23:44:50 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 23:44:50 +0000
Subject: Re: [PATCH] reset: tegra-bpmp: Restore Handle errors in BPMP response
To:     Sameer Pujar <spujar@nvidia.com>, p.zabel@pengutronix.de,
        thierry.reding@gmail.com, mperttunen@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1641995806-15245-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b8cfbe19-1784-0a75-a5bc-26f57043cf40@nvidia.com>
Date:   Thu, 13 Jan 2022 23:44:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <1641995806-15245-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR02CA0027.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::37) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb143dbd-790c-4a46-ef64-08d9d6eeb094
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0206:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02065E4BDF37898F63CAC3AFD9539@MWHPR1201MB0206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: us3wn+gF1Q9YHrmGXdG+FhT49o+nKSkRxOeWlYfrQUBPENxlqnTrFj5aXdC6cR9HtdbgofwhUwrgmm3gOnalZAXUJDyUGDiau913Qwug4OoKJWOj0PE+zA018QrLb19/6SN53/KnJLGiediScDzsq8/Sdt6QavANFZ47rS5wmMDhECTFR51n8DkFGIudunSahMV9BBOAcO47VUafGO/NnHZExkI5eUCKMh0vq888PvHIq4cl1JMaG4GupV0xZHFSC45AAvOZS1mpUzUZMyA7PtVZwnkav0S3esb4d4tqAb+EozTVGjVcT3YlkR7MbLfc/E33rEHOvuWQOP8OH37/4NRVeIkE+jLl3n2Ow6d6TxXR7ThWHUj+gbyFBHkF9z3SgRHx4RjfKpXU2f8UeSFRNXnDgvqneFuGAVwM7qOa4KcRe7wmH2+PXaHStsuzkMsT31it28GBnjrRXrJgKDnl1LBFtWMNmzCZhoSf2Hl9AkNU/+8stnDpizlpKRI7m7xhhPwHINj5djA0YyuoKMpakxMu5ZjpUV5dq/3U0n+IulpP76PKFOFokaSo0/eorrd98i4TFC6fRFkSCXT2Y2JaRCxiC1vsXBHOtBDYS+A/P+3u5rfwRDgYzfvHZMa0HcZYZpux6CBFcfTjPB9CSieGh2e7FTqVxkQTjTaQshKkyY7QKkg9KWjzmV1TKhRfqTk1+qVsIYoZs3ZuTCZn1NmPi9T6Ns53PELpKFxPqihFcMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66946007)(6486002)(66556008)(5660300002)(53546011)(186003)(316002)(26005)(55236004)(6506007)(36756003)(38100700002)(6666004)(66476007)(83380400001)(6636002)(6512007)(8936002)(8676002)(508600001)(31686004)(4326008)(31696002)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnFQaFRhUU1KM1BMakkrbVVhVGxrMzRpOWpVRUFlNTdvSUFmR3BacENYenpo?=
 =?utf-8?B?YnEySWZkd3J3b0U4YVBEOXdrOE1GT2t1QWZLbEowTzJHOTQ1Z250WjIwNmRt?=
 =?utf-8?B?NWlma29SenNGS1p0RE1RTHNEdlF3QUlpWnpId2lCSTF5UXM5dHBsNXkzYzND?=
 =?utf-8?B?Vlk0Z2FpZ0drUGk5akZBYnRVZHpSU1lEQTkzVVhyc3F0SnBxMno4VlBaNnhm?=
 =?utf-8?B?eERkbjJOSHRERnJEdnlUcWRiWCtxSFI5dEw4a2JyR2ozNmJqVlhocXczVnRw?=
 =?utf-8?B?a1YxV1ZyWVRCUGs3RkxCcGUwY253QVp1NmtGUnB2TDhpUGtpNTFQQVZmNnlO?=
 =?utf-8?B?enZUckI0QWdHNjg4Z3hLLzJteUpXVTE1MTk3TlVQbFRtWHNicjhXTHVNVVRi?=
 =?utf-8?B?OThFSTdaS1VjREJYLzdrVjNVZW1GNVFjY0NCVjVWeTIxbmpRc0lYSE5KdnNo?=
 =?utf-8?B?QjluVElySWJNc3VodE0wY093QWFORE93SGtCQ0pkdUdVVnB0cXd2KzM1QjZH?=
 =?utf-8?B?M2pHbEswazlLNFplMFlobXVwZ2d4ZlhnbG1TV09QK3BGV0R2V003NEdSZTE1?=
 =?utf-8?B?N1JSN0hkTmpOLzlCNGVVaW51aGNwWFNpTEdqYUZmR1VzRWlSeHMzUHl4dE9x?=
 =?utf-8?B?bUlyVzRqZzQ4ZE5GaUk5cUlIRzRhZGhaMHBKSXA4cjJwS2dZdFpzZ2NYVnVn?=
 =?utf-8?B?MVkwa2E4UVNkaGU1amJGejlzWjlZY013VkdQc1FKMEM1VTJwS2dDeEJmdWNS?=
 =?utf-8?B?LzlzLzF4OHVuWjBCcUVwQTJEZlp6elFsT1I5MTRjVVBOSUpsWWVWbWxlblRI?=
 =?utf-8?B?SFVMbXVwekF2QUZaZWhVaEQ3UEtXd091VERxa2I3VEFDcnZ6cDZqK2xONDYv?=
 =?utf-8?B?ZUFEdy9iQTh1bnJ3eFpJS0hzVGdxVjMvNG02QktvSjJuMXdseFhyZFMxRmdR?=
 =?utf-8?B?NWVrOFJNai9YZTJ2cjdaOEdRT0dTYnQwTkJaSkVRRmx4RS9xZENLNU10K0la?=
 =?utf-8?B?YkhEcExsTURRdkczczFWZzZGSGZQMXFGME1iK3V5QlRLbnp6Sy82Smh5bWRC?=
 =?utf-8?B?aU4xdWVuT2tJRC8rSWN3U2Q3RjhWWS9XbXdPdWVpT1p0UVZPVGdsRnBEUGM5?=
 =?utf-8?B?dFpwRFpZMXFJdjB5bitwOWk1TTRJVkh3Wmp2Z2xkejFpS25qWE9BSzJvNXJN?=
 =?utf-8?B?eVVGTWg4cTVNMlFIWkNHL293UjczaFByK085dTB6dnVDTkduWFllMjJMQmZS?=
 =?utf-8?B?d2lyUXMyMml4cW5ZL0Vsc2Vic1kyMWNEUEVqam1uMjlUYmJVTXBaVW9EVkdU?=
 =?utf-8?B?TWV3Q1lUZVk1MXgvYlNqcEo4aDJNaEJCZGowSGNib2hFK0xaVll4QmN1UVpD?=
 =?utf-8?B?d2tGckp0RXNOTS93Q20rVForbS9kZnFCT1NCY3dMcFkxbHZ5dFRsTXRMcHJm?=
 =?utf-8?B?V1VYbjFaR2VqY1VScUdVeGsrM2IzYVNqZVJERGxvZWJraE1hTGhZT2xqbUs2?=
 =?utf-8?B?V3dSakRrNXUzVU9yelVkdmZMUmdQRVFudDBZOU9aZkxpZG4zT2pyS3BsN3pE?=
 =?utf-8?B?b2xQa1pGTUkwL24rM1kzN2lVeit0Qy8xSDZIQVB3aWV0VjV2amY3ZmFEcGN4?=
 =?utf-8?B?eEU2U2F2NW9qeE9BbmdTY0VHM256MGZNeXBjZHBzYVdEZVU2WGN4WkdWOWRJ?=
 =?utf-8?B?TmpIT1U4aUw2Y1Jld2YyUmJyQnQ2K1hTeVFFMGZpaGZESm1MS1RUZXFWWXRv?=
 =?utf-8?B?VHh2NzRycUdtSlRPbzFpSTN0SldkUnZyS3UrQ3J3WW1hWHhpbXdnd0V0Uzg4?=
 =?utf-8?B?UUxzMnVpVDFNZmtGVUQ1V2JqTjJxNUtrcU1OTUpudFlqdUJPdVpEY2dkVkh5?=
 =?utf-8?B?Vi9ZaWlQYk9hK2M0RU83WXoycnJsSTZkWVYyNHN1NkJncEFkM2RYUmdkcDcy?=
 =?utf-8?B?b2VkREtYS0NXdXdZT0hGcjdPazRzVkVBV2RlaklPcmZOYlg1Z3JWSUJzYjl2?=
 =?utf-8?B?YUxoRjRjamduMi84eGlUMlV1WU54OE42ZjlKc1UwUE8zcWNEVnNVbU5qSlpa?=
 =?utf-8?B?WHd3Mm5LVUpvVjRNaUhZT3ozZTlTTXVUT1N2SDVwUllxUmtOYUpmK2VkbmY4?=
 =?utf-8?B?NFNvVTlYYUROY0ZzREFjYzlOb01wRS9tUTIwTENnUDJ4YkQzVFFOY2dZa1pm?=
 =?utf-8?Q?WnnQ+TY92r02UoZcWh9ghSs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb143dbd-790c-4a46-ef64-08d9d6eeb094
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 23:44:50.6808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsEgGx1v2kPPgVFTgUtzCSZHipeopW59v51L8G0Nssrx9SiM/ONuQcgDL+7IATshJ9UdYCECxjNkvzidm+ysOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0206
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/01/2022 13:56, Sameer Pujar wrote:
> This reverts following commit 69125b4b9440 ("reset: tegra-bpmp: Revert
> Handle errors in BPMP response").
> 
> The Tegra194 HDA reset failure is fixed by commit d278dc9151a0 ("ALSA:
> hda/tegra: Fix Tegra194 HDA reset failure"). The temporary revert of
> original commit c045ceb5a145 ("reset: tegra-bpmp: Handle errors in BPMP
> response") can be removed now.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>   drivers/reset/tegra/reset-bpmp.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/tegra/reset-bpmp.c b/drivers/reset/tegra/reset-bpmp.c
> index 24d3395..4c5bba5 100644
> --- a/drivers/reset/tegra/reset-bpmp.c
> +++ b/drivers/reset/tegra/reset-bpmp.c
> @@ -20,6 +20,7 @@ static int tegra_bpmp_reset_common(struct reset_controller_dev *rstc,
>   	struct tegra_bpmp *bpmp = to_tegra_bpmp(rstc);
>   	struct mrq_reset_request request;
>   	struct tegra_bpmp_message msg;
> +	int err;
>   
>   	memset(&request, 0, sizeof(request));
>   	request.cmd = command;
> @@ -30,7 +31,13 @@ static int tegra_bpmp_reset_common(struct reset_controller_dev *rstc,
>   	msg.tx.data = &request;
>   	msg.tx.size = sizeof(request);
>   
> -	return tegra_bpmp_transfer(bpmp, &msg);
> +	err = tegra_bpmp_transfer(bpmp, &msg);
> +	if (err)
> +		return err;
> +	if (msg.rx.ret)
> +		return -EINVAL;
> +
> +	return 0;
>   }
>   
>   static int tegra_bpmp_reset_module(struct reset_controller_dev *rstc,


Thanks!

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon


-- 
nvpublic
