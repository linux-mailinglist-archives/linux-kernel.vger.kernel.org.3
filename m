Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE5E55CBF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiF0ORi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbiF0ORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:17:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D0113F17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:17:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso2188255wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z6QEA8N2fEQzv1S4tlA6paW9O7X6dQLMNsP0wc/HP7s=;
        b=uPe74+/ly+UMX4CPKTPoTCSysd09kq6ElePcLvkN3BHQIUDPVKN/iclvrwHzcB+Gve
         +3RYNJUC4EBs85ofz36ifnr1kSj6JUBL0gmznsAKS2Us42FhQxSRJ8GJZHlWU++AFJhR
         qciHTjt2In5k37i2G74J8dMFAhtB8SCJBWrC1ielz30UDmlDpjlSgwnwx2XZLQlKo9O0
         PGjRkJePaH/xixuOVV5ZWvKIbM4Up9kW9q6p/gMUAnTLFhXlBo/GgcBIE40vE7niMosi
         6HmvJaT4JbOvAksvVi9GxR8yecXufZJSm6Ad0lafFkOKFdqFvwWaaHIMVNfNrP/galS3
         qXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z6QEA8N2fEQzv1S4tlA6paW9O7X6dQLMNsP0wc/HP7s=;
        b=X5FSCZIe9uQvCTpG7/wcBXIKh3E1crPT/WRr9Yc7wIoR2dENviTJclMMM19MIiNN7d
         +8ANrEqdo1Mhm8ygNCJjNA+4OR+ekVFe+oVCyrlMIIv8A+W1fD5SPlGKGiKwSH9/L652
         Fka2ztYRuZoAikkQ0DtjTlfNTaLHloBIavglYBJYzOYifY0FIq0O22eyfL5GlLVKh6j1
         NNk46491nOKPEtb4Dwi1iBOf9nH/T2cE9wyfAz3CS+rmdjBpyUArpNh4PpqgJaJsOA5Z
         KttEAV8LF+iEyrtxrgGSDNhO7rnRbM3EnYPfv+kVA+aAqHWOm9NALRuMKf7ZaQOIDG1W
         jVYA==
X-Gm-Message-State: AJIora+lAL/aqgRzVpyLAmOu6lTSo5MXUBjZwCn8bJr8u0ZZLRfbA7N6
        +aTjWg8wJgw2blEBu2qiKgZ8BrmBYZxxQg==
X-Google-Smtp-Source: AGRyM1sUUa25aokTh8//D/5KozJ829O+SuqtdxIljGwkDpsa/KC5DdNSc9Zz2uwc6cZM6qwVzhqy/A==
X-Received: by 2002:a05:600c:a02:b0:39c:97cc:82e3 with SMTP id z2-20020a05600c0a0200b0039c97cc82e3mr20504099wmp.97.1656339453354;
        Mon, 27 Jun 2022 07:17:33 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l4-20020a1c7904000000b003a04d19dab3sm2315371wme.3.2022.06.27.07.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:17:32 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:17:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org, stable@kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RESEND 1/1] Bluetooth: Use chan_list_lock to protect the whole
 put/destroy invokation
Message-ID: <Yrm7+nSB4QAK7zfN@google.com>
References: <20220622082716.478486-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220622082716.478486-1-lee.jones@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022, Lee Jones wrote:

> This change prevents a use-after-free caused by one of the worker
> threads starting up (see below) *after* the final channel reference
> has been put() during sock_close() but *before* the references to the
> channel have been destroyed.
> 
>   refcount_t: increment on 0; use-after-free.
>   BUG: KASAN: use-after-free in refcount_dec_and_test+0x20/0xd0
>   Read of size 4 at addr ffffffc114f5bf18 by task kworker/u17:14/705
> 
>   CPU: 4 PID: 705 Comm: kworker/u17:14 Tainted: G S      W       4.14.234-00003-g1fb6d0bd49a4-dirty #28
>   Hardware name: Qualcomm Technologies, Inc. SM8150 V2 PM8150 Google Inc. MSM sm8150 Flame DVT (DT)
>   Workqueue: hci0 hci_rx_work
>   Call trace:
>    dump_backtrace+0x0/0x378
>    show_stack+0x20/0x2c
>    dump_stack+0x124/0x148
>    print_address_description+0x80/0x2e8
>    __kasan_report+0x168/0x188
>    kasan_report+0x10/0x18
>    __asan_load4+0x84/0x8c
>    refcount_dec_and_test+0x20/0xd0
>    l2cap_chan_put+0x48/0x12c
>    l2cap_recv_frame+0x4770/0x6550
>    l2cap_recv_acldata+0x44c/0x7a4
>    hci_acldata_packet+0x100/0x188
>    hci_rx_work+0x178/0x23c
>    process_one_work+0x35c/0x95c
>    worker_thread+0x4cc/0x960
>    kthread+0x1a8/0x1c4
>    ret_from_fork+0x10/0x18
> 
> Cc: stable@kernel.org
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  net/bluetooth/l2cap_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This patch now passes all of the CI tests.

Except the check-patch/lint tests which return false positives.

Please consider for inclusion to remedy this serious bug.

TIA.

> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ae78490ecd3d4..82279c5919fd8 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -483,9 +483,7 @@ static void l2cap_chan_destroy(struct kref *kref)
>  
>  	BT_DBG("chan %p", chan);
>  
> -	write_lock(&chan_list_lock);
>  	list_del(&chan->global_l);
> -	write_unlock(&chan_list_lock);
>  
>  	kfree(chan);
>  }
> @@ -501,7 +499,9 @@ void l2cap_chan_put(struct l2cap_chan *c)
>  {
>  	BT_DBG("chan %p orig refcnt %u", c, kref_read(&c->kref));
>  
> +	write_lock(&chan_list_lock);
>  	kref_put(&c->kref, l2cap_chan_destroy);
> +	write_unlock(&chan_list_lock);
>  }
>  EXPORT_SYMBOL_GPL(l2cap_chan_put);
>  

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
