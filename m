Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22994E44B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiCVRJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbiCVRJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:09:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6AE71ED1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:07:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3AB67210F0;
        Tue, 22 Mar 2022 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647968867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKjFtB5KBr9W4w3NflnR7TkFxvAb0C5HMxfUzYIzr7s=;
        b=Vw95QBvC7cbTiU9SNUtLQSonYr3TkhQcan8iNTv8RiCH8N1dR+YThU56V5EDKHoqkvvrUO
        ZzvOcAW8EFpXpuZUKdhywBM/+IHGdAZM+/2uurakRCxllv4CKA5qHde1H122A1vQsT1pdO
        W0wKG48wPmQeihrQTEG9036FwahmFNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647968867;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKjFtB5KBr9W4w3NflnR7TkFxvAb0C5HMxfUzYIzr7s=;
        b=OU5aFBrDmu/SozBe6LOmSsOl+7vDH57qPQHFE/j9z8rXUuMYXfJbFMfrYXrZUo6aRgnhzl
        wdUl6cLEyeF+L9DQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 29758A3B89;
        Tue, 22 Mar 2022 17:07:47 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Hu Jiahui <kirin.say@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ALSA: pcm: Fix races among concurrent prepare and hw_params/hw_free calls
Date:   Tue, 22 Mar 2022 18:07:19 +0100
Message-Id: <20220322170720.3529-4-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220322170720.3529-1-tiwai@suse.de>
References: <20220322170720.3529-1-tiwai@suse.de>
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

Like the previous fixes to hw_params and hw_free ioctl races, we need
to paper over the concurrent prepare ioctl calls against hw_params and
hw_free, too.

This patch implements the locking with the existing
runtime->buffer_mutex for prepare ioctls.  Unlike the previous case
for snd_pcm_hw_hw_params() and snd_pcm_hw_free(), snd_pcm_prepare() is
performed to the linked streams, hence the lock can't be applied
simply on the top.  For tracking the lock in each linked substream, we
modify snd_pcm_action_group() slightly and apply the buffer_mutex for
the case stream_lock=false (formerly there was no lock applied)
there.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 266895374b83..0e4fbf5fd87b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1190,15 +1190,17 @@ struct action_ops {
 static int snd_pcm_action_group(const struct action_ops *ops,
 				struct snd_pcm_substream *substream,
 				snd_pcm_state_t state,
-				bool do_lock)
+				bool stream_lock)
 {
 	struct snd_pcm_substream *s = NULL;
 	struct snd_pcm_substream *s1;
 	int res = 0, depth = 1;
 
 	snd_pcm_group_for_each_entry(s, substream) {
-		if (do_lock && s != substream) {
-			if (s->pcm->nonatomic)
+		if (s != substream) {
+			if (!stream_lock)
+				mutex_lock_nested(&s->runtime->buffer_mutex, depth);
+			else if (s->pcm->nonatomic)
 				mutex_lock_nested(&s->self_group.mutex, depth);
 			else
 				spin_lock_nested(&s->self_group.lock, depth);
@@ -1226,18 +1228,18 @@ static int snd_pcm_action_group(const struct action_ops *ops,
 		ops->post_action(s, state);
 	}
  _unlock:
-	if (do_lock) {
-		/* unlock streams */
-		snd_pcm_group_for_each_entry(s1, substream) {
-			if (s1 != substream) {
-				if (s1->pcm->nonatomic)
-					mutex_unlock(&s1->self_group.mutex);
-				else
-					spin_unlock(&s1->self_group.lock);
-			}
-			if (s1 == s)	/* end */
-				break;
+	/* unlock streams */
+	snd_pcm_group_for_each_entry(s1, substream) {
+		if (s1 != substream) {
+			if (!stream_lock)
+				mutex_unlock(&s1->runtime->buffer_mutex);
+			else if (s1->pcm->nonatomic)
+				mutex_unlock(&s1->self_group.mutex);
+			else
+				spin_unlock(&s1->self_group.lock);
 		}
+		if (s1 == s)	/* end */
+			break;
 	}
 	return res;
 }
@@ -1367,10 +1369,12 @@ static int snd_pcm_action_nonatomic(const struct action_ops *ops,
 
 	/* Guarantee the group members won't change during non-atomic action */
 	down_read(&snd_pcm_link_rwsem);
+	mutex_lock(&substream->runtime->buffer_mutex);
 	if (snd_pcm_stream_linked(substream))
 		res = snd_pcm_action_group(ops, substream, state, false);
 	else
 		res = snd_pcm_action_single(ops, substream, state);
+	mutex_unlock(&substream->runtime->buffer_mutex);
 	up_read(&snd_pcm_link_rwsem);
 	return res;
 }
-- 
2.31.1

