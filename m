Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF5A5B0863
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIGPWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiIGPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:21:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24C5A9C39
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:21:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24AEB2054E;
        Wed,  7 Sep 2022 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662564108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJ34dsrJXuJLIdyPgcg3FxlDUp7oKXjhBhTpF0POUjI=;
        b=DPHxdmo4W6kBAbVthqDBf1fEhUyy2N35EvG96TF2MpRM2oWK7XlsPwkuFmFBoVe/jSEVKY
        5tt+BtuwIeCS+JMsgtw65qfDLlOH7bAioObSAKbZfbrkjKVU/bkIDi4oazsSOkCYSs7Bkq
        MCEcgjE8aSF5Ghb+xIjqr40SKJz8YQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662564108;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJ34dsrJXuJLIdyPgcg3FxlDUp7oKXjhBhTpF0POUjI=;
        b=ALDKvCbbtXKLIIMtlcCWet5yB28x4T2wMhqtxpQRuNfMy5tjzohcrP3iBJ81RoSw2AuV/t
        vcJyuPMUUwWHsXDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3A4813A66;
        Wed,  7 Sep 2022 15:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TU/COQu3GGODWQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 07 Sep 2022 15:21:47 +0000
Date:   Wed, 7 Sep 2022 17:21:46 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] firmware: dmi: Fortify entry point length checks
Message-ID: <20220907172146.72460eda@endymion.delvare>
In-Reply-To: <CAHp75VdzgWfQ=7nTvYmuxWMaPH0weF=Bzj+AEqsEhyQNeH1XHg@mail.gmail.com>
References: <20220907103041.0a88d5c4@endymion.delvare>
        <CAHp75VdzgWfQ=7nTvYmuxWMaPH0weF=Bzj+AEqsEhyQNeH1XHg@mail.gmail.com>
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

Hi Andy,

On Wed, 7 Sep 2022 17:52:10 +0300, Andy Shevchenko wrote:
> On Wed, Sep 7, 2022 at 11:30 AM Jean Delvare <jdelvare@suse.de> wrote:
> >
> > Ensure that the SMBIOS entry point is long enough to include all the
> > fields we need. Otherwise it is pointless to even attempt to verify
> > its checksum.
> >
> > Also fix the maximum length check, which is technically 32, not 31.
> > It does not matter in practice as the only valid values are 31 (for
> > SMBIOS 2.x)  
> 
> "NOTE: This value was incorrectly stated in version 2.1 of this specification as
> 1Eh. Because of this, there might be version 2.1 implementations that
> use either the 1Eh or the 1Fh value, but version 2.2 or later
> implementations must use the 1Fh value."

Good point, so maybe we should accept 0x1E and treat is silently as
0x1F (which is what we have been doing implicitly so far) for maximum
compatibility?

> > and 24 (for SMBIOS 3.x), but let's still have the check
> > right in case new fields are added to either structure in the
> > future.  
> 
> Thanks, makes sense to me. But probably needs more work :-)

Of course more work would presumably be needed there, but I assume such
changes would have to be compatible with previous implementations, so
we don't want to choke on a length check for no reason.

-- 
Jean Delvare
SUSE L3 Support
