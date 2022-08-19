Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD359A560
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349904AbiHSSLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349994AbiHSSKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:10:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24C79FF7;
        Fri, 19 Aug 2022 11:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBSrS+07aHxXbn0gK8OXjEAsUuGOeOCTYJRfI2+c73hiui31Lzt6XQ9mRx1cq96cfJIIrgHunL9OogmYAob5KonNR/fS0oQ7HJC6g08zZHtkIhgWtQexmmRKI7fEJu+ujS1y5A7NQQQV40YWm0+oEwkjijH2kRrmTS8KSuRE4PqvLPpnhH5Gm+5OQNuapqkMuR3kQMrZspMa8tJGSa+hFyBTj1VoDgxrwkuJAwRnL48t8zQQ+YOosGHemleTqadxVLUNwf7cG/EBkRIjHMmJ48wN//mJQsPcUzibHZW1Gv4Caeb1tJzQbe1XFu6fjM8B0BWUtcbtyM3Eu9xtnQKHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmvtuoZTC46Hai5gd9ctow2J+/J4eIREecU+PeIouNs=;
 b=dc5t3P7rCHEkzuI4YMTnhjDkoDrFNy7yp/930F9kSSwUxjiGLwBBraTwxd4g9ZFXhXM1AowCeFPGLyvJz5MaLQpKuBe/KG4G40T4r2pgHYtWc8IZ1hNBZ6E7eHc+te5kFRN2ew2CfT+dJX3uni9K0PGRBuzyTDTszy3JRIdOFvgp1buq4PPX6DDSBjf0d4D4EPawGqR+uqqjaj1UcwzD4UHQdf9cZL9mmtqU25OL8SKX0/1/fPp08cr/Zm+kZeOeNEFyZgNvyiAQPFsZ80Yx15GPSYwqGQz/Gj+d4Rdmw36AdXFUheJoMLFrPv4U4ygEwiiklqjVPEeVVyPXhvZx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmvtuoZTC46Hai5gd9ctow2J+/J4eIREecU+PeIouNs=;
 b=Et9naoRBdHZ/lm5uyg/iHXgI8NZCNFpUmTdKbvvtJhYSwReCsE1en5ClXXxIXcALfhJq6eRNZ42yUGCGnQXxvdBTV4tjIpxUJ8lx0ZYRTx2h5wU3iXGSuP7mZ1KaFDcCsIWTeoqopYhFINks5jiOjbxgwgZrnF3BcgNBvu7mPM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB3326.namprd12.prod.outlook.com (2603:10b6:208:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 19 Aug
 2022 18:00:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67%3]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 18:00:33 +0000
Message-ID: <1faa9531-8897-dd21-2c38-3b7dd740ebfa@amd.com>
Date:   Fri, 19 Aug 2022 13:00:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [External] [PATCH] platform/x86: thinkpad_acpi: Explicitly set to
 balanced mode on startup
