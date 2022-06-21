Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B84552E93
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349216AbiFUJil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348826AbiFUJij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:38:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7582B8;
        Tue, 21 Jun 2022 02:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZVrWbIkuAwJQYLMZvV2Yc2AFUjJlQ1UsHITOVkb9KfPGcminh8kDWPYo/eHpAheFwFoAahcbv3+16CutbPpoHfDTjG9SxM2lv1HFIqXCE+FwXADLlAy++QS30ZJ17Yos7OY6kKmu8sVnvsTYCgvQsI7ri5JFvwRtYktRiCRIz2mZ8LLR0DcVWsEELgHy0X2PZT/Yakixy2LVsz6ZEwZseJLwFnP0M0+LdcA1lZiBENsIUsozvTbpG3yi88GBU/TY3N9NLY9z5YoKfu1mCyCF/J6mWMBkwtCkZUj9cy5B8tkm+oZvLvavtakqjm2hoBsMq0AaHg4buZByRxCTBW5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keg1zAO9UQIM9UKhCwtHA+R918NfqpsdRUcaCbZu/pw=;
 b=XnJRLJlE2H0P9mlVX5xGVslg0WV0vs8mlVkPQRbfiLKiLOskqXAxaRhgxrkQP/aSkTsJgr9B/o0PrdErH5A7N+fGMhWKbSw0y7zJahhnDF1VE9NL0DEuMmFiT39yCSJRvYQw3iW7ofEhgcgSzJdKw0FKSou6m9vtOa6H8Jc+TQT1Yv1TR8JPvyk8ax5xaqn7jBKuSMSEnjqppL9c06LAv6FyNg6X3DxM6nMDc+4PLj4OkcOhLnKZbAtqLgrmpUMWA8dyVMLiaNtaccn41RfGgLBegD+xwvLebg9Loj6vY9uApMdLkJIKlTc5J32F5rRA+bvtEmO3mOBapdWf0N3KUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keg1zAO9UQIM9UKhCwtHA+R918NfqpsdRUcaCbZu/pw=;
 b=vkl8ueKA8YrAZw2XiueB4k7Afnyk/3SRWegFqnmYPK8o3Ro/8PGR+MpkUMT2yzaG3iTYu+Stniuw4NnsaSKOisSj0TUAyDMfAaoMNdCQ7emPvCe1/JWXp/2+OYHpMVS3CE2k/M374igYqhX/viEqyL1MeqaGOSb+pfq2VbuYVwgh/CsgOrAjhjSbDuvN/h5J2OgIPi6aa3r12KA+Ujwi99j9xqjdcWD3QyDCKdvUxDbQNcQ+vKc7aETJO6THH688EL2BACPGrUHy078j5/8bE8u/uABd/9dVpiLpRNKAJm5XH3dez1/vyOloiVNR7x1KXz1COmOEUURmIBFO1PyCcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by VE1PR04MB7454.eurprd04.prod.outlook.com
 (2603:10a6:800:1a8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 09:38:35 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5353.022; Tue, 21 Jun
 2022 09:38:35 +0000
Message-ID: <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
Date:   Tue, 21 Jun 2022 11:38:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: PM runtime_error handling missing in many drivers?
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        rafael.j.wysocki@intel.com, jic23@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20220620144231.GA23345@axis.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220620144231.GA23345@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d234e70-9f93-460b-225d-08da5369cff0
X-MS-TrafficTypeDiagnostic: VE1PR04MB7454:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB745498F0F8E982189C2FE6C0C7B39@VE1PR04MB7454.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3n1Sc/i13iV6vgKacmIsVaX5TYqjz8DycNoVlkDfWcZOlD38bB2VBZo+UW6g4iwroRtBU01GmI32q0CQB9J5xkV/y1S7e4bZbo5NvUI5SvGZQchGx0sp2rB9QRjHvQqnkrzbTJNdPj6nkwbILniITUaYV95Fw6x0FTtaOhS5nyyKNJyhDL6XCd+isE/fdaxapiZ1AIeKGw+3eMINFhbuqnBiOOIwvyzWfIPxCtMLdEMCCFv8xXrySavtOXv91Nbt9MQyJvp1yzXXw7yGrlWe9Du4e6bC4qd2Q0ls6LyADO2xhXR5pftliMqnfso25nW0EWfRrMzayqINz/BzLoFC6E3Nsrx9E0R8L1rvJ22fhOP1fvoN2e+U12VsIsUH+jvMDkNXh4REoBuQOKLM6M3PoM/ANBLKcslhP+MBlqn3FR32c+oHMDW6vFy/CtVwI4eBTlJ5lDlONApMF6XbqQGgF4T4QEEE6Beer2l2lzXJrLL1ZR9hRCvLCxkdgY6uaASCujftOjwX+qvbE4WDlNT/oEitNVcYctBc89YOeMmGjCmh37rswNxRWGLorRnIHAzyJWi3ANZYy1mu5UeOWdu+Qtjyo6pEwCKCyhzS47MUbDjT2EcSaav1/IeCJoc586TRXaQLtwFU8nDS/tQ2jIVfjD0O8J9/r55b4KDWB1YGLMVJNucv8k+9lntnrq8jdubYZHlsGG6PPoW64oFfV3sjRxw7r3pd4gppsNxN8yK0sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(346002)(136003)(39860400002)(8936002)(53546011)(478600001)(86362001)(6512007)(83380400001)(6506007)(66476007)(6486002)(38100700002)(66556008)(2906002)(316002)(36756003)(4326008)(8676002)(66946007)(31696002)(186003)(5660300002)(41300700001)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnY5dWFFSHNQT1kvRzJTZ1FMcHFVQ1lSUlFEcU1uQ0xRcTF0ZVFkc095U3JZ?=
 =?utf-8?B?QkZMVTV4a1lUZmQ1ZjlYWTVqbnozZjFjbU1jN2V4ejJVWDBrN0ltOFNsMk40?=
 =?utf-8?B?UlpPUlRHYjl5d0E3Q0xTS3I1a096NU5lLzBzRTQ0S2cyR2t0azdHU0RrWkpX?=
 =?utf-8?B?Uml5VTFEbmdBTThvYnJzcnpSV3JmcXhlY0hGSHNVZ0ZWZVZYeEtETjFVSjZn?=
 =?utf-8?B?UkFLTzNIREFINjMyc2VGY293cWFGWXlFdXg1TDdNOGprbEpYTmJ4UXRwL3Q5?=
 =?utf-8?B?ZXZPSUlpUDVScDZqaUtLR0pJQk5pK0kzRTNCNHJ4M2d0RHB6RURYRmdiT0xy?=
 =?utf-8?B?TEtTd0dRVjRqR2NUcG5yaVRzMS9URHUzSFZEZ0VxYThQR3RUa3VxK050R0pj?=
 =?utf-8?B?VUswdW1uVjJzTmRyWWMvK3NGOWlKZEpvdE5KazVaR0RTcmZhaTJOckRyYit5?=
 =?utf-8?B?aWpESkpuZ1NIN2ExVVMwRklnOElFVi92aTI1TlZNNFh4VXlYVFpNbHZkb2xP?=
 =?utf-8?B?VkVCMVhMaFplWFlENVpldkd1VGlCU28yMHkvSENvRXRRcGt2UnlCV09TblBC?=
 =?utf-8?B?YjQrN1phMHp0cWRNZU9TTjNvSTJBd1N6YkIrZVE1VVp0bnJIeVFoVndTZFRT?=
 =?utf-8?B?WWRSRWVvU0c2T3QyVzNCM0RuNE5paG1oQjRMWFJrcWU1MmdrVEJJd1dWR3Ju?=
 =?utf-8?B?Ykw2RmRBTjRYZUN6bkFMc20zNVQzQWZ4VjFCaFZ4bk1zWWttb1FFS1F4OEhO?=
 =?utf-8?B?ckpLOU5zNUJjbmFRMjA1N3JpT1lFaittWWpWK2RxTTY0akZNTjY5Y05WVDRM?=
 =?utf-8?B?V0wvdEs3eHVSbmZLZVo3b0RQSHhJbW1jTytSblBJclVVQXR0am1oRkxZbCto?=
 =?utf-8?B?Y3B0SDYySVJ3b0NYZktIV292RFhiaWhoSHFla1hRMVFNMVF4cldKS1BlSlVl?=
 =?utf-8?B?QU5QMngwNVV2eVNRRjRPaHF5K1hva3E2SDhFY0J0Q3pFMHhPaitXbnFndFdy?=
 =?utf-8?B?amRKaUtrblhkV2NPVGJ6bnRwZnl4TmIrbSs5b3dMSTFvZEUxcEhOZ2FlUGpG?=
 =?utf-8?B?Vlh6SE96djYrbFNrMklzYi9heERJTEFkdFFIUVZTa1l5WUc1MkxPVzd2RjNn?=
 =?utf-8?B?c2U4ZkJFMWxCaW9NZm5UeE11TVd2U0lGQU9qVHVveGxBK0pNbG5ML0pIb2Rr?=
 =?utf-8?B?ZW9vWUlRcXN3YWF6YUlrWGUwcmk3SXRrNEVvTk02ckFjNEtuMjBNWnF3cStB?=
 =?utf-8?B?YUxEVjRlVmNBWkZNbGxNZFVBamFhL0xHZWROK2ZiVnc0VWNTbGRmQnZ3YWF2?=
 =?utf-8?B?ZHJHcjAwNHp2dmE4amcvNHhCdWhLVTNLbTVvUUNrdFptbW15UGtXdk5ESVM3?=
 =?utf-8?B?NjZRcmNlT1RBVFFiS3VNYmpZUFBBTmxZVnhUbldUaXBYVUt6SXlTSUN1YzJr?=
 =?utf-8?B?d0dkK3NZQkhoVTFJcWN6aURPY0UxVGhCemVYN28rRmdDamhpZlhGMkwxUThh?=
 =?utf-8?B?Nmxpbm9uLzFGWW9DajEzSVhjLzMybi9OZWRBeHVIMldJeUF3K205OWZDV1U0?=
 =?utf-8?B?MlpnZ3VOMFhHUlFtT3A5UnpZMlJaek5zejhmczNZM3hCTkU2UWU0QmUwQ1Bx?=
 =?utf-8?B?UDJ1NWtwTjlud0doVDNON0JWNnpER2tuTEk5dXQxQTZjQ21pZ3UxSnpBSlBy?=
 =?utf-8?B?SEljbHkvbVpCN0Znei85aTRWb21MdFp2OW1TVlFzMWVQc05XZE94dTZGZXJz?=
 =?utf-8?B?NnpkVmhJdjBWdXNEQi96cjBSTDR5Q1NoTnVjRDE0aW9JZ2hmN3RwT25KOUxq?=
 =?utf-8?B?c2x4NGxjQ3JxSWpDTTVrdk5COGVrUXp0MitkMVdBcmp3Qzc0S3U3enRLZXhC?=
 =?utf-8?B?QktxQVppK1FlQ3FxQU41MVFVdnlXMHNSNmdNVlpGck52eEJXSmVCbzMwVGt2?=
 =?utf-8?B?U3A0U1hvT0w1bXE4UDZhUGZMRitYVmU2bEpNdWNZZ1Z6WHh3amQwa1Q3dkFx?=
 =?utf-8?B?NlpXWVdWczdNdFY5cFFYMkg2RFJMa0pvbXR6UmVpTVlTc1BwdVd2R3RGOWlF?=
 =?utf-8?B?bC9nSlJzZjkzWGhwanRlMTVzN1BjeFV6cmxiMEk3UVFKcXQrNEo2OWtXbVlV?=
 =?utf-8?B?QXRBczFrUWc0c1doUSt6K2ZnN00xMTVNc3hSandLaytiOVE4YndidWtsc2lx?=
 =?utf-8?B?WXFoVitnekRTSklnMUxCMVgyUy9rNTd1UndtYkxQUUJOS1l1cGtBSzkySlBG?=
 =?utf-8?B?QnhJSks5ZFlaRFhTTlVxRStER29QYUZ3RnRCbzllTkNVa1JDUy9ybER5bGpG?=
 =?utf-8?B?SjdERTZpRnRrNGhmOGJtVGRFS2dSYTN4R2ZPaUlyRUxoTDlqUWFaVlRJSm9p?=
 =?utf-8?Q?zYLfN7mw6Y7W6MR3MJg9vyfRI1tU4yPTzQWNofWxxQYAJ?=
X-MS-Exchange-AntiSpam-MessageData-1: 15pw6wToXESthw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d234e70-9f93-460b-225d-08da5369cff0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 09:38:35.3357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9e2QM2Pj16VhJ4iEbWr1UT8xyUo1xfY7RXvt7mdcuCSQjj2afZt+iG+hbzKfPFVYGY3QoHfMQkm7B/l3TGbHSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.22 16:42, Vincent Whitchurch wrote:

Hi,

> Many drivers do something like the following to resume their hardware
> before performing some hardware access when user space ask for it:
> 
> 	ret = pm_runtime_resume_and_get(dev);
> 	if (ret)
> 		return ret;
> 
> But if the ->runtime_resume() callback fails, then the
> power.runtime_error is set and any further attempts to use
> pm_runtime_resume_and_get() will fail, as documented in
> Documentation/power/runtime_pm.rst.

Whether this is properly documented is debatable.
4. Runtime PM Device Helper Functions (as a chapter)
does _not_ document it.


> [110778.050000][   T27] rpm_resume: 0-0009 flags-4 cnt-1  dep-0  auto-1 p-0 irq-0 child-0
> [110778.050000][   T27] rpm_return_int: rpm_resume+0x24d/0x11d0:0-0009 ret=-22
> 
> The following patch fixes the issue on vcnl4000, but is this the right in the


> fix?  And, unless I'm missing something, there are dozens of drivers
> with the same problem.

Yes. The point of pm_runtime_resume_and_get() is to remove the need
for handling errors when the resume fails. So I fail to see why a
permanent record of a failure makes sense for this API.

> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index e02e92bc2928..082b8969fe2f 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -414,6 +414,8 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
>  
>  	if (on) {
>  		ret = pm_runtime_resume_and_get(dev);
> +		if (ret)
> +			pm_runtime_set_suspended(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
>  		ret = pm_runtime_put_autosuspend(dev);

If you need to add this to every driver, you can just as well add it to
pm_runtime_resume_and_get() to avoid the duplication.

But I am afraid we need to ask a deeper question. Is there a point
in recording failures to resume? The error code is reported back.
If a driver wishes to act upon it, it can. The core really only
uses the result to block new PM operations.
But nobody requests a resume unless it is necessary. Thus I fail
to see the point of checking this flag in resume as opposed to
suspend. If we fail, we fail, why not retry? It seems to me that the
record should be used only during runtime suspend.

And as an immediate band aid, some errors like ENOMEM should
never be recorded.

	Regards
		Oliver
