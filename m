Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD757FFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiGYNKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiGYNKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:10:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4919665E4;
        Mon, 25 Jul 2022 06:10:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D98B11FADC;
        Mon, 25 Jul 2022 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658754626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=KX1pX+qxhjtmIbz/mv+FEb+97nfiqNjUtPVXNgyC9+k=;
        b=rUKxaZX0CHPTS50VFaCO+mGOMhsdNEtgp1vg5BxHKnKW2AOa+lz9H2pdCywO1hbdmx6a12
        RXcx0svD2XQLxceow51BjMeBWKi+WsEe7m4J14Omy/LBa3f6UCgztWlY7Wd0zsrhg3DYKt
        spMKmHdGfEXrJoj06P+/vb6fleLOEaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658754626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=KX1pX+qxhjtmIbz/mv+FEb+97nfiqNjUtPVXNgyC9+k=;
        b=8kOgZbPTQT3vpyhm8I40dvouQa6bVFortCiKzh6Qdk7sYywtd8pQZXxpDgniuZklq2fxu/
        Qypc2YvD108uEVCw==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id D24E82C152;
        Mon, 25 Jul 2022 13:10:26 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 56840444B2F; Mon, 25 Jul 2022 15:10:26 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [PATCH] rtla: fix double free
CC:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Yow:  Should I do my BOBBIE VINTON medley?
Date:   Mon, 25 Jul 2022 15:10:26 +0200
Message-ID: <mvmzggxl4n1.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't call trace_instance_destroy in trace_instance_init when it fails,
this is done by the caller.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 tools/tracing/rtla/src/trace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 5784c9f9e570..7c27fc2a52cb 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -179,7 +179,6 @@ int trace_instance_init(struct trace_instance *trace, char *tool_name)
 	return 0;
 
 out_err:
-	trace_instance_destroy(trace);
 	return 1;
 }
 
-- 
2.37.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
