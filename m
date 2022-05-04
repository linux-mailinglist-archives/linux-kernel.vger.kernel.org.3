Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED4A51AEE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377962AbiEDUWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355432AbiEDUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:22:10 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7063A4ECFD;
        Wed,  4 May 2022 13:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSeEPzA8mT4LZ5itI+wwBK88MxjGJ+0BM70CRDrJsS9htcUSZ6rTtJklB//+DXXpvfUJ5CwPXbGqg2dsoAWx7f/ElODG/d2RD4tEm05ubDeuhXVaR8LSEDkL88XUw3Yk9R/RLaTW7totb3tgNQ2iKc1xZTBK8VdlkQd7fFmR596o7mShA3Kw1CAodkciftvcW3U0u0iTQiXjFKfOWupwyu+DIOYQAnm+naFIkGCoBKa1yfEFDupnoZkgEejY9xKkVLZKQxtvZnO7zsfhmoFYp/gVh9uCWO7O3jGAQPoY1BfXjwLdtpVo97FQzdRQ+rTuQCSqyx1fkLEUIC1hEdq9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68XciWo3VZj99y6r6pMWwTKdDXR0LnX5A+9vgwbe/v0=;
 b=ShX9hkpSadocb/y783nmP8wA+g9mou64PX34oVQQB9VI9eeIeVLPhJc1HuwDTFXSV/T5itxApzUfqbB8i3RLmrcsVSkib7/xuVrWpPVKvW8UMaLJGSeIIXDMSa/ymKAKumZmkCxgYKn8WWwT/x/xVyXO5wpq0TKiQzkRXKD38Q9VVfpsbLpNdpoKe9yJ+abxPKhCEGts9BTzc7K+dVZmBpvOtVUVorhACrRdJb0WnvU6gbuFp7gJL1kjqsO1GprKTEteu2MfqLa+T98dygeKQJNmODrF6wflDjlCKcFm95gSv5dA6+sAz/EjB+3b+mejWAu65VQl7kCGzvfx82P88g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BL3PR01MB7011.prod.exchangelabs.com (2603:10b6:208:35a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Wed, 4 May 2022 20:18:25 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d41:91cf:552e:b16b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d41:91cf:552e:b16b%7]) with mapi id 15.20.5206.013; Wed, 4 May 2022
 20:18:25 +0000
Message-ID: <df763cb0-83f2-35a5-a381-57cfd040becf@talpey.com>
Date:   Wed, 4 May 2022 16:18:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: CIFS regression mounting vers=1.0 NTLMSSP when hostname is too
 long
Content-Language: en-US
To:     Paulo Alcantara <pc@cjr.nz>, Steven French <sfrench@samba.org>,
        Byron Stanoszek <gandalf@winds.org>
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org>
 <878rri2i6o.fsf@cjr.nz> <7dc6c729-73cd-74be-eec7-ac4a0013f60f@samba.org>
 <87tua51550.fsf@cjr.nz>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <87tua51550.fsf@cjr.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b134e80-02fa-4fba-f5ad-08da2e0b3e53
