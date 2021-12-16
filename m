Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E351476AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhLPHOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:14:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47158 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhLPHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:14:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76C1161C44;
        Thu, 16 Dec 2021 07:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE178C36AE2;
        Thu, 16 Dec 2021 07:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639638843;
        bh=xPCUzOj4GieQMOuilzV8vhjp46fj1EKmw4B3F1ga7AM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rQogwJyUY2Ccf5eLPliNU6Y8NbFy7TdJ+kSKc4Y7Wv4FX7dSWClDkFii8scmJZOyb
         4mG3qIjujwAsZrkyI0rYCtMQwySsmieU1j3ZKK+NXQbIFy3vSM0yVEUdtrTZvVr0yz
         TBdjcOG2O2JDyez61PspaJivdUXh0qNWZ0x0TX0cHeMdKA0F2xXhVK/wpPCB4NEZ+h
         U9hJAgjPdaBG2gqcEaMDK1i92AkX6ngHar3U1Q+jpWczxi5yrgncguefrbQ/aUAXAc
         MVLk0uJO4YkdmJI1keDZTm6lfzM131jnyQgUD9S5BoVMaFpdPan7lpwQGHLNVa7Ypj
         2QIj/wNn0aKkA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211118034719.28971-1-quic_collinsd@quicinc.com>
References: <20211118034719.28971-1-quic_collinsd@quicinc.com>
Subject: Re: [PATCH v2] spmi: spmi-pmic-arb: fix irq_set_type race condition
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Collins <quic_collinsd@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Kiran Gunda <quic_kgunda@quicinc.com>,
        Anirudh Ghayal <quic_aghayal@quicinc.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
To:     David Collins <quic_collinsd@quicinc.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 Dec 2021 23:14:01 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216071403.BE178C36AE2@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Collins (2021-11-17 19:47:19)
> The qpnpint_irq_set_type() callback function configures the type
> (edge vs level) and polarity (high, low, or both) of a particular
> PMIC interrupt within a given peripheral.  To do this, it reads
> the three consecutive IRQ configuration registers, modifies the
> specified IRQ bit within the register values, and finally writes
> the three modified register values back to the PMIC.  While a
> spinlock is used to provide mutual exclusion on the SPMI bus
> during the register read and write calls, there is no locking
> around the overall read, modify, write sequence.  This opens up
> the possibility of a race condition if two tasks set the type of
> a PMIC IRQ within the same peripheral simultaneously.
>=20
> When the race condition is encountered, both tasks will read the
> old value of the registers and IRQ bits set by one of the tasks
> will be dropped upon the register write of the other task.  This
> then leads to PMIC IRQs being enabled with an incorrect type and
> polarity configured.  Such misconfiguration can lead to an IRQ
> storm that overwhelms the system and causes it to crash.
>=20
> This race condition and IRQ storm have been observed when using
> a pair of pm8941-pwrkey devices to handle PMK8350 pwrkey and
> resin interrupts.  The independent devices probe asynchronously
> in parallel and can simultaneously request and configure PMIC
> IRQs in the same PMIC peripheral.
>=20
> For a good case, the IRQ configuration calls end up serialized
> due to timing deltas and the register read/write sequence looks
> like this:
>=20
> 1. pwrkey probe: SPMI  read(0x1311): 0x00, 0x00, 0x00
> 2. pwrkey probe: SPMI write(0x1311): 0x80, 0x80, 0x80
> 3. resin probe:  SPMI  read(0x1311): 0x80, 0x80, 0x80
> 4. resin probe:  SPMI write(0x1311): 0xC0, 0xC0, 0xC0
>=20
> The final register states after both devices have requested and
> enabled their respective IRQs is thus:
>=20
> 0x1311: 0xC0
> 0x1312: 0xC0
> 0x1313: 0xC0
> 0x1314: 0x00
> 0x1315: 0xC0
>=20
> For a bad case, the IRQ configuration calls end up occurring
> simultaneously and the race condition is encountered.  The
> register read/write sequence then looks like this:
>=20
> 1. pwrkey probe: SPMI  read(0x1311): 0x00, 0x00, 0x00
> 2. resin probe:  SPMI  read(0x1311): 0x00, 0x00, 0x00
> 3. pwrkey probe: SPMI write(0x1311): 0x80, 0x80, 0x80
> 4. resin probe:  SPMI write(0x1311): 0x40, 0x40, 0x40
>=20
> In this case, the final register states after both devices have
> requested and enabled their respective IRQs is thus:
>=20
> 0x1311: 0x40
> 0x1312: 0x40
> 0x1313: 0x40
> 0x1314: 0x00
> 0x1315: 0xC0
>=20
> This corresponds to the resin IRQ being configured for both
> rising and falling edges, as expected.  However, the pwrkey IRQ
> is misconfigured as level type with both polarity high and low
> set to disabled.  The PMIC IRQ triggering hardware treats this
> particular register configuration as if level low triggering is
> enabled.
>=20
> The raw pwrkey IRQ signal is low when the power key is not being
> pressed.  Thus, the pwrkey IRQ begins firing continuously in an
> IRQ storm.
>=20
> Fix the race condition by holding the spmi-pmic-arb spinlock for
> the duration of the read, modify, write sequence performed in the
> qpnpint_irq_set_type() function.  Split the pmic_arb_read_cmd()
> and pmic_arb_write_cmd() functions each into three parts so that
> hardware register IO is decoupled from spinlock locking.  This
> allows a new function pmic_arb_masked_write() to be added which
> locks the spinlock and then calls register IO functions to
> perform SPMI read and write commands in a single atomic
> operation.
>=20
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> ---

Applied to spmi-next
