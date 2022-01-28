Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91F14A041A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbiA1XKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:10:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:42117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243573AbiA1XKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643411398;
        bh=nKOgNNjjbb6iRRpllOw9CofNg19QrVk3e0lNK8nkpmA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=CbTgmQzercNn4ovhqp2FVGVWr0fSzwDDzZLmxXYcvLWcIjQVwpS09PwOTmTo/XIlD
         UefV02XMytSHycwvNNRQrsvBmQiZ2Z+RUtSkZx/kSf6EwEj7btWn3hujlts4hH9Akt
         lw13e2UbGx51BenEa+L8HXfO/epc7h/IxbX6G6v8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.80.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCKC-1mqOf400Dk-00N9H3; Sat, 29
 Jan 2022 00:09:58 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/4] clk drivers: Terminate clk_div_table with sentinel element
Date:   Sat, 29 Jan 2022 00:09:18 +0100
Message-Id: <20220128230922.2047140-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tbVADY7hTofNy/iKkkZ/jbRLr1vGtv/6YJWw2FH6bg/7syrKjZf
 QCmPQ+w52QP43UQoIcRKpE1QdThN1G3L6w/fLsdGTQy3Os8KYtwWNvnk57bzMf58ov95fjB
 5FYeIZD5abMkmXjDaBClBv6WxBbCgINREU9Yf+48aFuWNX1jGbZNcwyfBOrb437oyFVN2Uj
 h6F1XMhGJzAZ/RuNmLC0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rzwj+X1v+Fs=:W5+WGgXirIxBZKI7vrk48j
 rwrlQkAP9vIUUVZ5jXIElpayL+SkldFNErLH4QYIP+9EsqkILY1Rd5MW0LVH4oJwWRiwVLucx
 EvKRQOy0ynyaErqB3N1c8GQdqT1T5/q1cJEi19SMIGAnvBuvNqK1s1hVnIIEgJ7Xre6BKFBEE
 YzJGum3N1L9dAQz4yb7+8MYILFvoxR5JANdlKpsvl9N5SfPmQWjAIeQ6b31awvPe1VV4XLQcp
 VH2v2EVyvxupg/bJi8/Yp3hY5IXgTRCQDJEKEN6MnwnfmJW+4d9atXqgLBWQq2fn7PeJS8M/Z
 LyiopGYh3SGLi8P7eFLwvcCKe31lzXDbykQiRovCY1qMRkEuk/H5+mES+IuszIAr2YtVLAFjY
 hdZc68Uec/h7KdIWoTghJvmiEQZT9wHHjY1VPOHN+xC7VhLlmPrADChlfVBbupjOlq9jXjgU5
 V9wN7EEILUwLlwTKI3WJy6QnejtsWsjBHVWZA8cB8N9KzGV7pe6YPgAuLi4PQN2zcGiG75pnu
 ByXlBLj7EkWv8M12KV/2l94GXzrslhrRxSKiRRwybAvfJ1dzEzH5imyHgzslK9re2r+tppv1N
 r5RyzTb6UGY9XxgdLuwJwXFOaQcK1CRnbTiIbtJI/qCxmJlxjE7y/z0TdpsGUtUr++2mYaOFp
 sZ996inDXQMbd20J05e6JpAJG5GalfFA1Y6ld6ZtaT7n8Ihf3/1v9AGk7cD1Yud0WaqHhrtZt
 G23mzPDQQDj6Rgb7GyM+1cZMzzutb0GL+XnJpx4pYl/6QxpBgG0SaYiBolAefwAkpojO9s/SV
 3P9jPkD46/y/aH2aiVKab1cetsHSMns2U71A0ZbXvBL1nRO5wO0JOzxsMHo00+2kPpKq++YNe
 hKaR6qcCRfMIcbTuMukgzbv+4yGoqbnA0ztWxWyNES/GWjXDaEJU1oiZt/B1FSW4+iKr48nrk
 okN2Hho6qFCPBtlPYcbJIXrveIxWOYKO9fNrsTFBV0CKnstpfzMoIcPBezH87uXck8Qmc1Y8Q
 mJWOpfqB5CQ+8FYPpM04ej42JpriL/0l01tGEvMm0X0cawXtZB7GKYxILslue+urR1QQyID9C
 7rYvHg+ZSGm/q0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that some of the clk_div_tables in different drivers are not
terminated with a sentinel element. This may cause the code in
clk-divider.c to read garbage that happens to be beyond the end.

This patchset fixed all instances of this bug that I could find, except
for a case in drivers/phy/ti/phy-j721e-wiz.c that is already fixed in
linux-next:
  https://lore.kernel.org/lkml/20220117110108.4117-1-kishon@ti.com/

Jonathan Neusch=C3=A4fer (4):
  clk: actions: Terminate clk_div_table with sentinel element
  clk: loongson1: Terminate clk_div_table with sentinel element
  clk: hisilicon: Terminate clk_div_table with sentinel element
  clk: clps711x: Terminate clk_div_table with sentinel element

 drivers/clk/actions/owl-s700.c         | 1 +
 drivers/clk/actions/owl-s900.c         | 4 ++--
 drivers/clk/clk-clps711x.c             | 2 ++
 drivers/clk/hisilicon/clk-hi3559a.c    | 4 ++--
 drivers/clk/loongson1/clk-loongson1c.c | 1 +
 5 files changed, 8 insertions(+), 4 deletions(-)

=2D-
2.34.1

