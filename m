Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F045A689C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiH3QpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiH3Qo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:44:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6065509B;
        Tue, 30 Aug 2022 09:44:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m1so15001674edb.7;
        Tue, 30 Aug 2022 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=0shWUBObk0nNllny9lFlemOiZpmqVqe51l06iA8hC6s=;
        b=WnCAbA9lsTb+Wrop+gApYrfPA8MXFJvULCEtuskgj0KmnkwrKQ5bU8pzyrKFkBhSJa
         X2i/ltWUK+/BHIX0ZzjbTn1yNcRjtXxu29Bljz7+k66MUzMSTbusx+Jg6NNjMl1U7jld
         uXfyIuIqZIygY0IBGikI95gor3FYaH5+ZYibDHGZSblDJ9tpgnMBvG/ElE7Pff+RQBaK
         wTRbRjKzGvt1I6R39ZvahmTeFP19j+UniLUAHoTxEj+JhRYfjcWpjbcXQA3aA/gaUcXE
         TUgQlWcNyX5nt0QS8DUSoKDreOvX4vJQpJy1SiHkfQ5nKDaJnntW4Ha2ngg70EgSqJxB
         OWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=0shWUBObk0nNllny9lFlemOiZpmqVqe51l06iA8hC6s=;
        b=CaTSy6G3MA1J111SXCWtuqSJVWXXqRXH4lijCwBPAcDbMEDoXZa6wvVT9hF8+kPuMR
         Qc0STEPc3nRjcps2Z3oLWs0SdiqWRjCYJFDaZyYZH7y+cz8qHeW2AazC1PmHmRrVCC5V
         d5VUJoFEnoBSvHVn5OKLZeK7v/G7EXcSOpROweQ9D5HG1T89pFDmGSNgvm+HjIj33tWI
         DQEvgz4VQSKiBECy+dRWtO+UNZwwiLV0a+KjF5ONGXUibetR/AYpvY7xLoIIGsRA+mX4
         ftXYcsqFM0xQbvyqNIs2JfXPRe96OxVwFOn8jiqtT4Q6JrKMvetGKITW8vmbhhgUkyMz
         9Agg==
X-Gm-Message-State: ACgBeo3XDXdZlQyLiZJsbPL5Etj0pwqKhCrGF1YMP5qBVlbEa09HI0Uw
        XUcpSYPodG3fMnAwqHFBebQ=
X-Google-Smtp-Source: AA6agR5nzUP5jouc1qUgHWfQ7r8T4odDLBqpoWSPg7TLYIwnFXl7w868wn9uwM68MkWFZ15o+QkbyQ==
X-Received: by 2002:a05:6402:f21:b0:446:19c5:59ea with SMTP id i33-20020a0564020f2100b0044619c559eamr21403767eda.371.1661877894604;
        Tue, 30 Aug 2022 09:44:54 -0700 (PDT)
Received: from pc636 (host-90-235-23-118.mobileonline.telia.com. [90.235.23.118])
        by smtp.gmail.com with ESMTPSA id gh4-20020a170906e08400b00734bfab4d64sm6097971ejb.25.2022.08.30.09.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:44:54 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 30 Aug 2022 18:44:51 +0200
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <Yw4+g/0yEf7fpHrh@pc636>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen>
 <20220830162244.GA73392@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830162244.GA73392@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Frederic.

> 
> Although who knows, may be some periodic file operation while idle are specific
> to Android. I'll try to trace lazy callbacks while idle and the number of grace
> periods associated.
> 
> 
Everything related to lazy call-backs is about not waking "nocb"
kthreads in order to offload one or i should say few callbacks
because it is more or less useless. Currently if incoming callback
is the only one, it will kick a GP whereas a GP will kick nocb_kthread
to offload.

In "light" loaded test cases, especially where a power drain is a key
thing, such light load may lead to some kind of "noise" produced by the
RCU core, i.e. kicking idle CPUs, thus wasting power. On our ARM devices
it is not painful, but there is a small power gain and it is visible.
For other systems, like Joel measures for Intel SoC it is more visible,
because of a power cost getting in/out of isle states.

This is what i see on my setup.

--
Uladzislau Rezki
