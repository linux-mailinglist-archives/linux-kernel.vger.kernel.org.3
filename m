Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750DD54C2A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244135AbiFOHep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiFOHem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:34:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D33727CDB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:34:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D5A221BBE;
        Wed, 15 Jun 2022 07:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655278480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xnHkSCs6PdKJAPZ0Z/Xsv20auVXjVTIVCUkcb6mMdqc=;
        b=yFyn1WRxN68GfWQ2CP9O8+VB/ycfwlRW6zDkMVFofDlAmrFUR7HuA1IWBISCU7S01W6Gmk
        Wmcj3oI91GicuwzUitHsQj1LDLSfPxlR2TFtubYkQDHPyx+1lnbol/32Z4LAt/07ckVSU8
        Dom+BWnlvpOjSkYkfYn7uUxaClZ5B0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655278480;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xnHkSCs6PdKJAPZ0Z/Xsv20auVXjVTIVCUkcb6mMdqc=;
        b=HYS04bPWnnTR2eWyBn8plNvrzxrAUZcHGcaI1tbUMLxMQZrRponNWwk3rfh/2ctSNKCBSe
        QgKIdqIUUyEdpQCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C57C139F3;
        Wed, 15 Jun 2022 07:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ArtyDY+LqWLTCAAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 15 Jun 2022 07:34:39 +0000
Date:   Wed, 15 Jun 2022 09:34:37 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove unwanted initialization in
 vmemmap_populate_compound_pages()
Message-ID: <YqmLjSC5277UgRF5@localhost.localdomain>
References: <20220612182320.160651-1-gautammenghani201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612182320.160651-1-gautammenghani201@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 11:23:20AM -0700, Gautam Menghani wrote:
> Remove unwanted initialization for the variable 'next'. This fixes the
> clang scan warning: Value stored to 'next' during its initialization is 
> never read [deadcode.DeadStores]
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
