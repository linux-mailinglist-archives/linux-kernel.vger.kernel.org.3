Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0946C5263D4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355530AbiEMOYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355218AbiEMOYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:24:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EE55047F;
        Fri, 13 May 2022 07:24:19 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x8so4222242pgr.4;
        Fri, 13 May 2022 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DSFVvtb25vaSMEJHnBVUCbV3FpLzvNN+SMPfTZx1ihA=;
        b=qp2pxaTyYctTFWdpw9JQdQ3QXnRJeCkCFg4wEMX0q9mrELp8Q3U2hFOfksh/v2G6wv
         L66zZ/6JenJwKeyBZn/ABvCbA4ej2zaBfz0H3eBuxdjpd7+F3B60Rf9j9MkH8Xjbxqty
         iwteSrHoYBgFuOR2x+p0JVGRrLt2aOnzaLRt8lNMgzOaRDRnvWlKBi29ys9x8r3Mgekh
         QBUfqpaZ6poYs3K6Shk41nqil7NRlYV2t0b5CpjIKAOf6hwTWTb0BTZVWAYTQukEFB7u
         o69keVEw3T6yXdtOZspZh4R05hxFVO8kL58fvMviqKGsFD/qFjJhDIf8+ikjO22KR61u
         e1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=DSFVvtb25vaSMEJHnBVUCbV3FpLzvNN+SMPfTZx1ihA=;
        b=vkJx9XJtokCFz3MTSsBACOGDOJOkL964N3XqqwqerhotNqAapkm6Azjv2pU3UfBTU8
         utL65RfEaWBxDNK2hrg5ZWeK9P9lIVGEJ/j4gFDct0PPFHtwsSQRQr3xiYhhmVb6ZHG8
         dcAGMr6CUn/OzrE99gYaLtyUjYdwnARV9OedyH1lbVUXt8uDcFPh29/BJHNSfoJ3FMK9
         bjoT1FCeAkGKOLcAPRT9yfJxRIBhDWnOUXsoUq8p9C4Ewa2sxzji1Y0nXsQR/3MWXbDQ
         XCj+WTr6O0DJWwjDDTTzY4STx4HaE5yfpem7BGUQW45Jubd+aY+NAhjTfSBpkLstEqaa
         gFnA==
X-Gm-Message-State: AOAM533dBdpMeCMUg++M0D9wWFBtPhEO//7XtdvDb8kOqrXYNv/IbQJv
        Z6bwoXibBkx7/Rj1mCEtVpQ=
X-Google-Smtp-Source: ABdhPJwkNv+XJvGA6KBWMfFKv4SevAuYmOvl9B58tgbnkLWWoNlY5QyFiEGBww3BZg8owQA4lxkLbQ==
X-Received: by 2002:a63:6c8a:0:b0:3ab:8c07:4d93 with SMTP id h132-20020a636c8a000000b003ab8c074d93mr4259567pgc.431.1652451858778;
        Fri, 13 May 2022 07:24:18 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id jj10-20020a170903048a00b0015e8d4eb2ccsm1684488plb.278.2022.05.13.07.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 07:24:18 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 0/2] can: drop tx skb if the device is in listen only mode
Date:   Fri, 13 May 2022 23:23:53 +0900
Message-Id: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In listen only mode, tx CAN frames can still reach the driver if
injected via the packet socket. This series add a check toward
CAN_CTRLMODE_LISTENONLY in can_dropped_invalid_skb() to discard such
skb. The first patch does some preparation work and migrates
can_dropped_invalid_skb() from skb.h to dev.h. The second and last
patch is the actual change.

Vincent Mailhol (2):
  can: move can_dropped_invalid_skb from skb.h to dev.h
  can: dev: drop tx skb if in listen only mode

 include/linux/can/dev.h | 35 +++++++++++++++++++++++++++++++++++
 include/linux/can/skb.h | 28 ----------------------------
 2 files changed, 35 insertions(+), 28 deletions(-)

-- 
2.35.1

