Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6FB4EAB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiC2KLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiC2KLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:11:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054B1B9FD2;
        Tue, 29 Mar 2022 03:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bibX08QbdM+c0Gfcs4hTRlLh2bKpTzPXk7b5ni9GaQ/XKwkq2+QqZaIZH15FfouhzU3DMjTaZmRe2kmM1Ib9CY15m0irIQBc/Ormy4KIQ1OVdknYw8I3qm7xYyWPROM0BimmhaOJsVZlN4anEnXy/3Ue1Bd5pO6iF+RcUhwDVramp4PgUi4nqQ2yDoXDa3Z2rZMWlmqkoBxAiGtL7dJA9Lr2rRn5CovgKsbAgG2acoxWANqv1R6f2u1KNP3mde0QjundSc9ZAJMr1Ncy/fMzWNCfvG9jugAyicwWPNsghA3pvz6pSknFVbqS4ROP/8xyFEDxDXB+y39vbehLpvxc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biw0B3BbO8y4p6FhQFu6ghbOzExvwjdlF1ZB2unXFS4=;
 b=ay75QyTbkuIH+5/gY/PQmd6UQijdqeQkM+ZZC98s/YydqkwFB+t5Or0qn6XpYCej4ZcAicabenIOlIfqEJ9r4HdnbYMBcx66lTnp0KwGSxycBuwdCSfx5xx/yzmN/tLdHnj+tdKxmnDjK19Zfswv0510M5b5xPz9vkIAckBj8BN7vGWRyGpesSfnUmBjDIgj7B4pGOvGYaU+mg2L4+WR5muQBvR13qXHEvRz6yyx+jOKXdQoyXn3wgn092kqXzjs/Cf4BSDqm/9ZL7YWOl+5WDCJAsLUmAoelQx6h6vGWGtgW1A0DFse4WgD1BY3xDDQupyxNk2nbs7L+MvOTB6eGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biw0B3BbO8y4p6FhQFu6ghbOzExvwjdlF1ZB2unXFS4=;
 b=G6ghNwlcUbhJO0crFcVQFpmu95c67LT3+4jz1s81IvElXrx62t06iQWBLoAeJEoMGTWZHswU2uiSyIzL9gUIZIAEmYwff09DUr5/5SlTVww/eMLTHSFcR/MCNOrHJaIsQbNx4pBbnlpVv4PM2e35+h839IsVfoM18hS3Ehfr/5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by LV2PR19MB5960.namprd19.prod.outlook.com (2603:10b6:408:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Tue, 29 Mar
 2022 10:09:26 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::7c8f:fda5:16fa:a104]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::7c8f:fda5:16fa:a104%4]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 10:09:26 +0000
Message-ID: <ca485dfa-58e7-6a09-97b0-dbf7cde7a7e2@ddn.com>
Date:   Tue, 29 Mar 2022 12:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] fix certs compilation / export is_key_on_revocation_list
Content-Language: fr
From:   Bernd Schubert <bschubert@ddn.com>
To:     David Howells <dhowells@redhat.com>,
        "\"David Woodhouse" <dwmw2@infradead.org>,
        keyrings@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <ce5bc8c0-2c6d-2a22-1ad3-357254686366@ddn.com>
 <e92ef2ea-bb1c-8a8d-2e25-c784a784b995@ddn.com>
