Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438664764FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhLOVy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhLOVyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:54:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2D2C061574;
        Wed, 15 Dec 2021 13:54:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48AE161B05;
        Wed, 15 Dec 2021 21:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67352C36AE4;
        Wed, 15 Dec 2021 21:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639605263;
        bh=1oN5MbiWr8ncJJISL0YeC2irLttfEL4nIXiN8arS9kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fpb7hXGwN2dX+Kwe//hSaynEpB9Ur4A6oXW4ZZJcZ6ZN3NK2AZTuvCgQC4OR2bp/i
         4hhNG+BXhPpL3WScjLW4+gUUatMwp3+B86/BnL2afS6Nt+YSTsf+0fseMwkMuoP2w0
         O7kEQjMc7HU9o0CoojLop73+Mfo3zWeDSriOhjip3RaYE85SZKGQV3xA97WAG9hY9f
         7+4ugxvE7Ro4ymnwGVUpQUztJMNCGXSIhktEoaCP+2BoSz0PEsVXy01tGYhpBJ62mh
         d11dmRFKnY2vmIaxkB/MRNqwvivAN5GdO2MOHphh0XeWCHEib1UFatwGT31oBjLMKu
         Qy+pkK56XxNEQ==
Date:   Wed, 15 Dec 2021 16:00:04 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     paul@paul-moore.com, eparis@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next, v2] audit: use struct_size() helper in kmalloc()
Message-ID: <20211215220004.GA21862@embeddedor>
References: <20211215030420.72324-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215030420.72324-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:04:20AM +0800, Xiu Jianfeng wrote:
> Make use of struct_size() helper instead of an open-coded calculation.

I think you should also mention the flexible array transformation in
struct audit_rule_data.

Thanks
--
Gustavo

> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  include/uapi/linux/audit.h | 2 +-
>  kernel/audit.c             | 4 ++--
>  kernel/audit_tree.c        | 2 +-
>  kernel/auditfilter.c       | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 9176a095fefc..8eda133ca4c1 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -514,7 +514,7 @@ struct audit_rule_data {
>  	__u32		values[AUDIT_MAX_FIELDS];
>  	__u32		fieldflags[AUDIT_MAX_FIELDS];
>  	__u32		buflen;	/* total length of string fields */
> -	char		buf[0];	/* string fields buffer */
> +	char		buf[];	/* string fields buffer */
>  };
>  
>  #endif /* _UAPI_LINUX_AUDIT_H_ */
> diff --git a/kernel/audit.c b/kernel/audit.c
> index d4084751cfe6..7778eca34837 100644
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
> @@ -1459,7 +1459,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  			security_release_secctx(ctx, len);
>  		}
>  		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
> -				 sig_data, sizeof(*sig_data) + len);
> +				 sig_data, struct_size(sig_data, ctx, len));
>  		kfree(sig_data);
>  		break;
>  	case AUDIT_TTY_GET: {
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
> index 4173e771650c..42d99896e7a6 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -637,7 +637,7 @@ static struct audit_rule_data *audit_krule_to_data(struct audit_krule *krule)
>  	void *bufp;
>  	int i;
>  
> -	data = kmalloc(sizeof(*data) + krule->buflen, GFP_KERNEL);
> +	data = kmalloc(struct_size(data, buf, krule->buflen), GFP_KERNEL);
>  	if (unlikely(!data))
>  		return NULL;
>  	memset(data, 0, sizeof(*data));
> @@ -1092,7 +1092,7 @@ static void audit_list_rules(int seq, struct sk_buff_head *q)
>  				break;
>  			skb = audit_make_reply(seq, AUDIT_LIST_RULES, 0, 1,
>  					       data,
> -					       sizeof(*data) + data->buflen);
> +					       struct_size(data, buf, data->buflen));
>  			if (skb)
>  				skb_queue_tail(q, skb);
>  			kfree(data);
> -- 
> 2.17.1
> 
