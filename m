Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9BD50E59A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbiDYQ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbiDYQ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8069611F953;
        Mon, 25 Apr 2022 09:24:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p18so13914031edr.7;
        Mon, 25 Apr 2022 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zDxUYXJ85edhdDIF+OEx26/QJ4jh/O6Wi8CKRi3T9qY=;
        b=aBB+TJyntknavRNh2qCHf7TgVhnT5QBXxY7g1lTApEXIJ5yhpUA8JPTOEt1Q+s3Rxi
         k+eIgRdx0LuhOa2nGM4E6dNHCidYNvLrhlOzd56ZvijEzC6sIi2rT2cIfPrY4Wgg5IIb
         LEY66GUYb48H9pmkXQf6z3uEZZpFABRauzVcu2KV2xhzCuSm2wVGwpqSFh8HcXtdd0Mu
         cQhfdIXZyDhapNC3GdDc6LuNMlNzVrORK1u0IxQdeD9SYYBzbuA4EgnUgx/mgLId392O
         HZsF5UQmWm88V7H5FYggMHJiKJyGl+C6AoY4HWyYOxF1kv7h48eUnm4nJYR7QkTCE7Yf
         XYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zDxUYXJ85edhdDIF+OEx26/QJ4jh/O6Wi8CKRi3T9qY=;
        b=HolextABC6PrdkBmt9HAvbBeOPyhAL/06yQNdTNL5sZKRYBjYhLkgyKJbG8FKEGQH8
         txCiKe+Nb2He03OmycYkGc3dj8DpZpARO4kBC4kbqG+PeLxz+RghW14aVhwn5OMXr7UC
         aUJxIZgtyYr7/uqUsr9fgSZ3Vklq94/IM15TR/J+g8Un7NXlHb8nM/6PQP8JXdNGJhk3
         sEgo/OC5qU++DHMMwCfJbSo+RSMtrKPO2C7lkBYCr/s6LEgat3cBfBVZCBfi5VudhVxk
         q3x7NhDkwiyhputYZxWdcOrm169yHfCHKZ2QmKKR+QP2UZAgpd4tAI+wBeGwP1aBdwlX
         BW+w==
X-Gm-Message-State: AOAM532XI2xagGXK5tq+bag7FjwB9gGxQYZ54/UkHVLVIdPUXytaWPWb
        3kz7/HIYmUHePlWPqk7Pn1g=
X-Google-Smtp-Source: ABdhPJyeiOp8XQ3j+OmhJ83gBdO+eJbw61YxPbHhh9rwoEW2Xm+lIoQFboSjYEivRI+OjPE+A8hf/Q==
X-Received: by 2002:a05:6402:350a:b0:423:e41e:75cb with SMTP id b10-20020a056402350a00b00423e41e75cbmr20107014edd.178.1650903844991;
        Mon, 25 Apr 2022 09:24:04 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709062ecc00b006e8558c9a5csm3784122eji.94.2022.04.25.09.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:24:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 0/4] Extend and reorganize Highmem's documentation
Date:   Mon, 25 Apr 2022 18:23:56 +0200
Message-Id: <20220425162400.11334-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has the purpose to extend and reorganize Highmem's
documentation.

This is still a work in progress, because some information should still be
moved from highmem.rst to highmem.h and highmem-internal.h. Specifically 
I'm talking about moving the "how to" information to the relevant headers, 
as it as been suggested by Ira Weiny (Intel).

This series is composed by four patches gathered from a previous series
made of two, plus two more single patches. The subject of this cover has
changed and the layout of the changes across the four patches has
changed too. For this reason it is very hard to show a valid versions'
log. Therefore, I decided to start over and drop versions (Maintainers
of the previous patch have been told to drop them).

Changes from v1 to v2:

	1/4 - Fix typos (Mike Rapoport); re-write the description of @page
	      because the original was wrong (Ira Weiny); add Ira's and
	      Mike's tags in the commit message.
	2/4 - Add Ira's and Mike's tags in the commit message.
	3/4 - Rework the subject to better summarize what this patch
	      changes; merge the section which was removed from highmem.rst
	      with the kdocs of highmem.h (suggested by Ira Weiny); add 
	      Ira's tag in the commit message.
	4/4 - Reformulate a sentence that was incomprehensible due to my
              own mistakes in copying and pasting the text of another
              paragraph (problem noted by Ira Weiny); refer to the kdocs
	      of kmap_local_page () to show how nested mappings should be
	      handled; fix grammar error; add Ira's tag in the commit
	      message.

Fabio M. De Francesco (4):
  mm/highmem: Fix kernel-doc warnings in highmem*.h
  Documentation/vm: Include kdocs into highmem.rst
  Documentation/vm: Move section from highmem.rst to highmem.h
  Documentation/vm: Rework "Temporary Virtual Mappings" section

 Documentation/vm/highmem.rst     | 103 +++++++++++++++++++------------
 include/linux/highmem-internal.h |  14 ++++-
 include/linux/highmem.h          |  44 +++++++++----
 3 files changed, 107 insertions(+), 54 deletions(-)

-- 
2.34.1

