Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D812547CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 01:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbiFLXC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 19:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiFLXC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 19:02:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FDF26108
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 16:02:26 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655074944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GjKZ+LQkKXZaIY72unLROm2RmMm/98TrNKDzBYh55HY=;
        b=QFBhyi09gvtgmNpodSmZHpLhVm19IQDsrPWaS29a9x7F56NeE+OzmHo9x/A9S4H1XdIUg5
        ZbmK+Wy0jpr4Dgk0Yex+NdfqzrCNaIWi1SSGPMLygIzNoVKR/ULiECPhxYgSFirtHouvXD
        VBopQ1NfYfoXznJbcZmiKVU60qUvmGDZhxtyPFoiPY2Sb6QvRJ6VKPHuGozdimcp21UwsR
        8Cc3uS95cQcz9r26hz2ucvyc41BAWu+c93jpl2JCGy18eO5JxUJ/thDaerf11Qi3x7wNyY
        lA7vH2OaBe8shvd4ALPPC9bNeTrGiyrABNdPccjPMTchvVLXPhWt9VEBrx05EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655074944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GjKZ+LQkKXZaIY72unLROm2RmMm/98TrNKDzBYh55HY=;
        b=xaJ8o0jiQdqz1Cf3Sdk3m4i448g+KNCZL7Kr7OIv0X2C/6pYAqtyVR5xRwMeVqYNPqh8KX
        Nttn1qWMX30IbrDQ==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
In-Reply-To: <YqVZ4CyWTiDgngkA@google.com>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de> <YqVZ4CyWTiDgngkA@google.com>
Date:   Mon, 13 Jun 2022 01:08:23 +0206
Message-ID: <8735g9mqo0.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-12, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> Should a situation when we have only one online CPU be enough of a
> reason to do direct printing? Otherwise we might not have CPUs to
> wakeup khtread on, e.g. when CPU that printk is in atomic section for
> too long.

IMHO, no. Especially in that situation, we do not want printk causing
that atomic section to become even longer. If the machine has entered
normal operation, we want printk out of the way.

John Ogness
