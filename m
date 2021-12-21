Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2457A47C8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbhLUVbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:31:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42392 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbhLUVbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:31:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C371C617AF;
        Tue, 21 Dec 2021 21:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A4EC36AE8;
        Tue, 21 Dec 2021 21:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640122279;
        bh=/qM5xHCT4LRaktft7rjFAPqdkqB1j9+h9rt9Y06i7Sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwLvcrbeeZx5Z0TOqt6iQHWvx1wwiMn/dvWJZR/lJgltanuJ83nTstkFFvsBPyo2f
         FHxer0t72xeUNoI5HKFCTGEdIertrZctkoJAw1lDsSrzKnf9f7xqRiXKYuqGa+sb4S
         oVfkveJvHR/oFsueEulc4DOb0i3JC7dfq080qGXejYq6vsvjH8HTK0uxp72mHbWLe3
         70YJhHW5MQ/QBhMRm+cgScRUPIxo9TQNPBVtTORVh8WHq9T6+ZbhYk3YAx+w02anLX
         s907LuZ3M2Kk4ozXbjP4MbBc1g2o8c2Ws9UuZxhcxbEGSTd1/UTsd4Wt+WBJpjNFFj
         Ky00r1BepVfUA==
Date:   Tue, 21 Dec 2021 14:31:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     trix@redhat.com
Cc:     wangzhou1@hisilicon.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, ndesaulniers@google.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] crypto: cleanup warning in qm_get_qos_value()
Message-ID: <YcJHoqXXVFZatIla@archlinux-ax161>
References: <20211221205953.3128923-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221205953.3128923-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 12:59:53PM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Building with clang static analysis returns this warning:
> 
> qm.c:4382:11: warning: The left operand of '==' is a garbage value
>         if (*val == 0 || *val > QM_QOS_MAX_VAL || ret) {
>             ~~~~ ^
> 
> The call to qm_qos_value_init() can return an error without setting
> *val.  So check ret before checking *val.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Should this have a fixes tag?

Fixes: 72b010dc33b9 ("crypto: hisilicon/qm - supports writing QoS int the host")

> ---
>  drivers/crypto/hisilicon/qm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index b1fe9c7b8cc89..c906f2e59277b 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -4379,7 +4379,7 @@ static ssize_t qm_get_qos_value(struct hisi_qm *qm, const char *buf,
>  		return -EINVAL;
>  
>  	ret = qm_qos_value_init(val_buf, val);
> -	if (*val == 0 || *val > QM_QOS_MAX_VAL || ret) {
> +	if (ret || *val == 0 || *val > QM_QOS_MAX_VAL) {
>  		pci_err(qm->pdev, "input qos value is error, please set 1~1000!\n");
>  		return -EINVAL;
>  	}
> -- 
> 2.26.3
> 
