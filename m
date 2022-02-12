Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4679F4B3858
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 23:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiBLWRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 17:17:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiBLWRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 17:17:06 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D1D60A81
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 14:17:02 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id k13so23292109lfg.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 14:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLLDXiwc1zAowqYr8P91bEBGG8/afaZrRX+wfAwZ1k8=;
        b=p+YZp2LHLGfXp6o+BPTJl97qUJGAwHA/o97ZAm1qp25ZVbwllNR6pzPul5EtBGI3oq
         boOv2B0e86b9q1LsjAelcPh+KiDmPUmXU2RfyYMq0vBon86JogNXrtnsPt3QLbDia18L
         OCQOLpn4sSZOczP/GncLRIS7lrROmbma2gLMGgM8EjB1O5QKAHa8rAm0Cb/LLx6wHpQd
         bIJRhc2M5dS1/FBfCxw0d7/0U9Q9Q+HvOYalOvMCwg2TsvMywMGTgeYOFGoDJBmUrfNe
         Jth4ZaCx9Ibs0x8eInChZcWpqQuAYVqMZXzHQ8InVpBP9pcelNylMl2LUMLWoUZ9cMzW
         9K1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLLDXiwc1zAowqYr8P91bEBGG8/afaZrRX+wfAwZ1k8=;
        b=lgeN7MoT+SHKYdEsYzmqRmBnluo52CsKywgZFISuoD0qprfyItHPtx6L+N4JeB2Tnm
         2g4dcFnalooF8IIhtgO4mMswhLzeayWYtrfBPYt8ZEHzGg+Jjg9xvFTg/tGgcOlalBY5
         1AP7UOkG/vVjNznHjhPuEdqAAIP/ky4L1EIEupMV5vzIQpeDZoi1ZnWMewexUzlc0s+G
         hw8yBm/DTHQjaeYJMPbtssAUiV3mKF8zjZ2MI9qhw+G/YAGlzaolx95eGg52V7KJzfT9
         PZp3bTm5jL6t7zFOFMSvvnxz+a2XE8MTOMp2Fkt4KtKOKkXxblr7LB7pL2F9sZj46W4Y
         lkTA==
X-Gm-Message-State: AOAM532skgmf3F3FU405lO/QIlFS+9RM6aMqf6O0qM/tVk+IcjBmzY58
        Z01zei+tJOeUY6HenzFvl03h/ey3XdWM2HlGXyI=
X-Google-Smtp-Source: ABdhPJwISFy1v4C6ClK7RbYkoj9MKlAxZvU4HprF3RfUlZOm2OsWiHMUcZyF3ApjfahKnNLbjY4LRPYtorxcldClY0s=
X-Received: by 2002:ac2:4e12:: with SMTP id e18mr5610797lfr.282.1644704220387;
 Sat, 12 Feb 2022 14:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20220212200649.541061-1-matthewwaltzis@gmail.com>
 <20220212204851.GA1660889@dhcp-10-100-145-180.wdc.com> <CABwBYcb0XhomznNOV62uH3Yo1J7XjHowuhF3H36owXtiVSp8JQ@mail.gmail.com>
 <20220212210258.GA1660900@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220212210258.GA1660900@dhcp-10-100-145-180.wdc.com>
From:   Matt Waltz <matthewwaltzis@gmail.com>
Date:   Sat, 12 Feb 2022 15:16:24 -0700
Message-ID: <CABwBYcazb-2E937U2HeNJXRAtLbyfGdMh3AJarmP9wasyS-qWw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: fix prp list allocation
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 2:03 PM Keith Busch <kbusch@kernel.org> wrote:
> That only applies to chaining list elements. It does not apply to the
> "PRP list pointer in a command". The driver allocates from the 256B dma
> pool only for the command's PRP list pointer, so we're fine.

Ah yes, I was confused by the PRP2 definition which says it can be a
"PRP list pointer",
now I feel extremely silly. Guess I'll need to look elsewhere for a
fix for this bug I am
encountering, thank you for the clarity!
