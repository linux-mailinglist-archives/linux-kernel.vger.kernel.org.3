Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF34E4C8E51
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiCAOyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiCAOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:54:08 -0500
X-Greylist: delayed 508 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 06:53:25 PST
Received: from v-zimmta03.u-bordeaux.fr (v-zimmta03.u-bordeaux.fr [147.210.215.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9F24EA35
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:53:24 -0800 (PST)
Received: from v-zimmta03.u-bordeaux.fr (localhost [127.0.0.1])
        by v-zimmta03.u-bordeaux.fr (Postfix) with ESMTP id 140081800A87;
        Tue,  1 Mar 2022 15:44:54 +0100 (CET)
Received: from begin (nat-inria-interne-54-gw-02-bso.bordeaux.inria.fr [194.199.1.54])
        by v-zimmta03.u-bordeaux.fr (Postfix) with ESMTPSA id D81FB1800A80;
        Tue,  1 Mar 2022 15:44:53 +0100 (CET)
Received: from samy by begin with local (Exim 4.95)
        (envelope-from <samuel.thibault@labri.fr>)
        id 1nP3kD-00Bpvn-NJ;
        Tue, 01 Mar 2022 15:44:53 +0100
Date:   Tue, 1 Mar 2022 15:44:53 +0100
From:   Samuel Thibault <samuel.thibault@labri.fr>
To:     willemb@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] SO_ZEROCOPY should rather return -ENOPROTOOPT
Message-ID: <20220301144453.snstwdjy3kmpi4zf@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@labri.fr>,
        willemb@google.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ENOTSUPP is documented as "should never be seen by user programs", and
is not exposed in <errno.h>, so applications cannot safely check against
it. We should rather return the well-known -ENOPROTOOPT.

Signed-off-by: Samuel Thibault <samuel.thibault@labri.fr>

diff --git a/net/core/sock.c b/net/core/sock.c
index 4ff806d71921..6e5b84194d56 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1377,9 +1377,9 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 			if (!(sk_is_tcp(sk) ||
 			      (sk->sk_type == SOCK_DGRAM &&
 			       sk->sk_protocol == IPPROTO_UDP)))
-				ret = -ENOTSUPP;
+				ret = -ENOPROTOOPT;
 		} else if (sk->sk_family != PF_RDS) {
-			ret = -ENOTSUPP;
+			ret = -ENOPROTOOPT;
 		}
 		if (!ret) {
 			if (val < 0 || val > 1)
