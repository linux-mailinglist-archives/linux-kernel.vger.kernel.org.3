Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBBF46C1ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbhLGRkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbhLGRkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:40:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752D8C061574;
        Tue,  7 Dec 2021 09:36:41 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a9so30994961wrr.8;
        Tue, 07 Dec 2021 09:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a3zxNdfVlrqJM/GplmpbPoiA2qAHHXHO/zZh90BaEHU=;
        b=E5lKpb3vhHSuGisVdRa6wTrXBlzm+UHQSNVIT3A9bbLpPbwxnlWx0jfWvOTnL/DEj+
         0J89Dv1LCmYsbFsRCjVKwyTmI7JwOmq4JrCY6bDMjUtuBATEygHiMJoOriGihm9aCGnm
         HVAxfRHcJ4n2CdvTefeJ7jq1jQjRgAwQ1NjuCjo60gJIpXhxOkleYr/Jpcd8iCSQYfKs
         F4oHGljpvz+1Y5chJ7aBB2u5NcLh9H+qGHwmr77HGT5+zSqYnJepeNy9oBFMXeF+PTza
         SJ3oRhnXA4KwaIg4oB9DgqvwJ0xYY+WafBSTAHUZCK5yUAMKKuSuOlUh0gZJT4QkaoGA
         aRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a3zxNdfVlrqJM/GplmpbPoiA2qAHHXHO/zZh90BaEHU=;
        b=CwaAOQSpqpMizIOcLsBsTOiKKC2tJaY9S9T8N3kD3JzNvodlyUDgPSROkIIDpEuRYO
         En6l+1hOe5I+ozQ1safvA/4ZcF/Ly2HEYgVSnlukUVvX3CxvQz/3fehECU8AgVY0clOK
         HDLqNr/fToRDQN3HBgX3nWgnCSHHmpm/kdD0PJFQU9sA2yaklXs5IOLaFJHgQ8QmOfEV
         d0HqnBgD6rzBUa0MQntsJj3RB1NiYA5rdVNri2nt0bZHxD/89C/TEwi7EcNgJrd+BQL1
         Zi/IxIFrj7r0SkWzmicLH/GYOocOREVEoMDuw0NRN/4n4Lb12vyOB1JfVr8p/jXN5RAR
         2vaQ==
X-Gm-Message-State: AOAM531482SyPHPRCO4tdyxjHH3OkgzqzsH2rMDWpI4eUncoeOPUBwBG
        zK7hPNwkUwgOM8gffSTOLG+rbAMWbiE=
X-Google-Smtp-Source: ABdhPJxDtAZ5Ay3wLwPU3+O3McRLFyTMberw8gEw2xzruLB+PmktKIAlToGMhoAZ+LG4eaPKzC8H6g==
X-Received: by 2002:a5d:548b:: with SMTP id h11mr52995831wrv.11.1638898599733;
        Tue, 07 Dec 2021 09:36:39 -0800 (PST)
Received: from [192.168.8.198] ([148.252.132.245])
        by smtp.gmail.com with ESMTPSA id z18sm355250wrq.11.2021.12.07.09.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 09:36:39 -0800 (PST)
Message-ID: <95ea9142-9f36-981d-a04d-3efded544af7@gmail.com>
Date:   Tue, 7 Dec 2021 17:36:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/2] Revert "block: add single bio async direct IO helper"
 to avoid UAF
Content-Language: en-US
To:     George Kennedy <george.kennedy@oracle.com>,
        gregkh@linuxfoundation.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1638892302-14475-1-git-send-email-george.kennedy@oracle.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <1638892302-14475-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 15:51, George Kennedy wrote:
> git bisect shows that commit 54a88eb838d3
> ("block: add single bio async direct IO helper")
> causes the following UAF: KASAN: use-after-free Write in io_submit_one
> 
> Tried to root-cause the issue, but need the patch submitter's help in
> coming up with a fix.

Hey George, thanks for the report. Do you have a reproducer?

One spot I don't like is how errors from bio_iov_iter_get_pages()
are handled, will test it.

diff --git a/block/fops.c b/block/fops.c
index ad732a36f9b3..211f44974d1e 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -342,7 +342,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
  		if (unlikely(ret)) {
  			bio->bi_status = BLK_STS_IOERR;
  			bio_endio(bio);
-			return ret;
+			return -EIOCBQUEUED;
  		}
  	}
  	dio->size = bio->bi_iter.bi_size;


-- 
Pavel Begunkov
