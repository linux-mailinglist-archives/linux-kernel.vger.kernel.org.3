Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9259547CAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbhLVBqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:46:20 -0500
Received: from p3plsmtp16-03-2.prod.phx3.secureserver.net ([173.201.193.58]:34269
        "EHLO p3plwbeout16-03.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhLVBqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:46:19 -0500
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Dec 2021 20:46:19 EST
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id zqaLmocrca06VzqaMmDCZV; Tue, 21 Dec 2021 18:38:30 -0700
X-CMAE-Analysis: v=2.4 cv=E7MIGYRl c=1 sm=1 tr=0 ts=61c28196
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=IOMw9HtfNCkA:10
 a=mr8mJ_Mg9M5BUJlPZpQA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  zqaLmocrca06V
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp05.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1mzqaK-0003ER-No; Wed, 22 Dec 2021 01:38:29 +0000
Message-ID: <91a4bb22-0144-f8d8-86be-62c593e77cb6@squashfs.org.uk>
Date:   Wed, 22 Dec 2021 01:38:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fs/squashfs: handle possible null pointer
To:     Peng Hao <flyingpenghao@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20211221020347.46021-1-flyingpeng@tencent.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20211221020347.46021-1-flyingpeng@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfGhfW3/a30k6gJ3OH0EkNdC4ImUsvpet9/Ib1NdUq9bzV6owkpCYsCHJE0wF7V7P7KMh/BJF0uesilnR3qTJA2/TwUnztqvXjmyYeXw5Hv3VThFvA+qZ
 daEfZ32XZPn0OZ2CQVWJx5F9zAiE9ikImPMzZr+S8RENu3AvhejfHPjo3nAUW1OuSHLnUQ6ezcAGmTrJuAk08bpQJvEuXy44eXU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2021 02:03, Peng Hao wrote:
>   in squashfs_fill_super:
> 
>          msblk->decompressor = supported_squashfs_filesystem(
>                          fc,
>                          le16_to_cpu(sblk->s_major),
>                          le16_to_cpu(sblk->s_minor),
>                          le16_to_cpu(sblk->compression));
>          if (msblk->decompressor == NULL)
>                  goto failed_mount;
>          ...
> 
> failed_mount:
> 	...
> 	squashfs_decompressor_destroy(msblk);
> 
> in squashfs_decompressor_destroy:
> 	if (stream) {
>          	msblk->decompressor->free(stream->stream);
> msblk->decompressor is NULL.
> 
> so add a judgment whether a null pointer.

NACK.

The NULL pointer dereference (msblk->decompressor) will not happen 
because stream (msblk->stream) is NULL (thus the code in question will 
not be executed).

At the start of the initialisation phase msblk is zeroed out

	sb->s_fs_info = kzalloc(sizeof(*msblk), GFP_KERNEL);
	if (sb->s_fs_info == NULL) {
		ERROR("Failed to allocate squashfs_sb_info\n");
		return -ENOMEM;
	}
	msblk = sb->s_fs_info;

Making msblk->decompressor and msblk->stream NULL.

msblk->decompressor is allocated first

	msblk->decompressor = supported_squashfs_filesystem(
			fc,
			le16_to_cpu(sblk->s_major),
			le16_to_cpu(sblk->s_minor),
			le16_to_cpu(sblk->compression));
	if (msblk->decompressor == NULL)
		goto failed_mount;

If that succeeds (msblk->decompressor != NULL), then msblk->stream is 
allocated

	msblk->stream = squashfs_decompressor_setup(sb, flags);
	if (IS_ERR(msblk->stream)) {
		err = PTR_ERR(msblk->stream);
		msblk->stream = NULL;
		goto insanity;
	}

Thus, in squashfs_decompressor_destroy() if stream (msblk->stream) is 
not NULL, then msblk->decompressor is also guaranteed to be not NULL.

Likewise if msblk->decompressor is NULL, then msblk->stream will also be 
NULL.

Or to put it another way, the decompressor is only destroyed if it was 
previously created (msblk->stream != NULL), and it will only have been 
created if msblk->decompressor is != NULL.

Phillip

