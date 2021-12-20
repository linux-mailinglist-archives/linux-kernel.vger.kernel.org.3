Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079C647B646
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 00:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhLTXqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 18:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhLTXqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 18:46:00 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DF0C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:46:00 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id 14so15422903ioe.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qhtVAR+sknJEbgT3KYqmYZUz0TiJ2iQjq2f6Rqlsa2k=;
        b=XxElCAKWWJs2pQKrBlJFbACA67N2Vl59wigT46QPpfxbIZYqq9XJ72QJuKq+2ZE3sG
         ZBAP0t7vZCvdkJtpyQZgsx2MyzMh58D0uzF6+CSNsqiNPCkXG+m1c5znt9SeHTW0WLkt
         2GA6dIXavpJopJMLWH+j/CizTQk9SDZDewCBzjvQykY043C7blJ1GSk69iEyftKTR+9K
         0u9k6jcaIZL0lL2bewC/cElBXgvayAuggxmDUrnIHNSNtQ0DvdoGzhEuqTEymxoFqGbQ
         lz0xOBH3J/PJzGffW0JZljufm7Y4dOuvDkIbL8wP47u0czxrs5X7EEPtRmz27vRETAZu
         ezQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qhtVAR+sknJEbgT3KYqmYZUz0TiJ2iQjq2f6Rqlsa2k=;
        b=aq9k04Yu13aD8pDmfy1w+YGkgfFUjXvD3XebieaTIr/ZqsIyVt/j1zemWjw46BOoij
         5VutZWrk4mEqpD3JPw4xNUP+qmgLRyQoVOEWeI4WcjmdZfBm0udYHGSm4PdBH04mikMh
         l1LE92xrfyT5Nzfpe6855y+tGeVijEBzos5zMjNRC0+xNbe/u1tbqDYxNkHJPRLQYTHU
         DOvV8ZnaaCRkCk+bfLUQlC4se3V/yivsgkflKMVOOhWhBYGypFtNFBuBX0y0bXaeyTUa
         ktApjn1309XMf6ZmKosucZFYPEXvqfrV2dZd2hgsmgvRu7kLT5zSg9wyddNPAeofOnn+
         02eg==
X-Gm-Message-State: AOAM531JYhitlZK7cmMIE9cNOYE5YlFSJrQ9ODYAKcfetBeLpqQQqPnB
        embgFuSNzyPYO+QyeE6ruOyQBg==
X-Google-Smtp-Source: ABdhPJzFnCR55CYq0guosnTFrAh3y1n2+5JK2rxvkxO9p/h+QGR5kXv2EVonphXgb6l69YDxEzRaMg==
X-Received: by 2002:a05:6602:2c50:: with SMTP id x16mr305051iov.114.1640043959752;
        Mon, 20 Dec 2021 15:45:59 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l1sm9509232ioj.29.2021.12.20.15.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 15:45:59 -0800 (PST)
Subject: Re: [PATCH v5 1/1] blktrace: switch trace spinlock to a raw spinlock
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wander Costa <wcosta@redhat.com>,
        Wander Lairson Costa <wander@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20211220192827.38297-1-wander@redhat.com>
 <8340efc7-f922-fb8c-772c-de72cefe3470@kernel.dk>
 <CAAq0SUn_Nru1NTyzgjB9ETsaM46bgDRf3DTa+Z9sG-c8yjuQdw@mail.gmail.com>
 <b07b97b4-dff2-5915-ce56-a039a14a74dd@kernel.dk>
 <CAAq0SUmQ5aXtr-tVYLry7zZwTHG6J=X7QV9q0man7pXn7uZjQQ@mail.gmail.com>
 <2f2f5003-e1bf-15ce-32cd-a543634ba880@kernel.dk>
 <CAAq0SUkZ_Zm_KZc-S02xAuR+td0T1nx=cPCs6D2cb_xt6EsUEg@mail.gmail.com>
 <76333783-cb3a-d1b7-5e40-d07014c4e2c0@kernel.dk>
 <20211220183046.7193720d@rorschach.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4d110c2a-2e70-8fc1-a16e-cd576c646a39@kernel.dk>
Date:   Mon, 20 Dec 2021 16:45:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211220183046.7193720d@rorschach.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/21 4:30 PM, Steven Rostedt wrote:
> On Mon, 20 Dec 2021 13:49:47 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> Alright, fair enough, mistakes happen. I think the patch looks fine, my
>> main dislike is that it's Yet Another things that needs special RT
>> handling. But I guess that's how it is...
> 
> It's not really "yet another thing". That's because in general tracing
> needs special RT handling (and a lot of other special handling, not
> just RT). blktrace falls under the tracing category, and this just
> falls under one more thing to make tracing work with RT.

This isn't the first patch like this I've applied. I'm not saying this
is an issue with tracing, just that it's another one of these "spinlocks
are now preemptible/sleeping with RT" and that necessitates changes like
this.

-- 
Jens Axboe

