Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9A046FB40
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbhLJH33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:29:29 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:45548
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237181AbhLJH33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:29:29 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BD50B3F1AE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639121153;
        bh=76g9H+24WdaefKNkB80dgj1hR5XkeQFM1Oi8e8gaqLE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=RfFw4HbksWRmq6T0Z0A5zBMsjle+Wiw6jA1u2QdifklgBzmpg5BxTrq1QPcjI731/
         XJZ99GiSGNzHXj3n7hhu/drNPHsLauXFQ8kAJQoTg7iXSPimTwov6gbXVw57/JeRFU
         iNeBydvnodVUyelRAgL81ZsjA/t+eYmfgrqcrAyaBUngJ591apAVdlR5WHgIpX/T3Y
         Pj9G7eGpzwtBWN1MxIRh7yPVcSuNayGrWYdDtrkBv0Pw5YwHY6gXq4RHkcZJl84eje
         HWJeezO30NG7cacF3xnCAFmGUZ/JqmVRJYRva2DfnuCW2dOro+dFzI9naw8FGXNWEa
         u/UDwcEzrznyA==
Received: by mail-pg1-f197.google.com with SMTP id z8-20020a6553c8000000b00324e0d208d3so4768797pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 23:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76g9H+24WdaefKNkB80dgj1hR5XkeQFM1Oi8e8gaqLE=;
        b=GNmllm3pJ/kIVBnV/Vepm/f3Xt6CH+JLj6CPa/kEopBabBuX4LjoMd5rS4yns/wdQ4
         DYkq/dM7e3puXyuBo3tfOYUF6Hu0wtpyZYXonVmew9biZ0M5ZqFKOKQY+O4si7L6T8o7
         h0CxT1MITZYQhXluZeSAzx1VGrmGtXWTfsm2IpmAoa2iRFmz1nZJDafP9IyVLrnkJYGa
         7vg99a1nMo+H8O3/fgdUPTle//60I/JRjN2GCnxTwhqdJh9zU7xTL6Vk45crmoBgyJtw
         5n2fQCybJXNKMPSrsC/tHAyWjHW89WOai7xWaEf1T+EIKadZD3miD4oiST/4I51p3IWP
         2vQg==
X-Gm-Message-State: AOAM530V0eY87/mOEuyTyitT4eyviiL4zTcGoI0/dpdaE6nX0DzMpcAE
        X0l4SRmtpA+A0bD0vCDZvKEWdftJfC1cfg9Xmw7VnI0b/fcyWadgTJRW5QY8GHifgXX0iNiC1ZK
        rXhbILqolmBOCJzq7oJTGWyhgkx8weGXpDsfFxbWV
X-Received: by 2002:a17:903:2352:b0:142:76bc:de3b with SMTP id c18-20020a170903235200b0014276bcde3bmr73296465plh.36.1639121152133;
        Thu, 09 Dec 2021 23:25:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzetkN44F8aKYW+okI7AjCcEBNigejRUZfb7v/OkzJmGpRM+L3VZl6OPtHP4nhDAV6iLWfvg==
X-Received: by 2002:a17:903:2352:b0:142:76bc:de3b with SMTP id c18-20020a170903235200b0014276bcde3bmr73296438plh.36.1639121151849;
        Thu, 09 Dec 2021 23:25:51 -0800 (PST)
Received: from localhost.localdomain (2001-b011-2014-bac3-aa4d-91f5-d678-c6c2.dynamic-ip6.hinet.net. [2001:b011:2014:bac3:aa4d:91f5:d678:c6c2])
        by smtp.gmail.com with ESMTPSA id c2sm2035762pfv.112.2021.12.09.23.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 23:25:50 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     po-hsu.lin@canonical.com, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, skhan@linuxfoundation.org,
        andrea.righi@canonical.com, dsahern@kernel.org
Subject: [PATCHv2] selftests: icmp_redirect: pass xfail=0 to log_test()
Date:   Fri, 10 Dec 2021 15:25:23 +0800
Message-Id: <20211210072523.38886-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If any sub-test in this icmp_redirect.sh is failing but not expected
to fail. The script will complain:
    ./icmp_redirect.sh: line 72: [: 1: unary operator expected

This is because when the sub-test is not expected to fail, we won't
pass any value for the xfail local variable in log_test() and thus
it's empty. Fix this by passing 0 as the 4th variable to log_test()
for non-xfail cases.

v2: added fixes tag

Fixes: 0a36a75c6818 ("selftests: icmp_redirect: support expected failures")
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/icmp_redirect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/icmp_redirect.sh b/tools/testing/selftests/net/icmp_redirect.sh
index ecbf57f..7b9d6e3 100755
--- a/tools/testing/selftests/net/icmp_redirect.sh
+++ b/tools/testing/selftests/net/icmp_redirect.sh
@@ -311,7 +311,7 @@ check_exception()
 		ip -netns h1 ro get ${H1_VRF_ARG} ${H2_N2_IP} | \
 		grep -E -v 'mtu|redirected' | grep -q "cache"
 	fi
-	log_test $? 0 "IPv4: ${desc}"
+	log_test $? 0 "IPv4: ${desc}" 0
 
 	# No PMTU info for test "redirect" and "mtu exception plus redirect"
 	if [ "$with_redirect" = "yes" ] && [ "$desc" != "redirect exception plus mtu" ]; then
-- 
2.7.4

