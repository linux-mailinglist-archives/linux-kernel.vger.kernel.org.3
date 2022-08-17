Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E5596C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiHQJoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiHQJoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:44:17 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BC9DEFA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:44:15 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so670863wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=aVMCiEk+A4c+kqJFw5Jb0nwzc/UspXelbSIOACaw1vs=;
        b=A3uhbQs2b9+akzphzrl6uTpE1ERYj/m53htLOHmsAOKPbKdGLjuswpJNJ/8o1t/Sv2
         rtWqmURrVSS5k0QfswgswBfzg64/m1+vMEw/EnJaZpFQhBYs3C/KYTs30DQP3/EOOlmD
         pcFaN+o+vZ761/Ba0t5b/X5CTMLXTVR4NStSEVu4KYW8fbC2uoAImb/tdBz9UBKLShoY
         EYl4t7Up5bYo+NOC1zBysaQoxbeNiuArlFtcr+zb73SEbG9qcPvaFOGCuKQsPl9PENyX
         Am39R/iLRcNxX/svtn4JeEdq/9wtk5Va60Lav3bzoVbPkw5sjHpQB6BN2kHya6v4s2S9
         S5Bw==
X-Gm-Message-State: ACgBeo3ej0+B3ucAMzXmnt3mrnJZmDm9pplP2xMuMaaZ7/p7FJ+mDGk6
        8QTffe7dzqVQjJ5U04Fy7WdPpyueEEw=
X-Google-Smtp-Source: AA6agR74ePA+XDQzrtfqZzQO/yTSw7tCdII0WQN48k8WZBTN3DqWK7+fhFhWvr+djBI9CoPJiFfFVg==
X-Received: by 2002:a05:600c:b57:b0:3a5:3c06:f287 with SMTP id k23-20020a05600c0b5700b003a53c06f287mr1522776wmr.148.1660729454251;
        Wed, 17 Aug 2022 02:44:14 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5306000000b0021e519eba9bsm11893995wrv.42.2022.08.17.02.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 02:44:11 -0700 (PDT)
Message-ID: <c11e62ae-3439-e3e3-adba-d7f5f951791c@grimberg.me>
Date:   Wed, 17 Aug 2022 12:44:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
References: <20220816091808.23236-1-fmdefrancesco@gmail.com>
 <YvvpJbOT9iv6rnm2@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YvvpJbOT9iv6rnm2@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Therefore, I have two questions: am I right about thinking that the pages
>> mapped in nvmet_tcp_map_pdu_iovec() are allocated with GFP_KERNEL?
> 
> I think you are correct.

It is correct. It is the same model for the linux scsi target, sunrpc
etc.

>> If so, can anyone with more knowledge than mine please say if my changes make
>> any sense?
> 
> I think it does make sense. I like the code simplification, though this use
> was't really paying the kmap penalty since, as you mentioned, this is never
> highmem.

Yes, its the same code-path. Would be great if we still had an
abstraction that would do the right thing regardless of highmem or
not like kmap provides though.

> You should also remove the cmd's 'nr_mapped' field while you're at it,
> otherwise you'll hit the WARN in nvmet_tcp_free_cmd_buffers().

Not remove nr_mapped because we use it to know the iovec entries, but
we can just remove the WARN statement.
