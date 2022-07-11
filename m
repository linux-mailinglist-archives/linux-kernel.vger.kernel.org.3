Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC255709C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiGKSOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGKSOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:14:15 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0F4DE96;
        Mon, 11 Jul 2022 11:14:15 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 136so10059233ybl.5;
        Mon, 11 Jul 2022 11:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSE6Rh7NY69yyV0HNEoeIzk/x23R3XqEd+aAFDoyzfs=;
        b=e7Y6RlP5Uq1l+KwZBD6NPVouRaHbbLlPnMwsJ7ET+8OQmruK37HMTtxYq93Ty4wePd
         t/DkP8GobjxwGJ25I6WmCU2JgrM6Xzasp/I7OJpAEIBkAejFsLobtsV4eXBM5dmpZ0p5
         tLVvmdTHQOym00+L9XXjmawSL04LS18o+ZdAhaFu4AIkd2mtUytHsifJJydik5ViJs8y
         YrAMX9SQ2gwDpF3Wy4WxfttG+WrgMZNZGXXAyq4eDj8ZEivWZAvSOteo54D53U8XaFxM
         dfCAOzHtuIZ+7CbyhaqOK3FVhHybNT4WX+axyAYQ3UfRJjIvspuxPpMeDKTtT0Oswb6m
         47uw==
X-Gm-Message-State: AJIora/X0ktzbAvN/WDsF1SkJ/M9OewOAccWoheCBEFfA5j79dq+BZGO
        ylryShzuQRu1hSAM0CDUYQluk3knbYM4bO0y5qk=
X-Google-Smtp-Source: AGRyM1tK3zv2r6Gc27U2VFdxVpar/3lHXCtSY3cI6oDJV8EmnDJdAaAULbDnlXxtooPJjAEiig9O3iDQlMkPBqtiegE=
X-Received: by 2002:a25:a2ca:0:b0:66e:719e:279 with SMTP id
 c10-20020a25a2ca000000b0066e719e0279mr17594626ybn.622.1657563254492; Mon, 11
 Jul 2022 11:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <03096156-3478-db03-c015-28643479116c@I-love.SAKURA.ne.jp>
 <48d01ce7-e028-c103-ea7f-5a4ea4c8930b@I-love.SAKURA.ne.jp>
 <2646e8a3-cc9f-c2c5-e4d6-c86de6e1b739@I-love.SAKURA.ne.jp>
 <YsvbgxJ80kMP5juv@kroah.com> <601436f2-b13e-6c24-bcfd-29548e288f23@I-love.SAKURA.ne.jp>
In-Reply-To: <601436f2-b13e-6c24-bcfd-29548e288f23@I-love.SAKURA.ne.jp>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Jul 2022 20:14:03 +0200
Message-ID: <CAJZ5v0g9v35m9vaSeBC19axqRuNqG7qp+AGPn8wRb3Gzn+H9CA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PM: hibernate: allow wait_for_device_probe() to
 timeout when resuming from hibernation
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Len Brown <len.brown@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 1:21 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2022/07/11 17:12, Greg KH wrote:
> >                                                        creating a
> > locking loop like this should be resolved first,
>
> Rafael and Arjan, can we agree with removing wait_for_device_probe() from snapshot_open() ?

No, we can't.
