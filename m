Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97104BBD89
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiBRQbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:31:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiBRQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:31:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1701019DE8E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645201855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MlHUFHX+ZHcQFW+lyQMNcMO6c5EeDKK8SX4zE6inQZ8=;
        b=MS/QhgMLOo80EzVlFzryXt/Fhwtzx41Q//jk7cryhZaChcbvqhFiWiWZlYhWHhw6TSnYIi
        ameiv4QzcZ1BCmG3qdL5j5CrMXfwiXscWmBxmKoa+dfFGXoSKXIyP2ficeH1gKNSdrferb
        1hj5oBYTB/z2W8Cpe/Ik+/hjUJ4Nk0s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-LMwiVBZNN3W7RvvJmv-MRg-1; Fri, 18 Feb 2022 11:30:53 -0500
X-MC-Unique: LMwiVBZNN3W7RvvJmv-MRg-1
Received: by mail-qk1-f198.google.com with SMTP id u17-20020a05620a431100b004765c0dc33cso7800381qko.14
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MlHUFHX+ZHcQFW+lyQMNcMO6c5EeDKK8SX4zE6inQZ8=;
        b=7G+icJLvC9sXChLmtCqFYxMbwmasSzSOsxKuX4BsYT0Ei/txWVRJYQQjqkmS8fCy1n
         gZew99452yHiEh8T2iWwTQf2FJ95h/3ntnK984Fc0FL5qipAUrRXAHrIo8UFnOvLfHco
         snma0l64o0mNcGN3vKR7MsWaH7mOnRlbdUXgJ+2Q3PSwc6TN/yM0j1BruzrMeRzOQuVp
         Up7SEqEOUkNPWJk17rKrQ0nbQMFsNtt1K+y5+z0QQBp3Cpw0MdIOi6zkRLoVqwzRKzk5
         sDCX3ITSFE6cMP2N1rh/qF3atOIEZ2CDoFLmIpyN2B4+K5X6xq8tJwvgTE30s4F+DDKc
         tMDQ==
X-Gm-Message-State: AOAM533FwwPiRyZ1WbU/hTpPXKKlw7AI3i5trFlp9cvhRoaMjZjsBHWC
        BJwq6Uxggc4yAttxVx1Ce5GKGNZnXMNVJdWgtTeNcpk0SIEyHaHwLYveLvwB/JblZdhYc3Luh6i
        3RxjzXNnK2cG4Wl86FNmb0izR
X-Received: by 2002:a05:6214:2269:b0:42c:37d8:a1aa with SMTP id gs9-20020a056214226900b0042c37d8a1aamr6473773qvb.92.1645201853409;
        Fri, 18 Feb 2022 08:30:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4vFhU7HKS9yRqHe0sY1K1K2BAfoqEYhz5pP7+ki2kTzk8Y/F1C67XvLcFUXAjFfYcBr/Uhw==
X-Received: by 2002:a05:6214:2269:b0:42c:37d8:a1aa with SMTP id gs9-20020a056214226900b0042c37d8a1aamr6473751qvb.92.1645201853164;
        Fri, 18 Feb 2022 08:30:53 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id c2sm18024043qkp.0.2022.02.18.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 08:30:52 -0800 (PST)
From:   trix@redhat.com
To:     johannes@sipsolutions.net, davem@davemloft.net, kuba@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, cjhuang@codeaurora.org,
        briannorris@chromium.org, kuabhs@chromium.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nl80211: check return of nla_parse_nested
Date:   Fri, 18 Feb 2022 08:30:45 -0800
Message-Id: <20220218163045.3370662-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this representative problem
nl80211.c:15426:6: warning: Branch condition evaluates
  to a garbage value
  if (!tb[NL80211_SAR_ATTR_TYPE] ||
       ^~~~~~~~~~~~~~~~~~~~~~~~~~

tb is set when nla_parse_nested() is successful.
So check.

Fixes: 6bdb68cef7bf ("nl80211: add common API to configure SAR power limitations")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/wireless/nl80211.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7543c73a3f1d..c1532c8eb657 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15419,9 +15419,11 @@ static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NL80211_ATTR_SAR_SPEC])
 		return -EINVAL;
 
-	nla_parse_nested(tb, NL80211_SAR_ATTR_MAX,
-			 info->attrs[NL80211_ATTR_SAR_SPEC],
-			 NULL, NULL);
+	err = nla_parse_nested(tb, NL80211_SAR_ATTR_MAX,
+			       info->attrs[NL80211_ATTR_SAR_SPEC],
+			       NULL, NULL);
+	if (err)
+		return err;
 
 	if (!tb[NL80211_SAR_ATTR_TYPE] || !tb[NL80211_SAR_ATTR_SPECS])
 		return -EINVAL;
@@ -15444,8 +15446,10 @@ static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
 	sar_spec->type = type;
 	specs = 0;
 	nla_for_each_nested(spec_list, tb[NL80211_SAR_ATTR_SPECS], rem) {
-		nla_parse_nested(spec, NL80211_SAR_ATTR_SPECS_MAX,
-				 spec_list, NULL, NULL);
+		err = nla_parse_nested(spec, NL80211_SAR_ATTR_SPECS_MAX,
+				       spec_list, NULL, NULL);
+		if (err)
+			goto error;
 
 		switch (type) {
 		case NL80211_SAR_TYPE_POWER:
-- 
2.26.3

