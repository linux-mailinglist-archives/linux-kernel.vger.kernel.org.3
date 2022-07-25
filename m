Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D8580339
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiGYQ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbiGYQ6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:58:00 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F8E1DA7F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:57:56 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id c131so21119975ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embecosm.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=DriQn3oUNtY9KztAGS0KsFuBc5YfBmykMcm24BuA1yQ=;
        b=ZW+peu6caAHM2QqStdvCPisu6stK4U4IWoxtEX6sRrag8Bi+FtaUiXYwvMpPLfx+iT
         9wIQYYp4or6uCLmyXyLiaeYqBtuqM48wm34IClitS+rPWKz5zvduDxo2uxVXr1G/Ned8
         Vcxwlx4ZMLzw9M+qCJ1qnENF6WLSxT50llySPOYOXj+66tZP75fvxa3HcfUvSyKD3k/K
         MaBNKjRX8hkvsq8NbNHtg4Aj/F6sQOqEgf2jgCwh2NckJWZKVXkXMv0q2HgbTMDCBsYF
         NTd5VLR5CGNCcqhvK7cOZWg82T/fRShjQ9mwttc5oxb/O20MwRzSTfh3V6w+5ww4gofG
         vvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DriQn3oUNtY9KztAGS0KsFuBc5YfBmykMcm24BuA1yQ=;
        b=hV4e1QFzcIKF3Inpa6lCmWehH8Oz0SGlLUgVpYrGnKIFhPle8hJsagqKFqM59lfnto
         4zFGF8CYy+EflQq4Q87XLvSquNitkBHUsAU9F0pQvsZbGZRNKlpqaofOpDreuuHDbGjK
         BDVjAm32EE0C/RVCyo0tXV+394XmbHQIk9I6OL8W6tPhmH8Rqak5owg+Xne+vwc6r4hg
         Fd70twBGFFDeox9swJ3Wa/FXc5SmQ2k8jMjp2MD89dhJEo/da9Q4DlQ/A4zfsSSu4o8a
         Cxukk3Br5TRSP+U4AsSi+r/m+rvcIUpflR3sSYj/juNYuEE/uiC9XpFZkfmaAIl9McXc
         FIhQ==
X-Gm-Message-State: AJIora/jwXdVmjRIXdQFHzjMY0KnbLllG+Oh5MMSdynG04+0a+CakXuz
        n3qcxH5kqnRoW4w2N52yZ0CfXAolZL8CQQ6Tdq9fKA==
X-Google-Smtp-Source: AGRyM1vna0EzJ1fGGzIgIm07JkuMAsb1BoGLPWFsmN6rGuB3/QzKtteSbNpCgCzOcMV/LeVz+/zNh0xkSyZdNA1xFHA=
X-Received: by 2002:a5b:1c8:0:b0:671:5d14:5974 with SMTP id
 f8-20020a5b01c8000000b006715d145974mr1799440ybp.123.1658768275765; Mon, 25
 Jul 2022 09:57:55 -0700 (PDT)
MIME-Version: 1.0
From:   Maxim Blinov <maxim.blinov@embecosm.com>
Date:   Mon, 25 Jul 2022 17:57:45 +0100
Message-ID: <CADmoyEiUoULvn76UXcS0DaF2-Us4CTL=SyXf7PWYqfPTF3PTtQ@mail.gmail.com>
Subject: How to read RISC-V mcycle CSR from Linux userspace app?
To:     qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, stupid question but I can't for the life of me figure this out
even with all the docs open.

I need to get an estimate figure for the cyclecount of a busy loop in
one of my small Linux userspace apps. The app in question is running
in qemu-system-riscv64. I've compiled QEMU myself, and the full code
is like this:

#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

uint64_t get_mcycle() {
  uint64_t mcycle = 0;

  asm volatile ("csrr %0,mcycle"   : "=r" (mcycle)  );

  return mcycle;
}

int main(int argc, char **argv) {
  printf("Hello\n");
  printf("mcycle is %lu\n", get_mcycle());

  return 0;
}

Now I get SIGILL when I hit the `csrr` insn, which makes sense.
According to the "Privileged Architecture Version 1.10", page 32, [1]
we need to set mcounteren, hcounteren, and scounteren low bits to 1 in
order to get the mcycle csr to become available in userspace. So I add
the following function:

void enable_mcount() {
  /* Enable IR, TM, CY */
  uint64_t mcounteren = 0x5;
  asm volatile ("csrw mcounteren,%0" : "=r" (mcounteren));
  asm volatile ("csrw hcounteren,%0" : "=r" (mcounteren));
  asm volatile ("csrw scounteren,%0" : "=r" (mcounteren));
}

And call it before I call get_mcycle(), but this triggers SIGILL
(unsurprisingly) also, since these CSRs are also privileged. So
there's a bit of a chicken and egg problem.

Could someone more knowledgeable please suggest what the course of
action here is? I've got QEMU revision f45fd24c90 checked out, and I'm
staring at qemu/target/riscv/csr.c:71, which seems to deal with
whether or not to raise a SIGILL upon access. I can see a condition
for when we're in 'S' mode, but nothing for 'U' mode. Does that mean
there is fundamentally no access to these CSR's from 'U' mode? Is it
possible to just hack it in?

Maxim

[1]: https://riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1.10.pdf
