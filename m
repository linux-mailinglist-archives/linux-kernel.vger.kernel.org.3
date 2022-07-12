Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C738570F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiGLBfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGLBfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:35:22 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7162AE1C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:35:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id l124so6218217pfl.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=jXRrOtHMmDMb2DadCR02O1dtCn+wTACMEkhobAkdpNE=;
        b=JLcc59y5fh09ywEyDKJ7x4gepL4JF4hxb2zvX9UVYa87uaRp9ul73Fj6NQr4FUV4h8
         ylxqMYidlIO7XauV86NBKmMiz717kZzmlSORkNNtyyTfEyt6uzmci1umye3/3SZaTm7g
         0XsYCwHYeVkfHhAXqlt++Fx1GUqWmh7NxrX2pO1PPKNBsc40yGTPTqX8EbwDZY0OhPHj
         8f/72F7Qa5qy0N/Ah1wK2rGP96luC6koyDdw22W8h+RQjX4vpqe94mz/9TbtpBy/eD7m
         xKHl6i++amGJhCMYk8HVP7s8suCQUiKnzDd1gRkO5kF/jklTq14OJKRmQmC+d2efY+Y1
         ttuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=jXRrOtHMmDMb2DadCR02O1dtCn+wTACMEkhobAkdpNE=;
        b=OAXuE8kyCuk/F8wygOMktnjXV7T54CuSkYoDfXplYdEgGPmQmyeqJEZoIHIv2iKy8J
         F+KGqbm2Iwbm4ESZnc0c6XpETBJC+wt3qdzKhvH/FAGzUjNJngvQbM7sJMKLh4kksGcR
         18bqNpS9sgurz7calffOJMu7XGS4vEQVHYe5SRpUduRyrWOxONNpZBd63RSARrRfw7xJ
         owTeZ/FRdbd+Q0ecORAbzrVsZVbeUfcSkHka6Pzjudd9syJhk3uWH3/gG3VSwtYJ9jPX
         ZWCkigNSFcGVw1MwhV15koJC7h6qgo3s7KelXhnb0W6lWr9ktihjOjJqrW2EsdF89H8t
         R7ZQ==
X-Gm-Message-State: AJIora/Ex7ppyHVDkTNbGRul/QAPoJom5/POld2FNCnVnnb5J8dsE2I/
        LPRMRP8BjoE2nwW4YJgD6U9sSO40J0EUww==
X-Google-Smtp-Source: AGRyM1uY4XxNFwUuqiwYISuIg8rYGVvu8Y2ALlr00SQqXAJZbRJH72e+bqt0pfXV8c5r62x5nbMFfQ==
X-Received: by 2002:a05:6a00:c92:b0:528:a24f:60f9 with SMTP id a18-20020a056a000c9200b00528a24f60f9mr20853725pfv.47.1657589719888;
        Mon, 11 Jul 2022 18:35:19 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id a200-20020a621ad1000000b0052ab37ef3absm5392606pfa.116.2022.07.11.18.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:35:19 -0700 (PDT)
References: <20220708211755.73637-1-schspa@gmail.com>
 <20220708172614.14191089@gandalf.local.home> <m2v8s7mg78.fsf@gmail.com>
 <20220711161037.06b8c1ea@gandalf.local.home> <m2edyrnny9.fsf@gmail.com>
 <20220711211639.6c714635@gandalf.local.home>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sched/rt: fix bad task migration for rt tasks
Date:   Tue, 12 Jul 2022 09:33:58 +0800
In-reply-to: <20220711211639.6c714635@gandalf.local.home>
Message-ID: <m2sfn7glkk.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 12 Jul 2022 08:53:56 +0800
> Schspa Shi <schspa@gmail.com> wrote:
>
>> How about to change this to 
>> 
>> 			/*
>> 			 * We had to unlock the run queue. In
>> 			 * the mean time, task could have
>> 			 * migrated already or had its affinity changed.
>> 			 * Also make sure that it wasn't scheduled on its rq.
>> 			 * It is possible the task was scheduled, set
>>              * "migrate_disabled" and then got preempted, And we
>>              * check task migration disable flag here too.
>> 			 */
>
> That's better. But of course it needs better formatting ;-)
>
> -- Steve

I have upload a v5 patch for this comment change, please review it. ;-)
Link: https://lore.kernel.org/all/20220712013125.623338-1-schspa@gmail.com/T/#t

-- 
BRs
Schspa Shi
