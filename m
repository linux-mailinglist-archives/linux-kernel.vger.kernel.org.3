Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891FE510E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357013AbiD0B7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357038AbiD0B7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:59:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB23B2FE55
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:56:37 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kp1zy4BTHz1JBm9;
        Wed, 27 Apr 2022 09:55:42 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 09:56:35 +0800
Subject: Re: [PATCH -next] reboot: Fix build warning without CONFIG_SYSFS
To:     <mcgrof@kernel.org>, <tangmeng@uniontech.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20220407074807.1580-1-yuehaibing@huawei.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <3d54a148-922d-3da4-b564-44996ca56241@huawei.com>
Date:   Wed, 27 Apr 2022 09:56:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20220407074807.1580-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On 2022/4/7 15:48, YueHaibing wrote:
> If CONFIG_SYSFS is n, build warn:
> 
> kernel/reboot.c:443:20: error: ‘kernel_reboot_sysctls_init’ defined but not used [-Werror=unused-function]
>  static void __init kernel_reboot_sysctls_init(void)
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Move kernel_reboot_sysctls_init() to #ifdef block to fix this.
> 
> Fixes: 6e73c8344931 ("kernel/reboot: move reboot sysctls to its own file")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  kernel/reboot.c | 54 ++++++++++++++++++++++++-------------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index ed4e6dfb7d44..ecbf09ea03c5 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -421,33 +421,6 @@ void ctrl_alt_del(void)
>  static char poweroff_cmd[POWEROFF_CMD_PATH_LEN] = "/sbin/poweroff";
>  static const char reboot_cmd[] = "/sbin/reboot";
>  
> -#ifdef CONFIG_SYSCTL
> -static struct ctl_table kern_reboot_table[] = {
> -	{
> -		.procname       = "poweroff_cmd",
> -		.data           = &poweroff_cmd,
> -		.maxlen         = POWEROFF_CMD_PATH_LEN,
> -		.mode           = 0644,
> -		.proc_handler   = proc_dostring,
> -	},
> -	{
> -		.procname       = "ctrl-alt-del",
> -		.data           = &C_A_D,
> -		.maxlen         = sizeof(int),
> -		.mode           = 0644,
> -		.proc_handler   = proc_dointvec,
> -	},
> -	{ }
> -};
> -
> -static void __init kernel_reboot_sysctls_init(void)
> -{
> -	register_sysctl_init("kernel", kern_reboot_table);
> -}
> -#else
> -#define kernel_reboot_sysctls_init() do { } while (0)
> -#endif /* CONFIG_SYSCTL */
> -
>  static int run_cmd(const char *cmd)
>  {
>  	char **argv;
> @@ -895,6 +868,33 @@ static struct attribute *reboot_attrs[] = {
>  	NULL,
>  };
>  
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table kern_reboot_table[] = {
> +	{
> +		.procname       = "poweroff_cmd",
> +		.data           = &poweroff_cmd,
> +		.maxlen         = POWEROFF_CMD_PATH_LEN,
> +		.mode           = 0644,
> +		.proc_handler   = proc_dostring,
> +	},
> +	{
> +		.procname       = "ctrl-alt-del",
> +		.data           = &C_A_D,
> +		.maxlen         = sizeof(int),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dointvec,
> +	},
> +	{ }
> +};
> +
> +static void __init kernel_reboot_sysctls_init(void)
> +{
> +	register_sysctl_init("kernel", kern_reboot_table);
> +}
> +#else
> +#define kernel_reboot_sysctls_init() do { } while (0)
> +#endif /* CONFIG_SYSCTL */
> +
>  static const struct attribute_group reboot_attr_group = {
>  	.attrs = reboot_attrs,
>  };
> 
