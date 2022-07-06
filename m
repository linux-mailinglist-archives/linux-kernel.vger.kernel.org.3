Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19702569108
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiGFRs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiGFRs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:48:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25C16423;
        Wed,  6 Jul 2022 10:48:25 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s14so19406173ljs.3;
        Wed, 06 Jul 2022 10:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Tdf7ASxlbaDXe3UntpbJmcyMVIZx89GElFlVDq70G1E=;
        b=av5EmNC6KScDiSo3yZRxHh1JjVtGq58I72zcmjOS/GbgnhP9d8NL1M67W6AdDXWLBO
         smYrB5PVGshhhGcB3EOvl0VKQhQYBBZv45doGDeTc8aiualcqa94FJFkRbbZooofaXAR
         bXGL5bjfGNorBvl4Q/qYWvyzPb6qAA2SDjlNyda8uXSK9XxPxrO58pcJ14Td10bg1KFW
         EyHDqu5L8ZKn1kKjOWPdFbdL7k8qhfZbOZPv9OzdKlPYVeO2Q3u7kUhwgFhnQbQx+eVg
         9c74CIJZQE0C/YfHhRoBDFamJEMO/uldYuzvtYJC25qCRRqrPPcME4kMgAOeMfhB8wyR
         ZbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Tdf7ASxlbaDXe3UntpbJmcyMVIZx89GElFlVDq70G1E=;
        b=1n4k+URhVRTbPm3KEzfGe1BnIj9tx/9yWGD+D51847r9HonJlIdxK359Iw3l6JQ+Od
         e79zGd4DlNcmAq6Eq9RbRkr8BilA+IGVnOu7ZCygj/8ICVBk3ZdzVQxCT8uQcFEfJpCB
         MiM73k9KN82pW4OlWBPLm8LwdfpYsyaGAiCjTvwn3w4nAF4dT3x17Tb+TWXHPc3G2JXf
         +MymdRjY9LRZ4/llJAIeummsods+yx5GNTm/sytp0EjJYbqqsS6UpD6JNz7dueTtYBn1
         B64sQOCRnVerZ9XEXBWkqs5aLsoEr/ESEPdPcWvXYrzf+aB/X50E4FGa1A7kFhXBDuGU
         a6GA==
X-Gm-Message-State: AJIora/el513DMMRdlueaZmbUohmZaasu4u7pGIAY4HQvC87+/GcWaEW
        BFF+hf3goM/Mzzq1Sm/zQ50=
X-Google-Smtp-Source: AGRyM1u1HT+sFi2wLf7fp4YNZfwAKQU6WlrA9bLDUjbi9zIEm3uBpG7mqsv2U+35d/fU8R3i17yQvA==
X-Received: by 2002:a2e:9808:0:b0:25a:a30c:e5cb with SMTP id a8-20020a2e9808000000b0025aa30ce5cbmr24645544ljj.312.1657129703858;
        Wed, 06 Jul 2022 10:48:23 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c2-20020ac25f62000000b00478f3fe716asm6387536lfc.200.2022.07.06.10.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:48:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 6 Jul 2022 19:48:20 +0200
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        wireguard@lists.zx2c4.com, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Suren Baghdasaryan <surenb@google.com>, rcu@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Theodore Ts'o <tytso@mit.edu>, alexander.deucher@amd.com,
        Todd Kjos <tkjos@android.com>, uladzislau.rezki@sony.com,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: CONFIG_ANDROID (was: rcu_sched detected expedited stalls in
 amdgpu after suspend)
Message-ID: <YsXK5A0MiVgHd8Je@pc638.lan>
References: <1656357116.rhe0mufk6a.none.ref@localhost>
 <1656357116.rhe0mufk6a.none@localhost>
 <20220627204139.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656379893.q9yb069erk.none@localhost>
 <20220628041252.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656421946.ic03168yc3.none@localhost>
 <20220628185437.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656443915.mdjoauhqe0.none@localhost>
 <YrtgeSmwLmpzN/zw@pc638>
 <79c6ad70-47d9-47fe-4bb4-33fcf356dd37@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79c6ad70-47d9-47fe-4bb4-33fcf356dd37@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Mon, Jul 04, 2022 at 01:30:50PM +0200, Christian König wrote:
> Hi guys,
> 
> Am 28.06.22 um 22:11 schrieb Uladzislau Rezki:
> > > Excerpts from Paul E. McKenney's message of June 28, 2022 2:54 pm:
> > > > All you need to do to get the previous behavior is to add something like
> > > > this to your defconfig file:
> > > > 
> > > > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=21000
> > > > 
> > > > Any reason why this will not work for you?
> 
> sorry for jumping in so later, I was on vacation for a week.
> 
> Well when any RCU period is longer than 20ms and amdgpu in the backtrace my
> educated guess is that we messed up some timeout waiting for the hw.
> 
> We usually do wait a few us, but it can be that somebody is waiting for ms
> instead.
> 
> So there are some todos here as far as I can see and It would be helpful to
> get a cleaner backtrace if possible.
> 
Actually CONFIG_ANDROID looks like is going to be removed, so the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
will not have any dependencies on the CONFIG_ANDROID anymore:

https://lkml.org/lkml/2022/6/29/756

--
Uladzislau Rezki

