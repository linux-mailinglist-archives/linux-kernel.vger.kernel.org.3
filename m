Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163BB5650E8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiGDJan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiGDJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:30:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AE8BC99
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:30:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22C34B80E40
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1DFC341CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656926998;
        bh=ttUMoQ9vsj3uPDjki4S7OdzKytKhjR9X0UfCMNXPw9s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UaIl6oLM1DGJ5Uymo8xiIYY9+hCqgT23E+9mnWqY5ecTF41eGP245FK8X9iSNKxsd
         2gmhqEQFtCe8OW9LMWuWUc38HSrv1ZZwoOcgAUoMdN/RD4L1AF9r+75LxA/FZxxnt2
         2ucpPNbzIQH8xReFeUs/1gUdj3XOPzsF8rdlOZdvdP97OnDUur3LjNduaxqLGbO9h9
         Y+qFAfiyuDCNQJmZIpzaQ9z8S9pLiVirAEsuUfifjS0zt3CBvjxknA4xKogJpiLkyi
         W1++VlkwuQmH7JcRgHjSqglaJL5wpS5ewy+BaBh6sdFevsVuJBL8RngNBHMf4dx7Xs
         Nq9QWwt7YDrZg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] habanalabs: don't declare tmp twice in same function
Date:   Mon,  4 Jul 2022 12:29:39 +0300
Message-Id: <20220704092941.2237683-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704092941.2237683-1-ogabbay@kernel.org>
References: <20220704092941.2237683-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tmp is declared in the scope of the function cs_do_release() and
inside a block inside that function.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index eb5f1aee15fc..941f1ff190ae 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -718,9 +718,9 @@ static void cs_do_release(struct kref *ref)
 		 * staged submission
 		 */
 		if (cs->staged_last) {
-			struct hl_cs *staged_cs, *tmp;
+			struct hl_cs *staged_cs, *tmp_cs;
 
-			list_for_each_entry_safe(staged_cs, tmp,
+			list_for_each_entry_safe(staged_cs, tmp_cs,
 					&cs->staged_cs_node, staged_cs_node)
 				staged_cs_put(hdev, staged_cs);
 		}
-- 
2.25.1

