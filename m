Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB947B62F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 00:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhLTXav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 18:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhLTXau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 18:30:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF1C061574;
        Mon, 20 Dec 2021 15:30:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A0961307;
        Mon, 20 Dec 2021 23:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63898C36AE5;
        Mon, 20 Dec 2021 23:30:48 +0000 (UTC)
Date:   Mon, 20 Dec 2021 18:30:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Wander Costa <wcosta@redhat.com>,
        Wander Lairson Costa <wander@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v5 1/1] blktrace: switch trace spinlock to a raw
 spinlock
Message-ID: <20211220183046.7193720d@rorschach.local.home>
In-Reply-To: <76333783-cb3a-d1b7-5e40-d07014c4e2c0@kernel.dk>
References: <20211220192827.38297-1-wander@redhat.com>
        <8340efc7-f922-fb8c-772c-de72cefe3470@kernel.dk>
        <CAAq0SUn_Nru1NTyzgjB9ETsaM46bgDRf3DTa+Z9sG-c8yjuQdw@mail.gmail.com>
        <b07b97b4-dff2-5915-ce56-a039a14a74dd@kernel.dk>
        <CAAq0SUmQ5aXtr-tVYLry7zZwTHG6J=X7QV9q0man7pXn7uZjQQ@mail.gmail.com>
        <2f2f5003-e1bf-15ce-32cd-a543634ba880@kernel.dk>
        <CAAq0SUkZ_Zm_KZc-S02xAuR+td0T1nx=cPCs6D2cb_xt6EsUEg@mail.gmail.com>
        <76333783-cb3a-d1b7-5e40-d07014c4e2c0@kernel.dk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 13:49:47 -0700
Jens Axboe <axboe@kernel.dk> wrote:

> Alright, fair enough, mistakes happen. I think the patch looks fine, my
> main dislike is that it's Yet Another things that needs special RT
> handling. But I guess that's how it is...

It's not really "yet another thing". That's because in general tracing
needs special RT handling (and a lot of other special handling, not
just RT). blktrace falls under the tracing category, and this just
falls under one more thing to make tracing work with RT.

-- Steve
