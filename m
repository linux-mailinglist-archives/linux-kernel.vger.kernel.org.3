Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9C14E9A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbiC1O77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbiC1O75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:59:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231DBF0D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:58:16 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648479494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Gn1QwT0EvYD779jh6Nvet+oIgA0sr1ySIt5fRK2NZ8=;
        b=WhRxEk9MVnSLWphxKh7/JMP/lBPIh9cPWbFkqo/wmHEp9T1Uz70psONPhUhEsf9RyswsKL
        mvxqD2lkNBtwaO5E2dq5pold6b29XlaAR98Psbw8Vvbk+QSFq7KG6m2kGY2/kNB6WXa0QG
        si4bWqkvEOHhJTuUGw+6I/N730hyKSqZX+GOS9TOivdVi9WJHXvklQtZ7C2NgRauaX/xDR
        wMRhqukQYlA5DITCy7BPD6GFvdiUg8LZeO0b1zcDfWXfmTMPYlR46Ch6f2ek5mOE7H4W3k
        N/1sjIOleN0mEPQ0JP+a7lZLIx4VXFQcsy0avusRuF10VxxDhxiC2prFVABRjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648479494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Gn1QwT0EvYD779jh6Nvet+oIgA0sr1ySIt5fRK2NZ8=;
        b=zVlW2MbCS8cT5rIhOBy661wre7NRIuiGLxErpNd3QaYw4nT2ou8tRRoBZhYQOq3FbJcNJV
        0EkVshxdkgENh2BQ==
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        boqun.feng@gmail.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH v2 0/3] Remove volatile from arch_raw_cpu_ptr() and revert the hacks.
Date:   Mon, 28 Mar 2022 16:58:07 +0200
Message-Id: <20220328145810.86783-1-bigeasy@linutronix.de>
In-Reply-To: <CAHk-=wgcM9vUjGTdoCbX4DuBM+53FFmHFqYZdF8mNzATwj8z0A@mail.gmail.com>
References: <CAHk-=wgcM9vUjGTdoCbX4DuBM+53FFmHFqYZdF8mNzATwj8z0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove volatile from arch_raw_cpu_ptr() and revert the hacks.

v1=E2=80=A6v2: Updated the comments in 1/3

Sebastian


