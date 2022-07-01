Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAE2563853
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiGAQxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiGAQx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:53:29 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1567A201A1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:53:29 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id f15so1755612ilj.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QngqAYcbWPMAXzcn6/8W37ypoeckvQxEy3Q6vkXecHw=;
        b=jdIjxOhpw+LIx5vfLjG3VPobTFo8QQTOoKN9/UQE75Wng/IBjf27HkczvfvQM6nDSN
         jE7oXP2EJlomxZOrcOuQYKB3YORkb5xWDXB2aM3jM1APdooh9R49cfTNtHCKPRRIzRf4
         23KWrVqejgb6cwj8upMHQK5bz50XseCUSmGWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QngqAYcbWPMAXzcn6/8W37ypoeckvQxEy3Q6vkXecHw=;
        b=sFpfCGq2D5RZBTBcnm33k7jPd2bINfAKL+7mVFxydqgJwPiWEV1HVdWATMNkB6kEnq
         FDiThRVgrhFCQcsGIzQ6Ni9OXMfXjREix6thlVdq64dkq2NKKD4MC1hCeoS4FCrkK4/A
         hZ0sklI+eMGaxgtqeX6fq5ZuTpL6wjdHrQ8PLf01RQOiRsu0TOU9qMH63OJxLDcRaq2m
         DiP7i+quSegtpE6/ddDwGueOjA/zQcafUh4Srz40mJVkhC2Sq6gcHfGvo9i740WQbmpk
         wtUmFJUbYL8MQsCcHQ371zQHwyZmVpSNkdfxC9AC0SwxBfkL8eNaAgBvoz7y6360MJEf
         Hy0A==
X-Gm-Message-State: AJIora8eDkKQqcisQsiW+PmdDjnlmNTOdJl/CHJgrMsjAADWdQqpbYc3
        IuvHUjLmRn8sLTgEyxoTBAra3d0VBbY2ZZwACa2nsQ==
X-Google-Smtp-Source: AGRyM1tjbeENrzV4XMJtrMIovbztZoW3TqQAiTlnP9G+8wZDhuhdZgA7dGBlROuCLqlyG/xeJOBc6jvcLkHk4bGD3Og=
X-Received: by 2002:a92:603:0:b0:2d8:d6e0:1363 with SMTP id
 x3-20020a920603000000b002d8d6e01363mr9263138ilg.307.1656694408469; Fri, 01
 Jul 2022 09:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599072725.git.nachukannan@gmail.com> <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
 <CAL_JsqK7QRgCcD01MfVermvTGgLPj8KC412kxSQg2zsp_46fgQ@mail.gmail.com>
 <CAEXW_YTr9VaEY78S_C5iN1EH3hySZOED8F37t1A=7PNgbQK9CA@mail.gmail.com>
 <20220630154847.134d3d67@gandalf.local.home> <CAEXW_YREDKcgn9jkVeFMjBqjA51HGZ=1Tp4z4oUhngJ3Wyz8MA@mail.gmail.com>
 <20220701124628.36009f4a@gandalf.local.home>
In-Reply-To: <20220701124628.36009f4a@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 1 Jul 2022 12:53:17 -0400
Message-ID: <CAEXW_YQk44VdSrZFtpfyCPHcrDxEFaEe2Wu900CZcWWodw3+xg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Trace events to pstore
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nachammai Karuppiah <nachukannan@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Brian Norris <computersforpeace@gmail.com>
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

On Fri, Jul 1, 2022 at 12:46 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 1 Jul 2022 12:37:35 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > I am curious how this came on your radar after 2 years, did someone
> > tell you to prioritize improving performance of ftrace on pstore? I
> > could probably make time to work on it more if someone has a usecase
> > for this or something.
>
> I'm looking into ways to extract the ftrace ring buffer from crashes, and
> it was brought up that pstore was used before.

Interesting. In the case of pstore, you know exactly where the pages
are for ftrace. How would you know that for the buddy system where
pages are in the wild wild west? I guess you would need to track where
ftrace pages where allocated, within the crash dump/report.

 - Joel
