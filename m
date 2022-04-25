Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33EB50E6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbiDYRXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiDYRXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:23:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1671733E17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Gzg4AyS8net1R8Tx2bc8dK190ann924Vsd5NkTXRaiM=;
        t=1650907207; x=1652116807; b=JYkC0Bj1EfZV08cHHcsg0P2jiOlGnr4l0vq/EpxA4kT8C4S
        UCVvo6TducFs3LhyX33UneBOqloez6DiLtYXwFZYvcB74bSAa1ywQAyD+k7VCVZfTJOhRq3nGF43h
        zqC5yN5qfHfO5bhkKj8T6n6fY7nZnPwwrK4LcYWUi9/L8WXZ6OGzRhc6GAhXYp0NQMK4fktncuiaK
        6YooZtRXm3WLjUGFBgmHsPucSn2bl8CzbZMfIXl3Dtg+Tq4JB5xxZDaandiBHUz0fnOL4YSGf5AQq
        6Qt4X99NBEdRgEYsZ0mAxh5IVQr+k/B30/qhzuPmW3ueeX8G7U/95m86Z8IqEi3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nj2NT-00EwUY-Kz;
        Mon, 25 Apr 2022 19:19:59 +0200
Message-ID: <8186de033c87f0cdec296ae272a72c5b9a2880a3.camel@sipsolutions.net>
Subject: Re: [PATCH v2 ] devcoredump : Serialize devcd_del work
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org
Date:   Mon, 25 Apr 2022 19:19:58 +0200
In-Reply-To: <87levt14kn.ffs@tglx>
References: <87levt14kn.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 19:00 +0200, Thomas Gleixner wrote:
> 
> Johannes, can you please explain whether this immediate flush in
> disabled_store() is really required and if so, why?
> 

I don't really know, as I remember that requirement (or maybe even code,
not sure) came from Kees, who needed the lockdown.

Given the use case (ChromeOS?) I'm not sure I see a need to flush all of
them, since I guess a typical system would set the lockdown early in
boot and hopefully not have a crash-dump around already.


That said, I don't think the diagram you made works - fn() during the
iteration is guaranteed to be invoked with a reference of its own, so
the put_device() there can't be the last reference, only as fn() returns
you'd put the last reference *there*, freeing it.

johannes
