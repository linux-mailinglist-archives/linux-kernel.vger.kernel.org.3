Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50EA4C6A40
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiB1LZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiB1LZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:25:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B999243ECF;
        Mon, 28 Feb 2022 03:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tG6ggSulZNgAhyIjj/uL5J0uG8FdMjxyr1e5Wg1d4pk=; b=u5G+iB31hHZnTBXJX1UY0RONwS
        xx6MIhdJXmTFy3l99Gf64p1nF8s+g7rBQwGzBuHjmWXRtCsTNk7zGX1qKf3B3eEBONdrcKJmc8AcY
        RkC13TtKUYl17XOgvWPvu8VIruUUWYLahMDuZSOWDn5hfeezyw7AuFi/Vpc8owMF7Ws+DHHE3lXVQ
        WnDbtroYunms5VgcYpk3ugD18WP5Yy0G5Hf7xJ/B0BoEmiqgNxbdx5JxK0eIpf3nf2W4JTyD+ww1l
        OuycMiILdxfWNIlAsPKPGXTEn2vaZqeGd07TXbrBJ4Di+CueKtaC9wXnN9JB8xC9Vnk3MhozgvJWU
        gJv1dYXA==;
Received: from [2.53.163.181] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOe9K-00BqQZ-LU; Mon, 28 Feb 2022 11:25:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: raid5 bio handling cleanups
Date:   Mon, 28 Feb 2022 13:24:59 +0200
Message-Id: <20220228112503.841449-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

this series cleans up the raid5 bio handling to take advantage of
the bio allocation interface changes in Jens' for-5.18 branches.

Diffstat:
 raid5-cache.c |   33 ++++++++++++++++-----------------
 raid5-ppl.c   |    5 ++---
 raid5.c       |   25 ++++++++-----------------
 3 files changed, 26 insertions(+), 37 deletions(-)
