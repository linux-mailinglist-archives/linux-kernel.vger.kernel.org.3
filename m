Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D6C48A643
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245292AbiAKD0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:26:01 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:37398 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiAKDZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:25:58 -0500
Received: by mail-pj1-f52.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so2525054pjj.2;
        Mon, 10 Jan 2022 19:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+IrioJ14vRZe46/0NWAy9KztWiI2hvMJP8opnttVIEU=;
        b=E2LUMbKztkTD+R4dRyd3OEW/L8sjhTao2v+QXr7+SQeNLFCD9SZlA/H3C3s9Kq0YHv
         BRSs7iSigT1gvDeZUbwQg50CFR+14FteQvCfaZzXn0ebQOKSlOlZlx4X49wJvf0pmkfs
         jKy9I1/7I4G5NBWUq4GxivHlqF3CF6YjHas1T54jkSFN4h7Nbakr907qZ+GEztZV5QyR
         svRH5oBwKfKyV78SKExxpSnspzG+MfCzU+CfiRb836yP5CSaBJnLu/ioy4D6YbSizp7b
         Zyh/W0drw/FLGMWhrlKyAPMktDrsRP5yV7drXsO+a+IEv2ir27klqqn1YHbqTotJgtT1
         9Ndg==
X-Gm-Message-State: AOAM531iH+ID6W/a5nMVT8vdX2uqsSI7Cz0kf5mhCUVn3rqgsYUl1noJ
        6MBuuIh8DaJAkb3RrWSDl4C8fW6NGv0=
X-Google-Smtp-Source: ABdhPJxc5akiiLV56FHBQGpILjN/2inSGNxegSXkNU4UvRu5tiBs00Inrw8SHdk82j9XqkA3gUO5Xg==
X-Received: by 2002:a17:902:c946:b0:149:94d:c049 with SMTP id i6-20020a170902c94600b00149094dc049mr2652243pla.75.1641871557731;
        Mon, 10 Jan 2022 19:25:57 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b22sm8847399pfv.107.2022.01.10.19.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 19:25:57 -0800 (PST)
Message-ID: <bb83d65e-bcd8-9da8-e54b-0dde6f23434e@acm.org>
Date:   Mon, 10 Jan 2022 19:25:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/13] blk: make blk-rq-qos policies pluggable and modular
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     axboe@kernel.dk, jbacik@fb.com, tj@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
 <Ydxum/2iwp6hDw68@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Ydxum/2iwp6hDw68@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/22 09:36, Christoph Hellwig wrote:
> On Mon, Jan 10, 2022 at 05:10:33PM +0800, Wang Jianchao wrote:
>> This patchset attempts to make blk-rq-qos framework pluggable and modular.
> 
> I really don't think making them policies modular is a good thing, and
> your new exports/APIs are a very good sign for why it is not a good
> idea.

Hi Christoph,

Personally I don't need the ability to implement blk-rq-qos 
functionality as a loadable kernel module.

When I implemented the ioprio rq-qos policy (see also blk-ioprio.c) I 
noticed that I had to make changes in the block layer core 
(blkcg_init_queue(), rq_qos_id_to_name(), blk-rq-qos.h) instead of 
having all code related to the new rq-pos policy contained in a single 
file. I think it would be an improvement if new rq-qos policies could be 
implemented in a single source file and no block layer core changes 
would be necessary.

Thanks,

Bart.


