Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946EE5A3071
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiHZUZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHZUZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:25:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8F35A2D2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C130B83272
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 20:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BECC433C1;
        Fri, 26 Aug 2022 20:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661545543;
        bh=tAy+gOkwHBeFaHPZNmtZ7L9YF98U7oKwU4QO4vMFqY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XnOjuvFyCfs4ExS2iLDkQ8pvyvjqSpFVfAFzV6oLBdPNdD3schxiJLdFYbP/zQFky
         mS8BFqdGeo5ncLNHw/X8V3fmLcIl8YoLBjrieWBRCDBAwhDQrrJri4TXJuAyPsswMp
         lzPmjuiuanXIGiWPYMTOPJygz8Xsbo6n1ArRo8iOgdfqaU9ZBkUml5KSw+9+52jdfr
         h0Ouy4jhvYiJCK2H0Z01c2Am25gwQBzmXFdES7JQ8VuEJhvI07xDjxvgQLQwvtxry2
         9e3slfK1h7RLi7YFWZonVs9E8D8AlCgc4rkvqxVwJlznNWGHE+gAwDPnSgUKlkgCOE
         XrTQEIopOAZJg==
Date:   Fri, 26 Aug 2022 13:25:41 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/3] mm/zswap: delay the initializaton of zswap
 until the first enablement
Message-ID: <YwksRZPIfXmlOmHR@dev-arch.thelio-3990X>
References: <20220825142037.3214152-1-liushixin2@huawei.com>
 <20220825142037.3214152-3-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825142037.3214152-3-liushixin2@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On Thu, Aug 25, 2022 at 10:20:36PM +0800, Liu Shixin wrote:
