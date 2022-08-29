Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074C25A55C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiH2Usn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiH2Usj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:48:39 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1262F9A6B1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:48:39 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z72so7610826iof.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cHgb8is1s1/IIdUooiK63RBMdZzZXw58VVRpVaSHSIU=;
        b=wCqx693sslE2Savk58+n/qDHWX1TwwcS2+j3NFpcEfuSG+6DcMH5q7RP39tS1bx/VG
         9RI6VRuHaPfJZQuMCEj89hKiCgBkDEg4woLdZgEOqNloT9Yzn4SmYjKCmtAk9Ed2q/7N
         CPmTfynuiBHSaDEL6BtHEUjSYcTX1GcB5vuFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cHgb8is1s1/IIdUooiK63RBMdZzZXw58VVRpVaSHSIU=;
        b=dqsBzbfinTMXnSsTbcLYmayf7c+8HD0ZcJwI2uXrVJ+CLoBrE2/bf71K52nogtJquM
         Z/CBzEEY5SZ08dkKqcuXne8+ULjS0EZBWxfvoNwQ1Q6IkymQth6BGlldfACO5y469ezs
         fNp38UDlzt8cfRgvKJu6tvrIdRuONzr87O2brHhEHTt4yWQI0wD6xMi4Uo0BR0KHJjrt
         i4Fx82qsVqcBCuHOIwnc8g/xy9iQdUuLi+6TCfg/P1y6imdbT6wpcFpfF9/PUB7WXErv
         jXhEAGWiVXe2wAPmZ5IEozFHMwQxLK/0KxB/BknzX3CGd9CGxQSbCvxQgbYybUIpFcgC
         NLbA==
X-Gm-Message-State: ACgBeo2bB6ejO160acjKxPKXMNfuNzKS1DbH64eFwKzKcdKbhndhrFQu
        8zHL+aQUCECvyr/oDKW6sZOO/lor0pLjwAM2BHl5UxKJ57R79w==
X-Google-Smtp-Source: AA6agR7O/puL5L5YaRhK8BLONsdd+lAAqiJ1hNdUqhBbc6rhB+OrPdzdM7Tug6JV0zkZFDFG34gQBz5APaMWZkAJ9Ek=
X-Received: by 2002:a05:6638:160b:b0:346:ab00:9c7c with SMTP id
 x11-20020a056638160b00b00346ab009c7cmr10657775jas.241.1661806118443; Mon, 29
 Aug 2022 13:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen> <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen> <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 29 Aug 2022 16:48:25 -0400
Message-ID: <CAEXW_YSwkSi0UfBUrK=4gyMPC-R7pvQbreWOC3DcQqmLgp3aFQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous fixes
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 4:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Aug 29, 2022 at 04:36:40PM -0400, Joel Fernandes wrote:
> > On Mon, Aug 29, 2022 at 3:46 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > On Mon, Aug 29, 2022 at 12:45:40PM -0400, Joel Fernandes wrote:
> > > > On 8/29/2022 9:40 AM, Frederic Weisbecker wrote:
>
> [ . .  . ]
>
> > > > > 2) NOCB implies performance issues.
> > > >
> > > > Which kinds of? There is slightly worse boot times, but I'm guessing that's do
> > > > with the extra scheduling overhead of the extra threads which is usually not a
> > > > problem except that RCU is used in the critical path of boot up (on ChromeOS).
> > >
> > > I never measured it myself but executing callbacks on another CPUs, with
> > > context switches and locking can only involve significant performance issues if callbacks
> > > are frequent. So it's a tradeoff between power and performance.
> >
> > In my testing of benchmarks on real systems with 8-16 CPUs, the
> > performance hit is down in the noise. It is possible though that maybe
> > one can write a non-realistic synthetic test to force the performance
> > issues, but I've not seen it in the real world. Maybe on
> > networking-heavy servers with lots of cores, you'll see it but their
> > batteries if any would be pretty big :-).
>
> To Frederic's point, if you have enough servers, even a 1% decrease in
> power consumption is a very big deal.  ;-)

Ah I see Frederick's point now, so basically the claim is that using
lazy-RCU on servers might make sense to save power because
CONFIG_RCU_NO_CB_CPU may not be an option there (networking throughput
and so forth).

That's a good point indeed...

As you said, let us see v5 and how we want to proceed from there (as
it is not too far from posting) . I do appreciate Frederick's review
and valid concerns.

Thanks,

- Joel
