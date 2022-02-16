Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049434B8CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbiBPPmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:42:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiBPPmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:42:38 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2134.outbound.protection.outlook.com [40.107.92.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F492A2500;
        Wed, 16 Feb 2022 07:42:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAU4rSJdOLXB1kjBKmGS7zSEF3fjmz7LwYWhQ4T70TvjNYDfDg4T88jn6IngOPEXvYS2gHGaFzxOi1l9S5ZBN4aafYb92LwkH1NEu8jBypP3gRfs4ZIifY7hYEtLkth5GbSFy33K1G720KVgN5+5lBzW0xOtYoABS2a0jVwOb5h9ZxqgIKgZ20yxBhqohsqRFpgGVCNm7tzlLltIAgMvkLrUfIpNDShja8/k8sxXJ2UcRIQlUimhyUTv35DN09QxtQ+CIIsNhzfjHFp2VIfcaF6FManlNASeryAt0KpIy+hCgIKwvEbd/INBdfvHvqzU2pWVA4upwG9+PI2ej/GAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGi2Q5ITQwr+OGb8Z0RSvVJeYy454NBfKccsMDqx8Vk=;
 b=LqOCOsg5+OnNTSoYaSR/Zw3VfnxShoNTWCbWfxXOvDx/TdRDfRZoFAzYfzkR4BV+X8uIhheoKW/HPCjdkqM6STBWHF3Dd8GSWVhNTNpgQvRNz85Lj3IDXkSEKiwLbc1o8ogJ6AV3XhpG472ie8ZdqIFvhsNfJONp8ykz/eK18Nyu57qPhuw/QAKLWLtLYkQ5GVCfhJiMg8TI5KWzyHlybRbf9BMg3Sus98wmh/2Drvy9F9jEa+0sHYemmObKNmISDTqym4ASMf9rR/NLPATZCnuIhgLcOUSek1442p23Q2BndQ3zhr1bz6JZHJWQ6uc4lT4rJ0alzol3ExVhBUslMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGi2Q5ITQwr+OGb8Z0RSvVJeYy454NBfKccsMDqx8Vk=;
 b=Phiri6onr48mJDctu8ba1CD3HdrGViBrbLB+zcP/oVPIEnbaw2OtVCx4DN6earAe2aODKsigcogEzgceoKFHbZVelbYoWuJ5SsKF0yLgQaXwQjAcDvF36fbhzv2Eta8hF9PADGZk+vMW+0FY3N782aT8Q5bd1asK8j7yyIJhcEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by MWHPR10MB2016.namprd10.prod.outlook.com
 (2603:10b6:300:10e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 15:42:21 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5%6]) with mapi id 15.20.4975.012; Wed, 16 Feb 2022
 15:42:21 +0000
