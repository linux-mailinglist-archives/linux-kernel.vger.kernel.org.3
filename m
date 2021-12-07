Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A6B46B2E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhLGGdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbhLGGdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:33:14 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64187C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 22:29:44 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x131so12451798pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 22:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+udiqaZ67AekRJsfuEVb5uj3ROe2vP5ghr0oV195W0=;
        b=J/GkOY2JatD7FBAKkj7zo7qm0zu83gr3gssEcq7tECGOevoO4it7Y04ne6Pp3FnK0H
         zsGa0Q8F3qsvT6I4+YPKlNUfN4AUrxlPRJLNc4bitT7GsWdPgyBy5X6Nz9QXCwIMWniZ
         rEetwE3QNb+HZei31v9cbKSlBOd55Mtp6/JL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+udiqaZ67AekRJsfuEVb5uj3ROe2vP5ghr0oV195W0=;
        b=SsrlPPhb9tBaBSgDlZKf1NXRi+80eXbQJs39fpkBdY/0g5iRYaXDJWsSTXvrJShmse
         mdJjtI2njJ6fN6SInJ990owlSGn5XJEkC9aG5t5Ef0YiMlvYBcGqyuDzTjlp10iM+ZNb
         CtESqqeHVq6mtcIiMf5/w+X1rLgYcGbikYtg8gbG0gci0s7VaMc48p+0AHdpAZx5XU3S
         Aat5QxU9N4KhKSeil5l4R6ZT2BfLCVoONTUOVBLEgpRl//3rn+QpYhUTN3piEirTxNeK
         WNW8mpD/s30CSaLLp/KmMpNSpzi4dFjRHKV9GCOe8peIRfuvXt98kqKcCpvqA1kgNsDI
         CJeA==
X-Gm-Message-State: AOAM530gj29w1a0QkN1VJo4C3wRIKPHJU6/wrslb7XL2DP5Eq6qjyxml
        U+bvx2XTC6J4jLyidd6T2VveAQ==
X-Google-Smtp-Source: ABdhPJyZvwNoT4oSGFb3KwxVMh+6xEESFDRswigiC1MShWxc/lpwRffNVSSyabXgOqaqPo9je5cC7w==
X-Received: by 2002:aa7:9438:0:b0:4a2:c941:9ac4 with SMTP id y24-20020aa79438000000b004a2c9419ac4mr40707651pfo.12.1638858583943;
        Mon, 06 Dec 2021 22:29:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t13sm14347377pfl.98.2021.12.06.22.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 22:29:43 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ALSA: mixart: Reduce size of mixart_timer_notify
Date:   Mon,  6 Dec 2021 22:29:41 -0800
Message-Id: <20211207062941.2413679-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3108; h=from:subject; bh=Bxtg+Md4Tx2O3zfguW43xRX6QWLK3nr94r5jvTZ6XgY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhrv9VWCfHEI86ECNtov7rQKCtIX1smQa5Ihsv4FCj 5Fqfs7KJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYa7/VQAKCRCJcvTf3G3AJoAZD/ 9I4Bg7/tASi7/MTVYDZ2OFnqA7LGqGWzz6D1FZaf1OaIyQ7gz6QVCW+qLJQHpISRu7Z+vbvnEESekZ /qMW/R7pzdFdXaRWK2+XUIxBHgEo145KJOnnMI2qfmhsKgEWiThjnktZ53fZumZwQD/IylG4KOdrGO 1mu+8wuNxCLXj9wAZn3MoawwpPwZwkAkAx4PSK1hqmXFtW6p+bK8AmSdukZJkZE4J3Zpx5x/Zy4sHU he4eUP/OdqVsQ+DsznpT2xT6DFLHO3PrSDol+dKyzNoNKaDsWTmclO6fYG0zY7+EeYAxIBOVk6oWJ9 5XGK3CRaJU9LzoWiW27o1nRExmRCmWPO5dMpKTT62BxFzl+GsNljCaPCtyyFrQWSud8imTFzuuzz95 key5HrZkeMwpHeT6H5LxTDVkBjw0exV6ajR8MXsjxyOlXS5JAa1jc3yCZ07Sk7hNMarx+VVgLmIa5g aS9ZQJCLqg2u5qX07BddMQNGu2K6g6RjicdGWxlFNPjquU0B2wtq0/G7cswcx2PVycAui9Pv96hAuH c0DNtqpb5uH3d4ctWK0rOjK4Ba22wacYENz2WJkQcQnQGWMV0gfllH4QhMmntSXjyfXD9NR/53xKov m407NkStVJqCGCut2aywT/IyRhZmtPESfh94Kx8hkLX93rqdItGmwdip/QZg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mixart_timer_notify structure was larger than could be represented
by the mixart_msg_data array storage. Adjust the size to as large as
possible to fix the warning seen with -Warray-bounds builds:

sound/pci/mixart/mixart_core.c: In function 'snd_mixart_threaded_irq':
sound/pci/mixart/mixart_core.c:447:50: error: array subscript 'struct mixart_timer_notify[0]' is partly outside array bounds of 'u32[128]' {aka 'unsigned int[128]'} [-Werror=array-bounds]
  447 |                                 for(i=0; i<notify->stream_count; i++) {
      |                                                  ^~
sound/pci/mixart/mixart_core.c:328:12: note: while referencing 'mixart_msg_data'
  328 | static u32 mixart_msg_data[MSG_DEFAULT_SIZE / 4];
      |            ^~~~~~~~~~~~~~~

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/pci/mixart/mixart_core.c |  3 +--
 sound/pci/mixart/mixart_core.h | 10 +++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/pci/mixart/mixart_core.c b/sound/pci/mixart/mixart_core.c
index fb8895af0363..853083dd4bad 100644
--- a/sound/pci/mixart/mixart_core.c
+++ b/sound/pci/mixart/mixart_core.c
@@ -23,8 +23,6 @@
 #define MSG_DESCRIPTOR_SIZE         0x24
 #define MSG_HEADER_SIZE             (MSG_DESCRIPTOR_SIZE + 4)
 
-#define MSG_DEFAULT_SIZE            512
-
 #define MSG_TYPE_MASK               0x00000003    /* mask for following types */
 #define MSG_TYPE_NOTIFY             0             /* embedded -> driver (only notification, do not get_msg() !) */
 #define MSG_TYPE_COMMAND            1             /* driver <-> embedded (a command has no answer) */
@@ -444,6 +442,7 @@ irqreturn_t snd_mixart_threaded_irq(int irq, void *dev_id)
 				struct mixart_timer_notify *notify;
 				notify = (struct mixart_timer_notify *)mixart_msg_data;
 
+				BUILD_BUG_ON(sizeof(notify) > sizeof(mixart_msg_data));
 				for(i=0; i<notify->stream_count; i++) {
 
 					u32 buffer_id = notify->streams[i].buffer_id;
diff --git a/sound/pci/mixart/mixart_core.h b/sound/pci/mixart/mixart_core.h
index fbf4731a276d..2f0e29ed5d63 100644
--- a/sound/pci/mixart/mixart_core.h
+++ b/sound/pci/mixart/mixart_core.h
@@ -49,6 +49,7 @@ enum mixart_message_id {
 	MSG_CLOCK_SET_PROPERTIES             = 0x200002,
 };
 
+#define MSG_DEFAULT_SIZE            512
 
 struct mixart_msg
 {
@@ -251,10 +252,17 @@ struct mixart_sample_pos
 	u32   sample_pos_low_part;
 } __attribute__((packed));
 
+/*
+ * This structure is limited by the size of MSG_DEFAULT_SIZE. Instead of
+ * having MIXART_MAX_STREAM_PER_CARD * MIXART_MAX_CARDS many streams,
+ * this is capped to have a total size below MSG_DEFAULT_SIZE.
+ */
+#define MIXART_MAX_TIMER_NOTIFY_STREAMS				\
+	((MSG_DEFAULT_SIZE - sizeof(u32)) / sizeof(struct mixart_sample_pos))
 struct mixart_timer_notify
 {
 	u32                  stream_count;
-	struct mixart_sample_pos  streams[MIXART_MAX_STREAM_PER_CARD * MIXART_MAX_CARDS];
+	struct mixart_sample_pos  streams[MIXART_MAX_TIMER_NOTIFY_STREAMS];
 } __attribute__((packed));
 
 
-- 
2.30.2

