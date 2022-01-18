Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E16492E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348346AbiARTU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:20:59 -0500
Received: from mail-4316.protonmail.ch ([185.70.43.16]:49117 "EHLO
        mail-4316.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348688AbiARTU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:20:58 -0500
Date:   Tue, 18 Jan 2022 19:20:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1642533656;
        bh=2dgbR55aNLsLtRAPEJ4xaevshFDzpa+VOMgLkXkvJ6c=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=XkAGr0Db6QV3VyHD+YPvbFMJMs04ruJQDZ5OpZA8JyXNDrnxftvMRR+puCRkmr/PU
         2VJbE0ZKrjtdA9KnnpjtxJXftpD0s8uMtiehX9bhjIxgNo8VtbF5tKSUTHZkPbqHqT
         Kb29TJIUb9O0UYZXDTR18C6GLH+2ORYdUEno2jbn39L1qnyCK9fR2D1KoUUfW84VSu
         7gl8VrM6VxAeW+8dIRn6BsJoYz3n0XKtqVrXDh9DKAWnt+BgOOwNd5hVutr0aQkYlg
         tFpJWj/syBUUmUayioXySCwVDOOkXIjSMccdXD+0hlbbkmilLJCfQ8tCKA5TsLPpUS
         T0Rv+9aRCytVQ==
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kettenis@openbsd.org,
        =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Reply-To: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Subject: [PATCH v2 0/3] Support for Apple SoCs' NCO blocks
Message-ID: <20220118191839.64086-1-povik+lin@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is v2 of the common clock driver for NCO blocks on recent Apple SoCs.

Changes since v1:

 - drop apple,nchannels property from the binding, rely on size of the regi=
ster
   range instead to gauge the number of channels
 - add a lock to guard set_rate from racing with clock disable/enable
 - add short "theory of operation" comment
 - incorporate minor changes from Rob's, Sven's and Stephen's review (thank=
s!)

Martin

v1: https://lore.kernel.org/linux-clk/20211214120213.15649-1-povik@protonma=
il.com/

Martin Povi=C5=A1er (3):
  dt-bindings: clock: Add Apple NCO
  clk: clk-apple-nco: Add driver for Apple NCO
  MAINTAINERS: Add clk-apple-nco under ARM/APPLE MACHINE

 .../devicetree/bindings/clock/apple,nco.yaml  |  62 ++++
 MAINTAINERS                                   |   1 +
 drivers/clk/Kconfig                           |   9 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-apple-nco.c                   | 340 ++++++++++++++++++
 5 files changed, 413 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/apple,nco.yaml
 create mode 100644 drivers/clk/clk-apple-nco.c

--
2.33.0


