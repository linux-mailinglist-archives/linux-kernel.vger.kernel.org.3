Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBC4478CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhLQN6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:58:33 -0500
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:63297
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231667AbhLQN6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:58:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBFkGwXTxV7UyveWHV/CXLWwmx87bbEXdDXYNHngqGcc5eO5XXFRkaPqQ5PdoDRX5IlcDG9xxxnC4vr7R+W+wNiCuHTLUOyL9XrI3d+BQJPm/fBxY+Jn86ktoW/fKvRIbMdyI2zQKLvz7hzR81PdW5FGZ0Sqw5WXSPNisEVUmbiNgxh3CWtsi7mVYmsCaVOB4zEjC2tcd4ZnhycJPqSXnRThNc6gB9wywDfgElv6SUuM7LvVCAnPfgcS9r8Vigy13h4mOyPFGwQUfbjmA0WpdtsKvozCq1VGp5/0yCpRQeBxZQ+c4h1rW9i1hrg2bRAHAk6CfzkPEDowvsczGy+ilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyZ7pKF8/QQ17fGJdv3GllNIPhy+9tFbb6u4DWAqKJQ=;
 b=Sn98EG5ZtGxmgyQUhNFUOUMWIZip6BeDHogu6EEHmmAnvXuDbAD6aJfK3wrSRVrk4dHVIzU/FtpDIbG2/49bvclqHPALeTEYUcyDn7gsJ8GE75Ni9mN+ccTm+XQVtC3sZwvFrRLoxtluyUW5qbxk/zzGInBvHxH53W9CU33Br/oDDwybvO+YusVscdU5y1aFzoT+m+mHC0+vqPmKjizj8jl88EPGDShPhAodGsOgash0oukXb1xbbL+jtM7BGLE0cBXNWa7VPGCwMQKCYhmYelGoXzdhsxvKGOjAxKC3yoFbbjPUzJVCl5cYCaxPaTvIgqFpMd1eFOGwAq65Ac+Pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyZ7pKF8/QQ17fGJdv3GllNIPhy+9tFbb6u4DWAqKJQ=;
 b=d9o9x1WeIwgMZ+0oy+WesNRmJVzLh3Rep7tW81G3XOOwzkm6W3wzFu2yZHGt0ynj9ifLC3+3JCOopEwtnUU+1fpRt7w+dqibn0PPu6s+pMStIf+wB2P4lEF+G9BJO3pkbyKomUbIFkORKecWxIXBuRUUtUkkVBWVl1EKvUAMek0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3627.namprd12.prod.outlook.com (2603:10b6:5:3e::18) by
 DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Fri, 17 Dec 2021 13:58:27 +0000
