Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61A34D40ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 06:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbiCJFts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 00:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbiCJFta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:49:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819FEAE67
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:48:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D7356210F3;
        Thu, 10 Mar 2022 05:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646891303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hzxTsvvzhK5KVT7xuWAwpPmOQv+KiG4w64eraMyiq1M=;
        b=Jl9lihcEIuiCASQMBi+6z96c+PhquyjWojHJ7ThcmaL668ZSQQZ0qRvPuTH7FcG6ogJ253
        lElJQVY2kHYr3KcEIr0WMAWwqMtPegYQU646cw8W5W5mQIH0H6xG1V6YdeFpXMA8qGIbEM
        bB/4kRlQgUUSUVylyXsrZ9BXMjcEjRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646891303;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hzxTsvvzhK5KVT7xuWAwpPmOQv+KiG4w64eraMyiq1M=;
        b=DM+1Jv2UiUlEYLfpd6h8B+62AcnHcfJv2kVVEvHhVkNCKqefTvtFHZgaE5t/mnCBf2LV4Z
        tA1B5Kq2YlQTHfAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07DBC13D07;
        Thu, 10 Mar 2022 05:48:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z+L2OSaRKWLbfAAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 10 Mar 2022 05:48:22 +0000
Date:   Thu, 10 Mar 2022 06:48:21 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Only re-generate demotion targets when a numa node
 changes its N_CPU state
Message-ID: <YimRJS9XFE8nswkd@localhost.localdomain>
References: <20220309144644.4278-1-osalvador@suse.de>
 <87bkyefxnq.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkyefxnq.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 08:39:53AM +0800, Huang, Ying wrote:
> We need to call set_migration_target_nodes() during system boot
> somewhere, either here or in init_mm_internals().

Hi Huang Ying,

vmstat_cpu_online() already gets called during boot:

static struct cpuhp_step cpuhp_hp_states[] = {
...
	#ifdef CONFIG_SMP
	[CPUHP_CREATE_THREADS]= {
		.name			= "threads:prepare",
		.startup.single		= smpboot_create_threads,
		.teardown.single	= NULL,
		.cant_stop		= true,
	},
...

smpboot_create_threads
 __smpboot_create_thread
  smpboot_thread_fn
   ht->thread_fn() 
    cpuhp_thread_fun
     cpuhp_invoke_callback
      vmstat_cpu_online

That for every CPU that is brought up during boot.

So unless I am missing something, I would say we are already covered
there, right?


-- 
Oscar Salvador
SUSE Labs
