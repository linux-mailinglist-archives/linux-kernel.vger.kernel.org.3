Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CED5A1383
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbiHYOYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241339AbiHYOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:23:35 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0875FB6014;
        Thu, 25 Aug 2022 07:23:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 12so18037027pga.1;
        Thu, 25 Aug 2022 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=cVU0VI6SHUHssnCSIRaLHSdROjTj9L70izUE69+SVQI=;
        b=iyeuTXiHSUNy2JLfnzmnkGQBac1RWC4oduQxuaWC+q+SJbRjdpKqlX0/4EzSoBVRgb
         Q+0KkXZ35/EWiIxymYBc6rZ53bXyImV9j+UTHri6pA8gSyXS19kub5PnMoeRf/Ab5HoN
         8o4w3ilhynUVrB4sCn6Yo6PVAEGi7guxxZxA5Ws/ypvwkKOOY4NQJ1NYORW/G6zgeFAJ
         Tlv/bG9T/H0f6dL6YCW7LSX7n4ej9R8ZteyIhqbjVSvZr4VBpEO6+953FdIV/P5Gcr+i
         Q/7sqwCGhvojVOxXSIofPwZHurCDXFekWIATZC02M+p7i1zKzWh4IxjitDpGpYsOvlKj
         7kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=cVU0VI6SHUHssnCSIRaLHSdROjTj9L70izUE69+SVQI=;
        b=Y4a66fE6pdwGEvDn2qimzNX+scVuaeN4+xMS80tUAfCy+aHvWFzSvtBCtgOT9xs+s6
         cdDaYhyB01JgVvk2CgBUPddU/CC3DoBI3vWq/FszCz0vwHPjruDf/6UxeOnD/5mSqb/e
         hnb7MOQTpVrxrWht8O10cM8bYTtKmuHkjxm7FNCCvn8B/qTeIr4gvhd1VMcRKre5ZfLL
         aD0y9ekdixKP9GGcvOqb6AJljZ/1csfQ786bSa3Inv9nSPg7sg4LfeZg2qHGzPvE9XAN
         sR1f+A9zsOserQ9jo+37fQ4ooIcSgCxjvEx1E0S1Zl+FKGTOLzvqNwHHbuFAN7edjbpI
         JfJw==
X-Gm-Message-State: ACgBeo3C2RiTCILvNS36QEBlehKiatl+bPzt/4M6zmlyQtfRBwG+AASA
        GPjxvBXkHHHbkpt9czpLKHw=
X-Google-Smtp-Source: AA6agR47nAW/DbDYMnn/wzQQJNghFOEv8l4oZniUR/03+jNEV658GYe4pMs43MGah7jY4Rp48X4PSA==
X-Received: by 2002:a05:6a00:1402:b0:536:bf1c:3d16 with SMTP id l2-20020a056a00140200b00536bf1c3d16mr4516591pfu.20.1661437410518;
        Thu, 25 Aug 2022 07:23:30 -0700 (PDT)
Received: from linux-l9pv.suse (123-194-152-128.dynamic.kbronet.com.tw. [123.194.152.128])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b0016bb24f5d19sm14962803plh.209.2022.08.25.07.23.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:23:30 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Ben Boeckel <me@benboeckel.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Malte Gell <malte.gell@gmx.de>,
        Varad Gautam <varad.gautam@suse.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH v9,4/4] Documentation/admin-guide/module-signing.rst: add openssl command option example for CodeSign EKU
Date:   Thu, 25 Aug 2022 22:23:14 +0800
Message-Id: <20220825142314.8406-5-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20220825142314.8406-1-jlee@suse.com>
References: <20220825142314.8406-1-jlee@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an openssl command option example for generating CodeSign extended
key usage in X.509 when CONFIG_CHECK_CODESIGN_EKU is enabled.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 Documentation/admin-guide/module-signing.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index 7d7c7c8a545c..ca3b8f19466c 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -170,6 +170,12 @@ generate the public/private key files::
 	   -config x509.genkey -outform PEM -out kernel_key.pem \
 	   -keyout kernel_key.pem
 
+When ``CONFIG_CHECK_CODESIGN_EKU`` option is enabled, the following openssl
+command option should be added where for generating CodeSign extended key usage
+in X.509::
+
+        -addext "extendedKeyUsage=codeSigning"
+
 The full pathname for the resulting kernel_key.pem file can then be specified
 in the ``CONFIG_MODULE_SIG_KEY`` option, and the certificate and key therein will
 be used instead of an autogenerated keypair.
-- 
2.26.2

