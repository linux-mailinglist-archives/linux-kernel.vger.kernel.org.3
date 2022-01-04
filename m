Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D370E483E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiADJAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiADJAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:00:30 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF9AC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 01:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5o/XeagDa5IkViA9Io/7at9px3zYYZdV6zWUiAupJzE=;
        t=1641286830; x=1642496430; b=SQhdqvTSRqzKYEwBN9bUrXqsv3UI9R59nY2WhK1dKDSRzU2
        T0P8hXBO0D2AlkQ+k0tYlnanls/2TnqWAIYE9RDIH9GXGGncJn2Zm0wWt11FShRpKid+0TZYCHADp
        uyKmR18+m7sj4fwaXWAl0F7yiVEj4Bq0vA8nQSKUIoMAbh6wHG6Uey4duhx20seE1J3Kd8U063jDD
        J5lqKofnBhYtcCRukxVWAJKsew2/M0UW9YMtylrs78lGxZD85fJadtGwidRgoZgeaPAgP7YAg97ip
        b1/UrwyWDFgjoKbBCFeOe0TWwhHwHOM+LcQtf+s8kGE/Yz1Daj/XzjppxxUKYVyA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n4fgB-001hbV-Fw;
        Tue, 04 Jan 2022 10:00:27 +0100
Message-ID: <5fdb10e93535d83d208682e2eb5514fa1d5b6240.camel@sipsolutions.net>
Subject: Re: [PATCH 2/4] um: os_set_fd_block: Return old blocking mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, anton.ivanov@cambridgegreys.com
Date:   Tue, 04 Jan 2022 10:00:25 +0100
In-Reply-To: <20220101215810.13260-3-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
         <20220101215810.13260-3-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-01-01 at 22:58 +0100, Richard Weinberger wrote:
> This will be needed when we restore the old mode upon exit.
> The function now returns < 0 in case of an error, 1 if O_NONBLOCK
> was set, 0 otherwise.
> 
> +++ b/arch/um/drivers/chan_user.c
> @@ -257,7 +257,7 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
>  	}
>  
>  	err = os_set_fd_block(*fd_out, 0);
> -	if (err) {
> +	if (err < 0) {
>  		printk(UM_KERN_ERR "winch_tramp: failed to set thread_fd "
>  		       "non-blocking.\n");
>  		goto out_close;

This does 'return err' afterwards, which then changes the logic from 0
to 1, which seems wrong - especially given that it gets passed further
elsewhere as a pid, which seems very questionable in the first place,
but at least 1 would be valid pid unlike 0?

IOW, I think you need

-	return err;
+	return 0;

a couple of lines later.

johannes
