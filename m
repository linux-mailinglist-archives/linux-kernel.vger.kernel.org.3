Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34CD480107
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbhL0Pwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbhL0Pqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:46:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2307DC08EA73;
        Mon, 27 Dec 2021 07:42:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1FA6B810AA;
        Mon, 27 Dec 2021 15:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CDEC36AEA;
        Mon, 27 Dec 2021 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640619773;
        bh=OWtXgZdELdIx+ueQP4EPOs1uNr/MXpeB4xRaHx7T4fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0iYOStWy9WLOPTSNpt/WfiE+Gm19WmXuJUj1tMDrZFKeWpLWa4PfSIFdPUUjIqW/
         1JB3ZYam01ddbGDHJf8mQnbN7W+L31inTAWqfbqfeCS/CurozJgI2huEEk1ljBM6BI
         vFW/3u3IvfH7Gj6y9fNPzGegW0Hgc0MJQ4ciwbeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaoke Wang <xkernel.wang@foxmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 065/128] ALSA: jack: Check the return value of kstrdup()
Date:   Mon, 27 Dec 2021 16:30:40 +0100
Message-Id: <20211227151333.667602408@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211227151331.502501367@linuxfoundation.org>
References: <20211227151331.502501367@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

commit c01c1db1dc632edafb0dff32d40daf4f9c1a4e19 upstream.

kstrdup() can return NULL, it is better to check the return value of it.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/tencent_094816F3522E0DC704056C789352EBBF0606@qq.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/jack.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -509,6 +509,10 @@ int snd_jack_new(struct snd_card *card,
 		return -ENOMEM;
 
 	jack->id = kstrdup(id, GFP_KERNEL);
+	if (jack->id == NULL) {
+		kfree(jack);
+		return -ENOMEM;
+	}
 
 	/* don't creat input device for phantom jack */
 	if (!phantom_jack) {


