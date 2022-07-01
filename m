Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCB9563812
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiGAQhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiGAQhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:37:50 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E266145528
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:37:47 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id l24so2744758ion.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2VvgvSrGaNW2aLSS6vlMLVACmGnKdbuIgIOkWE2+4Q=;
        b=eKmV+QXg5sUUl9d7gujdJDksXS5hbSPzIxPVRil+T9JESZVhy2L023EiODyXF6z692
         BfWWArjTk41/R0J/tUoPT6uoVqcop+TU6yYzjHvNXFlONg8QPxfqBpY2uVfm5skWj7oc
         dGcgTMv4Nl3cpyqmEY6CbcV4Np1RNS0mLm5Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2VvgvSrGaNW2aLSS6vlMLVACmGnKdbuIgIOkWE2+4Q=;
        b=qmBxMGHSLsDYV6ZvyPXJCGfbFKOaT/72t7paTcrp9ESB5ew3xPvDy7vJKCcF4trjwg
         OO0ys31G2MJUxa+nUsezeK8b7kITi/lKTRE+1T8bA8VWYdGd4L8+I2sU/HTuFz9E6Dt1
         IEz+nA+0QZGfPCz40ust9XGYT7SpLdjFkYkEdIjKXWZyDlYJqkyZ1joU6osbDBMDCaOE
         EoWNPU7aIP84ZWV/8eOLG+RKjlszOnzhA82XhdXvk6DKWRP2MdoIzvu/QNgLdqCeXLTK
         6T9PUZo1H1IPv3amYdBmw5Vl5TeHnsrc3PeBFk6pLtk1bJ9XGbtx1KaUUzekDz5rQ9Sk
         pisQ==
X-Gm-Message-State: AJIora85o2DuZHjB7MsbYnE+51d39txqGrM7FnoUpz7UjlxQoB8okNW5
        m+EutSSMvUJkQ/QbNTtn7bdTaVCcBC+P3clfZxrijA==
X-Google-Smtp-Source: AGRyM1sUdMan6Jb5o9qiPca4fCfB7FQNWSfbHa6tfdT9xA4tpeEmjWI7vt8gCllPyVdAMQklcVtadGpKbIDbvf9q8BA=
X-Received: by 2002:a6b:7845:0:b0:64c:9acc:9f1a with SMTP id
 h5-20020a6b7845000000b0064c9acc9f1amr8157314iop.103.1656693467283; Fri, 01
 Jul 2022 09:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599072725.git.nachukannan@gmail.com> <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
 <CAL_JsqK7QRgCcD01MfVermvTGgLPj8KC412kxSQg2zsp_46fgQ@mail.gmail.com>
 <CAEXW_YTr9VaEY78S_C5iN1EH3hySZOED8F37t1A=7PNgbQK9CA@mail.gmail.com> <20220630154847.134d3d67@gandalf.local.home>
In-Reply-To: <20220630154847.134d3d67@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 1 Jul 2022 12:37:35 -0400
Message-ID: <CAEXW_YREDKcgn9jkVeFMjBqjA51HGZ=1Tp4z4oUhngJ3Wyz8MA@mail.gmail.com>
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

On Thu, Jun 30, 2022 at 3:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 10 Sep 2020 21:25:11 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > Hi Rob,
> > (Back from holidays, digging through the email pile). Reply below:
>
> What ever happen to this?
>
> Sorry, I was expecting more replies, and when there was nothing, it got
> lost in my inbox.
>
[...]
> > > From a DT standpoint, we already have a reserved persistent RAM
> > > binding too. There's already too much kernel specifics on how it is
> > > used, we don't need more of that in DT. We're not going to add another
> > > separate region (actually, you can have as many regions defined as you
> > > want. They will just all be 'ramoops' compatible).
> >
> > I agree with the sentiment here on DT. Maybe the DT can be generalized
> > to provide a ram region to which either ramoops or ramtrace can
> > attach.
>
> Right,
>
> Perhaps just remove patch 7, but still have the ramoops work move forward?

This was an internship project submission which stalled after the
internship ended, I imagine Nachammai has moved on to doing other
things since.

I am curious how this came on your radar after 2 years, did someone
tell you to prioritize improving performance of ftrace on pstore? I
could probably make time to work on it more if someone has a usecase
for this or something.

Thanks,

 - Joel
