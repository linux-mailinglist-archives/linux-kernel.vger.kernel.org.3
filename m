Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B34FBDF1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346814AbiDKOAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiDKOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:00:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735B321AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHsQXiOjcsFRRPSgqhGFyyDR08Y2VBLvzdhGxUlHGno2Wv8esT5Ts6hGo/C3C3MsEfFOFq8YnbuE1uJYgY4/bWzj8FFFeUI2JVVGsAyAY9xUvZ+a/5xqsLjFqQiVukmhpQm9LYTRHRts1Q3N3OxmMfERUor1A8M9+WzwOITC2TWjU8nqa8QKH5LzjGd3eFMBhjWmWbpCyX6fJDQrPrYnS2VvLY3w3RhlyzmU+DsiiRuqL0TFvT2lOUM9jNQuo66InMhnKcIgPkEI9wbakzgLy3YY1VnjU0spiSiIqz50aj5ugRQ329XjGqdPOg1rWUafE5OND9dRCh36D8xVLrSzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwGIrERlnIpNzNj6tYzUee+qRJCjKg+AW2C628zKikY=;
 b=bttFQqW1tNl9PhTEt4hjhYJVyjFXsblAnVEuu8mobw77Gj/zJo9OnscsI6FcOiEpl3tOoxuC+li5DRdnBRiTEtWhUZJtrJVuAWdQAz10bz8ta/n59ujHlYM7hRI9zDc9R219PaimvZP0xb+uV1s4Q/jWNpT4054JrtNtWhX9tHbMha4jQt5jUQsKI0zeojC8vGaH2AObgnNgxeM+U7rD3QYGFReeJQzCcCVj5xSQQ4eLExLBXV5Jk1YDuK9sfvr071AX6kgIailTirCvXDGDZF6pUjhnsXdKCvjAOg7wh4m4su84nYjA8IhXpHt73YxDv9rNeLiTb8yLFyy7FmuGYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwGIrERlnIpNzNj6tYzUee+qRJCjKg+AW2C628zKikY=;
 b=Np31Tl/ALzH7kiXQDXpyuqAvZpncuG8EQn6g7jXYh2y1LH8TDdEqVXNidWGbdBkaHUdomG0TEg/bZQRRorD3aVKHgFCiEBh1T+KlnHxJsoGZS09AENpOoUm0EZVQCKRfg9gwhfymn7VWCRjlcyrflNR+vj7eqjKpwdU7h0FcWM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 13:58:07 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::d957:4025:eebd:5107]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::d957:4025:eebd:5107%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 13:58:07 +0000
Message-ID: <860537a5-5fab-602d-1e00-a84903084383@amd.com>
Date:   Mon, 11 Apr 2022 08:58:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     brijesh.singh@amd.com, bp@suse.de
Subject: Re: [PATCH -next] virt: sevguest: Fix return value check in
 alloc_shared_pages()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
