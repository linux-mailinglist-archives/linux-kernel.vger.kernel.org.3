Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E755988EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbiHRQct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344800AbiHRQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:32:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C09B72856;
        Thu, 18 Aug 2022 09:32:39 -0700 (PDT)
Date:   Thu, 18 Aug 2022 18:32:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660840358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eRWjvTJioZag0NL+kWuQAJgjY2OnnzM0BJxuNTpvQzY=;
        b=mbGcKzxS+qB5xSvStj9dpA9H4TOAHWwkS1PTIqeQyi2gsgd2a/Fb/UgemvsAhSPd0chOZb
        GKXKABd84cUonoMmt/8mVioyyO3FcHeMg13E6VXdNtsHzXdBECS0ZMl7VsoxP6o2W/aH3o
        boGHcBh52ve9rGMGFwg9zZfH+SDuD2zBEHyxw/BqwYjVYhEXXWIQzMqqqLk78MOhrDEWmu
        wlnvvGwv+ZlkKFt49EaDnTQ0qb/EPVdo0SSZ/hGUzaXyA1Kxc7A+g+HVDr3c5zPdVFptX6
        UQ4UVPC9xirjNFQKH1kCCvGOBZOpjxdfreFuuPIE0PnfP9j8iNa8nZyQR16Rlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660840358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eRWjvTJioZag0NL+kWuQAJgjY2OnnzM0BJxuNTpvQzY=;
        b=aRiygy3jAMbToG5V+llK9UZ2dRmLzGWkArvNLdtFSKyqqr5UU53FvgpUBMrCZNWNt4LzSp
        qMaJGAiAxXxNj0BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yajun Deng <yajun.deng@linux.dev>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5.10-rt] locking/rtmutex: switch to EXPORT_SYMBOL() for
 ww_mutex_lock{,_interruptible}()
Message-ID: <Yv5ppS3wDbKFs9tv@linutronix.de>
References: <20220803062430.1307312-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220803062430.1307312-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-03 14:24:30 [+0800], Yajun Deng wrote:
> We can use EXPORT_SYMBOL() instead of EXPORT_SYMBOL_GPL() in
> ww_mutex_lock_interruptible() and ww_mutex_lock(). That match
> ww_mutex_unlock() well. And also good for 3rd kernel modules.

Not that I am fan of this but it will sync the symbols with what landed
upstream as of commit
   f8635d509d807 ("locking/ww_mutex: Implement rtmutex based ww_mutex API functions")

therefore it would be good to have.
Luis?

> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Sebastian
