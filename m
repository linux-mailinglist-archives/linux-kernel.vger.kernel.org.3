Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39CF5721DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiGLRki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGLRkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:40:36 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3801DC594E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:40:34 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 81D6EF91EB3;
        Tue, 12 Jul 2022 19:40:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1657647631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Oy/3n53WNJsTPScG8jHyyEWT5CZsrgAP/uMHV1X8fGI=;
        b=e2O8ia+eCMqEFlNhI/oh7jLPtnnCUqe90xjIRdiQyPDTOSBlMENR8K8PE0v7oBJG1NCpJr
        bPf6rNKDCSFegBqiIH7BiOWF6YL5zF0oGXbXDHUuOosM3kfZxA6l7XIB3gARGExqjJ0tV3
        tJQ6yD0xlM2gFSVEGayuDZaUkckSprc=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Perry Yuan <perry.yuan@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] amd-pstate doesn't work since v5.18.11
Date:   Tue, 12 Jul 2022 19:40:29 +0200
Message-ID: <3559249.JlDtxWtqDm@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mario.

The following commits were pulled into v5.18.11:

```
$ git log --oneline --no-merges v5.18.10..v5.18.11 | grep ACPI
2783414e6ef7 ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supported
3068cfeca3b5 ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked
8beb71759cc8 ACPI: bus: Set CPPC _OSC bits for all and when CPPC_LIB is supported
13bb696dd2f3 ACPI: CPPC: Check _OSC for flexible address space
```

and now this happens:

```
$ sudo modprobe amd-pstate shared_mem=1
modprobe: ERROR: could not insert 'amd_pstate': No such device
```

With v5.18.10 this worked just fine.

In your upstream commit 8b356e536e69f3a4d6778ae9f0858a1beadabb1f you write:

```
If there is additional breakage on the shared memory designs also
missing this _OSC, additional follow up changes may be needed.
```

So the question is what else should be pulled into the stable tree to unbreak amd-pstate?

Thanks.

-- 
Oleksandr Natalenko (post-factum)


