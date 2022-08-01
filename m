Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DD25866E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiHAJfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHAJfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:35:15 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535A0E11;
        Mon,  1 Aug 2022 02:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659346485; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Jx7BAp1Ur6Yy0pKzSMytCbuHMv1MZlMoS/DS7ceicZu9CSubb2WKmZHE/aCS37Z/BtxU+GYHTD6RX1jiuk0XQqY44m3vBcReT3M2ZWkeW0ai9S5BBQpVfhZi5D9qNrm/xsfL8CI67rxStz0mY7zUpb+LEFP1trlHj5R6BCTJloU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659346485; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=twn2Lmq1bFRdVMBDpvfp6I4loDJxtbWcsNoYD2aHONg=; 
        b=NypD12WMFZg8wntI1tSrPJ1yfVOd0CUMb1OGBHYlMltXv9S4G7TJyBOza1XFx/EvxChMiEB/hlLYFl+trg6eQX1KKYaQp+7zs4MYiMAhvXd0wObzToFNy7MHr1R+2+cyL7iZr7uSJhUOsNKI71ZszUYpSvIU0QqQzBRihOL7WhY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659346485;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=twn2Lmq1bFRdVMBDpvfp6I4loDJxtbWcsNoYD2aHONg=;
        b=e46cK0mKtBWMVu0xfepZMEMpuLyj/VpdL/YZutGDBZ70FCYq7sI3nDZtaj39aM/X
        ofMRfuiK9R5a8fwxswyiOJruXx+52OBBxbJGt1WeA5hHiNcLMtfcvWHPxNVGZoPa3as
        5QTGR3a4iLouam3PWtoPTLjA8UIh/gsg3QDcgQyc=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659346473940787.6963523925439; Mon, 1 Aug 2022 15:04:33 +0530 (IST)
Date:   Mon, 01 Aug 2022 15:04:33 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Dipanjan Das" <mail.dipanjan.das@gmail.com>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <18258c1d370.6c4bec7a269297.4170944235031209431@siddh.me>
In-Reply-To: <20220728155121.12145-1-code@siddh.me>
References: <20220728155121.12145-1-code@siddh.me>
Subject: Re: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dipanjan,

It would be nice if you could test this patch and tell if it fixes the
issue on v5.10, as you had reported it earlier.

Please apply the following commits before applying this patch:
db8facfc9faf ("watch_queue, pipe: Free watchqueue state after clearing pipe ring")
353f7988dd84 ("watchqueue: make sure to serialize 'wqueue->defunct' properly")

I have tested locally on tag v5.10, using the reproducer available on
syzkaller dashboard. The crash occurred when the patches weren't applied,
and it no longer occurs after applying the three patches.

Thanks,
Siddh

> If not done, a reference to a freed pipe remains in the watch_queue,
> as this function is called before freeing a pipe in free_pipe_info()
> (see line 834 of fs/pipe.c).
> 
> This causes a UAF when post_one_notification() tries to access the pipe
> on a key update, which is reported by syzbot.
> 
> We also need to use READ_ONCE() in post_one_notification() to prevent the
> compiler from optimising and loading a non-NULL value from wqueue->pipe.
> 
> Bug report: https://syzkaller.appspot.com/bug?id=1870dd7791ba05f2ea7f47f7cbdde701173973fc
> Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
> Changes in v3:
> - Restore the original unlock order, and clear before unlock.
> - Use READ_ONCE() in post path.
> 
> This was explained by David Howells <dhowells@redhat.com> in
> reply to v1. Not added Suggested-by since he didn't reply yet.
> 
> Changes in v2:
> - Removed the superfluous ifdef guard.
> 
>  kernel/watch_queue.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> index bb9962b33f95..617425e34252 100644
> --- a/kernel/watch_queue.c
> +++ b/kernel/watch_queue.c
> @@ -99,7 +99,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
>  				  struct watch_notification *n)
>  {
>  	void *p;
> -	struct pipe_inode_info *pipe = wqueue->pipe;
> +	struct pipe_inode_info *pipe = READ_ONCE(wqueue->pipe);
>  	struct pipe_buffer *buf;
>  	struct page *page;
>  	unsigned int head, tail, mask, note, offset, len;
> @@ -637,6 +637,12 @@ void watch_queue_clear(struct watch_queue *wqueue)
>  		spin_lock_bh(&wqueue->lock);
>  	}
>  
> +	/* Clearing the watch queue, so we should clean the associated pipe. */
> +	if (wqueue->pipe) {
> +		wqueue->pipe->watch_queue = NULL;
> +		wqueue->pipe = NULL;
> +	}
> +
>  	spin_unlock_bh(&wqueue->lock);
>  	rcu_read_unlock();
>  }
> -- 
> 2.35.1

