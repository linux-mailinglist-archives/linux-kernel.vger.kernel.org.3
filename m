Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753F64F1145
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbiDDIuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240841AbiDDItl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AC930F64;
        Mon,  4 Apr 2022 01:47:44 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id l129so7790009pga.3;
        Mon, 04 Apr 2022 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iezfqCSLi9aeu9geiwLSpu2ZGrh8RQtJ4hILxdTJPow=;
        b=YtZhxs5DRluKygjqYGKUkZHGilAsQaQg+/Yh6XhjAIHye3WtPxHz6OVtRzlCw0j2AJ
         EPD/kRpfj7N4WP1druCEOIr8C5js8jI6h5uIGtsqhj7buJS4KE40uEjZs0uyq4MaPLPc
         9Lp98IVFB6Sb0PT23Jjm+wQszcBoOuzxaiMyu9RB53sgu2pNXBIiuXzZKnM9fq+5R+T7
         CznVXqTEM79IapOa7jfCD0H8pp5iZxKudOhjJKTYMLZTGFFZFvQXZh3FeaynGy6j2y4Q
         RynB/Fbids5KUpCXdFnFQ3HFRGKwf/jBvP59VoEBkmYQ4X1mWi/TCs8/cHjtzlLg9qjd
         ekCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iezfqCSLi9aeu9geiwLSpu2ZGrh8RQtJ4hILxdTJPow=;
        b=uut79MlEpOHwSFHsGjZsEmYQUeqROGVMMuGFRA6sLyCzCD3gKH4L+zDwcroQGrzi4M
         9sXSeD14S69yFEvx3Jr/AloSq6jZ5p6q9SGkuXl+k9dGu5ENC1t5bMOe6kJ13OoXVbQ8
         Rkyweni4qOY1dLyrEOU4A9YsbIgN07ef40R1/sOUnJvFwv6iFq5Y3Y7ia8cMfVSAPLXm
         pNtQIyDa+/MwwVCCFZZsfKRxpgV22O2zYKK4nJdnd3LCreAn53iK9CgZN/wqUm4TSYPu
         w5c2TiyMTguT8TA8yV9ZCFwkRTX2Qe41nNarIqhnbWd73mtHvaERmxpC5pHK/9yOoKoq
         qOAQ==
X-Gm-Message-State: AOAM533/wL+V2P5x0s/bgwLyZ7YSr0aPCfmHLXoAQNYJGTg+w3XFYBWg
        yVU8wZ58ZWHS5A3ADt4DSn22ocSw8Itgw6f1Ew==
X-Google-Smtp-Source: ABdhPJxIscq7kv48PLNHhvQHl4s43/rPzURDjQM7KlkXxVudjUh0+KERzVFVcUn4q3vRY9v3WKhDlA==
X-Received: by 2002:a05:6a00:4007:b0:4fa:9505:8ac0 with SMTP id by7-20020a056a00400700b004fa95058ac0mr22981759pfb.67.1649062063779;
        Mon, 04 Apr 2022 01:47:43 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001ca88b0bdfesm3991960pjm.13.2022.04.04.01.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:47:43 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 0/7] Fix divide errors in fbdev drivers
Date:   Mon,  4 Apr 2022 16:47:16 +0800
Message-Id: <20220404084723.79089-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of these framebuffer drivers checks for 'pixclock', leading to many
divide errors, which we fix by checking the value of 'pixclock' in
*_check_var(). As discussed before, it is better to keep the check per
driver rather than in the caller.

https://lore.kernel.org/all/YPgbHMtLQqb1kP0l@ravnborg.org/

Zheyu Ma (7):
  video: fbdev: i740fb: Error out if 'pixclock' equals zero
  video: fbdev: neofb: Fix the check of 'var->pixclock'
  video: fbdev: kyro: Error out if 'lineclock' equals zero
  video: fbdev: vt8623fb: Error out if 'pixclock' equals zero
  video: fbdev: tridentfb: Error out if 'pixclock' equals zero
  video: fbdev: arkfb: Error out if 'pixclock' equals zero
  video: fbdev: s3fb: Error out if 'pixclock' equals zero

 drivers/video/fbdev/arkfb.c      | 3 +++
 drivers/video/fbdev/i740fb.c     | 3 +++
 drivers/video/fbdev/kyro/fbdev.c | 2 ++
 drivers/video/fbdev/neofb.c      | 2 +-
 drivers/video/fbdev/s3fb.c       | 3 +++
 drivers/video/fbdev/tridentfb.c  | 3 +++
 drivers/video/fbdev/vt8623fb.c   | 3 +++
 7 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.25.1

