Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F397E570EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiGLA3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGLA31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:29:27 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB771D0D1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:29:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 72so6207198pge.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=9GFp9h11aOkbojWfJpga+bds+Y2urkX7Qh7rwq4YdJ8=;
        b=AvYoV9N/BrwgpVrmMKqQu4TgFuA8otd1znqn/8TtezU0dUFWFlcqv0EvFHsd7UuYW5
         ZXOLYYEoBNi2y8+vIubPs7H5h7fHyUiiP2B9fV4E7SzGz11PS/3q8B+AbjwiAefGZf3+
         VUxNMd/E8+mNMlqcmeAh+GNLRFnYf5He7aRPkPQmnjV1+BuKOVz9YXYOsVhWmLjSpY0M
         2hJ8twcB4s/ZtEKT1WVCog5S5Weu2nEaEMSaDKN8SQk+VGBXYt7zSYCP2g+/qkpdMKep
         yQITdgNhpT3yXxeUTa8S5B7XOQIgXYUWIbJuNSWVZscR0BTKzidzj2EF4naPVM/gOMlD
         qKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=9GFp9h11aOkbojWfJpga+bds+Y2urkX7Qh7rwq4YdJ8=;
        b=DK7R+AKO6gMBnl+JZRFhdQ6NdKLVDOO/OudgaPrgLnD4M7Q+75QCiY2b8Ohhyb3UX3
         UkHknFKFB1fCr6Vj2VPhuPKxToM+J9TCQ9DoxLkdiKkR4gZiS1j3I2Pwk1D6hh5NuYvp
         6HX8fxtT/BirfXngfy/nFOqCHs8/rBCI3chp6yDI1csRgspbkiMp45pXH6rm5LRZDQut
         QVfk432mfPEIT2VcSHgls5knCidTmDG8emgPsAp7fD8V544K9W5zpWM8BNnW5znDWecT
         iNXuRh1ONwAtgU5OLCgqIhLzcN4PC2QFutJLU+NtcygVIG5G99z0PJgh97VKlHpZswcJ
         kd+w==
X-Gm-Message-State: AJIora9TvBcOa2SbD0JBTB5iGex7CZQySgtLpiujWHcqxYs1vcHvPh5v
        MxVkTiuDMUl8mnlgqhylEy4=
X-Google-Smtp-Source: AGRyM1ukt0IDQWhVWbx87FRx/BiL+piSZQ9XZnDPA0UIwsm42drnEjTsm3jHbZPg41AcC+CCrfRP/A==
X-Received: by 2002:a63:5cd:0:b0:412:b163:b7e1 with SMTP id 196-20020a6305cd000000b00412b163b7e1mr18448789pgf.451.1657585764946;
        Mon, 11 Jul 2022 17:29:24 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id gd18-20020a17090b0fd200b001efb45d6209sm5518402pjb.20.2022.07.11.17.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:29:24 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:29:17 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 05/13] locking/qspinlock: be less clever with the
 preprocessor
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20220704143820.3071004-1-npiggin@gmail.com>
        <20220704143820.3071004-6-npiggin@gmail.com>
        <YsRwJdjJqpXEFTnO@worktop.programming.kicks-ass.net>
In-Reply-To: <YsRwJdjJqpXEFTnO@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1657585289.3ylf8n6zpa.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 6, 2022 3:08 am:
> On Tue, Jul 05, 2022 at 12:38:12AM +1000, Nicholas Piggin wrote:
>> Stop qspinlock.c including itself and avoid most of the function
>> renaming with the preprocessor.
>>=20
>> This is mostly done by having the common slowpath code take a 'bool
>> paravirt' argument and adjusting code based on that.
>=20
> What does code-gen do? Is it clever enough to constant fold the lot?
>=20
> Should we be using __always_inline to ensure the compiler doesn't decide
> against inlining because $raisin and then emitting extra condtionals?
>=20

It seems to fold it. Code is just different enough to make it hard
to follow what the asm differences are exactly but doesn't seem to
pass 'paravirt' anywhere.

Yes it does need __always_inline certainly. Only one path will ever
be used at runtime so any icache sharing decision by the compiler
would be wrong (and we don't care about image size very much).

Thanks,
Nick
