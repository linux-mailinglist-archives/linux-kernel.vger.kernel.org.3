Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F0C54784A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 05:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiFLDNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 23:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiFLDNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 23:13:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAA82624
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 20:13:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso5758181pjl.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 20:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lOgAHSiJT1Ngpj0heEB7AArM9YKndUmEvJTCZaDYlAU=;
        b=mafhm2wm5Pb3UDVOJx+5BbrYe0URZx/DJjQaWBE+8RekPGDkLh6XL9byr3JXAo1Fz/
         RCp3YhlTTdzhW1pWA/h3eoq8bJhsFUKhl0Elk4SolPH9WvhC8MRL0zmKPBDpQLhITagT
         mGyLx5p27vY+p/ygF7fvSnZ3C2HIfi+IsSPao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lOgAHSiJT1Ngpj0heEB7AArM9YKndUmEvJTCZaDYlAU=;
        b=nEev9N7jyX5FVQY4R9CR/lYQAqDuLy1gpiAPYk+/16+ePU7Z/IX4nanUHc+lZKJYzz
         ix4ErNQFdJp8UkzSSMe9Q9AtGxWuN45qDtT1Q1PtQxtFktPvnrn0sqjWcLFRXKiVdSe8
         TSj01QS4yaI40yPla+deU3v4ZVuZ4tNduEDb+Bo5z2wqdtp3Tria3PPbNdPw5mGNI+u1
         RRRwVEnRI+uf8eaZkfp8KJRRl1nSdxurkbW40Vhavm5nEIU0Sde6HRYlom4mmDY41/BY
         B43oXChOh3pJN+INVJZ3JyCk1pK7y1FpdogHqABULUyj0hAG1UPkB0+oSpigNKZpZRH1
         QSzg==
X-Gm-Message-State: AOAM5322ZbrzNn97D/jl5PUHXm38kVrzKmgbX9ctqXpVwbL2vrB/pt5U
        NYIAWRfBavUEmysSRk0UGbxOkQ==
X-Google-Smtp-Source: ABdhPJzHOJF/7pbpsOby5kMUc8bfhWVW3/PFv3W7ClE96QVQymHI7YMRXE35CKe79pGo3nzQN8P5Xg==
X-Received: by 2002:a17:90a:eb11:b0:1e6:7865:4ecb with SMTP id j17-20020a17090aeb1100b001e678654ecbmr8090579pjz.172.1655003621107;
        Sat, 11 Jun 2022 20:13:41 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:a53:f177:9f19:3ef9])
        by smtp.gmail.com with ESMTPSA id g3-20020a62f943000000b0051be2ae1fb5sm2311329pfm.61.2022.06.11.20.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 20:13:40 -0700 (PDT)
Date:   Sun, 12 Jun 2022 12:13:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
Message-ID: <YqVZ4CyWTiDgngkA@google.com>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1y48spg.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/10 17:11), John Ogness wrote:
> It would be trivial to provide a boot parameter for this behavior, but I
> think we first need to see a real problem and also see if we can fix
> that problem.

John, Petr, a quick question

Should a situation when we have only one online CPU be enough of a reason
to do direct printing? Otherwise we might not have CPUs to wakeup khtread on,
e.g. when CPU that printk is in atomic section for too long.

---

@@ -480,6 +480,9 @@ static inline bool allow_direct_printing(void)
 	if (!printk_kthreads_available)
 		return true;
 
+	if (num_online_cpus() == 1)
+		return true;
+
 	/*
 	 * Prefer direct printing when the system is in a problematic state.
 	 * The context that sets this state will always see the updated value.
