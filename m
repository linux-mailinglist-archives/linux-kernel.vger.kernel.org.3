Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA3C475DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245047AbhLOQ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245036AbhLOQ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:56:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B9FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=t1UD/mbOsROHi20aljeAGjh0DC/YXJCwQ6Vm4qszs3w=; b=A0SLDwpyCH94niBU7hYeWKFYjt
        MtSoLyKkoJuE0P2dO55o+h5rQoVQk9DIWYJpBcZXml6wl9AY4Awt2Dm7GZ5bgdVs/cv3UfMA2hem3
        PtIqwPP4Vjv19hiOEX+IEoPyR3nmwEqDb7zoLcX5AOssPGPmK7WXH9wepJ9Nj0uz6Ece5Fq7+UQi2
        Ommq1GOjEhMVsr4tgH9gyMIkwxqgjWGdqBdDPP+cqYfjb5HDt2wqswxWRU11/jfOKvSnya/1c6Kwh
        zU+884Czsr0Ja6PwngpdCSuOQW3EigU+vQyZFyYzfLs3Kk7pAqT3LDv9bnVI8SLrmkiwpMQTG9hZP
        Owd+2kfQ==;
Received: from [2001:4bb8:184:5c65:a9d9:2b74:3491:e72b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxXZd-00EpX0-In; Wed, 15 Dec 2021 16:56:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     x86@kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: remove set_fs for UML
Date:   Wed, 15 Dec 2021 17:56:10 +0100
Message-Id: <20211215165612.554426-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard and Anton,

this series removes address space overrides using set_fs for UML.

Diffstat:
 um/Kconfig                   |    1 -
 um/include/asm/thread_info.h |    4 ----
 um/include/asm/uaccess.h     |   21 +++++++++++++++++++--
 um/kernel/skas/uaccess.c     |   25 -------------------------
 x86/include/asm/mtrr.h       |    8 +-------
 x86/kernel/setup.c           |    7 ++++++-
 x86/um/asm/segment.h         |    8 --------
 7 files changed, 26 insertions(+), 48 deletions(-)
