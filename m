Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AEA5B09C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiIGQJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiIGQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:09:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21BAFD0B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:09:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C20320585;
        Wed,  7 Sep 2022 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662566944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrsXd+bIvOt3zs7xld8Fn4DZIx7cnr+PjAHywJzUMzo=;
        b=wN6WLAEJiWw+RJdC6PceDP7mhQbvHHUMCQ/rNYisyZ9oyjsJCEdAq6tWgiqNvBt8MHiJwa
        I18skYmmRVbWdv+GgrpRovBEDbz4f0Jga0bjAbaEHQD2DF2qfQKSrSX1TNsmQgDMO4B/WQ
        vMpDp3UFT7Y1ojPl3qZ0PswP3KtwDdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662566944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrsXd+bIvOt3zs7xld8Fn4DZIx7cnr+PjAHywJzUMzo=;
        b=QIU7xYDNrn2poUZutLzb1YhkmZZ4nFpwBDW+wukE76KZDWunx7eLSCe8cPuqSEdHoJ2LHb
        xNwL+GthjA96ogBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6856013486;
        Wed,  7 Sep 2022 16:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eUDoFyDCGGODawAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 07 Sep 2022 16:09:04 +0000
Date:   Wed, 7 Sep 2022 18:09:03 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] firmware: dmi: Fortify entry point length checks
Message-ID: <20220907180903.5a14d3c4@endymion.delvare>
In-Reply-To: <CAHp75Vf+PdP2AiLOHYnKUWn5KDgvy+1poBHjHZd0hnJKTsGHtg@mail.gmail.com>
References: <20220907103041.0a88d5c4@endymion.delvare>
        <CAHp75VdzgWfQ=7nTvYmuxWMaPH0weF=Bzj+AEqsEhyQNeH1XHg@mail.gmail.com>
        <20220907172146.72460eda@endymion.delvare>
        <CAHp75Vf+PdP2AiLOHYnKUWn5KDgvy+1poBHjHZd0hnJKTsGHtg@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2022 18:48:03 +0300, Andy Shevchenko wrote:
> On Wed, Sep 7, 2022 at 6:21 PM Jean Delvare <jdelvare@suse.de> wrote:
> > On Wed, 7 Sep 2022 17:52:10 +0300, Andy Shevchenko wrote:  
> > > "NOTE: This value was incorrectly stated in version 2.1 of this specification as
> > > 1Eh. Because of this, there might be version 2.1 implementations that
> > > use either the 1Eh or the 1Fh value, but version 2.2 or later
> > > implementations must use the 1Fh value."  
> >
> > Good point, so maybe we should accept 0x1E and treat is silently as
> > 0x1F (which is what we have been doing implicitly so far) for maximum
> > compatibility?  
> 
> At least the previous comparison covers this case, if I'm not mistaken.

Before my proposed change, yes. After my proposed change, no longer.
Let's not risk a regression, I'll change the check to:

	if (memcmp(buf, "_SM_", 4) == 0 &&
	    buf[5] >= 30 && buf[5] <= 32 &&
	    dmi_checksum(buf, buf[5])) {

I'll also add a comment stating why we are allowing length 30.

Thanks for the valuable feedback,
-- 
Jean Delvare
SUSE L3 Support
