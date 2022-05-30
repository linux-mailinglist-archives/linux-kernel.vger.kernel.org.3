Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B00E53787A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiE3J7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiE3J7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:59:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F42671D8D;
        Mon, 30 May 2022 02:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKNwGoHj/DSp0abA7QuzYSewpvZ1heR26aUujpQEYIHKg1rt7W6eVcfAiQKrU/+ar7et8BI6ILBPruT9RVDClAoo0hUv5EPlcdCh0zWi11MYZ5Ru7dMdmtOyK6S5cwC2Nhw7bHn9hB3sBaXLsqk5VWweC6ul/juNBwcf1Ix6B+vHO57sboe9ndHn475KRbdGhGL6mn/GFM3MgTabTaluuytY7p9+s63PCT2y4U1ZBvkxTG1lCK22no07/r+OPMbcrwrSpWTDuNbepjr7T/1lIA7amNGTS+JnjpPZFpMdorqoCkUWoAd9A0k0cX/7FGdPzt6G7k4LRpMCY7TOCx7T2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2SYjudIZSDsVcyQukpCXEw2M+uCbuFjVygBnWNeIOM=;
 b=ZPn2q6P56ilMBGZPLDbSZ6MJ5z0rbpJKxqDVzGWxqCQavAngFOvTr7FJM/vUxhyNqReCAf6lH4lu5qA1YeI2ceMh79BHq6zxVgdt11InHvVoW5Ndzzkvdkn1CX8OK4+nmuitXMWJr2EtaEOD/m8lCx9zlZMn10/DVU+wA22hFcxP2pY9E6+CrI6CJ5yZ2mnyiEbC1u3XCPehJuBAfkcswx07+91nWrrnJHPY4vbqaZFWzc3BAERaudR9JA9b3EJZp1/X0zqOPsTTq/Ww+pRBD8WpbGu9vAQBus5oKkUCLaE1wLn/eeNmctJE9Vyt13lzH6+7CL2QNKU9uBduFkjUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2SYjudIZSDsVcyQukpCXEw2M+uCbuFjVygBnWNeIOM=;
 b=HySSwinoRmJh9ut39MBGJdTUC23CJtlBsW0H5YX0LNV9kV8xYeX9WdfYCY34g2JuoJUR+qOVuKokI68JrDCZXMKBFbmmUxnrFXt1OnI7dUG156O7g6PkaqVsy9WQD8PGExTuFS4D0VNbRb/YImv1dO5jLHnDFkNQQXtGbHqOraD86n83L9h8RR4dXpyiQ+T1ilyON48NAPZCpzoOCr5vZX3CqIIirMFT1AEIPqKMYwUvsZs7ztGX+aPKzl5WMIdle8OfFzFuVffywPVnh6QfvLHOsrEVlaw4Xd8LeQOdGDuW6d6Eg2KYGHQMGiLihu3r4JlO9znhOhSpnt+agPIQ2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
 by AM0PR0602MB3443.eurprd06.prod.outlook.com (2603:10a6:208:21::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 09:59:01 +0000
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::58ca:a1d:54ff:1473]) by HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::58ca:a1d:54ff:1473%3]) with mapi id 15.20.5293.017; Mon, 30 May 2022
 09:59:01 +0000
