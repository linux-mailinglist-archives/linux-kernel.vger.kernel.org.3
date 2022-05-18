Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A580D52B909
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiERLo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiERLoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:44:54 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670911796D9;
        Wed, 18 May 2022 04:44:52 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c22so1920685pgu.2;
        Wed, 18 May 2022 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e46I4qIXdzquI9xFD+cV1ACVVNgw+INdEKQ9QEnr4OI=;
        b=Nh0/Gtjh+a2IoDWF2IsH6LjJsbfFa2ls+RGo/YWXGFgUkeucd2niQ5WCVQPYpf7y/U
         Cmx7pTzDQ9PP7tNRsnHmU/9qAi3OmK/wmyx0mwTd43+fQjvAPKpQvyRobrqOUIpfYS0F
         BG2A7C0p12X4zCfzNvUX5A+eLouTQSkWu6dcUMwnQ2ue1CqLrYL2cG3libYJjprTw7Y1
         YW1N3/mdmXaPY+HtNABFX05KqegIBIotIqJyW45Y/6gv7g3Oi/bfNhZpark+UsHId/tA
         A5xAUzQaT2R2SzuL34L0HlW73CMoooDFXUTKbqr8g4DPAY7oQY8GzPPfXhe2JfYajuaH
         fytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=e46I4qIXdzquI9xFD+cV1ACVVNgw+INdEKQ9QEnr4OI=;
        b=50S2kJLIdjQLHDyfy9IG6aVH6+HX2GN+et8fyqsdwPhvVIdZJfUY4OhhPsBJCTgHbN
         KJ+xTFdN+q7wzDOJXlBpKfujEo+0ULwUDDUXPLUYn4/r0ufOzyOvJBdOqPOvJG2TfPeE
         R9RfkHand7w8do90ozUJfj25gpO/De3swDDrdZ+Vl/lQzlekLijPs9B3WFpO5/D4bCqf
         sKUF1I+LPCHD8/6FGETHNAXz3LoZlPMMa5tGYyc0aiLIWbx8iBtnAROgamROIrBTSAP8
         /e4wG81IWT65WH83dUPFiSc/aEhu5fR5QCRZcowoFbJ4e39F7yr7dW2gZMy5mpy2BFmG
         oe5g==
X-Gm-Message-State: AOAM530p3Hp+Xc0kwcl4b45Z8CTEiRajrMe+Wfwy79ILDI2gp8TyClhH
        e1TdwIbi3BzGoU6HQBo6f6k=
X-Google-Smtp-Source: ABdhPJzYBLHwICpNdU1uIc/fY0ueEsP71iwvxE76n7L9d8J1eiIBw//HBvohkbNgfUiutXbkZMTFNA==
X-Received: by 2002:a05:6a00:14cf:b0:510:5549:ad8a with SMTP id w15-20020a056a0014cf00b005105549ad8amr27233402pfu.24.1652874291646;
        Wed, 18 May 2022 04:44:51 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id 23-20020a631557000000b003db8691008esm1332158pgv.12.2022.05.18.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 04:44:51 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: mcp251xfd: silence clang's -Wunaligned-access warning
Date:   Wed, 18 May 2022 20:43:57 +0900
Message-Id: <20220518114357.55452-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518070517.q53bjzo6lbnq3f2i@pengutronix.de>
References: <20220518070517.q53bjzo6lbnq3f2i@pengutronix.de>
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

clang emits a -Wunaligned-access warning on union
mcp251xfd_tx_ojb_load_buf.

The reason is that field hw_tx_obj (not declared as packed) is being
packed right after a 16 bits field inside a packed struct:

| union mcp251xfd_tx_obj_load_buf {
| 	struct __packed {
| 		struct mcp251xfd_buf_cmd cmd;
| 		  /* ^ 16 bits fields */
| 		struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
| 		  /* ^ not declared as packed */
| 	} nocrc;
| 	struct __packed {
| 		struct mcp251xfd_buf_cmd_crc cmd;
| 		struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
| 		__be16 crc;
| 	} crc;
| } ____cacheline_aligned;

Starting from LLVM 14, having an unpacked struct nested in a packed
struct triggers a warning. c.f. [1].

This is a false positive because the field is always being accessed
with the relevant put_unaligned_*() function. Adding __packed to the
structure declaration silences the warning.

[1] https://github.com/llvm/llvm-project/issues/55520

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Actually, I do not have llvm 14 installed so I am not able to test
(this check was introduced in v14). But as explained in [1], adding
__packed should fix the warning.

Because this is a false positive, I did not add a Fixes tag, nor a
Reported-by: kernel test robot.
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 1d43bccc29bf..2b0309fedfac 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -441,7 +441,7 @@ struct mcp251xfd_hw_tef_obj {
 /* The tx_obj_raw version is used in spi async, i.e. without
  * regmap. We have to take care of endianness ourselves.
  */
-struct mcp251xfd_hw_tx_obj_raw {
+struct __packed mcp251xfd_hw_tx_obj_raw {
 	__le32 id;
 	__le32 flags;
 	u8 data[sizeof_field(struct canfd_frame, data)];
-- 
2.35.1