References: <20220411111213.1477853-1-yangyingliang@huawei.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <20220411111213.1477853-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:610:4c::21) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ca867ea-9b81-44b8-62cd-08da1bc34e4b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4039:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB403915429452494A4AD94236E5EA9@CH2PR12MB4039.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAEu4Fgr8cUJd6/Q7Bvy0VVgLGPKhh8MODQBOSTfp20uGTyi73ud4oEIk+rRzUFDXxakyahxeLHfVWd9lCtEFTl11RkAD1+Wazmk9oQuq/pLTwhCOLjrDLXs4Tjne0y2uiBIIJa7QQnh/LBfI3Km9/9Vygbz0AikQEUKBFEKFjNxMEvmN+1gzO3nliZTM5ytdw0P5zDRXdaDiTKO8dOpvO2WTds0daMUqX4F/1FZxxi2RG+1yaruu9F4Vg2T/jBDy6Dc8xHfIguu5RwXflJjpZf+Eurp8M8ahuFnEMLhXnXhmZCn73vObCkq3fHj17FUV457nJQatmfqVue4dMvBH45LJqKnYMYuU+J8h4ghgHOJHL5N4fz1J+mboAW5I8djR7JpBCsbRxvfnPpGrw9aPASiG7CuSagioQVIXxq9MHItDJMRsVqLQdeFflbSyTiZsafBZbXibPpZ+zippdFmA/2FB2n5OsE322SYM+l3lCLxnz2UwvC4ruem8e2WFS5Omt6CaOCuLAmqOYYqjiyOIVv40j1YAPwHTBdAA6pJsF0CeAC5euXBNeItTSxRt9ZXGaudctBPdXT/GJCKf8spLnTwceFygIFSlQ8wvt9JGjeNh3xPoio9pMdW4GxYJhSK1xhODstiDPQxR3sdTkW/Fbgd+0uQru8MdxKROJj7YhGipntn1p7SoxfwmsKKFdr7BDshWpYmB7mIA3bf/FAvd3jxoEKZXmNHGt/zfpbk2mU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(38100700002)(6486002)(8676002)(86362001)(66946007)(2616005)(508600001)(8936002)(66476007)(66556008)(316002)(53546011)(6666004)(2906002)(6506007)(4744005)(6512007)(44832011)(26005)(31696002)(186003)(5660300002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk1mbDVDek1ySHNsVmRJeWh1WEUrMzIrbzc1cTdSd0FVMUUxWmNzcDVjV3ZX?=
 =?utf-8?B?UGlodjcrVWFGcUZpR01oZi93SzBnbzVNV0l2Uzgwc3lvMXZNeGJwRXV6U3p6?=
 =?utf-8?B?d3puN3FxL05sVjREYTJrU0VCb1NWWHhBTFF6eG81T1ZzSnhBTUszd1I5MnY2?=
 =?utf-8?B?Mkt2c1MwK0tPeE1EWjIrSUF5anJZWWloRUgxaC8yNnVNTmRZU0t4eGRqd2w0?=
 =?utf-8?B?VjZHVGh1MzhjNHhvN3RPZ3dXU2p1WXo3ZlNWbzVPb0daV1RPbmtYUkdXcld6?=
 =?utf-8?B?WlQyRWdGdkRnMnhYcGV3ZzcrYm83T3hJZ08yb2tzQWRVS2xsOWhMUjR3VURJ?=
 =?utf-8?B?TlgrYnFlWTUrVUs2RW9vK0VLc0dqZjVka0pnQk02OHE1am8weTc2dWlkWnln?=
 =?utf-8?B?MzlGcVZSWVpaRnpuR2xQenNvOVJTTEozN0YybVBCN2h0cGFQRjFXNEU1Q0ZJ?=
 =?utf-8?B?ZTEvTUYrdFo0NjhPVitDOFhHdTF6akJnVFlPV2xIK0RQNEN3SXM0aTdqTVk3?=
 =?utf-8?B?Q0plTGtsT1NreE9nYUx3Qk1RZ2NDQ2phdmsvbWZUdzZuQjJhK1lpelNkMzhs?=
 =?utf-8?B?T0laV083elp5cCtBQUJoZVF5ZlZFVkdYYWFTWEU3VFYvbzdYRE9hY3dCR2Mx?=
 =?utf-8?B?SXJMY0p1R1Y2dHhZc05xb1Z3cUhObnMvWENOVWF0WTg1YjRDYm9ZejI3U3RF?=
 =?utf-8?B?YUQ5S0cyUkNCTSt5Q3o2MFFBcUxQRkpJVXpBY0NDeGU3Qlp4aEFCWm43VjZQ?=
 =?utf-8?B?M2pGQ0RSbzkwYk1iZ2RVQ1NTcE9PQ3F5UVgzU1R4VmFPc293UGd0b1ByRXpP?=
 =?utf-8?B?TURVOWQ0enUrSHNiSitsaktvcEQ5UnBWRzljS1VUOGExdTJ6WXlEemtIQjhM?=
 =?utf-8?B?eVEzajk5RFVCa3JsclVESjlSMTFQWHp2NXZjUkRVV0Z0VW9IVXRhRGZpMDZI?=
 =?utf-8?B?NzlsOVZvUS9EQmtET3ByVU04dUVaNGNiRTh2YlNyUUx1ZDBJd2VtV2xiQncr?=
 =?utf-8?B?SXRuWGFZcGZMcXFMM1ZJS3BXM29SNy9xd2oyN2xra1Z3Uzk2NktpTEtDY3Ar?=
 =?utf-8?B?QkRPbW55ODlvQ3RkZE1Oa3MxQUJLbkdSRUNISDNDTHYzUGpuam5ocVRyTjdn?=
 =?utf-8?B?c2pSQ3EyU0x0VnJWci9hbXhwWnJEMVl4SGRPcHQ2ZXBqajFFdVVTck4zMExq?=
 =?utf-8?B?L3ZXZEZmTGJJcDNUZEpkTWozR1FOUXlYcDc1WVhhVStNYXRRN3REUGRrcitO?=
 =?utf-8?B?MS9VeTBhYlFpUUQ1aWNwQU9JNHlsSHRkL1RSWS83WmRObFdEMFVsc3VPeGM1?=
 =?utf-8?B?SGpvM0FVL0g5b2RXNk1XVjh3UzhTUmoxMjJ4ZEd5Q2t1V1MrNnJ0aUg4cTFi?=
 =?utf-8?B?ekNyNFZZZkpKMDF3MDhlUklUbEEveWI3TFpFZnRTeDdNTkE3NENoc2VBNTl3?=
 =?utf-8?B?THo3eTBUclVkYllLcVlrVE5NRlI1dXFBRXVXZzlVRHl6bGVDL0ZnOExBb1A4?=
 =?utf-8?B?dWdqWnhMb0tnVUJGZ1pxY0QwbHh4U0hVdCtkeUNGMWxzNlBlVDB4V29HQ01H?=
 =?utf-8?B?NkIxNDZhNk9sSXBwU1R0SXR4ajJtbDN4bkxrY2M1bll1SC9jWU9BRWgzcDJV?=
 =?utf-8?B?NmJkT3BWTG5HaVQxUjF6b2dLcGlkNmZuNXUxTm01Wm1TZk1WVDFadzVMaU1l?=
 =?utf-8?B?djlYWmczYlZNRkxBN1lwc0RUbnozRUVVWGtVTEtjZFlaelFGdERzbVFVRHVO?=
 =?utf-8?B?NkExUE0zcTV3UWVUeFd2dzRZRTVzUFFRZjhhNkpNdURBLzArU1BRNWxuQlVY?=
 =?utf-8?B?ZXFmMkJKQzBUMUpyTDRKS3BQWisyNVhTVFBvZnB5ZFNqT1dpMkpWQzdsdnp0?=
 =?utf-8?B?R0k3MCtSYkNxM2RQaVRhSzNob2UzczJjcE5tbDU3THltN2hNQW44a3laZmxI?=
 =?utf-8?B?NzZNdWh3R3Q0bTlrejNzZVpGU1cweURkL2dGVklQTG1WMVVJdnFpQnJkOS82?=
 =?utf-8?B?Ly9FSlBIa1ZaelhPTnRhMDlUYmxEamlFUnNzelAzSUZYMW9BY1lDUzVvY29B?=
 =?utf-8?B?OWIyakxsWWIrekkwbWlqbUc0bm04cHNubUt5WVIrRGhUSjkweHpvOWlqZUpC?=
 =?utf-8?B?b0ZSWkV4YlVBMDlWU3BpTHBNVVB0V1NBQkdGOXBPTm1KemZvVXVDZkY5Y3BP?=
 =?utf-8?B?WFkwQWQxcHo5bzl4ZUlaK3Z6ODhGMkNIbmxMOGlzMURtZVYxQTJJOEVBTFR2?=
 =?utf-8?B?Sk5rVDlCanJwWTdwcU5rdVNjdVJlaE83aFk4YUs0V1JKa05leXdueWxodHhU?=
 =?utf-8?B?cXc5UThKVjhGYkpnMG9YdFF6Wkdaa1BwMWxvN1pxejNDZTUxdmFkUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca867ea-9b81-44b8-62cd-08da1bc34e4b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 13:58:07.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13xNj8SSlvfmcuBWuGKCAW9jGtUgGnHdCetpmlWEN4eWwL3rAqB0hceMlJvJJZxg+n7RQQjoff9V5kGYZRJjyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/22 06:12, Yang Yingliang wrote:
> If alloc_pages() fails, it returns NULL pointer, replaces
> IS_ERR() check with NULL pointer check.
> 
> Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>

thanks