X-MS-TrafficTypeDiagnostic: BL3PR01MB7011:EE_
X-Microsoft-Antispam-PRVS: <BL3PR01MB701104F6232E515DE1312F90D6C39@BL3PR01MB7011.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sy8Zcbq5mjLF5X7Xm8niKTlWsLigRBxYeonopmFKA3hk5HDhB1W2coPmZxfsiTYIL38XyssxBlvJOiRBO72lI5VBG76TWOdO+wZfYYQ4ZoJHnz1mKHnGru2F7OoVNL6xMeeYavctnSGHGNAWjRrarZ05C7VqzHnBrdPDaYQBk0dmFDrxBYrsAhF4nGJQ0ffRvpC164lOGCb7vysQ75k48BooKm7xe8NTdhGuQ58na+af7y9WE124yN8Ld1e0cYy+opqr31VR8Fc3JV5uaPUy2JSsj1yXba66UI9blq5JfQFhZY9fkXf/VC7cPrNontHfQRRCWhvKOj8fQcTh3+X3SDSkQQmPcHz/ayBU/WPCwhwXIjD+eZVPtIagDIiYoL7MYrS75dltjaDx7PNe/8jwRwN3mlTdUljyETiUPEZiWHf6lQ3MQ9L57+KgUNqG9N7CCeQCDtdeZm4SzP0dVRedMMXNTnCkyZLGAAlMQxzaa+gEGVvYO64jP4jJIMzoHL2EoMVG3G7NBvkPPqEG+iRmp+i60A+6kxCzgFu6ctkFCofZ8tE7240NjsbIQy9xse97QWTjpFJotUOPDbDQaLxmmB/JYOdbZOmKy6kcvccAvsGzJRmQWXM+H0uqWY68vUlwzgQ/t/ehpc24/lXsgiEsq6kKsx7+W7eoioxFJwOxtmw96rSu1BePhCTWsuBhgrRC/wOJ9D3xOABSQk5BfLgn5z63FMooBYEUR06DhHeUk3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(346002)(396003)(39830400003)(376002)(366004)(38350700002)(36756003)(53546011)(6486002)(38100700002)(2906002)(52116002)(6666004)(31686004)(8936002)(6506007)(508600001)(6512007)(4326008)(86362001)(110136005)(186003)(2616005)(26005)(316002)(5660300002)(31696002)(66556008)(8676002)(83380400001)(66946007)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1JyZXJIME9sbGxsVUhkK1h3YmtsOTJhcU5TZlBjMEhQdlBnRTRRRHdaRkk4?=
 =?utf-8?B?c2kvMThXWnpGRUNCVHRMQVBVQ3BES3FBMnVPSjVCazhuWC9XUzdGK250WWJa?=
 =?utf-8?B?dVpSRmpuRXBmZFA2d2Jrdk9JRFVCbXVvdVlncDhZakJjbnA3dXhtaDN2aGdE?=
 =?utf-8?B?cVBKYWpvWVlDci9DYUpGek82c2dtQU4waE1YVXlxNVdkcEdHSStyWVV3Z2Rs?=
 =?utf-8?B?Lzg4M2gwTy80Vm1XNHlSdjVwWm5BRmY5UHkvSWd6dUlrby9mV3RaQW9nNzRJ?=
 =?utf-8?B?WWZkWXhCQ0ExUXVGV0lWQWRtUmVNbEhkd1JyN01sNC9NT0xKRmZXTzUyeXNN?=
 =?utf-8?B?RFRTNTRXZjVvVW5RVk5ETGFVbDlLaUxyZXdUMGFsMjJLdUwwQmEvcjdNZld0?=
 =?utf-8?B?b05RRUVSc1p0YmEzbU14bE1aczFMRkgzM0Rqa1BwaFRkV0ExMXh3aFFDeC9J?=
 =?utf-8?B?aDNXRy9ldkNNZkVvQlRPejQwVXhTb2ZaaGRNbHg2MGwzVDl4VG4xZUZUanc4?=
 =?utf-8?B?bm9UT2dQZWo3THQyZkxsN3U2QmYwRi80UE5HWFA4UmdpOTM0ZGhLZGE5N1VX?=
 =?utf-8?B?dExCOEkrM2xIbkU2OS9XUXRhSkl6M3pYMjdXeEl4OHl0VlFITGJ3N0VOekRa?=
 =?utf-8?B?OVVJSmsrS2w3Y0hyMnZRNy9TZW5YRVd5emI5SVhIQThBRG1xZXI5OXRIYnFr?=
 =?utf-8?B?QksxQWQ5SmlMYWJJdTBFMURVVkxTSDArSFVQNnFud2FlcFU0TWJBS0xEYyt5?=
 =?utf-8?B?dmdTUWZtTkpnZjNzZzloM0FxblRzbFpSOXRVSE5FdXJuOVR5VVBRSkw0UXF2?=
 =?utf-8?B?eGtYamxRcnRqOHNNSisrc0haN01pd1k5R3NOcXhZRjZsT3hKMUFFalg5aVBh?=
 =?utf-8?B?Y2lBcS8zclJWeU9TQmcybUI4MTIvaHpkT2FhVHpyZHNTdkFGaktPTGVXamZx?=
 =?utf-8?B?a3B0Q3VMTHVlVWtqcXZOZmpzMXQ0QVROaXBNRytDUUZoRG1Tb29kL3JpNWxH?=
 =?utf-8?B?OEVFdG83cGRMcXM2blRiVk5ZblVPK041N2ZESjhZOStKV0lLK2F2d0YvNi9D?=
 =?utf-8?B?NWFOVjZma09aV2YwZGpOdVh3c0dSV1NCSUc2Vy9hRW4xbVJ3M0hxMk1HRkZi?=
 =?utf-8?B?UFk2emlSVk02Q2d0ekszYmphMkVBZit5dFQzMkJYWWwwVFdPNitqdE93bVNy?=
 =?utf-8?B?T0N0cVlYMjgycVNYT1B0KzlONWdYUHFLWENiZ3d0ZjlwZzgxUTZpekFNWGd3?=
 =?utf-8?B?enE4L2NhM1ViRUNPMlR0Rk9xa1JpbEdnd2YyUVpoNXl1bnBxWmlLb09iS08w?=
 =?utf-8?B?aW9ZaUtvd04vblpHUkh3eDJ0aldCb1VZbGc0aVdvOGtVNm9ubm1Sc2FHTm4r?=
 =?utf-8?B?RFdpblEyemZzbjMrRjlEOUQxbFk1cTBmYUIyNnJoY0tVU05IRnQxRyt2amNQ?=
 =?utf-8?B?YnA3bVpaNFpnYkhJU0pXUldDSzRVTkZLaUVoaENWMUMwNnVSS3d0Ujk5djRu?=
 =?utf-8?B?RTdsUTd6aXZ2YVNtVHMvT0N6T25HUE1Wb09JMCtTYjV5K2hjdWxva3NyQ1ZU?=
 =?utf-8?B?ejFwYzlvbm5PdE8xekZPVnZZUFVSV3pCdzlYdk1kYkQ2WDE3ZFdKcUZMSXl4?=
 =?utf-8?B?ZmQzTHdDNnBaVzJLRVJGZXQwbSt5RUxZMnBTbEdVRk9CaDlsNmc2bFd4Q1kz?=
 =?utf-8?B?OWlybHkySk9TVS9rLzF0MEZqd0ROM1p0WFFiVHpKbitEZlZxZnBhd1lDakw5?=
 =?utf-8?B?bCtpSEVMK1FPaDZaclZLcDlxUEUwZFV1aHYrc1NpTUpMa01UZFRrU0l3VmZU?=
 =?utf-8?B?TlhWUUdiZ2NxQTVMZ1ErQXlaNUd3b2drU0pUTVY0ZE5pMFZFa2Z3aHJWd2VZ?=
 =?utf-8?B?U1hkTmVwQTBKaEQ1dmxCZlpoS0NjNlhFMTd6Y1BpdDlxVnY4NjhNNm8xeTBN?=
 =?utf-8?B?aUlhWHpGemF5akVKb29zVkZpekRlc0k5YlVFbXc0L2F2U25aeTlWMmd1WEpz?=
 =?utf-8?B?eG1CUGw0OUNBdm5UbHpwWGtOMkhqVUdCNmNKRittMkZ4K05MSGZrQjdQMFp5?=
 =?utf-8?B?V3g3YXFhRkZMSGM0M0NGaThLcmt0djNiN1hCM2prbGxmOFA1Vm1KVmg5QmVK?=
 =?utf-8?B?WWlWbW9GRmEyNlB5L29IQnZpOEdWcE95N0UwM01ldFpFUDJyNytSM0doZi8r?=
 =?utf-8?B?ZW85dTloV1dCcmpldEJneVM0TVdHbGg3T3lGSmU0M2MzZnhYVU9sTytVRUFp?=
 =?utf-8?B?YXNsNmJkbGU2UGVVUS9NbFJmem9vK1ZWODYvTUx3Y2hEclk5VmlTdy92VmFK?=
 =?utf-8?Q?muYbVqRBs3llMfZzwm?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b134e80-02fa-4fba-f5ad-08da2e0b3e53
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 20:18:25.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ga6kZsqRijgg1CqTojfwzNBH6nqhsMWmpfXuCdKHRJXoHRwKTDRi4zmyWAOZnbJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7011
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/2022 3:15 PM, Paulo Alcantara wrote:
> Hi Steve,
> 
> Steven French <sfrench@samba.org> writes:
> 
>> makes sense - do you see anything related in the NTLMSSP doc?
> 
> I'll quote some relevant parts from MS-NLMP which make sense to me:
> 
> 	3.1.5.1.2 Client Receives a CHALLENGE_MESSAGE from the Server
> 	...
> 	If the NTLMSSP_NEGOTIATE_VERSION flag is set by the client application,
> 	the Version field MUST be set to the current version (section 2.2.2.10),
> 	and the Workstation field MUST be set to NbMachineName.
> 	
> 	3.2.1.1 Variables Internal to the Protocol
> 	...
> 	NbMachineName: A string that indicates the NetBIOS machine name of the
> 	server.
> 	
> 	2.2.2.1 AV_PAIR
> 	...
> 	MsvAvNbComputerName: The server's NetBIOS computer name. The name MUST
> 	be in Unicode, and is not null-terminated. This type of information MUST
> 	be present in the AV_pair list.
> 
> and indeed we set NTLMSSP_NEGOTIATE_VERSION in
> fs/cifs/sess.c:build_ntlmssp_smb3_negotiate_blob().
> 
> Unless I didn't miss anything obvious, I think we should be sending
> NetBIOS name or simply truncate utsname()->nodename to 16 bytes as
> previously proposed by Byron regardless what protocol version is being
> used.
> 
> Tom, what is your opinion on that?

I think the most conservative and spec-compliant choice should be made.
SMB1 should not be pushing the envelope of interoperability, in this day
and age.

I believe the NetBIOS name is a fixed array of 16 octets, right? So, if
the nodename is shorter, it needs to be padded with 0's.

Did this code change recently? Why???

Tom.
