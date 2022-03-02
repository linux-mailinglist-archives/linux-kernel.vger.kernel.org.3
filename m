Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC8F4CA9C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiCBQB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241512AbiCBQBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:01:23 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0785938B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:00:40 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id x14so1710668ill.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 08:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nk6Kahyrhb5yNQq5f9IHun18wXpxRfQnoxvt0M9WLOU=;
        b=qv4JtwVzupacsXxFEA51XjQXQrapkBiIlNukwNNtiPz7kYYK+Jym2cZjsBbPe35OCk
         8T+zGsiOD6jYNcPWjLLrFkWFCF8xbJo99C3vw08Xt46nRaZRl1d+eT1vAugHabb9NOF2
         DiHyEBEkLbo0uDL4LqggDzGX3XvY3812/8sng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nk6Kahyrhb5yNQq5f9IHun18wXpxRfQnoxvt0M9WLOU=;
        b=VG+aRS+dpHw7FR84dJFF87+hcDa73oJ84/DTMpFGBgYXsJEL15KCamftkMBXKrOIrh
         C7V79y88lR+rrBHbRSBDS1v6N7fKliGjY2aHqakG41xiLcpR6o0kHY6rsYaTaPrVUkHJ
         mwqvcc8obHtVAKwuXvRX1xkShBO5n8wgSl2yjptzd2oBQdItyr28FwEaO0wX3AEMgaZP
         F3yTjDGSUvV1R/nlzOClsBIWJVHfOJ53HaL4F9SPb6BtDrl/jlja2Y5XDHhnji8MY5S1
         msHFKl6/WCjrlvSsXRbpC4RXfIhVNl3vgmDbW2vH8e9pog0nwagfnCWr2VIksAuMQnlI
         BDIg==
X-Gm-Message-State: AOAM530QvWPztxVophgbCvIHaQ5ZLRI3J3BBhW2/yh6FXtzzu3/cf1GY
        LGsMRTtPzFGORrLcpvz91jSvuOvfYrr2PJfXgejk0cBfY/Y=
X-Google-Smtp-Source: ABdhPJylDEw1JTxWMePaUsTyGP2rrN4hCFhUC/Xeh4vGlw2rVFsKqwhvTs42gW7hcczsQ7oOhIf0I3fsp7fhjjgY1hA=
X-Received: by 2002:a92:d09:0:b0:2c3:f141:848b with SMTP id
 9-20020a920d09000000b002c3f141848bmr8295598iln.230.1646236839707; Wed, 02 Mar
 2022 08:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20220302032414.503960863@goodmis.org>
In-Reply-To: <20220302032414.503960863@goodmis.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 2 Mar 2022 11:00:27 -0500
Message-ID: <CAEXW_YSZf2a=t=OGBsop8ZmzUhoJ3uaXu4KkEt991CDP0GHq1A@mail.gmail.com>
Subject: Re: [PATCH 0/2] tracing: Add a way to have custom events in the
 tracefs directory
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 10:28 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> We would like to have in production a way to record sched wakeups and
> sched switch, and be able to save the information in a small file
> with as much available as possible. Currently the wake up and sched switch
> events are 36 and 64 bytes each (plus a 4 byte ring buffer event header).
>
> By having a custom module tap into the sched switch and waking trace points
> we can bring those events down to 16 and 14 bytes respectively.
>
> Steven Rostedt (Google) (2):
>       tracing: Allow custom events to be added to the tracefs directory
>       tracing: Add sample code for custom trace events

Great! I will test these out / review it in the coming week or so.

Thanks!

- Joel

>
> ----
>  kernel/trace/trace_events.c               |   2 +
>  samples/Kconfig                           |   8 +-
>  samples/Makefile                          |   1 +
>  samples/trace_events/Makefile             |   2 +
>  samples/trace_events/trace_custom_sched.c | 280 ++++++++++++++++++++++++++++++
>  5 files changed, 292 insertions(+), 1 deletion(-)
>  create mode 100644 samples/trace_events/trace_custom_sched.c
