Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0859F5908E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiHKXEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbiHKXEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:04:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8FC6E2DD
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:04:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id z19so18184089plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XV3d3jsQUJYVJchztvaIBQqSUAMrrh69qI/8EtCuYe4=;
        b=tAYpw4CDkWc6eiIf/KCP+KBGnVlg8ib0fvqDt5ayrPmOQ3UDOO3arWXihLT3hSbZKj
         1pdlYcKzB+T4+SasFbEJMHOq/hP4vIojAIE07EA0aHkak71KSWZBqg5GapGWPMtJLR+T
         GWQhqJ6aYuIolDRFFAQSA5ibYCoyfDyxmshgkCAZsT/x/Gq39TTr0V8mlZWHQNlKK+bo
         VtX3WQYPMJWzrLJmDLGqRrEz1l878YJIcYf9Aei5WQqWVRInY6G8UDjqe/rXnqPky2As
         vI59jAUyB/EIs2MwGoH2eStvS3NW2P0nzF4GRBOzPfpXoAezr8zzT3N5KjemNsHcQkk4
         GAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XV3d3jsQUJYVJchztvaIBQqSUAMrrh69qI/8EtCuYe4=;
        b=EMDik8gpejwdf7CH1rDxV08ZJYUuhnUWVce0HSfRWJsfSg9gs1j0Qkh1u6EBdtczcQ
         t4rD3NE+dXz8G6bX/7vYDaAuhnhKGqOP8yk41fgxH59iEUdFS2BSqKiha4zbhj3rGcfY
         mLHd1HdmGPTvES2Iaf4xGyzn7Yab5z1TnsNhSZ6a3TJ9LBiE1CRqMQv312MAY3fzCDBm
         /swFMYGOOGtQpbmkexjoQvs3C5JoeitXxclIdgzmc0UalztW5YLx1ewq1D/jNv2q2ZPL
         7N6+F4IOrMKxmh9GkqP6rMAPOpX56sHe5uUk74gHIfCO4P/4eJvlxYHwCmeeYtPoKkuQ
         hsgw==
X-Gm-Message-State: ACgBeo3BLJBVR7tEuDUT7RQSdeSpKbpIqb5cT+3x5gbA1y+M7xxqW+NP
        Izz71iitZzEFB8g0EAF+JaE1ag==
X-Google-Smtp-Source: AA6agR7c5ZybC8xsrpjrvhBO6n0LEHYhEqXt4UG2OAj9R+Pf2rUxq/CaSStiRwn5gSOKfUmkZxXwJA==
X-Received: by 2002:a17:90a:b00b:b0:1f1:6023:dacd with SMTP id x11-20020a17090ab00b00b001f16023dacdmr10643291pjq.184.1660259043795;
        Thu, 11 Aug 2022 16:04:03 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w186-20020a627bc3000000b005289ef6db79sm232168pfc.32.2022.08.11.16.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 16:04:03 -0700 (PDT)
Message-ID: <05cfb9dc-c740-5764-35f9-b5636e0577cb@kernel.dk>
Date:   Thu, 11 Aug 2022 17:04:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] virtio-blk: Avoid use-after-free on suspend/resume
Content-Language: en-US
To:     Shigeru Yoshida <syoshida@redhat.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        suwan.kim027@gmail.com
References: <20220810160948.959781-1-syoshida@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220810160948.959781-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 10:09 AM, Shigeru Yoshida wrote:
> +static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct virtio_blk *vblk = hctx->queue->queuedata;
> +	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> +
> +	return vq;
> +}

Would probably be cleaner as:

static struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
{
	struct virtio_blk *vblk = hctx->queue->queuedata;

	return &vblk->vqs[hctx->queue_num];
}

dropping the 'vq' variable, and also dropping the inline as the compiler
will work that out anyway.

Apart from that minor nit, looks good to me.

-- 
Jens Axboe

