Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C2A47CCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242662AbhLVGHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:07:51 -0500
Received: from mail1.kuutio.org ([54.37.79.207]:41814 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230384AbhLVGHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:07:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id C481B1FE07;
        Wed, 22 Dec 2021 07:00:11 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :date:subject:subject:from:from:received:received; s=dkim; t=
        1640152810; x=1642744811; bh=IZxlASaqe2+wXnziNok006bBOGqozM/mZq2
        OuTexEi8=; b=m6OQaL5jhhYN6MxP6wjCgexp+GBaRILG4FoHHLaX3pAu5DTFUaP
        zwUNMz0B2bdE1S7ug0psEVZ6MGHRhKlXwlGzUPORwhfP/9xAbotEVSg3sEAqB7vz
        1xGbBvhmlZY2LgFf1sHhFbodTLWF7RJN0wFG+UV05DFpeK4Qi69JwWpDYHtKKYcZ
        Qj/53jNsanawN1BS9iVVWgXFJtPtmLPXchIQnb58fQBLl+TKCGuv4Fw3Tql1RTkv
        BMhJKJP2WniNKq7TQ70a4y3p4UGlD64x3zk929k2TNLWlu3F4QCp8rPWPoX3oEQM
        8CDnlGb4CAQ7Pt55reLCOjkUp7a0Hjt3AUTh5xGfwaaldS97+DK0x/h7GTU/o+QF
        Z4OC0mKOlWLoIkooUT+8j1QojxyjSwRGe1OPvFqFAV8BDbUh7qy4LP8YliT+3QJQ
        2xvnOOhRVWb0sGJgPyVXabdXnGSa5lQMFztHag5FeuxltvmqnUi/Qe9nZfQGDexJ
        /c4i+mnwdHDM8vIDMtYzWWCE5vbyxFTq4WwHpsLkbitW5XsayTrQjLImMqxXXpx7
        qiKMtDdb7aWVguPMkVuIAwpbT4xBkTNj39Ol+B/GRBG8Z/idP8qoUUZ4fuE5u0eP
        TwaUz5dhFH0PewCfFqLxKLK08F5rJrKEwXOw76A/80ydTQi1JThlXzY4=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id vx0ZBEA8A4g8; Wed, 22 Dec 2021 07:00:10 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 53AF01FD6F;
        Wed, 22 Dec 2021 07:00:10 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH 0/2] spi: ar934x: fix transfer size and delays
Date:   Wed, 22 Dec 2021 07:59:56 +0200
Message-Id: <20211222055958.1383233-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of slow SPI devices can not handle 32 bits transfers or need
delay between words/transfers.

Series is tested with ATSAMD20J15 slave device which is running @8Mhz.
Limiting bits per word to 16 bits and adding delay between transfers,
gives slave device enough extra time to process reply.

Oskari Lemmela (2):
  spi: ar934x: fix transfer size
  spi: ar934x: fix transfer and word delays

 drivers/spi/spi-ar934x.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

-- 
2.25.1

