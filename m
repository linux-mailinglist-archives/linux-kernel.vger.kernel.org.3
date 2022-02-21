Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D01B4BE339
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354699AbiBUK01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:26:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355050AbiBUK0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:26:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B593AE0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:47:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 722E82112A;
        Mon, 21 Feb 2022 09:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645436866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pk1xOipV5voJ7yLZv8MbUm0kEPSkqLDIOfh31PmClxA=;
        b=k8BT4upj2bStO1OCtFiwY1jBOjsjwsSnsET2IW0bw1Lu6nY7Tn/NWbtD88JN+WkYE4rAQU
        pjlMNjSsWtgkwwCPyPHHWVE8ChDhmyJQU2XXXMCr1qqYZDmruidPrGItZzcxyJoqbtCIzF
        eF7mGIDoocBo9Cmx6N3+lnJRn03qIBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645436866;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pk1xOipV5voJ7yLZv8MbUm0kEPSkqLDIOfh31PmClxA=;
        b=+Bowmqi+Vl0JzpdPI67vAqnY33YviVxSOCDS0L5dWiETe8ODC/QGFm5qpXEECRbHHzFBVR
        FSTucjG4TKupd+Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBC3E13A7C;
        Mon, 21 Feb 2022 09:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id puNfKsFfE2IrDwAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 21 Feb 2022 09:47:45 +0000
Date:   Mon, 21 Feb 2022 10:47:44 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arch/x86/mm/numa: Do not initialize nodes twice
Message-ID: <YhNfwCO3xTIavi5v@localhost.localdomain>
References: <20220218224302.5282-1-osalvador@suse.de>
 <20220218224302.5282-2-osalvador@suse.de>
 <YhNZQgGSZglGQvcg@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhNZQgGSZglGQvcg@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:20:02AM +0100, Michal Hocko wrote:
> On Fri 18-02-22 23:43:02, Oscar Salvador wrote:
> > Why setting the node online saves us then? Well, simply because
> > __try_online_node() backs off when the node is online, meaning
> > we do not end up calling register_one_node() in the first place.
> 
> This is really a mess and a house built on sand. Thanks for looking into
> it and hopefully this can get cleaned up to a saner state.

Yes, I am willing to have a deep look into that and see how we can
improve the situation.

> This sha1 is from linux-next very likely so it won't be persistent.
> Please drop it.

Yes, it is. I guess it is fine to not have a "Fixes" tag here, so I will
remove it then.

> I would stick a TODO here.
> 			/*
> 			 * Exclude this node from 
> 			 * bringup_nonboot_cpus
> 			 *  cpu_up
> 			 *    __try_online_node
> 			 *      register_one_node
> 			 * because node_subsys is not initialized yet
> 			 * TODO remove dependency on node_online()
> 			 */

Sure, will do.

Thanks!

-- 
Oscar Salvador
SUSE Labs
