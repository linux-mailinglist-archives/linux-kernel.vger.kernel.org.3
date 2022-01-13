Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD0F48DB75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiAMQPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiAMQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:15:51 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0750C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:15:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s30so21276978lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=P30buJ9zTKX2oMltZeLL1gii6E0J/tz8ywcKKeV0WcQ=;
        b=f0glXzP4Db4lxpUf8U3jWYPcwcLcztxFLSchBXl57CS3fzjuOntk5D2/ODg+GKdCJv
         l0fLLfDqoEF9pcY7GakeCc1cc/Az+ljiPMczQcDCYI3xZmPKoy3VbPzc5D8QYzgAt/0+
         SwH28e/TipwCvVHXnwfOdKG9nt7GP2LawgXfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=P30buJ9zTKX2oMltZeLL1gii6E0J/tz8ywcKKeV0WcQ=;
        b=SLA/vGepkZQ/DpSs0EOQwOLFDLx02xGlNodElLr+kEA1B1hLDXJ+WjZESnxvpYQOSA
         dHRz46qr/EgKkuQeHnyJV8ZDcGxFAJF+lYJPQeWpVLCZ4VTWqOm0YN0fDyGmY+p6VJI1
         0FgtgpknIai7tGRBOYEG2gfvT8V1cZMPPOWoeTIwRn8Joe+LxPmE9LTxbyhR54qO5rPv
         FTG6WNA56uGuFc2cJPWYdQ97zbSYbhIVBOvqY0J5OgmyH15UERjYj6b2u5n5CudgENM6
         s88UB2o0PFeR2IDEqglv9KmLeYlI8BqjpzAWH+kXcKsjFhPCN/WPrA5fzVghHQIB6FOk
         Oyfg==
X-Gm-Message-State: AOAM531kHFI3aLf1mMhScu8ixd2377aKsqY3RF9bE3YSIZ3mrW07uQs/
        ov6X3BT4iyde5j69TDlwWbPOaQ==
X-Google-Smtp-Source: ABdhPJwYtJwqidUbknWoE+1E/7wgTDpZW+WAd26oe06V1QgXGSLsj+GZ7GgMEVutNVlrQ2zOVdhbPg==
X-Received: by 2002:ac2:4c22:: with SMTP id u2mr3662789lfq.390.1642090549241;
        Thu, 13 Jan 2022 08:15:49 -0800 (PST)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0e00.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id u7sm307159ljd.30.2022.01.13.08.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:15:48 -0800 (PST)
References: <20220113090029.1055-1-zhudi2@huawei.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Di Zhu <zhudi2@huawei.com>
Cc:     ast@kernel.org, davem@davemloft.net, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, luzhihao@huawei.com,
        rose.chen@huawei.com
