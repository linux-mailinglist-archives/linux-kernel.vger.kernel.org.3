Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0AD58604E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 20:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiGaSLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 14:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGaSLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 14:11:36 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04871A193;
        Sun, 31 Jul 2022 11:11:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f65so7832799pgc.12;
        Sun, 31 Jul 2022 11:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hqBKgf+Ek/JQSC2ln2M+FhamOJdervk7JOSiOKWTnXE=;
        b=FeKk7GPwptQofjZCsnRB6M98VcwSqFPPVXTVn5P5eIpBwkgiDjjqHkXgEV3C6Z6vFD
         4p46kuwmXz60IlNZyF8Ri6j4juO3EQeKMQf08tUD+MTBqb3zhiSidiQvi1fAJk92QbT8
         ZJncYLYWceXFFKGRLlJ/mRjBfW6zlFSgtvDmBCSoe4TmJzymjUVsBJPECPTc2g2lz+Xd
         kwhlgTXrCpxS0ScT34Ah0QUwC+ZWc0JNOlo9XG7gEfmQemEScTd9LrVeKY7QAuVeRVGC
         ks3jN72FnZtyD8pbyLlZytmx56A3lKVFbDJqSENadff5EQfW6lBElkTyYPVCQhqm9NV6
         3cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hqBKgf+Ek/JQSC2ln2M+FhamOJdervk7JOSiOKWTnXE=;
        b=XCxWLrD3t4nHRTxvPzzKGBGtuUivEIaM1uw3lrCJb82YCImAge4qfF0MBmgUUdXiYC
         zkPdMWBXYEZtSC3PDD8ZQT/g+7HkfkmahCw0FxIOFqJzlkbwcTpwGrq5V9BxCc6sGOpM
         NVd/ap7VJLe4NpEHMyj0AUtqm/rfuRX2QjWJfAgyQKCiheS2SsSyr86zWesS1azkjioc
         om7nvdhA1Ah+OoI8zntT8utQr4u8YbvnyLn2oP77ynGVaX83k+fj5FM+bAek38jP9crY
         Pjos0kXWGdDRaYQruXimPLVQaTntC40k+KPf8CBTMO0zD8f+UawRiO5CG6thYeoCtsLb
         +lgw==
X-Gm-Message-State: AJIora+u8N9nIGDoDhB9MKgETe+I5bXjBQkVMXfBL9BoQM/upkYggjfV
        UQix4/60KAqRdFoEsUUCHWc=
X-Google-Smtp-Source: AGRyM1sEvp+XYTCpwY4d2dm6Zd2VcBXo3vZHY8FWqth2u8zv48qtjSvQbAihhZJKf0JdVGKrtys2xg==
X-Received: by 2002:a63:1941:0:b0:41b:6722:b2df with SMTP id 1-20020a631941000000b0041b6722b2dfmr10392818pgz.263.1659291094444;
        Sun, 31 Jul 2022 11:11:34 -0700 (PDT)
Received: from berlinger (berlinger.seclab.cs.ucsb.edu. [128.111.49.72])
        by smtp.gmail.com with ESMTPSA id i18-20020a635852000000b0041bc393e594sm2795825pgm.6.2022.07.31.11.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 11:11:33 -0700 (PDT)
Date:   Sun, 31 Jul 2022 11:11:31 -0700
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     David Howells <dhowells@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+c70d87ac1d001f29a058 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
Message-ID: <20220731181131.GB3569921@berlinger>
References: <1822b768504.1d4e377e236061.5518350412857967240@siddh.me>
 <20220723135447.199557-1-code@siddh.me>
 <Ytv/4Tljvlt0PJ2r@kroah.com>
 <3558070.1658933200@warthog.procyon.org.uk>
 <182407602ce.190e58816827.7904364186178466266@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <182407602ce.190e58816827.7904364186178466266@siddh.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 09:50:52PM +0530, Siddh Raman Pant wrote:
> Thank you for explaining it!
> 
> I will send a v3. Should I add a Suggested-by tag mentioning you?

Sorry for jumping in.

We have reported the same bug in kernel v5.10.131 [https://lore.kernel.org/all/CANX2M5bHye2ZEEhEV6PUj1kYL2KdWYeJtgXw8KZRzwrNpLYz+A@mail.gmail.com]. We have been suggested to join this discussion so that we can have appropriate meta-information injected in this patch’s commit message to make sure that it gets backported to v5.10.y.  Therefore, we would like to be in the loop so that we can offer help in the process, if needed.

