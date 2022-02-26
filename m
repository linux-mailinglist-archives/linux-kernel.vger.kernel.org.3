Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102324C5353
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 03:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiBZCXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 21:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiBZCXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 21:23:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C861C4681
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 18:23:11 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso9976422pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 18:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TSCxVED1rSiRmk5/g+UpxyihtrfwTGTVYQufXRcc0Uk=;
        b=I7teuVA0+WlEFHMBXoGKne0PVNPz8sZVLzcaCjqQ4eaRIf3Iw/nw9UChdW4vUDqHSq
         Y8sJ5dtdbBdHIgIMZd8UF8llTzl4BkCBBRo6KuxPQKErgEhM2wSUSOKFV3EDa6HeCkSG
         9cN+OYgit3BauazEVSOb60UUL5NQfBa4d4P9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TSCxVED1rSiRmk5/g+UpxyihtrfwTGTVYQufXRcc0Uk=;
        b=JluHduJPKdfQYrLrGw34DkPYnxi3nExNxqPRwzMuxNX88V7SIEUcMNpd0Pgok+Leeu
         n3ULfqCD4CcrvrQdaThA75Wo0xqWPHwomSOxbintYjqf91SOP9WOrH+cy5N4kEyIwH8j
         87KSRN3cSPZERnTLFyiV8sEGxJRYBWQJON0cggXWzf8721Al34XLZIkvIzxf/aaxMZaj
         LI03JHZXS5i4JmpXAUm71zZPXbxT/csIcfAJfm1tvQBY9dbAInvqoNWwcjI3F8LLNL+D
         wQjzWVX5zBWvrnfWL+TNibi+FaLmhLCI4DDC/Gr1PcBpumYhx6mGOFDE6ZeZq6lLE75k
         d5sg==
X-Gm-Message-State: AOAM533F6bhnuuryVunVNsoLHwvSIDKDJR9rdtBuLFaCgS/1XzuVYkW9
        Ptd11MFBeW6E+BG+uz7ZCOfGxg==
X-Google-Smtp-Source: ABdhPJx6aNIx/6hBLLZL5W5WvF0xTHirANO8pk6FTXIxARIiW6HbgZ1mwK6IepR58g6EvFIWlSELow==
X-Received: by 2002:a17:902:8492:b0:14d:5ddc:9df6 with SMTP id c18-20020a170902849200b0014d5ddc9df6mr10218805plo.15.1645842191225;
        Fri, 25 Feb 2022 18:23:11 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:d7ef:f0a2:708b:c03e])
        by smtp.gmail.com with ESMTPSA id e2-20020a056a00162200b004e0a8002697sm4448265pfc.123.2022.02.25.18.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 18:23:10 -0800 (PST)
Date:   Sat, 26 Feb 2022 02:23:04 +0000
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, bhe@redhat.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <YhmPCE4zn5Nup+ou@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com>
 <YheXRmmWr619Qxin@alley>
 <YhhmnmgAlVCcVqSV@google.com>
 <YhjIsPpA0kN1yeOM@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhjIsPpA0kN1yeOM@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/25 13:16), Petr Mladek wrote:
> 
> The result looks good to me. We could do it as a followup patch.
> 

Yup, sounds good to me. Thanks.
