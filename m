Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79DD50EF73
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243624AbiDZEDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiDZEDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:03:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F06EBEF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B0FCB81C0C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108D0C385A0;
        Tue, 26 Apr 2022 04:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650945624;
        bh=828e55cJ0x+hMzKxwt0jf5R21C6RftD+9htwpVQTfHM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RcbDU3RJBTMdReCZe/1wagD7MFC7QiT3Nv95zp69NLC9hmECGzS25Abgnz6MFrMQY
         BRHYi8dltlZ4uTQ84QkHfYZC7dFoBgnA9irn6s8+3IUmEAa6tCHy+oJcv1BpX2OANG
         JrvPCz0UP0kbjnbU9L2alOVL6MQL2Nzf2e5f+BnNxOm5UsgSXuPO8b9xWSJbnBP2MR
         Pk+wtf4uCFA7RMcBWdU9BYSfhIiUcBIGXVzpQnaMnD1c8remZIBw54AJ9ku0Ka9CrU
         R7YLEVrs8Cp2NtxUOc6y6ZkCdqDLXOnlm7zt7W0fHpxgGiRYxnFCMLJdw4fbVvek48
         V7YqdjRzN/nSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9A9F45C042D; Mon, 25 Apr 2022 21:00:23 -0700 (PDT)
Date:   Mon, 25 Apr 2022 21:00:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2022.04.18b] BUILD REGRESSION
 ad68d8bf085421e4f22731c8b64c0b774a154e06
Message-ID: <20220426040023.GZ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <62676af1.i7L+J5fhS2CqZy/O%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62676af1.i7L+J5fhS2CqZy/O%lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:45:53AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.04.18b
> branch HEAD: ad68d8bf085421e4f22731c8b64c0b774a154e06  rcu/nocb: Add an option to offload all CPUs on boot
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/lkml/202204202111.gA58hkDX-lkp@intel.com
> https://lore.kernel.org/llvm/202204201732.oTzYh0Xo-lkp@intel.com
> https://lore.kernel.org/llvm/202204202254.kr5zvuSL-lkp@intel.com
> 
> Error/Warning: (recently discovered and may have been fixed)

The alleged fix is in this recently added updated commit that replaces
the commit called out above:

42942fb3cad5 ("rcu/nocb: Add an option to offload all CPUs on boot")

