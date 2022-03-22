Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2D64E44B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbiCVRJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbiCVRJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:09:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C59971EC9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:07:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 16F531F387;
        Tue, 22 Mar 2022 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647968867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=m0HZkkkCvfCXgsfLMiVZKxjN0kToTbJd7hKDVBIs6aw=;
        b=yXztFw54QWyEjaLgsgPWhqqOKkFrluWU7938ub+Z2d1duXcO0guuhmxi7f54qsEy6ozkC5
        ZuiOesYv/NlU1VLuwtG2uZZ8162OaN7k1uOl+xVdZoLjN+YRwAZ6xYZQ2SAXHcfh8BIJqq
        Rx+H7ia0S2/KRivAdzVe2IEMvxdxaGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647968867;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=m0HZkkkCvfCXgsfLMiVZKxjN0kToTbJd7hKDVBIs6aw=;
        b=GNNkuVErgDbvoXDAHyunnpH0GP9D4G6s997TI+dN8OtjcWuqoLEY/0GCvrCk/2GwL1Eymx
        N3JuCQ41MdjXX3Aw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 0EF0EA3B87;
        Tue, 22 Mar 2022 17:07:47 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Hu Jiahui <kirin.say@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ALSA: pcm: Fix ioctl races
Date:   Tue, 22 Mar 2022 18:07:16 +0100
Message-Id: <20220322170720.3529-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a patch set to address the recently reported bug for the racy
PCM ioctls.  In short, the current ALSA PCM core doesn't take enough
care of concurrent ioctl calls, and the concurrent calls may result in
a use-after-free.  The reported problem was the concurrent hw_free
calls, but there can be similar cases with other code paths like
hw_params, prepare, etc, too.

The patch set introduces the new runtime->buffer_mutex for protecting
those.  The first patch is the fix for the reported issue (the races
with hw_free), while the rest three are more hardening for the other
similar executions.

[ Note that the patch 3 was slightly modified from the version I sent
  to distros list, as I noticed possible lockdep (false-positive)
  warnings.  The behavior is almost same, just written differently. ]


thanks,

Takashi

===

Takashi Iwai (4):
  ALSA: pcm: Fix races among concurrent hw_params and hw_free calls
  ALSA: pcm: Fix races among concurrent read/write and buffer changes
  ALSA: pcm: Fix races among concurrent prepare and hw_params/hw_free
    calls
  ALSA: pcm: Fix races among concurrent prealloc proc writes

 include/sound/pcm.h     |  1 +
 sound/core/pcm.c        |  2 +
 sound/core/pcm_lib.c    |  4 ++
 sound/core/pcm_memory.c | 11 +++--
 sound/core/pcm_native.c | 93 +++++++++++++++++++++++++----------------
 5 files changed, 71 insertions(+), 40 deletions(-)

-- 
2.31.1

