Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9525657B61A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbiGTMFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGTMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:05:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D4D6B74E;
        Wed, 20 Jul 2022 05:05:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a5so25787402wrx.12;
        Wed, 20 Jul 2022 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=wpY8Fn5dD5ki3izlk7rpyV14VYuNyQSG8TlGbXhx8No=;
        b=E1yjOeYEWLfJi/4H5c4TezE+AA1j/db/ERei6jUfneCjFxtZ5eq/tgZqAsg6lyTHy9
         NWKwPHBrkVSB/ow8jBMNCTJbW56JYv4iDWxyQJzkdZewQmKa+LJaeqIRydoy7CMll2A8
         +HfyVR+DmLsWNOXxst+zhPjZFg4/Tm2YBMxUtFHxmxn337we06kWQGhS6thzNCUs5Kgh
         tdqpRW2bLvRkO/kd8S4s4e60x2NFQ31n3XgjA1DAIPtas1GPAKRFZq7UfOQ1Eng0VDxf
         wmPGp/uRWx/s27Lib1fQb3mFlD00vprSrj2+JW0BjdJefZUlm0gXdONB1Xcu3hHqjFFa
         0pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wpY8Fn5dD5ki3izlk7rpyV14VYuNyQSG8TlGbXhx8No=;
        b=zJveaJOawcwgCBvQr7JHsof6n2uXgp2IKxQF5pWOpjo3qAcO6LgiKEM+Y1sitOH8mh
         fAZ9TFDXjfS/NIR5ERE4VBWXZzN/EkbXui4PYXkyZfjr9s7cEbfhvJaikWrvq+ZVz/xY
         cm/FpDzX5xtb8wmOFjuNrR1Xl/9skQP2MDw6p54aBZbr9J+VCLabYd5tkXfZhm/zEXn9
         CewKGfBLhu3sjWjoANziyvRQO15Zuh4bfTXTHyUVAbXmEYc9C70f7MkN/9NTkFFBJWtC
         mjCin1oS63a6SmKXwsX+gEvPR1z/fjn8CPULZkMyYsYA2AKceuqr1Hpig8jNjEso470N
         6qzw==
X-Gm-Message-State: AJIora/Q9/YvKqwypntVHQ3ozYhM3Pao5c53aQKV38e8/bsyXKZviL49
        cVjZ9eEJSwKz9QgsxYP7iYyGKSBrjuI=
X-Google-Smtp-Source: AGRyM1sWSLteQUScsqfZ5Bz9P7W9wCqZ6Bc9liATh6PJxssCgIl6il4d8JhIZC8unswcIy7qtIR40Q==
X-Received: by 2002:adf:fcca:0:b0:21d:68ff:2e5a with SMTP id f10-20020adffcca000000b0021d68ff2e5amr31936301wrs.453.1658318699075;
        Wed, 20 Jul 2022 05:04:59 -0700 (PDT)
Received: from felia.fritz.box (200116b826a11f008020c2fc6e115b3e.dip.versatel-1u1.de. [2001:16b8:26a1:1f00:8020:c2fc:6e11:5b3e])
        by smtp.gmail.com with ESMTPSA id n5-20020a1c2705000000b003a1980d55c4sm2177090wmn.47.2022.07.20.05.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 05:04:58 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] apparmor: correct config reference to intended one
Date:   Wed, 20 Jul 2022 14:04:43 +0200
Message-Id: <20220720120443.16518-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5bfcbd22ee4e ("apparmor: Enable tuning of policy paranoid load for
embedded systems") introduces the config SECURITY_APPARMOR_PARANOID_LOAD,
but then refers in the code to SECURITY_PARANOID_LOAD; note the missing
APPARMOR in the middle.

Correct this to the introduced and intended config option.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 090a20805664..e29cade7b662 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1402,7 +1402,7 @@ module_param_named(path_max, aa_g_path_max, aauint, S_IRUSR);
  * DEPRECATED: read only as strict checking of load is always done now
  * that none root users (user namespaces) can load policy.
  */
-bool aa_g_paranoid_load = IS_ENABLED(CONFIG_SECURITY_PARANOID_LOAD);
+bool aa_g_paranoid_load = IS_ENABLED(CONFIG_SECURITY_APPARMOR_PARANOID_LOAD);
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 static int param_get_aaintbool(char *buffer, const struct kernel_param *kp);
-- 
2.17.1

