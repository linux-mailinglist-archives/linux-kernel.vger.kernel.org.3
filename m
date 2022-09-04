Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD535AC378
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 10:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiIDIj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 04:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDIjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 04:39:55 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6170618360;
        Sun,  4 Sep 2022 01:39:53 -0700 (PDT)
Received: from [192.168.230.80] (unknown [182.2.71.200])
        by gnuweeb.org (Postfix) with ESMTPSA id 2D7AB804D1;
        Sun,  4 Sep 2022 08:39:49 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662280792;
        bh=awbFdPWx5OJ12EhTNx9Kf8fsQ9KbanR2HansLBdvSz4=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=lZQdqIM/0i0vUqj7d4xtqKLoB0yIf+/cm23eWgvoF/Wk73YvxJR+TMtgI+oJxImGD
         W74DTTYJHtp34cn7l5ZJAZJv3cA5UIsEzZxymJbfTDBYe8D6LaMH9EiSioSug9I5qx
         dibMA/zIefYeTrDkC1eRVhlB1WsMC999tdBqiK1PZ034afqdoh1lgCFOd+ccx21mey
         Sum6tZzHoVbGfKArrdF8O72Yz1UEt37E9gZrpDLYjEqiu5L1bO4DFyn2N0nN3Yhpzu
         S/2YyhbK0/b1EWB2XLtUo1sP/CYdz6BKBX9WKX+MpmZbmC3qts5qtIh2ZptP1fGIoE
         rMQkDzBH6LyXA==
Message-ID: <cbd29bbc-09d6-efb7-fa3f-88ae5e1796ef@gnuweeb.org>
Date:   Sun, 4 Sep 2022 15:39:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Binyi Han <dantengknight@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Linux Memory Management Mailing List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20220904074647.GA64291@cloud-MacBookPro>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] mm: fix dereferencing possible ERR_PTR
In-Reply-To: <20220904074647.GA64291@cloud-MacBookPro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/22 2:46 PM, Binyi Han wrote:
> Smatch checker complains that 'secretmem_mnt' dereferencing possible
> ERR_PTR().
> Let the function return if 'secretmem_mnt' is ERR_PTR, to avoid
> deferencing it.
> 
> Signed-off-by: Binyi Han <dantengknight@gmail.com>
> ---

Fixes: 1507f51255c9ff07d75909a84e7c0d7f3c4b2f49 ("mm: introduce memfd_secret system call to create "secret" memory areas")

>   mm/secretmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index e3e9590c6fb3..3f7154099795 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -285,7 +285,7 @@ static int secretmem_init(void)
>   
>   	secretmem_mnt = kern_mount(&secretmem_fs);
>   	if (IS_ERR(secretmem_mnt))
> -		ret = PTR_ERR(secretmem_mnt);
> +		return PTR_ERR(secretmem_mnt);
>   
>   	/* prevent secretmem mappings from ever getting PROT_EXEC */
>   	secretmem_mnt->mnt_flags |= MNT_NOEXEC;

I agree that doing:

    secretmem_mnt->mnt_flags |= MNT_NOEXEC;

when IS_ERR(secretmem_mnt) evaluates to true is wrong. But I have
a question: what happen if you invoke memfd_secret() syscall when
@secretmem_mnt is an ERR_PTR?

Shouldn't we also guard the memfd_secret() path?

diff --git a/mm/secretmem.c b/mm/secretmem.c
index e3e9590c6fb3..2d52508d47a9 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -230,18 +230,21 @@ static struct file *secretmem_file_create(unsigned long flags)
  
  SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
  {
  	struct file *file;
  	int fd, err;
  
  	/* make sure local flags do not confict with global fcntl.h */
  	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
  
+	if (IS_ERR(secretmem_mnt))
+		return PTR_ERR(secretmem_mnt);
+
  	if (!secretmem_enable)
  		return -ENOSYS;
  
  	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
  		return -EINVAL;
  	if (atomic_read(&secretmem_users) < 0)
  		return -ENFILE;
  
  	fd = get_unused_fd_flags(flags & O_CLOEXEC);


-- 
Ammar Faizi