> In the initialization of zswap, about 18MB memory will be allocated for
> zswap_pool in my machine. Since not all users use zswap, the memory may be
> wasted. Save the memory for these users by delaying the initialization of
> zswap to first enablement.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  mm/zswap.c | 48 +++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 84e38300f571..90df72aceb08 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -81,6 +81,8 @@ static bool zswap_pool_reached_full;
>  
>  #define ZSWAP_PARAM_UNSET ""
>  
> +static int zswap_setup(void);
> +
>  /* Enable/disable zswap */
>  static bool zswap_enabled = IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
>  static int zswap_enabled_param_set(const char *,
> @@ -220,6 +222,8 @@ static atomic_t zswap_pools_count = ATOMIC_INIT(0);
>  
>  /* init state */
>  static int zswap_init_state;
> +/* used to ensure the integrity of initialization */
> +static DEFINE_MUTEX(zswap_init_lock);
>  
>  /* init completed, but couldn't create the initial pool */
>  static bool zswap_has_pool;
> @@ -273,13 +277,13 @@ static void zswap_update_total_size(void)
>  **********************************/
>  static struct kmem_cache *zswap_entry_cache;
>  
> -static int __init zswap_entry_cache_create(void)
> +static int zswap_entry_cache_create(void)
>  {
>  	zswap_entry_cache = KMEM_CACHE(zswap_entry, 0);
>  	return zswap_entry_cache == NULL;
>  }
>  
> -static void __init zswap_entry_cache_destroy(void)
> +static void zswap_entry_cache_destroy(void)
>  {
>  	kmem_cache_destroy(zswap_entry_cache);
>  }
> @@ -664,7 +668,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  	return NULL;
>  }
>  
> -static __init struct zswap_pool *__zswap_pool_create_fallback(void)
> +static struct zswap_pool *__zswap_pool_create_fallback(void)
>  {
>  	bool has_comp, has_zpool;
>  
> @@ -782,11 +786,17 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>  	if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
>  		return 0;
>  
> -	/* if this is load-time (pre-init) param setting,
> +	/*
> +	 * if zswap has not been initialized,
>  	 * don't create a pool; that's done during init.
>  	 */
> -	if (zswap_init_state == ZSWAP_UNINIT)
> -		return param_set_charp(s, kp);
> +	mutex_lock(&zswap_init_lock);
> +	if (zswap_init_state == ZSWAP_UNINIT) {
> +		ret = param_set_charp(s, kp);
> +		mutex_unlock(&zswap_init_lock);
> +		return ret;
> +	}
> +	mutex_unlock(&zswap_init_lock);
>  
>  	if (!type) {
>  		if (!zpool_has_pool(s)) {
> @@ -876,6 +886,14 @@ static int zswap_zpool_param_set(const char *val,
>  static int zswap_enabled_param_set(const char *val,
>  				   const struct kernel_param *kp)
>  {
> +	if (system_state == SYSTEM_RUNNING) {
> +		mutex_lock(&zswap_init_lock);
> +		if (zswap_setup()) {
> +			mutex_unlock(&zswap_init_lock);
> +			return -ENODEV;
> +		}
> +		mutex_unlock(&zswap_init_lock);
> +	}
>  	if (zswap_init_state == ZSWAP_INIT_FAILED) {
>  		pr_err("can't enable, initialization failed\n");
>  		return -ENODEV;
> @@ -1432,7 +1450,7 @@ static const struct frontswap_ops zswap_frontswap_ops = {
>  
>  static struct dentry *zswap_debugfs_root;
>  
> -static int __init zswap_debugfs_init(void)
> +static int zswap_debugfs_init(void)
>  {
>  	if (!debugfs_initialized())
>  		return -ENODEV;
> @@ -1463,7 +1481,7 @@ static int __init zswap_debugfs_init(void)
>  	return 0;
>  }
>  #else
> -static int __init zswap_debugfs_init(void)
> +static int zswap_debugfs_init(void)
>  {
>  	return 0;
>  }
> @@ -1472,11 +1490,14 @@ static int __init zswap_debugfs_init(void)
>  /*********************************
>  * module init and exit
>  **********************************/
> -static int __init init_zswap(void)
> +static int zswap_setup(void)
>  {
>  	struct zswap_pool *pool;
>  	int ret;
>  
> +	if (zswap_init_state != ZSWAP_UNINIT)
> +		return 0;
> +
>  	if (zswap_entry_cache_create()) {
>  		pr_err("entry cache creation failed\n");
>  		goto cache_fail;
> @@ -1534,6 +1555,15 @@ static int __init init_zswap(void)
>  	zswap_enabled = false;
>  	return -ENOMEM;
>  }
> +
> +static int __init init_zswap(void)
> +{
> +	/* skip init if zswap is disabled when system startup */
> +	if (!zswap_enabled)
> +		return 0;
> +	return zswap_setup();
> +}
> +
>  /* must be late so crypto has time to come up */
>  late_initcall(init_zswap);
>  
> -- 
> 2.25.1
> 
> 

This change is in -next as commit 22100432cf14 ("mm/zswap: delay the
initializaton of zswap until the first enablement"). I just bisected my
arm64 test system running Fedora failing to boot due to that commit,
with the following stack trace:

  Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
  Mem abort info:
    ESR = 0x0000000096000004
    EC = 0x25: DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x04: level 0 translation fault
  Data abort info:
    ISV = 0, ISS = 0x00000004
    CM = 0, WnR = 0
  user pgtable: 4k pages, 48-bit VAs, pgdp=00000020a4fab000
  [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
  Internal error: Oops: 96000004 [#1] SMP
  Modules linked in: zram fsl_dpaa2_eth pcs_lynx phylink ahci_qoriq crct10dif_ce ghash_ce sbsa_gwdt fsl_mc_dpio nvme lm90 nvme_core at803x xhci_plat_hcd rtc_fsl_ftm_alarm xgmac_mdio ahci_platform i2c_imx ip6_tables ip_tables fuse
  Unloaded tainted modules: cppc_cpufreq():1
  CPU: 10 PID: 761 Comm: swapon Not tainted 6.0.0-rc2-00454-g22100432cf14 #1
  Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIOS EDK II Jun 21 2022
  pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : frontswap_init+0x38/0x60
  lr : __do_sys_swapon+0x8a8/0x9f4
  sp : ffff80000969bcf0
  x29: ffff80000969bcf0 x28: ffff37bee0d8fc00 x27: ffff80000a7f5000
  x26: fffffcdefb971e80 x25: ffffaba797453b90 x24: 0000000000000064
  x23: ffff37c1f209d1a8 x22: ffff37bee880e000 x21: ffffaba797748560
  x20: ffff37bee0d8fce4 x19: ffffaba797748488 x18: 0000000000000014
  x17: 0000000030ec029a x16: ffffaba795a479b0 x15: 0000000000000000
  x14: 0000000000000000 x13: 0000000000000030 x12: 0000000000000001
  x11: ffff37c63c0aba18 x10: 0000000000000000 x9 : ffffaba7956b8c88
  x8 : ffff80000969bcd0 x7 : 0000000000000000 x6 : 0000000000000000
  x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffffaba79730f000
  x2 : ffff37bee0d8fc00 x1 : 0000000000000000 x0 : 0000000000000000
  Call trace:
  frontswap_init+0x38/0x60
  __do_sys_swapon+0x8a8/0x9f4
  __arm64_sys_swapon+0x28/0x3c
  invoke_syscall+0x78/0x100
  el0_svc_common.constprop.0+0xd4/0xf4
  do_el0_svc+0x38/0x4c
  el0_svc+0x34/0x10c
  el0t_64_sync_handler+0x11c/0x150
  el0t_64_sync+0x190/0x194
  Code: d000e283 910003fd f9006c41 f946d461 (f9400021)
  ---[ end trace 0000000000000000 ]---

This is with Fedora's configuration:

https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-aarch64-fedora.config

If there is any more information I can provide or patches I can test, I
am more than happy to do so!

Cheers,
Nathan
