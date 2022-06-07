Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC61D5403AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbiFGQWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344953AbiFGQWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:22:41 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90AA63B8;
        Tue,  7 Jun 2022 09:22:34 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 98938255B;
        Tue,  7 Jun 2022 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1654618915;
        bh=irHcnff1wq9PsQ/ooZgwpGjN4eo9539UTqaoXdp+yZM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=RyjHxpnZI5dvE9YplBk3xvaTo2NI1eh/x14lJCEoBOJVxmqU7PjnKjM9V6LKGPBnj
         4YzQM7LlXpBE8PzJHVBCh0QKmPmdoEO6ZWjqGbP6C4hNW7zOn8+SKn1dzucoNObJhF
         1I4Z2gNobFI4cjiCRm0V63wWDX7M8rLpYFSjMRzw=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id A8B462144;
        Tue,  7 Jun 2022 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1654618952;
        bh=irHcnff1wq9PsQ/ooZgwpGjN4eo9539UTqaoXdp+yZM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jlaRx3pBEkdB2/ZiAEJKNHge609MRLnrknR9OgcnwIUIxBx7GHR95VeNcV5FFMYQC
         IwY3YOmnZY+ZDdO9QZf8il6ZCdDTasUdC9U0jtU9VOzCtciDOc94/Sjz5OyIVou5rz
         XgTliCaHuKppKheWt3+n/gr4rA7tuv/o7i6uIXZ0=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 7 Jun 2022 19:22:32 +0300
Message-ID: <4d81ad89-57c4-88a9-8730-14c0fd9bb075@paragon-software.com>
Date:   Tue, 7 Jun 2022 19:22:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] fs/ntfs3: remove redundant assignment to variable frame
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>, <ntfs3@lists.linux.dev>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
References: <20211230155952.379721-1-colin.i.king@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20211230155952.379721-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/21 18:59, Colin Ian King wrote:
> Variable frame is assigned a value that is never read. The
> assignment is redundant and can be removed. Cleans up the
> clang-scan build warning:
> 
> fs/ntfs3/file.c:995:3: warning: Value stored to 'frame' is
> never read [deadcode.DeadStores]
>                  frame = pos >> frame_bits;
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   fs/ntfs3/file.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 3bae76930e68..27c32692513c 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -992,7 +992,6 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
>   		if (bytes > count)
>   			bytes = count;
>   
> -		frame = pos >> frame_bits;
>   		frame_vbo = pos & ~(frame_size - 1);
>   		index = frame_vbo >> PAGE_SHIFT;
>   

Applied, thanks!
