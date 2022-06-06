Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD4F53E355
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiFFHuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiFFHur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:50:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5C3BA548
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:50:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1B24C21A05;
        Mon,  6 Jun 2022 07:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654501843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8v3lgBRmpslmKRN8MWAVjAzh0okeA6O5CtXmHrDTJhY=;
        b=mOTTTad37p2zUEFZH9icQlg3towOhQRv4MRQFdwj6FeRX5+2cVeC9/aQQTgIuRf5I7J7r5
        MYCK5Ct9mpORsmdOlTEbHW7TY97mcJW88eAPrIMyLb5k6m9Xhs5gav2fFHO/Aw+3fCGS0q
        2yRUralipzPRAYQaeaip0sElUyjxn40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654501843;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8v3lgBRmpslmKRN8MWAVjAzh0okeA6O5CtXmHrDTJhY=;
        b=833Fq1LTcDL6dr0RmKtldoQKi+YkqElLKXnlSgIQXNWIDn+RF9DRFbmn68dNHIAA2fBcln
        SgwBrz5iI6q2oHAg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D5542C141;
        Mon,  6 Jun 2022 07:50:43 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BBDB6A0633; Mon,  6 Jun 2022 09:50:42 +0200 (CEST)
Date:   Mon, 6 Jun 2022 09:50:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     jack@suse.cz, hch@lst.de, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] lib/flex_proportions.c: Remove local_irq_ops in
 fprop_new_period()
Message-ID: <20220606075042.4zfxsj7k5nlownfu@quack3.lan>
References: <20220604131502.5190-1-wuchi.zero@gmail.com>
 <20220606074444.7givh4uaf2sgz6rn@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606074444.7givh4uaf2sgz6rn@quack3.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-06-22 09:44:44, Jan Kara wrote:
> On Sat 04-06-22 21:15:02, wuchi wrote:
> > The commit <e78d4833c03e28> (lib: Fix possible deadlock in flexible
> > proportion code) adds the local_irq_ops because percpu_counter_{sum
> > |add} ops'lock can cause deadlock by interrupts. Now percpu_counter
> > _{sum|add} ops use raw_spin_(un)lock_irq*, so revert the commit and
> > resolve the conflict.
> > 
> > Signed-off-by: wuchi <wuchi.zero@gmail.com>
> 
> Yes, good point. Thanks for cleaning this up. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> I guess Andrew will pickup this patch, or should I do it Andrew?

Oh, I can see Andrew already did pickup the patch. So everything is fine
:).
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
