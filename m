Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B234B41E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbiBNGN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:13:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240811AbiBNGNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:13:07 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B815714E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:12:56 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t36so16696809pfg.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AIyxw6VD2birfVNG9mzqYS0kDTvCKpwioYeMmhajnSM=;
        b=StfLOZ7DnPjcM9uaz1SnJzIzEfqDROQ1+XQ3CvIG/V/8CmyN6atPB9oZZR57OGV2fQ
         dBCumgmyLbLYAUgRxefTDpGMvmdDUUQSXTyFeW6F8gSA4l7jgB95Th8apLo6/tTr7Z1C
         Xe3gZqwr8W0Otp67PE+iaQeIh9r6YujIaFUfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AIyxw6VD2birfVNG9mzqYS0kDTvCKpwioYeMmhajnSM=;
        b=vCVduleKRR6d2klzK/DiT9o1gqIUDMloEfcRoKgMjdTAtJqHd2AITAxtEzKkKwnfoo
         dOxjOYcAqwJaSz6aZbkCR60yu2/rGy31EX65+b+xs+6eavh15j2L3owWfYbjEbI3wTLP
         Fyd1CciQz+K2c2YoYZ6Fo54fqkXCe0MFt3IuHy69bOFEFA1j+HfnSdZHR/3sd/KKciFM
         vv5XWO5SI2lc9JgG7oasuFuIKibTRI8mU5EisgBcysfqnsZeO75kfVFjLidGUesqiSPI
         vZxtLdSZFq+rJanj0umgJaF7AJnQGr6lZJXfQiTmLPPNVxxRH4STfAb0JxN7v4dW0U5c
         T5jw==
X-Gm-Message-State: AOAM531sZN6oi9a1FjQ8mOxl5lRhH+Cn6rsMQSdzZah8+Wp1ZT5He/da
        eBdCzICGRplfuMB6xzqxFQeUSQ==
X-Google-Smtp-Source: ABdhPJxdxmOTnAGjH0A2SJGQaLjSzfA+kqHMHRz9+eCyUdcZXO2BoRxAPy4D0XGHAnr84lZVzTbnQg==
X-Received: by 2002:aa7:88c9:: with SMTP id k9mr12797096pff.58.1644819176310;
        Sun, 13 Feb 2022 22:12:56 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3a3d:6c6e:58a7:8903])
        by smtp.gmail.com with ESMTPSA id l16sm11930125pjz.38.2022.02.13.22.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 22:12:55 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:12:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH printk v1 10/13] printk: add kthread console printers
Message-ID: <Ygny42nqV+3R5fp9@google.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220208083620.2736-1-hdanton@sina.com>
 <87v8xpmx9n.fsf@jogness.linutronix.de>
 <YgKD6X9eiADTnvIi@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgKD6X9eiADTnvIi@alley>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/08 15:53), Petr Mladek wrote:
> My mine concern is that the kthread_worker API still uses an internal
> lock. And it is yet another layer that might be hard to debug when
> printk() does not work.

Isn't this also true for kthreads? Looks like we add "couple of spin_locks"
to the picture - rq, etc. - one way of the other.
