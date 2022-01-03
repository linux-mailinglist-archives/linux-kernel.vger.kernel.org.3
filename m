Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA8F4833AE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiACOmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:42:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39594 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiACOlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:41:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D32461008;
        Mon,  3 Jan 2022 14:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABF0C36AED;
        Mon,  3 Jan 2022 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641220899;
        bh=4JTAn+oXPiUaNWM422sVao4rTCjngd+iLZ/dqxekgLg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LXNBe0g0zLOE5mh8XBVCHX2034ix2yRSolX245OSa+aUDnk7Y/HcRj4tNrj8qnagS
         j1vTgkjouesj/wrcBVPEoXvaqsBUYK3t1IuRtHOmBeXB520DaKMP3adb1AWhMqmyB0
         OzX8oJuefqQS85pG7YFs7KkahITxCVNGfa9UMBdr64pI1jJwC/h2f82z+R+2WvW8ea
         RGasERkpLFxOG3IAUhcpCF3RGolZpEQRT/5pVBCQcXlvcBNzAUoFUUDV8R79tbPLKS
         wFdj/BbuDn5ETnyo6iCeW3UsDjqnmOx6q+nezG2J5Wcga6Y5XTpNjE7bN20zG2MJ+x
         w7R2lzgl7zwbQ==
Message-ID: <bc8803b511ed25ddc7091ba1f09f10ca415ca51e.camel@kernel.org>
Subject: Re: [PATCH] ceph: replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
From:   Jeff Layton <jlayton@kernel.org>
To:     cgel.zte@gmail.com
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Mon, 03 Jan 2022 09:41:37 -0500
In-Reply-To: <20211221143614.480385-1-deng.changcheng@zte.com.cn>
References: <20211221143614.480385-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-21 at 14:36 +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Fix the following coccicheck warning:
> ./fs/ceph/debugfs.c: 390: 0-23: WARNING: congestion_kb_fops should be
> defined with DEFINE_DEBUGFS_ATTRIBUTE
> 
> Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE for
> debugfs files.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  fs/ceph/debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 3cf7c9c1085b..64c4158c17c8 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -387,8 +387,8 @@ static int congestion_kb_get(void *data, u64 *val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
> -			congestion_kb_set, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
> +			 congestion_kb_set, "%llu\n");
>  
>  
>  void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)

Thanks, merged into our testing branch. This should make v5.17.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>
