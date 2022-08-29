Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C8F5A4DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiH2NVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiH2NVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:21:19 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27752124B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:18:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [95.31.169.23])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6D10D40D403E;
        Mon, 29 Aug 2022 13:17:14 +0000 (UTC)
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org, Hillf Danton <hdanton@sina.com>
Subject: [PATCH v4 0/2] tty: n_gsm: avoid call of sleeping functions from atomic context
Date:   Mon, 29 Aug 2022 16:16:38 +0300
Message-Id: <20220829131640.69254-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7f8d878b-ca7b-9bc0-6962-1c7de28c2c7b@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reports calling of sleeping functions from atomic context. This
is fixed by the following patch series. 1/2 is a needed prerequisite patch
for the fixes made in 2/2 to be integrated.