In-Reply-To: <e92ef2ea-bb1c-8a8d-2e25-c784a784b995@ddn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0273.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::21) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ca5107f-5d00-4867-29d5-08da116c3448
X-MS-TrafficTypeDiagnostic: LV2PR19MB5960:EE_
X-Microsoft-Antispam-PRVS: <LV2PR19MB596060CFFADC023233D824EBB51E9@LV2PR19MB5960.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1ABlob2R6ZspjogDfBp/nKSuFHr9sr54kvtPBRAGWt9YYk1TsztkxVLIopubfuoj0wL9YSG54xl+MwHP8BKItbb3uAQrvEprnqOm+J5Shq89ZO+zZqC22N87MQlImHaBWeQt437uF9AG5etmUYZth4/LbGzo5GGfrOhvNh4FxfGnfGrbvkQo2Tc+BlzbRHIgkprfXW0QJczdgBxxuZlREjasKYiOERSDxKHKQyFf04oUOC/ZIB0w8YvPNR/KUWjO1+0OeGAoF7Gc5/nKmJgcxOdSMLTAebWzIc/tp+zu0jrw6YNEatDD0i+e8QRvemyPbeuqEuWrpLOT1DU8aNojkKRup6tHOXThakpuf04rbuICQ917haxS5AIJu0rXjL5DO9o49dE8+9qMEvM3uy57QjqC7yFAE+2zIhcvK6zJV8fjB5ZPlgi4hm75+CuCYrplCLrX5LkVXy3OUuN6fNvpeclYTHRToA4H7siSNVOBD5lsKXO/um+byyLR58araMBERr83+/6hC0bnuanqxAJeYfCMK8+c5T/yIaXq6xJ3NpNUcLf+4svBAdop6OKBh11K7DzVVVN11tRWQG7FNeytNCeL5s/EEXKgSmKd95rfg9E1nZTeKBq7q9X0YWey2hQGtdfh766ZaOVhT44xqINj8W65Uh2Zcv2GRfK+a0nG3/aOSa09KhOac9uWKx/y2/LVEfCcrmSxDuvqr7ka8SkP1rFCpy89umLRwvV+AGaXl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(6666004)(53546011)(6506007)(5660300002)(2906002)(31686004)(110136005)(36756003)(6512007)(38100700002)(316002)(66556008)(508600001)(86362001)(66476007)(66946007)(31696002)(2616005)(186003)(6486002)(83380400001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODVzOTRwbDFzTkdIeUJLa0IvK01LY3JVaDFXTWpkbWcxaUMrZUpGektiYTJr?=
 =?utf-8?B?bWhCWFRUc2tkZ09vQXFuK3RhM0ZQa2M3RFJqdmdXcXd1cTlGY2R5cmMvVUha?=
 =?utf-8?B?V21tblBTNHpYK3Fyc2dZUDBDaEkwTEpBYUltd1oyd0JKWjRHK2l6QnhOMkRO?=
 =?utf-8?B?VDYxbVBkT05JaHkxTjUrR1dMMDcyRDlrNXhSbGFQcWU0WjVpWG11NWFDbGl2?=
 =?utf-8?B?a3ZIZUkvaHZCNy96T2JhQnFKVW10ZWtkNklLMGRqdkxjM3dXS0hIWTJuUmEv?=
 =?utf-8?B?MXQ4ejZZRU1uWFB5b1J5UFQ0Vk01eE5hR1ZHMlY4cCsrWE9MUzRUU1pzRzhF?=
 =?utf-8?B?Ulg0QWIzTGo4dzV1V1dYYW9nUTE0QWhHYW9pdGUrSVh0TGlheFE4eTlIN0ND?=
 =?utf-8?B?L0JBQkZFZ2tIaWNkbjdQNTgremxXNWJKcHRWZVR6djVnOUxjRWJQeHRoUFlh?=
 =?utf-8?B?SEN2S0VxeXhKS1VXZFVZeVRpZlNFWDlGcjJ3T2ZMVnVmUlBrelU2MGN4Kzhp?=
 =?utf-8?B?ZXpXMVpLbWFqQXYwRzhCT2pmcHdtQnFhWGFRcGpQS3MrYzhyUURwbGdSaHQ0?=
 =?utf-8?B?WmpNMWVtbGdsVnFVY0VOZ3R4L05kbDU0WHM1T0NsdTh2cnM3S1NzenZuMTZ3?=
 =?utf-8?B?cEpjeWpuZllIM2RBOEw5ajVmbmtqdGxCcXVrMThXOEppdTdKNTdBY2pDMmtZ?=
 =?utf-8?B?THlTWEFZY3h4OTdYelJYY0huSS9BcU9MTkZmYkdpSFJ6MFBDUzlkdmZvWmNF?=
 =?utf-8?B?TTZGL2ZkdXRSTkhCbjhybkY5ZEJLY04zUEVDZFZNMFFiQi9WcFVUR1ZhakFL?=
 =?utf-8?B?enNJY1RIZzlJUXFFS0pVbmRCTGMzZjhSczVVUVU4TFJVUzVnRVl0STlEZ2VP?=
 =?utf-8?B?QVh2WkVOTTZPU28yeWtTUjc0T0ZuSGlKL3FJUTVhbkNWVDB0a3VDSWYwNktF?=
 =?utf-8?B?cjI1QmRYaTRUTElFSllDaEg0YXhxLzRxTWVkTkFxdnpKYzJyRWg1MDVoaGNF?=
 =?utf-8?B?VXBSOXNxMlR4ZWMreStKekptN1JMaHpWUmtrc25SakYzNDlac0Z6b1RxSHZU?=
 =?utf-8?B?NnlYM1NzLzI1eEg3MjZROGlKZVJLcDhpRm03dmFKWWx5Mm5iMTVTa2l4d0Nh?=
 =?utf-8?B?UzQ0UGRjTm5TVDFZcmRkVmRnZW95Yi81SkxKTThWNVd0bVhVNyt3dlpldXgz?=
 =?utf-8?B?M25XQ2thOGJwcE16eHJCbUU4S3E5Um1DNFZkS0orU3BmRFd2ZzNQTDQvUnUz?=
 =?utf-8?B?QTk0TU1PZEYxbWZSZ1liTjhsdllMS3ZmY0o1a2NVVm1sdCs5UllCLzMxNytG?=
 =?utf-8?B?UEc1K1pvQjVKdXRHZlJXUmxBYktTMWFtUW91MHFkREhmUThwemxNbFZyRkhB?=
 =?utf-8?B?RVptVkFVd2FueTR6V2hiU2hVM29Ia0ZZYnhXTDRpNC9ENjBaQkpwZGN3WW9C?=
 =?utf-8?B?R3B3V1kwTjJja3hFZ2xHNUZIaXk0RFgrVTZhaVNreWVTQ1k5c2JYZFo3UTZk?=
 =?utf-8?B?c3pqRk9zWnEvY3ZqcnlJY08rQVVkbnNZUWliUitneHdUYXpoMGJKOHJaZ2wy?=
 =?utf-8?B?ajhER3B2enZ4djRpVnptUDVFeWw4NnFpa0JHZlpBM3kyY01SUjd3TjRUa3JJ?=
 =?utf-8?B?VkNHSjdjV293ZUJmbUIvTkFiY1pCMVNkV2ZWY2RXaUlzeStYeXJ3cHFncS9z?=
 =?utf-8?B?ZGxDbkdJWVpQaVZiN2ppUzRYQmtXQmtLZXBGTXE3bEp5ZEV5aHBuc1ZYdlp5?=
 =?utf-8?B?S2dsMmFWWTJTTXFVOU12QXcrMDR2VmUvK0dQSEFCWGVtY3pMSC93Z3RnNW5F?=
 =?utf-8?B?ZVF4bnBLQWVLYlRVQnF3Z3JLbXA2VG0vQlh6bVFYQitxV1JIbklHZktLbjI2?=
 =?utf-8?B?akpJVk41N2V0MXorRUg1cHFiZjU1MGhoRHNSalZQSjN4NmVITHhwREgyaHBa?=
 =?utf-8?B?MVBlOC95dU9rMWx6bkU1TVd1OVB3N2hMS0dUSXlWNUtucW1IWjNrbWs5YXpD?=
 =?utf-8?B?YVRSaVQ5V1hoYmhBSlkwY29Md2dnRm14Y0tBUUc2Y3dYWlE2U01OcGhEU1R0?=
 =?utf-8?B?WTVoOHpiNXlwUHZDQWlyRGxhbW1mZHVMbWJUOUlyT1dTRU5CUVRXLzRsem1Y?=
 =?utf-8?B?ckk4UlVSUjRtLzBVdGUxemJVcENrL3ovRlphVk5IMkFIbFU2RU1US0UyZ1dY?=
 =?utf-8?B?aVd3L3lBSXBSVDNsWER5VWpiV1kvNVY2bmpqOVlCVHRxWDIxQkFGbkVSWFd4?=
 =?utf-8?B?cy91RVMrRG1jT2RKVEZwb0ZqZURVa0FtNFhEUkk5d2V6U1ZTQmdjcWdua2Jl?=
 =?utf-8?B?Z0huVEEyc3NYL3Z0U1MveEpuZk5XSS80UTZxVm01MnhyUUxIb3ZwY2o4UTRY?=
 =?utf-8?Q?T+JMs1swkkOu3zqJmhefYBr0ctPmZi9EITyb+mPRgGubU?=
X-MS-Exchange-AntiSpam-MessageData-1: 0bcU4u5P+8nwVA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca5107f-5d00-4867-29d5-08da116c3448
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 10:09:26.1068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PS32iECf0NjU0/CVLLKTSyKbilhEg5ACdgYms1S64HyoyvcRS4suySCOz/ibxZjk6LZ3t3oe8aXwnaM1tZ7liQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5960
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 3/2/22 21:19, Bernd Schubert wrote:
> Sorry for the spam, besides that pasting the patch somehow did not work 
> (I cannot apply it myself), I had also a typo in David W.'s mail. I hope 
> that attaching the patch is fine.
> 
> 
> 
> On 3/2/22 21:06, Bernd Schubert wrote:
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> Compilation of 5.17-rc7-master was failing with my .config
>> (actually taken from Ubuntus 5.17 package)
>>
>> certs/system_keyring.o: In function `verify_pkcs7_message_sig':
>> linux/certs/system_keyring.c:224:
>>      undefined reference to `is_key_on_revocation_list'
>>
>>
>> That got fixed by exporting the 'is_key_on_revocation_list' symbol.
>>
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>   certs/blacklist.c |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/certs/blacklist.c b/certs/blacklist.c
>> index c9a435b15af4..ad39780e5150 100644
>> --- a/certs/blacklist.c
>> +++ b/certs/blacklist.c
>> @@ -192,6 +192,7 @@ int is_key_on_revocation_list(struct pkcs7_message 
>> *pkcs7)
>>
>>       return -ENOKEY;
>>   }
>> +EXPORT_SYMBOL_GPL(is_key_on_revocation_list);
>>   #endif
>>
>>   /*