> include/linux/cpumask.h:276:9: error: expected identifier or '(' before 'for'
> include/linux/cpumask.h:277:25: error: initializer element is not constant
> include/linux/cpumask.h:278:23: error: expected '=', ',', ';', 'asm' or '__attribute__' before '<' token
> include/linux/cpumask.h:278:36: error: expected identifier or '(' before ')' token
> kernel/rcu/tree_nocb.h:1213:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
> kernel/rcu/tree_nocb.h:1217:9: error: expected identifier or '(' before 'if'
> kernel/rcu/tree_nocb.h:1245:9: error: expected identifier or '(' before 'else'
> kernel/rcu/tree_nocb.h:1251:22: error: type defaults to 'int' in declaration of 'cpu' [-Werror=implicit-int]
> kernel/rcu/tree_nocb.h:1259:9: error: conflicting types for 'rcu_organize_nocb_kthreads'; have 'int()'
> kernel/rcu/tree_nocb.h:1259:9: error: function declaration isn't a prototype [-Werror=strict-prototypes]
> kernel/rcu/tree_nocb.h:1259:9: error: type defaults to 'int' in declaration of 'rcu_organize_nocb_kthreads' [-Werror=implicit-int]
> kernel/rcu/tree_nocb.h:1260:1: error: expected identifier or '(' before '}' token
> kernel/rcu/tree_nocb.h:1339:20: error: conflicting types for 'rcu_organize_nocb_kthreads'; have 'void(void)'
> 
> Unverified Error/Warning (likely false positive, please contact us if interested):
> 
> include/linux/cpumask.h:277:17: warning: data definition has no type or storage class
> kernel/rcu/tree_nocb.h:1199:14: warning: variable 'need_rcu_nocb_mask' set but not used [-Wunused-but-set-variable]
> kernel/rcu/tree_nocb.h:1200:14: warning: variable 'offload_all' set but not used [-Wunused-but-set-variable]
> kernel/rcu/tree_nocb.h:1211:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
> kernel/rcu/tree_nocb.h:1217:2: error: expected identifier or '('
> kernel/rcu/tree_nocb.h:1259:28: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
> kernel/rcu/tree_nocb.h:1259:2: error: conflicting types for 'rcu_organize_nocb_kthreads'
> kernel/rcu/tree_nocb.h:1259:2: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
> kernel/rcu/tree_nocb.h:1259:9: warning: data definition has no type or storage class
> kernel/rcu/tree_nocb.h:1260:1: error: extraneous closing brace ('}')
> 
> Error/Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- arm64-randconfig-r031-20220420
> |   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
> |   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
> |   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
> |-- riscv-randconfig-r002-20220420
> |   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
> |   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
> |   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
> |-- sparc64-randconfig-c003-20220420
> |   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
> |   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
> |   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
> |   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
> |   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
> |   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
> |   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
> |-- sparc64-randconfig-r025-20220420
> |   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
> |   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
> |   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
> |   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
> |   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
> |   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
> |   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
> |-- x86_64-randconfig-a015
> |   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
> |   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
> |   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
> |   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
> |   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
> |   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
> |   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
> |-- x86_64-randconfig-s021
> |   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
> |   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
> |   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
> |   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
> |   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
> |   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
> |   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
> |-- x86_64-randconfig-s022
> |   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
> |   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
> |   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
> |   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
> |   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
> |   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
> |   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
> |-- x86_64-rhel-8.3
> |   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
> |   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
> |   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
> |   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
> |   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
> |   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
> |   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
> |-- x86_64-rhel-8.3-func
> |   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
> |   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
> |   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
> |   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
> |   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
> |   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
> |   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
> |-- x86_64-rhel-8.3-kselftests
> |   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
> |   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
> |   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
> |   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
> |   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
> |   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
> |   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
> |   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
> |   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
> |   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
> `-- x86_64-rhel-8.3-kunit
>     |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
>     |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
>     |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
>     |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
>     |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
>     |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
>     |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
>     |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
>     |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
>     |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
>     |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
>     |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
>     |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
>     |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
>     |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
>     |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
>     `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
> 
> clang_recent_errors
> |-- arm64-randconfig-r014-20220420
> |   `-- kernel-rcu-tree_nocb.h:warning:misleading-indentation-statement-is-not-part-of-the-previous-if
> |-- riscv-randconfig-r024-20220420
> |   |-- kernel-rcu-tree_nocb.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
> |   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads
> |   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(
> |   |-- kernel-rcu-tree_nocb.h:error:extraneous-closing-brace-(-)
> |   |-- kernel-rcu-tree_nocb.h:error:type-specifier-missing-defaults-to-int-Werror-Wimplicit-int
> |   `-- kernel-rcu-tree_nocb.h:warning:misleading-indentation-statement-is-not-part-of-the-previous-if
> `-- x86_64-randconfig-a014
>     |-- kernel-rcu-tree_nocb.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
>     |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads
>     |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(
>     |-- kernel-rcu-tree_nocb.h:error:extraneous-closing-brace-(-)
>     |-- kernel-rcu-tree_nocb.h:error:type-specifier-missing-defaults-to-int-Werror-Wimplicit-int
>     `-- kernel-rcu-tree_nocb.h:warning:misleading-indentation-statement-is-not-part-of-the-previous-if
> 
> elapsed time: 8791m
> 
> configs tested: 156
> configs skipped: 4
> 
> gcc tested configs:
> arm                              allmodconfig
> arm                              allyesconfig
> arm                                 defconfig
> arm64                               defconfig
> arm64                            allyesconfig
> i386                          randconfig-c001
> sh                          rsk7203_defconfig
> powerpc                 linkstation_defconfig
> sh                 kfr2r09-romimage_defconfig
> riscv                            allmodconfig
> m68k                          hp300_defconfig
> m68k                       m5208evb_defconfig
> powerpc                      ppc6xx_defconfig
> arc                                 defconfig
> powerpc                     asp8347_defconfig
> sh                           se7712_defconfig
> arc                        nsim_700_defconfig
> ia64                             alldefconfig
> arm                            qcom_defconfig
> nios2                         3c120_defconfig
> mips                        vocore2_defconfig
> powerpc                     tqm8541_defconfig
> powerpc                        cell_defconfig
> powerpc                     mpc83xx_defconfig
> arm                         nhk8815_defconfig
> powerpc                     stx_gp3_defconfig
> ia64                      gensparse_defconfig
> sh                        apsh4ad0a_defconfig
> mips                         cobalt_defconfig
> arm                        trizeps4_defconfig
> sh                                  defconfig
> arc                      axs103_smp_defconfig
> sh                          sdk7780_defconfig
> arm                          pxa910_defconfig
> powerpc64                           defconfig
> powerpc                       ppc64_defconfig
> parisc                           alldefconfig
> parisc64                            defconfig
> arc                          axs101_defconfig
> sh                             shx3_defconfig
> ia64                          tiger_defconfig
> powerpc                  iss476-smp_defconfig
> m68k                                defconfig
> s390                          debug_defconfig
> arm                            xcep_defconfig
> arm                          pxa3xx_defconfig
> sparc                       sparc32_defconfig
> powerpc                      pcm030_defconfig
> xtensa                    smp_lx200_defconfig
> s390                             allyesconfig
> sh                   secureedge5410_defconfig
> arm64                            alldefconfig
> sh                          polaris_defconfig
> powerpc                      ep88xc_defconfig
> sh                          rsk7269_defconfig
> x86_64                        randconfig-c001
> arm                  randconfig-c002-20220420
> arm                  randconfig-c002-20220421
> ia64                             allmodconfig
> ia64                             allyesconfig
> ia64                                defconfig
> m68k                             allyesconfig
> m68k                             allmodconfig
> nios2                               defconfig
> arc                              allyesconfig
> csky                                defconfig
> nios2                            allyesconfig
> alpha                               defconfig
> alpha                            allyesconfig
> h8300                            allyesconfig
> xtensa                           allyesconfig
> sh                               allmodconfig
> s390                                defconfig
> s390                             allmodconfig
> parisc                              defconfig
> parisc                           allyesconfig
> sparc                               defconfig
> i386                             allyesconfig
> sparc                            allyesconfig
> i386                                defconfig
> i386                   debian-10.3-kselftests
> i386                              debian-10.3
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                          allyesconfig
> powerpc                           allnoconfig
> powerpc                          allmodconfig
> x86_64                        randconfig-a006
> x86_64                        randconfig-a004
> x86_64                        randconfig-a002
> i386                          randconfig-a001
> i386                          randconfig-a003
> i386                          randconfig-a005
> x86_64                        randconfig-a011
> x86_64                        randconfig-a013
> x86_64                        randconfig-a015
> i386                          randconfig-a012
> i386                          randconfig-a014
> i386                          randconfig-a016
> arc                  randconfig-r043-20220420
> riscv                               defconfig
> riscv                    nommu_virt_defconfig
> riscv                          rv32_defconfig
> riscv                    nommu_k210_defconfig
> riscv                             allnoconfig
> riscv                            allyesconfig
> x86_64                    rhel-8.3-kselftests
> um                           x86_64_defconfig
> um                             i386_defconfig
> x86_64                          rhel-8.3-func
> x86_64                                  kexec
> x86_64                              defconfig
> x86_64                           allyesconfig
> x86_64                         rhel-8.3-kunit
> x86_64                               rhel-8.3
> 
> clang tested configs:
> riscv                randconfig-c006-20220422
> mips                 randconfig-c004-20220422
> x86_64                        randconfig-c007
> i386                          randconfig-c001
> arm                  randconfig-c002-20220422
> powerpc              randconfig-c003-20220422
> s390                 randconfig-c005-20220422
> riscv                randconfig-c006-20220424
> mips                 randconfig-c004-20220424
> arm                  randconfig-c002-20220424
> powerpc              randconfig-c003-20220424
> mips                        bcm63xx_defconfig
> arm                         orion5x_defconfig
> powerpc                      walnut_defconfig
> arm                        vexpress_defconfig
> arm                    vt8500_v6_v7_defconfig
> arm                         socfpga_defconfig
> arm                       spear13xx_defconfig
> mips                         tb0219_defconfig
> powerpc                        fsp2_defconfig
> powerpc                     tqm8560_defconfig
> powerpc                     tqm5200_defconfig
> mips                malta_qemu_32r6_defconfig
> mips                      bmips_stb_defconfig
> hexagon                          alldefconfig
> arm                     davinci_all_defconfig
> x86_64                        randconfig-a005
> x86_64                        randconfig-a003
> x86_64                        randconfig-a001
> i386                          randconfig-a002
> i386                          randconfig-a006
> i386                          randconfig-a004
> x86_64                        randconfig-a012
> x86_64                        randconfig-a014
> x86_64                        randconfig-a016
> i386                          randconfig-a013
> i386                          randconfig-a015
> i386                          randconfig-a011
> hexagon              randconfig-r041-20220420
> riscv                randconfig-r042-20220420
> hexagon              randconfig-r045-20220420
> s390                 randconfig-r044-20220420
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
