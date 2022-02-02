Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47B64A781E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiBBSlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:41:05 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37510 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbiBBSlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:41:03 -0500
Received: by mail-pg1-f180.google.com with SMTP id e16so256806pgn.4;
        Wed, 02 Feb 2022 10:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4SeKf0Pv3KI7vfINkFZfYLytziKJBKAleO/0SVcLdYY=;
        b=ZuWuI9db92GS8ouskq74uFfOm27ZtZdXqdwS/nnq8rqfNuQZWKqJjcAPc+4+ksdAB7
         txnFBHGwvJ3/1s1SfJ2YrJCrEJxEDYjLievwD7uqHDuDcZOarDGtBXXzf8F3rWqKKabG
         ERRLpSdPHOofEv6i8nx6gLLyXDkySs/0WOCeQKRU5FHHotLTtBYNLxZBgOFcq4RORzni
         ZKADn7sSBdPNpvJ8ZHQLCdDIW7hl+4yPTqBdE+9A8GOqdoxuDER+IsMbbvHdIWfcYmGC
         p0ipRKz6pLYFyubJ8vnd4gMMqDRSYobs2LPqIyWwaT0PPSPdGtOIkko9Okjz7m5M+rzF
         ZGeQ==
X-Gm-Message-State: AOAM530AY5/nEktDkd11p+RguJHywwoYyNUr4IXEn/2u1yqt1qFJxOkj
        hA09emXgm/49Zb3EAoeYk6Y=
X-Google-Smtp-Source: ABdhPJxKTvuMXBDvU4qW2/15ak/LKcMtqbqZF8vB1gLRYjaQ1c1OMJyU+DSvLA0785Up6vFD7FG4mg==
X-Received: by 2002:a63:6844:: with SMTP id d65mr12349403pgc.56.1643827263302;
        Wed, 02 Feb 2022 10:41:03 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j10sm26668742pfu.93.2022.02.02.10.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 10:41:02 -0800 (PST)
Message-ID: <60060901-acd0-5b39-6d0f-13b0359b756d@acm.org>
Date:   Wed, 2 Feb 2022 10:40:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv2 6/7] block: add pi for nvme enhanced integrity
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-7-kbusch@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220201190128.3075065-7-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 11:01, Keith Busch wrote:
> +			ref = get_unaligned_be48(pi->ref_tag);
> +			seed = iter->seed & 0xffffffffffffull;

The "& 0xffffffffffffull" operation occurs three times in this patch. 
Has it been considered to introduce a lower_48_bits() function?

Thanks,

Bart.
