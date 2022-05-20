Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A652F125
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351919AbiETQzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351824AbiETQzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:55:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEFF994FE
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:55:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w17-20020a17090a529100b001db302efed6so8334667pjh.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HImf2kaCG91lzQHnr8MRW3BphKAYkvqBRRs5ES2/Au0=;
        b=chMw8BbdMENO44Ex7To5iiOLh8gVzvLkcdwXIkjZhtLgjDmcw6bvH3pKV81xXyD1RT
         jaO2BDd6Ba12cdcRMcQWeQ3eTZhPw5pkToFSdosBNAEAA3xd7hoJfdOKEysEHf/EH7Gx
         PCTLhPtYCs/oxN3hQZ5CVWyNtXZRzsmr/2/UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HImf2kaCG91lzQHnr8MRW3BphKAYkvqBRRs5ES2/Au0=;
        b=0HRNvYhg0VqJAEA4aSCP6t6mZd6Oo+PKbPGoWUiTbiKV0AK8BBdMEhRuASfDRPby27
         C7gxANgSnlISTMGQWlp394QAJqK51aUJfLKQ3V2FkgJmbx9y2yKYJKibqGzD7x2SmXb2
         QXw/IDmp2hIIQiPBr7kBvBmXcKAwt5ISPrOi7CuEEldL7c41HUItRif/KnzLTIorD1Rs
         hfKbsTD8kYMVWZv7nvicXWtjVmd542qERaT7hyV1LC3s/aX2vi+RC4FX0IMFs2/Zg1p7
         W8bsnknVzJTWUa4HhC0/gEkkVI/k7s7H/XjU1YLOcWJFmwJgKQ7lSZNtNmCTMZsB7NFz
         9cBg==
X-Gm-Message-State: AOAM531s5YwXJJU6fMvDmNyYvvJ+i5ED5qSpLN3Mm87j2psUiAU3kMvP
        evvhnl1w8PrVQhSCgkaCTXBfzw==
X-Google-Smtp-Source: ABdhPJyPX/wiqqe3vp3/13uQvnlQZbUyGzIpvrkBOpe/APiP2oAzWvzYFRxJefLrl44crd3enNc2Lw==
X-Received: by 2002:a17:90b:4b83:b0:1df:6862:fa9d with SMTP id lr3-20020a17090b4b8300b001df6862fa9dmr12702530pjb.32.1653065741654;
        Fri, 20 May 2022 09:55:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bw1-20020a17090af60100b001dc37aef4ffsm2080789pjb.48.2022.05.20.09.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:55:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ALSA: lola: Bounds check loop iterator against streams array size
Date:   Fri, 20 May 2022 09:55:37 -0700
Message-Id: <20220520165537.2139826-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1649; h=from:subject; bh=gr574qUgcbq3MCtPgynzNKObQz8m2bTmWuCGKzHJ8oE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBih8gIIXIPk/P0F6PPAXfjj2YPCN4RrUGeVlJhNe5p dtIzbUCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYofICAAKCRCJcvTf3G3AJmiTD/ wLZy4PXZmSaQfadLpeAOF1dQZVsrfP59bq6c3hU+T8kHRdZW3c7TalWO8SX+bZ//+7SVTcdJ3UJR4U 5yQufY2Hu5aZ3SzEZieTedw2HeRQjSksM6BY86lsk7nCMQHsz1bv8ju2mh5JfscBmPxV8bCob83Wwc C3b38caQpgXXyLfO+4JnhaEdR/g+uSOpjCrr5pg2ibM3Yi+Ks51nX9fCaSnoDSJNVMv0ohoKHAYufC 6Vy4KR5vmxqVQ04jKa6PvDUR6UWAMvY0HKqln8l4KCKO8Hk06Ehrr7JRssAxU08EXO1rdscVF2pNrX bko77kiex8R3J9GV2TvBRQDTc/ddYj+4wHdETAY/8Hd9S2lTQL6Iq+fgpLIPbas35gzm3xnpbBsdaO 9j7QdWUXkSV85wipNjvYUpG2gQbi5cxtPr1CL4ejvZPUZs9L5TDQynWjmB2W6o29Ez8y08iCxy7Idv RcJhkyvvKw3vmG6ICncm8U2+yYyDIUywrft0CWriC3QZU9k90wdCdG310wVJEdfslQbXf8UgG3Hdbg quCgwW81cCh+SUGBw3NLNcOGx7VGJiQxvUMy9zKjVf4yuYbTSFpBNyhlLJM64JPCqxjTPw3iEIJ+Fx 37ZyhnaW3/JAHRauPrgsKEEXoGT+jBZuCVfVRqe4eAn8MomlRYNQkFyb//NA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 12 sees that it's technically possible for num_streams to be larger
than ARRAY_SIZE(pcm->streams). Bounds-check the iterator.

../sound/pci/lola/lola_pcm.c: In function 'lola_pcm_update':
../sound/pci/lola/lola_pcm.c:567:64: warning: array subscript [0, 31] is outside array bounds of 'struct lola_stream[16]' [-Warray-bounds]
  567 |                         struct lola_stream *str = &pcm->streams[i];
      |                                                    ~~~~~~~~~~~~^~~
In file included from ../sound/pci/lola/lola_pcm.c:15:
../sound/pci/lola/lola.h:307:28: note: while referencing 'streams'
  307 |         struct lola_stream streams[MAX_STREAM_COUNT];
      |                            ^~~~~~~

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/pci/lola/lola_pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/lola/lola_pcm.c b/sound/pci/lola/lola_pcm.c
index 738ec987000a..32193fae978d 100644
--- a/sound/pci/lola/lola_pcm.c
+++ b/sound/pci/lola/lola_pcm.c
@@ -561,8 +561,9 @@ static snd_pcm_uframes_t lola_pcm_pointer(struct snd_pcm_substream *substream)
 void lola_pcm_update(struct lola *chip, struct lola_pcm *pcm, unsigned int bits)
 {
 	int i;
+	u8 num_streams = min_t(u8, pcm->num_streams, ARRAY_SIZE(pcm->streams));
 
-	for (i = 0; bits && i < pcm->num_streams; i++) {
+	for (i = 0; bits && i < num_streams; i++) {
 		if (bits & (1 << i)) {
 			struct lola_stream *str = &pcm->streams[i];
 			if (str->substream && str->running)
-- 
2.32.0

