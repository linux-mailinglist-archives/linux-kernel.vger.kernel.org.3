Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D20E4BE320
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378338AbiBUOu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:50:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378385AbiBUOuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:50:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC93D616A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:49:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58AC56111C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82760C340E9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:49:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SdlvgkcZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645454975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3XjT+yfOH0QV2J9nIhHSeLvHRCR6LYKtnCGPGJmYylI=;
        b=SdlvgkcZml4i6C0vb6+1mOPAQFSQ7hviER5DKCgScfz7AyQ+O2h8Fqg+GwuE36h9CfmLHk
        nP2rf3EWcFCFlxUl5x8X7koz7DWMBkiNNamPK7zpsxy/RaKHQD7lLAOoByoTvT8p7KUlpN
        +z3uoknzXI65Cbc3Cy92z5QFb9mzNUs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 27168c16 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 21 Feb 2022 14:49:35 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2d66f95f1d1so140487807b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:49:34 -0800 (PST)
X-Gm-Message-State: AOAM533Ni0bQ83R5LEx87CyqXk5k6QvvCOEaBZMD4lB+QsSkURjPRTdy
        qIpcP3jx1jI3X9Fmqnz7KYzT4Ed2dISQz2aGw5Q=
X-Google-Smtp-Source: ABdhPJyB8+6i1agvtI75LRSMQoibCAc3zRdf6hQ7ayw4krrWuoH6RS0fx8OlwL0GESJijatlBtusbsHMOdHShpLeaMQ=
X-Received: by 2002:a81:7d04:0:b0:2d0:d0e2:126f with SMTP id
 y4-20020a817d04000000b002d0d0e2126fmr19448715ywc.485.1645454974340; Mon, 21
 Feb 2022 06:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20220212122318.623435-1-Jason@zx2c4.com> <20220212122318.623435-2-Jason@zx2c4.com>
 <YhMWS+gxKdrQIFwo@sol.localdomain>
In-Reply-To: <YhMWS+gxKdrQIFwo@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 15:49:22 +0100
X-Gmail-Original-Message-ID: <CAHmME9oSyKFc4fTPgBiKb+Urjf2qR5x2ydhgU6XnOcfty7qoFw@mail.gmail.com>
Message-ID: <CAHmME9oSyKFc4fTPgBiKb+Urjf2qR5x2ydhgU6XnOcfty7qoFw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] random: introduce drain_entropy() helper to
 declutter crng_reseed()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
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

On Mon, Feb 21, 2022 at 5:34 AM Eric Biggers <ebiggers@kernel.org> wrote:
> Looks good, but perhaps the comment should clarify that drain_entropy() doesn't
> destroy the entropy in the pool, but rather just extracts it and zeroes out the
> entropy counter?

Will do.
