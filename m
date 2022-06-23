Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB96557723
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiFWJvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiFWJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:51:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C981B848
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRH5NpRMrtMONiZ1XMBzLpTmL/ycHKKaOb5wO4TjNG5ztthbzpisad2IeutLdgqSMqS8m5cXiZnIy19RuGUKURLr5j4RU6IyeHzAZBK+uUyrUOeNPSFmIHrrwB88YYxD6/0hdIkGew2jnFIUaXA7Z0HSEHx+nJimzesczhbXiMaAIMn3HCmGjxzAjXKCqQirTvO9fAN1tNS/n8Grhj7RxvKblAgRvEqh0e1wf80mTY9MM92Cs8oODhWyArg4Dn9glxV2DtQVfKxtPx4OxczAgn2oNb1pO8G/q8FAemNOWXkuwkwVzBxEL/uOc3w22qlD19YmOCA+wIuIiJ8juk/lsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPkCWlh2g4+7fZKEVssqxY5bK56PP5KkWtPeMBrD6HY=;
 b=aWs67TC54fP+wfHpWULJzvk5Ehr7O1D58k+siXIicpbrZPCCRf7mJ+qrhYq/QEDFS48bDeM6+U/5s4IkUQcWk82J+a+2Yl94/9pxHBUXx6a+jOV/F2FXfmds4/4+UulMFIxLzzQZXJX+1Jat/NNV8kYa1FsJVOVKipcS0J6E/kEPy+bUwTeb/ySRTSzSiLfCdiNk49QlbCpR38ZUvB/mQOgbOyY5vQ+DMoU1QYn9plb37JpMQ6CNB1T1gsMEdhB52Zj1FoqmCQSMfb7QtV9cJX5aVvjK3EwTcmW8jXWz4IFnMj4hBWpFAgcmvS6Wk3A7WoM+PS5PNiPrD9/oHxJ8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPkCWlh2g4+7fZKEVssqxY5bK56PP5KkWtPeMBrD6HY=;
 b=MU6knorznhgr/KNHnlkstznCF6rWIP/2L1aoNdQ4Ax7qZe0Ebcm2/FEfyDGzAl7ZNE/PPocaRIsgWHQPulFfTI7d5vB0I85uwFztYDACokXv0t750Z6M7+POqraNgnwhk+rZi8CgnjraOhZMHi5USYITCCOC1+XmviciB/GDQe4y1p4zp7FYrlzJ+0YK1rASsOFUWRB8MnmPbYfxBdrak84Usb/669GwUaY5S0TAuCi+0bl4O9z7WF8H6guv3g3f6v74VTHwJ7QgDCu80sFw89Uk0nPdxa/Cl2Z67oWTfr7P1XJDSxwXQc6xL415Lh+1+lZpvnu9Pf8dk4Bf8Bp5NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AM0PR04MB6324.eurprd04.prod.outlook.com (2603:10a6:208:13f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 09:51:45 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b%7]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 09:51:45 +0000
Message-ID: <117fd526-a241-2f01-47b5-e40e1803124b@suse.com>
Date:   Thu, 23 Jun 2022 11:51:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] x86/xen: use clear_bss() for Xen PV guests
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220623094608.7294-1-jgross@suse.com>
 <20220623094608.7294-2-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20220623094608.7294-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P192CA0057.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::34) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e8848dc-1266-4755-f88c-08da54fdfb9b
