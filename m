Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554B247808B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhLPXb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:31:28 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:34353 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhLPXb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:31:27 -0500
Received: by mail-ot1-f42.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso809827otj.1;
        Thu, 16 Dec 2021 15:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ISZr1aZ8E2hlGFBNnfyHuvzOhe4RdEc7KunvIww2klM=;
        b=yJBtmVo1WtUIFnutgShq+k7mS9y2Updv1IWcMKmMz2rcmTouVePnN2ddmGO9zC66zz
         M7a9yemVfWRor26P8loE6X+FCWC0E7PXaFbBMjsjDRNfItjqN04X+Nhw6BfqF78g2yof
         s+I/eyzePN2ZnBJrBQmRIy+nWB4iWOxlJWocSuX048mp9r5YVH+vw7BhjrI6sSxufJCR
         ELRToCXvd7X2kiGEy3PXpOG7syC6z3P8XA6RaCtk43EdvD9Gt7vdrhEkYY1EL4+DOdaD
         eBydNkYSNWryqS7aSWqLIy3GWAXghegVLRl8vW77bNUsKLjev/k0XeDD2a5qTWXdScPc
         P/bQ==
X-Gm-Message-State: AOAM5318ApCRHDkSwyHOQTfTZeyAtH4MfoC0sdNU4i+a5UEna7aAi2bv
        gyOVnzgbYANYyWRGN64Z/wv3qcifAA==
X-Google-Smtp-Source: ABdhPJwRnPEqP6CDdJdWuxDIEplYmdIX9C15u0NdOJv94DZ7P0i9j4ulfS8Lbl94HsmPCcnAzs8QZw==
X-Received: by 2002:a05:6830:2683:: with SMTP id l3mr345202otu.258.1639697487067;
        Thu, 16 Dec 2021 15:31:27 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id n11sm1256646oor.9.2021.12.16.15.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:31:26 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/6] cacheinfo: CPU affinity and Devicetree 'id' support
Date:   Thu, 16 Dec 2021 17:31:19 -0600
Message-Id: <20211216233125.1130793-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For upcoming Arm MPAM support in resctrl, it is necessary to have the
cacheinfo 'id' for MPAM enabled caches. The 'id' is part of the resctrl
ABI. While this support already exists for ACPI based systems, it is
missing for DT. This series adds the support.

The 'id' value used is the smallest CPU h/w id value associated with a
cache. This requires walking the cache hierarchy from every CPU node to
get all CPUs associated with a cache. As MPAM also needs to know this,
the CPU affinity is also saved to avoid reimplementing and walking the
firmware tables again.

Patches 1 and 2 are v2 from the prior series[1]. The rest are new.

Tested on arm64 with DT. ACPI changes are untested. I don't have a
system with an appropriate PPTT nor do I know how to modify ACPI tables.

Rob

[1] https://lore.kernel.org/all/20211006164332.1981454-1-robh@kernel.org/

Rob Herring (6):
  cacheinfo: Allow for >32-bit cache 'id'
  cacheinfo: Set cache 'id' based on DT data
  cacheinfo: Add cpu_affinity_map to store affinity for all CPUs
  ACPI / PPTT: Populate the cacheinfo.cpu_affinity_map
  cacheinfo: Use cpu_affinity_map for populating shared_cpu_map
  cacheinfo: Add cacheinfo_get_cache_affinity() function

 drivers/acpi/pptt.c       | 29 +++++++++++++++--
 drivers/base/cacheinfo.c  | 65 ++++++++++++++++++++++++++-------------
 include/linux/cacheinfo.h | 29 +++++++++++++++--
 3 files changed, 97 insertions(+), 26 deletions(-)

-- 
2.32.0

