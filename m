Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88E2515DEF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbiD3ODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbiD3OC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A57734131B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651327175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AYgeIia3HvIu7L71WHNoppZ1JjXVMeC0Eo6Cyw1F8QU=;
        b=dth36p/AoLbPyZLwqQfkrFXWdq2zj020M90MSNFWINsrtf1TlJRiADhnqTRkQf5Wzf26wB
        9n4CwvM5usxdCbRsNGxlDs0WQcSRkj05y49et79xGvvtaSnbkn39PYxkvRIStlr8DH8L3P
        46gJnuXBSIa6rNkllBiahi1mPyIJwjM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-HLeA0g9iNZmG1H7l9XNU9w-1; Sat, 30 Apr 2022 09:59:34 -0400
X-MC-Unique: HLeA0g9iNZmG1H7l9XNU9w-1
Received: by mail-qt1-f198.google.com with SMTP id x5-20020a05622a000500b002f37cb8b803so7565514qtw.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYgeIia3HvIu7L71WHNoppZ1JjXVMeC0Eo6Cyw1F8QU=;
        b=dpTT99QsUQbwVFzfTnu45NvEvfu0JUVpR7N8NHAUOYY1ZfwnCNeoeIsWPcNbqUS4c5
         cZ0Bn6rAWA8ZQRyMuNGleQSu1SidCR/9k5v7wTNjXAJWpoJYLoLYrw27uT7b2+HrzsV6
         RNWWSzZvub7LiAz35IrnKqSELZOEG/+IwfIrK+oFV1cZG11r0I0kGrVXfAyuLofGdJ2l
         MH2q8NzTgu6v/d+Yd8Y2+J84c39v7sB8JvkdpRQs2Gb/RcxHvlgf3TceEuDEwAjvqU1w
         W7QJb/I9OikdB6comW07WadegVZGNqn6Ci9fxxjgT4HT3TPZhbcceRBXaVn39kA3O0aw
         sS9g==
X-Gm-Message-State: AOAM532tz7XINGpnPQqo6LVzwIvusY51Yfrj9mfL0GvG7U14k3OzTiPF
        RHRbgt3xP0uUChhRzELUpKeCiwctJT2KNRoUqlGQRPD0OVP00auCJ81xlV7b/G1ehrHvxlbm+/V
        XFmMpc7GCk8UqZNakCZB52CpH
X-Received: by 2002:a05:620a:4310:b0:67e:8460:5a10 with SMTP id u16-20020a05620a431000b0067e84605a10mr2711796qko.636.1651327173703;
        Sat, 30 Apr 2022 06:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwel1nbYUpx75kvKYqPktcEIXOiZkT9zBcIFtMqASkqbyos8K4Eg31Wn+Eenxuxq7PU31u5AQ==
X-Received: by 2002:a05:620a:4310:b0:67e:8460:5a10 with SMTP id u16-20020a05620a431000b0067e84605a10mr2711793qko.636.1651327173485;
        Sat, 30 Apr 2022 06:59:33 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 133-20020a37088b000000b0069fc20ad38bsm1231516qki.127.2022.04.30.06.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:59:32 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     len.brown@intel.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] tools/power x86_energy_perf_policy: close opened file
Date:   Sat, 30 Apr 2022 09:59:25 -0400
Message-Id: <20220430135925.1657374-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cppcheck reports this issue
x86_energy_perf_policy.c:1244]: (error) Resource leak: fp

When a file is opened with fopen it should be closed with fclose.
So close it.

Fixes: 4beec1d75196 ("tools/power x86_energy_perf_policy: support HWP.EPP")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 5fd9e594079c..0ed9ae66236d 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1239,6 +1239,7 @@ unsigned int get_pkg_num(int cpu)
 
 	fp = fopen_or_die(pathname, "r");
 	retval = fscanf(fp, "%d\n", &pkg);
+	fclose(fp);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
 	return pkg;
-- 
2.27.0

