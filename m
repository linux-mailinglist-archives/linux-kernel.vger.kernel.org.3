Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE554E606
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377576AbiFPP2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377879AbiFPP1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:27:49 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678BC237FC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:27:48 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a10so1816894ioe.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=upatriLmkO3sefxdPr9OKsvWnO7y75tD7XP4VtTCKA8=;
        b=0aISl+G8eIq7A8ZAxYGuTONwi911a0KTDFYa2Ba8tjGlempPy0Y4GLQevVM+uagLOX
         1gYBr1pxdL0s3ClG29zPK2GSBRghvvpsO/o30CbhqAiiNyD72PS8p44xSQs2xNla7lu8
         qf8ER/gUPEE1BJmDXSAbO4PXt4YCeVREGUJFpq4wt3s8oPooz0BTxBdbNXlKkAKSQyzs
         h8JR4CsShfdQ5iFlwWoTCVU+9mqKaJeycRZx0x47n/4EtIlNZ51Sh4PVAeYSPzsFd+5Z
         KgmLJz90llUBVYTYMbE1xXoDqf+N43mRiQs2YrJidVhV2vXTENPQjxrWqqvpyuPVufpl
         E3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=upatriLmkO3sefxdPr9OKsvWnO7y75tD7XP4VtTCKA8=;
        b=O7Y9G85f+cyNziWRQ2pvFIimRCd3HtSyfgMyHDX+dWIXMRTDF43PRkK0aqKKSleCds
         ka1k1wHObvHntC6YtBhUdadQxRRs0wH6pRETBGewXsFzTN/RPlZqBzyrj3PKyX5nL86r
         rkDiPq7XTze/bfx77Yix49EExNfxPe8tj2UXVA8wNhdmeiH/zJkBtO+fcHMDQBx0/BDk
         E7BIT/ZFaHL8Aq1lTWzH5z68CBA5Lh+jKRyqG/GfoJyi0x1JHZstqGQZu11sGJ+oxu/H
         VEnx0g3OQf6J/caN+0e+/v2LILvso1WkUO3E4gI7jdQcd6XRAuGkjJDay9xWR0vFA62m
         9pmA==
X-Gm-Message-State: AJIora+xrQd91eyN93AtB8XFm+IbGBxYjcPm8UpbYQOu8ByMhahwnuyG
        qQFU6aFkuq5eDQxKv9ynxFKvtC3kGx4GSA==
X-Google-Smtp-Source: AGRyM1sWGtz2ujc9bODZa2fJQWRkvHASOIH+uKiPq4diLwYftOeavGtp/uolR+hwk0xMV+9lt7sgYA==
X-Received: by 2002:a05:6638:2053:b0:331:6410:1e6d with SMTP id t19-20020a056638205300b0033164101e6dmr3099100jaj.98.1655393266404;
        Thu, 16 Jun 2022 08:27:46 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z4-20020a926504000000b002d11c598e12sm1116480ilb.61.2022.06.16.08.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 08:27:46 -0700 (PDT)
Message-ID: <281b7645-5ce3-0339-78d9-bbc737e4c50e@kernel.dk>
Date:   Thu, 16 Jun 2022 09:27:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCHv2] block: set bdi congested when no tag available
Content-Language: en-US
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com
References: <1655382631-3037-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1655382631-3037-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 6:30 AM, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> In previous version, block layer will set bdi to be congested when
> get_request fail, which may throttle direct_reclaim. Move them back
> under current blk-mq design.

bdi congestion doesn't exist anymore, not sure what this patch is
against?

-- 
Jens Axboe