Date:   Wed, 16 Feb 2022 07:42:02 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: ocelot: fix duplicate debugfs entry
Message-ID: <20220216154202.GB14638@MSI.localdomain>
References: <20220216122727.1005041-1-michael@walle.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216122727.1005041-1-michael@walle.cc>
X-ClientProxiedBy: MWHPR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:301:15::22) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd910efc-c6fd-4963-4944-08d9f162ebc5
X-MS-TrafficTypeDiagnostic: MWHPR10MB2016:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB2016E957464F336BDD49D657A4359@MWHPR10MB2016.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfjalGQVKlrYMlBwnluk0NguzLiHvWbMreqvAVGJPozYJb6xZ2W4BwPhXW42Idw6KZaQb6FPP1D8N6MqYcFyL1WYNXRtRSKnt+a/mdBCrPYaZ4PmRMaYDCMLWxGi6y9Y5u8bYRJRhL7emaU6M8MIy7jWYJNpJa6kguJ8KNF+NfkpZ6fG6uKgOLSZrsB1YRK+XGiGYPzHYKUhGTr64uK9TnccPGxC6mymYoBth/d2IOeGCeojFv1RgeVu/5dvq/EwTfAsyzu351oSfIU/p6SPQJYj+/3+TE0BJhK6KTtX2Wo9P9lhx+1Hswh9UZsGmuXUR+RD1+g+4KtIvYSdca4siN6SpprV/T3XdbkNG7X6H1SvIvqVhyPmwMluJy24JRrACI5JhGWLZgvkVJ/M+Rk6YdaykzMSAJ8Qm8YU10NtJbvvTD8kVip33wTSlTtZUEkeZquMNcsgtRslZyzD5ETXweE+ICTssKDLTYiVirkc+nhUNhwqMipctVjUPU5qJKhD+0ZBcgGDoKZfnEV6Pgp3HcxP8qYdXUaJ3GRNmciYppoOvQncdXVIZ2lKI6zSo7lq63SCV3q0fII730lKPIxUc+g+9ZsxItKsZmSfs5MhmoFKX2SblZeBQ8M/W9iWhdgfSAzQDhgT5PZLWyYow6EY2tkz1Zw0EO8VeZTgSAIWpf+y70EdAMK6o4rJ1xnNf9/14d2ZQC3F4TJ0v04sSyaGtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(39830400003)(376002)(136003)(346002)(366004)(42606007)(6916009)(66476007)(5660300002)(8936002)(316002)(66556008)(44832011)(86362001)(66946007)(4326008)(8676002)(2906002)(6512007)(9686003)(186003)(26005)(6486002)(1076003)(508600001)(33656002)(38350700002)(38100700002)(6666004)(6506007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3KJTwzBkOsCtYD/t4LiUcplPoTG3uTlhAQZW4bkbzoyOSpVONTd4tpHrNMLh?=
 =?us-ascii?Q?j80PDTs8lZYeA1tnyLs2QIwTNsnTiB7aplqQpEz1H0ipNZ3T7tK4h02sTLT+?=
 =?us-ascii?Q?YyQKHQgeTExOG6lofK/saHUrcyk+kS1vK0UOp/LMxbKIS6bCBMMawx0T4ufS?=
 =?us-ascii?Q?nK1tcW9JOzbGJRQ8elm9SG3SwLFEsVCVdYbuckoel5W9zXUTVi80AFq2Mw3D?=
 =?us-ascii?Q?rn77KfbYIuUZUFtgES9XpfBlyWcJu95YCB8l00kvSZj/Cc1VTRZZX+QkmxZR?=
 =?us-ascii?Q?KYB65HG6i9I6uWaKEgBCdlTrFzONQsclVfekQHLNT5Glq/094o6Cp5H5EYqj?=
 =?us-ascii?Q?se01hMKJCTQrCw4vrTNcJ9qj7UZVEEgUt5e+2Nmfctnnx4dq3csphjcOmqeV?=
 =?us-ascii?Q?qh5sA7n2vTe6dWMpM+bqgjC8Tqt7pHktrOxebx6O5hEFx6YRVxtGRP1u0kT0?=
 =?us-ascii?Q?SHopMe2huebijUVCv761RI03Di6nEFCbVjzbMVqm/zMCbphdL28FjzMPiwQN?=
 =?us-ascii?Q?zTyNioZQU7GGtZJPV6+i8g406eCzMBgpBpdccJfUn6vwNrghTEPyOnhS1OAN?=
 =?us-ascii?Q?X1cKl6cfh+YQ8tk18uuWfWkfi0nUbR+UGpmdYMre85wHxpSponV4sWLqLX8S?=
 =?us-ascii?Q?ikxa5ekzQy/OLQQSLtD20FtyIRDqz0U1L+6zaqVUS/Gor7CB8T3plZcufgXT?=
 =?us-ascii?Q?uIWhbw5u/CkRxYW5ZZklKW85dk/LhvM/yQm5+5mYML5PF0trXrmW59PvuJU7?=
 =?us-ascii?Q?wId8kkHTG0vpso57jRtqkt7br+dsrnwoi8U/HkRUw7JQx4ccl+e4kYnxPIU+?=
 =?us-ascii?Q?qA3LDwtXTPta85n/mU1Xq8LaZOsVeRWMSKX79FyHPFl5QDQxVtRFQM2yejCD?=
 =?us-ascii?Q?mPYhkNIFcCFwRe5f09stfVnp2CFU8i94bps7nf8ck3rHIkjkYP7iw9RTBnol?=
 =?us-ascii?Q?XxWKpfZz8LqD5fwErhcVYCgMIJEjOZ0g5HQ6+THYnA41GH22wW2fop4nWC99?=
 =?us-ascii?Q?Ic+i/C4Att496Tk3msJKOo6lIV4Kap9sA8NdJ5x7ENo1tSv/cVMjODNxdvju?=
 =?us-ascii?Q?uR5Tz/HnYUVvEf1VtAzAEYBozJIJSjjCoZyGCo1tSQ1FL348y1QUTaDsj/ue?=
 =?us-ascii?Q?xsA3vixoru3m+iiTrVkNeQIYTm31eeDT5+1jXnR7drcaC1vR12g5WIUGTS4P?=
 =?us-ascii?Q?bCkpYIvHczA30XPWEiPtZvR3398fRyXYfjpndje6ZBuXdq8ejHupRlPgBCFU?=
 =?us-ascii?Q?G/JP+C3i6lq3fGmvZT8w/vKQIvevLA9ARSar7+eHOIJDB2XPkipCKDuGgAnA?=
 =?us-ascii?Q?LtQ5wF5ZXHlikZ3kHdOUOXjNVa+ozP5BxQnYWGNhLO8+2DWLx/5FXks+afqk?=
 =?us-ascii?Q?STF8gDDz249s0w77+eoGomsAJEo1wEaPGlw/wI2inlLFofT8zww083ZWCZYb?=
 =?us-ascii?Q?jbE2rFUQH/uSNU0QqhzUWhI+rTa/hia2dg+ylXsgUxSX5z19sBYspEKIPsEc?=
 =?us-ascii?Q?wdmjDcjz63EjjyCHcfnkc8RBYn5E2I1bH8shj1qAYkRaz2B6WxHuhGlLCUPT?=
 =?us-ascii?Q?DspXLxuPrcAvF3M2bclirbef72vJhpL8HxdBDNnQY8oVZTMzigyhq5YfFtV4?=
 =?us-ascii?Q?FRYml1IH1nCoWMvxRAQPjh4vm7VZmYSkJvzL8CdGFCusZyQE6q1vhRFpnka1?=
 =?us-ascii?Q?XAwPSg=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd910efc-c6fd-4963-4944-08d9f162ebc5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 15:42:21.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nr68OyhbUW6ed6SPFWrimkvFWXkL89MOjavhjAfifZdQV7fViq76iLHH6JZPJxHypC61VR27Oun3eb/f0XKtE743cR6I7398VYCY6nQfTek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2016
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:27:27PM +0100, Michael Walle wrote:
> This driver can have up to two regmaps. If the second one is registered
> its debugfs entry will have the same name as the first one and the
> following error will be printed:
> 
> [    2.242568] debugfs: Directory 'e2004064.pinctrl' with parent 'regmap' already present!
> 
> Give the second regmap a name to avoid this.
> 
> Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index a859fbcb09af..35b213de1af8 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -1890,6 +1890,7 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
>  		.val_bits = 32,
>  		.reg_stride = 4,
>  		.max_register = 32,
> +		.name = "pincfg",
>  	};
>  
>  	base = devm_platform_ioremap_resource(pdev, 1);
> -- 
> 2.30.2
> 

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>