X-MS-TrafficTypeDiagnostic: AM0PR04MB6324:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0PR04MB6324BE2418761D390B2FAC1BB3B59@AM0PR04MB6324.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2UkmaNdZxfNORvtmTIF6RqV4//8CO09hcEe6RLZszB0dglB70vRxJ7/gwXdu/PBNR5cPbXwv03hCWsxOacrquvXiT0li1xeaL5vYw0x6/9VgO5GrRyXAPK86lyAqt1sHuTTxVGsOJfre3GkmDiL1AQB75ePyDwoB9WaILYGgGeeq1+5J2EiBAqx0QD8XsvWa3wUneSIX1AC0eMB9Dejl9g7A0rmiW6hD+zd5NRa8OX7crQpIgsKP1ePdPz2oC31MfGnDMZ2IAD7teFX0WGQ5YBuzuJa+vZFw/6mArv3DIASTJEEf0ucj5cwzQ0FU63wkG/UDZ7U5IKsd19yDFyq8tRyqWqJm/KPrHH3ocJS0F3Toa7jVuvzNMlzYPAxa9OHZLPyyGJ/wmesY81yIk3yF9wnXdwfsXVH9Ei/pZ1a5mpaLntDgpul6kEXsD+ntvjiOzCSYbAyJGQHk7zyhL5hgmKBFxgJutRLwBNa6gXV97hngCMl4kjIr3rcLvFAbmVSsqlHy6TjGktq6Xv3zMXOk6FvnTteE0ApdCJxpuN9Za733YvpOPlEazAWWJVYQNPlaYUI804HsEklmPp06L4emWqkG8FlXmD8ZBAr5zLCUiU9JEwMdBvZ3gcQC5nqggvE/uGtITAl6rOJUfb8zbTExs4SPes4x+Ja+pXlGatcgmfxnPRrK3xQZx2BdoMHB1ZQaUfCbANt68C4bzis8U9PpPFs+19mKPFgUnpIVJoW/C5NQ/U7ORrXj7rbs919fQu6Z1AWrOLRfMKRLRV8hDyKdhTMuxMkr8bOqknjiBlP3cA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(396003)(136003)(39860400002)(6486002)(53546011)(478600001)(6666004)(26005)(6506007)(54906003)(8936002)(6512007)(38100700002)(186003)(41300700001)(4744005)(31686004)(5660300002)(2616005)(8676002)(66476007)(36756003)(37006003)(316002)(6636002)(2906002)(4326008)(6862004)(86362001)(31696002)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZNMndKRjZMZGllVk8yS3hqV0VEYytPUi9lalJESDhIY1V5RHBkdlh2V05a?=
 =?utf-8?B?WlhsT0VpN3ExenJqYm9TUnhjTWszVENWY1JDZ0FvRUNhM3F2dlMwMldqdzdI?=
 =?utf-8?B?R09UTFMrNWJ1QmhIVzkvMXZxTkkwV2JOUFd2aFB0UlFRaXE3aGJZZVVJNTlu?=
 =?utf-8?B?QTVGSkFGWTdsV29ZVFBpR0o3VnF1QTk5bXZ3a0NmUjk4WmkxK0lnUSs2UWgw?=
 =?utf-8?B?T01OTlVMeEY2eWhkTSt0ZjFHRUpEMGpSNlRRTm1wTUoxOE9Zd0xTTVBYakNQ?=
 =?utf-8?B?QXczRm5Vc1BERFMrTXlFbHhoQ0d4ekEzeUpoVDJOSE51Ym5sSjlpdTh4L1Nt?=
 =?utf-8?B?aFhzUVFnQk1NZElkSGtISkRXV1p3Rmkxdk92RGRHZE5FZEpoakVrd2JjL0tI?=
 =?utf-8?B?Z050UFZCM1lHUjduSiswNVVwUEVoTWJvOE8vZTBtOGVpeEtoRXk1bDJTaS9t?=
 =?utf-8?B?OTRTSjdUbHdlT3dZOFlTVG44WkdBTExHSm43dlJNODYrU0lvaERIdm1XcnE2?=
 =?utf-8?B?N2JQekFBTjJaT0NCUHlxbFRpOVlmeGMzMDMwZFcrNUZIWHAwb0xZSGh6S2pM?=
 =?utf-8?B?T3BNUHZlZmlwcyt2NU5CSmpiZEM0VTJiRWp5S3RsanI4Qm9ldldSblQxSXdQ?=
 =?utf-8?B?TFlGenlwSHlYRDdVNDAyU290bG1nUWZ2Rm5KZ2M4VmI4WjdlRDNaREI1UWMy?=
 =?utf-8?B?SG5jVUZsc0ZBd3hRTWFVNklKMmtoVklkZkRjTHBJUG1XMEdaNWlpY0hZcUNJ?=
 =?utf-8?B?eVFtM3N1Z0NITmhxVHBXQ2wwM1BENWpxWm5zQXdEOFNLQUV1VTRpMWJGUVR3?=
 =?utf-8?B?RWdQd3FJNndKVEJvZ2NZUmZpbUxINE1oY0N3MGp0M251RUFySjZISi8rWi94?=
 =?utf-8?B?UG0xd0VJMzI5ejVvK2FhNjFEYUJZeTNnUFN5MHF0cXppYXVzcjdubktnRGJt?=
 =?utf-8?B?S0JrZS8ybDVaVDVvMXp4a1M4VWJWMjRmaXhTdTVnTzdLand3ak1wRjlCMnha?=
 =?utf-8?B?QWt0MlExYWFWMGd5M0FFck1Sa2N4ajYwTjUzNHdPUmVvREwrVmNaNmFseHJ5?=
 =?utf-8?B?S0NJYi9KUFlJVU5mZWwySURVSHJvVENQSFhya25WV0VLK2swekx0U1pFcEV5?=
 =?utf-8?B?NC9vVU5seWJTSVVMWkJJcWpCa005cDRKZU1aRjZTVE5BTjMxS2NMNUYrNHVZ?=
 =?utf-8?B?OGRkQ3dGek1BUEYwYk9zMU1aN0J2WVQ5b2VHdkg0NUY4Y2ZYenJBSlZJbzM1?=
 =?utf-8?B?TlNRK3pYUmNvWDZpVnZKNUpZQjNoRnVkSUVQd2ZnU1FBcE9ranZ1NVVCL1px?=
 =?utf-8?B?SjhwR1UzMTBVNEN4UnlzMnRZSVBHYmhSV0hxa2xpV3ArYlBXRUhkbmdQZ2JB?=
 =?utf-8?B?NUdlNzVXNmJhRVF2eXRRdWZTc254cjA5cFNkcm1vWkR6ekVvSFlybjdzWGZ2?=
 =?utf-8?B?c1JBRThxR1NjNTk1cG8vbW1lS1pncFVJU0JNQW9aOGM5bkw2cmlnZGVoT2I4?=
 =?utf-8?B?d04xTmwzb1RCcDdPSk1FRVhoYmZUNnkxYzQ0MitUMW5XZi96S2hhWGYyWC9a?=
 =?utf-8?B?S3gzdUt4cmhiVGh1NG9rVktjWmdwU29zdGhsbGJuVWxuTjVzOVRJQ0FIdjdq?=
 =?utf-8?B?aVhRK21BYU9wR05TNU9rNDd1NS9rMlFTRlk0M01yanA0SUhtbUo2RzdjVjRM?=
 =?utf-8?B?VGhKTkxlWUc1dTR6dUpyK0ZvMEJxbm16N25uSDM0QnU5b3R3RE43UWt2Zmkz?=
 =?utf-8?B?ZG9JaW5NQTJ1V1VNbnp2cDd4cmIzblJ5S3JLUjNyeUZlcFhQS0N4U3FNUUxs?=
 =?utf-8?B?c0lNQlJPcW05aThsL2pwMWxneHY3WXVIVWRFeUhHWCtFdFJvLzIrL0U2b3V5?=
 =?utf-8?B?akZOd2JFcmhuS3NBdXNvQW8rdndpRldFQ1FaV2dtSi9IYUxBQXgwdFZSSHkr?=
 =?utf-8?B?eGc3Zkx2bmc3RDQ2Nm1sZlRRZlQxK3NhVHJ0OXplbGIrRDllZ1BHRzlMWFZx?=
 =?utf-8?B?aXdRUmtVUzd5VEMzdi9xR01zRFNmbkNDamt1d0Y1MlZuR2hKemFPWFFmaW1C?=
 =?utf-8?B?ZklmZnRzU0NEMzBudm5KcnpvWDdTVUdib0R2T2FLWmdDMU5pMTdoeExKcUtv?=
 =?utf-8?Q?268NdWPJWZKXNEuR3qskNoJ+b?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8848dc-1266-4755-f88c-08da54fdfb9b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 09:51:45.2670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfyGMPdbQf6yUA21JLyChEz8CUhNOkUHAdwAj+tMT8bbiLPYqpg/a/YCfUHQMWMIIFca3xzuLDMNdgF2DQuT4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6324
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.2022 11:46, Juergen Gross wrote:
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -1183,15 +1183,19 @@ static void __init xen_domu_set_legacy_features(void)
>  extern void early_xen_iret_patch(void);
>  
>  /* First C function to be called on Xen boot */
> -asmlinkage __visible void __init xen_start_kernel(void)
> +asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
>  {
>  	struct physdev_set_iopl set_iopl;
>  	unsigned long initrd_start = 0;
>  	int rc;
>  
> -	if (!xen_start_info)
> +	if (!si)
>  		return;
>  
> +	clear_bss();

As per subsequent observation, this shouldn't really be needed: The
hypervisor (or tool stack for DomU-s) already does so. While I guess
we want to keep it to be on the safe side, maybe worth a comment?

Jan
