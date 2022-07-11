Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587325701CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiGKMNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGKMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:13:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF44A833
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:13:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A1A6A202F3;
        Mon, 11 Jul 2022 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657541585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RJTrqX4wTRC4bsbLa+oGGurpnRSIqFoGGm8rRNepF1U=;
        b=zWV2YtKM8u0yyeLAWJTZzMxHn40zWPKElXCwuTkoPuYgiCoFhPwZhsyCItkYFa7N/4Cwgb
        eorXLQtF4Vfng6IZvAGrd7zPPaxKUbLsRbnoT4m0SCJ8AYWFhBT8DYSBEwI+D5n6Qlb4s6
        VY2tORPRBMXnduLHG9SGzQXTwh4ic8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657541585;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RJTrqX4wTRC4bsbLa+oGGurpnRSIqFoGGm8rRNepF1U=;
        b=2VOaoIIwZYq3AABcC05h0mvfyzwswoQ1gsj93jIqbTHuPSZhO+OaM4FCIhJKU/5NyaGqcV
        yR1PRBzv5MpRXxDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 747B613524;
        Mon, 11 Jul 2022 12:13:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BOhMG9ETzGIOCwAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 11 Jul 2022 12:13:05 +0000
Date:   Mon, 11 Jul 2022 14:13:04 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH -V2 4/7] migrate_pages(): fix failure counting for THP
 subpages retrying
Message-ID: <YswT0OoJFRGP065E@localhost.localdomain>
References: <20220711084948.274787-1-ying.huang@intel.com>
 <20220711084948.274787-5-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711084948.274787-5-ying.huang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 04:49:45PM +0800, Huang Ying wrote:
> If THP is failed to be migrated for -ENOSYS and -ENOMEM, the THP will
> be split into thp_split_pages, and after other pages are migrated,
> pages in thp_split_pages will be migrated with no_subpage_counting ==
> true, because its failure have been counted already.  If some pages in
> thp_split_pages are retried during migration, we should not count
> their failure if no_subpage_counting == true too.  This is done this
> patch to fix the failure counting for THP subpages retrying.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
