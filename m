Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE7457BDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiGTS30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbiGTS3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:29:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839242D1CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:29:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sz17so34563922ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GHqH2gRrV/2rxKtA8XWYjPMg6Oti9PuMW2VK8iNu510=;
        b=iIFMWd57K6F8Ajkt/8N+ejZVpLGcvgCDYhigVjRaLZLE56u1Irb6VENXs+jjDpW57S
         gjH+Ufkzl95t3zGda578UKosQKe5DnAIs6f2FhDr8Algd7D3XstYz0VEuElYe8KrSknv
         ixOwLjA/zLxFurnkUVm38Hcp7UGf1rJEdsV70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GHqH2gRrV/2rxKtA8XWYjPMg6Oti9PuMW2VK8iNu510=;
        b=MRcBiO9tLdiGk6GBzkD34arJ7U2SAlhtbDN5ldf73Hf5uuIZQtrKWmS/KJyoTzbVDd
         48VbQxbUt9WZFFTUjpsy3GeqXreyuZhLDn3CpTZyRITHJEIcjAG1h1b0Ro7nUTgLp+qi
         dKnaOOcrvctOsOyF8k95SZ1AH8hytwa7Qm2+9dNVE8nHVgq/CIkCViaIPpZNYZtgjxtJ
         t4sTvQTu3X1hrZLiaH9N7KHQG8lshJNIsa5sQq+KT3OhQG0YGaEXCjVDEC4yXnUZPgHe
         UlzxE/b4wf4Gz9iVhF/0I3rw2S+pbGQ3lUPgKZHxjulePTIjr2F/E0Zx4obObpd95SPm
         AlVw==
X-Gm-Message-State: AJIora8nIgHJn4rLE6AcW4aUeMNpyW/D9RFj5qmdY5cQdDmrLQaqVHyt
        YscJ/dAqdFAbKzQAJTv9HBFW71ilN4Kb3A==
X-Google-Smtp-Source: AGRyM1vSFfNvRCAS+LNYuPUOmsNWVDJVJ3mc3clgh8W0mkfpMdbKp/pCrIvG4SEbRwPt9uTVDoXpmg==
X-Received: by 2002:a17:907:6d8b:b0:72b:5f51:a9e7 with SMTP id sb11-20020a1709076d8b00b0072b5f51a9e7mr37176431ejc.628.1658341761990;
        Wed, 20 Jul 2022 11:29:21 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:d58e])
        by smtp.gmail.com with ESMTPSA id gt2-20020a170906f20200b0072b342ad997sm8074418ejb.199.2022.07.20.11.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:29:21 -0700 (PDT)
Date:   Wed, 20 Jul 2022 19:29:20 +0100
From:   Chris Down <chris@chrisdown.name>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 0/2] printk: console: Per-console loglevels
Message-ID: <YthJgH5sIct8LeXw@chrisdown.name>
References: <cover.1658339046.git.chris@chrisdown.name>
 <87edyfmypa.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87edyfmypa.fsf@jogness.linutronix.de>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Ogness writes:
>On 2022-07-20, Chris Down <chris@chrisdown.name> wrote:
>> v3:
>>
>> - Update to work with John's kthread patches
>
>This will get a bit tricky, since I am also preparing a new kthread
>series. But for now it is helpful to base your work on the previous
>kthread work.

No worries -- I don't think it should get too bad. If I recall correctly, the 
only real changes were around handling suppress_message_printing in the new 
model, and they were fairly minor.

>Thanks for your efforts on this!

Likewise on the kthread work! Just let me know if/when you want me to rebase. 
:-)
