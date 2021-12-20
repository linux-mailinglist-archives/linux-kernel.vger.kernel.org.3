Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C8B47B490
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhLTUuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhLTUuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:50:54 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCFFC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 12:50:54 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z18so15000698iof.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 12:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=c9XJhvmZT/MX0Dmn9tb6Hib0N0oOR8X9axj2urQ+ZSE=;
        b=QhIEVb1sdRi9DSwei1pPOGnv4H5m/kGldy1JqqHn/TX5YJFyloAxEF0Q/vQ+XgoHaF
         f/notsBLa7mUrVpdhZuNF8FVhfR4oLy6gP8rjlGPWJD+inb7UgvHgcTMWtGUH+cbI4PG
         gyi0p1tLClbr6amGO+vUZMSHJLv48/UP7Ip60msMiDs3E9Io0Eqgx8JjJAyDHK5XAbb4
         l85Vm04lswpBKT70EoYygMKyEvthclWkiBJ6szdQ2oTAvbcw6yLrGoirNiGp+8X4zmtE
         xgi3zQfI+MdxkKcooDKGbM8E24HHfqZG9IImZkDtnMIR4z7U5wG5ayD3jRGhiMDZDjuW
         cfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=c9XJhvmZT/MX0Dmn9tb6Hib0N0oOR8X9axj2urQ+ZSE=;
        b=2SeKl5t7D8WZsOfkMKM9fCbkF3YXtiBnXPe+5tux9Ljk891ORkydJYS8iZXs8//bHb
         k7BRlDepmmjeYkc8UP43KUD2xpE5fzvN/m87RfQ4s0vvLKL7kwcN2E6Ej8sJrrvnV9Ck
         EqN85DRZN64jhUsG0IYxh2fwOEpQCNC+Y2kHN4csBMbDg+YSEDtyF/57ZbxGrYStDZDy
         3bigzpXv2CSXET7eMlxukMzPnIMRFS09Wjv/OOskKmqSahiFgJduqxfgEF49b1V3q8Yr
         TL7Bs8AwEKVov6dJoZeHZVVV1oMWk3VRbatUiNJKCUzgy+HXddeN47usyuc4KqmdNxWG
         +aqw==
X-Gm-Message-State: AOAM5301W/T3uoF+unVOcRlT03LRo/JBFQqSLG8S0jNgzw4M6+nIh+Ap
        49z/coR4v1iEXLlcqPWfer1LFg==
X-Google-Smtp-Source: ABdhPJzG7HYpgxUCbycJzyxcFvYpTM27QXhTJAT+2v6Ij02m6D8f14QUwUR71k55FnP+H0wQFCoL7A==
X-Received: by 2002:a05:6602:1552:: with SMTP id h18mr9327079iow.183.1640033453635;
        Mon, 20 Dec 2021 12:50:53 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t9sm1349672ilu.50.2021.12.20.12.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 12:50:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Wander Lairson Costa <wander@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20211220192827.38297-1-wander@redhat.com>
References: <20211220192827.38297-1-wander@redhat.com>
Subject: Re: [PATCH v5 1/1] blktrace: switch trace spinlock to a raw spinlock
Message-Id: <164003345302.532019.10882095301451527257.b4-ty@kernel.dk>
Date:   Mon, 20 Dec 2021 13:50:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 16:28:27 -0300, Wander Lairson Costa wrote:
> The running_trace_lock protects running_trace_list and is acquired
> within the tracepoint which implies disabled preemption. The spinlock_t
> typed lock can not be acquired with disabled preemption on PREEMPT_RT
> because it becomes a sleeping lock.
> The runtime of the tracepoint depends on the number of entries in
> running_trace_list and has no limit. The blk-tracer is considered debug
> code and higher latencies here are okay.
> 
> [...]

Applied, thanks!

[1/1] blktrace: switch trace spinlock to a raw spinlock
      commit: 361c81dbc58c8aa230e1f2d556045fa7bc3eb4a3

Best regards,
-- 
Jens Axboe


