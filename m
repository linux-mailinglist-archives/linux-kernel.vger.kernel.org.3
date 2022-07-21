Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF0C57D357
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiGUSeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiGUSdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84D668CC83
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658428428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HJB4awZMcHCUKT/brNSroFnUPIWlUAvdMcDbLhHOPQQ=;
        b=K3tn3pCVNX9XpIgDKrUBdrcxPuCpOfPz3TWbVvpI3kBHJykmLsQYB4mXhuZkF8auBJx6JD
        8Tcis9swU86EWYkFyOGncejbY9Aq8HIwOBdlKvA5snCvjFjd5H7JyE9NtShd6BEeu2iROk
        wGBnNPvkxrlNoMu1S/YQNOiHjHAVxZk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-HFgLW8ipPhSMEqo5l3nvzg-1; Thu, 21 Jul 2022 14:33:41 -0400
X-MC-Unique: HFgLW8ipPhSMEqo5l3nvzg-1
Received: by mail-qk1-f197.google.com with SMTP id s9-20020a05620a254900b006b54dd4d6deso1930048qko.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJB4awZMcHCUKT/brNSroFnUPIWlUAvdMcDbLhHOPQQ=;
        b=5QcKhQQIHgJOXsAJo4M/VIFc1ZE+sx/5jA089CK2LdCQcYdlqlkDdDQBusWWMVKzUK
         BI1rgY2imPhH/+j+SBmApZpNZNmG+P/w8p/zZKSP2ejlUz7zZjMRtq9IEnFuciFvaLAw
         8ui3tMNptDllinwCeCMMBnz+yQLBatI6+T7bMjsOBk+10Dx5b5PMEycxpv8SBIE1W1vz
         CGIYDN3rGQ+pM+e56oUsCT3lXZ9ZKpSd8zymglknr6oXH1MjhkNUsuq3RplecEykkf85
         X28HryD7gXj0cWDHDcxH3GE1assKeRG1uQYWb+B97+fmqOHtq5on3X0/L5CbemjOKyD+
         Bz5w==
X-Gm-Message-State: AJIora+pbrR+DOUaPiUjxa6myF2XVs0zYSiV0CPz9NWaKKESW5nMaoCM
        IJmK4drO/7T/IIizrDskrHOKQbk9x+gZO2lSRR8dTiCL06MHE4QBvaf+L9y1fux4ogpryxk16HR
        MvVi1tLme1vzvYo8zpkjwBC9yFIPp+4gscf+yMyTKg/VQEfz42iMaR7gIDnGHeFYrzJxZAGYcCQ
        ==
X-Received: by 2002:a05:620a:2556:b0:6a7:9f07:602 with SMTP id s22-20020a05620a255600b006a79f070602mr28249687qko.207.1658428420916;
        Thu, 21 Jul 2022 11:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t+xOHzxLKS6RXNOCj6oemogjHOTFszZibiB4umcqn73ukKiPEyCMActk/gwgysEap2Ss5eIg==
X-Received: by 2002:a05:620a:2556:b0:6a7:9f07:602 with SMTP id s22-20020a05620a255600b006a79f070602mr28249669qko.207.1658428420648;
        Thu, 21 Jul 2022 11:33:40 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id bj9-20020a05620a190900b006a6a7b4e7besm1878519qkb.109.2022.07.21.11.33.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Jul 2022 11:33:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v3 0/3] mm/mprotect: Fix soft-dirty checks
Date:   Thu, 21 Jul 2022 14:33:35 -0400
Message-Id: <20220721183338.27871-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: https://lore.kernel.org/lkml/20220720220324.88538-1-peterx@redhat.com/

Patch 1 is the previous patch and real fix.  Two more test patches added to
add mprotect test to soft-dirty.c, meanwhile add soft-dirty test into the
vm test loop.

Please review, thanks.

Peter Xu (3):
  mm/mprotect: Fix soft-dirty check in can_change_pte_writable()
  selftests: soft-dirty: Add test for mprotect
  selftests: Add soft-dirty into run_vmtests.sh

 mm/internal.h                             | 18 ++++++
 mm/mmap.c                                 |  2 +-
 mm/mprotect.c                             |  2 +-
 tools/testing/selftests/vm/run_vmtests.sh |  2 +
 tools/testing/selftests/vm/soft-dirty.c   | 69 ++++++++++++++++++++++-
 5 files changed, 90 insertions(+), 3 deletions(-)

-- 
2.32.0

