Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F91E478C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbhLQNqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbhLQNqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:46:19 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3689C061401
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 05:46:18 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p36-20020a05600c1da400b003457428ec78so2924959wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 05:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mdKVRQTB+ygcPjQqeQ7Uxm2NcgP8laoI/9TsYcZNS9w=;
        b=DUW+cyeDI6wHrdi4GMphNgO5DojVLDkHGvh4gFYbTV0tmGsOxum2QHDdHIS9vZjxHv
         4ZrzDyQF/q9E90+mXRuT6UP4BTLE0zn8Vc4E7BMgD2MCILZx6cWazOT8KSbnh1uKyh78
         wr70yhlsyD7OcKFReS1nEXBLEDeZFhOq/nV5BwIlqu9476RfPsBtIGZ1CCmgDvAIDrco
         IbxAFy/myCRdg5TcWz2hIrN55yOCisyE2JmOZ/22svz5ZnSAVcDo5gc8I+ApRTv8oL8t
         Gpm6Amm0UGsK6JbP51pni+cv0V/UpeC0xypsPVjU3WTPlUsTKPdyeSoSe3NS/wa98fGs
         WNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mdKVRQTB+ygcPjQqeQ7Uxm2NcgP8laoI/9TsYcZNS9w=;
        b=b3zaYYX6EcbY7f9hL9jJIts1BBSexH4qN0IK3FGSpUZ/TBnQNAp/f8bzS3VSqay/40
         7S8BAxsF2ZpUQIXKK1qqiFcMtSaVHK75FKy+8UwDoksFxahaE16s579lC13wEbYzNm9A
         ZxLfJfTbPpFzuFEcZsY470I6wADKTrXQaJMA/3vFmm7fqCdImWehzSmvbTLWKBQG/adR
         xCLr0peSC4p4WqG4lSc1TzCN1phgZkMyGfDaKxUN3A4eP1Kc4GCG2AQnyq/aTsflJ8qV
         5YBKhWEMWp9ZhpE0BPzJK0+BxjDGWho6oroeckYt2XSCTFQmrwAfl5V+dJuQjcYWuAs+
         ya8A==
X-Gm-Message-State: AOAM531w2D7HeUFmtIf/plixNpLrFiGJD2fL6Wgu4tKVDPpTpyipIRmo
        LBep09xJyPe0SSpDjruUrpc3vQ==
X-Google-Smtp-Source: ABdhPJxPABnhfoXnPdWLJk3MEqNDzo8El3vuW8EAIjvwdW+3eOgGsQc/P/OmQDfwN98DkfwHNYmEkA==
X-Received: by 2002:a05:600c:3b8f:: with SMTP id n15mr9811764wms.180.1639748777246;
        Fri, 17 Dec 2021 05:46:17 -0800 (PST)
Received: from localhost.localdomain ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id a22sm7106009wme.19.2021.12.17.05.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 05:46:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        lksctp developers <linux-sctp@vger.kernel.org>,
        "H.P. Yarroll" <piggy@acm.org>,
        Karl Knutson <karl@athena.chicago.il.us>,
        Jon Grimm <jgrimm@us.ibm.com>,
        Xingang Guo <xingang.guo@intel.com>,
        Hui Huang <hui.huang@nokia.com>,
        Sridhar Samudrala <sri@us.ibm.com>,
        Daisy Chang <daisyc@us.ibm.com>,
        Ryan Layer <rmlayer@us.ibm.com>,
        Kevin Gao <kevin.gao@intel.com>, netdev@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] sctp: export sctp_endpoint_{hold,put}() and return incremented endpoint
Date:   Fri, 17 Dec 2021 13:46:06 +0000
Message-Id: <20211217134607.74983-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

net/sctp/diag.c for instance is built into its own separate module
(sctp_diag.ko) and requires the use of sctp_endpoint_{hold,put}() in
order to prevent a recently found use-after-free issue.

