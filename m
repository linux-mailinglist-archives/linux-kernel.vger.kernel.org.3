Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A885ACFCB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbiIEKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbiIEKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:16:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3A85722A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7DB1B8100B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 10:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3DBC433D7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 10:14:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iF/hwuDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1662372897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mje1XfzUXneXB8mOvRlrEb7IGbPQZX311/9cO2XB3ms=;
        b=iF/hwuDGlyJ7eWQltgqfG3TiDJDjCCB/UKOXmD1D3u9UEDPGBWqdOJkXNdoGrXfrGXjzbO
        OG/nPpmqP1eQXUWwAuJ3L2HcRsmAy1Z+5Zd7psDJBWza/LQhGHgOhz+va2FA8HneCn5vWP
        YlBAZwhkbwCx3puRcg9Y1DxICXzMwBY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id febcf230 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 5 Sep 2022 10:14:57 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id g5so12086693ybg.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:14:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo0DDdCme2AZGrKVUb7DT8dQHa7IaP2fDTo+Pt/S13LkYyW/i+8l
        IYO6dt5EAftYlmrunTh5/qWgRswlQaVTuGjbs4g=
X-Google-Smtp-Source: AA6agR7q5r7oCDcBrWFAFYKqzwheYzc2NIErQgZWSkOyoAvffB/WFpVuq3cduMy2sDFnCHzIcbGLc7br9EjEDoW3E9g=
X-Received: by 2002:a25:8d02:0:b0:696:42f8:fa6f with SMTP id
 n2-20020a258d02000000b0069642f8fa6fmr29088730ybl.365.1662372896087; Mon, 05
 Sep 2022 03:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220516104807.16482-1-tiwai@suse.de> <YxXIWv8dYmg1tnXP@zx2c4.com>
In-Reply-To: <YxXIWv8dYmg1tnXP@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 5 Sep 2022 12:14:45 +0200
X-Gmail-Original-Message-ID: <CAHmME9qJfZ06RjBc7h1LnEfngOp0w_sn6xH-7XQgFqH6jcRG1w@mail.gmail.com>
Message-ID: <CAHmME9qJfZ06RjBc7h1LnEfngOp0w_sn6xH-7XQgFqH6jcRG1w@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Refcount multiple accesses on the single clock
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, 89q1r14hd@relay.firefox.com,
        LKML <linux-kernel@vger.kernel.org>,
        Wim Taymans <wtaymans@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 11:59 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Can we revert this for the time being and backport the revert to stable?

I sent the revert here:
https://lore.kernel.org/all/20220905101403.1435037-1-Jason@zx2c4.com/
