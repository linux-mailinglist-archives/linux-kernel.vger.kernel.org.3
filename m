Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD3C5254A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357590AbiELSWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357581AbiELSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:22:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FAB5E15F;
        Thu, 12 May 2022 11:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBpgN3n3LwLWWkF/OaXWWfaIb62I5UDttoqGWMblZwifLlkjvIt433KreAjpq4y9n9V5YU0e2/yCmJ8OPCG05uFr/RdXiy2TSmHGB1N2jNxTXm/6qSh6Hj98Arv6MD3YBt7IRxm7hgnEa7u3DY81s4ujB7XJDebL1JJYSdMfAUdK8T1Sn8EKo0EesH8MRNp5/L6vb+ik0e5/aby78pxLYiAT+l2R2AZKfPAPG+Xl9gruruCBolxq09pR5i3cWCSwJ/55U4QwiYZAwXbC10BlsHcRTZbgRukt07I5kYpcBQp2YcVMxrs8icpT9C8cetVYmCmXQsvfT9yLpu9nRqoA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogVDcO2Ow2wbrsFkm2NKVPnsIuZdgPZ2wTie/Iv6bXw=;
 b=BytfEnUx1C2WHVO6hArXL5+Vlideq0Ja3+0u1BJzYbAK6/V4GaQV6TqydoyQrTBP/AdLIhegULceJe6Ej/+/6YX6b3trLulVc7PAmYC4uSOLZSixDrYBaoX0qyPwIJi+5Ptmq9OJidN1t9J9nKWDX2amVKeA+QsOWRfiFMxZYc9pk0saeZiCIghU741Rb4LA1MweE8Ze/BKi9ZEGYHrdXANvcMI1NWzkOjocumRUvCjHKFxNbeJEDzGuKOK5ovkLB+E2MdunbJoZdcj59/mzVyLMg2PX/2GzRGp2OG/IfHb0g8up/BhBS89kJ6NucWpsIbA19DDeFudUGiSORKjDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogVDcO2Ow2wbrsFkm2NKVPnsIuZdgPZ2wTie/Iv6bXw=;
 b=uKaWVVLZ/LICo8mRSgVfnw6OLKvlmVUwgXwN8HtOLzpEdVhxHGyEX0aqKfAS9T9/wxEWRlxO8Nc6Yvf9ge18nYtWqyqXpywdJyi2kik9PGherzURpFhyK5GrlHEFzfM9QiKDbxKqnCO1hIOc4WlKWd8t9Zn4RlSWG1wygMQeEGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH2PR12MB4822.namprd12.prod.outlook.com (2603:10b6:610:6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 18:22:01 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::b3:bdef:2db6:d64e]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::b3:bdef:2db6:d64e%7]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 18:22:01 +0000
