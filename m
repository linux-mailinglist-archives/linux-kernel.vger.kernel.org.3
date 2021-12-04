Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48087468847
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhLDXkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:40:25 -0500
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:60673
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233976AbhLDXkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:40:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFcLk2FQvJbhcocqrBpFsSdn2N4xkHnuSzad0hHfoSyPTfit13XQ2wtZ7DeJELLYpeXgYcdDzrJoTgo/1I5XxnP2oI/jRktUnsz7qLwteKWcO4ZAzbsYtWtpfOB4HGLS0F7KNS+YIn2LJxWmNIXU5/FvCtrY3zZuiufXybquxtKxAbY/mJjycvl6N+b/2qaeE4ETn0kUu+5QevGw7gPPMbfImmTOY5Grj7z24HwVOFChyEZJKCqlilhNxKGW0M4+/3BBxTfrqMgbuRtqo79a69ZiwI0nQsh2Hqc/GtEIR3BnuQCbAs4deqn3d7QOwub4dHAaTuG5Rr23PxV/10cvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdQirB+udKXUf4WSvMKEu94jwYfxyhbPdgxZO7DI92A=;
 b=CslQr14E/a61uCEFFeiM5LqfAT63bJi+IPNxn7yTBns6rm0hH68510MtvOBRrz+W5bL+bbqZ9tP6jF9go+efKvAuT2/tGBZlXxemuPTZCwfdtJj7wb586OkUJnQxTscTaHEHblsrajHffjiEbZXBV39lYC8h1EBHuaIheiNDV1699ZGIPKH+Feb4n7Lymqi8hAUpgoAgsOPpjwyjRpcmZSOljiuPi2Nxys5NnCMg4sjekj7GkobMeeHb5J5lPVWMVXS2fL9oQ1KH/Qqlj5iV0t12779b78SpHiFdIrj91S0rUI7hegObb11qS4s/KL/MAMISI6onMAN822PYCNPZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdQirB+udKXUf4WSvMKEu94jwYfxyhbPdgxZO7DI92A=;
 b=Upkb2qzSAp/1RLotwMygwc2M0ahUrUj8tMGdclQE+GOGWHkuF4MatYdvDKLSu3CAhpuMvMQUkJBK3LPiD26li+elUGgsGcNXZCVwX/OSw0XQ2oDRbndGoo8Q/L16pYwQQC5S1m5RKxnXqNTNOfnT3KEtlXFN8iXasd2cKLJoLok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2720.namprd12.prod.outlook.com (2603:10b6:805:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Sat, 4 Dec
 2021 23:36:55 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%5]) with mapi id 15.20.4734.028; Sat, 4 Dec 2021
 23:36:54 +0000
