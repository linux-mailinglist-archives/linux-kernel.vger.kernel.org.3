Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EC4521D73
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345622AbiEJPIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345388AbiEJPIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:08:11 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71421333A0C;
        Tue, 10 May 2022 07:35:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m23so21087794ljb.8;
        Tue, 10 May 2022 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oUxNnzxeWS42GKKHFrqdYfWBClbSmeNzMOcA2uOdYns=;
        b=or7L+YkFy0jn81BAj3NsTsqLmC7tBycQnmVbSrU9snb3UD68EQG6NKsxs3vU8FKCqa
         ywQBLa1pZCqNjbNnO2qKjnc3aNjokGX0c8DLzGLe3HkSiMrX2K/SSd8bgcgQDbJEXajb
         CtoZXzu+zKVM1j4+ZBzstV0zR1SP49ztnad6T+AP+UMVOFfkG2v8oz7Td1TMqvts2fEt
         3x9XvXpFL/M89hGECik9dEpKb6LfXEtx1tMz2URZlnruE8TxQZRYmonvrtSj2eAVCFX5
         cIsLl3oaZoYmqQuDXbhAZBWnZJ8bO0B3TfcC4mO7Oy7eiPgsyUFdlYgvJGMimGkrRMXR
         B5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oUxNnzxeWS42GKKHFrqdYfWBClbSmeNzMOcA2uOdYns=;
        b=j9z1VFHavAJd3sMJ396n4CpQ6je/CC0JTaL6/7EMzal/8+LZcBRsUXGpCUczVG9V1+
         b6/TR6rGTkxOUEOzE5ZL3jAzwwxXjj0UAVyxXdmiLAVw9idrALK7E6AV+hY+t5wqqrZs
         uwYPSsYKCDnTJ99gemswZ6AuiesjiU3hhFvlzw+ilfas0QDubzPXbnWuaoQZvP2IdDBo
         /MCReLWw1+JZ+pD40zdUdFB3Z1/C6QcPUfvcISl5hKkq74HYII3TESIbv0EkZozdwOj6
         AEscu3G3QwJS/Cmal9e7Epj6AV5a/fd1b2nV9YKRQJQCF3Y8tUumG7Q+HNHxR+xVGAze
         UMyw==
X-Gm-Message-State: AOAM533tZ9Vvd0Oz3lcbNNv0HndLLISVykgAQeBaDt5x+EFsG0dzq4wO
        44k+GFfCTTa9+wweQZ+4EoI=
X-Google-Smtp-Source: ABdhPJyahnJbmaPkCTl51TlHaGj8SgPFVhNw5Uppycx3cChCnwy+YzI6FIrEQtDT+vWc+gh3KOKh+A==
X-Received: by 2002:a2e:9b57:0:b0:24f:12ea:fd26 with SMTP id o23-20020a2e9b57000000b0024f12eafd26mr13705191ljj.352.1652193316653;
        Tue, 10 May 2022 07:35:16 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id m1-20020a2ea881000000b0024f3d1daef1sm2161360ljq.121.2022.05.10.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 07:35:15 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 10 May 2022 16:35:13 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alison Chaiken <achaiken@aurora.tech>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <Ynp4Ifd5q2RLFyxt@pc638.lan>
References: <20220507223247.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com>
 <20220508213222.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ9t8gxp9cKCpba+e4NZ6ohPr8jHxJYuqRBFRtvSDa0Lw@mail.gmail.com>
 <20220509033740.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSbWetMt2_-m4G9Nt5S8ybATihB+5FMJMMo3jKDG4pPjg@mail.gmail.com>
 <20220509181417.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnldSkaWu40cVimj@pc638.lan>
 <20220509183934.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220510100946.5fdff700@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510100946.5fdff700@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 10:09:46AM -0400, Steven Rostedt wrote:
> On Mon, 9 May 2022 11:39:34 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > This allows your current RCU_NOCB_CPU_CB_BOOST with something like
> > this in place of the "default n":
> > 
> > 	default y if PREEMPT_RT
> > 	default n if !PREEMPT_RT
> 
> BTW, I don't think you need the !PREEMPT_RT, because all configs are
> 'n' by  default. That is:
> 
> 	default y if PREEMPT_RT
> 
> should be good enough.
> 
Thank you! This is what i have in the next v2 :)

--
Uladzislau Rezki
