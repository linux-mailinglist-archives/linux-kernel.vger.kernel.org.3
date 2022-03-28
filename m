Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9D4E8B76
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiC1BLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiC1BLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:11:35 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0514EF5B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:09:54 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id d65so6809716qke.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HLwATRdL3qnh4+RFHCS+QeiuVSG5OuceytzfKR6YaL4=;
        b=RyRHoJSJGVsHOt6dPdLU6Oe6diDyZqCMpl1cLmvuqaqWPicsOsn0c1UQtkvcn+G17t
         +Izwt8diODSqtmMia14yFOTeqUpnceRD6N3YriqppilI0Lr7fbq2f2z2hhd9nwxD8py2
         5tYXSJgzwm+IrpRflu5PLkeXFCofX9BPeUshTVovG2uOnylsiD0oksa7wC2ghl+mfX42
         MJExzYKlGj8p4xKQ0aVOqVqMpSXeIBoW0GiYcVXVgwbBJCOzYv7zhFbjv/tjkNIlwXnf
         tOs6Pozvzenk4uK8ZkxcPfqPdM2tRyAo7OdgnY0LXg1b0ebht2cR2uIw3smUchbx0Ssw
         lGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HLwATRdL3qnh4+RFHCS+QeiuVSG5OuceytzfKR6YaL4=;
        b=Q+ZhfaW7USKJg/sXDI6T6tUKQ9p5vctp+WJO4FOgWpzbAxhZZ+oItbxtU0Ud8c2PQ7
         J56s0jiVVdgaeVQNXsRolS/jr1zCUUpPbjy1zMjy7Njir2dNY6mhKUk+tXejGNZIjXjv
         v3s3DmnK/rv7slS7MggseLkmRYoEgvHnFXLF/yvXf4qcmEmT1zwxlOC1m1qpOJ6fJlJQ
         Zcj5MNIAjw5BdpTHbSjq0owDxffHHNiA8UOZt3JJzZYhIl1JMzevVo5+F9Kda9DbNQaH
         WuyOQ6Pr7PHAvrX8rJ7FZ+NNIe6z5YyEZ2HTn86pDXtXRP9StBTuKqOhpy7mc54qlN6H
         bZAQ==
X-Gm-Message-State: AOAM530hbE2v+/I2YpcPuvzd96LOvUZ29EQ1dXLU4C7BpZA3Xu/5GVFg
        SLdwER6E0TbliTDkDFMaQ1lSbT4xo4k=
X-Google-Smtp-Source: ABdhPJzQSDsaCAQzmrfmVaVU2TdkyDM0WkQvF88/7o7wMdLNqH8knAJrZg1mgWJFyhKid21NK3VW3A==
X-Received: by 2002:a37:9d7:0:b0:67e:85d2:2417 with SMTP id 206-20020a3709d7000000b0067e85d22417mr14223843qkj.753.1648429793920;
        Sun, 27 Mar 2022 18:09:53 -0700 (PDT)
Received: from localhost ([98.242.64.6])
        by smtp.gmail.com with ESMTPSA id az17-20020a05620a171100b00680af0db559sm5629479qkb.127.2022.03.27.18.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 18:09:53 -0700 (PDT)
Date:   Sun, 27 Mar 2022 18:09:51 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Pull request for bitmap branch
Message-ID: <YkEK37hEhUcl5NUU@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Can you please pull this branch for linux-next?
https://github.com/norov/linux/tree/bitmap

Thanks,
Yury
