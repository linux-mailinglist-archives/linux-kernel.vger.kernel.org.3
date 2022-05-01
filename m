Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ACF516478
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 14:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347324AbiEAMvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 08:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiEAMvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 08:51:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D0C659A
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 05:48:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 839E121879;
        Sun,  1 May 2022 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651409284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dUqW1QkMf1n45JCvg7wOgjlyU+bUTm30Sd1/2PVrELQ=;
        b=A9C9r058IqR6eaDBmwHaE81NOvHO5DIArMla9O83Yj59PG5BALC/CYluVn/XJHKZFssaYa
        JMJj7MDFVR6CZGgP29Y5flIVmyoIcomKWw8p83xSZP4s/SvrKH+pPaLVCS80cc0qU75hLl
        rG12QnQTUukujkRBd3EFn0/CF5qUsQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651409284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dUqW1QkMf1n45JCvg7wOgjlyU+bUTm30Sd1/2PVrELQ=;
        b=7jXY9SbkDoPpB89DZOaCVKB/mK2i2g4RoVdbKr4q426jSD/4Bkp6+OEJg6kpRUkUHdS65r
        p1jBolF5IJKtnhAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7699E139F5;
        Sun,  1 May 2022 12:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S/ftHISBbmKZQQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 01 May 2022 12:48:04 +0000
Date:   Sun, 1 May 2022 14:48:02 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Ozgur Karatas <ozgurk@ieee.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] irq/urgent for 5.18
Message-ID: <Ym6BgmOY4zxlbiIx@zn.tnic>
References: <Ym5vDU6KFdzYaTAo@zn.tnic>
 <CAADfD8ypPRzja3RU8QGwBNc=MiN1H3OLHjHVgnJ6h1fFPO2dhw@mail.gmail.com>
 <Ym528eZ5kb2geWwx@zn.tnic>
 <CAADfD8yk0-soyYt+qQ8t=unAoQ4ytL3b2Xv=h66ojYheYMa=Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADfD8yk0-soyYt+qQ8t=unAoQ4ytL3b2Xv=h66ojYheYMa=Nw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 04:24:22PM +0400, Ozgur Karatas wrote:
> I didnt think return value was an invalid argument and thought it might be
> return= -EINVAL;
> and i was wondering why error return, if not an invalid argument.
> So if there is no bad argument assigned to function I think error =
> -EINVAL; should be return = -EINVAL instead right?

Try building your suggestion.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