Message-ID: <299d0b0d-9f4b-d2dc-fde7-b3583da384e0@amd.com>
Date:   Sat, 4 Dec 2021 17:36:51 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Cc:     brijesh.singh@amd.com, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 0/5] Add SEV_INIT_EX support
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>, thomas.lendacky@amd.com
References: <20211203144642.3460447-1-pgonda@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <20211203144642.3460447-1-pgonda@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:806:d3::34) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.0.0.6] (70.112.153.56) by SA0PR11CA0029.namprd11.prod.outlook.com (2603:10b6:806:d3::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Sat, 4 Dec 2021 23:36:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8cdb355-2612-464c-959f-08d9b77ef467
X-MS-TrafficTypeDiagnostic: SN6PR12MB2720:
X-Microsoft-Antispam-PRVS: <SN6PR12MB272065DFB5519002EAC23F16E56B9@SN6PR12MB2720.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7hg91DgB818xWu+G4cJConVnYqqn9n8pnAiwv3df7dNR6UkXO6gW1JOEXASPQlpKcQKghMU8ztMVzgiPR3RPoEvXRC35FfGaEI3WK6ZH7qh/rVZTSspGcaRJ415B6WTjV8MsdALDwXGBDGPpHexiOsXTGX8zWXeseyDVxQixFmVTZ9cRpqvWrUTZDu6VKV7FG6ugitvM8JOv9idBv4xlgah55WFIO4rwtw8QEPGChL47pfPRFeH7aragjoYLXigM9acy8MMB8jENMewk8uWyqZMYALTAGpdYEcMQyAi9kCrqrJR7DXDb/fejXI0TDAt71Kx7dPBcrx80Dif3Tbr5WSfj6bent1/eN5xznOWqI7L/81ERix7vmzVne4MM6uiD1ZkcJVjecxL3pDzjvjhjAlBBq8KM3muPgwLxCiJ1ADOcVJ72tPTIBe/IIpkPcUTIdfNNZH9Stv9lsROuv6eYgKrz1fSn7hCwfqyqVxq8lXbFNut/HNrszjiWSX2oko0nyOOF4VHMsdRIRTKkWOVAvllEZbxG7sgXKE/H6qe963kIgVRWSuGLzdxV0BuKQ+UWhiRPeN39d2+zUJgJnwthwRhYTSuSNnrksTcfKaIcKsTTgb2XqbqzQXawxqqddLJKVK+o2w7qeHVfq1sgWG1cnNDWc2eeFkqv/dDa/n2jShjsnMsok9W6q+NBEXa4AeayZAo0okYWkShkGqEZXrTvd0rGQ/FWLMWQvxgAdLT4wQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(31696002)(2616005)(26005)(2906002)(16576012)(6636002)(956004)(316002)(66946007)(66556008)(38100700002)(66476007)(4326008)(6486002)(8676002)(31686004)(86362001)(36756003)(54906003)(44832011)(186003)(53546011)(508600001)(83380400001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkJJcE1NVjNqRkNrMjhqbkFUT3BaVVVrMGJpWWNva3NzZlVSbTNrK04vcE9u?=
 =?utf-8?B?WU5UOGV2N3pacDM1WFh1elppYU5ZNFZiL3VUMmNLNDNVZnNscllpaERYTkF0?=
 =?utf-8?B?M0JSaFZDYWZyNWY0Z3UzaW9Cc3ZwZi9zQVpZcmRFRXZUc2ljWm03UVpQaDYr?=
 =?utf-8?B?cG5OR2RBQU41dVE4TGxIQVlQRHlHQnVTY3N3V0Z1RXlocm85MlBYcVVuNzc3?=
 =?utf-8?B?aWtIRFU0dW0xbEdCdHR5dDNsL2NpUVpKZTEyaDV6a2NLY0dzMTd4ZVlEc1h3?=
 =?utf-8?B?ZkJ2VndEWW5EbSs2NUVyRVlXWWhCMERscS9NNGRwdXFkZXI1VVBpcC9FVHN3?=
 =?utf-8?B?dzJCdUdXaFJ4d0RqZWE5ak1RL2VZck1kaVN3RFBjM29zeXJkYy84WkU0ZHBx?=
 =?utf-8?B?Yi93SWU4N04vdXFYU2tqT1lURFhjTWhpendKcXhSRzIrZ0hwMzB1L1JBRWta?=
 =?utf-8?B?ZXU1QTFsOHZ4UXBnNC96RHJxQVRjcFk0SXNYWTZvS2tPVm5tZm5wYkpsd3lD?=
 =?utf-8?B?ZkVNQzhCS3Axb1dpYzYwNm0vdnFrVjlKU01VTFRHVDlheHZBdUl5NUNtdVZZ?=
 =?utf-8?B?czZTUmptbHJTNFpaTkdZUWxEd3dBUjlycnkwKzFzZlcwK2tpaDFxUnJuYlhW?=
 =?utf-8?B?M2d6bnE0WU81WG1JRlJBS2g0L3I1SUZyQlRWS0h5UzJRd0hGR1dnTDEvaDFS?=
 =?utf-8?B?ZGpHSWloZ0gxTS9mNkQ0NHNNek9raHVNN3hRWGpLd0JNeTJ4aVl1WC9NVENz?=
 =?utf-8?B?T1lWcEtCZ1d2emRua3R4Z3pZSlhhUTVncm1OSU1CQmNsSDh3MjhqbnVIeG1m?=
 =?utf-8?B?b0t4Z2ZsRlMxS0tzVUZrYlNIK1ZkZmtMWUtNcDV0bXVsQmN3aXo2NTRpMm0r?=
 =?utf-8?B?Mk5LVFhvU0NsMUltU0F5b3ZYZytZZ2VZaTJGQ2tEZExNTEp3QWxwUkZMSWJ0?=
 =?utf-8?B?RHQrMUhlbnRVTC8yR3l4ekkyeDQwY3Y5Mi96STZvbk5DYmlEd3g4VGNtZmhw?=
 =?utf-8?B?alFLMlRrVzBFSHYranlEYjdObC91TWdScmJLV3U1bU9nTjFkeFdCRDRDQUs0?=
 =?utf-8?B?Sm8wQTBVSFVIZUZYVllJQ21sdUhtS1BnaFNDeHJLQ3dPVGRyWmdvMXcreVVC?=
 =?utf-8?B?RlZDaUZ5QlF1LzFTbVVMQXIvT0VZeWkwM2VERWt1VjZuZkplWTdTQmZPQkRx?=
 =?utf-8?B?TlJxVHZMc2RoYkd4YlU3NE5ydFV6TEh4K3J4TFYyN1NUcUJOMGVlSXZuOEY5?=
 =?utf-8?B?Skk4Y3NFdDdzdTRHeXNETW5FUEFZejU2Vno2Y1FWTDhyRTNKNkhjTDBuZnQx?=
 =?utf-8?B?a1ErWXJtWEhyWFFnYm96dmVOUWc2Z093K0xSTUkrczhDaERpYWVMejN5T0d3?=
 =?utf-8?B?b1RHdEZBMXVSWjlLZm5ucVZYaS90VGpSK0dpYVFJbk5wNGRJWUwxK0xCaWV4?=
 =?utf-8?B?VUo5NXExUGh3amxWdEF0ZTBVaHhFK1FzSWM0N3lmWVBWTlFRSkJJblhXZVVU?=
 =?utf-8?B?RXpzYTIvS3hOeGNxS20xN3FyQjV3c1ByY3Fwc0ROOUU1R3JpODlIZGdEYkw5?=
 =?utf-8?B?dXBHNzNTa002c0hwZEdwU1NCYVZrVXdRWmVhZm8wL05ZWGI3T1RiR0liRDM3?=
 =?utf-8?B?RW9TMG1oZUdLaGJIOU5lc0pZZVlMeE1RUEUzdVFBeWdESXJ2VkVEbHF6czY3?=
 =?utf-8?B?ZUFNazBPcUJvWVl2QmQ0QXZoZGpXL0tUNExyNUpQSEc5S1ZQWEpLZE1nL2R3?=
 =?utf-8?B?YnlBRmoydXJucS8xYVZGVi83MFBxaXhsUEdZcUxzTGxIWkpsMTh1NkUzUjMr?=
 =?utf-8?B?T2NLVkowT0VvNnlNSHVGVGNGTnN6Zmxpc1ptenZab0dQZS9VUGx2amdMWldE?=
 =?utf-8?B?NmVRVDI4bXpYZ2U5eFlIZG9VOVAyTVJyaWtUdTU4bTJveUFBYUcyTERtejI0?=
 =?utf-8?B?WC9MWThneXdhb2tLU0RZQlJUT2g0eTNkQ2tvWThoV29hVnBsNVBNYjIwMUxK?=
 =?utf-8?B?N1JwcWhmV0pkeVVVc0tMa2NNenNscFB5cGZqTE5DSVhtNWxmZ2tlSXlEbGNR?=
 =?utf-8?B?T0FnRHlTMTd1UjNjRTE5STBBbzdScmhrWjJxNW8rUVRZMWIzb005b25jMXRz?=
 =?utf-8?B?SzVtcDZkMUZGMUNZbU1qWEFoVHhZQU9PMzFJZkFpVXpOck51Zy9rL1N4S3Rz?=
 =?utf-8?Q?NRi9TMRWXR4X73GQJ1SL6kY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cdb355-2612-464c-959f-08d9b77ef467
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 23:36:54.6215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUkD8FX0eUegHX++xBGw0ddSCS67H0mEsqFnR6S59SH0FfsUZNkMvqSPSX87l+ivFSKOR/LWY077ZzdYHIl2Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2720
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/3/21 8:46 AM, Peter Gonda wrote:
> SEV_INIT requires users to unlock their SPI bus for the PSP's non
> volatile (NV) storage. Users may wish to lock their SPI bus for numerous
> reasons, to support this the PSP firmware supports SEV_INIT_EX. INIT_EX
> allows the firmware to use a region of memory for its NV storage leaving
> the kernel responsible for actually storing the data in a persistent
> way. This series adds a new module parameter to ccp allowing users to
> specify a path to a file for use as the PSP's NV storage. The ccp driver
> then reads the file into memory for the PSP to use and is responsible
> for writing the file whenever the PSP modifies the memory region.
>
> V4
> * Fix make C=1 W=1 warnings.
>
> V3
> * Add another module parameter 'psp_init_on_probe' to allow for skipping
>   PSP init on module init.
> * Fixes review comments from Sean.
> * Fixes missing error checking with file reading.
> * Removed setting 'error' to a set value in patch 1.
>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Reviewed-by: Marc Orr <marcorr@google.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Marc Orr <marcorr@google.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David Rientjes <rientjes@google.com>
> Cc: John Allen <john.allen@amd.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org


Series

Acked-by: Brijesh Singh <brijesh.singh@amd.com>

thanks Peter.


