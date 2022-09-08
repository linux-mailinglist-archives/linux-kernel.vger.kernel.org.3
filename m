Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE185B2443
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiIHROv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIHROs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:14:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F01E1EC60
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:14:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d12so18545108plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=9VqwJSTg8rc2usG/0vrngTL6FGuSAVABcq4ZdVPrdpw=;
        b=JnzH+DEEUNwNRdXeOPCCNnRaYeWfcxvIXAiWbY8lDOcQZXM8rgFE8WeQDUqecEnSn3
         DsduVH6EmZ0hoxQ1kSNOSiyn2HxZ+o0qyIrFuA4OqkLsOa0FtkS+iEOXRz7gS1hdQBe5
         qs3fn689Ia53KoHTnEmyGqDpJA39gpbIEVYJdx+pRHRwqL07Y3ZirdJgvCOxxK3WfxxX
         5U8hCq2fxmFaAoN0XFVvuuXCgETBdX3+01KGnvPJPjqz0xQvsSb0ULHA7w169OuI/VJI
         egoLmwMPFpMD03NfHHKC8HL0G/FvF95GifnBHibCfU1yXRH8bWRoDQsXE+v1H5kQ3z3x
         kJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9VqwJSTg8rc2usG/0vrngTL6FGuSAVABcq4ZdVPrdpw=;
        b=8BPMZemxjr8cRBzFbJ1C7FT0LP0wirqINXOQjG1LSyD6j7Hu/JVvldKcHqEq8KxqQW
         CXa1U0hT1/vWoQ89bZBGT+W8wtIxSmH+Ir6CgbqUjyOI1TUXTLEiFo3zOtfUmAnVqTvc
         2tHNdNvgPbZoTiH9UXyjehLao4XTwwd2zQYDaIGj6Khr6uGrSkxAnQZiW9BSzoupBQ0T
         TY9ebC8yepubOiP8ss+/5n2n8bGkxM9dAGnjWD5jkIimq41hnOZsq3nKHnUenn/V4mOa
         /WUppuyRPvaS4/bKU9PuADTN/kEaomwDe3YnUS8HfUTDgFMfIm1Fk8NadBOwirked72c
         JjaA==
X-Gm-Message-State: ACgBeo3KapPOjx3fO+XKCBV24w74iejzlLJi4rAA4EAMjCou3eNjuu3i
        H7JZ5nJkH7m5vqgS1qHKVKU=
X-Google-Smtp-Source: AA6agR4kGjGA4nCpdIXdYIqkyBKYMvorWikVeU+sxJoL2QEmKGHd+ToZ8K6jL0v8Qipi9RVp7UrexA==
X-Received: by 2002:a17:902:9b85:b0:16e:cc02:b9b2 with SMTP id y5-20020a1709029b8500b0016ecc02b9b2mr9732471plp.74.1662657285649;
        Thu, 08 Sep 2022 10:14:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5e60])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a39c400b001ef81574355sm2043513pjf.12.2022.09.08.10.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 10:14:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 8 Sep 2022 07:14:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Christian A. Ehrhardt" <lk@c--e.de>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kernfs: fix use-after-free in __kernfs_remove
Message-ID: <YxojA7pDe8Ur7wpd@slm.duckdns.org>
References: <20220907200811.654034-1-lk@c--e.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907200811.654034-1-lk@c--e.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Christian.

On Wed, Sep 07, 2022 at 10:08:11PM +0200, Christian A. Ehrhardt wrote:
> Concurrent calls to __kernfs_remove can race on the removal
> of the root node: The race occurs if the root node(kn) is freed
> during kernfs_drain. The child node(pos) is explicitly protected
> with an additional ref count. Do the same for the root node.

I don't think this is right. We don't support parallel invocations of
__kernfs_remove() this way. If @kn can be freed during kernfs_drain(), it
also means that it can be freed before kernfs_rwsem is grabbed in
kernfs_remove(). The caller must be responsible for ensuring that @kn
remains allocated. Otherwise, it can't be made reliable.

Thanks.

-- 
tejun
