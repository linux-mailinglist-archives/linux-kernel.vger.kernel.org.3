Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529BC54B527
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347495AbiFNPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbiFNPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:55:31 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6401A81D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:55:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D08E63C7BAE;
        Tue, 14 Jun 2022 11:55:27 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8xBpgvQspl98; Tue, 14 Jun 2022 11:55:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5A4993C7BAC;
        Tue, 14 Jun 2022 11:55:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5A4993C7BAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1655222127;
        bh=OVVX77NJaKEpiz2cL6LOuhjWgBAIf5s6dwOHqFP2faw=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=uUX8WbvpTCfa6qRtpQrg4oPYh6zVIAqKr6eJ9A6oZz+ZgTbkiLNTVYX9AqBa4i5XP
         ZVzM3rmPV4y0iA5TFnCJXX6ymqSMahx4xD4cQvsTZoV7EkeFwMzRSDjkJ4cKi8oaxc
         rBd7/oKdwV1PkjVybO778Rj822QLmHsyg9y8t5eQo/CMt9VTqUAHT+lZz3oDaupJgp
         1y+xR4RqbbKjUplhxjuLbM5GwQbD01Dpq2hT12ZsqUr1j3RfJzPNOqzXEatvjY8TaB
         FjOq7gd96bPvkHYj8QqA8C2u2AplVc1HykR8k3JIkyNcxmN3sUqZ8c4qC8yRZtGCm4
         esJfqJM4R+JEA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vT9p9F8JpKWN; Tue, 14 Jun 2022 11:55:27 -0400 (EDT)
Received: from laptop-mjeanson.internal.efficios.com (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 101D93C7AB7;
        Tue, 14 Jun 2022 11:55:27 -0400 (EDT)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH 0/3] selftests/rseq: fixes for RISC-V and Glibc 2.35
Date:   Tue, 14 Jun 2022 11:48:27 -0400
Message-Id: <20220614154830.1367382-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

The patch series allows running the rseq selftests on a Glibc 2.35
system which has rseq support but no RSEQ_SIG defined for the RISC-V
architecture.

The patches were tested on both Glibc 2.33 and 2.35.

Michael Jeanson (3):
  selftests/rseq: riscv: use rseq_get_abi() helper
  selftests/rseq: riscv: fix 'literal-suffix' warning
  selftests/rseq: check if libc rseq support is registered

 tools/testing/selftests/rseq/rseq-riscv.h | 50 +++++++++++------------
 tools/testing/selftests/rseq/rseq.c       |  3 +-
 2 files changed, 27 insertions(+), 26 deletions(-)

--=20
2.34.1

