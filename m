Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27884734A4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbhLMTFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:05:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48740 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhLMTFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:05:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0458B210E2;
        Mon, 13 Dec 2021 19:05:37 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0F8113E53;
        Mon, 13 Dec 2021 19:05:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7Wl2HH6Zt2F6FwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 13 Dec 2021 19:05:34 +0000
Date:   Mon, 13 Dec 2021 11:05:29 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, bigeasy@linutronix.de, tglx@linutronix.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] blk-mq: make synchronous hw_queue runs RT friendly
Message-ID: <20211213190529.j54qikq7mk5zuc3o@offworld>
References: <20211213054425.28121-1-dave@stgolabs.net>
 <YbdFeHVnQbT0E5kR@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YbdFeHVnQbT0E5kR@infradead.org>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021, Christoph Hellwig wrote:
>But more importantly:  why isn't migrate_disable/enable doing the right
>thing for !PREEMPT_RT to avoid this mess?

Please see Peter's description of the situation in af449901b84.

While I'm not at all a fan of sprinkling migrate_disabling around code,
I didn't want to add any overhead for the common case. If this, however,
were not an issue (if most cases are async runs, for example) the ideal
solution I think would be to just pin current to the hctx->cpumask.

Thanks,
Davidlohr
