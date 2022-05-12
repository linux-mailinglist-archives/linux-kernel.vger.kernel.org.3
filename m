Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62E52548C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357528AbiELSQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357370AbiELSQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:16:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B1A33A07;
        Thu, 12 May 2022 11:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XchKxqzSTP78t+Co8iNLZ2Tz/NA1GI8cff62btMw/UMUMI7841YdUSvWQIvk6zTlxjqz4y+TI3IG1jFUuWOOZwntp2yDVRxdMypRskpv5T9xpo3Ab2KTZl4+30/CTOF+D2YygznlrI4Um7qidZZYhXmcEEvFm3m8hk7iyvNgZkZ9p2z5t8qX9M8U6xnSMujo23I6U/ZnWsXvvswQgRmB+plQZS4xNj1SUM20dot0eE0JI9Mwj4iJE2JZuxO/VxzpAs2DFQ8F3zjkJ/KEn/1I+Mff2gA1UcBzXWgNzY+RGLk7yWt/zaRa6U7tKjyy9NTxMcgArc0uzXkOxQWu+pIKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MafnkKOIr/zr78gFqB9d23k+SA3ky6aUQWJm6dOr7Z8=;
 b=TRftL0DydtfFKJcAUY2WAQ3FKP/oCrLkPOS+1WQERBD4qRxejiNyX7+yVHp3nmU7q/zK59GiJVgLOen2KJU7LmejZyaNpX23lRqqXaARATwOofN73ZuwGqZXniom248qU/o0rmgX/4Vb7wM2sWeeZgv648hyCkL9iijUaqT2GwkFKvcY1EUUjxK/sL+7YpVaJ81lNl/+lTz9bubAT4WykYAmU3I8EMaqZuIHnFIqTeCHjmuq7PR9y5N+VlxRQ2gJjDGmzQD7vTjrB5mw/5p85mFfK5BrQcrEca9d4kwL/7Q/sKTRUOor07X8MPnFgfdnNNqV5ADCfZZObfNQChKMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MafnkKOIr/zr78gFqB9d23k+SA3ky6aUQWJm6dOr7Z8=;
 b=w5y8YD040+WAngbxp/A39HpwWpaELraHVeLF9vwd/kCzZIKzVh9br5NmSI+vMBl7N9BDI3Mw5Ev7MzYpK8b7ov2RX1p6wz63GTvctfT+nhC09gkToYYZOB+XNN1bSmqnh7IJ+4jiiyI+9RGLL05Q/DYOWg2vgL7xdIXfO0fJ2SE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB2764.namprd12.prod.outlook.com (2603:10b6:5:4a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 18:16:28 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::b3:bdef:2db6:d64e]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::b3:bdef:2db6:d64e%7]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 18:16:28 +0000