In order to prevent data corruption of the pointer used to take a
reference on a specific endpoint, between the time of calling
sctp_endpoint_hold() and it returning, the API now returns a pointer
to the exact endpoint that was incremented.

For example, in sctp_sock_dump(), we could have the following hunk:

	sctp_endpoint_hold(tsp->asoc->ep);
	ep = tsp->asoc->ep;
	sk = ep->base.sk
	lock_sock(ep->base.sk);

It is possible for this task to be swapped out immediately following
the call into sctp_endpoint_hold() that would change the address of
tsp->asoc->ep to point to a completely different endpoint.  This means
a reference could be taken to the old endpoint and the new one would
be processed without a reference taken, moreover the new endpoint
could then be freed whilst still processing as a result, causing a
use-after-free.

If we return the exact pointer that was held, we ensure this task
processes only the endpoint we have taken a reference to.  The
resultant hunk now looks like this:

        ep = sctp_endpoint_hold(tsp->asoc->ep);
	sk = ep->base.sk
	lock_sock(sk);

Cc: Vlad Yasevich <vyasevich@gmail.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: lksctp developers <linux-sctp@vger.kernel.org>
Cc: "H.P. Yarroll" <piggy@acm.org>
Cc: Karl Knutson <karl@athena.chicago.il.us>
Cc: Jon Grimm <jgrimm@us.ibm.com>
Cc: Xingang Guo <xingang.guo@intel.com>
Cc: Hui Huang <hui.huang@nokia.com>
Cc: Sridhar Samudrala <sri@us.ibm.com>
Cc: Daisy Chang <daisyc@us.ibm.com>
Cc: Ryan Layer <rmlayer@us.ibm.com>
Cc: Kevin Gao <kevin.gao@intel.com>
Cc: linux-sctp@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 8f840e47f190c ("sctp: add the sctp_diag.c file")
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/net/sctp/structs.h | 2 +-
 net/sctp/endpointola.c     | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 651bba654d77d..78d71ca56452b 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -1380,7 +1380,7 @@ static inline struct sctp_endpoint *sctp_ep(struct sctp_ep_common *base)
 struct sctp_endpoint *sctp_endpoint_new(struct sock *, gfp_t);
 void sctp_endpoint_free(struct sctp_endpoint *);
 void sctp_endpoint_put(struct sctp_endpoint *);
-void sctp_endpoint_hold(struct sctp_endpoint *);
+struct sctp_endpoint *sctp_endpoint_hold(struct sctp_endpoint *);
 void sctp_endpoint_add_asoc(struct sctp_endpoint *, struct sctp_association *);
 struct sctp_association *sctp_endpoint_lookup_assoc(
 	const struct sctp_endpoint *ep,
diff --git a/net/sctp/endpointola.c b/net/sctp/endpointola.c
index 48c9c2c7602f7..bdbf74fc7eb4c 100644
--- a/net/sctp/endpointola.c
+++ b/net/sctp/endpointola.c
@@ -222,10 +222,12 @@ static void sctp_endpoint_destroy(struct sctp_endpoint *ep)
 }
 
 /* Hold a reference to an endpoint. */
-void sctp_endpoint_hold(struct sctp_endpoint *ep)
+struct sctp_endpoint *sctp_endpoint_hold(struct sctp_endpoint *ep)
 {
 	refcount_inc(&ep->base.refcnt);
+	return ep;
 }
+EXPORT_SYMBOL_GPL(sctp_endpoint_hold);
 
 /* Release a reference to an endpoint and clean up if there are
  * no more references.
@@ -235,6 +237,7 @@ void sctp_endpoint_put(struct sctp_endpoint *ep)
 	if (refcount_dec_and_test(&ep->base.refcnt))
 		sctp_endpoint_destroy(ep);
 }
+EXPORT_SYMBOL_GPL(sctp_endpoint_put);
 
 /* Is this the endpoint we are looking for?  */
 struct sctp_endpoint *sctp_endpoint_is_match(struct sctp_endpoint *ep,
-- 
2.34.1.173.g76aa8bc2d0-goog

