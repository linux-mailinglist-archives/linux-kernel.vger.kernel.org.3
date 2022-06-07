Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2AA54046B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345582AbiFGRK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344376AbiFGRKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:10:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870D69EB78
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:10:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o17so15349467pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kwTj8YdOZuObst4wtD8K+l0PjZhJW9HIxjZQ2N68gPU=;
        b=I4XhUF0QLsLtO9JMos0AshxMgyk0PgU+5pXlw29bOrsglbjgVZjP4Ajh6cKi/ATJLf
         aIpQ+8a/GocLXjoU9QPYVk6EAYX5jtDut8keUZoMOX0uFLb/3BUfzECChdOYdsRCx7E+
         anrwvETCzfgCQzAy5yTVltvF6E/yLKoHHsSPzMoCPAnxQemlLvhasbQQn3pPPKJFsGI+
         QRfr4UXwBMdzoCmEAsye7TwKQBGz0xdPu1G9A98JNQg+4775eFTyY/ZSmN1ydNQOTnuq
         4dHxPf61Hhqp/WWnaC1UvS2eOJUO0GHV5TozkA0ILhyNVY/Qr3TflyVo3Ue54Ak7+3ur
         vXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kwTj8YdOZuObst4wtD8K+l0PjZhJW9HIxjZQ2N68gPU=;
        b=Rgu39rEreENbcGJ65OXNyfwfEUbTsFqXMZs9RLNe+hR4e7Nu7JiqyD0evTuskU2+7n
         oOUoFr9pfnL3q48LNFczdC+rer/kSp07pKaGpjJHAysoWVd4gsgvyJClI9yeBebMFU7O
         lLZqIcuWx4vJbkk5RiK11bXbPE5woOtwQRyACyv7XaQQZ7mb1hUBTEk9OvpN2D4lgMTF
         WIzzqr2N8KtDX/gUW1/iatYY72bE5/VByaRB6HJEzFrk6o+odKg6jfnzkW45Q12AF3b4
         feZOo/j79XwY6mcXA4GMuUs/PmuJ6StQH2GVrRiKhAKDVnOHGjwkVnP0xWK9OTBNKL05
         KLdQ==
X-Gm-Message-State: AOAM533wza9q9cRfwV25aBf0/SfY8TG1Ke7dG0j3UjBCl/qBbCXSyEAl
        5+Sd+ANrf9Sry47fzuUkt0ZwAhM9MkM=
X-Google-Smtp-Source: ABdhPJwU7mwPjQCL/TfQIjW4MTYbhds14voQib5wpIY44O4uy8yMg7myonvF7SYSpt0Y8/m/rpkmJA==
X-Received: by 2002:a17:90b:4d90:b0:1e3:3025:66fe with SMTP id oj16-20020a17090b4d9000b001e3302566femr44518776pjb.145.1654621821873;
        Tue, 07 Jun 2022 10:10:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:fa4d])
        by smtp.gmail.com with ESMTPSA id x65-20020a627c44000000b0050dc7628168sm13133463pfc.66.2022.06.07.10.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:10:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 7 Jun 2022 07:10:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix type of cpu in trace event
Message-ID: <Yp+Ge8aITdgczA33@slm.duckdns.org>
References: <20220504023204.598531-1-vvghjk1234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504023204.598531-1-vvghjk1234@gmail.com>
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

On Wed, May 04, 2022 at 11:32:03AM +0900, Wonhyuk Yang wrote:
> The trace event "workqueue_queue_work" use unsigned int type for
> req_cpu, cpu. This casue confusing cpu number like below log.
> 
> $ cat /sys/kernel/debug/tracing/trace
> cat-317  [001] ...: workqueue_queue_work: ... req_cpu=8192 cpu=4294967295
> 
> So, change unsigned type to signed type in the trace event. After
> applying this patch, cpu number will be printed as -1 instead of
> 4294967295 as folllows.
> 
> $ cat /sys/kernel/debug/tracing/trace
> cat-1338  [002] ...: workqueue_queue_work: ... req_cpu=8192 cpu=-1
> 
> Cc: Baik Song An <bsahn@etri.re.kr>
> Cc: Hong Yeon Kim <kimhy@etri.re.kr>
> Cc: Taeung Song <taeung@reallinux.co.kr>
> Cc: linuxgeek@linuxgeek.io
> Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>

Applied to wq/for-5.19-fixes.

Thanks.

-- 
tejun
