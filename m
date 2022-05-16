Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9EF527E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbiEPHWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241091AbiEPHVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:21:45 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE9E1707C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1652684772; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=bLm0uBldu0r8i6aT3csYC9f8ddOBqdl7xdusBxGsn02gCo6DvXhWIuPKVnl79T36ybjsSH42UqLeCzp9ifpFqx96butoRPPi+OBy2ZQgts2zUYJpYd4Lm51V+sL4GwutoEzDeMExY/3lp79sAFw7Cp0+cgXKapTXpsYhzxv9h8c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1652684772; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=EU0N+NK2TGrYEQ59ert+9I0xYmY7UQqiUrHh4fhPx2Y=; 
        b=BLuYW7DHbM+A88pEdkNX0Hd52TdY8mDGka+sbcWXExC82kI+eq3CgUz+yQRoHAawD42cC5rzCFmspp5wWKhk2Yqf1V615krUqnywgPRI421zkWwRpZ9VEQmZgln5l11vO4vxtK8dsSGqJonc12Ws87i3daecjcRLvV9BcDe4kxc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=kempniu.pl;
        spf=pass  smtp.mailfrom=kernel@kempniu.pl;
        dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1652684772;
        s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=EU0N+NK2TGrYEQ59ert+9I0xYmY7UQqiUrHh4fhPx2Y=;
        b=McQAoBFKBVHL49UQWaH0M32WAL7xC6rDzr3Y53co8GjJwXXymSVFLvaZn5s+o0vi
        SmPHq0kt8nXDxk7bYo9d2jSpHVbutg9OIG+8+sI6Gx44T7e6mlw09JqpotSd4s5TbNa
        meRo4EXIvizUHC4J8kz2XRrOoLDuIDzXWNV+oQbM=
Received: from larwa.hq.kempniu.pl (212.180.138.61 [212.180.138.61]) by mx.zoho.eu
        with SMTPS id 16526847699991012.3311458811077; Mon, 16 May 2022 09:06:09 +0200 (CEST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20220516070601.11428-1-kernel@kempniu.pl>
Subject: [PATCH 0/2] mtdchar_write_ioctl(): prevent integer overflow, use kvmalloc()
Date:   Mon, 16 May 2022 09:05:59 +0200
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses two flaws in mtdchar_write_ioctl() found by
Richard Weinberger while he was reviewing v3 of the patch series
proposing a new MEMREAD ioctl [1].

Richard, I included a Suggested-by tag crediting you in both of the
patches in this series.  I hope that is okay with you, but please let me
know if it isn't.

Once this patch series is reviewed and accepted, I will apply similar
fixes in v4 of the MEMREAD ioctl patch series.

[1] https://lists.infradead.org/pipermail/linux-mtd/2022-February/091276.ht=
ml

Micha=C5=82 K=C4=99pie=C5=84 (2):
  mtdchar: prevent integer overflow in a safety check
  mtdchar: use kvmalloc() for potentially large allocations

 drivers/mtd/mtdchar.c      | 13 ++++++++-----
 include/uapi/mtd/mtd-abi.h |  4 ++--
 2 files changed, 10 insertions(+), 7 deletions(-)

--=20
2.36.1


