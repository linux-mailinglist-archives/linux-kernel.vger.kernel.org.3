Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5887C4D9661
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346112AbiCOIe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346113AbiCOIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:34:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E95C10F8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:32:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07B491F37E;
        Tue, 15 Mar 2022 08:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647333165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bYkhOc7jYnnaJzo+1Uv/M+ohxdNO0S/jT3vuFCDsVq0=;
        b=tYVVwupkSeyTkjuwC7GpGjykJWyIg0x1HfB8jJm6mimuRYUph0g8UTUQCdlRC2N4ZB5eKX
        ypjBzvT8agH+7xZwFvfK3G5hxO46HseVzv0cTeiPRHMIIIcVSrm3Wk2J2AK4y88kmSqw3v
        tT+lmUV0xKRyt8xM0LbFz3Hc2GZyaqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647333165;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bYkhOc7jYnnaJzo+1Uv/M+ohxdNO0S/jT3vuFCDsVq0=;
        b=JKMGLIfKHl/kcVKS1aposzv2vEEp3oEOhbC4yLi9tZVRs7XOP46OlBqJBP5GPGAam4h9Td
        HfFFjPpRdg//y6Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E84813B4E;
        Tue, 15 Mar 2022 08:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wWoEICxPMGLdZgAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 15 Mar 2022 08:32:44 +0000
Date:   Tue, 15 Mar 2022 09:32:42 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: Only re-generate demotion targets when a numa
 node changes its N_CPU state
Message-ID: <YjBPKmIpPNoJU/67@localhost.localdomain>
References: <20220314150945.12694-1-osalvador@suse.de>
 <87pmmn3eh6.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmmn3eh6.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 02:40:53PM +0800, Huang, Ying wrote:
> Oscar Salvador <osalvador@suse.de> writes:
> CPUHP_MM_DEMOTION_DEAD and CPUHP_AP_MM_DEMOTION_ONLINE needs to be
> deleted from include/linux/cpuhotplug.h too.

Hi Huang Ying,

Right.

Andrew, can you apply this on top? Thanks

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 411a428ace4d..8a9a2d01b7c6 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -72,8 +72,6 @@ enum cpuhp_state {
 	CPUHP_SLUB_DEAD,
 	CPUHP_DEBUG_OBJ_DEAD,
 	CPUHP_MM_WRITEBACK_DEAD,
-	/* Must be after CPUHP_MM_VMSTAT_DEAD */
-	CPUHP_MM_DEMOTION_DEAD,
 	CPUHP_MM_VMSTAT_DEAD,
 	CPUHP_SOFTIRQ_DEAD,
 	CPUHP_NET_MVNETA_DEAD,
@@ -244,8 +242,6 @@ enum cpuhp_state {
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
-	/* Must be after CPUHP_AP_ONLINE_DYN for node_states[N_CPU] update */
-	CPUHP_AP_MM_DEMOTION_ONLINE,
 	CPUHP_AP_X86_HPET_ONLINE,
 	CPUHP_AP_X86_KVM_CLK_ONLINE,
 	CPUHP_AP_ACTIVE,

Huang Ying, it would be great to have your Reviewed-by/Acked-by if you
are ok with the outome.

Thanks

-- 
Oscar Salvador
SUSE Labs
