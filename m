Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259EA5A7DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiHaMl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiHaMlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:41:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B27A6AD5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:41:18 -0700 (PDT)
Date:   Wed, 31 Aug 2022 14:41:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661949676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b4uXfTcXJzEovtZTYHUIWB1giQlX2EAgRixcjojyZUc=;
        b=LZdL38rlXuRLJh7odxvZiaog0QghoYrz6jGF0KjU2yYKL/MFXKyslMUh+d0OKuLAd2VNla
        6UVXKPozdmKKRpcxqP59K7VolpFF3F/uDqvkEYsI0tzcEBC/zFCgmpUHD4gZ1+yqXBZjxK
        2jGfrvK9xZLLK/D4XPk/Y8OXBaRboVZdClrSAEoPlhAUXe0OjKPxY7F0mfXsX+QMtrT5vt
        256CIi0U207an6+yv7j0exucpo8IV7qVeqwKQ1+UPBOrlN3ehjYxmbCkoBsxJ8O0PUvgxk
        Q0nK/tNEDlqb+DXP43HIwzyFT4TR/rF2dOEk7Rn4j8u+bR95rcEnNHVqiGkvgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661949676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b4uXfTcXJzEovtZTYHUIWB1giQlX2EAgRixcjojyZUc=;
        b=noyoIPRmtDlSp2u5341YWxmR8O99J08P5w5SpEnjqzejIfnvXse6u+sK5pphZML3GgZj7N
        zLBLvVMWNB7RylCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Marco Elver <elver@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        David Gow <davidgow@google.com>,
        tangmeng <tangmeng@uniontech.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] kernel/panic: Drop unblank_screen call
Message-ID: <Yw9W6qYo6Acg7rad@linutronix.de>
References: <20220830145004.430545-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220830145004.430545-1-daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-30 16:50:04 [+0200], Daniel Vetter wrote:
> Long story short, I have no idea why the direct call to unblank_screen
> survived for so long (the infrastructure to do it properly existed for
> years), nor why it wasn't removed when the console_unblank() call was
> finally added. But it makes a ton more sense to finally do that than
> not - it's just better encapsulation to go through the console
> functions instead of doing a direct call, so let's dare. Plus it
> really does not make much sense to call the only unblank
> implementation there is twice, once without, and once with appropriate
> locking.

Yup, calling it twice is redundant. 
The only difference I see is that the console implementation relies on
CONFIG_VT_CONSOLE while the former relied only on CONFIG_VT. There
should be no console output without CONFIG_VT_CONSOLE so no need to
unblank it.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
