Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A5E5879D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiHBJaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiHBJaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA96AE4
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659432608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gCQL5oYgdfdTOpZC0jukFwSa1JOhBskIQFaqiHYoNg8=;
        b=Nq2jQmFCzlOPsyJ+A9G0Kqjo0TfhLSJbb9pT8ypP0DIeShcqQhHb5KWDbJrLd53YW//+aq
        ceU2YXXX35DS9BW+ptMRWhVceOxVclzVtIx+3u3QrJl0Zi2Qxo+tTiXCWPPV19K09QXXdx
        35AEL8raMkaZjJ2GOUbXyuLxbWD0Ny0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-rYnJrw9APr2ioC3s2Ph3sw-1; Tue, 02 Aug 2022 05:30:05 -0400
X-MC-Unique: rYnJrw9APr2ioC3s2Ph3sw-1
Received: by mail-wr1-f71.google.com with SMTP id m7-20020adfa3c7000000b0021ef71807e3so3294789wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 02:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=gCQL5oYgdfdTOpZC0jukFwSa1JOhBskIQFaqiHYoNg8=;
        b=B7gpsR1vX1MvHPXW2HaJpSgkX/sd6rtL8WCWM3HetaHd1/NxC++2ATSBlXLMayewaE
         BWLIoqE8RqGhlGQYWs6tXNXMVypyO9n2f39y2/yyLPDdtbdzII/Ub4mMJbr0nrSA9yWY
         M7Gj2NV0CeCd9RAMUqouVlHaNML5pBTAf9J+bv4UICdDQcEd5lTuBP7MLsBftx/DKSmH
         I1ZQ/aSN2a7hdpMedhLN6EucQmU0S2RkjBfE3p1gjzA6E+zTth/pa9lyV9P/BGqJpLsx
         CM+ECC8I6VRfimH00pL/O6CRNA/1Q2Cw/gdOXnGM1awLHKH8/wBk9N9eVsE7nNb/0Os7
         n61g==
X-Gm-Message-State: ACgBeo3sCJVdK73BFhRF5WJBSLi1djctlEahKGQkZs+4yKvO49MNRc/Q
        Ipaig0Ocd1oacrjg07VStS4H88frHm/gSMLK9+lE0HWzJq5vanOx/MamSxmkPsM7U6aVD9qnJyc
        I6/U29H1C6caJ0kCwsiPeEKjU
X-Received: by 2002:a05:6000:1e19:b0:21f:c32:f45b with SMTP id bj25-20020a0560001e1900b0021f0c32f45bmr12845904wrb.657.1659432604396;
        Tue, 02 Aug 2022 02:30:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7nyc9pQL0uo0LoL9u2fTVhl885ZRUItugwEluHeWNoGIKBRG9DetFA4PC0R4QnBGH2G4P5mg==
X-Received: by 2002:a05:6000:1e19:b0:21f:c32:f45b with SMTP id bj25-20020a0560001e1900b0021f0c32f45bmr12845888wrb.657.1659432604236;
        Tue, 02 Aug 2022 02:30:04 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id q4-20020adfcd84000000b00220606afdf4sm7267620wrj.43.2022.08.02.02.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 02:30:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: "Dying CPU not properly vacated" splat
In-Reply-To: <20220705172342.GB1790663@paulmck-ThinkPad-P17-Gen-1>
References: <20220421193821.GA173010@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh4k2h9m26.mognet@vschneid.remote.csb>
 <20220425173320.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh1qxkakof.mognet@vschneid.remote.csb>
 <20220426000328.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <xhsmhy1zr99zt.mognet@vschneid.remote.csb>
 <20220426162445.GG4285@paulmck-ThinkPad-P17-Gen-1>
 <20220622195856.GA1694215@paulmck-ThinkPad-P17-Gen-1>
 <xhsmhzghof1eo.mognet@vschneid.remote.csb>
 <20220705172342.GB1790663@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 02 Aug 2022 10:30:02 +0100
Message-ID: <xhsmhsfmfc7s5.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/22 10:23, Paul E. McKenney wrote:
> The second of these occurred near shutdown, but the first was quite some
> time before shutdown.  In case that makes a difference.
>
> I have not seen this since.
>
> Any other diagnostics I should add?
>

Sorry, I let this get buried to the bottom of my inbox :(

I've had another look at rcutorture.c but just like for
rcu_torture_reader(), I don't see any obvious culprit (no
kthread_set_per_cpu() usage)).

One thing I think would help is a scheduling trace (say sched_switch,
sched_wakeup and cpuhp*, combined with ftrace_dump_on_oops + panic_on_warn
?) - that should at least tell us if the issue is in the wakeup placement
(if the task gets placed on a dying CPU *after* CPUHP_AP_ACTIVE), or in the
balance_push() mechanism (the task was *already* on the CPU when it started
dying and never moved away).

Neither make sense to me, but it has to be somewhere in there...

>                                                       Thanx, Paul

