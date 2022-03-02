Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3594CAEEE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbiCBToH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiCBToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:44:05 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805B7C9A08
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:43:21 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j7so4602950lfu.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+G1a09M8P4CbXu26QE7iCVML2k0uFj+bbvrsTaH93U=;
        b=YT7SnwtqKBiq9TKpietz8YIDhmCrKcmPJiEWKh4KKa99uTizqkdkS+y5iIvjMR4I0I
         0wBG0Nd16GJlOx6rYfz1vp/dBlAEZwc1fTAM+cBPALeRpkbfZBmGJGeT0C2Zr9pyIPP0
         AW8InIHxZhNGVMf0XNGsdqr7I4uUholU0zOcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+G1a09M8P4CbXu26QE7iCVML2k0uFj+bbvrsTaH93U=;
        b=VM0343xysQrDsrQKLz0+t2IXu5q/nd900lqZcFdAOLIJp6A1p2kNIREFXvMC49f9Eb
         X3ZRxS2SyfdYgd0hO+L5zD8gMNI70uBubrT/tSUOIKmMyV0KK9jAkjvtMzxjFNacvLBX
         W6iwHe+6jkkNBA7prDjsizU4jMw/935nKXxJQ9V6FQ0A6aNyhaBKnI+R94De6hP8vrS4
         cdVRnG9JXhOEU9AYXHWNgrC0gghjP55pKmVH7MM0ybXwb2k/SUiUVVnpnVFVqLHVEqmh
         dkEcmjn1llfMCpNPoAk4U40YUGIV7gxnTNnpX0HRS1ZmXtwRd/HpEUDRC3+x83+Ik6Mw
         yuNw==
X-Gm-Message-State: AOAM531y5c/4x6j4g8Go0r20tvR9h7MrRHoa6SAEwP5fsBCyT2SJ9QUZ
        5fjtcjvZMDMtXJIhWWsoTWdabOp6FP7A0fAOHPQ=
X-Google-Smtp-Source: ABdhPJxbE9MEwykNqSRVxTjC6DNxGE+d41xQjRn6RnPl5O619dfXf1dOCBvoSI8NUZgIeOv/rFM1Ew==
X-Received: by 2002:a05:6512:1053:b0:443:967f:bc45 with SMTP id c19-20020a056512105300b00443967fbc45mr20368616lfb.128.1646250199324;
        Wed, 02 Mar 2022 11:43:19 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f15-20020a2e6a0f000000b00244c8743c19sm2786246ljc.35.2022.03.02.11.43.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 11:43:18 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id b11so4571573lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:43:18 -0800 (PST)
X-Received: by 2002:ac2:4c8c:0:b0:445:6c26:3cff with SMTP id
 d12-20020ac24c8c000000b004456c263cffmr19624815lfl.435.1646250198484; Wed, 02
 Mar 2022 11:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20220211213628.GA1919658@xavier-xps> <20220211213628.GA1919658@xavier-xps>
In-Reply-To: <20220211213628.GA1919658@xavier-xps>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Mar 2022 11:43:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1oc0=YuMJCnjV_aY4FswtWk3OeO4-SEbCmAXGkAfDPA@mail.gmail.com>
Message-ID: <CAHk-=wh1oc0=YuMJCnjV_aY4FswtWk3OeO4-SEbCmAXGkAfDPA@mail.gmail.com>
Subject: Re: [PATCH v3] tmpfs: support for file creation time
To:     Xavier Roche <xavier.roche@algolia.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jean Delvare <jdelvare@suse.de>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 12:43 AM Xavier Roche <xavier.roche@algolia.com> wrote:
>
> Various filesystems (including ext4) now support file creation time.
> This patch adds such support for tmpfs-based filesystems.

What's the odd huge-page noise in this patch?

Other oddities:

    Reply-To: b954973a-b8d1-cab8-63bd-6ea8063de3@google.com

WHAT?

And finally - if we really want to treat btime as a first-class entity
and expect things like tmpfs to support it, then we should just bite
the bullet and put it in 'struct inode' along with the other times.

              Linus
