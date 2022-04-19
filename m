Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8A45060D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbiDSASp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbiDSASM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:18:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A786513F7A;
        Mon, 18 Apr 2022 17:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 198E9B81144;
        Tue, 19 Apr 2022 00:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CCFC385C7;
        Tue, 19 Apr 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327327;
        bh=Z7Z+/eQ/03NPG8mWKEObyqFMOTj5dMlYTAeNOeALIjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqD0HhKa9Pblww39evtkphIAXQObNV3BBKZOw9aESctc7G3Ph7/yhXDIEaf0vwg3P
         aGExQUK1y/hGEtfc6AI1KIaN/te0dvqI1ZGRVIKgAFdZuOhbXKn4YCnh8UyS8MVv0E
         /qA+gEZ9cM47QlXnpDvuzvb7TmzuCWZgDEX6A9dksw6o5yy+pNzyFk2y0s46LC5ok1
         S6wVVhMkZp8yha6TSByMMSy5AU/8g/pTGl6FiqeQ1SMBAoVNMIP/jML4Wwl2c8muev
         GPq08sIS12yFNNz38XHV/giYWRiXEccOsW4ecevqqcDG3VsNn/rUpovoHyAhi8nV5D
         /3+dAADz1grEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D0B545C121E; Mon, 18 Apr 2022 17:15:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/12] scftorture: Remove extraneous "scf" from per_version_boot_params
Date:   Mon, 18 Apr 2022 17:15:21 -0700
Message-Id: <20220419001525.3950505-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an extraneous "scf" in the per_version_boot_params shell function
used by scftorture.  No harm done in that it is just passed as an argument
to the /init program in initrd, but this commit nevertheless removes it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/configs/scf/ver_functions.sh  | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh
index d3d9e35d3d55..2d949e58f5a5 100644
--- a/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh
@@ -25,6 +25,5 @@ per_version_boot_params () {
 	echo $1 `scftorture_param_onoff "$1" "$2"` \
 		scftorture.stat_interval=15 \
 		scftorture.shutdown_secs=$3 \
-		scftorture.verbose=1 \
-		scf
+		scftorture.verbose=1
 }
-- 
2.31.1.189.g2e36527f23