Content-Language: en-US
To:     Mark Pearson <markpearson@lenovo.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     madcatx@atlas.cz, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220819140142.4925-1-mario.limonciello@amd.com>
 <d9be30da-7306-149d-0e43-f32832965e59@lenovo.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <d9be30da-7306-149d-0e43-f32832965e59@lenovo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 790ba33c-1b1a-4e54-42ce-08da820cb5c6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3326:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g4ob8mVGTILXol1uQVAqRWD+FxGF3s7gfablgYT6O2O+VXAJolIAeLFZjQd2fzLdsXZtcAyEwHcrRcZ8IeEbi1N1uMBrEYSAzcwRuyqUfYEFJRneIDCyWZCc2ODNSXfsNmq2khSadEBpkHr2wUVOrKypzVP05tNZnHfjYWdqUrLrBYkICyzSsRxJoT5xWbn2SJhUFk6SeBYK+houT29Xy4S0iUUVOXxCdi+iKNCp2YVqyjz45kNsqxB/WCW821UAopFUPf8OtBo5TNWCLrRtOWlaAimo7KYQlVLfRgxr/fpoTREChWSSPWkbZraStVzzMcrgoF9oQJKFzTiBW0WGwXlJ0d4ZwtEF8AxJ0vB084p+/ky7GB9y9aPdBjyWkegyJZ+FMcbfgMQMhQdtF+n1aBkVzORY0QnVZ0MIk440aLAwFaleqHuDtsg3GPb7G6w5EDzujFAkh+SJMgdhAkvvvkHkh46/mQLNUk2WOdwOV3s50ncf4UP30ItqqGSuXUJd2AYZPROu7pYQcgGqAx7+EfqfossXkLXAjldrTRbAcJOC5y3+XU3689AzL5pM0mvgL1h78KyTeQpcr0i7+5+XkEq/PnR8j8th5ENUefUuvtM6gQnBlur4UR0GKHK5HB+gYwtr1OBLGHjxhNfaR8d0O5+edNsXEqGa2P7elnMGh9hi+3nBgb50tcT4Hdq//rlxWbEatoy4Yk52mstmyVpIOrNk2InHpjv/4AD3fmq7m8R8hx+RbUQYXh7P2QJdjFDtsaDCFuRzV9XMElJCF1fV+cWFWT7X4o94odawdT/Uhv2EJN+KjZRGybCRQwofHjRf6dylJBhIG3nWA65lSLdhzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(45080400002)(83380400001)(966005)(6486002)(38100700002)(478600001)(26005)(53546011)(2616005)(66476007)(41300700001)(186003)(5660300002)(4326008)(36756003)(8676002)(6506007)(2906002)(66946007)(66556008)(8936002)(86362001)(6512007)(110136005)(31696002)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THNDNTBOcERtRkdrb3RXbTFZV2tUZUdjR1kyTWEyZjd3WXlIcGdabW5USGh5?=
 =?utf-8?B?S29UYk1uVXdZTkFBZDJwS3NTY0QwSWxYMEVzQUg3R3BSalB4OHBGbmU5T1Fa?=
 =?utf-8?B?M2w4azFybGNqM29JcmEwb0N3bkdXN0c4Z0FFNXZtcmF0TmFHU3FYL0FOdFZp?=
 =?utf-8?B?V1J2YXhNbUQ5VGdtZ2VwdWdLbDErdGJtYWFEbGNIS2NCSUZSN3ZNOWxnbndm?=
 =?utf-8?B?V2tHdklyOGtIVGRiOEJlSE94bE5OaUx5T0xrTDZQZUZmUjdtdUc1d2ErOGEz?=
 =?utf-8?B?T2Z1cXhIWThSazNVWTltYUNQSGw3bS9NSmtjaWw5eThhZ0p2em1Ua2p1cjYw?=
 =?utf-8?B?UGQ3UFpwRE41QUYrbllCaS9iUXl1SUgzd3FRNWpsUFZqZVN0S3d5Wi83SmV5?=
 =?utf-8?B?MXBWWERVTU5HT1k1cTlWYWdhSEhYK2M4TmtTVEtOb3R6dVk4V0t3dVJJUEtD?=
 =?utf-8?B?Q2hjbTU5Q3hnQUprQ25mV1diWUhWZ2k0UkxnV1RkWHJVRHIzc2pVUDFzTU5R?=
 =?utf-8?B?MjZkdCsvWUNzR3A3aHFTN2hsM21NSEF2NXdkSHhMbmZxQm5OMXJ1OTlZZ0Fn?=
 =?utf-8?B?bk9tQk83VlJRSzVVNzRJdE55QUZlc0svU1JNYVJlZ21GVzZWSzRkb3pKVVIr?=
 =?utf-8?B?TW9XeEpUdWM3UysyeWxnakx3MTU3WWRROWlNUlpFL3V5M2YrU3NoUHhhZ21m?=
 =?utf-8?B?b0VoZHlrNXA3NEh5cmFVYnU2UEFwa1UvRy9iOVRUSzZBdStIZUs4VTVSYXkw?=
 =?utf-8?B?ZzJjaGtSVWwxL2NjS2d3Q1pYVDd0LzJncG4ra2tCNnhUeFNxZTA0eFVTZkpS?=
 =?utf-8?B?allnc0lnQUVoVEpxZmNUS1k2d0o0RmFRaGpTRzBxTGt5RVdoYmJLSTlIZXcy?=
 =?utf-8?B?WXdaUlhLZjJ6WXZBZEg1MnFQeXlRUzB2WmE1RCtOM1BsKys4ZUFKTVZEZ2RS?=
 =?utf-8?B?eW5DeldITVNtUk9XbnNjcm5GZmM2dERxUHQzOHFqOWpaSm1KRTlJQ1FWK3Ay?=
 =?utf-8?B?c2EzKzdWeGxOaGpBWDk2bVhTbUFoU3VTTk5ONGFGRXZyalFXZ3BVMGRDYlpz?=
 =?utf-8?B?YmVwSmpqL0hFeklyWEwrbHZ6RG11L1I1NERwbXZGOTBIbVZIZlQ3ZWtzZStG?=
 =?utf-8?B?aUoxczJYMEd3WnpncW5aZjA0ZUhsT3I2OXlGR2RNRjJyaW9YKysrQjJSN2NT?=
 =?utf-8?B?dG1nSmdiY0NOQmk5em5vVGhRWTRKL3BLeVJEdGM2SHg3UEd3dUZsL0p2eU9O?=
 =?utf-8?B?SFBVZ29KMXQvK3F5Z0Rid1prOFdablJrMzI3NDJWYmh4VFMzaGYrdUxGQnJ5?=
 =?utf-8?B?QVZBSDlOR2EzV2JWUGJKenlMYytiODhnUTdick8ycGRRakNpZDQzOGh0S2d3?=
 =?utf-8?B?VzF2TTU5NjlucTBUNWszMW00OXkrVHNaRzVDL1JuSnR6MVhFSGFtTFdhZWMv?=
 =?utf-8?B?N1pKQ1JJZWlQbkFoRnoxa2JjZVNDcWZoQm8zYTJDa2FSMmtmU2k3M0pPRjNq?=
 =?utf-8?B?QXlmVHkvcWtiNXNwelFnQ3ZudTBIQTVFeFFjZEthSkFTeEhha21kZjZVYjJS?=
 =?utf-8?B?dHpWeFFKZkVMekMzbTYwYjdiRW9CTG5kc2h2bkI5SFk5aGtUeDVqWXYzK25r?=
 =?utf-8?B?Z0FESDRNbWJ3YVhGRWdiN0N4cXZGbVFpTGR5blNycWJoak9qRVBpYU5jQnZk?=
 =?utf-8?B?TVhJV3JjTGFkUldFcTF3K1Y3cGlhUXBwM2MwQmdRcWYzUldWL3VGaHVzblYz?=
 =?utf-8?B?aHRFeVhRRlhzeDY2OWpYaDJaZVkyZ3R1MmlDMmFndzNyMFJWdytNUnZzVXZW?=
 =?utf-8?B?Ukt6d1VQVDI2ekh5N3U3bzZhN0pnUVNYdlBNRnhpcVhxQ3FUdWhUeDQrdEVC?=
 =?utf-8?B?ZEYrSWF1RFZBYUMrd0FWamhERm0rVGRxbDhCZFBCdDdTdHpVTVZuT0N2dktl?=
 =?utf-8?B?R0F5QkRkbnIyVFc5YlhJbXVhY2F6MG5uTlhOZTJHYit6dEY5R0FQUEZsTkdr?=
 =?utf-8?B?cVVQUUdRVWNJRUNVYVk3dUxCL2l5UkI2SUhCQkkyTVRWNlhQdjFYVC9PRnNn?=
 =?utf-8?B?SytXeXFJZXhJODlZS2VGTUJJRDdtcEFFSTA1OHM2cXloNkhQTWt3cFo2SHdB?=
 =?utf-8?Q?kbcIe8a8Y4zsRlLSMHdgwP5b8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790ba33c-1b1a-4e54-42ce-08da820cb5c6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 18:00:32.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJR0ELkfxHcEN8TWuhg4rirD16sTrzm+D8inKpkcrK81QXKy82ZHCgsgwF1Cm+nUEzIbGVYT0ifJGNSEP9J6fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3326
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/2022 11:57, Mark Pearson wrote:
> 
> 
> On 2022-08-19 10:01, Mario Limonciello wrote:
>> It was observed that on a Thinkpad T14 Gen1 (AMD) that the platform
>> profile is starting up in 'low-power' mode after refreshing what the
>> firmware had.  This is most likely a firmware bug, but as a harmless
>> workaround set the default profile to 'balanced' at thinkpad_acpi startup.
>>
>> Reported-and-tested-by: madcatx@atlas.cz
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216347&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C7f33822a8c2c428fdb0b08da8203f783%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637965250825035615%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ua0qRTvx6MmngRCYI8TxgaTjLrd2fnRNtUhA0%2BRS6S8%3D&amp;reserved=0>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/platform/x86/thinkpad_acpi.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>> index 22d4e8633e30..e7e86c0b9ad7 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -10590,12 +10590,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>>   		return -ENODEV;
>>   
>>   	/* Ensure initial values are correct */
>> -	dytc_profile_refresh();
>> -
>> -	/* Set AMT correctly now we know current profile */
>> -	if ((dytc_capabilities & BIT(DYTC_FC_PSC)) &&
>> -	    (dytc_capabilities & BIT(DYTC_FC_AMT)))
>> -	    dytc_control_amt(dytc_current_profile == PLATFORM_PROFILE_BALANCED);
>> +	dytc_profile_set(NULL, PLATFORM_PROFILE_BALANCED);
>>   
>>   	return 0;
>>   }
> I'm hesitant on this and would like some time to dig into it first.
> 
> I worry that this would be overriding the setting in the BIOS. On the
> Intel platforms (at least on the mobile workstations) we can set the
> default power setting in the BIOS. I don't see this on the T14 AMD G1 -
> and haven't had a chance to check other platforms so its less of a
> concern there.

Ah wasn't aware you stored it for some systems.

> 
> As a compromise I'd want to force the profile to balanced on the PSC
> modes only.
> 
> Ideally, if this is a FW bug we should get it fixed in FW. I know our FW
> team can be a bit slow, but I'd rather hold off a few more days until I
> have a better idea where the issue is. I don't really understand why the
> person with the original issue is seeing the behaviour that they are.
> 
> Mark

Sure; I'll send out a v2 to that effect.
