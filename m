Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DBE596D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbiHQK5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbiHQK5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:57:20 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C863F10;
        Wed, 17 Aug 2022 03:57:18 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPSA id 64194200002;
        Wed, 17 Aug 2022 10:57:15 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 0/4] iio/adc-joystick: buffer data parsing fixes
Date:   Wed, 17 Aug 2022 12:56:39 +0200
Message-Id: <20220817105643.95710-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this patch set fixes the way channel data is being parsed in the
adc-joystick driver. To achieve that, it also introduces helpers in the
IIO subsystem. As a side effect of those changes, a bug in ingenic-adc
has been exposed, which this patch set promptly rectifies.

Tested on GCW Zero (by me) and on Anbernic RG350 (by Paul).

Chris:
As you have originally reported the issue, would you be able to test
the above changes on your setup (Odroid Go Advance, was it)?

Artur Rojek (4):
  iio/adc: ingenic: fix channel offsets in buffer
  iio: add iio_channel_cb_get_iio_buffer helper
  iio: add helper function for reading channel offset in buffer
  input: joystick: Fix buffer data parsing

 drivers/iio/adc/ingenic-adc.c               |  7 +++---
 drivers/iio/buffer/industrialio-buffer-cb.c |  7 ++++++
 drivers/iio/industrialio-buffer.c           | 28 +++++++++++++++++++++
 drivers/input/joystick/adc-joystick.c       | 26 ++++++++++++-------
 include/linux/iio/buffer.h                  |  4 +++
 include/linux/iio/consumer.h                | 12 +++++++++
 6 files changed, 71 insertions(+), 13 deletions(-)

-- 
2.37.2