Message-ID: <55cfcf6c-df3e-ff77-c9dd-82d3123428b8@amd.com>
Date:   Thu, 12 May 2022 23:46:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] HID: amd_sfh: Don't show client init failed as error when
 discovery fails
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>, jikos@kernel.org
Cc:     basavaraj.natikar@amd.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Chang <David.Chang@amd.com>
References: <20220512180043.26206-1-mario.limonciello@amd.com>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20220512180043.26206-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7144ec96-2a62-44a1-fb03-08da34438877
X-MS-TrafficTypeDiagnostic: DM6PR12MB2764:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2764AEEF8F8A3586A5C91E92E6CB9@DM6PR12MB2764.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUeuY31I/QGaXrfTMkDhQCIhYZ0eMlj3cSY3I1s9CE8gtnndvs6kX87MNiJhuHjo9hYNf1LdDFFk93bd5ZaoYCAedHXP/Q39lbIh4EloW9VUeJ4JfKCMJ2dmGk6FfiVBlXTYAfDHEvYx6l+MeflDUFSoe6I7eAJRYPVTTQy/bnq9FZcqAyucozUy+GyzZJGSl2dslu9L7yEjBjdxvm8PffRfpLOxkipiimhSaNVxKSB9dXxVR+7Eua0J9PPGt+4+IUt9BKnAH8WpR2hhpJlOuvoarAO4qabhgbVwin5Y/dTpBPj2uNXTNUAfbuHVgNwXQWobmKLxiLBWkr7cQQ0HNnKwgXrl7+80EoP4brZ37yUfpYrIzg4/sOUuPaTGilYV2B+GvzBHqN7eZX9be5sKzlkGU80eWK6/6CJ02iHfhX2hQZHzmUtaCnrajFHOewCd65qxxGXkmg4jkmc+STclmMo7VoX2gxvyi+aiZSBStKmlhwEGRFeFm148VPYr5QorXTqV+UCu6eqEVPTr/GOkF3Jnr520ygBwva/WD8s6EL6lgwjqLHz5oMs4EAEdodbL4bOtvAuB8odaYeXpo4I7kOsJV521VwGmWscs//Zy1IlUN+zF022xfmTfGwUodHpslzsSnaXEdznjJZ1HvUMghDNlFDOM4g1YRb4Kvrn+wku9Zkk8fsw4pRgNpXQB3VZN+88prcGhSEZb2qCpo9Lm4GP2HrlpeuwQcZPdSbquQpqlB/dQKl3uLJL59nxnrxsA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(31696002)(66946007)(8676002)(66556008)(4326008)(66476007)(186003)(8936002)(31686004)(38100700002)(5660300002)(2906002)(316002)(26005)(53546011)(508600001)(6506007)(2616005)(36756003)(6512007)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFI0US8xdW1jb3pUaW5YV2cxZy9oY1A5b2JWQ3RvQjRLdVUxZXV4WGNvQm1N?=
 =?utf-8?B?SVJkcDVZVU0xazNhTmROQUc5UUJxUnRGaWNTd2p0T0NyMURRSXExYW9hdFgz?=
 =?utf-8?B?UTVZV3ZaZXJQeFVMSzA5dlJOY1YxZzJwODd6RUsvUjNDck00bHI4UXI0WWo4?=
 =?utf-8?B?aFYxNW5RQ3hHUnpvUTZRbUZQdW1pdkJuVWNxdDFqM0pzYXNRdkh2ZGtGSGs3?=
 =?utf-8?B?NWVvVjVKZ2R5UTZLNGVDeUdPMGtDZkZOYVZKdXhHUWlFOEVobHkvWnNlSGgz?=
 =?utf-8?B?RzlHQ0pRWHZMdEg0MmRoZTR4Z1VhSnNFcGdaanNlaHo1UFpsZThyMS9ra1RM?=
 =?utf-8?B?aElxTyt6YjRWVHk2N242NnAzSnVEcm9GKzBlQy9kTy9LeThrM1N2SU51VGk4?=
 =?utf-8?B?dVlqMjBUanpFRk1OWjBxMk5aRFVKeGRrditRdUpkaXJsMnpyRjZBTEc1eFVY?=
 =?utf-8?B?S3c4L2VEMElWeVJuelhZeTU4QVBBaW84RC8zWkR0cWtrQ2ZleDg2WExlNzBO?=
 =?utf-8?B?bG82SisxSlk4R2V0STZHMEkva0djd21aNm5reVRNQUVqWXVveHB0WXd6cC9X?=
 =?utf-8?B?QzUzbG4yQ0djakVzSVVXSUtrUDZHZTBBNUVWalZYSzZ5aGZqYWpWa0lXNFU2?=
 =?utf-8?B?K0FoNXRQKzlTcExUNitiRFJRa0htS1RDR2xoUERPRVo5cWZhWHI4eURzY1VV?=
 =?utf-8?B?YWc4YVpEWktKQ21UNUQyc1lEQUFDckFVWDZtZjdzeUdCK1p0YW1na3EvTHJl?=
 =?utf-8?B?N2lpZEcyMEo0UEZpcEU3M3BWTzlMNHZJbVYzWURPb0lTMGQ2SHh2bGNoMDVm?=
 =?utf-8?B?dk8rakxHOEc2bXNhK0tmRzM4MnJkc3VKZGtrbjd5RXFOa1ZhaTRWUlJranpM?=
 =?utf-8?B?dnNnY1Q4NnRhYkcvV0RJVXRiZTBTN3VnTEJWMkY1UEZmNkxxbGcxeEMxaWRm?=
 =?utf-8?B?aWNPOHVmQkRJQ0o0Q1dzeDM1c3l4REQ1d05BWGl3dVZXZEFUYVJwVU1DZHYr?=
 =?utf-8?B?WmJwQ2tSb1FaeS91QzkyZC8rQndqN2MrdU4vRnhHUVV6SEU0aFJDRDNKRDBS?=
 =?utf-8?B?SUorQjhvNkpxUzVrb0FvdjI1akJDV1pra1ZrVjRjT2MvZStVRWFweE9EZmxH?=
 =?utf-8?B?VDJMbzlUdENDaVYwc2crTTM5SjduVU1meVphNUh5ZHF6STZtaGxQb0wwOVpj?=
 =?utf-8?B?d1Vza2U0OHNXUC9LRUVYUjlmYS8zRmtaSFM0ZG5JY2RzT241Sk9rWHBkbWN1?=
 =?utf-8?B?TEdNMnUyWkJSeFNHVmhsTTlnOXQwQmJYVzdlZ0JFdVBqcWZ3cGZRamtSRkl1?=
 =?utf-8?B?TFpadFN4L1VOUU5rTzFGdHhzdTBzVG9LcURkaEoraURmWFNFRkhXOHAwTDVJ?=
 =?utf-8?B?TzZUc3YzMExUeTA5Um9WcVZTREtpN1FzRkxNODFDdjhKc203dmc1Vk5VNkpl?=
 =?utf-8?B?TlZpc1hQWTUzRys1Njhjc21tZVFRUkwvcVNGNDZZdGtHWnBXc3hSbGVINEhD?=
 =?utf-8?B?aWtMTnIrK3dTbmt2QjU2a3JMSTJtSlM1Y29BUWxZRythU05rbzRUL2pUNm1S?=
 =?utf-8?B?Mk9KbUh0RHQxTGQ2N0N5bjRuY2owS2Y1a29JZStROXBqMjUrK0tpQjJlMVNQ?=
 =?utf-8?B?d1lJMnZBOUUwckRPRHVsNjhmQ0Y3SmVMUTBMMmJPelprYjg4akVHRy83SWdX?=
 =?utf-8?B?ZEdEOVU4M1dMU2ZZbURBbEhnV2FDdTR4R0h0N0ZBY0FJeGliOWRZN2Q2VGFM?=
 =?utf-8?B?YU1LWFhxVlVMR3VxbGJHNHhmUERwaDRWMVp1Wno0bzBDalBXQUhDU09XbTVB?=
 =?utf-8?B?Q3V5T2RUNUJpbStuVmJ3VlZ0V1hSRGpzTk9XcVFRekdua082Q2xZNGxGeXg4?=
 =?utf-8?B?dVhDdTg2blFVMW9Xc3ZJNmxIWmQ0U2V0MDVDWU82ckR2a01jdzRtd3BGQ1Qw?=
 =?utf-8?B?bE5oVE5UVnA2R3ZBRWpYeDNaRjZHdmhPWkhQVVM3YWZ2TzlFUkgxNjVyOHZo?=
 =?utf-8?B?eVhqR01aMmUxc1AxZWtudmNGWUpDYjhEWi8zYnlONDg2T2kzRlMvNVV0TkJl?=
 =?utf-8?B?ZGIyMGYzczRtaGZNSDFnT2ZxSEQzTGYyemo1ZG51VlhkNWtXelFJMDZIVUZ3?=
 =?utf-8?B?RDdyNjFHM2F4QVdIa3Z3Z2RLQ1p6NlhsdUNBZWU4TnhDTFZCV2tmN285T0lJ?=
 =?utf-8?B?a1gzR2tpdzRCRmRXaUJiNDdacldUeCtlOGtHeG9wTGFyc2lPcXlFd0lOM1g1?=
 =?utf-8?B?UlkvYWoybkl1UGN4Zk5OUGFxSlA0MlNWQlRsUCtlVGpzT1E1MDhuSzdLR1hu?=
 =?utf-8?B?ajlOb3RabkZLczUvTElWVTVLVTRZdCtlS01nR2FRdHBPOFFvREE1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7144ec96-2a62-44a1-fb03-08da34438877
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 18:16:28.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBQCorpcz0xHQQL13h0CXjeErG04x9X4Ids3L3CSdaVQgguFf/dDnAuIeq2vdbX3c8o+YW7Jqnx/jNSv3dI96Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2764
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/12/2022 11:30 PM, Mario Limonciello wrote:

> When sensor discovery fails, this means that the system doesn't have
> any sensors connected and a user should only be notified at most one time.
> A message is already displayed at WARN level of "failed ot discover,

s/failed ot/Failed to

> sensors not enabled".  It's pointless to show that the client init failed
> at ERR level for the same condition.
>
> Check the return code and don't display this message in thoes conditions.

s/thoes/those

Thanks,
Basavaraj

>
> Fixes: b5d7f43e97da ("HID: amd_sfh: Add support for sensor discovery")
> Reported-by: David Chang <David.Chang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index dadc491bbf6b..1441787a154a 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -327,7 +327,8 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
>  	rc = amd_sfh_hid_client_init(privdata);
>  	if (rc) {
>  		amd_sfh_clear_intr(privdata);
> -		dev_err(&pdev->dev, "amd_sfh_hid_client_init failed\n");
> +		if (rc != -EOPNOTSUPP)
> +			dev_err(&pdev->dev, "amd_sfh_hid_client_init failed\n");
>  		return rc;
>  	}
>  

