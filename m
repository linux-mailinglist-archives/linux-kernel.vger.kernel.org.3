Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE784E8FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbiC1IP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbiC1IPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:15:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3297BFD04
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:14:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E38B9210DF;
        Mon, 28 Mar 2022 08:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648455252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+vB3veO+w1AVdDAZ0JQhhQ3DjaQr7v+h/WkhgJ35PGw=;
        b=vtdyileMsiHdQjXtZsBNq3VQd7NYxSTqvtpD+3ocgDKaovgWVAmpworFzvJcDUSp5uMyf1
        QvCD17WtoZnghedU8Qa9q0C0Yn9x9OEqInx1pUEjyjt5tQK1IwcWz6yWME0kTwv3HupCz3
        EYcK8xPP5He6PyWfcVPqWoTfU/CkrsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648455252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+vB3veO+w1AVdDAZ0JQhhQ3DjaQr7v+h/WkhgJ35PGw=;
        b=cGtUK9BBZIGORuB+sT5IQyPvpZof6ulpigSinoQyDFSZmN4zdt+hnSngkQ2Wu7aeITRbOG
        TNccGsRtCq7H4XBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 587C013215;
        Mon, 28 Mar 2022 08:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W79jEVRuQWInBgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 28 Mar 2022 08:14:12 +0000
Date:   Mon, 28 Mar 2022 10:14:10 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net
Subject: Re: [PATCH 1/2] mm/vmscan: reclaim only affects managed_zones
Message-ID: <YkFuUsWe2LAuQa3n@localhost.localdomain>
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327024101.10378-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 02:41:00AM +0000, Wei Yang wrote:
> As mentioned in commit 6aa303defb74 ("mm, vmscan: only allocate and
> reclaim from zones with pages managed by the buddy allocator") , reclaim
> only affects managed_zones.
> 
> Let's adjust the code and comment accordingly.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

LGTM,

Reviewed-by: Oscar Salvador <osalvador@suse.de>

We still have some other places scattered all over where we use
populated_zone().
I think it should be great to check whether all those usages are
right.


-- 
Oscar Salvador
SUSE Labs
