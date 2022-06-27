Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50EF55C1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiF0TG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiF0TGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:06:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C552627;
        Mon, 27 Jun 2022 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656356778;
        bh=byy4E4EiJd0hCnXHmLJQZVe2F93ir294u7Rcd5JqdM4=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=aE2wIFFVNNeiqP/wqCcKS3AnWp5JhwkIakaAqwFWDARR/s2WnhnlqNGrFHU4uW/3v
         ZLHyYPS1c22i06V0nNUK4rL7J36cKyuN8CgRHbsx5rXSXxdOXbROYxI0ivuTpW2OW5
         TBfU/I7ON20RJTFlJ1duVFHlRvng5hvYSXONStvg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.176.39]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wGs-1o4n4A2hUi-003JuJ; Mon, 27
 Jun 2022 21:06:18 +0200
From:   Helge Deller <deller@gmx.de>
To:     mcgrof@kernel.org, jeyu@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [PATCH 1/2] modules: Ensure natural alignment for .altinstructions and __bug_table sections
Date:   Mon, 27 Jun 2022 21:05:50 +0200
Message-Id: <20220627190551.517561-1-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tDjHc/AtG5ryQJBeAYXVlyFl2ik7Oe2mNxsz3suMzz3oXSq4X4w
 9Hiat9N9u70hSW0Md276tcPPTDkDDYMlh/pnQjDVi5WwCtlCFn4aWAiPirAbHTS2A/PwVU3
 7mrRWmNol0ejPz49RXvG9a5OOMrgeoPMIEoiN12QQx36PTUcS/mmbfq2/U0c6fINzND9/x9
 Rl3xhBT3vvwzQb44fZcnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HP79HB2Hc9M=:eq+bDKebwImE9OIBQW47+y
 B6TS59ZEpB20QkT673aoRAgaosNayuALbVUcc02xsm/ojIpRW/kYwVabY30qDfcQSKuEIewSn
 aCOwNGYmwr12V6Es3y348Kf80KOoCQAS+0aeze6fIuW1Rwlzz6hOnIAzi9Fq2QVAmcOam0SGm
 CdkZ4TyxJLt7lflRggXKcW//UCmOxmAANDagSMuWIfgj+/zeqcB+s1kiEzGXCrbR4kZQNJHKv
 0zsdoFJTsq/BvNkXS9BitIrURHGZjA6x2Lh3mafLs+YwD3pQx/tMVN6vkK7ST3TDfZtzdpx9A
 o3VDpeFsKWO4waSc+1WbOXKEyIgYXuMXzBaqK2fth4xoiGbDVvmeUmdhxkC9wzZrSzpUs4iMm
 Pm3M01vXXdjkO744HASC3x8glQZhIvsLVfZMzoz6HHn1D4dEcCIGR/hFYQLC0uboEuzmwe1oG
 kyAE2+RVHCzgtPecwLA6yb2AegwJlmDqHVKjgRnWRhyRbL8tdxSPA2qdFmQlvza5CGOwc3jWP
 kaWyMqi01V1WKNMsS4aVscdcu2SKTO54dxLI/iYT8LzeSi+rbjS18YPt7K0w4FhtZmc66nLNs
 udMm3Dd1JbEw+PVcWlc44ZPYpefnC7f2GkbF2YiY4AkhJEKWSI+huGtvY4kYAphX3xgg++GT7
 t3VgVU5HOvsU1terHFYeRR7YU8rDN1tj7zDOBidf7PL+t5dk9jlMUwrCYIsXIOKMSY0WhxDaY
 GeuzXUnGMtoaDm4atwPIb3RyfuRu+hkVSI9fkzsEJY4bDvPUQ0kbnc/q6hFSCaWxwG32U1PZt
 pGzFWoT+4lvQ/DcdkhbU85fNL0FiCXUITLONbEsxJozno/AWmZmqDjcI6W4OCLfK8lD8jrfRv
 sPra+ETeD8D+LgPosdaGeDfgnDjm7JPEwma9t07tHArhiJyNfpx6LFk/Iu88RhLGcy6zQWL5I
 0YOilTQacuwR9sW6nwkfU50y3X0yq1ntLnwPTFRspF6rH5bAmBzpToZFSMb82HjFiPHFiFpfV
 HOntSAx23rQdE+jpjUqt44GcBB+iy0uJRBfbMxV+KGxG20WdktJ4GpOsYl187Dt32uWE0Hbty
 mKbxQLj6XPIGJh2rzIunhysP3O4QeKPguVuyKBJk38951QjN24IwxwgtA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the kernel image vmlinux.lds.S linker scripts the .altinstructions
and __bug_table sections are 32- or 64-bit aligned because they hold 32-
and/or 64-bit values.

But for modules the module.lds.S linker script doesn't define a default
alignment yet, so the linker chooses the default byte-alignment, which
then leads to unnecessary unaligned memory accesses at runtime.

This patch adds the missing alignments.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 scripts/module.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 1d0e1e4dc3d2..3a3aa2354ed8 100644
=2D-- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -27,6 +27,8 @@ SECTIONS {
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }

+	.altinstructions	0 : ALIGN(8) { KEEP(*(.altinstructions)) }
+	__bug_table		0 : ALIGN(8) { KEEP(*(__bug_table)) }
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }

 	__patchable_function_entries : { *(__patchable_function_entries) }
=2D-
2.35.3