Message-ID: <471dd5be-cb03-2d1a-1f74-01e3346f77c1@amd.com>
Date:   Thu, 12 May 2022 23:51:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] HID: amd_sfh: Don't show client init failed as error
 when discovery fails
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>, jikos@kernel.org
Cc:     basavaraj.natikar@amd.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Chang <David.Chang@amd.com>
References: <20220512181848.27347-1-mario.limonciello@amd.com>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20220512181848.27347-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de4836b1-c885-455a-689d-08da34444e99
X-MS-TrafficTypeDiagnostic: CH2PR12MB4822:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB482209CD854C98EC0DFE4091E6CB9@CH2PR12MB4822.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umSULsEKTjBhqze9axHDUIWHfFn5fpXVZuddoQswkQUrVDavZwPiLmcj+GRgAy6af7HOsrZBhQlzcDfUMjZ/BwRz9ocRNs1zhFCFU8dBzELQOQXUOQSS2ZKUdiQ+qoqZTjXFfA7lUs5Vd2RzKO3NU+iNLIPbo1rc1NFVBvp8iznmsiboclcpP8XyfXLFq+h3tMFwPMYb82b3BSEJpF6AVjPMIyQSv7dgrw8QsHDF7bTx27ELlV+8Tin4zJmMc5FOQy4DtYbfQBnuyJ9HuRFVIkMC4ZakvYE3JlcWhE8wz6veHmLnlTedymbYpKXcqBN7aPRi/YamqZ/mHnc8OjvulkwQxIbOvD1DYyydpcuXrddHmSXdT0WnWWxzkI2EQz36i0fwhWD8n0Tihc6BrC3xFjTK1sXsbhHalON7DAa5A+zuFC9zO5cIqK08FhxXf9oJXXeB3BisKeyIZbuzNZUhlmEn8Tk8e5oONEGKi/7IAcCv4dkBjSlv6rZpNGCQeAyPdiMsxow+ZFigdEnoJHRp8ENaE8ykcp3kBVbvtJNR7sa46ZiviSXXCklqGABzoMhN+zbpDBU3ajZSsUEOeanmyeOYmj1u0xFlFrrKTeeDRJFBeDkq5Lbb8zFG3jqPbBC6zbA/E24/yaLHRmnltEpAFuPSKVTdhmww836VM/0kV0Fqa/z0nQh5J2ncl+nXkX0xAlJfkyBBEOJ9TgrB1X1enj4UDM0LWWsD+/skBDnfy2wPBVXzivY+9CwcsdL7johv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(83380400001)(186003)(2906002)(5660300002)(36756003)(31686004)(316002)(2616005)(4326008)(8676002)(31696002)(8936002)(66476007)(66556008)(66946007)(6506007)(508600001)(26005)(53546011)(6512007)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjhIeE90MmREand6RFg3Z0NqcXovcTVheXZvemJHM1dzcEVPYWJWUGN5ZGtU?=
 =?utf-8?B?Tk8reEVVaWJLbVlUU2hLV0duakhCYVdTTTY3RDZDQUtlOHNpSWxwMGpTWjQ2?=
 =?utf-8?B?T0hNU1lnZDZJMUxqQ2l1K0RPWU1FVFJJcmVhNXFYaENobXRraUh5czl2Z3VM?=
 =?utf-8?B?WUtpM2w4L3EwQ0xJSXdFYVh5aVJISFJ0bkg3M3lRSEViY3ZoYnJvaURoQW96?=
 =?utf-8?B?SW91NXRKN0V1cFNNdys1Q0Z5UXpOYnVIUlVubndrZWFBdlErU1RLaFNMTksr?=
 =?utf-8?B?VDZUUjlITEJIdWo0YzFRTFM2cnJXeVVHYll0Vng5OXFCL0JmV1Mzc0IyTmdM?=
 =?utf-8?B?eityUzB6VC9qVW1tVUlWQWFuMS9hTkNjekJZSURTQXBQNDFyaWFNMWVaRW9x?=
 =?utf-8?B?WW9xMHg2Q3l4N0ljS3owdnYvcERqVlVJT1B3MGpnd3Uwd1h2UmZUUUZ0NGE4?=
 =?utf-8?B?azBrQjRuSzJSYmZjV01TMjZZRy9hS3NWemltZ0FVVE9lb3lkekxMd3R3Y1c2?=
 =?utf-8?B?K0xpdVFHYU1JN3pZd3Z2enNDYXE1ZjlReGI4RnhydnlvcUhtN0JtWEM2RlhF?=
 =?utf-8?B?eUE5MkxocThNN2JIWU5FSFFkN29xZ2FJNlcxN0VIMktpQmZodjJQSi9zOUx6?=
 =?utf-8?B?WnoxL2IwMDVWY3BhQysySmROeHhXekNneUxYMGJJQ05xQzlGZFNUK2lJMEE1?=
 =?utf-8?B?clk1QUhEckJVQjJ6eUYzU3VCY05Mc0ptaERjRzNGaGxnYmZiMC9MamE4bU5K?=
 =?utf-8?B?c1pTSndSTUoxY1RrR1dyd0tUS2czVUVPMDBzblVaWmZRNHlyOU5yWnR4bERF?=
 =?utf-8?B?azlHZSsrY0szRk1PK0JvKzBhUFBMVjI5eG1JWWQ4c29OTXNndWlRNnJtaWhI?=
 =?utf-8?B?aVp0eS9xWEJPNGZ0NExUM3k3ZHMwRTg0NnNyNlNJZ1pUWG5peWh3YngrMXk4?=
 =?utf-8?B?VG00RERvVEJoTWxhcUlpVllURGhwNnpGY3Q2V0RQMlljWTBPSi90V2lCV1Ur?=
 =?utf-8?B?Z2lzVUY1NDV0ZUh5aTdVU0tsMWN3ajVrTVBDbitPeHVmemlLaHIxZWpJUEc3?=
 =?utf-8?B?M3RJWW13bkJqRXpBYnhJMW5nVEk3bHZFK2Z4R09QbE54TXc3VTREY3dlTkZj?=
 =?utf-8?B?Wm03TitQcHFwMDJJejZQcjRMNE5tL2JYMzdhY1BoVXRRRldleHg2cFZrdTYz?=
 =?utf-8?B?ZWN2OWV5cncvNDlCcStMdEtxOGRvS1FHS0IxbFVpSUdtNGZ6bzlvTC9qNWpL?=
 =?utf-8?B?ZUhGeXVUenZmRWpXemVCdFI0VUp4alVzZkRKOWZsVENoWGpTcHJocFpmMENy?=
 =?utf-8?B?ZEZkcGZINkZVM2VZLzVDOUVWbktHdElpaVZwNHJCcm0wU3dRS3NpakhLd3lG?=
 =?utf-8?B?VHQzMUh4YkZrZnd2S1ZmREpIdy9JaXVxUnJuQkFpUExXZWVrSGY2YjRpYk5h?=
 =?utf-8?B?a2QrL0c1QXZOWkJGL0w4NzdMYXBYVytnVERBVFo2OTlOUUMzbEhUK0Fla3B5?=
 =?utf-8?B?YzZYaExrdmcwMjAzdGZsaTNGWlh4UUJwRFk5eFRNTWNNZlV0dFlFOVY5T3c3?=
 =?utf-8?B?TGtDR2EwRER4MHFVbmpuRllvVDZKeXdJdVVOTlViei9TcG1IMU5oYS9oYXRy?=
 =?utf-8?B?aFNZaTFaWGRFTCs1cUNqeHR3Z3JzTHgwekMyRkgvTE9KMUc5UUpSelp5dklF?=
 =?utf-8?B?UXlRVWJCSDdUTjJoRmhiWWgyOU11aFRTNURiSzRIYzd0WFNHS0xMaE5FaTZ1?=
 =?utf-8?B?M29pNnFGcE5wMlpGbDJ4bnhWTWw0N2NjVWNaSTdWNzUxaUNsV2gvaVNYYWJR?=
 =?utf-8?B?WmV2Z3RKTnRTYityZldzUWtSOXRmbnNtUC9JVUV0eTQvS1BhdHlwR1o5Rnd4?=
 =?utf-8?B?L21KV1hrbHg2Zm1ob1dwQTJkMWFybjc0ZUlTTjY2T2lrY0VzdVJLMkIvTE05?=
 =?utf-8?B?eXg3VjM4VmtCTzgvRFZueDJHUUdDOXF6NCtQTGZFYkcrVVhuVkdRaTNRSGdq?=
 =?utf-8?B?emRxWHhZeTQ0MERIZnRwaUpQZWsvRjNuTVlXdWZ3aEF3QjZoQXdBTjcxMDlS?=
 =?utf-8?B?Vm52Um5UbVdHQ2NmVU84K1RLb1prSUY0cWxNRUNzUklyamt1MUZzSzFZdDc3?=
 =?utf-8?B?OExVK0FpM3V1VnRkQ1Azd3NYdEV1M3VwV082c1Jpc1pmYlFNeUw4VWVMbmh0?=
 =?utf-8?B?SGowQUFObzJTWTNDaUNhRnFKL3ZqMC9lTkdYZXZCckRvSVh2R0xXazNUR2la?=
 =?utf-8?B?OE80d3lrbXQ3eFN5QWNvZzM3Wld2L1RacWpoUzdDWnZ2aittSUIwRmI2MjU5?=
 =?utf-8?B?Nmh4anBGcjlrSXFHQ2FIZHNrV0FYaEl1c05GMGRiT1gyNE9rMTc4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4836b1-c885-455a-689d-08da34444e99
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 18:22:01.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjeL1qy+iono6aw6nGNartH3pPcYzM9jBPM4DWI9NPt+R3EUjhQT3hwZGgP+ZOzr030B72/E1GAGIwcOVPYgAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4822
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/12/2022 11:48 PM, Mario Limonciello wrote:

> When sensor discovery fails, this means that the system doesn't have
> any sensors connected and a user should only be notified at most one time.
> A message is already displayed at WARN level of "failed to discover,
> sensors not enabled".  It's pointless to show that the client init failed
> at ERR level for the same condition.
>
> Check the return code and don't display this message in those conditions.
>
> Fixes: b5d7f43e97da ("HID: amd_sfh: Add support for sensor discovery")
> Reported-by: David Chang <David.Chang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * fix some fat finger typos in commit message
>
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

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
Basavaraj

