Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0358DFE2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbiHITHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348116AbiHITGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:06:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E97F248CE
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:48:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i14so23794939ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DhUIuH+fIv77WJzm8eKuRBv3nR/JhYDUtxzpNkXaI2E=;
        b=OtCLH0do5IYLP3xRhX2XKN5rqVJR6zlV4hl/xmMCr0/f52r1aBM4edtcIvE8u9au8b
         yJAqKhenGtQuoWeme1R2oSE2YmJgYsCOMRYZO36i3m2QVZp048cs2P0WpncxTtN/vTMB
         nD81POpU1weccBApk3K2JDNk+T15xFvxrG/gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DhUIuH+fIv77WJzm8eKuRBv3nR/JhYDUtxzpNkXaI2E=;
        b=gke62JGpLshnfqeAq20gzvQ4EXLC06itDFcqv2XWSw82aLoTQdmeX38hP7SDzRdfvd
         kEKu+cRzlw8pOLAc9Yg4+sht9Dz+YeTRCJjazkuJlzcVM220iGd4RjZdwWrb0sQh8ABr
         ipamKy4w9AaGYZas5hOe2kM1WZ0HEpXLv7Ungnk/Ck0gssRzOuvqI41U27OaBerVrTOW
         rHjE0xJ2jazagukSTryPnxybXVCw4/I7gzMVvky3W2XpijZkEzpmR9c7Gp+BPTUlqx1B
         MK2eUS3hxF/BtRGKDOrP/pzsTRew7e4CHH/7tjQjSbNirNyz3ZXfCUxel3Cp+WExKItF
         sYCg==
X-Gm-Message-State: ACgBeo3HCQ+PIfEsN1sLE3hMJTzHwvk9wSRBTR45szWLVHFs3pl+SVR0
        yIzjW6PixPiyZPB55djvBjIRG3Dmf5tm7l9WH3Q=
X-Google-Smtp-Source: AA6agR5mBEKICDZb87/T8P4LrUCxWJ1a52g8Jo4+So5yhGAjZQcUBgtyRyOscvkuC8O/7h9zC0qudQ==
X-Received: by 2002:a17:907:168e:b0:731:4ba0:d5e9 with SMTP id hc14-20020a170907168e00b007314ba0d5e9mr9234883ejc.204.1660070923684;
        Tue, 09 Aug 2022 11:48:43 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id d16-20020a50fe90000000b0043b986751a7sm6393044edt.41.2022.08.09.11.48.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 11:48:43 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so2455468wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 11:48:42 -0700 (PDT)
X-Received: by 2002:a1c:f603:0:b0:3a5:23ca:3e7c with SMTP id
 w3-20020a1cf603000000b003a523ca3e7cmr12452214wmc.38.1660070921906; Tue, 09
 Aug 2022 11:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220808073232.8808-1-david@redhat.com>
In-Reply-To: <20220808073232.8808-1-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Aug 2022 11:48:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKm3QjM1_XwWNW8P8drW6s0ZeANm7VKy_1c7WH6RSp3g@mail.gmail.com>
Message-ID: <CAHk-=wiKm3QjM1_XwWNW8P8drW6s0ZeANm7VKy_1c7WH6RSp3g@mail.gmail.com>
Subject: Re: [PATCH v1] mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
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

On Mon, Aug 8, 2022 at 12:32 AM David Hildenbrand <david@redhat.com> wrote:
>
> For example, a write() via /proc/self/mem to a uffd-wp-protected range has
> to fail instead of silently granting write access and bypassing the
> userspace fault handler.

This, btw, just makes me go "uffd-wp is broken garbage" once more.

It also makes me go "if uffd-wp can disallow ptrace writes, then why
doesn't regular write protect do it"?

IOW, I don't think the patch is wrong (apart from the VM_BUG_ON's that
absolutely must go away), but I get the strong feelign that we instead
should try to get rid of FOLL_FORCE entirely.

If some other user action can stop FOLL_FORCE anyway, then why do we
support it at all?

             Linus
