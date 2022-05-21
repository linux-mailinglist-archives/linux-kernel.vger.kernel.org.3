Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4452FEF1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 21:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345069AbiEUTXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 15:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiEUTXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 15:23:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBE63A731
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 12:23:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so15521190wrg.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fmSLJRmyPvYhJQlYJuWNQHn/82kAZpr9Fa7yUQ0wfjo=;
        b=DfWPkhG4KefoimoF62GlyKfWv5m/mWoo/nrVTceetD4kcywARYolCJdV/6aQaC5XVW
         OQ7aRvfYiMwAczBkEs3qid7u/N2aAks7tungtB+mo04vyM3qtFA4kT4Dm9+rN3Jgo75I
         ZglsNR7q8fxfS42UhlzrQ7BfRY0s6Tir3S6no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmSLJRmyPvYhJQlYJuWNQHn/82kAZpr9Fa7yUQ0wfjo=;
        b=tdI1kR8ENIO4Nwquri/0LBCJGoPoBVgCna06QOv1P0GKI+ZZNZCmjlysYoZSe9lM01
         H8Ccl7TILjDyxEYt/TuFhUkg20vQzJPZ/c4OD0zUARHYElYfJyTEm/J5CCrO0J585Abj
         S7CqvLKc9InglRWrjnKkLzc6JKw0z0feCW0xX7DcGxF9UsWU/DjDNFsp+Iu0W308DUxR
         JYFzrt4umDR3msm35KAJctM6LeJ2YpQbA7EBC3YBw7W4YpMcZiL49NwEl6YtRDrw+0VO
         BSG445Pd9mJSRionJIj30M+LJffj4i+aH80Q6eoojIjrcUawZVkooDKhhPW7kW1+q+DH
         pAbA==
X-Gm-Message-State: AOAM5306E9ZM9DsU1Yy8aNHGp379hG/V34pQ4X69PULVY/+QacaV0pah
        aXsH9vlbb9nvb/vpwPawI0JCjMFRDAIc+Q==
X-Google-Smtp-Source: ABdhPJwrTuVN5pH3z6uJdpaeX1JEvTd076Cu7XIJzR0RguT//F25E0YPDSF5cYI7IbPZ9W3ARtz9uQ==
X-Received: by 2002:a5d:6701:0:b0:20c:dc44:f7e7 with SMTP id o1-20020a5d6701000000b0020cdc44f7e7mr12957027wru.484.1653160987427;
        Sat, 21 May 2022 12:23:07 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id u6-20020adfc646000000b0020d0c48d135sm5989350wrg.15.2022.05.21.12.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 12:23:06 -0700 (PDT)
Date:   Sat, 21 May 2022 20:23:06 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [RFC PATCH v2] printk: console: Allow each console to have its
 own loglevel
Message-ID: <Yok8GtbfXkc1E0PR@chrisdown.name>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <Yok0yjx0aKvlgoIL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Yok0yjx0aKvlgoIL@kroah.com>
User-Agent: Mutt/2.2.5 (a8c7fba1) (2022-05-16)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman writes:
>You forgot what changed from v1 :(

Whoops! I must have accidentally nuked it when writing the mail.

The list should be:

- Dynamically allocate struct device*
- Document sysfs attributes in Documentation/ABI/
- Use sysfs_emit() instead of sprintf() in dev sysfs files
- Remove WARN_ON() for device_add/IS_ERR(console_class)
- Remove "soon" comment for kernel.printk, wait to discuss timeline with Petr
- Fix !CONFIG_PRINTK build
- Fix device_unregister() NULL dereference if called before class setup
- Add new documentation to MAINTAINERS

>Anyway, the driver model interaction looks good to me, nice work, no
>objections at all.

Great, thanks for checking it over :-)
