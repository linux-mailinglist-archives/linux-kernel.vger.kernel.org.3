Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0864B3B86
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 14:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiBMNLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 08:11:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBMNLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 08:11:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963945D65D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:11:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DEBF61164
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B30DC340EF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:11:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GAcHZxXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644757871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8vqWWoulwDvbUUq049soUccncLgPDpV5oO0KcHp9aO0=;
        b=GAcHZxXosJ6a1NMsk+8Cnx/pkCQPdjXpdq/IRLDoiKqXEd3C5ND7fBSYktrtj/5h+FNX1v
        vJlmR/USV2DUVwd5irXdOo5G5JFzse+/h57wOkC9vFxRtB1yVqCKx8+Y6hDVX+sjBIGPJk
        bauIDjGX87zy6pCIAUFR/S4VrLGvdsg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8bddafa1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 13 Feb 2022 13:11:11 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id j2so38739221ybu.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:11:11 -0800 (PST)
X-Gm-Message-State: AOAM533u3LY/rXnyVgdSq5TX6QS/vU0F0Nsp25OjehPhK57CiwADxRS+
        AQ+l0xqRQgArrnWtsD59RF1DcQLbvLWuGliFCYY=
X-Google-Smtp-Source: ABdhPJyqZ7NOe/bo/EAnyPWUNP2UpXq0B/WbnOo8+8e3ly20+FumUF/xRT36Ix2nYModegUOPtBwBgyCSuY0G66ONxM=
X-Received: by 2002:a25:4144:: with SMTP id o65mr8327105yba.113.1644757870686;
 Sun, 13 Feb 2022 05:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20220212122318.623435-1-Jason@zx2c4.com> <20220212122318.623435-5-Jason@zx2c4.com>
 <YgirDzvwEYRwvLHS@owl.dominikbrodowski.net>
In-Reply-To: <YgirDzvwEYRwvLHS@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 13 Feb 2022 14:11:00 +0100
X-Gmail-Original-Message-ID: <CAHmME9rfWxPpUe0pmZZKqHMjfd_x_=LozgNdQR2reiTahEsM_w@mail.gmail.com>
Message-ID: <CAHmME9rfWxPpUe0pmZZKqHMjfd_x_=LozgNdQR2reiTahEsM_w@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] random: group initialization wait functions
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
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

Nice catch. Will unify these to be "input pool" since that's what
we're still calling it in the variables and elsewhere.
