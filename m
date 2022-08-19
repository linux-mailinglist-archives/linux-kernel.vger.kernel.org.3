Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3154659A58B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350055AbiHSSRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349783AbiHSSRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:17:45 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FF2B4B6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 11:17:44 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 10so3906239iou.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0N+aGlpvF5n2BpgF0PUXQA/veXWFFa+QNzcAxMqjXwY=;
        b=Bfi1w1xU6UkNJragDtxZi5Zg/Lw+a7nqgU6c598ghTQUesRRoZxA5lXbi0AL380OlK
         a/Ckw/Z86Y82FXXOyduEcphMLQjXNWaqULg05UUm0LLjdNRo//VF3S+2omqQBUPEc2iG
         IKAy2RJ9lbBcVAxxfQhQw7d2elim+10uw740E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0N+aGlpvF5n2BpgF0PUXQA/veXWFFa+QNzcAxMqjXwY=;
        b=Nb5u0e5YjzRS03ht/pUWG7E40NwceNAZzLbBPVM7+rfIYB7G0dHDffRNQrzqhJMQhr
         Puk/uvhYc0Rx3O8oPDC+3SRxl/UGpDVTNiVCqbGKBNYlwBT/y5TdPSLoAzf4ARNkm2/F
         Cc+9IlhTZqj/IDOC8aR3h64q6goJ2EDrtkqceCjqullz12pZV/1+3f8Ufvv95kr858JR
         F5U6Qy+Aprb9Pw/FvsNEH6xNXWrgUtRcULTi3w2u4Zq75SCl5/Q3uESN3pNu49R0rIDo
         2JyJtM3qULsCAzH0vx5SdLiu76NbbTNkZJto+S8XqFpPu9lcmP90C2feza+iA8S+ZvKq
         NILQ==
X-Gm-Message-State: ACgBeo36/Mb8DYzchrPgtgLMU+ktSWKzA/ynwR+6IV6PI6q9wTTiE/qz
        QnAStkXyBheJs7jNz3J1E3OcbpJLD3RyNoC8BJM+FVp3SsU=
X-Google-Smtp-Source: AA6agR6Nn5dT2qqMts4wTltvlhnHOo8EQ1ViTBNvWlPoB1Xcuqhzr01b82bdA7VmWpDZmKiRy/HAk+JJACwdOCVReA8=
X-Received: by 2002:a05:6638:4982:b0:342:39e0:1d44 with SMTP id
 cv2-20020a056638498200b0034239e01d44mr3908539jab.213.1660933063633; Fri, 19
 Aug 2022 11:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <20220809034517.3867176-5-joel@joelfernandes.org> <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
 <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com>
 <CAEXW_YT3VnK5KJTbyXdCzs8j4jw9XFTSCF4Dt9QwLPtkPSb1tA@mail.gmail.com>
 <20220819023550.GN2125313@paulmck-ThinkPad-P17-Gen-1> <4deb7354-bac7-b530-47ba-54cf50cfce58@joelfernandes.org>
 <2d56e4ad-7d6e-2abb-461f-15f20128d42b@joelfernandes.org> <20220819171249.GP2125313@paulmck-ThinkPad-P17-Gen-1>
 <fa8b7857-b9fd-72ad-36a7-8b09e4472816@joelfernandes.org>
In-Reply-To: <fa8b7857-b9fd-72ad-36a7-8b09e4472816@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 19 Aug 2022 14:17:32 -0400
Message-ID: <CAEXW_YTxtfbbQ_rOiSbu62GpDPBDFpfWrNBef06MAkYPybNJ2A@mail.gmail.com>
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
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

On Fri, Aug 19, 2022 at 2:14 PM Joel Fernandes <joel@joelfernandes.org> wrote:
[..]
> >> Things are much better with the following change. However, this brings
> >> me to a question about lock-contention based or any deferring and boot time.
> >>
> >> If you have a path like selinux doing a synchronize_rcu(), shouldn't we
> >> skip the jiffie waiting for the bypass timer? Otherwise things
> >> synchronously waiting will slow down more than usual. Maybe bypassing
> >> should not be done for any case until boot up is done. I'm curious to
> >> see if that improves boot time.
> >
> > Why not simply disable laziness at boot time and enable it only after
> > booting is complete?  The exiting rcupdate.rcu_normal_after_boot kernel
> > boot parameter uses a similar scheme.
>
> That sounds like the right thing to good, but unfortunately it wont help
> this problem. The boot time issue happens after init has started. So the
> OS is still "booting" even though the kernel has.
>
> Also the problem can happen after boot as well, like if RCU
> lazy/non-lazy callbacks come back to back quickly, or so.
>
> But yes nonetheless, I can see the value of disabling it till the
> in-kernel boot completets.

My mail client is acting weird. I meant to add to this, I wonder if
there is a way other subsystems detect when userspace boots using some
heuristic?

Thanks,

 -  Joel