Message-ID: <ffdd68af-a6ec-5a10-f4b8-56678285861f@vaisala.com>
Date:   Mon, 30 May 2022 12:58:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V9 0/5] iio: accel: sca3300: add compatible for scl3300
Content-Language: en-US
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.haemmerle@leica-geosystems.com
Cc:     linux-iio@vger.kernel.org
References: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
From:   Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0027.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::16) To HE1PR0602MB3625.eurprd06.prod.outlook.com
 (2603:10a6:7:81::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50e93087-17c2-4f61-25d8-08da422305b7
X-MS-TrafficTypeDiagnostic: AM0PR0602MB3443:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0602MB344360B2384C2841FB462607FDDD9@AM0PR0602MB3443.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UN5R3otMSZJ2DmmByYcqkKbUKhpZBaNzBfY/yqSz0+dpW4VmgGFmhNdc/HoqfPJDuy25sHGv9a7ABno7USKIPZwKdSQASc6b/EXZNtZobSmI6zWRul7nTMsL5A8zTXy+/fr3GEJVPoE56jk0Qrz5oVk/ohcsggBas7ZdsfIj+4jHpkNwaSiaRScYNm4o1FCq2HH+QxD02LQdegeCQJi7FzHFiegq+IgHtUSZQ/jP6UYOfcKkQ1D3xl961MT9+B8AU2yYiBUAjdD6sx9T35gVCJuwJoblK1lnF9HHul9QqjOcyL63RItyzeUqfHrpKHR2F6rqyOgyup2oeBfjVbjc++PYXxf97iBk9wMgS59BYqyXDgRu9CwjEAmLHC9CxdiUPrzrFvDN+DCR4OqEY6xf8quAfn0vlCHCHazKOiObqXDVoCAOkTqEWN90m3FMZ3m0cBUbHlE4ubA96HVwMhK086o6JKQPw+pZ5Oae0LL0w1LBTMwIwfyx6y9E7ijqTjuKRNeOjzqE5Q54nb7UwnXECZXVAarw5FxYjn+HL9HpOObCYgbJ896J0lBPzIN06fMEYQurm1Tr5DNf2YAd9/KJMLI35mG/p88lp/IThemSmYw4LjYU7MTX0ZsRxjWvqtqcwEZX4G9akNaW0sFyI38p8wTm3igNwuoz5B1+gAEyoCsVYxXsl5usCT5BNhcdfI7Kfs6ATSDkOwSjUI+U+1BTqkzXBZsLHufvrf8wquFIeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3625.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38100700002)(2616005)(8676002)(316002)(4326008)(36756003)(66476007)(83380400001)(31686004)(66556008)(8936002)(53546011)(6486002)(86362001)(6506007)(31696002)(508600001)(5660300002)(44832011)(4744005)(66946007)(26005)(6512007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG1JVFlVUWhObC9WeEJyQkkwbGl4UkYyUkVJNnQwLytpMkQ4ajNmNXVFNWds?=
 =?utf-8?B?NDVqTVAvalNXbC8wNmFKRTdYbjNMTzJDSmpNb2lLdFN3TXlRdDA0eWlwNGJZ?=
 =?utf-8?B?YUpVeStTRnVLb0QxOS9KYzBueFpvSDU4UWpsaHZTZDJJWDNuYzljVlRWRDdr?=
 =?utf-8?B?bHl4NWtqMndJTFRSMHduaWs1aFFoTENTZlFMS1JMczI0VVBRbHYyc2RpSFFh?=
 =?utf-8?B?d08vVXZGaXFlQ2k0WmJwaEVlejUvRmhtWUp4N3B3czNJVk8rQisrZ1JxeDBl?=
 =?utf-8?B?ZTdvZ1ByT0tMcG9yVVRnUittc3puRmhqVnlxU0xhTG4zR2NhTlBNZjZWUFdV?=
 =?utf-8?B?bllKeHkvSUd2WW1LY2pZbmREM2dERG8vQ1VYSFluY3JEeWdjbFk0RzhqL2pT?=
 =?utf-8?B?cmZqS0tndkM0c2V6STZUOTZ4akltamdmRExwU1JDNEdUN2dKM05ZdTlkK0Fk?=
 =?utf-8?B?RnVXQUt2VFI2N1R1aXkzMjNucGZNaTJ0L1dmdnBPY2l2b2hFa3FtMW0zM2t2?=
 =?utf-8?B?TEYvcTJHcW1iWHVURjFRTUFTOGRqQXRPeHc2SVNmWUVHV1dqYUhleWFxNi9H?=
 =?utf-8?B?aFFXOWNHMWpVSmpVZS9pWmMrNWZwUWltVG1YL05ENnQ2eHd0cTNXd0h5VkU3?=
 =?utf-8?B?MUYrRmduTGo0NzRkZXQvUlhLQXgxWENOWXVoREIzTDQxUlJyK1JITmcyNWZ3?=
 =?utf-8?B?NzNQdWlKYkw2N054N0lOVVIxRzFjWFZJOG12RWF5VVZUampGdU5jS3ZtU2ti?=
 =?utf-8?B?T1dQdWx1SktrMFNScVYrTXR2Z3hxWXdUTEtwallrSk9DZFRleGx0K2RCZVRE?=
 =?utf-8?B?dC84N0tueEFBb1ZNbFpjRHM2ZXY0TExxb3NZLzJDSnpXVHNNVmc2OEk0MFFJ?=
 =?utf-8?B?VG13U3VMZk9IeUw5WVNHbWhLcXZJeDhrSzZDYW51K0FHSHQrT0Vma3hHYmRS?=
 =?utf-8?B?MTh5dUd2QUpVQTJpeE1odDJzNCszWWRTU3l2M0FJU2RKRkwvRzZnT3h1NE9i?=
 =?utf-8?B?a3ZtWDF5MmdwQ2lqR0hGWS9lZ0w0RlJKRWM2TjdkdjVYNHNXaUdJRFNQY0NQ?=
 =?utf-8?B?ZjBMN2U3dVppMzIzQnlGOVE1TTBPMitQb3pkOG11WWhiMmV0eVFzbGg2SGNB?=
 =?utf-8?B?L21vZHozbjNTckh4SisvWi9LanBudURqSUkxMzlhSEFkWk1iWFgvVnM5VTdr?=
 =?utf-8?B?SkhIREdLSncrMm13VHY5WjB6V0R5R1hjbTRJWW1hbkVJTXRiNXA5UXBlSVJZ?=
 =?utf-8?B?dUZHN1B0U2pqMDVMZFp2WlVaMytsOTJRZFk2OVBwajNJdWtoN2Y5YklHbEpn?=
 =?utf-8?B?OVZqQnpMOWdxQjYrbENNRnh3QjQwQmJheUVQTVZleHZZU0crL3RjMk05SkJI?=
 =?utf-8?B?UnhrZURqOTNUNk0xbXlqdXVYdzVYT0tDQWVCT3RUS1JaZEV5UndlVnFxNVdy?=
 =?utf-8?B?NzV5eHp4bkhmWEdmUUorbU1PckltdTJreWJacWdKYlpUdVJibkJKbEtXM3dF?=
 =?utf-8?B?OUJycVF1NmJWVjI0SWpoN1lxSnBEL1pxZ0R1Zk1raVNkeVhKeHpRM1FYcnNQ?=
 =?utf-8?B?dEZSVWxuTngxRlFjYlFFY3JBaFVmWXR1TXRpOWJBRVZUOFNHUFp3YS9ib25I?=
 =?utf-8?B?M25SVUEzY0JtSDFTWXBBT1hyNW5NMG1UclpQV2tzSitDM3FmZWdJd2w3cHI5?=
 =?utf-8?B?L2UxYUdVV1hqU1dkUWpMdVpEeDZ1NTNlYno1RVBkS3BPc0Q0UjdLb3VKb0N3?=
 =?utf-8?B?b3JNMmdRem1IeFVYTDZiaks4SkFTdUFodlhpWHZtZFA2eWFDeWVIeWEva1hu?=
 =?utf-8?B?Z1c4K1VtWkwyTHhNajNlV0VYNFZWQ28zZ2FqZ28xSU8vWWVJY2p0ZEtNYmVN?=
 =?utf-8?B?bHM2SlJnZ1R6cTdJc054REJKcnlFSncrVVJJUW1qVnRtNy9jQzlOR2FNWDhU?=
 =?utf-8?B?bHA4d2lTNll5b1RUTkI4M0t2aUxhUVNzU0o1NEhRZ2hpRTRnQmxqYkpXNm1T?=
 =?utf-8?B?ZlZKQnBmb0M5a1kyeTdDcUtxMnJCaHo4Y1Y4amtXS3FkSEhXMER0bS9xS2NM?=
 =?utf-8?B?SkJPY2JJUzc1bmFOZnF6bEZRTGt3eStBczRjUlpDNDlZUjNaRG1ZQ25tOWpC?=
 =?utf-8?B?ZmJSTEVmOUVjN3QrNXFvTzNDNlFLRm94bWIxSytQTUxhVW1ZdFBSYlNmVWov?=
 =?utf-8?B?ZjNmUUlCRS94VUp6QmNYYzN1TGVscmFLeEVqb1c0TVR0MUxGK0hPald4TWxW?=
 =?utf-8?B?dzl6TWtOVFA1QU1WUFBjeGluUmI1RkE3UC9WZ3pKK1FYQ0tvUW9PY1VWOHhK?=
 =?utf-8?B?Zk8wOGJJcS81SXV5bWNrQnI2SEhIOEVPRzVtOXBvSmg2bkl4Q0VUNm1tOXFo?=
 =?utf-8?Q?ay2YABQzWEBv1OIk=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e93087-17c2-4f61-25d8-08da422305b7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3625.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 09:59:01.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqTuB49VgvL7hGwZMErd7NYT8bUmLW5CI+b+osgedcV4ff7zMxzdBziGueZBXP/aTVI35gqjLL6SG6MG14fETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0602MB3443
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/05/2022 09:18, LI Qingwu wrote:
> The current driver support sca3300 only, modified to support SCL3300.
> Verified with SCL3300 on IMX8MM.
> 
> SCL3300 is a three-axis accelerometer sensor with angle output, 
> the change adds the support of scl3300 and inclination data output.
> 
> 
> Changes in v9: 
>  - Rename angle to angle_supported.
>  - Delete reg_val &= GENMASK(1, 0), it's redundant.
>  - Fix typo of comments.
> 
> 
> LI Qingwu (5):
>   dt-bindings: iio: accel: sca3300: Document murata,scl3300
>   iio: accel: sca3300: add define for temp channel for reuse.
>   iio: accel: sca3300: modified to support multi chips
>   iio: accel: sca3300: Add support for SCL3300
>   iio: accel: sca3300: Add inclination channels
> 
>  .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
>  drivers/iio/accel/sca3300.c                   | 323 +++++++++++++++---
>  2 files changed, 269 insertions(+), 55 deletions(-)
> 

Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>
