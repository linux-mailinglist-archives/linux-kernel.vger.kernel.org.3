Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A074E3289
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiCUWIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiCUWIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:08:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58EE3FCCE8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 14:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=roFmIy7ERbZhzCdoKPTNzJ04IPexvyGINPkBzgIr3yI=; b=R5o7PYoxgNC067hILjqK+/dz9x
        6uL2vy8NfYNYqZLoYMbNS+EHz5nPJE5bk7D25QQjeW3WxYYSx86VOIRrPQ8b8Syse84r6KOTissD4
        yjbAqu+w3nW1Lnam0BCg5VVUKNb7yI7yesp9xtp8iNjBl2tUWoYoD/J5HjKH3OTrkb8wKU2jm6n69
        SXHWoqLSnQL/7tJmRC9I4SYEuMlZWekh+z12ONXpvusPF1sT1fl9tIkr2l6eAllnU7nC9mSVaX/iU
        Eloy61/03ss+UQXnBOsrZAgvemxmHYt+arYILd+7T6kMlWn+oKf8VXis+wOWfNXXzpWHm+l4VqzsD
        swVbh2jA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWPzM-003G0Q-Em; Mon, 21 Mar 2022 21:54:56 +0000
Message-ID: <11533b46-70ec-6dde-fd18-af44cc36b1ab@infradead.org>
Date:   Mon, 21 Mar 2022 14:54:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] macintosh/via-pmu: Avoid compiler warnings when
 CONFIG_PROC_FS is disabled
Content-Language: en-US
To:     Finn Thain <fthain@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <0c11c0770fc4ec7e80a4b2e0ffce1055b792cfdb.1647854880.git.fthain@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <0c11c0770fc4ec7e80a4b2e0ffce1055b792cfdb.1647854880.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/22 02:28, Finn Thain wrote:
> drivers/macintosh/via-pmu.c:897:12: warning: 'pmu_battery_proc_show' defined but not used [-Wunused-function]
>  static int pmu_battery_proc_show(struct seq_file *m, void *v)
>             ^~~~~~~~~~~~~~~~~~~~~
> drivers/macintosh/via-pmu.c:871:12: warning: 'pmu_irqstats_proc_show' defined but not used [-Wunused-function]
>  static int pmu_irqstats_proc_show(struct seq_file *m, void *v)
>             ^~~~~~~~~~~~~~~~~~~~~~
> drivers/macintosh/via-pmu.c:860:12: warning: 'pmu_info_proc_show' defined but not used [-Wunused-function]
>  static int pmu_info_proc_show(struct seq_file *m, void *v)
>             ^~~~~~~~~~~~~~~~~~
> 
> Add some #ifdefs to avoid unused code warnings when CONFIG_PROC_FS is
> disabled.
> 
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changed since v1:
>  - Simplified to take advantage of the fact that proc_mkdir() is stubbed
>    out when CONFIG_PROC_FS=n. Hence that call doesn't need to move
>    within the #ifdef.
> ---
>  drivers/macintosh/via-pmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
> index 2109129ea1bb..495fd35b11de 100644
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -204,9 +204,11 @@ static int init_pmu(void);
>  static void pmu_start(void);
>  static irqreturn_t via_pmu_interrupt(int irq, void *arg);
>  static irqreturn_t gpio1_interrupt(int irq, void *arg);
> +#ifdef CONFIG_PROC_FS
>  static int pmu_info_proc_show(struct seq_file *m, void *v);
>  static int pmu_irqstats_proc_show(struct seq_file *m, void *v);
>  static int pmu_battery_proc_show(struct seq_file *m, void *v);
> +#endif
>  static void pmu_pass_intr(unsigned char *data, int len);
>  static const struct proc_ops pmu_options_proc_ops;
>  
> @@ -857,6 +859,7 @@ query_battery_state(void)
>  			2, PMU_SMART_BATTERY_STATE, pmu_cur_battery+1);
>  }
>  
> +#ifdef CONFIG_PROC_FS
>  static int pmu_info_proc_show(struct seq_file *m, void *v)
>  {
>  	seq_printf(m, "PMU driver version     : %d\n", PMU_DRIVER_VERSION);
> @@ -977,6 +980,7 @@ static const struct proc_ops pmu_options_proc_ops = {
>  	.proc_release	= single_release,
>  	.proc_write	= pmu_options_proc_write,
>  };
> +#endif
>  
>  #ifdef CONFIG_ADB
>  /* Send an ADB command */

-- 
~Randy
