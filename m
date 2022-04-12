Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADAA4FCBDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245439AbiDLB2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiDLB16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:27:58 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B886A1A824;
        Mon, 11 Apr 2022 18:25:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h5so14790292pgc.7;
        Mon, 11 Apr 2022 18:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNhAr9IyPTBjGimzBz9nywCikjUEwdp04TPn/doIlVY=;
        b=DQokl79QPCuTveZ0JPDhUGU2LZxaZUQ4bL40Op784Me21fu1M2W3ZAOi6lhhzqCjzL
         4Lq6kGJ5sC4UzZH7Ji2QBZZpx/iZlRENsNY6F+d742sBmnwi54zZe3yxB5wuJjCXeALv
         aHOMnFiMHhoGYBQ4JIuIMqLnAYdONA9vA+WKmiKgYeec0xcGgmq7N5Gv/dF7oyGWB5GO
         rd2/InIjSIHlngKpYjenjEY6SlthUYLK+NE4vpN7rWgz7Gw0s7HojulaCyY8Xpqa4Lbt
         LICU5/gv6RIk2AX8TdfeQ8XRU1YQ5O9ZKFKDejDZA85OQmyU6rsMvbF8gfjgBrv01rFw
         klUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNhAr9IyPTBjGimzBz9nywCikjUEwdp04TPn/doIlVY=;
        b=sdfUkCrISTi38kbKj6to9xPbxDsJ47b2Fnc5WIWsWI3EIUXH8Ztt/ajPN/NsoB9pum
         BmjjI7IP6gU7AEhG7WbLUpkrmRjKLS8Hg57OC1nev++a+qqfRmJ7YFjTgASSF95QFOCG
         Ykr8btHKluWZvFK5XTbQ0IxaxEsj/uJjIpIK+0zLP7UxijhbQo4zKp9vwxoXQdfAGqmB
         1/YpwwbzmePt4L/dS0K6sfGiUEEAhSjsWWA/ekIXE2kr5Hysur7yKU6UnuH8ceUMDiKr
         JV0cHSTUvKEf77RjVzCuM5xCeQWQGd5e1QZaatyLOYKbEYtSJwU0VFDQ2qrur7a2FugS
         OGhA==
X-Gm-Message-State: AOAM532I6tzFw+kEU6RIUAUm52y1of2aXJ5klj8+uZFXrDDC2EdS0Iym
        3R0YtJ/qSOoPqSxUO456nY8=
X-Google-Smtp-Source: ABdhPJzq9/iX0tXOPjv+uevKkGpblIWdbUcvmdxEovaAZUO/l3DnrZBv16KOsMdG3HcPW+JUhBHgWA==
X-Received: by 2002:a63:1061:0:b0:399:5cd:3ddf with SMTP id 33-20020a631061000000b0039905cd3ddfmr28131265pgq.271.1649726742096;
        Mon, 11 Apr 2022 18:25:42 -0700 (PDT)
Received: from localhost.localdomain ([103.149.162.115])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090a3d4500b001c97528521asm707461pjf.6.2022.04.11.18.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 18:25:41 -0700 (PDT)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     like.xu.linux@gmail.com
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jmattson@google.com,
        jolsa@kernel.org, joro@8bytes.org, kim.phillips@amd.com,
        kvmx86@gmail.com, liam.merwick@oracle.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@kernel.org, namhyung@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH] perf/x86/amd: cpu_hw_events::perf_ctr_virt_mask should only be used on host
Date:   Tue, 12 Apr 2022 09:25:30 +0800
Message-Id: <20220412012530.794790-1-sidongli1997@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <edfc8bd1-8dc3-9e88-d9c3-6a427b039a98@gmail.com>
References: <edfc8bd1-8dc3-9e88-d9c3-6a427b039a98@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Apr 2022 22:29:18 +0800, Like Xu wrote:
> Or you can work it out to make nested vPMU functional on AMD.
Unless in the future kvm wants to emulate on L1 HV the behavior of not
count when HO bit is set and SVM is disabled, otherwise it doesn't make
sense to use perf_ctr_virt_mask in the guest to mask HO bit. At least for
now, this patch helps clarify what perf_ctr_virt_mask actually does.

> This is not a typical revert commit.
Thanks for pointing out the problem with my patch,
I will write another patch specifically to revert this commit.

> Please check the chronological order of the related commits and the motivations.
I know that commit df51fe7ea1c1c fixed the problem of use vPMU on old KVM,
but I think it's a speculative way and make things a little obscure,
because this #GP is actually a KVM problem rather than a guest problem,
I think it is the user's responsibility to update their host kernel.

> > +	/*
> > +	 * When SVM is disabled, set the Host-Only bit will cause the
> > +	 * performance counter to not work.
> It's ridiculous. Based on the AMD APM Table 13-3. Host/Guest Only Bits,
> the performance counter would count "Host events" rather than "not work".
You are wrong, you can test it on the host, and the description of the
commit 1018faa6cf23 also pointed out this problem, this is the result of an
experiment, AMD APM has not documented this problem.

I forgot to say this is the behavior on the host, I will improve this
comment to specify 'why' more clearly, like this:
	/*
	 * It turns out that when SVM is disabled on the host (L0), set the
	 * Host-Only bit will cause the performance counter to not count.
	 */

> Note, your proposal change should work on the L0, L1 and L2.
Yes, I tested it on L0, L1, L2 with 5.18-rc1 and it works as expected.

There is a related discussion here:
https://lore.kernel.org/all/20220320002106.1800166-1-sidongli1997@gmail.com/

Regards,
Dongli

