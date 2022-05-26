Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDB55353B0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348670AbiEZS4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348649AbiEZS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:56:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BD2CC155
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:56:01 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y189so2395835pfy.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C23ku60u5EbcBtHDM0AvRYZ9fyGdZC0fsc/OWH0Q2Bo=;
        b=CzDVt5+0oQ4YdZ25DftcUtcOo9puptREsJGh6kStUtHLsiG3a51UKOFcBCQWGAHz8L
         LsewvqTAm4PAJUSPfIu1urJRNcxxW3Z3M63Caa0SOzfZcC9qJtrmmL5TjVj2Bpp2oaLE
         l0d771pItRmXXUKBQWqym60FEuEeQHD6iI4UR2HHqDLIsQ8UdhKAR8db2Arg8Yj6S5kS
         5e7yumUXd2sjWycHiDgyverKbEfaQeaQdXoyNjtIxBE22rFzXSm2PMxLG7gQ36+DwMws
         CL6EqB3Di7KUS6Jd8CaW9IeSdzfqvK6+U8JUTLEKaN8Tq0RM1+jmMfyYSBko6lg/szMh
         Yr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=C23ku60u5EbcBtHDM0AvRYZ9fyGdZC0fsc/OWH0Q2Bo=;
        b=6bj7vlA+j0Fw93mpmHr9cm8gM4fkpwzFhgQ4Wzd5gqQFDCWZtpRHpt+43KJL33YdSa
         ChRvDvk28+dKnswN89Qa9sME5vtWI4zMTqSvA1r+DlIQs2oMHbrvaH1JsN0WoJXuY+/r
         DJ4IN0COa8spQVmI/t5eIvWhvZ7Yq9yLQ6YOn9dcOfFiEVpkK+L8btdiLzVUnB/KQ865
         VPqDt157fheYSyQTIzrTL3U3UNuMH6vh8IBw4A6asu+HXDnABoYGL8rQvuQIj2WBLw59
         AdteS0fApFg+xgbcwkwDCzsK8V1rDXwkWKN6Vy3HdTvfS/JBTsSzek+PuxrpCnTafQk6
         rnfQ==
X-Gm-Message-State: AOAM532y+jcH48xaDijLG9dHiIp97g9GaAZiXRwxvTIMHCrUqRT3VkGP
        q8nhhAYTeZ7AVCr7NBIbayYeJ0mPLeU=
X-Google-Smtp-Source: ABdhPJxZMhMAjhxQZZDv6TJ/bk+5+JOPLY0CGxLMkTHmSiZzWwIMhhfaXuT0C2q9BLRWk+Lauv9guA==
X-Received: by 2002:a63:d04f:0:b0:3f2:76be:bf2e with SMTP id s15-20020a63d04f000000b003f276bebf2emr33624888pgi.15.1653591360823;
        Thu, 26 May 2022 11:56:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:aafd])
        by smtp.gmail.com with ESMTPSA id q21-20020aa79615000000b0050dc76281ecsm1857273pfg.198.2022.05.26.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:56:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 May 2022 08:55:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wonhyuk Yang <vvghjk1234@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix type of cpu in trace event
Message-ID: <Yo/NPkJW9vnuHBcr@slm.duckdns.org>
References: <20220504023204.598531-1-vvghjk1234@gmail.com>
 <20220524162912.0133006b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524162912.0133006b@gandalf.local.home>
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

On Tue, May 24, 2022 at 04:29:12PM -0400, Steven Rostedt wrote:
> On Wed,  4 May 2022 11:32:03 +0900
> Wonhyuk Yang <vvghjk1234@gmail.com> wrote:
> 
> > The trace event "workqueue_queue_work" use unsigned int type for
> > req_cpu, cpu. This casue confusing cpu number like below log.
> > 
> > $ cat /sys/kernel/debug/tracing/trace
> > cat-317  [001] ...: workqueue_queue_work: ... req_cpu=8192 cpu=4294967295
> > 
> > So, change unsigned type to signed type in the trace event. After
> > applying this patch, cpu number will be printed as -1 instead of
> > 4294967295 as folllows.
> > 
> 
> I was going through my backlog of pending patches and came across this.
> Note, that trace events are maintained by the subsystem they belong to.
> This change is for workqueues, not tracing (as your subject correctly
> states).
> 
> I Cc'd Tejun here as he maintains this code.

I'll apply it to the wq tree once rc1 drops.

Thanks.

-- 
tejun
