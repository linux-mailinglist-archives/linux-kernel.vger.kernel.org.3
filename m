Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9384CE2BE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 06:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiCEFQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 00:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiCEFQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 00:16:11 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F867DE06
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 21:15:22 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id w1so9180416qtj.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 21:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Qqre9T83MgFd1lwtm24c1+3QX4c34JcVWYR3R8loqjw=;
        b=Vn1arAadXOHSvHLz68xnnhq0gf+QSxD8O/T+CWFhDuVrYgqpTNmBR0VZgYB4Laz2KP
         sSn6lrIwBpBn3wwRvOaAnK9S9cXF/vJa0yNGT015/OqLDrvEWz3nFils6eENpWXJoibf
         sVcgWmK6i0DJDIE8UdNMjsKxuMqRulLTVrq2QxFpHCrIi3907UuX9eZmx/RvejCP3y37
         OwpCTCc9YWy4z7/So0HShZe1bvRgHI5VhaDLbDySSZm3apZRrMQlsCfjwKq8NNPVlo4c
         aggIYbWpmL9PwxqoLy+mLhan+O5KQJGzsfQlqlayUAWrOXEsPS/BOPIjIE05GmJNiV7J
         W3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Qqre9T83MgFd1lwtm24c1+3QX4c34JcVWYR3R8loqjw=;
        b=EWWYYHCtTAjYxW5Q3LF7bB01YWHa6AzXDHpT8jqh/FzqmD8FYK/6NQfLKsIq/4Ixq6
         K2vst8cSgSiRlgx8mtudcZzY64P36Yg0/pic+sn0i4DsnLJBs7A6vOKm6I7VvLlSIi/i
         S9AexA43ZsuRAM8WqQ683VAe/804Dr83spAKHT8gjs5vrNw+oX10+H718zjd1/M4vuME
         GT/rn4givOVKDGQSUo3H7RiziYkt2kzqPSm4Z/7d5jnLnh56Q8YgR6aKq/RjgIQC6t8G
         Ldym16WZRL21bgKnUyXbp3UOLCHrDhJj2EEd5Pb59ktfuANY1fQXpAKwWYR3AKjWnCt6
         rk5g==
X-Gm-Message-State: AOAM533J+5kj3p6VBKLjf63GYezwYGyk2i5GaN8aDzJBF22sKzlRYC2H
        i/b9x+vIHnYmmUn7+QT9q/7X/loHBKFleA==
X-Google-Smtp-Source: ABdhPJyLN9FchwXjOawdWE592l/DmvKitZNnmI7UIxl2Vuiq8tngW6xc6+R8abAbwa6XE3+k/b86tA==
X-Received: by 2002:ac8:5a4f:0:b0:2dd:e0d4:a4f1 with SMTP id o15-20020ac85a4f000000b002dde0d4a4f1mr1767850qta.478.1646457321243;
        Fri, 04 Mar 2022 21:15:21 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n7-20020a05622a040700b002ddea69efb8sm4796138qtx.56.2022.03.04.21.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 21:15:20 -0800 (PST)
Date:   Fri, 4 Mar 2022 21:15:19 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm 00/15] mm: assorted small fixes and cleanups
In-Reply-To: <8caa60fa-fb3e-e2ea-64fa-65971e382db9@google.com>
Message-ID: <809b613-62a4-1d5b-6610-ebc4c948f49@google.com>
References: <8caa60fa-fb3e-e2ea-64fa-65971e382db9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022, Hugh Dickins wrote:

> Andrew, I'm about to trickle through the first six of probably fifteen
> patches, diffed against against top of next-20220301, equally applicable
> to mmotm 2022-02-28-14-45 (sorry, not looked at 2022-03-02-16-53 yet).
> 
> These are independent patches, which may be applied or dropped as you
> wish: I'm not numbering them N/15, and I'm Cc'ing different interested
> parties on the different patches.
> 
> More to come later today or tomorrow or after, I'm still updating
> commit messages and Cc-lists for the rebased and retested patches: many
> of which go back years, never quite reaching priority for posting until
> now.  I'd hoped to send them earlier in the cycle, but mm/munlock took
> precedence - and the first I'll send is a fix to an issue there.

All sent now, but only 14: there's a KSM might_need_to_copy one that
Andrea and I were discussing a month ago, that I'd hoped to include;
but I find that I just cannot compress the thought I still need to
give it into the time available.

Thanks,
Hugh