Subject: Re: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
In-reply-to: <20220113090029.1055-1-zhudi2@huawei.com>
Date:   Thu, 13 Jan 2022 17:15:48 +0100
Message-ID: <8735lrpq6j.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 10:00 AM CET, Di Zhu wrote:
> Right now there is no way to query whether BPF programs are
> attached to a sockmap or not.
>
> we can use the standard interface in libbpf to query, such as:
> bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
> the mapFd is the fd of sockmap.
>
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h  |  9 +++++
>  kernel/bpf/syscall.c |  5 +++
>  net/core/sock_map.c  | 78 ++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 85 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6e947cd91152..c4ca14c9f838 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2071,6 +2071,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
>  int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
>  int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
>  int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
> +int sock_map_bpf_prog_query(const union bpf_attr *attr,
> +			    union bpf_attr __user *uattr);
> +
>  void sock_map_unhash(struct sock *sk);
>  void sock_map_close(struct sock *sk, long timeout);
>  #else
> @@ -2124,6 +2127,12 @@ static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline int sock_map_bpf_prog_query(const union bpf_attr *attr,
> +					  union bpf_attr __user *uattr)
> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_BPF_SYSCALL */
>  #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index fa4505f9b611..9e0631f091a6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3318,6 +3318,11 @@ static int bpf_prog_query(const union bpf_attr *attr,
>  	case BPF_FLOW_DISSECTOR:
>  	case BPF_SK_LOOKUP:
>  		return netns_bpf_prog_query(attr, uattr);
> +	case BPF_SK_SKB_STREAM_PARSER:
> +	case BPF_SK_SKB_STREAM_VERDICT:
> +	case BPF_SK_MSG_VERDICT:
> +	case BPF_SK_SKB_VERDICT:
> +		return sock_map_bpf_prog_query(attr, uattr);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 1827669eedd6..a424f51041ca 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1416,38 +1416,50 @@ static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
>  	return NULL;
>  }
>
> -static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> -				struct bpf_prog *old, u32 which)
> +static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog ***pprog,
> +				u32 which)
>  {
>  	struct sk_psock_progs *progs = sock_map_progs(map);
> -	struct bpf_prog **pprog;
>
>  	if (!progs)
>  		return -EOPNOTSUPP;
>
>  	switch (which) {
>  	case BPF_SK_MSG_VERDICT:
> -		pprog = &progs->msg_parser;
> +		*pprog = &progs->msg_parser;
>  		break;
>  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>  	case BPF_SK_SKB_STREAM_PARSER:
> -		pprog = &progs->stream_parser;
> +		*pprog = &progs->stream_parser;
>  		break;
>  #endif
>  	case BPF_SK_SKB_STREAM_VERDICT:
>  		if (progs->skb_verdict)
>  			return -EBUSY;
> -		pprog = &progs->stream_verdict;
> +		*pprog = &progs->stream_verdict;
>  		break;
>  	case BPF_SK_SKB_VERDICT:
>  		if (progs->stream_verdict)
>  			return -EBUSY;
> -		pprog = &progs->skb_verdict;
> +		*pprog = &progs->skb_verdict;
>  		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
>
> +	return 0;
> +}
> +
> +static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> +				struct bpf_prog *old, u32 which)
> +{
> +	struct bpf_prog **pprog;
> +	int ret;
> +
> +	ret = sock_map_prog_lookup(map, &pprog, which);
> +	if (ret)
> +		return ret;
> +
>  	if (old)
>  		return psock_replace_prog(pprog, prog, old);
>
> @@ -1455,6 +1467,58 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
>  	return 0;
>  }
>
> +int sock_map_bpf_prog_query(const union bpf_attr *attr,
> +			    union bpf_attr __user *uattr)
> +{
> +	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
> +	u32 prog_cnt = 0, flags = 0, ufd = attr->target_fd;
> +	struct bpf_prog **pprog;
> +	struct bpf_prog *prog;
> +	struct bpf_map *map;
> +	struct fd f;
> +	u32 id = 0;
> +	int ret;
> +
> +	if (attr->query.query_flags)
> +		return -EINVAL;
> +
> +	f = fdget(ufd);
> +	map = __bpf_map_get(f);
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	rcu_read_lock();
> +
> +	ret = sock_map_prog_lookup(map, &pprog, attr->query.attach_type);
> +	if (ret)
> +		goto end;
> +
> +	prog = *pprog;
> +	prog_cnt = !prog ? 0 : 1;
> +
> +	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
> +		goto end;
> +
> +	id = prog->aux->id;

^ This looks like a concurrent read/write.

Would wrap with READ_ONCE() and corresponding WRITE_ONCE() in
bpf_prog_free_id(). See [1] for rationale.

[1] https://github.com/google/kernel-sanitizers/blob/master/other/READ_WRITE_ONCE.md

> +
> +	/* we do not hold the refcnt, the bpf prog may be released
> +	 * asynchronously and the id would be set to 0.
> +	 */
> +	if (id == 0)
> +		prog_cnt = 0;
> +
> +end:
> +	rcu_read_unlock();
> +
> +	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)) ||
> +	    (id != 0 && copy_to_user(prog_ids, &id, sizeof(u32))) ||
> +	    copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt)))
> +		ret = -EFAULT;
> +
> +	fdput(f);
> +	return ret;
> +}
> +
>  static void sock_map_unlink(struct sock *sk, struct sk_psock_link *link)
>  {
>  	switch (link->map->map_type) {
