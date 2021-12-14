Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A205474A10
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhLNRtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhLNRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:49:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E181C061574;
        Tue, 14 Dec 2021 09:49:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BA3661624;
        Tue, 14 Dec 2021 17:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57007C34600;
        Tue, 14 Dec 2021 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639504149;
        bh=oeDtLufyp672o/5kLxPXZARCMSWw31bWlpxnaaqixMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ll/i3tbc90CkBStFvq9J+jIo2+0mtLIjhJtTxgITucPuW0p5jnAY1BDOy9vcYdw3c
         6rGTEF2v+zYJv3PcsoJNUS9pb/NYi9ah8L0Czd1/gsfIObPimVp+OVos8gQZsJezb1
         p98TcAtUxO9bY69ndp0vCpIutt6qjNJaE3eVmndBVBm+tI65Mllnwp+hwwcHMQD+1K
         G+bQ6JalHNlx96BRpccYtSCPbP105KCwoEMcieUAr6NLe24pYTQq/BNuiHA6cseM1A
         +rx1rDtce99SM9xTTGXr3DBD+7JfiVX1aTqClVBhTuJaR0BRZORUlDFGtQjLu5vGlz
         X1zVQDleoIlJw==
Date:   Tue, 14 Dec 2021 11:54:48 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     paul@paul-moore.com, eparis@redhat.com, keescook@chromium.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        wangweiyang2@huawei.com, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH -next] audit: use struct_size() helper in kmalloc()
Message-ID: <20211214175448.GA13107@embeddedor>
References: <20211214114854.133328-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214114854.133328-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 07:48:54PM +0800, Xiu Jianfeng wrote:
> Make use of struct_size() helper instead of an open-coded calucation.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/audit.c       | 2 +-
>  kernel/audit_tree.c  | 2 +-
>  kernel/auditfilter.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index d4084751cfe6..f33028578c60 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1446,7 +1446,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  			if (err)
>  				return err;
>  		}
> -		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
> +		sig_data = kmalloc(struct_size(sig_data, ctx, len), GFP_KERNEL);
>  		if (!sig_data) {
>  			if (audit_sig_sid)
>  				security_release_secctx(ctx, len);
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 72324afcffef..e7315d487163 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -94,7 +94,7 @@ static struct audit_tree *alloc_tree(const char *s)
>  {
>  	struct audit_tree *tree;
>  
> -	tree = kmalloc(sizeof(struct audit_tree) + strlen(s) + 1, GFP_KERNEL);
> +	tree = kmalloc(struct_size(tree, pathname, strlen(s) + 1), GFP_KERNEL);
>  	if (tree) {
>  		refcount_set(&tree->count, 1);
>  		tree->goner = 0;
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 4173e771650c..19352820b274 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -637,7 +637,7 @@ static struct audit_rule_data *audit_krule_to_data(struct audit_krule *krule)
>  	void *bufp;
>  	int i;
>  
> -	data = kmalloc(sizeof(*data) + krule->buflen, GFP_KERNEL);
> +	data = kmalloc(struct_size(data, buf, krule->buflen), GFP_KERNEL);

Why don't you also transform the zero-length array in struct
audit_rule_data into a flexible-array member:

508 struct audit_rule_data {
509         __u32           flags;  /* AUDIT_PER_{TASK,CALL}, AUDIT_PREPEND */
510         __u32           action; /* AUDIT_NEVER, AUDIT_POSSIBLE, AUDIT_ALWAYS */
511         __u32           field_count;
512         __u32           mask[AUDIT_BITMASK_SIZE]; /* syscall(s) affected */
513         __u32           fields[AUDIT_MAX_FIELDS];
514         __u32           values[AUDIT_MAX_FIELDS];
515         __u32           fieldflags[AUDIT_MAX_FIELDS];
516         __u32           buflen; /* total length of string fields */
517         char            buf[0]; /* string fields buffer */
518 };

Thanks
--
Gustavo

>  	if (unlikely(!data))
>  		return NULL;
>  	memset(data, 0, sizeof(*data));
> -- 
> 2.17.1
> 
> 
> 
> 
