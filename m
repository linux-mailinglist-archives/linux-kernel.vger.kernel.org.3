Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DD64DCE16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiCQSyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbiCQSyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:54:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A060412D0A5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:53:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3EE5C1F38E;
        Thu, 17 Mar 2022 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647543194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sg6FmafrPdR1KtYNg/JwS0y/weg8uwWLi0b4wB9DaB8=;
        b=CW+6aHqwJGO16ayz+hSnPGa0OPbIHWsUKut3I4UlP3B9++g8YafKAZteQjBFUdF6bEJfoH
        hpy6Ebcd2p94U4iCH9Lc1apwE77b13nAy1ZvtBdnmBxqwOdyTaVCwhE1JXtYPQ4Uq7QOy7
        s1DPlV+jNFXxC91mvrPiXyLcTnNioUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647543194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sg6FmafrPdR1KtYNg/JwS0y/weg8uwWLi0b4wB9DaB8=;
        b=o8CjYA0ITGwkIvMJKFrEfzWkeowZgmhKOTbhiqLw0rKG8pL+AQyrQ9lPQ17fvlbiiikol3
        lPAUcMEz8wfNLADQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DB7A13BB5;
        Thu, 17 Mar 2022 18:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G5OlApqDM2IkKwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 17 Mar 2022 18:53:14 +0000
Message-ID: <34856139-e2db-4d34-07b5-c0af2bdf44f4@suse.cz>
Date:   Thu, 17 Mar 2022 19:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v2 1/4] [PATCH 1/4] mm: refactor of vma_merge()
Content-Language: en-US
To:     =?UTF-8?Q?Jakub_Mat=c4=9bna?= <matenajakub@gmail.com>,
        linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org
References: <20220311174602.288010-1-matenajakub@gmail.com>
 <20220311174602.288010-2-matenajakub@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220311174602.288010-2-matenajakub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 18:45, Jakub Matěna wrote:
> Refactor vma_merge() to make it shorter, more understandable and
> suitable for tracing of successful merges that are made possible by
> following patches in the series. Main change is the elimination of code
> duplicity in the case of merge next check. This is done by first doing
> checks and caching the results before executing the merge itself. Exit
> paths are also unified.
> 
> Signed-off-by: Jakub Matěna <matenajakub@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

It's a nice cleanup on its own. Removed duplication and reduced indentation
levels helps.
