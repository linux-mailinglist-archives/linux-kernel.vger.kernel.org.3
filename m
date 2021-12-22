Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9347CD17
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbhLVGvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:51:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242796AbhLVGvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640155874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ch2Xpj1pnRLF55Cf/9agxcFXuNqtmtfpr9anTXKKzF0=;
        b=CoiMsn53WqYTqKPi1iJOBd+xoCcn+MALUrzFdOy/GeGs5UJr9whe1e2fGsKs91Myl/O+13
        X4D4uIU5xkHjs6NCVFVZdZDSZ3kl4JjpWrvfZlqSoaxdb44m0FnKWMhTaPqGOYWzDf9sfz
        CHLwFdJRNJJOEiiD1Y6SelFPGPvIMJo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-zym3a5saN-66vOEvIsUysQ-1; Wed, 22 Dec 2021 01:51:12 -0500
X-MC-Unique: zym3a5saN-66vOEvIsUysQ-1
Received: by mail-wr1-f69.google.com with SMTP id o20-20020adfa114000000b001a2abc089d8so404332wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 22:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ch2Xpj1pnRLF55Cf/9agxcFXuNqtmtfpr9anTXKKzF0=;
        b=ZfrzxBLZQGO3wch4w8Z0KHbb9AUmRxWxWq9Rs8ibV9cz9fRVBFmBnp+tXfHrCcBwME
         HpyQQkYkxTgI2dE9BURKR7ROlB16eJCCQ0q3clrvw89+u8s3bLV7dF/tmS3238aPGyld
         S/0FkOFzPkuNa03CU9/M8iC2nWMaev86ThYp9KXj2LwZXmVOQYIG/pMHZztcBoLUkqvE
         7zywKfseJc3MUlZn6fQXvIcfRrzuoS2HuvUuG2trnAdk99WjC/fjV+VetjkBsN9BvuQR
         IRBsQJlcjK5FaSD51t11Kyo5gbeHqBXvZaD/dypEVbYmcFuyaND7kEblmC2M3oPvkSn1
         9AFA==
X-Gm-Message-State: AOAM5300grADMJGjb7pEnjUNargp5hY0RTgr/rfBTwyOu/8JUaQLjqS5
        iPpVrpZWpHu0Tx2Qe3lFs6b9pmLg35KftV2JnwKUNGGPe5iVVy0uuvX566e7eZxIBw98bT5K5a+
        0XcawHlVzoL0hk5vjc3JP/+IE
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr1124851wmk.46.1640155871822;
        Tue, 21 Dec 2021 22:51:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDtNRmO6B8NSDYghPyCIuC7SMgE+EpTU/PA6KZoEqMErn7wwJ2gVK2teXs+Zth65RDz/bQuQ==
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr1124841wmk.46.1640155871637;
        Tue, 21 Dec 2021 22:51:11 -0800 (PST)
Received: from localhost.localdomain ([151.29.58.184])
        by smtp.gmail.com with ESMTPSA id g8sm685827wmh.17.2021.12.21.22.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 22:51:10 -0800 (PST)
Date:   Wed, 22 Dec 2021 07:51:08 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V9 00/14] RTLA: An interface for osnoise/timerlat tracers
Message-ID: <YcLK3MXdFTwYYC7O@localhost.localdomain>
References: <cover.1639158831.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1639158831.git.bristot@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 10/12/21 19:11, Daniel Bristot de Oliveira wrote:
> The rtla(1) is a meta-tool that includes a set of commands that
> aims to analyze the real-time properties of Linux. But instead of
> testing Linux as a black box, rtla leverages kernel tracing
> capabilities to provide precise information about the properties
> and root causes of unexpected results.
> 
> To start, it presents an interface to the osnoise and timerlat tracers.
> In the future, it will also serve as home to the rtsl [1] and other
> latency/noise tracers.
> 
> If you just want to run it, you can download the tarball here:
>   - https://bristot.me/files/rtla/tarball/rtla-0.5.tar.bz2
> 
> To compile rtla on fedora you need:
>   $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git
>   $ cd libtraceevent/
>   $ make
>   $ sudo make install
>   $ cd ..
>   $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git
>   $ cd libtracefs/
>   $ make
>   $ sudo make install
>   $ cd ..
>   $ sudo dnf install python3-docutils procps-devel
>   $ cd $rtla_src
>   $ make
>   $ sudo make install
> 
> The tracing option (-t) depends some kernel patches that are
> available at [2].

FWIW, I took this for a spin (on RT) and had a very positive experience
with it. Think is does what it says on the tin and makes using osnoise
and timerlat tracers easier.

Please feel free to add

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