Received: from DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::2437:1c64:765e:2fb6]) by DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::2437:1c64:765e:2fb6%5]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 13:58:27 +0000
Message-ID: <9e069312-529a-f922-f537-e03e0c5523cc@amd.com>
Date:   Fri, 17 Dec 2021 19:28:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] ASoC: max98357a: Add mixer control to mute/unmute speaker
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211208185850.1555996-1-AjitKumar.Pandey@amd.com>
 <YbETxcwa83U8WXTO@sirena.org.uk> <YbEYVq+uvIcoxqko@sirena.org.uk>
 <3ec805fc-07cc-6091-551a-771dffe459d0@amd.com>
 <Ybs/i3Lg9VN0d4kg@sirena.org.uk>
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
In-Reply-To: <Ybs/i3Lg9VN0d4kg@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::16) To DM6PR12MB3627.namprd12.prod.outlook.com
 (2603:10b6:5:3e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8018f31-2a8c-4eba-6f38-08d9c1654c48
X-MS-TrafficTypeDiagnostic: DM5PR12MB2407:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2407B6E22817FA7D4022834E82789@DM5PR12MB2407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44rQrna0VjaCKM0V3pk+pAqzvCe+vM7a65tPtlIppefcM1imh77IeceYPW8TFWwgaXtQhK+v6dWlxhUdWv3DgpD6tx/sMRW5ThqwEL28thNbwOwt67kKzVzMZ2Oy1MAinMurYXzX7+Rvrx+sfIFLoI6IR2eDYSCxcQCk+pHPs2bFN3VbmWGfoFwSRHoddAYR3zdAuu8aQXKnYHYUYFHlpzgeemuK7vLEWtDg4jyujmxd09s8q7nAJYN/a87SuMmqj6qWYNFawg4evGgPAEUP4xilrlw7tLCl5/ohIjwmMpH3W3ixVQS+p5WcSJbZIDzUGOAMNZlQHzmsxrUW/VylEwmdqQaI3xu1wmWYoXvvmLPidmtu+EVOyUTZtcLDdJIIJ3xbE2MFO4BLvnZJMh0+tsCRbjtD9zlaMG7alx8J1l07EnWaZj9rtsfprZcO5sNzW9VqfRFHFKFEOquOMiYMMC3/gKDI0S6t7raaie/+LYkCJLuGbxOFcLmAjioMCW+GbPLqxSoWlMrxOSNJyzDuNy1zhESbrJ66W3q7bTOcANAVgjcmEANbFKZFATRwVYDWzegkDDjulfu3keohgmnFVT8otAglAKeHJTUc87aDThffbQ8N72XZtoFODzJe86RT8VPIqeV8R6FhbJwbCcvWd76hTxwEJYMwSBBhPp03S/TpfH3UlkO35rP/AGtSkqymCjIIkgcdncNViMV+WMv2vOEwPD1f2PppzYt0gykcPq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3627.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(4326008)(66476007)(66556008)(2906002)(2616005)(6512007)(31686004)(8936002)(26005)(53546011)(8676002)(86362001)(31696002)(36756003)(66946007)(38100700002)(316002)(558084003)(6916009)(6666004)(5660300002)(6486002)(6506007)(186003)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlNFY2Fjc3NyOEgwTzVkcE13dytnNlc3WHBvZFhRb2N1djVZNGkyV1Rham5E?=
 =?utf-8?B?OHhVV3dNNnV2SmRlZmJwcXVhNWdvQ2hBdFJZS3ljZS81Y3lRYzlNQVh4dmVZ?=
 =?utf-8?B?aUNOTXlQSWgyUFdESmN1SjRsS21OK0U3akFXSDFzZGUvaEF5TWxwUnRqbW1Q?=
 =?utf-8?B?VjlYQXUwOFJ0dk8xL0VwWkMvYjJGL05qSW9EUS93QXdneW9aTDdaSmtuREpC?=
 =?utf-8?B?S0hFNGQwK3pzRWsxejdKcXIwRXZYck1ueVFETGJmMjRBTm4xNnNXUVN4SWdm?=
 =?utf-8?B?dC9FcmJBUU9PVis4SVNZZHc2OXVvY1pkN00rdnRvNHpxWWJuV29UZG42dFdU?=
 =?utf-8?B?ZFMydytLVlUrU1hieVpDZG5lT1MwYVZ6ZDhDNmtKZ1E5VlFkS2RHMEd0LzBN?=
 =?utf-8?B?WHBrK2R3M01Kc281b2pSVUN0ejVRNlk2N2Z2YlpveW0waFNNQThBSTZXWmdq?=
 =?utf-8?B?bTJIeisyQWwxanM0ZlRHNGloUkZQQlV1bVQwd2hwZG9sWWp5VGg2UWxhMDJG?=
 =?utf-8?B?YkF5YUd6RUJIMUlXY1RwR1FGWmczM0JWaWUxM2ttMlFITjM2N0RaeEk3NDV1?=
 =?utf-8?B?eXZ6bXhlSTh6WlU5RW0wUEt5anhod010SmJLd3VJQTIrbUF5VjZLMjE3K3Y5?=
 =?utf-8?B?dGQ4bmY5b2JVekdJOEVMeE9iKzUxTldremYrTS9CK1JIQWJNWUlIay9pTGVR?=
 =?utf-8?B?UVR5R0t6aVZ5dTZkNVRWTUlIeW5kVTVKTnBOYjdQbW5qbS95SjZNWHJmZ3RI?=
 =?utf-8?B?VTc1Sk1kUVV3UVBKZ0xwRU56YnBnV2NZRVgvaURZMWxNOU5VV09rVGNmaEIv?=
 =?utf-8?B?QzJPS1AzdkttaWFqUTdQUlpJQ216K0RGTGV4V1J1Ym03UDh6Y1Znb24reU5W?=
 =?utf-8?B?MjF3Vjh6TGU5ZUFWZnpQbU9qcnQ4b2c4YlBYeWxTYmlCR2NpTG9nWXJ6amth?=
 =?utf-8?B?R2E4QVJGZzBvUXR5Y1p6bWthMXZwTTJWdXFSMXp6b051ZDJJWGZzaGdNUnZp?=
 =?utf-8?B?alJUajc1dGJvTGlGYXBjU1NhcFBNaUcvZFdzVy9OcXZxc1o4RFRsb0hML2x2?=
 =?utf-8?B?T1JNOENnbDRxdTZSUlMvN3ZhUFg4NUlDM3ZtV1NBM1dDSlR2YXRPcFVKdlgw?=
 =?utf-8?B?NEw5aWo3YitsV0pJWk9aUmlWOGFMZjh5VFJoUjF0VmV5RlpUalI5cU96Tm5S?=
 =?utf-8?B?RUNpN1dHR21DOVpSdHFQK2hBQWZHSzV2Wkh4VVRnZWNjSS9zWDdsLzFjZmo0?=
 =?utf-8?B?bjNKSFhERGRudm9Nd3hBTzYvcFlRVWdEM2lUUEtkdUx4a3NJWmtlRXhackI4?=
 =?utf-8?B?UGRSQ3JlYnZjWFN6ZkFhbzJQVzYzNWQxT0NxRURzNTg1MHh6U2N4bWN6OWtR?=
 =?utf-8?B?WUVaT3dMOTdIRzdYeFI0UU1BV2pXU0FCNk9PWUJEdDB0WVJjcHZKeS9QdmVj?=
 =?utf-8?B?ZFY5cjQ5WlI5cXpqdnJrVG85Y1hWWTFINnpIQzRhUko1cDY3bkRGN05YcVRm?=
 =?utf-8?B?ZEZyME1rblZPM3F1SUVGVFdVNzFQdmgxVUFsMDZMdlR6aWxQREN3WTBCL1BZ?=
 =?utf-8?B?d2I4NWNqSXV1TUhabEo0Q09WMDNTL1hmV2drRlM0eW5IUGdsL2tCc2ZyRTIr?=
 =?utf-8?B?dWVCY0t3cnVOU3JoUzZiMG1vNHg1VXFSTGcyc2J5eFRMT0N6N1JYTC9iUHVG?=
 =?utf-8?B?OEh5S3oyNDJxelJtUnhBTTlUbmVha0lqOGlFemUzREJNVlF3SmdGMUNRRXBT?=
 =?utf-8?B?dnhMTkdOamM1bXl6engrZEpsWXluMnA0RmlVMFBGa3pENlFzT0dCY2l2Vmhm?=
 =?utf-8?B?QnBLQ0dRaGVidnF5ZlpYMmJaeFNHaFdqbnUyTXdYMkJIZ0MrTFV4MWVKREQ3?=
 =?utf-8?B?VGphbWgwMVFZelA4N3lKYTl4QTJZMVBVazRrdlZvdUFhcUdlRmh0Q1lLMHpZ?=
 =?utf-8?B?TWp6am0zQktqa09NNHErcThjaVpwQVhzbmx3ZWpjL2FtS1RjaTZUcndHWkVr?=
 =?utf-8?B?Q2JGRWpwS3lkMytGeEsrNDRXWUpXTkkwcGg2VE1BNkF0ak5SOXY4U3l4akRp?=
 =?utf-8?B?MTgzcWhnL3dZeFp5MGQvcytnUTFSTXRyMkxJNHJDTTFVR0IxSTdCYUVPZThR?=
 =?utf-8?B?QzFENmZaNS9GTUpuN3c0N3BiMkRRQStwbVNaQSs0YisxbFJVb3p5UzF5dVM0?=
 =?utf-8?Q?BbYn9RxxgmDtxe6NZpwzPdw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8018f31-2a8c-4eba-6f38-08d9c1654c48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3627.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 13:58:26.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9BipfcclWfP/C1PzkFcLOHRlenmPDxVq2R4Cr2MKB6zT2kBY1SuGdu6xeUqlycrQYqAU7ePSXCn05/r5rqZog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2407
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2021 7:00 PM, Mark Brown wrote:
> DAPM should cope perfectly fine with this setup...

Ok Thanks , we will re-look our DAPM graph and comeback.
We can drop this change for now.
