Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34592471F53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhLMC2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:28:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37940 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLMC2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:28:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4ECC72114E;
        Mon, 13 Dec 2021 02:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639362528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=enfqsRJpLj7mhCGBT1hqlOexzdy735VnIW7MqPEc4uY=;
        b=hOYOrMzUaXEuLFVDR2Q/aeqX2FGBpDSs0kF2jYmfWZGi7Mep+J+21X++4WpgubwcMh1FPi
        VOGd+PwmNohxoLaCx33i8thFWpL9+8sn1ZjM1U51pd39XlVNS0vCkC205154tzfFb1gcOi
        +mmxkXVBHo+Y92o17I2h8M/oP/H723I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639362528;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=enfqsRJpLj7mhCGBT1hqlOexzdy735VnIW7MqPEc4uY=;
        b=blrwoEFZy12BijwEUwE3KpTqMnBqge94k0X+Q6ygPQi5Cl6iIaeJNWDo19aHYKCumqHu/O
        pKzh/s4sOimozpDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F223713310;
        Mon, 13 Dec 2021 02:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bfmMK96vtmEwJwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Dec 2021 02:28:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [PATCH v2] FAT: use schedule_timeout_uninterruptible() instead of
 congestion_wait()
In-reply-to: <87h7bfmtqc.fsf@mail.parknet.co.jp>
References: <163712349419.13692.2859038330142282757@noble.neil.brown.name>,
 <87ee79yiik.fsf@mail.parknet.co.jp>,
 <163754226639.13692.10449616189734943162@noble.neil.brown.name>,
 <874k84hi5q.fsf@mail.parknet.co.jp>,
 <163911011670.9928.6438117555175130033@noble.neil.brown.name>,
 <163911016975.9928.6568675782275129@noble.neil.brown.name>,
 <87h7bfmtqc.fsf@mail.parknet.co.jp>
Date:   Mon, 13 Dec 2021 13:28:43 +1100
Message-id: <163936252397.22433.9103044991910658320@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021, OGAWA Hirofumi wrote:
> "NeilBrown" <neilb@suse.de> writes:
> 
> > congestion_wait() in this context is just a sleep - block devices do not
> > in general support congestion signalling any more.
> >
> > The goal here is to wait for any recently written data to get to
> > storage.  blkdev_issue_flush() is thought to be too expensive, so
> > replace congestion_wait() with an explicit timeout.
> 
> If just replace, the following looks better
> 
> 	set_current_state(TASK_UNINTERRUPTIBLE);
> 	io_schedule_timeout(HZ/10);
> 
> Otherwise,
> 
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.
According to MAINTAINERS, I should send patches for this code to you,
with the implication (I assumed) that you would forwarded them upstream
if acceptable.
But the fact that you have send mt an Acked-By seems to suggest that you
won't be doing that.
To whom should I send this patch with your acked-by?

Thanks,
NeilBrown
