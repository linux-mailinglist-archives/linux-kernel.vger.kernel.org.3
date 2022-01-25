Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0622A49B90E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381044AbiAYQov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:44:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1585111AbiAYQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643128888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbY3XP61M3uD9sP2FFUZOwoizO9Z7SgKKtfr4x3BErc=;
        b=JcuEmNEHhX3Lsr5Bq7eKJGS+nXPeuky2yjqW85AGn4JuG1ja8e0uP3Psy9i/mPA7HiTzV2
        aqaMuqkhened1AL3gXHidVXGIjrCNgAdL3Qs6kbHKef6BEVUPsPEAgSGglMVEA75tNIeOC
        TpD0R7Hx1gdasdxWYerojXLbO5SUVeo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-PKz8F_BmM4KgvKXt6bWuLg-1; Tue, 25 Jan 2022 11:41:26 -0500
X-MC-Unique: PKz8F_BmM4KgvKXt6bWuLg-1
Received: by mail-ej1-f69.google.com with SMTP id v2-20020a1709062f0200b006a5f725efc1so3663436eji.23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GbY3XP61M3uD9sP2FFUZOwoizO9Z7SgKKtfr4x3BErc=;
        b=rgDSg9VFjG4zZxfz0Zlslf3SZlZq4sP0RvF2suL94Rq0Os6vKJfjoIdaAWb1XqzwwZ
         8IldeL+aWTwlh7wmMFq+b3MrWZVruCddatTXxP4Gw/QTAmwgdvp6Fg0QIwDjYEYmIgC3
         aPFELorDQB3euODta1A1NMP6HhIcdDkd4NCBA+u3x28lLhi/L5jDfpC/y/yUu/5eSTHp
         kU/a7uIWfBHt7CzB+49A25LHJj5+hO+J1pksxn1cetn9FRUtMzNK6XwOvZqeZgnw4WUm
         /In2wy7rS+GLX+f8LSMAPwNVZ9KCxkaydjzjJpP6e1T+OD/QRtsbbWrzBY+zuv4AH4qF
         BPpg==
X-Gm-Message-State: AOAM530opxOJ738lrI3R+05bC1q0U5UuECjDFcXvqEM+3GysvOTqAL2l
        AfsiS3kln+oCc6R9C5r7tF5GoKOozftdvkOGf2p3Co8eoxXse4MhNEXoDVGAfaYxTykJ+fxVqHc
        HcBTLBUh1tZcNbZJ/eeNxdwE8
X-Received: by 2002:a17:907:3f29:: with SMTP id hq41mr6272871ejc.358.1643128884403;
        Tue, 25 Jan 2022 08:41:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwg37J+bP3Vw6kcPaqHnw/mAqqdxblwP1MOYVrCrqDDNprj6rBqlub90ZLbiCa3i8cWgEnxKg==
X-Received: by 2002:a17:907:3f29:: with SMTP id hq41mr6272861ejc.358.1643128884190;
        Tue, 25 Jan 2022 08:41:24 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id a14sm8449020edx.96.2022.01.25.08.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:41:23 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:41:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 2/9] fprobe: Add ftrace based probe APIs
Message-ID: <YfAoMW6i4gqw2Na0@krava>
References: <164311269435.1933078.6963769885544050138.stgit@devnote2>
 <164311271777.1933078.9066058105807126444.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164311271777.1933078.9066058105807126444.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 09:11:57PM +0900, Masami Hiramatsu wrote:

SNIP

> +
> +/* Convert ftrace location address from symbols */
> +static int convert_func_addresses(struct fprobe *fp)
> +{
> +	unsigned long addr, size;
> +	unsigned int i;
> +
> +	/* Convert symbols to symbol address */
> +	if (fp->syms) {
> +		fp->addrs = kcalloc(fp->nentry, sizeof(*fp->addrs), GFP_KERNEL);
> +		if (!fp->addrs)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < fp->nentry; i++) {
> +			fp->addrs[i] = kallsyms_lookup_name(fp->syms[i]);
> +			if (!fp->addrs[i])	/* Maybe wrong symbol */
> +				goto error;
> +		}
> +	}
> +
> +	/* Convert symbol address to ftrace location. */
> +	for (i = 0; i < fp->nentry; i++) {
> +		if (!kallsyms_lookup_size_offset(fp->addrs[i], &size, NULL))
> +			size = MCOUNT_INSN_SIZE;
> +		addr = ftrace_location_range(fp->addrs[i], fp->addrs[i] + size);

you need to substract 1 from 'end' in here, as explained in
__within_notrace_func comment:

        /*
         * Since ftrace_location_range() does inclusive range check, we need
         * to subtract 1 byte from the end address.
         */

like in the patch below

also this convert is for archs where address from kallsyms does not match
the real attach addresss, like for arm you mentioned earlier, right?

could we have that arch specific, so we don't have extra heavy search
loop for archs that do not need it?

thanks,
jirka


---
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 4d089dda89c2..7970418820e7 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -91,7 +91,7 @@ static int convert_func_addresses(struct fprobe *fp)
 	for (i = 0; i < fp->nentry; i++) {
 		if (!kallsyms_lookup_size_offset(fp->addrs[i], &size, NULL))
 			size = MCOUNT_INSN_SIZE;
-		addr = ftrace_location_range(fp->addrs[i], fp->addrs[i] + size);
+		addr = ftrace_location_range(fp->addrs[i], fp->addrs[i] + size - 1);
 		if (!addr) /* No dynamic ftrace there. */
 			goto error;
 		fp->addrs[i] = addr;

