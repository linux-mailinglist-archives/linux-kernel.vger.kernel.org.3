Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479EB563419
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiGANJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiGANJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:09:36 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33D26356
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:09:32 -0700 (PDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2DE740189
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1656680967;
        bh=bkTBuby+z+q404bznRm4C2WfjI3S1VMHAhTALnkOBrw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=jZPDxiEf9PzoKlYyMDuseon/xnKT1RVfyAkTKkokMn6csRfjkZP5GUKx6BbrGQAmK
         oTZcv2Fy4UhhRx4V640TDWy/w/UKICDI2xGCS0eL2SARiS/8FHBT7AiXo144urG0gl
         HVIc/SvN5PFcHj7R6w+uDPzFGIxjGK4HeGI0hnVH4cUgSKvfWPXq0kSSIqNRQB5A1J
         pjuVbeDx1DZyBETNfymJu7U/XOAFHbGzpb6fi9xQNSvl58E5+yLWe3/XtHjU5kcpow
         0gjHnSCTLTOkMYr8KmPSfCKtDEoRRjCQu7+0jFRI5fsZ4JcTBea5SbC5QuUxdwpxqL
         xzLewfr1M7CuA==
Received: by mail-pf1-f198.google.com with SMTP id v2-20020a622f02000000b0052573fc72f8so979063pfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 06:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkTBuby+z+q404bznRm4C2WfjI3S1VMHAhTALnkOBrw=;
        b=CZhX8na1hGaPaew2MNZ6kbLJym7BABjlMXwOHv8DkvFb6cNAjXKJxjMwLtX7OVKl42
         ZDMm9os+Yw+B3Ty8cq0jVwBwlXlRlZfY0R0VNWvsWckFQFKHIft9ajug+hmyQDizTKRM
         4db7sIf5bTnBq7OzI2Yd1TPa/C35FK6FitbxI+PNn9q3A+7zyd0RuieF1uXGTi9qoGNl
         amgZl5HAe++jdVqtfcOat0O6kc03HHgo0fi3VJHdG2xQgV3zofZk1sny21PxPTKENBVO
         cNOWeiO1U1KizJ18CS7mxjzHKWZ9qQRqMOEd7q1tDMTJ3mzXe81tZrB3x5YiwLtbScCP
         QaGA==
X-Gm-Message-State: AJIora/6UJmiv5ZTaZntNj9grLd0KeMbsDSp3djeO78uLL1XiV2Gr1ti
        a+8Ics6ys8cKiQ6UsovQgf8zxYfZGy6NVqQzzQGUbRXpFNBfdeCKzigt9ODUS90kdmIU5YbEK7e
        Xl6qrvr6/J7TTjhqkML89d1UzgTUWpJEgaaM4B7ZO
X-Received: by 2002:a17:903:2d1:b0:168:e83e:dab0 with SMTP id s17-20020a17090302d100b00168e83edab0mr19652285plk.118.1656680966122;
        Fri, 01 Jul 2022 06:09:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sk0jiTePAWb+BHjT9kQt6hrICWdaULs84xQJH0UNsIamjUk84RRFrRdeDhGYCeZRsrR4Hbww==
X-Received: by 2002:a17:903:2d1:b0:168:e83e:dab0 with SMTP id s17-20020a17090302d100b00168e83edab0mr19652265plk.118.1656680965890;
        Fri, 01 Jul 2022 06:09:25 -0700 (PDT)
Received: from localhost.localdomain (223-137-32-253.emome-ip.hinet.net. [223.137.32.253])
        by smtp.gmail.com with ESMTPSA id cp2-20020a170902e78200b0015e8d4eb1d7sm15489395plb.33.2022.07.01.06.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 06:09:25 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     memxor@gmail.com, linux-kernel@vger.kernel.org, ast@kernel.org,
        po-hsu.lin@canonical.com
Subject: [PATCH stable 5.15 0/1] Fix bpf selftest build failure - error: 'struct bpf_test' has no member named 'fixup_kfunc_btf_id'
Date:   Fri,  1 Jul 2022 21:08:57 +0800
Message-Id: <20220701130858.282569-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bpf selftest build will fail on the stable 5.15 tree with:

  CC       test_stub.o
  BINARY   test_verifier
In file included from /home/ubuntu/linux/tools/testing/selftests/bpf/verifier/tests.h:21,
                 from test_verifier.c:432:
/home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:124:10: error: 'struct bpf_test' has no member named 'fixup_kfunc_btf_id'
  124 |         .fixup_kfunc_btf_id = {
      |          ^~~~~~~~~~~~~~~~~~
/home/ubuntu/linux/tools/testing/selftests/bpf/verifier/calls.c:124:9: warning: braces around scalar initializer
  124 |         .fixup_kfunc_btf_id = {
      |         ^

This is because of the fixup_kfunc_btf_id member in struct bpf_test
added in commit 13c6a37d40 ("selftests/bpf: Add test for reg2btf_ids
out of bounds access") from upstream.

We will need commit 0201b80772 ("selftests/bpf: Add test_verifier
support to fixup kfunc call insns") from upstream to solve this build
issue. Some backport work is needed for the 5.15 tree to skip
fixup_map_timer related changes, which came from commit e60e6962c5
("selftests/bpf: Add tests for restricted helpers").

Kumar Kartikeya Dwivedi (1):
  selftests/bpf: Add test_verifier support to fixup kfunc call insns

 tools/testing/selftests/bpf/test_verifier.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
2.7.4

