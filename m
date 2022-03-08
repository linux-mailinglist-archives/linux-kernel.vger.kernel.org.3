Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FBD4D20C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348168AbiCHS6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349876AbiCHS6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:58:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D6254186
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:57:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C626210ED;
        Tue,  8 Mar 2022 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646765821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0IfmFdPIHuTa75Qa/8oUKNFdCQJv+DchlDBS9H5YG4g=;
        b=pBCnBqihs3rV/BlNOD7j+ZB76sI0/mQiVbUmo4Y1slWqqutSwmU941y0E92p9zs+axP5MA
        1N+zo8cVSDUtuT93RJnEu+h5Hmd0aAGCGkKl6TrGsQOB6p/W2jTzLxUYBv25M8pARnacJd
        U5L/w/1zP7/0J8LuxVlGQrIxaxK01qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646765821;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0IfmFdPIHuTa75Qa/8oUKNFdCQJv+DchlDBS9H5YG4g=;
        b=MmAU06sDhhgGSHT7iox+uiNH8sbWBaWDyuuLKEmA5kKxjoS95T5mEkPL9CF5+KuDjuqh5g
        wV4kmO6vJWq0qEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7F7313CE9;
        Tue,  8 Mar 2022 18:57:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yIJwLfymJ2IBRAAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 08 Mar 2022 18:57:00 +0000
Date:   Tue, 8 Mar 2022 19:56:59 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -V11 2/9] mm/migrate: update node demotion order on
 hotplug events
Message-ID: <Yiem+4YbComC0EGC@localhost.localdomain>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-2-ying.huang@intel.com>
 <eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com>
 <f5edb9dc-8b25-47c2-9905-09e88e41861b@intel.com>
 <4e8067e1-0574-c9d2-9d6c-d676d32071bd@linux.vnet.ibm.com>
 <87pmnb3ccr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YicvnkVODh5qbxTC@localhost.localdomain>
 <86383ac9-e5f2-1a2e-dd19-02e39714a3fd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86383ac9-e5f2-1a2e-dd19-02e39714a3fd@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 09:07:20AM -0800, Dave Hansen wrote:
> On 3/8/22 02:27, Oscar Salvador wrote:
> > @@ -2043,7 +2044,12 @@ static void __init init_cpu_node_state(void)
> >  static int vmstat_cpu_online(unsigned int cpu)
> >  {
> >  	refresh_zone_stat_thresholds();
> > -	node_set_state(cpu_to_node(cpu), N_CPU);
> > +
> > +	if (!node_state(cpu_to_node(cpu), N_CPU)) {
> > +		node_set_state(cpu_to_node(cpu), N_CPU);
> > +		set_migration_target_nodes();
> > +	}
> > +
> >  	return 0;
> >  }
> > 
> > @@ -2066,6 +2072,8 @@ static int vmstat_cpu_dead(unsigned int cpu)
> >  		return 0;
> > 
> >  	node_clear_state(node, N_CPU);
> > +	set_migration_target_nodes();
> > +
> >  	return 0;
> >  }
> 
> Yeah, those callbacks do look like they're reinventing the wheel.  This
> is a much more direct way of doing it.

Then let me play a bit more with it and I can cook a patch unless
someone feels strong against it.

Thanks

-- 
Oscar Salvador
SUSE Labs
